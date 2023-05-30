Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C56B716289
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 May 2023 15:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjE3Nsk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 09:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjE3Nsd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 09:48:33 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B00114;
        Tue, 30 May 2023 06:48:19 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34UBALCm027324;
        Tue, 30 May 2023 12:34:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=N+35H6cGzEZcml2yscuLVxwjgVgunQH7bxB+drYW3/w=;
 b=DRLkZHvqw7AQkP8kfNEyNFJnrTZM+oso5YQ+270EnZDbfI+zZCoeh0pOPXs7AzEeZ64M
 fxj4KSfRBBK1sPQTP9Rp5kX9qvBiCJ85BAX5hHnEP9Xgti7iQecBTqiKV3wFb3VhIwrp
 m4CfKvPY8FMdrMXPb5oKJorFQP+KB9+qpsCPtk541tiSGYjAIo1PXJ2BcATXbB8MW4Y7
 T5zre5sX4uKpe2YKilwuyHBU/l5lBSwx22WxliZ6puXnMM+G/QUm1Ur/noGblVB0OTTO
 rC8OmJ0//OlxHny6sVJY33lWdk+38kauTDcP9KqotX9EmDlgnbeWZNa+SKS4/ncO0DxA cw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qwbst1dwd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 12:34:08 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34UBowgd003266;
        Tue, 30 May 2023 12:34:07 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qwbst1dty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 12:34:07 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34U0oZCB017713;
        Tue, 30 May 2023 12:34:05 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3qu9g59fe0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 12:34:04 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34UCY2o241026210
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 May 2023 12:34:02 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B209720040;
        Tue, 30 May 2023 12:34:02 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9A27A20043;
        Tue, 30 May 2023 12:34:00 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.in.ibm.com (unknown [9.109.253.169])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 30 May 2023 12:34:00 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: [PATCH v2 04/12] ext4: Convert mballoc cr (criteria) to enum
Date:   Tue, 30 May 2023 18:03:42 +0530
Message-Id: <5d82fd467bdf70ea45bdaef810af3b146013946c.1685449706.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1685449706.git.ojaswin@linux.ibm.com>
References: <cover.1685449706.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nOIegfHLqILxEieNPHDEaDb-XIvKRxKG
X-Proofpoint-GUID: wtp93fRy3ivtwq74yRJOktMgccJFKorK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_08,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 mlxscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305300103
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert criteria to be an enum so it easier to maintain and
update the tracefiles to use enum names. This change also makes
it easier to insert new criterias in the future.

There is no functional change in this patch.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext4/ext4.h              | 23 +++++++--
 fs/ext4/mballoc.c           | 96 ++++++++++++++++++-------------------
 include/trace/events/ext4.h | 16 ++++++-
 3 files changed, 82 insertions(+), 53 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index c075da665ec1..f9a4eaa10c6a 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -127,6 +127,23 @@ enum SHIFT_DIRECTION {
 	SHIFT_RIGHT,
 };
 
+/*
+ * Number of criterias defined. For each criteria, mballoc has slightly
+ * different way of finding the required blocks nad usually, higher the
+ * criteria the slower the allocation. We start at lower criterias and keep
+ * falling back to higher ones if we are not able to find any blocks.
+ */
+#define EXT4_MB_NUM_CRS 4
+/*
+ * All possible allocation criterias for mballoc
+ */
+enum criteria {
+	CR0,
+	CR1,
+	CR2,
+	CR3,
+};
+
 /*
  * Flags used in mballoc's allocation_context flags field.
  *
@@ -1542,9 +1559,9 @@ struct ext4_sb_info {
 	atomic_t s_bal_2orders;	/* 2^order hits */
 	atomic_t s_bal_cr0_bad_suggestions;
 	atomic_t s_bal_cr1_bad_suggestions;
-	atomic64_t s_bal_cX_groups_considered[4];
-	atomic64_t s_bal_cX_hits[4];
-	atomic64_t s_bal_cX_failed[4];		/* cX loop didn't find blocks */
+	atomic64_t s_bal_cX_groups_considered[EXT4_MB_NUM_CRS];
+	atomic64_t s_bal_cX_hits[EXT4_MB_NUM_CRS];
+	atomic64_t s_bal_cX_failed[EXT4_MB_NUM_CRS];		/* cX loop didn't find blocks */
 	atomic_t s_mb_buddies_generated;	/* number of buddies generated */
 	atomic64_t s_mb_generation_time;
 	atomic_t s_mb_lost_chunks;
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 9d73f61458d4..97eaa22b907d 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -155,19 +155,19 @@
  * structures to decide the order in which groups are to be traversed for
  * fulfilling an allocation request.
  *
