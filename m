Return-Path: <linux-fsdevel+bounces-21856-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4A890BFDC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2024 01:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A0DAB220E1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 23:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1384D19A2A4;
	Mon, 17 Jun 2024 23:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="rFIjbmnr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4EF71991A3;
	Mon, 17 Jun 2024 23:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718667704; cv=none; b=ZX7YxX77W0WrVOgvMvB0CVKTobVwaf1vZDsEYNkUUSMr3tjNWct6k3ZQyZpHrb4yeJSUsVbqxqOLz4gpFg8STMefEFhE3FV9pZsk+A94O7N4GvGDVlqeKbEFDhXyhnTeSi0E/bCNHxlksRzIHYTDlDVBZvM0dPd1PLvOucD91jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718667704; c=relaxed/simple;
	bh=vf2yH6Zku+faQc7knbMO5hC1Hbbz01B414/kGg6JJYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m3sLF2z0bs2Qzi8k8wrfBYTk24UD83yvGtV/pAZPqO9Ayd5YXOGn32i85DnTPT85moYoV+NI8VeLfvs4en6L9edDnneC02jZDt72rnGO4vm0ptePHsaxkElw6JvvmuP5pYGEmNvvdGwot7vwf3fw/oRWDReWmKqSCRq1l0qIHRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=rFIjbmnr; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from xps-8930.corp.microsoft.com (unknown [131.107.160.48])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4B2E020B7007;
	Mon, 17 Jun 2024 16:41:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4B2E020B7007
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1718667702;
	bh=OoNWht+g6Mgy8Z0xXNF0BBYWigNOFUC9fBG64RGD97E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rFIjbmnrkqAP3yOavX0B9vmwCDgkI9EUVW40OEGplcS1Yia6LwuBuG6UMQwccoHQj
	 JNhfSkscVrr6aJLBGQH7BVQ5VFiQFZjR/UjFm/pMtvAqDjqL6Tn0xBtimytuMABGby
	 OqFT4+RxS/hFZEht1EAlbfFeFsfck0+qpZ6Xel9E=
From: Roman Kisel <romank@linux.microsoft.com>
To: akpm@linux-foundation.org,
	apais@linux.microsoft.com,
	ardb@kernel.org,
	bigeasy@linutronix.de,
	brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	keescook@chromium.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	nagvijay@microsoft.com,
	oleg@redhat.com,
	tandersen@netflix.com,
	vincent.whitchurch@axis.com,
	viro@zeniv.linux.org.uk
Cc: apais@microsoft.com,
	ssengar@microsoft.com,
	sunilmut@microsoft.com,
	vdso@hexbites.dev
Subject: [PATCH 1/1] binfmt_elf, coredump: Log the reason of the failed core dumps
Date: Mon, 17 Jun 2024 16:41:30 -0700
Message-ID: <20240617234133.1167523-2-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240617234133.1167523-1-romank@linux.microsoft.com>
References: <20240617234133.1167523-1-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Missing, failed, or corrupted core dumps might impede crash
investigations. To improve reliability of that process and consequently
the programs themselves, one needs to trace the path from producing
a core dumpfile to analyzing it. That path starts from the core dump file
written to the disk by the kernel or to the standard input of a user
mode helper program to which the kernel streams the coredump contents.
There are cases where the kernel will interrupt writing the core out or
produce a truncated/not-well-formed core dump.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
---
 fs/binfmt_elf.c          | 48 +++++++++++++++++++++-------
 fs/coredump.c            | 69 +++++++++++++++++++++++++++++++---------
 include/linux/coredump.h |  4 +--
 kernel/signal.c          |  5 ++-
 4 files changed, 96 insertions(+), 30 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index a43897b03ce9..26f6ff00913d 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1994,8 +1994,10 @@ static int elf_core_dump(struct coredump_params *cprm)
 	 * Collect all the non-memory information about the process for the
 	 * notes.  This also sets up the file header.
 	 */
-	if (!fill_note_info(&elf, e_phnum, &info, cprm))
+	if (!fill_note_info(&elf, e_phnum, &info, cprm)) {
+		pr_err("Error collecting note info for the core dump; dumping core failed");
 		goto end_coredump;
+	}
 
 	has_dumped = 1;
 
