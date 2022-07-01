Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E79562EB6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Jul 2022 10:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236296AbiGAIr5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Jul 2022 04:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbiGAIrz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Jul 2022 04:47:55 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DF8735B2
        for <linux-fsdevel@vger.kernel.org>; Fri,  1 Jul 2022 01:47:51 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id b7-20020a256707000000b00669b4b2c5daso1483997ybc.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Jul 2022 01:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=NuZanDiX6ZABSMbfniI1TGr/DxYkHBykbUx4x4ghkJs=;
        b=CZLCtNgssNVr6nSXDn6fB604VBq+KkeWkf1tsogW0rqBqDsWGig719MPVJL6gYAvgY
         9RLRb9A15yblqEPywZl4Lgr6YSf9RXOrCrx05owdb7fROgwlMHPgEHweT+hfEokeoi8o
         LNHODCorIbIyKm8aLbO68fc481xtKztaTjZzYQOWZdYOt+CAO+QwI1YDcZSKV3SuqVOA
         FJ1LmVHx3rC43z4OWzucakfkXECe5G+RwAjDe0BEzlgwIeQv+q77AUOJhIdqm3JQLg0q
         MP46dyYMh7yz1bpDLglsTAKkhXu3eoWqjeliptD0SJta9R4nLcM52BDKD2JG16NnEN4l
         O7Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=NuZanDiX6ZABSMbfniI1TGr/DxYkHBykbUx4x4ghkJs=;
        b=haHPAM5aVeZhSoDE8Wbxwa9gS9HjP+a+OwpjmM+OLUZ9OwudyfcAewxOr7t9AkUjnp
         nGdmW9MqJ69kE7w4Ot9bR3PWvURJrbRMMk4kma2gG+lupBOh5205qUj0v8PF+kkJaP0f
         rZrWkbHnSCeGrmljU6gxyLI1mFID0UUp94lvXt8HfoOpaEN7Xn0U1TxKLKrsZpf0WBJT
         8vaC6RjMSPn/Kta7hiAvx/PszVy9f8beCswNR16212ETtRy9sZgcfClXtV8Vxme19lU1
         e4r3ZzFPfb41BAKD1VMY8BQGc0MWMQ4YiGUszSMQnhnpxoLbnPso78/+z1ME7UnyvUsG
         ddUA==
X-Gm-Message-State: AJIora+QSjtJYAAfyV4Bhox5wKhh2af3vpyHjBsBjHUyTPpN6nuZCen/
        nQf1YQscsIErP0p86insfuyPVz17mBuYuQ==
X-Google-Smtp-Source: AGRyM1ueeVhwlJQ7zRKjLy1gM9/U9w/+eRK9KccBKyOEVw0DgaknmIifOXTfkG/tj2NIxQjOyOX+A2D1Xy7eSg==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a25:d292:0:b0:66c:8adb:ce55 with SMTP id
 j140-20020a25d292000000b0066c8adbce55mr14348011ybg.131.1656665270212; Fri, 01
 Jul 2022 01:47:50 -0700 (PDT)
Date:   Fri,  1 Jul 2022 16:47:41 +0800
Message-Id: <20220701084744.3002019-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v4 1/4] panic: Taint kernel if tests are run
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

Finally getting back to this, with the addition of a MODULE_INFO()
to mark a module as a test module. This is automatically set for modules
in the "tools/testing" directory by modpost (see patch #2).

The 'N' character for the taint is even less useful now that it's no
longer short for kuNit, but all the letters in TEST are taken. :-(

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

