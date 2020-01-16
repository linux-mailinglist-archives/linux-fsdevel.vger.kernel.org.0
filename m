Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 138DB13D5F4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2020 09:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731036AbgAPIav (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jan 2020 03:30:51 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:52698 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbgAPIav (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jan 2020 03:30:51 -0500
Received: by mail-pj1-f65.google.com with SMTP id a6so1202585pjh.2;
        Thu, 16 Jan 2020 00:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PRD6aeufLSd46od9AzCBC//aqtaStUZLDGOKGtSVPRE=;
        b=FggrzmcfUxGIJSa3geWjNxYL4+CEFhT7P/fxy7SEYin7E8xeo3A9XygBO9kjb2n0E+
         gVwbZbyE6Mvar8FK2QVTSKXxQ6j/pwH8YZH/hjhKFjIfEjJc2T4b5e42PhZRuU/4mZyc
         YYi6c5eIi94a3DvgGQoIEElGlCWiJ1YQdXrhVRvO+TwLFfd/9/jqWep7s/pmc3CrC+3m
         wV7xy1FvASlYZRH/7a/zyVP8guxAn+z3JPu2ay67O9EszexVbVmypIAgJzSZJG+6AB8n
         hfBZGZMqgfj9PYEso1aQ+Rzas4r6mJu+OXVG3OOmgTbd4bnsnD21bDN5KZr3UVEbD3FP
         W2BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=PRD6aeufLSd46od9AzCBC//aqtaStUZLDGOKGtSVPRE=;
        b=RsNoa6EPFBQWXhOwIRshsXSdE+H1pqPpVGuAxB1Oi2XjikJzPa5SfcipWQ7x4RJmIR
         osexnV5dXH50HWf5aQ7VWPuzUAHxTTYdraFS44oLHfVZkrnESmU+iV6JOZh8+CcY6Y8f
         eJR4az/jvqqAixdXfohaeSTF5OqHshnqihs6uH496lYycK7+boJxqHUIheaGyfThMvSq
         WIOwYZtFSDgemv6/DoPdKd0rzJ4d3beNTE8TINyoaSj7Dt8jy0hLzb8ise9io+4TkLe6
         0PVFH24S8p0YhXMrhvd1xO4JKuYAXEPjhQe2WQstRx+5d9tgm6jcLkRQrwtfl8vjONz+
         SzGQ==
X-Gm-Message-State: APjAAAUyTg2pI2u1xTfkkgHWhwt+K39P/LYlrtF8XeBxPxAQjoSDJ4Ag
        HLPCJ2K7JAJA9FsKEkjdmvv8PNmK6freWw==
X-Google-Smtp-Source: APXvYqweeOU4USwlRuwhMJ38zJ0vYKCTyawhwg7skQD3cW4OokmktruOFDl7FFPKS4Hg3FkZEK4TYA==
X-Received: by 2002:a17:90a:c78f:: with SMTP id gn15mr5534469pjb.88.1579163450116;
        Thu, 16 Jan 2020 00:30:50 -0800 (PST)
Received: from xps.lan ([103.125.232.133])
        by smtp.gmail.com with ESMTPSA id l10sm2509108pjy.5.2020.01.16.00.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 00:30:49 -0800 (PST)
From:   YunQiang Su <syq@debian.org>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        James.Bottomley@hansenpartnership.com, viro@zeniv.linux.org.uk,
        laurent@vivier.eu
Cc:     YunQiang Su <ysu@wavecomp.com>
Subject: [PATCH v3] binfmt_misc: pass info about P flag by AT_FLAGS
Date:   Thu, 16 Jan 2020 16:30:31 +0800
Message-Id: <20200116083031.174367-1-syq@debian.org>
X-Mailer: git-send-email 2.25.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: YunQiang Su <ysu@wavecomp.com>

Currently program invoked by binfmt_misc cannot be aware about whether
P flag, aka preserve path is enabled.

Some applications like qemu need to know since it has 2 use case:
  1. call by hand, like: qemu-mipsel-static test.app OPTION
     so, qemu have to assume that P option is not enabled.
  2. call by binfmt_misc. If qemu cannot know about whether P flag is
     enabled, distribution's have to set qemu without P flag, and
     binfmt_misc call qemu like:
       qemu-mipsel-static /absolute/path/to/test.app OPTION
     even test.app is not called by absoulute path, like
       ./relative/path/to/test.app

This patch passes this information by the 0st bits of unused AT_FLAGS.
Then, in qemu, we can get this info by:
   getauxval(AT_FLAGS) & (1<<0)

v2->v3:
  define a new AT_FLAGS_PRESERVE_ARGV0 as (1<<0), so now we use 0st bit.

v1->v2:
  not enable kdebug

See: https://bugs.launchpad.net/qemu/+bug/1818483
Signed-off-by: YunQiang Su <ysu@wavecomp.com>
---
 fs/binfmt_elf.c         | 6 +++++-
 fs/binfmt_elf_fdpic.c   | 6 +++++-
 fs/binfmt_misc.c        | 2 ++
 include/linux/binfmts.h | 4 ++++
 4 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index f4713ea76e82..c4efff74223f 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -178,6 +178,7 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
 	unsigned char k_rand_bytes[16];
 	int items;
 	elf_addr_t *elf_info;
+	elf_addr_t flags = 0;
 	int ei_index;
 	const struct cred *cred = current_cred();
 	struct vm_area_struct *vma;
@@ -252,7 +253,10 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
 	NEW_AUX_ENT(AT_PHENT, sizeof(struct elf_phdr));
 	NEW_AUX_ENT(AT_PHNUM, exec->e_phnum);
 	NEW_AUX_ENT(AT_BASE, interp_load_addr);
-	NEW_AUX_ENT(AT_FLAGS, 0);
+	if (bprm->interp_flags & BINPRM_FLAGS_PRESERVE_ARGV0) {
+		flags |= AT_FLAGS_PRESERVE_ARGV0;
+	}
+	NEW_AUX_ENT(AT_FLAGS, flags);
 	NEW_AUX_ENT(AT_ENTRY, e_entry);
 	NEW_AUX_ENT(AT_UID, from_kuid_munged(cred->user_ns, cred->uid));
 	NEW_AUX_ENT(AT_EUID, from_kuid_munged(cred->user_ns, cred->euid));
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index 240f66663543..c89a4630efad 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -507,6 +507,7 @@ static int create_elf_fdpic_tables(struct linux_binprm *bprm,
 	char __user *u_platform, *u_base_platform, *p;
 	int loop;
 	int nr;	/* reset for each csp adjustment */
+	unsigned long flags = 0;
 
 #ifdef CONFIG_MMU
 	/* In some cases (e.g. Hyper-Threading), we want to avoid L1 evictions
@@ -647,7 +648,10 @@ static int create_elf_fdpic_tables(struct linux_binprm *bprm,
 	NEW_AUX_ENT(AT_PHENT,	sizeof(struct elf_phdr));
 	NEW_AUX_ENT(AT_PHNUM,	exec_params->hdr.e_phnum);
 	NEW_AUX_ENT(AT_BASE,	interp_params->elfhdr_addr);
-	NEW_AUX_ENT(AT_FLAGS,	0);
+	if (bprm->interp_flags & BINPRM_FLAGS_PRESERVE_ARGV0) {
+		flags |= AT_FLAGS_PRESERVE_ARGV0;
+	}
+	NEW_AUX_ENT(AT_FLAGS,	flags);
 	NEW_AUX_ENT(AT_ENTRY,	exec_params->entry_addr);
 	NEW_AUX_ENT(AT_UID,	(elf_addr_t) from_kuid_munged(cred->user_ns, cred->uid));
 	NEW_AUX_ENT(AT_EUID,	(elf_addr_t) from_kuid_munged(cred->user_ns, cred->euid));
diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index cdb45829354d..cb14e9bbf00f 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -158,6 +158,8 @@ static int load_misc_binary(struct linux_binprm *bprm)
 		retval = remove_arg_zero(bprm);
 		if (retval)
 			goto ret;
+	} else {
+		bprm->interp_flags |= AT_FLAGS_PRESERVE_ARGV0;
 	}
 
 	if (fmt->flags & MISC_FMT_OPEN_BINARY) {
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index b40fc633f3be..380a30a46db1 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -78,6 +78,10 @@ struct linux_binprm {
 #define BINPRM_FLAGS_PATH_INACCESSIBLE_BIT 2
 #define BINPRM_FLAGS_PATH_INACCESSIBLE (1 << BINPRM_FLAGS_PATH_INACCESSIBLE_BIT)
 
+/* if preserve the argv0 for the interpreter  */
+#define AT_FLAGS_PRESERVE_ARGV0_BIT 0
+#define AT_FLAGS_PRESERVE_ARGV0 (1 << AT_FLAGS_PRESERVE_ARGV0_BIT)
+
 /* Function parameter for binfmt->coredump */
 struct coredump_params {
 	const kernel_siginfo_t *siginfo;
-- 
2.25.0.rc1

