Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE38391187
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 May 2021 09:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbhEZHx4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 May 2021 03:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbhEZHxy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 May 2021 03:53:54 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A9CC061756
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 May 2021 00:52:23 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id g6-20020a17090adac6b029015d1a9a6f1aso3183578pjx.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 May 2021 00:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LcAnj+dk3wPXVKYPA66jlPJ5Hh8JRNQel8CkgoOsfTU=;
        b=nMS/oHFizjg02ojMOCfTbIFJZEFWeGLAp001Tt8PtBwALDgXe42pByatwDiV8iD8nH
         KeJ03WJM2O7x0OFKq7uS7rVUV6mVQ8mpSesqYHF5F+KdxciHB+3vK+uBcjXqoftXiKgY
         YFEgAvqvM4+ykGyRU398+9UOslYorE6hgoEiUiSypTgo5oppttC9w+WLtSFaXriZ36Qj
         wi+XEZUtsxZCmZWVFMGDEKHfKLqR25h0SI4FUQWdA1S16MgaFmcQaHmfcmRVODV+c5Wk
         66Nblrffx4fJtlQ+NJR21PbgZtFwK8rw1+xgx7sdgvsj4yOSZGJ0vruNHvAvyJYeLLhJ
         Utew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LcAnj+dk3wPXVKYPA66jlPJ5Hh8JRNQel8CkgoOsfTU=;
        b=JQ0/dS1DzlKZFOsXmkX0Map8aQrPBdcXeKwPnSC/Ox42tGUYWTpuwDqr00MdRLMGLa
         3Mi6hjSKjICET9y2qiPVtFWW2zd+kzvFcUkF4Uoe8+qskozw+Uq+NGOcFPBbKp54vC85
         IELFx8Js0aI67Z5y7d6sXC8HK3ade/hB8nF159FLHrNmUqUv97MpcA0NVM5HVhPjeaOx
         2qw6thQ2m5kKGgKKE1WC7DsnZaHlvm1G1sbB0S00fDI2CakmTX84/bIXoHmp4jYZBfCM
         3o6HVkvjW8DTQqXzxjufyNlh0XdyYHu17LL/nS6VTyPstRu2nxdpVLQVBfiI6mR7OcbA
         oaJw==
X-Gm-Message-State: AOAM530Slrq9zthtiQN8noFz8EWwywKoWBDDVmQTn0Wxxh0Keweu3Gd6
        nVDR+uj10XG8sZLyh9CcKFEvJg==
X-Google-Smtp-Source: ABdhPJzRVz9zbxiSoMyHVzJH5MfTeutCv076ly57mbYqsH+ldrrtiqvMkhkLjkL8IuNZ6AGRu43QeQ==
X-Received: by 2002:a17:90b:713:: with SMTP id s19mr35415386pjz.144.1622015542873;
        Wed, 26 May 2021 00:52:22 -0700 (PDT)
Received: from FVFX41FWHV2J.bytedance.net ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id s3sm17138693pgs.62.2021.05.26.00.52.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 May 2021 00:52:22 -0700 (PDT)
From:   Feng zhou <zhoufeng.zf@bytedance.com>
To:     adobriyan@gmail.com, akpm@linux-foundation.org, rppt@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        songmuchun@bytedance.com, zhouchengming@bytedance.com,
        chenying.kernel@bytedance.com, zhengqi.arch@bytedance.com,
        zhoufeng.zf@bytedance.com
Subject: [PATCH] fs/proc/kcore.c: add mmap interface
Date:   Wed, 26 May 2021 15:51:42 +0800
Message-Id: <20210526075142.9740-1-zhoufeng.zf@bytedance.com>
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

Co-developed-by: ZHOUFENG Co-Author <zhoufeng.zf@bytedance.com>
Signed-off-by: ZHOUFENG Co-Author <zhoufeng.zf@bytedance.com>
Co-developed-by: CHENYING Co-Author <chenying.kernel@bytedance.com>
Signed-off-by: CHENYING Co-Author <chenying.kernel@bytedance.com>
Signed-off-by: ZHOUFENG <zhoufeng.zf@bytedance.com>
---
 fs/proc/kcore.c | 70 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index 4d2e64e9016c..25a7a9ba2c4a 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -573,11 +573,81 @@ static int release_kcore(struct inode *inode, struct file *file)
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
+		if (remap_pfn_range(vma, vma->vm_start, pfn, size,
+				vma->vm_page_prot)) {
+			ret = -EAGAIN;
+			goto out;
+		}
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

