Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6CF6616FC
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Jan 2023 17:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234617AbjAHQ5P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Jan 2023 11:57:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234482AbjAHQ5I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Jan 2023 11:57:08 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0FD615F;
        Sun,  8 Jan 2023 08:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=LRWqWW8CxEBUBZTClfw9RwYeRYBhCeQ4pIrtvl3s68o=; b=oQx7Rv3KHPp6gTVM17C0X1F/0A
        Ss7aKkMKn13YqMFTiyj9UovpO3YmHbFIkdRu6P1lm0x3YzRL/33E+Nm0c8v7BQiUB9dtCG6vzzb9d
        G41l8V5rOwy6wLPJHKKUyuQ6evYLtxQubPvataSaZCelc+12PgJfW96pThp+vHnLueP3p23yrcT4r
        T4i62q0kSRL41BsGk/4004k+MK+VqsohoC8D9EslgyHPJVq8uN74IO2CqRkbKPz+ZTHIKdyRRSA1J
        LI9sFgAsTdSHr/VGk8960vHaAhlEZaxW4aRfr5eGg0W61z0hBEv5IpN8Y2QgFE8AkE/5sr+NKzDRt
        VGJHblOw==;
Received: from [2001:4bb8:198:a591:1c7c:bf66:af15:b282] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pEYyg-00ERsb-Mk; Sun, 08 Jan 2023 16:56:59 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Dave Kleikamp <shaggy@kernel.org>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Evgeniy Dushistov <dushistov@mail.ru>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-btrfs@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
        ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 4/7] sysv: don't flush page immediately for DIRSYNC directories
Date:   Sun,  8 Jan 2023 17:56:42 +0100
Message-Id: <20230108165645.381077-5-hch@lst.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230108165645.381077-1-hch@lst.de>
References: <20230108165645.381077-1-hch@lst.de>
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
 fs/sysv/dir.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/fs/sysv/dir.c b/fs/sysv/dir.c
index 88e38cd8f5c9ae..1d852ca6388297 100644
--- a/fs/sysv/dir.c
+++ b/fs/sysv/dir.c
@@ -34,21 +34,26 @@ static inline void dir_put_page(struct page *page)
 	put_page(page);
 }
 
-static int dir_commit_chunk(struct page *page, loff_t pos, unsigned len)
+static void dir_commit_chunk(struct page *page, loff_t pos, unsigned len)
 {
 	struct address_space *mapping = page->mapping;
 	struct inode *dir = mapping->host;
-	int err = 0;
 
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
+static int sysv_handle_dirsync(struct inode *dir)
+{
+	int err;
+
+	err = filemap_write_and_wait(dir->i_mapping);
+	if (!err)
+		err = sync_inode_metadata(dir, 1);
 	return err;
 }
 
@@ -215,9 +220,10 @@ int sysv_add_link(struct dentry *dentry, struct inode *inode)
 	memcpy (de->name, name, namelen);
 	memset (de->name + namelen, 0, SYSV_DIRSIZE - namelen - 2);
 	de->inode = cpu_to_fs16(SYSV_SB(inode->i_sb), inode->i_ino);
-	err = dir_commit_chunk(page, pos, SYSV_DIRSIZE);
+	dir_commit_chunk(page, pos, SYSV_DIRSIZE);
 	dir->i_mtime = dir->i_ctime = current_time(dir);
 	mark_inode_dirty(dir);
+	sysv_handle_dirsync(dir);
 out_page:
 	dir_put_page(page);
 out:
@@ -238,10 +244,11 @@ int sysv_delete_entry(struct sysv_dir_entry *de, struct page *page)
 	err = sysv_prepare_chunk(page, pos, SYSV_DIRSIZE);
 	BUG_ON(err);
 	de->inode = 0;
-	err = dir_commit_chunk(page, pos, SYSV_DIRSIZE);
+	dir_commit_chunk(page, pos, SYSV_DIRSIZE);
 	dir_put_page(page);
 	inode->i_ctime = inode->i_mtime = current_time(inode);
 	mark_inode_dirty(inode);
+	sysv_handle_dirsync(inode);
 	return err;
 }
 
@@ -272,7 +279,8 @@ int sysv_make_empty(struct inode *inode, struct inode *dir)
 	strcpy(de->name,"..");
 
 	kunmap(page);
-	err = dir_commit_chunk(page, 0, 2 * SYSV_DIRSIZE);
+	dir_commit_chunk(page, 0, 2 * SYSV_DIRSIZE);
+	err = sysv_handle_dirsync(inode);
 fail:
 	put_page(page);
 	return err;
@@ -336,10 +344,11 @@ void sysv_set_link(struct sysv_dir_entry *de, struct page *page,
 	err = sysv_prepare_chunk(page, pos, SYSV_DIRSIZE);
 	BUG_ON(err);
 	de->inode = cpu_to_fs16(SYSV_SB(inode->i_sb), inode->i_ino);
-	err = dir_commit_chunk(page, pos, SYSV_DIRSIZE);
+	dir_commit_chunk(page, pos, SYSV_DIRSIZE);
 	dir_put_page(page);
 	dir->i_mtime = dir->i_ctime = current_time(dir);
 	mark_inode_dirty(dir);
+	sysv_handle_dirsync(inode);
 }
 
 struct sysv_dir_entry * sysv_dotdot (struct inode *dir, struct page **p)
-- 
2.35.1

