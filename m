Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A08517B81D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2020 09:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgCFIJo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Mar 2020 03:09:44 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33637 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgCFIJn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Mar 2020 03:09:43 -0500
Received: by mail-pl1-f195.google.com with SMTP id ay11so561926plb.0;
        Fri, 06 Mar 2020 00:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7TiOD25ZQuBocGWSYjvqKa3msFH5m2kuVO7nsDjKlwo=;
        b=NYMTN0wG6q+cq6aqTvrP9llFnl30M4rXTg+zEDw75WgKwGfqHH1odu9d4WDLBoE7TN
         PwOHuFwovG9TJWp/Hq8kcYY9ZQC3iYdTFjnpb/uc7dQt6+HnCiMG0mHThwgbHJKrPeDc
         lIT1d+OXgu/TKT7KUckC7Q9CmT/B8I16f5Df49kXmc0uVa6E0p/2rareOGebjILOBdr5
         Z12Bgs1bBXUibC/ue4p7pSzIEx7aMftiubqw9WQKH0STVLM2caaWgtVt+HTwWLkcdryH
         5k4H4/5qfWQ9CFLX4N6kPOoOLjyEfJzivdHTu8IbGt35LlPmbZGtrEmxZ3f/Dlg47Wyc
         GOug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=7TiOD25ZQuBocGWSYjvqKa3msFH5m2kuVO7nsDjKlwo=;
        b=N7VMgqD+6vKtggsTohNgLlZCzPAj0i/bQB0VepOpiNEBxTYGH+uxtlSf4cG/bqAdQS
         6ugek2JM5vzS4w8tkLqrEe3rkS6irLTHM2NlE4scuha+F8Pb+F7S210y5NXjWR2w3C0c
         gm9Fsn+nsJw7w/s4bUKD5xCASpLX2Qk/nacrpigIvR7CtYXKtWTNxympxVVPu7vFiMad
         7onIcGpe8Y4EVF9yuBU1pFJlhZ18TpizXE6Ul7f5vl9+UH9Gx0z+Jd1qsnGA79lSylUI
         EACebf31wrNBwTSZWqNEFkPnZrZCmjqJKdJa1/RUgvA+wXhR0GGKp7EMPYvLcrjqNAGW
         s83g==
X-Gm-Message-State: ANhLgQ1viSRO+NTiyBybskLFoohcBgoOxHe3znMpgmNYfxqGR1himOf1
        6ZBkqGANmzp9nurwI1rkCTc=
X-Google-Smtp-Source: ADFU+vsb++EN7BBbPDSzAC6BTc8MhQ1pUQF5dlP8WpcswbDRkZeKP9dFhHsYJt/c3xvb9l36V0FUlQ==
X-Received: by 2002:a17:90b:8c9:: with SMTP id ds9mr2422171pjb.11.1583482182196;
        Fri, 06 Mar 2020 00:09:42 -0800 (PST)
Received: from xps.vpn2.bfsu.edu.cn ([103.125.232.133])
        by smtp.gmail.com with ESMTPSA id x65sm22614647pfd.34.2020.03.06.00.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 00:09:41 -0800 (PST)
From:   YunQiang Su <syq@debian.org>
To:     torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        James.Bottomley@hansenpartnership.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        libc-alpha@sourceware.org, Laurent Vivier <laurent@vivier.eu>,
        YunQiang Su <syq@debian.org>
Subject: [PATCH] binfmt_misc: pass binfmt_misc P flag to the interpreter
Date:   Fri,  6 Mar 2020 16:09:05 +0800
Message-Id: <20200306080905.173466-1-syq@debian.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Laurent Vivier <laurent@vivier.eu>

It can be useful to the interpreter to know which flags are in use.

For instance, knowing if the preserve-argv[0] is in use would
allow to skip the pathname argument.

This patch uses an unused auxiliary vector, AT_FLAGS, to add a
flag to inform interpreter if the preserve-argv[0] is enabled.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: YunQiang Su <syq@debian.org>
---

Notes:
    This patch uses AT_FLAGS, which has never been used. We need to make a decision.
    since it is about the fundmental API of userland.

    This can be tested with QEMU from my branch:

      https://github.com/vivier/qemu/commits/binfmt-argv0

    With something like:

      # cp ..../qemu-ppc /chroot/powerpc/jessie

      # qemu-binfmt-conf.sh --qemu-path / --systemd ppc --credential yes \
                            --persistent no --preserve-argv0 yes
      # systemctl restart systemd-binfmt.service
      # cat /proc/sys/fs/binfmt_misc/qemu-ppc
      enabled
      interpreter //qemu-ppc
      flags: POC
      offset 0
      magic 7f454c4601020100000000000000000000020014
      mask ffffffffffffff00fffffffffffffffffffeffff
      # chroot /chroot/powerpc/jessie  sh -c 'echo $0'
      sh

      # qemu-binfmt-conf.sh --qemu-path / --systemd ppc --credential yes \
                            --persistent no --preserve-argv0 no
      # systemctl restart systemd-binfmt.service
      # cat /proc/sys/fs/binfmt_misc/qemu-ppc
      enabled
      interpreter //qemu-ppc
      flags: OC
      offset 0
      magic 7f454c4601020100000000000000000000020014
      mask ffffffffffffff00fffffffffffffffffffeffff
      # chroot /chroot/powerpc/jessie  sh -c 'echo $0'
      /bin/sh

    v4: Update to merge with linux-next: 20200305.
    v3: mix my patch with one from YunQiang Su and my comments on it
        introduce a new flag in the uabi for the AT_FLAGS
    v2: only pass special flags (remove Magic and Enabled flags)
