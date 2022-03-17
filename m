Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 917A84DCEB0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Mar 2022 20:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237907AbiCQTWL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Mar 2022 15:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236054AbiCQTWK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Mar 2022 15:22:10 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C8D21A8B3;
        Thu, 17 Mar 2022 12:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647544853; x=1679080853;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Q1TUQPfLOqJiY+H7s42JJmt7qOtLkdLcXdvqtfl9Y5o=;
  b=CmeEAf049uXQbT7noIr7hT6sfe+iP3pMsXtmYyo9gTHh1lzJNTS/KkCA
   d1/kJJPYW6oiJH7V8lrOS5WzH+UcQWze3G0WFsA/9SdkQHcSe1UFig+xt
   tg0Of2Pxi1y0KncT8GUhHnHW3kURJUiaAX+2K/jVxeMQivCyKQJ4mYt10
   M8m2OeMijifyRivsrvV+yPewr35d8Zj74+2DaRCe6hcZ15RnYUzooznt5
   eRagrXyOOcssIhckIiCtI8BoPqBQGjh4JuonwC6xE9jS+ydz6ID6yjPRI
   SMcKbMUplr4OWApgtctvCdJclgA4ChQTsSRtqpDsq1Pg+fd40MyCsR9lJ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="257150094"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="257150094"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 12:20:52 -0700
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="691054859"
Received: from awyatt-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.212.178.193])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 12:20:52 -0700
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     dave.hansen@intel.com, len.brown@intel.com, tony.luck@intel.com,
        rafael.j.wysocki@intel.com, reinette.chatre@intel.com,
        dan.j.williams@intel.com, viro@zeniv.linux.org.uk,
        ebiederm@xmission.com, keescook@chromium.org
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] x86: Improve formatting of user_regset arrays
Date:   Thu, 17 Mar 2022 12:20:12 -0700
Message-Id: <20220317192013.13655-3-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220317192013.13655-1-rick.p.edgecombe@intel.com>
References: <20220317192013.13655-1-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/kernel/ptrace.c | 105 ++++++++++++++++++++++++---------------
 1 file changed, 64 insertions(+), 41 deletions(-)

diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index c6a4a4d0d804..d69e064e3e93 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -1235,28 +1235,37 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 
 static struct user_regset x86_64_regsets[] __ro_after_init = {
 	[REGSET64_GENERAL] = {
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
 	[REGSET64_FP] = {
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
 	[REGSET64_XSTATE] = {
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
 	[REGSET64_IOPERM] = {
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
 	[REGSET32_GENERAL] = {
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
 	[REGSET32_FP] = {
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
 	[REGSET32_XFP] = {
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
 	[REGSET32_XSTATE] = {
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
 	[REGSET32_TLS] = {
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
 	[REGSET32_IOPERM] = {
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

