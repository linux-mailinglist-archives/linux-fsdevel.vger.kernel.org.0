Return-Path: <linux-fsdevel+bounces-23626-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8ED9301C0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2024 23:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A62C1F23930
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2024 21:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5794161FF2;
	Fri, 12 Jul 2024 21:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="X1XyMhnd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0896F482E9;
	Fri, 12 Jul 2024 21:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720821157; cv=none; b=lPW6DtEw/0mOMe3QP6miODXIRdOdG2fxG0UO3FXaKUzoOzHyPJw13VmTfwBUVNlk5ectbIBDMZbXQNd7bWcOQRqx3PnD2FUePwvXINktNklCjL8T7O8PfU2WXpweSSEuTszA9TMDV5ert4sWH+sWAcRphOTGxsHaLKQX1rF9oZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720821157; c=relaxed/simple;
	bh=Bb1goPqZtkE0BL/XCKTkJwE2pbkX9MOKCFBeGpXPQuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ibI8+ZpmEcKmR2rpTT36Iuq5wPjJV3vRnWWSyW5tk6O8kJSrSgTnVm5XSuR4zcScsEK09PZkZ6oEP1iN2ZaBf96JTblAIxhgWxlYjLlxCYnhBT8TxdI2j6lboQxQUYeAb8s68AwigpXe91YPzNLHaCfP63OUwh/gX8FRE5MwfkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=X1XyMhnd; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from xps-8930.corp.microsoft.com (unknown [131.107.160.48])
	by linux.microsoft.com (Postfix) with ESMTPSA id 68BF120B7177;
	Fri, 12 Jul 2024 14:52:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 68BF120B7177
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1720821155;
	bh=vlM/9AYMe+bZ/CjTBx+0VChGrsIZg2Kgvum/VpWD09Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X1XyMhndS0kgyqLVT93yc3wVq3pLg1eeY2+xeRSHgmnlMOabTX7VCwka1P7RvTgJz
	 5cCNJVTHET7y1PJ6EQI7Fj8r1t6Q6v2fhfOvlE73tysLshqHoCMvpf0Oxz0NuXP6Zf
	 FIxnJcVbFYsfb2mShJpT5ASwfscQ3Xi8wYiQJ0Zc=
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
Subject: [PATCH v2 1/1] binfmt_elf, coredump: Log the reason of the failed core dumps
Date: Fri, 12 Jul 2024 14:50:56 -0700
Message-ID: <20240712215223.605363-2-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240712215223.605363-1-romank@linux.microsoft.com>
References: <20240712215223.605363-1-romank@linux.microsoft.com>
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

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
---
 fs/binfmt_elf.c          |  60 ++++++++++++++++-----
 fs/coredump.c            | 109 ++++++++++++++++++++++++++++++++-------
 include/linux/coredump.h |   8 ++-
 kernel/signal.c          |  22 +++++++-
 4 files changed, 165 insertions(+), 34 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index a43897b03ce9..cfe84b9436af 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1994,8 +1994,11 @@ static int elf_core_dump(struct coredump_params *cprm)
 	 * Collect all the non-memory information about the process for the
 	 * notes.  This also sets up the file header.
 	 */
-	if (!fill_note_info(&elf, e_phnum, &info, cprm))
+	if (!fill_note_info(&elf, e_phnum, &info, cprm)) {
+		pr_err_ratelimited("Error collecting note info, core dump of %s(PID %d) failed\n",
+			current->comm, current->pid);
 		goto end_coredump;
+	}
 
 	has_dumped = 1;
 
@@ -2010,8 +2013,11 @@ static int elf_core_dump(struct coredump_params *cprm)
 		sz += elf_coredump_extra_notes_size();
 
 		phdr4note = kmalloc(sizeof(*phdr4note), GFP_KERNEL);
-		if (!phdr4note)
+		if (!phdr4note) {
+			pr_err_ratelimited("Error allocating program headers note entry, core dump of %s(PID %d) failed\n",
+				current->comm, current->pid);
 			goto end_coredump;
+		}
 
 		fill_elf_note_phdr(phdr4note, sz, offset);
 		offset += sz;
