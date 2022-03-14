Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3062D4D7EC1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Mar 2022 10:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238206AbiCNJiZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Mar 2022 05:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238159AbiCNJiU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Mar 2022 05:38:20 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020423FBC1;
        Mon, 14 Mar 2022 02:37:11 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id t22so1789025plo.0;
        Mon, 14 Mar 2022 02:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Rc30Ltg5OaNXziswtFeLNccH8pd7ymn8bVN5NTdVbj8=;
        b=Ki/4dypeHaGER1Hb9fJsbNxtix+BqHNvGSuCb81og/lGwmD942hNiNJEOezYimhgbG
         Xl6FwntRM9Wh9eeNGkg+jGixUurpcd+S0fKegAFJM3xHU71NCCxqbMsHtqNBV4aRzDS+
         ++QkgTPyelCDk7pw+SlGNDIap2Ll3Yat4bKRE9ao5dHDs+EZWDvMyTVVLsUh9V+QVEaQ
         X/gHSyzyohJ0bUhq32LRuywUB5SVbnyF4XNEqTFRfXM6uwFwmCr1a2olpLIn62APqRGm
         IkR+H9I6vMoGwoHb4muzI/d6QiJW2urGBUf5OF5Lo3sJV/Uy3KuiSs55Tth8yOW+IH2c
         tf7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Rc30Ltg5OaNXziswtFeLNccH8pd7ymn8bVN5NTdVbj8=;
        b=mSdBrbrqxlU9U3xEm9mGVRQFZlUMcp0I6Cux3VdE55N/Eotk1vHPjaKYs4ftcRXIhs
         +0kk8xQz53R6h0znNKFq+Dp1erT1Q6raommudN/v+BDojfOVLfo5ljK0NLYE91UMsMG7
         gpP3dR7HmWFfOVrGm8KFiG+CLuYBq1fbVw7zP+0i8CeGOorD+YokBwZDw8A627t+gKzP
         p0bimRG8FiVOjv9ry101P937wLTJhE8cFVQGOawqucW+ZeXp/fWxfUXhgMLz2/Q9gS2v
         8AbnANhwpre4K37paKtQrbDKhNa6uZl2GXDxGCgy01nNyYEvuWegfX9apkEm44jCJROT
         /TYg==
X-Gm-Message-State: AOAM530xmkzQTxmArPFO3tTf+6+o+XXFXhb4tDy0QhHonNBFBfHNuiu5
        qhj3my0/QOFv7pZiz8jYmTA=
X-Google-Smtp-Source: ABdhPJyOtjSmYlypA0RLzVKRhyy0NRodqlYP+jhHGIQ6y6h8mUJO7LfKZaLhdkUCJdo0piomwsV2og==
X-Received: by 2002:a17:902:f545:b0:151:fa59:95bc with SMTP id h5-20020a170902f54500b00151fa5995bcmr23226335plf.82.1647250630137;
        Mon, 14 Mar 2022 02:37:10 -0700 (PDT)
Received: from localhost ([115.231.19.224])
        by smtp.gmail.com with ESMTPSA id a5-20020a621a05000000b004f79f8f795fsm9321559pfa.0.2022.03.14.02.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 02:37:09 -0700 (PDT)
From:   "chao.peng" <chaop.peng@gmail.com>
To:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     peng_super@163.com, chaop.peng@gmail.com
Subject: [PATCH] Coredump: fix crash when set core_pipe_limit
Date:   Mon, 14 Mar 2022 17:37:05 +0800
Message-Id: <20220314093705.5895-1-chaop.peng@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "chaop.peng" <chaop.peng@gmail.com>

If core_pipe_count was set by /proc/sys/kernel/core_pipe_limit, and the
umh kernel config with the following configuration:
...
CONFIG_STATIC_USERMODEHELPER=y
CONFIG_STATIC_USERMODEHELPER_PATH=""
...
The umh was disabled and call_usermodehelper_exec() return early,
the variable core_pipe_limitand ispipe both with none-zero value,
if the current task signal is pending, call wait_for_dump_helpers
(cprm.file) with NULL value would caused carsh.

