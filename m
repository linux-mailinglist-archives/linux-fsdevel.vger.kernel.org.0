Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2765D3DB4AC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jul 2021 09:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237824AbhG3Hsm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jul 2021 03:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbhG3Hsm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jul 2021 03:48:42 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F79C061765
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jul 2021 00:48:37 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id x9so5803124qtw.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jul 2021 00:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=EDpc0/d9Oj/hIds1HKJj7zYeYPkeXWmfcCU40dY3+sw=;
        b=mulBDyHU6yp0zs2CFm2s/qF8ZQrZf+J2EM92FJ7UD86JWzy6+B+y02mYtGpoe/bymr
         FulZ9jgWv8TSoZG2zmk+sh3BcGjARG5wTNH9RMKlhHCPgTdQ9t44NZmIsEgGqSX7T2eD
         ZPciAH+CbJ+bJ8Qkv/+dK/eJ6h2fJkahljPWaWbVMl0NaQvNAZyCdL6QRkftIXIxCfru
         FCfAjzrflmygFr09VLHPRLI4xj5kDYcsZ0yTrpmH6LR/6BSPrUqUw76Pt5G0B1yewiOt
         i3ppecxRxcCkJ1xMFXsBjQ7uC+2vG3bqwdqVS5Kk5oCB3p3WZ+BiUnt7eoup6ZDTLsQC
         H9JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=EDpc0/d9Oj/hIds1HKJj7zYeYPkeXWmfcCU40dY3+sw=;
        b=JaiJbsHs3/C2o66nEn2dXRYbwq9zQVzuOCknggEGSt51cwkGqezAxGj0BIq8U6Nszb
         Uc4Zw3seu3h2VgNZYL49gWZZWqW+uVD4gs+AK8iWRAniGD+zKR6ofwd/dIdKIhTBrMw8
         4V3M3LrbFYboupFUIMhH5d1QNaxDj3LYRf5c7C+I2ceAuyEcsfKrodyJf/Idm7fRuLiv
         NEDXMF2UpM72YYdh7MeWK7NT/bScaSPsd9RcZwGWi5BrTJbSx5tg1kZhzIYPYKuTFffD
         xIfnTOgmV8cDHZl/jeQ1jZIl7FUM5oJTHv6RkycKBN6YlOb4QztwFG/2IFaEItEW3pfx
         D5IA==
X-Gm-Message-State: AOAM532B2XxMxo3SXZVed2nFynm8kS0Z/HPoByK4NX8g7AHN3qa4h8LE
        9DLK4G670FE0k0EB0u2yJFB5ug==
X-Google-Smtp-Source: ABdhPJxpjf8WwHJfSjqtA9nxku8loLDko6+6MLVcrUnY5FWupM5kOcvLXGpW+9Cz0tLmMtD8aDa0vA==
X-Received: by 2002:ac8:a84:: with SMTP id d4mr1172505qti.109.1627631316774;
        Fri, 30 Jul 2021 00:48:36 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id l4sm304571qtr.62.2021.07.30.00.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 00:48:35 -0700 (PDT)
Date:   Fri, 30 Jul 2021 00:48:33 -0700 (PDT)
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
Subject: [PATCH 08/16] huge tmpfs: fcntl(fd, F_HUGEPAGE) and fcntl(fd,
 F_NOHUGEPAGE)
In-Reply-To: <2862852d-badd-7486-3a8e-c5ea9666d6fb@google.com>
Message-ID: <1c32c75b-095-22f0-aee3-30a44d4a4744@google.com>
References: <2862852d-badd-7486-3a8e-c5ea9666d6fb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add support for fcntl(fd, F_HUGEPAGE) and fcntl(fd, F_NOHUGEPAGE), to
select hugeness per file: useful to override the default hugeness of the
shmem mount, when occasionally needing to store a hugepage file in a
smallpage mount or vice versa.

These fcntls just specify whether or not to try for huge pages when
allocating to the object later: F_HUGEPAGE does not touch small pages
already allocated (though khugepaged may do so when the file is mapped
afterwards), F_NOHUGEPAGE does not split huge pages already allocated.

Why fcntl?  Because it's already in use (for sealing) on memfds; and I'm
anxious to keep this simple, just applying it to whole files: fallocate,
madvise and posix_fadvise each involve a range, which would need a new
kind of tree attached to the inode for proper support.  Any application
needing range support should be able to provide that from userspace, by
issuing the respective fcntl prior to instantiating each range.

Do not allow it when the file is open read-only (EBADF).  Do not permit
a PR_SET_THP_DISABLE (MMF_DISABLE_THP) task to interfere with the flags,
and do not let VM_HUGEPAGE be set if THPs are not allowed at all (EPERM).

