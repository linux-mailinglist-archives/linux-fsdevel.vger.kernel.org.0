Return-Path: <linux-fsdevel+bounces-50170-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1CDAC8AD1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 11:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70EC44E404D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 09:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16BB721E0BB;
	Fri, 30 May 2025 09:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="iLObVoMY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD7221D5AF
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 May 2025 09:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748597386; cv=none; b=F9XfjR0jhPeaN0TW4Lie98vc4Kou0/rLynA0QRnFgm79nvr13SohRZ7NDDtmcb72//DenZ3VuV2BJ17Nx5/Bx5aFzeEFqm3FGhN6i31qJkalgdWhlU/S5ya96bXTqYLHH+172CM45k2qNeVU+7A33Df62tsEGiU7d53ErZJHd6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748597386; c=relaxed/simple;
	bh=S20otgpxbfyI8rSmt5eNc2YoPuXrdf/0GSL9ciOvIuU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gM/aiuq/cxSti9omvATeUmY7zS0su8Lg6UdWaENj7jHTyJFTnP/rlxrrFYVSE+nSM57WgG7ASn9ZrwitNsszdeLdbWyFPufkUMsZv1eHB7JarN3UsWhOJREqMJrEpSe6nTu4CHZ2S0H2hqQgs41msxsELLOo1mw3EhaACq1z4KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=iLObVoMY; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b1396171fb1so1099684a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 May 2025 02:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1748597383; x=1749202183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fsVmARra3PYHgocOota+jP5MYor7RDP1xSKc/otYVfE=;
        b=iLObVoMYwVTx9dhtWeCngYlgKCMrTA89+js5cJ0RTSqzOZ4UgePxNvcf8jYO6Y5tUF
         yT6Cf/7ITvg0YCbz+hQnvej2YkXbHWclcB9TkFDxHJw3LvvBigI/TeocZ8YFUoiwAVD4
         fOjac9/1X7ptj3WKAnchTLK2e7NoPagBOZwkI7Go4RbmNvkaynfvxYRWDqrl6gpkHwoU
         T20DkUTDq2gcdh98euhWD4xZCLZjGfH3Se/xiCQxFmNzDLSq1NhA4/DflY0Dg5z84yJz
         R12oC38E1BmVKU+fjwnStUPCB6XMzTlFwEQqFqV7NuTLfPTtNxGZvAcOxFW7YPGU5OQ0
         zISA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748597383; x=1749202183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fsVmARra3PYHgocOota+jP5MYor7RDP1xSKc/otYVfE=;
        b=IGdbVtsRjDAuggd5CQTqs0KxUnN95kU0sME6kRYJ+3fF0yiQ6QJ1rUo70Y6KcBVqH7
         nPYtq4DT4vrkewUeRZuhPgK+ZXoH94wY5dRJRpzxJqXRZrqceVXjC45BleUNpnykOjPT
         GqKt85eGSNgDbrREct969NBKafPvPnw/6ywFRaZEE8FQEeHQgxHnPEAguQWbKLZj/rYR
         WUkK55spynJmW+FBGrbADUptBNdARcSpXox8CS1vMrvjRmRww1fnnvqDPIrOR8UALPGp
         rLOB9ueqWLyYgc43MHxYD6xhflphlL9PhVqzf9MXjsZKqh7wKnnqBUkS8JcoIQt+/GLn
         IbEg==
X-Forwarded-Encrypted: i=1; AJvYcCVoX2VM3zPbEOI96uiNc1JWO5DVfsPIjqYEgdoy4jLF59AuRIAWfBoifUwDwvtTMBrcYFpklRWP6+ll3/uL@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4tH5HSyOh4H7+yB5KHb0FL6ouz8yBft7mJOe/BAWBuJNALPDX
	5d/lOC6oRda0z/o1BJ5mjGQFLqdtVhj64BPzUz0Bzlcbj6cP1JJVUv7V1HqykqDdwmE=
