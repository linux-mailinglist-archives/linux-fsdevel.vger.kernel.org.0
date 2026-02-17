Return-Path: <linux-fsdevel+bounces-77381-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBHVNSCtlGl7GQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77381-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 19:02:08 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5372C14ED82
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 19:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2B9523053BC3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 18:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4E4372B24;
	Tue, 17 Feb 2026 18:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cBScIjuJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f73.google.com (mail-oa1-f73.google.com [209.85.160.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F5729BDB0
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Feb 2026 18:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771351276; cv=none; b=PwnpN9zYHk9TH0heHdjXZtaQPPktolmSIp19MLLoH4BN4U0TQB1ngMVhbk7gxQRsHXtB53Ma6+bSVgpnMNymg1b4phR9osVLZdl2v+fj5yrPXMpYm6WOIr8/+76EXI9xJqmlutaU0pgc+6VxHKw0MwIdLZI6DCIig1To12Ayc80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771351276; c=relaxed/simple;
	bh=IMo7fTZiH5AjbqIlP1FpJeao4rQ8mb0ZRSl0gCTzrco=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Li0W1dr5MW642BEOEYYnWrILodR7MqAm7CTpXDNqkksaXiAqlMhA9XtBPKTcWjkK1PBRGPVawLlpJX54AmyLhUUS1zrqs3YyOgTJuSvLZS+DDd9SovJTBOZNUGtPkeKSL8dTIVOuHFEw9vQKWvpdYD3RPp0cbP3umxPt+Evrmvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cBScIjuJ; arc=none smtp.client-ip=209.85.160.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com
Received: by mail-oa1-f73.google.com with SMTP id 586e51a60fabf-40ee65ba6f9so39200910fac.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Feb 2026 10:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771351274; x=1771956074; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zNf1st2FT2PYXwVv7YSArpm+3hAEziPMQnbmcsUNwA8=;
        b=cBScIjuJbSK0MAIIJ0IkAAfG4mzSLTMKibqW8EV8CDg2m4WqplDlgQMpIenXC2u5PK
         8TsQgBGHMjfXZKjPxTWsfAgU9gxpRefyMbU3uoN7PENBINz9RZsuoSLJMa9I8IgfvFrR
         1lE6h/i4Is4BVMNbL5R3vkQGNo5uYeMQTzY6pwtIUubtYQLBTBnSHI4QNUdaBQqEKf19
         rieZJqV+tdH+j6u1tGedpSIu6w0KgbbZWfIOMDuYbyEK9WX/J+9aqJ5NuoF3hKQxVEgw
         IR6Ingz6krSB54x2F+FoxTe85Df9Bjs162g8KpnIEoHCl7MK1RyL+pPbrM7lCfOoRGBB
         QtoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771351274; x=1771956074;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zNf1st2FT2PYXwVv7YSArpm+3hAEziPMQnbmcsUNwA8=;
        b=FveuzMUc+MAfPOcucvglAPr+kpQo1vdxBnWtCVvtWspODT+YOdwG6PatbIGWEpmMkT
         vr3aM3Zzkc/BUhi+t2NNy48GAQ2ymv/qWSQX92ppM4Yn7BFDC8BvEClp2n8QSH/gRtlS
         tFpkBn6LWy/RLkiHNmAFMFxKx/83UsRa5BGeiCZNKll301Whjw3w1mU5uUzjdqjXQWC7
         I+qNrHOqiZN+3/2fJUUvuKHWcr07t3yFBv1XMCC3JkbE1vSg3h6yAFg20jCJXknqwtyP
         uG28LrMz2BpK8vlkPdvLoFvGiYtlibM8vuMuRYz3yFL1ygWhEx4CUM2j/b7U0JQ1UOeH
         45SQ==
X-Forwarded-Encrypted: i=1; AJvYcCWp/RYVKP0DAWcNgIylTtjHawDLWgLAL5/u42iLzDJ1xNHAq7HLF2Rz2tnSGt+a91LZdDDYzqNWfEFxklh/@vger.kernel.org
X-Gm-Message-State: AOJu0YzT3KjBwrJIZbpjQNXT5QnT+UohJvSPGuoG4ZBIahypdy3P56Fg
	1UUvH4xhU/TlKciduab48HsZwdb0rwiW4PDqsovdzqgUJ7KmTqIFn05azR3/Uw9jCQpDsrKSDXu
	19g09lg==
X-Received: from jabx17.prod.google.com ([2002:a02:6f11:0:b0:5cf:13a7:b8e8])
 (user=avagin job=prod-delivery.src-stubby-dispatcher) by 2002:a4a:e719:0:b0:678:cf78:1e9a
 with SMTP id 006d021491bc7-678cf7820e5mr4561614eaf.35.1771351274078; Tue, 17
 Feb 2026 10:01:14 -0800 (PST)
Date: Tue, 17 Feb 2026 18:01:06 +0000
In-Reply-To: <20260217180108.1420024-1-avagin@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260217180108.1420024-1-avagin@google.com>
X-Mailer: git-send-email 2.53.0.310.g728cabbaf7-goog
Message-ID: <20260217180108.1420024-3-avagin@google.com>
Subject: [PATCH 2/4] exec: inherit HWCAPs from the parent process
From: Andrei Vagin <avagin@google.com>
To: Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Cyrill Gorcunov <gorcunov@gmail.com>, Mike Rapoport <rppt@kernel.org>, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, criu@lists.linux.dev, 
	Chen Ridong <chenridong@huawei.com>, Christian Brauner <brauner@kernel.org>, 
	David Hildenbrand <david@kernel.org>, Eric Biederman <ebiederm@xmission.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Michal Koutny <mkoutny@suse.com>, 
	Andrei Vagin <avagin@google.com>, 
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-77381-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avagin@google.com,linux-fsdevel@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,mihalicyn.com,vger.kernel.org,kvack.org,lists.linux.dev,huawei.com,xmission.com,oracle.com,suse.com,google.com,futurfusion.io];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[futurfusion.io:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5372C14ED82
X-Rspamd-Action: no action

Introduces a mechanism to inherit hardware capabilities (AT_HWCAP,
AT_HWCAP2, etc.) from a parent process when they have been modified via
prctl.

To support C/R operations (snapshots, live migration) in heterogeneous
clusters, we must ensure that processes utilize CPU features available
on all potential target nodes. To solve this, we need to advertise a
common feature set across the cluster.

This patch adds a new mm flag MMF_USER_HWCAP, which is set when the
auxiliary vector is modified via prctl(PR_SET_MM, PR_SET_MM_AUXV).  When
execve() is called, if the current process has MMF_USER_HWCAP set, the
HWCAP values are extracted from the current auxiliary vector and stored
in the linux_binprm structure. These values are then used to populate
the auxiliary vector of the new process, effectively inheriting the
hardware capabilities.

The inherited HWCAPs are masked with the hardware capabilities supported
by the current kernel to ensure that we don't report more features than
actually supported. This is important to avoid unexpected behavior,
especially for processes with additional privileges.

Reviewed-by: Cyrill Gorcunov <gorcunov@gmail.com>
Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Signed-off-by: Andrei Vagin <avagin@google.com>
---
 fs/binfmt_elf.c          |  8 ++---
 fs/binfmt_elf_fdpic.c    |  8 ++---
 fs/exec.c                | 63 ++++++++++++++++++++++++++++++++++++++++
 include/linux/binfmts.h  | 11 +++++++
 include/linux/mm_types.h |  2 ++
 kernel/fork.c            |  3 ++
 kernel/sys.c             |  5 +++-
 7 files changed, 91 insertions(+), 9 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 3eb734c192e9..aec129e33f0b 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -246,7 +246,7 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
 	 */
 	ARCH_DLINFO;
 #endif
-	NEW_AUX_ENT(AT_HWCAP, ELF_HWCAP);
+	NEW_AUX_ENT(AT_HWCAP, bprm->hwcap);
 	NEW_AUX_ENT(AT_PAGESZ, ELF_EXEC_PAGESIZE);
 	NEW_AUX_ENT(AT_CLKTCK, CLOCKS_PER_SEC);
 	NEW_AUX_ENT(AT_PHDR, phdr_addr);
@@ -264,13 +264,13 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
 	NEW_AUX_ENT(AT_SECURE, bprm->secureexec);
 	NEW_AUX_ENT(AT_RANDOM, (elf_addr_t)(unsigned long)u_rand_bytes);
 #ifdef ELF_HWCAP2
-	NEW_AUX_ENT(AT_HWCAP2, ELF_HWCAP2);
+	NEW_AUX_ENT(AT_HWCAP2, bprm->hwcap2);
 #endif
 #ifdef ELF_HWCAP3
-	NEW_AUX_ENT(AT_HWCAP3, ELF_HWCAP3);
+	NEW_AUX_ENT(AT_HWCAP3, bprm->hwcap3);
 #endif
 #ifdef ELF_HWCAP4
-	NEW_AUX_ENT(AT_HWCAP4, ELF_HWCAP4);
+	NEW_AUX_ENT(AT_HWCAP4, bprm->hwcap4);
 #endif
 	NEW_AUX_ENT(AT_EXECFN, bprm->exec);
 	if (k_platform) {
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index a3d4e6973b29..55b482f03c82 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -629,15 +629,15 @@ static int create_elf_fdpic_tables(struct linux_binprm *bprm,
 	 */
 	ARCH_DLINFO;
 #endif
-	NEW_AUX_ENT(AT_HWCAP,	ELF_HWCAP);
+	NEW_AUX_ENT(AT_HWCAP,	bprm->hwcap);
 #ifdef ELF_HWCAP2
-	NEW_AUX_ENT(AT_HWCAP2,	ELF_HWCAP2);
+	NEW_AUX_ENT(AT_HWCAP2,	bprm->hwcap2);
 #endif
 #ifdef ELF_HWCAP3
-	NEW_AUX_ENT(AT_HWCAP3,	ELF_HWCAP3);
+	NEW_AUX_ENT(AT_HWCAP3,	bprm->hwcap3);
 #endif
 #ifdef ELF_HWCAP4
-	NEW_AUX_ENT(AT_HWCAP4,	ELF_HWCAP4);
+	NEW_AUX_ENT(AT_HWCAP4,	bprm->hwcap4);
 #endif
 	NEW_AUX_ENT(AT_PAGESZ,	PAGE_SIZE);
 	NEW_AUX_ENT(AT_CLKTCK,	CLOCKS_PER_SEC);
diff --git a/fs/exec.c b/fs/exec.c
index 2e3a6593c6fd..9c70776fca9e 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1454,6 +1454,17 @@ static struct linux_binprm *alloc_bprm(int fd, struct filename *filename, int fl
 	 */
 	bprm->is_check = !!(flags & AT_EXECVE_CHECK);
 
+	bprm->hwcap = ELF_HWCAP;
+#ifdef ELF_HWCAP2
+	bprm->hwcap2 = ELF_HWCAP2;
+#endif
+#ifdef ELF_HWCAP3
+	bprm->hwcap3 = ELF_HWCAP3;
+#endif
+#ifdef ELF_HWCAP4
+	bprm->hwcap4 = ELF_HWCAP4;
+#endif
+
 	retval = bprm_mm_init(bprm);
 	if (!retval)
 		return bprm;
@@ -1775,6 +1786,55 @@ static int bprm_execve(struct linux_binprm *bprm)
 	return retval;
 }
 
+static void inherit_hwcap(struct linux_binprm *bprm)
+{
+	struct mm_struct *mm = current->mm;
+	int i, n;
+
+#ifdef ELF_HWCAP4
+	n = 4;
+#elif defined(ELF_HWCAP3)
+	n = 3;
+#elif defined(ELF_HWCAP2)
+	n = 2;
+#else
+	n = 1;
+#endif
+
+	for (i = 0; n && i < AT_VECTOR_SIZE; i += 2) {
+		unsigned long type = mm->saved_auxv[i];
+		unsigned long val = mm->saved_auxv[i + 1];
+
+		switch (type) {
+		case AT_NULL:
+			goto done;
+		case AT_HWCAP:
+			bprm->hwcap = val & ELF_HWCAP;
+			break;
+#ifdef ELF_HWCAP2
+		case AT_HWCAP2:
+			bprm->hwcap2 = val & ELF_HWCAP2;
+			break;
+#endif
+#ifdef ELF_HWCAP3
+		case AT_HWCAP3:
+			bprm->hwcap3 = val & ELF_HWCAP3;
+			break;
+#endif
+#ifdef ELF_HWCAP4
+		case AT_HWCAP4:
+			bprm->hwcap4 = val & ELF_HWCAP4;
+			break;
+#endif
+		default:
+			continue;
+		}
+		n--;
+	}
+done:
+	mm_flags_set(MMF_USER_HWCAP, bprm->mm);
+}
+
 static int do_execveat_common(int fd, struct filename *filename,
 			      struct user_arg_ptr argv,
 			      struct user_arg_ptr envp,
@@ -1843,6 +1903,9 @@ static int do_execveat_common(int fd, struct filename *filename,
 			     current->comm, bprm->filename);
 	}
 
+	if (mm_flags_test(MMF_USER_HWCAP, current->mm))
+		inherit_hwcap(bprm);
+
 	return bprm_execve(bprm);
 }
 
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index 65abd5ab8836..94a3dcf9b1d2 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_BINFMTS_H
 #define _LINUX_BINFMTS_H
 
+#include <linux/elf.h>
 #include <linux/sched.h>
 #include <linux/unistd.h>
 #include <asm/exec.h>
@@ -67,6 +68,16 @@ struct linux_binprm {
 	unsigned long exec;
 
 	struct rlimit rlim_stack; /* Saved RLIMIT_STACK used during exec. */
+	unsigned long hwcap;
+#ifdef ELF_HWCAP2
+	unsigned long hwcap2;
+#endif
+#ifdef ELF_HWCAP3
+	unsigned long hwcap3;
+#endif
+#ifdef ELF_HWCAP4
+	unsigned long hwcap4;
+#endif
 
 	char buf[BINPRM_BUF_SIZE];
 } __randomize_layout;
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 8731606d8d36..2f3c6ad48c0a 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1918,6 +1918,8 @@ enum {
 #define MMF_TOPDOWN		31	/* mm searches top down by default */
 #define MMF_TOPDOWN_MASK	BIT(MMF_TOPDOWN)
 
+#define MMF_USER_HWCAP		32	/* user-defined HWCAPs */
+
 #define MMF_INIT_LEGACY_MASK	(MMF_DUMPABLE_MASK | MMF_DUMP_FILTER_MASK |\
 				 MMF_DISABLE_THP_MASK | MMF_HAS_MDWE_MASK |\
 				 MMF_VM_MERGE_ANY_MASK | MMF_TOPDOWN_MASK)
diff --git a/kernel/fork.c b/kernel/fork.c
index e832da9d15a4..4c92a2bc3cbb 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1104,6 +1104,9 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 
 		__mm_flags_overwrite_word(mm, mmf_init_legacy_flags(flags));
 		mm->def_flags = current->mm->def_flags & VM_INIT_DEF_MASK;
+
+		if (mm_flags_test(MMF_USER_HWCAP, current->mm))
+			mm_flags_set(MMF_USER_HWCAP, mm);
 	} else {
 		__mm_flags_overwrite_word(mm, default_dump_filter);
 		mm->def_flags = 0;
diff --git a/kernel/sys.c b/kernel/sys.c
index cdbf8513caf6..e4b0fa2f6845 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2157,8 +2157,10 @@ static int prctl_set_mm_map(int opt, const void __user *addr, unsigned long data
 	 * not introduce additional locks here making the kernel
 	 * more complex.
 	 */
-	if (prctl_map.auxv_size)
+	if (prctl_map.auxv_size) {
 		memcpy(mm->saved_auxv, user_auxv, sizeof(user_auxv));
+		mm_flags_set(MMF_USER_HWCAP, mm);
+	}
 
 	mmap_read_unlock(mm);
 	return 0;
@@ -2190,6 +2192,7 @@ static int prctl_set_auxv(struct mm_struct *mm, unsigned long addr,
 
 	task_lock(current);
 	memcpy(mm->saved_auxv, user_auxv, len);
+	mm_flags_set(MMF_USER_HWCAP, mm);
 	task_unlock(current);
 
 	return 0;
-- 
2.53.0.310.g728cabbaf7-goog


