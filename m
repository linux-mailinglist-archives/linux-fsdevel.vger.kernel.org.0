Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 699563771BD
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 May 2021 14:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbhEHMa3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 May 2021 08:30:29 -0400
Received: from foss.arm.com ([217.140.110.172]:53616 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231174AbhEHMa1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 May 2021 08:30:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B0F0C11D4;
        Sat,  8 May 2021 05:29:25 -0700 (PDT)
Received: from entos-ampere-02.shanghai.arm.com (entos-ampere-02.shanghai.arm.com [10.169.214.110])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3E5EA3F73B;
        Sat,  8 May 2021 05:29:18 -0700 (PDT)
From:   Jia He <justin.he@arm.com>
To:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@ftp.linux.org.uk>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Eric Biggers <ebiggers@google.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jia He <justin.he@arm.com>
Subject: [PATCH RFC 2/3] lib/vsprintf.c: make %pD print full path for file
Date:   Sat,  8 May 2021 20:25:29 +0800
Message-Id: <20210508122530.1971-3-justin.he@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210508122530.1971-1-justin.he@arm.com>
References: <20210508122530.1971-1-justin.he@arm.com>
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

Hence "file_dentry_name()" simply shouldn't use "dentry_name()" at all.
Despite that shared code origin, and despite that similar letter
choice (lower-vs-upper case), a dentry and a file really are very
different from a name standpoint.

[1] https://lore.kernel.org/lkml/CAHk-=wimsMqGdzik187YWLb-ru+iktb4MYbMQG1rnZ81dXYFVg@mail.gmail.com/

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Jia He <justin.he@arm.com>
---
 Documentation/core-api/printk-formats.rst |  5 +++--
 lib/vsprintf.c                            | 12 ++++++++++--
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
index f063a384c7c8..6770130d32c8 100644
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
+last components.  %pD does the same thing for struct file and prints full
+file path together with mount-related parenthood.
 
 Passed by reference.
 
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index f0c35d9b65bf..8220ab1411c5 100644
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
@@ -923,10 +924,17 @@ static noinline_for_stack
 char *file_dentry_name(char *buf, char *end, const struct file *f,
 			struct printf_spec spec, const char *fmt)
 {
+	const struct path *path = &f->f_path;
+	char *p;
+	char tmp[128];
+
 	if (check_pointer(&buf, end, f, spec))
 		return buf;
 
-	return dentry_name(buf, end, f->f_path.dentry, spec, fmt);
+	p = d_path_fast(path, (char *)tmp, 128);
+	buf = string(buf, end, p, spec);
+
+	return buf;
 }
 #ifdef CONFIG_BLOCK
 static noinline_for_stack
@@ -2296,7 +2304,7 @@ early_param("no_hash_pointers", no_hash_pointers_enable);
  * - 'a[pd]' For address types [p] phys_addr_t, [d] dma_addr_t and derivatives
  *           (default assumed to be phys_addr_t, passed by reference)
  * - 'd[234]' For a dentry name (optionally 2-4 last components)
- * - 'D[234]' Same as 'd' but for a struct file
+ * - 'D' Same as 'd' but for a struct file
  * - 'g' For block_device name (gendisk + partition number)
  * - 't[RT][dt][r]' For time and date as represented by:
  *      R    struct rtc_time
-- 
2.17.1

