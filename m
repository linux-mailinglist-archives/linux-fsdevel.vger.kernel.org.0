Return-Path: <linux-fsdevel+bounces-29079-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC682974DD1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 11:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D041E1C218EA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 09:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85619181BA8;
	Wed, 11 Sep 2024 09:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ldbJfn3K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6F417CA0A;
	Wed, 11 Sep 2024 09:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726045292; cv=none; b=FlrEnzJ7JYHbx8Eo0wR2CFk4P4UFiXujvoxQbMokwNv7t5VM0wddjd2/5F40F71yOd0HN0PUfcicTO6s1KVG6llesUtd9jQagnq3xUIB3w1dny77VTpbU3kYVyx619mVTk6mX9ApfBRAmyyu58otSDMT5LA+WZqGVfI9odm3eKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726045292; c=relaxed/simple;
	bh=jd8FSTGR4XQgbUPpzzHFefpwftEHIkgBoh1yYwPdIXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lpW3KgiHbi9JpUjpjU47OtDWxOok2vhAm4BRc8kSqs40Xev5jKRxUbo8av5jtz6scf/aifQNONh0IoNhWJkv2jgWHqM0f1QsNv+q326gj6KRBCHtbQ5+gRkCCDW8e/7dMvgM02AdKo5XoT1+dbiQF9863lKmpzMev+0wDIRr9ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ldbJfn3K; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48B7L9ZF008336;
	Wed, 11 Sep 2024 09:01:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=MRdPjSH7Wl1rI
	WISQKQo89B2JKiM+2R/9igZckD2ekw=; b=ldbJfn3KvJZJsqSBL+YY6eEJe08wZ
	qfE1W5LwFgjDelqdkMOArFZEkbLRitj//oe8s3paw+47gMXRZ7KaNS83xcBkbH6H
	osCpF+8oPqJWLN1W/wLYCfaqSR2UfwasXAj8q6MW3f4KxDwapRJX8J5euJUVjePD
	nJ8gvlMCWotPTdl2HTBK/y2Z0X3ojMjMt7x3yrpyXgLdPTI2/J+gWKUS+IM2CnO/
	ERFr9xXtvhBOdsiY4r9zBmTf8x3C38orNr8/K58Gmr3bUcGdYLP6If54g6GEvxyT
	Kky3u/edr7ojfUABxWPY8wgVhgmiW0V3i13f8kdtgM1JiNWSOl2m2GGWQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gd8kmee2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Sep 2024 09:01:17 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48B8vNEH018725;
	Wed, 11 Sep 2024 09:01:17 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gd8kmedv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Sep 2024 09:01:16 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48B7To03019847;
	Wed, 11 Sep 2024 09:01:16 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41h25q0bxf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Sep 2024 09:01:16 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48B91EK345810140
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Sep 2024 09:01:14 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 37E452004D;
	Wed, 11 Sep 2024 09:01:14 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 85A5120049;
	Wed, 11 Sep 2024 09:01:12 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.in.ibm.com (unknown [9.109.253.82])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Sep 2024 09:01:12 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>, dchinner@redhat.com
Subject: [RFC 1/5] ext4: add aligned allocation hint in mballoc
Date: Wed, 11 Sep 2024 14:31:05 +0530
Message-ID: <3a17d8d55c88799a3af9a7d337f183863912e28e.1726034272.git.ojaswin@linux.ibm.com>
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
X-Proofpoint-GUID: th1Mj74_lChmgM2Y_8I6D0XwYtNuPs7g
X-Proofpoint-ORIG-GUID: zQV5Zz-WHZ97A6519km2HUeqhJMxYnl7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-10_12,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409110064

Add support in mballoc for allocating blocks that are aligned
to a certain power-of-2 offset.

1. We define a new flag EXT4_MB_ALIGNED_HINT to indicate that we want
an aligned allocation. This is just a hint, mballoc tries its best to
provide aligned blocks but if it can't then it'll fallback to normal
allocation

2. The alignment is determined by the length of the allocation, for
example if we ask for 8192 bytes, then the alignment of physical blocks
will also be 8192 bytes aligned (ie 2 blocks aligned on 4k blocksize).

3. We dont yet support arbitrary alignment. For aligned writes, the
length/alignment must be power of 2 in blocks, ie for 4k blocksize we
can get 4k byte aligned, 8k byte aligned, 16k byte aligned ...
allocation but not 12k byte aligned.

4. We use CR_POWER2_ALIGNED criteria for aligned allocation which by
design allocates in an aligned manner. Since CR_POWER2_ALIGNED needs the
ac->ac_g_ex.fe_len to be power of 2, thats where the restriction in
point 3 above comes from. Since right now aligned allocation support is
added mainly for atomic writes use case, this restriction should be fine
since atomic write capable devices usually support only power of 2
alignments

