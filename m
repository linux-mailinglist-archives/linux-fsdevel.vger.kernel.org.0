Return-Path: <linux-fsdevel+bounces-47881-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A63AA67C7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 02:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 460A31743F4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 00:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA277101F2;
	Fri,  2 May 2025 00:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D36+Rf/p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B448BFF;
	Fri,  2 May 2025 00:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746145116; cv=none; b=XH3ON2YeWMnteK6bC+dz8UCdglsEcTcWu8QDzLzfwQx3JmM7lnuLwPc1fIQr9/mULmyUKcMTLTdtDZrYwLuN4vj/7jZYU2uusW0CZcbclS0V4Fm+/5tJJfP0CINvvNvoytdOfXYElI9yqmhMA4wWmKr76EdL94RoQ3Z8IdMEbw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746145116; c=relaxed/simple;
	bh=C1agfbcIGH8c1uh09yOH+nZbFwUQt1cpEcDGVH3eqos=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qA3r9VHOxgBM2kEjAJrR1Zygx8Wd6gJhDNoYUBWeHQBvrymnE2+O/N+oAqVFNcZWZfA3ADqGCii/+vS/3eAAdb9lZKF+qfopdrq8v/Fk1gDmydGNVh3odAXbC8Zd18UvEevQdEoVYf4cVU8j0kTYjjktAnSV5cLwUssC7td/jNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D36+Rf/p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93CAFC4CEE3;
	Fri,  2 May 2025 00:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746145115;
	bh=C1agfbcIGH8c1uh09yOH+nZbFwUQt1cpEcDGVH3eqos=;
	h=From:To:Cc:Subject:Date:From;
	b=D36+Rf/psYYwTgOj8fUim3S4V3YyPczfLzidVL40KjqQ4nmeAiuUOCKYl7Svb4Fgj
	 D2QeDrgQMFpNeW5Qn2QcVfM0IDpasU6+AXDm56S7QGGWxWNw0V0oXAgU3bOQj+bqzk
	 48x1NafYFa9+1QUfzMdazRIsKESTjIaZOy5jlWJ5JTQbfZQeKCWxJ54m00KgfOIKKS
	 zZ1P9V8n1qlL58IRDFKnH1ftbRA5TJAvJU/Ly6Irf7uSX2NER0c9frnTuHW6v67a6s
	 MyCXeHfp9VAQLO/VzTRvrjpOXrBV7wTqwndUMomS5tHRgxqmX0t+YldCO0IabwEqjd
	 T7Zj6ojknTQ1g==
