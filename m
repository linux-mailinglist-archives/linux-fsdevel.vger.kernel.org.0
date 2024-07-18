Return-Path: <linux-fsdevel+bounces-23953-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7636793518E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 20:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBE3DB22131
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 18:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BD6145A1F;
	Thu, 18 Jul 2024 18:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="GboBFozA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6B11442FF;
	Thu, 18 Jul 2024 18:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721327282; cv=none; b=rnUMbfwemzTikmS3wftwYwp6qJRy5ojW2bm/mhE9gqQJgeDgeTnnTF1exbhPIcfgAXELds60y+uNvLt9/mYkY0aDxBT3fDUjtopMMT8j/SGqUmVAY3wXPOm0WugKpTFIj+lQimWycglTh3jFn5stg2KuiYAs0iKtXQ0urY1GSlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721327282; c=relaxed/simple;
	bh=aGGjOMrA5NOy6MpmzY89VWRMX06aFAG5yDPnsKbTUzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kx032Ie/v1Gs5p39U0Cr/MHNZz9p5n+95s7yzuEbmULplFdkj++5PSdh67mXR8lpe1pUcfDClFcnuHF+yvJDXoCmRei4+ZzcOrnNOWpCjFohkSoBjfrnWtKJt7fVUf4EY0IuIYH0KSQrb5JOqdDiU5Ma3DzzP8p7SbJiSnGZweY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=GboBFozA; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from xps-8930.corp.microsoft.com (unknown [131.107.160.48])
	by linux.microsoft.com (Postfix) with ESMTPSA id 140B520B7123;
	Thu, 18 Jul 2024 11:27:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 140B520B7123
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1721327274;
	bh=1e3l8AB/5X9bCXqJTK5ycCS5UCYJGifmUe4sbQWGhvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GboBFozAYYNkWlkFoo0d95FXYjmn9e/+UpjDfGiZUT4lD5VfIL/dxOXsx8oXJkvO3
	 x/McV4pwA0/1uRhR5SZVGSI3hCC/U63msyCONOqWBLnWeVoCyUUDky2Nmqw8/nKaWO
	 lw0PgFlbnVlUQSTMcs20tsmyobA48kqUCt/t6mJ0=
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
	benhill@microsoft.com,
	ssengar@microsoft.com,
	sunilmut@microsoft.com,
	vdso@hexbites.dev
Subject: [PATCH v3 2/2] binfmt_elf, coredump: Log the reason of the failed core dumps
Date: Thu, 18 Jul 2024 11:27:25 -0700
Message-ID: <20240718182743.1959160-3-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718182743.1959160-1-romank@linux.microsoft.com>
References: <20240718182743.1959160-1-romank@linux.microsoft.com>
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
produce a truncated/not-well-formed core dump without leaving a note.

Add logging for the core dump collection failure paths to be able to reason
what has gone wrong when the core dump is malformed or missing.
Report the size of the data written to aid in diagnosing the user mode
helper.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
---
 fs/binfmt_elf.c          |  48 +++++++++++++-----
 fs/coredump.c            | 107 ++++++++++++++++++++++++++++++++-------
 include/linux/coredump.h |   8 ++-
 kernel/signal.c          |  21 +++++++-
 4 files changed, 150 insertions(+), 34 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index a43897b03ce9..0fa5a8af247e 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1994,8 +1994,10 @@ static int elf_core_dump(struct coredump_params *cprm)
 	 * Collect all the non-memory information about the process for the
 	 * notes.  This also sets up the file header.
 	 */
-	if (!fill_note_info(&elf, e_phnum, &info, cprm))
+	if (!fill_note_info(&elf, e_phnum, &info, cprm)) {
+		coredump_report_failure("Error collecting note info");
 		goto end_coredump;
+	}
 
 	has_dumped = 1;
 
@@ -2010,8 +2012,10 @@ static int elf_core_dump(struct coredump_params *cprm)
 		sz += elf_coredump_extra_notes_size();
 
 		phdr4note = kmalloc(sizeof(*phdr4note), GFP_KERNEL);
-		if (!phdr4note)
+		if (!phdr4note) {
+			coredump_report_failure("Error allocating program headers note entry");
 			goto end_coredump;
+		}
 
 		fill_elf_note_phdr(phdr4note, sz, offset);
 		offset += sz;
