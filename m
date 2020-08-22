Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0B0424E715
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Aug 2020 13:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbgHVLfB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Aug 2020 07:35:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:62566 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727113AbgHVLe7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Aug 2020 07:34:59 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07MBXZBH142775;
        Sat, 22 Aug 2020 07:34:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=sBSrCREw7iV6UUm6KKETVDl0mwpxm3K7fbLURRyVoak=;
 b=VKtE2fyatc/RLvKLO7oTuCkUsU90QeLxvF6mFkHmuhk3tyL1UkdK63+EjKiSYmLSep5N
 dr6Z162gLOxbS0vbscV4R8S4XXqnb+LOZwEp9NC4+NORzW+EUx41ycQfF/PjJAkDuBiy
 lPOA/i7ejOgsNf4G9zU8DYqyi3HuleDYPfn1C4hTnpyKaxmxX4+QAzU2ArUD0XEFdGYB
 BQ7ZN9U/u5yQVlu16n84/scCVCTcddltSrKvqZ7oRfq700Bh7IdIXs3qcmttw30GnGKK
 lz2sltPZ+/Qo2Jz+axXxNdQZAW+W+yBlTe8MCsybGiLK0fiCg3Rksm+wWqySeUM/Q37i Mw== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 332x6gc4c0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 22 Aug 2020 07:34:51 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07MBXfpt021892;
        Sat, 22 Aug 2020 11:34:49 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 332utsrar9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 22 Aug 2020 11:34:49 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07MBYl6O27787744
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Aug 2020 11:34:47 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 13F3952052;
        Sat, 22 Aug 2020 11:34:47 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.199.33.217])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id A35E75204E;
        Sat, 22 Aug 2020 11:34:45 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     jack@suse.cz, tytso@mit.edu,
        Dan Williams <dan.j.williams@intel.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv2 1/3] ext4: Refactor ext4_overwrite_io() to take ext4_map_blocks as argument
Date:   Sat, 22 Aug 2020 17:04:35 +0530
Message-Id: <057a08972f818c035621a9fd3ff870bedcdf5e83.1598094830.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <cover.1598094830.git.riteshh@linux.ibm.com>
References: <cover.1598094830.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-22_07:2020-08-21,2020-08-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=834
 clxscore=1015 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 impostorscore=0 suspectscore=1 spamscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008220125
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Refactor ext4_overwrite_io() to take struct ext4_map_blocks
as it's function argument with m_lblk and m_len filled
from caller

There should be no functionality change in this patch.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/file.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 2a01e31a032c..84f73ed91af2 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -188,26 +188,22 @@ ext4_extending_io(struct inode *inode, loff_t offset, size_t len)
 }
 
 /* Is IO overwriting allocated and initialized blocks? */
-static bool ext4_overwrite_io(struct inode *inode, loff_t pos, loff_t len)
+static bool ext4_overwrite_io(struct inode *inode, struct ext4_map_blocks *map)
 {
-	struct ext4_map_blocks map;
 	unsigned int blkbits = inode->i_blkbits;
-	int err, blklen;
+	loff_t end = (map->m_lblk + map->m_len) << blkbits;
+	int err, blklen = map->m_len;
 
-	if (pos + len > i_size_read(inode))
+	if (end > i_size_read(inode))
 		return false;
 
-	map.m_lblk = pos >> blkbits;
-	map.m_len = EXT4_MAX_BLOCKS(len, pos, blkbits);
-	blklen = map.m_len;
-
-	err = ext4_map_blocks(NULL, inode, &map, 0);
+	err = ext4_map_blocks(NULL, inode, map, 0);
 	/*
 	 * 'err==len' means that all of the blocks have been preallocated,
 	 * regardless of whether they have been initialized or not. To exclude
 	 * unwritten extents, we need to check m_flags.
 	 */
-	return err == blklen && (map.m_flags & EXT4_MAP_MAPPED);
+	return err == blklen && (map->m_flags & EXT4_MAP_MAPPED);
 }
 
 static ssize_t ext4_generic_write_checks(struct kiocb *iocb,
@@ -407,6 +403,7 @@ static ssize_t ext4_dio_write_checks(struct kiocb *iocb, struct iov_iter *from,
 {
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file_inode(file);
+	struct ext4_map_blocks map;
 	loff_t offset;
 	size_t count;
 	ssize_t ret;
@@ -420,6 +417,9 @@ static ssize_t ext4_dio_write_checks(struct kiocb *iocb, struct iov_iter *from,
 	count = ret;
 	if (ext4_extending_io(inode, offset, count))
 		*extend = true;
+
+	map.m_lblk = offset >> inode->i_blkbits;
+	map.m_len = EXT4_MAX_BLOCKS(count, offset, inode->i_blkbits);
 	/*
 	 * Determine whether the IO operation will overwrite allocated
 	 * and initialized blocks.
@@ -427,7 +427,7 @@ static ssize_t ext4_dio_write_checks(struct kiocb *iocb, struct iov_iter *from,
 	 * in file_modified().
 	 */
 	if (*ilock_shared && (!IS_NOSEC(inode) || *extend ||
-	     !ext4_overwrite_io(inode, offset, count))) {
+	     !ext4_overwrite_io(inode, &map))) {
 		inode_unlock_shared(inode);
 		*ilock_shared = false;
 		inode_lock(inode);
-- 
2.25.4

