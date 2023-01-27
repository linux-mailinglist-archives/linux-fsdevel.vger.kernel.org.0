Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1963B67E579
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jan 2023 13:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234241AbjA0MiT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Jan 2023 07:38:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234206AbjA0MiH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Jan 2023 07:38:07 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9B51CAC5;
        Fri, 27 Jan 2023 04:38:02 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30RC1NPZ009994;
        Fri, 27 Jan 2023 12:37:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=oxXbLlZMSCqBiLXI1OQsnriO0ZS7CHP7ifIFwBzqpTU=;
 b=GM2u6HPdY90xiF3aabJdrWZzxHYx7IirARw8SBOXGBH85VdHDr6gC1lgU4SK+d4PZfOB
 C6asRtUFSxZHUIUVrRPO8jbdoFaCqedWlbg9dzJ30Gjd16fAcfGfO2WpFUmz6wpb1p8a
 EQvRRD5XF1xM80MePS2E8PQMph3OVy3UXKtBJDYDpwlOE1KLkiqLDznGxVzVhVPrarqQ
 U5WK4k+hCHLklVHvWdcr7c2lfxG14AWV5HzL3AVYSZnB5jODDt6/2S3Ez63YrlTIokrB
 zx2kPNeMC4Chbz3IKk7rISSOWkL6p7YPCHd9E/uHKgJmxpQgVUJFDMl7vC+XxM8XgwCj wQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nce8m8ve4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 12:37:58 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30RCNMbN011766;
        Fri, 27 Jan 2023 12:37:58 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nce8m8vda-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 12:37:58 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30QEe0Sc016228;
        Fri, 27 Jan 2023 12:37:56 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3n87p6dcs5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 12:37:56 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30RCbrUj48366014
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Jan 2023 12:37:53 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BB13420043;
        Fri, 27 Jan 2023 12:37:53 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D6FEA20040;
        Fri, 27 Jan 2023 12:37:51 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.40.88])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 27 Jan 2023 12:37:51 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFC 04/11] ext4: Convert mballoc cr (criteria) to enum
Date:   Fri, 27 Jan 2023 18:07:31 +0530
Message-Id: <9670431b31aa62e83509fa2802aad364910ee52e.1674822311.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1674822311.git.ojaswin@linux.ibm.com>
References: <cover.1674822311.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9UEX5AozGlyJy9EPm2mLvGUWaBhhopF1
X-Proofpoint-GUID: PGS5qxUUkYbQ25qLQqCg_zcF-FeTCIdO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-27_07,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 mlxscore=0 spamscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 priorityscore=1501 adultscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301270113
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert criteria to be an enum so it easier to maintain. This change
also makes it easier to insert new criterias in the future.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext4/ext4.h    | 14 ++++++--
 fs/ext4/mballoc.c | 88 +++++++++++++++++++++++------------------------
 fs/ext4/mballoc.h | 10 ++++++
 3 files changed, 65 insertions(+), 47 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index b8b00457da8d..6037b8e0af86 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -126,6 +126,14 @@ enum SHIFT_DIRECTION {
 	SHIFT_RIGHT,
 };
 
+/*
+ * Number of criterias defined. For each criteria, mballoc has slightly
+ * different way of finding the required blocks nad usually, higher the
+ * criteria the slower the allocation. We start at lower criterias and keep
+ * falling back to higher ones if we are not able to find any blocks.
+ */
+#define EXT4_MB_NUM_CRS 4
+
 /*
  * Flags used in mballoc's allocation_context flags field.
  *
@@ -1631,9 +1639,9 @@ struct ext4_sb_info {
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
index 8b22cc07b054..323604a2ff45 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -409,7 +409,7 @@ static void ext4_mb_generate_from_freelist(struct super_block *sb, void *bitmap,
 static void ext4_mb_new_preallocation(struct ext4_allocation_context *ac);
 
 static bool ext4_mb_good_group(struct ext4_allocation_context *ac,
-			       ext4_group_t group, int cr);
+			       ext4_group_t group, enum criteria cr);
 
 static int ext4_try_to_trim_range(struct super_block *sb,
 		struct ext4_buddy *e4b, ext4_grpblk_t start,
@@ -857,7 +857,7 @@ mb_update_avg_fragment_size(struct super_block *sb, struct ext4_group_info *grp)
  * cr level needs an update.
  */
 static void ext4_mb_choose_next_group_cr0(struct ext4_allocation_context *ac,
-			int *new_cr, ext4_group_t *group, ext4_group_t ngroups)
+			enum criteria *new_cr, ext4_group_t *group, ext4_group_t ngroups)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
 	struct ext4_group_info *iter, *grp;