@@ -2010,8 +2012,10 @@ static int elf_core_dump(struct coredump_params *cprm)
 		sz += elf_coredump_extra_notes_size();
 
 		phdr4note = kmalloc(sizeof(*phdr4note), GFP_KERNEL);
-		if (!phdr4note)
+		if (!phdr4note) {
+			pr_err("Error allocating program headers note entry; dumping core failed");
 			goto end_coredump;
+		}
 
 		fill_elf_note_phdr(phdr4note, sz, offset);
 		offset += sz;
@@ -2025,18 +2029,24 @@ static int elf_core_dump(struct coredump_params *cprm)
 
 	if (e_phnum == PN_XNUM) {
 		shdr4extnum = kmalloc(sizeof(*shdr4extnum), GFP_KERNEL);
-		if (!shdr4extnum)
+		if (!shdr4extnum) {
+			pr_err("Error allocating extra program headers; dumping core failed");
 			goto end_coredump;
+		}
 		fill_extnum_info(&elf, shdr4extnum, e_shoff, segs);
 	}
 
 	offset = dataoff;
 
-	if (!dump_emit(cprm, &elf, sizeof(elf)))
+	if (!dump_emit(cprm, &elf, sizeof(elf))) {
+		pr_err("Error emitting the ELF header; dumping core failed");
 		goto end_coredump;
+	}
 
-	if (!dump_emit(cprm, phdr4note, sizeof(*phdr4note)))
+	if (!dump_emit(cprm, phdr4note, sizeof(*phdr4note))) {
+		pr_err("Error emitting the program header for notes; dumping core failed");
 		goto end_coredump;
+	}
 
 	/* Write program headers for segments dump */
 	for (i = 0; i < cprm->vma_count; i++) {
@@ -2059,20 +2069,28 @@ static int elf_core_dump(struct coredump_params *cprm)
 			phdr.p_flags |= PF_X;
 		phdr.p_align = ELF_EXEC_PAGESIZE;
 
-		if (!dump_emit(cprm, &phdr, sizeof(phdr)))
+		if (!dump_emit(cprm, &phdr, sizeof(phdr))) {
+			pr_err("Error emitting program headers; dumping core failed");
 			goto end_coredump;
+		}
 	}
 
-	if (!elf_core_write_extra_phdrs(cprm, offset))
+	if (!elf_core_write_extra_phdrs(cprm, offset)) {
+		pr_err("Error writing out extra program headers; dumping core failed");
 		goto end_coredump;
+	}
 
 	/* write out the notes section */
-	if (!write_note_info(&info, cprm))
+	if (!write_note_info(&info, cprm)) {
+		pr_err("Error writing out notes; dumping core failed");
 		goto end_coredump;
+	}
 
 	/* For cell spufs */
-	if (elf_coredump_extra_notes_write(cprm))
+	if (elf_coredump_extra_notes_write(cprm)) {
+		pr_err("Error writing out extra notes; dumping core failed");
 		goto end_coredump;
+	}
 
 	/* Align to page */
 	dump_skip_to(cprm, dataoff);
@@ -2080,16 +2098,22 @@ static int elf_core_dump(struct coredump_params *cprm)
 	for (i = 0; i < cprm->vma_count; i++) {
 		struct core_vma_metadata *meta = cprm->vma_meta + i;
 
-		if (!dump_user_range(cprm, meta->start, meta->dump_size))
+		if (!dump_user_range(cprm, meta->start, meta->dump_size)) {
+			pr_err("Error writing out the process memory; dumping core failed");
 			goto end_coredump;
+		}
 	}
 
-	if (!elf_core_write_extra_data(cprm))
+	if (!elf_core_write_extra_data(cprm)) {
+		pr_err("Error writing out extra data; dumping core failed");
 		goto end_coredump;
+	}
 
 	if (e_phnum == PN_XNUM) {
-		if (!dump_emit(cprm, shdr4extnum, sizeof(*shdr4extnum)))
+		if (!dump_emit(cprm, shdr4extnum, sizeof(*shdr4extnum))) {
+			pr_err("Error writing out extra program headers; dumping core failed");
 			goto end_coredump;
+		}
 	}
 
 end_coredump:
diff --git a/fs/coredump.c b/fs/coredump.c
index a57a06b80f57..a7200c9024c6 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -519,7 +519,7 @@ static int umh_pipe_setup(struct subprocess_info *info, struct cred *new)
 	return err;
 }
 
