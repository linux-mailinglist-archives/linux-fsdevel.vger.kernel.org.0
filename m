Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D30D67E593
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jan 2023 13:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbjA0MkG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Jan 2023 07:40:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234313AbjA0MjR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Jan 2023 07:39:17 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA457C703;
        Fri, 27 Jan 2023 04:38:21 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30RCNH3x016842;
        Fri, 27 Jan 2023 12:38:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=vA9w2AqADgE+8GLQA2K3wl60BfEzSK5alu9EOQk+mOU=;
 b=W91QI8F0G/3cKTxGX5ujs9buJYyjfu8Hx/kHndJwK0KG0zqqWbHmCdT86ZvzcNZqlyVt
 bkH/4qBnjCGUqB0x5qwk35KASVhHJsb9j91oEVkowtBMhH+an801S5O+xIxF996V8l3I
 NCWnljci0AuklfNzgHncQqcdf4SRWkhBEWpg+x/tlQtRQsr2uAB3jO7MYUIdY66laffZ
 o1VohP1SNCsl1cx+46NfWaWWMPqeBA6kLwhns4Jq9G7x68HdOzQDI3bJtLlBUiYgdRRa
 xoxjJ6d/YubfRqTYC7eOltwFYrjUS1O0c2envE4jpInqvA0DT2rUbLPgJSlaW2Erq9+H YQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ncejugc9y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 12:38:16 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30RCNEg0016698;
        Fri, 27 Jan 2023 12:38:15 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ncejugc8x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 12:38:15 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30R9u6FN029861;
        Fri, 27 Jan 2023 12:38:13 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3n87afdems-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 12:38:13 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30RCcAuW24642236
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Jan 2023 12:38:10 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B14BB20043;
        Fri, 27 Jan 2023 12:38:10 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 755EF20040;
        Fri, 27 Jan 2023 12:38:08 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.40.88])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 27 Jan 2023 12:38:08 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFC 11/11] ext4: Add allocation criteria 1.5 (CR1_5)
Date:   Fri, 27 Jan 2023 18:07:38 +0530
Message-Id: <08173ee255f70cdc8de9ac3aa2e851f9d74acb12.1674822312.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1674822311.git.ojaswin@linux.ibm.com>
References: <cover.1674822311.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TgljfCq8sVTfVOkJ9_mkAl6M6ASXEfxg
X-Proofpoint-GUID: FSTixGVukMGXaNze1LdmIYi3lMbYihah
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-27_08,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301270118
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

CR1_5 aims to optimize allocations which can't be satisfied in CR1. The
fact that we couldn't find a group in CR1 suggests that it would be
difficult to find a continuous extent to compleltely satisfy our
allocations. So before falling to the slower CR2, in CR1.5 we
proactively trim the the preallocations so we can find a group with
(free / fragments) big enough.  This speeds up our allocation at the
cost of slightly reduced preallocation.

The patch also adds a new sysfs tunable:

* /sys/fs/ext4/<partition>/mb_cr1_5_max_trim_order

