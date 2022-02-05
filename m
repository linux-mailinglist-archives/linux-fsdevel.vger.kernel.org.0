Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE67D4AA952
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Feb 2022 15:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380098AbiBEOKj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Feb 2022 09:10:39 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58300 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1380083AbiBEOKi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Feb 2022 09:10:38 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21593rvP026250;
        Sat, 5 Feb 2022 14:10:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=H9H4xgYe/HHEOuVjclUsjWgT4r2GN2BR2UlJGiBaKEI=;
 b=arPSscEvEzRaFluf+tm1w1VZECq9xpdhjQlMQceYRo0HFV2RhdQd/xosWZMCq+rSwmzK
 5AmUtJVXRWjhwAw3j+ZqN+GfMc6r+P0x7zQvq71SKsnetfZxCI3NF1bfXPSDzZ4ru/XO
 aC+4fI71N7/O3ySK0a269nqDFM+Fu/WX8y3KIDScMwqYoqA0YZxkCF1B8894bFM7UZTj
 Zg30hXiNr02VMtWv7eFrTORoTSJBWtCgDOQftk0vULNx6vJ6tLQSyGehp1nCdhc83gIi
 F+pl2AveNfl4tLwTyOEKrjfa2Py45JXN71K69krC+NX/XOCPILPcHQiPaOIiXQSl0nnY iw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e1hq7pxsw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Feb 2022 14:10:34 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 215EAYKB027457;
        Sat, 5 Feb 2022 14:10:34 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e1hq7pxsm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Feb 2022 14:10:34 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 215E3Dgk017405;
        Sat, 5 Feb 2022 14:10:32 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 3e1gv8t5xm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Feb 2022 14:10:32 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 215EATDq43516236
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 5 Feb 2022 14:10:29 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B034B4C044;
        Sat,  5 Feb 2022 14:10:29 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AA71E4C046;
        Sat,  5 Feb 2022 14:10:28 +0000 (GMT)
Received: from localhost (unknown [9.43.12.205])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat,  5 Feb 2022 14:10:28 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Jan Kara <jack@suse.cz>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv1 5/9] ext4: Rename ext4_set_bits to mb_set_bits
Date:   Sat,  5 Feb 2022 19:39:54 +0530
Message-Id: <2751fcbeb66524472f33828d01a296191daa8fc6.1644062450.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1644062450.git.riteshh@linux.ibm.com>
References: <cover.1644062450.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6cBv-Pv632SEEo6ayobWKAfrRKtJHHqA
X-Proofpoint-ORIG-GUID: kwj8KEGjU71At9CAqT5IS6KLbK7N25qh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-05_10,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 impostorscore=0
 spamscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202050095
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ext4_set_bits() should actually be mb_set_bits() for uniform API naming
convention.
This is via below cmd -

