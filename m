Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 775DA157E3E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2020 16:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729314AbgBJPGV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Feb 2020 10:06:21 -0500
Received: from monster.unsafe.ru ([5.9.28.80]:54164 "EHLO mail.unsafe.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729283AbgBJPGU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Feb 2020 10:06:20 -0500
Received: from comp-core-i7-2640m-0182e6.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.unsafe.ru (Postfix) with ESMTPSA id B9BAFC61B1A;
        Mon, 10 Feb 2020 15:06:16 +0000 (UTC)
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Djalal Harouni <tixxdz@gmail.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Solar Designer <solar@openwall.com>
Subject: [PATCH v8 08/11] proc: instantiate only pids that we can ptrace on 'hidepid=4' mount option
Date:   Mon, 10 Feb 2020 16:05:16 +0100
Message-Id: <20200210150519.538333-9-gladkov.alexey@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200210150519.538333-1-gladkov.alexey@gmail.com>
References: <20200210150519.538333-1-gladkov.alexey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If "hidepid=4" mount option is set then do not instantiate pids that
we can not ptrace. "hidepid=4" means that procfs should only contain
pids that the caller can ptrace.

Cc: Kees Cook <keescook@chromium.org>
Cc: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Djalal Harouni <tixxdz@gmail.com>
Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>
---
 fs/proc/base.c          | 15 +++++++++++++++
 fs/proc/root.c          | 14 +++++++++++---
 include/linux/proc_fs.h |  1 +
 3 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 24b7c620ded3..49937d54e745 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -699,6 +699,14 @@ static bool has_pid_permissions(struct proc_fs_info *fs_info,
 				 struct task_struct *task,
 				 int hide_pid_min)
 {
+	/*
+	 * If 'hidpid' mount option is set force a ptrace check,
+	 * we indicate that we are using a filesystem syscall
+	 * by passing PTRACE_MODE_READ_FSCREDS
+	 */
+	if (proc_fs_hide_pid(fs_info) == HIDEPID_NOT_PTRACABLE)
+		return ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS);
+
 	if (proc_fs_hide_pid(fs_info) < hide_pid_min)
 		return true;
 	if (in_group_p(proc_fs_pid_gid(fs_info)))
@@ -3271,7 +3279,14 @@ struct dentry *proc_pid_lookup(struct dentry *dentry, unsigned int flags)
 	if (!task)
 		goto out;
 
+	/* Limit procfs to only ptracable tasks */
+	if (proc_fs_hide_pid(fs_info) == HIDEPID_NOT_PTRACABLE) {
+		if (!has_pid_permissions(fs_info, task, HIDEPID_NO_ACCESS))
+			goto out_put_task;
+	}
+
 	result = proc_pid_instantiate(dentry, task, NULL);
+out_put_task:
 	put_task_struct(task);
 out:
 	return result;
diff --git a/fs/proc/root.c b/fs/proc/root.c
index e2bb015da1a8..5e27bb31f125 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -52,6 +52,15 @@ static const struct fs_parameter_description proc_fs_parameters = {
 	.specs		= proc_param_specs,
 };
 
+static inline int
+valid_hidepid(unsigned int value)
+{
+	return (value == HIDEPID_OFF ||
+		value == HIDEPID_NO_ACCESS ||
+		value == HIDEPID_INVISIBLE ||
+		value == HIDEPID_NOT_PTRACABLE);
+}
+
 static int proc_parse_param(struct fs_context *fc, struct fs_parameter *param)
 {
 	struct proc_fs_context *ctx = fc->fs_private;
@@ -68,10 +77,9 @@ static int proc_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		break;
 
 	case Opt_hidepid:
+		if (!valid_hidepid(result.uint_32))
+			return invalf(fc, "proc: unknown value of hidepid.\n");
 		ctx->hidepid = result.uint_32;
-		if (ctx->hidepid < HIDEPID_OFF ||
-		    ctx->hidepid > HIDEPID_INVISIBLE)
-			return invalf(fc, "proc: hidepid value must be between 0 and 2.\n");
 		break;
 
 	default:
diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index f307940f8311..6822548405a7 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -17,6 +17,7 @@ enum {
 	HIDEPID_OFF	  = 0,
 	HIDEPID_NO_ACCESS = 1,
 	HIDEPID_INVISIBLE = 2,
+	HIDEPID_NOT_PTRACABLE = 4, /* Limit pids to only ptracable pids */
 };
 
 struct proc_fs_info {
-- 
2.24.1

