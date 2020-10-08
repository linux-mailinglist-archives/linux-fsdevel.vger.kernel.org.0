Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6E8A28702D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Oct 2020 09:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729066AbgJHHzo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Oct 2020 03:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729041AbgJHHzm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Oct 2020 03:55:42 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC462C0613D8;
        Thu,  8 Oct 2020 00:55:31 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id x16so3601121pgj.3;
        Thu, 08 Oct 2020 00:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=+D+2jt/lSuuv5ngz/ELFFsRQ4iKFzjc5y47NExgYtsk=;
        b=TcvgfWTvlwyihLEatUZPA4DfwXuPBYdxYxsTqPa8ZdtWUbnm9rtcAkT/7Et6Sk/MNA
         s8s+DpwCf67JvoXW7URCCoLiVUozFwQ5NN5RsK5YMRltwBP4Zzw0G1KUEFsqw10ccowZ
         c5WfSyAxoFkHjDwvGVpGhUtb2p0PBwBpj7XCZmuyh3lE1YliF1EMrGYanfKiD2kNMBQx
         QVAnbEXbiWYIKyLnUtzR6nOeeJntLp504YbpTd3woPyYrLfena1jQ/LP9vVsy7Ei7X+Y
         7uau9Qp+78+cp3nvJXMgVhpZqbC552v3oXqLfPjxUwD6Do7huS9eoNA7J1bMwpNwcnDN
         rNuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=+D+2jt/lSuuv5ngz/ELFFsRQ4iKFzjc5y47NExgYtsk=;
        b=YpTxwOGKpUt+ZU7un/C2/zLNXwJ7tC4QVm7xSviqFap6SqdhbaoUvRo7qz7dBGSUjy
         brVddpYiFXsfkjNsz2olWciF/+I3vazg/utbzGgxJ6G6P3PqIcuBYIsxxKGGOT2LD6Nx
         64ECJLJ003NElVO69iTtoww25CvmTzyVtG6oe4VWcC1JoxXlMfUGl2IdIZZh8HiHpEm3
         kPqsYlSIVeEqY/9RpR53fIqMv0oB4uB4Y570RjhsFdXHB3jRORNfs3CdBt5qv1QV7Vwt
         SDQ4+pd4aJG7sQBTF3ukZOzzJcfQ3xFNzeV2kSpC5Y0XVgd0jrvVYR4LQNqZAYSWMLDI
         v8Uw==
X-Gm-Message-State: AOAM530TMVkIJ6RZUEkpCMaAvgePwypUUpEuYtkvSdOK/o/Irlrrf2AG
        KMkwMSDymw3a7YM82GCW+qM=
X-Google-Smtp-Source: ABdhPJwjl1+Gftssqt2c421sbJB6de2k1LCPW6sxmsPvotpeXPXE9JAkY7pY86kFzlUX5gGJakpTZQ==
X-Received: by 2002:a63:d65:: with SMTP id 37mr6411206pgn.139.1602143731417;
        Thu, 08 Oct 2020 00:55:31 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.61])
        by smtp.gmail.com with ESMTPSA id k206sm6777106pfd.126.2020.10.08.00.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 00:55:30 -0700 (PDT)
From:   yulei.kernel@gmail.com
X-Google-Original-From: yuleixzhang@tencent.com
To:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        viro@zeniv.linux.org.uk, pbonzini@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, xiaoguangrong.eric@gmail.com,
        kernellwp@gmail.com, lihaiwei.kernel@gmail.com,
        Yulei Zhang <yuleixzhang@tencent.com>,
        Chen Zhuo <sagazchen@tencent.com>
Subject: [PATCH 24/35] dmemfs: support hugepage for dmemfs
Date:   Thu,  8 Oct 2020 15:54:14 +0800
Message-Id: <4d6038207c6472a0dd3084cbc77e70554fb9de91.1602093760.git.yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1602093760.git.yuleixzhang@tencent.com>
References: <cover.1602093760.git.yuleixzhang@tencent.com>
In-Reply-To: <cover.1602093760.git.yuleixzhang@tencent.com>
References: <cover.1602093760.git.yuleixzhang@tencent.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Yulei Zhang <yuleixzhang@tencent.com>

It add hugepage support for dmemfs. We use PFN_DMEM to notify
vmf_insert_pfn_pmd, and dmem huge pmd will be marked with
_PAGE_SPECIAL and _PAGE_DMEM. So that GUP-fast can separate
dmemfs page from other page type and handle it correctly.

Signed-off-by: Chen Zhuo <sagazchen@tencent.com>
Signed-off-by: Yulei Zhang <yuleixzhang@tencent.com>
---
 fs/dmemfs/inode.c | 113 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 111 insertions(+), 2 deletions(-)

diff --git a/fs/dmemfs/inode.c b/fs/dmemfs/inode.c
index b3e394f33b42..53a9bf214e0d 100644
--- a/fs/dmemfs/inode.c
+++ b/fs/dmemfs/inode.c
@@ -460,7 +460,7 @@ static int dmemfs_split(struct vm_area_struct *vma, unsigned long addr)
 	return 0;
 }
 
-static vm_fault_t dmemfs_fault(struct vm_fault *vmf)
+static vm_fault_t __dmemfs_fault(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct inode *inode = file_inode(vma->vm_file);
@@ -488,6 +488,63 @@ static vm_fault_t dmemfs_fault(struct vm_fault *vmf)
 	return ret;
 }
 
