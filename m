Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24F96287044
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Oct 2020 09:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbgJHH4T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Oct 2020 03:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729114AbgJHHzs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Oct 2020 03:55:48 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5F5C061755;
        Thu,  8 Oct 2020 00:55:48 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id bb1so2375567plb.2;
        Thu, 08 Oct 2020 00:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=yi7jGxxMRJTKFHMt31rtyi+qjpDfCVRN9Gvuq5A1fhY=;
        b=gozkt5zB0DgYVhBidJhV+3vMXvqRNyABsdhKqCq86ORheKAC8rxjkpILlfOy5sDRnh
         OWypeMNFz+MRE/KvQf0Iep9F+oqDQ0inncfWzr66ewlRDYUsZ+JjIXGnj2TesfBBNo3f
         +iIHhotwCu5A5fEjoWzcqMf5V9XLrVeKeZy20Vtr1mwPIg9EnFOO1GSSMuwAgDbcBpXv
         SqgOznz8FarHLZQs6/XLHvurg4ZzWpzfiUraE6vQkRpXon/gtopXQb+9uxA5Dc7jjl1q
         GCrc+go7/JRvYFlbqAln9NVPmm41R01BYy5Hk6eY/IUnysJ+TsuH/Ut8E05TsVh8l3hC
         B0DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=yi7jGxxMRJTKFHMt31rtyi+qjpDfCVRN9Gvuq5A1fhY=;
        b=hzIs5oAqoBaywUlCAytMwu9NqFinLrpOlxbWp7mt3krmyCzCN4UIFajQEsjnjrJ+D1
         CLL/R9SkaJ2m0aAOIla19UXVjaEnmzyyePIg1RzwXg2DF2w1RYP+5G8Xs929L6S5FOLv
         U9bWfQgpjE0joIvFA4gRz1zy0314qeONUbh59JMAkze7JE3UGXS95HLS9sB7ubqnl++R
         mgCp+N/uw5fwbz5mVh0VeldbMdjbvn4lE72OVYhqEUP+lGdZFtScdNLG2TrRP7wU51zL
         Ecr1wrS73Yk1sssRvLxEENxADqrfT6nvOWIZJYXwRDZPqFCuCiU6eFiXT54ZSIKu5ui1
         Uobg==
X-Gm-Message-State: AOAM530xE5POnMgZuCclHv7spB0UnJ2uzqT4YVufTL68D1wpLtVFsSd+
        OOJclY6j/X3nkDlRV1CVotQ=
X-Google-Smtp-Source: ABdhPJz089XPEbawgMw+wnqaJGiaMcZofnvQOPXXqAfc3qfL7nSL9Oiv4dpga2EV5DLU23FnwN3xJg==
X-Received: by 2002:a17:902:ea8c:b029:d2:8abd:c8de with SMTP id x12-20020a170902ea8cb02900d28abdc8demr6617467plb.21.1602143748229;
        Thu, 08 Oct 2020 00:55:48 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.61])
        by smtp.gmail.com with ESMTPSA id k206sm6777106pfd.126.2020.10.08.00.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 00:55:47 -0700 (PDT)
From:   yulei.kernel@gmail.com
X-Google-Original-From: yuleixzhang@tencent.com
To:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        viro@zeniv.linux.org.uk, pbonzini@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, xiaoguangrong.eric@gmail.com,
        kernellwp@gmail.com, lihaiwei.kernel@gmail.com,
        Yulei Zhang <yuleixzhang@tencent.com>,
        Chen Zhuo <sagazchen@tencent.com>
Subject: [PATCH 28/35] mm, dmemfs: support huge_fault() for dmemfs
Date:   Thu,  8 Oct 2020 15:54:18 +0800
Message-Id: <4c905a63ed6c68fd23f81e1aafb6a41197a85909.1602093760.git.yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1602093760.git.yuleixzhang@tencent.com>
References: <cover.1602093760.git.yuleixzhang@tencent.com>
In-Reply-To: <cover.1602093760.git.yuleixzhang@tencent.com>
References: <cover.1602093760.git.yuleixzhang@tencent.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Yulei Zhang <yuleixzhang@tencent.com>

Introduce __dmemfs_huge_fault() to handle 1G huge pud for dmemfs.

Signed-off-by: Chen Zhuo <sagazchen@tencent.com>
Signed-off-by: Yulei Zhang <yuleixzhang@tencent.com>
---
 fs/dmemfs/inode.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/fs/dmemfs/inode.c b/fs/dmemfs/inode.c
index 53a9bf214e0d..027428a7f7a0 100644
--- a/fs/dmemfs/inode.c
+++ b/fs/dmemfs/inode.c
@@ -522,6 +522,43 @@ static vm_fault_t  __dmemfs_pmd_fault(struct vm_fault *vmf)
 	return ret;
 }
 
+#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
+static vm_fault_t __dmemfs_huge_fault(struct vm_fault *vmf)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	unsigned long pud_addr = vmf->address & PUD_MASK;
+	struct inode *inode = file_inode(vma->vm_file);
+	void *entry;
+	phys_addr_t phys;
+	pfn_t pfn;
+	int ret;
+
+	if (dmem_page_size(inode) < PUD_SIZE)
+		return VM_FAULT_FALLBACK;
+
+	WARN_ON(pud_addr < vma->vm_start ||
+		vma->vm_end < pud_addr + PUD_SIZE);
+
+	entry = radix_get_create_entry(vma, pud_addr, inode,
+				       linear_page_index(vma, pud_addr));
+	if (IS_ERR(entry))
+		return (PTR_ERR(entry) == -ENOMEM) ?
+			VM_FAULT_OOM : VM_FAULT_SIGBUS;
+
+	phys = dmem_entry_to_addr(inode, entry);
+	pfn = phys_to_pfn_t(phys, PFN_DMEM);
+	ret = vmf_insert_pfn_pud(vmf, pfn, !!(vma->vm_flags & VM_WRITE));
+
+	radix_put_entry();
+	return ret;
+}
+#else
+static vm_fault_t __dmemfs_huge_fault(struct vm_fault *vmf)
+{
+	return VM_FAULT_FALLBACK;
+}
+#endif /* !CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
+
 static vm_fault_t dmemfs_huge_fault(struct vm_fault *vmf, enum page_entry_size pe_size)
 {
 	int ret;
@@ -533,6 +570,9 @@ static vm_fault_t dmemfs_huge_fault(struct vm_fault *vmf, enum page_entry_size p
 	case PE_SIZE_PMD:
 		ret = __dmemfs_pmd_fault(vmf);
 		break;
+	case PE_SIZE_PUD:
+		ret = __dmemfs_huge_fault(vmf);
+		break;
 	default:
 		ret = VM_FAULT_SIGBUS;
 	}
-- 
2.28.0

