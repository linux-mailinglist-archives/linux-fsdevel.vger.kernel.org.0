Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58CCC11C5A9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 06:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbfLLF4P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 00:56:15 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:17086 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727704AbfLLF4P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 00:56:15 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBC5kKtO089374
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2019 00:56:13 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wsqc2xpca-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2019 00:56:12 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Thu, 12 Dec 2019 05:56:10 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 12 Dec 2019 05:56:07 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBC5u66H26935474
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Dec 2019 05:56:06 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B9722AE051;
        Thu, 12 Dec 2019 05:56:06 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5E0BAAE055;
        Thu, 12 Dec 2019 05:56:05 +0000 (GMT)
Received: from dhcp-9-199-158-163.in.ibm.com (unknown [9.199.158.163])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 12 Dec 2019 05:56:05 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     jack@suse.cz, tytso@mit.edu, linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, mbobrowski@mbobrowski.org,
        joseph.qi@linux.alibaba.com, Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv5 2/3] ext4: Start with shared i_rwsem in case of DIO instead of exclusive
Date:   Thu, 12 Dec 2019 11:25:56 +0530
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191212055557.11151-1-riteshh@linux.ibm.com>
References: <20191212055557.11151-1-riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19121205-0028-0000-0000-000003C7BB43
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19121205-0029-0000-0000-0000248AF294
Message-Id: <20191212055557.11151-3-riteshh@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-12_01:2019-12-12,2019-12-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 malwarescore=0 suspectscore=3 clxscore=1015 mlxscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=532 spamscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912120036
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Earlier there was no shared lock in DIO read path. But this patch
(16c54688592ce: ext4: Allow parallel DIO reads)
simplified some of the locking mechanism while still allowing for parallel DIO
reads by adding shared lock in inode DIO read path.

But this created problem with mixed read/write workload. It is due to the fact
that in DIO path, we first start with exclusive lock and only when we determine
that it is a ovewrite IO, we downgrade the lock. This causes the problem, since
we still have shared locking in DIO reads.

So, this patch tries to fix this issue by starting with shared lock and then
switching to exclusive lock only when required based on ext4_dio_write_checks().

Other than that, it also simplifies below cases:-

1. Simplified ext4_unaligned_aio API to ext4_unaligned_io. Previous API was
abused in the sense that it was not really checking for AIO anywhere also it
used to check for extending writes. So this API was renamed and simplified to
ext4_unaligned_io() which actully only checks if the IO is really unaligned.

Now, in case of unaligned direct IO, iomap_dio_rw needs to do zeroing of partial
block and that will require serialization against other direct IOs in the same
block. So we take a exclusive inode lock for any unaligned DIO. In case of AIO
we also need to wait for any outstanding IOs to complete so that conversion from
unwritten to written is completed before anyone try to map the overlapping block.
Hence we take exclusive inode lock and also wait for inode_dio_wait() for
unaligned DIO case. Please note since we are anyway taking an exclusive lock in
unaligned IO, inode_dio_wait() becomes a no-op in case of non-AIO DIO.

2. Added ext4_extending_io(). This checks if the IO is extending the file.

3. Added ext4_dio_write_checks(). In this we start with shared inode lock and
only switch to exclusive lock if required. So in most cases with aligned,
non-extending, dioread_nolock & overwrites, it tries to write with a shared
lock. If not, then we restart the operation in ext4_dio_write_checks(), after
acquiring exclusive lock.

Reviewed-by: Jan Kara <jack@suse.cz>
Tested-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/file.c | 191 ++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 142 insertions(+), 49 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 977ac58dc718..1da49dffa3df 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -166,19 +166,25 @@ static int ext4_release_file(struct inode *inode, struct file *filp)
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
@@ -204,7 +210,8 @@ static bool ext4_overwrite_io(struct inode *inode, loff_t pos, loff_t len)
 	return err == blklen && (map.m_flags & EXT4_MAP_MAPPED);
 }
 
