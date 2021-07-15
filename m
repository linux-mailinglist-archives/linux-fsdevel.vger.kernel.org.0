Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEF763C957F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 03:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbhGOBR3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jul 2021 21:17:29 -0400
Received: from foss.arm.com ([217.140.110.172]:45100 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233625AbhGOBR3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jul 2021 21:17:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB9E811FB;
        Wed, 14 Jul 2021 18:14:36 -0700 (PDT)
Received: from entos-ampere-02.shanghai.arm.com (entos-ampere-02.shanghai.arm.com [10.169.214.103])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C3CAE3F7D8;
        Wed, 14 Jul 2021 18:14:31 -0700 (PDT)
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
Subject: [PATCH v7 3/5] lib/vsprintf.c: make '%pD' print the full path of file
Date:   Thu, 15 Jul 2021 09:14:05 +0800
Message-Id: <20210715011407.7449-4-justin.he@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210715011407.7449-1-justin.he@arm.com>
References: <20210715011407.7449-1-justin.he@arm.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Previously, the specifier '%pD' was for printing dentry name of struct
file. It may not be perfect since by default it only prints one component.

As suggested by Linus [1]:
  A dentry has a parent, but at the same time, a dentry really does
  inherently have "one name" (and given just the dentry pointers, you
  can't show mount-related parenthood, so in many ways the "show just
  one name" makes sense for "%pd" in ways it doesn't necessarily for
  "%pD"). But while a dentry arguably has that "one primary component",
  a _file_ is certainly not exclusively about that last component.

Hence change the behavior of '%pD' to print the full path of that file.
It is worthy of noting that %pD uses the entire given buffer as a scratch
space. It might write something behind the trailing '\0' but never write
beyond the scratch space.

Precision specifier is never going to be used with %p (or any of its
kernel extensions) if -Wformat is turned on.

Link: https://lore.kernel.org/lkml/CAHk-=wimsMqGdzik187YWLb-ru+iktb4MYbMQG1rnZ81dXYFVg@mail.gmail.com/ [1]
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Jia He <justin.he@arm.com>
---
 Documentation/core-api/printk-formats.rst |  7 ++--
 lib/vsprintf.c                            | 40 ++++++++++++++++++++---
 2 files changed, 41 insertions(+), 6 deletions(-)

diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
index d941717a191b..15d6f1057b66 100644
--- a/Documentation/core-api/printk-formats.rst
+++ b/Documentation/core-api/printk-formats.rst
@@ -418,12 +418,15 @@ dentry names
 ::
 
 	%pd{,2,3,4}
-	%pD{,2,3,4}
+	%pD
 
 For printing dentry name; if we race with :c:func:`d_move`, the name might
 be a mix of old and new ones, but it won't oops.  %pd dentry is a safer
 equivalent of %s dentry->d_name.name we used to use, %pd<n> prints ``n``
-last components.  %pD does the same thing for struct file.
+last components. %pD prints full file path together with mount-related
+parenthood. %pD uses the entire given buffer as a scratch space. It might
+write something behind the trailing '\0' but never write beyond the
+scratch space.
 
 Passed by reference.
 
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 26c83943748a..e65799292745 100644
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
@@ -947,13 +948,44 @@ char *dentry_name(char *buf, char *end, const struct dentry *d, struct printf_sp
 }
 
 static noinline_for_stack
-char *file_dentry_name(char *buf, char *end, const struct file *f,
+char *file_d_path_name(char *buf, char *end, const struct file *f,
 			struct printf_spec spec, const char *fmt)
 {
+	int prepend_len, widen_len, dpath_len;
+	const struct path *path;
+	char *p;
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
+	 * the field width is greater than the full path length.
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
@@ -2341,7 +2373,7 @@ early_param("no_hash_pointers", no_hash_pointers_enable);
  * - 'a[pd]' For address types [p] phys_addr_t, [d] dma_addr_t and derivatives
  *           (default assumed to be phys_addr_t, passed by reference)
  * - 'd[234]' For a dentry name (optionally 2-4 last components)
- * - 'D[234]' Same as 'd' but for a struct file
+ * - 'D' For the full path name of a struct file
  * - 'g' For block_device name (gendisk + partition number)
  * - 't[RT][dt][r][s]' For time and date as represented by:
  *      R    struct rtc_time
@@ -2440,7 +2472,7 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
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

