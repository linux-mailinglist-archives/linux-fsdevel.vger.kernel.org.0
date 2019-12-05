Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB5801141E0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2019 14:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729456AbfLENqT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Dec 2019 08:46:19 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:62198 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729165AbfLENqT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Dec 2019 08:46:19 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB5Dh3qW063629
        for <linux-fsdevel@vger.kernel.org>; Thu, 5 Dec 2019 08:46:18 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wq1ky4e9a-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Dec 2019 08:46:17 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Thu, 5 Dec 2019 13:46:15 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 5 Dec 2019 13:46:13 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB5DkCoR49020952
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 5 Dec 2019 13:46:12 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5022AA405C;
        Thu,  5 Dec 2019 13:46:12 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ADAE2A4062;
        Thu,  5 Dec 2019 13:46:10 +0000 (GMT)
Received: from dhcp-9-199-159-163.in.ibm.com (unknown [9.199.159.163])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  5 Dec 2019 13:46:10 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     jack@suse.cz, tytso@mit.edu, linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, mbobrowski@mbobrowski.org,
        riteshh@linux.ibm.com, joseph.qi@linux.alibaba.com
Subject: [PATCHv4 3/3] ext4: Move to shared i_rwsem even without dioread_nolock mount opt
Date:   Thu,  5 Dec 2019 19:16:05 +0530
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191205120529.GB32639@quack2.suse.cz>
References: <20191205120529.GB32639@quack2.suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19120513-0028-0000-0000-000003C55B99
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120513-0029-0000-0000-000024887DB2
Message-Id: <20191205134605.2593-1-riteshh@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-05_03:2019-12-04,2019-12-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 mlxlogscore=548 malwarescore=0 priorityscore=1501 impostorscore=0
 mlxscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 suspectscore=3
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912050115
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We were using shared locking only in case of dioread_nolock mount option in case
of DIO overwrites. This mount condition is not needed anymore with current code,
since:-

1. No race between buffered writes & DIO overwrites. Since buffIO writes takes
exclusive lock & DIO overwrites will take shared locking. Also DIO path will
make sure to flush and wait for any dirty page cache data.

2. No race between buffered reads & DIO overwrites, since there is no block
allocation that is possible with DIO overwrites. So no stale data exposure
should happen. Same is the case between DIO reads & DIO overwrites.

3. Also other paths like truncate is protected, since we wait there for any DIO
in flight to be over.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/file.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index cbafaec9e4fc..682ed956eb02 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -392,8 +392,8 @@ static const struct iomap_dio_ops ext4_dio_write_ops = {
  * - For extending writes case we don't take the shared lock, since it requires
  *   updating inode i_disksize and/or orphan handling with exclusive lock.
  *
- * - shared locking will only be true mostly with overwrites in dioread_nolock
- *   mode. Otherwise we will switch to exclusive i_rwsem lock.
+ * - shared locking will only be true mostly with overwrites. Otherwise we will
+ *   switch to exclusive i_rwsem lock.
  */
 static ssize_t ext4_dio_write_checks(struct kiocb *iocb, struct iov_iter *from,
 				     bool *ilock_shared, bool *extend)
@@ -415,14 +415,11 @@ static ssize_t ext4_dio_write_checks(struct kiocb *iocb, struct iov_iter *from,
 		*extend = true;
 	/*
 	 * Determine whether the IO operation will overwrite allocated
-	 * and initialized blocks. If so, check to see whether it is
-	 * possible to take the dioread_nolock path.
-	 *
+	 * and initialized blocks.
 	 * We need exclusive i_rwsem for changing security info
 	 * in file_modified().
 	 */
 	if (*ilock_shared && (!IS_NOSEC(inode) || *extend ||
-	     !ext4_should_dioread_nolock(inode) ||
 	     !ext4_overwrite_io(inode, offset, count))) {
 		inode_unlock_shared(inode);
 		*ilock_shared = false;
-- 
2.21.0

