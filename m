Return-Path: <linux-fsdevel+bounces-46438-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06469A896A4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 10:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 624FE3B973B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 08:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD1728DEE1;
	Tue, 15 Apr 2025 08:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U2KXtqb3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C9128BAB0;
	Tue, 15 Apr 2025 08:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744705683; cv=none; b=PT3YHjzFAeYRBm+unsbSs+a5JM9IlURbzM9YPanGQ+Pic6xPhjLlFW6s6LK9625QEoPOxNexffN4ntEDF10fMFLE7wsg49Uw2PEUcQcB+phQG24VZcyop8kNy2VaqI6iFIfAQsZ3v9gUGth2znQ8HarnqjGWC36Q0menguSbtCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744705683; c=relaxed/simple;
	bh=bJ7ZPUThSUnefT1KsfBYGvnQ6e2CeijPhdt/RibAHwM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S3bORvji5xmDSqulPau67rvQyR0E3XS1XdRSkF8TajOwvF/xNtnclkXyuAFHJCZ5LF9TNuGbGeWHg6WlRneTjFOJS2TlJ5a8Wu7ladLSoOz3/t9ljvfvdkrQC+Tlwl3Nvlgn37kBmrW3Uk28eC6goRYDuU3mN+P3S9Gps0BGKYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U2KXtqb3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7143EC4CEDD;
	Tue, 15 Apr 2025 08:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744705682;
	bh=bJ7ZPUThSUnefT1KsfBYGvnQ6e2CeijPhdt/RibAHwM=;
	h=From:To:Cc:Subject:Date:From;
	b=U2KXtqb3X8Sj4NOHcaB0jB/39OR8RnneTpvE9qkMnlxDNYSEY0Xy8QHQ0b/i/RGjr
	 GxSfW9wiusROd+zLSDJNprWvntdBrsZ4yN+mJqrbXVEDAY5rDqAHucIPBvHXWF3RBD
	 l00i8I+CqoOn6PI57gFXdVrl/aiwj1ctef0+vW0Q36Zry+u4tEGycAAuzVr4p4ZBgW
	 /oFuRNcpIfepK46d2YK2B3ODSHb6YrpkjTWul0PQt+/0NICyrZ5RIY3ANFUVe1iqOR
	 UhIDFLpQHr1HPb5hXP7hgouSTMI/OSaUCts0fcz+S361EM/PscBPutwJCgl3ylLOjZ
	 RMfotyZJTZknw==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH] fs: remove uselib() system call
Date: Tue, 15 Apr 2025 10:27:50 +0200
Message-ID: <20250415-kanufahren-besten-02ac00e6becd@brauner>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8390; i=brauner@kernel.org; h=from:subject:message-id; bh=bJ7ZPUThSUnefT1KsfBYGvnQ6e2CeijPhdt/RibAHwM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT/k+jKqri+95XfjR+eWidNb05iWhacquLxIo6H45aS9 c1Xi+azd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEwkqISRYUZhhfz7gqjCXw0+ b10LjgsqP17E7b0wiKvilomKbeSFTkaGyXf4GI9sV42sUH7uHbmIpewg/yz2q5Ebz7+7OHvvokx dbgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

This system call has been deprecated for quite a while now.
Let's try and remove it from the kernel completely.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 arch/m68k/configs/amcore_defconfig         |  1 -
 arch/x86/configs/i386_defconfig            |  1 -
 arch/xtensa/configs/cadence_csp_defconfig  |  1 -
 fs/binfmt_elf.c                            | 76 ----------------------
 fs/exec.c                                  | 60 -----------------
 include/linux/binfmts.h                    |  1 -
 init/Kconfig                               | 10 ---
 tools/testing/selftests/bpf/config.aarch64 |  1 -
 tools/testing/selftests/bpf/config.s390x   |  1 -
 9 files changed, 152 deletions(-)

diff --git a/arch/m68k/configs/amcore_defconfig b/arch/m68k/configs/amcore_defconfig
index 110279a64aa4..60767811e34a 100644
--- a/arch/m68k/configs/amcore_defconfig
+++ b/arch/m68k/configs/amcore_defconfig
@@ -2,7 +2,6 @@ CONFIG_LOCALVERSION="amcore-002"
 CONFIG_DEFAULT_HOSTNAME="amcore"
 CONFIG_SYSVIPC=y
 # CONFIG_FHANDLE is not set
-# CONFIG_USELIB is not set
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 # CONFIG_AIO is not set
diff --git a/arch/x86/configs/i386_defconfig b/arch/x86/configs/i386_defconfig
index 91801138b10b..7cd2f395f301 100644
--- a/arch/x86/configs/i386_defconfig
+++ b/arch/x86/configs/i386_defconfig
@@ -1,7 +1,6 @@
 CONFIG_WERROR=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
