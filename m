Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A677460C27
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2019 22:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbfGEUQs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jul 2019 16:16:48 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:59890 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725813AbfGEUQs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jul 2019 16:16:48 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id B89CA8EE1F7;
        Fri,  5 Jul 2019 13:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1562357807;
        bh=/fS6oDKd86mR68HLZIDsjxT25I9JNDvE3EMLthbo3Gw=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=LyrtSm3dlpYR3Dnij+N2oCfQNrTgwA5tI8si8INMhkMnEwYyD07PrXf3VhHEFQnvp
         U9wdArnWMZ6nMCmAsFwZnlYt8QraBFEqgh1zizUNxDUpkAUzO5Y38R/Wax6SEimuHQ
         YEY2EWbeRsRvFz25jzcOMJdwu5zypCu1RrB/0RoQ=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WTXfkHKjcD9J; Fri,  5 Jul 2019 13:16:47 -0700 (PDT)
Received: from jarvis.lan (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 5A47B8EE0CF;
        Fri,  5 Jul 2019 13:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1562357807;
        bh=/fS6oDKd86mR68HLZIDsjxT25I9JNDvE3EMLthbo3Gw=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=LyrtSm3dlpYR3Dnij+N2oCfQNrTgwA5tI8si8INMhkMnEwYyD07PrXf3VhHEFQnvp
         U9wdArnWMZ6nMCmAsFwZnlYt8QraBFEqgh1zizUNxDUpkAUzO5Y38R/Wax6SEimuHQ
         YEY2EWbeRsRvFz25jzcOMJdwu5zypCu1RrB/0RoQ=
Message-ID: <1562357806.10899.8.camel@HansenPartnership.com>
Subject: [PATCH 3/4] iplboot: add ext4 support
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Parisc List <linux-parisc@vger.kernel.org>
Date:   Fri, 05 Jul 2019 13:16:46 -0700
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

For a read only filesystem, like iplboot, the only real additions for
ext4 are allowing for extent based inodes and a variable group size.

The current block transformation scheme simply goes from filesystem
block offset to absolute partition block employing a caching scheme
for the indirect inodes.  We can follow a similar scheme for the
extent tree based on depth, relying on the fact that linear block
loading will optimally keep the cache at a given depth until it's not
needed.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 ipl/ext2.c | 180 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 173 insertions(+), 7 deletions(-)

diff --git a/ipl/ext2.c b/ipl/ext2.c
index 9d198fe..31b8469 100644
--- a/ipl/ext2.c
+++ b/ipl/ext2.c
@@ -25,6 +25,7 @@
 #include "bootloader.h"
 
 #define MAX_OPEN_FILES		5
+#define EXTENT_MAX_DEPTH	5
 
 static int ext2_blocksize;
 
@@ -32,6 +33,7 @@ static struct ext2_super_block sb;
 static struct ext2_group_desc *gds;
 static struct ext2_inode *root_inode = NULL;
 static int ngroups = 0;
+static int group_size;
 static int directlim;			/* Maximum direct blkno */
 static int ind1lim;			/* Maximum single-indir blkno */
 static int ind2lim;			/* Maximum double-indir blkno */
@@ -62,6 +64,11 @@ static struct inode_table_entry {
 #undef DEBUG
 #define Debug 0
 
+static struct ext3_extent_header *ext3_extent_header(struct ext2_inode *i)
+{
+	return (struct ext3_extent_header *)&i->i_block[0];
+}
+
 
 static void swapsb(struct ext2_super_block *sb)
 {
@@ -104,6 +111,8 @@ static void swapsb(struct ext2_super_block *sb)
     inplace(__le32_to_cpu, sb->s_feature_ro_compat);
     inplace(__le32_to_cpu, sb->s_algorithm_usage_bitmap);
 
+    inplace(__le16_to_cpu, sb->s_desc_size);
+
     /* whew! */
 }
 
@@ -119,6 +128,15 @@ static void swapgrp(struct ext2_group_desc *g)
 
 }
 
+static void swapextenthdr(struct ext3_extent_header *hdr)
+{
+		inplace(__le16_to_cpu, hdr->eh_magic);
+		inplace(__le16_to_cpu, hdr->eh_entries);
+		inplace(__le16_to_cpu, hdr->eh_max);
+		inplace(__le16_to_cpu, hdr->eh_depth);
+		inplace(__le32_to_cpu, hdr->eh_generation);
+}
+
 static void swapino(struct ext2_inode *i)
 {
 	int n;
@@ -148,8 +166,18 @@ static void swapino(struct ext2_inode *i)
 		} masix1;
 	} osd1;				/* OS dependent 1 */
 #endif
