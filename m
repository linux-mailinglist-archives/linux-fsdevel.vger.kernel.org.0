Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABFFE710B22
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 13:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241078AbjEYLeZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 07:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241038AbjEYLd4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 07:33:56 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E834E41;
        Thu, 25 May 2023 04:33:52 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34PBHmWu013901;
        Thu, 25 May 2023 11:33:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=uq99HM4/dup6LbOFfDw5vnK3Qa0PQoP8byc+TXXdEfA=;
 b=dpgcpD6OnffGm9G+FBpRpEMGYYq552k/qdwNWjWGBMxFx03h48lFsn/CZwa6/BXutR06
 W/dB88qRqls2azQpFJndTcLf5PzU6/pAp8bek4C+v/ZN3bdk5sJbPFJztv4GtVplIXWS
 m/YvpUK+2JvxBX7BCyCrXECDmkVM3LADCo7Q90zQsSkHW8k5C/ekUtH+Lwsy7MxUJ+3n
 PCyb8DBje+S2reHkfWzpcDZ9R2N5A1gyLE8tbdMxxIzZqugJAqO0j5/0J/3VsmCZOCnx
 2kGcrG2vZYOZf3JosQRcJmGcoyZf1RV/7IXSZI1iGN9+xu7j1rDI1FkwNUguspqBdBrr Pg== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qt6p60cce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 11:33:45 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34P6gQXN017669;
        Thu, 25 May 2023 11:33:43 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3qppa4t0v8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 11:33:43 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34PBXfTE61931832
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 May 2023 11:33:41 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 16AE620043;
        Thu, 25 May 2023 11:33:41 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3C56520040;
        Thu, 25 May 2023 11:33:39 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.in.ibm.com (unknown [9.109.253.169])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 25 May 2023 11:33:39 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Kemeng Shi <shikemeng@huaweicloud.com>
Subject: [PATCH 13/13] ext4: Give symbolic names to mballoc criterias
Date:   Thu, 25 May 2023 17:03:07 +0530
Message-Id: <00a2f84d749368bf4d7e6fb192aaa80e8f8b77b2.1685009579.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1685009579.git.ojaswin@linux.ibm.com>
References: <cover.1685009579.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Vdq6-6jm7MTiz6jFVm0XFgDf2dV_GzSE
X-Proofpoint-GUID: Vdq6-6jm7MTiz6jFVm0XFgDf2dV_GzSE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-25_06,2023-05-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 spamscore=0 bulkscore=0 phishscore=0 impostorscore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305250096
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
 fs/ext4/mballoc.c           | 269 ++++++++++++++++++++----------------
 fs/ext4/mballoc.h           |   8 +-
 fs/ext4/sysfs.c             |   4 +-
 include/trace/events/ext4.h |  26 ++--
 5 files changed, 212 insertions(+), 150 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 0d30255cca2b..cd41591ddb22 100644
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
index 6f48f2fb843c..c5f7a86553e0 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -154,27 +154,31 @@
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
@@ -359,8 +363,8 @@
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
@@ -392,7 +396,7 @@
  *
  *  - allocation path (ext4_mb_regular_allocator)
  *    group
- *    cr0/cr1
+ *    cr_power2_aligned/cr_goal_len_fast
  */
 static struct kmem_cache *ext4_pspace_cachep;
 static struct kmem_cache *ext4_ac_cachep;
@@ -866,7 +870,7 @@ mb_update_avg_fragment_size(struct super_block *sb, struct ext4_group_info *grp)
  * Choose next group by traversing largest_free_order lists. Updates *new_cr if
  * cr level needs an update.
  */
