Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 071B1562EC8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Jul 2022 10:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234650AbiGAIsN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Jul 2022 04:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235680AbiGAIsK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Jul 2022 04:48:10 -0400
Received: from mail-ot1-x349.google.com (mail-ot1-x349.google.com [IPv6:2607:f8b0:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F25735B9
        for <linux-fsdevel@vger.kernel.org>; Fri,  1 Jul 2022 01:47:59 -0700 (PDT)
Received: by mail-ot1-x349.google.com with SMTP id l9-20020a05683016c900b00616e99c836dso899335otr.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Jul 2022 01:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+zs9McyspJyuL95L2dn0e+9NIxzA0pjwBmrT4ez5azk=;
        b=HmwOyP6LrnIAWygRoWdFbVte/NF7Ah59SSg24ixrC26UeYUaKiYpQKfZwy2wWBmJFn
         Xaomq42IBwaqcq3kDZB+l8s9M9DwICaR9OKfMsrGUuSUOfKrJ0D/IpWcOrKEQgKNNZQT
         CQ0KByJB/jeS6aPe2d/KcOVERt2009aYYdIVwx6xDhdEYkPx4zUP3AAeYBVLDScapS7U
         CGY9Nlc6mKCbptKcFKQgUJ6+uPeOCme/4epvAMbCz3TJ0+UkNPXU/N39sIdBxXdYASTF
         sVP14pf/aoE4623J+BZz4m8+dDOv3Cssppe2cg7fSTZ+n6MMfxbKku+TM5hQn4WJ3o6n
         9bMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+zs9McyspJyuL95L2dn0e+9NIxzA0pjwBmrT4ez5azk=;
        b=fCcBMrDcl4J207dKKydZMN7qxJvbp1VjHRl59iI/IqUGTtPLfQFXzTWeCq/sRzoS89
         DbmSmE+g2NX/Np7fdfmdrSVSVUvlOUIvq5IEM4DKdPRzDUDf5TZlC6DNSV5OqbmG70X9
         HjrL67kHR0jAPIsvRTK+zP5dy1kJnMNUoweuqHxWY731mtP5p9hMOifoUUT7y0JEYFfp
         Ji/mnVYx1PpbfUyJAujTyGotK0zOC2+SvHt6KLFBqum9SDEkijV3UXV0b9/PWh2JvYVw
         aYWDwaJ/cJ+sGFtacgPIjB2BqzNdO5386cASshcycPsMfVkRVUoj91H6AQKe/geygpyx
         WVRw==
X-Gm-Message-State: AJIora8MH0opYWbCiQJN08QEXGcXOB9x+Q5O490leTta3Wp+5oH3dH1t
        /4frcNE6ZxhL7/ZDqMLoCpSCIb97ebKTng==
X-Google-Smtp-Source: AGRyM1uB137feo67oTb7/H8CK/WR5OXActRbYHb36UQgb0dyDSrNGYp9HMhU3C7dbaN7jOKGwmCf/p4tUTZgrw==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a05:6808:19a5:b0:335:cffd:b276 with SMTP
 id bj37-20020a05680819a500b00335cffdb276mr3489043oib.226.1656665279047; Fri,
 01 Jul 2022 01:47:59 -0700 (PDT)
Date:   Fri,  1 Jul 2022 16:47:43 +0800
In-Reply-To: <20220701084744.3002019-1-davidgow@google.com>
Message-Id: <20220701084744.3002019-3-davidgow@google.com>
Mime-Version: 1.0
References: <20220701084744.3002019-1-davidgow@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v4 3/4] kunit: Taint the kernel when KUnit tests are run
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

Make KUnit trigger the new TAINT_TEST taint when any KUnit test is run.
Due to KUnit tests not being intended to run on production systems, and
potentially causing problems (or security issues like leaking kernel
addresses), the kernel's state should not be considered safe for
production use after KUnit tests are run.

This both marks KUnit modules as test modules using MODULE_INFO() and
manually taints the kernel when tests are run (which catches builtin
tests).

Acked-by: Luis Chamberlain <mcgrof@kernel.org>
Tested-by: Daniel Latypov <dlatypov@google.com>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Signed-off-by: David Gow <davidgow@google.com>
---

Changes since v3:
https://lore.kernel.org/lkml/20220513083212.3537869-2-davidgow@google.com/
- Use MODULE_INFO() for KUnit modules.
  - This is technically redundant, as the KUnit executor will taint the
    kernel when _any_ KUnit tests are run, but may be useful if some
    other tool will parse the 'test' property.
- Add {Acked,Tested,Reviewed}-by tags.

---
 include/kunit/test.h | 3 ++-
 lib/kunit/test.c     | 4 ++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 8ffcd7de9607..ccae848720dc 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -277,7 +277,8 @@ static inline int kunit_run_all_tests(void)
 	{								\
 		return __kunit_test_suites_exit(__suites);		\
 	}								\
-	module_exit(kunit_test_suites_exit)
+	module_exit(kunit_test_suites_exit)				\
+	MODULE_INFO(test, "Y");
 #else
 #define kunit_test_suites_for_module(__suites)
 #endif /* MODULE */
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index a5053a07409f..8b11552dc215 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -11,6 +11,7 @@
 #include <kunit/test-bug.h>
 #include <linux/kernel.h>
 #include <linux/moduleparam.h>
+#include <linux/panic.h>
 #include <linux/sched/debug.h>
 #include <linux/sched.h>
 
@@ -501,6 +502,9 @@ int kunit_run_tests(struct kunit_suite *suite)
 	struct kunit_result_stats suite_stats = { 0 };
 	struct kunit_result_stats total_stats = { 0 };
 
+	/* Taint the kernel so we know we've run tests. */
+	add_taint(TAINT_TEST, LOCKDEP_STILL_OK);
+
 	if (suite->suite_init) {
 		suite->suite_init_err = suite->suite_init(suite);
 		if (suite->suite_init_err) {
-- 
2.37.0.rc0.161.g10f37bed90-goog

