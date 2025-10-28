Return-Path: <linux-fsdevel+bounces-65887-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 386BDC139A1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 09:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEF84562B98
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 08:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB40246327;
	Tue, 28 Oct 2025 08:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DAJIBJnd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364C22D595B;
	Tue, 28 Oct 2025 08:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761641193; cv=none; b=CkPQdJfWIGUhYaO28t7h+oUYRhLyEifNhZYb28JTn9VFWQ0euHVKTF88z26oDKKw6+fmZvsC4ilK1oOqz/b5L0mbQlUOSRMHLVFWWBggfF8wWSa2EZiUrz1C7gUEzHrNBj5knS+Ei5tHgQcdyufI1GXSDQWvdEDseDIxDYMOTY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761641193; c=relaxed/simple;
	bh=RVh2i7HDkT2NYWf85JxVPLYfSr8x+7ix55FiOfx/B10=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LO35tF6XphBD8oJqqxnSZr8v9syM53K+XFyEH5/0gmAjV/5bLSfYqrS+mr4FdGskHo+pbubw1X9hPGYOdt+3v8ybAL7hogUJyrKGq2fEcfzs/ZM6vtOFa0PPi1I6fGRpTOrmf137iKG7wfN+J+Gdik81KruhmTXZfQHG9MJc3Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DAJIBJnd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9F0CC4CEE7;
	Tue, 28 Oct 2025 08:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761641193;
	bh=RVh2i7HDkT2NYWf85JxVPLYfSr8x+7ix55FiOfx/B10=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DAJIBJndvBisOf4GuvYK0Vghj8duRR9e0IUFTF9GlKbOOu8bLPYV6dRO9lyEdHDOu
	 JN5EtzdzxBTGUUU9MAfRmFxBekfcYv7Gfb3lVE1Ie3On/jgJDqiUiBetioJuBzFlIg
	 R/780TvwL9Ry+uDK4lhel1yf13wkFRcKh1jYWEDyCqeJAX1QtW+SdpNtVhmhfK/IEf
	 k3acPFvqpj90cKTk1umxqrYGKPh4tPqTfWgWEoK+lCtJpR1dRZyRL41Z5TPuePCWA1
	 zS3cAiV5crVzRCfZydRT64Gub2EuVLitf+8B0YMt1DSGAHygiC6XViKwiLH4Gg5/g0
	 OMWC1shm32RKA==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 28 Oct 2025 09:45:52 +0100
Subject: [PATCH 07/22] pidfs: drop struct pidfs_exit_info
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-work-coredump-signal-v1-7-ca449b7b7aa0@kernel.org>
References: <20251028-work-coredump-signal-v1-0-ca449b7b7aa0@kernel.org>
In-Reply-To: <20251028-work-coredump-signal-v1-0-ca449b7b7aa0@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>, Amir Goldstein <amir73il@gmail.com>, 
 Aleksa Sarai <cyphar@cyphar.com>, 
 Yu Watanabe <watanabe.yu+github@gmail.com>, 
 Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
 Jann Horn <jannh@google.com>, Luca Boccassi <luca.boccassi@gmail.com>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Lennart Poettering <lennart@poettering.net>, 
 Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=3668; i=brauner@kernel.org;
 h=from:subject:message-id; bh=RVh2i7HDkT2NYWf85JxVPLYfSr8x+7ix55FiOfx/B10=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQyNB2c+2VvD7/movDad0nb2Kc5HC7dxdcbeiBPxFa2e
 k3pu/cHOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYyPZKR4fSm70zGtc+2Ga+o
 0jT7JnKVv0OLJU9jl0DlxY8L3vywiWH4Z5MwO/9SrrG3c+WtIKf7p6bNNg73K3CMj2A9JuYdotz
 OBgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

This is not needed anymore now that we have the new scheme to guarantee
all-or-nothing information exposure.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/pidfs.c | 35 +++++++++++------------------------
 1 file changed, 11 insertions(+), 24 deletions(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index 0fad0c969b7a..a3b80be3b98b 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -39,16 +39,6 @@ void pidfs_get_root(struct path *path)
 	path_get(path);
 }
 