Note that transparent_hugepage_allowed(), used to validate F_HUGEPAGE,
accepts (anon) transparent_hugepage_flags in addition to mount option.
This is to overcome the limitation of the "huge=advise" option, which
applies hugepage alignment (reducing ASLR) to all mappings, because
madvise(address,len,MADV_HUGEPAGE) needs address before it can be used.
So mount option "huge=never" gives a default which can be overridden by
fcntl(fd, F_HUGEPAGE) when /sys/kernel/mm/transparent_hugepage/enabled
is not "never" too.  (We could instead add a "huge=fcntl" mount option
between "never" and "advise", but I lack the enthusiasm for that.)

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 fs/fcntl.c                 |  5 +++
 include/linux/shmem_fs.h   |  8 +++++
 include/uapi/linux/fcntl.h |  9 +++++
 mm/shmem.c                 | 70 ++++++++++++++++++++++++++++++++++----
 4 files changed, 85 insertions(+), 7 deletions(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index f946bec8f1f1..9cfff87c3332 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -23,6 +23,7 @@
 #include <linux/rcupdate.h>
 #include <linux/pid_namespace.h>
 #include <linux/user_namespace.h>
+#include <linux/shmem_fs.h>
 #include <linux/memfd.h>
 #include <linux/compat.h>
 #include <linux/mount.h>
@@ -434,6 +435,10 @@ static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
 	case F_SET_FILE_RW_HINT:
 		err = fcntl_rw_hint(filp, cmd, arg);
 		break;
+	case F_HUGEPAGE:
+	case F_NOHUGEPAGE:
+		err = shmem_fcntl(filp, cmd, arg);
+		break;
 	default:
 		break;
 	}
diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 3b05a28e34c4..51b75d74ce89 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -67,6 +67,14 @@ extern int shmem_zero_setup(struct vm_area_struct *);
 extern unsigned long shmem_get_unmapped_area(struct file *, unsigned long addr,
 		unsigned long len, unsigned long pgoff, unsigned long flags);
 extern int shmem_lock(struct file *file, int lock, struct ucounts *ucounts);
+#ifdef CONFIG_TMPFS
+extern long shmem_fcntl(struct file *file, unsigned int cmd, unsigned long arg);
+#else
+static inline long shmem_fcntl(struct file *f, unsigned int c, unsigned long a)
+{
+	return -EINVAL;
+}
+#endif /* CONFIG_TMPFS */
 #ifdef CONFIG_SHMEM
 extern const struct address_space_operations shmem_aops;
 static inline bool shmem_mapping(struct address_space *mapping)
diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index 2f86b2ad6d7e..10f82b223642 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -73,6 +73,15 @@
  */
 #define RWF_WRITE_LIFE_NOT_SET	RWH_WRITE_LIFE_NOT_SET
 
+/*
+ * Allocate hugepages when available: useful on a tmpfs which was not mounted
+ * with the "huge=always" option, as for memfds.  And, do not allocate hugepages
+ * even when available: useful to cancel the above request, or make an exception
+ * on a tmpfs mounted with "huge=always" (without splitting existing hugepages).
+ */
+#define F_HUGEPAGE		(F_LINUX_SPECIFIC_BASE + 15)
+#define F_NOHUGEPAGE		(F_LINUX_SPECIFIC_BASE + 16)
+
 /*
  * Types of directory notifications that may be requested.
  */
