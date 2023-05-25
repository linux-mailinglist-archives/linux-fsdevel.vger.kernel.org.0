Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A647710B0B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 13:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240983AbjEYLdp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 07:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240953AbjEYLdj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 07:33:39 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFB412F;
        Thu, 25 May 2023 04:33:37 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34PBEBK2009568;
        Thu, 25 May 2023 11:33:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=xdniZbIR5n4XhghpE9z65LKpy7FxlOT8/VhUvjUkuM0=;
 b=Gxr5yh16IWDw1DmdjKhnKvbVCdDfU9Kwo3Xbqx1TcW/7mhwD67yktAdK7iZqdOBogId5
 qrnNpmsSpctClmOb2RI1ODkpwDvT9JlEp2jAUyPa7gbXa4mYvE3y4+T60wpNoA5XQewh
 mgE1Im+tew9tHaQQp+zXQDvzmGaRBsO1XhXJIWHE2vQqJ6+7D51I2aiKAfyRX58nTCdu
 ME7gV3CHv0B/5c8FeDVFmn1YxmedK79ODTWjo82Qb0iCbpDY7pJsx4wJw/73UG/6U2a0
 ySdeqcEdkbtYMF8Klv+FB4ZFhg/ig95FAyaKGb9tmcDjs67GC6qAA4YKTLH6Z/ZG6Qxv mQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qt6m6rexs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 11:33:27 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34PBF1ak010739;
        Thu, 25 May 2023 11:33:26 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qt6m6rewx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 11:33:26 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34P4pocf023481;
        Thu, 25 May 2023 11:33:25 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3qppbmj07b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 11:33:24 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34PBXMLL15401494
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 May 2023 11:33:22 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 561BB20040;
        Thu, 25 May 2023 11:33:22 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6316620043;
        Thu, 25 May 2023 11:33:20 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.in.ibm.com (unknown [9.109.253.169])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 25 May 2023 11:33:20 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: [PATCH 05/13] ext4: Convert mballoc cr (criteria) to enum
Date:   Thu, 25 May 2023 17:02:59 +0530
Message-Id: <263f1c5774fd04550a9c04f88ca583bb693eb604.1685009579.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1685009579.git.ojaswin@linux.ibm.com>
References: <cover.1685009579.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FZM1qBGWHHrjR4kS762bkoOUz6Act2x8
X-Proofpoint-GUID: W4aaGPI3KJG_kbFI3nu1xC_Co0bDk0YC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-25_06,2023-05-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 phishscore=0 adultscore=0
 impostorscore=0 mlxlogscore=999 priorityscore=1501 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305250092
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index 80e01fbcd0a3..2fa4e77eb3a1 100644
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
index 72c5d1a33bad..10dd86a02997 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -154,19 +154,19 @@
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
@@ -409,7 +409,7 @@ static void ext4_mb_generate_from_freelist(struct super_block *sb, void *bitmap,
 static void ext4_mb_new_preallocation(struct ext4_allocation_context *ac);
 
 static bool ext4_mb_good_group(struct ext4_allocation_context *ac,
-			       ext4_group_t group, int cr);
+			       ext4_group_t group, enum criteria cr);
 
 static int ext4_try_to_trim_range(struct super_block *sb,
 		struct ext4_buddy *e4b, ext4_grpblk_t start,
@@ -859,7 +859,7 @@ mb_update_avg_fragment_size(struct super_block *sb, struct ext4_group_info *grp)
  * cr level needs an update.
  */
 static void ext4_mb_choose_next_group_cr0(struct ext4_allocation_context *ac,
-			int *new_cr, ext4_group_t *group, ext4_group_t ngroups)
+			enum criteria *new_cr, ext4_group_t *group, ext4_group_t ngroups)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
 	struct ext4_group_info *iter, *grp;
