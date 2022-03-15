Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83BC14DA3DA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Mar 2022 21:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351651AbiCOUT2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Mar 2022 16:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351647AbiCOUTP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Mar 2022 16:19:15 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64F61A3BF;
        Tue, 15 Mar 2022 13:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647375482; x=1678911482;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DESpJfUMGi9jfI12D+F/BGPyFyL1JuFW4J8huG6CJOU=;
  b=i6UcWOCxrA6APPGKjiOuMP4IERtOzju/W7UAYEnIB6+x9uFcLkE0MvKC
   kAsBBiNCTnZ/Re7a9n57xRWQ6JsAqQRLNMnLAKv7fpOM+zXOxim3QMOpc
   Q01kiaq2Qn6LR0pQGX/QhekpYuzaFutMNzFwbwCh3KYxsBxK4KPbkzlAn
   hoo9vt0jCNvMNMdbQPyt4rPEvHO0ZkduNe7Rjjl3EmUnj3elrAols1baK
   Z/JbiDqroQF0genqzRohBPjn1yAp/NRJGI+GfCqNI9fQ0z4wc33mCMKq9
   8B3iO+/fEI/1CRV7Ss2/c4iRA8zGgeTqAw48zoiVd22GwRPWvbO2A1psk
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="319634453"
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="319634453"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 13:18:01 -0700
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="598448307"
Received: from anirudhk-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.212.229.227])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 13:18:01 -0700
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     dave.hansen@intel.com, len.brown@intel.com, tony.luck@intel.com,
        rafael.j.wysocki@intel.com, reinette.chatre@intel.com,
        dan.j.williams@intel.com, viro@zeniv.linux.org.uk,
        ebiederm@xmission.com, keescook@chromium.org
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] x86: Separate out x86_regset for 32 and 64 bit
Date:   Tue, 15 Mar 2022 13:17:04 -0700
Message-Id: <20220315201706.7576-2-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220315201706.7576-1-rick.p.edgecombe@intel.com>
References: <20220315201706.7576-1-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
bitsize generic code.

This should have no functional change and is only changing how constants
are generated and named. The enum is local to this file, so it does not
introduce any burden on code calling from other places in the kernel now
having to worry about whether to use a 32 bit or 64 bit enum name.

[1] https://lore.kernel.org/lkml/20180717162502.32274-1-yu-cheng.yu@intel.com/

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/kernel/ptrace.c | 60 ++++++++++++++++++++++++++--------------
 1 file changed, 39 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index 8d2f2f995539..7a4988d13c43 100644
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
+enum x86_regset_32 {
+	REGSET_GENERAL32,
+	REGSET_FP32,
+	REGSET_XFP32,
+	REGSET_XSTATE32,
+	REGSET_TLS32,
 	REGSET_IOPERM32,
 };
 
