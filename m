Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C05460C22
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2019 22:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbfGEUPn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jul 2019 16:15:43 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:59814 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725813AbfGEUPn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jul 2019 16:15:43 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id BFDC68EE1F7;
        Fri,  5 Jul 2019 13:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1562357742;
        bh=e5/bI1Cum6ei0b0XE2xAlH9tdKUwuuduNp6TYLfFJUk=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=UacpHspTk63g49PxxaQvY4AK64Fl7otU2LHsf/gSImaJxyJ5QtBdcv0aICi3YDTbo
         C1JyOsLqCZNn0Zdb0dVsn3/jj8zKrGrBCs3Mdw87igIn6mmRKTHHE+8wkOaycNS6Nh
         KmlbMVMxl8apDdQeEk8tY68EK/UznMvXZOHLueqE=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Ne0Xyb7bAnK0; Fri,  5 Jul 2019 13:15:42 -0700 (PDT)
Received: from jarvis.lan (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 689E48EE0CF;
        Fri,  5 Jul 2019 13:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1562357742;
        bh=e5/bI1Cum6ei0b0XE2xAlH9tdKUwuuduNp6TYLfFJUk=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=UacpHspTk63g49PxxaQvY4AK64Fl7otU2LHsf/gSImaJxyJ5QtBdcv0aICi3YDTbo
         C1JyOsLqCZNn0Zdb0dVsn3/jj8zKrGrBCs3Mdw87igIn6mmRKTHHE+8wkOaycNS6Nh
         KmlbMVMxl8apDdQeEk8tY68EK/UznMvXZOHLueqE=
Message-ID: <1562357740.10899.6.camel@HansenPartnership.com>
Subject: [PATCH 1/4] iplboot: eliminate unused struct bootfs
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Parisc List <linux-parisc@vger.kernel.org>
Date:   Fri, 05 Jul 2019 13:15:40 -0700
In-Reply-To: <1562357231.10899.5.camel@HansenPartnership.com>
References: <1562357231.10899.5.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It's only used locally in ext2.c to carry the blocksize, so make
blocksize a static variable instead.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 ipl/bootloader.h | 13 ---------
 ipl/ext2.c       | 80 ++++++++++++++++++++------------------------------------
 2 files changed, 29 insertions(+), 64 deletions(-)

diff --git a/ipl/bootloader.h b/ipl/bootloader.h
index 626ebd3..956b6ed 100644
--- a/ipl/bootloader.h
+++ b/ipl/bootloader.h
@@ -12,19 +12,6 @@
 
 #define MAX_FD 20
 
-struct bootfs {
-	int	fs_type;
-	int	blocksize;
-	
-	int	(*mount)(long dev, long partition_start, long quiet);
-
-	int	(*open)(const char *filename);
-	int	(*bread)(int fd, long blkno, long nblks, char *buf);
-	void	(*close)(int fd);
-	const char *	(*readdir)(int fd, int rewind);
-};
-
-
 /* pdc_misc.c */
 void die(const char *);
 void firmware_init(int started_wide);
diff --git a/ipl/ext2.c b/ipl/ext2.c
index 4679c13..9d198fe 100644
--- a/ipl/ext2.c
+++ b/ipl/ext2.c
@@ -26,7 +26,7 @@
 
 #define MAX_OPEN_FILES		5
 
-extern struct bootfs ext2fs;
+static int ext2_blocksize;
 
 static struct ext2_super_block sb;
 static struct ext2_group_desc *gds;
@@ -242,26 +242,26 @@ int ext2_mount(long cons_dev, long p_offset, long quiet)
 	gds = (struct ext2_group_desc *)
 	          malloc((size_t)(ngroups * sizeof(struct ext2_group_desc)));
 
-	ext2fs.blocksize = EXT2_BLOCK_SIZE(&sb);
-	if (Debug) printf("ext2 block size %d\n", ext2fs.blocksize);
+	ext2_blocksize = EXT2_BLOCK_SIZE(&sb);
+	if (Debug) printf("ext2 block size %d\n", ext2_blocksize);
 
 	/* read in the group descriptors (immediately follows superblock) */
 	cons_read(dev, gds, ngroups * sizeof(struct ext2_group_desc),
 		  partition_offset +
-                  ext2fs.blocksize * (EXT2_MIN_BLOCK_SIZE/ext2fs.blocksize + 1));
+                  ext2_blocksize * (EXT2_MIN_BLOCK_SIZE/ext2_blocksize + 1));
 	for (i = 0; i < ngroups; i++)
 	{
 	    swapgrp(&gds[i]);
 	}
 	/*
 	 * Calculate direct/indirect block limits for this file system
-	 * (blocksize dependent):
+	 * (ext2_blocksize dependent):
 	 */
