Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB1D44B81A6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Feb 2022 08:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbiBPHdy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Feb 2022 02:33:54 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:58682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbiBPHdx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Feb 2022 02:33:53 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14A226EB;
        Tue, 15 Feb 2022 23:33:41 -0800 (PST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21G6lbVt002668;
        Wed, 16 Feb 2022 07:03:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=IkwWHTUurc3FRvmLx4bTbyh2Vu3qBiUStceolJtq9jw=;
 b=CoV6jkJEOWmmvQBAoBIx8C+r1M9qQ45K/K9ylPVGgmvxSYD25VGWs4ktv1O1iWfQ9Ryy
 SVnbm2dqqdDTqBuPjDtChkkTbtyj4pYuL9cXHbOXJfanCSe+fzZAnoU1LInsBPk1vQIj
 mKIJU2yK+yrH6dDFPKzGPT6wJkBmd6eZ/elsP9M/eARA7CslcEEYa/jpghI0urp3irQA
 OE60ImAnc+AmpMyoPqlFkSu/OU4hPhePhWEKuED3RlHCvA629zO7VVanj+AwvIeXbJf8
 4WFxKUven8dxTVg5XzRV0oQ4tnV4/yfh2WGczPgFMg7JzSj55AJiTItJqqnGr9n+KQj8 wA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e8vah8887-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Feb 2022 07:03:10 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21G6um9j024169;
        Wed, 16 Feb 2022 07:03:10 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e8vah887b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Feb 2022 07:03:10 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21G71oCQ014775;
        Wed, 16 Feb 2022 07:03:07 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04fra.de.ibm.com with ESMTP id 3e64ha41ke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Feb 2022 07:03:07 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21G735TU22217204
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Feb 2022 07:03:05 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4D631A4064;
        Wed, 16 Feb 2022 07:03:05 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D0A47A405C;
        Wed, 16 Feb 2022 07:03:04 +0000 (GMT)
Received: from localhost (unknown [9.43.85.173])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 16 Feb 2022 07:03:04 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        linux-fsdevel@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv2 5/9] ext4: Rename ext4_set_bits to mb_set_bits
Date:   Wed, 16 Feb 2022 12:32:47 +0530
Message-Id: <f1f6ece1405b76a7a987e9145d1adfaf71e30695.1644992610.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1644992609.git.riteshh@linux.ibm.com>
References: <cover.1644992609.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -f9k9RGMq2V8wc3lSN9FSJjo1c0G9psT
X-Proofpoint-GUID: 6o1wAeQy6XZWv0o-ilfauMKcXXqzBSj8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-16_02,2022-02-14_04,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=907 phishscore=0 impostorscore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202160038
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ext4_set_bits() should actually be mb_set_bits() for uniform API naming
convention.
This is via below cmd -

grep -nr "ext4_set_bits" fs/ext4/ | cut -d ":" -f 1 | xargs sed -i 's/ext4_set_bits/mb_set_bits/g'

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/ext4.h    |  2 +-
 fs/ext4/mballoc.c | 14 +++++++-------
 fs/ext4/resize.c  |  4 ++--
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index bcd3b9bf8069..97c85ae185a9 100644
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
index 7b80c5dd9f40..c2a6f924b456 100644
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

