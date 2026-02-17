Return-Path: <linux-fsdevel+bounces-77426-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJaDC3/tlGnUIwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77426-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 23:36:47 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA16D151893
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 23:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 095A83026338
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 22:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4590931BC94;
	Tue, 17 Feb 2026 22:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQbptT86"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BF72D5C6C;
	Tue, 17 Feb 2026 22:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771367796; cv=none; b=RwbgsW95lIJRageYtBlMsVb5clbw72rH+/CIYnwiaEwcb8+F7bD1jDftlE3GK1k9rFSuuPve2IiJR5rAg/nm57CpiL1OEQQ+uSSjl5pqlLLMmJQJsZw0v9JARzZ4N/G5TOC55JmLhT23pF9aZWbj6gVvh1Joi7y2QdED9wyjsb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771367796; c=relaxed/simple;
	bh=GGzmN2/fE67M1JU7gWLPFT4Zm6OWe251kFDBMS3MTEo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TEoeiELT8uD3TWRQ3/uVKcth/g1bXXNL2R+9bEUN78u6KER5UAeXyoAgHxhDPVren/+ZODuTgJNQiFgiTf9R4l4CnFC+yEKHRLhoGNIOZjm3haWW3VnvXlKA95MQM2sC0Qaz6+7YTP14R+t2x/7wiGHxSRdKvNWH7bFoVdVpkQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQbptT86; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C295AC2BC87;
	Tue, 17 Feb 2026 22:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771367796;
	bh=GGzmN2/fE67M1JU7gWLPFT4Zm6OWe251kFDBMS3MTEo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OQbptT86YN5+nOMS/mN8pxSEaY3GoQmPY8M0zSx33QT65Tc2GDRUENEI3JL8bind3
	 /DvXAbAAYceVRFE2i7J3+hfU4el86WxI5a6MfqomCoZvW5gVpw+uye0xyvr6FRh2J+
	 s8O/mQWvRVeMhgLQ1pt3Cfwmas3/61gGYJ2GNwm/UKgGAVjsECzar/PbxGQ90mpDdB
	 nTKNj5p9mb2/6JU+vGFx4Wzx9v+Vx7b39QWOuJOwTDINI6lbtL2EtuXoDvNKa2ewIs
	 wuvOFWUKcrO3zGDZoSsZ97Zta7gpHYdhrbzMixMda5Jx0iaP11G77iuLnQsVMzOODP
	 pZIeHybCGBBFA==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 17 Feb 2026 23:35:51 +0100
Subject: [PATCH RFC v3 2/4] pidfd: add CLONE_PIDFD_AUTOKILL
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260217-work-pidfs-autoreap-v3-2-33a403c20111@kernel.org>
References: <20260217-work-pidfs-autoreap-v3-0-33a403c20111@kernel.org>
In-Reply-To: <20260217-work-pidfs-autoreap-v3-0-33a403c20111@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=5319; i=brauner@kernel.org;
 h=from:subject:message-id; bh=GGzmN2/fE67M1JU7gWLPFT4Zm6OWe251kFDBMS3MTEo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWROeZsn8qHb8NkMAXFx5zXGhb90mHLNl+f+lwxpULi0M
 mI3r5FGRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQOBjAy9Nlee1Pdwu+UZjF5
 zSPlg1PrbeKENppdzhG/Li2+ZV7IJIa/Mkm/ZbUrZtxknOd3MKRrpuLRGyYFVy7M69BmzT/W3qH
 PAgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77426-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BA16D151893
X-Rspamd-Action: no action

Add a new clone3() flag CLONE_PIDFD_AUTOKILL that ties a child's
lifetime to the pidfd returned from clone3(). When the last reference to
the struct file created by clone3() is closed the kernel sends SIGKILL
to the child. A pidfd obtained via pidfd_open() for the same process
does not keep the child alive and does not trigger autokill - only the
specific struct file from clone3() has this property.

This is useful for container runtimes, service managers, and sandboxed
subprocess execution - any scenario where the child must die if the
parent crashes or abandons the pidfd.

CLONE_PIDFD_AUTOKILL requires both CLONE_PIDFD (the whole point is tying
lifetime to the pidfd file) and CLONE_AUTOREAP (a killed child with no
one to reap it would become a zombie). CLONE_THREAD is rejected because
autokill targets a process not a thread.

The clone3 pidfd is identified by storing a pointer to the struct file in
signal_struct.autokill_pidfd. The pidfs .release handler compares the
file being closed against this pointer and sends SIGKILL via
group_send_sig_info(SIGKILL, SEND_SIG_PRIV, ...) only on match. Files
from pidfd_open() or open_by_handle_at() are distinct struct files and
will never match. dup()/fork() share the same struct file so they extend
the child's lifetime until the last reference drops.