@@ -2025,18 +2029,24 @@ static int elf_core_dump(struct coredump_params *cprm)
 
 	if (e_phnum == PN_XNUM) {
 		shdr4extnum = kmalloc(sizeof(*shdr4extnum), GFP_KERNEL);
-		if (!shdr4extnum)
+		if (!shdr4extnum) {
+			coredump_report_failure("Error allocating extra program headers");
 			goto end_coredump;
+		}
 		fill_extnum_info(&elf, shdr4extnum, e_shoff, segs);
 	}
 
 	offset = dataoff;
 
-	if (!dump_emit(cprm, &elf, sizeof(elf)))
+	if (!dump_emit(cprm, &elf, sizeof(elf))) {
+		coredump_report_failure("Error emitting the ELF headers");
 		goto end_coredump;
+	}
 
-	if (!dump_emit(cprm, phdr4note, sizeof(*phdr4note)))
+	if (!dump_emit(cprm, phdr4note, sizeof(*phdr4note))) {
+		coredump_report_failure("Error emitting the program header for notes");
 		goto end_coredump;
+	}
 
 	/* Write program headers for segments dump */
 	for (i = 0; i < cprm->vma_count; i++) {
@@ -2059,20 +2069,28 @@ static int elf_core_dump(struct coredump_params *cprm)
 			phdr.p_flags |= PF_X;
 		phdr.p_align = ELF_EXEC_PAGESIZE;
 
-		if (!dump_emit(cprm, &phdr, sizeof(phdr)))
+		if (!dump_emit(cprm, &phdr, sizeof(phdr))) {
+			coredump_report_failure("Error emitting program headers");
 			goto end_coredump;
+		}
 	}
 
-	if (!elf_core_write_extra_phdrs(cprm, offset))
+	if (!elf_core_write_extra_phdrs(cprm, offset)) {
+		coredump_report_failure("Error writing out extra program headers");
 		goto end_coredump;
+	}
 
 	/* write out the notes section */
-	if (!write_note_info(&info, cprm))
+	if (!write_note_info(&info, cprm)) {
+		coredump_report_failure("Error writing out notes");
 		goto end_coredump;
+	}
 
 	/* For cell spufs */
-	if (elf_coredump_extra_notes_write(cprm))
+	if (elf_coredump_extra_notes_write(cprm)) {
+		coredump_report_failure("Error writing out extra notes");
 		goto end_coredump;
+	}
 
 	/* Align to page */
 	dump_skip_to(cprm, dataoff);
@@ -2080,16 +2098,22 @@ static int elf_core_dump(struct coredump_params *cprm)
 	for (i = 0; i < cprm->vma_count; i++) {
 		struct core_vma_metadata *meta = cprm->vma_meta + i;
 
-		if (!dump_user_range(cprm, meta->start, meta->dump_size))
+		if (!dump_user_range(cprm, meta->start, meta->dump_size)) {
+			coredump_report_failure("Error writing out the process memory");
 			goto end_coredump;
+		}
 	}
 
-	if (!elf_core_write_extra_data(cprm))
+	if (!elf_core_write_extra_data(cprm)) {
+		coredump_report_failure("Error writing out extra data");
 		goto end_coredump;
+	}
 
 	if (e_phnum == PN_XNUM) {
-		if (!dump_emit(cprm, shdr4extnum, sizeof(*shdr4extnum)))
+		if (!dump_emit(cprm, shdr4extnum, sizeof(*shdr4extnum))) {
+			coredump_report_failure("Error emitting extra program headers");
 			goto end_coredump;
+		}
 	}
 
 end_coredump:
diff --git a/fs/coredump.c b/fs/coredump.c
index 19d3343b93c6..8c8f6748efac 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -464,7 +464,17 @@ static bool dump_interrupted(void)
 	 * but then we need to teach dump_write() to restart and clear
 	 * TIF_SIGPENDING.
 	 */
-	return fatal_signal_pending(current) || freezing(current);
+	if (fatal_signal_pending(current)) {
+		coredump_report_failure("interrupted: fatal signal pending");
+		return true;
+	}
+
+	if (freezing(current)) {
+		coredump_report_failure("interrupted: freezing");
+		return true;
+	}
+
+	return false;
 }
 
 static void wait_for_dump_helpers(struct file *file)