@@ -2025,18 +2031,27 @@ static int elf_core_dump(struct coredump_params *cprm)
 
 	if (e_phnum == PN_XNUM) {
 		shdr4extnum = kmalloc(sizeof(*shdr4extnum), GFP_KERNEL);
-		if (!shdr4extnum)
+		if (!shdr4extnum) {
+			pr_err_ratelimited("Error allocating extra program headers, core dump of %s(PID %d) failed\n",
+				current->comm, current->pid);
 			goto end_coredump;
+		}
 		fill_extnum_info(&elf, shdr4extnum, e_shoff, segs);
 	}
 
 	offset = dataoff;
 
-	if (!dump_emit(cprm, &elf, sizeof(elf)))
+	if (!dump_emit(cprm, &elf, sizeof(elf))) {
+		pr_err_ratelimited("Error emitting the ELF header, core dump of %s(PID %d) failed\n",
+			current->comm, current->pid);
 		goto end_coredump;
+	}
 
-	if (!dump_emit(cprm, phdr4note, sizeof(*phdr4note)))
+	if (!dump_emit(cprm, phdr4note, sizeof(*phdr4note))) {
+		pr_err_ratelimited("Error emitting the program header for notes, core dump of %s(PID %d) failed\n",
+			current->comm, current->pid);
 		goto end_coredump;
+	}
 
 	/* Write program headers for segments dump */
 	for (i = 0; i < cprm->vma_count; i++) {
@@ -2059,20 +2074,32 @@ static int elf_core_dump(struct coredump_params *cprm)
 			phdr.p_flags |= PF_X;
 		phdr.p_align = ELF_EXEC_PAGESIZE;
 
-		if (!dump_emit(cprm, &phdr, sizeof(phdr)))
+		if (!dump_emit(cprm, &phdr, sizeof(phdr))) {
+			pr_err_ratelimited("Error emitting program headers, core dump of %s(PID %d) failed\n",
+				current->comm, current->pid);
 			goto end_coredump;
+		}
 	}
 
-	if (!elf_core_write_extra_phdrs(cprm, offset))
+	if (!elf_core_write_extra_phdrs(cprm, offset)) {
+		pr_err_ratelimited("Error writing out extra program headers, core dump of %s(PID %d) failed\n",
+			current->comm, current->pid);
 		goto end_coredump;
+	}
 
 	/* write out the notes section */
-	if (!write_note_info(&info, cprm))
+	if (!write_note_info(&info, cprm)) {
+		pr_err_ratelimited("Error writing out notes, core dump of %s(PID %d) failed\n",
+			current->comm, current->pid);
 		goto end_coredump;
+	}
 
 	/* For cell spufs */
-	if (elf_coredump_extra_notes_write(cprm))
+	if (elf_coredump_extra_notes_write(cprm)) {
+		pr_err_ratelimited("Error writing out extra notes, core dump of %s(PID %d) failed\n",
+			current->comm, current->pid);
 		goto end_coredump;
+	}
 
 	/* Align to page */
 	dump_skip_to(cprm, dataoff);
@@ -2080,16 +2107,25 @@ static int elf_core_dump(struct coredump_params *cprm)
 	for (i = 0; i < cprm->vma_count; i++) {
 		struct core_vma_metadata *meta = cprm->vma_meta + i;
 
-		if (!dump_user_range(cprm, meta->start, meta->dump_size))
+		if (!dump_user_range(cprm, meta->start, meta->dump_size)) {
+			pr_err_ratelimited("Error writing out the process memory, core dump of %s(PID %d) failed\n",
+				current->comm, current->pid);
 			goto end_coredump;
+		}
 	}
 
-	if (!elf_core_write_extra_data(cprm))
+	if (!elf_core_write_extra_data(cprm)) {
+		pr_err_ratelimited("Error writing out extra data, core dump of %s(PID %d) failed\n",
+			current->comm, current->pid);
 		goto end_coredump;
+	}
 
 	if (e_phnum == PN_XNUM) {
-		if (!dump_emit(cprm, shdr4extnum, sizeof(*shdr4extnum)))
+		if (!dump_emit(cprm, shdr4extnum, sizeof(*shdr4extnum))) {
+			pr_err_ratelimited("Error emitting extra program headers, core dump of %s(PID %d) failed\n",
+				current->comm, current->pid);
 			goto end_coredump;
+		}
 	}
 
 end_coredump:
