Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A607796E7B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Sep 2023 03:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232858AbjIGBSc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 21:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbjIGBSc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 21:18:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8808611B;
        Wed,  6 Sep 2023 18:18:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE0C4C433C7;
        Thu,  7 Sep 2023 01:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694049508;
        bh=BeOcAfqz6CSc1uyYqrlte5iokIu2e62KSauO75vYKJ4=;
        h=From:To:Cc:Subject:Date:From;
        b=cYWTQpyumk7mQ7cEikaoDdx1Jh9PLmDLRqHqicm4G4fLdYqkPTe8pBXH45YwN3Lc2
         AtIVWrbVueM+5SPGOVCfFj9PhyarGhjQfYpLPJZ338+PXgf02TUXbZcjoC2H42LtyY
         LdxiMXyRbP8LsFbyP/QxpALAPKibolLa6q8dAokmKfSy4nV8uO1uX44/E8wpm8J6zQ
         F/oeezDmfqNSqrPt8+lCbRPxPem3h1XVa9afRZvr8lmnEx4wTFkf5D9NG2FZeL61cY
         E5wMXjkBvjqBLOw0BMo/p9yDoe4Fu4mzzSxjNxb+92ULbaLHk1V+g9jd5gNvpbTd9H
         5iKUyzc3J4etw==
From:   Greg Ungerer <gerg@kernel.org>
To:     linux-arm@lists.infradead.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, eescook@chromium.org,
        ebiederm@xmission.com, brauner@kernel.org, viro@zeniv.linux.org.uk,
        Greg Ungerer <gerg@kernel.org>
Subject: [PATCH v2] fs: binfmt_elf_efpic: fix personality for ELF-FDPIC
Date:   Thu,  7 Sep 2023 11:18:08 +1000
Message-Id: <20230907011808.2985083-1-gerg@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The elf-fdpic loader hard sets the process personality to either
PER_LINUX_FDPIC for true elf-fdpic binaries or to PER_LINUX for
normal ELF binaries (in this case they would be constant displacement
compiled with -pie for example). The problem with that is that it
will lose any other bits that may be in the ELF header personality
(such as the "bug emulation" bits).

On the ARM architecture the ADDR_LIMIT_32BIT flag is used to signify
a normal 32bit binary - as opposed to a legacy 26bit address binary.
This matters since start_thread() will set the ARM CPSR register as
required based on this flag. If the elf-fdpic loader loses this bit
the process will be mis-configured and crash out pretty quickly.

Modify elf-fdpic loader personality setting so that it preserves the
upper three bytes by using the SET_PERSONALITY macro to set it. This
macro in the generic case sets PER_LINUX and preserves the upper bytes.
Architectures can override this for their specific use case, and ARM
does exactly this.

The problem shows up quite easily running under qemu using the ARM
architecture, but not necessarily on all types of real ARM hardware.
If the underlying ARM processor does not support the legacy 26-bit
addressing mode then everything will work as expected.

Signed-off-by: Greg Ungerer <gerg@kernel.org>
---
 fs/binfmt_elf_fdpic.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

v2: fixes the elf-fdpic binary case as well

I have done more extensive testing, and in particular on the true
elf-fdpic case. It was broken for that too (as expected).

diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index 43b2a2851ba3..206812ce544a 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -345,10 +345,9 @@ static int load_elf_fdpic_binary(struct linux_binprm *bprm)
 	/* there's now no turning back... the old userspace image is dead,
 	 * defunct, deceased, etc.
 	 */
+	SET_PERSONALITY(exec_params.hdr);
 	if (elf_check_fdpic(&exec_params.hdr))
-		set_personality(PER_LINUX_FDPIC);
-	else
-		set_personality(PER_LINUX);
+		current->personality |= PER_LINUX_FDPIC;
 	if (elf_read_implies_exec(&exec_params.hdr, executable_stack))
 		current->personality |= READ_IMPLIES_EXEC;
 
-- 
2.25.1