-CONFIG_USELIB=y
 CONFIG_AUDIT=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
diff --git a/arch/xtensa/configs/cadence_csp_defconfig b/arch/xtensa/configs/cadence_csp_defconfig
index 91c4c4cae8a7..49f50d1bd724 100644
--- a/arch/xtensa/configs/cadence_csp_defconfig
+++ b/arch/xtensa/configs/cadence_csp_defconfig
@@ -1,6 +1,5 @@
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
-CONFIG_USELIB=y
 CONFIG_NO_HZ_IDLE=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_IRQ_TIME_ACCOUNTING=y
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 584fa89bc877..7e2afe3220f7 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -68,12 +68,6 @@
 
 static int load_elf_binary(struct linux_binprm *bprm);
 
-#ifdef CONFIG_USELIB
-static int load_elf_library(struct file *);
-#else
-#define load_elf_library NULL
-#endif
-
 /*
  * If we don't support core dumping, then supply a NULL so we
  * don't even try.
@@ -101,7 +95,6 @@ static int elf_core_dump(struct coredump_params *cprm);
 static struct linux_binfmt elf_format = {
 	.module		= THIS_MODULE,
 	.load_binary	= load_elf_binary,
-	.load_shlib	= load_elf_library,
 #ifdef CONFIG_COREDUMP
 	.core_dump	= elf_core_dump,
 	.min_coredump	= ELF_EXEC_PAGESIZE,
@@ -1361,75 +1354,6 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	goto out;
 }
 
-#ifdef CONFIG_USELIB
-/* This is really simpleminded and specialized - we are loading an
-   a.out library that is given an ELF header. */
-static int load_elf_library(struct file *file)
-{
-	struct elf_phdr *elf_phdata;
-	struct elf_phdr *eppnt;
-	int retval, error, i, j;
-	struct elfhdr elf_ex;
-
-	error = -ENOEXEC;
-	retval = elf_read(file, &elf_ex, sizeof(elf_ex), 0);
-	if (retval < 0)
-		goto out;
-
-	if (memcmp(elf_ex.e_ident, ELFMAG, SELFMAG) != 0)
-		goto out;
-
-	/* First of all, some simple consistency checks */
-	if (elf_ex.e_type != ET_EXEC || elf_ex.e_phnum > 2 ||
-	    !elf_check_arch(&elf_ex) || !file->f_op->mmap)
-		goto out;
-	if (elf_check_fdpic(&elf_ex))
-		goto out;
-
-	/* Now read in all of the header information */
-
-	j = sizeof(struct elf_phdr) * elf_ex.e_phnum;
-	/* j < ELF_MIN_ALIGN because elf_ex.e_phnum <= 2 */
-
-	error = -ENOMEM;
-	elf_phdata = kmalloc(j, GFP_KERNEL);
-	if (!elf_phdata)
-		goto out;
-
-	eppnt = elf_phdata;
-	error = -ENOEXEC;
-	retval = elf_read(file, eppnt, j, elf_ex.e_phoff);
-	if (retval < 0)
-		goto out_free_ph;
-
-	for (j = 0, i = 0; i<elf_ex.e_phnum; i++)
-		if ((eppnt + i)->p_type == PT_LOAD)
-			j++;
-	if (j != 1)
-		goto out_free_ph;
-
-	while (eppnt->p_type != PT_LOAD)
-		eppnt++;
-
-	/* Now use mmap to map the library into memory. */
-	error = elf_load(file, ELF_PAGESTART(eppnt->p_vaddr),
-			eppnt,
-			PROT_READ | PROT_WRITE | PROT_EXEC,
-			MAP_FIXED_NOREPLACE | MAP_PRIVATE,
-			0);
-
-	if (error != ELF_PAGESTART(eppnt->p_vaddr))
-		goto out_free_ph;
-
-	error = 0;
-
-out_free_ph:
-	kfree(elf_phdata);
-out:
-	return error;
-}
-#endif /* #ifdef CONFIG_USELIB */
-
 #ifdef CONFIG_ELF_CORE
 /*
  * ELF core dumper
diff --git a/fs/exec.c b/fs/exec.c
index 8e4ea5f1e64c..cfbb2b9ee3c9 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -115,66 +115,6 @@ bool path_noexec(const struct path *path)
 	       (path->mnt->mnt_sb->s_iflags & SB_I_NOEXEC);
 }
 
-#ifdef CONFIG_USELIB
-/*
- * Note that a shared library must be both readable and executable due to
- * security reasons.
- *
- * Also note that we take the address to load from the file itself.
- */
-SYSCALL_DEFINE1(uselib, const char __user *, library)
-{
-	struct linux_binfmt *fmt;
-	struct file *file;
-	struct filename *tmp = getname(library);
-	int error = PTR_ERR(tmp);
-	static const struct open_flags uselib_flags = {
-		.open_flag = O_LARGEFILE | O_RDONLY,
-		.acc_mode = MAY_READ | MAY_EXEC,
-		.intent = LOOKUP_OPEN,
-		.lookup_flags = LOOKUP_FOLLOW,
-	};
-
-	if (IS_ERR(tmp))
-		goto out;
-
-	file = do_filp_open(AT_FDCWD, tmp, &uselib_flags);
-	putname(tmp);
-	error = PTR_ERR(file);
-	if (IS_ERR(file))
-		goto out;
-
-	/*
-	 * Check do_open_execat() for an explanation.
-	 */
-	error = -EACCES;
-	if (WARN_ON_ONCE(!S_ISREG(file_inode(file)->i_mode)) ||
-	    path_noexec(&file->f_path))
-		goto exit;
-
-	error = -ENOEXEC;
-
-	read_lock(&binfmt_lock);
-	list_for_each_entry(fmt, &formats, lh) {
-		if (!fmt->load_shlib)
-			continue;
-		if (!try_module_get(fmt->module))
-			continue;
-		read_unlock(&binfmt_lock);
-		error = fmt->load_shlib(file);
-		read_lock(&binfmt_lock);
-		put_binfmt(fmt);
-		if (error != -ENOEXEC)
-			break;
-	}
-	read_unlock(&binfmt_lock);
-exit:
-	fput(file);
-out:
-	return error;
-}
-#endif /* #ifdef CONFIG_USELIB */
-
 #ifdef CONFIG_MMU
 /*
  * The nascent bprm->mm is not visible until exec_mmap() but it can
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index 1625c8529e70..65abd5ab8836 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -90,7 +90,6 @@ struct linux_binfmt {
 	struct list_head lh;
 	struct module *module;
 	int (*load_binary)(struct linux_binprm *);
-	int (*load_shlib)(struct file *);
 #ifdef CONFIG_COREDUMP
 	int (*core_dump)(struct coredump_params *cprm);
 	unsigned long min_coredump;	/* minimal dump size */