diff --git a/fs/coredump.c b/fs/coredump.c
index a57a06b80f57..c6d6ee6040de 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -464,7 +464,19 @@ static bool dump_interrupted(void)
 	 * but then we need to teach dump_write() to restart and clear
 	 * TIF_SIGPENDING.
 	 */
-	return fatal_signal_pending(current) || freezing(current);
+	if (fatal_signal_pending(current)) {
+		pr_err_ratelimited("Core dump of %s(PID %d) interrupted: fatal signal pending\n",
+			current->comm, current->pid);
+		return true;
+	}
+
+	if (freezing(current)) {
+		pr_err_ratelimited("Core dump of %s(PID %d) interrupted: freezing\n",
+			current->comm, current->pid);
+		return true;
+	}
+
+	return false;
 }
 
 static void wait_for_dump_helpers(struct file *file)
@@ -519,7 +531,7 @@ static int umh_pipe_setup(struct subprocess_info *info, struct cred *new)
 	return err;
 }
 
-void do_coredump(const kernel_siginfo_t *siginfo)
+int do_coredump(const kernel_siginfo_t *siginfo)
 {
 	struct core_state core_state;
 	struct core_name cn;
@@ -527,7 +539,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 	struct linux_binfmt * binfmt;
 	const struct cred *old_cred;
 	struct cred *cred;
-	int retval = 0;
+	int retval;
 	int ispipe;
 	size_t *argv = NULL;
 	int argc = 0;
@@ -551,14 +563,20 @@ void do_coredump(const kernel_siginfo_t *siginfo)
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
@@ -588,6 +606,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 		if (ispipe < 0) {
 			printk(KERN_WARNING "format_corename failed\n");
 			printk(KERN_WARNING "Aborting core\n");
+			retval = ispipe;
 			goto fail_unlock;
 		}
 
@@ -611,6 +630,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 				"Process %d(%s) has RLIMIT_CORE set to 1\n",
 				task_tgid_vnr(current), current->comm);
 			printk(KERN_WARNING "Aborting core\n");
+			retval = -EPERM;
 			goto fail_unlock;
 		}
 		cprm.limit = RLIM_INFINITY;
@@ -620,6 +640,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 			printk(KERN_WARNING "Pid %d(%s) over core_pipe_limit\n",
 			       task_tgid_vnr(current), current->comm);
 			printk(KERN_WARNING "Skipping core dump\n");
+			retval = -E2BIG;
 			goto fail_dropcount;
 		}
 
@@ -628,6 +649,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 		if (!helper_argv) {
 			printk(KERN_WARNING "%s failed to allocate memory\n",
 			       __func__);
+			retval = -ENOMEM;
 			goto fail_dropcount;
 		}
 		for (argi = 0; argi < argc; argi++)
@@ -654,14 +676,17 @@ void do_coredump(const kernel_siginfo_t *siginfo)
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
 
@@ -707,20 +732,28 @@ void do_coredump(const kernel_siginfo_t *siginfo)
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
@@ -732,17 +765,22 @@ void do_coredump(const kernel_siginfo_t *siginfo)
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
 
@@ -758,10 +796,15 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 		 */
 		if (!cprm.file) {
 			pr_info("Core dump to |%s disabled\n", cn.corename);
+			retval = -EPERM;
 			goto close_fail;
 		}
-		if (!dump_vma_snapshot(&cprm))
+		if (!dump_vma_snapshot(&cprm)) {
+			pr_err_ratelimited("Can't get VMA snapshot for core dump |%s, %s(PID %d)\n",
+				cn.corename, current->comm, current->pid);
+			retval = -EACCES;
 			goto close_fail;
+		}
 
 		file_start_write(cprm.file);
 		core_dumped = binfmt->core_dump(&cprm);
@@ -777,9 +820,21 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 		}
 		file_end_write(cprm.file);
 		free_vma_snapshot(&cprm);
