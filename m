Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF2822D0F7C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 12:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbgLGLh3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 06:37:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727339AbgLGLf0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 06:35:26 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6553AC08ED7E;
        Mon,  7 Dec 2020 03:35:02 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id o5so8647403pgm.10;
        Mon, 07 Dec 2020 03:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d/DMcQ5p9kWqt/8+2V3dACGpqFuk8uMzI8jd59zbvK8=;
        b=uDgPrdaW7QyZet4jLziwzIsT2FNC+muT99czm8HXIiXGHPutl3zp4sPeraiv07ll3r
         BQwlcD3KzLyJ9zAdfZ/NPlv4v98ZJhyXKeYwxNluZgjB08IT0zg+7sgClpKtweMJHL2i
         L6gt6Sx8ux6fk/NHOVacX/B4cu+FfYGthe2oAKzj2STci8jOmsss5yDhreWOWvLf3u2L
         c14M826QMvoUlMzulslcHONuIx1sPeUjQUjZ8rtHti7e48GSHl4Yi/RFWw5lNMrL8MSM
         k7CHx/oPR5izM2UgYMUgqFLnQKcs7gnrSlWrGV5pRWN31vfQBOKvYyB71NjPuk9WUbRK
         SBDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d/DMcQ5p9kWqt/8+2V3dACGpqFuk8uMzI8jd59zbvK8=;
        b=SNvGrhdKrLQ3z6bs+8Ienw+nvfVhgc4H1k9VZtT19J3BdnHritG5wKEB6al5g41LNx
         PkprroLsQc+9er20D0uR0clOiI92ScOqyV1pFdlsLZnA7rtHTjduwvGHavlZNQQiKZxg
         n7aRY4LK6WK/B5LxLdeCyeTdvivoOxz1HkpXrYIzaQlWzQBbDTb3B9knnPkww+Vp0WCb
         ITrR0FggSY368rNHGtnd8PeVyAIRDPn8vAWzGDFYnU9PmB51LVyfbT6A3QiGDGOndaWq
         +83mCrGmlWNnbq5nttwDXvkr5r4CA/onzl9HpIcHVPgp1rIsj009X9hnulpI+QCpAd8M
         2esA==
X-Gm-Message-State: AOAM530iD18M95CuLzD3dZR64S/UPhDoR+/tXDlPLQijj0S9Epdqw8cR
        dnSANbbpEsJMnS44iGXH+9o=
X-Google-Smtp-Source: ABdhPJzsTfFyeDeSqCA2nVBB3th4mGCgQXxAf/7SC6+PJE0lBNEtPZT6GhKeWck8kJzv61kWa4w/EA==
X-Received: by 2002:aa7:8b15:0:b029:196:59ad:ab93 with SMTP id f21-20020aa78b150000b029019659adab93mr15268290pfd.16.1607340901970;
        Mon, 07 Dec 2020 03:35:01 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id d4sm14219822pfo.127.2020.12.07.03.34.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Dec 2020 03:35:01 -0800 (PST)
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
Subject: [RFC V2 24/37] dmemfs: support hugepage for dmemfs
Date:   Mon,  7 Dec 2020 19:31:17 +0800
Message-Id: <ed7bd51468d10fcbd4c0110ad1b81a2b07ebd880.1607332046.git.yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1607332046.git.yuleixzhang@tencent.com>
References: <cover.1607332046.git.yuleixzhang@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 fs/dmemfs/inode.c | 113 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 111 insertions(+), 2 deletions(-)

diff --git a/fs/dmemfs/inode.c b/fs/dmemfs/inode.c
index b165bd3..17a518c 100644
--- a/fs/dmemfs/inode.c
+++ b/fs/dmemfs/inode.c
@@ -457,7 +457,7 @@ static int dmemfs_split(struct vm_area_struct *vma, unsigned long addr)
 	return 0;
 }
 
-static vm_fault_t dmemfs_fault(struct vm_fault *vmf)
+static vm_fault_t __dmemfs_fault(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct inode *inode = file_inode(vma->vm_file);
@@ -485,6 +485,63 @@ static vm_fault_t dmemfs_fault(struct vm_fault *vmf)
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
@@ -495,6 +552,7 @@ static unsigned long dmemfs_pagesize(struct vm_area_struct *vma)
 	.fault = dmemfs_fault,
 	.pagesize = dmemfs_pagesize,
 	.access = dmemfs_access_dmem,
+	.huge_fault = dmemfs_huge_fault,
 };
 
 int dmemfs_file_mmap(struct file *file, struct vm_area_struct *vma)
@@ -507,15 +565,66 @@ int dmemfs_file_mmap(struct file *file, struct vm_area_struct *vma)
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
1.8.3.1