-static ssize_t ext4_write_checks(struct kiocb *iocb, struct iov_iter *from)
+static ssize_t ext4_generic_write_checks(struct kiocb *iocb,
+					 struct iov_iter *from)
 {
 	struct inode *inode = file_inode(iocb->ki_filp);
 	ssize_t ret;
@@ -228,11 +235,21 @@ static ssize_t ext4_write_checks(struct kiocb *iocb, struct iov_iter *from)
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
-
-	return iov_iter_count(from);
+	return count;
 }
 
 static ssize_t ext4_buffered_write_iter(struct kiocb *iocb,
@@ -364,62 +381,139 @@ static const struct iomap_dio_ops ext4_dio_write_ops = {
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
+ * - shared locking will only be true mostly with overwrites in dioread_nolock
+ *   mode. Otherwise we will switch to exclusive i_rwsem lock.
+ */
+static ssize_t ext4_dio_write_checks(struct kiocb *iocb, struct iov_iter *from,
+				     bool *ilock_shared, bool *extend)
+{
+	struct file *file = iocb->ki_filp;
+	struct inode *inode = file_inode(file);
+	loff_t offset;
+	size_t count;
+	ssize_t ret;
+
+restart:
+	ret = ext4_generic_write_checks(iocb, from);
+	if (ret <= 0)
+		goto out;
+
+	offset = iocb->ki_pos;
+	count = ret;
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
+	if (*ilock_shared && (!IS_NOSEC(inode) || *extend ||
+	     !ext4_should_dioread_nolock(inode) ||
+	     !ext4_overwrite_io(inode, offset, count))) {
+		inode_unlock_shared(inode);
+		*ilock_shared = false;
+		inode_lock(inode);
+		goto restart;
+	}
+
+	ret = file_modified(file);
+	if (ret < 0)
+		goto out;
+
+	return count;
+out:
+	if (*ilock_shared)
+		inode_unlock_shared(inode);
+	else
+		inode_unlock(inode);
+	return ret;
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
+	loff_t offset = iocb->ki_pos;
+	size_t count = iov_iter_count(from);
+	bool extend = false, unaligned_io = false;
+	bool ilock_shared = true;
+
+	/*
+	 * We initially start with shared inode lock unless it is
+	 * unaligned IO which needs exclusive lock anyways.
+	 */
+	if (ext4_unaligned_io(inode, from, offset)) {
+		unaligned_io = true;
+		ilock_shared = false;
+	}
+	/*
+	 * Quick check here without any i_rwsem lock to see if it is extending
+	 * IO. A more reliable check is done in ext4_dio_write_checks() with
+	 * proper locking in place.
+	 */
+	if (offset + count > i_size_read(inode))
+		ilock_shared = false;
 
 	if (iocb->ki_flags & IOCB_NOWAIT) {
-		if (!inode_trylock(inode))
-			return -EAGAIN;
+		if (ilock_shared) {
+			if (!inode_trylock_shared(inode))
+				return -EAGAIN;
+		} else {
+			if (!inode_trylock(inode))
+				return -EAGAIN;
+		}
 	} else {
-		inode_lock(inode);
+		if (ilock_shared)
+			inode_lock_shared(inode);
+		else
+			inode_lock(inode);
 	}
 
+	/* Fallback to buffered I/O if the inode does not support direct I/O. */
 	if (!ext4_dio_supported(inode)) {
-		inode_unlock(inode);
-		/*
-		 * Fallback to buffered I/O if the inode does not support
-		 * direct I/O.
-		 */
+		if (ilock_shared)
+			inode_unlock_shared(inode);
+		else
+			inode_unlock(inode);
 		return ext4_buffered_write_iter(iocb, from);
 	}
 
-	ret = ext4_write_checks(iocb, from);
-	if (ret <= 0) {
-		inode_unlock(inode);
+	ret = ext4_dio_write_checks(iocb, from, &ilock_shared, &extend);
+	if (ret <= 0)
 		return ret;
-	}
 
-	/*
-	 * Unaligned asynchronous direct I/O must be serialized among each
-	 * other as the zeroing of partial blocks of two competing unaligned
-	 * asynchronous direct I/O writes can result in data corruption.
-	 */
 	offset = iocb->ki_pos;
-	count = iov_iter_count(from);
-	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS) &&
-	    !is_sync_kiocb(iocb) && ext4_unaligned_aio(inode, from, offset)) {
-		unaligned_aio = true;
-		inode_dio_wait(inode);
-	}
+	count = ret;
 
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
-		downgrade_write(&inode->i_rwsem);
-	}
+	if (unaligned_io)
+		inode_dio_wait(inode);
 
-	if (offset + count > EXT4_I(inode)->i_disksize) {
+	if (extend) {
 		handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
 		if (IS_ERR(handle)) {
 			ret = PTR_ERR(handle);
@@ -432,18 +526,17 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
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
 
 out:
-	if (overwrite)
+	if (ilock_shared)
 		inode_unlock_shared(inode);
 	else
 		inode_unlock(inode);
-- 
2.21.0

