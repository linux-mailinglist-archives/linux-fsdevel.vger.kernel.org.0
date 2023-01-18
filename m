Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B997D6724F9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jan 2023 18:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbjARRbf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Jan 2023 12:31:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbjARRbF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Jan 2023 12:31:05 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041F359250
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jan 2023 09:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=BoUmolxcC4WWev3Bomon8s2I6PcBF6tpLGBKR42OIV8=; b=ZQCLvKpSD0KCAbbeXHpyfp33/6
        qx0a/KrfAFDWErK41OUDp0S+BSBMCboHO/UrxmMoAIzr7RofHT8nUn9Z0cYLsDia4oBqBcxHsEsHn
        DgtNTzw6mUh3h1qKIMi1ccvVMnNrnywN2365w7y0YciLh0/5mUI7c5mAAgggpDJlVo+a2gYS6j5gf
        HQzin5r1Wvq09X86pLvUuXLWnxta7uxx9qHcpSS3UDz48bByC9KuOuV8pfOh+heFHaBsutGEMTzsQ
        vOflyNklFdlV19i73Z1dwLI408NnZpyVftwfyeJ2kdNGM7wV4We11Q58QrO+8b3qIuK5wmELaRtd5
        YdSZhIIA==;
Received: from [2001:4bb8:19a:2039:cce7:a1cd:f61c:a80d] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pICGo-0022AZ-5G; Wed, 18 Jan 2023 17:30:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Evgeniy Dushistov <dushistov@mail.ru>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 4/7] minix: don't flush page immediately for DIRSYNC directories
Date:   Wed, 18 Jan 2023 18:30:24 +0100
Message-Id: <20230118173027.294869-5-hch@lst.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230118173027.294869-1-hch@lst.de>
References: <20230118173027.294869-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We do not need to writeout modified directory blocks immediately when
modifying them while the page is locked. It is enough to do the flush
somewhat later which has the added benefit that inode times can be
flushed as well. It also allows us to stop depending on
write_one_page() function.

Ported from an ext2 patch by Jan Kara.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/minix/dir.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/fs/minix/dir.c b/fs/minix/dir.c
index 34c1cdb5dc7d47..bf9858f76b6ae1 100644
--- a/fs/minix/dir.c
+++ b/fs/minix/dir.c
@@ -46,21 +46,27 @@ minix_last_byte(struct inode *inode, unsigned long page_nr)
 	return last_byte;
 }
 
-static int dir_commit_chunk(struct page *page, loff_t pos, unsigned len)
+static void dir_commit_chunk(struct page *page, loff_t pos, unsigned len)
 {
 	struct address_space *mapping = page->mapping;
 	struct inode *dir = mapping->host;
-	int err = 0;
+
 	block_write_end(NULL, mapping, pos, len, len, page, NULL);
 
 	if (pos+len > dir->i_size) {
 		i_size_write(dir, pos+len);
 		mark_inode_dirty(dir);
 	}
-	if (IS_DIRSYNC(dir))
-		err = write_one_page(page);
-	else
-		unlock_page(page);
+	unlock_page(page);
+}
+
+static int minix_handle_dirsync(struct inode *dir)
+{
+	int err;
+
+	err = filemap_write_and_wait(dir->i_mapping);
+	if (!err)
+		err = sync_inode_metadata(dir, 1);
 	return err;
 }
 
@@ -274,9 +280,10 @@ int minix_add_link(struct dentry *dentry, struct inode *inode)
 		memset (namx + namelen, 0, sbi->s_dirsize - namelen - 2);
 		de->inode = inode->i_ino;
 	}
-	err = dir_commit_chunk(page, pos, sbi->s_dirsize);
+	dir_commit_chunk(page, pos, sbi->s_dirsize);
 	dir->i_mtime = dir->i_ctime = current_time(dir);
 	mark_inode_dirty(dir);
+	err = minix_handle_dirsync(dir);
 out_put:
 	dir_put_page(page);
 out:
@@ -305,12 +312,10 @@ int minix_delete_entry(struct minix_dir_entry *de, struct page *page)
 		((minix3_dirent *)de)->inode = 0;
 	else
 		de->inode = 0;
-	err = dir_commit_chunk(page, pos, len);
-	if (err)
-		return err;
+	dir_commit_chunk(page, pos, len);
 	inode->i_ctime = inode->i_mtime = current_time(inode);
 	mark_inode_dirty(inode);
-	return 0;
+	return minix_handle_dirsync(inode);
 }
 
 int minix_make_empty(struct inode *inode, struct inode *dir)
@@ -350,7 +355,8 @@ int minix_make_empty(struct inode *inode, struct inode *dir)
 	}
 	kunmap_atomic(kaddr);
 
-	err = dir_commit_chunk(page, 0, 2 * sbi->s_dirsize);
+	dir_commit_chunk(page, 0, 2 * sbi->s_dirsize);
+	err = minix_handle_dirsync(inode);
 fail:
 	put_page(page);
 	return err;
@@ -429,12 +435,10 @@ int minix_set_link(struct minix_dir_entry *de, struct page *page,
 		((minix3_dirent *)de)->inode = inode->i_ino;
 	else
 		de->inode = inode->i_ino;
-	err = dir_commit_chunk(page, pos, sbi->s_dirsize);
-	if (err)
-		return err;
+	dir_commit_chunk(page, pos, sbi->s_dirsize);
 	dir->i_mtime = dir->i_ctime = current_time(dir);
 	mark_inode_dirty(dir);
-	return 0;
+	return minix_handle_dirsync(dir);
 }
 
 struct minix_dir_entry * minix_dotdot (struct inode *dir, struct page **p)
-- 
2.39.0

