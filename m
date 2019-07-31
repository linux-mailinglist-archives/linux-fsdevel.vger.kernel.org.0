Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24D447C47F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2019 16:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387663AbfGaONE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Jul 2019 10:13:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36477 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbfGaOND (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Jul 2019 10:13:03 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 07B7E46672;
        Wed, 31 Jul 2019 14:13:03 +0000 (UTC)
Received: from pegasus.maiolino.com (unknown [10.40.205.152])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3595760852;
        Wed, 31 Jul 2019 14:13:01 +0000 (UTC)
From:   Carlos Maiolino <cmaiolino@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     hch@lst.de, adilger@dilger.ca, jaegeuk@kernel.org,
        darrick.wong@oracle.com, miklos@szeredi.hu, rpeterso@redhat.com,
        linux-xfs@vger.kernel.org
Subject: [PATCH 1/9] fs: Enable bmap() function to properly return errors
Date:   Wed, 31 Jul 2019 16:12:37 +0200
Message-Id: <20190731141245.7230-2-cmaiolino@redhat.com>
In-Reply-To: <20190731141245.7230-1-cmaiolino@redhat.com>
References: <20190731141245.7230-1-cmaiolino@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 31 Jul 2019 14:13:03 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

By now, bmap() will either return the physical block number related to
the requested file offset or 0 in case of error or the requested offset
maps into a hole.
This patch makes the needed changes to enable bmap() to proper return
errors, using the return value as an error return, and now, a pointer
must be passed to bmap() to be filled with the mapped physical block.

It will change the behavior of bmap() on return:

- negative value in case of error
- zero on success or map fell into a hole

In case of a hole, the *block will be zero too

Since this is a prep patch, by now, the only error return is -EINVAL if
->bmap doesn't exist.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
---
 drivers/md/md-bitmap.c | 16 ++++++++++------
 fs/inode.c             | 30 +++++++++++++++++-------------
 fs/jbd2/journal.c      | 22 +++++++++++++++-------
 include/linux/fs.h     |  2 +-
 mm/page_io.c           | 11 +++++++----
 5 files changed, 50 insertions(+), 31 deletions(-)

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index 1cd4f991792c..0668b2dd290e 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -363,7 +363,7 @@ static int read_page(struct file *file, unsigned long index,
 	int ret = 0;
 	struct inode *inode = file_inode(file);
 	struct buffer_head *bh;
-	sector_t block;
+	sector_t block, blk_cur;
 
 	pr_debug("read bitmap file (%dB @ %llu)\n", (int)PAGE_SIZE,
 		 (unsigned long long)index << PAGE_SHIFT);
@@ -374,17 +374,21 @@ static int read_page(struct file *file, unsigned long index,
 		goto out;
 	}
 	attach_page_buffers(page, bh);
-	block = index << (PAGE_SHIFT - inode->i_blkbits);
+	blk_cur = index << (PAGE_SHIFT - inode->i_blkbits);
 	while (bh) {
+		block = blk_cur;
+
 		if (count == 0)
 			bh->b_blocknr = 0;
 		else {
-			bh->b_blocknr = bmap(inode, block);
-			if (bh->b_blocknr == 0) {
-				/* Cannot use this file! */
+			ret = bmap(inode, &block);
+			if (ret || !block) {
 				ret = -EINVAL;
+				bh->b_blocknr = 0;
 				goto out;
 			}
+
+			bh->b_blocknr = block;
 			bh->b_bdev = inode->i_sb->s_bdev;
 			if (count < (1<<inode->i_blkbits))
 				count = 0;
@@ -398,7 +402,7 @@ static int read_page(struct file *file, unsigned long index,
 			set_buffer_mapped(bh);
 			submit_bh(REQ_OP_READ, 0, bh);
 		}
-		block++;
+		blk_cur++;
 		bh = bh->b_this_page;
 	}
 	page->index = index;
diff --git a/fs/inode.c b/fs/inode.c
index e9d97add2b36..824fa54d393d 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1577,21 +1577,25 @@ EXPORT_SYMBOL(iput);
 
 /**
  *	bmap	- find a block number in a file
- *	@inode: inode of file
- *	@block: block to find
- *
- *	Returns the block number on the device holding the inode that
- *	is the disk block number for the block of the file requested.
- *	That is, asked for block 4 of inode 1 the function will return the
- *	disk block relative to the disk start that holds that block of the
- *	file.
+ *	@inode:  inode owning the block number being requested
+ *	@*block: pointer containing the block to find
+ *
+ *	Replaces the value in *block with the block number on the device holding
+ *	corresponding to the requested block number in the file.
+ *	That is, asked for block 4 of inode 1 the function will replace the
+ *	4 in *block, with disk block relative to the disk start that holds that
+ *	block of the file.
+ *
+ *	Returns -EINVAL in case of error, 0 otherwise. If mapping falls into a
+ *	hole, returns 0 and *block is also set to 0.
  */
-sector_t bmap(struct inode *inode, sector_t block)
+int bmap(struct inode *inode, sector_t *block)
 {
-	sector_t res = 0;
-	if (inode->i_mapping->a_ops->bmap)
-		res = inode->i_mapping->a_ops->bmap(inode->i_mapping, block);
-	return res;
+	if (!inode->i_mapping->a_ops->bmap)
+		return -EINVAL;
+
+	*block = inode->i_mapping->a_ops->bmap(inode->i_mapping, *block);
+	return 0;
 }
 EXPORT_SYMBOL(bmap);
 
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 382c030cc78b..b5b3b7bfa8f6 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -798,18 +798,23 @@ int jbd2_journal_bmap(journal_t *journal, unsigned long blocknr,
 {
 	int err = 0;
 	unsigned long long ret;
+	sector_t block = 0;
 
 	if (journal->j_inode) {
-		ret = bmap(journal->j_inode, blocknr);
-		if (ret)
-			*retp = ret;
-		else {
+		block = blocknr;
+		ret = bmap(journal->j_inode, &block);
+
+		if (ret || !block) {
 			printk(KERN_ALERT "%s: journal block not found "
 					"at offset %lu on %s\n",
 			       __func__, blocknr, journal->j_devname);
 			err = -EIO;
 			__journal_abort_soft(journal, err);
+
+		} else {
+			*retp = block;
 		}
+
 	} else {
 		*retp = blocknr; /* +journal->j_blk_offset */
 	}
@@ -1235,11 +1240,14 @@ journal_t *jbd2_journal_init_dev(struct block_device *bdev,
 journal_t *jbd2_journal_init_inode(struct inode *inode)
 {
 	journal_t *journal;
+	sector_t blocknr;
 	char *p;
-	unsigned long long blocknr;
+	int err = 0;
+
+	blocknr = 0;
+	err = bmap(inode, &blocknr);
 
-	blocknr = bmap(inode, 0);
-	if (!blocknr) {
+	if (err || !blocknr) {
 		pr_err("%s: Cannot locate journal superblock\n",
 			__func__);
 		return NULL;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 8b42df09b04c..d5e7c744aea6 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2803,7 +2803,7 @@ static inline ssize_t generic_write_sync(struct kiocb *iocb, ssize_t count)
 extern void emergency_sync(void);
 extern void emergency_remount(void);
 #ifdef CONFIG_BLOCK
-extern sector_t bmap(struct inode *, sector_t);
+extern int bmap(struct inode *, sector_t *);
 #endif
 extern int notify_change(struct dentry *, struct iattr *, struct inode **);
 extern int inode_permission(struct inode *, int);
diff --git a/mm/page_io.c b/mm/page_io.c
index 2e8019d0e048..dc878c47916c 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -177,8 +177,9 @@ int generic_swapfile_activate(struct swap_info_struct *sis,
 
 		cond_resched();
 
-		first_block = bmap(inode, probe_block);
-		if (first_block == 0)
+		first_block = probe_block;
+		ret = bmap(inode, &first_block);
+		if (ret || !first_block)
 			goto bad_bmap;
 
 		/*
@@ -193,9 +194,11 @@ int generic_swapfile_activate(struct swap_info_struct *sis,
 					block_in_page++) {
 			sector_t block;
 
-			block = bmap(inode, probe_block + block_in_page);
-			if (block == 0)
+			block = probe_block + block_in_page;
+			ret = bmap(inode, &block);
+			if (ret || !block)
 				goto bad_bmap;
+
 			if (block != first_block + block_in_page) {
 				/* Discontiguity */
 				probe_block++;
-- 
2.20.1

