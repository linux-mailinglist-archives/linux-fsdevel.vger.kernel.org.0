Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F248113F89
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2019 11:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729283AbfLEKjS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Dec 2019 05:39:18 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10856 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729223AbfLEKjS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Dec 2019 05:39:18 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB5AbhlN112448
        for <linux-fsdevel@vger.kernel.org>; Thu, 5 Dec 2019 05:39:16 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wpuy4tche-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Dec 2019 05:39:15 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Thu, 5 Dec 2019 10:39:13 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 5 Dec 2019 10:39:09 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB5Ad83Y44826694
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 5 Dec 2019 10:39:08 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BE5C0A405C;
        Thu,  5 Dec 2019 10:39:08 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AD7EDA4054;
        Thu,  5 Dec 2019 10:39:06 +0000 (GMT)
Received: from dhcp-9-199-159-163.in.ibm.com (unknown [9.199.159.163])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  5 Dec 2019 10:39:06 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     willy@infradead.org, linux-fsdevel@vger.kernel.org,
        jlayton@kernel.org, viro@zeniv.linux.org.uk
Cc:     ceph-devel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-nfs@vger.kernel.org, devel@lists.orangefs.org,
        linux-unionfs@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCH 1/1] fs: Use inode_lock/unlock class of provided APIs in filesystems
Date:   Thu,  5 Dec 2019 16:09:02 +0530
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191205103902.23618-1-riteshh@linux.ibm.com>
References: <20191205103902.23618-1-riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19120510-4275-0000-0000-0000038BAB58
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120510-4276-0000-0000-0000389F5001
Message-Id: <20191205103902.23618-2-riteshh@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-05_02:2019-12-04,2019-12-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=289 suspectscore=3 impostorscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912050087
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This defines 4 more APIs which some of the filesystem needs
and reduces the direct use of i_rwsem in filesystem drivers.
Instead those are replaced with inode_lock/unlock_** APIs.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/btrfs/delayed-inode.c |  2 +-
 fs/btrfs/ioctl.c         |  4 ++--
 fs/ceph/io.c             | 24 ++++++++++++------------
 fs/nfs/io.c              | 24 ++++++++++++------------
 fs/orangefs/file.c       |  4 ++--
 fs/overlayfs/readdir.c   |  2 +-
 fs/readdir.c             |  4 ++--
 include/linux/fs.h       | 21 +++++++++++++++++++++
 8 files changed, 53 insertions(+), 32 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index d3e15e1d4a91..c3e92f2fd915 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1644,7 +1644,7 @@ void btrfs_readdir_put_delayed_items(struct inode *inode,
 	 * The VFS is going to do up_read(), so we need to downgrade back to a
 	 * read lock.
 	 */
-	downgrade_write(&inode->i_rwsem);
+	inode_lock_downgrade(inode);
 }
 
 int btrfs_should_delete_dir_index(struct list_head *del_list,
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index a1ee0b775e65..1cbd763a46d8 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -955,7 +955,7 @@ static noinline int btrfs_mksubvol(const struct path *parent,
 	struct dentry *dentry;
 	int error;
 
-	error = down_write_killable_nested(&dir->i_rwsem, I_MUTEX_PARENT);
+	error = inode_lock_killable_nested(dir, I_MUTEX_PARENT);
 	if (error == -EINTR)
 		return error;
 
@@ -2863,7 +2863,7 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 		goto out;
 
 
-	err = down_write_killable_nested(&dir->i_rwsem, I_MUTEX_PARENT);
+	err = inode_lock_killable_nested(dir, I_MUTEX_PARENT);
 	if (err == -EINTR)
 		goto out_drop_write;
 	dentry = lookup_one_len(vol_args->name, parent, namelen);
diff --git a/fs/ceph/io.c b/fs/ceph/io.c
index 97602ea92ff4..e94186259c2e 100644
--- a/fs/ceph/io.c
+++ b/fs/ceph/io.c
@@ -53,14 +53,14 @@ ceph_start_io_read(struct inode *inode)
 	struct ceph_inode_info *ci = ceph_inode(inode);
 
 	/* Be an optimist! */
-	down_read(&inode->i_rwsem);
+	inode_lock_shared(inode);
 	if (!(READ_ONCE(ci->i_ceph_flags) & CEPH_I_ODIRECT))
 		return;
-	up_read(&inode->i_rwsem);
+	inode_unlock_shared(inode);
 	/* Slow path.... */
-	down_write(&inode->i_rwsem);
+	inode_lock(inode);
 	ceph_block_o_direct(ci, inode);
-	downgrade_write(&inode->i_rwsem);
+	inode_lock_downgrade(inode);
 }
 
 /**
@@ -73,7 +73,7 @@ ceph_start_io_read(struct inode *inode)
 void
 ceph_end_io_read(struct inode *inode)
 {
-	up_read(&inode->i_rwsem);
+	inode_unlock_shared(inode);
 }
 
 /**
@@ -86,7 +86,7 @@ ceph_end_io_read(struct inode *inode)
 void
 ceph_start_io_write(struct inode *inode)
 {
-	down_write(&inode->i_rwsem);
+	inode_lock(inode);
 	ceph_block_o_direct(ceph_inode(inode), inode);
 }
 
@@ -100,7 +100,7 @@ ceph_start_io_write(struct inode *inode)
 void
 ceph_end_io_write(struct inode *inode)
 {
-	up_write(&inode->i_rwsem);
+	inode_unlock(inode);
 }
 
 /* Call with exclusively locked inode->i_rwsem */
@@ -139,14 +139,14 @@ ceph_start_io_direct(struct inode *inode)
 	struct ceph_inode_info *ci = ceph_inode(inode);
 
 	/* Be an optimist! */
-	down_read(&inode->i_rwsem);
+	inode_lock_shared(inode);
 	if (READ_ONCE(ci->i_ceph_flags) & CEPH_I_ODIRECT)
 		return;
-	up_read(&inode->i_rwsem);
+	inode_unlock_shared(inode);
 	/* Slow path.... */
-	down_write(&inode->i_rwsem);
+	inode_lock(inode);
 	ceph_block_buffered(ci, inode);
-	downgrade_write(&inode->i_rwsem);
+	inode_lock_downgrade(inode);
 }
 
 /**
@@ -159,5 +159,5 @@ ceph_start_io_direct(struct inode *inode)
 void
 ceph_end_io_direct(struct inode *inode)
 {
-	up_read(&inode->i_rwsem);
+	inode_unlock_shared(inode);
 }
diff --git a/fs/nfs/io.c b/fs/nfs/io.c
index 5088fda9b453..bf5ed7bea59d 100644
--- a/fs/nfs/io.c
+++ b/fs/nfs/io.c
@@ -44,14 +44,14 @@ nfs_start_io_read(struct inode *inode)
 {
 	struct nfs_inode *nfsi = NFS_I(inode);
 	/* Be an optimist! */