+	} else {
+		pr_err_ratelimited("Core dump to %s%s has been interrupted, %s(PID %d)\n",
+			ispipe ? "|" : "", cn.corename, current->comm, current->pid);
+		retval = -EAGAIN;
+		goto fail;
 	}
+	pr_info_ratelimited(
+		"Core dump of %s(PID %d) to %s%s: VMAs: %d, size %zu; core: %lld bytes, pos %lld\n",
+		current->comm, current->pid, ispipe ? "|" : "", cn.corename,
+		cprm.vma_count, cprm.vma_data_size, cprm.written, cprm.pos);
 	if (ispipe && core_pipe_limit)
 		wait_for_dump_helpers(cprm.file);
+
+	retval = 0;
+
 close_fail:
 	if (cprm.file)
 		filp_close(cprm.file, NULL);
@@ -794,7 +849,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 fail_creds:
 	put_cred(cred);
 fail:
-	return;
+	return retval;
 }
 
 /*
@@ -814,8 +869,16 @@ static int __dump_emit(struct coredump_params *cprm, const void *addr, int nr)
 	if (dump_interrupted())
 		return 0;
 	n = __kernel_write(file, addr, nr, &pos);
-	if (n != nr)
+	if (n != nr) {
+		if (n < 0)
+			pr_err_ratelimited("Core dump of %s(PID %d) failed when writing out, error %ld\n",
+				current->comm, current->pid, n);
+		else
+			pr_err_ratelimited("Core dump of %s(PID %d) partially written out, only %ld(of %d) bytes written\n",
+				current->comm, current->pid, n, nr);
+
 		return 0;
+	}
 	file->f_pos = pos;
 	cprm->written += n;
 	cprm->pos += n;
@@ -828,9 +891,17 @@ static int __dump_skip(struct coredump_params *cprm, size_t nr)
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
+			pr_err_ratelimited("Core dump of %s(PID %d) failed when seeking, error %d\n",
+				current->comm, current->pid, ret);
+			return 0;
+		}
 		cprm->pos += nr;
 		return 1;
 	} else {
diff --git a/include/linux/coredump.h b/include/linux/coredump.h
index 0904ba010341..e97c027ce2c9 100644
--- a/include/linux/coredump.h
+++ b/include/linux/coredump.h
@@ -42,9 +42,13 @@ extern int dump_emit(struct coredump_params *cprm, const void *addr, int nr);
 extern int dump_align(struct coredump_params *cprm, int align);
 int dump_user_range(struct coredump_params *cprm, unsigned long start,
 		    unsigned long len);
-extern void do_coredump(const kernel_siginfo_t *siginfo);
+extern int do_coredump(const kernel_siginfo_t *siginfo);
 #else
-static inline void do_coredump(const kernel_siginfo_t *siginfo) {}
+static inline int do_coredump(const kernel_siginfo_t *siginfo)
+{
+	/* Coredump support is not available, can't fail. */
+	return 0;
+}
 #endif
 
 #if defined(CONFIG_COREDUMP) && defined(CONFIG_SYSCTL)
diff --git a/kernel/signal.c b/kernel/signal.c
index 1f9dd41c04be..3af77048c305 100644
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
@@ -2891,7 +2893,25 @@ bool get_signal(struct ksignal *ksig)
 			 * first and our do_group_exit call below will use
 			 * that value and ignore the one we pass it.
 			 */
-			do_coredump(&ksig->info);
+			ret = do_coredump(&ksig->info);
+			if (ret)
+				pr_err("coredump has not been created for %s(PID %d), error %d\n",
+					current->comm, current->pid, ret);
+			else if (!IS_ENABLED(CONFIG_COREDUMP)) {
+				/*
+				 * Coredumps are not available, can't fail collecting
+				 * the coredump.
+				 *
+				 * Leave a note though that the coredump is going to be
+				 * not created. This is not an error or a warning as disabling
+				 * support for coredumps isn't commonplace, and the user
+				 * must've built the kernel with the custom config so they know
+				 * that is the case. Let them know all works as prescribed.
+				 */
+				pr_info_ratelimited("No coredump collected for %s(PID %d); "
+					"no coredump support available in the kernel configuration\n",
+					current->comm, current->pid);
+			}
 		}
 
 		/*
-- 
2.45.2


