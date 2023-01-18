Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A336E6724FC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jan 2023 18:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjARRbo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Jan 2023 12:31:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbjARRbI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Jan 2023 12:31:08 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9FD21A0D
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jan 2023 09:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=v3PglRWzIOokZtWskK857KErIsUBx1dUWoEIj+rmors=; b=U05qheovgxBUbMhTKKemw5ZM2W
        +lw1zqiSw0fTKUbYGe4qcdGWpVpSVtuCixVD8X05UaJPzH0rV12qgPwg6yrdCoj58546B7wZkvItN
        aFBV6i6UuPYSTlEDevcYjEqKtWYeXCL9YJuF2o0ktbYV85kZYtLzrPpqLCUnrQOdm9tdrLM0zEJTT
        YGK7YdkqWaEvFJ/1iWN+aLUbVyyZE/fW3pvAcev6gYBqg4UUNvQ7LL3/j/TMEsY9lwC2STBR+1xQ3
        OAGX583TWkypdhRyd5ZIFMj5ZNc1iYMPGalHjY5KsPCHBup21MLTKOruniP8ileEqsqVnakRllDNF
        lm4B09wg==;
Received: from [2001:4bb8:19a:2039:cce7:a1cd:f61c:a80d] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pICGu-0022EW-GD; Wed, 18 Jan 2023 17:30:49 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Evgeniy Dushistov <dushistov@mail.ru>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 6/7] ufs: don't flush page immediately for DIRSYNC directories
Date:   Wed, 18 Jan 2023 18:30:26 +0100
Message-Id: <20230118173027.294869-7-hch@lst.de>
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
 fs/ufs/dir.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/fs/ufs/dir.c b/fs/ufs/dir.c
index 391efaf1d52897..379d75796a5ce3 100644
--- a/fs/ufs/dir.c
+++ b/fs/ufs/dir.c
@@ -42,11 +42,10 @@ static inline int ufs_match(struct super_block *sb, int len,
 	return !memcmp(name, de->d_name, len);
 }
 
-static int ufs_commit_chunk(struct page *page, loff_t pos, unsigned len)
+static void ufs_commit_chunk(struct page *page, loff_t pos, unsigned len)
 {
 	struct address_space *mapping = page->mapping;
 	struct inode *dir = mapping->host;
-	int err = 0;
 
 	inode_inc_iversion(dir);
 	block_write_end(NULL, mapping, pos, len, len, page, NULL);
@@ -54,10 +53,16 @@ static int ufs_commit_chunk(struct page *page, loff_t pos, unsigned len)
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
+static int ufs_handle_dirsync(struct inode *dir)
+{
+	int err;
+
+	err = filemap_write_and_wait(dir->i_mapping);
+	if (!err)
+		err = sync_inode_metadata(dir, 1);
 	return err;
 }
 
@@ -99,11 +104,12 @@ void ufs_set_link(struct inode *dir, struct ufs_dir_entry *de,
 	de->d_ino = cpu_to_fs32(dir->i_sb, inode->i_ino);
 	ufs_set_de_type(dir->i_sb, de, inode->i_mode);
 
-	err = ufs_commit_chunk(page, pos, len);
+	ufs_commit_chunk(page, pos, len);
 	ufs_put_page(page);
 	if (update_times)
 		dir->i_mtime = dir->i_ctime = current_time(dir);
 	mark_inode_dirty(dir);
+	ufs_handle_dirsync(dir);
 }
 
 
@@ -390,10 +396,11 @@ int ufs_add_link(struct dentry *dentry, struct inode *inode)
 	de->d_ino = cpu_to_fs32(sb, inode->i_ino);
 	ufs_set_de_type(sb, de, inode->i_mode);
 
-	err = ufs_commit_chunk(page, pos, rec_len);
+	ufs_commit_chunk(page, pos, rec_len);
 	dir->i_mtime = dir->i_ctime = current_time(dir);
 
 	mark_inode_dirty(dir);
+	err = ufs_handle_dirsync(dir);
 	/* OFFSET_CACHE */
 out_put:
 	ufs_put_page(page);
@@ -531,9 +538,10 @@ int ufs_delete_entry(struct inode *inode, struct ufs_dir_entry *dir,
 	if (pde)
 		pde->d_reclen = cpu_to_fs16(sb, to - from);
 	dir->d_ino = 0;
-	err = ufs_commit_chunk(page, pos, to - from);
+	ufs_commit_chunk(page, pos, to - from);
 	inode->i_ctime = inode->i_mtime = current_time(inode);
 	mark_inode_dirty(inode);
+	err = ufs_handle_dirsync(inode);
 out:
 	ufs_put_page(page);
 	UFSD("EXIT\n");
@@ -579,7 +587,8 @@ int ufs_make_empty(struct inode * inode, struct inode *dir)
 	strcpy (de->d_name, "..");
 	kunmap(page);
 
-	err = ufs_commit_chunk(page, 0, chunk_size);
+	ufs_commit_chunk(page, 0, chunk_size);
+	err = ufs_handle_dirsync(inode);
 fail:
 	put_page(page);
 	return err;
-- 
2.39.0

