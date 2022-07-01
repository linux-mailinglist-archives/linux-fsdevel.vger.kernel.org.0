Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9D8562EBF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Jul 2022 10:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234233AbiGAIr7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Jul 2022 04:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236031AbiGAIr4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Jul 2022 04:47:56 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A74735A7
        for <linux-fsdevel@vger.kernel.org>; Fri,  1 Jul 2022 01:47:55 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 130-20020a251288000000b0066c81091670so1462993ybs.18
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Jul 2022 01:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ml8Z1qiNNiXT/1PzWyvvt8aN8dvJcZjDGqTV68m+tGo=;
        b=NAQpECpRDHIM/hlGNxwkg9Hv5tgmFumtJ6WiXYFdt9aQ4roUlytgKojb2oeQb8TjrB
         HtvQBKcDWTPW0CjksH/AhxabVHDzZRMvRckEaD1IChNoWcA+AfXWvMzo5dmBGoZ7rZ6N
         ISBu70K79ljdgzwwSF+syxkbcCxHMVeZ1DW4SyFLagkIxCY3sc/IbqWgF642UX89HEVY
         HCM2kY5y7QtM4/HpY7j5bkgVJKqqeel36d+kTOEv9wuWYxInCQtPmh0pNG58a4QwgHSS
         qD6mJgVR0l2XfXKAlRjasF9Q9XreGRXEuMYw9+sZwGQuRQ2K3W511ibsd9lsVTfQPphz
         1zfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ml8Z1qiNNiXT/1PzWyvvt8aN8dvJcZjDGqTV68m+tGo=;
        b=PLWWaHBMisl637NRVmVdLqiE1MAf5d5U9LKt0vH3XiMtX67eW5tLG+97J5wNMo2cEF
         ZMSdvYqXgMVHg2siu11Hq2jEGl1HA+qYst00AXA4p0olryMd4jADvKeLeftxi1C3oHxe
         fZcBrvSkBwQneJUcy2sSkYpCC66K4KlnVFwm71fmtrfd6O8pCsuI7SsmLI/nzv8k9YKY
         nUcXX3WqEF3Fe0aDSYFodSnXK0GzmheP4QZK0E8HOE0DGMmXDEQJBr9Z5zOpMOcT/uaO
         cdG6dFUB4x9cPb3x6ZJBD1qyB8O5YEE5szmaGUw7HUj2cBhcaqbR1O6fuks3PB/QzNBt
         ECGw==
X-Gm-Message-State: AJIora/SeGUQ51Bqg+3Q6V9SCStgrI0blmSOx7+zKbTj39+qZCJBcFHB
        Nnr3U38NsnnsgiTMqMoutySBjtPWzsNAlw==
X-Google-Smtp-Source: AGRyM1v7ew3j0R7c9yqC49uzuTOOzGkqAmVFXXxCn9zfU56NTTgCwP9X9gSqBlJ1BgffmPx/w2LuWEXg7FpvCA==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a81:2443:0:b0:2eb:4ffe:fab2 with SMTP id
 k64-20020a812443000000b002eb4ffefab2mr14909347ywk.330.1656665274440; Fri, 01
 Jul 2022 01:47:54 -0700 (PDT)
Date:   Fri,  1 Jul 2022 16:47:42 +0800
In-Reply-To: <20220701084744.3002019-1-davidgow@google.com>
Message-Id: <20220701084744.3002019-2-davidgow@google.com>
Mime-Version: 1.0
References: <20220701084744.3002019-1-davidgow@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v4 2/4] module: panic: Taint the kernel when selftest modules load
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     David Gow <davidgow@google.com>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Sebastian Reichel <sre@kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Joe Fradley <joefradley@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Taint the kernel with TAINT_TEST whenever a test module loads, by adding
a new "TEST" module property, and setting it for all modules in the
tools/testing directory. This property can also be set manually, for
tests which live outside the tools/testing directory with:
MODULE_INFO(test, "Y");

Signed-off-by: David Gow <davidgow@google.com>
---

This patch is new in v4 of this series.

---
 kernel/module/main.c  | 8 ++++++++
 scripts/mod/modpost.c | 3 +++
 2 files changed, 11 insertions(+)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index fed58d30725d..f2ca0a3ee5e6 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1988,6 +1988,14 @@ static int check_modinfo(struct module *mod, struct load_info *info, int flags)
 	/* Set up license info based on the info section */
 	set_license(mod, get_modinfo(info, "license"));
 
+	if (!get_modinfo(info, "test")) {
+		if (!test_taint(TAINT_TEST))
+			pr_warn("%s: loading test module taints kernel.\n",
+				mod->name);
+		add_taint_module(mod, TAINT_TEST, LOCKDEP_STILL_OK);
+	}
+
+
 	return 0;
 }
 
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 29d5a841e215..5937212b4433 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -2191,6 +2191,9 @@ static void add_header(struct buffer *b, struct module *mod)
 
 	if (strstarts(mod->name, "drivers/staging"))
 		buf_printf(b, "\nMODULE_INFO(staging, \"Y\");\n");
+
+	if (strstarts(mod->name, "tools/testing"))
+		buf_printf(b, "\nMODULE_INFO(test, \"Y\");\n");
 }
 
 static void add_exported_symbols(struct buffer *buf, struct module *mod)
-- 
2.37.0.rc0.161.g10f37bed90-goog

