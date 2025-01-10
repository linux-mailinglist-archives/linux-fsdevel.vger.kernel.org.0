Return-Path: <linux-fsdevel+bounces-38848-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1841BA08CC5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 10:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF7B7168D84
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 09:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA7C20B1E5;
	Fri, 10 Jan 2025 09:47:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mxct.zte.com.cn (mxct.zte.com.cn [58.251.27.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A581F20ADFB;
	Fri, 10 Jan 2025 09:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=58.251.27.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736502447; cv=none; b=DaXtz6xIOpDq82yRcA9cNuUT1juRDp80OakehkBEwlmSrOfXY8PuIGN/fuGhIyPPXgw6jIDxNdX0Xfi6Wmv9kMMludQd6ZPGJRFZq64eOFsQtq8d61z0OvsVOp3plu8u0McDC9iRz3CL8uKaIRoCnoTEPbqTpooo8CXBDh1DYTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736502447; c=relaxed/simple;
	bh=NGjWt383SMJtO0Z2o21cxQKnCOz2Q7xNbu3x6jIoD2k=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=tk6P8M4fATqa1pkG6XHMCbRo3MQO5+G0kg4PHGIAJxcB9fUv4xzwOTwEGIccFoPXYeTgz8BbRPdOX9ptkQWcN/oT972U+/B8jKlA1tQ6s8APnG4M/jJATHpRWwlDT+Xv+Oj/N77zrUi/moRl5vv0/q+Omx8cLBOchBK6MsnYSR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=58.251.27.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mxde.zte.com.cn (unknown [10.35.20.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4YTxVR2qzBzKjT;
	Fri, 10 Jan 2025 17:41:03 +0800 (CST)
Received: from mxhk.zte.com.cn (unknown [192.168.250.137])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mxde.zte.com.cn (FangMail) with ESMTPS id 4YTxVK0HvKzBRHKM;
	Fri, 10 Jan 2025 17:40:57 +0800 (CST)
Received: from mxct.zte.com.cn (unknown [192.168.251.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4YTxV426tKz8R049;
	Fri, 10 Jan 2025 17:40:44 +0800 (CST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4YTxTx0N7Rz501bN;
	Fri, 10 Jan 2025 17:40:37 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl1.zte.com.cn with SMTP id 50A9eVaD045689;
	Fri, 10 Jan 2025 17:40:31 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Fri, 10 Jan 2025 17:40:34 +0800 (CST)
Date: Fri, 10 Jan 2025 17:40:34 +0800 (CST)
X-Zmail-TransId: 2afb6780eb12ffffffff881-70433
X-Mailer: Zmail v1.0
Message-ID: <20250110174034304QOb8eDoqtFkp3_t8mqnqc@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xu.xin16@zte.com.cn>
To: <akpm@linux-foundation.org>
Cc: <david@redhat.com>, <linux-kernel@vger.kernel.org>,
        <wang.yaxin@zte.com.cn>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIHY1XSBrc206IGFkZCBrc20gaW52b2x2ZW1lbnQgaW5mb3JtYXRpb24gZm9yIGVhY2ggcHJvY2Vzcw==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 50A9eVaD045689
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6780EB2E.001/4YTxVR2qzBzKjT

From: xu xin <xu.xin16@zte.com.cn>

In /proc/<pid>/ksm_stat, Add two extra ksm involvement items including
KSM_mergeable and KSM_merge_any. It helps administrators to
better know the system's KSM behavior at process level.

ksm_merge_any: yes/no
	whether the process'mm is added by prctl() into the candidate list
	of KSM or not, and fully enabled at process level.

ksm_mergeable: yes/no
    whether any VMAs of the process'mm are currently applicable to KSM.

Purpose
=======
These two items are just to improve the observability of KSM at process
level, so that users can know if a certain process has enable KSM.

For example, if without these two items, when we look at
/proc/<pid>/ksm_stat and there's no merging pages found, We are not sure
whether it is because KSM was not enabled or because KSM did not
successfully merge any pages.

Althrough "mg" in /proc/<pid>/smaps indicate VM_MERGEABLE, it's opaque
and not very obvious for non professionals.

Signed-off-by: xu xin <xu.xin16@zte.com.cn>
Cc: Wang Yaxin <wang.yaxin@zte.com.cn>
---
Changelog v4 -> v5:
1. Update the documentation.
2. Correct a comment sentence and add purpose statment in commit message.
---
 Documentation/filesystems/proc.rst | 66 ++++++++++++++++++++++++++++++++++++++
 fs/proc/base.c                     | 11 +++++++
 include/linux/ksm.h                |  1 +
 mm/ksm.c                           | 19 +++++++++++
 4 files changed, 97 insertions(+)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 6a882c57a7e7..916f83203de0 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -48,6 +48,7 @@ fixes/update part 1.1  Stefani Seibold <stefani@seibold.net>    June 9 2009
   3.11	/proc/<pid>/patch_state - Livepatch patch operation state
   3.12	/proc/<pid>/arch_status - Task architecture specific information
   3.13  /proc/<pid>/fd - List of symlinks to open files
+  3.14  /proc/<pid/ksm_stat - Information about the process' ksm status.

   4	Configuring procfs
   4.1	Mount options
@@ -2232,6 +2233,71 @@ The number of open files for the process is stored in 'size' member
 of stat() output for /proc/<pid>/fd for fast access.
 -------------------------------------------------------

+3.14 /proc/<pid/ksm_stat - Information about the process' ksm status
+--------------------------------------------------------------------
+When CONFIG_KSM is enabled, each process has this file which displays
+the information of ksm merging status.
+
+Example
+~~~~~~~
+
+::
+
+    / # cat /proc/self/ksm_stat
+    ksm_rmap_items 0
+    ksm_zero_pages 0
+    ksm_merging_pages 0
+    ksm_process_profit 0
+    ksm_merge_any: no
+    ksm_mergeable: no
+
+Description
+~~~~~~~~~~~
+
+ksm_rmap_items
+^^^^^^^^^^^^^^
+
+The number of ksm_rmap_item structure in use. The structure of
+ksm_rmap_item is to store the reverse mapping information for virtual
+addresses. KSM will generate a ksm_rmap_item for each ksm-scanned page
+of the process.
+
+ksm_zero_pages
+^^^^^^^^^^^^^^
+
+When /sys/kernel/mm/ksm/use_zero_pages is enabled, it represent how many
+empty pages are merged with kernel zero pages by KSM.
+
+ksm_merging_pages
+^^^^^^^^^^^^^^^^^
+
+It represents how many pages of this process are involved in KSM merging
+(not including ksm_zero_pages). It is the same with what
+/proc/<pid>/ksm_merging_pages shows.
+
+ksm_process_profit
+^^^^^^^^^^^^^^^^^^
+
+The profit that KSM brings (Saved bytes). KSM can save memory by merging
+identical pages, but also can consume additional memory, because it needs
+to generate a number of rmap_items to save each scanned page's brief rmap
+information. Some of these pages may be merged, but some may not be abled
+to be merged after being checked several times, which are unprofitable
+memory consumed.
+
+ksm_merge_any
+^^^^^^^^^^^^^
+
+It specifies whether the process'mm is added by prctl() into the candidate list
+of KSM or not, and KSM scanning is fully enabled at process level.
+
+ksm_mergeable
+^^^^^^^^^^^^^
+
+It specifies whether any VMAs of the process'mm are currently applicable to KSM.
+
+More information about KSM can be found at Documentation/admin-guide/mm/ksm.rst.
+

 Chapter 4: Configuring procfs
 =============================
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 0edf14a9840e..a50b222a5917 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3269,6 +3269,7 @@ static int proc_pid_ksm_stat(struct seq_file *m, struct pid_namespace *ns,
 				struct pid *pid, struct task_struct *task)
 {
 	struct mm_struct *mm;
+	int ret = 0;

 	mm = get_task_mm(task);
 	if (mm) {
@@ -3276,6 +3277,16 @@ static int proc_pid_ksm_stat(struct seq_file *m, struct pid_namespace *ns,
 		seq_printf(m, "ksm_zero_pages %ld\n", mm_ksm_zero_pages(mm));
 		seq_printf(m, "ksm_merging_pages %lu\n", mm->ksm_merging_pages);
 		seq_printf(m, "ksm_process_profit %ld\n", ksm_process_profit(mm));
+		seq_printf(m, "ksm_merge_any: %s\n",
+				test_bit(MMF_VM_MERGE_ANY, &mm->flags) ? "yes" : "no");
+		ret = mmap_read_lock_killable(mm);
+		if (ret) {
+			mmput(mm);
+			return ret;
+		}
+		seq_printf(m, "ksm_mergeable: %s\n",
+				ksm_process_mergeable(mm) ? "yes" : "no");
+		mmap_read_unlock(mm);
 		mmput(mm);
 	}

diff --git a/include/linux/ksm.h b/include/linux/ksm.h
index 6a53ac4885bb..d73095b5cd96 100644
--- a/include/linux/ksm.h
+++ b/include/linux/ksm.h
@@ -93,6 +93,7 @@ void folio_migrate_ksm(struct folio *newfolio, struct folio *folio);
 void collect_procs_ksm(const struct folio *folio, const struct page *page,
 		struct list_head *to_kill, int force_early);
 long ksm_process_profit(struct mm_struct *);
+bool ksm_process_mergeable(struct mm_struct *mm);

 #else  /* !CONFIG_KSM */

diff --git a/mm/ksm.c b/mm/ksm.c
index 7ac59cde626c..be2eb1778225 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -3263,6 +3263,25 @@ static void wait_while_offlining(void)
 #endif /* CONFIG_MEMORY_HOTREMOVE */

 #ifdef CONFIG_PROC_FS
+/*
+ * The process is mergeable only if any VMA is currently
+ * applicable to KSM.
+ *
+ * The mmap lock must be held in read mode.
+ */
+bool ksm_process_mergeable(struct mm_struct *mm)
+{
+	struct vm_area_struct *vma;
+
+	mmap_assert_locked(mm);
+	VMA_ITERATOR(vmi, mm, 0);
+	for_each_vma(vmi, vma)
+		if (vma->vm_flags & VM_MERGEABLE)
+			return true;
+
+	return false;
+}
+
 long ksm_process_profit(struct mm_struct *mm)
 {
 	return (long)(mm->ksm_merging_pages + mm_ksm_zero_pages(mm)) * PAGE_SIZE -
-- 
2.15.2

