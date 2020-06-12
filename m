Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBF451F717C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jun 2020 02:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgFLAwW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Jun 2020 20:52:22 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59368 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbgFLAwV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Jun 2020 20:52:21 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05C0hfiI067485;
        Fri, 12 Jun 2020 00:52:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=BqruuEepRpLOTVs/WiJmrvJ1Ufka84VWpP0ssp1Ad/Q=;
 b=opqINedqgLtul5F8tt9GP0s4R78REWtM5gch6ohTx/FDzUgy0QGZZyvnTrSrZChW9omK
 8QJMe7ML97LoJfKC1w8GnZfdMyjwtjfC8DIWFdJLWF9kOR9gf0rWlHFCowIjDk7AIg0Q
 YQecxHD4PddJ64RqjVDA37mLYE52oY9+hz6NSn2+nwZZzmMGvpAjMiVMv7QmARr+KpI3
 FxVRug7GQBZh+JOyWpd1nuxPeGsS8QRRPdZARKVDWadwi1B6ytx6HcMfnWDu425V8eVK
 ICQC+mGVhwmtdHrGOtt5rW9YahDb3tMNN5/1elYKKNYANSlK0HZ6NAgX27PoXi74ZAgM Lg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 31g2jrjnme-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 12 Jun 2020 00:52:01 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05C0lmlk021786;
        Fri, 12 Jun 2020 00:52:01 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 31kye5070n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jun 2020 00:52:01 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 05C0kv2I007040;
        Fri, 12 Jun 2020 00:46:57 GMT
Received: from monkey.oracle.com (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 11 Jun 2020 17:46:57 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@infradead.org>,
        Colin Walters <walters@verbum.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+d6ec23007e951dadf3de@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v4 1/2] hugetlb: use f_mode & FMODE_HUGETLBFS to identify hugetlbfs files
Date:   Thu, 11 Jun 2020 17:46:43 -0700
Message-Id: <20200612004644.255692-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9649 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 adultscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006120003
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9649 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 cotscore=-2147483648 priorityscore=1501 spamscore=0 suspectscore=2
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006120002
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The routine is_file_hugepages() checks f_op == hugetlbfs_file_operations
to determine if the file resides in hugetlbfs.  This is problematic when
the file is on a union or overlay.  Instead, define a new file mode
FMODE_HUGETLBFS which is set when a hugetlbfs file is opened.  The mode
can easily be copied to other 'files' derived from the original hugetlbfs
file.

With this change hugetlbfs_file_operations can be static as it should be.

There is also a (duplicate) set of shm file operations used for the routine
is_file_shm_hugepages().  Instead of setting/using special f_op's, just
propagate the FMODE_HUGETLBFS mode.  This means is_file_shm_hugepages() and
the duplicate f_ops can be removed.

While cleaning things up, change the name of is_file_hugepages() to
is_file_hugetlbfs().  The term hugepages is a bit ambiguous.

A subsequent patch will propagate FMODE_HUGETLBFS in overlayfs.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 fs/hugetlbfs/inode.c    |  7 +++++++
 fs/io_uring.c           |  2 +-
 include/linux/fs.h      |  3 +++
 include/linux/hugetlb.h | 10 ++++------
 include/linux/shm.h     |  5 -----
 ipc/shm.c               | 34 ++++++++--------------------------
 mm/memfd.c              |  2 +-
 mm/mmap.c               |  8 ++++----
 8 files changed, 28 insertions(+), 43 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 991c60c7ffe0..5c0c50a88c84 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -324,6 +324,12 @@ static ssize_t hugetlbfs_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	return retval;
 }
 
