Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2AF4AA94B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Feb 2022 15:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380089AbiBEOKZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Feb 2022 09:10:25 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:24262 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1380085AbiBEOKY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Feb 2022 09:10:24 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 215AlRrC006979;
        Sat, 5 Feb 2022 14:10:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=qKTwEI1OWCxGjIbwTR3EX/HJgAkRBNNkiDslzHcy8ig=;
 b=QsprOmvFtUpvUxj8WbKwuk5SNrHer9UUynroGMzv3Ybt8aS3jNuzHmERUOUwsZbmpIqU
 R3zTYyZE7qVwQsGhp3qmzWxXQwYWzcnCesokM4B22S0cbqEj/Pehvq1seHEeW9bijvru
 vXb32ARVCI2BN+sIForNEodusW2nSLBIBgUekmMVzqnzi8Us1tlj7vsDAwAwP9zkCqar
 UvSahKr6/iGIb+PmSr4b4FJ/J2CJsNThAofctZ46hdtcUGfOE/Ckwv4ENb1O8FqailuM
 feFU3xCS9R+mSAazF+5Bfb5E7MQAKKeydYKsEoY36dzyErbaOtMEp/RvqAhYdq1bQZMY KA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e1hvby3hn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Feb 2022 14:10:17 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 215Dwjkf010398;
        Sat, 5 Feb 2022 14:10:17 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e1hvby3h4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Feb 2022 14:10:17 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 215E3UJj006001;
        Sat, 5 Feb 2022 14:10:15 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 3e1ggja7n2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Feb 2022 14:10:15 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 215E0EBp46792976
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 5 Feb 2022 14:00:14 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BB1B8A4040;
        Sat,  5 Feb 2022 14:10:12 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 42E29A405B;
        Sat,  5 Feb 2022 14:10:11 +0000 (GMT)
Received: from localhost (unknown [9.43.12.205])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat,  5 Feb 2022 14:10:10 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Jan Kara <jack@suse.cz>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv1 2/9] ext4: Fixes ext4_mb_mark_bb() with flex_bg with fast_commit
Date:   Sat,  5 Feb 2022 19:39:51 +0530
Message-Id: <53596bdf7bd7aed66020db98d903b1653a1dbc7a.1644062450.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1644062450.git.riteshh@linux.ibm.com>
References: <cover.1644062450.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jOFEkUGFMWcyWy81C3-HnrNde2YXDtSp
X-Proofpoint-ORIG-GUID: 7rJCJgmRDospv4W_L2n1GkLk2YUIvhbP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-05_10,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 priorityscore=1501 mlxscore=0 spamscore=0 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202050095
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In case of flex_bg feature (which is by default enabled), extents for
any given inode might span across blocks from two different block group.
ext4_mb_mark_bb() only reads the buffer_head of block bitmap once for the
starting block group, but it fails to read it again when the extent length
boundary overflows to another block group. Then in this below loop it
accesses memory beyond the block group bitmap buffer_head and results
into a data abort.

	for (i = 0; i < clen; i++)
		if (!mb_test_bit(blkoff + i, bitmap_bh->b_data) == !state)
			already++;

This patch adds this functionality for checking block group boundary in
ext4_mb_mark_bb() and update the buffer_head(bitmap_bh) for every different
block group.

w/o this patch, I was easily able to hit a data access abort using Power platform.

<...>
[   74.327662] EXT4-fs error (device loop3): ext4_mb_generate_buddy:1141: group 11, block bitmap and bg descriptor inconsistent: 21248 vs 23294 free clusters
[   74.533214] EXT4-fs (loop3): shut down requested (2)
[   74.536705] Aborting journal on device loop3-8.
[   74.702705] BUG: Unable to handle kernel data access on read at 0xc00000005e980000
[   74.703727] Faulting instruction address: 0xc0000000007bffb8
cpu 0xd: Vector: 300 (Data Access) at [c000000015db7060]
    pc: c0000000007bffb8: ext4_mb_mark_bb+0x198/0x5a0
    lr: c0000000007bfeec: ext4_mb_mark_bb+0xcc/0x5a0
    sp: c000000015db7300
   msr: 800000000280b033
   dar: c00000005e980000
 dsisr: 40000000
  current = 0xc000000027af6880
  paca    = 0xc00000003ffd5200   irqmask: 0x03   irq_happened: 0x01
    pid   = 5167, comm = mount
