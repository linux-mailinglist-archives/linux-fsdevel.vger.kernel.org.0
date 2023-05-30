Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38B0A7161A3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 May 2023 15:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbjE3NX6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 09:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjE3NX4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 09:23:56 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8FAB0;
        Tue, 30 May 2023 06:23:53 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34UBk7uO010419;
        Tue, 30 May 2023 12:34:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=5ppg8sWIaNmOt58tiDRr7hdnXKfZ8OMFB1aiKVovmQo=;
 b=mZOulnzXMP1IAGDVR59xxtXddurgvPAC0UbZqKjqHEr89wxr3wpt++7o3Az4x+/xCkkV
 XurRhFvC0nHTXDMLgrCh0Egt+IaIn3G7S+vAab5lcz0hKjIxcCuIvzqYzXLFbyE1/KhM
 daKAzZzwmi9KnxwYYyaW3goUsDyQrITCly/rAaCC8XmA7pd/2OejMK32SxPvMxR/iut4
 kzpp8lhK6CObpccFnWZtPUiXU5bZjrnj4QFBpFXOuZ5g3bLICsUVSGQRx/QMLzzv/jVG
 IlJRSztJRksPMTWsja05Z/bCSYLZs3lVSxIRovRUD1+AzPdi6B3WGPaloVQhDZd3Q54X Qg== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qwg5dt2n7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 12:34:26 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34U1Z7v3022973;
        Tue, 30 May 2023 12:34:23 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3qu9g518be-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 12:34:23 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34UCYLt844499304
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 May 2023 12:34:21 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0E8932004F;
        Tue, 30 May 2023 12:34:21 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7395D20043;
        Tue, 30 May 2023 12:34:19 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.in.ibm.com (unknown [9.109.253.169])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 30 May 2023 12:34:19 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Kemeng Shi <shikemeng@huaweicloud.com>
Subject: [PATCH v2 12/12] ext4: Give symbolic names to mballoc criterias
Date:   Tue, 30 May 2023 18:03:50 +0530
Message-Id: <a2dc6ec5aea5e5e68cf8e788c2a964ffead9c8b0.1685449706.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1685449706.git.ojaswin@linux.ibm.com>
References: <cover.1685449706.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5mOoeLSNM7InesJ6CLmBEpviecZDiXk5
X-Proofpoint-GUID: 5mOoeLSNM7InesJ6CLmBEpviecZDiXk5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_08,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305300103
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

mballoc criterias have historically been called by numbers
like CR0, CR1... however this makes it confusing to understand
what each criteria is about.

Change these criterias from numbers to symbolic names and add
relevant comments. While we are at it, also reformat and add some
comments to ext4_seq_mb_stats_show() for better readability.

