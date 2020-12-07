Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5547D2D0F8D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 12:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbgLGLhz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 06:37:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbgLGLfQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 06:35:16 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D81C08E860;
        Mon,  7 Dec 2020 03:34:58 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id c12so2530182pfo.10;
        Mon, 07 Dec 2020 03:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3Q5MS2UXjUQqUjTpuPXnY5Lc/xhe4Tibwul6rnRwWL4=;
        b=nW7tHnXavpC5taczb2SrIKzWwWUMvoY4U2MTkN3vDPPis+BUGXKaGqPDCsIxEfquXK
         6tmf6cEkdZTLCJdDXSh6MnNQCPBTV6kFB9HnhWkc91ozY0AAtLOOKkEMOqDBzYi4fqmn
         vakqjy46p1cUwbWXP/xi7QIAw9YzTSRnmgmnJrHoKXeAFo3V1L5iM3PHOBMX46KN5v3Z
         34HgCx9eDmAlKhggnpFYM8ACTmm6p267BNhSJCIFO9+Der0ooC1Q9+xIQNrzo5WPJwHE
         9owlGXBvga1yQ91B0OHtPxgNUCzR6oEuiJ6+Tvv4ZAklNhM3orxx6h4kzT/nmxGA3nGL
         lpuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Q5MS2UXjUQqUjTpuPXnY5Lc/xhe4Tibwul6rnRwWL4=;
        b=AOlZ6/m/ax7skDD1F4UBxGDn8M4zj7sPPxO4GHdt7OdxRIld8VqbMZI60BFphocRwx
         oud65dcah1PW0xGUZZ133E3KUE9QVeMfai4XBoUqT93rsO3L85Ts2Cqc4HiDUlOfBRq2
         gev7L+E8U8COcszGBE5y+fXUgMwfhbQe9UnZ2s5GCTOzPWuKLjQ7EtvNKtathNJ4ZACl
         JuYQefP7JYy2LtvlxC1Dy0YfZ6MlwqeMbxcg4MPoSXdvYbYjW+tZCGxcUw4e3Xxuk66K
         VjvRjbBezdyTlpeH20zeQx6vvOhlp1etxXW96aN6DDS9O/3fkjYKNE6J550l+kDdcH4R
         aaEw==
X-Gm-Message-State: AOAM530U14SZL7oezcpOjXqTJGf/SDCdPRvaonzlo45rE72nlx/nbxzZ
        8XYFWWqMR4eRjNOFSitazWk=
X-Google-Smtp-Source: ABdhPJzvNvnKPK0JB4i5KGpQCvE8rYhnqcuhj31K/F7yMqFfiJ9DwwOo6y8xk/RvjaqCiew/ogf9Kg==
X-Received: by 2002:a62:9205:0:b029:19d:bab0:ba17 with SMTP id o5-20020a6292050000b029019dbab0ba17mr15435970pfd.37.1607340898388;
        Mon, 07 Dec 2020 03:34:58 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id d4sm14219822pfo.127.2020.12.07.03.34.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Dec 2020 03:34:57 -0800 (PST)
From:   yulei.kernel@gmail.com
X-Google-Original-From: yuleixzhang@tencent.com
To:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, naoya.horiguchi@nec.com,
        viro@zeniv.linux.org.uk, pbonzini@redhat.com
Cc:     joao.m.martins@oracle.com, rdunlap@infradead.org,
        sean.j.christopherson@intel.com, xiaoguangrong.eric@gmail.com,
        kernellwp@gmail.com, lihaiwei.kernel@gmail.com,
        Yulei Zhang <yuleixzhang@tencent.com>,
        Chen Zhuo <sagazchen@tencent.com>
Subject: [RFC V2 23/37] kvm, x86: introduce VM_DMEM for syscall support usage
Date:   Mon,  7 Dec 2020 19:31:16 +0800
Message-Id: <aff53d725dd12615b3bb9412a7612cbb5fe15f2d.1607332046.git.yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1607332046.git.yuleixzhang@tencent.com>
References: <cover.1607332046.git.yuleixzhang@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Yulei Zhang <yuleixzhang@tencent.com>

Currently dmemfs do not support memory readonly, so change_protection()
will be disabled for dmemfs vma. Since vma->vm_flags could be changed to
new flag in mprotect_fixup(), so we introduce a new vma flag VM_DMEM and
check this flag in mprotect_fixup() to avoid changing vma->vm_flags.

We also check it in vma_to_resize() to disable mremap() for dmemfs vma.

Signed-off-by: Chen Zhuo <sagazchen@tencent.com>
Signed-off-by: Yulei Zhang <yuleixzhang@tencent.com>
---
 fs/dmemfs/inode.c  | 2 +-
 include/linux/mm.h | 7 +++++++
 mm/gup.c           | 7 +++++--
 mm/mincore.c       | 8 ++++++--
 mm/mprotect.c      | 5 ++++-
 mm/mremap.c        | 3 +++
 6 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/fs/dmemfs/inode.c b/fs/dmemfs/inode.c
