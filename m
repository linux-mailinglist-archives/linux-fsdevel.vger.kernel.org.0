Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 324573DB4A7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jul 2021 09:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237888AbhG3HqB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jul 2021 03:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237667AbhG3Hp7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jul 2021 03:45:59 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12798C0613C1
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jul 2021 00:45:54 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id 129so8613331qkg.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jul 2021 00:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=Hjb4Qvz+d4rYfp83KEA4cSUCQ4NRMEv6hD5clar2zEo=;
        b=a7HxZWdRuQp/zhxdj9ZcSffkcLO8HYoMF85EQHR69lnn6lWZFwTxyv1XpqKMeLtIqv
         XIXaGDHJwfWpAl+KwQV0h6XIqzYEOWE60HA9eqcxGD37L31oqLG3edyDXvQ8Retknk6K
         0WuRqc35Hc3ncI3tEDPx4nIPfhoOoxRviPd0VD2XUuZ+hb4W1vHQugu6R4CpXCa/DO8C
         KSOXL82pzPwx3B5pU6GJNxVM/E22uC7bFDvuHFjKggCu97Z4dxW6o33YLWi4uEDKMi6K
         z/rRSowG6Za2DhA/BYRuReLIYJQ/tXN+EonrH/gzp+MW3wGfZKCQhOAp8C0SrnHPDetw
         UGeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=Hjb4Qvz+d4rYfp83KEA4cSUCQ4NRMEv6hD5clar2zEo=;
        b=IBaK5T/yhEl69Sw5nC7/gic5yqgVoaaCGrP3qOQLhzbZjG5jmMCUfUyqMk/MB3rQI0
         Ep9ngGruz+7Ga4N9iG+KYKl5JwZatpse4nBdw/v2Kwl3YcOyxS1cw5HNNkP2F8/GT2aL
         Ih/q9GizNULn8+aG3EN+KQUY94BUW1zMIkvsTnEU7JjcrGcAxXT/vuhe6e/d5ODR9yls
         ZOVk6Op2MQggvBWyFPnJSQrEQ2DobtE4yjLzQz9gsY7BOUCotr9WuoRZj7cB766GeX/+
         cncmnmloMxzmab0V4ub3eJJieBZm4UNgzuDxXvF/cPuC7FjfVJ71YzzR+IRY3EjbnD79
         hF9Q==
X-Gm-Message-State: AOAM530s8ajAhpAaySc6y8sH/wlFI6V/yV3IihsQyhdRnXw3cPw8jGep
        c+vI/zP/5PaIR4MSGyG06TWDEg==
X-Google-Smtp-Source: ABdhPJyxwl7K7cMuTTQwVGAyfcH23tbKgh3bhsC84QKSqBFc0wlrNsNL3TZXdmX5JSzubXT3+108+A==
X-Received: by 2002:ae9:e901:: with SMTP id x1mr1079559qkf.360.1627631153052;
        Fri, 30 Jul 2021 00:45:53 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id x125sm539177qkd.8.2021.07.30.00.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 00:45:52 -0700 (PDT)
Date:   Fri, 30 Jul 2021 00:45:49 -0700 (PDT)
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
Subject: [PATCH 07/16] memfd: memfd_create(name, MFD_HUGEPAGE) for shmem huge
 pages
