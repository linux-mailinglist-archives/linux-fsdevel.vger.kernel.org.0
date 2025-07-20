Return-Path: <linux-fsdevel+bounces-55541-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0A9B0B83C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Jul 2025 22:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64DEF188F76E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Jul 2025 21:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD3E2376FC;
	Sun, 20 Jul 2025 20:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="M7GZZbJ9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EC722069A;
	Sun, 20 Jul 2025 20:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753045094; cv=none; b=d4/SxThP9yAEsCRgxjyJOQFxHSozMNkkMrjhlxN+F2yHlV5y+010oP2RpQddR072+sIbLQq3YOn6T/ZD3ncFSGtNbINYuflZLEJfRfVW/cG9ld5F1RM3VSbSc+wTZaKkGdq9sJoNqMYWszpCrpG+uhM6glUYtIwYLfO+HYtEbEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753045094; c=relaxed/simple;
	bh=zPlbxH78VXxZ1Fd44pBywx7cXWN+Y9Fz/uLQUm7sreU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OUtY6PcCj3bRTdS/lLEc0Y4OsQ6euhAuE+rSgPz3FPv6c4vUPfaQ9cwgOILBMTBEIyCSA9ZES2B/7wyOG7VmokDhbyJWGBtfO0XdBYS3nlKjJqhGSJpsV4QJ/53lmBEFkhHSfBzkCqHS3epcRY0du9Mr/KvniGIDzBX0UPBLvwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=M7GZZbJ9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56KJjbkq030009;
	Sun, 20 Jul 2025 20:57:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=xx9d5OUwWdIyY+yXB
	JW4VLQQ9V8gvlQn5d5t5pjUOe0=; b=M7GZZbJ9Lg6kJKXitSzPCDVkB/Ep0Qtzu
	i4/KYwDN90Yp1hgoyJ004gFjzj0EyXfSYJsyRWkXzhZGr4ZX6DPKBuku+UZ37TCp
	cDLlTvzgTQahEE9dwceRGDDnUJRCQTY+3/1DhSG7DXFLaPoTBc8LZiyKyfMtaKls
	JtzSNk0ZSouixHs3DwTT0fEvhjfvPsY6B0l5HJgKYOoj4k5xckqqVCjD68lcow2F
	Q9NKIb+Fv8hdzpHPtGXTD68QPvkiJHk0Iv9KYG8nxDTQIkIOzOxIFZeJouGD99FJ
	E4osLsw++q6BBv6QwOfNyRD2jus1e/2cP9XHrvyifdQrueOohx8hQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48069v5kk0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 20 Jul 2025 20:57:57 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56KKvuat026625;
	Sun, 20 Jul 2025 20:57:56 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48069v5kjw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 20 Jul 2025 20:57:56 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56KIiGpo024704;
	Sun, 20 Jul 2025 20:57:55 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 480rd22ydv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 20 Jul 2025 20:57:55 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56KKvr9V10289428
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 20 Jul 2025 20:57:54 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D107C20043;
	Sun, 20 Jul 2025 20:57:53 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 79D6E20040;
	Sun, 20 Jul 2025 20:57:51 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.16.241])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 20 Jul 2025 20:57:51 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Jan Kara <jack@suse.cz>, Baokun Li <libaokun1@huawei.com>,
        Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>,
        linux-kernel@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: [RFC v4 6/7] ext4: make extsize work with EOF allocations
Date: Mon, 21 Jul 2025 02:27:32 +0530
Message-ID: <eb56b39b6315acc8bdaa04ee3a821bda3b9a0b3a.1753044253.git.ojaswin@linux.ibm.com>
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
X-Proofpoint-GUID: oEiUvRUmALhPJFXyH_7BowBpQj3B_cIC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIwMDE5OCBTYWx0ZWRfX+tzFQjeZ1okv
 hjdGPPZJo8srVifuEw1oLFOKRki6yOy2ee6ag6YfG6pw+d2N7qaox7RZp7tAW3AFBsphWTygkbt
 GiAy+le/XUHxWb7zr2Ge6Ku63J6CyGbuaGjo/QpAVzuQ07WIWVKBNS0KppnLNDZSh8apsAYGWaX
 XqX1gAJEuLl0sVKzWnl3yjp9JQHb39GGjpR3QmyjemNMi2NNJIiXmB7/R8pC9NCJ96D2hqdboUp
 CwE3pf3lfoomGJ3qr/MzNOAfXcD+sfPHgXzKInVTEZohq7PtxFk0KkE/Q/ANQ1GJoiLMsA8qPpG
 2xGSC1Vw42CELmyza3KuG/hYDAn2oUz6VWTnKbQToX1L7aFN/E5BNzlU+05DHNq5UdoAKjNk7q5
 Y83W0NKdY+umhnb/FLm7oQBRXZTTBtqSuPZvnzWEzFi1Wgl+r91bXNWuHRwLi1f2i6bWQTep
X-Proofpoint-ORIG-GUID: UL9ftHSosS7Tq5Cr1-Q7UGWSJKENMB8R
X-Authority-Analysis: v=2.4 cv=JJQ7s9Kb c=1 sm=1 tr=0 ts=687d5855 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=pvUrSPAteZZR1bcYYl4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-20_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 impostorscore=0 clxscore=1015 mlxscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507200198

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
index 385fbd745e12..1b60e45a593e 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -861,7 +861,6 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 		 * ext4_extents.h here?
 		 */
 		int max_unwrit_len = ((1UL << 15) - 1);
-		loff_t end;
 
 		align = orig_map->m_lblk % extsize;
 		len = orig_map->m_len + align;
@@ -870,18 +869,6 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
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
@@ -4011,10 +3998,13 @@ static int ext4_iomap_alloc(struct inode *inode, struct ext4_map_blocks *map,
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
2.49.0