X-Gm-Gg: ASbGncsuaUXqzpBhkh3lq3XSF5z8vmgpRzfjZc9Fc6EhBbsdsELDjeHue0j3fODgRQ/
	fnUlZwFdPsaLucZ/omd/xEC5Q2BGyKBfTHI4QYwk9JsQhKHKCAtz7qZoLssj0qGDofH88xN4eE8
	lqt7opFQAvlnE3K6d51QpWgBWogELqkgjiiQcglXo1aQhaVTJCfLLQiX2P1TbuhZdS6nHluxsna
	0upObQwKcrTZ3SuDPY1FIJZ/6QmhVMKMFveSaPPbW6InZOJR688U/hpiYWXCHMXTVLqKbDhSdKM
	l4nGYwGVtcEHr0y1EH8NMdrebSvcFHeivTFs7fEelXQdDfGIrHh63ij1Bt5JauBIZrCoaUx1n6Q
	nZw4P9Lk7wDOUG9w/TS9dZhX1zFZdY6A=
X-Google-Smtp-Source: AGHT+IGDxz/qX0egNQr6P0EaiRBDIQcZ9ust5aoVSte6/Q83iWKLonGQ/1cLLq8vU8IelvR0XV1gQw==
X-Received: by 2002:a17:90b:5344:b0:312:b4a:6342 with SMTP id 98e67ed59e1d1-31241e9c28fmr4334365a91.33.1748597382681;
        Fri, 30 May 2025 02:29:42 -0700 (PDT)
Received: from FQ627FTG20.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e29f7b8sm838724a91.2.2025.05.30.02.29.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 30 May 2025 02:29:42 -0700 (PDT)
From: Bo Li <libo.gcs85@bytedance.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	luto@kernel.org,
	kees@kernel.org,
	akpm@linux-foundation.org,
	david@redhat.com,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	peterz@infradead.org
Cc: dietmar.eggemann@arm.com,
	hpa@zytor.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	jannh@google.com,
	pfalcato@suse.de,
	riel@surriel.com,
	harry.yoo@oracle.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	duanxiongchun@bytedance.com,
	yinhongbo@bytedance.com,
	dengliang.1214@bytedance.com,
	xieyongji@bytedance.com,
	chaiwen.cc@bytedance.com,
	songmuchun@bytedance.com,
	yuanzhu@bytedance.com,
	chengguozhu@bytedance.com,
	sunjiadong.lff@bytedance.com,
	Bo Li <libo.gcs85@bytedance.com>
Subject: [RFC v2 05/35] RPAL: enable virtual address space partitions
Date: Fri, 30 May 2025 17:27:33 +0800
Message-Id: <a5737be8dc2fb2f5058f6536f081fed611bdd093.1748594840.git.libo.gcs85@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <cover.1748594840.git.libo.gcs85@bytedance.com>
References: <cover.1748594840.git.libo.gcs85@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Each RPAL service occupies a contiguous 512GB virtual address space, with
its base address determined by the id assigned during initialization. For
userspace virtual address space beyond this 512GB range, we employ memory
ballooning to occupy these regions, ensuring that processes do not utilize
these virtual addresses.

Since the address space layout is determined when the process is loaded,
RPAL sets the unused fields in the header of the ELF binary to the "RPAL"
characters to alter the loading method of RPAL processes, enabling the
process to be located within the correct 512GB address space upon loading.

Signed-off-by: Bo Li <libo.gcs85@bytedance.com>
---
 arch/x86/mm/mmap.c      | 10 +++++
 arch/x86/rpal/Makefile  |  2 +-
 arch/x86/rpal/mm.c      | 70 +++++++++++++++++++++++++++++
 arch/x86/rpal/service.c |  8 ++++
 fs/binfmt_elf.c         | 98 ++++++++++++++++++++++++++++++++++++++++-
 include/linux/rpal.h    | 65 +++++++++++++++++++++++++++
 6 files changed, 251 insertions(+), 2 deletions(-)
 create mode 100644 arch/x86/rpal/mm.c

