Return-Path: <linux-fsdevel+bounces-4399-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6BF7FF2B8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 15:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 012152826BB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 14:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD55F51008
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 14:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UZJKC68m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736FB170B;
	Thu, 30 Nov 2023 05:53:47 -0800 (PST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AUDnZ3h001557;
	Thu, 30 Nov 2023 13:53:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=OLCZNiRjZ6gnwfClcveUD+5icHyr7gsNTwEW2i0DScM=;
 b=UZJKC68myhv6LTIU+jkYnDf4TRRJduigFshj9QUu0HESNTkq2QqwUqvll0LsG6WRBXuV
 JctlJ1CTctR5rcDFprEi+Biz+wb/XXZRY+l0FFg8GEpgN91a94xJC3r0ItYQ5CsDwG1A
 MOt0cQS6B3M1PunIJHF36Rc+QrDyr4yqAJrTP4M9aqR0uYeEbtqWGV7wILcKHFScJuGe
 sDe/4h07okqb2Xn9qxxe0oQbulchV9V4YjXaqt3gjab/UHscf8XCMNofPHL98s0Ge2J8
 jFCGOQPUmpa6Zj/m4aHjtXG7oIcQVx3jGbE13kEHd3Pt1qHwchOaEsjW6Iy73ZDLnJ9S OQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3upu2vh3k6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Nov 2023 13:53:41 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AUDnb5M001726;
	Thu, 30 Nov 2023 13:53:40 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3upu2vh3ju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Nov 2023 13:53:40 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AUDn2Qi021292;
	Thu, 30 Nov 2023 13:53:39 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ukumyxkr1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Nov 2023 13:53:39 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AUDrbsc19530370
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Nov 2023 13:53:37 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 93A3E2004B;
	Thu, 30 Nov 2023 13:53:37 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A86B20040;
	Thu, 30 Nov 2023 13:53:35 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com.com (unknown [9.43.76.38])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Nov 2023 13:53:34 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>, dchinner@redhat.com
Subject: [RFC 4/7] ext4: allow inode preallocation for aligned alloc
Date: Thu, 30 Nov 2023 19:23:13 +0530
Message-Id: <74aceb317593df40539a0a3e109406992600853c.1701339358.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1701339358.git.ojaswin@linux.ibm.com>
References: <cover.1701339358.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: y7j525rcsX4Mk3vCDTfdNxmNhtFW-PmU
X-Proofpoint-ORIG-GUID: JpD_H5u2m3yifwts5EBH1iG38hWe4U9Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-30_12,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 mlxlogscore=994 adultscore=0 lowpriorityscore=0 impostorscore=0
 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311300102

Enable inode preallocation support for aligned allocations. Inode
preallocation will only be used if the preallocated blocks are able to
satisfy the length and alignment requirements of the allocations, else
we disable preallocation for this particular allocation and proceed as
usual. Disabling inode preallocation is required otherwise we might end
up with overlapping preallocated ranges which can trigger a BUG() later.

While normalizing the request, we need to make sure that:

1. start of normalized(goal) request matches original request so it is
easier to align it during actual allocations. This prevents various edge
cases where the start of goal is different than original start making it
trickier to align the original start as requested by user.

2. the length of goal should not be smaller than original and should
   be a power of 2.

For now, group preallocation is disabled for aligned allocations.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/mballoc.c | 168 +++++++++++++++++++++++++++++-----------------
 1 file changed, 107 insertions(+), 61 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index b1df531e6db3..c21b2758c3f0 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2151,8 +2151,6 @@ static void ext4_mb_use_best_found(struct ext4_allocation_context *ac,
 	 * space in a special descriptor.
 	 */
 	if (ac->ac_o_ex.fe_len < ac->ac_b_ex.fe_len) {
-		/* Aligned allocation doesn't have preallocation support */
-		WARN_ON(ac->ac_flags & EXT4_MB_ALIGNED_ALLOC);
 		ext4_mb_new_preallocation(ac);
 	}
 
@@ -2992,8 +2990,7 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 
 		WARN_ON(!is_power_of_2(len));
 		WARN_ON(start % len);
-		/* We don't support preallocation yet */
-		WARN_ON(ac->ac_b_ex.fe_len != ac->ac_o_ex.fe_len);
+		WARN_ON(ac->ac_b_ex.fe_len < ac->ac_o_ex.fe_len);
 	}
 
  exit:
@@ -4309,7 +4306,7 @@ ext4_mb_pa_adjust_overlap(struct ext4_allocation_context *ac,
 	struct ext4_prealloc_space *tmp_pa = NULL, *left_pa = NULL, *right_pa = NULL;
 	struct rb_node *iter;
 	ext4_lblk_t new_start, tmp_pa_start, right_pa_start = -1;
-	loff_t new_end, tmp_pa_end, left_pa_end = -1;
+	loff_t size, new_end, tmp_pa_end, left_pa_end = -1;
 
 	new_start = *start;
 	new_end = *end;
@@ -4429,6 +4426,22 @@ ext4_mb_pa_adjust_overlap(struct ext4_allocation_context *ac,
 	}
 	read_unlock(&ei->i_prealloc_lock);
 
+	if (ac->ac_flags & EXT4_MB_ALIGNED_ALLOC) {
+		/*
+		 * Aligned allocation happens via CR_POWER2_ALIGNED criteria
+		 * hence we must make sure that the new size is a power of 2.
+		 */
+		size = new_end - new_start;
+		size = (loff_t)1 << (fls64(size) - 1);
+
+		if (unlikely(size < ac->ac_o_ex.fe_len))
+			size = ac->ac_o_ex.fe_len;
+		new_end = new_start + size;
+
+		WARN_ON(*start != new_start);
+		WARN_ON(!is_power_of_2(size));
+	}
+
 	/* XXX: extra loop to check we really don't overlap preallocations */
 	ext4_mb_pa_assert_overlap(ac, new_start, new_end);
 
@@ -4484,6 +4497,21 @@ static void ext4_mb_pa_predict_size(struct ext4_allocation_context *ac,
 					      ac->ac_o_ex.fe_len) << bsbits;
 	}
 
+	/*
+	 * For aligned allocations, we need to ensure 2 things:
+	 *
+	 * 1. The start should remain same as original start so that finding
+	 * aligned physical blocks for it is straight forward.
+	 *
+	 * 2. The new_size should not be less than the original len. This
+	 * can sometimes happen due to the way we predict size above.
+	 */
+	if (ac->ac_flags & EXT4_MB_ALIGNED_ALLOC) {
+		new_start = ac->ac_o_ex.fe_logical << bsbits;
+		new_size = max_t(loff_t, new_size,
+				 EXT4_C2B(sbi, ac->ac_o_ex.fe_len) << bsbits);
+	}
+
 	*size = new_size;
 	*start = new_start;
 }
