Return-Path: <linux-fsdevel+bounces-46381-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCC2A884A2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 16:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3CC2190320C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 14:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5C52949E0;
	Mon, 14 Apr 2025 13:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ca23AS7D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B11292934;
	Mon, 14 Apr 2025 13:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744638922; cv=none; b=gz3HQHtE7lbG+ioPdadRHs27/F7n0J/p/wvcdOnQSchC3EHUoOmTihIKROFBozsAbvRBTIP4vn9mphafKQvM8ur3o28Gvggt8UlvFlWhmaVs7lGXMXqm2RMiEs6Ehq916OogEJgMkwax8UfMjg0mnUtKUavcsWamPN8dw7KXQZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744638922; c=relaxed/simple;
	bh=EjPH7+pMyBOIy9AujSxvWyvHYKNLvMJ1UIyKY25E7Qo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OBE+tDP6GCe6DHPEFFFUWXBcrE8iwJJViSrMT/NVq/VC1T4XW0fwlrYqNEM3v5JUTuUORQpQlECZpvMfAWRJoMPynWyOGjLGbfBYIDJeGuKStiSu0i8OLUuTKdLAU3eKuxWUw3vVk1sjXDDuGNj+m3nN2wai2ocT9fhJ3kMLGyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ca23AS7D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 415D5C4CEEB;
	Mon, 14 Apr 2025 13:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744638921;
	bh=EjPH7+pMyBOIy9AujSxvWyvHYKNLvMJ1UIyKY25E7Qo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ca23AS7Du1op3pg7LrcSalnLIbsE1JxvlsFppdYDI1jHrCcZflFC3hgUdiS7aHKWR
	 iRaBSZ6j1PsmjFqtrzJpO6c8ON6qKdUCToT5nvhSNCXyLzQGgOC1RAN7DVTgBeGJSy
	 gKuliipsZ06NarNxA7a0KLKyO1wM8jpimikPRSy8uDmbgjUrUZoIRPQimBJvq5yFbr
	 BeZMkEivR0nNluMzoAuQBMmO6S0PVc7ohZszEf6FdV8kpPysTrPed2Y8+okMUCzzb4
	 gUOU/7eZvqrpuPgzh9wyndmMVqR1GZdBAEM2HyjbfEospONjGcL3OvmM5U1KAX17Cn
	 KQTeuLufZSi6A==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 14 Apr 2025 15:55:07 +0200
Subject: [PATCH v2 3/3] coredump: hand a pidfd to the usermode coredump
 helper
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250414-work-coredump-v2-3-685bf231f828@kernel.org>
References: <20250414-work-coredump-v2-0-685bf231f828@kernel.org>
In-Reply-To: <20250414-work-coredump-v2-0-685bf231f828@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>, 
 Luca Boccassi <luca.boccassi@gmail.com>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 linux-kernel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=5654; i=brauner@kernel.org;
 h=from:subject:message-id; bh=EjPH7+pMyBOIy9AujSxvWyvHYKNLvMJ1UIyKY25E7Qo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT/Fd6/4t/mIA7PVddmX3hynfvRnteFBWkFexOTj1h4R
 +U7TatU6ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIlz8Mf7iYi1+K7F142MN6
 z13Zk/KqAaFLH9Rr9zLuua727crNen9Ghh8zly7zXBbXwmgu/2LZvXlnbfUkfkSaBuRGTbsr/ex
 nEwcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Give userspace a way to instruct the kernel to install a pidfd into the
usermode helper process. This makes coredump handling a lot more
reliable for userspace. In parallel with this commit we already have
systemd adding support for this in [1].

We create a pidfs file for the coredumping process when we process the
corename pattern. When the usermode helper process is forked we then
install the pidfs file as file descriptor three into the usermode
helpers file descriptor table so it's available to the exec'd program.

Since usermode helpers are either children of the system_unbound_wq
workqueue or kthreadd we know that the file descriptor table is empty
and can thus always use three as the file descriptor number.

Note, that we'll install a pidfd for the thread-group leader even if a
subthread is calling do_coredump(). We know that task linkage hasn't
been removed due to delay_group_leader() and even if this @current isn't
the actual thread-group leader we know that the thread-group leader
cannot be reaped until @current has exited.

Link: https://github.com/systemd/systemd/pull/37125 [1]
Tested-by: Luca Boccassi <luca.boccassi@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/coredump.c            | 59 ++++++++++++++++++++++++++++++++++++++++++++----
 include/linux/coredump.h |  1 +
 2 files changed, 56 insertions(+), 4 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 9da592aa8f16..403be0ff780e 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -43,6 +43,9 @@
 #include <linux/timekeeping.h>
 #include <linux/sysctl.h>
 #include <linux/elf.h>