<...>
enter ? for help
[c000000015db7380] c000000000782708 ext4_ext_clear_bb+0x378/0x410
[c000000015db7400] c000000000813f14 ext4_fc_replay+0x1794/0x2000
[c000000015db7580] c000000000833f7c do_one_pass+0xe9c/0x12a0
[c000000015db7710] c000000000834504 jbd2_journal_recover+0x184/0x2d0
[c000000015db77c0] c000000000841398 jbd2_journal_load+0x188/0x4a0
[c000000015db7880] c000000000804de8 ext4_fill_super+0x2638/0x3e10
[c000000015db7a40] c0000000005f8404 get_tree_bdev+0x2b4/0x350
[c000000015db7ae0] c0000000007ef058 ext4_get_tree+0x28/0x40
[c000000015db7b00] c0000000005f6344 vfs_get_tree+0x44/0x100
[c000000015db7b70] c00000000063c408 path_mount+0xdd8/0xe70
[c000000015db7c40] c00000000063c8f0 sys_mount+0x450/0x550
[c000000015db7d50] c000000000035770 system_call_exception+0x4a0/0x4e0
[c000000015db7e10] c00000000000c74c system_call_common+0xec/0x250

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/mballoc.c | 131 +++++++++++++++++++++++++++-------------------
 1 file changed, 76 insertions(+), 55 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 2f117ce3bb73..d0bd51b1e1ad 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3901,72 +3901,93 @@ void ext4_mb_mark_bb(struct super_block *sb, ext4_fsblk_t block,
 	ext4_grpblk_t blkoff;
 	int i, err;
 	int already;
-	unsigned int clen, clen_changed;
+	unsigned int clen, clen_changed, thisgrp_len;
 
-	clen = EXT4_NUM_B2C(sbi, len);
-
-	ext4_get_group_no_and_offset(sb, block, &group, &blkoff);
-	bitmap_bh = ext4_read_block_bitmap(sb, group);
-	if (IS_ERR(bitmap_bh)) {
-		err = PTR_ERR(bitmap_bh);
-		bitmap_bh = NULL;
-		goto out_err;
-	}
-
-	err = -EIO;
-	gdp = ext4_get_group_desc(sb, group, &gdp_bh);
-	if (!gdp)
-		goto out_err;
+	while (len > 0) {
+		ext4_get_group_no_and_offset(sb, block, &group, &blkoff);
 
-	ext4_lock_group(sb, group);
-	already = 0;
-	for (i = 0; i < clen; i++)
-		if (!mb_test_bit(blkoff + i, bitmap_bh->b_data) == !state)
-			already++;
-
-	clen_changed = clen - already;
-	if (state)
-		ext4_set_bits(bitmap_bh->b_data, blkoff, clen);
-	else
-		mb_test_and_clear_bits(bitmap_bh->b_data, blkoff, clen);
-	if (ext4_has_group_desc_csum(sb) &&
-	    (gdp->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT))) {
-		gdp->bg_flags &= cpu_to_le16(~EXT4_BG_BLOCK_UNINIT);
-		ext4_free_group_clusters_set(sb, gdp,
-					     ext4_free_clusters_after_init(sb,
-						group, gdp));
-	}
-	if (state)
-		clen = ext4_free_group_clusters(sb, gdp) - clen_changed;
-	else
-		clen = ext4_free_group_clusters(sb, gdp) + clen_changed;
+		/*
+		 * Check to see if we are freeing blocks across a group
+		 * boundary.
+		 * In case of flex_bg, this can happen that (block, len) may
+		 * span across more than one group. In that case we need to
+		 * get the corresponding group metadata to work with.
+		 * For this we have goto again loop.
+		 */
+		thisgrp_len = min_t(unsigned int, (unsigned int)len,
+			EXT4_BLOCKS_PER_GROUP(sb) - EXT4_C2B(sbi, blkoff));
+		clen = EXT4_NUM_B2C(sbi, thisgrp_len);
 
-	ext4_free_group_clusters_set(sb, gdp, clen);
-	ext4_block_bitmap_csum_set(sb, group, gdp, bitmap_bh);
-	ext4_group_desc_csum_set(sb, group, gdp);
+		bitmap_bh = ext4_read_block_bitmap(sb, group);
+		if (IS_ERR(bitmap_bh)) {
+			err = PTR_ERR(bitmap_bh);
+			bitmap_bh = NULL;
+			break;
+		}
 
-	ext4_unlock_group(sb, group);
+		err = -EIO;
+		gdp = ext4_get_group_desc(sb, group, &gdp_bh);
+		if (!gdp)
+			break;
 
-	if (sbi->s_log_groups_per_flex) {
-		ext4_group_t flex_group = ext4_flex_group(sbi, group);
-		struct flex_groups *fg = sbi_array_rcu_deref(sbi,
-					   s_flex_groups, flex_group);
+		ext4_lock_group(sb, group);
+		already = 0;
+		for (i = 0; i < clen; i++)
+			if (!mb_test_bit(blkoff + i, bitmap_bh->b_data) ==
+					 !state)
+				already++;
 
+		clen_changed = clen - already;
 		if (state)
-			atomic64_sub(clen_changed, &fg->free_clusters);
+			ext4_set_bits(bitmap_bh->b_data, blkoff, clen);
 		else
-			atomic64_add(clen_changed, &fg->free_clusters);
+			mb_test_and_clear_bits(bitmap_bh->b_data, blkoff, clen);
+		if (ext4_has_group_desc_csum(sb) &&
+		    (gdp->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT))) {
+			gdp->bg_flags &= cpu_to_le16(~EXT4_BG_BLOCK_UNINIT);
+			ext4_free_group_clusters_set(sb, gdp,
+			     ext4_free_clusters_after_init(sb, group, gdp));
+		}
+		if (state)
+			clen = ext4_free_group_clusters(sb, gdp) - clen_changed;
+		else
+			clen = ext4_free_group_clusters(sb, gdp) + clen_changed;
+
+		ext4_free_group_clusters_set(sb, gdp, clen);
+		ext4_block_bitmap_csum_set(sb, group, gdp, bitmap_bh);
+		ext4_group_desc_csum_set(sb, group, gdp);
+
+		ext4_unlock_group(sb, group);
+
+		if (sbi->s_log_groups_per_flex) {
+			ext4_group_t flex_group = ext4_flex_group(sbi, group);
+			struct flex_groups *fg = sbi_array_rcu_deref(sbi,
+						   s_flex_groups, flex_group);
+
+			if (state)
+				atomic64_sub(clen_changed, &fg->free_clusters);
+			else
+				atomic64_add(clen_changed, &fg->free_clusters);
+
+		}
+
+		err = ext4_handle_dirty_metadata(NULL, NULL, bitmap_bh);
+		if (err)
+			break;
+		sync_dirty_buffer(bitmap_bh);
+		err = ext4_handle_dirty_metadata(NULL, NULL, gdp_bh);
+		sync_dirty_buffer(gdp_bh);
+		if (err)
+			break;
+
+		block += thisgrp_len;
+		len = len - thisgrp_len;
+		put_bh(bitmap_bh);
+		BUG_ON(len < 0);
 	}
 
-	err = ext4_handle_dirty_metadata(NULL, NULL, bitmap_bh);
 	if (err)
-		goto out_err;
-	sync_dirty_buffer(bitmap_bh);
-	err = ext4_handle_dirty_metadata(NULL, NULL, gdp_bh);
-	sync_dirty_buffer(gdp_bh);
-
-out_err:
-	brelse(bitmap_bh);
+		brelse(bitmap_bh);
 }
 
 /*
-- 
2.31.1

