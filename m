Return-Path: <linux-fsdevel+bounces-37018-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE209EC634
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 08:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A4DD1658F3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 07:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14F91DB36B;
	Wed, 11 Dec 2024 07:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Pb8U1qmZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B5E1D89FD;
	Wed, 11 Dec 2024 07:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733903897; cv=none; b=A/GLFnjxgk1EEmktiYmufQTjZw0bJBAwjbfeypv46H0Eu8pRYhODXBVoQ1zf4A5pinvViX9aB2iISeIUTKNB08wPU2iMqdyV3+N4lrca7xjDCxSFDbeokQ/YW6kH/1D1KXjkKbItT2LQodmG8tP2jsukywy5AXNygQdCcqILdYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733903897; c=relaxed/simple;
	bh=x6lR300+v3pYu2909ppa7a7w/98zMfnEokqzVY7l3oM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oFZWmmtNpy2wbxnD3gKnMVGnI+vXN3lRdE4CHIkbHvgbCdpqlbqhh8CnLVqkB/+gt161Ya9styMHI4dDJ8jhOnabcjAJCsBEwtSKQ89KU1pAhbTLOrulmDizzAJBYblpv0v4zn4+PQS2ZD9I3CS7P2rClcYSJi5ePDU9sTO770g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Pb8U1qmZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BB00c8Y007195;
	Wed, 11 Dec 2024 07:58:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=9LObTc9ZuVTH43XFG
	B13SIbNi89VdBVAkTkQAtQ3BPQ=; b=Pb8U1qmZcLsH0zNx6Bphk7dxqrWBJH0JN
	XOYCTlniACbOib0XQ1UEXwyMgWf8qJ4afdjSrYI5seK2sT+ptrsw+P9F/xIXqSe4
	1dQocygggNLXVR34UIBQGPScq1pc+GjDpz9vQRvLbrT/D3E8ss+6z4OqgA+vREX1
	uIwZo4Xk9dM+hITdRgzxdzOgPsqtfw3tfIfhzwW/Kc8X0myL60CNlUZdgJsQOT4T
	eaU+Aaek1OTpgDfHHj1yYSun/YvLhWHzfmR7y8agr/GldVxfN8xTf3hA9zoZJ1nV
	J/QvVk3NDJwOM/qULx6n6grPXj4+hc0oBbfzHismbysxDs3PomLNQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43cdv8uw6x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 07:58:09 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BB7lWnB024091;
	Wed, 11 Dec 2024 07:58:08 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43cdv8uw6t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 07:58:08 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BB5GYUh032754;
	Wed, 11 Dec 2024 07:58:07 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 43d0psgf77-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 07:58:07 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BB7w5oK34865530
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Dec 2024 07:58:06 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD70120043;
	Wed, 11 Dec 2024 07:58:05 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 43AA020040;
	Wed, 11 Dec 2024 07:58:04 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com.com (unknown [9.39.30.217])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Dec 2024 07:58:04 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>, dchinner@redhat.com,
        Nirjhar Roy <nirjhar@linux.ibm.com>
Subject: [RFC v2 4/6] ext4: pass lblk and len explicitly to ext4_split_extent*()
Date: Wed, 11 Dec 2024 13:27:53 +0530
Message-ID: <21b9db7b9978113077056744d26a2b7579af653b.1733901374.git.ojaswin@linux.ibm.com>
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
X-Proofpoint-GUID: xnOTm05UWH6WeAS6AZbp9E9KpqOT3tQe
X-Proofpoint-ORIG-GUID: xr5E1xLvKx2aag3_jiS2OscVqlgoQPsG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0 mlxlogscore=633
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412110056

Since these functions only use the map to determine lblk and len of
the split, pass them explicitly. This is in preparation for making
them work with extent size hints cleanly.

No functional change in this patch.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/extents.c | 57 +++++++++++++++++++++++++----------------------
 1 file changed, 30 insertions(+), 27 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index a07a98a4b97a..4f2dd20d6da5 100644
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


