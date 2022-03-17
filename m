Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D697B4DCEB3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Mar 2022 20:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237960AbiCQTWM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Mar 2022 15:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233990AbiCQTWK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Mar 2022 15:22:10 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5735021A8B2;
        Thu, 17 Mar 2022 12:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647544853; x=1679080853;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P4VQ7x77pzhKc7Ls0LPr32z9bXqOTx2XsGy3L1O0etg=;
  b=FJvLOQ/8YK+qNf10IXjcIGmNbEJbdRxC/BcwrQdRiz6J3WjsBar19rFW
   61ndYb5+YUpvRBWeK9wds2NnF30vlLzw1R3+2aS/ga+MlG5I1vUYzgph9
   bOIKpB5z0Wj6G9H4B244JYo9d492W1IP2z02mICIQK8dDyN+9tF006lXf
   dS4Mlkqf2t47Eo3ZO6ATQiVCb0w3ABmdGldxKCu/hcEvZfLn0qUwE3YvQ
   N+fOzXyfOh6qwuSe3LKkelfGY7+wb0R5gmWOaS0/VcxFpalEi7ueTmIjU
   rZgaj8lxq54xwlF8ZcMsfFo5wThxf+wKyPIADJd2dSwIoj3L9qi+SVH41
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="257150093"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="257150093"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 12:20:52 -0700
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="691054853"
Received: from awyatt-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.212.178.193])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 12:20:51 -0700
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     dave.hansen@intel.com, len.brown@intel.com, tony.luck@intel.com,
        rafael.j.wysocki@intel.com, reinette.chatre@intel.com,
        dan.j.williams@intel.com, viro@zeniv.linux.org.uk,
        ebiederm@xmission.com, keescook@chromium.org
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] x86: Separate out x86_regset for 32 and 64 bit
Date:   Thu, 17 Mar 2022 12:20:11 -0700
Message-Id: <20220317192013.13655-2-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220317192013.13655-1-rick.p.edgecombe@intel.com>
References: <20220317192013.13655-1-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In ptrace, the x86_32_regsets and x86_64_regsets are constructed such that
there are no gaps in the arrays. This appears to be for two reasons. One,
the code in fill_thread_core_info() can't handle the gaps. This will be
addressed in a future patch. And two, not having gaps shrinks the size of
the array in memory.

Both regset arrays draw their indices from a shared enum x86_regset, but 32
bit and 64 bit don't all support the same regsets. In the case of
IA32_EMULATION they can be compiled in at the same time. So this enum has
to be laid out in a special way such that there are no gaps for both
x86_32_regsets and x86_64_regsets. This involves creating aliases for
enum’s that are only in one view or the other, or creating multiple
versions like in the case of REGSET_IOPERM32/REGSET_IOPERM64.

Simplify the construction of these arrays by just fully separating out the
enums for 32 bit and 64 bit. Add some bitsize-free defines for
REGSET_GENERAL and REGSET_FP since they are the only two referred to in
bitsize generic code. Also, change the name pattern to be like
REGSET32_FOO, instead of REGSET_FOO32, to better emphasize that the bit
size is the bitsize of the architecture, not the register itself.

This should have no functional change and is only changing how constants
are generated and named. The enum is local to this file, so it does not
introduce any burden on code calling from other places in the kernel now
having to worry about whether to use a 32 bit or 64 bit enum name.

[1] https://lore.kernel.org/lkml/20180717162502.32274-1-yu-cheng.yu@intel.com/

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Acked-by: Kees Cook <keescook@chromium.org>

---

v2:
 - Rename REGSET_FOO32 to REGSET32_FOO (Eric Biederman)
 - Drop Kees' Reviewed-by to Acked-by, due to changing enum value names
 
 arch/x86/kernel/ptrace.c | 66 +++++++++++++++++++++++++---------------
 1 file changed, 42 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index 8d2f2f995539..c6a4a4d0d804 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -45,16 +45,34 @@
 
 #include "tls.h"
 