index ab6a492..b165bd3 100644
--- a/fs/dmemfs/inode.c
+++ b/fs/dmemfs/inode.c
@@ -507,7 +507,7 @@ int dmemfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 	if (!(vma->vm_flags & VM_SHARED))
 		return -EINVAL;
 
-	vma->vm_flags |= VM_PFNMAP;
+	vma->vm_flags |= VM_PFNMAP | VM_DMEM | VM_IO;
 
 	file_accessed(file);
 	vma->vm_ops = &dmemfs_vm_ops;
diff --git a/include/linux/mm.h b/include/linux/mm.h
index db6ae4d..2f3135fe 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -311,6 +311,8 @@ int overcommit_policy_handler(struct ctl_table *, int, void *, size_t *,
 #define VM_HIGH_ARCH_4	BIT(VM_HIGH_ARCH_BIT_4)
 #endif /* CONFIG_ARCH_USES_HIGH_VMA_FLAGS */
 
+#define VM_DMEM		BIT(38)		/* Dmem page VM */
+
 #ifdef CONFIG_ARCH_HAS_PKEYS
 # define VM_PKEY_SHIFT	VM_HIGH_ARCH_BIT_0
 # define VM_PKEY_BIT0	VM_HIGH_ARCH_0	/* A protection key is a 4-bit value */
@@ -666,6 +668,11 @@ static inline bool vma_is_accessible(struct vm_area_struct *vma)
 	return vma->vm_flags & VM_ACCESS_FLAGS;
 }
 
+static inline bool vma_is_dmem(struct vm_area_struct *vma)
+{
+	return !!(vma->vm_flags & VM_DMEM);
+}
+
 #ifdef CONFIG_SHMEM
 /*
  * The vma_is_shmem is not inline because it is used only by slow
diff --git a/mm/gup.c b/mm/gup.c
index 47c8197..0ea9071 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -492,8 +492,11 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 			goto no_page;
 	} else if (unlikely(!page)) {
 		if (flags & FOLL_DUMP) {
-			/* Avoid special (like zero) pages in core dumps */
-			page = ERR_PTR(-EFAULT);
+			if (vma_is_dmem(vma))
+				page = ERR_PTR(-EEXIST);
+			else
+				/* Avoid special (like zero) pages in core dumps */
+				page = ERR_PTR(-EFAULT);
 			goto out;
 		}
 
diff --git a/mm/mincore.c b/mm/mincore.c
index 02db1a8..f8d10e4 100644
--- a/mm/mincore.c
+++ b/mm/mincore.c
@@ -78,8 +78,12 @@ static int __mincore_unmapped_range(unsigned long addr, unsigned long end,
 		pgoff_t pgoff;
 
 		pgoff = linear_page_index(vma, addr);
-		for (i = 0; i < nr; i++, pgoff++)
-			vec[i] = mincore_page(vma->vm_file->f_mapping, pgoff);
+		for (i = 0; i < nr; i++, pgoff++) {
+			if (vma_is_dmem(vma))
+				vec[i] = 1;
+			else
+				vec[i] = mincore_page(vma->vm_file->f_mapping, pgoff);
+		}
 	} else {
 		for (i = 0; i < nr; i++)
 			vec[i] = 0;
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 56c02be..b1650b5 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -236,7 +236,7 @@ static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
 		 * for all the checks.
 		 */
 		if (!is_swap_pmd(*pmd) && !pmd_devmap(*pmd) &&
-		     pmd_none_or_clear_bad_unless_trans_huge(pmd))
+		     pmd_none_or_clear_bad_unless_trans_huge(pmd) && !pmd_special(*pmd))
 			goto next;
 
 		/* invoke the mmu notifier if the pmd is populated */
@@ -412,6 +412,9 @@ static int prot_none_test(unsigned long addr, unsigned long next,
 		return 0;
 	}
 
+	if (vma_is_dmem(vma))
+		return -EINVAL;
+
 	/*
 	 * Do PROT_NONE PFN permission checks here when we can still
 	 * bail out without undoing a lot of state. This is a rather
diff --git a/mm/mremap.c b/mm/mremap.c
index 138abba..598e681 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -482,6 +482,9 @@ static struct vm_area_struct *vma_to_resize(unsigned long addr,
 	if (!vma || vma->vm_start > addr)
 		return ERR_PTR(-EFAULT);
 
+	if (vma_is_dmem(vma))
+		return ERR_PTR(-EINVAL);
+
 	/*
 	 * !old_len is a special case where an attempt is made to 'duplicate'
 	 * a mapping.  This makes no sense for private mappings as it will
-- 
1.8.3.1

