Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEA01032AE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2019 06:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbfKTFAo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Nov 2019 00:00:44 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:30218 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726080AbfKTFAm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Nov 2019 00:00:42 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAK4vT3C132206
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Nov 2019 00:00:41 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wcf47qnkp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Nov 2019 00:00:41 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Wed, 20 Nov 2019 05:00:39 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 20 Nov 2019 05:00:37 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xAK50atA38994002
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Nov 2019 05:00:36 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 84385A405B;
        Wed, 20 Nov 2019 05:00:36 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 38DFBA404D;
        Wed, 20 Nov 2019 05:00:35 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.199.63.56])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 20 Nov 2019 05:00:34 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     jack@suse.cz, tytso@mit.edu, linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, mbobrowski@mbobrowski.org,
        riteshh@linux.ibm.com
Subject: [RFCv3 4/4] ext4: Move to shared iolock even without dioread_nolock mount opt
Date:   Wed, 20 Nov 2019 10:30:24 +0530
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191120050024.11161-1-riteshh@linux.ibm.com>
References: <20191120050024.11161-1-riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19112005-0020-0000-0000-0000038BE5BA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112005-0021-0000-0000-000021E2154A
Message-Id: <20191120050024.11161-5-riteshh@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-19_08:2019-11-15,2019-11-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=735
 spamscore=0 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1911200045
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We were using shared locking only in case of dioread_nolock
mount option in case of DIO overwrites. This mount condition
is not needed anymore with current code, since:-

1. No race between buffered writes & DIO overwrites.
Since buffIO writes takes exclusive locks & DIO overwrites
will take share locking. Also DIO path will make sure
to flush and wait for any dirty page cache data.

2. No race between buffered reads & DIO overwrites, since there
is no block allocation that is possible with DIO overwrites.
So no stale data exposure should happen. Same is the case
between DIO reads & DIO overwrites.

3. Also other paths like truncate is protected,
since we wait there for any DIO in flight to be over.

4. In case of buffIO writes followed by DIO reads:
Since here also we take exclusive locks in ext4_write_begin/end().
There is no risk of exposing any stale data in this case.
Since after ext4_write_end, iomap_dio_rw() will wait to flush &
wait for any dirty page cache data.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/file.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 18cbf9fa52c6..b97efc89cd63 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -383,6 +383,17 @@ static const struct iomap_dio_ops ext4_dio_write_ops = {
 	.end_io = ext4_dio_write_end_io,
 };
 
+static bool ext4_dio_should_shared_lock(struct inode *inode)
+{
+	if (!S_ISREG(inode->i_mode))
+		return false;
+	if (!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)))
+		return false;
+	if (ext4_should_journal_data(inode))
+		return false;
+	return true;
+}
+
 /*
  * The intention here is to start with shared lock acquired then see if any
  * condition requires an exclusive inode lock. If yes, then we restart the
@@ -394,8 +405,8 @@ static const struct iomap_dio_ops ext4_dio_write_ops = {
  * - For extending writes case we don't take the shared lock, since it requires
  *   updating inode i_disksize and/or orphan handling with exclusive lock.
  *
- * - shared locking will only be true mostly in case of overwrites with
- *   dioread_nolock mode. Otherwise we will switch to excl. iolock mode.
+ * - shared locking will only be true mostly in case of overwrites.
+ *   Otherwise we will switch to excl. iolock mode.
  */
 static ssize_t ext4_dio_write_checks(struct kiocb *iocb, struct iov_iter *from,
 				 unsigned int *iolock, bool *unaligned_io,
@@ -433,15 +444,14 @@ static ssize_t ext4_dio_write_checks(struct kiocb *iocb, struct iov_iter *from,
 		*extend = true;
 	/*
 	 * Determine whether the IO operation will overwrite allocated
-	 * and initialized blocks. If so, check to see whether it is
-	 * possible to take the dioread_nolock path.
+	 * and initialized blocks.
 	 *
 	 * We need exclusive i_rwsem for changing security info
 	 * in file_modified().
 	 */
 	if (*iolock == EXT4_IOLOCK_SHARED &&
 	    (!IS_NOSEC(inode) || *unaligned_io || *extend ||
-	     !ext4_should_dioread_nolock(inode) ||
+	     !ext4_dio_should_shared_lock(inode) ||
 	     !ext4_overwrite_io(inode, offset, count))) {
 		ext4_iunlock(inode, *iolock);
 		*iolock = EXT4_IOLOCK_EXCL;
@@ -485,7 +495,10 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		iolock = EXT4_IOLOCK_EXCL;
 	}
 
-	if (iolock == EXT4_IOLOCK_SHARED && !ext4_should_dioread_nolock(inode))
+	/*
+	 * Check if we should continue with shared iolock
+	 */
+	if (iolock == EXT4_IOLOCK_SHARED && !ext4_dio_should_shared_lock(inode))
 		iolock = EXT4_IOLOCK_EXCL;
 
 	if (iocb->ki_flags & IOCB_NOWAIT) {
-- 
2.21.0