-	ext2fs.blocksize = EXT2_BLOCK_SIZE(&sb);
-	if (Debug) printf("ext2 block size %d\n", ext2fs.blocksize);
+	ext2_blocksize = EXT2_BLOCK_SIZE(&sb);
+	if (Debug) printf("ext2 block size %d\n", ext2_blocksize);
 
 	directlim = EXT2_NDIR_BLOCKS - 1;
-	ptrs_per_blk = ext2fs.blocksize/sizeof(unsigned int);
+	ptrs_per_blk = ext2_blocksize/sizeof(unsigned int);
 	ind1lim = ptrs_per_blk + directlim;
 	ind2lim = (ptrs_per_blk * ptrs_per_blk) + directlim;
 
@@ -317,7 +317,7 @@ static struct ext2_inode *ext2_iget(int ino)
 	printf("group is %d\n", group);
 #endif
 	offset = partition_offset
-		+ ((long) gds[group].bg_inode_table * (long)ext2fs.blocksize)
+		+ ((long) gds[group].bg_inode_table * (long)ext2_blocksize)
 		+ (((ino - 1) % EXT2_INODES_PER_GROUP(&sb))
 		   * EXT2_INODE_SIZE(&sb));
 #ifdef DEBUG
@@ -325,7 +325,7 @@ static struct ext2_inode *ext2_iget(int ino)
 	       "(%ld + (%d * %d) + ((%d) %% %d) * %d) "
 	       "(inode %d -> table %d)\n", 
 	       sizeof(struct ext2_inode), offset, partition_offset,
-	       gds[group].bg_inode_table, ext2fs.blocksize,
+	       gds[group].bg_inode_table, ext2_blocksize,
 	       ino - 1, EXT2_INODES_PER_GROUP(&sb), EXT2_INODE_SIZE(&sb),
 	       ino, (int) (itp - inode_table));
 #endif
