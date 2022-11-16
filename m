Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78C4C62B883
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 11:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbiKPKch (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Nov 2022 05:32:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232715AbiKPKcC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Nov 2022 05:32:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390C9326EB
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Nov 2022 02:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668594458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CRZgYtQk0WJDMWcPE6Ik5l6ROIQ+8KCPRqImipF7TGM=;
        b=G77qpFjMAfhSNiBU8595iqSDWhZ3c4iOqoUIwX4tPlbwO/wzCjGYftm8vZqdqr/QwJmtIo
        Y6MDyqSj5feh6hi/lSJ0cncGx5ttIYhOS0Bxx4+P3ob1uh0LyGNXBNQMoMhFrKUgU53uqS
        hS2p39s2QfE4fCusqspTeFlNf0MGvhQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-625-ccCkLAZZNOS2K5RcgvoY3g-1; Wed, 16 Nov 2022 05:27:33 -0500
X-MC-Unique: ccCkLAZZNOS2K5RcgvoY3g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 33AAD3C0F66D;
        Wed, 16 Nov 2022 10:27:31 +0000 (UTC)
Received: from t480s.fritz.box (unknown [10.39.193.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C9DEA2028CE4;
        Wed, 16 Nov 2022 10:27:23 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-samsung-soc@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-perf-users@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Peter Xu <peterx@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>, Nadav Amit <namit@vmware.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Shuah Khan <shuah@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH mm-unstable v1 01/20] selftests/vm: anon_cow: prepare for non-anonymous COW tests
Date:   Wed, 16 Nov 2022 11:26:40 +0100
Message-Id: <20221116102659.70287-2-david@redhat.com>
In-Reply-To: <20221116102659.70287-1-david@redhat.com>
References: <20221116102659.70287-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Originally, the plan was to have a separate tests for testing COW of
non-anonymous (e.g., shared zeropage) pages.

Turns out, that we'd need a lot of similar functionality and that there
isn't a really good reason to separate it. So let's prepare for non-anon
tests by renaming to "cow".

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 tools/testing/selftests/vm/.gitignore         |  2 +-
 tools/testing/selftests/vm/Makefile           | 10 ++++----
 tools/testing/selftests/vm/check_config.sh    |  4 +--
 .../selftests/vm/{anon_cow.c => cow.c}        | 25 +++++++++++--------
 tools/testing/selftests/vm/run_vmtests.sh     |  8 +++---
 5 files changed, 27 insertions(+), 22 deletions(-)
 rename tools/testing/selftests/vm/{anon_cow.c => cow.c} (97%)

diff --git a/tools/testing/selftests/vm/.gitignore b/tools/testing/selftests/vm/.gitignore
index 8a536c731e3c..ee8c41c998e6 100644
--- a/tools/testing/selftests/vm/.gitignore
+++ b/tools/testing/selftests/vm/.gitignore
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
-anon_cow
+cow
 hugepage-mmap
 hugepage-mremap
 hugepage-shm
diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
index 0986bd60c19f..89c14e41bd43 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -27,7 +27,7 @@ MAKEFLAGS += --no-builtin-rules
 
 CFLAGS = -Wall -I $(top_srcdir) -I $(top_srcdir)/usr/include $(EXTRA_CFLAGS) $(KHDR_INCLUDES)
 LDLIBS = -lrt -lpthread
-TEST_GEN_FILES = anon_cow
+TEST_GEN_FILES = cow
 TEST_GEN_FILES += compaction_test
 TEST_GEN_FILES += gup_test
 TEST_GEN_FILES += hmm-tests
@@ -99,7 +99,7 @@ TEST_FILES += va_128TBswitch.sh
 
 include ../lib.mk
 
-$(OUTPUT)/anon_cow: vm_util.c
+$(OUTPUT)/cow: vm_util.c
 $(OUTPUT)/khugepaged: vm_util.c
 $(OUTPUT)/ksm_functional_tests: vm_util.c
 $(OUTPUT)/madv_populate: vm_util.c
@@ -156,8 +156,8 @@ warn_32bit_failure:
 endif
 endif
 
-# ANON_COW_EXTRA_LIBS may get set in local_config.mk, or it may be left empty.
-$(OUTPUT)/anon_cow: LDLIBS += $(ANON_COW_EXTRA_LIBS)
+# cow_EXTRA_LIBS may get set in local_config.mk, or it may be left empty.
+$(OUTPUT)/cow: LDLIBS += $(COW_EXTRA_LIBS)
 
 $(OUTPUT)/mlock-random-test $(OUTPUT)/memfd_secret: LDLIBS += -lcap
 
@@ -170,7 +170,7 @@ local_config.mk local_config.h: check_config.sh
 
 EXTRA_CLEAN += local_config.mk local_config.h
 
-ifeq ($(ANON_COW_EXTRA_LIBS),)
+ifeq ($(COW_EXTRA_LIBS),)
 all: warn_missing_liburing
 
 warn_missing_liburing:
diff --git a/tools/testing/selftests/vm/check_config.sh b/tools/testing/selftests/vm/check_config.sh
index 9a44c6520925..bcba3af0acea 100644
--- a/tools/testing/selftests/vm/check_config.sh
+++ b/tools/testing/selftests/vm/check_config.sh
@@ -21,11 +21,11 @@ $CC -c $tmpfile_c -o $tmpfile_o >/dev/null 2>&1
 
 if [ -f $tmpfile_o ]; then
     echo "#define LOCAL_CONFIG_HAVE_LIBURING 1"  > $OUTPUT_H_FILE
-    echo "ANON_COW_EXTRA_LIBS = -luring"         > $OUTPUT_MKFILE
+    echo "COW_EXTRA_LIBS = -luring"              > $OUTPUT_MKFILE
 else
     echo "// No liburing support found"          > $OUTPUT_H_FILE
     echo "# No liburing support found, so:"      > $OUTPUT_MKFILE
-    echo "ANON_COW_EXTRA_LIBS = "               >> $OUTPUT_MKFILE
+    echo "COW_EXTRA_LIBS = "                    >> $OUTPUT_MKFILE
 fi
 
 rm ${tmpname}.*
diff --git a/tools/testing/selftests/vm/anon_cow.c b/tools/testing/selftests/vm/cow.c
similarity index 97%
rename from tools/testing/selftests/vm/anon_cow.c
rename to tools/testing/selftests/vm/cow.c
index bbb251eb5025..d202bfd63585 100644
--- a/tools/testing/selftests/vm/anon_cow.c
+++ b/tools/testing/selftests/vm/cow.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * COW (Copy On Write) tests for anonymous memory.
+ * COW (Copy On Write) tests.
  *
  * Copyright 2022, Red Hat, Inc.
  *
@@ -986,7 +986,11 @@ struct test_case {
 	test_fn fn;
 };
 
-static const struct test_case test_cases[] = {
+/*
+ * Test cases that are specific to anonymous pages: pages in private mappings
+ * that may get shared via COW during fork().
+ */
+static const struct test_case anon_test_cases[] = {
 	/*
 	 * Basic COW tests for fork() without any GUP. If we miss to break COW,
 	 * either the child can observe modifications by the parent or the
@@ -1104,7 +1108,7 @@ static const struct test_case test_cases[] = {
 	},
 };
 
-static void run_test_case(struct test_case const *test_case)
+static void run_anon_test_case(struct test_case const *test_case)
 {
 	int i;
 
@@ -1125,15 +1129,17 @@ static void run_test_case(struct test_case const *test_case)
 				 hugetlbsizes[i]);
 }
 
-static void run_test_cases(void)
+static void run_anon_test_cases(void)
 {
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(test_cases); i++)
-		run_test_case(&test_cases[i]);
+	ksft_print_msg("[INFO] Anonymous memory tests in private mappings\n");
+
+	for (i = 0; i < ARRAY_SIZE(anon_test_cases); i++)
+		run_anon_test_case(&anon_test_cases[i]);
 }
 
-static int tests_per_test_case(void)
+static int tests_per_anon_test_case(void)
 {
 	int tests = 2 + nr_hugetlbsizes;
 
@@ -1144,7 +1150,6 @@ static int tests_per_test_case(void)
 
 int main(int argc, char **argv)
 {
-	int nr_test_cases = ARRAY_SIZE(test_cases);
 	int err;
 
 	pagesize = getpagesize();
@@ -1152,14 +1157,14 @@ int main(int argc, char **argv)
 	detect_hugetlbsizes();
 
 	ksft_print_header();
-	ksft_set_plan(nr_test_cases * tests_per_test_case());
+	ksft_set_plan(ARRAY_SIZE(anon_test_cases) * tests_per_anon_test_case());
 
 	gup_fd = open("/sys/kernel/debug/gup_test", O_RDWR);
 	pagemap_fd = open("/proc/self/pagemap", O_RDONLY);
 	if (pagemap_fd < 0)
 		ksft_exit_fail_msg("opening pagemap failed\n");
 
-	run_test_cases();
+	run_anon_test_cases();
 
 	err = ksft_get_fail_cnt();
 	if (err)
diff --git a/tools/testing/selftests/vm/run_vmtests.sh b/tools/testing/selftests/vm/run_vmtests.sh
index ce52e4f5ff21..71744b9002d0 100755
--- a/tools/testing/selftests/vm/run_vmtests.sh
+++ b/tools/testing/selftests/vm/run_vmtests.sh
@@ -50,8 +50,8 @@ separated by spaces:
 	memory protection key tests
 - soft_dirty
 	test soft dirty page bit semantics
-- anon_cow
-	test anonymous copy-on-write semantics
+- cow
+	test copy-on-write semantics
 example: ./run_vmtests.sh -t "hmm mmap ksm"
 EOF
 	exit 0
@@ -267,7 +267,7 @@ fi
 
 CATEGORY="soft_dirty" run_test ./soft-dirty
 
-# COW tests for anonymous memory
-CATEGORY="anon_cow" run_test ./anon_cow
+# COW tests
+CATEGORY="cow" run_test ./cow
 
 exit $exitcode
-- 
2.38.1