-static void ext4_mb_choose_next_group_cr0(struct ext4_allocation_context *ac,
+static void ext4_mb_choose_next_group_p2_aligned(struct ext4_allocation_context *ac,
 			enum criteria *new_cr, ext4_group_t *group, ext4_group_t ngroups)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
@@ -876,8 +880,8 @@ static void ext4_mb_choose_next_group_cr0(struct ext4_allocation_context *ac,
 	if (ac->ac_status == AC_STATUS_FOUND)
 		return;
 
-	if (unlikely(sbi->s_mb_stats && ac->ac_flags & EXT4_MB_CR0_OPTIMIZED))
-		atomic_inc(&sbi->s_bal_cr0_bad_suggestions);
+	if (unlikely(sbi->s_mb_stats && ac->ac_flags & EXT4_MB_CR_POWER2_ALIGNED_OPTIMIZED))
+		atomic_inc(&sbi->s_bal_p2_aligned_bad_suggestions);
 
 	grp = NULL;
 	for (i = ac->ac_2order; i < MB_NUM_ORDERS(ac->ac_sb); i++) {
@@ -892,8 +896,8 @@ static void ext4_mb_choose_next_group_cr0(struct ext4_allocation_context *ac,
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
@@ -905,10 +909,10 @@ static void ext4_mb_choose_next_group_cr0(struct ext4_allocation_context *ac,
 
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
 
@@ -947,16 +951,16 @@ ext4_mb_find_good_group_avg_frag_lists(struct ext4_allocation_context *ac, int o
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
@@ -968,22 +972,22 @@ static void ext4_mb_choose_next_group_cr1(struct ext4_allocation_context *ac,
 
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
@@ -991,9 +995,9 @@ static void ext4_mb_choose_next_group_cr1_5(struct ext4_allocation_context *ac,
 	int i, order, min_order;
 	unsigned long num_stripe_clusters = 0;
 
-	if (unlikely(ac->ac_flags & EXT4_MB_CR1_5_OPTIMIZED)) {
+	if (unlikely(ac->ac_flags & EXT4_MB_CR_BEST_AVAIL_LEN_OPTIMIZED)) {
 		if (sbi->s_mb_stats)
-			atomic_inc(&sbi->s_bal_cr1_5_bad_suggestions);
+			atomic_inc(&sbi->s_bal_best_avail_bad_suggestions);
 	}
 
 	/*
@@ -1003,7 +1007,7 @@ static void ext4_mb_choose_next_group_cr1_5(struct ext4_allocation_context *ac,
 	 * goal length.
 	 */
 	order = fls(ac->ac_g_ex.fe_len);
-	min_order = order - sbi->s_mb_cr1_5_max_trim_order;
+	min_order = order - sbi->s_mb_best_avail_max_trim_order;
 	if (min_order < 0)
 		min_order = 0;
 
@@ -1051,11 +1055,11 @@ static void ext4_mb_choose_next_group_cr1_5(struct ext4_allocation_context *ac,
 
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
 
@@ -1063,7 +1067,7 @@ static inline int should_optimize_scan(struct ext4_allocation_context *ac)
 {
 	if (unlikely(!test_opt2(ac->ac_sb, MB_OPTIMIZE_SCAN)))
 		return 0;
-	if (ac->ac_criteria >= CR2)
+	if (ac->ac_criteria >= CR_GOAL_LEN_SLOW)
 		return 0;
 	if (!ext4_test_inode_flag(ac->ac_inode, EXT4_INODE_EXTENTS))
 		return 0;
@@ -1117,12 +1121,12 @@ static void ext4_mb_choose_next_group(struct ext4_allocation_context *ac,
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
@@ -2444,11 +2448,12 @@ void ext4_mb_complex_scan_group(struct ext4_allocation_context *ac,
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
@@ -2542,7 +2547,7 @@ static bool ext4_mb_good_group(struct ext4_allocation_context *ac,
 	int flex_size = ext4_flex_bg_size(EXT4_SB(ac->ac_sb));
 	struct ext4_group_info *grp = ext4_get_group_info(ac->ac_sb, group);
 
-	BUG_ON(cr < CR0 || cr >= EXT4_MB_NUM_CRS);
+	BUG_ON(cr < CR_POWER2_ALIGNED || cr >= EXT4_MB_NUM_CRS);
 
 	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(grp) || !grp))
 		return false;
@@ -2556,7 +2561,7 @@ static bool ext4_mb_good_group(struct ext4_allocation_context *ac,
 		return false;
 
 	switch (cr) {
-	case CR0:
+	case CR_POWER2_ALIGNED:
 		BUG_ON(ac->ac_2order == 0);
 
 		/* Avoid using the first bg of a flexgroup for data files */
@@ -2575,16 +2580,16 @@ static bool ext4_mb_good_group(struct ext4_allocation_context *ac,
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
@@ -2625,7 +2630,7 @@ static int ext4_mb_good_group_nolock(struct ext4_allocation_context *ac,
 	free = grp->bb_free;
 	if (free == 0)
 		goto out;
-	if (cr <= CR2 && free < ac->ac_g_ex.fe_len)
+	if (cr <= CR_FAST && free < ac->ac_g_ex.fe_len)
 		goto out;
 	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(grp)))
 		goto out;
@@ -2640,15 +2645,16 @@ static int ext4_mb_good_group_nolock(struct ext4_allocation_context *ac,
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
@@ -2808,10 +2814,10 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
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
@@ -2841,7 +2847,7 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 			 * spend a lot of time loading imperfect groups
 			 */
 			if ((prefetch_grp == group) &&
-			    (cr > CR1_5 ||
+			    (cr >= CR_FAST ||
 			     prefetch_ios < sbi->s_mb_prefetch_limit)) {
 				nr = sbi->s_mb_prefetch;
 				if (ext4_has_feature_flex_bg(sb)) {
@@ -2879,9 +2885,9 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 			}
 
 			ac->ac_groups_scanned++;
-			if (cr == CR0)
+			if (cr == CR_POWER2_ALIGNED)
 				ext4_mb_simple_scan_group(ac, &e4b);
-			else if ((cr == CR1 || cr == CR1_5) && sbi->s_stripe &&
+			else if ((cr == CR_GOAL_LEN_FAST || cr == CR_BEST_AVAIL_LEN) && sbi->s_stripe &&
 				 !(ac->ac_g_ex.fe_len % sbi->s_stripe))
 				ext4_mb_scan_aligned(ac, &e4b);
 			else
@@ -2897,9 +2903,9 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 		if (sbi->s_mb_stats && i == ngroups)
 			atomic64_inc(&sbi->s_bal_cX_failed[cr]);
 
-		if (i == ngroups && ac->ac_criteria == CR1_5)
+		if (i == ngroups && ac->ac_criteria == CR_BEST_AVAIL_LEN)
 			/* Reset goal length to original goal length before
-			 * falling into CR2 */
+			 * falling into CR_GOAL_LEN_SLOW */
 			ac->ac_g_ex.fe_len = ac->ac_orig_goal_len;
 	}
 
@@ -2926,7 +2932,7 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 			ac->ac_b_ex.fe_len = 0;
 			ac->ac_status = AC_STATUS_CONTINUE;
 			ac->ac_flags |= EXT4_MB_HINT_FIRST;
-			cr = CR3;
+			cr = CR_ANY_FREE;
 			goto repeat;
 		}
 	}
@@ -3042,66 +3048,94 @@ int ext4_seq_mb_stats_show(struct seq_file *seq, void *offset)
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
@@ -3109,8 +3143,7 @@ int ext4_seq_mb_stats_show(struct seq_file *seq, void *offset)
 		   atomic64_read(&sbi->s_mb_generation_time));
 	seq_printf(seq, "\tpreallocated: %u\n",
 		   atomic_read(&sbi->s_mb_preallocated));
-	seq_printf(seq, "\tdiscarded: %u\n",
-		   atomic_read(&sbi->s_mb_discarded));
+	seq_printf(seq, "\tdiscarded: %u\n", atomic_read(&sbi->s_mb_discarded));
 	return 0;
 }
 
@@ -3597,7 +3630,7 @@ int ext4_mb_init(struct super_block *sb)
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