grep -nr "ext4_set_bits" fs/ext4/ | cut -d ":" -f 1 | xargs sed -i 's/ext4_set_bits/mb_set_bits/g'

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/ext4.h    |  2 +-
 fs/ext4/mballoc.c | 14 +++++++-------
 fs/ext4/resize.c  |  4 ++--
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 09d8f60ebf0f..8c1d0e352f47 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1279,7 +1279,7 @@ struct ext4_inode_info {
 #define ext4_find_next_zero_bit		find_next_zero_bit_le
 #define ext4_find_next_bit		find_next_bit_le

-extern void ext4_set_bits(void *bm, int cur, int len);
+extern void mb_set_bits(void *bm, int cur, int len);

 /*
  * Maximal mount counts between two filesystem checks
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 91058f81a0c6..f80af108d05e 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -1689,7 +1689,7 @@ static int mb_test_and_clear_bits(void *bm, int cur, int len)
 	return zero_bit;
 }

-void ext4_set_bits(void *bm, int cur, int len)
+void mb_set_bits(void *bm, int cur, int len)
 {
 	__u32 *addr;

@@ -1996,7 +1996,7 @@ static int mb_mark_used(struct ext4_buddy *e4b, struct ext4_free_extent *ex)
 	mb_set_largest_free_order(e4b->bd_sb, e4b->bd_info);

 	mb_update_avg_fragment_size(e4b->bd_sb, e4b->bd_info);
-	ext4_set_bits(e4b->bd_bitmap, ex->fe_start, len0);
+	mb_set_bits(e4b->bd_bitmap, ex->fe_start, len0);
 	mb_check_buddy(e4b);

 	return ret;
@@ -3825,7 +3825,7 @@ ext4_mb_mark_diskspace_used(struct ext4_allocation_context *ac,
 		 * We leak some of the blocks here.
 		 */
 		ext4_lock_group(sb, ac->ac_b_ex.fe_group);
-		ext4_set_bits(bitmap_bh->b_data, ac->ac_b_ex.fe_start,
+		mb_set_bits(bitmap_bh->b_data, ac->ac_b_ex.fe_start,
 			      ac->ac_b_ex.fe_len);
 		ext4_unlock_group(sb, ac->ac_b_ex.fe_group);
 		err = ext4_handle_dirty_metadata(handle, NULL, bitmap_bh);
@@ -3844,7 +3844,7 @@ ext4_mb_mark_diskspace_used(struct ext4_allocation_context *ac,
 		}
 	}
 #endif
-	ext4_set_bits(bitmap_bh->b_data, ac->ac_b_ex.fe_start,
+	mb_set_bits(bitmap_bh->b_data, ac->ac_b_ex.fe_start,
 		      ac->ac_b_ex.fe_len);
 	if (ext4_has_group_desc_csum(sb) &&
 	    (gdp->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT))) {
@@ -3939,7 +3939,7 @@ void ext4_mb_mark_bb(struct super_block *sb, ext4_fsblk_t block,

 		clen_changed = clen - already;
 		if (state)
-			ext4_set_bits(bitmap_bh->b_data, blkoff, clen);
+			mb_set_bits(bitmap_bh->b_data, blkoff, clen);
 		else
 			mb_test_and_clear_bits(bitmap_bh->b_data, blkoff, clen);
 		if (ext4_has_group_desc_csum(sb) &&
@@ -4459,7 +4459,7 @@ static void ext4_mb_generate_from_freelist(struct super_block *sb, void *bitmap,

 	while (n) {
 		entry = rb_entry(n, struct ext4_free_data, efd_node);
-		ext4_set_bits(bitmap, entry->efd_start_cluster, entry->efd_count);
+		mb_set_bits(bitmap, entry->efd_start_cluster, entry->efd_count);
 		n = rb_next(n);
 	}
 	return;
@@ -4500,7 +4500,7 @@ void ext4_mb_generate_from_pa(struct super_block *sb, void *bitmap,
 		if (unlikely(len == 0))
 			continue;
 		BUG_ON(groupnr != group);
-		ext4_set_bits(bitmap, start, len);
+		mb_set_bits(bitmap, start, len);
 		preallocated += len;
 	}
 	mb_debug(sb, "preallocated %d for group %u\n", preallocated, group);
diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index ee8f02f406cb..f507f34be602 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -483,7 +483,7 @@ static int set_flexbg_block_bitmap(struct super_block *sb, handle_t *handle,
 		}
 		ext4_debug("mark block bitmap %#04llx (+%llu/%u)\n",
 			   first_cluster, first_cluster - start, count2);
-		ext4_set_bits(bh->b_data, first_cluster - start, count2);
+		mb_set_bits(bh->b_data, first_cluster - start, count2);

 		err = ext4_handle_dirty_metadata(handle, NULL, bh);
 		brelse(bh);
@@ -632,7 +632,7 @@ static int setup_new_flex_group_blocks(struct super_block *sb,
 		if (overhead != 0) {
 			ext4_debug("mark backup superblock %#04llx (+0)\n",
 				   start);
-			ext4_set_bits(bh->b_data, 0,
+			mb_set_bits(bh->b_data, 0,
 				      EXT4_NUM_B2C(sbi, overhead));
 		}
 		ext4_mark_bitmap_end(EXT4_B2C(sbi, group_data[i].blocks_count),
--
2.31.1

