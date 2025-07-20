Return-Path: <linux-fsdevel+bounces-55539-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0DAB0B837
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Jul 2025 22:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C35E97A1DB0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Jul 2025 20:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A248922F765;
	Sun, 20 Jul 2025 20:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cwI6nu0X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3642264A8;
	Sun, 20 Jul 2025 20:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753045083; cv=none; b=CAl6Y4gQsZmH4UnpP7mMA0Dgbrft/zBDqEejO3sK7j6WfhjsMpH70Fs26kZlZBr8JJGAcmsK8IVm0OqyQYZ41froR6jOBMpOpsdB2kW44Jc3KCA4QNs/hWD0rCurgX+S4eKYxjcjc+oanHF+87PE8bzFAbYPYAqtjRSDDoBiLMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753045083; c=relaxed/simple;
	bh=l6qAOXqpnKLpYhgY71vabipzsUrvP5AJE5tAAR22fDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cJwOm0ewb7zzgPk7pvbyYYXqH9nlSOBqAF0yH5xNYi3Z28dSvLmOi/A0k1kdfF0l9nM/axLp1tC28GcrIzfES6j4NbmbMorEUEi0hvNze2Lar24lR8YT7oUktvB7j46i5GzrEiBYDKdA1UkGthjXqBz3t47N2T5xMio4iWiNKP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cwI6nu0X; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56KJrJnS003936;
	Sun, 20 Jul 2025 20:57:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=e9pbuHs1AKFmacSJP
	n9zsMkCsmz6wbHkOEKNdeI2sBk=; b=cwI6nu0Xu4znxc1DzOtfJ7vV6HncUknbm
	sGhMdqQFUzxRzzx5lEG6ao64Yqr2REguqH4w/ZqlObvj8CNPusEuF1zkOQDWYxU3
	cJvd1vE0xkS9hjAH5O4Ux2GFIwky60exwwdGe07Glv/nPn7VQ2QKOxo68SPdQ1U8
	Px3nCk9mINFUHei9bKX7dGU6CFeAveerHYRyzYIXlLaEDbapl+gfWEX3O2QPv+r4
	WufR5NjioF4B3y2zyAWWLwPewJR7esC2J7VFYWVk1lYXhKFpdlPZ3MiHfLlRnOF3
	JXJHheBrUkTWgAYzLlUcsBaf9bV25ovvKJRUKLnqsiaAPYtt1Igug==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48069v5jx0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 20 Jul 2025 20:57:43 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56KKtY7J016970;
	Sun, 20 Jul 2025 20:57:43 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48069v5jww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 20 Jul 2025 20:57:43 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56KGklKJ012462;
	Sun, 20 Jul 2025 20:57:41 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 480p2yubbb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 20 Jul 2025 20:57:41 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56KKvdsE38338906
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 20 Jul 2025 20:57:40 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E3B2A20040;
	Sun, 20 Jul 2025 20:57:39 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8BE1820043;
	Sun, 20 Jul 2025 20:57:37 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.16.241])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 20 Jul 2025 20:57:37 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Jan Kara <jack@suse.cz>, Baokun Li <libaokun1@huawei.com>,
        Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>,
        linux-kernel@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: [RFC v4 1/7] ext4: add aligned allocation hint in mballoc
Date: Mon, 21 Jul 2025 02:27:27 +0530
Message-ID: <6f38c1940a938c1b3b1f3a4980fb90f407715947.1753044253.git.ojaswin@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=QLdoRhLL c=1 sm=1 tr=0 ts=687d5847 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=jvNEtpLD9h76yb2HC5gA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIwMDE5OCBTYWx0ZWRfXwy3sU649GlLx
 vYDy1bMrXKyJIAVHW0cvnMAvdtThE0ZRPmsJiCVn9MbPIbxcvHhYzcOVaV0QXVlHEpIHpvaK9OL
 1r92E3WBYb6nf+zh2O8AGiOntcB/VZgcFpMD781phhczBfJ2hyjZ6N6zfqO+XdRAVSCyWwNWYNJ
 8hrqpjaoZf9E13/m3EBbz7eU6hFdryIjyDdV/zmCY5ecap10gPWF44ewdd7+Ar3RRSgaEHWcV8b
 dEdH3cy7UBHReCiwH9UUXzzUmJTUUxTeGmqMLWi6NXrjvmes8+vhwkVpeC1JCT+91PFU70hatwV
 S0zRDx0c2pS8OBiS7mIb20U0xABUJZg8n1FRPTy6ufiJcs9oZLM2rUXIxPhWNPtetFo5B7SXeRa
 akGsEyTJYR0co9OxkY0PmW48achL8AFqia/I2bxEm+8GlcCLZWCm92auaIX6Inwqf2r4MMkE
X-Proofpoint-ORIG-GUID: EDWNzMp19NucH062MjYLsQOqHDWL7CaI
X-Proofpoint-GUID: 1PL90zwc4rNdUwhCISN5z-w8ak7ai2UN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-20_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 clxscore=1011
 adultscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507200198

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
 fs/ext4/mballoc.c           | 57 +++++++++++++++++++++++++++++++++----
 include/trace/events/ext4.h |  1 +
 3 files changed, 55 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 9ac0a7d4fa0c..7b353d1af580 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -222,6 +222,8 @@ enum criteria {
 /* Avg fragment size rb tree lookup succeeded at least once for
  * CR_BEST_AVAIL_LEN */
 #define EXT4_MB_CR_BEST_AVAIL_LEN_OPTIMIZED		0x00020000
+/* mballoc will try to align physical start to length (aka natural alignment) */
+#define EXT4_MB_HINT_ALIGNED		0x40000
 
 struct ext4_allocation_request {
 	/* target inode for block we're allocating */
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 1e98c5be4e0a..d8d9aa717a26 100644
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
@@ -2861,6 +2869,16 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
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
@@ -2993,6 +3011,24 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
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
@@ -4438,6 +4474,13 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
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
@@ -4792,6 +4835,10 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
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
index 845451077c41..d5cec574984c 100644
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
2.49.0