In-Reply-To: <2862852d-badd-7486-3a8e-c5ea9666d6fb@google.com>
Message-ID: <c140f56a-1aa3-f7ae-b7d1-93da7d5a3572@google.com>
References: <2862852d-badd-7486-3a8e-c5ea9666d6fb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Commit 749df87bd7be ("mm/shmem: add hugetlbfs support to memfd_create()")
in 4.14 added the MFD_HUGETLB flag to memfd_create(), to use hugetlbfs
pages instead of tmpfs pages: now add the MFD_HUGEPAGE flag, to use tmpfs
Transparent Huge Pages when they can be allocated (flag named to follow
the precedent of madvise's MADV_HUGEPAGE for THPs).

/sys/kernel/mm/transparent_hugepage/shmem_enabled "always" or "force"
already made this possible: but that is much too blunt an instrument,
affecting all the very different kinds of files on the internal shmem
mount, and was intended just for ease of testing hugepage loads.

MFD_HUGEPAGE is implemented internally by VM_HUGEPAGE in the shmem inode
flags: do not permit a PR_SET_THP_DISABLE (MMF_DISABLE_THP) task to set
this flag, and do not set it if THPs are not allowed at all; but let the
memfd_create() succeed even in those cases - the caller wants to create a
memfd, just hinting how it's best allocated if huge pages are available.

shmem_is_huge() (at allocation time or khugepaged time) applies its
SHMEM_HUGE_DENY and vma VM_NOHUGEPAGE and vm_mm MMF_DISABLE_THP checks
first, and only then allows the memfd's MFD_HUGEPAGE to take effect.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 include/uapi/linux/memfd.h |  3 ++-
 mm/memfd.c                 | 24 ++++++++++++++++++------
 mm/shmem.c                 | 33 +++++++++++++++++++++++++++++++--
 3 files changed, 51 insertions(+), 9 deletions(-)

diff --git a/include/uapi/linux/memfd.h b/include/uapi/linux/memfd.h
index 7a8a26751c23..8358a69e78cc 100644
--- a/include/uapi/linux/memfd.h
+++ b/include/uapi/linux/memfd.h
@@ -7,7 +7,8 @@
 /* flags for memfd_create(2) (unsigned int) */
 #define MFD_CLOEXEC		0x0001U
 #define MFD_ALLOW_SEALING	0x0002U
-#define MFD_HUGETLB		0x0004U
+#define MFD_HUGETLB		0x0004U		/* Use hugetlbfs */
+#define MFD_HUGEPAGE		0x0008U		/* Use huge tmpfs */
 
 /*
  * Huge page size encoding when MFD_HUGETLB is specified, and a huge page
diff --git a/mm/memfd.c b/mm/memfd.c
index 081dd33e6a61..0d1a504d2fc9 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -245,7 +245,10 @@ long memfd_fcntl(struct file *file, unsigned int cmd, unsigned long arg)
 #define MFD_NAME_PREFIX_LEN (sizeof(MFD_NAME_PREFIX) - 1)
 #define MFD_NAME_MAX_LEN (NAME_MAX - MFD_NAME_PREFIX_LEN)
 
-#define MFD_ALL_FLAGS (MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_HUGETLB)
+#define MFD_ALL_FLAGS  (MFD_CLOEXEC | \
+			MFD_ALLOW_SEALING | \
+			MFD_HUGETLB | \
+			MFD_HUGEPAGE)
 
 SYSCALL_DEFINE2(memfd_create,
 		const char __user *, uname,
@@ -257,14 +260,17 @@ SYSCALL_DEFINE2(memfd_create,
 	char *name;
 	long len;
 
-	if (!(flags & MFD_HUGETLB)) {
-		if (flags & ~(unsigned int)MFD_ALL_FLAGS)
+	if (flags & MFD_HUGETLB) {
+		/* Disallow huge tmpfs when choosing hugetlbfs */
+		if (flags & MFD_HUGEPAGE)
 			return -EINVAL;
-	} else {
 		/* Allow huge page size encoding in flags. */
 		if (flags & ~(unsigned int)(MFD_ALL_FLAGS |
 				(MFD_HUGE_MASK << MFD_HUGE_SHIFT)))
 			return -EINVAL;
+	} else {
+		if (flags & ~(unsigned int)MFD_ALL_FLAGS)
+			return -EINVAL;
 	}
 
 	/* length includes terminating zero */
@@ -303,8 +309,14 @@ SYSCALL_DEFINE2(memfd_create,
 					HUGETLB_ANONHUGE_INODE,
 					(flags >> MFD_HUGE_SHIFT) &
 					MFD_HUGE_MASK);
