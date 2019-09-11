Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B63D3AFDDD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2019 15:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbfIKNnY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Sep 2019 09:43:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:64847 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727302AbfIKNnY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Sep 2019 09:43:24 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 13C0710DCCA6;
        Wed, 11 Sep 2019 13:43:24 +0000 (UTC)
Received: from pegasus.maiolino.com (ovpn-204-18.brq.redhat.com [10.40.204.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BE96110016EB;
        Wed, 11 Sep 2019 13:43:22 +0000 (UTC)
From:   Carlos Maiolino <cmaiolino@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     hch@lst.de, adilger@dilger.ca, darrick.wong@oracle.com,
        linux-xfs@vger.kernel.org
Subject: [PATCH 1/9] fs: Enable bmap() function to properly return errors
Date:   Wed, 11 Sep 2019 15:43:07 +0200
Message-Id: <20190911134315.27380-2-cmaiolino@redhat.com>
In-Reply-To: <20190911134315.27380-1-cmaiolino@redhat.com>
References: <20190911134315.27380-1-cmaiolino@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.64]); Wed, 11 Sep 2019 13:43:24 +0000 (UTC)
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

Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
---
Changelog:

	V6:
		- Fix bmap() doc function
			Reported-by: kbuild test robot <lkp@intel.com>
	V5:
		- Rebasing against 5.3 required changes to the f2fs
		  check_swap_activate() function

 drivers/md/md-bitmap.c | 16 ++++++++++------
 fs/f2fs/data.c         | 16 +++++++++++-----
 fs/inode.c             | 30 +++++++++++++++++-------------
 fs/jbd2/journal.c      | 22 +++++++++++++++-------
 include/linux/fs.h     |  2 +-
 mm/page_io.c           | 11 +++++++----
 6 files changed, 61 insertions(+), 36 deletions(-)

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index b092c7b5282f..bfb7fddd4f1b 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -364,7 +364,7 @@ static int read_page(struct file *file, unsigned long index,
 	int ret = 0;
 	struct inode *inode = file_inode(file);
 	struct buffer_head *bh;
-	sector_t block;
+	sector_t block, blk_cur;
 
 	pr_debug("read bitmap file (%dB @ %llu)\n", (int)PAGE_SIZE,
 		 (unsigned long long)index << PAGE_SHIFT);
@@ -375,17 +375,21 @@ static int read_page(struct file *file, unsigned long index,
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
@@ -399,7 +403,7 @@ static int read_page(struct file *file, unsigned long index,
 			set_buffer_mapped(bh);
 			submit_bh(REQ_OP_READ, 0, bh);
 		}
-		block++;
+		blk_cur++;
 		bh = bh->b_this_page;
 	}
 	page->index = index;
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index ada78a0f49bf..49ff6d2239c3 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3065,12 +3065,16 @@ static int check_swap_activate(struct file *swap_file, unsigned int max)
 	while ((probe_block + blocks_per_page) <= last_block && page_no < max) {
 		unsigned block_in_page;
 		sector_t first_block;
+		sector_t block = 0;
+		int	 err = 0;
 
 		cond_resched();
 
-		first_block = bmap(inode, probe_block);
-		if (first_block == 0)
+		block = probe_block;
+		err = bmap(inode, &block);
+		if (err || !block)
 			goto bad_bmap;
+		first_block = block;
 
 		/*
 		 * It must be PAGE_SIZE aligned on-disk
@@ -3082,11 +3086,13 @@ static int check_swap_activate(struct file *swap_file, unsigned int max)
 
 		for (block_in_page = 1; block_in_page < blocks_per_page;
 					block_in_page++) {
-			sector_t block;
 
-			block = bmap(inode, probe_block + block_in_page);
-			if (block == 0)
+			block = probe_block + block_in_page;
+			err = bmap(inode, &block);
+
+			if (err || !block)
 				goto bad_bmap;
+
 			if (block != first_block + block_in_page) {
 				/* Discontiguity */
 				probe_block++;
diff --git a/fs/inode.c b/fs/inode.c
index fef457a42882..0a20aaa572f2 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1593,21 +1593,25 @@ EXPORT_SYMBOL(iput);
 
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
+ *	@block: pointer containing the block to find
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
index 1c58859aa592..5664101c73a8 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -795,18 +795,23 @@ int jbd2_journal_bmap(journal_t *journal, unsigned long blocknr,
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
@@ -1232,11 +1237,14 @@ journal_t *jbd2_journal_init_dev(struct block_device *bdev,
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
index c6495389bb43..d787ceefc937 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2860,7 +2860,7 @@ static inline ssize_t generic_write_sync(struct kiocb *iocb, ssize_t count)
 extern void emergency_sync(void);
 extern void emergency_remount(void);
 #ifdef CONFIG_BLOCK
-extern sector_t bmap(struct inode *, sector_t);
+extern int bmap(struct inode *, sector_t *);
 #endif
 extern int notify_change(struct dentry *, struct iattr *, struct inode **);
 extern int inode_permission(struct inode *, int);
diff --git a/mm/page_io.c b/mm/page_io.c
index 24ee600f9131..dfc55616ff17 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -176,8 +176,9 @@ int generic_swapfile_activate(struct swap_info_struct *sis,
 
 		cond_resched();
 
-		first_block = bmap(inode, probe_block);
-		if (first_block == 0)
+		first_block = probe_block;
+		ret = bmap(inode, &first_block);
+		if (ret || !first_block)
 			goto bad_bmap;
 
 		/*
@@ -192,9 +193,11 @@ int generic_swapfile_activate(struct swap_info_struct *sis,
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

