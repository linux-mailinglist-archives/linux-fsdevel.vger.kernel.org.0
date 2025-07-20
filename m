Return-Path: <linux-fsdevel+bounces-55536-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4405AB0B82E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Jul 2025 22:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D39631898511
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Jul 2025 20:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1230D2248B0;
	Sun, 20 Jul 2025 20:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RPUvnvuw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8421AA7BF;
	Sun, 20 Jul 2025 20:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753045080; cv=none; b=LwMNRBKWdeuV0tDQqqM7J4no35RdmMmp2m/rDpEHumds+8aqD9yJaVbTq9rfUZrD6q6G8yMVLjdzJEL20gQel5K78Dp2fuCAXopKDx/QbZGZtOPpvo6lcUAVBVXlwyJ+mbQrLRX3kHtX1kAWM11agVLvP2jQbn+NcRBzsyt63Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753045080; c=relaxed/simple;
	bh=/GU7vBQ6UjTG90MT4vm51Z5Nxn6PZNIxjeSGR6/InMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bKJuY2YKj59gyxXqg1wgDLc5SwM5OROqOezGXKedwJ1h+ibpfqlOh/XuBpyIneXfwyt71HBcYVbNy1B91PXahCReC3oPrWukwwsXV1WbImaPmXOptoOHedaSxewkDpgOkwEh+4Ub/0eQmvYHQdwAVa5evCGUomnKsyi8dx5vxic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RPUvnvuw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56KJrJnT003936;
	Sun, 20 Jul 2025 20:57:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=B7QWFolN+U1nGufxS
	wbE6IB2XagE9Okr3SaoODqxGDQ=; b=RPUvnvuwIZte/HA2GIvJtcY56y/YX0OXY
	BiYbAKO6qCmSFlOPYrW6xLHTpLlx/+Do9RvymFlGtCNH/UnsYxoMCvGwHK2YnLr8
	13VvRMwByDkbbvlNbGb+Hqx+yJDLbx9pYw9DXPAkz862hHSVVmh7y3jU+pun5O0q
	YnJn5+wLSvXCBUpDL7fS6pMis9tZbTNOutKHhBDqgF1dLKIHVfad6rvi+2f8X/UZ
	cazQzxyf+sFDtSTBZG6J4ojgxiph/mRZbmDzONOiib8mbuSIJ/e4yQWcB67L/NMm
	MkiwDXapMDWpooIXDmclQDA/acVBsWl4gHzbF//XXlyzkam4yAzKA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48069v5jx4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 20 Jul 2025 20:57:45 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56KKvjsa020982;
	Sun, 20 Jul 2025 20:57:45 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48069v5jx1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 20 Jul 2025 20:57:45 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56KIgIAj024744;
	Sun, 20 Jul 2025 20:57:44 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 480rd22ydj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 20 Jul 2025 20:57:44 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56KKvg9g49283336
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 20 Jul 2025 20:57:42 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AC6E420043;
	Sun, 20 Jul 2025 20:57:42 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D2CB20040;
	Sun, 20 Jul 2025 20:57:40 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.16.241])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 20 Jul 2025 20:57:40 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Jan Kara <jack@suse.cz>, Baokun Li <libaokun1@huawei.com>,
        Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>,
        linux-kernel@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: [RFC v4 2/7] ext4: allow inode preallocation for aligned alloc
