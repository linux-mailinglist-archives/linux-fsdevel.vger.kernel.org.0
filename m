Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02516134182
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2020 13:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbgAHMTW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jan 2020 07:19:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:55656 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727236AbgAHMTW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jan 2020 07:19:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1E982B275;
        Wed,  8 Jan 2020 12:19:21 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E228D1E0B47; Wed,  8 Jan 2020 13:19:20 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH] udf: Fix free space reporting for metadata and virtual partitions
Date:   Wed,  8 Jan 2020 13:19:19 +0100
Message-Id: <20200108121919.12343-1-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Free space on filesystems with metadata or virtual partition maps
currently gets misreported. This is because these partitions are just
remapped onto underlying real partitions from which keep track of free
blocks. Take this remapping into account when counting free blocks as
well.

Reported-by: Pali Rohár <pali.rohar@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/super.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

I plan to take this patch to my tree.

diff --git a/fs/udf/super.c b/fs/udf/super.c
index 8c28e93e9b73..b89e420a4b85 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -2492,17 +2492,26 @@ static unsigned int udf_count_free_table(struct super_block *sb,
 static unsigned int udf_count_free(struct super_block *sb)
 {
 	unsigned int accum = 0;
-	struct udf_sb_info *sbi;
+	struct udf_sb_info *sbi = UDF_SB(sb);
 	struct udf_part_map *map;
+	unsigned int part = sbi->s_partition;
+	int ptype = sbi->s_partmaps[part].s_partition_type;
+
+	if (ptype == UDF_METADATA_MAP25) {
+		part = sbi->s_partmaps[part].s_type_specific.s_metadata.
+							s_phys_partition_ref;
+	} else if (ptype == UDF_VIRTUAL_MAP15 || ptype == UDF_VIRTUAL_MAP20) {
+		part = UDF_I(sbi->s_vat_inode)->i_location.
+							partitionReferenceNum;
+	}
 
-	sbi = UDF_SB(sb);
 	if (sbi->s_lvid_bh) {
 		struct logicalVolIntegrityDesc *lvid =
 			(struct logicalVolIntegrityDesc *)
 			sbi->s_lvid_bh->b_data;
-		if (le32_to_cpu(lvid->numOfPartitions) > sbi->s_partition) {
+		if (le32_to_cpu(lvid->numOfPartitions) > part) {
 			accum = le32_to_cpu(
-					lvid->freeSpaceTable[sbi->s_partition]);
+					lvid->freeSpaceTable[part]);
 			if (accum == 0xFFFFFFFF)
 				accum = 0;
 		}
@@ -2511,7 +2520,7 @@ static unsigned int udf_count_free(struct super_block *sb)
 	if (accum)
 		return accum;
 
-	map = &sbi->s_partmaps[sbi->s_partition];
+	map = &sbi->s_partmaps[part];
 	if (map->s_partition_flags & UDF_PART_FLAG_UNALLOC_BITMAP) {
 		accum += udf_count_free_bitmap(sb,
 					       map->s_uspace.s_bitmap);
-- 
2.16.4

