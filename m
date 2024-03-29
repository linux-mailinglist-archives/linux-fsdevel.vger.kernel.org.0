Return-Path: <linux-fsdevel+bounces-15670-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A768916F9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 11:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AF1C1C234BD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 10:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC64A69D37;
	Fri, 29 Mar 2024 10:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NpdolpcQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06F11E886;
	Fri, 29 Mar 2024 10:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711708857; cv=none; b=KxViV8bIMcobZoZq2sIsFdPkESGpdPvbW7AP8QDJk4Ezui6q1QTcv47vbC4tWBddZehsRiHAGA99soEVJM/xYiQZXxMEmskwN6PgJh6GyUAb+hgicMm6adW1+LpL+O34/7gpiy5tMB3ESNn6PWYqI7ARWECxUTkMdAduVwcVD54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711708857; c=relaxed/simple;
	bh=8QhnzJ92/JfF8yO7xxDB7/MufKwwvN9L53CvmP6hR+I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LmTNY2+xFG386upzrF3F1glYekHNeWq0xpO6JntaRZ6W/RihlXwf4jN4RC3g9VUxNiuy7hWxpOnVoLzSUITe3mD7zpfYRZvhV4u4WvmztBNTBdgRjmcuC0X0VPbgVJsskfkYAwgfZOKuex68CW934mwgEk0mYEwknBP2a88v4Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NpdolpcQ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e2178b2cf2so13423995ad.0;
        Fri, 29 Mar 2024 03:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711708854; x=1712313654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aKfQ46G6jxb2DuzNIXY3MtD45W75p83CICPlnE2JT2k=;
        b=NpdolpcQBtn6fWxcAkcEAiEOR0jjoVALjY06AfCwCnfz+iJ18E6IQVUt0DERwq7n3P
         mwbE7T/eDX2wfiYlAN/1M1XUeJOs+L70gyMw/9IcwI4iB0Tgfcop5ejLuCE+jOwLwLSC
         8ZdL7Qo8punoLTjlOX5UZnmGXlypX4eI8t5wTGp/RYrtvNpiXyz2T3lu6y0aFanhGQd5
         p3/9GcXZnaJC1PaS+1Ag85STtZYZpYELWKZZoQfRMWSuZVHU4nXxg03SwN/7F2KWM2Hz
         Bex3J+IE7FjMze+MDb1YLOl22c2whCxpy/OTJwklPdHeM2+oGwSLAcULxgYmGZSrn/nI
         Y0/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711708854; x=1712313654;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aKfQ46G6jxb2DuzNIXY3MtD45W75p83CICPlnE2JT2k=;
        b=A162EylaUhPoz9hGFmwczYjSDXCg0R2O453bZvZVUefPbtetNnwSY6CYkri9auaots
         b1yks+S3HzENiJJcadzfmy5xANdAPvdMnZzkNzwzHVkPltyUe7/upbhsc4Y41Zyyt9OM
         8r5eKw1zrTqWRbQplYXtw9ho0i8Radzgo7v1t9U3cdEDK/L2/qSb8pGheMAxZLzw3Won
         uzMLDVIMgD+SR6kLkBTYj03pcn9BjhmAaJ10+gvHoidY3IQPY77/hPzDQOJjg3vSHrZS
         UUZmEW1fzlnHvcy7K1HLO81/hZSjt2mmtI3AP16VYWJJaOM6E5n8hU9L84h/dsA5C09l
         PjZg==
X-Forwarded-Encrypted: i=1; AJvYcCVgGFsmJaRPbzuJk2CD250vJBFQ06kdZc+Yfnu7YGXOnIBBNeP+5K1qsxLakIDpEGRvUQmklbyzmw0cd1OnyCZEwlCB70mWXVkgeDEvOsuXRXnvH7YZtkvE7L/2OMXBS9xmavZkJZWR4hC2vg==
X-Gm-Message-State: AOJu0Yy1KAD89ZCKU8zhOboMo4wZ9Db3MmR3O6rQKN3msXSoKxENOsbk
	zQn+3/27y03l9VOxnmF/y5PO/2nqFHOrLHiXjEfdCEIjJw9FypLI
X-Google-Smtp-Source: AGHT+IFVUCR1L7yGKqPxTGBiHlr3ZkSWgaA9fBgb1xAwcZhX/BTuph9psT54dF7FRXk6WXl6pgKfHw==
X-Received: by 2002:a17:902:7848:b0:1e2:a70:247e with SMTP id e8-20020a170902784800b001e20a70247emr2028165pln.18.1711708853797;
        Fri, 29 Mar 2024 03:40:53 -0700 (PDT)
Received: from localhost.localdomain ([47.89.83.80])
        by smtp.gmail.com with ESMTPSA id y4-20020a170902ed4400b001e0abeb8fb5sm3162693plb.271.2024.03.29.03.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 03:40:53 -0700 (PDT)
From: Hui Zhu <teawater@gmail.com>
X-Google-Original-From: Hui Zhu <teawater@antgroup.com>
To: akpm@linux-foundation.org,
	brauner@kernel.org,
	oleg@redhat.com,
	jlayton@kernel.org,
	adobriyan@gmail.com,
	yang.lee@linux.alibaba.com,
	xu.xin16@zte.com.cn,
	casey@schaufler-ca.com,
	mic@digikod.net,
	en.wolsieffer@hefring.com,
	serge@hallyn.com,
	david@redhat.com,
	usama.anjum@collabora.com,
	avagin@google.com,
	peterx@redhat.com,
	hughd@google.com,
	ryan.roberts@arm.com,
	wangkefeng.wang@huawei.com,
	shr@devkernel.io,
	ran.xiaokai@zte.com.cn,
	willy@infradead.org,
	xialonglong1@huawei.com,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Cc: teawater@antgroup.com,
	teawater@gmail.com
Subject: [RFC] mm: Introduce uKSM for user-controlled KSM
Date: Fri, 29 Mar 2024 18:40:35 +0800
Message-ID: <20240329104035.62942-1-teawater@antgroup.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

uKSM (user space control Kernel SamePage Merging) is an extension to the
existing Kernel SamePage Merging (KSM) facility. This enhancement
addresses the flexibility limitations of the current KSM implementation,
allowing for user-space control over page merging activities. With uKSM,
user-space applications can now interact directly with KSM functionality
via proc interfaces, providing them with the capability to inform kernel
decisions with more context-specific information.

Current limitations of KSM include the kernel's sole responsibility for
identifying and merging identical pages, which restricts adaptability to
diverse user requirements. For instance, virtual machine clean file
caches are prime candidates for KSM, but the user had no control over
managing these pages until now. Additionally, KSM can cause the
splitting of transparent huge pages (THPs), which may not always be
desirable depending on the task. Users also need finer control over the
prioritization and frequency of page scans, as well as grouping tasks
for page merging within specific groups only.

To overcome these challenges, uKSM introduces several proc interfaces
for
managing page merging:
- /proc/uksm/merge enables the merging of two pages given their process
  IDs and addresses.
- /proc/uksm/unmerge allows unmerging a previously merged KSM page.
- /proc/uksm/cmp provides a lightweight mechanism to check page content
  equivalence before invoking a merge operation.
- /proc/uksm/lru_add_drain_all facilitates efficient merging of newly
  added LRU pages without the overhead of calling lru_add_drain_all on
  every merge operation.
- /proc/task_id/uksm_pagemap delivers extended page information useful
  for identifying mergeable pages with additional uKSM-specific
  metadata.

This feature is governed by the CONFIG_UKSM compile-time option, which
depends on CONFIG_KSM being enabled. The bulk of the functionality is
implemented in mm/uksm.c.