-	down_read(&inode->i_rwsem);
+	inode_lock_shared(inode);
 	if (test_bit(NFS_INO_ODIRECT, &nfsi->flags) == 0)
 		return;
-	up_read(&inode->i_rwsem);
+	inode_unlock_shared(inode);
 	/* Slow path.... */
-	down_write(&inode->i_rwsem);
+	inode_lock(inode);
 	nfs_block_o_direct(nfsi, inode);
-	downgrade_write(&inode->i_rwsem);
+	inode_lock_downgrade(inode);
 }
 
 /**
@@ -64,7 +64,7 @@ nfs_start_io_read(struct inode *inode)
 void
 nfs_end_io_read(struct inode *inode)
 {
-	up_read(&inode->i_rwsem);
+	inode_unlock_shared(inode);
 }
 
 /**
@@ -77,7 +77,7 @@ nfs_end_io_read(struct inode *inode)
 void
 nfs_start_io_write(struct inode *inode)
 {
-	down_write(&inode->i_rwsem);
+	inode_lock(inode);
 	nfs_block_o_direct(NFS_I(inode), inode);
 }
 
@@ -91,7 +91,7 @@ nfs_start_io_write(struct inode *inode)
 void
 nfs_end_io_write(struct inode *inode)
 {
-	up_write(&inode->i_rwsem);
+	inode_unlock(inode);
 }
 
 /* Call with exclusively locked inode->i_rwsem */