diff --git a/mm/shmem.c b/mm/shmem.c
index e2bcf3313686..67a4b7a4849b 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -448,9 +448,9 @@ static bool shmem_confirm_swap(struct address_space *mapping,
  *	enables huge pages for the mount;
  * SHMEM_HUGE_WITHIN_SIZE:
  *	only allocate huge pages if the page will be fully within i_size,
- *	also respect fadvise()/madvise() hints;
+ *	also respect fcntl()/madvise() hints;
  * SHMEM_HUGE_ADVISE:
- *	only allocate huge pages if requested with fadvise()/madvise();
+ *	only allocate huge pages if requested with fcntl()/madvise().
  */
 
 #define SHMEM_HUGE_NEVER	0
@@ -477,13 +477,13 @@ static bool shmem_confirm_swap(struct address_space *mapping,
 static int shmem_huge __read_mostly = SHMEM_HUGE_NEVER;
 
 /*
- * Does either /sys/kernel/mm/transparent_hugepage/shmem_enabled or
+ * Does either tmpfs mount option (or transparent_hugepage/shmem_enabled) or
  * /sys/kernel/mm/transparent_hugepage/enabled allow transparent hugepages?
  * (Can only return true when the machine has_transparent_hugepage() too.)
  */
-static bool transparent_hugepage_allowed(void)
+static bool transparent_hugepage_allowed(struct shmem_sb_info *sbinfo)
 {
-	return	shmem_huge > SHMEM_HUGE_NEVER ||
+	return	sbinfo->huge > SHMEM_HUGE_NEVER ||
 		test_bit(TRANSPARENT_HUGEPAGE_FLAG,
 			&transparent_hugepage_flags) ||
 		test_bit(TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG,
@@ -500,6 +500,8 @@ bool shmem_is_huge(struct vm_area_struct *vma,
 	if (vma && ((vma->vm_flags & VM_NOHUGEPAGE) ||
 	    test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags)))
 		return false;
+	if (SHMEM_I(inode)->flags & VM_NOHUGEPAGE)
+		return false;
 	if (SHMEM_I(inode)->flags & VM_HUGEPAGE)
 		return true;
 	if (shmem_huge == SHMEM_HUGE_FORCE)
@@ -692,7 +694,7 @@ static long shmem_unused_huge_count(struct super_block *sb,
 
 #define shmem_huge SHMEM_HUGE_DENY
 
-bool transparent_hugepage_allowed(void)
+bool transparent_hugepage_allowed(struct shmem_sb_info *sbinfo)
 {
 	return false;
 }
@@ -2197,6 +2199,8 @@ unsigned long shmem_get_unmapped_area(struct file *file,
 		if (file) {
 			VM_BUG_ON(file->f_op != &shmem_file_operations);
 			inode = file_inode(file);
+			if (SHMEM_I(inode)->flags & VM_NOHUGEPAGE)
+				return addr;
 			if (SHMEM_I(inode)->flags & VM_HUGEPAGE)
 				goto huge;
 			sb = inode->i_sb;
@@ -2211,6 +2215,11 @@ unsigned long shmem_get_unmapped_area(struct file *file,
 		}
 		if (SHMEM_SB(sb)->huge == SHMEM_HUGE_NEVER)
 			return addr;
+		/*
+		 * Note that SHMEM_HUGE_ADVISE has to give out huge-aligned
+		 * addresses to everyone, because madvise(,,MADV_HUGEPAGE)
+		 * needs the address-chicken on which to advise if huge-egg.
+		 */
 	}
 huge:
 	offset = (pgoff << PAGE_SHIFT) & (HPAGE_PMD_SIZE-1);
@@ -2334,7 +2343,7 @@ static struct inode *shmem_get_inode(struct super_block *sb, const struct inode
 		info->seals = F_SEAL_SEAL;
 		info->flags = flags & VM_NORESERVE;
 		if ((flags & VM_HUGEPAGE) &&
-		    transparent_hugepage_allowed() &&
+		    transparent_hugepage_allowed(sbinfo) &&
 		    !test_bit(MMF_DISABLE_THP, &current->mm->flags))
 			info->flags |= VM_HUGEPAGE;
 		INIT_LIST_HEAD(&info->shrinklist);
@@ -2674,6 +2683,53 @@ static loff_t shmem_file_llseek(struct file *file, loff_t offset, int whence)
 	return offset;
 }
 
+static int shmem_huge_fcntl(struct file *file, unsigned int cmd)
+{
+	struct inode *inode = file_inode(file);
+	struct shmem_inode_info *info = SHMEM_I(inode);
+
+	if (!(file->f_mode & FMODE_WRITE))
+		return -EBADF;
+	if (test_bit(MMF_DISABLE_THP, &current->mm->flags))
+		return -EPERM;
+	if (cmd == F_HUGEPAGE &&
+	    !transparent_hugepage_allowed(SHMEM_SB(inode->i_sb)))
+		return -EPERM;
+
+	inode_lock(inode);
+	if (cmd == F_HUGEPAGE) {
+		info->flags &= ~VM_NOHUGEPAGE;
+		info->flags |= VM_HUGEPAGE;
+	} else {
+		info->flags &= ~VM_HUGEPAGE;
+		info->flags |= VM_NOHUGEPAGE;
+	}
+	inode_unlock(inode);
+	return 0;
+}
+
+long shmem_fcntl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	long error = -EINVAL;
+
+	if (file->f_op != &shmem_file_operations)
+		return error;
+
+	switch (cmd) {
+	/*
+	 * case F_ADD_SEALS:
+	 * case F_GET_SEALS:
+	 *	are handled by memfd_fcntl().
+	 */
+	case F_HUGEPAGE:
+	case F_NOHUGEPAGE:
+		error = shmem_huge_fcntl(file, cmd);
+		break;
+	}
+
+	return error;
+}
+
 static long shmem_fallocate(struct file *file, int mode, loff_t offset,
 							 loff_t len)
 {
-- 
2.26.2