@@ -403,9 +403,9 @@ static int ext2_blkno(struct ext2_inode *ip, int blkoff)
 
 		/* Read the indirect block */
 		if (cached_iblkno != iblkno) {
-			offset = partition_offset + (long)iblkno * (long)ext2fs.blocksize;
-			if (cons_read(dev, iblkbuf, ext2fs.blocksize, offset)
-			    != ext2fs.blocksize)
+			offset = partition_offset + (long)iblkno * (long)ext2_blocksize;
+			if (cons_read(dev, iblkbuf, ext2_blocksize, offset)
+			    != ext2_blocksize)
 			{
 				printf("ext2_blkno: error on iblk read\n");
 				return 0;
@@ -430,9 +430,9 @@ static int ext2_blkno(struct ext2_inode *ip, int blkoff)
 
 		/* Read in the double-indirect block */
 		if (cached_diblkno != diblkno) {
-			offset = partition_offset + (long) diblkno * (long) ext2fs.blocksize;
-			if (cons_read(dev, diblkbuf, ext2fs.blocksize, offset)
-			    != ext2fs.blocksize)
+			offset = partition_offset + (long) diblkno * (long) ext2_blocksize;
+			if (cons_read(dev, diblkbuf, ext2_blocksize, offset)
+			    != ext2_blocksize)
 			{
 				printf("ext2_blkno: err reading dindr blk\n");
 				return 0;
@@ -451,9 +451,9 @@ static int ext2_blkno(struct ext2_inode *ip, int blkoff)
 		/* Read the indirect block */
     
 		if (cached_iblkno != iblkno) {
-			offset = partition_offset + (long) iblkno * (long) ext2fs.blocksize;
-			if (cons_read(dev, iblkbuf, ext2fs.blocksize, offset)
-			    != ext2fs.blocksize)
+			offset = partition_offset + (long) iblkno * (long) ext2_blocksize;
+			if (cons_read(dev, iblkbuf, ext2_blocksize, offset)
+			    != ext2_blocksize)
 			{
 				printf("ext2_blkno: err on iblk read\n");
 				return 0;
@@ -493,8 +493,8 @@ static int ext2_breadi(struct ext2_inode *ip, long blkno, long nblks,
 		ip, blkno, nblks, buffer);
 
 	tot_bytes = 0;
-	if ((blkno+nblks)*ext2fs.blocksize > ip->i_size)
-		nblks = (ip->i_size + ext2fs.blocksize) / ext2fs.blocksize - blkno;
+	if ((blkno+nblks)*ext2_blocksize > ip->i_size)
+		nblks = (ip->i_size + ext2_blocksize) / ext2_blocksize - blkno;
 
 	if (Debug) printf("nblks = %ld\n", nblks);
 	while (nblks) {
@@ -507,7 +507,7 @@ static int ext2_breadi(struct ext2_inode *ip, long blkno, long nblks,
 		if (Debug) printf("dev_blkno = %ld\n", dev_blkno);
 		do {
 			++blkno; ++ncontig; --nblks;
-			nbytes += ext2fs.blocksize;
+			nbytes += ext2_blocksize;
 		} while (nblks &&
 			 print_ext2_blkno(ip, blkno) == dev_blkno + ncontig);
 
@@ -518,7 +518,7 @@ static int ext2_breadi(struct ext2_inode *ip, long blkno, long nblks,
 			memset(buffer, 0, nbytes);
 		} else {
 			/* Read it for real */
-			offset = partition_offset + (long) dev_blkno* (long) ext2fs.blocksize;
+			offset = partition_offset + (long) dev_blkno* (long) ext2_blocksize;
 #ifdef DEBUG
 			printf("ext2_bread: reading %ld bytes at offset %ld\n",
 			       nbytes, offset);
@@ -557,8 +557,8 @@ static struct ext2_dir_entry_2 *ext2_readdiri(struct ext2_inode *dir_inode,
 	printf("ext2_readdiri: blkoffset %d diroffset %d len %d\n",
 		blockoffset, diroffset, dir_inode->i_size);
 #endif
-	if (blockoffset >= ext2fs.blocksize) {
-		diroffset += ext2fs.blocksize;
+	if (blockoffset >= ext2_blocksize) {
+		diroffset += ext2_blocksize;
 		if (diroffset >= dir_inode->i_size)
 			return NULL;
 #ifdef DEBUG
@@ -567,7 +567,7 @@ static struct ext2_dir_entry_2 *ext2_readdiri(struct ext2_inode *dir_inode,
 #endif
 		/* assume that this will read the whole block */
 		if (ext2_breadi(dir_inode,
-				diroffset / ext2fs.blocksize,
+				diroffset / ext2_blocksize,
 				1, blkbuf) < 0)
 			return NULL;
 		blockoffset = 0;
@@ -668,16 +668,6 @@ static struct ext2_inode *ext2_namei(const char *name)
 }
 
 
-/*
- * Read block number "blkno" from the specified file.
- */
-static int ext2_bread(int fd, long blkno, long nblks, char *buffer)
-{
-	struct ext2_inode * ip;
-	ip = &inode_table[fd].inode;
-	return ext2_breadi(ip, blkno, nblks, buffer);
-}
-
 /*
  * Note: don't mix any kind of file lookup or other I/O with this or
  * you will lose horribly (as it reuses blkbuf)
@@ -785,8 +775,8 @@ static int ext2_read(int fd, char *buf, unsigned count, unsigned devaddr)
 		fd, buf, count, devaddr);
 
 	return ext2_breadi(ip,
-		devaddr / ext2fs.blocksize,
-		count / ext2fs.blocksize,
+		devaddr / ext2_blocksize,
+		count / ext2_blocksize,
 		buf);
 }
 
@@ -795,7 +785,7 @@ static void ext2_describe(int fd, int *bufalign,
 {
     describe(dev, bufalign, blocksize);
     if (blocksize != 0)
-	*blocksize = ext2fs.blocksize;
+	*blocksize = ext2_blocksize;
 }
 
 int ext2_open(const char *filename)
@@ -830,15 +820,3 @@ void ext2_close(int fd)
 	if (&inode_table[fd].inode != root_inode)
 		ext2_iput(&inode_table[fd].inode);
 }
-
-
-struct bootfs ext2fs = {
-	.fs_type =	0,
-	.blocksize =	0,
-	.mount =	ext2_mount,
-	.open =		ext2_open,
-	.bread = 	ext2_bread,
-	.close = 	ext2_close,
-	.readdir =	ext2_readdir,
-	/* .fstat =	ext2_fstat */
-};
-- 
2.16.4

