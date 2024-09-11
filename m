Return-Path: <linux-fsdevel+bounces-29078-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98338974DCE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 11:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B650B25E61
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 09:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DDD917BB0D;
	Wed, 11 Sep 2024 09:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fHkK79Vq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FDD16DEA7;
	Wed, 11 Sep 2024 09:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726045287; cv=none; b=B6EFa0qSZO6DxHmyNYaFsx1ppUwTlLB9eXucIQ5pBp3/c3VkjYRsWstovYW3u5nErp08ONeDKA0E8C9PfcluWrG1f5i45oQOL3ZjknfYt5lZUNPiElkqpe34AnsU0frpn7jqqdJnP55kug+S92AGjHYbHYhWtZmAi9ssqVKX7TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726045287; c=relaxed/simple;
	bh=PzNZw6NXBeSBlaIFjYqQOwtAce5PHUf4j/0cLhdP9J4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X/K8Pdi5cKF1wI8+IQ8W7ASrepee5G+SGOQMVG3+Jcch8EwN+yH3U+/aqVeLX92IvEJz3Ia2a0WNzgla7SyAtmMS9Eyuu6X43SL48g1qmFvNt5MowrTE7IsEi3580dKsv0DYYg+ELdS+pr4afIGiV0gO7Ha+sOWK4PI4E7/U0Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fHkK79Vq; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48ALVVKu022933;
	Wed, 11 Sep 2024 09:01:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=QsWsSdrldUDth
	aoscoTTEvWVk10Hss1tSzmbjQcYOBo=; b=fHkK79VqtH8LLM27nXq0WqudvpFK9
	mRPFOM+yOmMReUJh/HeYSRgplmoTFdrbDdfw8E4Z0kr6upvR28H/3b1H6WCJljDN
	28AymYheyhFhIQ1ug2OuhIhgWC42NHrOXXlz134nif8rrlkHLBJfkqc7exgVJm0+
	W7KUo1fKUqE45YrW2dXOGOZ2wGRSinn6F2pzB581fedK0Q1JKnbLP5lzBLA2yZl4
	jyf79G4w2d4V/6A9q0KxkgXaVm0C3UFzC4PVFIvKAltE5MqZ2XeOquqZDVPc7NLv
	pu+x7+sjYrQYKt6kTvg3W1NjRhTpOt0SIKUyfq+JFqnWOs5nPeXNaW0XA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gejamm42-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Sep 2024 09:01:20 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48B8rb2S013815;
	Wed, 11 Sep 2024 09:01:19 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gejamm3t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Sep 2024 09:01:19 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48B6s7xf032399;
	Wed, 11 Sep 2024 09:01:18 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41h1j0rg2k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Sep 2024 09:01:18 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48B91Grv49807752
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Sep 2024 09:01:16 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 413D820049;
	Wed, 11 Sep 2024 09:01:16 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8765420040;
	Wed, 11 Sep 2024 09:01:14 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.in.ibm.com (unknown [9.109.253.82])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Sep 2024 09:01:14 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>, dchinner@redhat.com
Subject: [RFC 2/5] ext4: allow inode preallocation for aligned alloc
Date: Wed, 11 Sep 2024 14:31:06 +0530
Message-ID: <2ab5226e6e5fe27a5cd0a1a756527c22bbd8d7c2.1726034272.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1726034272.git.ojaswin@linux.ibm.com>
References: <cover.1726034272.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lsKP52efjPTsO4O4cxigR_FzY7g-Su3D
X-Proofpoint-GUID: IqzTRvFhoup8hvGGAiKaM3-d0Ou3exuw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-10_12,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 impostorscore=0 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409110064

Enable inode preallocation support for aligned allocations. Inode
preallocation will only be used if the preallocated blocks are able to
satisfy the length and alignment requirements of the allocations, else
we disable preallocation for this particular allocation and proceed as
usual. Disabling inode preallocation is required otherwise we might end
up with overlapping preallocated ranges which can trigger a BUG() later.

Further, during normalizing, we usually try to round it up to a power of
2 which can still give us aligned allocation. We also make sure not
change the goal start so aligned allocation is more straightforward. If for
whatever reason the goal is not power of 2 or doesn't contain the original
request, then we throw a warning and proceed as normal.

For now, group preallocation is disabled for aligned allocations.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/mballoc.c | 96 +++++++++++++++++++++++++++++++----------------
 1 file changed, 63 insertions(+), 33 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 724905552f3b..23a553ad02fa 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2178,8 +2178,6 @@ static void ext4_mb_use_best_found(struct ext4_allocation_context *ac,
 	 * space in a special descriptor.
 	 */
 	if (ac->ac_o_ex.fe_len < ac->ac_b_ex.fe_len) {
-		/* Aligned allocation doesn't have preallocation support */
-		WARN_ON(ac->ac_flags & EXT4_MB_HINT_ALIGNED);
 		ext4_mb_new_preallocation(ac);
 	}
 
@@ -3027,8 +3025,7 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 
 		WARN_ON_ONCE(!is_power_of_2(len));
 		WARN_ON_ONCE(start % len);
-		/* We don't support preallocation yet */
-		WARN_ON_ONCE(ac->ac_b_ex.fe_len != ac->ac_o_ex.fe_len);
+		WARN_ON_ONCE(ac->ac_b_ex.fe_len < ac->ac_o_ex.fe_len);
 	}
 
  exit:
@@ -4479,13 +4476,6 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
 	if (ac->ac_flags & EXT4_MB_HINT_NOPREALLOC)
 		return;
 
-	/*
-	 * caller may have strict alignment requirements. In this case, avoid
-	 * normalization since it is not alignment aware.
-	 */
-	if (ac->ac_flags & EXT4_MB_HINT_ALIGNED)
-		return;
-
 	if (ac->ac_flags & EXT4_MB_HINT_GROUP_ALLOC) {
 		ext4_mb_normalize_group_request(ac);
 		return ;
@@ -4542,6 +4532,21 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
 		size	  = (loff_t) EXT4_C2B(sbi,
 					      ac->ac_o_ex.fe_len) << bsbits;
 	}
+
+	/*
+	 * For aligned allocations, we need to ensure 2 things:
+	 *
+	 * 1. The start should remain same as original start so that finding
+	 * aligned physical blocks for it is straight forward.
+	 *
+	 * 2. The new_size should not be less than the original len. This
+	 * can sometimes happen due to the way we predict size above.
+	 */
+	if (ac->ac_flags & EXT4_MB_HINT_ALIGNED) {
+		start_off = ac->ac_o_ex.fe_logical << bsbits;
+		size = max_t(loff_t, size,
+				 EXT4_C2B(sbi, ac->ac_o_ex.fe_len) << bsbits);
+	}
 	size = size >> bsbits;
 	start = start_off >> bsbits;
 
@@ -4792,32 +4797,46 @@ ext4_mb_check_group_pa(ext4_fsblk_t goal_block,
 }
 
 /*
- * check if found pa meets EXT4_MB_HINT_GOAL_ONLY
+ * check if found pa meets EXT4_MB_HINT_GOAL_ONLY or EXT4_MB_HINT_ALIGNED
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
+		     ac->ac_flags & EXT4_MB_HINT_ALIGNED)))
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
+	} else if (ac->ac_flags & EXT4_MB_HINT_ALIGNED) {
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
@@ -4840,10 +4859,6 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
 	if (!(ac->ac_flags & EXT4_MB_HINT_DATA))
 		return false;
 
-	/* using preallocated blocks is not alignment aware. */
-	if (ac->ac_flags & EXT4_MB_HINT_ALIGNED)
-		return false;
-
 	/*
 	 * first, try per-file preallocation by searching the inode pa rbtree.
 	 *
@@ -4949,7 +4964,7 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
 		goto try_group_pa;
 	}
 
-	if (tmp_pa->pa_free && likely(ext4_mb_pa_goal_check(ac, tmp_pa))) {
+	if (tmp_pa->pa_free && likely(ext4_mb_pa_check(ac, tmp_pa))) {
 		atomic_inc(&tmp_pa->pa_count);
 		ext4_mb_use_inode_pa(ac, tmp_pa);
 		spin_unlock(&tmp_pa->pa_lock);
@@ -4984,6 +4999,19 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
 		 * pa_free == 0.
 		 */
 		WARN_ON_ONCE(tmp_pa->pa_free == 0);
+
+		/*
+		 * If, for any reason, we reach here then we need to disable PA
+		 * because otherwise ext4_mb_normalize_request() will try to
+		 * allocate a new PA for this logical range where another PA
+		 * already exists. This is not allowed and will trigger BUG_ONs.
+		 * Hence, as a workaround we disable PA.
+		 *
+		 * NOTE: ideally we would want to have some logic to take care
+		 * of the unusable PA. Maybe a more fine grained discard logic
+		 * that could allow us to discard only specific PAs.
+		 */
+		ac->ac_flags |= EXT4_MB_HINT_NOPREALLOC;
 	}
 	spin_unlock(&tmp_pa->pa_lock);
 try_group_pa:
@@ -5790,6 +5818,7 @@ static void ext4_mb_group_or_file(struct ext4_allocation_context *ac)
 	int bsbits = ac->ac_sb->s_blocksize_bits;
 	loff_t size, isize;
 	bool inode_pa_eligible, group_pa_eligible;
+	bool is_aligned = (ac->ac_flags & EXT4_MB_HINT_ALIGNED);
 
 	if (!(ac->ac_flags & EXT4_MB_HINT_DATA))
 		return;
@@ -5797,7 +5826,8 @@ static void ext4_mb_group_or_file(struct ext4_allocation_context *ac)
 	if (unlikely(ac->ac_flags & EXT4_MB_HINT_GOAL_ONLY))
 		return;
 
-	group_pa_eligible = sbi->s_mb_group_prealloc > 0;
+	/* Aligned allocation does not support group pa */
+	group_pa_eligible = (!is_aligned && sbi->s_mb_group_prealloc > 0);
 	inode_pa_eligible = true;
 	size = extent_logical_end(sbi, &ac->ac_o_ex);
 	isize = (i_size_read(ac->ac_inode) + ac->ac_sb->s_blocksize - 1)
-- 
2.43.5


