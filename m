Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACBB4DA3DB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Mar 2022 21:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351657AbiCOUT0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Mar 2022 16:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351648AbiCOUTP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Mar 2022 16:19:15 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD541A809;
        Tue, 15 Mar 2022 13:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647375483; x=1678911483;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=YW3ySFVzqcbjT4kVMunyDUmn8ihrxsyZCTKW+tcmodk=;
  b=FiL0y+ZcMUFO5tJVWfRX6DSm5FDKGTWRAfnyL0TSssRVtcwUHwkZSgCg
   YgJ2KWWEMObUIiO6D/U+uRhSykSdTifZATGCyiHP+F/9n88eAYwXHT7l1
   3fmbfZVulgv+zsleNlXW0U8sHhjYz1PoSKVNcTWP8QJ/FVtVLlNgUQpLH
   ZFDe2Sss2pHmmX8IiWHFSknPYrTuGw9ECjHDD08gn8WD0bGesyHLIir7z
   tl3WufwW1LgPIspcReHgG7gVDe62c4Z8G3Eajaf42vaNz36eBgdR9fW14
   LfzOE4530b+8KvAViYsVDlt222XsSYQvsJ/gTPA00NDeiLxw32thYhq3Q
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="319634457"
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="319634457"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 13:18:02 -0700
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="598448319"
Received: from anirudhk-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.212.229.227])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 13:18:01 -0700
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     dave.hansen@intel.com, len.brown@intel.com, tony.luck@intel.com,
        rafael.j.wysocki@intel.com, reinette.chatre@intel.com,
        dan.j.williams@intel.com, viro@zeniv.linux.org.uk,
        ebiederm@xmission.com, keescook@chromium.org
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] x86: Improve formatting of user_regset arrays
Date:   Tue, 15 Mar 2022 13:17:05 -0700
Message-Id: <20220315201706.7576-3-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220315201706.7576-1-rick.p.edgecombe@intel.com>
References: <20220315201706.7576-1-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Back in 2018, Ingo Molnar suggested[0] to improve the formatting of the
struct user_regset arrays. They have multiple member initializations per
line and some lines exceed 100 chars. Reformat them like he suggested.

[0] https://lore.kernel.org/lkml/20180711102035.GB8574@gmail.com/

Suggested-by: Ingo Molnar <mingo@redhat.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/kernel/ptrace.c | 105 ++++++++++++++++++++++++---------------
 1 file changed, 64 insertions(+), 41 deletions(-)

diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index 7a4988d13c43..30355f8d635e 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -1235,28 +1235,37 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 
 static struct user_regset x86_64_regsets[] __ro_after_init = {
 	[REGSET_GENERAL64] = {
-		.core_note_type = NT_PRSTATUS,
-		.n = sizeof(struct user_regs_struct) / sizeof(long),
-		.size = sizeof(long), .align = sizeof(long),
-		.regset_get = genregs_get, .set = genregs_set
+		.core_note_type	= NT_PRSTATUS,
+		.n		= sizeof(struct user_regs_struct) / sizeof(long),
+		.size		= sizeof(long),
+		.align		= sizeof(long),
+		.regset_get	= genregs_get,
+		.set		= genregs_set
 	},
 	[REGSET_FP64] = {
 		.core_note_type = NT_PRFPREG,
-		.n = sizeof(struct fxregs_state) / sizeof(long),
-		.size = sizeof(long), .align = sizeof(long),
-		.active = regset_xregset_fpregs_active, .regset_get = xfpregs_get, .set = xfpregs_set
+		.n		= sizeof(struct fxregs_state) / sizeof(long),
+		.size		= sizeof(long),
+		.align		= sizeof(long),
+		.active		= regset_xregset_fpregs_active,
+		.regset_get	= xfpregs_get,
+		.set		= xfpregs_set
 	},
 	[REGSET_XSTATE64] = {
-		.core_note_type = NT_X86_XSTATE,
-		.size = sizeof(u64), .align = sizeof(u64),
-		.active = xstateregs_active, .regset_get = xstateregs_get,
-		.set = xstateregs_set
+		.core_note_type	= NT_X86_XSTATE,
+		.size		= sizeof(u64),
+		.align		= sizeof(u64),
+		.active		= xstateregs_active,
+		.regset_get	= xstateregs_get,
+		.set		= xstateregs_set
 	},
 	[REGSET_IOPERM64] = {
-		.core_note_type = NT_386_IOPERM,
-		.n = IO_BITMAP_LONGS,
-		.size = sizeof(long), .align = sizeof(long),
-		.active = ioperm_active, .regset_get = ioperm_get
+		.core_note_type	= NT_386_IOPERM,
+		.n		= IO_BITMAP_LONGS,
+		.size		= sizeof(long),
+		.align		= sizeof(long),
+		.active		= ioperm_active,
+		.regset_get	= ioperm_get
 	},
 };
 
