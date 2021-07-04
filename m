Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42D423BABAB
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Jul 2021 08:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbhGDGY5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Jul 2021 02:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbhGDGY5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Jul 2021 02:24:57 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32862C061762
        for <linux-fsdevel@vger.kernel.org>; Sat,  3 Jul 2021 23:22:22 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id kt19so9472004pjb.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 03 Jul 2021 23:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XORvEp2gtWbQSLTOuxakjCQ6T0QdIM+9WQNeYuDCfSQ=;
        b=eSZeT/8nUlJ8JAIidLTRFAa5IlIFdof0TE/J1j7xMrrXxM/QA7KXfcSStxeTRPTLGl
         NRXILx9NGhWxe+UZGf6b4Y0gmzvfkS41m5/O07fsAEFGliKHAo/5SHBxsYtLE587Y3E3
         VIlmA3gYrhj+eGlxs+Y2gG9ylu8czJspclA6/dFNOC6tRypu57wyoinA5O6eRLkGMw1o
         6zGBBYrkMHdo09oNQYgnXpNEcC/WapWSGlemSmp5rFRengb8tEFRrd5uEEniJ3/lcDub
         Vq935RNtK7AC3S0jwX9gB18Bjc9cP0OiDdZyOYHifsWMgBuBhqxSHQanqF7IJqrrpoig
         Yl3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XORvEp2gtWbQSLTOuxakjCQ6T0QdIM+9WQNeYuDCfSQ=;
        b=bR9tcq7nVFEWr7nlFrtBgLBZ75UhzjlePaQ2BAJjdMOOb/eSi3eML6Ogyu6oZgFoQj
         ASu5ua8rnZVLG8KQRGOaOzt+2RbJG2tgtxKGZUbzb296sZEskC8Z3MwONH+qzApR9J0Y
         XgTRv6FI3l4s3wBw/mhqOFWrNlyV1db4jXILi5astMl7kIGWS0LE/mRkXQ1oAsxSfXhN
         a/SRTwq6Uja61J8byqSH2ZbCoKg27gxe7ZLTJYDhHL+ZUWKYDdABDJCP8wwcfDOC1U+D
         6hmTcdCtO0O+Mhyy3hb5nUFe45TJHFNrIGQpnJ6myEzwzUfxho0Mu+d55VjW/W2hDRcZ
         dupQ==
X-Gm-Message-State: AOAM530eKos1fG4fGJxEh4VvvOp30alMu2QEyefNLfPz5xPQtzSUQgWt
        8uhiRzCNAduOLUPPMsk4EnY+KQ==
X-Google-Smtp-Source: ABdhPJz9rTDPPUHNUrbswBT+i/+oDCamLR/aueRSZ5nfssEqE1XwWvKJKV0KmjnU7p71FRYn7fh1MQ==
X-Received: by 2002:a17:90a:fa92:: with SMTP id cu18mr8290447pjb.215.1625379741234;
        Sat, 03 Jul 2021 23:22:21 -0700 (PDT)
Received: from FVFX41FWHV2J.bytedance.net ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id y4sm9423683pfc.15.2021.07.03.23.22.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Jul 2021 23:22:20 -0700 (PDT)
From:   Feng zhou <zhoufeng.zf@bytedance.com>
To:     adobriyan@gmail.com, akpm@linux-foundation.org, rppt@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com,
        zhouchengming@bytedance.com, chenying.kernel@bytedance.com,
        zhengqi.arch@bytedance.com, zhoufeng.zf@bytedance.com
Subject: [PATCH v3] fs/proc/kcore.c: add mmap interface
Date:   Sun,  4 Jul 2021 14:22:08 +0800
Message-Id: <20210704062208.7898-1-zhoufeng.zf@bytedance.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Feng Zhou <zhoufeng.zf@bytedance.com>

