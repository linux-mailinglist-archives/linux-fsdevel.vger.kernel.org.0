Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCBFA563E1F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Jul 2022 06:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbiGBEKM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 2 Jul 2022 00:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbiGBEKI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 2 Jul 2022 00:10:08 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1C92F649
        for <linux-fsdevel@vger.kernel.org>; Fri,  1 Jul 2022 21:10:05 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id u6-20020a17090a1d4600b001ec8200fe70so1942659pju.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Jul 2022 21:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=JYBUfu4dRUjoMzW6ZjvMbfNS2SXXbcilGbZXDricLmU=;
        b=M4MJU8ZtAznGxGY7dmrESXmUeUdfwxVXaZ3LRTPPliqlD1cjIRvh0Kuu9p+55etK+G
         ssHoq9j+4VuU5ypw24KgRs00V2EOx2rP48tiZMH3uEzPs5p/ypPIdoka9KFEA9LJXTQO
         YzLU4cyHzky6gMG3CCcxBVEGqCTRajbCWW4NYFEUTUqpbATF8M7Foysv+CtQISLM5ZIn
         NqDoOQcVM5GL1QMEgtyJy0tUXiAoJs9bGYtAqIcihC0i09A0y5JYYaQ8ShZs5hbaZmqC
         weflkr6UfyLGZSWRz6003TMwH7ooADO1uCeZg7H3kRFgDmJ/5xwajyv+Vd3nEvcakbue
         TLqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=JYBUfu4dRUjoMzW6ZjvMbfNS2SXXbcilGbZXDricLmU=;
        b=3mI/4CkL8YJv4elv9FZI14u5IPXzGwchlqFWzRqWE2l8sY832JAn0PcJtwoUfZqo2Y
         sWpJVb4tRR5iAj45vInOPP954X2pkBTAQBO6NEdd1jFlgGBjBqncWM0NYKbXR657la7r
         Z6p6XJE2pKC3rPKWxCOf4QdrAK2hwL1Vbe1zAG9B7LsFkO7Us2QfSIXwd+605Cw42BDh
         XURddftxcPW9nIzR67vhFZH8aCnQOkUiUARS9paaqDRl79PU5DFGJrZ2x1qRT4AGNTOb
         1f2Tdnl9XnIOoDrX2tvW/lkRQ5IxINVI2xaXWZmKCksvMuschZFMUZvEAr0hEyyavkO4
         HMRA==
X-Gm-Message-State: AJIora/sqaw9iHd+mpL0aCSVGSeXB2KGaOR4kowL/UtG6wac1wY2Z67l
        oVr/6SIuNwoBi3HvpwZhrBQw4Fp3UUvKnw==
X-Google-Smtp-Source: AGRyM1tc9Vqs6oy+LUsRBTDq9oRr1m1I1QWjO6kc0pe/ucgnGBlQ/kUFBPdYqaY/2AaS/BgbvI64xKTE8IhJgw==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a05:6a00:c84:b0:528:3c39:f42d with SMTP
 id a4-20020a056a000c8400b005283c39f42dmr4507362pfv.76.1656735004933; Fri, 01
 Jul 2022 21:10:04 -0700 (PDT)
Date:   Sat,  2 Jul 2022 12:09:56 +0800
Message-Id: <20220702040959.3232874-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v5 1/4] panic: Taint kernel if tests are run
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
        autolearn=unavailable autolearn_force=no version=3.4.6
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