- * At CR = 0, we look for groups which have the largest_free_order >= the order
+ * At CR0 , we look for groups which have the largest_free_order >= the order
  * of the request. We directly look at the largest free order list in the data
  * structure (1) above where largest_free_order = order of the request. If that
  * list is empty, we look at remaining list in the increasing order of
- * largest_free_order. This allows us to perform CR = 0 lookup in O(1) time.
+ * largest_free_order. This allows us to perform CR0 lookup in O(1) time.
  *
- * At CR = 1, we only consider groups where average fragment size > request
+ * At CR1, we only consider groups where average fragment size > request
  * size. So, we lookup a group which has average fragment size just above or
  * equal to request size using our average fragment size group lists (data
  * structure 2) in O(1) time.
  *
  * If "mb_optimize_scan" mount option is not set, mballoc traverses groups in
- * linear order which requires O(N) search time for each CR 0 and CR 1 phase.
+ * linear order which requires O(N) search time for each CR0 and CR1 phase.
  *
  * The regular allocator (using the buddy cache) supports a few tunables.
  *
@@ -410,7 +410,7 @@ static void ext4_mb_generate_from_freelist(struct super_block *sb, void *bitmap,
 static void ext4_mb_new_preallocation(struct ext4_allocation_context *ac);
 
 static bool ext4_mb_good_group(struct ext4_allocation_context *ac,
-			       ext4_group_t group, int cr);
+			       ext4_group_t group, enum criteria cr);
 
 static int ext4_try_to_trim_range(struct super_block *sb,
 		struct ext4_buddy *e4b, ext4_grpblk_t start,
@@ -860,7 +860,7 @@ mb_update_avg_fragment_size(struct super_block *sb, struct ext4_group_info *grp)
  * cr level needs an update.
  */
 static void ext4_mb_choose_next_group_cr0(struct ext4_allocation_context *ac,
-			int *new_cr, ext4_group_t *group, ext4_group_t ngroups)
+			enum criteria *new_cr, ext4_group_t *group, ext4_group_t ngroups)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
 	struct ext4_group_info *iter, *grp;
