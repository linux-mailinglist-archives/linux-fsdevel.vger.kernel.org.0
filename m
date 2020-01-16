Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21A0C13D21F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2020 03:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbgAPCVP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 21:21:15 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37348 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbgAPCVP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 21:21:15 -0500
Received: by mail-pg1-f193.google.com with SMTP id q127so9104901pga.4;
        Wed, 15 Jan 2020 18:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I18TcJc5J/5NVytSTHAB8Z9j/dAkt1uAP5HlQjHDlpo=;
        b=m5mxi5gDBbNGkmrb4O4cBeW9Wp+NHvF04ZoWB+ieyGTqgESvip6ncAgsQZ5cdUZw6d
         rlV6q8TorGLfvXU/Oc7rY787vQ9/ssHVfut7bUP3sjeCmuyae2xNbeYZ1n1bjV4tM0kr
         oS4R4rdx1U5OyY9QnFDQd5miR6V+oH79ZozOp0rvMFBweo3NtjQTzKZHt1LcnXDFUw5c
         xRC6XjSZX23xwBNN6LFlspUepSgHw8zj9G8w7MEzRm0GG3Ip0nm3bLfAl9jmdwGMbzAM
         L6UST2VxC70IzZrqN5HFJaaHuPzyuDD7OP++qhhgtsc1zielD0rQQR+1roSyjJ7KPnJq
         oc5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=I18TcJc5J/5NVytSTHAB8Z9j/dAkt1uAP5HlQjHDlpo=;
        b=A//fMBacV5MAmVL9rJfqsfJ8I416AHiomhfuHKAino9B9yQHx84UxwlUMtgqHOIp6A
         kV168u6VtDQWG1RS+/URF1hrejdh488+UY0KvpgqSPrssa7U9ZftsTfUxRhUOWkocBjs
         GautP/bYV49XCH8gGN6R/9rDhJHr3Pa9UlAJzAEi1h6EFLBHNYKg50yMVmdbN3hJHw8x
         IAyjtsH6JjU225Mi6m14mcjzjOFlrN6WN8z4NsF1g1R3CRL4TS5TxqjenMUqoC1K4QKS
         WnH/BFKchnqgdwKv9wEWJBvltaPbB8Z0WdUKyoHFUnLcQGfBOwTpaql59IPi7PJPBAI8
         eEag==
X-Gm-Message-State: APjAAAW+l32fiGL7yrGsgv0W/6nlQogTAF0Baqi2fYY4oIkCRiZaQLZG
        jIjpFJ13/CyK3duTd0sq8qXb5ofC6OJ2pA==
X-Google-Smtp-Source: APXvYqw1qJ4Hp/CIKT/m4U/3NgQfylWNU9Vs05nDBK6X5UEO087z+6bsU4xUIQXXciGQQdj+ipOvLA==
X-Received: by 2002:a62:e80b:: with SMTP id c11mr35222354pfi.28.1579141274223;
        Wed, 15 Jan 2020 18:21:14 -0800 (PST)
Received: from xps.lan ([103.125.232.133])
        by smtp.gmail.com with ESMTPSA id u23sm23073232pfm.29.2020.01.15.18.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 18:21:13 -0800 (PST)
From:   YunQiang Su <syq@debian.org>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Laurent Vivier <laurent@vivier.eu>
Cc:     YunQiang Su <ysu@wavecomp.com>
Subject: [PATCH v2] binfmt_misc: pass info about P flag by AT_FLAGS
Date:   Thu, 16 Jan 2020 10:20:49 +0800
Message-Id: <20200116022049.164659-1-syq@debian.org>
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

This patch passes this information by the 3rd bits of unused AT_FLAGS.
Then, in qemu, we can get this info by:
   getauxval(AT_FLAGS) & (1<<3)

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
index f4713ea76e82..d33ee07d7f57 100644
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
+		flags |= BINPRM_FLAGS_PRESERVE_ARGV0;
+	}
+	NEW_AUX_ENT(AT_FLAGS, flags);
 	NEW_AUX_ENT(AT_ENTRY, e_entry);
 	NEW_AUX_ENT(AT_UID, from_kuid_munged(cred->user_ns, cred->uid));
 	NEW_AUX_ENT(AT_EUID, from_kuid_munged(cred->user_ns, cred->euid));
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index 240f66663543..5ad8fdb3babe 100644
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
+		flags |= BINPRM_FLAGS_PRESERVE_ARGV0;
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
-- 
2.25.0.rc1

