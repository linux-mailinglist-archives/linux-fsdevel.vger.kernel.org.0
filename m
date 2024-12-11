Return-Path: <linux-fsdevel+bounces-37021-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 731F49EC63F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 08:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 007DD28546F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 07:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913821E9B32;
	Wed, 11 Dec 2024 07:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hfa9xS2W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677611D0E28;
	Wed, 11 Dec 2024 07:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733903905; cv=none; b=tZ2rvxH1z8du6kHhGnct5JVlxJe9gl5kQLjW4gSEO8LLumMIQTXMIQ211xuuRv+B8i/HYfZTKzs26OESPYbuC3d25g4VsMQ4jlbnlR/xG+QJvMiW/znBog8PWDojOaU0lAHGJ96T5nZI5upZ90fH64B/bnh79lDc2P4j+/28NXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733903905; c=relaxed/simple;
	bh=tMpv5LeOHSfLNp3qLGN7hTotuOB8L59eDUlqDg/ma1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ArnbxUoib3RQvPacjbw1BoyXmAMdNGvUhvvR5rHjP69xxUtsFeF+bXNNW0Cwd2VMWtso3oXouGMSEZiQA2NTPzkzmlge9AFy2eYp/D0GnqKOokOZub7zVXwdoMQt581uvEsSMhlXKTT1N04Q118wwyq59r/OSkRRdwnJOgOh5Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hfa9xS2W; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BB1SJLP025987;
	Wed, 11 Dec 2024 07:58:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=4qMIY5BJghurRRbbx
	ix/ChndzugGNuMDrQpQehDbW88=; b=hfa9xS2WGCf2FD36hdCE5gxOlCGugJXNe
	7teJ3Vs7EDE6Io3vXmK4e+MTQGVXVQN1wYwlrBJqVSi31ymizvxDERsoeTKi36ep
	5vR/L+js7Cmk/M976XWEgMO22qmnpTgUmMD6WdEE5FPQCrHeqsPEit5QWBveZMFc
	Qx7734mDSYQlhU0etmtnAkO8ErApNcRPUdhGKoyFRsgr4u88tsn3USp10eXq0Wif
	hf3cjAmbj441621f8XztNJxYA9qJlB3yZeWtVFqUb5dgVvHS1t4W4pZerbwAzBir
	ZO935FHrzfzvFm5XO/cF4xa9rvNTqBWKzpQM+jzJxW9UGL3ggxkgA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43cbsqb3yp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 07:58:14 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BB7sHo6002061;
	Wed, 11 Dec 2024 07:58:13 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43cbsqb3yn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 07:58:13 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BB5kEJs032739;
	Wed, 11 Dec 2024 07:58:12 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 43d0psgf7d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 07:58:12 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BB7wBqR64422356
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Dec 2024 07:58:11 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1209F20043;
	Wed, 11 Dec 2024 07:58:11 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5256920040;
	Wed, 11 Dec 2024 07:58:09 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com.com (unknown [9.39.30.217])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Dec 2024 07:58:09 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>, dchinner@redhat.com,
        Nirjhar Roy <nirjhar@linux.ibm.com>
Subject: [RFC v2 6/6] ext4: make extsize work with EOF allocations
Date: Wed, 11 Dec 2024 13:27:55 +0530
Message-ID: <57264a45aabcf8d789278e09da5db297d2e6b192.1733901374.git.ojaswin@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: bckmckhFq7qMo8N5MAMiIA3mggTcN_lC
X-Proofpoint-GUID: lPj7xrGTsT-2TUMthEIgt0gxaPnwaFKK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0
 suspectscore=0 spamscore=0 mlxscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412110056

Make extsize hints work with EOF allocations. We deviate from XFS here
because in case we have blocks left past EOF, we don't truncate them.
There are 2 main reasons:

1. Since the user is opting for extsize allocations, chances are
that they will use the blocks in future.

2. If we start truncating all EOF blocks in ext4_release_file like
XFS, then we will have to always truncate blocks even if they
have been intentionally preallocated using fallocate w/ KEEP_SIZE
which might cause confusion for users. This is mainly because
ext4 doesn't have a way to distinguish if the blocks beyond EOF
have been allocated intentionally. We can work around this by
using an ondisk inode flag like XFS (XFS_DIFLAG_PREALLOC) but
that would be an overkill. It's much simpler to just let the EOF
blocks stick around.

NOTE:
One thing that changes in this patch is that for direct IO we need to
pass the EXT4_GET_BLOCKS_IO_CREATE_EXT even if we are allocating beyond
i_size.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/inode.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index d511282ebdcc..d292e39a050a 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -756,7 +756,6 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 		 * ext4_extents.h here?
 		 */
 		int max_unwrit_len = ((1UL << 15) - 1);
-		loff_t end;
 
 		align = orig_map->m_lblk % extsize;
 		len = orig_map->m_len + align;
@@ -765,18 +764,6 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 		extsize_map.m_len =
 			max_t(unsigned int, roundup_pow_of_two(len), extsize);
 
-		/*
-		 * For now allocations beyond EOF don't use extsize hints so
-		 * that we can avoid dealing with extra blocks allocated past
-		 * EOF. We have inode lock since extsize allocations are
-		 * non-delalloc so i_size can be accessed safely
-		 */
-		end = (extsize_map.m_lblk + (loff_t)extsize_map.m_len) << inode->i_blkbits;
-		if (end > inode->i_size) {
-			flags = orig_flags & ~EXT4_GET_BLOCKS_EXTSIZE;
-			goto set_map;
-		}
-
 		/* Fallback to normal allocation if we go beyond max len */
 		if (extsize_map.m_len >= max_unwrit_len) {
 			flags = orig_flags & ~EXT4_GET_BLOCKS_EXTSIZE;
@@ -3641,10 +3628,13 @@ static int ext4_iomap_alloc(struct inode *inode, struct ext4_map_blocks *map,
 	 * i_disksize out to i_size. This could be beyond where direct I/O is
 	 * happening and thus expose allocated blocks to direct I/O reads.
 	 *
-	 * NOTE for extsize hints: We only support it for writes inside
-	 * EOF (for now) to not have to deal with blocks past EOF
+	 * NOTE: For extsize hint based EOF allocations, we still need
+	 * IO_CREATE_EXT flag because we will be allocating more than the write
+	 * hence the extra blocks need to be marked unwritten and split before
+	 * the I/O.
 	 */
-	else if (((loff_t)map->m_lblk << blkbits) >= i_size_read(inode))
+	else if (((loff_t)map->m_lblk << blkbits) >= i_size_read(inode) &&
+		 !ext4_should_use_extsize(inode))
 		m_flags = EXT4_GET_BLOCKS_CREATE;
 	else if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)) {
 		m_flags = EXT4_GET_BLOCKS_IO_CREATE_EXT;
-- 
2.43.5


