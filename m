Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 510CD24E71C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Aug 2020 13:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbgHVLfO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Aug 2020 07:35:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33674 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727940AbgHVLfA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Aug 2020 07:35:00 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07MBVtYC058212;
        Sat, 22 Aug 2020 07:34:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=cQeKEY71AFOA0P5zcHV2666il5bBKQcdx8CHXk3yy6U=;
 b=mihzx/vjT/z2msIwIF7DPD4gtTTmAwDjvUj5AsiBcENC+eaHUUM1fweM2QVapMWm9RYY
 AaAkLjlh33r8xPU20upMp0F17vY4c4XHAICE5nwUGXYAVJzg7Wi/vomuxDBn4nRar/GB
 1hhedUGuTTeRONINZ7ljERYTplYTgfVCsurR1YwNbeyVIKW45UBorduIRKSslqGFPLsz
 PwJCNivzx66i+wfCPWM8H/1AqkJj4Fo+RNbea9LLzHr3G67D27ZVg8s6wG4QHdKKcJvz
 D/aqeCdKyvB+U3KE3WlnXmWSjSHA9H4eAL/bt+ji4TIP7q3OrMJqb/5XLH7Z/VGpIcyM 1w== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 332ygnax6b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 22 Aug 2020 07:34:52 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07MBWlDf029409;
        Sat, 22 Aug 2020 11:34:51 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03fra.de.ibm.com with ESMTP id 332utq06hc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 22 Aug 2020 11:34:50 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07MBYm2c31129932
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Aug 2020 11:34:48 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B1C4152051;
        Sat, 22 Aug 2020 11:34:48 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.199.33.217])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 4D67152052;
        Sat, 22 Aug 2020 11:34:47 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     jack@suse.cz, tytso@mit.edu,
        Dan Williams <dan.j.williams@intel.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv2 2/3] ext4: Extend ext4_overwrite_io() for dax path
Date:   Sat, 22 Aug 2020 17:04:36 +0530
Message-Id: <a859ef13d6453ae8cdb87109519062dad899a9b6.1598094830.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <cover.1598094830.git.riteshh@linux.ibm.com>
References: <cover.1598094830.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-22_07:2020-08-21,2020-08-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=1 mlxlogscore=852
 phishscore=0 spamscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008220120
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DAX uses ->iomap_begin path which gets called to map/allocate
extents. In order to avoid starting journal txn where extent
allocation is not required, we need to check if ext4_map_blocks()
has returned any mapped extent entry.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/ext4.h |  2 ++
 fs/ext4/file.c | 14 +++++++++++---
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 42f5060f3cdf..8a1b468bfb49 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3232,6 +3232,8 @@ extern const struct dentry_operations ext4_dentry_ops;
 extern const struct inode_operations ext4_file_inode_operations;
 extern const struct file_operations ext4_file_operations;
 extern loff_t ext4_llseek(struct file *file, loff_t offset, int origin);
+extern bool ext4_overwrite_io(struct inode *inode, struct ext4_map_blocks *map,
+			      bool is_dax);
 
 /* inline.c */
 extern int ext4_get_max_inline_size(struct inode *inode);
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 84f73ed91af2..6c252498334b 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -188,7 +188,8 @@ ext4_extending_io(struct inode *inode, loff_t offset, size_t len)
 }
 
 /* Is IO overwriting allocated and initialized blocks? */
-static bool ext4_overwrite_io(struct inode *inode, struct ext4_map_blocks *map)
+bool ext4_overwrite_io(struct inode *inode, struct ext4_map_blocks *map,
+		       bool is_dax)
 {
 	unsigned int blkbits = inode->i_blkbits;
 	loff_t end = (map->m_lblk + map->m_len) << blkbits;
@@ -198,12 +199,19 @@ static bool ext4_overwrite_io(struct inode *inode, struct ext4_map_blocks *map)
 		return false;
 
 	err = ext4_map_blocks(NULL, inode, map, 0);
+
 	/*
+	 * In case of dax to avoid starting a transaction in ext4_iomap_begin()
+	 * we check if ext4_map_blocks() can return any mapped extent.
+	 *
 	 * 'err==len' means that all of the blocks have been preallocated,
 	 * regardless of whether they have been initialized or not. To exclude
 	 * unwritten extents, we need to check m_flags.
 	 */
-	return err == blklen && (map->m_flags & EXT4_MAP_MAPPED);
+	if (is_dax)
+		return err > 0 && (map->m_flags & EXT4_MAP_MAPPED);
+	else
+		return err == blklen && (map->m_flags & EXT4_MAP_MAPPED);
 }
 
 static ssize_t ext4_generic_write_checks(struct kiocb *iocb,
@@ -427,7 +435,7 @@ static ssize_t ext4_dio_write_checks(struct kiocb *iocb, struct iov_iter *from,
 	 * in file_modified().
 	 */
 	if (*ilock_shared && (!IS_NOSEC(inode) || *extend ||
-	     !ext4_overwrite_io(inode, &map))) {
+	     !ext4_overwrite_io(inode, &map, false))) {
 		inode_unlock_shared(inode);
 		*ilock_shared = false;
 		inode_lock(inode);
-- 
2.25.4