@@ -882,8 +882,8 @@ static void ext4_mb_choose_next_group_cr0(struct ext4_allocation_context *ac,
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
@@ -895,7 +895,7 @@ static void ext4_mb_choose_next_group_cr0(struct ext4_allocation_context *ac,
 
 	if (!grp) {
 		/* Increment cr and search again */
-		*new_cr = 1;
+		*new_cr = CR1;
 	} else {
 		*group = grp->bb_group;
 		ac->ac_flags |= EXT4_MB_CR0_OPTIMIZED;
@@ -907,7 +907,7 @@ static void ext4_mb_choose_next_group_cr0(struct ext4_allocation_context *ac,
  * order. Updates *new_cr if cr level needs an update.
  */
 static void ext4_mb_choose_next_group_cr1(struct ext4_allocation_context *ac,
-		int *new_cr, ext4_group_t *group, ext4_group_t ngroups)
+		enum criteria *new_cr, ext4_group_t *group, ext4_group_t ngroups)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
 	struct ext4_group_info *grp = NULL, *iter;
@@ -930,8 +930,8 @@ static void ext4_mb_choose_next_group_cr1(struct ext4_allocation_context *ac,
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
@@ -945,7 +945,7 @@ static void ext4_mb_choose_next_group_cr1(struct ext4_allocation_context *ac,
 		*group = grp->bb_group;
 		ac->ac_flags |= EXT4_MB_CR1_OPTIMIZED;
 	} else {
-		*new_cr = 2;
+		*new_cr = CR2;
 	}
 }
 
@@ -953,7 +953,7 @@ static inline int should_optimize_scan(struct ext4_allocation_context *ac)
 {
 	if (unlikely(!test_opt2(ac->ac_sb, MB_OPTIMIZE_SCAN)))
 		return 0;
-	if (ac->ac_criteria >= 2)
+	if (ac->ac_criteria >= CR2)
 		return 0;
 	if (!ext4_test_inode_flag(ac->ac_inode, EXT4_INODE_EXTENTS))
 		return 0;
@@ -998,7 +998,7 @@ next_linear_group(struct ext4_allocation_context *ac, int group, int ngroups)
  * @ngroups   Total number of groups
  */
 static void ext4_mb_choose_next_group(struct ext4_allocation_context *ac,
-		int *new_cr, ext4_group_t *group, ext4_group_t ngroups)
+		enum criteria *new_cr, ext4_group_t *group, ext4_group_t ngroups)
 {
 	*new_cr = ac->ac_criteria;
 
@@ -1007,9 +1007,9 @@ static void ext4_mb_choose_next_group(struct ext4_allocation_context *ac,
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
@@ -2378,13 +2378,13 @@ void ext4_mb_scan_aligned(struct ext4_allocation_context *ac,
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
 
 	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(grp)))
 		return false;
@@ -2398,7 +2398,7 @@ static bool ext4_mb_good_group(struct ext4_allocation_context *ac,
 		return false;
 
 	switch (cr) {
-	case 0:
+	case CR0:
 		BUG_ON(ac->ac_2order == 0);
 
 		/* Avoid using the first bg of a flexgroup for data files */
@@ -2417,15 +2417,15 @@ static bool ext4_mb_good_group(struct ext4_allocation_context *ac,
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
@@ -2446,7 +2446,7 @@ static bool ext4_mb_good_group(struct ext4_allocation_context *ac,
  * out"!
  */
 static int ext4_mb_good_group_nolock(struct ext4_allocation_context *ac,
-				     ext4_group_t group, int cr)
+				     ext4_group_t group, enum criteria cr)
 {
 	struct ext4_group_info *grp = ext4_get_group_info(ac->ac_sb, group);
 	struct super_block *sb = ac->ac_sb;
@@ -2464,7 +2464,7 @@ static int ext4_mb_good_group_nolock(struct ext4_allocation_context *ac,
 	free = grp->bb_free;
 	if (free == 0)
 		goto out;
-	if (cr <= 2 && free < ac->ac_g_ex.fe_len)
+	if (cr <= CR2 && free < ac->ac_g_ex.fe_len)
 		goto out;
 	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(grp)))
 		goto out;
@@ -2479,7 +2479,7 @@ static int ext4_mb_good_group_nolock(struct ext4_allocation_context *ac,
 			ext4_get_group_desc(sb, group, NULL);
 		int ret;
 
-		/* cr=0/1 is a very optimistic search to find large
+		/* cr=CR0/CR1 is a very optimistic search to find large
 		 * good chunks almost for free.  If buddy data is not
 		 * ready, then this optimization makes no sense.  But
 		 * we never skip the first block group in a flex_bg,
@@ -2487,7 +2487,7 @@ static int ext4_mb_good_group_nolock(struct ext4_allocation_context *ac,
 		 * and we want to make sure we locate metadata blocks
 		 * in the first block group in the flex_bg if possible.
 		 */
-		if (cr < 2 &&
+		if (cr < CR2 &&
 		    (!sbi->s_log_groups_per_flex ||
 		     ((group & ((1 << sbi->s_log_groups_per_flex) - 1)) != 0)) &&
 		    !(ext4_has_group_desc_csum(sb) &&
@@ -2593,7 +2593,7 @@ static noinline_for_stack int
 ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 {
 	ext4_group_t prefetch_grp = 0, ngroups, group, i;
-	int cr = -1, new_cr;
+	enum criteria cr, new_cr;
 	int err = 0, first_err = 0;
 	unsigned int nr = 0, prefetch_ios = 0;
 	struct ext4_sb_info *sbi;
@@ -2651,13 +2651,13 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
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
@@ -2684,7 +2684,7 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 			 * spend a lot of time loading imperfect groups
 			 */
 			if ((prefetch_grp == group) &&
-			    (cr > 1 ||
+			    (cr > CR1 ||
 			     prefetch_ios < sbi->s_mb_prefetch_limit)) {
 				unsigned int curr_ios = prefetch_ios;
 
@@ -2726,9 +2726,9 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
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
@@ -2768,7 +2768,7 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 			ac->ac_b_ex.fe_len = 0;
 			ac->ac_status = AC_STATUS_CONTINUE;
 			ac->ac_flags |= EXT4_MB_HINT_FIRST;
-			cr = 3;
+			cr = CR3;
 			goto repeat;
 		}
 	}
@@ -2891,36 +2891,36 @@ int ext4_seq_mb_stats_show(struct seq_file *seq, void *offset)
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
diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
index 165a17893c81..f0087a85e366 100644
--- a/fs/ext4/mballoc.h
+++ b/fs/ext4/mballoc.h
@@ -95,6 +95,16 @@
  */
 #define MB_NUM_ORDERS(sb)		((sb)->s_blocksize_bits + 2)
 
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
 struct ext4_free_data {
 	/* this links the free block information from sb_info */
 	struct list_head		efd_list;
-- 
2.31.1

