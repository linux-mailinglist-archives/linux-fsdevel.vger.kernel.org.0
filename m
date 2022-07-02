Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1B9563E31
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Jul 2022 06:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbiGBEKy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 2 Jul 2022 00:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbiGBEKq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 2 Jul 2022 00:10:46 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8794635865
        for <linux-fsdevel@vger.kernel.org>; Fri,  1 Jul 2022 21:10:19 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2dc7bdd666fso32016997b3.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Jul 2022 21:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=HBYnSHzQWg2Lp2cioqz+iG/q+4XSrXc7FbjoZdcHpbA=;
        b=lxI8R+2BiFyIZIQT3Z8E6VUUX7SJWJwlS4m8uYrDpLk9tJq1hJfYZ/wKsRPQ7un8xP
         BGC68H6zMkzJxgQEO3lAogc4mt1HjWX0CL0tpdOx+ihRO8huvjSujzsHIJDwr0qFUA+R
         HH0TCAR3RB5ZVNcDHtskNIwPUBSOmp/viRstPTFEgyxsS+clwidWKThmtmPKLi0+3lzh
         tcVE0aSlTOG60UOz8sUQtA5g3WgC/7svYkE/JA9yy5UrVvgWWwcwGc80vG+3PfHt9O+O
         L+PopdPOgg43U82wOfInv41nEGulTRdZOcZGJmmvghaGL9GT1q912vvmXvPuq5FlMN7v
         jsPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HBYnSHzQWg2Lp2cioqz+iG/q+4XSrXc7FbjoZdcHpbA=;
        b=1snbPQYramx41dm8UMZ8kK3JUkPd2RIghdPpbjRvuXGrjUtv++4CJJU5SAY7irrkyd
         T31D9T9XvaTuIJKToyTrqKGMxNuNumCQqS2AT/zKIhHiASOAy/ryCppeE8bnxfbVge6Z
         I0ewzjoyshUL1fvfvtrQ8k5CPwSJ4xWJNImBm8ayaukkAweNnU/ERXncy8n129JZY48u
         qvp5Elzc/ylrhubsAL5KoITJJUsTjbKf5IXtEI7BOgSIkBgs/D9MdcldyAeyC+wFRnUQ
         PfUooR/NRglqffY1lL55GF8to7/fnuOsCFQE33o+ySpy7I1z6uqK+ubG/XcWCF4gd9nI
         C3Jw==
X-Gm-Message-State: AJIora/WRLqXPsdDVPSYI8uDV5tfhBmge9Q00xXl2F34/W6XAFxyzPu1
        Nzus2qX1csVaoKLhgGfKVTLOsZCmGo3uLw==
X-Google-Smtp-Source: AGRyM1sGhN3kPsCRXpGwIS0KN1F+hayAdFlP3aPqIerwHYupXDbnptnxmhxIJYlrF/5cw+l2900yFBjIdeAaaQ==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a81:74a:0:b0:31c:c28:a620 with SMTP id
 71-20020a81074a000000b0031c0c28a620mr21591367ywh.137.1656735018635; Fri, 01
 Jul 2022 21:10:18 -0700 (PDT)
Date:   Sat,  2 Jul 2022 12:09:59 +0800
In-Reply-To: <20220702040959.3232874-1-davidgow@google.com>
Message-Id: <20220702040959.3232874-4-davidgow@google.com>
Mime-Version: 1.0
References: <20220702040959.3232874-1-davidgow@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v5 4/4] selftest: Taint kernel when test module loaded
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

Make any kselftest test module (using the kselftest_module framework)
taint the kernel with TAINT_TEST on module load.

Also mark the module as a test module using MODULE_INFO(test, "Y") so
that other tools can tell this is a test module. We can't rely solely
on this, though, as these test modules are also often built-in.

Finally, update the kselftest documentation to mention that the kernel
should be tainted, and how to do so manually (as below).

Note that several selftests use kernel modules which are not based on
the kselftest_module framework, and so will not automatically taint the
kernel.

This can be done in two ways:
- Moving the module to the tools/testing directory. All modules under
  this directory will taint the kernel.
- Adding the 'test' module property with:
  MODULE_INFO(test, "Y")

Similarly, selftests which do not load modules into the kernel generally
should not taint the kernel (or possibly should only do so on failure),
as it's assumed that testing from user-space should be safe. Regardless,
they can write to /proc/sys/kernel/tainted if required.

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: David Gow <davidgow@google.com>
---
 Documentation/dev-tools/kselftest.rst      | 9 +++++++++
 tools/testing/selftests/kselftest_module.h | 4 ++++
 2 files changed, 13 insertions(+)

diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
index a833ecf12fbc..1096a9833550 100644
--- a/Documentation/dev-tools/kselftest.rst
+++ b/Documentation/dev-tools/kselftest.rst
@@ -250,6 +250,14 @@ assist writing kernel modules that are for use with kselftest:
 - ``tools/testing/selftests/kselftest_module.h``
 - ``tools/testing/selftests/kselftest/module.sh``
 
+Note that test modules should taint the kernel with TAINT_TEST. This will
+happen automatically for modules which are in the ``tools/testing/``
+directory, or for modules which use the ``kselftest_module.h`` header above.
+Otherwise, you'll need to add ``MODULE_INFO(test, "Y")`` to your module
+source. selftests which do not load modules typically should not taint the
+kernel, but in cases where a non-test module is loaded, TEST_TAINT can be
+applied from userspace by writing to ``/proc/sys/kernel/tainted``.
+
 How to use
 ----------
 
@@ -308,6 +316,7 @@ A bare bones test module might look like this:
    KSTM_MODULE_LOADERS(test_foo);
    MODULE_AUTHOR("John Developer <jd@fooman.org>");
    MODULE_LICENSE("GPL");
+   MODULE_INFO(test, "Y");
 
 Example test script
 -------------------
diff --git a/tools/testing/selftests/kselftest_module.h b/tools/testing/selftests/kselftest_module.h
index e2ea41de3f35..63cd7487373f 100644
--- a/tools/testing/selftests/kselftest_module.h
+++ b/tools/testing/selftests/kselftest_module.h
@@ -3,6 +3,7 @@
 #define __KSELFTEST_MODULE_H
 
 #include <linux/module.h>
+#include <linux/panic.h>
 
 /*
  * Test framework for writing test modules to be loaded by kselftest.
@@ -41,6 +42,7 @@ static inline int kstm_report(unsigned int total_tests, unsigned int failed_test
 static int __init __module##_init(void)			\
 {							\
 	pr_info("loaded.\n");				\
+	add_taint(TAINT_TEST, LOCKDEP_STILL_OK);	\
 	selftest();					\
 	return kstm_report(total_tests, failed_tests, skipped_tests);	\
 }							\
@@ -51,4 +53,6 @@ static void __exit __module##_exit(void)		\
 module_init(__module##_init);				\
 module_exit(__module##_exit)
 
+MODULE_INFO(test, "Y");
+
 #endif	/* __KSELFTEST_MODULE_H */
-- 
2.37.0.rc0.161.g10f37bed90-goog