Additionally, define CR_FAST which signifies the criteria
below which we can make quicker decisions like:
  * quitting early if (free block < requested len)
  * avoiding to scan free extents smaller than required len.
  * avoiding to initialize buddy cache and work with existing cache
  * limiting prefetches

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/ext4.h              |  55 ++++++--
 fs/ext4/mballoc.c           | 271 ++++++++++++++++++++----------------
 fs/ext4/mballoc.h           |   8 +-
 fs/ext4/sysfs.c             |   4 +-
 include/trace/events/ext4.h |  26 ++--
 5 files changed, 214 insertions(+), 150 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 942e97026a60..c29a4e1fcd5d 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -135,16 +135,45 @@ enum SHIFT_DIRECTION {
  */
 #define EXT4_MB_NUM_CRS 5
 /*
- * All possible allocation criterias for mballoc
+ * All possible allocation criterias for mballoc. Lower are faster.
  */
 enum criteria {
-	CR0,
-	CR1,
-	CR1_5,
-	CR2,
-	CR3,
+	/*
+	 * Used when number of blocks needed is a power of 2. This doesn't
+	 * trigger any disk IO except prefetch and is the fastest criteria.
+	 */
+	CR_POWER2_ALIGNED,
+
+	/*
+	 * Tries to lookup in-memory data structures to find the most suitable
+	 * group that satisfies goal request. No disk IO except block prefetch.
+	 */
+	CR_GOAL_LEN_FAST,
+
+        /*
+	 * Same as CR_GOAL_LEN_FAST but is allowed to reduce the goal length to
+         * the best available length for faster allocation.
+	 */
+	CR_BEST_AVAIL_LEN,
+
+	/*
+	 * Reads each block group sequentially, performing disk IO if necessary, to
+	 * find find_suitable block group. Tries to allocate goal length but might trim
+	 * the request if nothing is found after enough tries.
+	 */
+	CR_GOAL_LEN_SLOW,
+
+	/*
+	 * Finds the first free set of blocks and allocates those. This is only
+	 * used in rare cases when CR_GOAL_LEN_SLOW also fails to allocate
+	 * anything.
+	 */
+	CR_ANY_FREE,
 };
 
+/* criteria below which we use fast block scanning and avoid unnecessary IO */
+#define CR_FAST CR_GOAL_LEN_SLOW
+
 /*
  * Flags used in mballoc's allocation_context flags field.
  *
@@ -183,11 +212,11 @@ enum criteria {
 /* Do strict check for free blocks while retrying block allocation */
 #define EXT4_MB_STRICT_CHECK		0x4000
 /* Large fragment size list lookup succeeded at least once for cr = 0 */
-#define EXT4_MB_CR0_OPTIMIZED		0x8000
+#define EXT4_MB_CR_POWER2_ALIGNED_OPTIMIZED		0x8000
 /* Avg fragment size rb tree lookup succeeded at least once for cr = 1 */
-#define EXT4_MB_CR1_OPTIMIZED		0x00010000
+#define EXT4_MB_CR_GOAL_LEN_FAST_OPTIMIZED		0x00010000
 /* Avg fragment size rb tree lookup succeeded at least once for cr = 1.5 */
-#define EXT4_MB_CR1_5_OPTIMIZED		0x00020000
+#define EXT4_MB_CR_BEST_AVAIL_LEN_OPTIMIZED		0x00020000
 
 struct ext4_allocation_request {
 	/* target inode for block we're allocating */
@@ -1551,7 +1580,7 @@ struct ext4_sb_info {
 	unsigned long s_mb_last_start;
 	unsigned int s_mb_prefetch;
 	unsigned int s_mb_prefetch_limit;
-	unsigned int s_mb_cr1_5_max_trim_order;
+	unsigned int s_mb_best_avail_max_trim_order;
 
 	/* stats for buddy allocator */
 	atomic_t s_bal_reqs;	/* number of reqs with len > 1 */
@@ -1564,9 +1593,9 @@ struct ext4_sb_info {
 	atomic_t s_bal_len_goals;	/* len goal hits */
 	atomic_t s_bal_breaks;	/* too long searches */
 	atomic_t s_bal_2orders;	/* 2^order hits */
-	atomic_t s_bal_cr0_bad_suggestions;
-	atomic_t s_bal_cr1_bad_suggestions;
-	atomic_t s_bal_cr1_5_bad_suggestions;
+	atomic_t s_bal_p2_aligned_bad_suggestions;
+	atomic_t s_bal_goal_fast_bad_suggestions;
+	atomic_t s_bal_best_avail_bad_suggestions;
 	atomic64_t s_bal_cX_groups_considered[EXT4_MB_NUM_CRS];
 	atomic64_t s_bal_cX_hits[EXT4_MB_NUM_CRS];
 	atomic64_t s_bal_cX_failed[EXT4_MB_NUM_CRS];		/* cX loop didn't find blocks */
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 0cf037489e97..4f2a1df98141 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -155,27 +155,31 @@
  * structures to decide the order in which groups are to be traversed for
  * fulfilling an allocation request.
  *
- * At CR0 , we look for groups which have the largest_free_order >= the order
- * of the request. We directly look at the largest free order list in the data
- * structure (1) above where largest_free_order = order of the request. If that
- * list is empty, we look at remaining list in the increasing order of
- * largest_free_order. This allows us to perform CR0 lookup in O(1) time.
+ * At CR_POWER2_ALIGNED , we look for groups which have the largest_free_order
+ * >= the order of the request. We directly look at the largest free order list
+ * in the data structure (1) above where largest_free_order = order of the
+ * request. If that list is empty, we look at remaining list in the increasing
+ * order of largest_free_order. This allows us to perform CR_POWER2_ALIGNED
+ * lookup in O(1) time.
  *
- * At CR1, we only consider groups where average fragment size > request
- * size. So, we lookup a group which has average fragment size just above or
- * equal to request size using our average fragment size group lists (data
- * structure 2) in O(1) time.
+ * At CR_GOAL_LEN_FAST, we only consider groups where
+ * average fragment size > request size. So, we lookup a group which has average
+ * fragment size just above or equal to request size using our average fragment
+ * size group lists (data structure 2) in O(1) time.
  *
- * At CR1.5 (aka CR1_5), we aim to optimize allocations which can't be satisfied
- * in CR1. The fact that we couldn't find a group in CR1 suggests that there is
- * no BG that has average fragment size > goal length. So before falling to the
- * slower CR2, in CR1.5 we proactively trim goal length and then use the same
- * fragment lists as CR1 to find a BG with a big enough average fragment size.
- * This increases the chances of finding a suitable block group in O(1) time and
- * results * in faster allocation at the cost of reduced size of allocation.
+ * At CR_BEST_AVAIL_LEN, we aim to optimize allocations which can't be satisfied
+ * in CR_GOAL_LEN_FAST. The fact that we couldn't find a group in
+ * CR_GOAL_LEN_FAST suggests that there is no BG that has avg
+ * fragment size > goal length. So before falling to the slower
+ * CR_GOAL_LEN_SLOW, in CR_BEST_AVAIL_LEN we proactively trim goal length and
+ * then use the same fragment lists as CR_GOAL_LEN_FAST to find a BG with a big
+ * enough average fragment size. This increases the chances of finding a
+ * suitable block group in O(1) time and results in faster allocation at the
+ * cost of reduced size of allocation.
  *
  * If "mb_optimize_scan" mount option is not set, mballoc traverses groups in
- * linear order which requires O(N) search time for each CR0 and CR1 phase.
+ * linear order which requires O(N) search time for each CR_POWER2_ALIGNED and
+ * CR_GOAL_LEN_FAST phase.
  *
  * The regular allocator (using the buddy cache) supports a few tunables.
  *
@@ -360,8 +364,8 @@
  *  - bitlock on a group	(group)
  *  - object (inode/locality)	(object)
  *  - per-pa lock		(pa)
- *  - cr0 lists lock		(cr0)
- *  - cr1 tree lock		(cr1)
+ *  - cr_power2_aligned lists lock	(cr_power2_aligned)
+ *  - cr_goal_len_fast lists lock	(cr_goal_len_fast)
  *
  * Paths:
  *  - new pa
@@ -393,7 +397,7 @@
  *
  *  - allocation path (ext4_mb_regular_allocator)
  *    group
- *    cr0/cr1
+ *    cr_power2_aligned/cr_goal_len_fast
  */
 static struct kmem_cache *ext4_pspace_cachep;
 static struct kmem_cache *ext4_ac_cachep;
@@ -867,7 +871,7 @@ mb_update_avg_fragment_size(struct super_block *sb, struct ext4_group_info *grp)
  * Choose next group by traversing largest_free_order lists. Updates *new_cr if
  * cr level needs an update.
  */
-static void ext4_mb_choose_next_group_cr0(struct ext4_allocation_context *ac,
+static void ext4_mb_choose_next_group_p2_aligned(struct ext4_allocation_context *ac,
 			enum criteria *new_cr, ext4_group_t *group, ext4_group_t ngroups)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
@@ -877,8 +881,8 @@ static void ext4_mb_choose_next_group_cr0(struct ext4_allocation_context *ac,
 	if (ac->ac_status == AC_STATUS_FOUND)
 		return;
 
-	if (unlikely(sbi->s_mb_stats && ac->ac_flags & EXT4_MB_CR0_OPTIMIZED))
-		atomic_inc(&sbi->s_bal_cr0_bad_suggestions);
+	if (unlikely(sbi->s_mb_stats && ac->ac_flags & EXT4_MB_CR_POWER2_ALIGNED_OPTIMIZED))
+		atomic_inc(&sbi->s_bal_p2_aligned_bad_suggestions);
 
 	grp = NULL;
 	for (i = ac->ac_2order; i < MB_NUM_ORDERS(ac->ac_sb); i++) {
@@ -893,8 +897,8 @@ static void ext4_mb_choose_next_group_cr0(struct ext4_allocation_context *ac,
 		list_for_each_entry(iter, &sbi->s_mb_largest_free_orders[i],
 				    bb_largest_free_order_node) {
 			if (sbi->s_mb_stats)
-				atomic64_inc(&sbi->s_bal_cX_groups_considered[CR0]);
-			if (likely(ext4_mb_good_group(ac, iter->bb_group, CR0))) {
+				atomic64_inc(&sbi->s_bal_cX_groups_considered[CR_POWER2_ALIGNED]);
+			if (likely(ext4_mb_good_group(ac, iter->bb_group, CR_POWER2_ALIGNED))) {
 				grp = iter;
 				break;
 			}
@@ -906,10 +910,10 @@ static void ext4_mb_choose_next_group_cr0(struct ext4_allocation_context *ac,
 
 	if (!grp) {
 		/* Increment cr and search again */
-		*new_cr = CR1;
+		*new_cr = CR_GOAL_LEN_FAST;
 	} else {
 		*group = grp->bb_group;
-		ac->ac_flags |= EXT4_MB_CR0_OPTIMIZED;
+		ac->ac_flags |= EXT4_MB_CR_POWER2_ALIGNED_OPTIMIZED;
 	}
 }
 
@@ -948,16 +952,16 @@ ext4_mb_find_good_group_avg_frag_lists(struct ext4_allocation_context *ac, int o
  * Choose next group by traversing average fragment size list of suitable
  * order. Updates *new_cr if cr level needs an update.
  */
-static void ext4_mb_choose_next_group_cr1(struct ext4_allocation_context *ac,
+static void ext4_mb_choose_next_group_goal_fast(struct ext4_allocation_context *ac,
 		enum criteria *new_cr, ext4_group_t *group, ext4_group_t ngroups)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
 	struct ext4_group_info *grp = NULL;
 	int i;
 
-	if (unlikely(ac->ac_flags & EXT4_MB_CR1_OPTIMIZED)) {
+	if (unlikely(ac->ac_flags & EXT4_MB_CR_GOAL_LEN_FAST_OPTIMIZED)) {
 		if (sbi->s_mb_stats)
-			atomic_inc(&sbi->s_bal_cr1_bad_suggestions);
+			atomic_inc(&sbi->s_bal_goal_fast_bad_suggestions);
 	}
 
 	for (i = mb_avg_fragment_size_order(ac->ac_sb, ac->ac_g_ex.fe_len);
@@ -969,22 +973,22 @@ static void ext4_mb_choose_next_group_cr1(struct ext4_allocation_context *ac,
 
 	if (grp) {
 		*group = grp->bb_group;
-		ac->ac_flags |= EXT4_MB_CR1_OPTIMIZED;
+		ac->ac_flags |= EXT4_MB_CR_GOAL_LEN_FAST_OPTIMIZED;
 	} else {
-		*new_cr = CR1_5;
+		*new_cr = CR_BEST_AVAIL_LEN;
 	}
 }
 
 /*
- * We couldn't find a group in CR1 so try to find the highest free fragment
+ * We couldn't find a group in CR_GOAL_LEN_FAST so try to find the highest free fragment
  * order we have and proactively trim the goal request length to that order to
  * find a suitable group faster.
  *
  * This optimizes allocation speed at the cost of slightly reduced
  * preallocations. However, we make sure that we don't trim the request too
- * much and fall to CR2 in that case.
+ * much and fall to CR_GOAL_LEN_SLOW in that case.
  */
-static void ext4_mb_choose_next_group_cr1_5(struct ext4_allocation_context *ac,
+static void ext4_mb_choose_next_group_best_avail(struct ext4_allocation_context *ac,
 		enum criteria *new_cr, ext4_group_t *group, ext4_group_t ngroups)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
@@ -992,9 +996,9 @@ static void ext4_mb_choose_next_group_cr1_5(struct ext4_allocation_context *ac,
 	int i, order, min_order;
 	unsigned long num_stripe_clusters = 0;
 
-	if (unlikely(ac->ac_flags & EXT4_MB_CR1_5_OPTIMIZED)) {
+	if (unlikely(ac->ac_flags & EXT4_MB_CR_BEST_AVAIL_LEN_OPTIMIZED)) {
 		if (sbi->s_mb_stats)
-			atomic_inc(&sbi->s_bal_cr1_5_bad_suggestions);
+			atomic_inc(&sbi->s_bal_best_avail_bad_suggestions);
 	}
 
 	/*
@@ -1004,7 +1008,7 @@ static void ext4_mb_choose_next_group_cr1_5(struct ext4_allocation_context *ac,
 	 * goal length.
 	 */
 	order = fls(ac->ac_g_ex.fe_len);
-	min_order = order - sbi->s_mb_cr1_5_max_trim_order;
+	min_order = order - sbi->s_mb_best_avail_max_trim_order;
 	if (min_order < 0)
 		min_order = 0;
 
@@ -1052,11 +1056,11 @@ static void ext4_mb_choose_next_group_cr1_5(struct ext4_allocation_context *ac,
 
 	if (grp) {
 		*group = grp->bb_group;
-		ac->ac_flags |= EXT4_MB_CR1_5_OPTIMIZED;
+		ac->ac_flags |= EXT4_MB_CR_BEST_AVAIL_LEN_OPTIMIZED;
 	} else {
-		/* Reset goal length to original goal length before falling into CR2 */
+		/* Reset goal length to original goal length before falling into CR_GOAL_LEN_SLOW */
 		ac->ac_g_ex.fe_len = ac->ac_orig_goal_len;
-		*new_cr = CR2;
+		*new_cr = CR_GOAL_LEN_SLOW;
 	}
 }
 
@@ -1064,7 +1068,7 @@ static inline int should_optimize_scan(struct ext4_allocation_context *ac)
 {
 	if (unlikely(!test_opt2(ac->ac_sb, MB_OPTIMIZE_SCAN)))
 		return 0;
-	if (ac->ac_criteria >= CR2)
+	if (ac->ac_criteria >= CR_GOAL_LEN_SLOW)
 		return 0;
 	if (!ext4_test_inode_flag(ac->ac_inode, EXT4_INODE_EXTENTS))
 		return 0;
@@ -1118,12 +1122,12 @@ static void ext4_mb_choose_next_group(struct ext4_allocation_context *ac,
 		return;
 	}
 
-	if (*new_cr == CR0) {
-		ext4_mb_choose_next_group_cr0(ac, new_cr, group, ngroups);
-	} else if (*new_cr == CR1) {
-		ext4_mb_choose_next_group_cr1(ac, new_cr, group, ngroups);
-	} else if (*new_cr == CR1_5) {
-		ext4_mb_choose_next_group_cr1_5(ac, new_cr, group, ngroups);
+	if (*new_cr == CR_POWER2_ALIGNED) {
+		ext4_mb_choose_next_group_p2_aligned(ac, new_cr, group, ngroups);
+	} else if (*new_cr == CR_GOAL_LEN_FAST) {
+		ext4_mb_choose_next_group_goal_fast(ac, new_cr, group, ngroups);
+	} else if (*new_cr == CR_BEST_AVAIL_LEN) {
+		ext4_mb_choose_next_group_best_avail(ac, new_cr, group, ngroups);
 	} else {
 		/*
 		 * TODO: For CR=2, we can arrange groups in an rb tree sorted by
@@ -2445,11 +2449,12 @@ void ext4_mb_complex_scan_group(struct ext4_allocation_context *ac,
 			break;
 		}
 
-		if (ac->ac_criteria < CR2) {
+		if (ac->ac_criteria < CR_FAST) {
 			/*
-			 * In CR1 and CR1_5, we are sure that this group will
-			 * have a large enough continuous free extent, so skip
-			 * over the smaller free extents
+			 * In CR_GOAL_LEN_FAST and CR_BEST_AVAIL_LEN, we are
+			 * sure that this group will have a large enough
+			 * continuous free extent, so skip over the smaller free
+			 * extents
 			 */
 			j = mb_find_next_bit(bitmap,
 						EXT4_CLUSTERS_PER_GROUP(sb), i);
@@ -2545,7 +2550,7 @@ static bool ext4_mb_good_group(struct ext4_allocation_context *ac,
 	int flex_size = ext4_flex_bg_size(EXT4_SB(ac->ac_sb));
 	struct ext4_group_info *grp = ext4_get_group_info(ac->ac_sb, group);
 
-	BUG_ON(cr < CR0 || cr >= EXT4_MB_NUM_CRS);
+	BUG_ON(cr < CR_POWER2_ALIGNED || cr >= EXT4_MB_NUM_CRS);
 
 	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(grp) || !grp))
 		return false;
@@ -2559,7 +2564,7 @@ static bool ext4_mb_good_group(struct ext4_allocation_context *ac,
 		return false;
 
 	switch (cr) {
-	case CR0:
+	case CR_POWER2_ALIGNED:
 		BUG_ON(ac->ac_2order == 0);
 
 		/* Avoid using the first bg of a flexgroup for data files */
@@ -2578,16 +2583,16 @@ static bool ext4_mb_good_group(struct ext4_allocation_context *ac,
 			return false;
 
 		return true;
-	case CR1:
-	case CR1_5:
+	case CR_GOAL_LEN_FAST:
+	case CR_BEST_AVAIL_LEN:
 		if ((free / fragments) >= ac->ac_g_ex.fe_len)
 			return true;
 		break;
-	case CR2:
+	case CR_GOAL_LEN_SLOW:
 		if (free >= ac->ac_g_ex.fe_len)
 			return true;
 		break;
-	case CR3:
+	case CR_ANY_FREE:
 		return true;
 	default:
 		BUG();
@@ -2628,7 +2633,7 @@ static int ext4_mb_good_group_nolock(struct ext4_allocation_context *ac,
 	free = grp->bb_free;
 	if (free == 0)
 		goto out;
-	if (cr <= CR2 && free < ac->ac_g_ex.fe_len)
+	if (cr <= CR_FAST && free < ac->ac_g_ex.fe_len)
 		goto out;
 	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(grp)))
 		goto out;
@@ -2643,15 +2648,16 @@ static int ext4_mb_good_group_nolock(struct ext4_allocation_context *ac,
 			ext4_get_group_desc(sb, group, NULL);
 		int ret;
 
-		/* cr=CR0/CR1 is a very optimistic search to find large
-		 * good chunks almost for free.  If buddy data is not
-		 * ready, then this optimization makes no sense.  But
-		 * we never skip the first block group in a flex_bg,
-		 * since this gets used for metadata block allocation,
-		 * and we want to make sure we locate metadata blocks
-		 * in the first block group in the flex_bg if possible.
+		/*
+		 * cr=CR_POWER2_ALIGNED/CR_GOAL_LEN_FAST is a very optimistic
+		 * search to find large good chunks almost for free. If buddy
+		 * data is not ready, then this optimization makes no sense. But
+		 * we never skip the first block group in a flex_bg, since this
+		 * gets used for metadata block allocation, and we want to make
+		 * sure we locate metadata blocks in the first block group in
+		 * the flex_bg if possible.
 		 */
-		if (cr < CR2 &&
+		if (cr < CR_FAST &&
 		    (!sbi->s_log_groups_per_flex ||
 		     ((group & ((1 << sbi->s_log_groups_per_flex) - 1)) != 0)) &&
 		    !(ext4_has_group_desc_csum(sb) &&
@@ -2811,10 +2817,10 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 	}
 
 	/* Let's just scan groups to find more-less suitable blocks */
-	cr = ac->ac_2order ? CR0 : CR1;
+	cr = ac->ac_2order ? CR_POWER2_ALIGNED : CR_GOAL_LEN_FAST;
 	/*
-	 * cr == CR0 try to get exact allocation,
-	 * cr == CR3 try to get anything
+	 * cr == CR_POWER2_ALIGNED try to get exact allocation,
+	 * cr == CR_ANY_FREE try to get anything
 	 */
 repeat:
 	for (; cr < EXT4_MB_NUM_CRS && ac->ac_status == AC_STATUS_CONTINUE; cr++) {
@@ -2844,7 +2850,7 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 			 * spend a lot of time loading imperfect groups
 			 */
 			if ((prefetch_grp == group) &&
-			    (cr > CR1_5 ||
+			    (cr >= CR_FAST ||
 			     prefetch_ios < sbi->s_mb_prefetch_limit)) {
 				nr = sbi->s_mb_prefetch;
 				if (ext4_has_feature_flex_bg(sb)) {
@@ -2882,9 +2888,11 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 			}
 
 			ac->ac_groups_scanned++;
-			if (cr == CR0)
+			if (cr == CR_POWER2_ALIGNED)
 				ext4_mb_simple_scan_group(ac, &e4b);
-			else if ((cr == CR1 || cr == CR1_5) && sbi->s_stripe &&
+			else if ((cr == CR_GOAL_LEN_FAST ||
+				 cr == CR_BEST_AVAIL_LEN) &&
+				 sbi->s_stripe &&
 				 !(ac->ac_g_ex.fe_len %
 				 EXT4_B2C(sbi, sbi->s_stripe)))
 				ext4_mb_scan_aligned(ac, &e4b);
@@ -2901,9 +2909,9 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 		if (sbi->s_mb_stats && i == ngroups)
 			atomic64_inc(&sbi->s_bal_cX_failed[cr]);
 
-		if (i == ngroups && ac->ac_criteria == CR1_5)
+		if (i == ngroups && ac->ac_criteria == CR_BEST_AVAIL_LEN)
 			/* Reset goal length to original goal length before
-			 * falling into CR2 */
+			 * falling into CR_GOAL_LEN_SLOW */
 			ac->ac_g_ex.fe_len = ac->ac_orig_goal_len;
 	}
 
@@ -2930,7 +2938,7 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 			ac->ac_b_ex.fe_len = 0;
 			ac->ac_status = AC_STATUS_CONTINUE;
 			ac->ac_flags |= EXT4_MB_HINT_FIRST;
-			cr = CR3;
+			cr = CR_ANY_FREE;
 			goto repeat;
 		}
 	}
@@ -3046,66 +3054,94 @@ int ext4_seq_mb_stats_show(struct seq_file *seq, void *offset)
 	seq_puts(seq, "mballoc:\n");
 	if (!sbi->s_mb_stats) {
 		seq_puts(seq, "\tmb stats collection turned off.\n");
-		seq_puts(seq, "\tTo enable, please write \"1\" to sysfs file mb_stats.\n");
+		seq_puts(
+			seq,
+			"\tTo enable, please write \"1\" to sysfs file mb_stats.\n");
 		return 0;
 	}
 	seq_printf(seq, "\treqs: %u\n", atomic_read(&sbi->s_bal_reqs));
 	seq_printf(seq, "\tsuccess: %u\n", atomic_read(&sbi->s_bal_success));
 
-	seq_printf(seq, "\tgroups_scanned: %u\n",  atomic_read(&sbi->s_bal_groups_scanned));
-
-	seq_puts(seq, "\tcr0_stats:\n");
-	seq_printf(seq, "\t\thits: %llu\n", atomic64_read(&sbi->s_bal_cX_hits[CR0]));
-	seq_printf(seq, "\t\tgroups_considered: %llu\n",
-		   atomic64_read(&sbi->s_bal_cX_groups_considered[CR0]));
-	seq_printf(seq, "\t\textents_scanned: %u\n", atomic_read(&sbi->s_bal_cX_ex_scanned[CR0]));
+	seq_printf(seq, "\tgroups_scanned: %u\n",
+		   atomic_read(&sbi->s_bal_groups_scanned));
+
+	/* CR_POWER2_ALIGNED stats */
+	seq_puts(seq, "\tcr_p2_aligned_stats:\n");
+	seq_printf(seq, "\t\thits: %llu\n",
+		   atomic64_read(&sbi->s_bal_cX_hits[CR_POWER2_ALIGNED]));
+	seq_printf(
+		seq, "\t\tgroups_considered: %llu\n",
+		atomic64_read(
+			&sbi->s_bal_cX_groups_considered[CR_POWER2_ALIGNED]));
+	seq_printf(seq, "\t\textents_scanned: %u\n",
+		   atomic_read(&sbi->s_bal_cX_ex_scanned[CR_POWER2_ALIGNED]));
 	seq_printf(seq, "\t\tuseless_loops: %llu\n",
-		   atomic64_read(&sbi->s_bal_cX_failed[CR0]));
+		   atomic64_read(&sbi->s_bal_cX_failed[CR_POWER2_ALIGNED]));
 	seq_printf(seq, "\t\tbad_suggestions: %u\n",
-		   atomic_read(&sbi->s_bal_cr0_bad_suggestions));
+		   atomic_read(&sbi->s_bal_p2_aligned_bad_suggestions));
 
-	seq_puts(seq, "\tcr1_stats:\n");
-	seq_printf(seq, "\t\thits: %llu\n", atomic64_read(&sbi->s_bal_cX_hits[CR1]));
+	/* CR_GOAL_LEN_FAST stats */
+	seq_puts(seq, "\tcr_goal_fast_stats:\n");
+	seq_printf(seq, "\t\thits: %llu\n",
+		   atomic64_read(&sbi->s_bal_cX_hits[CR_GOAL_LEN_FAST]));
 	seq_printf(seq, "\t\tgroups_considered: %llu\n",
-		   atomic64_read(&sbi->s_bal_cX_groups_considered[CR1]));
-	seq_printf(seq, "\t\textents_scanned: %u\n", atomic_read(&sbi->s_bal_cX_ex_scanned[CR1]));
+		   atomic64_read(
+			   &sbi->s_bal_cX_groups_considered[CR_GOAL_LEN_FAST]));
+	seq_printf(seq, "\t\textents_scanned: %u\n",
+		   atomic_read(&sbi->s_bal_cX_ex_scanned[CR_GOAL_LEN_FAST]));
 	seq_printf(seq, "\t\tuseless_loops: %llu\n",
-		   atomic64_read(&sbi->s_bal_cX_failed[CR1]));
+		   atomic64_read(&sbi->s_bal_cX_failed[CR_GOAL_LEN_FAST]));
 	seq_printf(seq, "\t\tbad_suggestions: %u\n",
-		   atomic_read(&sbi->s_bal_cr1_bad_suggestions));
-
-	seq_puts(seq, "\tcr1.5_stats:\n");
-	seq_printf(seq, "\t\thits: %llu\n", atomic64_read(&sbi->s_bal_cX_hits[CR1_5]));
-	seq_printf(seq, "\t\tgroups_considered: %llu\n",
-		   atomic64_read(&sbi->s_bal_cX_groups_considered[CR1_5]));
-	seq_printf(seq, "\t\textents_scanned: %u\n", atomic_read(&sbi->s_bal_cX_ex_scanned[CR1_5]));
+		   atomic_read(&sbi->s_bal_goal_fast_bad_suggestions));
+
+	/* CR_BEST_AVAIL_LEN stats */
+	seq_puts(seq, "\tcr_best_avail_stats:\n");
+	seq_printf(seq, "\t\thits: %llu\n",
+		   atomic64_read(&sbi->s_bal_cX_hits[CR_BEST_AVAIL_LEN]));
+	seq_printf(
+		seq, "\t\tgroups_considered: %llu\n",
+		atomic64_read(
+			&sbi->s_bal_cX_groups_considered[CR_BEST_AVAIL_LEN]));
+	seq_printf(seq, "\t\textents_scanned: %u\n",
+		   atomic_read(&sbi->s_bal_cX_ex_scanned[CR_BEST_AVAIL_LEN]));
 	seq_printf(seq, "\t\tuseless_loops: %llu\n",
-		   atomic64_read(&sbi->s_bal_cX_failed[CR1_5]));
+		   atomic64_read(&sbi->s_bal_cX_failed[CR_BEST_AVAIL_LEN]));
 	seq_printf(seq, "\t\tbad_suggestions: %u\n",
-		   atomic_read(&sbi->s_bal_cr1_5_bad_suggestions));
+		   atomic_read(&sbi->s_bal_best_avail_bad_suggestions));
 
-	seq_puts(seq, "\tcr2_stats:\n");
-	seq_printf(seq, "\t\thits: %llu\n", atomic64_read(&sbi->s_bal_cX_hits[CR2]));
+	/* CR_GOAL_LEN_SLOW stats */
+	seq_puts(seq, "\tcr_goal_slow_stats:\n");
+	seq_printf(seq, "\t\thits: %llu\n",
+		   atomic64_read(&sbi->s_bal_cX_hits[CR_GOAL_LEN_SLOW]));
 	seq_printf(seq, "\t\tgroups_considered: %llu\n",
-		   atomic64_read(&sbi->s_bal_cX_groups_considered[CR2]));
-	seq_printf(seq, "\t\textents_scanned: %u\n", atomic_read(&sbi->s_bal_cX_ex_scanned[CR2]));
+		   atomic64_read(
+			   &sbi->s_bal_cX_groups_considered[CR_GOAL_LEN_SLOW]));
+	seq_printf(seq, "\t\textents_scanned: %u\n",
+		   atomic_read(&sbi->s_bal_cX_ex_scanned[CR_GOAL_LEN_SLOW]));
 	seq_printf(seq, "\t\tuseless_loops: %llu\n",
-		   atomic64_read(&sbi->s_bal_cX_failed[CR2]));
-
-	seq_puts(seq, "\tcr3_stats:\n");
-	seq_printf(seq, "\t\thits: %llu\n", atomic64_read(&sbi->s_bal_cX_hits[CR3]));
-	seq_printf(seq, "\t\tgroups_considered: %llu\n",
-		   atomic64_read(&sbi->s_bal_cX_groups_considered[CR3]));
-	seq_printf(seq, "\t\textents_scanned: %u\n", atomic_read(&sbi->s_bal_cX_ex_scanned[CR3]));
+		   atomic64_read(&sbi->s_bal_cX_failed[CR_GOAL_LEN_SLOW]));
+
+	/* CR_ANY_FREE stats */
+	seq_puts(seq, "\tcr_any_free_stats:\n");
+	seq_printf(seq, "\t\thits: %llu\n",
+		   atomic64_read(&sbi->s_bal_cX_hits[CR_ANY_FREE]));
+	seq_printf(
+		seq, "\t\tgroups_considered: %llu\n",
+		atomic64_read(&sbi->s_bal_cX_groups_considered[CR_ANY_FREE]));
+	seq_printf(seq, "\t\textents_scanned: %u\n",
+		   atomic_read(&sbi->s_bal_cX_ex_scanned[CR_ANY_FREE]));
 	seq_printf(seq, "\t\tuseless_loops: %llu\n",
-		   atomic64_read(&sbi->s_bal_cX_failed[CR3]));
-	seq_printf(seq, "\textents_scanned: %u\n", atomic_read(&sbi->s_bal_ex_scanned));
+		   atomic64_read(&sbi->s_bal_cX_failed[CR_ANY_FREE]));
+
+	/* Aggregates */
+	seq_printf(seq, "\textents_scanned: %u\n",
+		   atomic_read(&sbi->s_bal_ex_scanned));
 	seq_printf(seq, "\t\tgoal_hits: %u\n", atomic_read(&sbi->s_bal_goals));
-	seq_printf(seq, "\t\tlen_goal_hits: %u\n", atomic_read(&sbi->s_bal_len_goals));
+	seq_printf(seq, "\t\tlen_goal_hits: %u\n",
+		   atomic_read(&sbi->s_bal_len_goals));
 	seq_printf(seq, "\t\t2^n_hits: %u\n", atomic_read(&sbi->s_bal_2orders));
 	seq_printf(seq, "\t\tbreaks: %u\n", atomic_read(&sbi->s_bal_breaks));
 	seq_printf(seq, "\t\tlost: %u\n", atomic_read(&sbi->s_mb_lost_chunks));
-
 	seq_printf(seq, "\tbuddies_generated: %u/%u\n",
 		   atomic_read(&sbi->s_mb_buddies_generated),
 		   ext4_get_groups_count(sb));
@@ -3113,8 +3149,7 @@ int ext4_seq_mb_stats_show(struct seq_file *seq, void *offset)
 		   atomic64_read(&sbi->s_mb_generation_time));
 	seq_printf(seq, "\tpreallocated: %u\n",
 		   atomic_read(&sbi->s_mb_preallocated));
-	seq_printf(seq, "\tdiscarded: %u\n",
-		   atomic_read(&sbi->s_mb_discarded));
+	seq_printf(seq, "\tdiscarded: %u\n", atomic_read(&sbi->s_mb_discarded));
 	return 0;
 }
 
@@ -3601,7 +3636,7 @@ int ext4_mb_init(struct super_block *sb)
 	sbi->s_mb_stats = MB_DEFAULT_STATS;
 	sbi->s_mb_stream_request = MB_DEFAULT_STREAM_THRESHOLD;
 	sbi->s_mb_order2_reqs = MB_DEFAULT_ORDER2_REQS;
-	sbi->s_mb_cr1_5_max_trim_order = MB_DEFAULT_CR1_5_TRIM_ORDER;
+	sbi->s_mb_best_avail_max_trim_order = MB_DEFAULT_BEST_AVAIL_TRIM_ORDER;
 
 	/*
 	 * The default group preallocation is 512, which for 4k block
diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
index bddc0335c261..df6b5e7c2274 100644
--- a/fs/ext4/mballoc.h
+++ b/fs/ext4/mballoc.h
@@ -86,11 +86,11 @@
 #define MB_DEFAULT_LINEAR_SCAN_THRESHOLD	16
 
 /*
- * The maximum order upto which CR1.5 can trim a particular allocation request.
- * Example, if we have an order 7 request and max trim order of 3, CR1.5 can
- * trim this upto order 4.
+ * The maximum order upto which CR_BEST_AVAIL_LEN can trim a particular
+ * allocation request. Example, if we have an order 7 request and max trim order
+ * of 3, we can trim this request upto order 4.
  */
-#define MB_DEFAULT_CR1_5_TRIM_ORDER	3
+#define MB_DEFAULT_BEST_AVAIL_TRIM_ORDER	3
 
 /*
  * Number of valid buddy orders
diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
index 4a5c08c8dddb..6d332dff79dd 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -223,7 +223,7 @@ EXT4_RW_ATTR_SBI_UI(warning_ratelimit_interval_ms, s_warning_ratelimit_state.int
 EXT4_RW_ATTR_SBI_UI(warning_ratelimit_burst, s_warning_ratelimit_state.burst);
 EXT4_RW_ATTR_SBI_UI(msg_ratelimit_interval_ms, s_msg_ratelimit_state.interval);
 EXT4_RW_ATTR_SBI_UI(msg_ratelimit_burst, s_msg_ratelimit_state.burst);
-EXT4_RW_ATTR_SBI_UI(mb_cr1_5_max_trim_order, s_mb_cr1_5_max_trim_order);
+EXT4_RW_ATTR_SBI_UI(mb_best_avail_max_trim_order, s_mb_best_avail_max_trim_order);
 #ifdef CONFIG_EXT4_DEBUG
 EXT4_RW_ATTR_SBI_UL(simulate_fail, s_simulate_fail);
 #endif
@@ -274,7 +274,7 @@ static struct attribute *ext4_attrs[] = {
 	ATTR_LIST(warning_ratelimit_burst),
 	ATTR_LIST(msg_ratelimit_interval_ms),
 	ATTR_LIST(msg_ratelimit_burst),
-	ATTR_LIST(mb_cr1_5_max_trim_order),
+	ATTR_LIST(mb_best_avail_max_trim_order),
 	ATTR_LIST(errors_count),
 	ATTR_LIST(warning_count),
 	ATTR_LIST(msg_count),
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index 7ea9b4fcb21f..bab28121c7a4 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -120,19 +120,19 @@ TRACE_DEFINE_ENUM(EXT4_FC_REASON_MAX);
 		{ EXT4_FC_REASON_INODE_JOURNAL_DATA,	"INODE_JOURNAL_DATA"}, \
 		{ EXT4_FC_REASON_ENCRYPTED_FILENAME,	"ENCRYPTED_FILENAME"})
 
-TRACE_DEFINE_ENUM(CR0);
-TRACE_DEFINE_ENUM(CR1);
-TRACE_DEFINE_ENUM(CR1_5);
-TRACE_DEFINE_ENUM(CR2);
-TRACE_DEFINE_ENUM(CR3);
-
-#define show_criteria(cr)                       \
-	__print_symbolic(cr,                    \
-			 { CR0, "CR0" },	\
-			 { CR1, "CR1" },        \
-			 { CR1_5, "CR1.5" }     \
-			 { CR2, "CR2" },        \
-			 { CR3, "CR3" })
+TRACE_DEFINE_ENUM(CR_POWER2_ALIGNED);
+TRACE_DEFINE_ENUM(CR_GOAL_LEN_FAST);
+TRACE_DEFINE_ENUM(CR_BEST_AVAIL_LEN);
+TRACE_DEFINE_ENUM(CR_GOAL_LEN_SLOW);
+TRACE_DEFINE_ENUM(CR_ANY_FREE);
+
+#define show_criteria(cr)                                               \
+	__print_symbolic(cr,                                            \
+			 { CR_POWER2_ALIGNED, "CR_POWER2_ALIGNED" },	\
+			 { CR_GOAL_LEN_FAST, "CR_GOAL_LEN_FAST" },      \
+			 { CR_BEST_AVAIL_LEN, "CR_BEST_AVAIL_LEN" },    \
+			 { CR_GOAL_LEN_SLOW, "CR_GOAL_LEN_SLOW" },      \
+			 { CR_ANY_FREE, "CR_ANY_FREE" })
 
 TRACE_EVENT(ext4_other_inode_update_time,
 	TP_PROTO(struct inode *inode, ino_t orig_ino),
-- 
2.31.1

