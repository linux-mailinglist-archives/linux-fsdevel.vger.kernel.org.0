Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D65D51349C7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2020 18:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbgAHRur (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jan 2020 12:50:47 -0500
Received: from verein.lst.de ([213.95.11.211]:50484 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727181AbgAHRur (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jan 2020 12:50:47 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8DE3968BFE; Wed,  8 Jan 2020 18:50:44 +0100 (CET)
Date:   Wed, 8 Jan 2020 18:50:44 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, linkinjeon@gmail.com, pali.rohar@gmail.com
Subject: Re: [PATCH v9 03/13] exfat: add inode operations
Message-ID: <20200108175044.GA14009@lst.de>
References: <20200102082036.29643-1-namjae.jeon@samsung.com> <CGME20200102082402epcas1p47cdc0873473f99c5d81f56865bb94abc@epcas1p4.samsung.com> <20200102082036.29643-4-namjae.jeon@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200102082036.29643-4-namjae.jeon@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 02, 2020 at 04:20:26PM +0800, Namjae Jeon wrote:
> +#include "exfat_fs.h"
> +
> +/* 2-level option flag */
> +enum {
> +	BMAP_NOT_CREATE,
> +	BMAP_ADD_CLUSTER,
> +};

I looked at how this flag is used and found the get_block code a little
confusing.  Let me know what you think of the following untested patch to
streamline that area:


diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index c2b04537cb24..ccf9700c6a55 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -17,12 +17,6 @@
 #include "exfat_raw.h"
 #include "exfat_fs.h"
 
-/* 2-level option flag */
-enum {
-	BMAP_NOT_CREATE,
-	BMAP_ADD_CLUSTER,
-};
-
 static int __exfat_write_inode(struct inode *inode, int sync)
 {
 	int ret = -EIO;
@@ -298,109 +292,91 @@ static int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
 	return 0;
 }
 
-static int exfat_bmap(struct inode *inode, sector_t sector, sector_t *phys,
-		unsigned long *mapped_blocks, int *create)
+static int exfat_map_new_buffer(struct exfat_inode_info *ei,
+		struct buffer_head *bh, loff_t pos)
 {
-	struct super_block *sb = inode->i_sb;
-	struct exfat_sb_info *sbi = EXFAT_SB(sb);
-	sector_t last_block;
-	unsigned int cluster, clu_offset, sec_offset;
-	int err = 0;
-
-	*phys = 0;
-	*mapped_blocks = 0;
-
-	last_block = EXFAT_B_TO_BLK_ROUND_UP(i_size_read(inode), sb);
-	if (sector >= last_block && *create == BMAP_NOT_CREATE)
-		return 0;
-
-	/* Is this block already allocated? */
-	clu_offset = sector >> sbi->sect_per_clus_bits;  /* cluster offset */
-
-	err = exfat_map_cluster(inode, clu_offset, &cluster,
-		*create & BMAP_ADD_CLUSTER);
-	if (err) {
-		if (err != -ENOSPC)
-			return -EIO;
-		return err;
-	}
-
-	if (cluster != EXFAT_EOF_CLUSTER) {
-		/* sector offset in cluster */
-		sec_offset = sector & (sbi->sect_per_clus - 1);
-
-		*phys = exfat_cluster_to_sector(sbi, cluster) + sec_offset;
-		*mapped_blocks = sbi->sect_per_clus - sec_offset;
-	}
+	if (buffer_delay(bh) && pos > ei->i_size_aligned)
+		return -EIO;
+	set_buffer_new(bh);
 
-	if (sector < last_block)
-		*create = BMAP_NOT_CREATE;
+	/*
+	 * Adjust i_size_aligned if i_size_ondisk is bigger than it.
+	 * (i.e. non-DA)
+	 */
+	if (ei->i_size_ondisk > ei->i_size_aligned)
+		ei->i_size_aligned = ei->i_size_ondisk;
 	return 0;
 }
 
 static int exfat_get_block(struct inode *inode, sector_t iblock,
 		struct buffer_head *bh_result, int create)
 {
+	struct exfat_inode_info *ei = EXFAT_I(inode);
 	struct super_block *sb = inode->i_sb;
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
 	unsigned long max_blocks = bh_result->b_size >> inode->i_blkbits;
 	int err = 0;
-	unsigned long mapped_blocks;
-	sector_t phys;
+	unsigned long mapped_blocks = 0;
+	unsigned int cluster, sec_offset;
+	sector_t last_block;
+	sector_t phys = 0;
 	loff_t pos;
-	int bmap_create = create ? BMAP_ADD_CLUSTER : BMAP_NOT_CREATE;
+	
+	mutex_lock(&sbi->s_lock);
+	last_block = EXFAT_B_TO_BLK_ROUND_UP(i_size_read(inode), sb);
+	if (iblock >= last_block && !create)
+		goto done;
 
-	mutex_lock(&EXFAT_SB(sb)->s_lock);
-	err = exfat_bmap(inode, iblock, &phys, &mapped_blocks, &bmap_create);
+	/* Is this block already allocated? */
+	err = exfat_map_cluster(inode, iblock >> sbi->sect_per_clus_bits,
+				&cluster, create);
 	if (err) {
-		if (err != -ENOSPC)
-			exfat_fs_error_ratelimit(sb,
-				"failed to bmap (inode : %p iblock : %llu, err : %d)",
-				inode, (unsigned long long)iblock, err);
+		if (err == -ENOSPC)
+			goto unlock_ret;
+
+		exfat_fs_error_ratelimit(sb,
+			"failed to bmap (inode : %p iblock : %llu, err : %d)",
+			inode, (unsigned long long)iblock, err);
 		goto unlock_ret;
 	}
 
-	if (phys) {
-		max_blocks = min(mapped_blocks, max_blocks);
-
-		/* Treat newly added block / cluster */
-		if (bmap_create || buffer_delay(bh_result)) {
-			/* Update i_size_ondisk */
-			pos = EXFAT_BLK_TO_B((iblock + 1), sb);
-			if (EXFAT_I(inode)->i_size_ondisk < pos)
-				EXFAT_I(inode)->i_size_ondisk = pos;
-
-			if (bmap_create) {
-				if (buffer_delay(bh_result) &&
-				    pos > EXFAT_I(inode)->i_size_aligned) {
-					exfat_fs_error(sb,
-						"requested for bmap out of range(pos : (%llu) > i_size_aligned(%llu)\n",
-						pos,
-						EXFAT_I(inode)->i_size_aligned);
-					err = -EIO;
-					goto unlock_ret;
-				}
-				set_buffer_new(bh_result);
-
-				/*
-				 * adjust i_size_aligned if i_size_ondisk is
-				 * bigger than it. (i.e. non-DA)
-				 */
-				if (EXFAT_I(inode)->i_size_ondisk >
-				    EXFAT_I(inode)->i_size_aligned) {
-					EXFAT_I(inode)->i_size_aligned =
-						EXFAT_I(inode)->i_size_ondisk;
-				}
-			}
+	if (cluster == EXFAT_EOF_CLUSTER)
+		goto done;
+
+	/* sector offset in cluster */
+	sec_offset = iblock & (sbi->sect_per_clus - 1);
+
+	phys = exfat_cluster_to_sector(sbi, cluster) + sec_offset;
+	mapped_blocks = sbi->sect_per_clus - sec_offset;
+	max_blocks = min(mapped_blocks, max_blocks);
 
-			if (buffer_delay(bh_result))
-				clear_buffer_delay(bh_result);
+	/* Treat newly added block / cluster */
+	if (iblock < last_block)
+		create = 0;
+
+	if (create || buffer_delay(bh_result)) {
+		pos = EXFAT_BLK_TO_B((iblock + 1), sb);
+		if (ei->i_size_ondisk < pos)
+			ei->i_size_ondisk = pos;
+	}
+
+	if (create) {
+		err = exfat_map_new_buffer(ei, bh_result, pos);
+		if (err) {
+			exfat_fs_error(sb,
+				"requested for bmap out of range(pos : (%llu) > i_size_aligned(%llu)\n",
+				pos, ei->i_size_aligned);
+			goto unlock_ret;
 		}
-		map_bh(bh_result, sb, phys);
 	}
 
+	if (buffer_delay(bh_result))
+		clear_buffer_delay(bh_result);
+	map_bh(bh_result, sb, phys);
+done:
 	bh_result->b_size = EXFAT_BLK_TO_B(max_blocks, sb);
 unlock_ret:
-	mutex_unlock(&EXFAT_SB(sb)->s_lock);
+	mutex_unlock(&sbi->s_lock);
 	return err;
 }
 
