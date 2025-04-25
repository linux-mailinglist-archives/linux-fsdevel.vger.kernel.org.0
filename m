Return-Path: <linux-fsdevel+bounces-47420-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B808A9D5CE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Apr 2025 00:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9454F4C21E2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 22:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0EF82957CE;
	Fri, 25 Apr 2025 22:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JNPpmPBi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4805B2957B6;
	Fri, 25 Apr 2025 22:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745621111; cv=none; b=N7WTT7BXTpnPxNDcJkgF2Q6xdIwANasda/BIULkvirqRcTkiIRUcABnXs5KfqKhLWQKIctcAvYTHgUKlQwS3TdMgK6CXEfbPBEfszRr623Vr3HYT5W9o6zsaQ8ciAJvK+tGosHe6tAgS0x25O52cpYriR7t6PEaymOLCZ4KFe0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745621111; c=relaxed/simple;
	bh=m1yupztsyxl7cQ4kn1kX9OLaeAaGqeyZCazZnJSh7Sw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MuCRw+2e1eixfUsaF6ThxDkfICUPCoWsnWfbcK1+X1I4Gp5GyR+Sc6Vwi5ErehzDWGJ4xYxYF9xAKNHv0OGYfpO9qi7UHn6IT1UmpOHFOq8zBAG/qt4NQ83T9BDGUM3ggNHo/ebQuwZKCC1zCHQrqAgg3gXqjpEKti0mXXp0K9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JNPpmPBi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A732EC4CEE4;
	Fri, 25 Apr 2025 22:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745621110;
	bh=m1yupztsyxl7cQ4kn1kX9OLaeAaGqeyZCazZnJSh7Sw=;
	h=From:To:Cc:Subject:Date:From;
	b=JNPpmPBitNtn+f5UEYrD0AXc7Y1JyYzO7kUbgoGuf23ddRWjLn5QemhzLtDQgfghF
	 QQwwKYXYCWiLc8Kr5V/QuMRDj/+q1O1lU+ExVlQQCBND+cXjdvnMBv+Qk0oADCnNOz
	 y0omoEiMxsuKUv1yEr1qp/6aL/QLnfcxxyVeZu7OBrDqaBEuPJdirQR5LPF5dZuHGd
	 7zkCE4y8wO2JEWhSruV03CJ/w53TZ6i57BGby0QC5DOGMCzMa1fcOAFc86Kx5Ykei9
	 t7shHKl0MAx53zvNQCIVu53t/CgCihb3I1ak1lPkJFXf9ECj0aqS38T3AqjoeYful2
	 8T6erUcjDFJYQ==
From: Kees Cook <kees@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Kees Cook <kees@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Ali Saidi <alisaidi@amazon.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] binfmt_elf: Move brk for static PIE even if ASLR disabled
Date: Fri, 25 Apr 2025 15:45:06 -0700
Message-Id: <20250425224502.work.520-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8271; i=kees@kernel.org; h=from:subject:message-id; bh=m1yupztsyxl7cQ4kn1kX9OLaeAaGqeyZCazZnJSh7Sw=; b=owGbwMvMwCVmps19z/KJym7G02pJDBk8AoX8CtlHZqZG7zo3I4XhzIFZf72yUp3/TD0a/Er2e +D8w9nMHaUsDGJcDLJiiixBdu5xLh5v28Pd5yrCzGFlAhnCwMUpABPJqmNkWG4wyXB153vzueuW zLnxMSMpsPPS7p4+5/5cJ/GkX5PmtTP8D97fmN3SapG+4XjMv0cXD5+Z+PvuNaEFz/kf/RGZs3x +Ey8A
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

fffff7f20000-fffff7fde000 r-xp 00000000 fe:02 8110426 /home/ubuntu/glibc-2.35/build/elf/ldconfig
fffff7fee000-fffff7ff5000 rw-p 000be000 fe:02 8110426 /home/ubuntu/glibc-2.35/build/elf/ldconfig
fffff7ff5000-fffff7ffa000 rw-p 00000000 00:00 0
***[brk will go here at fffff7ffa000]***
fffff7ffc000-fffff7ffe000 r--p 00000000 00:00 0       [vvar]
fffff7ffe000-fffff8000000 r-xp 00000000 00:00 0       [vdso]
fffffffdf000-1000000000000 rw-p 00000000 00:00 0      [stack]

After commit 0b3bc3354eb9 ("arm64: vdso: Switch to generic storage
implementation"), the arm64 vvar grew slightly, and suddenly the brk
collided with the allocation.

fffff7f20000-fffff7fde000 r-xp 00000000 fe:02 8110426 /home/ubuntu/glibc-2.35/build/elf/ldconfig
fffff7fee000-fffff7ff5000 rw-p 000be000 fe:02 8110426 /home/ubuntu/glibc-2.35/build/elf/ldconfig
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
moving it is (via current->brk_randomized). (Though why isn't this always
just start_brk? More research is needed, but leave that alone for now.)

Reported-by: Ryan Roberts <ryan.roberts@arm.com>
Closes: https://lore.kernel.org/lkml/f93db308-4a0e-4806-9faf-98f890f5a5e6@arm.com/
Fixes: bbdc6076d2e5 ("binfmt_elf: move brk out of mmap when doing direct loader exec")
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: <linux-fsdevel@vger.kernel.org>
Cc: <linux-mm@kvack.org>
---
 fs/binfmt_elf.c | 67 +++++++++++++++++++++++++++++++------------------
 1 file changed, 43 insertions(+), 24 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 584fa89bc877..26c87d076adb 100644
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
@@ -1291,27 +1297,40 @@ static int load_elf_binary(struct linux_binprm *bprm)
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
+	 */
+	if (IS_ENABLED(CONFIG_ARCH_HAS_ELF_RANDOMIZE) &&
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