This controls how much CR1.5 can trim a request before falling to CR2.
For example, for a request of order 7 and max trim order 2, CR1.5 can
trim this upto order 5.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext4/ext4.h    |  7 +++-
 fs/ext4/mballoc.c | 97 ++++++++++++++++++++++++++++++++++++++++++++---
 fs/ext4/mballoc.h | 14 +++++++
 fs/ext4/sysfs.c   |  2 +
 4 files changed, 113 insertions(+), 7 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index d8fa01e54e81..879aac5e39a9 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -132,7 +132,7 @@ enum SHIFT_DIRECTION {
  * criteria the slower the allocation. We start at lower criterias and keep
  * falling back to higher ones if we are not able to find any blocks.
  */
-#define EXT4_MB_NUM_CRS 4
+#define EXT4_MB_NUM_CRS 5
 
 /*
  * Flags used in mballoc's allocation_context flags field.
@@ -175,6 +175,9 @@ enum SHIFT_DIRECTION {
 #define EXT4_MB_CR0_OPTIMIZED		0x8000
 /* Avg fragment size rb tree lookup succeeded at least once for cr = 1 */
 #define EXT4_MB_CR1_OPTIMIZED		0x00010000
+/* Avg fragment size rb tree lookup succeeded at least once for cr = 1.5 */
+#define EXT4_MB_CR1_5_OPTIMIZED		0x00020000
+
 struct ext4_allocation_request {
 	/* target inode for block we're allocating */
 	struct inode *inode;
@@ -1627,6 +1630,7 @@ struct ext4_sb_info {
 	unsigned long s_mb_last_start;
 	unsigned int s_mb_prefetch;
 	unsigned int s_mb_prefetch_limit;
+	unsigned int s_mb_cr1_5_max_trim_order;
 
 	/* stats for buddy allocator */
 	atomic_t s_bal_reqs;	/* number of reqs with len > 1 */
@@ -1641,6 +1645,7 @@ struct ext4_sb_info {
 	atomic_t s_bal_2orders;	/* 2^order hits */
 	atomic_t s_bal_cr0_bad_suggestions;
 	atomic_t s_bal_cr1_bad_suggestions;
+	atomic_t s_bal_cr1_5_bad_suggestions;
 	atomic64_t s_bal_cX_groups_considered[EXT4_MB_NUM_CRS];
 	atomic64_t s_bal_cX_hits[EXT4_MB_NUM_CRS];
 	atomic64_t s_bal_cX_failed[EXT4_MB_NUM_CRS];		/* cX loop didn't find blocks */
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 1ce1174aea52..8e9032f94966 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -960,6 +960,67 @@ static void ext4_mb_choose_next_group_cr1(struct ext4_allocation_context *ac,
 		*group = grp->bb_group;
 		ac->ac_flags |= EXT4_MB_CR1_OPTIMIZED;
 	} else {
+		*new_cr = CR1_5;
+	}
+}
+
+/*
+ * We couldn't find a group in CR1 so try to find the highest free fragment
+ * order we have and proactively trim the goal request length to that order to
+ * find a suitable group faster.
+ *
+ * This optimizes allocation speed at the cost of slightly reduced
+ * preallocations. However, we make sure that we don't trim the request too
+ * much and fall to CR2 in that case.
+ */
+static void ext4_mb_choose_next_group_cr1_5(struct ext4_allocation_context *ac,
+		enum criteria *new_cr, ext4_group_t *group, ext4_group_t ngroups)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
+	struct ext4_group_info *grp = NULL;
+	int i, order, min_order;
+
+	if (unlikely(ac->ac_flags & EXT4_MB_CR1_5_OPTIMIZED)) {
+		if (sbi->s_mb_stats)
+			atomic_inc(&sbi->s_bal_cr1_5_bad_suggestions);
+	}
+
+	/*
+	 * mb_avg_fragment_size_order() returns order in a way that makes
+	 * retrieving back the length using (1 << order) inaccurate. Hence, use
+	 * fls() instead since we need to know the actual length while modifying
+	 * goal length.
+	 */
+	order = fls(ac->ac_g_ex.fe_len);
+	min_order = order - sbi->s_mb_cr1_5_max_trim_order;
+	if (min_order < 0)
+		min_order = 0;
+
+	for (i = order; i >= min_order; i--) {
+		if (ac->ac_o_ex.fe_len <= (1 << i)) {
+			/*
+			 * Scale down goal len to make sure we find something
+			 * in the free fragments list. Basically, reduce
+			 * preallocations.
+			 */
+			ac->ac_g_ex.fe_len = 1 << i;
+		} else {
+			break;
+		}
+
+		grp = ext4_mb_find_good_group_avg_frag_lists(ac,
+							     mb_avg_fragment_size_order(ac->ac_sb,
+							     ac->ac_g_ex.fe_len));
+		if (grp)
+			break;
+	}
+
+	if (grp) {
+		*group = grp->bb_group;
+		ac->ac_flags |= EXT4_MB_CR1_5_OPTIMIZED;
+	} else {
+		/* Reset goal length to original goal length before falling into CR2 */
+		ac->ac_g_ex.fe_len = ac->ac_orig_goal_len;
 		*new_cr = CR2;
 	}
 }
@@ -1026,6 +1087,8 @@ static void ext4_mb_choose_next_group(struct ext4_allocation_context *ac,
 		ext4_mb_choose_next_group_cr0(ac, new_cr, group, ngroups);
 	} else if (*new_cr == CR1) {
 		ext4_mb_choose_next_group_cr1(ac, new_cr, group, ngroups);
+	} else if (*new_cr == CR1_5) {
+		ext4_mb_choose_next_group_cr1_5(ac, new_cr, group, ngroups);
 	} else {
 		/*
 		 * TODO: For CR=2, we can arrange groups in an rb tree sorted by
@@ -2323,7 +2386,7 @@ void ext4_mb_complex_scan_group(struct ext4_allocation_context *ac,
 
 		if (ac->ac_criteria < CR2) {
 			/*
-			 * In CR1, we are sure that this group will
+			 * In CR1 and CR1_5, we are sure that this group will
 			 * have a large enough continuous free extent, so skip
 			 * over the smaller free extents
 			 */
@@ -2453,6 +2516,7 @@ static bool ext4_mb_good_group(struct ext4_allocation_context *ac,
 
 		return true;
 	case CR1:
+	case CR1_5:
 		if ((free / fragments) >= ac->ac_g_ex.fe_len)
 			return true;
 		break;
@@ -2715,7 +2779,7 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 			 * spend a lot of time loading imperfect groups
 			 */
 			if ((prefetch_grp == group) &&
-			    (cr > CR1 ||
+			    (cr > CR1_5 ||
 			     prefetch_ios < sbi->s_mb_prefetch_limit)) {
 				nr = sbi->s_mb_prefetch;
 				if (ext4_has_feature_flex_bg(sb)) {
@@ -2755,8 +2819,8 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 			ac->ac_groups_scanned++;
 			if (cr == CR0)
 				ext4_mb_simple_scan_group(ac, &e4b);
-			else if (cr == CR1 && sbi->s_stripe &&
-					!(ac->ac_g_ex.fe_len % sbi->s_stripe))
+			else if ((cr == CR1 || cr == CR1_5) && sbi->s_stripe &&
+				 !(ac->ac_g_ex.fe_len % sbi->s_stripe))
 				ext4_mb_scan_aligned(ac, &e4b);
 			else
 				ext4_mb_complex_scan_group(ac, &e4b);
@@ -2770,6 +2834,11 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 		/* Processed all groups and haven't found blocks */
 		if (sbi->s_mb_stats && i == ngroups)
 			atomic64_inc(&sbi->s_bal_cX_failed[cr]);
+
+		if (i == ngroups && ac->ac_criteria == CR1_5)
+			/* Reset goal length to original goal length before
+			 * falling into CR2 */
+			ac->ac_g_ex.fe_len = ac->ac_orig_goal_len;
 	}
 
 	if (ac->ac_b_ex.fe_len > 0 && ac->ac_status != AC_STATUS_FOUND &&
@@ -2937,6 +3006,16 @@ int ext4_seq_mb_stats_show(struct seq_file *seq, void *offset)
 	seq_printf(seq, "\t\tbad_suggestions: %u\n",
 		   atomic_read(&sbi->s_bal_cr1_bad_suggestions));
 
+	seq_puts(seq, "\tcr1.5_stats:\n");
+	seq_printf(seq, "\t\thits: %llu\n", atomic64_read(&sbi->s_bal_cX_hits[CR1_5]));
+	seq_printf(seq, "\t\tgroups_considered: %llu\n",
+		   atomic64_read(&sbi->s_bal_cX_groups_considered[CR1_5]));
+	seq_printf(seq, "\t\textents_scanned: %u\n", atomic_read(&sbi->s_bal_cX_ex_scanned[CR1_5]));
+	seq_printf(seq, "\t\tuseless_loops: %llu\n",
+		   atomic64_read(&sbi->s_bal_cX_failed[CR1_5]));
+	seq_printf(seq, "\t\tbad_suggestions: %u\n",
+		   atomic_read(&sbi->s_bal_cr1_5_bad_suggestions));
+
 	seq_puts(seq, "\tcr2_stats:\n");
 	seq_printf(seq, "\t\thits: %llu\n", atomic64_read(&sbi->s_bal_cX_hits[CR2]));
 	seq_printf(seq, "\t\tgroups_considered: %llu\n",
@@ -3452,6 +3531,8 @@ int ext4_mb_init(struct super_block *sb)
 	sbi->s_mb_stream_request = MB_DEFAULT_STREAM_THRESHOLD;
 	sbi->s_mb_order2_reqs = MB_DEFAULT_ORDER2_REQS;
 	sbi->s_mb_max_inode_prealloc = MB_DEFAULT_MAX_INODE_PREALLOC;
+	sbi->s_mb_cr1_5_max_trim_order = MB_DEFAULT_CR1_5_TRIM_ORDER;
+
 	/*
 	 * The default group preallocation is 512, which for 4k block
 	 * sizes translates to 2 megabytes.  However for bigalloc file
@@ -4218,6 +4299,7 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
 	 * placement or satisfy big request as is */
 	ac->ac_g_ex.fe_logical = start;
 	ac->ac_g_ex.fe_len = EXT4_NUM_B2C(sbi, size);
+	ac->ac_orig_goal_len = ac->ac_g_ex.fe_len;
 
 	/* define goal start in order to merge */
 	if (ar->pright && (ar->lright == (start + size))) {
@@ -4258,8 +4340,10 @@ static void ext4_mb_collect_stats(struct ext4_allocation_context *ac)
 		if (ac->ac_g_ex.fe_start == ac->ac_b_ex.fe_start &&
 				ac->ac_g_ex.fe_group == ac->ac_b_ex.fe_group)
 			atomic_inc(&sbi->s_bal_goals);
-		if (ac->ac_f_ex.fe_len == ac->ac_g_ex.fe_len)
+		/* did we allocate as much as normalizer originally wanted? */
+		if (ac->ac_f_ex.fe_len == ac->ac_orig_goal_len)
 			atomic_inc(&sbi->s_bal_len_goals);
+
 		if (ac->ac_found > sbi->s_mb_max_to_scan)
 			atomic_inc(&sbi->s_bal_breaks);
 	}
@@ -4652,7 +4736,7 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
 
 	pa = ac->ac_pa;
 
-	if (ac->ac_b_ex.fe_len < ac->ac_g_ex.fe_len) {
+	if (ac->ac_b_ex.fe_len < ac->ac_orig_goal_len) {
 		int winl;
 		int wins;
 		int win;
@@ -5281,6 +5365,7 @@ ext4_mb_initialize_context(struct ext4_allocation_context *ac,
 	ac->ac_o_ex.fe_start = block;
 	ac->ac_o_ex.fe_len = len;
 	ac->ac_g_ex = ac->ac_o_ex;
+	ac->ac_orig_goal_len = ac->ac_g_ex.fe_len;
 	ac->ac_flags = ar->flags;
 
 	/* we have to define context: we'll work with a file or
diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
index 004b8d163cc9..c1b0bf2f6f4d 100644
--- a/fs/ext4/mballoc.h
+++ b/fs/ext4/mballoc.h
@@ -90,6 +90,13 @@
  */
 #define MB_DEFAULT_LINEAR_SCAN_THRESHOLD	16
 
+/*
+ * The maximum order upto which CR1.5 can trim a particular allocation request.
+ * Example, if we have an order 7 request and max trim order of 3, CR1.5 can
+ * trim this upto order 4.
+ */
+#define MB_DEFAULT_CR1_5_TRIM_ORDER	3
+
 /*
  * Number of valid buddy orders
  */
@@ -101,6 +108,7 @@
 enum criteria {
 	CR0,
 	CR1,
+	CR1_5,
 	CR2,
 	CR3,
 };
@@ -188,6 +196,12 @@ struct ext4_allocation_context {
 	/* copy of the best found extent taken before preallocation efforts */
 	struct ext4_free_extent ac_f_ex;
 
+	/*
+	 * goal len can change in CR1.5, so save the original len. This is
+	 * used while adjusting the PA window and for accounting.
+	 */
+	ext4_grpblk_t	ac_orig_goal_len;
+
 	__u32 ac_groups_considered;
 	__u32 ac_flags;		/* allocation hints */
 	__u16 ac_groups_scanned;
diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
index d233c24ea342..5ba884a0246e 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -224,6 +224,7 @@ EXT4_RW_ATTR_SBI_UI(warning_ratelimit_interval_ms, s_warning_ratelimit_state.int
 EXT4_RW_ATTR_SBI_UI(warning_ratelimit_burst, s_warning_ratelimit_state.burst);
 EXT4_RW_ATTR_SBI_UI(msg_ratelimit_interval_ms, s_msg_ratelimit_state.interval);
 EXT4_RW_ATTR_SBI_UI(msg_ratelimit_burst, s_msg_ratelimit_state.burst);
+EXT4_RW_ATTR_SBI_UI(mb_cr1_5_max_trim_order, s_mb_cr1_5_max_trim_order);
 #ifdef CONFIG_EXT4_DEBUG
 EXT4_RW_ATTR_SBI_UL(simulate_fail, s_simulate_fail);
 #endif
@@ -275,6 +276,7 @@ static struct attribute *ext4_attrs[] = {
 	ATTR_LIST(warning_ratelimit_burst),
 	ATTR_LIST(msg_ratelimit_interval_ms),
 	ATTR_LIST(msg_ratelimit_burst),
+	ATTR_LIST(mb_cr1_5_max_trim_order),
 	ATTR_LIST(errors_count),
 	ATTR_LIST(warning_count),
 	ATTR_LIST(msg_count),
-- 
2.31.1

