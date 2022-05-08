Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA5551EC7F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 11:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbiEHJbV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 05:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350174AbiEHJbN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 05:31:13 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6A0101D1;
        Sun,  8 May 2022 02:27:16 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id i1so11341146plg.7;
        Sun, 08 May 2022 02:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UPYhM1TdHcEAVOFdRrVOUgQchTCfnoZv3XDvbB8om90=;
        b=bO6BpaVK938s5i4sKd4JAC4qkU/x5twAQMlSRLa0ud/WJSrzu1qhbeRQgIGIiz0ieX
         rruyOHu9JW5wsnLkzyQoANEhjyCiWh093X+kw4sBcPoHGwkHH79oST1UyXyRTy8piI8q
         1AKE4M5kn5SuUxhdFMgazHQhYtsfB5VCRPNYAlnhQasabJpDIFhv1rX8qlbDWS6EtBsr
         ytoAqLZMku4cr+aoPr7jYE6eSXCNCm+M05mUDMg/qtPxXzp4idRn1qKHEqS5F6+7zFMr
         TIDZihpZL3IQOtO2cjtZxONS56JLE4XLXgJUsKKRAuvYw9vwaKlXCymT15B9ZygBg3c9
         LIlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UPYhM1TdHcEAVOFdRrVOUgQchTCfnoZv3XDvbB8om90=;
        b=aq6UG4115fM7hlEKhgV6I+88RxGTqADv4J0Wtnsgg0sXOwOvC8MjjWJkh8fJ78Mx77
         ZbPrAwwicKCgb7wHi8HUCZGhEgVKy0Qp27s+2Ru77bIqDbN1qIYTYysGStYVLUqawe8f
         roDnb0iH6Vk6h3VcxBvh2MUpycClOkxruXyDWkEe4PO3OepNMRKdO5vLmzLv439FwM/C
         WTwGdVqAIQFg5gpiOv1rfGch0ljKLR/CUXlSIQIaaESmRbDqU1+/zuP/1ajsb0vawrbK
         T1Hl0AqjMaUkdpQ/8fYBXOoAGcYGhWZ9okNV7c54yBnhuM1LbRdftz2URYF8c9pre7qu
         J88g==
X-Gm-Message-State: AOAM531CM8CwZ9A7yBkHgRk3Q3N1Qr1DMO0gTpQw5RsQL/C944l7Ppsr
        yQzYhkXI726YdZTd+yy+vck=
X-Google-Smtp-Source: ABdhPJyA5UXIH7lDOw+m15Ca0/RphyNMKJ2n7GiHy+RAUQpyIG35Lh8YdHLcGQX03msYr6mdLdI52g==
X-Received: by 2002:a17:902:f70a:b0:153:88c7:774 with SMTP id h10-20020a170902f70a00b0015388c70774mr11345710plo.166.1652002036362;
        Sun, 08 May 2022 02:27:16 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id u8-20020a1709026e0800b0015e8d4eb233sm4812246plk.125.2022.05.08.02.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 02:27:15 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: xu.xin16@zte.com.cn
To:     akpm@linux-foundation.org
Cc:     cgel.zte@gmail.com, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, ran.xiaokai@zte.com.cn, wang.yong12@zte.com.cn,
        xu.xin16@zte.com.cn, yang.yang29@zte.com.cn,
        zhang.yunkai@zte.com.cn
Subject: [PATCH v5] mm/ksm: introduce ksm_force for each process
Date:   Sun,  8 May 2022 09:27:10 +0000
Message-Id: <20220508092710.930126-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220507105926.d4423601230f698b0f5228d1@linux-foundation.org>
References: <20220507105926.d4423601230f698b0f5228d1@linux-foundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
process and unmerge those merged pages belonging to VMAs which is not
madvised as MADV_MERGEABLE of this process, but leave MADV_MERGEABLE
areas merged.

Signed-off-by: xu xin <xu.xin16@zte.com.cn>
Reviewed-by: Yang Yang <yang.yang29@zte.com.cn>
Reviewed-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
Reviewed-by: wangyong <wang.yong12@zte.com.cn>
Reviewed-by: Yunkai Zhang <zhang.yunkai@zte.com.cn>
---
v5:
- fix typos in Documentation/filesystems/proc.rst
v4:
- fix typos in commit log
- add interface descriptions under Documentation/
v3:
- fix compile error of mm/ksm.c
v2:
- fix a spelling error in commit log.
- remove a redundant condition check in ksm_force_write().
---
 Documentation/admin-guide/mm/ksm.rst | 20 +++++-
 Documentation/filesystems/proc.rst   | 17 +++++
 fs/proc/base.c                       | 99 ++++++++++++++++++++++++++++
 include/linux/mm_types.h             |  9 +++
 mm/ksm.c                             | 32 ++++++++-
 5 files changed, 174 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/mm/ksm.rst b/Documentation/admin-guide/mm/ksm.rst
index b244f0202a03..e42cffa42463 100644
--- a/Documentation/admin-guide/mm/ksm.rst
+++ b/Documentation/admin-guide/mm/ksm.rst
@@ -32,7 +32,7 @@ are swapped back in: ksmd must rediscover their identity and merge again).
 Controlling KSM with madvise
 ============================
 
-KSM only operates on those areas of address space which an application
+KSM can operates on those areas of address space which an application
 has advised to be likely candidates for merging, by using the madvise(2)
 system call::
 
@@ -70,6 +70,24 @@ Applications should be considerate in their use of MADV_MERGEABLE,
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
+this process to be involved in KSM scanning. But It is effective only when the
+klob of ``/sys/kernel/mm/ksm/run`` is set as 1.
+	e.g. ``echo 1 > /proc/<pid>/ksm_force``
+
+You can also set ksm_force to 0 to cancel that force feature of this process
+and unmerge those merged pages which belongs to those VMAs not marked as
+MADV_MERGEABLE of this process. But that will leave those pages belonging to
+VMAs marked as MADV_MERGEABLE merged.
+	e.g. ``echo 0 > /proc/<pid>/ksm_force``
+
 .. _ksm_sysfs:
 
 KSM daemon sysfs interface
diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 061744c436d9..8f959697ae1e 100644
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
+areas marked as MADV_MERGEABLE merged.
+
 Chapter 4: Configuring procfs
 =============================
 
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 8dfa36a99c74..3115ffa4c9fb 100644
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
@@ -3168,6 +3169,102 @@ static int proc_pid_ksm_merging_pages(struct seq_file *m, struct pid_namespace *
 
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
+	if (copy_from_user(buffer, buf, count)) {
+		err = -EFAULT;
+		goto out_return;
+	}
+
+	err = kstrtoint(strstrip(buffer), 0, &force);
+
+	if (err)
+		goto out_return;
+	if (force != 0 && force != 1) {
+		err = -EINVAL;
+		goto out_return;
+	}
+
+	task = get_proc_task(file_inode(file));
+	if (!task) {
+		err = -ESRCH;
+		goto out_return;
+	}
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
+out_return:
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
@@ -3303,6 +3400,7 @@ static const struct pid_entry tgid_base_stuff[] = {
 #endif
 #ifdef CONFIG_KSM
 	ONE("ksm_merging_pages",  S_IRUSR, proc_pid_ksm_merging_pages),
+	REG("ksm_force", S_IRUSR|S_IWUSR, proc_pid_ksm_force_operations),
 #endif
 };
 
@@ -3639,6 +3737,7 @@ static const struct pid_entry tid_base_stuff[] = {
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

