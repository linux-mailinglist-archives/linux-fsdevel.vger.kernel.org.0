Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6573A8537
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 17:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbhFOPyF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 11:54:05 -0400
Received: from foss.arm.com ([217.140.110.172]:39130 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231766AbhFOPw3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 11:52:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71922143D;
        Tue, 15 Jun 2021 08:50:24 -0700 (PDT)
Received: from entos-ampere-02.shanghai.arm.com (entos-ampere-02.shanghai.arm.com [10.169.214.103])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C1CAC3F694;
        Tue, 15 Jun 2021 08:50:19 -0700 (PDT)
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
        Jia He <justin.he@arm.com>
Subject: [PATCH RFCv4 4/4] lib/test_printf.c: add test cases for '%pD'
Date:   Tue, 15 Jun 2021 23:49:52 +0800
Message-Id: <20210615154952.2744-5-justin.he@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210615154952.2744-1-justin.he@arm.com>
References: <20210615154952.2744-1-justin.he@arm.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

After the behaviour of specifier '%pD' is changed to print full path
of struct file, the related test cases are also updated.

Given the string of '%pD' is prepended from the end of the buffer, the
check of "wrote beyond the nul-terminator" should be skipped.

Signed-off-by: Jia He <justin.he@arm.com>
---
 lib/test_printf.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/lib/test_printf.c b/lib/test_printf.c
index d1d2f898ebae..9f851a82b3af 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -16,6 +16,7 @@
 
 #include <linux/bitmap.h>
 #include <linux/dcache.h>
+#include <linux/fs.h>
 #include <linux/socket.h>
 #include <linux/in.h>
 
@@ -34,6 +35,7 @@ KSTM_MODULE_GLOBALS();
 
 static char *test_buffer __initdata;
 static char *alloced_buffer __initdata;
+static bool is_prepended_buf __initdata;
 
 extern bool no_hash_pointers;
 
@@ -78,7 +80,7 @@ do_test(int bufsize, const char *expect, int elen,
 		return 1;
 	}
 
-	if (memchr_inv(test_buffer + written + 1, FILL_CHAR, bufsize - (written + 1))) {
+	if (!is_prepended_buf && memchr_inv(test_buffer + written + 1, FILL_CHAR, bufsize - (written + 1))) {
 		pr_warn("vsnprintf(buf, %d, \"%s\", ...) wrote beyond the nul-terminator\n",
 			bufsize, fmt);
 		return 1;
@@ -501,6 +503,27 @@ dentry(void)
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
+	is_prepended_buf = true;
+	test("/bravo/alfa   |/bravo/alfa   ", "%-14pD|%*pD", &test_file, -14, &test_file);
+	test("   /bravo/alfa|   /bravo/alfa", "%14pD|%*pD", &test_file, 14, &test_file);
+	test("   /bravo/alfa|/bravo/alfa   ", "%14pD|%-14pD", &test_file, &test_file);
+	is_prepended_buf = false;
+}
+
 static void __init
 struct_va_format(void)
 {
@@ -784,6 +807,7 @@ test_pointer(void)
 	ip();
 	uuid();
 	dentry();
+	f_d_path();
 	struct_va_format();
 	time_and_date();
 	struct_clk();
-- 
2.17.1

