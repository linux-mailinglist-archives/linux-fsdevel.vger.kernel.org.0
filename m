Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1E01032B0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2019 06:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbfKTFAq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Nov 2019 00:00:46 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:4582 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726083AbfKTFAq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Nov 2019 00:00:46 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAK4vP4e175181
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Nov 2019 00:00:45 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wadmxvsmg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Nov 2019 00:00:44 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Wed, 20 Nov 2019 05:00:37 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 20 Nov 2019 05:00:35 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xAK50YYU64356402
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Nov 2019 05:00:34 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D4DD3A4057;
        Wed, 20 Nov 2019 05:00:34 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 50B20A4040;
        Wed, 20 Nov 2019 05:00:33 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.199.63.56])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 20 Nov 2019 05:00:33 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     jack@suse.cz, tytso@mit.edu, linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, mbobrowski@mbobrowski.org,
        riteshh@linux.ibm.com
Subject: [RFCv3 3/4] ext4: start with shared iolock in case of DIO instead of excl. iolock
Date:   Wed, 20 Nov 2019 10:30:23 +0530
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191120050024.11161-1-riteshh@linux.ibm.com>
References: <20191120050024.11161-1-riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19112005-0016-0000-0000-000002C95AC7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112005-0017-0000-0000-0000332B1614
Message-Id: <20191120050024.11161-4-riteshh@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-19_08:2019-11-15,2019-11-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 impostorscore=0 mlxscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 suspectscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1911200045
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Earlier there was no shared lock in DIO read path.
But this patch (16c54688592ce: ext4: Allow parallel DIO reads)
simplified some of the locking mechanism while still allowing
for parallel DIO reads by adding shared lock in inode DIO
read path.

But this created problem with mixed read/write workload.
It is due to the fact that in DIO path, we first start with
exclusive lock and only when we determine that it is a ovewrite
IO, we downgrade the lock. This causes the problem, since
with above patch we have shared locking in DIO reads.

So, this patch tries to fix this issue by starting with
shared lock and then switching to exclusive lock only
when required based on ext4_dio_write_checks().

Other than that, it also simplifies below cases:-

1. Simplified ext4_unaligned_aio API to ext4_unaligned_io.
Previous API was abused in the sense that it was not really checking
for AIO anywhere also it used to check for extending writes.
So this API was renamed and simplified to ext4_unaligned_io()
which actully only checks if the IO is really unaligned.

Now, in case of unaligned direct IO, iomap_dio_rw needs to do
zeroing of partial block and that will require serialization
against other direct IOs in the same block. So we take a excl iolock
for any unaligned DIO.
In case of AIO we also need to wait for any outstanding IOs to
complete so that conversion from unwritten to written is completed
before anyone try to map the overlapping block. Hence we take
excl iolock and also wait for inode_dio_wait() for unaligned DIO case.
Please note since we are anyway taking an exclusive lock in unaligned IO,
inode_dio_wait() becomes a no-op in case of non-AIO DIO.

2. Added ext4_extending_io(). This checks if the IO is extending the file.

3. Added ext4_dio_write_checks().
In this we start with shared iolock and only switch to exclusive iolock
if required. So in most cases with aligned, non-extening, dioread_nolock
overwrites tries to write with a shared locking.
If not, then we restart the operation in ext4_dio_write_checks(),
after acquiring excl iolock.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/file.c | 191 ++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 142 insertions(+), 49 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index ebe3f051598d..18cbf9fa52c6 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -167,19 +167,25 @@ static int ext4_release_file(struct inode *inode, struct file *filp)
  * threads are at work on the same unwritten block, they must be synchronized
  * or one thread will zero the other's data, causing corruption.
  */
-static int
-ext4_unaligned_aio(struct inode *inode, struct iov_iter *from, loff_t pos)
+static bool
+ext4_unaligned_io(struct inode *inode, struct iov_iter *from, loff_t pos)
 {
 	struct super_block *sb = inode->i_sb;
-	int blockmask = sb->s_blocksize - 1;
-
-	if (pos >= ALIGN(i_size_read(inode), sb->s_blocksize))
-		return 0;
+	unsigned long blockmask = sb->s_blocksize - 1;
 
 	if ((pos | iov_iter_alignment(from)) & blockmask)
-		return 1;
+		return true;
 
-	return 0;
+	return false;
+}
+
+static bool
+ext4_extending_io(struct inode *inode, loff_t offset, size_t len)
+{
+	if (offset + len > i_size_read(inode) ||
+	    offset + len > EXT4_I(inode)->i_disksize)
+		return true;
+	return false;
 }
 
 /* Is IO overwriting allocated and initialized blocks? */