@@ -884,8 +884,8 @@ static void ext4_mb_choose_next_group_cr0(struct ext4_allocation_context *ac,
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
@@ -897,7 +897,7 @@ static void ext4_mb_choose_next_group_cr0(struct ext4_allocation_context *ac,
 
 	if (!grp) {
 		/* Increment cr and search again */
-		*new_cr = 1;
+		*new_cr = CR1;
 	} else {
 		*group = grp->bb_group;
 		ac->ac_flags |= EXT4_MB_CR0_OPTIMIZED;
@@ -909,7 +909,7 @@ static void ext4_mb_choose_next_group_cr0(struct ext4_allocation_context *ac,
  * order. Updates *new_cr if cr level needs an update.
  */
 static void ext4_mb_choose_next_group_cr1(struct ext4_allocation_context *ac,
-		int *new_cr, ext4_group_t *group, ext4_group_t ngroups)
+		enum criteria *new_cr, ext4_group_t *group, ext4_group_t ngroups)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
 	struct ext4_group_info *grp = NULL, *iter;
@@ -932,8 +932,8 @@ static void ext4_mb_choose_next_group_cr1(struct ext4_allocation_context *ac,
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
@@ -947,7 +947,7 @@ static void ext4_mb_choose_next_group_cr1(struct ext4_allocation_context *ac,
 		*group = grp->bb_group;
 		ac->ac_flags |= EXT4_MB_CR1_OPTIMIZED;
 	} else {
-		*new_cr = 2;
+		*new_cr = CR2;
 	}
 }
 
@@ -955,7 +955,7 @@ static inline int should_optimize_scan(struct ext4_allocation_context *ac)
 {
 	if (unlikely(!test_opt2(ac->ac_sb, MB_OPTIMIZE_SCAN)))
 		return 0;
-	if (ac->ac_criteria >= 2)
+	if (ac->ac_criteria >= CR2)
 		return 0;
 	if (!ext4_test_inode_flag(ac->ac_inode, EXT4_INODE_EXTENTS))
 		return 0;
@@ -1000,7 +1000,7 @@ next_linear_group(struct ext4_allocation_context *ac, int group, int ngroups)
  * @ngroups   Total number of groups
  */
 static void ext4_mb_choose_next_group(struct ext4_allocation_context *ac,
-		int *new_cr, ext4_group_t *group, ext4_group_t ngroups)
+		enum criteria *new_cr, ext4_group_t *group, ext4_group_t ngroups)
 {
 	*new_cr = ac->ac_criteria;
 
@@ -1009,9 +1009,9 @@ static void ext4_mb_choose_next_group(struct ext4_allocation_context *ac,
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
@@ -2406,13 +2406,13 @@ void ext4_mb_scan_aligned(struct ext4_allocation_context *ac,
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
@@ -2426,7 +2426,7 @@ static bool ext4_mb_good_group(struct ext4_allocation_context *ac,
 		return false;
 
 	switch (cr) {
-	case 0:
+	case CR0:
 		BUG_ON(ac->ac_2order == 0);
 
 		/* Avoid using the first bg of a flexgroup for data files */
@@ -2445,15 +2445,15 @@ static bool ext4_mb_good_group(struct ext4_allocation_context *ac,
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
@@ -2474,7 +2474,7 @@ static bool ext4_mb_good_group(struct ext4_allocation_context *ac,
  * out"!
  */
 static int ext4_mb_good_group_nolock(struct ext4_allocation_context *ac,
-				     ext4_group_t group, int cr)
+				     ext4_group_t group, enum criteria cr)
 {
 	struct ext4_group_info *grp = ext4_get_group_info(ac->ac_sb, group);
 	struct super_block *sb = ac->ac_sb;
@@ -2494,7 +2494,7 @@ static int ext4_mb_good_group_nolock(struct ext4_allocation_context *ac,
 	free = grp->bb_free;
 	if (free == 0)
 		goto out;
-	if (cr <= 2 && free < ac->ac_g_ex.fe_len)
+	if (cr <= CR2 && free < ac->ac_g_ex.fe_len)
 		goto out;
 	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(grp)))
 		goto out;
@@ -2509,7 +2509,7 @@ static int ext4_mb_good_group_nolock(struct ext4_allocation_context *ac,
 			ext4_get_group_desc(sb, group, NULL);
 		int ret;
 
-		/* cr=0/1 is a very optimistic search to find large
+		/* cr=CR0/CR1 is a very optimistic search to find large
 		 * good chunks almost for free.  If buddy data is not
 		 * ready, then this optimization makes no sense.  But
 		 * we never skip the first block group in a flex_bg,
@@ -2517,7 +2517,7 @@ static int ext4_mb_good_group_nolock(struct ext4_allocation_context *ac,
 		 * and we want to make sure we locate metadata blocks
 		 * in the first block group in the flex_bg if possible.
 		 */
-		if (cr < 2 &&
+		if (cr < CR2 &&
 		    (!sbi->s_log_groups_per_flex ||
 		     ((group & ((1 << sbi->s_log_groups_per_flex) - 1)) != 0)) &&
 		    !(ext4_has_group_desc_csum(sb) &&
@@ -2623,7 +2623,7 @@ static noinline_for_stack int
 ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 {
 	ext4_group_t prefetch_grp = 0, ngroups, group, i;
-	int cr = -1, new_cr;
+	enum criteria cr, new_cr;
 	int err = 0, first_err = 0;
 	unsigned int nr = 0, prefetch_ios = 0;
 	struct ext4_sb_info *sbi;
@@ -2681,13 +2681,13 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
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
@@ -2714,7 +2714,7 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 			 * spend a lot of time loading imperfect groups
 			 */
 			if ((prefetch_grp == group) &&
-			    (cr > 1 ||
+			    (cr > CR1 ||
 			     prefetch_ios < sbi->s_mb_prefetch_limit)) {
 				unsigned int curr_ios = prefetch_ios;
 
@@ -2756,9 +2756,9 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 			}
 
 			ac->ac_groups_scanned++;
-			if (cr == 0)
+			if (cr == CR0)
 				ext4_mb_simple_scan_group(ac, &e4b);
-			else if (cr == 1 && sbi->s_stripe &&
+			else if (cr == CR1 && sbi->s_stripe &&
 					!(ac->ac_g_ex.fe_len % sbi->s_stripe))
 				ext4_mb_scan_aligned(ac, &e4b);
 			else
@@ -2798,7 +2798,7 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 			ac->ac_b_ex.fe_len = 0;
 			ac->ac_status = AC_STATUS_CONTINUE;
 			ac->ac_flags |= EXT4_MB_HINT_FIRST;
-			cr = 3;
+			cr = CR3;
 			goto repeat;
 		}
 	}
@@ -2923,36 +2923,36 @@ int ext4_seq_mb_stats_show(struct seq_file *seq, void *offset)
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

