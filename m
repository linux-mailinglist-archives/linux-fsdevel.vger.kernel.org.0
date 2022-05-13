Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F96525D82
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 May 2022 10:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378300AbiEMIcq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 May 2022 04:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378326AbiEMIcj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 May 2022 04:32:39 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED362A8077
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 May 2022 01:32:36 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2f825f8c944so66455817b3.15
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 May 2022 01:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hk5uEtV3LYTwsgSEedR4CtG2vms3qpu/B7wOj7VdRzM=;
        b=kYsNC7Eo1NPKL0cqSlEK8e68ZyQYRtrrD4EnKB7z+KZUKXD6WFKCXPMla4tDAyiQIg
         R1v92Ef6+EDCeojrvVKCFLPHuTXNldGmrN3nb9HL03DPkjJYrcMFg+FEzjRUKnv41p52
         DaTPHxS5FuqN17a+jcm7VV3rkWuvNzYSRlAFDZ1WVlmZkoCNSAgwxJJ6kx1/K1dpk8UB
         oLOfeDKbeXB/4ENa6HPZYZL19N2I5sPvx4Acjap9xrQm9O0s0oit88YP4JxMHjYgoid+
         UzSwLRjFMOKiGSVr/IAHMiXkp3ltx/Ft57LuU27hwohf3PH9UIVrKDk0ITX5r4ZD9gmV
         /XZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hk5uEtV3LYTwsgSEedR4CtG2vms3qpu/B7wOj7VdRzM=;
        b=y28GPIA77wC02IL+D7Oc7woG/54rnU3xO61764zfJlvyDnvAOx8OP9zKj/OhuDV75f
         7s/ayHvIHwOG5TEnLYJZQBmCLqKs4BeDM7eKp8Z1E5HqMXgXqwYJq5Jf9zB7uBNTG88J
         icLuOZUsWy6ELa95qJpdqtwHXQyp4nZhIJ57Yza+fHtUFQPqSq6DjMfaBSR3WziGB5kL
         CGb6nTYPAqmazJjMF3RaO+/0cU2etq4ob+v6JQ5fyYP9FdbUPwiQs0Q3yXZHzE63wgpY
         r3dCSsb2pgrIu9j58/YPrT8miT21smfEhb3u3XcPCbShUYFEoMlyw5wgo43/mNR0cg66
         X1ww==
X-Gm-Message-State: AOAM532KKKWKk6Nsx5VmT13iHRsOBwKv7273Fal4F5lvgHCTPehzvNbG
        UsqXlY+2PnHLVa1bzs7eQsI7yY0nUraCUw==
X-Google-Smtp-Source: ABdhPJw+htFPIH6EdUeS8xrLV26f4EOL11gNUDqQ9wJshw5TbY2Hsc8UJKgk0N0pjRBQIDiAvH1OrXDakVEOHQ==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a25:4902:0:b0:648:d1db:af83 with SMTP id
 w2-20020a254902000000b00648d1dbaf83mr3678022yba.559.1652430756152; Fri, 13
 May 2022 01:32:36 -0700 (PDT)
Date:   Fri, 13 May 2022 16:32:13 +0800
In-Reply-To: <20220429043913.626647-1-davidgow@google.com>
Message-Id: <20220513083212.3537869-3-davidgow@google.com>
Mime-Version: 1.0
References: <20220429043913.626647-1-davidgow@google.com>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH v3 3/3] selftest: Taint kernel when test module loaded
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>
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
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
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
kernel. These modules will have to be manually modified if they should
taint the kernel this way.

Similarly, selftests which do not load modules into the kernel generally
should not taint the kernel (or possibly should only do so on failure),
as it's assumed that testing from user-space should be safe. Regardless,
they can write to /proc/sys/kernel/tainted if required.

Signed-off-by: David Gow <davidgow@google.com>
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
2.36.0.550.gb090851708-goog