+static vm_fault_t  __dmemfs_pmd_fault(struct vm_fault *vmf)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	unsigned long pmd_addr = vmf->address & PMD_MASK;
+	unsigned long page_addr;
+	struct inode *inode = file_inode(vma->vm_file);
+	void *entry;
+	phys_addr_t phys;
+	pfn_t pfn;
+	int ret;
+
+	if (dmem_page_size(inode) < PMD_SIZE)
+		return VM_FAULT_FALLBACK;
+
+	WARN_ON(pmd_addr < vma->vm_start ||
+		vma->vm_end < pmd_addr + PMD_SIZE);
+
+	page_addr = vmf->address & ~(dmem_page_size(inode) - 1);
+	entry = radix_get_create_entry(vma, page_addr, inode,
+				       linear_page_index(vma, page_addr));
+	if (IS_ERR(entry))
+		return (PTR_ERR(entry) == -ENOMEM) ?
+			VM_FAULT_OOM : VM_FAULT_SIGBUS;
+
+	phys = dmem_addr_to_pfn(inode, dmem_entry_to_addr(inode, entry),
+				linear_page_index(vma, pmd_addr), PMD_SHIFT);
+	phys <<= PAGE_SHIFT;
+	pfn = phys_to_pfn_t(phys, PFN_DMEM);
+	ret = vmf_insert_pfn_pmd(vmf, pfn, !!(vma->vm_flags & VM_WRITE));
+
+	radix_put_entry();
+	return ret;
+}
+
+static vm_fault_t dmemfs_huge_fault(struct vm_fault *vmf, enum page_entry_size pe_size)
+{
+	int ret;
+
+	switch (pe_size) {
+	case PE_SIZE_PTE:
+		ret = __dmemfs_fault(vmf);
+		break;
+	case PE_SIZE_PMD:
+		ret = __dmemfs_pmd_fault(vmf);
+		break;
+	default:
+		ret = VM_FAULT_SIGBUS;
+	}
+
+	return ret;
+}
+
+static vm_fault_t dmemfs_fault(struct vm_fault *vmf)
+{
+	return dmemfs_huge_fault(vmf, PE_SIZE_PTE);
+}
+
 static unsigned long dmemfs_pagesize(struct vm_area_struct *vma)
 {
 	return dmem_page_size(file_inode(vma->vm_file));
@@ -498,6 +555,7 @@ static const struct vm_operations_struct dmemfs_vm_ops = {
 	.fault = dmemfs_fault,
 	.pagesize = dmemfs_pagesize,
 	.access = dmemfs_access_dmem,
+	.huge_fault = dmemfs_huge_fault,
 };
 
 int dmemfs_file_mmap(struct file *file, struct vm_area_struct *vma)
@@ -510,15 +568,66 @@ int dmemfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 	if (!(vma->vm_flags & VM_SHARED))
 		return -EINVAL;
 
-	vma->vm_flags |= VM_PFNMAP | VM_DMEM | VM_IO;
+	vma->vm_flags |= VM_PFNMAP | VM_DONTCOPY | VM_DMEM | VM_IO;
+
+	if (dmem_page_size(inode) != PAGE_SIZE)
+		vma->vm_flags |= VM_HUGEPAGE;
 
 	file_accessed(file);
 	vma->vm_ops = &dmemfs_vm_ops;
 	return 0;
 }
 
+/*
+ * If the size of area returned by mm->get_unmapped_area() is one
+ * dmem pagesize larger than 'len', the returned addr by
+ * mm->get_unmapped_area() could be aligned to dmem pagesize to
+ * meet alignment demand.
+ */
+static unsigned long
+dmemfs_get_unmapped_area(struct file *file, unsigned long addr,
+			 unsigned long len, unsigned long pgoff,
+			 unsigned long flags)
+{
+	unsigned long len_pad;
+	unsigned long off = pgoff << PAGE_SHIFT;
+	unsigned long align;
+
+	align = dmem_page_size(file_inode(file));
+
+	/* For pud or pmd pagesize, could not support fault fallback. */
+	if (len & (align - 1))
+		return -EINVAL;
+	if (len > TASK_SIZE)
+		return -ENOMEM;
+
+	if (flags & MAP_FIXED) {
+		if (addr & (align - 1))
+			return -EINVAL;
+		return addr;
+	}
+
+	/*
+	 * Pad a extra align space for 'len', as we want to find a unmapped
+	 * area which is larger enough to align with dmemfs pagesize, if
+	 * pagesize of dmem is larger than 4K.
+	 */
+	len_pad = (align == PAGE_SIZE) ? len : len + align;
+
+	/* 'len' or 'off' is too large for pad. */
+	if (len_pad < len || (off + len_pad) < off)
+		return -EINVAL;
+
+	addr = current->mm->get_unmapped_area(file, addr, len_pad,
+					      pgoff, flags);
+
+	/* Now 'addr' could be aligned to upper boundary. */
+	return IS_ERR_VALUE(addr) ? addr : round_up(addr, align);
+}
+
 static const struct file_operations dmemfs_file_operations = {
 	.mmap = dmemfs_file_mmap,
+	.get_unmapped_area = dmemfs_get_unmapped_area,
 };
 
 static int dmemfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
-- 
2.28.0

