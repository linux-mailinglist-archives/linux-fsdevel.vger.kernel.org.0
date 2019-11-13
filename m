Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB6FFB518
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2019 17:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbfKMQae (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Nov 2019 11:30:34 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:54861 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfKMQad (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Nov 2019 11:30:33 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MTRAS-1iIqj91PGm-00Tiv9; Wed, 13 Nov 2019 17:30:27 +0100
From:   Laurent Vivier <laurent@vivier.eu>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Laurent Vivier <laurent@vivier.eu>
Subject: [RFC] binfmt_misc: pass binfmt_misc flags to the interpreter
Date:   Wed, 13 Nov 2019 17:30:23 +0100
Message-Id: <20191113163023.12093-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:tKDMUG8kcwt6Ne6b/bU0I1DLrrXe8vTkpOS+u1umkGjkHDSF+JU
 A7lwtw6498ZdmmBz3K/VaEjT8J6PNt8keECx4g+9SGAHtcspsCjYiAdKlcF9xAEuufKb8y9
 pEgsZuyqKfdHBoOGNdB93fl6L6EmER3HmIEY64rmNEAShCmbAWpRSw7WIYy/qL2WTqVS1gI
 uETF245dKXzKYPRsFW1mQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Tvi5kkWmOQE=:ZFtWzL0TVRJ2aXPjbIWkcW
 8Ju9ZhhcB0e3hPbGotiKy9DsFQJQw6G4WePxU34waM4OCqeQOQShcOcPp6prro9ATF4DBvjW0
 WuCz9+0Wg3fU16nIYJTiaDnSzbmwT9e53aQqCTTPI4UgoRffaFU7FIbKLm9/cs+ZGtOGWLIZR
 UgkfcNIeFQkZzQct5tHAv3wugtQjCitxxkt9On1X3gcG6h9kasI+9Ruo8s2cXeSFf9wFF4loO
 FiSyFT/HFqlOUeGnNwLO9qWBlD9458lL5OO27p8+5ZTX49C0+gzJIIfIZZZoJde4ztiFMm/GR
 ir+yGZbZpL8msdwP/AFXb6ClbzSTu8TVKDSjp91lf28Gy4cRR/6JfK+KTyG83qF6tsqRqIzxd
 5O6iOKE/gkeSGC2ybVehvrfErfcoSxgpODFPwk/g/JVrP3ievnbD7KrlM16OATiAOidMUIgcs
 wRRSIcGfhXMs5S45B5+QoUCpVho2Q68XE5Ay9Ty8zPQ7A0z5enLM8rcLo9D1loum1LU4USgAF
 k4yMrbaJOIpogPsUNLBaAX68ec3tqRxmOzdLhLwbGe9sMUUEGJepGxLTAbG6jd8ae4BKXhBBf
 yEdeMopecLr5vyk0R7hZSR8XQgJeP7or4jdtCNdKZz76TW4EmTe5EkLnBgf6OHj7HuJxjQshf
 ts/MwAfP4HwLSbVUIMUMNjfocISmcl7dNXwJahZZQrUf5+7JaIk/rvkkWWGRto3qURXkt8Qa0
 CdADQegswy8fGsqZT8d7HFq2TA1URShuQcDuptGSZ6sLt4D1oRD26b6fvJbkIiZK9nAdXC67K
 9ryYW2rag1fxD9krIb507bWQjxT313+lDNAciFzQMp2iMA1lGi7lxvhID8wqNGUgoBUtCds2X
 NdOLxUv2hlPHwV9TWcVg==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It can be useful to the interpreter to know which flags are in use.

For instance, knowing if the preserve-argv[0] is in use would
allow to skip the pathname argument.

This patch uses an unused auxiliary vector, AT_FLAGS,  to pass the
content of the binfmt flags (bits for P, F, C, O, ...).

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 fs/binfmt_elf.c         | 2 +-
 fs/binfmt_elf_fdpic.c   | 2 +-
 fs/binfmt_misc.c        | 2 ++
 include/linux/binfmts.h | 2 +-
 4 files changed, 5 insertions(+), 3 deletions(-)

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
index cdb45829354d..b204fa5a2fe4 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -149,6 +149,8 @@ static int load_misc_binary(struct linux_binprm *bprm)
 	if (!fmt)
 		return retval;
 
+	bprm->fmt_flags = fmt->flags;
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

