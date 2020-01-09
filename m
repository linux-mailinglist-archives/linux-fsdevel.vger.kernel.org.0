Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6D8C135A23
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2020 14:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730027AbgAINa6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jan 2020 08:30:58 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33736 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729114AbgAINa6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jan 2020 08:30:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578576656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wkLJ3bvQVebbfSchEDrEagK3yptheqo0smfxCSgrKo8=;
        b=czK3XEKcdSm6jLoPBsy7hElKcIARXVc7PqF67+clQ97xEuEzS/VpxnhM5yaDH+IPfEIklN
        4PdtJeQkm9P91K/4Nbyd2VSJORc4UNc50avVrkbuxBLZWkZv75fykKOoPJeWGC+D4+UY2R
        0T+cOc0T8dgTCR23jP+PT9PO2pZaWzI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-_QLUlaD7MDmvXAI_oehztA-1; Thu, 09 Jan 2020 08:30:53 -0500
X-MC-Unique: _QLUlaD7MDmvXAI_oehztA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E6BF6DBF5;
        Thu,  9 Jan 2020 13:30:51 +0000 (UTC)
Received: from orion.redhat.com (ovpn-205-210.brq.redhat.com [10.40.205.210])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 94A8260FC6;
        Thu,  9 Jan 2020 13:30:50 +0000 (UTC)