5. For ease of review enabling inode preallocation support is done in
upcoming patches and is disabled in this patch.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/ext4.h              |  2 ++
 fs/ext4/mballoc.c           | 60 +++++++++++++++++++++++++++++++++----
 include/trace/events/ext4.h |  1 +
 3 files changed, 58 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 8cc15d00e5c8..17964994a049 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -222,6 +222,8 @@ enum criteria {
 /* Avg fragment size rb tree lookup succeeded at least once for
  * CR_BEST_AVAIL_LEN */
 #define EXT4_MB_CR_BEST_AVAIL_LEN_OPTIMIZED		0x00020000
+/* The allocation must respect alignment requirements for physical blocks */
+#define EXT4_MB_HINT_ALIGNED	      	0x40000
 
 struct ext4_allocation_request {
 	/* target inode for block we're allocating */
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index d73e38323879..724905552f3b 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2177,8 +2177,11 @@ static void ext4_mb_use_best_found(struct ext4_allocation_context *ac,
 	 * user requested originally, we store allocated
 	 * space in a special descriptor.
 	 */
-	if (ac->ac_o_ex.fe_len < ac->ac_b_ex.fe_len)
+	if (ac->ac_o_ex.fe_len < ac->ac_b_ex.fe_len) {
+		/* Aligned allocation doesn't have preallocation support */
+		WARN_ON(ac->ac_flags & EXT4_MB_HINT_ALIGNED);
 		ext4_mb_new_preallocation(ac);
+	}
 
 }
 
@@ -2814,10 +2817,15 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 
 	BUG_ON(ac->ac_status == AC_STATUS_FOUND);
 
-	/* first, try the goal */
-	err = ext4_mb_find_by_goal(ac, &e4b);
-	if (err || ac->ac_status == AC_STATUS_FOUND)
-		goto out;
+	/*
+	 * first, try the goal. Skip trying goal for aligned allocations since
+	 * goal determination logic is not alignment aware (yet)
+	 */
+	if (!(ac->ac_flags & EXT4_MB_HINT_ALIGNED)) {
+		err = ext4_mb_find_by_goal(ac, &e4b);
+		if (err || ac->ac_status == AC_STATUS_FOUND)
+			goto out;
+	}
 
 	if (unlikely(ac->ac_flags & EXT4_MB_HINT_GOAL_ONLY))
 		goto out;
@@ -2858,9 +2866,22 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 	 */
 	if (ac->ac_2order)
 		cr = CR_POWER2_ALIGNED;
+	else
+		WARN_ON_ONCE(ac->ac_g_ex.fe_len > 1 &&
+			     ac->ac_flags & EXT4_MB_HINT_ALIGNED);
 repeat:
 	for (; cr < EXT4_MB_NUM_CRS && ac->ac_status == AC_STATUS_CONTINUE; cr++) {
 		ac->ac_criteria = cr;
+
+		if (ac->ac_criteria > CR_POWER2_ALIGNED &&
+		    ac->ac_flags & EXT4_MB_HINT_ALIGNED &&
+		    ac->ac_g_ex.fe_len > 1) {
+			ext4_warning_inode(
+				ac->ac_inode,
+				"Aligned allocation not possible, using unaligned allocation");
+			ac->ac_flags &= ~EXT4_MB_HINT_ALIGNED;
+		}
+
 		/*
 		 * searching for the right group start
 		 * from the goal value specified
@@ -2993,6 +3014,24 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 	if (!err && ac->ac_status != AC_STATUS_FOUND && first_err)
 		err = first_err;
 
+	if (ac->ac_flags & EXT4_MB_HINT_ALIGNED && ac->ac_status == AC_STATUS_FOUND) {
+		ext4_fsblk_t start = ext4_grp_offs_to_block(sb, &ac->ac_b_ex);
+		ext4_grpblk_t len = EXT4_C2B(sbi, ac->ac_b_ex.fe_len);
+
+		if (!len) {
+			ext4_warning_inode(ac->ac_inode,
+					   "Expected a non zero len extent");
+			ac->ac_status = AC_STATUS_BREAK;
+			goto exit;
+		}
+
+		WARN_ON_ONCE(!is_power_of_2(len));
+		WARN_ON_ONCE(start % len);
+		/* We don't support preallocation yet */
+		WARN_ON_ONCE(ac->ac_b_ex.fe_len != ac->ac_o_ex.fe_len);
+	}
+
+ exit:
 	mb_debug(sb, "Best len %d, origin len %d, ac_status %u, ac_flags 0x%x, cr %d ret %d\n",
 		 ac->ac_b_ex.fe_len, ac->ac_o_ex.fe_len, ac->ac_status,
 		 ac->ac_flags, cr, err);
@@ -4440,6 +4479,13 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
 	if (ac->ac_flags & EXT4_MB_HINT_NOPREALLOC)
 		return;
 
+	/*
+	 * caller may have strict alignment requirements. In this case, avoid
+	 * normalization since it is not alignment aware.
+	 */
+	if (ac->ac_flags & EXT4_MB_HINT_ALIGNED)
+		return;
+
 	if (ac->ac_flags & EXT4_MB_HINT_GROUP_ALLOC) {
 		ext4_mb_normalize_group_request(ac);
 		return ;
@@ -4794,6 +4840,10 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
 	if (!(ac->ac_flags & EXT4_MB_HINT_DATA))
 		return false;
 
+	/* using preallocated blocks is not alignment aware. */
+	if (ac->ac_flags & EXT4_MB_HINT_ALIGNED)
+		return false;
+
 	/*
 	 * first, try per-file preallocation by searching the inode pa rbtree.
 	 *
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index cc5e9b7b2b44..05441f87c5d2 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -36,6 +36,7 @@ struct partial_cluster;
 	{ EXT4_MB_STREAM_ALLOC,		"STREAM_ALLOC" },	\
 	{ EXT4_MB_USE_ROOT_BLOCKS,	"USE_ROOT_BLKS" },	\
 	{ EXT4_MB_USE_RESERVED,		"USE_RESV" },		\
+	{ EXT4_MB_HINT_ALIGNED,		"HINT_ALIGNED" }, \
 	{ EXT4_MB_STRICT_CHECK,		"STRICT_CHECK" })
 
 #define show_map_flags(flags) __print_flags(flags, "|",			\
-- 
2.43.5


