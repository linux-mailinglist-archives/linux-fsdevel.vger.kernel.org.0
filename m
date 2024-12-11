Return-Path: <linux-fsdevel+bounces-37017-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC04E9EC632
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 08:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30E5B1883E14
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 07:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273771D86FF;
	Wed, 11 Dec 2024 07:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="C3MaTwRW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65C11D6199;
	Wed, 11 Dec 2024 07:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733903894; cv=none; b=cXMzTY4OJnZMFCuhrA9tN3V6vTy6IcQqEmFTJkW7XwBKm59K0VOQxciRRBWWWpmc6TqSdRw1/7CY8W2NXpN4xToCw/mxGu02lVdv6FNNcN7zXZg3FVDFDY5osJw7CwYD7h1SdIEdhQXHTMlerS5j7reSIMOKQsUovTVt+a5Nw2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733903894; c=relaxed/simple;
	bh=tgkjsBdLe6XjB+3Og3UJ9Af08aioXP5i4O/7SFI+lys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mGrHtBEaDm8uKrAi7YDds1m1FTLWZJRlUoWM7LWdAAh+/KOTHY1rnL3OEK77hIife0XsKoBwhCuZC/GV09hhb+qhgXs3T1DcwkqDl11KEk5MuqbJSdRtHLLOR1k5UlQyrT/s6/6rLSwZbOfd2dnGcvtnKhlI/DcZ9PCtgtuPrhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=C3MaTwRW; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BAM1jOT009037;
	Wed, 11 Dec 2024 07:58:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=YCSqPevAtP19vU3Po
	oeadSd6bxNvOLLOnMFkzwR1LOg=; b=C3MaTwRWbKsbltoAqzidadbacxBUlYS14
	pAfTzxKB7YuROzixv2mOt/T7Ez4LUZj547Z2fVMyWu9N5LEgdMfQP44goclhCxF+
	gKCg07zAYJMQVNzMFUkbSQR1NzbyK8QY+AFXvMEf7nZK/+g9UCzrhfYfXSftpiIO
	UX7bTmj/5xFv5nLPZjOEirg3RO5PHK3tc8EuhJUK+pdZxIArC5JQa0zAFkrj16pI
	zNX5lwu1D8nwzNUSLjme2mdiPDPPjriyXq4nDnJRVplw3dvtl4sLDDk7baXw8d3K
	kW6sOp4cr4MuUi+u/UpMWrdYJR7viOj1GLCeWxx2C+udxkCABosHQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce38uve7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 07:58:05 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BB7trnG025864;
	Wed, 11 Dec 2024 07:58:04 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce38uve4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 07:58:04 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BB7NM1L023047;
	Wed, 11 Dec 2024 07:58:03 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 43d2wjyxvc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 07:58:03 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BB7w25G36897122
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Dec 2024 07:58:02 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1092520043;
	Wed, 11 Dec 2024 07:58:02 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5EC4F20040;
	Wed, 11 Dec 2024 07:58:00 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com.com (unknown [9.39.30.217])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Dec 2024 07:58:00 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>, dchinner@redhat.com,
        Nirjhar Roy <nirjhar@linux.ibm.com>
Subject: [RFC v2 2/6] ext4: allow inode preallocation for aligned alloc
Date: Wed, 11 Dec 2024 13:27:51 +0530
Message-ID: <1e6ea627ac0b8caf202c1430e44ddd2b9d320644.1733901374.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1733901374.git.ojaswin@linux.ibm.com>
References: <cover.1733901374.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: x7sysE1pgs_vbWvxe30mgYU-8xZ57af5
X-Proofpoint-ORIG-GUID: HJahXmGBJSUC2Z5KPOdcMm4qyuER63p4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 bulkscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412110051

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
index 9763349598e9..a500a561c47d 100644
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


