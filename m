Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCFF3B1370
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 07:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbhFWFxE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 01:53:04 -0400
Received: from foss.arm.com ([217.140.110.172]:58000 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229998AbhFWFxB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 01:53:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01D96106F;
        Tue, 22 Jun 2021 22:50:44 -0700 (PDT)
Received: from entos-ampere-02.shanghai.arm.com (entos-ampere-02.shanghai.arm.com [10.169.214.103])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CB2753F694;
        Tue, 22 Jun 2021 22:50:38 -0700 (PDT)
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
Subject: [PATCH v2 2/4] lib/vsprintf.c: make '%pD' print the full path of file
Date:   Wed, 23 Jun 2021 13:50:09 +0800
Message-Id: <20210623055011.22916-3-justin.he@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210623055011.22916-1-justin.he@arm.com>
References: <20210623055011.22916-1-justin.he@arm.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Previously, the specifier '%pD' is for printing dentry name of struct
file. It may not be perfect (by default it only prints one component.)

As suggested by Linus [1]:
> A dentry has a parent, but at the same time, a dentry really does
> inherently have "one name" (and given just the dentry pointers, you
> can't show mount-related parenthood, so in many ways the "show just
> one name" makes sense for "%pd" in ways it doesn't necessarily for
> "%pD"). But while a dentry arguably has that "one primary component",
> a _file_ is certainly not exclusively about that last component.

Hence change the behavior of '%pD' to print the full path of that file.

If someone invokes snprintf() with small but positive space,
prepend_name_with_len() moves or truncates the string partially. More
than that, kasprintf() will pass NULL @buf and @end as the parameters,
and @end - @buf can be negative in some case. Hence make it return at
the very beginning with false in these cases.

Precision is never going to be used with %p (or any of its kernel
extensions) if -Wformat is turned on.

Link: https://lore.kernel.org/lkml/CAHk-=wimsMqGdzik187YWLb-ru+iktb4MYbMQG1rnZ81dXYFVg@mail.gmail.com/ [1]
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Jia He <justin.he@arm.com>
---
 Documentation/core-api/printk-formats.rst |  5 +--
 lib/vsprintf.c                            | 40 ++++++++++++++++++++---
 2 files changed, 39 insertions(+), 6 deletions(-)

diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
index f063a384c7c8..3c0d0f90b171 100644
--- a/Documentation/core-api/printk-formats.rst
+++ b/Documentation/core-api/printk-formats.rst
@@ -408,12 +408,13 @@ dentry names
 ::
 
 	%pd{,2,3,4}
-	%pD{,2,3,4}
+	%pD
 
 For printing dentry name; if we race with :c:func:`d_move`, the name might
 be a mix of old and new ones, but it won't oops.  %pd dentry is a safer
 equivalent of %s dentry->d_name.name we used to use, %pd<n> prints ``n``
-last components.  %pD does the same thing for struct file.
+last components. %pD prints full file path together with mount-related
+parenthood.
 
 Passed by reference.
 
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index f0c35d9b65bf..f4494129081f 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -26,6 +26,7 @@
 #include <linux/types.h>
 #include <linux/string.h>
 #include <linux/ctype.h>
+#include <linux/dcache.h>
 #include <linux/kernel.h>
 #include <linux/kallsyms.h>
 #include <linux/math64.h>
@@ -920,13 +921,44 @@ char *dentry_name(char *buf, char *end, const struct dentry *d, struct printf_sp
 }
 
 static noinline_for_stack
-char *file_dentry_name(char *buf, char *end, const struct file *f,
+char *file_d_path_name(char *buf, char *end, const struct file *f,
 			struct printf_spec spec, const char *fmt)
 {
+	char *p;
+	const struct path *path;
+	int prepend_len, widen_len, dpath_len;
+
 	if (check_pointer(&buf, end, f, spec))
 		return buf;
 
-	return dentry_name(buf, end, f->f_path.dentry, spec, fmt);
+	path = &f->f_path;
+	if (check_pointer(&buf, end, path, spec))
+		return buf;
+
+	p = d_path_unsafe(path, buf, end - buf, &prepend_len);
+
+	/* Calculate the full d_path length, ignoring the tail '\0' */
+	dpath_len = end - buf - prepend_len - 1;
+
+	widen_len = max_t(int, dpath_len, spec.field_width);
+
+	/* Case 1: Already started past the buffer. Just forward @buf. */
+	if (buf >= end)
+		return buf + widen_len;
+
+	/*
+	 * Case 2: The entire remaining space of the buffer filled by
+	 * the truncated path. Still need to get moved right when
+	 * the filled width is greather than the full path length.
+	 */
+	if (prepend_len < 0)
+		return widen_string(buf + dpath_len, dpath_len, end, spec);
+
+	/*
+	 * Case 3: The full path is printed at the end of the buffer.
+	 * Print it at the right location in the same buffer.
+	 */
+	return string_nocheck(buf, end, p, spec);
 }
 #ifdef CONFIG_BLOCK
 static noinline_for_stack
@@ -2296,7 +2328,7 @@ early_param("no_hash_pointers", no_hash_pointers_enable);
  * - 'a[pd]' For address types [p] phys_addr_t, [d] dma_addr_t and derivatives
  *           (default assumed to be phys_addr_t, passed by reference)
  * - 'd[234]' For a dentry name (optionally 2-4 last components)
- * - 'D[234]' Same as 'd' but for a struct file
+ * - 'D' For full path name of a struct file
  * - 'g' For block_device name (gendisk + partition number)
  * - 't[RT][dt][r]' For time and date as represented by:
  *      R    struct rtc_time
@@ -2395,7 +2427,7 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 	case 'C':
 		return clock(buf, end, ptr, spec, fmt);
 	case 'D':
-		return file_dentry_name(buf, end, ptr, spec, fmt);
+		return file_d_path_name(buf, end, ptr, spec, fmt);
 #ifdef CONFIG_BLOCK
 	case 'g':
 		return bdev_name(buf, end, ptr, spec, fmt);
-- 
2.17.1

