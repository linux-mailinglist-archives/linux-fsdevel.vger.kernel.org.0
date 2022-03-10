Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B55F44D48A9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 15:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242704AbiCJOKq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Mar 2022 09:10:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239848AbiCJOKp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Mar 2022 09:10:45 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99DD25B3E9;
        Thu, 10 Mar 2022 06:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646921384; x=1678457384;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=HfTyQumQLz3rZd208DGi7M1QzPzA68CVqOu0FcAUOfs=;
  b=dDBCisZooMBX55z0pvOo7BwiNT5YhNhADPCorGQXClD5946mFRGHoO9V
   T9F6wuZ4663tySstqAAqxykQcxCAKAWx5y17YpVc00QZpWB1yEX6ZLR87
   3PDBjoJJTOLyjXazfvDqE6Ly2NvfrV/dbMyGx+uZlQhHX/A6S+eLELFQe
   FT3uIk5rxUKPaOxtAaPf/nxZ0lkGQuditkFAnUPs08i78z33frS+TlyW6
   9FPaWYGWZCNpYX0Fd3EHgTDcUQlUAq7+rwQhvz7H5qNeAAGuBQ76r3/GR
   WOAz9SjxQo+5CPduqTT05vZGwagZJtSvoJQwHtAMGVBiJ3IgWRAYx/R1J
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="318479227"
X-IronPort-AV: E=Sophos;i="5.90,170,1643702400"; 
   d="scan'208";a="318479227"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 06:09:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,170,1643702400"; 
   d="scan'208";a="554654769"
Received: from chaop.bj.intel.com ([10.240.192.101])
  by orsmga008.jf.intel.com with ESMTP; 10 Mar 2022 06:09:36 -0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, qemu-devel@nongnu.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com
Subject: [PATCH v5 01/13] mm/memfd: Introduce MFD_INACCESSIBLE flag
Date:   Thu, 10 Mar 2022 22:08:59 +0800
Message-Id: <20220310140911.50924-2-chao.p.peng@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220310140911.50924-1-chao.p.peng@linux.intel.com>
References: <20220310140911.50924-1-chao.p.peng@linux.intel.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

Introduce a new memfd_create() flag indicating the content of the
created memfd is inaccessible from userspace through ordinary MMU
access (e.g., read/write/mmap). However, the file content can be
accessed via a different mechanism (e.g. KVM MMU) indirectly.

It provides semantics required for KVM guest private memory support
that a file descriptor with this flag set is going to be used as the
source of guest memory in confidential computing environments such
as Intel TDX/AMD SEV but may not be accessible from host userspace.

Since page migration/swapping is not yet supported for such usages
so these pages are currently marked as UNMOVABLE and UNEVICTABLE
which makes them behave like long-term pinned pages.

The flag can not coexist with MFD_ALLOW_SEALING, future sealing is
also impossible for a memfd created with this flag.

