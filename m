Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCA5E9A77
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2019 11:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfJ3Kzz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Oct 2019 06:55:55 -0400
Received: from 59-120-53-16.HINET-IP.hinet.net ([59.120.53.16]:53919 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726184AbfJ3Kzz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Oct 2019 06:55:55 -0400
X-Greylist: delayed 354 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Oct 2019 06:55:54 EDT
Received: from ATCSQR.andestech.com (localhost [127.0.0.2] (may be forged))
        by ATCSQR.andestech.com with ESMTP id x9UAWISe061204;
        Wed, 30 Oct 2019 18:32:18 +0800 (GMT-8)
        (envelope-from ruinland@andestech.com)
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id x9UAW5As061184;
        Wed, 30 Oct 2019 18:32:05 +0800 (GMT-8)
        (envelope-from ruinland@andestech.com)
Received: from APC301.andestech.com (10.0.12.139) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Wed, 30 Oct 2019
 18:49:42 +0800
From:   Ruinland Chuan-Tzu Tsai <ruinland@andestech.com>
To:     <viro@zeniv.linux.org.uk>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alankao@andestech.com>, <ruinland@andestech.com>
Subject: [PATCH] elf: Relocate brk elsewhere for static-PIE ELFs.
Date:   Wed, 30 Oct 2019 18:49:27 +0800
Message-ID: <20191030104927.6681-1-ruinland@andestech.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.12.139]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com x9UAW5As061184
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Previous commits (bbdc607, 7be3cb0) move brk to ELF_ET_DYN_BASE to
mitigate collision between heap and stack during ASLR's randomization
procedure. We found the collision to be not limited to heap and stack
nor ASLR enablement.

During the mapping of static-PIE binaries (ET_DYN, no INTERP) e.g.
glibc's ld.so, elf_map() is used with load_bias being zero, which
makes get_unmapped_area() to return an arbitrary unamapped area.

After mapping the static-PIE binary, set_brk() is called to setup
program break.

Then, arch_setup_additional_pages() carries out its duty to initialize
vDSO pages and get_unmapped_area() is invoked with addr being zero
once again - - in some cases (*), this could make it land right next to
the previously mapped static-PIE program and occupy the space for heap.

If we want to avoid this issue, we need to relocate our heap somewhere
else. Regarding the principle of reusing the code, we simply make
brk's relocating happen no matter ASLR is enabled or not.

* This could be reproduced on qemu-system-riscv64 and I observed this
  issue on my riscv32 platform as well.

Signed-off-by: Ruinland Chuan-Tzu Tsai <ruinland@andestech.com>
---
 fs/binfmt_elf.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index d4e11b2e04f6..a49eb1ea2c6b 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1133,18 +1133,19 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	current->mm->end_data = end_data;
 	current->mm->start_stack = bprm->p;
 
-	if ((current->flags & PF_RANDOMIZE) && (randomize_va_space > 1)) {
-		/*
-		 * For architectures with ELF randomization, when executing
-		 * a loader directly (i.e. no interpreter listed in ELF
-		 * headers), move the brk area out of the mmap region
-		 * (since it grows up, and may collide early with the stack
-		 * growing down), and into the unused ELF_ET_DYN_BASE region.
-		 */
-		if (IS_ENABLED(CONFIG_ARCH_HAS_ELF_RANDOMIZE) && !interpreter)
-			current->mm->brk = current->mm->start_brk =
-				ELF_ET_DYN_BASE;
+	/*
+	 * While treating static-PIE, force brk to move to ELF_ET_DYN_BASE
+	 * no matter ASLR is enabled or * not. vDSO may collide with
+	 * heap since both of them call get_unmapped_area() which doesn't
+	 * know about set_brk(), causing vDSO to overlap our heap.
+	 */
 
+	if (loc->elf_ex.e_type == ET_DYN && !interpreter) {
+		current->mm->brk = current->mm->start_brk =
+			PAGE_ALIGN(ELF_ET_DYN_BASE);
+	}
+
+	if ((current->flags & PF_RANDOMIZE) && (randomize_va_space > 1)) {
 		current->mm->brk = current->mm->start_brk =
 			arch_randomize_brk(current->mm);
 #ifdef compat_brk_randomized
-- 
2.17.1