@@ -885,8 +885,8 @@ static void ext4_mb_choose_next_group_cr0(struct ext4_allocation_context *ac,
 		list_for_each_entry(iter, &sbi->s_mb_largest_free_orders[i],
 				    bb_largest_free_order_node) {
 			if (sbi->s_mb_stats)
-				atomic64_inc(&sbi->s_bal_cX_groups_considered[0]);
-			if (likely(ext4_mb_good_group(ac, iter->bb_group, 0))) {
+				atomic64_inc(&sbi->s_bal_cX_groups_considered[CR0]);
+			if (likely(ext4_mb_good_group(ac, iter->bb_group, CR0))) {
 				grp = iter;
 				break;
 			}
@@ -898,7 +898,7 @@ static void ext4_mb_choose_next_group_cr0(struct ext4_allocation_context *ac,
 
 	if (!grp) {
 		/* Increment cr and search again */
-		*new_cr = 1;
+		*new_cr = CR1;
 	} else {
 		*group = grp->bb_group;
 		ac->ac_flags |= EXT4_MB_CR0_OPTIMIZED;
@@ -910,7 +910,7 @@ static void ext4_mb_choose_next_group_cr0(struct ext4_allocation_context *ac,
  * order. Updates *new_cr if cr level needs an update.
  */
 static void ext4_mb_choose_next_group_cr1(struct ext4_allocation_context *ac,
-		int *new_cr, ext4_group_t *group, ext4_group_t ngroups)
+		enum criteria *new_cr, ext4_group_t *group, ext4_group_t ngroups)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
 	struct ext4_group_info *grp = NULL, *iter;
@@ -933,8 +933,8 @@ static void ext4_mb_choose_next_group_cr1(struct ext4_allocation_context *ac,
 		list_for_each_entry(iter, &sbi->s_mb_avg_fragment_size[i],
 				    bb_avg_fragment_size_node) {
 			if (sbi->s_mb_stats)
-				atomic64_inc(&sbi->s_bal_cX_groups_considered[1]);
-			if (likely(ext4_mb_good_group(ac, iter->bb_group, 1))) {
+				atomic64_inc(&sbi->s_bal_cX_groups_considered[CR1]);
+			if (likely(ext4_mb_good_group(ac, iter->bb_group, CR1))) {
 				grp = iter;
 				break;
 			}
@@ -948,7 +948,7 @@ static void ext4_mb_choose_next_group_cr1(struct ext4_allocation_context *ac,
 		*group = grp->bb_group;
 		ac->ac_flags |= EXT4_MB_CR1_OPTIMIZED;
 	} else {
-		*new_cr = 2;
+		*new_cr = CR2;
 	}
 }
 
@@ -956,7 +956,7 @@ static inline int should_optimize_scan(struct ext4_allocation_context *ac)
 {
 	if (unlikely(!test_opt2(ac->ac_sb, MB_OPTIMIZE_SCAN)))
 		return 0;
-	if (ac->ac_criteria >= 2)
+	if (ac->ac_criteria >= CR2)
 		return 0;
 	if (!ext4_test_inode_flag(ac->ac_inode, EXT4_INODE_EXTENTS))
 		return 0;
@@ -1001,7 +1001,7 @@ next_linear_group(struct ext4_allocation_context *ac, int group, int ngroups)
  * @ngroups   Total number of groups
  */
 static void ext4_mb_choose_next_group(struct ext4_allocation_context *ac,
-		int *new_cr, ext4_group_t *group, ext4_group_t ngroups)
+		enum criteria *new_cr, ext4_group_t *group, ext4_group_t ngroups)
 {
 	*new_cr = ac->ac_criteria;
 
@@ -1010,9 +1010,9 @@ static void ext4_mb_choose_next_group(struct ext4_allocation_context *ac,
 		return;
 	}
 
-	if (*new_cr == 0) {
+	if (*new_cr == CR0) {
 		ext4_mb_choose_next_group_cr0(ac, new_cr, group, ngroups);
-	} else if (*new_cr == 1) {
+	} else if (*new_cr == CR1) {
 		ext4_mb_choose_next_group_cr1(ac, new_cr, group, ngroups);
 	} else {
 		/*
@@ -2409,13 +2409,13 @@ void ext4_mb_scan_aligned(struct ext4_allocation_context *ac,
  * for the allocation or not.
  */
 static bool ext4_mb_good_group(struct ext4_allocation_context *ac,
-				ext4_group_t group, int cr)
+				ext4_group_t group, enum criteria cr)
 {
 	ext4_grpblk_t free, fragments;
 	int flex_size = ext4_flex_bg_size(EXT4_SB(ac->ac_sb));
 	struct ext4_group_info *grp = ext4_get_group_info(ac->ac_sb, group);
 
-	BUG_ON(cr < 0 || cr >= 4);
+	BUG_ON(cr < CR0 || cr >= EXT4_MB_NUM_CRS);
 
 	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(grp) || !grp))
 		return false;
@@ -2429,7 +2429,7 @@ static bool ext4_mb_good_group(struct ext4_allocation_context *ac,
 		return false;
 
 	switch (cr) {
-	case 0:
+	case CR0:
 		BUG_ON(ac->ac_2order == 0);
 
 		/* Avoid using the first bg of a flexgroup for data files */
@@ -2448,15 +2448,15 @@ static bool ext4_mb_good_group(struct ext4_allocation_context *ac,
 			return false;
 
 		return true;
-	case 1:
+	case CR1:
 		if ((free / fragments) >= ac->ac_g_ex.fe_len)
 			return true;
 		break;
-	case 2:
+	case CR2:
 		if (free >= ac->ac_g_ex.fe_len)
 			return true;
 		break;
-	case 3:
+	case CR3:
 		return true;
 	default:
 		BUG();
@@ -2477,7 +2477,7 @@ static bool ext4_mb_good_group(struct ext4_allocation_context *ac,
  * out"!
  */
 static int ext4_mb_good_group_nolock(struct ext4_allocation_context *ac,
-				     ext4_group_t group, int cr)
+				     ext4_group_t group, enum criteria cr)
 {
 	struct ext4_group_info *grp = ext4_get_group_info(ac->ac_sb, group);
 	struct super_block *sb = ac->ac_sb;
@@ -2497,7 +2497,7 @@ static int ext4_mb_good_group_nolock(struct ext4_allocation_context *ac,
 	free = grp->bb_free;
 	if (free == 0)
 		goto out;
-	if (cr <= 2 && free < ac->ac_g_ex.fe_len)
+	if (cr <= CR2 && free < ac->ac_g_ex.fe_len)
 		goto out;
 	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(grp)))
 		goto out;
@@ -2512,7 +2512,7 @@ static int ext4_mb_good_group_nolock(struct ext4_allocation_context *ac,
 			ext4_get_group_desc(sb, group, NULL);
 		int ret;
 
-		/* cr=0/1 is a very optimistic search to find large
+		/* cr=CR0/CR1 is a very optimistic search to find large
 		 * good chunks almost for free.  If buddy data is not
 		 * ready, then this optimization makes no sense.  But
 		 * we never skip the first block group in a flex_bg,
@@ -2520,7 +2520,7 @@ static int ext4_mb_good_group_nolock(struct ext4_allocation_context *ac,
 		 * and we want to make sure we locate metadata blocks
 		 * in the first block group in the flex_bg if possible.
 		 */
-		if (cr < 2 &&
+		if (cr < CR2 &&
 		    (!sbi->s_log_groups_per_flex ||
 		     ((group & ((1 << sbi->s_log_groups_per_flex) - 1)) != 0)) &&
 		    !(ext4_has_group_desc_csum(sb) &&
@@ -2626,7 +2626,7 @@ static noinline_for_stack int
 ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 {
 	ext4_group_t prefetch_grp = 0, ngroups, group, i;
-	int cr = -1, new_cr;
+	enum criteria cr, new_cr;
 	int err = 0, first_err = 0;
 	unsigned int nr = 0, prefetch_ios = 0;
 	struct ext4_sb_info *sbi;
@@ -2684,13 +2684,13 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 	}
 
 	/* Let's just scan groups to find more-less suitable blocks */
-	cr = ac->ac_2order ? 0 : 1;
+	cr = ac->ac_2order ? CR0 : CR1;
 	/*
-	 * cr == 0 try to get exact allocation,
-	 * cr == 3  try to get anything
+	 * cr == CR0 try to get exact allocation,
+	 * cr == CR3 try to get anything
 	 */
 repeat:
-	for (; cr < 4 && ac->ac_status == AC_STATUS_CONTINUE; cr++) {
+	for (; cr < EXT4_MB_NUM_CRS && ac->ac_status == AC_STATUS_CONTINUE; cr++) {
 		ac->ac_criteria = cr;
 		/*
 		 * searching for the right group start
@@ -2717,7 +2717,7 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 			 * spend a lot of time loading imperfect groups
 			 */
 			if ((prefetch_grp == group) &&
-			    (cr > 1 ||
+			    (cr > CR1 ||
 			     prefetch_ios < sbi->s_mb_prefetch_limit)) {
 				unsigned int curr_ios = prefetch_ios;
 
@@ -2759,9 +2759,9 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 			}
 
 			ac->ac_groups_scanned++;
-			if (cr == 0)
+			if (cr == CR0)
 				ext4_mb_simple_scan_group(ac, &e4b);
-			else if (cr == 1 && sbi->s_stripe &&
+			else if (cr == CR1 && sbi->s_stripe &&
 				 !(ac->ac_g_ex.fe_len %
 				 EXT4_B2C(sbi, sbi->s_stripe)))
 				ext4_mb_scan_aligned(ac, &e4b);
@@ -2802,7 +2802,7 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 			ac->ac_b_ex.fe_len = 0;
 			ac->ac_status = AC_STATUS_CONTINUE;
 			ac->ac_flags |= EXT4_MB_HINT_FIRST;
-			cr = 3;
+			cr = CR3;
 			goto repeat;
 		}
 	}
@@ -2927,36 +2927,36 @@ int ext4_seq_mb_stats_show(struct seq_file *seq, void *offset)
 	seq_printf(seq, "\tgroups_scanned: %u\n",  atomic_read(&sbi->s_bal_groups_scanned));
 
 	seq_puts(seq, "\tcr0_stats:\n");
-	seq_printf(seq, "\t\thits: %llu\n", atomic64_read(&sbi->s_bal_cX_hits[0]));
+	seq_printf(seq, "\t\thits: %llu\n", atomic64_read(&sbi->s_bal_cX_hits[CR0]));
 	seq_printf(seq, "\t\tgroups_considered: %llu\n",
-		   atomic64_read(&sbi->s_bal_cX_groups_considered[0]));
+		   atomic64_read(&sbi->s_bal_cX_groups_considered[CR0]));
 	seq_printf(seq, "\t\tuseless_loops: %llu\n",
-		   atomic64_read(&sbi->s_bal_cX_failed[0]));
+		   atomic64_read(&sbi->s_bal_cX_failed[CR0]));
 	seq_printf(seq, "\t\tbad_suggestions: %u\n",
 		   atomic_read(&sbi->s_bal_cr0_bad_suggestions));
 
 	seq_puts(seq, "\tcr1_stats:\n");
-	seq_printf(seq, "\t\thits: %llu\n", atomic64_read(&sbi->s_bal_cX_hits[1]));
+	seq_printf(seq, "\t\thits: %llu\n", atomic64_read(&sbi->s_bal_cX_hits[CR1]));
 	seq_printf(seq, "\t\tgroups_considered: %llu\n",
-		   atomic64_read(&sbi->s_bal_cX_groups_considered[1]));
+		   atomic64_read(&sbi->s_bal_cX_groups_considered[CR1]));
 	seq_printf(seq, "\t\tuseless_loops: %llu\n",
-		   atomic64_read(&sbi->s_bal_cX_failed[1]));
+		   atomic64_read(&sbi->s_bal_cX_failed[CR1]));
 	seq_printf(seq, "\t\tbad_suggestions: %u\n",
 		   atomic_read(&sbi->s_bal_cr1_bad_suggestions));
 
 	seq_puts(seq, "\tcr2_stats:\n");
-	seq_printf(seq, "\t\thits: %llu\n", atomic64_read(&sbi->s_bal_cX_hits[2]));
+	seq_printf(seq, "\t\thits: %llu\n", atomic64_read(&sbi->s_bal_cX_hits[CR2]));
 	seq_printf(seq, "\t\tgroups_considered: %llu\n",
-		   atomic64_read(&sbi->s_bal_cX_groups_considered[2]));
+		   atomic64_read(&sbi->s_bal_cX_groups_considered[CR2]));
 	seq_printf(seq, "\t\tuseless_loops: %llu\n",
-		   atomic64_read(&sbi->s_bal_cX_failed[2]));
+		   atomic64_read(&sbi->s_bal_cX_failed[CR2]));
 
 	seq_puts(seq, "\tcr3_stats:\n");
-	seq_printf(seq, "\t\thits: %llu\n", atomic64_read(&sbi->s_bal_cX_hits[3]));
+	seq_printf(seq, "\t\thits: %llu\n", atomic64_read(&sbi->s_bal_cX_hits[CR3]));
 	seq_printf(seq, "\t\tgroups_considered: %llu\n",
-		   atomic64_read(&sbi->s_bal_cX_groups_considered[3]));
+		   atomic64_read(&sbi->s_bal_cX_groups_considered[CR3]));
 	seq_printf(seq, "\t\tuseless_loops: %llu\n",
-		   atomic64_read(&sbi->s_bal_cX_failed[3]));
+		   atomic64_read(&sbi->s_bal_cX_failed[CR3]));
 	seq_printf(seq, "\textents_scanned: %u\n", atomic_read(&sbi->s_bal_ex_scanned));
 	seq_printf(seq, "\t\tgoal_hits: %u\n", atomic_read(&sbi->s_bal_goals));
 	seq_printf(seq, "\t\t2^n_hits: %u\n", atomic_read(&sbi->s_bal_2orders));
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index ebccf6a6aa1b..f062147ca32b 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -120,6 +120,18 @@ TRACE_DEFINE_ENUM(EXT4_FC_REASON_MAX);
 		{ EXT4_FC_REASON_INODE_JOURNAL_DATA,	"INODE_JOURNAL_DATA"}, \
 		{ EXT4_FC_REASON_ENCRYPTED_FILENAME,	"ENCRYPTED_FILENAME"})
 
+TRACE_DEFINE_ENUM(CR0);
+TRACE_DEFINE_ENUM(CR1);
+TRACE_DEFINE_ENUM(CR2);
+TRACE_DEFINE_ENUM(CR3);
+
+#define show_criteria(cr)                       \
+	__print_symbolic(cr,                    \
+			 { CR0, "CR0" },	\
+			 { CR1, "CR1" },        \
+			 { CR2, "CR2" },        \
+			 { CR3, "CR3" })
+
 TRACE_EVENT(ext4_other_inode_update_time,
 	TP_PROTO(struct inode *inode, ino_t orig_ino),
 
@@ -1063,7 +1075,7 @@ TRACE_EVENT(ext4_mballoc_alloc,
 	),
 
 	TP_printk("dev %d,%d inode %lu orig %u/%d/%u@%u goal %u/%d/%u@%u "
-		  "result %u/%d/%u@%u blks %u grps %u cr %u flags %s "
+		  "result %u/%d/%u@%u blks %u grps %u cr %s flags %s "
 		  "tail %u broken %u",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  (unsigned long) __entry->ino,
@@ -1073,7 +1085,7 @@ TRACE_EVENT(ext4_mballoc_alloc,
 		  __entry->goal_len, __entry->goal_logical,
 		  __entry->result_group, __entry->result_start,
 		  __entry->result_len, __entry->result_logical,
-		  __entry->found, __entry->groups, __entry->cr,
+		  __entry->found, __entry->groups, show_criteria(__entry->cr),
 		  show_mballoc_flags(__entry->flags), __entry->tail,
 		  __entry->buddy ? 1 << __entry->buddy : 0)
 );
-- 
2.31.1

