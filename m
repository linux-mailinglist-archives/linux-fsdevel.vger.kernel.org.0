Return-Path: <linux-fsdevel+bounces-66223-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E32EC1A363
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 13:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD48D1A2539D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 12:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C08340D81;
	Wed, 29 Oct 2025 12:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tZkCvX8E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0713F342C9D;
	Wed, 29 Oct 2025 12:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740489; cv=none; b=P2PArI/V3G3TGaeNo/U3qnjkck3DnpGQ6+oDFe9yB4qtKpeM0TOigB1DeBEBWFcM2GnPkeFDt30GMgBZY0ubF6kQEMRjdbnKR91Ez5s2k+uLLzovqQqCkTgpF/iW2/Sv8Fj7A7OcGaLg8LqkBt2zELcZHTWqMEw8hgrQAR+wDX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740489; c=relaxed/simple;
	bh=PRr5aGNWRTH+10xraw3D5wgKQID6oDCbNnUrUcndNYk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tbsVp6xmUiMKPoYf1eiuLqAi1PFTirq4zgquKcHeLaoCoOdE794V+bW9nIQ7eaCNiRNH94vDweKiQxqqA/Lrw6PXkLabPQj4OMZI2PmQvwdYbi0y3dXWHWooiRc380ZJmL6Ies5IvpZgWCfX3Bu9oB/yJ8FnZmlpCOuCkdmH9d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tZkCvX8E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C4EAC4CEFF;
	Wed, 29 Oct 2025 12:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761740488;
	bh=PRr5aGNWRTH+10xraw3D5wgKQID6oDCbNnUrUcndNYk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tZkCvX8Ezt9skrONwRfHO7x/hsnWbdExfREUqnEGXm2bSo3B0/mw2hOr0Yeql4uKc
	 puQdWRGZaasI7cQEJ32nBx4w5uYpuFRmqwjo49yxs8ACvRFbrgWHjSW1HU2c6yUWvP
	 clGbTSlgwVJrGBJyq526gZwCqAuY6XFCddngAjFKhLixl0k0IuEiCzuubKuv7al/5d
	 E599uh/gtDZ07cGf84nTFhrT471Us+19U2R0FU4DE6AgiO1x4b0c93poIz9RzlyRFH
	 lxAEkWbLa9t/IX50RfPet7ExkePVePElNQQ7BU2q00e5FPzccrrg7Rq26NGirQuiqS
	 7xc7l4TDQ6s/g==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 29 Oct 2025 13:20:23 +0100
Subject: [PATCH v4 10/72] ns: rename to exit_nsproxy_namespaces()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-work-namespace-nstree-listns-v4-10-2e6f823ebdc0@kernel.org>
References: <20251029-work-namespace-nstree-listns-v4-0-2e6f823ebdc0@kernel.org>
In-Reply-To: <20251029-work-namespace-nstree-listns-v4-0-2e6f823ebdc0@kernel.org>
To: linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>
Cc: Jann Horn <jannh@google.com>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Lennart Poettering <mzxreary@0pointer.de>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
 Amir Goldstein <amir73il@gmail.com>, Tejun Heo <tj@kernel.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, bpf@vger.kernel.org, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 netdev@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=2954; i=brauner@kernel.org;
 h=from:subject:message-id; bh=PRr5aGNWRTH+10xraw3D5wgKQID6oDCbNnUrUcndNYk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQysfW8rWcqOxTxYWK5yArHwqO9l10ZNbgZzO72bhUvX
 ryttymro5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCJc5xkZVl6fMD3JMELW4P/b
 j+t29RsseF/V3X6dj6dR+NtW2TWRsQz/o/KMupeFM1kF75Ccc8RtfrP/nG2e3ILn//5YfWzT9au
 sPAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The current naming is very misleading as this really isn't exiting all
of the task's namespaces. It is only exiting the namespaces that hang of
off nsproxy. Reflect that in the name.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/nsproxy.h | 2 +-
 kernel/cgroup/cgroup.c  | 6 +++---
 kernel/exit.c           | 2 +-
 kernel/fork.c           | 2 +-
 kernel/nsproxy.c        | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/nsproxy.h b/include/linux/nsproxy.h
index bd118a187dec..538ba8dba184 100644
--- a/include/linux/nsproxy.h
+++ b/include/linux/nsproxy.h
@@ -93,7 +93,7 @@ static inline struct cred *nsset_cred(struct nsset *set)
  */
 
 int copy_namespaces(u64 flags, struct task_struct *tsk);
-void exit_task_namespaces(struct task_struct *tsk);
+void exit_nsproxy_namespaces(struct task_struct *tsk);
 void switch_task_namespaces(struct task_struct *tsk, struct nsproxy *new);
 int exec_task_namespaces(void);
 void free_nsproxy(struct nsproxy *ns);
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index a82918da8bae..ce4d227a9ca2 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1523,9 +1523,9 @@ static struct cgroup *current_cgns_cgroup_dfl(void)
 	} else {
 		/*
 		 * NOTE: This function may be called from bpf_cgroup_from_id()
-		 * on a task which has already passed exit_task_namespaces() and
-		 * nsproxy == NULL. Fall back to cgrp_dfl_root which will make all
-		 * cgroups visible for lookups.
+		 * on a task which has already passed exit_nsproxy_namespaces()
+		 * and nsproxy == NULL. Fall back to cgrp_dfl_root which will
+		 * make all cgroups visible for lookups.
 		 */
 		return &cgrp_dfl_root.cgrp;
 	}
diff --git a/kernel/exit.c b/kernel/exit.c
index 9f74e8f1c431..825998103520 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -962,7 +962,7 @@ void __noreturn do_exit(long code)
 	exit_fs(tsk);
 	if (group_dead)
 		disassociate_ctty(1);
-	exit_task_namespaces(tsk);
+	exit_nsproxy_namespaces(tsk);
 	exit_task_work(tsk);
 	exit_thread(tsk);
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 3da0f08615a9..0926bfe4b8df 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2453,7 +2453,7 @@ __latent_entropy struct task_struct *copy_process(
 	if (p->io_context)
 		exit_io_context(p);
 bad_fork_cleanup_namespaces:
-	exit_task_namespaces(p);
+	exit_nsproxy_namespaces(p);
 bad_fork_cleanup_mm:
 	if (p->mm) {
 		mm_clear_owner(p->mm, p);
diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
index 19aa64ab08c8..6ce76a0278ab 100644
--- a/kernel/nsproxy.c
+++ b/kernel/nsproxy.c
@@ -241,7 +241,7 @@ void switch_task_namespaces(struct task_struct *p, struct nsproxy *new)
 		put_nsproxy(ns);
 }
 
-void exit_task_namespaces(struct task_struct *p)
+void exit_nsproxy_namespaces(struct task_struct *p)
 {
 	switch_task_namespaces(p, NULL);
 }

-- 
2.47.3