When we do the kernel monitor, use the DRGN
(https://github.com/osandov/drgn) access to kernel data structures,
found that the system calls a lot. DRGN is implemented by reading
/proc/kcore. After looking at the kcore code, it is found that kcore
does not implement mmap, resulting in frequent context switching
triggered by read. Therefore, we want to add mmap interface to optimize
performance. Since vmalloc and module areas will change with allocation
and release, consistency cannot be guaranteed, so mmap interface only
maps KCORE_TEXT and KCORE_RAM.

The test results:
1. the default version of kcore
real 11.00
user 8.53
sys 3.59

% time     seconds  usecs/call     calls    errors syscall
------ ----------- ----------- --------- --------- ----------------
99.64  128.578319          12  11168701           pread64
...
------ ----------- ----------- --------- --------- ----------------
100.00  129.042853              11193748       966 total

2. added kcore for the mmap interface
real 6.44
user 7.32
sys 0.24

% time     seconds  usecs/call     calls    errors syscall
------ ----------- ----------- --------- --------- ----------------
32.94    0.130120          24      5317       315 futex
11.66    0.046077          21      2231         1 lstat
 9.23    0.036449         177       206           mmap
...
------ ----------- ----------- --------- --------- ----------------
100.00    0.395077                 25435       971 total

The test results show that the number of system calls and time
consumption are significantly reduced.

Co-developed-by: Ying Chen <chenying.kernel@bytedance.com>
Signed-off-by: Ying Chen <chenying.kernel@bytedance.com>
Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
---
Updates since v2:
- Remove the judgment on KCORE_REMAP
- Add a test between "vma->vm_pgoff << PAGE_SHIFT" and "data_offset"
- Modify the judgment logic for check that "start+size" hasn't
overflowed

 fs/proc/kcore.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index 4d2e64e9016c..4aab4e3848fa 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -573,11 +573,84 @@ static int release_kcore(struct inode *inode, struct file *file)
 	return 0;
 }
 
+static vm_fault_t mmap_kcore_fault(struct vm_fault *vmf)
+{
+	return VM_FAULT_SIGBUS;
+}
+
+static const struct vm_operations_struct kcore_mmap_ops = {
+	.fault = mmap_kcore_fault,
+};
+
+static int mmap_kcore(struct file *file, struct vm_area_struct *vma)
+{
+	size_t size = vma->vm_end - vma->vm_start;
+	u64 start, end, pfn;
+	int nphdr;
+	size_t data_offset;
+	size_t phdrs_len, notes_len;
+	struct kcore_list *m = NULL;
+	int ret = 0;
+
+	down_read(&kclist_lock);
+
+	get_kcore_size(&nphdr, &phdrs_len, &notes_len, &data_offset);
+
+	data_offset &= PAGE_MASK;
+	start = (u64)vma->vm_pgoff << PAGE_SHIFT;
+	if (start < data_offset) {
+		ret = -EINVAL;
+		goto out;
+	}
+	start = kc_offset_to_vaddr(start - data_offset);
+	end   = start + size;
+
+	list_for_each_entry(m, &kclist_head, list) {
+		if (start >= m->addr && end <= m->addr + m->size)
+			break;
+	}
+
+	if (&m->list == &kclist_head) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (vma->vm_flags & (VM_WRITE | VM_EXEC)) {
+		ret = -EPERM;
+		goto out;
+	}
+
+	vma->vm_flags &= ~(VM_MAYWRITE | VM_MAYEXEC);
+	vma->vm_flags |= VM_MIXEDMAP;
+	vma->vm_ops = &kcore_mmap_ops;
+
+	if (kern_addr_valid(start)) {
+		if (m->type == KCORE_RAM)
+			pfn = __pa(start) >> PAGE_SHIFT;
+		else if (m->type == KCORE_TEXT)
+			pfn = __pa_symbol(start) >> PAGE_SHIFT;
+		else {
+			ret = -EFAULT;
+			goto out;
+		}
+
+		ret = remap_pfn_range(vma, vma->vm_start, pfn, size,
+				vma->vm_page_prot);
+	} else {
+		ret = -EFAULT;
+	}
+
+out:
+	up_read(&kclist_lock);
+	return ret;
+}
+
 static const struct proc_ops kcore_proc_ops = {
 	.proc_read	= read_kcore,
 	.proc_open	= open_kcore,
 	.proc_release	= release_kcore,
 	.proc_lseek	= default_llseek,
+	.proc_mmap	= mmap_kcore,
 };
 
 /* just remember that we have to update kcore */
-- 
2.11.0