+#include <linux/pidfs.h>
+#include <uapi/linux/pidfd.h>
+#include <linux/vfsdebug.h>
 
 #include <linux/uaccess.h>
 #include <asm/mmu_context.h>
@@ -60,6 +63,12 @@ static void free_vma_snapshot(struct coredump_params *cprm);
 #define CORE_FILE_NOTE_SIZE_DEFAULT (4*1024*1024)
 /* Define a reasonable max cap */
 #define CORE_FILE_NOTE_SIZE_MAX (16*1024*1024)
+/*
+ * File descriptor number for the pidfd for the thread-group leader of
+ * the coredumping task installed into the usermode helper's file
+ * descriptor table.
+ */
+#define COREDUMP_PIDFD_NUMBER 3
 
 static int core_uses_pid;
 static unsigned int core_pipe_limit;
@@ -339,6 +348,27 @@ static int format_corename(struct core_name *cn, struct coredump_params *cprm,
 			case 'C':
 				err = cn_printf(cn, "%d", cprm->cpu);
 				break;
+			/* pidfd number */
+			case 'F': {
+				/*
+				 * Installing a pidfd only makes sense if
+				 * we actually spawn a usermode helper.
+				 */
+				if (!ispipe)
+					break;
+
+				/*
+				 * Note that we'll install a pidfd for the
+				 * thread-group leader. We know that task
+				 * linkage hasn't been removed yet and even if
+				 * this @current isn't the actual thread-group
+				 * leader we know that the thread-group leader
+				 * cannot be reaped until @current has exited.
+				 */
+				cprm->pid = task_tgid(current);
+				err = cn_printf(cn, "%d", COREDUMP_PIDFD_NUMBER);
+				break;
+			}
 			default:
 				break;
 			}
@@ -493,7 +523,7 @@ static void wait_for_dump_helpers(struct file *file)
 }
 
 /*
- * umh_pipe_setup
+ * umh_coredump_setup
  * helper function to customize the process used
  * to collect the core in userspace.  Specifically
  * it sets up a pipe and installs it as fd 0 (stdin)
@@ -503,12 +533,33 @@ static void wait_for_dump_helpers(struct file *file)
  * is a special value that we use to trap recursive
  * core dumps
  */
-static int umh_pipe_setup(struct subprocess_info *info, struct cred *new)
+static int umh_coredump_setup(struct subprocess_info *info, struct cred *new)
 {
 	struct file *files[2];
 	struct coredump_params *cp = (struct coredump_params *)info->data;
 	int err;
 
+	if (cp->pid) {
+		struct file *pidfs_file __free(fput) = NULL;
+
+		pidfs_file = pidfs_alloc_file(cp->pid, 0);
+		if (IS_ERR(pidfs_file))
+			return PTR_ERR(pidfs_file);
+
+		/*
+		 * Usermode helpers are childen of either
+		 * system_unbound_wq or of kthreadd. So we know that
+		 * we're starting off with a clean file descriptor
+		 * table. So we should always be able to use
+		 * COREDUMP_PIDFD_NUMBER as our file descriptor value.
+		 */
+		VFS_WARN_ON_ONCE((pidfs_file = fget_raw(COREDUMP_PIDFD_NUMBER)) != NULL);
+
+		err = replace_fd(COREDUMP_PIDFD_NUMBER, pidfs_file, 0);
+		if (err < 0)
+			return err;
+	}
+
 	err = create_pipe_files(files, 0);
 	if (err)
 		return err;
@@ -598,7 +649,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 		}
 
 		if (cprm.limit == 1) {
-			/* See umh_pipe_setup() which sets RLIMIT_CORE = 1.
+			/* See umh_coredump_setup() which sets RLIMIT_CORE = 1.
 			 *
 			 * Normally core limits are irrelevant to pipes, since
 			 * we're not writing to the file system, but we use
@@ -637,7 +688,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 		retval = -ENOMEM;
 		sub_info = call_usermodehelper_setup(helper_argv[0],
 						helper_argv, NULL, GFP_KERNEL,
-						umh_pipe_setup, NULL, &cprm);
+						umh_coredump_setup, NULL, &cprm);
 		if (sub_info)
 			retval = call_usermodehelper_exec(sub_info,
 							  UMH_WAIT_EXEC);
diff --git a/include/linux/coredump.h b/include/linux/coredump.h
index 77e6e195d1d6..76e41805b92d 100644
--- a/include/linux/coredump.h
+++ b/include/linux/coredump.h
@@ -28,6 +28,7 @@ struct coredump_params {
 	int vma_count;
 	size_t vma_data_size;
 	struct core_vma_metadata *vma_meta;
+	struct pid *pid;
 };
 
 extern unsigned int core_file_note_size_limit;

-- 
2.47.2


