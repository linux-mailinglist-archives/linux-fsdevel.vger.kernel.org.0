Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB5F03A45DD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jun 2021 18:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbhFKQCW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Jun 2021 12:02:22 -0400
Received: from foss.arm.com ([217.140.110.172]:33770 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230387AbhFKQCT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Jun 2021 12:02:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E54AC143D;
        Fri, 11 Jun 2021 09:00:20 -0700 (PDT)
Received: from entos-ampere-02.shanghai.arm.com (entos-ampere-02.shanghai.arm.com [10.169.214.103])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 84F103F719;
        Fri, 11 Jun 2021 09:00:16 -0700 (PDT)
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
        linux-fsdevel@vger.kernel.org, Jia He <justin.he@arm.com>
Subject: [PATCH RFCv3 2/3] lib/vsprintf.c: make %pD print full path for file
Date:   Fri, 11 Jun 2021 23:59:52 +0800
Message-Id: <20210611155953.3010-3-justin.he@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210611155953.3010-1-justin.he@arm.com>
References: <20210611155953.3010-1-justin.he@arm.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We have '%pD' for printing a filename. It may not be perfect (by
default it only prints one component.)

As suggested by Linus at [1]:
A dentry has a parent, but at the same time, a dentry really does
inherently have "one name" (and given just the dentry pointers, you
can't show mount-related parenthood, so in many ways the "show just
one name" makes sense for "%pd" in ways it doesn't necessarily for
"%pD"). But while a dentry arguably has that "one primary component",
a _file_ is certainly not exclusively about that last component.

Hence change the behavior of '%pD' to print full path of that file.

Things become more complicated when spec.precision and spec.field_width
is added in. string_truncate() is to handle the small space case for
'%pD' precision and field_width.

[1] https://lore.kernel.org/lkml/CAHk-=wimsMqGdzik187YWLb-ru+iktb4MYbMQG1rnZ81dXYFVg@mail.gmail.com/

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Jia He <justin.he@arm.com>
---
 Documentation/core-api/printk-formats.rst |  5 ++-
 lib/vsprintf.c                            | 47 +++++++++++++++++++++--
 2 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
index f063a384c7c8..95ba14dc529b 100644
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
+last components.  %pD prints full file path together with mount-related
+parenthood.
 
 Passed by reference.
 
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index f0c35d9b65bf..317b65280252 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -27,6 +27,7 @@
 #include <linux/string.h>
 #include <linux/ctype.h>
 #include <linux/kernel.h>
+#include <linux/dcache.h>
 #include <linux/kallsyms.h>
 #include <linux/math64.h>
 #include <linux/uaccess.h>
@@ -601,6 +602,20 @@ char *widen_string(char *buf, int n, char *end, struct printf_spec spec)
 }
 
 /* Handle string from a well known address. */
+static char *string_truncate(char *buf, char *end, const char *s,
+			     u32 full_len, struct printf_spec spec)
+{
+	int lim = 0;
+
+	if (buf < end) {
+		if (spec.precision >= 0)
+			lim = strlen(s) - min_t(int, spec.precision, strlen(s));
+
+		return widen_string(buf + full_len, full_len, end - lim, spec);
+	}
+
+	return buf;
+}
 static char *string_nocheck(char *buf, char *end, const char *s,
 			    struct printf_spec spec)
 {
@@ -920,13 +935,37 @@ char *dentry_name(char *buf, char *end, const struct dentry *d, struct printf_sp
 }
 
 static noinline_for_stack
-char *file_dentry_name(char *buf, char *end, const struct file *f,
+char *file_d_path_name(char *buf, char *end, const struct file *f,
 			struct printf_spec spec, const char *fmt)
 {
+	const struct path *path;
+	char *p;
+	int prepend_len, reserved_size, dpath_len;
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
+	/* Minus 1 byte for '\0' */
+	dpath_len = end - buf - prepend_len - 1;
+
+	reserved_size = max_t(int, dpath_len, spec.field_width);
+
+	/* no filling space at all */
+	if (buf >= end || !buf)
+		return buf + reserved_size;
+
+	/* small space for long name */
+	if (buf < end && prepend_len < 0)
+		return string_truncate(buf, end, p, dpath_len, spec);
+
+	/* space is enough */
+	return string_nocheck(buf, end, p, spec);
 }
 #ifdef CONFIG_BLOCK
 static noinline_for_stack
@@ -2296,7 +2335,7 @@ early_param("no_hash_pointers", no_hash_pointers_enable);
  * - 'a[pd]' For address types [p] phys_addr_t, [d] dma_addr_t and derivatives
  *           (default assumed to be phys_addr_t, passed by reference)
  * - 'd[234]' For a dentry name (optionally 2-4 last components)
- * - 'D[234]' Same as 'd' but for a struct file
+ * - 'D' For full path name of a struct file
  * - 'g' For block_device name (gendisk + partition number)
  * - 't[RT][dt][r]' For time and date as represented by:
  *      R    struct rtc_time
@@ -2395,7 +2434,7 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
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