-void do_coredump(const kernel_siginfo_t *siginfo)
+int do_coredump(const kernel_siginfo_t *siginfo)
 {
 	struct core_state core_state;
 	struct core_name cn;
@@ -527,7 +527,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 	struct linux_binfmt * binfmt;
 	const struct cred *old_cred;
 	struct cred *cred;
-	int retval = 0;
+	int retval;
 	int ispipe;
 	size_t *argv = NULL;
 	int argc = 0;
@@ -551,14 +551,20 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 	audit_core_dumps(siginfo->si_signo);
 
 	binfmt = mm->binfmt;
-	if (!binfmt || !binfmt->core_dump)
+	if (!binfmt || !binfmt->core_dump) {
+		retval = -ENOEXEC;
 		goto fail;
-	if (!__get_dumpable(cprm.mm_flags))
+	}
+	if (!__get_dumpable(cprm.mm_flags)) {
+		retval = -EACCES;
 		goto fail;
+	}
 
 	cred = prepare_creds();
-	if (!cred)
+	if (!cred) {
+		retval = -EPERM;
 		goto fail;
+	}
 	/*
 	 * We cannot trust fsuid as being the "true" uid of the process
 	 * nor do we know its entire history. We only know it was tainted
@@ -588,6 +594,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 		if (ispipe < 0) {
 			printk(KERN_WARNING "format_corename failed\n");
 			printk(KERN_WARNING "Aborting core\n");
+			retval = ispipe;
 			goto fail_unlock;
 		}
 
@@ -611,6 +618,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 				"Process %d(%s) has RLIMIT_CORE set to 1\n",
 				task_tgid_vnr(current), current->comm);
 			printk(KERN_WARNING "Aborting core\n");
+			retval = -EPERM;
 			goto fail_unlock;
 		}
 		cprm.limit = RLIM_INFINITY;
@@ -620,6 +628,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 			printk(KERN_WARNING "Pid %d(%s) over core_pipe_limit\n",
 			       task_tgid_vnr(current), current->comm);
 			printk(KERN_WARNING "Skipping core dump\n");
+			retval = -E2BIG;
 			goto fail_dropcount;
 		}
 
@@ -628,6 +637,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 		if (!helper_argv) {
 			printk(KERN_WARNING "%s failed to allocate memory\n",
 			       __func__);
+			retval = -ENOMEM;
 			goto fail_dropcount;
 		}
 		for (argi = 0; argi < argc; argi++)
@@ -654,14 +664,17 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 		int open_flags = O_CREAT | O_WRONLY | O_NOFOLLOW |
 				 O_LARGEFILE | O_EXCL;
 
-		if (cprm.limit < binfmt->min_coredump)
+		if (cprm.limit < binfmt->min_coredump) {
+			retval = -E2BIG;
 			goto fail_unlock;
+		}
 
 		if (need_suid_safe && cn.corename[0] != '/') {
 			printk(KERN_WARNING "Pid %d(%s) can only dump core "\
 				"to fully qualified path!\n",
 				task_tgid_vnr(current), current->comm);
 			printk(KERN_WARNING "Skipping core dump\n");
+			retval = -EPERM;
 			goto fail_unlock;
 		}
 
@@ -707,20 +720,28 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 		} else {
 			cprm.file = filp_open(cn.corename, open_flags, 0600);
 		}
-		if (IS_ERR(cprm.file))
+		if (IS_ERR(cprm.file)) {
+			retval = PTR_ERR(cprm.file);
 			goto fail_unlock;
+		}
 
 		inode = file_inode(cprm.file);
-		if (inode->i_nlink > 1)
+		if (inode->i_nlink > 1) {
+			retval = -EMLINK;
 			goto close_fail;
-		if (d_unhashed(cprm.file->f_path.dentry))
+		}
+		if (d_unhashed(cprm.file->f_path.dentry)) {
+			retval = -EEXIST;
 			goto close_fail;
+		}
 		/*
 		 * AK: actually i see no reason to not allow this for named
 		 * pipes etc, but keep the previous behaviour for now.
 		 */
-		if (!S_ISREG(inode->i_mode))
+		if (!S_ISREG(inode->i_mode)) {
+			retval = -EISDIR;
 			goto close_fail;
+		}
 		/*
 		 * Don't dump core if the filesystem changed owner or mode
 		 * of the file during file creation. This is an issue when
@@ -732,17 +753,22 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 				    current_fsuid())) {
 			pr_info_ratelimited("Core dump to %s aborted: cannot preserve file owner\n",
 					    cn.corename);
+			retval = -EPERM;
 			goto close_fail;
 		}
 		if ((inode->i_mode & 0677) != 0600) {
 			pr_info_ratelimited("Core dump to %s aborted: cannot preserve file permissions\n",
 					    cn.corename);
+			retval = -EPERM;
 			goto close_fail;
 		}
-		if (!(cprm.file->f_mode & FMODE_CAN_WRITE))
+		if (!(cprm.file->f_mode & FMODE_CAN_WRITE)) {
+			retval = -EACCES;
 			goto close_fail;
-		if (do_truncate(idmap, cprm.file->f_path.dentry,
-				0, 0, cprm.file))
+		}
+		retval = do_truncate(idmap, cprm.file->f_path.dentry,
+				0, 0, cprm.file);
+		if (retval)
 			goto close_fail;
 	}
 
@@ -758,10 +784,14 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 		 */
 		if (!cprm.file) {
 			pr_info("Core dump to |%s disabled\n", cn.corename);
+			retval = -EPERM;
 			goto close_fail;
 		}
-		if (!dump_vma_snapshot(&cprm))
+		if (!dump_vma_snapshot(&cprm)) {
+			pr_err("Can't get VMA snapshot for core dump |%s\n", cn.corename);
+			retval = -EACCES;
 			goto close_fail;
+		}
 
 		file_start_write(cprm.file);
 		core_dumped = binfmt->core_dump(&cprm);
@@ -777,9 +807,18 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 		}
 		file_end_write(cprm.file);
 		free_vma_snapshot(&cprm);