[26083.547473] Unable to handle kernel NULL pointer dereference at
virtual address 00000000000000d8
[26083.547485] Mem abort info:
[26083.547491]	 ESR = 0x96000006
[26083.547498]   EC = 0x25: DABT (current EL), IL = 32 bits
[26083.547504]	 SET = 0, FnV = 0
[26083.547509]	 EA = 0, S1PTW = 0
[26083.547514] Data abort info:
[26083.547520]	 ISV = 0, ISS = 0x00000006
[26083.547525]	 CM = 0, WnR = 0
[26083.547533] user pgtable: 4k pages, 39-bit VAs, pgdp=000000011181b000
[26083.547539] [00000000000000d8] pgd=0000000123e4e003
[26083.547543] , p4d=0000000123e4e003
[26083.547549] , pud=0000000123e4e003
[26083.547555] , pmd=0000000000000000
[26083.547570] Internal error: Oops: 96000006 [#1] PREEMPT SMP
[26083.597731] Kernel Offset: 0x1af0c0000 from 0xffffffc010000000
[26083.597744] PHYS_OFFSET: 0x40000000
[26083.597753] pstate: 22400005 (nzCv daif +PAN -UAO)
[26083.597765] pc : [0xffffffdb012a9280] do_coredump+0x99c/0x1ad4
[26083.597773] lr : [0xffffffdb012a90d0] do_coredump+0x7ec/0x1ad4
[26083.597778] sp : ffffffc048803b50
[26083.597784] x29: ffffffc048803c60 x28: ffffffdb03dee748
[26083.597790] x27: ffffff819060cec0 x26: ffffff8107a1f3c0
[26083.597796] x25: ffffff895e655400 x24: 0000000000000001
[26083.597801] x23: 0000000000000000 x22: 0000000000000000
[26083.597806] x21: ffffff818f3eb580 x20: ffffff81890973c0
[26083.597812] x19: ffffff800dff3780 x18: ffffffc03da8b020
[26083.597817] x17: ffffffdb03688544 x16: 0000000000000002
[26083.597823] x15: 0000000000000001 x14: 0000000000000000
[26083.597828] x13: ffffff818f3eb420 x12: 0000000000000000
[26083.597834] x11: 0000000000000001 x10: 0000000000000000
[26083.597839] x9 : 0000000000000000 x8 : 0000000000000000
[26083.597844] x7 : 0000000000000000 x6 : ffffff818f3eb428
[26083.597850] x5 : 0000000000000040 x4 : 0000000000000000
[26083.597855] x3 : 0000000000000001 x2 : 0000000000000001
[26083.597860] x1 : 0000000000000000 x0 : ffffff800fab8dc0
[26083.598835] Call trace:
[26083.598844]  dump_backtrace.cfi_jt+0x0/0x8
[26083.598852]  dump_stack_lvl+0xc4/0x140
[26083.598857]  dump_stack+0x1c/0x2c
[26083.598952]  die+0x344/0x748
[26083.598959]  die_kernel_fault+0x84/0x94
[26083.598965]  __do_kernel_fault+0x230/0x27c
[26083.598974]  do_page_fault+0xb4/0x778
[26083.598980]  do_translation_fault+0x48/0x64
[26083.598986]  do_mem_abort+0x6c/0x164
[26083.598993]  el1_abort+0x44/0x68
[26083.599000]  el1_sync_handler+0x58/0x88
[26083.599006]  el1_sync+0x8c/0x140
[26083.599013]  do_coredump+0x99c/0x1ad4
[26083.599020]  get_signal+0xc68/0xffc
[26083.599026]  do_signal+0xd4/0x268
[26083.599032]  do_notify_resume+0x15c/0x264
[26083.599038]  work_pending+0xc/0x5f0

Signed-off-by: chaop.peng <chaop.peng@gmail.com>
---
 fs/coredump.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 1c060c0a2d72..7add39409203 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -736,15 +736,15 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 	retval = unshare_files();
 	if (retval)
 		goto close_fail;
+	/*
+	 * umh disabled with CONFIG_STATIC_USERMODEHELPER_PATH="" would
+	 * have this set to NULL.
+	 */
+	if (!cprm.file) {
+		pr_info("Core dump to |%s disabled\n", cn.corename);
+		goto close_fail;
+	}
 	if (!dump_interrupted()) {
-		/*
-		 * umh disabled with CONFIG_STATIC_USERMODEHELPER_PATH="" would
-		 * have this set to NULL.
-		 */
-		if (!cprm.file) {
-			pr_info("Core dump to |%s disabled\n", cn.corename);
-			goto close_fail;
-		}
 		file_start_write(cprm.file);
 		core_dumped = binfmt->core_dump(&cprm);
 		/*
-- 
2.25.1