+enum x86_regset_64 {
+	REGSET_GENERAL64,
+	REGSET_FP64,
+	REGSET_IOPERM64,
+	REGSET_XSTATE64,
+};
+
+#define REGSET_GENERAL \
+({ \
+	BUILD_BUG_ON((int)REGSET_GENERAL32 != (int)REGSET_GENERAL64); \
+	REGSET_GENERAL32; \
+})
+
+#define REGSET_FP \
+({ \
+	BUILD_BUG_ON((int)REGSET_FP32 != (int)REGSET_FP64); \
+	REGSET_FP32; \
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
+					   REGSET_XFP32,
 					   0, sizeof(struct user_fxsr_struct),
 					   datap) ? -EIO : 0;
 
 	case PTRACE_SETFPXREGS:	/* Set the child extended FPU state. */
 		return copy_regset_from_user(child, &user_x86_32_view,
-					     REGSET_XFP,
+					     REGSET_XFP32,
 					     0, sizeof(struct user_fxsr_struct),
 					     datap) ? -EIO : 0;
 #endif
@@ -1087,13 +1105,13 @@ static long ia32_arch_ptrace(struct task_struct *child, compat_long_t request,
 
 	case PTRACE_GETFPXREGS:	/* Get the child extended FPU state. */
 		return copy_regset_to_user(child, &user_x86_32_view,
-					   REGSET_XFP, 0,
+					   REGSET_XFP32, 0,
 					   sizeof(struct user32_fxsr_struct),
 					   datap);
 
 	case PTRACE_SETFPXREGS:	/* Set the child extended FPU state. */
 		return copy_regset_from_user(child, &user_x86_32_view,
-					     REGSET_XFP, 0,
+					     REGSET_XFP32, 0,
 					     sizeof(struct user32_fxsr_struct),
 					     datap);
 
@@ -1216,19 +1234,19 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 #ifdef CONFIG_X86_64
 
 static struct user_regset x86_64_regsets[] __ro_after_init = {
-	[REGSET_GENERAL] = {
+	[REGSET_GENERAL64] = {
 		.core_note_type = NT_PRSTATUS,
 		.n = sizeof(struct user_regs_struct) / sizeof(long),
 		.size = sizeof(long), .align = sizeof(long),
 		.regset_get = genregs_get, .set = genregs_set
 	},
-	[REGSET_FP] = {
+	[REGSET_FP64] = {
 		.core_note_type = NT_PRFPREG,
 		.n = sizeof(struct fxregs_state) / sizeof(long),
 		.size = sizeof(long), .align = sizeof(long),
 		.active = regset_xregset_fpregs_active, .regset_get = xfpregs_get, .set = xfpregs_set
 	},
-	[REGSET_XSTATE] = {
+	[REGSET_XSTATE64] = {
 		.core_note_type = NT_X86_XSTATE,
 		.size = sizeof(u64), .align = sizeof(u64),
 		.active = xstateregs_active, .regset_get = xstateregs_get,
@@ -1257,31 +1275,31 @@ static const struct user_regset_view user_x86_64_view = {
 
 #if defined CONFIG_X86_32 || defined CONFIG_IA32_EMULATION
 static struct user_regset x86_32_regsets[] __ro_after_init = {
-	[REGSET_GENERAL] = {
+	[REGSET_GENERAL32] = {
 		.core_note_type = NT_PRSTATUS,
 		.n = sizeof(struct user_regs_struct32) / sizeof(u32),
 		.size = sizeof(u32), .align = sizeof(u32),
 		.regset_get = genregs32_get, .set = genregs32_set
 	},
-	[REGSET_FP] = {
+	[REGSET_FP32] = {
 		.core_note_type = NT_PRFPREG,
 		.n = sizeof(struct user_i387_ia32_struct) / sizeof(u32),
 		.size = sizeof(u32), .align = sizeof(u32),
 		.active = regset_fpregs_active, .regset_get = fpregs_get, .set = fpregs_set
 	},
-	[REGSET_XFP] = {
+	[REGSET_XFP32] = {
 		.core_note_type = NT_PRXFPREG,
 		.n = sizeof(struct fxregs_state) / sizeof(u32),
 		.size = sizeof(u32), .align = sizeof(u32),
 		.active = regset_xregset_fpregs_active, .regset_get = xfpregs_get, .set = xfpregs_set
 	},
-	[REGSET_XSTATE] = {
+	[REGSET_XSTATE32] = {
 		.core_note_type = NT_X86_XSTATE,
 		.size = sizeof(u64), .align = sizeof(u64),
 		.active = xstateregs_active, .regset_get = xstateregs_get,
 		.set = xstateregs_set
 	},
-	[REGSET_TLS] = {
+	[REGSET_TLS32] = {
 		.core_note_type = NT_386_TLS,
 		.n = GDT_ENTRY_TLS_ENTRIES, .bias = GDT_ENTRY_TLS_MIN,
 		.size = sizeof(struct user_desc),
@@ -1312,10 +1330,10 @@ u64 xstate_fx_sw_bytes[USER_XSTATE_FX_SW_WORDS];
 void __init update_regset_xstate_info(unsigned int size, u64 xstate_mask)
 {
 #ifdef CONFIG_X86_64
-	x86_64_regsets[REGSET_XSTATE].n = size / sizeof(u64);
+	x86_64_regsets[REGSET_XSTATE64].n = size / sizeof(u64);
 #endif
 #if defined CONFIG_X86_32 || defined CONFIG_IA32_EMULATION
-	x86_32_regsets[REGSET_XSTATE].n = size / sizeof(u64);
+	x86_32_regsets[REGSET_XSTATE32].n = size / sizeof(u64);
 #endif
 	xstate_fx_sw_bytes[USER_XSTATE_XCR0_WORD] = xstate_mask;
 }
-- 
2.17.1