diff --git a/init/Kconfig b/init/Kconfig
index 63f5974b9fa6..b7cc7f5b2595 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -479,16 +479,6 @@ config CROSS_MEMORY_ATTACH
 	  to directly read from or write to another process' address space.
 	  See the man page for more details.
 
-config USELIB
-	bool "uselib syscall (for libc5 and earlier)"
-	default ALPHA || M68K || SPARC
-	help
-	  This option enables the uselib syscall, a system call used in the
-	  dynamic linker from libc5 and earlier.  glibc does not use this
-	  system call.  If you intend to run programs built on libc5 or
-	  earlier, you may need to enable this syscall.  Current systems
-	  running glibc can safely disable this.
-
 config AUDIT
 	bool "Auditing support"
 	depends on NET
diff --git a/tools/testing/selftests/bpf/config.aarch64 b/tools/testing/selftests/bpf/config.aarch64
index 3720b7611523..e1495a4bbc99 100644
--- a/tools/testing/selftests/bpf/config.aarch64
+++ b/tools/testing/selftests/bpf/config.aarch64
@@ -158,7 +158,6 @@ CONFIG_TRANSPARENT_HUGEPAGE=y
 CONFIG_TUN=y
 CONFIG_UNIX=y
 CONFIG_UPROBES=y
-CONFIG_USELIB=y
 CONFIG_USER_NS=y
 CONFIG_VETH=y
 CONFIG_VLAN_8021Q=y
diff --git a/tools/testing/selftests/bpf/config.s390x b/tools/testing/selftests/bpf/config.s390x
index 706931a8c2c6..26c3bc2ce11d 100644
--- a/tools/testing/selftests/bpf/config.s390x
+++ b/tools/testing/selftests/bpf/config.s390x
@@ -128,7 +128,6 @@ CONFIG_TRANSPARENT_HUGEPAGE=y
 CONFIG_TUN=y
 CONFIG_UNIX=y
 CONFIG_UPROBES=y
-CONFIG_USELIB=y
 CONFIG_USER_NS=y
 CONFIG_VETH=y
 CONFIG_VLAN_8021Q=y
-- 
2.47.2