+static int hugetlbfs_open(struct inode *inode, struct file *file)
+{
+	file->f_mode |= FMODE_HUGETLBFS;
+	return 0;
+}
+
 static int hugetlbfs_write_begin(struct file *file,
 			struct address_space *mapping,
 			loff_t pos, unsigned len, unsigned flags,
@@ -1112,6 +1118,7 @@ static void init_once(void *foo)
 
 const struct file_operations hugetlbfs_file_operations = {
 	.read_iter		= hugetlbfs_read_iter,
+	.open			= hugetlbfs_open,
 	.mmap			= hugetlbfs_file_mmap,
 	.fsync			= noop_fsync,
 	.get_unmapped_area	= hugetlb_get_unmapped_area,
diff --git a/fs/io_uring.c b/fs/io_uring.c
index bb25e3997d41..96e8a4bb610a 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -7123,7 +7123,7 @@ static int io_sqe_buffer_register(struct io_ring_ctx *ctx, void __user *arg,
 				struct vm_area_struct *vma = vmas[j];
 
 				if (vma->vm_file &&
-				    !is_file_hugepages(vma->vm_file)) {
+				    !is_file_hugetlbfs(vma->vm_file)) {
 					ret = -EOPNOTSUPP;
 					break;
 				}
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 45cc10cdf6dd..99af9513f9ab 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -175,6 +175,9 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
 /* File does not contribute to nr_files count */
 #define FMODE_NOACCOUNT		((__force fmode_t)0x20000000)
 
+/* File is in hugetlbfs filesystem */
+#define FMODE_HUGETLBFS		((__force fmode_t)0x40000000)
+
 /*
  * Flag for rw_copy_check_uvector and compat_rw_copy_check_uvector
  * that indicates that they should check the contents of the iovec are
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 43a1cef8f0f1..aa3408775464 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -429,18 +429,16 @@ static inline struct hugetlbfs_inode_info *HUGETLBFS_I(struct inode *inode)
 	return container_of(inode, struct hugetlbfs_inode_info, vfs_inode);
 }
 
-extern const struct file_operations hugetlbfs_file_operations;
 extern const struct vm_operations_struct hugetlb_vm_ops;
 struct file *hugetlb_file_setup(const char *name, size_t size, vm_flags_t acct,
 				struct user_struct **user, int creat_flags,
 				int page_size_log);
 
-static inline bool is_file_hugepages(struct file *file)
+static inline bool is_file_hugetlbfs(struct file *file)
 {
-	if (file->f_op == &hugetlbfs_file_operations)
+	if (unlikely(file->f_mode & FMODE_HUGETLBFS))
 		return true;
-
-	return is_file_shm_hugepages(file);
+	return false;
 }
 
 static inline struct hstate *hstate_inode(struct inode *i)
@@ -449,7 +447,7 @@ static inline struct hstate *hstate_inode(struct inode *i)
 }
 #else /* !CONFIG_HUGETLBFS */
 
-#define is_file_hugepages(file)			false
+#define is_file_hugetlbfs(file)			false
 static inline struct file *
 hugetlb_file_setup(const char *name, size_t size, vm_flags_t acctflag,
 		struct user_struct **user, int creat_flags,
diff --git a/include/linux/shm.h b/include/linux/shm.h
index d8e69aed3d32..1ab62d7b334f 100644
--- a/include/linux/shm.h
+++ b/include/linux/shm.h
@@ -16,7 +16,6 @@ struct sysv_shm {
 
 long do_shmat(int shmid, char __user *shmaddr, int shmflg, unsigned long *addr,
 	      unsigned long shmlba);
-bool is_file_shm_hugepages(struct file *file);
 void exit_shm(struct task_struct *task);
 #define shm_init_task(task) INIT_LIST_HEAD(&(task)->sysvshm.shm_clist)
 #else
@@ -30,10 +29,6 @@ static inline long do_shmat(int shmid, char __user *shmaddr,
 {
 	return -ENOSYS;
 }
-static inline bool is_file_shm_hugepages(struct file *file)
-{
-	return false;
-}
 static inline void exit_shm(struct task_struct *task)
 {
 }
diff --git a/ipc/shm.c b/ipc/shm.c
index 0ba6add05b35..8f119b1d6170 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -285,7 +285,7 @@ static void shm_destroy(struct ipc_namespace *ns, struct shmid_kernel *shp)
 	ns->shm_tot -= (shp->shm_segsz + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	shm_rmid(ns, shp);
 	shm_unlock(shp);
-	if (!is_file_hugepages(shm_file))
+	if (!is_file_hugetlbfs(shm_file))
 		shmem_lock(shm_file, 0, shp->mlock_user);
 	else if (shp->mlock_user)
 		user_shm_unlock(i_size_read(file_inode(shm_file)),
@@ -560,24 +560,6 @@ static const struct file_operations shm_file_operations = {
 	.fallocate	= shm_fallocate,
 };
 
-/*
- * shm_file_operations_huge is now identical to shm_file_operations,
- * but we keep it distinct for the sake of is_file_shm_hugepages().
- */
-static const struct file_operations shm_file_operations_huge = {
-	.mmap		= shm_mmap,
-	.fsync		= shm_fsync,
-	.release	= shm_release,
-	.get_unmapped_area	= shm_get_unmapped_area,
-	.llseek		= noop_llseek,
-	.fallocate	= shm_fallocate,
-};
-
-bool is_file_shm_hugepages(struct file *file)
-{
-	return file->f_op == &shm_file_operations_huge;
-}
-
 static const struct vm_operations_struct shm_vm_ops = {
 	.open	= shm_open,	/* callback for a new vm-area open */
 	.close	= shm_close,	/* callback for when the vm-area is released */
@@ -698,7 +680,7 @@ static int newseg(struct ipc_namespace *ns, struct ipc_params *params)
 no_id:
 	ipc_update_pid(&shp->shm_cprid, NULL);
 	ipc_update_pid(&shp->shm_lprid, NULL);
-	if (is_file_hugepages(file) && shp->mlock_user)
+	if (is_file_hugetlbfs(file) && shp->mlock_user)
 		user_shm_unlock(size, shp->mlock_user);
 	fput(file);
 	ipc_rcu_putref(&shp->shm_perm, shm_rcu_free);
@@ -836,7 +818,7 @@ static void shm_add_rss_swap(struct shmid_kernel *shp,
 
 	inode = file_inode(shp->shm_file);
 
-	if (is_file_hugepages(shp->shm_file)) {
+	if (is_file_hugetlbfs(shp->shm_file)) {
 		struct address_space *mapping = inode->i_mapping;
 		struct hstate *h = hstate_file(shp->shm_file);
 		*rss_add += pages_per_huge_page(h) * mapping->nrpages;
@@ -1102,7 +1084,7 @@ static int shmctl_do_lock(struct ipc_namespace *ns, int shmid, int cmd)
 	}
 
 	shm_file = shp->shm_file;
-	if (is_file_hugepages(shm_file))
+	if (is_file_hugetlbfs(shm_file))
 		goto out_unlock0;
 
 	if (cmd == SHM_LOCK) {
@@ -1523,10 +1505,7 @@ long do_shmat(int shmid, char __user *shmaddr, int shmflg,
 		goto out_nattch;
 	}
 
-	file = alloc_file_clone(base, f_flags,
-			  is_file_hugepages(base) ?
-				&shm_file_operations_huge :
-				&shm_file_operations);
+	file = alloc_file_clone(base, f_flags, &shm_file_operations);
 	err = PTR_ERR(file);
 	if (IS_ERR(file)) {
 		kfree(sfd);
@@ -1534,6 +1513,9 @@ long do_shmat(int shmid, char __user *shmaddr, int shmflg,
 		goto out_nattch;
 	}
 
+	/* copy hugetlbfs mode for is_file_hugetlbfs() */
+	file->f_mode |= (base->f_mode & FMODE_HUGETLBFS);
+
 	sfd->id = shp->shm_perm.id;
 	sfd->ns = get_ipc_ns(ns);
 	sfd->file = base;
diff --git a/mm/memfd.c b/mm/memfd.c
index 2647c898990c..e6c16b6bf3f6 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -123,7 +123,7 @@ static unsigned int *memfd_file_seals_ptr(struct file *file)
 		return &SHMEM_I(file_inode(file))->seals;
 
 #ifdef CONFIG_HUGETLBFS
-	if (is_file_hugepages(file))
+	if (is_file_hugetlbfs(file))
 		return &HUGETLBFS_I(file_inode(file))->seals;
 #endif
 
diff --git a/mm/mmap.c b/mm/mmap.c
index f609e9ec4a25..703a9680a937 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1538,7 +1538,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 			vm_flags |= VM_NORESERVE;
 
 		/* hugetlb applies strict overcommit unless MAP_NORESERVE */
-		if (file && is_file_hugepages(file))
+		if (file && is_file_hugetlbfs(file))
 			vm_flags |= VM_NORESERVE;
 	}
 
@@ -1562,10 +1562,10 @@ unsigned long ksys_mmap_pgoff(unsigned long addr, unsigned long len,
 		file = fget(fd);
 		if (!file)
 			return -EBADF;
-		if (is_file_hugepages(file))
+		if (is_file_hugetlbfs(file))
 			len = ALIGN(len, huge_page_size(hstate_file(file)));
 		retval = -EINVAL;
-		if (unlikely(flags & MAP_HUGETLB && !is_file_hugepages(file)))
+		if (unlikely(flags & MAP_HUGETLB && !is_file_hugetlbfs(file)))
 			goto out_fput;
 	} else if (flags & MAP_HUGETLB) {
 		struct user_struct *user = NULL;
@@ -1678,7 +1678,7 @@ static inline int accountable_mapping(struct file *file, vm_flags_t vm_flags)
 	 * hugetlb has its own accounting separate from the core VM
 	 * VM_HUGETLB may not be set yet so we cannot check for that flag.
 	 */
-	if (file && is_file_hugepages(file))
+	if (file && is_file_hugetlbfs(file))
 		return 0;
 
 	return (vm_flags & (VM_NORESERVE | VM_SHARED | VM_WRITE)) == VM_WRITE;
-- 
2.25.4