Unlike pdeath_signal autokill isn't disarmed on exec and on credential
changes that cross privilege boundaries. It would defeat the purpose of
this whole endeavour.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/pidfs.c                   | 16 ++++++++++++++++
 include/linux/sched/signal.h |  3 +++
 include/uapi/linux/sched.h   |  1 +
 kernel/fork.c                | 16 ++++++++++++++--
 4 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index 318253344b5c..b3891b2097eb 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -8,6 +8,8 @@
 #include <linux/mount.h>
 #include <linux/pid.h>
 #include <linux/pidfs.h>
+#include <linux/sched/signal.h>
+#include <linux/signal.h>
 #include <linux/pid_namespace.h>
 #include <linux/poll.h>
 #include <linux/proc_fs.h>
@@ -637,7 +639,21 @@ static long pidfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	return open_namespace(ns_common);
 }
 
+static int pidfs_file_release(struct inode *inode, struct file *file)
+{
+	struct pid *pid = inode->i_private;
+	struct task_struct *task;
+
+	guard(rcu)();
+	task = pid_task(pid, PIDTYPE_TGID);
+	if (task && READ_ONCE(task->signal->autokill_pidfd) == file)
+		do_send_sig_info(SIGKILL, SEND_SIG_PRIV, task, PIDTYPE_TGID);
+
+	return 0;
+}
+
 static const struct file_operations pidfs_file_operations = {
+	.release	= pidfs_file_release,
 	.poll		= pidfd_poll,
 #ifdef CONFIG_PROC_FS
 	.show_fdinfo	= pidfd_show_fdinfo,
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index f842c86b806f..85a3de5c4030 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -134,6 +134,9 @@ struct signal_struct {
 	unsigned int		has_child_subreaper:1;
 	unsigned int		autoreap:1;
 
+	/* pidfd that triggers SIGKILL on close, or NULL */
+	const struct file	*autokill_pidfd;
+
 #ifdef CONFIG_POSIX_TIMERS
 
 	/* POSIX.1b Interval Timers */
diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
index 8a22ea640817..b1aea8a86e2f 100644
--- a/include/uapi/linux/sched.h
+++ b/include/uapi/linux/sched.h
@@ -37,6 +37,7 @@
 #define CLONE_CLEAR_SIGHAND 0x100000000ULL /* Clear any signal handler and reset to SIG_DFL. */
 #define CLONE_INTO_CGROUP 0x200000000ULL /* Clone into a specific cgroup given the right permissions. */
 #define CLONE_AUTOREAP 0x400000000ULL /* Auto-reap child on exit. */
+#define CLONE_PIDFD_AUTOKILL 0x800000000ULL /* Kill child when clone pidfd closes. */
 
 /*
  * cloning flags intersect with CSIGNAL so can be used with unshare and clone3
diff --git a/kernel/fork.c b/kernel/fork.c
index bc27dc10c309..7bcdba54c9a0 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2035,6 +2035,15 @@ __latent_entropy struct task_struct *copy_process(
 			return ERR_PTR(-EINVAL);
 	}
 
+	if (clone_flags & CLONE_PIDFD_AUTOKILL) {
+		if (!(clone_flags & CLONE_PIDFD))
+			return ERR_PTR(-EINVAL);
+		if (!(clone_flags & CLONE_AUTOREAP))
+			return ERR_PTR(-EINVAL);
+		if (clone_flags & CLONE_THREAD)
+			return ERR_PTR(-EINVAL);
+	}
+
 	/*
 	 * Force any signals received before this point to be delivered
 	 * before the fork happens.  Collect up signals sent to multiple
@@ -2470,8 +2479,11 @@ __latent_entropy struct task_struct *copy_process(
 	syscall_tracepoint_update(p);
 	write_unlock_irq(&tasklist_lock);
 
-	if (pidfile)
+	if (pidfile) {
+		if (clone_flags & CLONE_PIDFD_AUTOKILL)
+			p->signal->autokill_pidfd = pidfile;
 		fd_install(pidfd, pidfile);
+	}
 
 	proc_fork_connector(p);
 	sched_post_fork(p);
@@ -2909,7 +2921,7 @@ static bool clone3_args_valid(struct kernel_clone_args *kargs)
 	/* Verify that no unknown flags are passed along. */
 	if (kargs->flags &
 	    ~(CLONE_LEGACY_FLAGS | CLONE_CLEAR_SIGHAND | CLONE_INTO_CGROUP |
-	      CLONE_AUTOREAP))
+	      CLONE_AUTOREAP | CLONE_PIDFD_AUTOKILL))
 		return false;
 
 	/*

-- 
2.47.3