@@ -519,7 +529,7 @@ static int umh_pipe_setup(struct subprocess_info *info, struct cred *new)
 	return err;
 }
 
-void do_coredump(const kernel_siginfo_t *siginfo)
+int do_coredump(const kernel_siginfo_t *siginfo)
 {
 	struct core_state core_state;
 	struct core_name cn;
@@ -527,7 +537,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 	struct linux_binfmt * binfmt;
 	const struct cred *old_cred;
 	struct cred *cred;
-	int retval = 0;
+	int retval;
 	int ispipe;
 	size_t *argv = NULL;
 	int argc = 0;
@@ -551,14 +561,20 @@ void do_coredump(const kernel_siginfo_t *siginfo)
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
@@ -587,6 +603,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 
 		if (ispipe < 0) {
 			coredump_report_failure("format_corename failed, aborting core");
+			retval = ispipe;
 			goto fail_unlock;
 		}
 
@@ -607,6 +624,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 			 * core_pattern process dies.
 			 */
 			coredump_report_failure("RLIMIT_CORE is set to 1, aborting core");
+			retval = -EPERM;
 			goto fail_unlock;
 		}
 		cprm.limit = RLIM_INFINITY;
@@ -614,6 +632,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 		dump_count = atomic_inc_return(&core_dump_count);
 		if (core_pipe_limit && (core_pipe_limit < dump_count)) {
 			coredump_report_failure("over core_pipe_limit, skipping core dump");
+			retval = -E2BIG;
 			goto fail_dropcount;
 		}
 
@@ -621,6 +640,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 					    GFP_KERNEL);
 		if (!helper_argv) {
 			coredump_report_failure("%s failed to allocate memory", __func__);
+			retval = -ENOMEM;
 			goto fail_dropcount;
 		}
 		for (argi = 0; argi < argc; argi++)
@@ -646,12 +666,16 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 		int open_flags = O_CREAT | O_WRONLY | O_NOFOLLOW |
 				 O_LARGEFILE | O_EXCL;
 
-		if (cprm.limit < binfmt->min_coredump)
+		if (cprm.limit < binfmt->min_coredump) {
+			coredump_report_failure("over coredump resource limit, skipping core dump");
+			retval = -E2BIG;
 			goto fail_unlock;
+		}
 
 		if (need_suid_safe && cn.corename[0] != '/') {
 			coredump_report_failure(
 				"this process can only dump core to a fully qualified path, skipping core dump");
+			retval = -EPERM;
 			goto fail_unlock;
 		}
 
@@ -697,20 +721,28 @@ void do_coredump(const kernel_siginfo_t *siginfo)
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
@@ -722,17 +754,22 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 				    current_fsuid())) {
 			coredump_report_failure("Core dump to %s aborted: "
 				"cannot preserve file owner", cn.corename);
+			retval = -EPERM;
 			goto close_fail;
 		}
 		if ((inode->i_mode & 0677) != 0600) {
 			coredump_report_failure("Core dump to %s aborted: "
 				"cannot preserve file permissions", cn.corename);
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
 
@@ -748,10 +785,15 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 		 */
 		if (!cprm.file) {
 			coredump_report_failure("Core dump to |%s disabled", cn.corename);
+			retval = -EPERM;
 			goto close_fail;
 		}
-		if (!dump_vma_snapshot(&cprm))
+		if (!dump_vma_snapshot(&cprm)) {
+			coredump_report_failure("Can't get VMA snapshot for core dump |%s",
+				cn.corename);
+			retval = -EACCES;
 			goto close_fail;
+		}
 
 		file_start_write(cprm.file);
 		core_dumped = binfmt->core_dump(&cprm);
@@ -767,9 +809,21 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 		}
 		file_end_write(cprm.file);
 		free_vma_snapshot(&cprm);
+	} else {
+		coredump_report_failure("Core dump to %s%s has been interrupted",
+			ispipe ? "|" : "", cn.corename);
+		retval = -EAGAIN;
+		goto fail;
 	}
+	coredump_report(
+		"written to %s%s: VMAs: %d, size %zu; core: %lld bytes, pos %lld",
+		ispipe ? "|" : "", cn.corename,
+		cprm.vma_count, cprm.vma_data_size, cprm.written, cprm.pos);
 	if (ispipe && core_pipe_limit)
 		wait_for_dump_helpers(cprm.file);