@@ -1276,42 +1285,56 @@ static const struct user_regset_view user_x86_64_view = {
 #if defined CONFIG_X86_32 || defined CONFIG_IA32_EMULATION
 static struct user_regset x86_32_regsets[] __ro_after_init = {
 	[REGSET_GENERAL32] = {
-		.core_note_type = NT_PRSTATUS,
-		.n = sizeof(struct user_regs_struct32) / sizeof(u32),
-		.size = sizeof(u32), .align = sizeof(u32),
-		.regset_get = genregs32_get, .set = genregs32_set
+		.core_note_type	= NT_PRSTATUS,
+		.n		= sizeof(struct user_regs_struct32) / sizeof(u32),
+		.size		= sizeof(u32),
+		.align		= sizeof(u32),
+		.regset_get	= genregs32_get,
+		.set		= genregs32_set
 	},
 	[REGSET_FP32] = {
-		.core_note_type = NT_PRFPREG,
-		.n = sizeof(struct user_i387_ia32_struct) / sizeof(u32),
-		.size = sizeof(u32), .align = sizeof(u32),
-		.active = regset_fpregs_active, .regset_get = fpregs_get, .set = fpregs_set
+		.core_note_type	= NT_PRFPREG,
+		.n		= sizeof(struct user_i387_ia32_struct) / sizeof(u32),
+		.size		= sizeof(u32),
+		.align		= sizeof(u32),
+		.active		= regset_fpregs_active,
+		.regset_get	= fpregs_get,
+		.set		= fpregs_set
 	},
 	[REGSET_XFP32] = {
-		.core_note_type = NT_PRXFPREG,
-		.n = sizeof(struct fxregs_state) / sizeof(u32),
-		.size = sizeof(u32), .align = sizeof(u32),
-		.active = regset_xregset_fpregs_active, .regset_get = xfpregs_get, .set = xfpregs_set
+		.core_note_type	= NT_PRXFPREG,
+		.n		= sizeof(struct fxregs_state) / sizeof(u32),
+		.size		= sizeof(u32),
+		.align		= sizeof(u32),
+		.active		= regset_xregset_fpregs_active,
+		.regset_get	= xfpregs_get,
+		.set		= xfpregs_set
 	},
 	[REGSET_XSTATE32] = {
-		.core_note_type = NT_X86_XSTATE,
-		.size = sizeof(u64), .align = sizeof(u64),
-		.active = xstateregs_active, .regset_get = xstateregs_get,
-		.set = xstateregs_set
+		.core_note_type	= NT_X86_XSTATE,
+		.size		= sizeof(u64),
+		.align		= sizeof(u64),
+		.active		= xstateregs_active,
+		.regset_get	= xstateregs_get,
+		.set		= xstateregs_set
 	},
 	[REGSET_TLS32] = {
-		.core_note_type = NT_386_TLS,
-		.n = GDT_ENTRY_TLS_ENTRIES, .bias = GDT_ENTRY_TLS_MIN,
-		.size = sizeof(struct user_desc),
-		.align = sizeof(struct user_desc),
-		.active = regset_tls_active,
-		.regset_get = regset_tls_get, .set = regset_tls_set
+		.core_note_type	= NT_386_TLS,
+		.n		= GDT_ENTRY_TLS_ENTRIES,
+		.bias		= GDT_ENTRY_TLS_MIN,
+		.size		= sizeof(struct user_desc),
+		.align		= sizeof(struct user_desc),
+		.active		= regset_tls_active,
+		.regset_get	= regset_tls_get,
+		.set		= regset_tls_set
 	},
 	[REGSET_IOPERM32] = {
-		.core_note_type = NT_386_IOPERM,
-		.n = IO_BITMAP_BYTES / sizeof(u32),
-		.size = sizeof(u32), .align = sizeof(u32),
-		.active = ioperm_active, .regset_get = ioperm_get
+		.core_note_type	= NT_386_IOPERM,
+		.n		= IO_BITMAP_BYTES / sizeof(u32),
+		.size		= sizeof(u32),
+		.align		= sizeof(u32),
+		.active		= ioperm_active,
+		.regset_get	= ioperm_get
 	},
 };
 
-- 
2.17.1

