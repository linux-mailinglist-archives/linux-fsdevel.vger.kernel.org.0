Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C91983C9585
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 03:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234577AbhGOBRl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jul 2021 21:17:41 -0400
Received: from foss.arm.com ([217.140.110.172]:45156 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234288AbhGOBRk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jul 2021 21:17:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52CDE1396;
        Wed, 14 Jul 2021 18:14:48 -0700 (PDT)
Received: from entos-ampere-02.shanghai.arm.com (entos-ampere-02.shanghai.arm.com [10.169.214.103])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 29DF73F7D8;
        Wed, 14 Jul 2021 18:14:42 -0700 (PDT)
From:   Jia He <justin.he@arm.com>
To:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Eric Biggers <ebiggers@google.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>, nd@arm.com,
        Jia He <justin.he@arm.com>
Subject: [PATCH v7 5/5] lib/test_printf.c: add test cases for '%pD'
Date:   Thu, 15 Jul 2021 09:14:07 +0800
Message-Id: <20210715011407.7449-6-justin.he@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210715011407.7449-1-justin.he@arm.com>
References: <20210715011407.7449-1-justin.he@arm.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

After the behaviour of specifier '%pD' is changed to print the full path
of struct file, the related test cases are also updated.

Given the full path string of '%pD' is prepended from the end of the scratch
buffer, the check of "wrote beyond the nul-terminator" should be skipped
for '%pD'.

Parameterize the new using_scratch_space in __test(), do_test() and wrapper
macros to skip the test case mentioned above,

Signed-off-by: Jia He <justin.he@arm.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/test_printf.c | 49 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 39 insertions(+), 10 deletions(-)

diff --git a/lib/test_printf.c b/lib/test_printf.c
index cabdf9f5fd15..381c9dcd3c2d 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -16,6 +16,7 @@
 
 #include <linux/bitmap.h>
 #include <linux/dcache.h>
+#include <linux/fs.h>
 #include <linux/socket.h>
 #include <linux/in.h>
 
@@ -37,8 +38,8 @@ static char *alloced_buffer __initdata;
 
 extern bool no_hash_pointers;
 
-static int __printf(4, 0) __init
-do_test(int bufsize, const char *expect, int elen,
+static int __printf(5, 0) __init
+do_test(int bufsize, const char *expect, int elen, bool using_scratch_space,
 	const char *fmt, va_list ap)
 {
 	va_list aq;
@@ -78,7 +79,7 @@ do_test(int bufsize, const char *expect, int elen,
 		return 1;
 	}
 
-	if (memchr_inv(test_buffer + written + 1, FILL_CHAR, bufsize - (written + 1))) {
+	if (!using_scratch_space && memchr_inv(test_buffer + written + 1, FILL_CHAR, bufsize - (written + 1))) {
 		pr_warn("vsnprintf(buf, %d, \"%s\", ...) wrote beyond the nul-terminator\n",
 			bufsize, fmt);
 		return 1;
@@ -97,8 +98,9 @@ do_test(int bufsize, const char *expect, int elen,
 	return 0;
 }
 
-static void __printf(3, 4) __init
-__test(const char *expect, int elen, const char *fmt, ...)
+static void __printf(4, 5) __init
+__test(const char *expect, int elen, bool using_scratch_space,
+	const char *fmt, ...)
 {
 	va_list ap;
 	int rand;
@@ -119,11 +121,11 @@ __test(const char *expect, int elen, const char *fmt, ...)
 	 * enough and 0), and then we also test that kvasprintf would
 	 * be able to print it as expected.
 	 */
-	failed_tests += do_test(BUF_SIZE, expect, elen, fmt, ap);
+	failed_tests += do_test(BUF_SIZE, expect, elen, using_scratch_space, fmt, ap);
 	rand = 1 + prandom_u32_max(elen+1);
 	/* Since elen < BUF_SIZE, we have 1 <= rand <= BUF_SIZE. */
-	failed_tests += do_test(rand, expect, elen, fmt, ap);
-	failed_tests += do_test(0, expect, elen, fmt, ap);
+	failed_tests += do_test(rand, expect, elen, using_scratch_space, fmt, ap);
+	failed_tests += do_test(0, expect, elen, using_scratch_space, fmt, ap);
 
 	p = kvasprintf(GFP_KERNEL, fmt, ap);
 	if (p) {
@@ -138,8 +140,15 @@ __test(const char *expect, int elen, const char *fmt, ...)
 	va_end(ap);
 }
 
+/*
+ * More relaxed test for non-standard formats that are using the provided buffer
+ * as a scratch space and write beyond the trailing '\0'.
+ */
+#define test_using_scratch_space(expect, fmt, ...)			\
+	__test(expect, strlen(expect), true, fmt, ##__VA_ARGS__)
+
 #define test(expect, fmt, ...)					\
-	__test(expect, strlen(expect), fmt, ##__VA_ARGS__)
+	__test(expect, strlen(expect), false, fmt, ##__VA_ARGS__)
 
 static void __init
 test_basic(void)
@@ -150,7 +159,7 @@ test_basic(void)
 	test("", &nul);
 	test("100%", "100%%");
 	test("xxx%yyy", "xxx%cyyy", '%');
-	__test("xxx\0yyy", 7, "xxx%cyyy", '\0');
+	__test("xxx\0yyy", 7, false, "xxx%cyyy", '\0');
 }
 
 static void __init
@@ -501,6 +510,25 @@ dentry(void)
 	test("  bravo/alfa|  bravo/alfa", "%12pd2|%*pd2", &test_dentry[2], 12, &test_dentry[2]);
 }
 
+static struct vfsmount test_vfsmnt __initdata = {};
+
+static struct file test_file __initdata = {
+	.f_path = { .dentry = &test_dentry[2],
+		    .mnt = &test_vfsmnt,
+	},
+};
+
+static void __init
+f_d_path(void)
+{
+	test("(null)", "%pD", NULL);
+	test("(efault)", "%pD", PTR_INVALID);
+
+	test_using_scratch_space("/bravo/alfa   |/bravo/alfa   ", "%-14pD|%*pD", &test_file, -14, &test_file);
+	test_using_scratch_space("   /bravo/alfa|   /bravo/alfa", "%14pD|%*pD", &test_file, 14, &test_file);
+	test_using_scratch_space("   /bravo/alfa|/bravo/alfa   ", "%14pD|%-14pD", &test_file, &test_file);
+}
+
 static void __init
 struct_va_format(void)
 {
@@ -789,6 +817,7 @@ test_pointer(void)
 	ip();
 	uuid();
 	dentry();
+	f_d_path();
 	struct_va_format();
 	time_and_date();
 	struct_clk();
-- 
2.17.1

