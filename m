Return-Path: <linux-fsdevel+bounces-29080-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D72ED974DD4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 11:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 032FF1C20401
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 09:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD206183CA6;
	Wed, 11 Sep 2024 09:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NdzsgZSN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9285815381A;
	Wed, 11 Sep 2024 09:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726045292; cv=none; b=HQgFh8QdKYjcj3J2LtxiG3uFgzswi9JgUlZf+Eee2nB/K8Vx1xPHyD+iDYjehlzsneSIbkfyQbmz40rG3chYCMZtnKRhkRtetH6UjEUW8vGm485Y70IKSyQNZoYWUJX29WI+7FuROhsjgCMOTLM+sYj9mUB4gGT75QcXnuMBBaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726045292; c=relaxed/simple;
	bh=yrID4KohIk6xncNm/NMKEFC1LATH0YC8oNkPsYVr6wo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eCi+H0IzHJGHd0mmpcFtiHZV3egMvAbqi4UKtz3UhYzOCwDJv4ypwKFQIWEDX4jnmpFYn0vbPE5ghH1GlHyaw9LFhZeOhZ5PUEiAA07tA3RLkgX3sIAxoVH2/UPAjftS7GVYyb2pjvPL24DzzSYriLkIh4r6+TuMtt5+JkTBNzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NdzsgZSN; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48AJxktr005571;
	Wed, 11 Sep 2024 09:01:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=Zlmur8TQDlUpV
	bfQd7mPaUXRtaFk/VFFlbEreuhKxZM=; b=NdzsgZSNZsKaABIJqs5/dharDIzGu
	CA+1gF+igkePNhhuUk1WE4G7eYH5FS7RH7GnDQlhpVJBb7GBrplkAfLcuLH37yd6
	EarG/GEjuPSOnoXQTtUm8Y0OAowmkd9Z0Gfcg/jhkvFldd43QEP2Infv1ZH00Pdb
	BYSH5g+FV/RCRK3koi0PqjZtRH231W2sRemFxy0v9GnJ412siTS/AlYubb1GurF/
	EpMhDot/qXGqQPwVt5V+lc9f6xksB2ht/A2SRaHpn20HF6yYPf9cg7CPRHJ5Ra8X
	Zs2X5yIg9YUyqRaLBwyUOvOTFDhLXRof8sVVsLTRniElillBquPaOw2ZQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gd8kmef2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Sep 2024 09:01:23 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48B91NlZ029094;
	Wed, 11 Sep 2024 09:01:23 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gd8kmeeu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Sep 2024 09:01:23 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48B7CZml019843;
	Wed, 11 Sep 2024 09:01:22 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41h25q0by2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Sep 2024 09:01:22 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48B91KXN52363670
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Sep 2024 09:01:20 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4519120040;
	Wed, 11 Sep 2024 09:01:20 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 941312004D;
	Wed, 11 Sep 2024 09:01:18 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.in.ibm.com (unknown [9.109.253.82])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Sep 2024 09:01:18 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>, dchinner@redhat.com
Subject: [RFC 4/5] ext4: pass lblk and len explicitly to ext4_split_extent*()
Date: Wed, 11 Sep 2024 14:31:08 +0530
Message-ID: <35d703d739deafcdd8e57328de0830aecd0bf2e9.1726034272.git.ojaswin@linux.ibm.com>
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
X-Proofpoint-GUID: 5S70imQ3r5t2bIH10SBo5CDtBZWqV4fn
X-Proofpoint-ORIG-GUID: 4LQc49d_ts3Tozl_qf6CHCdas8lssgye
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-10_12,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 mlxscore=0 mlxlogscore=638 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409110064

Since these functions only use the map to determine lblk and len of
the split, pass them explicitly. This is in preparation for making
them work with extent size hints cleanly.

