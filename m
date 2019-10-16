Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5DB0D89E1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2019 09:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732842AbfJPHh3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Oct 2019 03:37:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:1668 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732531AbfJPHh1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Oct 2019 03:37:27 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9G7b7nx082101
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2019 03:37:26 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vnuq1x6n5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2019 03:37:26 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Wed, 16 Oct 2019 08:37:24 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 16 Oct 2019 08:37:21 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9G7bK1e53084230
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Oct 2019 07:37:21 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C8863AE04D;
        Wed, 16 Oct 2019 07:37:20 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 75EAEAE053;
        Wed, 16 Oct 2019 07:37:19 +0000 (GMT)
Received: from dhcp-9-199-158-105.in.ibm.com (unknown [9.199.158.105])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 16 Oct 2019 07:37:18 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     tytso@mit.edu, jack@suse.cz, linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, mbobrowski@mbobrowski.org,
        riteshh@linux.ibm.com
Subject: [RFC 2/5] ext4: Add API to bring in support for unwritten io_end_vec conversion
Date:   Wed, 16 Oct 2019 13:07:08 +0530
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191016073711.4141-1-riteshh@linux.ibm.com>
References: <20191016073711.4141-1-riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19101607-0008-0000-0000-000003227AA4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19101607-0009-0000-0000-00004A4192F1
Message-Id: <20191016073711.4141-3-riteshh@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-16_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910160071
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch just brings in the API for conversion of unwritten io_end_vec
extents which will be required for blocksize < pagesize support
for dioread_nolock feature.

No functional changes in this patch.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/ext4.h    |  2 ++
 fs/ext4/extents.c | 42 +++++++++++++++++++++++++++---------------
 fs/ext4/page-io.c |  7 +++----
 3 files changed, 32 insertions(+), 19 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 03db3e71676c..8d924bd19ca7 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3264,6 +3264,8 @@ extern long ext4_fallocate(struct file *file, int mode, loff_t offset,
 			  loff_t len);
 extern int ext4_convert_unwritten_extents(handle_t *handle, struct inode *inode,
 					  loff_t offset, ssize_t len);
+extern int ext4_convert_unwritten_io_end_vec(handle_t *handle,
+					     ext4_io_end_t *io_end);
 extern int ext4_map_blocks(handle_t *handle, struct inode *inode,
 			   struct ext4_map_blocks *map, int flags);
 extern int ext4_ext_calc_metadata_amount(struct inode *inode,
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index fb0f99dc8c22..731e67ccab22 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4962,23 +4962,13 @@ int ext4_convert_unwritten_extents(handle_t *handle, struct inode *inode,
 	int ret = 0;
 	int ret2 = 0;
 	struct ext4_map_blocks map;
-	unsigned int credits, blkbits = inode->i_blkbits;
+	unsigned int blkbits = inode->i_blkbits;
+	unsigned int credits = 0;
 
 	map.m_lblk = offset >> blkbits;
 	max_blocks = EXT4_MAX_BLOCKS(len, offset, blkbits);
 
-	/*
-	 * This is somewhat ugly but the idea is clear: When transaction is
-	 * reserved, everything goes into it. Otherwise we rather start several
-	 * smaller transactions for conversion of each extent separately.
-	 */
-	if (handle) {
-		handle = ext4_journal_start_reserved(handle,
-						     EXT4_HT_EXT_CONVERT);
-		if (IS_ERR(handle))
-			return PTR_ERR(handle);
-		credits = 0;
-	} else {
+	if (!handle) {
 		/*
 		 * credits to insert 1 extent into extent tree
 		 */
@@ -5009,11 +4999,33 @@ int ext4_convert_unwritten_extents(handle_t *handle, struct inode *inode,
 		if (ret <= 0 || ret2)
 			break;
 	}
-	if (!credits)
-		ret2 = ext4_journal_stop(handle);
 	return ret > 0 ? ret2 : ret;
 }
 
+int ext4_convert_unwritten_io_end_vec(handle_t *handle, ext4_io_end_t *io_end)
+{
+	int ret, err = 0;
+
+	/*
+	 * This is somewhat ugly but the idea is clear: When transaction is
+	 * reserved, everything goes into it. Otherwise we rather start several
+	 * smaller transactions for conversion of each extent separately.
+	 */
+	if (handle) {
+		handle = ext4_journal_start_reserved(handle,
+						     EXT4_HT_EXT_CONVERT);
+		if (IS_ERR(handle))
+			return PTR_ERR(handle);
+	}
+
+	ret = ext4_convert_unwritten_extents(handle, io_end->inode,
+					     io_end->offset, io_end->size);
+	if (handle)
+		err = ext4_journal_stop(handle);
+
+	return ret < 0 ? ret : err;
+}
+
 /*
  * If newes is not existing extent (newes->ec_pblk equals zero) find
  * delayed extent at start of newes and update newes accordingly and
diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index d9b96fc976a3..3ccf54a380b2 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -149,7 +149,7 @@ static int ext4_end_io_end(ext4_io_end_t *io_end)
 		   io_end, inode->i_ino, io_end->list.next, io_end->list.prev);
 
 	io_end->handle = NULL;	/* Following call will use up the handle */
-	ret = ext4_convert_unwritten_extents(handle, inode, offset, size);
+	ret = ext4_convert_unwritten_io_end_vec(handle, io_end);
 	if (ret < 0 && !ext4_forced_shutdown(EXT4_SB(inode->i_sb))) {
 		ext4_msg(inode->i_sb, KERN_EMERG,
 			 "failed to convert unwritten extents to written "
@@ -269,9 +269,8 @@ int ext4_put_io_end(ext4_io_end_t *io_end)
 
 	if (atomic_dec_and_test(&io_end->count)) {
 		if (io_end->flag & EXT4_IO_END_UNWRITTEN) {
-			err = ext4_convert_unwritten_extents(io_end->handle,
-						io_end->inode, io_end->offset,
-						io_end->size);
+			err = ext4_convert_unwritten_io_end_vec(io_end->handle,
+								io_end);
 			io_end->handle = NULL;
 			ext4_clear_io_unwritten_flag(io_end);
 		}
-- 
2.21.0