From:   Carlos Maiolino <cmaiolino@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     hch@lst.de, viro@zeniv.linux.org.uk
Subject: [PATCH 1/5] fs: Enable bmap() function to properly return errors
Date:   Thu,  9 Jan 2020 14:30:41 +0100
Message-Id: <20200109133045.382356-2-cmaiolino@redhat.com>
In-Reply-To: <20200109133045.382356-1-cmaiolino@redhat.com>
References: <20200109133045.382356-1-cmaiolino@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
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
 fs/f2fs/data.c         | 16 +++++++++++-----
 fs/inode.c             | 30 +++++++++++++++++-------------
 fs/jbd2/journal.c      | 22 +++++++++++++++-------
 include/linux/fs.h     |  2 +-
 mm/page_io.c           | 11 +++++++----
 6 files changed, 61 insertions(+), 36 deletions(-)

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index 3ad18246fcb3..92d3b515252d 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -364,7 +364,7 @@ static int read_page(struct file *file, unsigned long=
 index,
 	int ret =3D 0;
 	struct inode *inode =3D file_inode(file);
 	struct buffer_head *bh;
-	sector_t block;
+	sector_t block, blk_cur;
=20
 	pr_debug("read bitmap file (%dB @ %llu)\n", (int)PAGE_SIZE,
 		 (unsigned long long)index << PAGE_SHIFT);
@@ -375,17 +375,21 @@ static int read_page(struct file *file, unsigned lo=
ng index,
 		goto out;
 	}
 	attach_page_buffers(page, bh);
-	block =3D index << (PAGE_SHIFT - inode->i_blkbits);
+	blk_cur =3D index << (PAGE_SHIFT - inode->i_blkbits);
 	while (bh) {
+		block =3D blk_cur;
+
 		if (count =3D=3D 0)
 			bh->b_blocknr =3D 0;
 		else {
-			bh->b_blocknr =3D bmap(inode, block);
-			if (bh->b_blocknr =3D=3D 0) {
-				/* Cannot use this file! */
+			ret =3D bmap(inode, &block);
+			if (ret || !block) {
 				ret =3D -EINVAL;
+				bh->b_blocknr =3D 0;
 				goto out;
 			}
+
+			bh->b_blocknr =3D block;
 			bh->b_bdev =3D inode->i_sb->s_bdev;
 			if (count < (1<<inode->i_blkbits))
 				count =3D 0;
@@ -399,7 +403,7 @@ static int read_page(struct file *file, unsigned long=
 index,
 			set_buffer_mapped(bh);
 			submit_bh(REQ_OP_READ, 0, bh);
 		}
-		block++;
+		blk_cur++;
 		bh =3D bh->b_this_page;
 	}
 	page->index =3D index;
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 356642e8c3b3..3bc3d137c9ff 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3647,12 +3647,16 @@ static int check_swap_activate(struct swap_info_s=
truct *sis,
 			page_no < sis->max) {
 		unsigned block_in_page;
 		sector_t first_block;
+		sector_t block =3D 0;
+		int	 err =3D 0;
=20
 		cond_resched();
=20
-		first_block =3D bmap(inode, probe_block);
-		if (first_block =3D=3D 0)
+		block =3D probe_block;
+		err =3D bmap(inode, &block);
+		if (err || !block)
 			goto bad_bmap;
+		first_block =3D block;
=20
 		/*
 		 * It must be PAGE_SIZE aligned on-disk
@@ -3664,11 +3668,13 @@ static int check_swap_activate(struct swap_info_s=
truct *sis,
=20
 		for (block_in_page =3D 1; block_in_page < blocks_per_page;
 					block_in_page++) {
-			sector_t block;
=20
-			block =3D bmap(inode, probe_block + block_in_page);
-			if (block =3D=3D 0)
+			block =3D probe_block + block_in_page;
+			err =3D bmap(inode, &block);
+
+			if (err || !block)
 				goto bad_bmap;
+
 			if (block !=3D first_block + block_in_page) {
 				/* Discontiguity */
 				probe_block++;
diff --git a/fs/inode.c b/fs/inode.c
index 2b0f51161918..9f894b25af2b 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1600,21 +1600,25 @@ EXPORT_SYMBOL(iput);
=20
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
+ *	Replaces the value in *block with the block number on the device hold=
ing
+ *	corresponding to the requested block number in the file.
+ *	That is, asked for block 4 of inode 1 the function will replace the
+ *	4 in *block, with disk block relative to the disk start that holds th=
at
+ *	block of the file.
+ *
+ *	Returns -EINVAL in case of error, 0 otherwise. If mapping falls into =
a
+ *	hole, returns 0 and *block is also set to 0.
  */
-sector_t bmap(struct inode *inode, sector_t block)
+int bmap(struct inode *inode, sector_t *block)
 {
-	sector_t res =3D 0;
-	if (inode->i_mapping->a_ops->bmap)
-		res =3D inode->i_mapping->a_ops->bmap(inode->i_mapping, block);
-	return res;
+	if (!inode->i_mapping->a_ops->bmap)
+		return -EINVAL;
+
+	*block =3D inode->i_mapping->a_ops->bmap(inode->i_mapping, *block);
+	return 0;
 }
 EXPORT_SYMBOL(bmap);
=20
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index fa3a9232caa7..8e2756e2252f 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -795,18 +795,23 @@ int jbd2_journal_bmap(journal_t *journal, unsigned =
long blocknr,
 {
 	int err =3D 0;
 	unsigned long long ret;
+	sector_t block =3D 0;
=20
 	if (journal->j_inode) {
-		ret =3D bmap(journal->j_inode, blocknr);
-		if (ret)
-			*retp =3D ret;
-		else {
+		block =3D blocknr;
+		ret =3D bmap(journal->j_inode, &block);
+
+		if (ret || !block) {
 			printk(KERN_ALERT "%s: journal block not found "
 					"at offset %lu on %s\n",
 			       __func__, blocknr, journal->j_devname);
 			err =3D -EIO;
 			__journal_abort_soft(journal, err);
+
+		} else {
+			*retp =3D block;
 		}
+
 	} else {
 		*retp =3D blocknr; /* +journal->j_blk_offset */
 	}
@@ -1243,11 +1248,14 @@ journal_t *jbd2_journal_init_dev(struct block_dev=
ice *bdev,
 journal_t *jbd2_journal_init_inode(struct inode *inode)
 {
 	journal_t *journal;
+	sector_t blocknr;
 	char *p;
-	unsigned long long blocknr;
+	int err =3D 0;
+
+	blocknr =3D 0;
+	err =3D bmap(inode, &blocknr);
=20
-	blocknr =3D bmap(inode, 0);
-	if (!blocknr) {
+	if (err || !blocknr) {
 		pr_err("%s: Cannot locate journal superblock\n",
 			__func__);
 		return NULL;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index d7584bcef5d3..092699e99faa 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2865,7 +2865,7 @@ static inline ssize_t generic_write_sync(struct kio=
cb *iocb, ssize_t count)
 extern void emergency_sync(void);
 extern void emergency_remount(void);
 #ifdef CONFIG_BLOCK
-extern sector_t bmap(struct inode *, sector_t);
+extern int bmap(struct inode *, sector_t *);
 #endif
 extern int notify_change(struct dentry *, struct iattr *, struct inode *=
*);
 extern int inode_permission(struct inode *, int);
diff --git a/mm/page_io.c b/mm/page_io.c
index 3a198deb8bb1..76965be1d40e 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -177,8 +177,9 @@ int generic_swapfile_activate(struct swap_info_struct=
 *sis,
=20
 		cond_resched();
=20
-		first_block =3D bmap(inode, probe_block);
-		if (first_block =3D=3D 0)
+		first_block =3D probe_block;
+		ret =3D bmap(inode, &first_block);
+		if (ret || !first_block)
 			goto bad_bmap;
=20
 		/*
@@ -193,9 +194,11 @@ int generic_swapfile_activate(struct swap_info_struc=
t *sis,
 					block_in_page++) {
 			sector_t block;
=20
-			block =3D bmap(inode, probe_block + block_in_page);
-			if (block =3D=3D 0)
+			block =3D probe_block + block_in_page;
+			ret =3D bmap(inode, &block);
+			if (ret || !block)
 				goto bad_bmap;
+
 			if (block !=3D first_block + block_in_page) {
 				/* Discontiguity */
 				probe_block++;
--=20
2.23.0