+	} else {
+		pr_err("Core dump to |%s has been interrupted\n", cn.corename);
+		retval = -EAGAIN;
+		goto fail;
 	}
+	pr_info("Core dump to |%s: vma_count %d, vma_data_size %lu, written %lld bytes, pos %lld\n",
+		cn.corename, cprm.vma_count, cprm.vma_data_size, cprm.written, cprm.pos);
 	if (ispipe && core_pipe_limit)
 		wait_for_dump_helpers(cprm.file);
+
+	retval = 0;
+
 close_fail:
 	if (cprm.file)
 		filp_close(cprm.file, NULL);
@@ -794,7 +833,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 fail_creds:
 	put_cred(cred);
 fail:
-	return;
+	return retval;
 }
 
 /*
diff --git a/include/linux/coredump.h b/include/linux/coredump.h
index 0904ba010341..8b29be758a87 100644
--- a/include/linux/coredump.h
+++ b/include/linux/coredump.h
@@ -42,9 +42,9 @@ extern int dump_emit(struct coredump_params *cprm, const void *addr, int nr);
 extern int dump_align(struct coredump_params *cprm, int align);
 int dump_user_range(struct coredump_params *cprm, unsigned long start,
 		    unsigned long len);
-extern void do_coredump(const kernel_siginfo_t *siginfo);
+extern int do_coredump(const kernel_siginfo_t *siginfo);
 #else
-static inline void do_coredump(const kernel_siginfo_t *siginfo) {}
+static inline int do_coredump(const kernel_siginfo_t *siginfo) {}
 #endif
 
 #if defined(CONFIG_COREDUMP) && defined(CONFIG_SYSCTL)
diff --git a/kernel/signal.c b/kernel/signal.c
index 1f9dd41c04be..f2ecf29a994d 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2675,6 +2675,7 @@ bool get_signal(struct ksignal *ksig)
 	struct sighand_struct *sighand = current->sighand;
 	struct signal_struct *signal = current->signal;
 	int signr;
+	int ret;
 
 	clear_notify_signal();
 	if (unlikely(task_work_pending(current)))
@@ -2891,7 +2892,9 @@ bool get_signal(struct ksignal *ksig)
 			 * first and our do_group_exit call below will use
 			 * that value and ignore the one we pass it.
 			 */
-			do_coredump(&ksig->info);
+			ret = do_coredump(&ksig->info);
+			if (ret)
+				pr_err("coredump has not been created, error %d\n", ret);
 		}
 
 		/*
-- 
2.45.2


