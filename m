Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 836213DB4C1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jul 2021 09:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238001AbhG3Hzd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jul 2021 03:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237851AbhG3Hzc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jul 2021 03:55:32 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17EFCC0613C1
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jul 2021 00:55:27 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id z26so12066885oih.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jul 2021 00:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=RMStr+4np8YoPskN92/pPzruONJ2EqyVRrBa1/D0LCs=;
        b=lh3y8fimrdjE5vv7C7NyR40xZo8b9wN1o3GcQD0WrNYcvMjTmwIS6m0UMTToLDPzzO
         jhutDxwEI4Q7aJlj0GMTeFqxg36Fv2SGHWPMk7ZPouhevmncddjx8PurTfOHM1GDu/F8
         +VGmQ6zWUTWxhfZwjrrfQByl393WiN0qmjTFmGBTcb5U2EvBgDzbF+KRr1ottqHHqtbn
         Ql+PvNOOxbFRvUaB2lkdQF3Q88RM8SbpvlQI32xnBMz0YioHyWzCESA7J4P65h2XFaHu
         NYB9AnDqs9ENYBY/SqoiP1dbOATAyQKOztzTSITS2KFz5bHR6LAd7H7U0q+jP4snrGe1
         QH9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=RMStr+4np8YoPskN92/pPzruONJ2EqyVRrBa1/D0LCs=;
        b=WLm9vn11PUeGuUka4vYLy43rmnipT0qJm7ZcSAo2iwP4mlHnV4g4vNjQbAXylh3jl7
         zkt0vfANEnezBMblnr0AKUT7FtZ87XPTq2ujBvMHP4sYgWeFAbds9OfrgpfHAZgR/LA3
         pG5opJG8biaOnKDk2l9Na5JbdjoSu+V+MCnJtD6egvTkcDPAcRuUtvjbkqoK6hgRnt3c
         jLfVCKo7Hw0Lv2Xr3cgSFRTWDn4EzmBky/0WkSCnAi8LG2perkveMhbayKQ4E3bwkmZF
         BSmiIPqbjiIRvX3JET9YpclC8HWa7pJDceumZqiPS+g7fpI0e2phqrG36ha1g4VUrTNZ
         kwqA==
X-Gm-Message-State: AOAM533JBwFaJf9qiQAoB/WR8+kFu3LNXnme6gPDXzBpo4AmMEMbXFzk
        V/UdI5P8IkWH11G53kBA+22n/A==
X-Google-Smtp-Source: ABdhPJy4kWg+4Sk9qcVwxcHQBhMXif/y5EwKo/yp8CClsDo7kMW10/4mmrm6MeykZRLm4UnpUK6b+A==
X-Received: by 2002:a54:4d8f:: with SMTP id y15mr1065690oix.32.1627631726130;
        Fri, 30 Jul 2021 00:55:26 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id i20sm135085ook.12.2021.07.30.00.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 00:55:25 -0700 (PDT)
Date:   Fri, 30 Jul 2021 00:55:22 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Auld <matthew.auld@intel.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 10/16] tmpfs: fcntl(fd, F_MEM_LOCK) to memlock a tmpfs file
In-Reply-To: <2862852d-badd-7486-3a8e-c5ea9666d6fb@google.com>
Message-ID: <54e03798-d836-ae64-f41-4a1d46bc115b@google.com>
References: <2862852d-badd-7486-3a8e-c5ea9666d6fb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Shakeel Butt <shakeelb@google.com>

A new uapi to lock the files on tmpfs in memory, to protect against swap
without mapping the files. This commit introduces two new commands to
fcntl and shmem: F_MEM_LOCK and F_MEM_UNLOCK. The locking will be
charged against RLIMIT_MEMLOCK of uid in namespace of the caller.

This feature is implemented by mostly re-using the shmctl's SHM_LOCK
mechanism (System V IPC shared memory). This api follows the design
choices of shmctl's SHM_LOCK and also of mlock2 syscall where pages
on swap are not populated on the syscall. The pages will be brought
to memory on first access.