A sample application demonstrating the use of uKSM interfaces for
tracking and merging pages of specified tasks is available at:
https://github.com/teawater/uksmd

Signed-off-by: Hui Zhu <teawater@antgroup.com>
---
 fs/proc/base.c        |   6 +
 fs/proc/internal.h    |   3 +
 fs/proc/task_mmu.c    | 147 +++++++++-
 include/linux/errno.h |   2 +
 include/linux/ksm.h   |  38 ++-
 mm/Kconfig            |  12 +
 mm/Makefile           |   1 +
 mm/ksm.c              |  64 ++++-
 mm/swap.c             |   5 +
 mm/uksm.c             | 643 ++++++++++++++++++++++++++++++++++++++++++
 mm/uksm.h             |  76 +++++
 11 files changed, 974 insertions(+), 23 deletions(-)
 create mode 100644 mm/uksm.c
 create mode 100644 mm/uksm.h

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 18550c071d71..969b669dff6c 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3359,6 +3359,9 @@ static const struct pid_entry tgid_base_stuff[] = {
 	ONE("ksm_merging_pages",  S_IRUSR, proc_pid_ksm_merging_pages),
 	ONE("ksm_stat",  S_IRUSR, proc_pid_ksm_stat),
 #endif
+#ifdef CONFIG_UKSM
+	REG("uksm_pagemap",    S_IRUSR, proc_uksm_pagemap_operations),
+#endif
 };
 
 static int proc_tgid_base_readdir(struct file *file, struct dir_context *ctx)
@@ -3698,6 +3701,9 @@ static const struct pid_entry tid_base_stuff[] = {
 	ONE("ksm_merging_pages",  S_IRUSR, proc_pid_ksm_merging_pages),
 	ONE("ksm_stat",  S_IRUSR, proc_pid_ksm_stat),
 #endif
+#ifdef CONFIG_UKSM
+	REG("uksm_pagemap",    S_IRUSR, proc_uksm_pagemap_operations),
+#endif
 };
 
 static int proc_tid_base_readdir(struct file *file, struct dir_context *ctx)
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index a71ac5379584..8bf0a143177e 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -303,6 +303,9 @@ extern const struct file_operations proc_pid_smaps_operations;
 extern const struct file_operations proc_pid_smaps_rollup_operations;
 extern const struct file_operations proc_clear_refs_operations;
 extern const struct file_operations proc_pagemap_operations;