From: Kees Cook <kees@kernel.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Kees Cook <kees@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Ali Saidi <alisaidi@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2] binfmt_elf: Move brk for static PIE even if ASLR disabled
Date: Thu,  1 May 2025 17:18:23 -0700
Message-Id: <20250502001820.it.026-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8400; i=kees@kernel.org; h=from:subject:message-id; bh=C1agfbcIGH8c1uh09yOH+nZbFwUQt1cpEcDGVH3eqos=; b=owGbwMvMwCVmps19z/KJym7G02pJDBki/P7y23Xyu+OZ+4UtFjw74RDwUkH8tcjE4/wVs/9Ht 3jurkzuKGVhEONikBVTZAmyc49z8XjbHu4+VxFmDisTyBAGLk4BmMjb5Qz/g8PuzBDRL77NUNXL esI2uKnugpmTx6f38opfl4m17Jt6hJHhwaHf+wLWqH/QFG+7fkr6s4a2iKD37/bHpzfurxMQvFj PDQA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In commit bbdc6076d2e5 ("binfmt_elf: move brk out of mmap when doing
direct loader exec"), the brk was moved out of the mmap region when
loading static PIE binaries (ET_DYN without INTERP). The common case
for these binaries was testing new ELF loaders, so the brk needed to
be away from mmap to avoid colliding with stack, future mmaps (of the
loader-loaded binary), etc. But this was only done when ASLR was enabled,
in an attempt to minimize changes to memory layouts.

After adding support to respect alignment requirements for static PIE
binaries in commit 3545deff0ec7 ("binfmt_elf: Honor PT_LOAD alignment
for static PIE"), it became possible to have a large gap after the
final PT_LOAD segment and the top of the mmap region. This means that
future mmap allocations might go after the last PT_LOAD segment (where
brk might be if ASLR was disabled) instead of before them (where they
traditionally ended up).

On arm64, running with ASLR disabled, Ubuntu 22.04's "ldconfig" binary,
a static PIE, has alignment requirements that leaves a gap large enough
after the last PT_LOAD segment to fit the vdso and vvar, but still leave
enough space for the brk (which immediately follows the last PT_LOAD
segment) to be allocated by the binary.

fffff7f20000-fffff7fde000 r-xp 00000000 fe:02 8110426 /sbin/ldconfig.real
fffff7fee000-fffff7ff5000 rw-p 000be000 fe:02 8110426 /sbin/ldconfig.real
fffff7ff5000-fffff7ffa000 rw-p 00000000 00:00 0
***[brk will go here at fffff7ffa000]***
fffff7ffc000-fffff7ffe000 r--p 00000000 00:00 0       [vvar]
fffff7ffe000-fffff8000000 r-xp 00000000 00:00 0       [vdso]
fffffffdf000-1000000000000 rw-p 00000000 00:00 0      [stack]

After commit 0b3bc3354eb9 ("arm64: vdso: Switch to generic storage
implementation"), the arm64 vvar grew slightly, and suddenly the brk
collided with the allocation.

fffff7f20000-fffff7fde000 r-xp 00000000 fe:02 8110426 /sbin/ldconfig.real
fffff7fee000-fffff7ff5000 rw-p 000be000 fe:02 8110426 /sbin/ldconfig.real
fffff7ff5000-fffff7ffa000 rw-p 00000000 00:00 0
***[oops, no room any more, vvar is at fffff7ffa000!]***
fffff7ffa000-fffff7ffe000 r--p 00000000 00:00 0       [vvar]
fffff7ffe000-fffff8000000 r-xp 00000000 00:00 0       [vdso]
fffffffdf000-1000000000000 rw-p 00000000 00:00 0      [stack]

The solution is to unconditionally move the brk out of the mmap region
for static PIE binaries. Whether ASLR is enabled or not does not change if
there may be future mmap allocation collisions with a growing brk region.

Update memory layout comments (with kernel-doc headings), consolidate
the setting of mm->brk to later (it isn't needed early), move static PIE
brk out of mmap unconditionally, and make sure brk(2) knows to base brk
position off of mm->start_brk not mm->end_data no matter what the cause of
moving it is (via current->brk_randomized).

For the CONFIG_COMPAT_BRK case, though, leave the logic unchanged, as we
can never safely move the brk. These systems, however, are not using
specially aligned static PIE binaries.

Reported-by: Ryan Roberts <ryan.roberts@arm.com>
Closes: https://lore.kernel.org/lkml/f93db308-4a0e-4806-9faf-98f890f5a5e6@arm.com/
Fixes: bbdc6076d2e5 ("binfmt_elf: move brk out of mmap when doing direct loader exec")
Link: https://lore.kernel.org/r/20250425224502.work.520-kees@kernel.org
Signed-off-by: Kees Cook <kees@kernel.org>
---
 v2: exclude CONFIG_COMPAT_BRK (ryan)
 v1: https://lore.kernel.org/all/20250425224502.work.520-kees@kernel.org/
---
 fs/binfmt_elf.c | 71 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 47 insertions(+), 24 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 584fa89bc877..4c1ea6b52a53 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -830,6 +830,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	struct elf_phdr *elf_ppnt, *elf_phdata, *interp_elf_phdata = NULL;
 	struct elf_phdr *elf_property_phdata = NULL;
 	unsigned long elf_brk;
+	bool brk_moved = false;
 	int retval, i;
 	unsigned long elf_entry;
 	unsigned long e_entry;
@@ -1097,15 +1098,19 @@ static int load_elf_binary(struct linux_binprm *bprm)
 			/* Calculate any requested alignment. */
 			alignment = maximum_alignment(elf_phdata, elf_ex->e_phnum);
 
-			/*
-			 * There are effectively two types of ET_DYN
-			 * binaries: programs (i.e. PIE: ET_DYN with PT_INTERP)
-			 * and loaders (ET_DYN without PT_INTERP, since they
-			 * _are_ the ELF interpreter). The loaders must
-			 * be loaded away from programs since the program
-			 * may otherwise collide with the loader (especially
-			 * for ET_EXEC which does not have a randomized
-			 * position). For example to handle invocations of
+			/**
+			 * DOC: PIE handling
+			 *
+			 * There are effectively two types of ET_DYN ELF
+			 * binaries: programs (i.e. PIE: ET_DYN with
+			 * PT_INTERP) and loaders (i.e. static PIE: ET_DYN
+			 * without PT_INTERP, usually the ELF interpreter
+			 * itself). Loaders must be loaded away from programs
+			 * since the program may otherwise collide with the
+			 * loader (especially for ET_EXEC which does not have
+			 * a randomized position).
+			 *
+			 * For example, to handle invocations of
 			 * "./ld.so someprog" to test out a new version of
 			 * the loader, the subsequent program that the
 			 * loader loads must avoid the loader itself, so
@@ -1118,6 +1123,9 @@ static int load_elf_binary(struct linux_binprm *bprm)
 			 * ELF_ET_DYN_BASE and loaders are loaded into the
 			 * independently randomized mmap region (0 load_bias
 			 * without MAP_FIXED nor MAP_FIXED_NOREPLACE).
+			 *
+			 * See below for "brk" handling details, which is
+			 * also affected by program vs loader and ASLR.
 			 */
 			if (interpreter) {
 				/* On ET_DYN with PT_INTERP, we do the ASLR. */
@@ -1234,8 +1242,6 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	start_data += load_bias;
 	end_data += load_bias;
 
-	current->mm->start_brk = current->mm->brk = ELF_PAGEALIGN(elf_brk);
-
 	if (interpreter) {
 		elf_entry = load_elf_interp(interp_elf_ex,
 					    interpreter,
@@ -1291,27 +1297,44 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	mm->end_data = end_data;
 	mm->start_stack = bprm->p;
 
-	if ((current->flags & PF_RANDOMIZE) && (snapshot_randomize_va_space > 1)) {
+	/**
+	 * DOC: "brk" handling
+	 *
+	 * For architectures with ELF randomization, when executing a
+	 * loader directly (i.e. static PIE: ET_DYN without PT_INTERP),
+	 * move the brk area out of the mmap region and into the unused
+	 * ELF_ET_DYN_BASE region. Since "brk" grows up it may collide
+	 * early with the stack growing down or other regions being put
+	 * into the mmap region by the kernel (e.g. vdso).
+	 *
+	 * In the CONFIG_COMPAT_BRK case, though, everything is turned
+	 * off because we're not allowed to move the brk at all.
+	 */
+	if (!IS_ENABLED(CONFIG_COMPAT_BRK) &&
+	    IS_ENABLED(CONFIG_ARCH_HAS_ELF_RANDOMIZE) &&
+	    elf_ex->e_type == ET_DYN && !interpreter) {
+		elf_brk = ELF_ET_DYN_BASE;
+		/* This counts as moving the brk, so let brk(2) know. */
+		brk_moved = true;
+	}
+	mm->start_brk = mm->brk = ELF_PAGEALIGN(elf_brk);
+
+	if ((current->flags & PF_RANDOMIZE) && snapshot_randomize_va_space > 1) {
 		/*
-		 * For architectures with ELF randomization, when executing
-		 * a loader directly (i.e. no interpreter listed in ELF
-		 * headers), move the brk area out of the mmap region
-		 * (since it grows up, and may collide early with the stack
-		 * growing down), and into the unused ELF_ET_DYN_BASE region.
+		 * If we didn't move the brk to ELF_ET_DYN_BASE (above),
+		 * leave a gap between .bss and brk.
 		 */
-		if (IS_ENABLED(CONFIG_ARCH_HAS_ELF_RANDOMIZE) &&
-		    elf_ex->e_type == ET_DYN && !interpreter) {
-			mm->brk = mm->start_brk = ELF_ET_DYN_BASE;
-		} else {
-			/* Otherwise leave a gap between .bss and brk. */
+		if (!brk_moved)
 			mm->brk = mm->start_brk = mm->brk + PAGE_SIZE;
-		}
 
 		mm->brk = mm->start_brk = arch_randomize_brk(mm);
+		brk_moved = true;
+	}
+
 #ifdef compat_brk_randomized
+	if (brk_moved)
 		current->brk_randomized = 1;
 #endif
-	}
 
 	if (current->personality & MMAP_PAGE_ZERO) {
 		/* Why this, you ask???  Well SVr4 maps page 0 as read-only,
-- 
2.34.1


