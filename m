Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD3122FDF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2019 11:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730354AbfETJJt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 May 2019 05:09:49 -0400
Received: from master.debian.org ([82.195.75.110]:47354 "EHLO
        master.debian.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbfETJJt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 May 2019 05:09:49 -0400
X-Greylist: delayed 468 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 May 2019 05:09:47 EDT
Received: from pabs by master.debian.org with local (Exim 4.89)
        (envelope-from <pabs@master.debian.org>)
        id 1hSeAn-0004YE-6T; Mon, 20 May 2019 09:01:33 +0000
From:   Paul Wise <pabs3@bonedaddy.net>
To:     Neil Horman <nhorman@tuxdriver.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Paul Wise <pabs3@bonedaddy.net>, Jakub Wilk <jwilk@jwilk.net>
Subject: [PATCH] coredump: Split pipe command whitespace before expanding template
Date:   Mon, 20 May 2019 17:01:15 +0800
Message-Id: <20190520090115.11276-1-pabs3@bonedaddy.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <c8b7ecb8508895bf4adb62a748e2ea2c71854597.camel@bonedaddy.net>
References: <c8b7ecb8508895bf4adb62a748e2ea2c71854597.camel@bonedaddy.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Save the offsets of the start of each argument to avoid having to
update pointers to each argument after every corename krealloc and
to avoid having to duplicate the memory for the dump command.

Executable names containing spaces were previously being expanded from
%e or %E and then split in the middle of the filename. This is incorrect
behaviour since an argument list can represent arguments with spaces.

The splitting could lead to extra arguments being passed to the core dump
handler that it might have interpreted as options or ignored completely.

Core dump handlers that are not aware of this Linux kernel issue will be
using %e or %E without considering that it may be split and so they will
be vulnerable to processes with spaces in their names breaking their
argument list. If their internals are otherwise well written, such as
if they are written in shell but quote arguments, they will work better
after this change than before. If they are not well written, then there
is a slight chance of breakage depending on the details of the code but
they will already be fairly broken by the split filenames.

Core dump handlers that are aware of this Linux kernel issue will be
placing %e or %E as the last item in their core_pattern and then
aggregating all of the remaining arguments into one, separated by
spaces. Alternatively they will be obtaining the filename via other
methods. Both of these will be compatible with the new arrangement.

A side effect from this change is that unknown template types
(for example %z) result in an empty argument to the dump handler
instead of the argument being dropped. This is a desired change as:

It is easier for dump handlers to process empty arguments than dropped
ones, especially if they are written in shell or don't pass each template
item with a preceding command-line option in order to differentiate
between individual template types. Most core_patterns in the wild do not
use options so they can confuse different template types (especially
numeric ones) if an earlier one gets dropped in old kernels. If the
kernel introduces a new template type and a core_pattern uses it, the
core dump handler might not expect that the argument can be dropped in
old kernels.

For example, this can result in security issues when %d is dropped in old
kernels. This happened with the corekeeper package in Debian and resulted
in the interface between corekeeper and Linux having to be rewritten to
use command-line options to differentiate between template types.

The core_pattern for most core dump handlers is written by the handler
author who would generally not insert unknown template types so this
change should be compatible with all the core dump handlers that exist.

Reported-by: Jakub Wilk <jwilk@jwilk.net>
Reported-in: <20190312145043.jxjoj66kqssptolr@jwilk.net>
Reported-by: Paul Wise <pabs3@bonedaddy.net>
Reported-in: <c8b7ecb8508895bf4adb62a748e2ea2c71854597.camel@bonedaddy.net>
Suggestions-from: Jakub Wilk <jwilk@jwilk.net>
Signed-off-by: Paul Wise <pabs3@bonedaddy.net>
See-also: https://bugs.debian.org/924398
Fixes: commit 74aadce986052f20088c2678f589ea0e8d3a4b59
---
 fs/coredump.c | 45 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 40 insertions(+), 5 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index e42e17e55bfd..40c440efb5f4 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -7,6 +7,7 @@
 #include <linux/stat.h>
 #include <linux/fcntl.h>
 #include <linux/swap.h>
+#include <linux/ctype.h>
 #include <linux/string.h>
 #include <linux/init.h>
 #include <linux/pagemap.h>
@@ -187,11 +188,13 @@ static int cn_print_exe_file(struct core_name *cn)
  * name into corename, which must have space for at least
  * CORENAME_MAX_SIZE bytes plus one byte for the zero terminator.
  */
-static int format_corename(struct core_name *cn, struct coredump_params *cprm)
+static int format_corename(struct core_name *cn, struct coredump_params *cprm,
+			   size_t **argv, int *argc)
 {
 	const struct cred *cred = current_cred();
 	const char *pat_ptr = core_pattern;
 	int ispipe = (*pat_ptr == '|');
+	bool was_space = false;
 	int pid_in_pattern = 0;
 	int err = 0;
 
@@ -201,12 +204,36 @@ static int format_corename(struct core_name *cn, struct coredump_params *cprm)
 		return -ENOMEM;
 	cn->corename[0] = '\0';
 
-	if (ispipe)
+	if (ispipe) {
+		/* sizeof(core_pattern) / 2 is the maximum number of args. */
+		int argvs = sizeof(core_pattern) / 2;
+		(*argvs) = kmalloc_array(argvs, sizeof(**argv), GFP_KERNEL);
+		if (!(*argv))
+			return -ENOMEM;
+		(*argv)[(*argc)++] = 0;
 		++pat_ptr;
+	}
 
 	/* Repeat as long as we have more pattern to process and more output
 	   space */
 	while (*pat_ptr) {
+		/*
+		 * Split on spaces before doing template expansion so that
+		 * %e and %E don't get split if they have spaces in them
+		 */
+		if (ispipe) {
+			if (isspace(*pat_ptr)) {
+				was_space = true;
+				pat_ptr++;
+				continue;
+			} else if (was_space) {
+				was_space = false;
+				err = cn_printf(cn, "%c", '\0');
+				if (err)
+					return err;
+				(*argv)[(*argc)++] = cn->used;
+			}
+		}
 		if (*pat_ptr != '%') {
 			err = cn_printf(cn, "%c", *pat_ptr++);
 		} else {
@@ -546,6 +573,8 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 	struct cred *cred;
 	int retval = 0;
 	int ispipe;
+	size_t *argv = NULL;
+	int argc = 0;
 	struct files_struct *displaced;
 	/* require nonrelative corefile path and be extra careful */
 	bool need_suid_safe = false;
@@ -592,9 +621,10 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 
 	old_cred = override_creds(cred);
 
-	ispipe = format_corename(&cn, &cprm);
+	ispipe = format_corename(&cn, &cprm, &argv, &argc);
 
 	if (ispipe) {
+		int argi;
 		int dump_count;
 		char **helper_argv;
 		struct subprocess_info *sub_info;
@@ -637,12 +667,16 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 			goto fail_dropcount;
 		}
 
-		helper_argv = argv_split(GFP_KERNEL, cn.corename, NULL);
+		helper_argv = kmalloc_array(argc + 1, sizeof(*helper_argv),
+					    GFP_KERNEL);
 		if (!helper_argv) {
 			printk(KERN_WARNING "%s failed to allocate memory\n",
 			       __func__);
 			goto fail_dropcount;
 		}
+		for (argi = 0; argi < argc; argi++)
+			helper_argv[argi] = cn.corename + argv[argi];
+		helper_argv[argi] = NULL;
 
 		retval = -ENOMEM;
 		sub_info = call_usermodehelper_setup(helper_argv[0],
@@ -652,7 +686,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 			retval = call_usermodehelper_exec(sub_info,
 							  UMH_WAIT_EXEC);
 
-		argv_free(helper_argv);
+		kfree(helper_argv);
 		if (retval) {
 			printk(KERN_INFO "Core dump to |%s pipe failed\n",
 			       cn.corename);
@@ -766,6 +800,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 	if (ispipe)
 		atomic_dec(&core_dump_count);
 fail_unlock:
+	kfree(argv);
 	kfree(cn.corename);
 	coredump_finish(mm, core_dumped);
 	revert_creds(old_cred);
-- 
2.20.1

