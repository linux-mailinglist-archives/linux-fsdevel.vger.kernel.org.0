Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 714A052152C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 May 2022 14:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241660AbiEJM04 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 May 2022 08:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241328AbiEJM0z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 May 2022 08:26:55 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06AB014085B;
        Tue, 10 May 2022 05:22:58 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id a11so14801343pff.1;
        Tue, 10 May 2022 05:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jUn/XcQte1+YKQ1/fBhkzirtoSXJDM63v5+XTC+eQm8=;
        b=DgtMpAac3k9bfyxUkQ6yRKX0pzlJa5x4fa4kUJl+yBH99MPF6kVeu2kxzlxvxEtWZ9
         Fwv6R/VcgPw8vFGs1cbczhgTWYF04byFteIyx7UnEC3o9X3knDLD8FDLEJDPCF4uDB9r
         CifR8+keWO5thkPklRZUaYQeTZMPbG0ywGE5ngydFyp2d7Oq4HOrKC/SP/eBk3qt0PAJ
         tgUL821Mzd7bxzrrEjYDm0kYMo8cr63lmMToUdv1049vCiHrJX+Rma2BVoLOEy+AXocB
         GZBQDYA1x8jEZRY2g1Gez9UdVaxri4PsUa63rniW0LOHKczOIpUnSdzOk5HSdPxkuPDV
         rIsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jUn/XcQte1+YKQ1/fBhkzirtoSXJDM63v5+XTC+eQm8=;
        b=CHBklOjMWs/XCGnL6Fs26Qa58gb2YDTh3Gm7MNhCI3VwLdqKYUf/+ZegUpPq7UAFS0
         6LU+0GBFQeRkEI8k0yuYoAyv7/g4mDkF4lm9kZzQOeyD9MyUiVZa2jV42BmqFXBVh0cl
         tsQJrjSvolUk5uwSJcJiNvwGoVbzYXVl5aLQKwWZIydEmxUZM3QFRw/rc+pUbJbsrdTu
         JKATL98I0fICDmQtXTGNyXCFA0ubzCm6VyEYs9eGAbyATo81/UML8GLD3k6gfg11I3p/
         UXf0XxKmpqnnq1AP0lNC70v6jnWmrMHOpa04V3VWJJ6/QJHg6VUz6303aXe70yYqr8DS
         0qfQ==
X-Gm-Message-State: AOAM531+X9VCVq9+SzAAbW+UIGsemA/nGlojR5zEZpvPOLFI5ZFoLiyq
        x6VanvbgkOo2ql/afMRBjN0=
X-Google-Smtp-Source: ABdhPJweXFhfBJqeaVe+SM3WqT/JZKv8g8j9/WxM40wkMl68vI+rdjzS3DRIq5y5/Wdbmk2nrzvJZg==
X-Received: by 2002:a05:6a00:ad0:b0:50a:51b3:1e3d with SMTP id c16-20020a056a000ad000b0050a51b31e3dmr20491133pfl.18.1652185377453;
        Tue, 10 May 2022 05:22:57 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id ik19-20020a170902ab1300b0015e8d4eb297sm1827946plb.225.2022.05.10.05.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 05:22:57 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: xu.xin16@zte.com.cn
To:     akpm@linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, corbet@lwn.net, xu xin <xu.xin16@zte.com.cn>,
        Yang Yang <yang.yang29@zte.com.cn>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        wangyong <wang.yong12@zte.com.cn>,
        Yunkai Zhang <zhang.yunkai@zte.com.cn>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v6] mm/ksm: introduce ksm_force for each process
Date:   Tue, 10 May 2022 12:22:42 +0000
Message-Id: <20220510122242.1380536-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: xu xin <xu.xin16@zte.com.cn>

To use KSM, we have to explicitly call madvise() in application code,
which means installed apps on OS needs to be uninstall and source code
needs to be modified. It is inconvenient.

In order to change this situation, We add a new proc file ksm_force
under /proc/<pid>/ to support turning on/off KSM scanning of a
process's mm dynamically.