At this time only shmem implements this flag.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
---
 include/linux/shmem_fs.h   |  7 +++++
 include/uapi/linux/memfd.h |  1 +
 mm/memfd.c                 | 26 +++++++++++++++--
 mm/shmem.c                 | 57 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 88 insertions(+), 3 deletions(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index e65b80ed09e7..2dde843f28ef 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -12,6 +12,9 @@
 
 /* inode in-kernel data */
 
+/* shmem extended flags */
+#define SHM_F_INACCESSIBLE	0x0001  /* prevent ordinary MMU access (e.g. read/write/mmap) to file content */
+
 struct shmem_inode_info {
 	spinlock_t		lock;
 	unsigned int		seals;		/* shmem seals */
@@ -24,6 +27,7 @@ struct shmem_inode_info {
 	struct shared_policy	policy;		/* NUMA memory alloc policy */
 	struct simple_xattrs	xattrs;		/* list of xattrs */
 	atomic_t		stop_eviction;	/* hold when working on inode */
+	unsigned int		xflags;		/* shmem extended flags */
 	struct inode		vfs_inode;
 };
 
@@ -61,6 +65,9 @@ extern struct file *shmem_file_setup(const char *name,
 					loff_t size, unsigned long flags);
 extern struct file *shmem_kernel_file_setup(const char *name, loff_t size,
 					    unsigned long flags);
+extern struct file *shmem_file_setup_xflags(const char *name, loff_t size,
+					    unsigned long flags,
+					    unsigned int xflags);
 extern struct file *shmem_file_setup_with_mnt(struct vfsmount *mnt,
 		const char *name, loff_t size, unsigned long flags);
 extern int shmem_zero_setup(struct vm_area_struct *);
diff --git a/include/uapi/linux/memfd.h b/include/uapi/linux/memfd.h
index 7a8a26751c23..48750474b904 100644
--- a/include/uapi/linux/memfd.h
+++ b/include/uapi/linux/memfd.h
@@ -8,6 +8,7 @@
 #define MFD_CLOEXEC		0x0001U
 #define MFD_ALLOW_SEALING	0x0002U
 #define MFD_HUGETLB		0x0004U
+#define MFD_INACCESSIBLE	0x0008U
 
 /*
  * Huge page size encoding when MFD_HUGETLB is specified, and a huge page
diff --git a/mm/memfd.c b/mm/memfd.c
index 9f80f162791a..74d45a26cf5d 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -245,16 +245,20 @@ long memfd_fcntl(struct file *file, unsigned int cmd, unsigned long arg)
 #define MFD_NAME_PREFIX_LEN (sizeof(MFD_NAME_PREFIX) - 1)
 #define MFD_NAME_MAX_LEN (NAME_MAX - MFD_NAME_PREFIX_LEN)
 
-#define MFD_ALL_FLAGS (MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_HUGETLB)
+#define MFD_ALL_FLAGS (MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_HUGETLB | \
+		       MFD_INACCESSIBLE)
 
 SYSCALL_DEFINE2(memfd_create,
 		const char __user *, uname,
 		unsigned int, flags)
 {
+	struct address_space *mapping;
 	unsigned int *file_seals;
+	unsigned int xflags;
 	struct file *file;
 	int fd, error;
 	char *name;
+	gfp_t gfp;
 	long len;
 
 	if (!(flags & MFD_HUGETLB)) {
@@ -267,6 +271,10 @@ SYSCALL_DEFINE2(memfd_create,
 			return -EINVAL;
 	}
 
+	/* Disallow sealing when MFD_INACCESSIBLE is set. */
+	if (flags & MFD_INACCESSIBLE && flags & MFD_ALLOW_SEALING)
+		return -EINVAL;
+
 	/* length includes terminating zero */
 	len = strnlen_user(uname, MFD_NAME_MAX_LEN + 1);
 	if (len <= 0)
@@ -301,8 +309,11 @@ SYSCALL_DEFINE2(memfd_create,
 					HUGETLB_ANONHUGE_INODE,
 					(flags >> MFD_HUGE_SHIFT) &
 					MFD_HUGE_MASK);
-	} else
-		file = shmem_file_setup(name, 0, VM_NORESERVE);
+	} else {
+		xflags = flags & MFD_INACCESSIBLE ? SHM_F_INACCESSIBLE : 0;
+		file = shmem_file_setup_xflags(name, 0, VM_NORESERVE, xflags);
+	}
+
 	if (IS_ERR(file)) {
 		error = PTR_ERR(file);
 		goto err_fd;
@@ -313,6 +324,15 @@ SYSCALL_DEFINE2(memfd_create,
 	if (flags & MFD_ALLOW_SEALING) {
 		file_seals = memfd_file_seals_ptr(file);
 		*file_seals &= ~F_SEAL_SEAL;
+	} else if (flags & MFD_INACCESSIBLE) {
+		mapping = file_inode(file)->i_mapping;
+		gfp = mapping_gfp_mask(mapping);
+		gfp &= ~__GFP_MOVABLE;
+		mapping_set_gfp_mask(mapping, gfp);
+		mapping_set_unevictable(mapping);
+
+		file_seals = memfd_file_seals_ptr(file);
+		*file_seals = F_SEAL_SEAL;
 	}
 
 	fd_install(fd, file);
diff --git a/mm/shmem.c b/mm/shmem.c
index a09b29ec2b45..9b31a7056009 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1084,6 +1084,13 @@ static int shmem_setattr(struct user_namespace *mnt_userns,
 		    (newsize > oldsize && (info->seals & F_SEAL_GROW)))
 			return -EPERM;
 
+		if (info->xflags & SHM_F_INACCESSIBLE) {
+			if(oldsize)
+				return -EPERM;
+			if (!PAGE_ALIGNED(newsize))
+				return -EINVAL;
+		}
+
 		if (newsize != oldsize) {
 			error = shmem_reacct_size(SHMEM_I(inode)->flags,
 					oldsize, newsize);
@@ -1331,6 +1338,8 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
 		goto redirty;
 	if (!total_swap_pages)
 		goto redirty;
+	if (info->xflags & SHM_F_INACCESSIBLE)
+		goto redirty;
 
 	/*
 	 * Our capabilities prevent regular writeback or sync from ever calling
@@ -2228,6 +2237,9 @@ static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
 	if (ret)
 		return ret;
 
+	if (info->xflags & SHM_F_INACCESSIBLE)
+		return -EPERM;
+
 	/* arm64 - allow memory tagging on RAM-based files */
 	vma->vm_flags |= VM_MTE_ALLOWED;
 
@@ -2433,6 +2445,8 @@ shmem_write_begin(struct file *file, struct address_space *mapping,
 		if ((info->seals & F_SEAL_GROW) && pos + len > inode->i_size)
 			return -EPERM;
 	}
+	if (unlikely(info->xflags & SHM_F_INACCESSIBLE))
+		return -EPERM;
 
 	ret = shmem_getpage(inode, index, pagep, SGP_WRITE);
 
@@ -2517,6 +2531,21 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		end_index = i_size >> PAGE_SHIFT;
 		if (index > end_index)
 			break;
+
+		/*
+		 * inode_lock protects setting up seals as well as write to
+		 * i_size. Setting SHM_F_INACCESSIBLE only allowed with
+		 * i_size == 0.
+		 *
+		 * Check SHM_F_INACCESSIBLE after i_size. It effectively
+		 * serialize read vs. setting SHM_F_INACCESSIBLE without
+		 * taking inode_lock in read path.
+		 */
+		if (SHMEM_I(inode)->xflags & SHM_F_INACCESSIBLE) {
+			error = -EPERM;
+			break;
+		}
+
 		if (index == end_index) {
 			nr = i_size & ~PAGE_MASK;
 			if (nr <= offset)
@@ -2648,6 +2677,12 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
 			goto out;
 		}
 
+		if ((info->xflags & SHM_F_INACCESSIBLE) &&
+		    (!PAGE_ALIGNED(offset) || !PAGE_ALIGNED(len))) {
+			error = -EINVAL;
+			goto out;
+		}
+
 		shmem_falloc.waitq = &shmem_falloc_waitq;
 		shmem_falloc.start = (u64)unmap_start >> PAGE_SHIFT;
 		shmem_falloc.next = (unmap_end + 1) >> PAGE_SHIFT;
@@ -4082,6 +4117,28 @@ struct file *shmem_kernel_file_setup(const char *name, loff_t size, unsigned lon
 	return __shmem_file_setup(shm_mnt, name, size, flags, S_PRIVATE);
 }
 
+/**
+ * shmem_file_setup_xflags - get an unlinked file living in tmpfs with
+ *      additional xflags.
+ * @name: name for dentry (to be seen in /proc/<pid>/maps
+ * @size: size to be set for the file
+ * @flags: VM_NORESERVE suppresses pre-accounting of the entire object size
+ * @xflags: SHM_F_INACCESSIBLE prevents ordinary MMU access to the file content
+ */
+
+struct file *shmem_file_setup_xflags(const char *name, loff_t size,
+				     unsigned long flags, unsigned int xflags)
+{
+	struct shmem_inode_info *info;
+	struct file *res = __shmem_file_setup(shm_mnt, name, size, flags, 0);
+
+	if(!IS_ERR(res)) {
+		info = SHMEM_I(file_inode(res));
+		info->xflags = xflags & SHM_F_INACCESSIBLE;
+	}
+	return res;
+}
+
 /**
  * shmem_file_setup - get an unlinked file living in tmpfs
  * @name: name for dentry (to be seen in /proc/<pid>/maps
-- 
2.17.1