Date: Mon, 21 Jul 2025 02:27:28 +0530
Message-ID: <7dd90fa157d865b0352f15ff7cceb167d9d87f17.1753044253.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1753044253.git.ojaswin@linux.ibm.com>
References: <cover.1753044253.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=QLdoRhLL c=1 sm=1 tr=0 ts=687d584a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=8OuK9DH78nEBFM-xf5kA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIwMDE5OCBTYWx0ZWRfXzB4UWaSVEl+G
 PA4t+aJ6EBUEX7kpeDD9ZbJXmOYz3PC6Td+JpQDSNVGmStUkQmfsvkK2CxPk57cDq8Llu3Yuh6V
 ffYg01j+Rv3bHP2u3mQ8u/lsRJFyyJZ9WVU/XS103e58crEZ1sf8JweEeakQb4lOHCNSIXYVy5b
 rJbMJTA70nW+B/naF7nTV9cstV3aPJbC2+rYgtY7Cirukt21q7zcineLqPTy6JOCwBU3627qILi
 NxTMhR1imR/Uauw3kju0PynCQZo1vZJ6MnwMPwa66mQWr8jhfyPQH1/eNxYbKO1UlO5HuOhWeNY
 tERGPrQHK+pfjSCtBW3Swu8TtBYX8oaR1li8J8r3zfFI2OolSFqhfHIxdt42VbQAeClqEXgGpAk
 TP+T7CfOm3LvGulI2NMZ/E9yVAWR77Pw9IiyFE/Jy1ZTA5fc+RKfH069z9E6UEjqZJ/q4FCO
X-Proofpoint-ORIG-GUID: hlmlj8mqjmmu6NtPNnXN6UniW2sacPPl
X-Proofpoint-GUID: CPoxY56B42-anEzAEF5v01MPK1-AwZyy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-20_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 clxscore=1015
 adultscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507200198

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
index d8d9aa717a26..090564b6e6d4 100644
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
 
@@ -3024,8 +3022,7 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 
 		WARN_ON_ONCE(!is_power_of_2(len));
 		WARN_ON_ONCE(start % len);
-		/* We don't support preallocation yet */
-		WARN_ON_ONCE(ac->ac_b_ex.fe_len != ac->ac_o_ex.fe_len);
+		WARN_ON_ONCE(ac->ac_b_ex.fe_len < ac->ac_o_ex.fe_len);
 	}
 
  exit:
@@ -4474,13 +4471,6 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
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
@@ -4537,6 +4527,21 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
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
 
@@ -4787,32 +4792,46 @@ ext4_mb_check_group_pa(ext4_fsblk_t goal_block,
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
@@ -4835,10 +4854,6 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
 	if (!(ac->ac_flags & EXT4_MB_HINT_DATA))
 		return false;
 
-	/* using preallocated blocks is not alignment aware. */
-	if (ac->ac_flags & EXT4_MB_HINT_ALIGNED)
-		return false;
-
 	/*
 	 * first, try per-file preallocation by searching the inode pa rbtree.
 	 *
@@ -4944,7 +4959,7 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
 		goto try_group_pa;
 	}
 
-	if (tmp_pa->pa_free && likely(ext4_mb_pa_goal_check(ac, tmp_pa))) {
+	if (tmp_pa->pa_free && likely(ext4_mb_pa_check(ac, tmp_pa))) {
 		atomic_inc(&tmp_pa->pa_count);
 		ext4_mb_use_inode_pa(ac, tmp_pa);
 		spin_unlock(&tmp_pa->pa_lock);
@@ -4979,6 +4994,19 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
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
@@ -5785,6 +5813,7 @@ static void ext4_mb_group_or_file(struct ext4_allocation_context *ac)
 	int bsbits = ac->ac_sb->s_blocksize_bits;
 	loff_t size, isize;
 	bool inode_pa_eligible, group_pa_eligible;
+	bool is_aligned = (ac->ac_flags & EXT4_MB_HINT_ALIGNED);
 
 	if (!(ac->ac_flags & EXT4_MB_HINT_DATA))
 		return;
@@ -5792,7 +5821,8 @@ static void ext4_mb_group_or_file(struct ext4_allocation_context *ac)
 	if (unlikely(ac->ac_flags & EXT4_MB_HINT_GOAL_ONLY))
 		return;
 
-	group_pa_eligible = sbi->s_mb_group_prealloc > 0;
+	/* Aligned allocation does not support group pa */
+	group_pa_eligible = (!is_aligned && sbi->s_mb_group_prealloc > 0);
 	inode_pa_eligible = true;
 	size = extent_logical_end(sbi, &ac->ac_o_ex);
 	isize = (i_size_read(ac->ac_inode) + ac->ac_sb->s_blocksize - 1)
-- 
2.49.0


