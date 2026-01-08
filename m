Return-Path: <linux-fsdevel+bounces-72713-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C19D010A3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 06:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C63D3053BD6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 05:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795032D5932;
	Thu,  8 Jan 2026 05:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RlY9pZDX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f74.google.com (mail-oo1-f74.google.com [209.85.161.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A20A2D481F
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jan 2026 05:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767848877; cv=none; b=PAfM2J5pFQQbiifIoCp5KXe2FAsNn1XGTyHuN/bBI+4VYuZxfXjlVlX7+1hwbUfRMdJCfkNMKi5as1DzX8ZozKe9rfEso6b9tjOIat/Udrov76969doTHTSITWz9DgNWl6VvLiPOP1bg7jcGgjEgREzbumIkATpIiDfd5kXigKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767848877; c=relaxed/simple;
	bh=xai/ZZ4nWO9LhAkDeI2fOyW7f7WEasHJs/SoRQMaWes=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kUvmz6AP6y3esuWKN9k0g6UxCEiUaBHps7xNQr+RzsgQkFSL9c25/RbtN3Ijz4NI2gLUmYrvQ4NkWWQ5p6u0iKKRbehM0cYCQxio8oLiwGiugAmW48jiZKL6pKnmm3wzGp/496k89+dMY9O8lDZuNRIZwccVGJrccIW9fdNEAs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RlY9pZDX; arc=none smtp.client-ip=209.85.161.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com
Received: by mail-oo1-f74.google.com with SMTP id 006d021491bc7-65ec1bb9db9so5272140eaf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jan 2026 21:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767848874; x=1768453674; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BM9pkeWkyDkeF/wsVeQk1KlrHlvWtFk07wiFD8D6vLQ=;
        b=RlY9pZDXvzwns8EbV7ZhOPRjVFVpH22XtqzAkijfpHua8bCTdNViBvqKmllmmWHrb9
         mTEjw/pXEadX5qdXTTsWd2pu3husLDhxyswXClFhLMfb7ARa53ui7/xTIgVtY9Rh1u8K
         Z9D+aYa9fo+br7nKb/M12qZtRqGfQnn0ibwKcmniNfJANONE7etvIa9iMrudqAWetFDA
         THePIGADn6fQKLhIpNusYYkAEog6Rp2x+Aj7DglquZOV9m6g++v6VGLvcQOBT0XbqrZZ
         3EwcspBcUwRg4IMSvyldLWdZ0mnAMQBRZPdQaqLum0lhYSb2fI1j9d4c0Rx5qy4t8Z/T
         L33Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767848874; x=1768453674;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BM9pkeWkyDkeF/wsVeQk1KlrHlvWtFk07wiFD8D6vLQ=;
        b=rnANj12NP5x8/0PHw7eZhsUjR8RyFMvvQ153VRNCaxp4HTQ3UT0ogastlsHx7cPicA
         2C1lS+kdF/JgM5D39NjyDhxAPz86Fhdv33I+gEO+xXK/9XucrO7KcS11ilpYOjJLb6xi
         QUz8J/FTmjwsrMIMcMGQtoC0/AkCufhQRywUnln0zfpNVTE54sScw1l9gTSxIe7Q598D
         g/kRZPwZ6oLq2HtwwyN4NwB1x0Ocu7mUN0T05wCpHQ8nkF74s6r9j5NZYAzB2K51AOpo
         FKYJF86gQSquC1Nb7LGjUGSW/cFB0MiPOwBDtcGYImTM7LnPW9vaAQtgUgwQwotMYWcf
         uDEA==
X-Forwarded-Encrypted: i=1; AJvYcCXnb63DIF4cuqlqkzHqXSApGWaOgQsGSucPiuCU3/QC9W1DuPRR/tmkCtl/+iJlXtK6qrJlNXf9XZajrD8N@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2vD8pWEQQ2v3k1Yz6Pq2EyoUyJw3fqQgbIDPd6rGxvQu3vHP3
	qe4vaK/fCHOYVTu2NSlmpKop1ZQ+lPVFXs2WzPqqYC1puNjLCEpL3LRUEAGKjcAxJP3voDG+TCJ
	HfQSaXQ==
X-Google-Smtp-Source: AGHT+IHignbPdIC8t4fB2nIzu96Ku0xOznzgAT1ynazkafzO6fVYBLy8OffFhZPxxjW0YPmoKPVOk64VQHI=
X-Received: from iobjk24.prod.google.com ([2002:a05:6602:7218:b0:954:95ac:e0cc])
 (user=avagin job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6820:228f:b0:659:9a49:8f93
 with SMTP id 006d021491bc7-65f54eea37dmr2056872eaf.12.1767848874105; Wed, 07
 Jan 2026 21:07:54 -0800 (PST)
Date: Thu,  8 Jan 2026 05:07:47 +0000
In-Reply-To: <20260108050748.520792-1-avagin@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260108050748.520792-1-avagin@google.com>
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Message-ID: <20260108050748.520792-3-avagin@google.com>
Subject: [PATCH 2/3] exec: inherit HWCAPs from the parent process
From: Andrei Vagin <avagin@google.com>
To: Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, criu@lists.linux.dev, 
	Andrew Morton <akpm@linux-foundation.org>, Chen Ridong <chenridong@huawei.com>, 
	Christian Brauner <brauner@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Eric Biederman <ebiederm@xmission.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Michal Koutny <mkoutny@suse.com>, Andrei Vagin <avagin@google.com>
Content-Type: text/plain; charset="UTF-8"

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

Signed-off-by: Andrei Vagin <avagin@google.com>
---
 fs/binfmt_elf.c          |  8 +++---
 fs/binfmt_elf_fdpic.c    |  8 +++---
 fs/exec.c                | 58 ++++++++++++++++++++++++++++++++++++++++
 include/linux/binfmts.h  | 11 ++++++++
 include/linux/mm_types.h |  2 ++
 kernel/fork.c            |  3 +++
 kernel/sys.c             |  5 +++-
 7 files changed, 86 insertions(+), 9 deletions(-)

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
index 9d5ebc9d15b0..94382285eeda 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1462,6 +1462,17 @@ static struct linux_binprm *alloc_bprm(int fd, struct filename *filename, int fl
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
@@ -1780,6 +1791,50 @@ static int bprm_execve(struct linux_binprm *bprm)
 	return retval;
 }
 
+static void inherit_hwcap(struct linux_binprm *bprm)
+{
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
+		long val = current->mm->saved_auxv[i + 1];
+
+		switch (current->mm->saved_auxv[i]) {
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
+	mm_flags_set(MMF_USER_HWCAP, bprm->mm);
+}
+
 static int do_execveat_common(int fd, struct filename *filename,
 			      struct user_arg_ptr argv,
 			      struct user_arg_ptr envp,
@@ -1856,6 +1911,9 @@ static int do_execveat_common(int fd, struct filename *filename,
 			     current->comm, bprm->filename);
 	}
 
+	if (mm_flags_test(MMF_USER_HWCAP, current->mm))
+		inherit_hwcap(bprm);
+
 	retval = bprm_execve(bprm);
 out_free:
 	free_bprm(bprm);
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
index 42af2292951d..93e7aa929fda 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1862,6 +1862,8 @@ enum {
 #define MMF_TOPDOWN		31	/* mm searches top down by default */
 #define MMF_TOPDOWN_MASK	BIT(MMF_TOPDOWN)
 
+#define MMF_USER_HWCAP		32	/* user-defined HWCAPs */
+
 #define MMF_INIT_LEGACY_MASK	(MMF_DUMPABLE_MASK | MMF_DUMP_FILTER_MASK |\
 				 MMF_DISABLE_THP_MASK | MMF_HAS_MDWE_MASK |\
 				 MMF_VM_MERGE_ANY_MASK | MMF_TOPDOWN_MASK)
diff --git a/kernel/fork.c b/kernel/fork.c
index b1f3915d5f8e..0091315643de 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1103,6 +1103,9 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 
 		__mm_flags_overwrite_word(mm, mmf_init_legacy_flags(flags));
 		mm->def_flags = current->mm->def_flags & VM_INIT_DEF_MASK;
+
+		if (mm_flags_test(MMF_USER_HWCAP, current->mm))
+			mm_flags_set(MMF_USER_HWCAP, mm);
 	} else {
 		__mm_flags_overwrite_word(mm, default_dump_filter);
 		mm->def_flags = 0;
diff --git a/kernel/sys.c b/kernel/sys.c
index 8d199cf457ae..83283001abfb 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2157,8 +2157,10 @@ static int prctl_set_mm_map(int opt, const void __user *addr, unsigned long data
 	 * not introduce additional locks here making the kernel
 	 * more complex.
 	 */
-	if (prctl_map.auxv_size)
+	if (prctl_map.auxv_size) {
 		memcpy(mm->saved_auxv, user_auxv, sizeof(user_auxv));
+		mm_flags_set(MMF_USER_HWCAP, current->mm);
+	}
 
 	mmap_read_unlock(mm);
 	return 0;
@@ -2191,6 +2193,7 @@ static int prctl_set_auxv(struct mm_struct *mm, unsigned long addr,
 	task_lock(current);
 	memcpy(mm->saved_auxv, user_auxv, len);
 	task_unlock(current);
+	mm_flags_set(MMF_USER_HWCAP, current->mm);
 
 	return 0;
 }
-- 
2.52.0.351.gbe84eed79e-goog