If ksm_force is set to 1, force all anonymous and 'qualified' VMAs
of this mm to be involved in KSM scanning without explicitly calling
madvise to mark VMA as MADV_MERGEABLE. But It is effective only when
the klob of /sys/kernel/mm/ksm/run is set as 1.

If ksm_force is set to 0, cancel the feature of ksm_force of this
process (fallback to the default state) and unmerge those merged pages
belonging to VMAs which is not madvised as MADV_MERGEABLE of this process,
but still leave MADV_MERGEABLE areas merged.

Signed-off-by: xu xin <xu.xin16@zte.com.cn>
Reviewed-by: Yang Yang <yang.yang29@zte.com.cn>
Reviewed-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
Reviewed-by: wangyong <wang.yong12@zte.com.cn>
Reviewed-by: Yunkai Zhang <zhang.yunkai@zte.com.cn>
Suggested-by: Matthew Wilcox <willy@infradead.org>
---
v6:
- modify the way of "return"
- remove unnecessary words in Documentation/admin-guide/mm/ksm.rst
- add additional notes to "set 0 to ksm_force" in Documentation/../ksm.rst
and Documentation/../proc.rst
v5:
- fix typos in Documentation/filesystem/proc.rst
v4:
- fix typos in commit log
- add interface descriptions under Documentation/
v3:
- fix compile error of mm/ksm.c
v2:
- fix a spelling error in commit log.
- remove a redundant condition check in ksm_force_write().
---
 Documentation/admin-guide/mm/ksm.rst | 19 +++++-
 Documentation/filesystems/proc.rst   | 17 +++++
 fs/proc/base.c                       | 93 ++++++++++++++++++++++++++++
 include/linux/mm_types.h             |  9 +++
 mm/ksm.c                             | 32 +++++++++-
 5 files changed, 167 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/mm/ksm.rst b/Documentation/admin-guide/mm/ksm.rst
index b244f0202a03..8cabc2504005 100644
--- a/Documentation/admin-guide/mm/ksm.rst
+++ b/Documentation/admin-guide/mm/ksm.rst
@@ -32,7 +32,7 @@ are swapped back in: ksmd must rediscover their identity and merge again).
 Controlling KSM with madvise
 ============================
 
-KSM only operates on those areas of address space which an application
+KSM can operates on those areas of address space which an application
 has advised to be likely candidates for merging, by using the madvise(2)
 system call::
 
@@ -70,6 +70,23 @@ Applications should be considerate in their use of MADV_MERGEABLE,
 restricting its use to areas likely to benefit.  KSM's scans may use a lot
 of processing power: some installations will disable KSM for that reason.
 
+Controlling KSM with procfs
+===========================
+
+KSM can also operate on anonymous areas of address space of those processes's
+knob ``/proc/<pid>/ksm_force`` is on, even if app codes doesn't call madvise()
+explicitly to advise specific areas as MADV_MERGEABLE.
+
+You can set ksm_force to 1 to force all anonymous and qualified VMAs of
+this process to be involved in KSM scanning.
+	e.g. ``echo 1 > /proc/<pid>/ksm_force``
+
+You can also set ksm_force to 0 to cancel that force feature of this process
+and unmerge those merged pages which belongs to those VMAs not marked as
+MADV_MERGEABLE of this process. But that still leave those pages belonging to
+VMAs marked as MADV_MERGEABLE merged (fallback to the default state).
+	e.g. ``echo 0 > /proc/<pid>/ksm_force``
+
 .. _ksm_sysfs:
 
 KSM daemon sysfs interface
diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 061744c436d9..8890b8b457a4 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -47,6 +47,7 @@ fixes/update part 1.1  Stefani Seibold <stefani@seibold.net>    June 9 2009
   3.10  /proc/<pid>/timerslack_ns - Task timerslack value
   3.11	/proc/<pid>/patch_state - Livepatch patch operation state
   3.12	/proc/<pid>/arch_status - Task architecture specific information
+  3.13	/proc/<pid>/ksm_force - Setting of mandatory involvement in KSM
 
   4	Configuring procfs
   4.1	Mount options