diff --git a/arch/x86/mm/mmap.c b/arch/x86/mm/mmap.c
index 5ed2109211da..504f2b9a0e8e 100644
--- a/arch/x86/mm/mmap.c
+++ b/arch/x86/mm/mmap.c
@@ -19,6 +19,7 @@
 #include <linux/sched/mm.h>
 #include <linux/compat.h>
 #include <linux/elf-randomize.h>
+#include <linux/rpal.h>
 #include <asm/elf.h>
 #include <asm/io.h>
 
@@ -119,6 +120,15 @@ static void arch_pick_mmap_base(unsigned long *base, unsigned long *legacy_base,
 		*base = mmap_base(random_factor, task_size, rlim_stack);
 }
 
+#ifdef CONFIG_RPAL
+void rpal_pick_mmap_base(struct mm_struct *mm, struct rlimit *rlim_stack)
+{
+	arch_pick_mmap_base(&mm->mmap_base, &mm->mmap_legacy_base,
+			arch_rnd(RPAL_MAX_RAND_BITS), rpal_get_top(mm->rpal_rs),
+			rlim_stack);
+}
+#endif
+
 void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
 {
 	if (mmap_is_legacy())
diff --git a/arch/x86/rpal/Makefile b/arch/x86/rpal/Makefile
index ee3698b5a9b3..2c858a8d7b9e 100644
--- a/arch/x86/rpal/Makefile
+++ b/arch/x86/rpal/Makefile
@@ -2,4 +2,4 @@
 
 obj-$(CONFIG_RPAL)		+= rpal.o
 
-rpal-y := service.o core.o
+rpal-y := service.o core.o mm.o
diff --git a/arch/x86/rpal/mm.c b/arch/x86/rpal/mm.c
new file mode 100644
index 000000000000..f469bcf57b66
--- /dev/null
+++ b/arch/x86/rpal/mm.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * RPAL service level operations
+ * Copyright (c) 2025, ByteDance. All rights reserved.
+ *
+ *     Author: Jiadong Sun <sunjiadong.lff@bytedance.com>
+ */
+
+#include <linux/rpal.h>
+#include <linux/security.h>
+#include <linux/mman.h>
+#include <linux/mm.h>
+
+static inline int rpal_balloon_mapping(unsigned long base, unsigned long size)
+{
+	struct vm_area_struct *vma;
+	unsigned long addr, populate;
+	int is_fail = 0;
+
+	if (size == 0)
+		return 0;
+
+	addr = do_mmap(NULL, base, size, PROT_NONE,
+		       MAP_FIXED | MAP_ANONYMOUS | MAP_PRIVATE,
+		       VM_DONTEXPAND | VM_PFNMAP | VM_DONTDUMP, 0, &populate,
+		       NULL);
+
+	is_fail = base != addr;
+
+	if (is_fail) {
+		pr_info("rpal: Balloon mapping 0x%016lx - 0x%016lx, %s, addr: 0x%016lx\n",
+			base, base + size, is_fail ? "Fail" : "Success", addr);
+	}
+	vma = find_vma(current->mm, addr);
+	if (vma->vm_start != addr || vma->vm_end != addr + size) {
+		is_fail = 1;
+		rpal_err("rpal: find vma 0x%016lx - 0x%016lx fail\n", addr,
+			 addr + size);
+	}
+
+	return is_fail;
+}
+
+#define RPAL_USER_TOP TASK_SIZE
+
+int rpal_balloon_init(unsigned long base)
+{
+	unsigned long top;
+	struct mm_struct *mm = current->mm;
+	int ret;
+
+	top = base + RPAL_ADDR_SPACE_SIZE;
+
+	mmap_write_lock(mm);
+
+	if (base > mmap_min_addr) {
+		ret = rpal_balloon_mapping(mmap_min_addr, base - mmap_min_addr);
+		if (ret)
+			goto out;
+	}
+
+	ret = rpal_balloon_mapping(top, RPAL_USER_TOP - top);
+	if (ret && base > mmap_min_addr)
+		do_munmap(mm, mmap_min_addr, base - mmap_min_addr, NULL);
+
+out:
+	mmap_write_unlock(mm);
+
+	return ret;
+}
diff --git a/arch/x86/rpal/service.c b/arch/x86/rpal/service.c
index 55ecb7e0ef8c..caa4afa5a2c6 100644
--- a/arch/x86/rpal/service.c
+++ b/arch/x86/rpal/service.c
@@ -143,6 +143,11 @@ static void delete_service(struct rpal_service *rs)
 	spin_unlock_irqrestore(&hash_table_lock, flags);
 }
 