@@ -205,7 +211,8 @@ static bool ext4_overwrite_io(struct inode *inode, loff_t pos, loff_t len)
 	return err == blklen && (map.m_flags & EXT4_MAP_MAPPED);
 }
 
-static ssize_t ext4_write_checks(struct kiocb *iocb, struct iov_iter *from)
+static ssize_t ext4_generic_write_checks(struct kiocb *iocb,
+					 struct iov_iter *from)
 {
 	struct inode *inode = file_inode(iocb->ki_filp);
 	ssize_t ret;
@@ -229,11 +236,22 @@ static ssize_t ext4_write_checks(struct kiocb *iocb, struct iov_iter *from)
 		iov_iter_truncate(from, sbi->s_bitmap_maxbytes - iocb->ki_pos);
 	}
 
+	return iov_iter_count(from);
+}
+
+static ssize_t ext4_write_checks(struct kiocb *iocb, struct iov_iter *from)
+{
+	ssize_t ret, count;
+
+	count = ext4_generic_write_checks(iocb, from);
+	if (count <= 0)
+		return count;
+
 	ret = file_modified(iocb->ki_filp);
 	if (ret)
 		return ret;
 
-	return iov_iter_count(from);
+	return count;
 }
 
 static ssize_t ext4_buffered_write_iter(struct kiocb *iocb,
@@ -365,15 +383,110 @@ static const struct iomap_dio_ops ext4_dio_write_ops = {
 	.end_io = ext4_dio_write_end_io,
 };
 
+/*
+ * The intention here is to start with shared lock acquired then see if any
+ * condition requires an exclusive inode lock. If yes, then we restart the
+ * whole operation by releasing the shared lock and acquiring exclusive lock.
+ *
+ * - For unaligned_io we never take shared lock as it may cause data corruption
+ *   when two unaligned IO tries to modify the same block e.g. while zeroing.
+ *
+ * - For extending writes case we don't take the shared lock, since it requires
+ *   updating inode i_disksize and/or orphan handling with exclusive lock.
+ *
+ * - shared locking will only be true mostly in case of overwrites with
+ *   dioread_nolock mode. Otherwise we will switch to excl. iolock mode.
+ */
+static ssize_t ext4_dio_write_checks(struct kiocb *iocb, struct iov_iter *from,
+				 unsigned int *iolock, bool *unaligned_io,
+				 bool *extend)
+{
+	struct file *file = iocb->ki_filp;
+	struct inode *inode = file_inode(file);
+	loff_t offset = iocb->ki_pos;
+	loff_t final_size;
+	size_t count;
+	ssize_t ret;
+
+restart:
+	/* Fallback to buffered I/O if the inode does not support direct I/O. */
+	if (!ext4_dio_supported(inode)) {
+		ext4_iunlock(inode, *iolock);
+		return ext4_buffered_write_iter(iocb, from);
+	}
+
+	ret = ext4_generic_write_checks(iocb, from);
+	if (ret <= 0) {
+		ext4_iunlock(inode, *iolock);
+		return ret;
+	}
+
+	/* Recalculate since offset & count may change above. */
+	offset = iocb->ki_pos;
+	count = iov_iter_count(from);
+	final_size = offset + count;
+
+	if (ext4_unaligned_io(inode, from, offset))
+		*unaligned_io = true;
+
+	if (ext4_extending_io(inode, offset, count))
+		*extend = true;
+	/*
+	 * Determine whether the IO operation will overwrite allocated
+	 * and initialized blocks. If so, check to see whether it is
+	 * possible to take the dioread_nolock path.
+	 *
+	 * We need exclusive i_rwsem for changing security info
+	 * in file_modified().
+	 */
+	if (*iolock == EXT4_IOLOCK_SHARED &&
+	    (!IS_NOSEC(inode) || *unaligned_io || *extend ||
+	     !ext4_should_dioread_nolock(inode) ||
+	     !ext4_overwrite_io(inode, offset, count))) {
+		ext4_iunlock(inode, *iolock);
+		*iolock = EXT4_IOLOCK_EXCL;
+		ext4_ilock(inode, *iolock);
+		goto restart;
+	}
+
+	ret = file_modified(file);
+	if (ret < 0) {
+		ext4_iunlock(inode, *iolock);
+		return ret;
+	}
+
+	return count;
+}
+
 static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	ssize_t ret;
-	size_t count;
-	loff_t offset;
 	handle_t *handle;
 	struct inode *inode = file_inode(iocb->ki_filp);
-	bool extend = false, overwrite = false, unaligned_aio = false;
-	unsigned int iolock = EXT4_IOLOCK_EXCL;
+	loff_t offset = iocb->ki_pos;
+	size_t count = iov_iter_count(from);
+	bool extend = false, unaligned_io = false;
+	unsigned int iolock = EXT4_IOLOCK_SHARED;
+
+	/*
+	 * We initially start with shared inode lock
+	 * unless it is unaligned IO which needs
+	 * exclusive lock anyways.
+	 */
+	if (ext4_unaligned_io(inode, from, offset)) {
+		unaligned_io = true;
+		iolock = EXT4_IOLOCK_EXCL;
+	}
+	/*
+	 * Extending writes need exclusive lock.
+	 */
+	if (ext4_extending_io(inode, offset, count)) {
+		extend = true;
+		iolock = EXT4_IOLOCK_EXCL;
+	}
+
+	if (iolock == EXT4_IOLOCK_SHARED && !ext4_should_dioread_nolock(inode))
+		iolock = EXT4_IOLOCK_EXCL;
 
 	if (iocb->ki_flags & IOCB_NOWAIT) {
 		if (!ext4_ilock_nowait(inode, iolock))
@@ -382,47 +495,28 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		ext4_ilock(inode, iolock);
 	}
 
-	if (!ext4_dio_supported(inode)) {
-		ext4_iunlock(inode, iolock);
-		/*
-		 * Fallback to buffered I/O if the inode does not support
-		 * direct I/O.
-		 */
-		return ext4_buffered_write_iter(iocb, from);
-	}
-
-	ret = ext4_write_checks(iocb, from);
-	if (ret <= 0) {
-		ext4_iunlock(inode, iolock);
+	ret = ext4_dio_write_checks(iocb, from, &iolock, &unaligned_io,
+				    &extend);
+	if (ret <= 0)
 		return ret;
-	}
 
-	/*
-	 * Unaligned asynchronous direct I/O must be serialized among each
-	 * other as the zeroing of partial blocks of two competing unaligned
-	 * asynchronous direct I/O writes can result in data corruption.
-	 */
 	offset = iocb->ki_pos;
 	count = iov_iter_count(from);
-	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS) &&
-	    !is_sync_kiocb(iocb) && ext4_unaligned_aio(inode, from, offset)) {
-		unaligned_aio = true;
-		inode_dio_wait(inode);
-	}
 
 	/*
-	 * Determine whether the I/O will overwrite allocated and initialized
-	 * blocks. If so, check to see whether it is possible to take the
-	 * dioread_nolock path.
+	 * Unaligned direct IO must be serialized among each other as zeroing
+	 * of partial blocks of two competing unaligned IOs can result in data
+	 * corruption.
+	 *
+	 * So we make sure we don't allow any unaligned IO in flight.
+	 * For IOs where we need not wait (like unaligned non-AIO DIO),
+	 * below inode_dio_wait() may anyway become a no-op, since we start
+	 * with exclusive lock.
 	 */
-	if (!unaligned_aio && ext4_overwrite_io(inode, offset, count) &&
-	    ext4_should_dioread_nolock(inode)) {
-		overwrite = true;
-		ext4_ilock_demote(inode, iolock);
-		iolock = EXT4_IOLOCK_SHARED;
-	}
+	if (unaligned_io)
+		inode_dio_wait(inode);
 
-	if (offset + count > EXT4_I(inode)->i_disksize) {
+	if (extend) {
 		handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
 		if (IS_ERR(handle)) {
 			ret = PTR_ERR(handle);
@@ -435,12 +529,11 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 			goto out;
 		}
 
-		extend = true;
 		ext4_journal_stop(handle);
 	}
 
 	ret = iomap_dio_rw(iocb, from, &ext4_iomap_ops, &ext4_dio_write_ops,
-			   is_sync_kiocb(iocb) || unaligned_aio || extend);
+			   is_sync_kiocb(iocb) || unaligned_io || extend);
 
 	if (extend)
 		ret = ext4_handle_inode_extension(inode, offset, ret, count);
-- 
2.21.0

