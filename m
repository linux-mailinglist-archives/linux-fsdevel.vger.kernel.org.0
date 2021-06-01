Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B067D396ED3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jun 2021 10:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233438AbhFAIYf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Jun 2021 04:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233324AbhFAIYd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Jun 2021 04:24:33 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE6FC06174A
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Jun 2021 01:22:53 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id r1so10107194pgk.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Jun 2021 01:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Cmtbv533T+lIcgmnYXDQIYlfDlz/3dP+vNE0ksXaWFg=;
        b=j+wd4DLtohlBcCHNl1RZQ/Ih+s3QZ9YjLM/SkASYaUI9tMKnyfQH0jA2IQDMut7am/
         F18ajErF8iOReZlQvEeMZs3TL9fs5o1gIk9sHL2eo8SdQoXsqs7HMZXmpVQCT4CI6hFG
         TjgieFCVQ0R9J9Mbp4JFZCo4qScT5uneVZ8kSriR9i0eT4yTqaLMCTP01joxgTrXk3vh
         tXR2OLNu03J8gkFlEz1dgwbvsyb7gW/ww0VARqyBkZKkP2XqAQ+eaKaVhk/91RGkSO3e
         R9xuJdYJTyG2KfZLpsnP6pNaS1XnT6Pfmp0vt4MBqs+j/MrYEoj+aBw3V/bGgv7pTO3x
         isXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Cmtbv533T+lIcgmnYXDQIYlfDlz/3dP+vNE0ksXaWFg=;
        b=PLCHbXDFAK8JpoYW+lOmQVyzRs+o0Oa1+L0QETkapb0tOzAEvTWX5h6OzNrcb/Ir8k
         jQVtnFRwqMqJDHSM+6OwDyoQ6HOexrezALmc2idYHCm382WESDEbkL7s1uIdQC8qpZgS
         wqG0kogfx8NXQcu0q8z4jCuIHHUzII20ugex6iumgD9iY+1q0N6TYmT/AIV+RBHSg2wB
         O+U7nEJDRLvdW6N8GGFY1aWlF/wXHJQhj5L3tL0hmLu0auIdjeQN188G/HR7z8f4wHqk
         LyjTiLFPqXf58T8rw8vGVP25kq20NwpOgMNNL8Z2hdY2KyUhJWVU58ukBy70qsbSKsWM
         Lq4g==
X-Gm-Message-State: AOAM533kxYuNXHqPsjWRTdO0N18J52WLPIwsDsXX6Q+iJV1io3V+vXL0
        +iX1VDKYiHRSv3oMaYBgUvp1pg==
X-Google-Smtp-Source: ABdhPJxqYIztjAiH2O3UXaLiF5pofSZstUQEhihvG513bJN2IQj26dsDk5GPVwZCHwtnEcF1YCXOhA==
X-Received: by 2002:a63:594f:: with SMTP id j15mr8436110pgm.244.1622535772563;
        Tue, 01 Jun 2021 01:22:52 -0700 (PDT)
Received: from FVFX41FWHV2J.bytedance.net ([139.177.225.224])
        by smtp.gmail.com with ESMTPSA id g19sm1485193pjl.24.2021.06.01.01.22.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Jun 2021 01:22:51 -0700 (PDT)
From:   Feng zhou <zhoufeng.zf@bytedance.com>
To:     adobriyan@gmail.com, akpm@linux-foundation.org, rppt@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        songmuchun@bytedance.com, zhouchengming@bytedance.com,
        chenying.kernel@bytedance.com, zhengqi.arch@bytedance.com,
        zhoufeng.zf@bytedance.com
Subject: [PATCH v2] fs/proc/kcore.c: add mmap interface
Date:   Tue,  1 Jun 2021 16:22:41 +0800
Message-Id: <20210601082241.13378-1-zhoufeng.zf@bytedance.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: ZHOUFENG <zhoufeng.zf@bytedance.com>

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

Thanks to Andrew Morton for your advice.

Co-developed-by: CHENYING <chenying.kernel@bytedance.com>
Signed-off-by: CHENYING <chenying.kernel@bytedance.com>
Signed-off-by: ZHOUFENG <zhoufeng.zf@bytedance.com>
---
Updates since v1:
- Replace EAGAIN with the return value of remap_pfn_range(). more details
can be seen from here:
https://lore.kernel.org/patchwork/patch/1436352/

 fs/proc/kcore.c | 67 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index 4d2e64e9016c..91b19f63a298 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -573,11 +573,78 @@ static int release_kcore(struct inode *inode, struct file *file)
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
+	u64 start, pfn;
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
+	start = kc_offset_to_vaddr(((u64)vma->vm_pgoff << PAGE_SHIFT) -
+		((data_offset >> PAGE_SHIFT) << PAGE_SHIFT));
+
+	list_for_each_entry(m, &kclist_head, list) {
+		if (start >= m->addr && size <= m->size)
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
+		if (m->type == KCORE_RAM || m->type == KCORE_REMAP)
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