+static inline unsigned long calculate_base_address(int id)
+{
+	return RPAL_ADDRESS_SPACE_LOW + RPAL_ADDR_SPACE_SIZE * id;
+}
+
 struct rpal_service *rpal_register_service(void)
 {
 	struct rpal_service *rs;
@@ -168,6 +173,9 @@ struct rpal_service *rpal_register_service(void)
 	if (unlikely(rs->key == RPAL_INVALID_KEY))
 		goto key_fail;
 
+	rs->bad_service = false;
+	rs->base = calculate_base_address(rs->id);
+
 	current->rpal_rs = rs;
 
 	rs->group_leader = get_task_struct(current);
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index a43363d593e5..9d27d9922de4 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -47,6 +47,7 @@
 #include <linux/dax.h>
 #include <linux/uaccess.h>
 #include <linux/rseq.h>
+#include <linux/rpal.h>
 #include <asm/param.h>
 #include <asm/page.h>
 
@@ -814,6 +815,61 @@ static int parse_elf_properties(struct file *f, const struct elf_phdr *phdr,
 	return ret == -ENOENT ? 0 : ret;
 }
 
+#if IS_ENABLED(CONFIG_RPAL)
+static int rpal_create_service(char *e_ident, struct rpal_service **rs,
+			unsigned long *rpal_base, int *retval,
+			struct linux_binprm *bprm, int executable_stack)
+{
+	/*
+	 * The first 16 bytes of the elf binary is magic number, and the last
+	 * 7 bytes of that is reserved and ignored. We use the last 4 bytes
+	 * to indicate a rpal binary. If the last 4 bytes is "RPAL", then this
+	 * is a rpal binary and we need to do register routinue.
+	 */
+	if (memcmp(e_ident + RPAL_MAGIC_OFFSET, RPAL_MAGIC, RPAL_MAGIC_LEN) ==
+	    0) {
+		unsigned long rpal_stack_top = STACK_TOP;
+
+		*rs = rpal_register_service();
+		if (*rs != NULL) {
+			*rpal_base = rpal_get_base(*rs);
+			rpal_stack_top = *rpal_base + RPAL_ADDR_SPACE_SIZE;
+			/*
+			 * We need to recalculate the mmap_base, otherwise the address space
+			 * layout randomization will not make any difference.
+			 */
+			rpal_pick_mmap_base(current->mm, &bprm->rlim_stack);
+		}
+		/*
+		 * RPAL process only has a contiguous 512GB address space, Whose base
+		 * address is given by its struct rpal_service. We need to rearrange
+		 * the user stack in this 512GB address space.
+		 */
+		*retval = setup_arg_pages(bprm,
+					  randomize_stack_top(rpal_stack_top),
+					  executable_stack);
+		/*
+		 * We use memory ballon to avoid kernel allocating vma other than
+		 * the process's 512GB memory.
+		 */
+		if (unlikely(*rs != NULL && rpal_balloon_init(*rpal_base))) {
+			rpal_err("pid: %d, comm: %s: rpal balloon init fail\n",
+					 current->pid, current->comm);
+			rpal_unregister_service(*rs);
+			*rs = NULL;
+			*retval = -EINVAL;
+			goto out;
+		}
+	} else {
+		*retval = setup_arg_pages(bprm, randomize_stack_top(STACK_TOP),
+					  executable_stack);
+	}
+
+out:
+	return 0;
+}
+#endif
+
 static int load_elf_binary(struct linux_binprm *bprm)
 {
 	struct file *interpreter = NULL; /* to shut gcc up */
@@ -836,6 +892,10 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	struct arch_elf_state arch_state = INIT_ARCH_ELF_STATE;
 	struct mm_struct *mm;
 	struct pt_regs *regs;
+#ifdef CONFIG_RPAL
+	struct rpal_service *rs = NULL;
+	unsigned long rpal_base;
+#endif
 
 	retval = -ENOEXEC;
 	/* First of all, some simple consistency checks */
@@ -1008,10 +1068,19 @@ static int load_elf_binary(struct linux_binprm *bprm)
 
 	setup_new_exec(bprm);
 
+#ifdef CONFIG_RPAL
+	/* call original function if fails */
+	if (rpal_create_service((char *)&elf_ex->e_ident, &rs, &rpal_base,
+				&retval, bprm, executable_stack))
+		retval = setup_arg_pages(bprm, randomize_stack_top(STACK_TOP),
+					 executable_stack);
+#else
 	/* Do this so that we can load the interpreter, if need be.  We will
 	   change some of these later */
 	retval = setup_arg_pages(bprm, randomize_stack_top(STACK_TOP),
 				 executable_stack);
+#endif
+
 	if (retval < 0)
 		goto out_free_dentry;
 
@@ -1055,6 +1124,22 @@ static int load_elf_binary(struct linux_binprm *bprm)
 			 * is needed.
 			 */
 			elf_flags |= MAP_FIXED_NOREPLACE;
+#ifdef CONFIG_RPAL
+			/*
+			 * If We load MAP_FIXED binary, it will either fail when
+			 * doing mmap, as we have done the memory balloon before,
+			 * or work well, where we are so lucky to have fixed address
+			 * in it's RPAL address space. A MAP_FIXED binary should
+			 * by no means be a RPAL service. Here we only print
+			 * an error. Maybe we will handle it in the future.
+			 */
+			if (unlikely(rs != NULL)) {
+				rpal_err(
+					"pid: %d, common: %s, load a binary with MAP_FIXED segment\n",
+					current->pid, current->comm);
+				rs->bad_service = true;
+			}
+#endif
 		} else if (elf_ex->e_type == ET_DYN) {
 			/*
 			 * This logic is run once for the first LOAD Program
@@ -1128,6 +1213,12 @@ static int load_elf_binary(struct linux_binprm *bprm)
 				/* Adjust alignment as requested. */
 				if (alignment)
 					load_bias &= ~(alignment - 1);
+#ifdef CONFIG_RPAL
+				if (rs != NULL) {
+					load_bias &= RPAL_RAND_ADDR_SPACE_MASK;
+					load_bias += rpal_base;
+				}
+#endif
 				elf_flags |= MAP_FIXED_NOREPLACE;
 			} else {
 				/*
@@ -1306,7 +1397,12 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	if (!IS_ENABLED(CONFIG_COMPAT_BRK) &&
 	    IS_ENABLED(CONFIG_ARCH_HAS_ELF_RANDOMIZE) &&
 	    elf_ex->e_type == ET_DYN && !interpreter) {
-		elf_brk = ELF_ET_DYN_BASE;
+#ifdef CONFIG_RPAL
+		if (rs && !rs->bad_service)
+			elf_brk = rpal_base;
+		else
+#endif
+			elf_brk = ELF_ET_DYN_BASE;
 		/* This counts as moving the brk, so let brk(2) know. */
 		brk_moved = true;
 	}
diff --git a/include/linux/rpal.h b/include/linux/rpal.h
index 7b9d90b62b3f..f7c0de747f55 100644
--- a/include/linux/rpal.h
+++ b/include/linux/rpal.h
@@ -15,11 +15,17 @@
 #include <linux/workqueue.h>
 #include <linux/hashtable.h>
 #include <linux/atomic.h>
+#include <linux/sizes.h>
 
 #define RPAL_ERROR_MSG "rpal error: "
 #define rpal_err(x...) pr_err(RPAL_ERROR_MSG x)
 #define rpal_err_ratelimited(x...) pr_err_ratelimited(RPAL_ERROR_MSG x)
 
+/* RPAL magic macros in binary elf header */
+#define RPAL_MAGIC "RPAL"
+#define RPAL_MAGIC_OFFSET 12
+#define RPAL_MAGIC_LEN 4
+
 /*
  * The first 512GB is reserved due to mmap_min_addr.
  * The last 512GB is dropped since stack will be initially
@@ -30,6 +36,47 @@
 #define RPAL_FIRST_KEY _AC(1, UL)
 #define RPAL_INVALID_KEY _AC(0, UL)
 
+/*
+ * Process Virtual Address Space Layout (For 4-level Paging)
+ *  |-------------|
+ *  |  No Mapping |
+ *  |-------------| <-- 64 KB (mmap_min_addr)
+ *  |     ...     |
+ *  |-------------| <-- 1 * 512GB
+ *  |  service 0  |
+ *  |-------------| <-- 2 * 512 GB
+ *  |  Service 1  |
+ *  |-------------| <-- 3 * 512 GB
+ *  |  Service 2  |
+ *  |-------------| <-- 4 * 512 GB
+ *  |     ...     |
+ *  |-------------| <-- 255 * 512 GB
+ *  | Service 254 |
+ *  |-------------| <-- 128 TB
+ *  |             |
+ *  |     ...     |
+ *  |-------------| <-- PAGE_OFFSET
+ *  |             |
+ *  |    Kernel   |
+ *  |_____________|
+ *
+ */
+#define RPAL_ADDR_SPACE_SIZE (_AC(512, UL) * SZ_1G)
+/*
+ * Since RPAL restricts the virtual address space used by a single
+ * process to 512GB, the number of bits for address randomization
+ * must be correspondingly reduced; otherwise, issues such as overlaps
+ * in randomized addresses could occur. RPAL employs 20-bit (page number)
+ * address randomization to balance security and usability.
+ */
+#define RPAL_RAND_ADDR_SPACE_MASK _AC(0xfffffff0, UL)
+#define RPAL_MAX_RAND_BITS 20
+
+#define RPAL_NR_ADDR_SPACE 256
+
+#define RPAL_ADDRESS_SPACE_LOW  ((0UL) + RPAL_ADDR_SPACE_SIZE)
+#define RPAL_ADDRESS_SPACE_HIGH ((0UL) + RPAL_NR_ADDR_SPACE * RPAL_ADDR_SPACE_SIZE)
+
 /*
  * Each RPAL process (a.k.a RPAL service) should have a pointer to
  * struct rpal_service in all its tasks' task_struct.
@@ -52,6 +99,10 @@ struct rpal_service {
 	u64 key;
 	/* virtual address space id */
 	int id;
+	/* virtual address space base address of this service */
+	unsigned long base;
+	/* bad rpal binary */
+	bool bad_service;
 
     /*
      * Fields above should never change after initialization.
@@ -86,6 +137,16 @@ struct rpal_service *rpal_get_service(struct rpal_service *rs);
  */
 void rpal_put_service(struct rpal_service *rs);
 
+static inline unsigned long rpal_get_base(struct rpal_service *rs)
+{
+	return rs->base;
+}
+
+static inline unsigned long rpal_get_top(struct rpal_service *rs)
+{
+	return rs->base + RPAL_ADDR_SPACE_SIZE;
+}
+
 #ifdef CONFIG_RPAL
 static inline struct rpal_service *rpal_current_service(void)
 {
@@ -100,4 +161,8 @@ struct rpal_service *rpal_register_service(void);
 struct rpal_service *rpal_get_service_by_key(u64 key);
 void copy_rpal(struct task_struct *p);
 void exit_rpal(bool group_dead);
+int rpal_balloon_init(unsigned long base);
+
+extern void rpal_pick_mmap_base(struct mm_struct *mm,
+	struct rlimit *rlim_stack);
 #endif
-- 
2.20.1


