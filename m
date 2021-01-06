Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADB42EBAAB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Jan 2021 08:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbhAFHuD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Jan 2021 02:50:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbhAFHuD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Jan 2021 02:50:03 -0500
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDF9C061359
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 Jan 2021 23:49:22 -0800 (PST)
Received: from ramsan.of.borg ([84.195.186.194])
        by xavier.telenet-ops.be with bizsmtp
        id DKpL2401D4C55Sk01KpLW7; Wed, 06 Jan 2021 08:49:20 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kx3ZI-001Vb6-0o; Wed, 06 Jan 2021 08:49:20 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kx3ZH-006gMf-HS; Wed, 06 Jan 2021 08:49:19 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] binfmt_elf: Fix fill_prstatus() call in fill_note_info()
Date:   Wed,  6 Jan 2021 08:49:17 +0100
Message-Id: <20210106074919.1592772-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On m68k, which does not define CORE_DUMP_USE_REGSET:

    fs/binfmt_elf.c: In function ‘fill_note_info’:
    fs/binfmt_elf.c:2040:20: error: passing argument 1 of ‘fill_prstatus’ from incompatible pointer type [-Werror=incompatible-pointer-types]
     2040 |  fill_prstatus(info->prstatus, current, siginfo->si_signo);
	  |                ~~~~^~~~~~~~~~
	  |                    |
	  |                    struct elf_prstatus *
    fs/binfmt_elf.c:1498:55: note: expected ‘struct elf_prstatus_common *’ but argument is of type ‘struct elf_prstatus *’
     1498 | static void fill_prstatus(struct elf_prstatus_common *prstatus,
	  |                           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~

The fill_prstatus() signature was changed, but one caller was not
updated.

Reported-by: noreply@ellerman.id.au
Fixes: 147d88b334cd5416 ("elf_prstatus: collect the common part (everything before pr_reg) into a struct")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Compile-tested only.  Feel free to fold into the original commit.
---
 fs/binfmt_elf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 1b678aff3bac93eb..4c1550b13899efd7 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -2037,7 +2037,7 @@ static int fill_note_info(struct elfhdr *elf, int phdrs,
 	}
 	/* now collect the dump for the current */
 	memset(info->prstatus, 0, sizeof(*info->prstatus));
-	fill_prstatus(info->prstatus, current, siginfo->si_signo);
+	fill_prstatus(&info->prstatus->common, current, siginfo->si_signo);
 	elf_core_copy_regs(&info->prstatus->pr_reg, regs);
 
 	/* Set up header */
-- 
2.25.1

