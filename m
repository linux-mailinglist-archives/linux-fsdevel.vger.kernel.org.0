Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2B514B4D9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2020 14:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbgA1NZ5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jan 2020 08:25:57 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:38037 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbgA1NZ5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jan 2020 08:25:57 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MqJVd-1jJLER3DyF-00nTKY; Tue, 28 Jan 2020 14:25:45 +0100
From:   Laurent Vivier <laurent@vivier.eu>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, YunQiang Su <ysu@wavecomp.com>,
        YunQiang Su <syq@debian.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v3] binfmt_misc: pass binfmt_misc flags to the interpreter
Date:   Tue, 28 Jan 2020 14:25:39 +0100
Message-Id: <20200128132539.782286-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:eWXb7aaroK86zzrWjK2j9vwjKnkAFyaw1v87qa/5v3cEHbTXQyv
 +AojOiDa01l1slt9K7UtAdtfMB9l1rh1L9Dok9mJzXiPR67AACyxN3kf7RUMT/5gYHzm2wD
 CMHdvPFD7j6o55bic4wFldgXjYLBN1TudIuHTfj5gwS9k1vBCNmb44arH0kdq59ELPQeYRs
 HtSQ8o3mWAOQEZiqd+/WQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:fqqHEZHmUuE=:DY0duXsJ3ymN7AM5TpJXL0
 YtOpUUYESk/zIJVBwYkwgsHhiLm0GLWoq/UTxv58JBYfFrdPNHMq/N2vBAeV0pol8W+SYArqi
 k742DwDiom8wq3wDCkHpoMHaaKzs77w9XU2EL6KeUu4pz1EtqgIbHFjpOF2AJ0qsRhaVahVbJ
 8i9vweNL7oql+4u/H/q8SKMfaDNKtMpD/9BPwWJqOznXo5QsUxe02Xa0BsJzdtxElw3tLd3dx
 S8LAb38sVJtLfosPkD5YDDF2R6ahUYYdsYZqKK3+RU5Ee1pMsrKEvCyoQmkSgpboAs2/s4hvW
 TI/7lAhLMdUK3lA58USZSr3S4faUowuShrfw6EEVMdBSnCElt7LUybrSw1TOb1uLyOREZEQxX
 txwZ4cN8JayjMlSCFWD8cs9fHX1WVWS3Pfk369JpiXUqjUdse5QfUld1wSQb8BDVLh9lnOvpY
 5KW7s/KYNFpnIz4feqkt1OiiFqyysjKP6MExbKyV9ZAJCbF2X9gpw3VSlm8FLSh34xInsNCE4
 L+EYTHSs/cy4a7oH7qW0kSsSHQQ6H1s5NTN0u55BkXFSACLGcDSxzX9R9S+7C8tZeI6g95A/3
 bEvkfVBq5HoPUIVtGmKtHb07Z//H7QEEt5+DayNtjw34VX6pHesAi+zNcM9YLGGZrqUcPclwI
 d9/AVdrFha5lpAgFaeG3xiietcpOAQf7NjrIBQpStWQsaKixM1DlvqH8y5eDOzZN2MIr58XvY
 jt6nzrFYcsfWpKQye23wjcRsP5ywzdprUj6x0rwXF50J8NE7D1LggSDzphe9VVp0XfcaY1vpd
 Hk6XtN5ymb75ZN9xH5wrBFRwVTYYNUD2CVwrks4fngzMQTMq41j6l4dcuxsT/A8dsvGl82o
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It can be useful to the interpreter to know which flags are in use.

For instance, knowing if the preserve-argv[0] is in use would
allow to skip the pathname argument.

This patch uses an unused auxiliary vector, AT_FLAGS, to add a
flag to inform interpreter if the preserve-argv[0] is enabled.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---

Notes:
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
    
    v3: mix my patch with one from YunQiang Su and my comments on it
        introduce a new flag in the uabi for the AT_FLAGS
    v2: only pass special flags (remove Magic and Enabled flags)

 fs/binfmt_elf.c              | 5 ++++-
 fs/binfmt_elf_fdpic.c        | 5 ++++-
 fs/binfmt_misc.c             | 4 +++-
 include/linux/binfmts.h      | 4 ++++
 include/uapi/linux/binfmts.h | 4 ++++
 5 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index ecd8d2698515..ff918042ceed 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -176,6 +176,7 @@ create_elf_tables(struct linux_binprm *bprm, struct elfhdr *exec,
 	unsigned char k_rand_bytes[16];
 	int items;
 	elf_addr_t *elf_info;
+	elf_addr_t flags = 0;
 	int ei_index = 0;
 	const struct cred *cred = current_cred();
 	struct vm_area_struct *vma;
@@ -250,7 +251,9 @@ create_elf_tables(struct linux_binprm *bprm, struct elfhdr *exec,
 	NEW_AUX_ENT(AT_PHENT, sizeof(struct elf_phdr));
 	NEW_AUX_ENT(AT_PHNUM, exec->e_phnum);
 	NEW_AUX_ENT(AT_BASE, interp_load_addr);
-	NEW_AUX_ENT(AT_FLAGS, 0);
+	if (bprm->interp_flags & BINPRM_FLAGS_PRESERVE_ARGV0)
+		flags |= AT_FLAGS_PRESERVE_ARGV0;
+	NEW_AUX_ENT(AT_FLAGS, flags);
 	NEW_AUX_ENT(AT_ENTRY, exec->e_entry);
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
2.24.1

