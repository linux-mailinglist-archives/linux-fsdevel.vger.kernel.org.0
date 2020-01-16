Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCFA113D6E0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2020 10:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729274AbgAPJ3B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jan 2020 04:29:01 -0500
Received: from mail-pg1-f174.google.com ([209.85.215.174]:33299 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgAPJ3B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jan 2020 04:29:01 -0500
Received: by mail-pg1-f174.google.com with SMTP id 6so9618155pgk.0;
        Thu, 16 Jan 2020 01:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jKNqEDMAYJLWiVXwLrJSv2qQntpmVMG4CM0E+WSOCeg=;
        b=IaebaFcpW3PSdbTSyUT224K3/YfvSKnBaLGL4X2CT/EtvihEIrkdEgGgb8Qngv6hpN
         /qY9a+w5OXZ6h7usiipxX+0Svn42v3ecnGWXMYFSswYCTU7i1UW7OqN2pyCX+tdZ18D7
         nNpdUSO+t2D1AAm2DHqpOvvch4r31qeFBNwHSULRQtlDA0GG2FKItBZ9kQAXRGP3GEV2
         up2CrVCjWu8iyq0GYH/HGBxYWj5xJvv8Pm8utUM2NQpJlBmPoZJMP4sj4aQt4mtlnbGO
         O2Sz59onVGRoPwY8Q5l13HvCkFZ/oJ9mQv7SzSzOOGqce3X7Gp8zh7km4SmOYMIlHWlv
         lCVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=jKNqEDMAYJLWiVXwLrJSv2qQntpmVMG4CM0E+WSOCeg=;
        b=aCj0TkTatyBtAbe4NripF2zYI6sMmTjl1st1x3pzs9cOprhkHcfOxakj9/+/vEVUeQ
         OSaTwWnbc/1a3xy1pQxNmy3xrPJyx0XlUyjOpBr4JCTi/4pgNgO/s6OqL3J5IKk7qbrw
         8epzPkn6gfuUxbEjvh6sDZPj1RTWQTkKOxvQRwxZHpqGERvNYXOD1xt0UcENClaMLHgP
         l3zHRf4jKN4AXw34HgBRLTf6xJgaNqPa9SH8sycsIYw9Io4IPXwQyoykIAND/1HTx83r
         nRsOHIGPip38CkUzyRU38XgNl0anp50GKatPbJBOUOZSJjLqzC5KMYgG3qmAMAfX3x9h
         M+SQ==
X-Gm-Message-State: APjAAAX5VwZZXTVIINp/p1ut/NowoLy9HaiRCLqgV99DmXy6EMj8xeI/
        RvncFVTcGRR1zj4IvSe2xYs4E79n5FsJ+5rF
X-Google-Smtp-Source: APXvYqxhFXKcGChC/mi6M3HY0Ab3AyLkeay+tKD2boeg9Nk/4j7dCuV/kI66ooyvN+iArLtdq5iHPg==
X-Received: by 2002:a62:1b4d:: with SMTP id b74mr37357303pfb.59.1579166940199;
        Thu, 16 Jan 2020 01:29:00 -0800 (PST)
Received: from xps.vpn2.bfsu.edu.cn ([103.125.232.133])
        by smtp.gmail.com with ESMTPSA id d27sm23276038pgm.53.2020.01.16.01.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 01:28:59 -0800 (PST)
From:   YunQiang Su <syq@debian.org>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        James.Bottomley@hansenpartnership.com, viro@zeniv.linux.org.uk
Cc:     YunQiang Su <ysu@wavecomp.com>
Subject: [PATCH v4] binfmt_misc: pass info about P flag by AT_FLAGS
Date:   Thu, 16 Jan 2020 17:28:52 +0800
Message-Id: <20200116092852.438603-1-syq@debian.org>
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

v3->v4:
 use BINPRM_FLAGS_PRESERVE_ARGV0 (1<<3) as internal ABI, and
     AT_FLAGS_PRESERVE_ARGV0 (1<<0) as external ABI.

v2->v3:
  define a new AT_FLAGS_PRESERVE_ARGV0 as (1<<0), so now we use 0st bit.

v1->v2:
  not enable kdebug

See: https://bugs.launchpad.net/qemu/+bug/1818483
Signed-off-by: YunQiang Su <ysu@wavecomp.com>
---
 fs/binfmt_elf.c              | 6 +++++-
 fs/binfmt_elf_fdpic.c        | 6 +++++-
 fs/binfmt_misc.c             | 2 ++
 include/linux/binfmts.h      | 4 ++++
 include/uapi/linux/binfmts.h | 3 +++
 5 files changed, 19 insertions(+), 2 deletions(-)

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
index cdb45829354d..3f41b667b241 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -158,6 +158,8 @@ static int load_misc_binary(struct linux_binprm *bprm)
 		retval = remove_arg_zero(bprm);
 		if (retval)
 			goto ret;
+	} else {
+		bprm->interp_flags |= BINPRM_FLAGS_PRESERVE_ARGV0;
 	}
 
 	if (fmt->flags & MISC_FMT_OPEN_BINARY) {
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
index 689025d9c185..cd69a4ebba3f 100644
--- a/include/uapi/linux/binfmts.h
+++ b/include/uapi/linux/binfmts.h
@@ -18,4 +18,7 @@ struct pt_regs;
 /* sizeof(linux_binprm->buf) */
 #define BINPRM_BUF_SIZE 256
 
+#define AT_FLAGS_PRESERVE_ARGV0_BIT 0
+#define AT_FLAGS_PRESERVE_ARGV0 (1 << AT_FLAGS_PRESERVE_ARGV0_BIT)
+
 #endif /* _UAPI_LINUX_BINFMTS_H */
-- 
2.25.0.rc1