As with System V shared memory, these pages are counted as Unevictable
in /proc/meminfo (when they are allocated, or when page reclaim finds
any allocated earlier), but they are not counted as Mlocked there.

For simplicity the locked files are forbidden to grow or shrink
to keep the user accounting simple. This design decision will be
revisited once such use-case arises.

The permissions to lock and unlock differs slightly from other similar
interfaces. Anyone having CAP_IPC_LOCK or remaining rlimit can lock
the file, but the unlocker has to have either CAP_IPC_LOCK or it
should be the locker itself.

This commit does not make the locked status of a tmpfs file visible.
We can add an F_MEM_LOCKED fcntl later, to query that status if
required; but it's not yet clear how best to make it visible.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
Signed-off-by: Hugh Dickins <hughd@google.com>
---
 fs/fcntl.c                 |  2 ++
 include/linux/shmem_fs.h   |  1 +
 include/uapi/linux/fcntl.h |  7 +++++
 mm/shmem.c                 | 59 ++++++++++++++++++++++++++++++++++++--
 4 files changed, 66 insertions(+), 3 deletions(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 9cfff87c3332..a3534764b50e 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -437,6 +437,8 @@ static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
 		break;
 	case F_HUGEPAGE:
 	case F_NOHUGEPAGE:
+	case F_MEM_LOCK:
+	case F_MEM_UNLOCK:
 		err = shmem_fcntl(filp, cmd, arg);
 		break;
 	default:
diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 51b75d74ce89..ffdd0da816e5 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -24,6 +24,7 @@ struct shmem_inode_info {
 	struct shared_policy	policy;		/* NUMA memory alloc policy */
 	struct simple_xattrs	xattrs;		/* list of xattrs */
 	atomic_t		stop_eviction;	/* hold when working on inode */
+	struct ucounts		*mlock_ucounts;	/* user memlocked tmpfs file */
 	struct inode		vfs_inode;
 };
 
diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index 10f82b223642..21dc969df0fd 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -82,6 +82,13 @@
 #define F_HUGEPAGE		(F_LINUX_SPECIFIC_BASE + 15)
 #define F_NOHUGEPAGE		(F_LINUX_SPECIFIC_BASE + 16)
 
+/*
+ * Lock all pages of file into memory, as they are allocated; or unlock them.
+ * Currently supported only on tmpfs, and on its memfd_created files.
+ */
+#define F_MEM_LOCK		(F_LINUX_SPECIFIC_BASE + 17)
+#define F_MEM_UNLOCK		(F_LINUX_SPECIFIC_BASE + 18)
+
 /*
  * Types of directory notifications that may be requested.
  */
diff --git a/mm/shmem.c b/mm/shmem.c
index f50f2ede71da..ba9b9900287b 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -888,7 +888,7 @@ unsigned long shmem_swap_usage(struct vm_area_struct *vma)
 }
 
 /*
- * SysV IPC SHM_UNLOCK restore Unevictable pages to their evictable lists.
+ * SHM_UNLOCK or F_MEM_UNLOCK restore Unevictable pages to their evictable list.
  */
 void shmem_unlock_mapping(struct address_space *mapping)
 {
@@ -897,7 +897,7 @@ void shmem_unlock_mapping(struct address_space *mapping)
 
 	pagevec_init(&pvec);
 	/*
-	 * Minor point, but we might as well stop if someone else SHM_LOCKs it.
+	 * Minor point, but we might as well stop if someone else memlocks it.
 	 */
 	while (!mapping_unevictable(mapping)) {
 		if (!pagevec_lookup(&pvec, mapping, &index))
@@ -1123,7 +1123,8 @@ static int shmem_setattr(struct user_namespace *mnt_userns,
 
 		/* protected by i_mutex */
 		if ((newsize < oldsize && (info->seals & F_SEAL_SHRINK)) ||
-		    (newsize > oldsize && (info->seals & F_SEAL_GROW)))
+		    (newsize > oldsize && (info->seals & F_SEAL_GROW)) ||
+		    (newsize != oldsize && info->mlock_ucounts))
 			return -EPERM;
 
 		if (newsize != oldsize) {
@@ -1161,6 +1162,10 @@ static void shmem_evict_inode(struct inode *inode)
 	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
 
 	if (shmem_mapping(inode->i_mapping)) {
+		if (info->mlock_ucounts) {
+			user_shm_unlock(inode->i_size, info->mlock_ucounts);
+			info->mlock_ucounts = NULL;
+		}
 		shmem_unacct_size(info->flags, inode->i_size);
 		inode->i_size = 0;
 		shmem_truncate_range(inode, 0, (loff_t)-1);
@@ -2266,6 +2271,7 @@ int shmem_lock(struct file *file, int lock, struct ucounts *ucounts)
 
 	/*
 	 * What serializes the accesses to info->flags?
+	 * inode_lock() when called from shmem_memlock_fcntl(),
 	 * ipc_lock_object() when called from shmctl_do_lock(),
 	 * no serialization needed when called from shm_destroy().
 	 */
@@ -2286,6 +2292,43 @@ int shmem_lock(struct file *file, int lock, struct ucounts *ucounts)
 	return retval;
 }
 
+static int shmem_memlock_fcntl(struct file *file, unsigned int cmd)
+{
+	struct inode *inode = file_inode(file);
+	struct shmem_inode_info *info = SHMEM_I(inode);
+	bool cleanup_mapping = false;
+	int retval = 0;
+
+	inode_lock(inode);
+	if (cmd == F_MEM_LOCK) {
+		if (!info->mlock_ucounts) {
+			struct ucounts *ucounts = current_ucounts();
+			/* capability/rlimit check is down in user_shm_lock */
+			retval = shmem_lock(file, 1, ucounts);
+			if (!retval)
+				info->mlock_ucounts = ucounts;
+			else if (!rlimit(RLIMIT_MEMLOCK))
+				retval = -EPERM;
+			/* else retval == -ENOMEM */
+		}
+	} else { /* F_MEM_UNLOCK */
+		if (info->mlock_ucounts) {
+			if (info->mlock_ucounts == current_ucounts() ||
+			    capable(CAP_IPC_LOCK)) {
+				shmem_lock(file, 0, info->mlock_ucounts);
+				info->mlock_ucounts = NULL;
+				cleanup_mapping = true;
+			} else
+				retval = -EPERM;
+		}
+	}
+	inode_unlock(inode);
+
+	if (cleanup_mapping)
+		shmem_unlock_mapping(file->f_mapping);
+	return retval;
+}
+
 static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct shmem_inode_info *info = SHMEM_I(file_inode(file));
@@ -2503,6 +2546,8 @@ shmem_write_begin(struct file *file, struct address_space *mapping,
 		if ((info->seals & F_SEAL_GROW) && pos + len > inode->i_size)
 			return -EPERM;
 	}
+	if (unlikely(info->mlock_ucounts) && pos + len > inode->i_size)
+		return -EPERM;
 
 	return shmem_getpage(inode, index, pagep, SGP_WRITE);
 }
@@ -2715,6 +2760,10 @@ long shmem_fcntl(struct file *file, unsigned int cmd, unsigned long arg)
 	case F_NOHUGEPAGE:
 		error = shmem_huge_fcntl(file, cmd);
 		break;
+	case F_MEM_LOCK:
+	case F_MEM_UNLOCK:
+		error = shmem_memlock_fcntl(file, cmd);
+		break;
 	}
 
 	return error;
@@ -2778,6 +2827,10 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
 		error = -EPERM;
 		goto out;
 	}
+	if (info->mlock_ucounts && offset + len > inode->i_size) {
+		error = -EPERM;
+		goto out;
+	}
 
 	start = offset >> PAGE_SHIFT;
 	end = (offset + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
-- 
2.26.2

