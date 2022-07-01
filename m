Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1FF7562EC2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Jul 2022 10:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236064AbiGAIsP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Jul 2022 04:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236338AbiGAIsL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Jul 2022 04:48:11 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951487390C
        for <linux-fsdevel@vger.kernel.org>; Fri,  1 Jul 2022 01:48:03 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id b11-20020a5b008b000000b00624ea481d55so1458367ybp.19
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Jul 2022 01:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=fZhsQWUMRsqP4fT4YbqRmtPfIJ3qiGBySrh/88eLEVc=;
        b=h47MjT9X36O0Dr/QUNMr44h8p/7VMC+LIl6ktx6l5nZUHLR6XZfIs7vt2fN5PFs7ca
         yLPurqgqC3Jubn3FTuu/IxaEB5bubhCRpmpavHOZDaz5SDUhVGQgkFd9MeTpB+8U8ppv
         /DDSdRuhBcfcoaIAz2GiQORZg6D2AP1Nn9PSnpH4tKkN2ICkYo4zPbMZ6UROvIJwLmQI
         2K1M5u2MWwQKEbjo9f9bWwdOiIKThrMD3OsLpScaT+Ydhh5ikh6IfE94rhnUvIFsgPSg
         D7rQ0hv0uoJwS1cAwI1kHV+ednhWq2jRo6h8iIKv1Ghzu08Fs+ZeCndkrkLNwZa7FYbg
         PYvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fZhsQWUMRsqP4fT4YbqRmtPfIJ3qiGBySrh/88eLEVc=;
        b=BBCZ421AAjRtJxag0UQGx2w0ZEWWFohr73//+Xl1W7msquk40u+bcguQwcpdqYmXS7
         BTMVPF455u3wzO+KCwy11HcotqFLAbxqEDDb5Nbq4e/CNbs8j8IIvsY5EGxqNfCzmQiN
         liSNzQ77WlsppyvmLwFGY1GhwVHja7wIhapXkxS1U5xPbB1u//intsinTZYXMthrQrPa
         QDQGg2pWcqOquCjKDBldEfXgNsHMM4BMHyYXlxvAAkZxamng9xMMrk/VI7DbvzjhkIPz
         Lcz2rzX5KTntB7VqkBXw9MIsnwnq5fmQBgeCaKuyV+t+Mk1BUFNPRW05Gdzz6CK1kurx
         vdVw==
X-Gm-Message-State: AJIora+19yvp0sQBfdZtpoCTVo03G0PtnWTLN7Ef90YR9l0T9SkgW4kx
        cO20hqH8/J9Jm5m5EVvmxJ5bzxLKaNZ0Sw==
X-Google-Smtp-Source: AGRyM1spgZIN2lcHFWw0+ZQmMq5w3ZWXcntdQzIT8XqVLbGVBnJKK1cxu7PAMs/rUgKSf22SLLQoBtVsvGmTIw==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a25:8b8b:0:b0:669:b37d:f9cd with SMTP id
 j11-20020a258b8b000000b00669b37df9cdmr13972189ybl.394.1656665283291; Fri, 01
 Jul 2022 01:48:03 -0700 (PDT)
Date:   Fri,  1 Jul 2022 16:47:44 +0800
In-Reply-To: <20220701084744.3002019-1-davidgow@google.com>
Message-Id: <20220701084744.3002019-4-davidgow@google.com>
Mime-Version: 1.0
References: <20220701084744.3002019-1-davidgow@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v4 4/4] selftest: Taint kernel when test module loaded
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

Make any kselftest test module (using the kselftest_module framework)
taint the kernel with TAINT_TEST on module load.

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

Signed-off-by: David Gow <davidgow@google.com>
---

This still only covers a subset of selftest modules, but combined with
the modpost check for the tools/testing path, it should catch many
future tests. Others can be moved, adapted to use this framework, or
have MODULE_INFO(test, "Y") added. (Alas, I don't have the time to hunt
down all of the tests which don't do this at the moment.

No changes since v3:
https://lore.kernel.org/lkml/20220513083212.3537869-3-davidgow@google.com/

---
 tools/testing/selftests/kselftest_module.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/kselftest_module.h b/tools/testing/selftests/kselftest_module.h
index e2ea41de3f35..226e616b82e0 100644
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
+	add_taint(TAINT_KUNIT, LOCKDEP_STILL_OK);	\
 	selftest();					\
 	return kstm_report(total_tests, failed_tests, skipped_tests);	\
 }							\
-- 
2.37.0.rc0.161.g10f37bed90-goog