-enum x86_regset {
-	REGSET_GENERAL,
-	REGSET_FP,
-	REGSET_XFP,
-	REGSET_IOPERM64 = REGSET_XFP,
-	REGSET_XSTATE,
-	REGSET_TLS,
-	REGSET_IOPERM32,
+enum x86_regset_32 {
+	REGSET32_GENERAL,
+	REGSET32_FP,
+	REGSET32_XFP,
+	REGSET32_XSTATE,
+	REGSET32_TLS,
+	REGSET32_IOPERM,
 };
 
+enum x86_regset_64 {
+	REGSET64_GENERAL,
+	REGSET64_FP,
+	REGSET64_IOPERM,
+	REGSET64_XSTATE,
+};
+
+#define REGSET_GENERAL \
+({ \
+	BUILD_BUG_ON((int)REGSET32_GENERAL != (int)REGSET64_GENERAL); \
+	REGSET32_GENERAL; \
+})
+
+#define REGSET_FP \
+({ \
+	BUILD_BUG_ON((int)REGSET32_FP != (int)REGSET64_FP); \
+	REGSET32_FP; \
+})
+
 struct pt_regs_offset {
 	const char *name;
 	int offset;
@@ -789,13 +807,13 @@ long arch_ptrace(struct task_struct *child, long request,
 #ifdef CONFIG_X86_32
 	case PTRACE_GETFPXREGS:	/* Get the child extended FPU state. */
 		return copy_regset_to_user(child, &user_x86_32_view,
-					   REGSET_XFP,
+					   REGSET32_XFP,
 					   0, sizeof(struct user_fxsr_struct),
 					   datap) ? -EIO : 0;
 
 	case PTRACE_SETFPXREGS:	/* Set the child extended FPU state. */
 		return copy_regset_from_user(child, &user_x86_32_view,
-					     REGSET_XFP,
+					     REGSET32_XFP,
 					     0, sizeof(struct user_fxsr_struct),
 					     datap) ? -EIO : 0;
 #endif
@@ -1087,13 +1105,13 @@ static long ia32_arch_ptrace(struct task_struct *child, compat_long_t request,
 
 	case PTRACE_GETFPXREGS:	/* Get the child extended FPU state. */
 		return copy_regset_to_user(child, &user_x86_32_view,
-					   REGSET_XFP, 0,
+					   REGSET32_XFP, 0,
 					   sizeof(struct user32_fxsr_struct),
 					   datap);
 
 	case PTRACE_SETFPXREGS:	/* Set the child extended FPU state. */
 		return copy_regset_from_user(child, &user_x86_32_view,
-					     REGSET_XFP, 0,
+					     REGSET32_XFP, 0,
 					     sizeof(struct user32_fxsr_struct),
 					     datap);
 
@@ -1216,25 +1234,25 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 #ifdef CONFIG_X86_64
 
 static struct user_regset x86_64_regsets[] __ro_after_init = {
-	[REGSET_GENERAL] = {
+	[REGSET64_GENERAL] = {
 		.core_note_type = NT_PRSTATUS,
 		.n = sizeof(struct user_regs_struct) / sizeof(long),
 		.size = sizeof(long), .align = sizeof(long),
 		.regset_get = genregs_get, .set = genregs_set
 	},
-	[REGSET_FP] = {
+	[REGSET64_FP] = {
 		.core_note_type = NT_PRFPREG,
 		.n = sizeof(struct fxregs_state) / sizeof(long),
 		.size = sizeof(long), .align = sizeof(long),
 		.active = regset_xregset_fpregs_active, .regset_get = xfpregs_get, .set = xfpregs_set
 	},
-	[REGSET_XSTATE] = {
+	[REGSET64_XSTATE] = {
 		.core_note_type = NT_X86_XSTATE,
 		.size = sizeof(u64), .align = sizeof(u64),
 		.active = xstateregs_active, .regset_get = xstateregs_get,
 		.set = xstateregs_set
 	},
-	[REGSET_IOPERM64] = {
+	[REGSET64_IOPERM] = {
 		.core_note_type = NT_386_IOPERM,
 		.n = IO_BITMAP_LONGS,
 		.size = sizeof(long), .align = sizeof(long),
@@ -1257,31 +1275,31 @@ static const struct user_regset_view user_x86_64_view = {
 
 #if defined CONFIG_X86_32 || defined CONFIG_IA32_EMULATION
 static struct user_regset x86_32_regsets[] __ro_after_init = {
-	[REGSET_GENERAL] = {
+	[REGSET32_GENERAL] = {
 		.core_note_type = NT_PRSTATUS,
 		.n = sizeof(struct user_regs_struct32) / sizeof(u32),
 		.size = sizeof(u32), .align = sizeof(u32),
 		.regset_get = genregs32_get, .set = genregs32_set
 	},
-	[REGSET_FP] = {
+	[REGSET32_FP] = {
 		.core_note_type = NT_PRFPREG,
 		.n = sizeof(struct user_i387_ia32_struct) / sizeof(u32),
 		.size = sizeof(u32), .align = sizeof(u32),
 		.active = regset_fpregs_active, .regset_get = fpregs_get, .set = fpregs_set
 	},
-	[REGSET_XFP] = {
+	[REGSET32_XFP] = {
 		.core_note_type = NT_PRXFPREG,
 		.n = sizeof(struct fxregs_state) / sizeof(u32),
 		.size = sizeof(u32), .align = sizeof(u32),
 		.active = regset_xregset_fpregs_active, .regset_get = xfpregs_get, .set = xfpregs_set
 	},
-	[REGSET_XSTATE] = {
+	[REGSET32_XSTATE] = {
 		.core_note_type = NT_X86_XSTATE,
 		.size = sizeof(u64), .align = sizeof(u64),
 		.active = xstateregs_active, .regset_get = xstateregs_get,
 		.set = xstateregs_set
 	},
-	[REGSET_TLS] = {
+	[REGSET32_TLS] = {
 		.core_note_type = NT_386_TLS,
 		.n = GDT_ENTRY_TLS_ENTRIES, .bias = GDT_ENTRY_TLS_MIN,
 		.size = sizeof(struct user_desc),
@@ -1289,7 +1307,7 @@ static struct user_regset x86_32_regsets[] __ro_after_init = {
 		.active = regset_tls_active,
 		.regset_get = regset_tls_get, .set = regset_tls_set
 	},
-	[REGSET_IOPERM32] = {
+	[REGSET32_IOPERM] = {
 		.core_note_type = NT_386_IOPERM,
 		.n = IO_BITMAP_BYTES / sizeof(u32),
 		.size = sizeof(u32), .align = sizeof(u32),
@@ -1312,10 +1330,10 @@ u64 xstate_fx_sw_bytes[USER_XSTATE_FX_SW_WORDS];
 void __init update_regset_xstate_info(unsigned int size, u64 xstate_mask)
 {
 #ifdef CONFIG_X86_64
-	x86_64_regsets[REGSET_XSTATE].n = size / sizeof(u64);
+	x86_64_regsets[REGSET64_XSTATE].n = size / sizeof(u64);
 #endif
 #if defined CONFIG_X86_32 || defined CONFIG_IA32_EMULATION
-	x86_32_regsets[REGSET_XSTATE].n = size / sizeof(u64);
+	x86_32_regsets[REGSET32_XSTATE].n = size / sizeof(u64);
 #endif
 	xstate_fx_sw_bytes[USER_XSTATE_XCR0_WORD] = xstate_mask;
 }
-- 
2.17.1

