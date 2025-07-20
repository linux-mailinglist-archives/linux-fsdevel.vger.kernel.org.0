Return-Path: <linux-fsdevel+bounces-55538-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C2DB0B835
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Jul 2025 22:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89CE27AC91A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Jul 2025 20:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4AD522AE75;
	Sun, 20 Jul 2025 20:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VPatiRD2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86D622172E;
	Sun, 20 Jul 2025 20:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753045082; cv=none; b=ufRh0xQlWRz23l0jHn/XtT1oJdj1ltzUASaYUHU+LA6WF8A1PNROBjwhH2ilowqXZhfdA9uBPhk6tRfpRJRgtfFxiAd0KDVqD+AWnyABMtZS9rQlvKG85N4/PyYwSfMNze12ygJPMK+N4rr3ci4MKn8f+gw/2tgR35O/HB9PrNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753045082; c=relaxed/simple;
	bh=p6G53arM7YG3hIRsBRZW8bPJMmm7gC+E1ntAdgOXjh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FMEi0ZS+t1zmwuKu6L3qtyWhRWE/FDxwGOIKz0hVATeJtKoTaw2OL9Jqo8TvomSNLap2lPlfEMcls4GN6F2XfkgmN0STorkxFvs+aL3fjZ34rA3gcjacQVtkgmNZOh3KVsQQUnJwWsp31QX3Z8EQOTVpO7ubdVWZqGZt2wiD0tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VPatiRD2; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56KKkZMp022328;
	Sun, 20 Jul 2025 20:57:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=VAXeE+DPl5hNUGTS9
	pA4mkC+e93Ylfvof8V5MeNC4K8=; b=VPatiRD2PZyjTA5L7qvchlAK4tzGmtD00
	/Fp3IzAE7K/qWA5NZdvZgOOsPkJWBxzjZk+KIyLMgtEoauN1Eex3ylVlcsy4pvDZ
	iM6UISwJN2vwmku9B+5OYbJkFnrPb+SOceGDZ/BU9xUgoD4TzvIFFXKH74SkPk5E
	xz4AlWGJ4xbke4s6V835YX03kzMG3s/QGKamP7RvP0wcR1LcvxxJ1WVKGcPJLn/s
	zkk2dDwxJVSKbpxnW1j3zTqN8zmgBg5q8td96zePuyOoqThc4856IDp4RH6lxzVj
	buy4ofI3h3nq80w5PFqig5lMeYIELJYXTHA5sbs5ojilAZ7ovJPaQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4805uswmyt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 20 Jul 2025 20:57:51 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56KKvooj010106;
	Sun, 20 Jul 2025 20:57:50 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4805uswmyr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 20 Jul 2025 20:57:50 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56KITBAf024766;
	Sun, 20 Jul 2025 20:57:49 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 480rd22ydn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 20 Jul 2025 20:57:49 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56KKvmbN50069992
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 20 Jul 2025 20:57:48 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E74020043;
	Sun, 20 Jul 2025 20:57:48 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BACAC20040;
	Sun, 20 Jul 2025 20:57:45 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.16.241])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 20 Jul 2025 20:57:45 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Jan Kara <jack@suse.cz>, Baokun Li <libaokun1@huawei.com>,
        Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>,
        linux-kernel@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: [RFC v4 4/7] ext4: pass lblk and len explicitly to ext4_split_extent*()
Date: Mon, 21 Jul 2025 02:27:30 +0530
Message-ID: <a8a06d4bc1fa9a32b29cdaa4c60536b97d52f750.1753044253.git.ojaswin@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIwMDE5OCBTYWx0ZWRfX9qvckIOmhc4u
 kdDY6+wGYgSK4mDun3k8y39NsS0JBVXQq1+xvGHWM0+7rAk2Fw6YBCvAGLLq6loMKejOgquRjZm
 gkqWAtpmK2gxg92sZS/kc2TMVIexqFjU+F039r3kUhEqiwoMCopWxBxbHr88IP2kqAOuuUjlksA
 QHOmVnqPzWYckoUG7gD78gmgShQfKe/lLiFGcj6gos6sx2olKpJCDp01Utak5f8TIHM4iLhrq9v
 1HJJVkdmvSDQtH2mSa36+IbmFU8Qpy0P4JbQHz0AK/+dpJF4PZpUM/zeRnd4VFi6fScty/DceFD
 9CPjDYzDCAOn/SjcyGUTlKyNLeUn/zEZJS8qDsfTw7oN2M6RUr4GfEc5KoXDU9WhuvaTnxw8i+c
 tANbMFJO5bhlqt8MRx6MMQ9V+XE9a+/JNvrFcYGEexbBSkHAgzbrz2RosEAwoPbWddH+gHC7