-/*
- * Stashes information that userspace needs to access even after the
- * process has been reaped.
- */
-struct pidfs_exit_info {
-	__u64 cgroupid;
-	__s32 exit_code;
-	__u32 coredump_mask;
-};
-
 enum pidfs_attr_mask_bits {
 	PIDFS_ATTR_BIT_EXIT	= 0,
 };
@@ -56,8 +46,11 @@ enum pidfs_attr_mask_bits {
 struct pidfs_attr {
 	unsigned long attr_mask;
 	struct simple_xattrs *xattrs;
-	struct pidfs_exit_info __pei;
-	struct pidfs_exit_info *exit_info;
+	struct /* exit info */ {
+		__u64 cgroupid;
+		__s32 exit_code;
+	};
+	__u32 coredump_mask;
 };
 
 static struct rb_root pidfs_ino_tree = RB_ROOT;
@@ -313,7 +306,6 @@ static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
 	struct pid *pid = pidfd_pid(file);
 	size_t usize = _IOC_SIZE(cmd);
 	struct pidfd_info kinfo = {};
-	struct pidfs_exit_info *exit_info;
 	struct user_namespace *user_ns;
 	struct pidfs_attr *attr;
 	const struct cred *c;
@@ -342,15 +334,15 @@ static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
 			smp_rmb();
 			kinfo.mask |= PIDFD_INFO_EXIT;
 #ifdef CONFIG_CGROUPS
-			kinfo.cgroupid = exit_info->cgroupid;
+			kinfo.cgroupid = attr->cgroupid;
 			kinfo.mask |= PIDFD_INFO_CGROUPID;
 #endif
-			kinfo.exit_code = exit_info->exit_code;
+			kinfo.exit_code = attr->exit_code;
 		}
 	}
 
 	if (mask & PIDFD_INFO_COREDUMP) {
-		kinfo.coredump_mask = READ_ONCE(attr->__pei.coredump_mask);
+		kinfo.coredump_mask = READ_ONCE(attr->coredump_mask);
 		if (kinfo.coredump_mask)
 			kinfo.mask |= PIDFD_INFO_COREDUMP;
 	}
@@ -629,7 +621,6 @@ void pidfs_exit(struct task_struct *tsk)
 {
 	struct pid *pid = task_pid(tsk);
 	struct pidfs_attr *attr;
-	struct pidfs_exit_info *exit_info;
 #ifdef CONFIG_CGROUPS
 	struct cgroup *cgrp;
 #endif
@@ -657,15 +648,13 @@ void pidfs_exit(struct task_struct *tsk)
 	 * is put
 	 */
 
-	exit_info = &attr->__pei;
-
 #ifdef CONFIG_CGROUPS
 	rcu_read_lock();
 	cgrp = task_dfl_cgroup(tsk);
-	exit_info->cgroupid = cgroup_id(cgrp);
+	attr->cgroupid = cgroup_id(cgrp);
 	rcu_read_unlock();
 #endif
-	exit_info->exit_code = tsk->exit_code;
+	attr->exit_code = tsk->exit_code;
 
 	/* Ensure that PIDFD_GET_INFO sees either all or nothing. */
 	smp_wmb();
@@ -676,7 +665,6 @@ void pidfs_exit(struct task_struct *tsk)
 void pidfs_coredump(const struct coredump_params *cprm)
 {
 	struct pid *pid = cprm->pid;
-	struct pidfs_exit_info *exit_info;
 	struct pidfs_attr *attr;
 	__u32 coredump_mask = 0;
 
@@ -685,14 +673,13 @@ void pidfs_coredump(const struct coredump_params *cprm)
 	VFS_WARN_ON_ONCE(!attr);
 	VFS_WARN_ON_ONCE(attr == PIDFS_PID_DEAD);
 
-	exit_info = &attr->__pei;
 	/* Note how we were coredumped. */
 	coredump_mask = pidfs_coredump_mask(cprm->mm_flags);
 	/* Note that we actually did coredump. */
 	coredump_mask |= PIDFD_COREDUMPED;
 	/* If coredumping is set to skip we should never end up here. */
 	VFS_WARN_ON_ONCE(coredump_mask & PIDFD_COREDUMP_SKIP);
-	smp_store_release(&exit_info->coredump_mask, coredump_mask);
+	smp_store_release(&attr->coredump_mask, coredump_mask);
 }
 #endif
 

-- 
2.47.3