+#ifdef CONFIG_UKSM
+extern const struct file_operations proc_uksm_pagemap_operations;
+#endif
 
 extern unsigned long task_vsize(struct mm_struct *);
 extern unsigned long task_statm(struct mm_struct *,
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 23fbab954c20..5f39ede89d92 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -384,7 +384,7 @@ const struct file_operations proc_pid_maps_operations = {
  */
 #define PSS_SHIFT 12
 
-#ifdef CONFIG_PROC_PAGE_MONITOR
+#if defined(CONFIG_PROC_PAGE_MONITOR) || defined(CONFIG_UKSM)
 struct mem_size_stats {
 	unsigned long resident;
 	unsigned long shared_clean;
@@ -1322,20 +1322,40 @@ const struct file_operations proc_clear_refs_operations = {
 	.llseek		= noop_llseek,
 };
 
+#ifdef CONFIG_UKSM
+typedef struct {
+	u64 pme;
+	u64 uksm_pme;
+} uksm_pagemap_entry_t;
+#endif
+
 typedef struct {
 	u64 pme;
 } pagemap_entry_t;
 
 struct pagemapread {
 	int pos, len;		/* units: PM_ENTRY_BYTES, not bytes */
+#ifdef CONFIG_UKSM
+	union {
+		pagemap_entry_t *buffer;
+		uksm_pagemap_entry_t *upm;
+	};
+#else
 	pagemap_entry_t *buffer;
+#endif
 	bool show_pfn;
+#ifdef CONFIG_UKSM
+	bool is_uksm;
+#endif
 };
 
 #define PAGEMAP_WALK_SIZE	(PMD_SIZE)
 #define PAGEMAP_WALK_MASK	(PMD_MASK)
 
 #define PM_ENTRY_BYTES		sizeof(pagemap_entry_t)
+#ifdef CONFIG_UKSM
+#define UKSM_PM_ENTRY_BYTES	sizeof(uksm_pagemap_entry_t)
+#endif
 #define PM_PFRAME_BITS		55
 #define PM_PFRAME_MASK		GENMASK_ULL(PM_PFRAME_BITS - 1, 0)
 #define PM_SOFT_DIRTY		BIT_ULL(55)
@@ -1352,6 +1372,38 @@ static inline pagemap_entry_t make_pme(u64 frame, u64 flags)
 	return (pagemap_entry_t) { .pme = (frame & PM_PFRAME_MASK) | flags };
 }
 
+#ifdef CONFIG_UKSM
+#define UKSM_CRC_BITS		32
+#define UKSM_CRC_MASK		GENMASK_ULL(UKSM_CRC_BITS - 1, 0)
+#define UKSM_CRC_PRESENT	BIT_ULL(63)
+#define UKSM_PM_THP		BIT_ULL(62)
+#define UKSM_PM_KSM		BIT_ULL(61)
+
+static inline u64 make_uksm_pme(u32 crc, u64 flags)
+{
+	return (((u64)crc) & UKSM_CRC_MASK) | flags;
+}
+
+static int add_to_pagemap_uksm(pagemap_entry_t *pme,
+			       struct pagemapread *pm, u64 uksm_pme)
+{
+	if (pm->is_uksm) {
+		pm->upm[pm->pos].pme = pme->pme;
+		pm->upm[pm->pos].uksm_pme = uksm_pme;
+		pm->pos++;
+	} else
+		pm->buffer[pm->pos++] = *pme;
+	if (pm->pos >= pm->len)
+		return PM_END_OF_BUFFER;
+	return 0;
+}
+
+static int add_to_pagemap(pagemap_entry_t *pme,
+			  struct pagemapread *pm)
+{
+	return add_to_pagemap_uksm(pme, pm, 0);
+}
+#else
 static int add_to_pagemap(pagemap_entry_t *pme, struct pagemapread *pm)
 {
 	pm->buffer[pm->pos++] = *pme;
@@ -1359,6 +1411,7 @@ static int add_to_pagemap(pagemap_entry_t *pme, struct pagemapread *pm)
 		return PM_END_OF_BUFFER;
 	return 0;
 }
+#endif
 
 static int pagemap_pte_hole(unsigned long start, unsigned long end,
 			    __always_unused int depth, struct mm_walk *walk)
@@ -1400,13 +1453,23 @@ static int pagemap_pte_hole(unsigned long start, unsigned long end,
 	return err;
 }
 
+#ifdef CONFIG_UKSM
+static pagemap_entry_t pte_to_pagemap_entry_uksm(struct pagemapread *pm,
+		struct vm_area_struct *vma, unsigned long addr, pte_t pte,
+		u64 *uksm_pme)
+#else
 static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
 		struct vm_area_struct *vma, unsigned long addr, pte_t pte)
+#endif
 {
 	u64 frame = 0, flags = 0;
 	struct page *page = NULL;
 	bool migration = false;
 
+#ifdef CONFIG_UKSM
+	*uksm_pme = 0;
+#endif
+
 	if (pte_present(pte)) {
 		if (pm->show_pfn)
 			frame = pte_pfn(pte);
@@ -1444,8 +1507,21 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
 			flags |= PM_UFFD_WP;
 	}
 
-	if (page && !PageAnon(page))
-		flags |= PM_FILE;
+	if (page) {
+		if (!PageAnon(page))
+			flags |= PM_FILE;
+#ifdef CONFIG_UKSM
+		else if ((flags & PM_PRESENT) && pm->is_uksm && pm->show_pfn) {
+			u64 flags = UKSM_CRC_PRESENT;
+
+			if (PageKsm(page))
+				flags |= UKSM_PM_KSM;
+
+			*uksm_pme = make_uksm_pme(ksm_calc_checksum(page),
+						  flags);
+		}
+#endif
+	}
 	if (page && !migration && page_mapcount(page) == 1)
 		flags |= PM_MMAP_EXCLUSIVE;
 	if (vma->vm_flags & VM_SOFTDIRTY)
@@ -1518,7 +1594,17 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
 		for (; addr != end; addr += PAGE_SIZE) {
 			pagemap_entry_t pme = make_pme(frame, flags);
 
-			err = add_to_pagemap(&pme, pm);
+#ifdef CONFIG_UKSM
+			if ((flags & PM_PRESENT) && pm->is_uksm &&
+			    pm->show_pfn) {
+				u32 crc = ksm_calc_checksum(pfn_to_page(frame));
+				u64 uksm_pme = make_uksm_pme(crc,
+					UKSM_CRC_PRESENT | UKSM_PM_THP);
+
+				err = add_to_pagemap_uksm(&pme, pm, uksm_pme);
+			} else
+#endif
+				err = add_to_pagemap(&pme, pm);
 			if (err)
 				break;
 			if (pm->show_pfn) {
@@ -1545,8 +1631,16 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
 	for (; addr < end; pte++, addr += PAGE_SIZE) {
 		pagemap_entry_t pme;
 
+#ifdef CONFIG_UKSM
+		u64 uksm_pme;
+
+		pme = pte_to_pagemap_entry_uksm(pm, vma, addr,
+						ptep_get(pte), &uksm_pme);
+		err = add_to_pagemap_uksm(&pme, pm, uksm_pme);
+#else
 		pme = pte_to_pagemap_entry(pm, vma, addr, ptep_get(pte));
 		err = add_to_pagemap(&pme, pm);
+#endif
 		if (err)
 			break;
 	}
@@ -1645,8 +1739,8 @@ static const struct mm_walk_ops pagemap_ops = {
  * determine which areas of memory are actually mapped and llseek to
  * skip over unmapped regions.
  */
-static ssize_t pagemap_read(struct file *file, char __user *buf,
-			    size_t count, loff_t *ppos)
+static ssize_t pagemap_read_1(struct file *file, char __user *buf,
+			      size_t count, loff_t *ppos, bool is_uksm)
 {
 	struct mm_struct *mm = file->private_data;
 	struct pagemapread pm;
@@ -1655,13 +1749,20 @@ static ssize_t pagemap_read(struct file *file, char __user *buf,
 	unsigned long start_vaddr;
 	unsigned long end_vaddr;
 	int ret = 0, copied = 0;
+	u64 entry_bytes = PM_ENTRY_BYTES;
 
 	if (!mm || !mmget_not_zero(mm))
 		goto out;
 
+#ifdef CONFIG_UKSM
+	if (is_uksm)
+		entry_bytes = UKSM_PM_ENTRY_BYTES;
+	pm.is_uksm = is_uksm;
+#endif
+
 	ret = -EINVAL;
 	/* file position must be aligned */
-	if ((*ppos % PM_ENTRY_BYTES) || (count % PM_ENTRY_BYTES))
+	if ((*ppos % entry_bytes) || (count % entry_bytes))
 		goto out_mm;
 
 	ret = 0;
@@ -1672,13 +1773,13 @@ static ssize_t pagemap_read(struct file *file, char __user *buf,
 	pm.show_pfn = file_ns_capable(file, &init_user_ns, CAP_SYS_ADMIN);
 
 	pm.len = (PAGEMAP_WALK_SIZE >> PAGE_SHIFT);
-	pm.buffer = kmalloc_array(pm.len, PM_ENTRY_BYTES, GFP_KERNEL);
+	pm.buffer = kmalloc_array(pm.len, entry_bytes, GFP_KERNEL);
 	ret = -ENOMEM;
 	if (!pm.buffer)
 		goto out_mm;
 
 	src = *ppos;
-	svpfn = src / PM_ENTRY_BYTES;
+	svpfn = src / entry_bytes;
 	end_vaddr = mm->task_size;
 
 	/* watch out for wraparound */
@@ -1692,7 +1793,7 @@ static ssize_t pagemap_read(struct file *file, char __user *buf,
 		start_vaddr = untagged_addr_remote(mm, svpfn << PAGE_SHIFT);
 		mmap_read_unlock(mm);
 
-		end = start_vaddr + ((count / PM_ENTRY_BYTES) << PAGE_SHIFT);
+		end = start_vaddr + ((count / entry_bytes) << PAGE_SHIFT);
 		if (end >= start_vaddr && end < mm->task_size)
 			end_vaddr = end;
 	}
@@ -1718,7 +1819,7 @@ static ssize_t pagemap_read(struct file *file, char __user *buf,
 		mmap_read_unlock(mm);
 		start_vaddr = end;
 
-		len = min(count, PM_ENTRY_BYTES * pm.pos);
+		len = min(count, entry_bytes * pm.pos);
 		if (copy_to_user(buf, pm.buffer, len)) {
 			ret = -EFAULT;
 			goto out_free;
@@ -2516,6 +2617,12 @@ static long do_pagemap_cmd(struct file *file, unsigned int cmd,
 	}
 }
 
+static ssize_t pagemap_read(struct file *file, char __user *buf,
+			    size_t count, loff_t *ppos)
+{
+	return pagemap_read_1(file, buf, count, ppos, false);
+}
+
 const struct file_operations proc_pagemap_operations = {
 	.llseek		= mem_lseek, /* borrow this */
 	.read		= pagemap_read,
@@ -2524,7 +2631,23 @@ const struct file_operations proc_pagemap_operations = {
 	.unlocked_ioctl = do_pagemap_cmd,
 	.compat_ioctl	= do_pagemap_cmd,
 };
-#endif /* CONFIG_PROC_PAGE_MONITOR */
+
+#ifdef CONFIG_UKSM
+static ssize_t uksm_pagemap_read(struct file *file, char __user *buf,
+				 size_t count, loff_t *ppos)
+{
+	return pagemap_read_1(file, buf, count, ppos, true);
+}
+
+const struct file_operations proc_uksm_pagemap_operations = {
+	.llseek		= mem_lseek,
+	.read		= uksm_pagemap_read,
+	.open		= pagemap_open,
+	.release	= pagemap_release,
+};
+#endif
+
+#endif /* CONFIG_PROC_PAGE_MONITOR || CONFIG_UKSM */
 
 #ifdef CONFIG_NUMA
 
diff --git a/include/linux/errno.h b/include/linux/errno.h
index 8b0c754bab02..bd9580ba38cd 100644
--- a/include/linux/errno.h
+++ b/include/linux/errno.h
@@ -33,4 +33,6 @@
 #define ERECALLCONFLICT	530	/* conflict with recalled state */
 #define ENOGRACE	531	/* NFS file lock reclaim refused */
 
+#define EPAGESNOTSAME	541	/* KSM two pages are not the same. */
+
 #endif
diff --git a/include/linux/ksm.h b/include/linux/ksm.h
index 401348e9f92b..3aba6d908f5d 100644
--- a/include/linux/ksm.h
+++ b/include/linux/ksm.h
@@ -16,6 +16,8 @@
 #include <linux/sched/coredump.h>
 
 #ifdef CONFIG_KSM
+#ifndef CONFIG_UKSM
+
 int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
 		unsigned long end, int advice, unsigned long *vm_flags);
 
@@ -26,6 +28,14 @@ int ksm_disable(struct mm_struct *mm);
 
 int __ksm_enter(struct mm_struct *mm);
 void __ksm_exit(struct mm_struct *mm);
+
+#else /* CONFIG_UKSM */
+
+void uksm_folio_clear(struct folio *folio);
+u32 ksm_calc_checksum(struct page *page);
+
+#endif /* CONFIG_UKSM */
+
 /*
  * To identify zeropages that were mapped by KSM, we reuse the dirty bit
  * in the PTE. If the PTE is dirty, the zeropage was mapped by KSM when
@@ -38,11 +48,14 @@ extern unsigned long ksm_zero_pages;
 static inline void ksm_might_unmap_zero_page(struct mm_struct *mm, pte_t pte)
 {
 	if (is_ksm_zero_pte(pte)) {
+#ifndef CONFIG_UKSM
 		ksm_zero_pages--;
+#endif
 		mm->ksm_zero_pages--;
 	}
 }
 
+#ifndef CONFIG_UKSM
 static inline int ksm_fork(struct mm_struct *mm, struct mm_struct *oldmm)
 {
 	int ret;
@@ -65,6 +78,8 @@ static inline void ksm_exit(struct mm_struct *mm)
 		__ksm_exit(mm);
 }
 
+#endif /* !CONFIG_UKSM */
+
 /*
  * When do_swap_page() first faults in from swap what used to be a KSM page,
  * no problem, it will be assigned to this vma's anon_vma; but thereafter,
@@ -91,8 +106,9 @@ void collect_procs_ksm(struct page *page, struct list_head *to_kill,
 long ksm_process_profit(struct mm_struct *);
 #endif /* CONFIG_PROC_FS */
 
-#else  /* !CONFIG_KSM */
+#endif /* CONFIG_KSM */
 
+#if !defined(CONFIG_KSM) || defined(CONFIG_UKSM)
 static inline void ksm_add_vma(struct vm_area_struct *vma)
 {
 }
@@ -111,6 +127,7 @@ static inline void ksm_exit(struct mm_struct *mm)
 {
 }
 
+#ifndef CONFIG_KSM
 static inline void ksm_might_unmap_zero_page(struct mm_struct *mm, pte_t pte)
 {
 }
@@ -121,6 +138,7 @@ static inline void collect_procs_ksm(struct page *page,
 {
 }
 #endif
+#endif /* !CONFIG_KSM */
 
 #ifdef CONFIG_MMU
 static inline int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
@@ -129,6 +147,7 @@ static inline int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
 	return 0;
 }
 
+#ifndef CONFIG_KSM
 static inline struct folio *ksm_might_need_to_copy(struct folio *folio,
 			struct vm_area_struct *vma, unsigned long addr)
 {
@@ -143,7 +162,22 @@ static inline void rmap_walk_ksm(struct folio *folio,
 static inline void folio_migrate_ksm(struct folio *newfolio, struct folio *old)
 {
 }
-#endif /* CONFIG_MMU */
 #endif /* !CONFIG_KSM */
+#endif /* CONFIG_MMU */
+#endif /* !CONFIG_KSM || CONFIG_UKSM */
+
+#ifdef CONFIG_UKSM
+
+static inline int ksm_enable_merge_any(struct mm_struct *mm)
+{
+	return 0;
+}
+
+static inline int ksm_disable_merge_any(struct mm_struct *mm)
+{
+	return 0;
+}
+
+#endif /* CONFIG_UKSM */
 
 #endif /* __LINUX_KSM_H */
diff --git a/mm/Kconfig b/mm/Kconfig
index b1448aa81e15..810acb234591 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -706,6 +706,18 @@ config KSM
 	  until a program has madvised that an area is MADV_MERGEABLE, and
 	  root has set /sys/kernel/mm/ksm/run to 1 (if CONFIG_SYSFS is set).
 
+config UKSM
+	bool "Enable user space control KSM"
+	depends on KSM
+	help
+	  uKSM (user space control Kernel SamePage Merging) is an extension to the
+	  existing Kernel SamePage Merging (KSM) facility. This enhancement
+	  addresses the flexibility limitations of the current KSM implementation,
+	  allowing for user-space control over page merging activities. With uKSM,
+	  user-space applications can now interact directly with KSM functionality
+	  via proc interfaces, providing them with the capability to inform kernel
+	  decisions with more context-specific information.
+
 config DEFAULT_MMAP_MIN_ADDR
 	int "Low address space to protect from user allocation"
 	depends on MMU
diff --git a/mm/Makefile b/mm/Makefile
index e4b5b75aaec9..c623b4699b94 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -79,6 +79,7 @@ obj-$(CONFIG_SPARSEMEM)	+= sparse.o
 obj-$(CONFIG_SPARSEMEM_VMEMMAP) += sparse-vmemmap.o
 obj-$(CONFIG_MMU_NOTIFIER) += mmu_notifier.o
 obj-$(CONFIG_KSM) += ksm.o
+obj-$(CONFIG_UKSM) += uksm.o
 obj-$(CONFIG_PAGE_POISONING) += page_poison.o
 obj-$(CONFIG_KASAN)	+= kasan/
 obj-$(CONFIG_KFENCE) += kfence/
diff --git a/mm/ksm.c b/mm/ksm.c
index 8c001819cf10..3ee8dab61cee 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -49,6 +49,12 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/ksm.h>
 
+#ifdef CONFIG_UKSM
+
+#include "uksm.h"
+
+#else /* !CONFIG_UKSM */
+
 #ifdef CONFIG_NUMA
 #define NUMA(x)		(x)
 #define DO_NUMA(x)	do { (x); } while (0)
@@ -599,6 +605,8 @@ static inline void free_stable_node(struct ksm_stable_node *stable_node)
 	kmem_cache_free(stable_node_cache, stable_node);
 }
 
+#endif /* !CONFIG_UKSM */
+
 /*
  * ksmd, and unmerge_and_remove_all_rmap_items(), must not touch an mm's
  * page tables after it has passed through ksm_exit() - which, if necessary,
@@ -713,6 +721,8 @@ static int break_ksm(struct vm_area_struct *vma, unsigned long addr, bool lock_v
 	return (ret & VM_FAULT_OOM) ? -ENOMEM : 0;
 }
 
+#ifndef CONFIG_UKSM
+
 static bool vma_ksm_compatible(struct vm_area_struct *vma)
 {
 	if (vma->vm_flags & (VM_SHARED  | VM_MAYSHARE   | VM_PFNMAP  |
@@ -735,19 +745,25 @@ static bool vma_ksm_compatible(struct vm_area_struct *vma)
 	return true;
 }
 
-static struct vm_area_struct *find_mergeable_vma(struct mm_struct *mm,
+#endif /* !CONFIG_UKSM */
+
+struct vm_area_struct *find_mergeable_vma(struct mm_struct *mm,
 		unsigned long addr)
 {
 	struct vm_area_struct *vma;
 	if (ksm_test_exit(mm))
 		return NULL;
 	vma = vma_lookup(mm, addr);
+#ifdef CONFIG_UKSM
+	if (!vma || !vma->anon_vma)
+#else
 	if (!vma || !(vma->vm_flags & VM_MERGEABLE) || !vma->anon_vma)
+#endif
 		return NULL;
 	return vma;
 }
 
-static void break_cow(struct ksm_rmap_item *rmap_item)
+void break_cow(struct ksm_rmap_item *rmap_item)
 {
 	struct mm_struct *mm = rmap_item->mm;
 	unsigned long addr = rmap_item->address;
@@ -766,6 +782,8 @@ static void break_cow(struct ksm_rmap_item *rmap_item)
 	mmap_read_unlock(mm);
 }
 
+#ifndef CONFIG_UKSM
+
 static struct page *get_mergeable_page(struct ksm_rmap_item *rmap_item)
 {
 	struct mm_struct *mm = rmap_item->mm;
@@ -1054,6 +1072,8 @@ static void remove_trailing_rmap_items(struct ksm_rmap_item **rmap_list)
 	}
 }
 
+#endif /* !CONFIG_UKSM */
+
 /*
  * Though it's very tempting to unmerge rmap_items from stable tree rather
  * than check every pte of a given vma, the locking doesn't quite work for
@@ -1067,8 +1087,8 @@ static void remove_trailing_rmap_items(struct ksm_rmap_item **rmap_list)
  * to the next pass of ksmd - consider, for example, how ksmd might be
  * in cmp_and_merge_page on one of the rmap_items we would be removing.
  */
-static int unmerge_ksm_pages(struct vm_area_struct *vma,
-			     unsigned long start, unsigned long end, bool lock_vma)
+int unmerge_ksm_pages(struct vm_area_struct *vma,
+		      unsigned long start, unsigned long end, bool lock_vma)
 {
 	unsigned long addr;
 	int err = 0;
@@ -1084,6 +1104,8 @@ static int unmerge_ksm_pages(struct vm_area_struct *vma,
 	return err;
 }
 
+#ifndef CONFIG_UKSM
+
 static inline struct ksm_stable_node *folio_stable_node(struct folio *folio)
 {
 	return folio_test_ksm(folio) ? folio_raw_mapping(folio) : NULL;
@@ -1266,7 +1288,9 @@ static int unmerge_and_remove_all_rmap_items(void)
 }
 #endif /* CONFIG_SYSFS */
 
-static u32 calc_checksum(struct page *page)
+#endif /* !CONFIG_UKSM */
+
+u32 ksm_calc_checksum(struct page *page)
 {
 	u32 checksum;
 	void *addr = kmap_local_page(page);
@@ -1428,7 +1452,9 @@ static int replace_page(struct vm_area_struct *vma, struct page *page,
 		 * the dirty bit in zero page's PTE is set.
 		 */
 		newpte = pte_mkdirty(pte_mkspecial(pfn_pte(page_to_pfn(kpage), vma->vm_page_prot)));
+#ifndef CONFIG_UKSM
 		ksm_zero_pages++;
+#endif
 		mm->ksm_zero_pages++;
 		/*
 		 * We're replacing an anonymous page with a zero page, which is
@@ -1471,6 +1497,8 @@ static int replace_page(struct vm_area_struct *vma, struct page *page,
  *         or NULL the first time when we want to use page as kpage.
  *
  * This function returns 0 if the pages were merged, -EFAULT otherwise.
+ * Return -EPAGESNOTSAME if page and kpage are not the same.
+ *
  */
 static int try_to_merge_one_page(struct vm_area_struct *vma,
 				 struct page *page, struct page *kpage)
@@ -1523,6 +1551,8 @@ static int try_to_merge_one_page(struct vm_area_struct *vma,
 			err = 0;
 		} else if (pages_identical(page, kpage))
 			err = replace_page(vma, page, kpage, orig_pte);
+		else
+			err = -EPAGESNOTSAME;
 	}
 
 out_unlock:
@@ -1537,8 +1567,8 @@ static int try_to_merge_one_page(struct vm_area_struct *vma,
  *
  * This function returns 0 if the pages were merged, -EFAULT otherwise.
  */
-static int try_to_merge_with_ksm_page(struct ksm_rmap_item *rmap_item,
-				      struct page *page, struct page *kpage)
+int try_to_merge_with_ksm_page(struct ksm_rmap_item *rmap_item,
+				struct page *page, struct page *kpage)
 {
 	struct mm_struct *mm = rmap_item->mm;
 	struct vm_area_struct *vma;
@@ -1553,8 +1583,10 @@ static int try_to_merge_with_ksm_page(struct ksm_rmap_item *rmap_item,
 	if (err)
 		goto out;
 
+#ifndef CONFIG_UKSM
 	/* Unstable nid is in union with stable anon_vma: remove first */
 	remove_rmap_item_from_tree(rmap_item);
+#endif /* !CONFIG_UKSM */
 
 	/* Must get reference to anon_vma while still holding mmap_lock */
 	rmap_item->anon_vma = vma->anon_vma;
@@ -1566,6 +1598,8 @@ static int try_to_merge_with_ksm_page(struct ksm_rmap_item *rmap_item,
 	return err;
 }
 
+#ifndef CONFIG_UKSM
+
 /*
  * try_to_merge_two_pages - take two identical pages and prepare them
  * to be merged into one page.
@@ -2363,7 +2397,7 @@ static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_ite
 	 * don't want to insert it in the unstable tree, and we don't want
 	 * to waste our time searching for something identical to it there.
 	 */
-	checksum = calc_checksum(page);
+	checksum = ksm_calc_checksum(page);
 	if (rmap_item->oldchecksum != checksum) {
 		rmap_item->oldchecksum = checksum;
 		return;
@@ -3049,6 +3083,8 @@ void __ksm_exit(struct mm_struct *mm)
 	trace_ksm_exit(mm);
 }
 
+#endif /* !CONFIG_UKSM */
+
 struct folio *ksm_might_need_to_copy(struct folio *folio,
 			struct vm_area_struct *vma, unsigned long addr)
 {
@@ -3060,8 +3096,12 @@ struct folio *ksm_might_need_to_copy(struct folio *folio,
 		return folio;
 
 	if (folio_test_ksm(folio)) {
+#ifdef CONFIG_UKSM
+		if (folio_stable_node(folio))
+#else
 		if (folio_stable_node(folio) &&
 		    !(ksm_run & KSM_RUN_UNMERGE))
+#endif
 			return folio;	/* no need to copy it */
 	} else if (!anon_vma) {
 		return folio;		/* no need to copy it */
@@ -3238,6 +3278,7 @@ void folio_migrate_ksm(struct folio *newfolio, struct folio *folio)
 }
 #endif /* CONFIG_MIGRATION */
 
+#ifndef CONFIG_UKSM
 #ifdef CONFIG_MEMORY_HOTREMOVE
 static void wait_while_offlining(void)
 {
@@ -3366,6 +3407,7 @@ static void wait_while_offlining(void)
 {
 }
 #endif /* CONFIG_MEMORY_HOTREMOVE */
+#endif /* !CONFIG_UKSM */
 
 #ifdef CONFIG_PROC_FS
 long ksm_process_profit(struct mm_struct *mm)
@@ -3375,6 +3417,8 @@ long ksm_process_profit(struct mm_struct *mm)
 }
 #endif /* CONFIG_PROC_FS */
 
+#ifndef CONFIG_UKSM
+
 #ifdef CONFIG_SYSFS
 /*
  * This all compiles without CONFIG_SYSFS, but is a waste of space.
@@ -3910,7 +3954,7 @@ static int __init ksm_init(void)
 	int err;
 
 	/* The correct value depends on page size and endianness */
-	zero_checksum = calc_checksum(ZERO_PAGE(0));
+	zero_checksum = ksm_calc_checksum(ZERO_PAGE(0));
 	/* Default to false for backwards compatibility */
 	ksm_use_zero_pages = false;
 
@@ -3949,3 +3993,5 @@ static int __init ksm_init(void)
 	return err;
 }
 subsys_initcall(ksm_init);
+
+#endif /* !CONFIG_UKSM */
diff --git a/mm/swap.c b/mm/swap.c
index 500a09a48dfd..565abdcfe115 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -37,6 +37,7 @@
 #include <linux/page_idle.h>
 #include <linux/local_lock.h>
 #include <linux/buffer_head.h>
+#include <linux/ksm.h>
 
 #include "internal.h"
 
@@ -96,6 +97,10 @@ static void __page_cache_release(struct folio *folio, struct lruvec **lruvecp,
 		zone_stat_mod_folio(folio, NR_MLOCK, -nr_pages);
 		count_vm_events(UNEVICTABLE_PGCLEARED, nr_pages);
 	}
+#ifdef CONFIG_UKSM
+	if (unlikely(folio_test_ksm(folio)))
+		uksm_folio_clear(folio);
+#endif
 }
 
 /*
diff --git a/mm/uksm.c b/mm/uksm.c
new file mode 100644
index 000000000000..b4dff2332a5f
--- /dev/null
+++ b/mm/uksm.c
@@ -0,0 +1,643 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * User space control memory merging support.
+ *
+ * Copyright (C) 2023 Ant Group, Inc.
+ * Authors:
+ *	Hui Zhu (teawater)
+ */
+
+#include <linux/errno.h>
+#include <linux/mm.h>
+#include <linux/mm_inline.h>
+#include <linux/fs.h>
+#include <linux/mman.h>
+#include <linux/sched.h>
+#include <linux/sched/mm.h>
+#include <linux/sched/coredump.h>
+#include <linux/rwsem.h>
+#include <linux/pagemap.h>
+#include <linux/rmap.h>
+#include <linux/spinlock.h>
+#include <linux/xxhash.h>
+#include <linux/delay.h>
+#include <linux/kthread.h>
+#include <linux/wait.h>
+#include <linux/slab.h>
+#include <linux/rbtree.h>
+#include <linux/memory.h>
+#include <linux/mmu_notifier.h>
+#include <linux/swap.h>
+#include <linux/ksm.h>
+#include <linux/hashtable.h>
+#include <linux/freezer.h>
+#include <linux/oom.h>
+#include <linux/numa.h>
+#include <linux/pagewalk.h>
+#include <linux/proc_fs.h>
+
+#include <asm/tlbflush.h>
+#include "internal.h"
+#include "uksm.h"
+
+static inline int lock_page_killable(struct page *page)
+{
+	struct folio *folio;
+
+	might_sleep();
+
+	folio = page_folio(page);
+	if (!folio_trylock(folio))
+		return __folio_lock_killable(folio);
+	return 0;
+}
+
+static struct kmem_cache *rmap_item_cache;
+static struct kmem_cache *stable_node_cache;
+static atomic64_t rmap_item_count = ATOMIC64_INIT(0);
+static atomic64_t stable_node_count = ATOMIC64_INIT(0);
+
+static inline struct ksm_rmap_item *alloc_rmap_item(void)
+{
+	struct ksm_rmap_item *rmap_item;
+
+	rmap_item = kmem_cache_zalloc(rmap_item_cache, GFP_KERNEL |
+					__GFP_NORETRY | __GFP_NOWARN);
+	if (rmap_item)
+		atomic64_inc(&rmap_item_count);
+
+	return rmap_item;
+}
+
+static inline void free_rmap_item(struct ksm_rmap_item *rmap_item)
+{
+	if (rmap_item) {
+		kmem_cache_free(rmap_item_cache, rmap_item);
+		atomic64_dec(&rmap_item_count);
+	}
+}
+
+static inline struct ksm_stable_node *alloc_stable_node(void)
+{
+	struct ksm_stable_node *stable_node;
+
+	stable_node = kmem_cache_alloc(stable_node_cache, GFP_KERNEL | __GFP_HIGH);
+	if (stable_node)
+		atomic64_inc(&stable_node_count);
+
+	return stable_node;
+}
+
+static inline void free_stable_node(struct ksm_stable_node *stable_node)
+{
+	if (stable_node) {
+		kmem_cache_free(stable_node_cache, stable_node);
+		atomic64_dec(&stable_node_count);
+	}
+}
+
+static int
+uksm_get_page(struct mm_struct *mm,  unsigned long addr, struct page **pagep)
+{
+	int ret = -EINVAL;
+	struct vm_area_struct *vma;
+
+	mmap_read_lock(mm);
+	vma = vma_lookup(mm, addr);
+	if (!vma || !vma->anon_vma)
+		goto out;
+
+	*pagep = follow_page(vma, addr, FOLL_GET);
+	if (IS_ERR_OR_NULL(*pagep)) {
+		if (*pagep)
+			ret = PTR_ERR(*pagep);
+		goto out;
+	}
+	if (is_zone_device_page(*pagep))
+		goto out_putpage;
+
+	if (!PageAnon(*pagep))
+		goto out_putpage;
+
+	flush_anon_page(vma, *pagep, addr);
+	flush_dcache_page(*pagep);
+
+	ret = 0;
+out_putpage:
+	if (ret)
+		put_page(*pagep);
+out:
+	mmap_read_unlock(mm);
+
+	return ret;
+}
+
+/* If target page is KSM page, *rmap_item_p will be set to NULL.  */
+static int
+uksm_get_page_rmap_item(struct mm_struct *mm,  unsigned long addr,
+			struct page **pagep, struct ksm_rmap_item **rmap_item_p)
+{
+	int ret;
+	bool is_ksm;
+
+	ret = uksm_get_page(mm, addr, pagep);
+	if (ret)
+		goto out;
+
+	ret = lock_page_killable(*pagep);
+	if (ret)
+		goto out_putpage;
+	is_ksm = PageKsm(*pagep);
+	unlock_page(*pagep);
+
+	if (!is_ksm) {
+		*rmap_item_p = alloc_rmap_item();
+		if (!*rmap_item_p) {
+			ret = -ENOMEM;
+			goto out_putpage;
+		}
+		(*rmap_item_p)->mm = mm;
+		(*rmap_item_p)->address = addr;
+	} else
+		*rmap_item_p = NULL;
+
+out_putpage:
+	if (ret)
+		put_page(*pagep);
+out:
+	return ret;
+}
+
+static int uksm_merge(struct mm_struct *mm1, struct mm_struct *mm2,
+		      unsigned long addr1, unsigned long addr2)
+{
+	int ret;
+	struct page *page1, *page2, *kpage;
+	struct ksm_rmap_item *ri1, *ri2, *ri;
+	struct ksm_stable_node *stable_node = NULL;
+
+	ret = uksm_get_page_rmap_item(mm1, addr1, &page1, &ri1);
+	if (ret)
+		goto out;
+	ret = uksm_get_page_rmap_item(mm2, addr2, &page2, &ri2);
+	if (ret)
+		goto put_page1;
+	if (page1 == page2)
+		goto put_page2;
+	if (!ri1 && !ri2) {
+		ret = -EINVAL;
+		goto put_page2;
+	}
+
+	if (ri1 && ri2) {
+		/* change page1 to ksm page. */
+		stable_node = alloc_stable_node();
+		if (!stable_node) {
+			ret = -ENOMEM;
+			goto put_page2;
+		}
+		INIT_HLIST_HEAD(&stable_node->hlist);
+		stable_node->kpfn = page_to_pfn(page1);
+		ret = try_to_merge_with_ksm_page(ri1, page1, NULL);
+		if (ret)
+			goto free_stable_node;
+	}
+
+	if (ri2) {
+		kpage = page1;
+		ri = ri2;
+		ret = try_to_merge_with_ksm_page(ri, page2, kpage);
+	} else {
+		kpage = page2;
+		ri = ri1;
+		ret = try_to_merge_with_ksm_page(ri, page1, kpage);
+	}
+	if (ret)
+		goto break_cow_page1;
+
+	ret = lock_page_killable(kpage);
+	if (ret)
+		goto break_cow_page;
+
+	if (!stable_node) {
+		stable_node = page_stable_node(kpage);
+		if (!stable_node) {
+			ret = -EBUSY;
+			goto unlock_kpage;
+		}
+	} else
+		set_page_stable_node(kpage, stable_node);
+
+	if (ri1) {
+		ri1->head = stable_node;
+		hlist_add_head(&ri1->hlist, &stable_node->hlist);
+	}
+	if (ri2) {
+		ri2->head = stable_node;
+		hlist_add_head(&ri2->hlist, &stable_node->hlist);
+	}
+
+unlock_kpage:
+	unlock_page(kpage);
+
+break_cow_page:
+	if (ret) {
+		/* change no-ksm page to normal page. */
+		break_cow(ri);
+	}
+
+break_cow_page1:
+	if (ret && ri1 && ri2) {
+		/*
+		 * if both pages are no-ksm page, ri1 will be set to
+		 * ksm page before merge.
+		 * following change it back to normal page.
+		 */
+		break_cow(ri1);
+	}
+
+free_stable_node:
+	if (ret)
+		free_stable_node(stable_node);
+
+put_page2:
+	put_page(page2);
+	if (ret)
+		free_rmap_item(ri2);
+
+put_page1:
+	put_page(page1);
+	if (ret)
+		free_rmap_item(ri1);
+out:
+	return ret;
+}
+
+static int uksm_cmp(struct mm_struct *mm1, struct mm_struct *mm2,
+		    unsigned long addr1, unsigned long addr2)
+{
+	int ret;
+	struct page *page1, *page2;
+
+	ret = uksm_get_page(mm1, addr1, &page1);
+	if (ret)
+		goto out;
+	ret = uksm_get_page(mm2, addr2, &page2);
+	if (ret)
+		goto put_page1;
+
+	if (page1 == page2)
+		goto put_page2;
+
+	if (!pages_identical(page1, page2))
+		ret = -EPAGESNOTSAME;
+
+put_page2:
+	put_page(page2);
+
+put_page1:
+	put_page(page1);
+out:
+	return ret;
+}
+
+static int uksm_unmerge(struct mm_struct *mm,
+			unsigned long start, unsigned long end)
+{
+	struct vm_area_struct *vma;
+	int ret;
+
+	mmap_read_lock(mm);
+
+	vma = find_mergeable_vma(mm, start);
+	if (!vma || end > vma->vm_end) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	ret = unmerge_ksm_pages(vma, start, end, false);
+
+unlock:
+	mmap_read_unlock(mm);
+	return ret;
+}
+
+static struct mm_struct *uksm_pid2mm(pid_t upid)
+{
+	struct pid *pid;
+	struct task_struct *task;
+	struct mm_struct *mm = NULL;
+
+	pid = find_get_pid(upid);
+	if (!pid)
+		goto out;
+	task = get_pid_task(pid, PIDTYPE_PID);
+	if (!task)
+		goto put_pid;
+	mm = get_task_mm(task);
+
+	put_task_struct(task);
+put_pid:
+	put_pid(pid);
+out:
+	return mm;
+}
+
+static ssize_t uksm_merge_write_1(bool merge, struct file *file, const char __user *buf,
+				  size_t count, loff_t *pos)
+{
+	char kbuf[128];
+	int ret;
+	char *p, *tok;
+	pid_t pid1, pid2;
+	struct mm_struct *mm1, *mm2;
+	unsigned long addr1, addr2;
+
+	if (count >= 128)
+		goto einval;
+	ret = strncpy_from_user(kbuf, buf, count);
+	if (ret < 0)
+		goto out;
+	kbuf[count] = '\0';
+	p = kbuf;
+
+	/* Get pid1 */
+	tok = strsep(&p, " ");
+	if (!tok)
+		goto einval;
+	ret = kstrtoint(tok, 0, &pid1);
+	if (ret)
+		goto out;
+
+	/* Get addr1 */
+	tok = strsep(&p, " ");
+	if (!tok)
+		goto einval;
+	ret = kstrtoul(tok, 0, &addr1);
+	if (ret)
+		goto out;
+	if (addr1 & ~PAGE_MASK)
+		goto einval;
+
+	/* Get pid2 */
+	tok = strsep(&p, " ");
+	if (!tok)
+		goto einval;
+	ret = kstrtoint(tok, 0, &pid2);
+	if (ret)
+		goto out;
+
+	/* Get addr2 */
+	if (!p)
+		goto einval;
+	ret = kstrtoul(p, 0, &addr2);
+	if (ret)
+		goto out;
+	if (addr2 & ~PAGE_MASK)
+		goto einval;
+
+	ret = -ESRCH;
+	mm1 = uksm_pid2mm(pid1);
+	if (!mm1)
+		goto out;
+
+	mm2 = uksm_pid2mm(pid2);
+	if (!mm2)
+		goto put_mm1;
+
+	if (merge)
+		ret = uksm_merge(mm1, mm2, addr1, addr2);
+	else
+		ret = uksm_cmp(mm1, mm2, addr1, addr2);
+
+	mmput(mm2);
+put_mm1:
+	mmput(mm1);
+out:
+	if (!ret)
+		ret = count;
+	return ret;
+
+einval:
+	ret = -EINVAL;
+	goto out;
+}
+
+static ssize_t uksm_merge_write(struct file *file, const char __user *buf,
+				size_t count, loff_t *pos)
+{
+	return uksm_merge_write_1(true, file, buf, count, pos);
+}
+
+static const struct proc_ops uksm_merge_ops = {
+	.proc_write = uksm_merge_write,
+};
+
+static ssize_t uksm_unmerge_write(struct file *file, const char __user *buf,
+				  size_t count, loff_t *pos)
+{
+	char kbuf[128];
+	int ret;
+	char *p, *tok;
+	pid_t pid;
+	struct mm_struct *mm;
+	unsigned long start, end;
+
+	if (count >= 128)
+		goto einval;
+	ret = strncpy_from_user(kbuf, buf, count);
+	if (ret < 0)
+		goto out;
+	kbuf[count] = '\0';
+	p = kbuf;
+
+	/* Get pid */
+	tok = strsep(&p, " ");
+	if (!tok)
+		goto einval;
+	ret = kstrtoint(tok, 0, &pid);
+	if (ret)
+		goto out;
+
+	/* Get start */
+	tok = strsep(&p, " ");
+	if (!tok)
+		goto einval;
+	ret = kstrtoul(tok, 0, &start);
+	if (ret)
+		goto out;
+	if (start & ~PAGE_MASK)
+		goto einval;
+
+	/* Get end */
+	if (p) {
+		ret = kstrtoul(p, 0, &end);
+		if (ret)
+			goto out;
+		if (end & ~PAGE_MASK)
+			goto einval;
+		if (end < start)
+			goto einval;
+	} else
+		end = start + PAGE_SIZE;
+
+	mm = uksm_pid2mm(pid);
+	if (!mm) {
+		ret = -ESRCH;
+		goto out;
+	}
+
+	ret = uksm_unmerge(mm, start, end);
+
+	mmput(mm);
+out:
+	if (!ret)
+		ret = count;
+	return ret;
+
+einval:
+	ret = -EINVAL;
+	goto out;
+}
+
+static const struct proc_ops uksm_unmerge_ops = {
+	.proc_write = uksm_unmerge_write,
+};
+
+static ssize_t uksm_cmp_write(struct file *file, const char __user *buf,
+			      size_t count, loff_t *pos)
+{
+	return uksm_merge_write_1(false, file, buf, count, pos);
+}
+
+static const struct proc_ops uksm_cmp_ops = {
+	.proc_write = uksm_cmp_write,
+};
+
+static ssize_t uksm_lru_add_drain_all_write(struct file *file,
+					const char __user *buf,
+					size_t count,
+					loff_t *pos)
+{
+	lru_add_drain_all();
+	return count;
+}
+
+static const struct proc_ops uksm_lru_add_drain_all_ops = {
+	.proc_write	= uksm_lru_add_drain_all_write,
+};
+
+static int uksm_status_show(struct seq_file *s, void *unused)
+{
+	seq_printf(s, "rmap_item_count: %lld\n", (u64)atomic64_read(&rmap_item_count));
+	seq_printf(s, "stable_node_count: %lld\n", (u64)atomic64_read(&stable_node_count));
+
+	return 0;
+}
+
+static int uksm_status_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, uksm_status_show, pde_data(inode));
+}
+
+static const struct proc_ops uksm_status_ops = {
+	.proc_open		= uksm_status_open,
+	.proc_read		= seq_read,
+	.proc_lseek		= seq_lseek,
+	.proc_release		= single_release,
+};
+
+static struct proc_dir_entry *uksm_dir;
+
+void uksm_folio_clear(struct folio *folio)
+{
+	struct ksm_stable_node *stable_node = folio_raw_mapping(folio);
+
+	if (stable_node) {
+		struct ksm_rmap_item *rmap_item;
+		struct hlist_node *n;
+
+		hlist_for_each_entry_safe(rmap_item, n, &stable_node->hlist, hlist) {
+			hlist_del_init(&rmap_item->hlist);
+			put_anon_vma(rmap_item->anon_vma);
+			free_rmap_item(rmap_item);
+		}
+		free_stable_node(stable_node);
+		set_page_stable_node(&folio->page, NULL);
+	}
+}
+
+#define KSM_KMEM_CACHE(__struct, __flags) kmem_cache_create(#__struct,\
+		sizeof(struct __struct), __alignof__(struct __struct),\
+		(__flags), NULL)
+
+static int __init uksm_slab_init(void)
+{
+	rmap_item_cache = KSM_KMEM_CACHE(ksm_rmap_item, 0);
+	if (!rmap_item_cache)
+		goto out;
+
+	stable_node_cache = KSM_KMEM_CACHE(ksm_stable_node, 0);
+	if (!stable_node_cache)
+		goto out_free;
+
+	return 0;
+
+out_free:
+	kmem_cache_destroy(rmap_item_cache);
+out:
+	return -ENOMEM;
+}
+
+static void __init uksm_slab_free(void)
+{
+	kmem_cache_destroy(stable_node_cache);
+	kmem_cache_destroy(rmap_item_cache);
+}
+
+static int __init uksm_init(void)
+{
+	int ret = uksm_slab_init();
+
+	if (ret)
+		goto out;
+
+	ret = -ENOMEM;
+
+	uksm_dir = proc_mkdir("uksm", NULL);
+	if (!uksm_dir)
+		goto out_free;
+
+	if (!proc_create("merge", 0200, uksm_dir, &uksm_merge_ops))
+		goto out_free;
+
+	if (!proc_create("unmerge", 0200, uksm_dir, &uksm_unmerge_ops))
+		goto out_free;
+
+	if (!proc_create("cmp", 0200, uksm_dir, &uksm_cmp_ops))
+		goto out_free;
+
+	if (!proc_create("lru_add_drain_all", 0200, uksm_dir,
+			&uksm_lru_add_drain_all_ops))
+		goto out_free;
+
+	if (!proc_create("status", 0400, uksm_dir, &uksm_status_ops))
+		goto release_proc;
+
+	ret = 0;
+release_proc:
+	if (ret) {
+		remove_proc_entry("merge", uksm_dir);
+		remove_proc_entry("unmerge", uksm_dir);
+		remove_proc_entry("cmp", uksm_dir);
+		remove_proc_entry("lru_add_drain_all", uksm_dir);
+		remove_proc_entry("status", uksm_dir);
+		remove_proc_entry("uksm", NULL);
+	}
+out_free:
+	if (ret)
+		uksm_slab_free();
+out:
+	return ret;
+}
+subsys_initcall(uksm_init);
diff --git a/mm/uksm.h b/mm/uksm.h
new file mode 100644
index 000000000000..541ac42076e2
--- /dev/null
+++ b/mm/uksm.h
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2023 Ant Group, Inc.
+ * Authors:
+ *	Hui Zhu (teawater)
+ */
+
+#ifndef __MM_UKSM_H
+#define __MM_UKSM_H
+
+/**
+ * struct ksm_stable_node - node of the stable rbtree
+ * @node: rb node of this ksm page in the stable tree
+ * @head: (overlaying parent) &migrate_nodes indicates temporarily on that list
+ * @hlist_dup: linked into the stable_node->hlist with a stable_node chain
+ * @list: linked into migrate_nodes, pending placement in the proper node tree
+ * @hlist: hlist head of rmap_items using this ksm page
+ * @kpfn: page frame number of this ksm page (perhaps temporarily on wrong nid)
+ * @chain_prune_time: time of the last full garbage collection
+ * @rmap_hlist_len: number of rmap_item entries in hlist or STABLE_NODE_CHAIN
+ * @nid: NUMA node id of stable tree in which linked (may not match kpfn)
+ */
+struct ksm_stable_node {
+	struct hlist_head hlist;
+	unsigned long kpfn;
+};
+
+/**
+ * struct ksm_rmap_item - reverse mapping item for virtual addresses
+ * @rmap_list: next rmap_item in mm_slot's singly-linked rmap_list
+ * @anon_vma: pointer to anon_vma for this mm,address, when in stable tree
+ * @nid: NUMA node id of unstable tree in which linked (may not match page)
+ * @mm: the memory structure this rmap_item is pointing into
+ * @address: the virtual address this rmap_item tracks (+ flags in low bits)
+ * @oldchecksum: previous checksum of the page at that virtual address
+ * @node: rb node of this rmap_item in the unstable tree
+ * @head: pointer to stable_node heading this list in the stable tree
+ * @hlist: link into hlist of rmap_items hanging off that stable_node
+ * @age: number of scan iterations since creation
+ * @remaining_skips: how many scans to skip
+ */
+struct ksm_rmap_item {
+	struct anon_vma *anon_vma;
+	struct mm_struct *mm;
+	unsigned long address;
+
+	struct ksm_stable_node *head;
+	struct hlist_node hlist;
+};
+
+static inline void set_page_stable_node(struct page *page,
+					struct ksm_stable_node *stable_node)
+{
+	VM_BUG_ON_PAGE(PageAnon(page) && PageAnonExclusive(page), page);
+	page->mapping = (void *)((unsigned long)stable_node | PAGE_MAPPING_KSM);
+}
+
+static inline struct ksm_stable_node *folio_stable_node(struct folio *folio)
+{
+	return folio_test_ksm(folio) ? folio_raw_mapping(folio) : NULL;
+}
+
+static inline struct ksm_stable_node *page_stable_node(struct page *page)
+{
+	return folio_stable_node(page_folio(page));
+}
+
+struct vm_area_struct *find_mergeable_vma(struct mm_struct *mm,
+					  unsigned long addr);
+int try_to_merge_with_ksm_page(struct ksm_rmap_item *rmap_item,
+				struct page *page, struct page *kpage);
+void break_cow(struct ksm_rmap_item *rmap_item);
+int unmerge_ksm_pages(struct vm_area_struct *vma,
+		      unsigned long start, unsigned long end, bool lock_vma);
+
+#endif	/* __MM_UKSM_H */
-- 
2.19.1.6.gb485710b