-	} else
-		file = shmem_file_setup(name, 0, VM_NORESERVE);
+	} else {
+		unsigned long vm_flags = VM_NORESERVE;
+
+		if (flags & MFD_HUGEPAGE)
+			vm_flags |= VM_HUGEPAGE;
+		file = shmem_file_setup(name, 0, vm_flags);
+	}
+
 	if (IS_ERR(file)) {
 		error = PTR_ERR(file);
 		goto err_fd;
diff --git a/mm/shmem.c b/mm/shmem.c
index 6def7391084c..e2bcf3313686 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -476,6 +476,20 @@ static bool shmem_confirm_swap(struct address_space *mapping,
 
 static int shmem_huge __read_mostly = SHMEM_HUGE_NEVER;
 
+/*
+ * Does either /sys/kernel/mm/transparent_hugepage/shmem_enabled or
+ * /sys/kernel/mm/transparent_hugepage/enabled allow transparent hugepages?
+ * (Can only return true when the machine has_transparent_hugepage() too.)
+ */
+static bool transparent_hugepage_allowed(void)
+{
+	return	shmem_huge > SHMEM_HUGE_NEVER ||
+		test_bit(TRANSPARENT_HUGEPAGE_FLAG,
+			&transparent_hugepage_flags) ||
+		test_bit(TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG,
+			&transparent_hugepage_flags);
+}
+
 bool shmem_is_huge(struct vm_area_struct *vma,
 		   struct inode *inode, pgoff_t index)
 {
@@ -486,6 +500,8 @@ bool shmem_is_huge(struct vm_area_struct *vma,
 	if (vma && ((vma->vm_flags & VM_NOHUGEPAGE) ||
 	    test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags)))
 		return false;
+	if (SHMEM_I(inode)->flags & VM_HUGEPAGE)
+		return true;
 	if (shmem_huge == SHMEM_HUGE_FORCE)
 		return true;
 
@@ -676,6 +692,11 @@ static long shmem_unused_huge_count(struct super_block *sb,
 
 #define shmem_huge SHMEM_HUGE_DENY
 
+bool transparent_hugepage_allowed(void)
+{
+	return false;
+}
+
 bool shmem_is_huge(struct vm_area_struct *vma,
 		   struct inode *inode, pgoff_t index)
 {
@@ -2171,10 +2192,14 @@ unsigned long shmem_get_unmapped_area(struct file *file,
 
 	if (shmem_huge != SHMEM_HUGE_FORCE) {
 		struct super_block *sb;
+		struct inode *inode;
 
 		if (file) {
 			VM_BUG_ON(file->f_op != &shmem_file_operations);
-			sb = file_inode(file)->i_sb;
+			inode = file_inode(file);
+			if (SHMEM_I(inode)->flags & VM_HUGEPAGE)
+				goto huge;
+			sb = inode->i_sb;
 		} else {
 			/*
 			 * Called directly from mm/mmap.c, or drivers/char/mem.c
@@ -2187,7 +2212,7 @@ unsigned long shmem_get_unmapped_area(struct file *file,
 		if (SHMEM_SB(sb)->huge == SHMEM_HUGE_NEVER)
 			return addr;
 	}
-
+huge:
 	offset = (pgoff << PAGE_SHIFT) & (HPAGE_PMD_SIZE-1);
 	if (offset && offset + len < 2 * HPAGE_PMD_SIZE)
 		return addr;
@@ -2308,6 +2333,10 @@ static struct inode *shmem_get_inode(struct super_block *sb, const struct inode
 		atomic_set(&info->stop_eviction, 0);
 		info->seals = F_SEAL_SEAL;
 		info->flags = flags & VM_NORESERVE;
+		if ((flags & VM_HUGEPAGE) &&
+		    transparent_hugepage_allowed() &&
+		    !test_bit(MMF_DISABLE_THP, &current->mm->flags))
+			info->flags |= VM_HUGEPAGE;
 		INIT_LIST_HEAD(&info->shrinklist);
 		INIT_LIST_HEAD(&info->swaplist);
 		simple_xattrs_init(&info->xattrs);
-- 
2.26.2