+
+	retval = 0;
+
 close_fail:
 	if (cprm.file)
 		filp_close(cprm.file, NULL);
@@ -784,7 +838,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 fail_creds:
 	put_cred(cred);
 fail:
-	return;
+	return retval;
 }
 
 /*
@@ -804,8 +858,16 @@ static int __dump_emit(struct coredump_params *cprm, const void *addr, int nr)
 	if (dump_interrupted())
 		return 0;
 	n = __kernel_write(file, addr, nr, &pos);
-	if (n != nr)
+	if (n != nr) {
+		if (n < 0)
+			coredump_report_failure("failed when writing out, error %zd", n);
+		else
+			coredump_report_failure(
+				"partially written out, only %zd(of %d) bytes written",
+				n, nr);
+
 		return 0;
+	}
 	file->f_pos = pos;
 	cprm->written += n;
 	cprm->pos += n;
@@ -818,9 +880,16 @@ static int __dump_skip(struct coredump_params *cprm, size_t nr)
 	static char zeroes[PAGE_SIZE];
 	struct file *file = cprm->file;
 	if (file->f_mode & FMODE_LSEEK) {
-		if (dump_interrupted() ||
-		    vfs_llseek(file, nr, SEEK_CUR) < 0)
+		int ret;
+
+		if (dump_interrupted())
 			return 0;
+
+		ret = vfs_llseek(file, nr, SEEK_CUR);
+		if (ret < 0) {
+			coredump_report_failure("failed when seeking, error %d", ret);
+			return 0;
+		}
 		cprm->pos += nr;
 		return 1;
 	} else {
diff --git a/include/linux/coredump.h b/include/linux/coredump.h
index 45e598fe3476..edeb8532ce0f 100644
--- a/include/linux/coredump.h
+++ b/include/linux/coredump.h
@@ -42,7 +42,7 @@ extern int dump_emit(struct coredump_params *cprm, const void *addr, int nr);
 extern int dump_align(struct coredump_params *cprm, int align);
 int dump_user_range(struct coredump_params *cprm, unsigned long start,
 		    unsigned long len);
-extern void do_coredump(const kernel_siginfo_t *siginfo);
+extern int do_coredump(const kernel_siginfo_t *siginfo);
 
 /*
  * Logging for the coredump code, ratelimited.
@@ -62,7 +62,11 @@ extern void do_coredump(const kernel_siginfo_t *siginfo);
 #define coredump_report_failure(fmt, ...) __COREDUMP_PRINTK(KERN_WARNING, fmt, ##__VA_ARGS__)
 
 #else
-static inline void do_coredump(const kernel_siginfo_t *siginfo) {}
+static inline int do_coredump(const kernel_siginfo_t *siginfo)
+{
+	/* Coredump support is not available, can't fail. */
+	return 0;
+}
 
 #define coredump_report(...)
 #define coredump_report_failure(...)
diff --git a/kernel/signal.c b/kernel/signal.c
index 1f9dd41c04be..4d1ed397b175 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2880,6 +2880,8 @@ bool get_signal(struct ksignal *ksig)
 		current->flags |= PF_SIGNALED;
 
 		if (sig_kernel_coredump(signr)) {
+			int ret;
+
 			if (print_fatal_signals)
 				print_fatal_signal(signr);
 			proc_coredump_connector(current);
@@ -2891,7 +2893,24 @@ bool get_signal(struct ksignal *ksig)
 			 * first and our do_group_exit call below will use
 			 * that value and ignore the one we pass it.
 			 */
-			do_coredump(&ksig->info);
+			ret = do_coredump(&ksig->info);
+			if (ret)
+				coredump_report_failure("coredump has not been created, error %d",
+					ret);
+			else if (!IS_ENABLED(CONFIG_COREDUMP)) {
+				/*
+				 * Coredumps are not available, can't fail collecting
+				 * the coredump.
+				 *
+				 * Leave a note though that the coredump is going to be
+				 * not created. This is not an error or a warning as disabling
+				 * support in the kernel for coredumps isn't commonplace, and
+				 * the user must've built the kernel with the custom config so
+				 * let them know all works as desired.
+				 */
+				coredump_report("no coredump collected as "
+					"that is disabled in the kernel configuration");
+			}
 		}
 
 		/*
-- 
2.45.2