@@ -124,14 +124,14 @@ nfs_start_io_direct(struct inode *inode)
 {
 	struct nfs_inode *nfsi = NFS_I(inode);
 	/* Be an optimist! */
-	down_read(&inode->i_rwsem);
+	inode_lock_shared(inode);
 	if (test_bit(NFS_INO_ODIRECT, &nfsi->flags) != 0)
 		return;
-	up_read(&inode->i_rwsem);
+	inode_unlock_shared(inode);
 	/* Slow path.... */
-	down_write(&inode->i_rwsem);
+	inode_lock(inode);
 	nfs_block_buffered(nfsi, inode);
-	downgrade_write(&inode->i_rwsem);
+	inode_lock_downgrade(inode);
 }
 
 /**
@@ -144,5 +144,5 @@ nfs_start_io_direct(struct inode *inode)
 void
 nfs_end_io_direct(struct inode *inode)
 {
-	up_read(&inode->i_rwsem);
+	inode_unlock_shared(inode);
 }
diff --git a/fs/orangefs/file.c b/fs/orangefs/file.c
index a5612abc0936..6420503e1275 100644
--- a/fs/orangefs/file.c
+++ b/fs/orangefs/file.c
@@ -328,14 +328,14 @@ static ssize_t orangefs_file_read_iter(struct kiocb *iocb,
 		ro->blksiz = iter->count;
 	}
 
-	down_read(&file_inode(iocb->ki_filp)->i_rwsem);
+	inode_lock_shared(file_inode(iocb->ki_filp));
 	ret = orangefs_revalidate_mapping(file_inode(iocb->ki_filp));
 	if (ret)
 		goto out;
 
 	ret = generic_file_read_iter(iocb, iter);
 out:
-	up_read(&file_inode(iocb->ki_filp)->i_rwsem);
+	inode_unlock_shared(file_inode(iocb->ki_filp));
 	return ret;
 }
 
diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index 47a91c9733a5..c203e73160b0 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -273,7 +273,7 @@ static int ovl_check_whiteouts(struct dentry *dir, struct ovl_readdir_data *rdd)
 
 	old_cred = ovl_override_creds(rdd->dentry->d_sb);
 
-	err = down_write_killable(&dir->d_inode->i_rwsem);
+	err = inode_lock_killable(dir->d_inode);
 	if (!err) {
 		while (rdd->first_maybe_whiteout) {
 			p = rdd->first_maybe_whiteout;
diff --git a/fs/readdir.c b/fs/readdir.c
index d26d5ea4de7b..10a34efa0af0 100644
--- a/fs/readdir.c
+++ b/fs/readdir.c
@@ -52,9 +52,9 @@ int iterate_dir(struct file *file, struct dir_context *ctx)
 		goto out;
 
 	if (shared)
-		res = down_read_killable(&inode->i_rwsem);
+		res = inode_lock_shared_killable(inode);
 	else
-		res = down_write_killable(&inode->i_rwsem);
+		res = inode_lock_killable(inode);
 	if (res)
 		goto out;
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 98e0349adb52..2b407464fac1 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -831,6 +831,27 @@ static inline void inode_lock_shared_nested(struct inode *inode, unsigned subcla
 	down_read_nested(&inode->i_rwsem, subclass);
 }
 
+static inline void inode_lock_downgrade(struct inode *inode)
+{
+	downgrade_write(&inode->i_rwsem);
+}
+
+static inline int inode_lock_killable(struct inode *inode)
+{
+	return down_write_killable(&inode->i_rwsem);
+}
+
+static inline int inode_lock_shared_killable(struct inode *inode)
+{
+	return down_read_killable(&inode->i_rwsem);
+}
+
+static inline int inode_lock_killable_nested(struct inode *inode,
+					     unsigned subclass)
+{
+	return down_write_killable_nested(&inode->i_rwsem, subclass);
+}
+
 void lock_two_nondirectories(struct inode *, struct inode*);
 void unlock_two_nondirectories(struct inode *, struct inode*);
 
-- 
2.21.0

