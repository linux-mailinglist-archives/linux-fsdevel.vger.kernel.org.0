Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC5C56B214
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jul 2022 07:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237347AbiGHEtL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jul 2022 00:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237217AbiGHEtJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jul 2022 00:49:09 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA93D27FDF
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Jul 2022 21:49:06 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 9-20020a631449000000b00412b1418c79so3729155pgu.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Jul 2022 21:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=VZyJYOYOmyBhccquB8jdOUnepxpHA2EaXyI1P4UgbZk=;
        b=OHzkH6CUxvF29C6YQodBsFfPokm7+7etvB60EYT5rIwMD9OH9U0AtmpXKx8ZweKRed
         oVZZWfzMiTxQCiJZmTzZFy/2zT1zAwz/QiMCizqTeCDDUMzkWm28PYce3SbM5zzYBW77
         yV0Uad6HwQFnl1WR7X0N9vmmphNFvmNcYpOaRGosGMuX2CSg5QrwApAEgKVwDHQTpcxy
         Sky7eDBPBbF7SJ/f16wadWBTNZoJ/jocoStlAp9thvE9KSXkl3BZyWZ1QT9Zu68DamHv
         OkCWlI0K2FLP1JijkIPh/bzpwjR0tPLlC54olqaueZJM3XL7OldUYMDKpjvcPNHZcS7f
         1tug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=VZyJYOYOmyBhccquB8jdOUnepxpHA2EaXyI1P4UgbZk=;
        b=SSCJG4Yh9n29NnrRDDa1Xr4forrsp3DCGYDpdhW5H9vgs/8PBn2U2nmUuyqijvuhoB
         HlbjouJSqSDF/MsJlHm1RpmgPSlzuKctBikU5mwwq3RUUQKPsomLr7epp21qAECXRMEM
         mQhg6vbm9d+eQlteINr+OtE2xaBgpF753xcIAoPhvO8s0lFgj50DLpi/+fRWy7kTHHoZ
         fGvC1J2Ro/Ma4kDgDP8EYHGmuJ5XLZeI5ujXtgWhqo3mPdUpmUAaSSvxoJmNVNLaagBI
         kJeVNS+ua7TDbHljf3rYAMkAWH4/1f2lejiIrtOKcKiVAdIMU6F36EuHuw6IV/U6gfn4
         yviA==
X-Gm-Message-State: AJIora8+KalcnEJ/yJ/RksPCcFuKojJAwb6e2+FfFc4WiEL1XJRm/RcL
        QMtu9gCkXdTXPKfIMUtT5iGtFW6OrZ471Q==
X-Google-Smtp-Source: AGRyM1v/UKrknfucMWmYcBRyH1xUQKjKyi5ZMpliyIdbk8sMgra7H2LLCj2bXBXPVZ4KhAqUnXO25gVfJYLhfQ==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a05:6a00:1895:b0:527:f270:64de with SMTP
 id x21-20020a056a00189500b00527f27064demr1678536pfh.61.1657255746437; Thu, 07
 Jul 2022 21:49:06 -0700 (PDT)
Date:   Fri,  8 Jul 2022 12:48:44 +0800
Message-Id: <20220708044847.531566-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v6 1/4] panic: Taint kernel if tests are run
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>
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

Most in-kernel tests (such as KUnit tests) are not supposed to run on
production systems: they may do deliberately illegal things to trigger
errors, and have security implications (for example, KUnit assertions
will often deliberately leak kernel addresses).

Add a new taint type, TAINT_TEST to signal that a test has been run.
This will be printed as 'N' (originally for kuNit, as every other
sensible letter was taken.)

This should discourage people from running these tests on production
systems, and to make it easier to tell if tests have been run
accidentally (by loading the wrong configuration, etc.)

Acked-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Signed-off-by: David Gow <davidgow@google.com>
---

This is v6 of the "make tests taint the kernel" patchset. The only
changes since v5 (which is the version in linux-next at time of writing)
are some rather critical fixes to patch 2/4, where the cruicial check
was inverted. (Oops!)

The 'N' character for the taint is even less useful now that it's no
longer short for kuNit, but all the letters in TEST are taken. :-(

No changes since v5:
https://lore.kernel.org/linux-kselftest/20220702040959.3232874-1-davidgow@google.com/

No changes since v4:
https://lore.kernel.org/linux-kselftest/20220701084744.3002019-1-davidgow@google.com/

Changes since v3:
https://lore.kernel.org/lkml/20220513083212.3537869-1-davidgow@google.com/
- Remove the mention of KUnit from the documentation.
- Add Luis and Brendan's Acked/Reviewed-by tags.

Changes since v2:
https://lore.kernel.org/linux-kselftest/20220430030019.803481-1-davidgow@google.com/
- Rename TAINT_KUNIT -> TAINT_TEST.
- Split into separate patches for adding the taint, and triggering it.
- Taint on a kselftest_module being loaded (patch 3/3)

Changes since v1:
https://lore.kernel.org/linux-kselftest/20220429043913.626647-1-davidgow@google.com/
- Make the taint per-module, to handle the case when tests are in
  (longer lasting) modules. (Thanks Greg KH).

Note that this still has checkpatch.pl warnings around bracket
placement, which are intentional as part of matching the surrounding
code.

---
 Documentation/admin-guide/tainted-kernels.rst | 1 +
 include/linux/panic.h                         | 3 ++-
 kernel/panic.c                                | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentation/admin-guide/tainted-kernels.rst
index ceeed7b0798d..7d80e8c307d1 100644
--- a/Documentation/admin-guide/tainted-kernels.rst
+++ b/Documentation/admin-guide/tainted-kernels.rst
@@ -100,6 +100,7 @@ Bit  Log  Number  Reason that got the kernel tainted
  15  _/K   32768  kernel has been live patched
  16  _/X   65536  auxiliary taint, defined for and used by distros
  17  _/T  131072  kernel was built with the struct randomization plugin
+ 18  _/N  262144  an in-kernel test has been run
 ===  ===  ======  ========================================================
 
 Note: The character ``_`` is representing a blank in this table to make reading
diff --git a/include/linux/panic.h b/include/linux/panic.h
index e71161da69c4..c7759b3f2045 100644
--- a/include/linux/panic.h
+++ b/include/linux/panic.h
@@ -68,7 +68,8 @@ static inline void set_arch_panic_timeout(int timeout, int arch_default_timeout)
 #define TAINT_LIVEPATCH			15
 #define TAINT_AUX			16
 #define TAINT_RANDSTRUCT		17
-#define TAINT_FLAGS_COUNT		18
+#define TAINT_TEST			18
+#define TAINT_FLAGS_COUNT		19
 #define TAINT_FLAGS_MAX			((1UL << TAINT_FLAGS_COUNT) - 1)
 
 struct taint_flag {
diff --git a/kernel/panic.c b/kernel/panic.c
index a3c758dba15a..6b3369e21026 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -428,6 +428,7 @@ const struct taint_flag taint_flags[TAINT_FLAGS_COUNT] = {
 	[ TAINT_LIVEPATCH ]		= { 'K', ' ', true },
 	[ TAINT_AUX ]			= { 'X', ' ', true },
 	[ TAINT_RANDSTRUCT ]		= { 'T', ' ', true },
+	[ TAINT_TEST ]			= { 'N', ' ', true },
 };
 
 /**
-- 
2.37.0.rc0.161.g10f37bed90-goog