@@ -2176,6 +2177,22 @@ AVX512_elapsed_ms
   the task is unlikely an AVX512 user, but depends on the workload and the
   scheduling scenario, it also could be a false negative mentioned above.
 
+3.13	/proc/<pid>/ksm_force - Setting of mandatory involvement in KSM
+-----------------------------------------------------------------------
+When CONFIG_KSM is enabled, this file can be used to specify if this
+process's anonymous memory can be involved in KSM scanning without app codes
+explicitly calling madvise to mark memory address as MADV_MERGEABLE.
+
+If writing 1 to this file, the kernel will force all anonymous and qualified
+memory to be involved in KSM scanning without explicitly calling madvise to
+mark memory address as MADV_MERGEABLE. But that is effective only when the
+klob of '/sys/kernel/mm/ksm/run' is set as 1.
+
+If writing 0 to this file, the mandatory KSM feature of this process's will
+be cancelled and unmerge those merged pages which belongs to those areas not
+marked as MADV_MERGEABLE of this process, but leave those pages belonging to
+areas marked as MADV_MERGEABLE merged (fallback to the default state).
+
 Chapter 4: Configuring procfs
 =============================
 
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 8dfa36a99c74..d60f7342f79e 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -96,6 +96,7 @@
 #include <linux/time_namespace.h>
 #include <linux/resctrl.h>
 #include <linux/cn_proc.h>
+#include <linux/ksm.h>
 #include <trace/events/oom.h>
 #include "internal.h"
 #include "fd.h"
@@ -3168,6 +3169,96 @@ static int proc_pid_ksm_merging_pages(struct seq_file *m, struct pid_namespace *
 
 	return 0;
 }
+
+static ssize_t ksm_force_read(struct file *file, char __user *buf, size_t count,
+				loff_t *ppos)
+{
+	struct task_struct *task;
+	struct mm_struct *mm;
+	char buffer[PROC_NUMBUF];
+	ssize_t len;
+	int ret;
+
+	task = get_proc_task(file_inode(file));
+	if (!task)
+		return -ESRCH;
+
+	mm = get_task_mm(task);
+	ret = 0;
+	if (mm) {
+		len = snprintf(buffer, sizeof(buffer), "%d\n", mm->ksm_force);
+		ret =  simple_read_from_buffer(buf, count, ppos, buffer, len);
+		mmput(mm);
+	}
+
+	return ret;
+}
+
+static ssize_t ksm_force_write(struct file *file, const char __user *buf,
+				size_t count, loff_t *ppos)
+{
+	struct task_struct *task;
+	struct mm_struct *mm;
+	char buffer[PROC_NUMBUF];
+	int force;
+	int err = 0;
+
+	memset(buffer, 0, sizeof(buffer));
+	if (count > sizeof(buffer) - 1)
+		count = sizeof(buffer) - 1;
+	if (copy_from_user(buffer, buf, count))
+		return -EFAULT;
+
+	err = kstrtoint(strstrip(buffer), 0, &force);
+	if (err)
+		return err;
+
+	if (force != 0 && force != 1)
+		return -EINVAL;
+
+	task = get_proc_task(file_inode(file));
+	if (!task)
+		return -ESRCH;
+
+	mm = get_task_mm(task);
+	if (!mm)
+		goto out_put_task;
+
+	if (mm->ksm_force != force) {
+		if (mmap_write_lock_killable(mm)) {
+			err = -EINTR;
+			goto out_mmput;
+		}
+
+		if (force == 0)
+			mm->ksm_force = force;
+		else {
+			/*
+			 * Force anonymous pages of this mm to be involved in KSM merging
+			 * without explicitly calling madvise.
+			 */
+			if (!test_bit(MMF_VM_MERGEABLE, &mm->flags))
+				err = __ksm_enter(mm);
+			if (!err)
+				mm->ksm_force = force;
+		}
+
+		mmap_write_unlock(mm);
+	}
+
+out_mmput:
+	mmput(mm);
+out_put_task:
+	put_task_struct(task);
+
+	return err < 0 ? err : count;
+}
+
+static const struct file_operations proc_pid_ksm_force_operations = {
+	.read		= ksm_force_read,
+	.write		= ksm_force_write,
+	.llseek		= generic_file_llseek,
+};
 #endif /* CONFIG_KSM */
 
 #ifdef CONFIG_STACKLEAK_METRICS
