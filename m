Return-Path: <linux-fsdevel+bounces-79543-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJjRDoESqmnFKgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79543-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 00:32:17 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E73AB2194CA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 00:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 99741302FE67
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2026 23:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A671436B078;
	Thu,  5 Mar 2026 23:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJBkZmau"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AAC35E92F;
	Thu,  5 Mar 2026 23:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772753467; cv=none; b=iz3y63UiepgXj1SRGH2lAoCHuydkRgpz6I3fAGD4fN10+qpOnqoMP22THsORRjIn4IcGyV21kyag9lLXdJpEvT+VbhTbydbC6jxmyfnizm0a8lMf/UYkEKW4Bm8acHLc1FGluG6Zfaof0fhF8NO6hyych9Thyved5TO0R7DDuXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772753467; c=relaxed/simple;
	bh=EOCV2pb/HqDWEobk9WOoHPEHdvd/YNkEMUQqkx9ABNo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ihi5zdqnKxaMpJhPmijdyQiuNSEyvC6R7SWRMZ5f0Ffuwzw1nSWnxQBqX2Hqblj9a+aSMycqKq/r5luKS7vzy+3ntgs2/2WGaknZLQFehFme6KC3fhzn7dC82RkAx47eTvcU1wdrkCwWdmmKvYKD2H61x6vILDHbf3b6bh9TcXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LJBkZmau; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D65A5C19423;
	Thu,  5 Mar 2026 23:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772753466;
	bh=EOCV2pb/HqDWEobk9WOoHPEHdvd/YNkEMUQqkx9ABNo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LJBkZmau2fuzxZNEkJEO1aEWOuWZWF/64JfEUirOHCD300jFpkCI+M9J45yIDx3kl
	 qN7Aczw4/GpoijDWeVoKvcgOn4LZQlUetKGFM2P5w4KoXyLIVpR+l486KfqFcf5gJP
	 sgKuMPLaJ35hem/fqh10oeLy4hhbjObzDjsx3LAzok0MTdq7qWK39j3c37+O2oLPFE
	 YB1z99SX4+a3UO+t+dFPXaekqZ53CJOnjPhi2qPa2C3mIfEjwC2NqwiNVHE22PAQgA
	 iDy/FNlZmEROvIB1ctcpIBhiqxWr2ADt/ctyRYMivZusUGmj4s5ZxRo51+4ifdxM1D
	 LtZh/BbBpzVhA==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 06 Mar 2026 00:30:21 +0100
Subject: [PATCH RFC v2 18/23] fs: add umh argument to struct
 kernel_clone_args
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260306-work-kthread-nullfs-v2-18-ad1b4bed7d3e@kernel.org>
References: <20260306-work-kthread-nullfs-v2-0-ad1b4bed7d3e@kernel.org>
In-Reply-To: <20260306-work-kthread-nullfs-v2-0-ad1b4bed7d3e@kernel.org>
To: linux-fsdevel@vger.kernel.org, 
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Jann Horn <jannh@google.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=2817; i=brauner@kernel.org;
 h=from:subject:message-id; bh=EOCV2pb/HqDWEobk9WOoHPEHdvd/YNkEMUQqkx9ABNo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSuEuJi+7lI0uFPjenneRu09zimPHrdeXh+aPnksK7PG
 Y+D2l9O6ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIqRsjw/caU7fMfpffpnXv
 77Jtuyd7Rap8b7N5RG1PYUnm+7zqWEaGP58tZXon/4i7r7fiQ/RuqReR1vdmHd7p/3zOw7j6O3c
 KmAE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Queue-Id: E73AB2194CA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79543-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

Add a umh field to struct kernel_clone_args. When set, copy_fs() copies
from pid 1's fs_struct instead of the kthread's fs_struct. This ensures
usermodehelper threads always get init's filesystem state regardless of
their parent's (kthreadd's) fs.

Usermodehelper threads are not allowed to create mount namespaces
(CLONE_NEWNS), share filesystem state (CLONE_FS), or be started from
a non-initial mount namespace. No usermodehelper currently does this so
we don't need to worry about this restriction.

Set .umh = 1 in user_mode_thread(). At this stage pid 1's fs points to
rootfs which is the same as kthreadd's fs, so this is functionally
equivalent.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/sched/task.h |  1 +
 kernel/fork.c              | 23 ++++++++++++++++++++---
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 41ed884cffc9..e0c1ca8c6a18 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -31,6 +31,7 @@ struct kernel_clone_args {
 	u32 io_thread:1;
 	u32 user_worker:1;
 	u32 no_files:1;
+	u32 umh:1;
 	unsigned long stack;
 	unsigned long stack_size;
 	unsigned long tls;
diff --git a/kernel/fork.c b/kernel/fork.c
index 73f4ed82f656..c740fe2ad1ef 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1590,9 +1590,25 @@ static int copy_mm(u64 clone_flags, struct task_struct *tsk)
 	return 0;
 }
 
-static int copy_fs(u64 clone_flags, struct task_struct *tsk)
+static int copy_fs(u64 clone_flags, struct task_struct *tsk, bool umh)
 {
-	struct fs_struct *fs = current->fs;
+	struct fs_struct *fs;
+
+	/*
+	 * Usermodehelper may use userspace_init_fs filesystem state but
+	 * they don't get to create mount namespaces, share the
+	 * filesystem state, or be started from a non-initial mount
+	 * namespace.
+	 */
+	if (umh) {
+		if (clone_flags & (CLONE_NEWNS | CLONE_FS))
+			return -EINVAL;
+		if (current->nsproxy->mnt_ns != &init_mnt_ns)
+			return -EINVAL;
+		fs = userspace_init_fs;
+	} else {
+		fs = current->fs;
+	}
 
 	VFS_WARN_ON_ONCE(current->fs != current->real_fs);
 	if (clone_flags & CLONE_FS) {
@@ -2213,7 +2229,7 @@ __latent_entropy struct task_struct *copy_process(
 	retval = copy_files(clone_flags, p, args->no_files);
 	if (retval)
 		goto bad_fork_cleanup_semundo;
-	retval = copy_fs(clone_flags, p);
+	retval = copy_fs(clone_flags, p, args->umh);
 	if (retval)
 		goto bad_fork_cleanup_files;
 	retval = copy_sighand(clone_flags, p);
@@ -2727,6 +2743,7 @@ pid_t user_mode_thread(int (*fn)(void *), void *arg, unsigned long flags)
 		.exit_signal	= (flags & CSIGNAL),
 		.fn		= fn,
 		.fn_arg		= arg,
+		.umh		= 1,
 	};
 
 	return kernel_clone(&args);

-- 
2.47.3