---
 fs/binfmt_elf.c              | 6 ++++--
 fs/binfmt_elf_fdpic.c        | 5 ++++-
 fs/binfmt_misc.c             | 4 +++-
 include/linux/binfmts.h      | 4 ++++
 include/uapi/linux/binfmts.h | 4 ++++
 5 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 13f25e241ac4..e9f5d135b847 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -178,7 +178,7 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
 	const char *k_base_platform = ELF_BASE_PLATFORM;
 	unsigned char k_rand_bytes[16];
 	int items;
-	elf_addr_t *elf_info;
+	elf_addr_t *elf_info, flags = 0;
 	int ei_index;
 	const struct cred *cred = current_cred();
 	struct vm_area_struct *vma;
@@ -253,7 +253,9 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
 	NEW_AUX_ENT(AT_PHENT, sizeof(struct elf_phdr));
 	NEW_AUX_ENT(AT_PHNUM, exec->e_phnum);
 	NEW_AUX_ENT(AT_BASE, interp_load_addr);
-	NEW_AUX_ENT(AT_FLAGS, 0);
+	if (bprm->interp_flags & BINPRM_FLAGS_PRESERVE_ARGV0)
+		flags |= AT_FLAGS_PRESERVE_ARGV0;
+	NEW_AUX_ENT(AT_FLAGS, flags);
 	NEW_AUX_ENT(AT_ENTRY, e_entry);
 	NEW_AUX_ENT(AT_UID, from_kuid_munged(cred->user_ns, cred->uid));
 	NEW_AUX_ENT(AT_EUID, from_kuid_munged(cred->user_ns, cred->euid));
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index 240f66663543..abb90d82aa58 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -507,6 +507,7 @@ static int create_elf_fdpic_tables(struct linux_binprm *bprm,
 	char __user *u_platform, *u_base_platform, *p;
 	int loop;
 	int nr;	/* reset for each csp adjustment */
+	unsigned long flags = 0;
 
 #ifdef CONFIG_MMU
 	/* In some cases (e.g. Hyper-Threading), we want to avoid L1 evictions
@@ -647,7 +648,9 @@ static int create_elf_fdpic_tables(struct linux_binprm *bprm,
 	NEW_AUX_ENT(AT_PHENT,	sizeof(struct elf_phdr));
 	NEW_AUX_ENT(AT_PHNUM,	exec_params->hdr.e_phnum);
 	NEW_AUX_ENT(AT_BASE,	interp_params->elfhdr_addr);
-	NEW_AUX_ENT(AT_FLAGS,	0);
+	if (bprm->interp_flags & BINPRM_FLAGS_PRESERVE_ARGV0)
+		flags |= AT_FLAGS_PRESERVE_ARGV0;
+	NEW_AUX_ENT(AT_FLAGS,	flags);
 	NEW_AUX_ENT(AT_ENTRY,	exec_params->entry_addr);
 	NEW_AUX_ENT(AT_UID,	(elf_addr_t) from_kuid_munged(cred->user_ns, cred->uid));
 	NEW_AUX_ENT(AT_EUID,	(elf_addr_t) from_kuid_munged(cred->user_ns, cred->euid));
diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index cdb45829354d..b9acdd26a654 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -154,7 +154,9 @@ static int load_misc_binary(struct linux_binprm *bprm)
 	if (bprm->interp_flags & BINPRM_FLAGS_PATH_INACCESSIBLE)
 		goto ret;
 
-	if (!(fmt->flags & MISC_FMT_PRESERVE_ARGV0)) {
+	if (fmt->flags & MISC_FMT_PRESERVE_ARGV0) {
+		bprm->interp_flags |= BINPRM_FLAGS_PRESERVE_ARGV0;
+	} else {
 		retval = remove_arg_zero(bprm);
 		if (retval)
 			goto ret;
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index b40fc633f3be..265b80d5fd6f 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -78,6 +78,10 @@ struct linux_binprm {
 #define BINPRM_FLAGS_PATH_INACCESSIBLE_BIT 2
 #define BINPRM_FLAGS_PATH_INACCESSIBLE (1 << BINPRM_FLAGS_PATH_INACCESSIBLE_BIT)
 
+/* if preserve the argv0 for the interpreter  */
+#define BINPRM_FLAGS_PRESERVE_ARGV0_BIT 3
+#define BINPRM_FLAGS_PRESERVE_ARGV0 (1 << BINPRM_FLAGS_PRESERVE_ARGV0_BIT)
+
 /* Function parameter for binfmt->coredump */
 struct coredump_params {
 	const kernel_siginfo_t *siginfo;
diff --git a/include/uapi/linux/binfmts.h b/include/uapi/linux/binfmts.h
index 689025d9c185..a70747416130 100644
--- a/include/uapi/linux/binfmts.h
+++ b/include/uapi/linux/binfmts.h
@@ -18,4 +18,8 @@ struct pt_regs;
 /* sizeof(linux_binprm->buf) */
 #define BINPRM_BUF_SIZE 256
 
+/* if preserve the argv0 for the interpreter  */
+#define AT_FLAGS_PRESERVE_ARGV0_BIT 0
+#define AT_FLAGS_PRESERVE_ARGV0 (1 << AT_FLAGS_PRESERVE_ARGV0_BIT)
+
 #endif /* _UAPI_LINUX_BINFMTS_H */
-- 
2.25.1

