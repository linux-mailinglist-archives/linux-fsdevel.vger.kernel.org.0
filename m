Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50978107488
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2019 16:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfKVPIl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Nov 2019 10:08:41 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:52367 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbfKVPIk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Nov 2019 10:08:40 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MNccf-1iDS4A3GTj-00P4Ht; Fri, 22 Nov 2019 16:08:33 +0100
From:   Laurent Vivier <laurent@vivier.eu>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Laurent Vivier <laurent@vivier.eu>
Subject: [RFC v2] binfmt_misc: pass binfmt_misc flags to the interpreter
Date:   Fri, 22 Nov 2019 16:08:30 +0100
Message-Id: <20191122150830.15855-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:NEbcxsm+SkmB3SNa2ecYAw74OLAO27N+abnqS0hw6qizot3DkL/
 oIZPMS1Fl4h2KcTVxsaiMjun8uGWTNb3MBUF3AgUHh1PAyXn9mp+dZOb+WIXeHyIeJ9aNXg
 SiJpEBEOeG4f9FM1q6B8fWmzCXye4JNtGJzNOG9SludRw/0uTQKV/UC/MlrsdGlT8vjHQ3J
 Mfd7+LCmAsMD1tVcKE+EA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:r7soFzH1jcU=:wSVdgrQR0o0d3Ul5DZ+2Qw
 c1obj69GkbQmgRldov7tQJuXqhHluogD7Uk688a/NiNREejKTACBYmQHFsbUEtfq+szeImKYx
 JjIE6ePBCuxrNjpGMTFG/p2oEIIbvlYdyGBVSPJs7hToLg1keKbCJ1HgvksG2Gu9BM/II+nnt
 KeBYDVyNhcFJVT79wqqia8c5XvWfMiuPwQP1SYIki2ZOxuOqJM6iuJT4IClsnHmUEbRZFiJs8
 TJskALBuBaw26JHOasAjsfHZfd5eObd3HD1nIF9BrcIC/WNyMcrLvyVDY67Baq5bxCELAS2mY
 /G5nPERmhK2bCvrcJDaBSPQb2t8/VWAX+4he6j7hjOS4FnxgpLwbtz+t/OCEuHCRa/yZSxSwb
 +vArW9GYM02zGTqZ0LwdJ2l2Sqh7s3ucWM5gA8r/JlxbxvFvLfpx04dARJTfGoo3vU5gH4aQf
 gwe6dkZucPNqHr0McZ2qcLmltnnX67TyZ1X82c2JHiEuiX39CfqQMAcbmhsr37uVB00nU7sdF
 WFV6bT8MJI59ZVu3GGuz3zXg5YhIh4WoY8UwOQyRD4qRPNbFRewzfmaIi0cftTYg0mp2M18yu
 eVqVRNNWmQKCHRUgHtqyru6RjUuKhP4HXdTyp6PeZ8/Mo89FzkK8Pq9SDjsM7xDo0MoREKuUD
 nTMTccJtiElBBF/R6zfIwsdCd3oTjeBzUUzC0WYQ5v4RjXvxcwcbj59y20NFhrT9D0Fe39hy+
 wKFjdglhZugsU+gTyT9Oe9yqVeXQzAbh6m1BYrEpNi/pab/HOe4Xtm9SmnpMEW3fKRV9vBJMt
 cbssmiip3eTNkCb4Xtj5OCV943C9EUcLQ2dl0+Q4WNQtDBi5s8lhv1Vb+iQTS3q83XlhOOkQZ
 4rDn+dXTriymz8iDH75A==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It can be useful to the interpreter to know which flags are in use.

For instance, knowing if the preserve-argv[0] is in use would
allow to skip the pathname argument.

This patch uses an unused auxiliary vector, AT_FLAGS,  to pass the
content of the binfmt flags (special flags: P, F, C, O).

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---

Notes:
    v2: only pass special flags (remove Magic and Enabled flags)

 fs/binfmt_elf.c         | 2 +-
 fs/binfmt_elf_fdpic.c   | 2 +-
 fs/binfmt_misc.c        | 6 ++++++
 include/linux/binfmts.h | 2 +-
 4 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index c5642bcb6b46..7a34c03e5857 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -250,7 +250,7 @@ create_elf_tables(struct linux_binprm *bprm, struct elfhdr *exec,
 	NEW_AUX_ENT(AT_PHENT, sizeof(struct elf_phdr));
 	NEW_AUX_ENT(AT_PHNUM, exec->e_phnum);
 	NEW_AUX_ENT(AT_BASE, interp_load_addr);
-	NEW_AUX_ENT(AT_FLAGS, 0);
+	NEW_AUX_ENT(AT_FLAGS, bprm->fmt_flags);
 	NEW_AUX_ENT(AT_ENTRY, exec->e_entry);
 	NEW_AUX_ENT(AT_UID, from_kuid_munged(cred->user_ns, cred->uid));
 	NEW_AUX_ENT(AT_EUID, from_kuid_munged(cred->user_ns, cred->euid));
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index d86ebd0dcc3d..8fe839be125e 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -647,7 +647,7 @@ static int create_elf_fdpic_tables(struct linux_binprm *bprm,
 	NEW_AUX_ENT(AT_PHENT,	sizeof(struct elf_phdr));
 	NEW_AUX_ENT(AT_PHNUM,	exec_params->hdr.e_phnum);
 	NEW_AUX_ENT(AT_BASE,	interp_params->elfhdr_addr);
-	NEW_AUX_ENT(AT_FLAGS,	0);
+	NEW_AUX_ENT(AT_FLAGS,	bprm->fmt_flags);
 	NEW_AUX_ENT(AT_ENTRY,	exec_params->entry_addr);
 	NEW_AUX_ENT(AT_UID,	(elf_addr_t) from_kuid_munged(cred->user_ns, cred->uid));
 	NEW_AUX_ENT(AT_EUID,	(elf_addr_t) from_kuid_munged(cred->user_ns, cred->euid));
diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index cdb45829354d..25a392f23409 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -48,6 +48,9 @@ enum {Enabled, Magic};
 #define MISC_FMT_OPEN_BINARY (1 << 30)
 #define MISC_FMT_CREDENTIALS (1 << 29)
 #define MISC_FMT_OPEN_FILE (1 << 28)
+#define MISC_FMT_FLAGS_MASK (MISC_FMT_PRESERVE_ARGV0 | MISC_FMT_OPEN_BINARY | \
+			     MISC_FMT_CREDENTIALS | MISC_FMT_OPEN_FILE)
+
 
 typedef struct {
 	struct list_head list;
@@ -149,6 +152,9 @@ static int load_misc_binary(struct linux_binprm *bprm)
 	if (!fmt)
 		return retval;
 
+	/* pass special flags to the interpreter */
+	bprm->fmt_flags = fmt->flags & MISC_FMT_FLAGS_MASK;
+
 	/* Need to be able to load the file after exec */
 	retval = -ENOENT;
 	if (bprm->interp_flags & BINPRM_FLAGS_PATH_INACCESSIBLE)
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index b40fc633f3be..dae0d0d7b84d 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -60,7 +60,7 @@ struct linux_binprm {
 				   different for binfmt_{misc,script} */
 	unsigned interp_flags;
 	unsigned interp_data;
-	unsigned long loader, exec;
+	unsigned long loader, exec, fmt_flags;
 
 	struct rlimit rlim_stack; /* Saved RLIMIT_STACK used during exec. */
 
-- 
2.21.0