@@ -4517,13 +4545,6 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
 	if (ac->ac_flags & EXT4_MB_HINT_NOPREALLOC)
 		return;
 
-	/*
-	 * caller may have strict alignment requirements. In this case, avoid
-	 * normalization since it is not alignment aware.
-	 */
-	if (ac->ac_flags & EXT4_MB_ALIGNED_ALLOC)
-		return;
-
 	if (ac->ac_flags & EXT4_MB_HINT_GROUP_ALLOC) {
 		ext4_mb_normalize_group_request(ac);
 		return ;
@@ -4557,8 +4578,13 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
 	start = max(start, rounddown(ac->ac_o_ex.fe_logical,
 			(ext4_lblk_t)EXT4_BLOCKS_PER_GROUP(ac->ac_sb)));
 
-	/* don't cover already allocated blocks in selected range */
+	/*
+	 * don't cover already allocated blocks in selected range. For aligned
+	 * alloc, since we don't change the original start we should ideally not
+	 * enter this if block.
+	 */
 	if (ar->pleft && start <= ar->lleft) {
+		WARN_ON(ac->ac_flags & EXT4_MB_ALIGNED_ALLOC);
 		size -= ar->lleft + 1 - start;
 		start = ar->lleft + 1;
 	}
@@ -4791,32 +4817,46 @@ ext4_mb_check_group_pa(ext4_fsblk_t goal_block,
 }
 
 /*
- * check if found pa meets EXT4_MB_HINT_GOAL_ONLY
+ * check if found pa meets EXT4_MB_HINT_GOAL_ONLY or EXT4_MB_ALIGNED_ALLOC
  */
 static bool
-ext4_mb_pa_goal_check(struct ext4_allocation_context *ac,
+ext4_mb_pa_check(struct ext4_allocation_context *ac,
 		      struct ext4_prealloc_space *pa)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
 	ext4_fsblk_t start;
 
-	if (likely(!(ac->ac_flags & EXT4_MB_HINT_GOAL_ONLY)))
+	if (likely(!(ac->ac_flags & EXT4_MB_HINT_GOAL_ONLY ||
+		     ac->ac_flags & EXT4_MB_ALIGNED_ALLOC)))
 		return true;
 
-	/*
-	 * If EXT4_MB_HINT_GOAL_ONLY is set, ac_g_ex will not be adjusted
-	 * in ext4_mb_normalize_request and will keep same with ac_o_ex
-	 * from ext4_mb_initialize_context. Choose ac_g_ex here to keep
-	 * consistent with ext4_mb_find_by_goal.
-	 */
-	start = pa->pa_pstart +
-		(ac->ac_g_ex.fe_logical - pa->pa_lstart);
-	if (ext4_grp_offs_to_block(ac->ac_sb, &ac->ac_g_ex) != start)
-		return false;
+	if (ac->ac_flags & EXT4_MB_HINT_GOAL_ONLY) {
+		/*
+		 * If EXT4_MB_HINT_GOAL_ONLY is set, ac_g_ex will not be adjusted
+		 * in ext4_mb_normalize_request and will keep same with ac_o_ex
+		 * from ext4_mb_initialize_context. Choose ac_g_ex here to keep
+		 * consistent with ext4_mb_find_by_goal.
+		 */
+		start = pa->pa_pstart +
+			(ac->ac_g_ex.fe_logical - pa->pa_lstart);
+		if (ext4_grp_offs_to_block(ac->ac_sb, &ac->ac_g_ex) != start)
+			return false;
 
-	if (ac->ac_g_ex.fe_len > pa->pa_len -
-	    EXT4_B2C(sbi, ac->ac_g_ex.fe_logical - pa->pa_lstart))
-		return false;
+		if (ac->ac_g_ex.fe_len >
+		    pa->pa_len - EXT4_B2C(sbi, ac->ac_g_ex.fe_logical -
+						       pa->pa_lstart))
+			return false;
+	} else if (ac->ac_flags & EXT4_MB_ALIGNED_ALLOC) {
+		start = pa->pa_pstart +
+			(ac->ac_g_ex.fe_logical - pa->pa_lstart);
+		if (start % EXT4_C2B(sbi, ac->ac_g_ex.fe_len))
+			return false;
+
+		if (EXT4_C2B(sbi, ac->ac_g_ex.fe_len) >
+		    (EXT4_C2B(sbi, pa->pa_len) -
+		     (ac->ac_g_ex.fe_logical - pa->pa_lstart)))
+			return false;
+	}
 
 	return true;
 }
@@ -4839,10 +4879,6 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
 	if (!(ac->ac_flags & EXT4_MB_HINT_DATA))
 		return false;
 
-	/* using preallocated blocks is not alignment aware. */
-	if (ac->ac_flags & EXT4_MB_ALIGNED_ALLOC)
-		return false;
-
 	/*
 	 * first, try per-file preallocation by searching the inode pa rbtree.
 	 *
@@ -4948,41 +4984,49 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
 		goto try_group_pa;
 	}
 
-	if (tmp_pa->pa_free && likely(ext4_mb_pa_goal_check(ac, tmp_pa))) {
+	if (tmp_pa->pa_free && likely(ext4_mb_pa_check(ac, tmp_pa))) {
 		atomic_inc(&tmp_pa->pa_count);
 		ext4_mb_use_inode_pa(ac, tmp_pa);
 		spin_unlock(&tmp_pa->pa_lock);
 		read_unlock(&ei->i_prealloc_lock);
 		return true;
 	} else {
+		if (tmp_pa->pa_free == 0)
+			/*
+			 * We found a valid overlapping pa but couldn't use it because
+			 * it had no free blocks. This should ideally never happen
+			 * because:
+			 *
+			 * 1. When a new inode pa is added to rbtree it must have
+			 *    pa_free > 0 since otherwise we won't actually need
+			 *    preallocation.
+			 *
+			 * 2. An inode pa that is in the rbtree can only have it's
+			 *    pa_free become zero when another thread calls:
+			 *      ext4_mb_new_blocks
+			 *       ext4_mb_use_preallocated
+			 *        ext4_mb_use_inode_pa
+			 *
+			 * 3. Further, after the above calls make pa_free == 0, we will
+			 *    immediately remove it from the rbtree in:
+			 *      ext4_mb_new_blocks
+			 *       ext4_mb_release_context
+			 *        ext4_mb_put_pa
+			 *
+			 * 4. Since the pa_free becoming 0 and pa_free getting removed
+			 * from tree both happen in ext4_mb_new_blocks, which is always
+			 * called with i_data_sem held for data allocations, we can be
+			 * sure that another process will never see a pa in rbtree with
+			 * pa_free == 0.
+			 */
+			WARN_ON_ONCE(tmp_pa->pa_free == 0);
 		/*
-		 * We found a valid overlapping pa but couldn't use it because
-		 * it had no free blocks. This should ideally never happen
-		 * because:
-		 *
-		 * 1. When a new inode pa is added to rbtree it must have
-		 *    pa_free > 0 since otherwise we won't actually need
-		 *    preallocation.
-		 *
-		 * 2. An inode pa that is in the rbtree can only have it's
-		 *    pa_free become zero when another thread calls:
-		 *      ext4_mb_new_blocks
-		 *       ext4_mb_use_preallocated
-		 *        ext4_mb_use_inode_pa
-		 *
-		 * 3. Further, after the above calls make pa_free == 0, we will
-		 *    immediately remove it from the rbtree in:
-		 *      ext4_mb_new_blocks
-		 *       ext4_mb_release_context
-		 *        ext4_mb_put_pa
-		 *
-		 * 4. Since the pa_free becoming 0 and pa_free getting removed
-		 * from tree both happen in ext4_mb_new_blocks, which is always
-		 * called with i_data_sem held for data allocations, we can be
-		 * sure that another process will never see a pa in rbtree with
-		 * pa_free == 0.
+		 * If we come here we need to disable preallocations else we'd
+		 * have multiple preallocations for the same logical offset
+		 * which is not allowed and will cause BUG_ONs to be triggered
+		 * later.
 		 */
-		WARN_ON_ONCE(tmp_pa->pa_free == 0);
+		ac->ac_flags |= EXT4_MB_HINT_NOPREALLOC;
 	}
 	spin_unlock(&tmp_pa->pa_lock);
 try_group_pa:
@@ -5818,6 +5862,7 @@ static void ext4_mb_group_or_file(struct ext4_allocation_context *ac)
 	int bsbits = ac->ac_sb->s_blocksize_bits;
 	loff_t size, isize;
 	bool inode_pa_eligible, group_pa_eligible;
+	bool is_aligned = (ac->ac_flags & EXT4_MB_ALIGNED_ALLOC);
 
 	if (!(ac->ac_flags & EXT4_MB_HINT_DATA))
 		return;
@@ -5825,7 +5870,8 @@ static void ext4_mb_group_or_file(struct ext4_allocation_context *ac)
 	if (unlikely(ac->ac_flags & EXT4_MB_HINT_GOAL_ONLY))
 		return;
 
-	group_pa_eligible = sbi->s_mb_group_prealloc > 0;
+	/* Aligned allocation does not support group pa */
+	group_pa_eligible = (!is_aligned && sbi->s_mb_group_prealloc > 0);
 	inode_pa_eligible = true;
 	size = extent_logical_end(sbi, &ac->ac_o_ex);
 	isize = (i_size_read(ac->ac_inode) + ac->ac_sb->s_blocksize - 1)
-- 
2.39.3


