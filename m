Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9CE2D0F6E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 12:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbgLGLhI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 06:37:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727425AbgLGLfc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 06:35:32 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C89CC0613D2;
        Mon,  7 Dec 2020 03:35:15 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id c79so9618736pfc.2;
        Mon, 07 Dec 2020 03:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WOqN3wAFWNmwPLLbitVjeNVP3/1EeNDqwEgp1U7by0Y=;
        b=t2mhCRx4ddW/Vy1XTuXt7xLNO/CzgHXZeydB8wf2nGDpcuoOfUMGpcemrPer6RwsAu
         uNrNzd2nFAftQMHWukm68XBY2ZReEiQDmMuknuogHStEJ92RpzjB90S9K9a1cbyDhi2W
         9Vm6qF/G07WKj7L5wgUVDnQOr5/Zh79lLesUmR9Lh/aRQyBdGzd14FIUZji0fOJd8pl+
         /jy3wxMeIMmrTvfNtbWdW+RdAKQyWUr9HmQ31ldStU+rb3XP8uT16WXN0+pGuRlr4ZTK
         AOGRKulren3uPBcL5hwFYJaFeUE2vqsl9ziKH6yRfEJ//oEfAk2A5bJm4l2xsQwEEOOy
         Hptg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WOqN3wAFWNmwPLLbitVjeNVP3/1EeNDqwEgp1U7by0Y=;
        b=EJLd6ULjOYjaQkY3OaixEUj1mOdd9JsPSLmGlkfqLqNyMLwUPr9nUw7XWbEqOWjApV
         gsId4qNCfbb8plitRD0isCdXEpR9H/+jz6Msx7uFeHrKYO5CAqDYiHPnhjSlve5JY8tg
         7+nMVVch5sVpdUWN3a98v/YV6xUQL57UIxakp2ZpU3c+fqFDd2lfrkXSS63ryHeuksq8
         cW5NBcH3giMPasNzBaa25wSANyHbIQH5+9ImSKl3QQx+ryy91Km6PvbIR+Z86zilCI5B
         7S+sIpw29Bw3Ypvw9zv5JyS4ejJn1xkhoLlsbHw+WvCAGQ8Rl5Yec+tfat1IxMy75iFL
         jlHQ==
X-Gm-Message-State: AOAM533agR3739qsaOo0XZaZZTUqLletb8ko/XHYi95HNioLEAKRIRVE
        MLNhQsiWbol5FM/7gdC2xtU=
X-Google-Smtp-Source: ABdhPJwbvfVevLMEXxhQw8TM4SqqQZ/7ZuW0O/nKHs8QddAXnvoNRyEBcv9DCTj5vDpAlxEcd07BrA==
X-Received: by 2002:a17:902:860a:b029:da:e83a:7f1f with SMTP id f10-20020a170902860ab02900dae83a7f1fmr7784842plo.60.1607340915254;
        Mon, 07 Dec 2020 03:35:15 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id d4sm14219822pfo.127.2020.12.07.03.35.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Dec 2020 03:35:14 -0800 (PST)
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
Subject: [RFC V2 28/37] mm, dmemfs: support huge_fault() for dmemfs
Date:   Mon,  7 Dec 2020 19:31:21 +0800
Message-Id: <c70e7ffb9052b9798d38f2d1525ad0ba429ec073.1607332046.git.yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1607332046.git.yuleixzhang@tencent.com>
References: <cover.1607332046.git.yuleixzhang@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 17a518c..f698b9d 100644
--- a/fs/dmemfs/inode.c
+++ b/fs/dmemfs/inode.c
@@ -519,6 +519,43 @@ static vm_fault_t  __dmemfs_pmd_fault(struct vm_fault *vmf)
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
@@ -530,6 +567,9 @@ static vm_fault_t dmemfs_huge_fault(struct vm_fault *vmf, enum page_entry_size p
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
1.8.3.1