-	for (n = 0; n < EXT2_N_BLOCKS; n++) {
-		inplace(__le32_to_cpu, i->i_block[n]);
+	if ((i->i_flags & EXT3_EXTENTS_FL)) {
+		/* the extent header is in the i_block array */
+		struct ext3_extent_header *hdr = ext3_extent_header(i);
+
+		swapextenthdr(hdr);
+		if (Debug)
+			printf("ext4: extent based inode; depth %d, size %d\n",
+			       hdr->eh_depth, hdr->eh_entries);
+	} else {
+		for (n = 0; n < EXT2_N_BLOCKS; n++) {
+			inplace(__le32_to_cpu, i->i_block[n]);
+		}
 	}
 	inplace(__le32_to_cpu, i->i_generation);
 	inplace(__le32_to_cpu, i->i_file_acl);
@@ -193,6 +221,13 @@ static void swapde(struct ext2_dir_entry_2 *de)
 				de->name_len, de->name);
 }
 
+static struct ext2_group_desc *ext2_gds(int i)
+{
+	char *ptr = (char *)gds;
+
+	return (struct ext2_group_desc *)(ptr + group_size * i);
+}
+
 /*
  * Initialize an ext2 partition starting at offset P_OFFSET; this is
  * sort-of the same idea as "mounting" it.  Read in the relevant
@@ -239,8 +274,14 @@ int ext2_mount(long cons_dev, long p_offset, long quiet)
 		   EXT2_BLOCKS_PER_GROUP(&sb) - 1)
 		/ EXT2_BLOCKS_PER_GROUP(&sb);
 
-	gds = (struct ext2_group_desc *)
-	          malloc((size_t)(ngroups * sizeof(struct ext2_group_desc)));
+	if (sb.s_feature_incompat & EXT4_FEATURE_INCOMPAT_64BIT)
+		group_size = sb.s_desc_size;
+	else
+		group_size = sizeof(struct ext2_group_desc);
+
+	printf("filesystem group size %d\n", group_size);
+
+	gds = (struct ext2_group_desc *)malloc(ngroups * group_size);
 
 	ext2_blocksize = EXT2_BLOCK_SIZE(&sb);
 	if (Debug) printf("ext2 block size %d\n", ext2_blocksize);
@@ -251,7 +292,7 @@ int ext2_mount(long cons_dev, long p_offset, long quiet)
                   ext2_blocksize * (EXT2_MIN_BLOCK_SIZE/ext2_blocksize + 1));
 	for (i = 0; i < ngroups; i++)
 	{
-	    swapgrp(&gds[i]);
+		swapgrp(ext2_gds(i));
 	}
 	/*
 	 * Calculate direct/indirect block limits for this file system
@@ -317,7 +358,7 @@ static struct ext2_inode *ext2_iget(int ino)
 	printf("group is %d\n", group);
 #endif
 	offset = partition_offset
-		+ ((long) gds[group].bg_inode_table * (long)ext2_blocksize)
+		+ ((long) ext2_gds(group)->bg_inode_table * (long)ext2_blocksize)
 		+ (((ino - 1) % EXT2_INODES_PER_GROUP(&sb))
 		   * EXT2_INODE_SIZE(&sb));
 #ifdef DEBUG
@@ -325,7 +366,7 @@ static struct ext2_inode *ext2_iget(int ino)
 	       "(%ld + (%d * %d) + ((%d) %% %d) * %d) "
 	       "(inode %d -> table %d)\n", 
 	       sizeof(struct ext2_inode), offset, partition_offset,
-	       gds[group].bg_inode_table, ext2_blocksize,
+	       ext2_gds(group)->bg_inode_table, ext2_blocksize,
 	       ino - 1, EXT2_INODES_PER_GROUP(&sb), EXT2_INODE_SIZE(&sb),
 	       ino, (int) (itp - inode_table));
 #endif
@@ -338,6 +379,18 @@ static struct ext2_inode *ext2_iget(int ino)
 
 	swapino(ip);
 	if (Debug) printinode("iget", ip);
+	if (ip->i_flags & EXT3_EXTENTS_FL) {
+		struct ext3_extent_header *hdr = ext3_extent_header(ip);
+
+		if (hdr->eh_magic != EXT3_EXT_MAGIC) {
+			printf("ext2_iget: wrong extent magic in inode\n");
+			return NULL;
+		}
+		if (hdr->eh_depth > EXTENT_MAX_DEPTH) {
+			printf("ext2_iget: file has too deep an extent tree]n");
+			return NULL;
+		}
+	}
 
 	itp->free = 0;
 	itp->inumber = ino;
@@ -366,6 +419,116 @@ static void ext2_iput(struct ext2_inode *ip)
 	itp->free = 1;
 }
 
+/*
+ * Recursive function to find the mapping of a block in the extent
+ * tree We make a load of assumptions here, firstly, since we're
+ * dealing with filesystems < 2GB we assume all the _hi elements are
+ * zero.  Secondly we assume monotonic logical block traversal for
+ * kernel/initrd loading, so the cache is static per depth in the
+ * tree.
+ */
+
+static int ext3_extent_leaf_find(struct ext3_extent_header *hdr, int blkoff)
+{
+	struct ext3_extent *leaf = (struct ext3_extent *)(hdr + 1);
+	int i;
+
+	for (i = 0; i < hdr->eh_entries; i++) {
+		__u32 block = __le32_to_cpu(leaf[i].ee_block);
+		__u16 len = __le16_to_cpu(leaf[i].ee_len);
+		__u32 start = __le32_to_cpu(leaf[i].ee_start);
+
+		if (block <= blkoff && block + len > blkoff)
+			return blkoff - block + start;
+	}
+
+	/* block is not in map: this means a hole */
+	return 0;
+}
+
+static int ext3_extent_load_find(struct ext2_inode *ip, int leaf, int d,
+				 int blkoff);
+
+static int ext3_extent_node_find(struct ext2_inode *ip,
+				 struct ext3_extent_header *hdr, int blkoff)
+{
+	struct ext3_extent_idx *node = (struct ext3_extent_idx *)(hdr + 1);
+	struct ext3_extent_idx *prev = node;
+	int i;
+	__u32 start = __le32_to_cpu(prev->ei_block);
+	__u32 leaf = __le32_to_cpu(prev->ei_leaf);
+
+	for (i = 1; i < hdr->eh_entries; i++) {
+		__u32 block = __le32_to_cpu(node[i].ei_block);
+
+		if (start <= blkoff && block > blkoff)
+			break;
+
+		prev = &node[i];
+		start = __le32_to_cpu(prev->ei_block);
+		leaf = __le32_to_cpu(prev->ei_leaf);
+	}
+
+	return ext3_extent_load_find(ip, leaf, hdr->eh_depth - 1, blkoff);
+}
+
+static int ext3_extent_load_find(struct ext2_inode *ip, int leaf, int d,
+				 int blkoff)
+{
+	static char blockbuf[EXTENT_MAX_DEPTH][EXT2_MAX_BLOCK_SIZE];
+	static int cached_blockno[EXTENT_MAX_DEPTH];
+	struct ext3_extent_header *hdr;
+
+	hdr = (struct ext3_extent_header *)blockbuf[d];
+	if (cached_blockno[d] != leaf) {
+		printf("load extent tree[%d] block at %d\n", d, leaf);
+
+		if (cons_read(dev, blockbuf[d], sizeof(blockbuf[d]),
+			      leaf * ext2_blocksize) !=
+		    sizeof(blockbuf[d])) {
+			printf("ext3_extent_load_find: read error\n");
+			return -1;
+		}
+		cached_blockno[d] = leaf;
+		swapextenthdr(hdr);
+	}
+
+	/* these checks could be done once after load, but belt and braces */
+	if (hdr->eh_magic != EXT3_EXT_MAGIC) {
+		printf("ext3_extent_load_find: wrong extent magic in block\n");
+		return -1;
+	}
+	if (hdr->eh_depth != d) {
+		printf("ext3_extent_load_find: wrong depth %d!=%d\n",
+		       hdr->eh_depth, d);
+		return -1;
+	}
+	if (sizeof(hdr) + sizeof(struct ext3_extent)*hdr->eh_entries >
+	    sizeof(blockbuf[d])) {
+		printf("ext3_extent_load_find: extent is larger than buffer\n");
+		return -1;
+	}
+
+	if (hdr->eh_depth == 0)
+		return ext3_extent_leaf_find(hdr, blkoff);
+	else
+		return ext3_extent_node_find(ip, hdr, blkoff);
+}
+
+/*
+ * Map a block using the extents tree
+ */
+static int ext3_extent_blkno(struct ext2_inode *ip, int blkoff)
+{
+	struct ext3_extent_header *hdr = ext3_extent_header(ip);
+
+
+	if (hdr->eh_depth == 0)
+		return ext3_extent_leaf_find(hdr, blkoff);
+	else
+		return ext3_extent_node_find(ip, hdr, blkoff);
+}
+
 
 /*
  * Map a block offset into a file into an absolute block number.
@@ -385,6 +548,9 @@ static int ext2_blkno(struct ext2_inode *ip, int blkoff)
 	int diblkno;
 	unsigned long offset;
 
+	if (ip->i_flags & EXT3_EXTENTS_FL)
+		return ext3_extent_blkno(ip, blkoff);
+
 	ilp = (unsigned int *)iblkbuf;
 	dlp = (unsigned int *)diblkbuf;
 
-- 
2.16.4