X-Authority-Analysis: v=2.4 cv=Nd/m13D4 c=1 sm=1 tr=0 ts=687d584f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=Jo52ochBzWdcE45m7K4A:9
X-Proofpoint-ORIG-GUID: eY6voXG8wW-altNbdKSiSwXrSxzo4Ru0
X-Proofpoint-GUID: Jp1Mxt9QKFBtO6YC35X4XFNJvXwtgKGO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-20_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 mlxlogscore=536 malwarescore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 impostorscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507200198

Since these functions only use the map to determine lblk and len of
the split, pass them explicitly. This is in preparation for making
them work with extent size hints cleanly.

No functional change in this patch.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/extents.c | 57 +++++++++++++++++++++++++----------------------
 1 file changed, 30 insertions(+), 27 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index f0f155458697..3233ab89c99e 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3350,7 +3350,8 @@ static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
 static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
 					       struct inode *inode,
 					       struct ext4_ext_path *path,
-					       struct ext4_map_blocks *map,
+					       ext4_lblk_t lblk,
+					       unsigned int len,
 					       int split_flag, int flags,
 					       unsigned int *allocated)
 {
@@ -3366,7 +3367,7 @@ static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
 	ee_len = ext4_ext_get_actual_len(ex);
 	unwritten = ext4_ext_is_unwritten(ex);
 
-	if (map->m_lblk + map->m_len < ee_block + ee_len) {
+	if (lblk + len < ee_block + ee_len) {
 		split_flag1 = split_flag & EXT4_EXT_MAY_ZEROOUT;
 		flags1 = flags | EXT4_GET_BLOCKS_PRE_IO;
 		if (unwritten)
@@ -3375,28 +3376,28 @@ static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
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
@@ -3404,16 +3405,16 @@ static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
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
@@ -3661,8 +3662,8 @@ ext4_ext_convert_to_initialized(handle_t *handle, struct inode *inode,
 	}
 
 fallback:
-	path = ext4_split_extent(handle, inode, path, &split_map, split_flag,
-				 flags, NULL);
+	path = ext4_split_extent(handle, inode, path, split_map.m_lblk,
+				 split_map.m_len, split_flag, flags, NULL);
 	if (IS_ERR(path))
 		return path;
 out:
@@ -3702,11 +3703,11 @@ ext4_ext_convert_to_initialized(handle_t *handle, struct inode *inode,
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
@@ -3715,12 +3716,12 @@ static struct ext4_ext_path *ext4_split_convert_extents(handle_t *handle,
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
@@ -3740,8 +3741,8 @@ static struct ext4_ext_path *ext4_split_convert_extents(handle_t *handle,
 		split_flag |= (EXT4_EXT_MARK_UNWRIT2 | EXT4_EXT_DATA_VALID2);
 	}
 	flags |= EXT4_GET_BLOCKS_PRE_IO;
-	return ext4_split_extent(handle, inode, path, map, split_flag, flags,
-				 allocated);
+	return ext4_split_extent(handle, inode, path, lblk, len, split_flag,
+				 flags, allocated);
 }
 
 static struct ext4_ext_path *
@@ -3776,7 +3777,7 @@ ext4_convert_unwritten_extents_endio(handle_t *handle, struct inode *inode,
 			     inode->i_ino, (unsigned long long)ee_block, ee_len,
 			     (unsigned long long)map->m_lblk, map->m_len);
 #endif
-		path = ext4_split_convert_extents(handle, inode, map, path,
+		path = ext4_split_convert_extents(handle, inode, map->m_lblk, map->m_len, path,
 						EXT4_GET_BLOCKS_CONVERT, NULL);
 		if (IS_ERR(path))
 			return path;
@@ -3840,8 +3841,9 @@ convert_initialized_extent(handle_t *handle, struct inode *inode,
 		  (unsigned long long)ee_block, ee_len);
 
 	if (ee_block != map->m_lblk || ee_len > map->m_len) {
-		path = ext4_split_convert_extents(handle, inode, map, path,
-				EXT4_GET_BLOCKS_CONVERT_UNWRITTEN, NULL);
+		path = ext4_split_convert_extents(
+			handle, inode, map->m_lblk, map->m_len, path,
+			EXT4_GET_BLOCKS_CONVERT_UNWRITTEN, NULL);
 		if (IS_ERR(path))
 			return path;
 
@@ -3912,8 +3914,9 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
 
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
2.49.0