@@ -3303,6 +3394,7 @@ static const struct pid_entry tgid_base_stuff[] = {
 #endif
 #ifdef CONFIG_KSM
 	ONE("ksm_merging_pages",  S_IRUSR, proc_pid_ksm_merging_pages),
+	REG("ksm_force", S_IRUSR|S_IWUSR, proc_pid_ksm_force_operations),
 #endif
 };
 
@@ -3639,6 +3731,7 @@ static const struct pid_entry tid_base_stuff[] = {
 #endif
 #ifdef CONFIG_KSM
 	ONE("ksm_merging_pages",  S_IRUSR, proc_pid_ksm_merging_pages),
+	REG("ksm_force", S_IRUSR|S_IWUSR, proc_pid_ksm_force_operations),
 #endif
 };
 
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index b34ff2cdbc4f..1b1592c2f5cf 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -661,6 +661,15 @@ struct mm_struct {
 		 * merging.
 		 */
 		unsigned long ksm_merging_pages;
+		/*
+		 * If true, force anonymous pages of this mm to be involved in KSM
+		 * merging without explicitly calling madvise. It is effctive only
+		 * when the klob of '/sys/kernel/mm/ksm/run' is set as 1. If false,
+		 * cancel the feature of ksm_force of this process and unmerge
+		 * those merged pages which is not madvised as MERGEABLE of this
+		 * process, but leave MERGEABLE areas merged.
+		 */
+		bool ksm_force;
 #endif
 	} __randomize_layout;
 
diff --git a/mm/ksm.c b/mm/ksm.c
index 38360285497a..c9f672dcc72e 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -334,6 +334,34 @@ static void __init ksm_slab_free(void)
 	mm_slot_cache = NULL;
 }
 
+/* Check if vma is qualified for ksmd scanning */
+static bool ksm_vma_check(struct vm_area_struct *vma)
+{
+	unsigned long vm_flags = vma->vm_flags;
+
+	if (!(vma->vm_flags & VM_MERGEABLE) && !(vma->vm_mm->ksm_force))
+		return false;
+
+	if (vm_flags & (VM_SHARED	| VM_MAYSHARE	|
+			VM_PFNMAP	| VM_IO | VM_DONTEXPAND |
+			VM_HUGETLB	| VM_MIXEDMAP))
+		return false;       /* just ignore this vma*/
+
+	if (vma_is_dax(vma))
+		return false;
+
+#ifdef VM_SAO
+	if (vm_flags & VM_SAO)
+		return false;
+#endif
+#ifdef VM_SPARC_ADI
+	if (vm_flags & VM_SPARC_ADI)
+		return false;
+#endif
+
+	return true;
+}
+
 static __always_inline bool is_stable_node_chain(struct stable_node *chain)
 {
 	return chain->rmap_hlist_len == STABLE_NODE_CHAIN;
@@ -523,7 +551,7 @@ static struct vm_area_struct *find_mergeable_vma(struct mm_struct *mm,
 	if (ksm_test_exit(mm))
 		return NULL;
 	vma = vma_lookup(mm, addr);
-	if (!vma || !(vma->vm_flags & VM_MERGEABLE) || !vma->anon_vma)
+	if (!vma || !ksm_vma_check(vma) || !vma->anon_vma)
 		return NULL;
 	return vma;
 }
@@ -2297,7 +2325,7 @@ static struct rmap_item *scan_get_next_rmap_item(struct page **page)
 		vma = find_vma(mm, ksm_scan.address);
 
 	for (; vma; vma = vma->vm_next) {
-		if (!(vma->vm_flags & VM_MERGEABLE))
+		if (!ksm_vma_check(vma))
 			continue;
 		if (ksm_scan.address < vma->vm_start)
 			ksm_scan.address = vma->vm_start;
-- 
2.25.1