No functional change in this patch.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/extents.c | 57 +++++++++++++++++++++++++----------------------
 1 file changed, 30 insertions(+), 27 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 34e25eee6521..94aeb5b47971 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3347,7 +3347,8 @@ static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
 static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
 					       struct inode *inode,
 					       struct ext4_ext_path *path,
-					       struct ext4_map_blocks *map,
+					       ext4_lblk_t lblk,
+					       unsigned int len,
 					       int split_flag, int flags,
 					       unsigned int *allocated)
 {
@@ -3363,7 +3364,7 @@ static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
 	ee_len = ext4_ext_get_actual_len(ex);
 	unwritten = ext4_ext_is_unwritten(ex);
 
-	if (map->m_lblk + map->m_len < ee_block + ee_len) {
+	if (lblk + len < ee_block + ee_len) {
 		split_flag1 = split_flag & EXT4_EXT_MAY_ZEROOUT;
 		flags1 = flags | EXT4_GET_BLOCKS_PRE_IO;
 		if (unwritten)
@@ -3372,28 +3373,28 @@ static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
 		if (split_flag & EXT4_EXT_DATA_VALID2)
 			split_flag1 |= EXT4_EXT_DATA_VALID1;
 		path = ext4_split_extent_at(handle, inode, path,
-				map->m_lblk + map->m_len, split_flag1, flags1);
+				lblk + len, split_flag1, flags1);
 		if (IS_ERR(path))
 			return path;
 		/*
 		 * Update path is required because previous ext4_split_extent_at
 		 * may result in split of original leaf or extent zeroout.
 		 */
-		path = ext4_find_extent(inode, map->m_lblk, path, flags);
+		path = ext4_find_extent(inode, lblk, path, flags);
 		if (IS_ERR(path))
 			return path;
 		depth = ext_depth(inode);
 		ex = path[depth].p_ext;
 		if (!ex) {
 			EXT4_ERROR_INODE(inode, "unexpected hole at %lu",
-					(unsigned long) map->m_lblk);
+					(unsigned long) lblk);
 			ext4_free_ext_path(path);
 			return ERR_PTR(-EFSCORRUPTED);
 		}
 		unwritten = ext4_ext_is_unwritten(ex);
 	}
 
-	if (map->m_lblk >= ee_block) {
+	if (lblk >= ee_block) {
 		split_flag1 = split_flag & EXT4_EXT_DATA_VALID2;
 		if (unwritten) {
 			split_flag1 |= EXT4_EXT_MARK_UNWRIT1;
@@ -3401,16 +3402,16 @@ static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
 						     EXT4_EXT_MARK_UNWRIT2);
 		}
 		path = ext4_split_extent_at(handle, inode, path,
-				map->m_lblk, split_flag1, flags);
+				lblk, split_flag1, flags);
 		if (IS_ERR(path))
 			return path;
 	}
 
 	if (allocated) {
-		if (map->m_lblk + map->m_len > ee_block + ee_len)
-			*allocated = ee_len - (map->m_lblk - ee_block);
+		if (lblk + len > ee_block + ee_len)
+			*allocated = ee_len - (lblk - ee_block);
 		else
-			*allocated = map->m_len;
+			*allocated = len;
 	}
 	ext4_ext_show_leaf(inode, path);
 	return path;
@@ -3658,8 +3659,8 @@ ext4_ext_convert_to_initialized(handle_t *handle, struct inode *inode,
 	}
 
 fallback:
-	path = ext4_split_extent(handle, inode, path, &split_map, split_flag,
-				 flags, NULL);
+	path = ext4_split_extent(handle, inode, path, split_map.m_lblk,
+				 split_map.m_len, split_flag, flags, NULL);
 	if (IS_ERR(path))
 		return path;
 out:
@@ -3699,11 +3700,11 @@ ext4_ext_convert_to_initialized(handle_t *handle, struct inode *inode,
  * allocated pointer. Return an extent path pointer on success, or an error
  * pointer on failure.
  */
-static struct ext4_ext_path *ext4_split_convert_extents(handle_t *handle,
-					struct inode *inode,
-					struct ext4_map_blocks *map,
-					struct ext4_ext_path *path,
-					int flags, unsigned int *allocated)
+static struct ext4_ext_path *
+ext4_split_convert_extents(handle_t *handle, struct inode *inode,
+			   ext4_lblk_t lblk, unsigned int len,
+			   struct ext4_ext_path *path, int flags,
+			   unsigned int *allocated)
 {
 	ext4_lblk_t eof_block;
 	ext4_lblk_t ee_block;
@@ -3712,12 +3713,12 @@ static struct ext4_ext_path *ext4_split_convert_extents(handle_t *handle,
 	int split_flag = 0, depth;
 
 	ext_debug(inode, "logical block %llu, max_blocks %u\n",
-		  (unsigned long long)map->m_lblk, map->m_len);
+		  (unsigned long long)lblk, len);
 
 	eof_block = (EXT4_I(inode)->i_disksize + inode->i_sb->s_blocksize - 1)
 			>> inode->i_sb->s_blocksize_bits;
-	if (eof_block < map->m_lblk + map->m_len)
-		eof_block = map->m_lblk + map->m_len;
+	if (eof_block < lblk + len)
+		eof_block = lblk + len;
 	/*
 	 * It is safe to convert extent to initialized via explicit
 	 * zeroout only if extent is fully inside i_size or new_size.
@@ -3737,8 +3738,8 @@ static struct ext4_ext_path *ext4_split_convert_extents(handle_t *handle,
 		split_flag |= (EXT4_EXT_MARK_UNWRIT2 | EXT4_EXT_DATA_VALID2);
 	}
 	flags |= EXT4_GET_BLOCKS_PRE_IO;
-	return ext4_split_extent(handle, inode, path, map, split_flag, flags,
-				 allocated);
+	return ext4_split_extent(handle, inode, path, lblk, len, split_flag,
+				 flags, allocated);
 }
 
 static struct ext4_ext_path *
@@ -3773,7 +3774,7 @@ ext4_convert_unwritten_extents_endio(handle_t *handle, struct inode *inode,
 			     inode->i_ino, (unsigned long long)ee_block, ee_len,
 			     (unsigned long long)map->m_lblk, map->m_len);
 #endif
-		path = ext4_split_convert_extents(handle, inode, map, path,
+		path = ext4_split_convert_extents(handle, inode, map->m_lblk, map->m_len, path,
 						EXT4_GET_BLOCKS_CONVERT, NULL);
 		if (IS_ERR(path))
 			return path;
@@ -3837,8 +3838,9 @@ convert_initialized_extent(handle_t *handle, struct inode *inode,
 		  (unsigned long long)ee_block, ee_len);
 
 	if (ee_block != map->m_lblk || ee_len > map->m_len) {
-		path = ext4_split_convert_extents(handle, inode, map, path,
-				EXT4_GET_BLOCKS_CONVERT_UNWRITTEN, NULL);
+		path = ext4_split_convert_extents(
+			handle, inode, map->m_lblk, map->m_len, path,
+			EXT4_GET_BLOCKS_CONVERT_UNWRITTEN, NULL);
 		if (IS_ERR(path))
 			return path;
 
@@ -3909,8 +3911,9 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
 
 	/* get_block() before submitting IO, split the extent */
 	if (flags & EXT4_GET_BLOCKS_PRE_IO) {
-		path = ext4_split_convert_extents(handle, inode, map, path,
-				flags | EXT4_GET_BLOCKS_CONVERT, allocated);
+		path = ext4_split_convert_extents(
+			handle, inode, map->m_lblk, map->m_len, path,
+			flags | EXT4_GET_BLOCKS_CONVERT, allocated);
 		if (IS_ERR(path))
 			return path;
 		/*
-- 
2.43.5


