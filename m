Return-Path: <linux-fsdevel+bounces-62218-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A9BB88C0C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 12:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B2031C80C3A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 10:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176822ECD1D;
	Fri, 19 Sep 2025 10:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LDqGYqSi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65049381BA;
	Fri, 19 Sep 2025 10:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758276323; cv=none; b=fU4G+M6Fx4V/RXXTSK8bTT4denNw/T2uOZtA+iB2KIt/T/Z0+JqmnHRSJ9w571mLpLvqyOaITApSevvQL3WZLQGWfvMPih5iBcYySWXJGq9tDQCOU/bphdHiJ/AChoKVIsEs8HCOK7wsOZtG4MmD3aWLVF0aSiTdxcUUujBotR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758276323; c=relaxed/simple;
	bh=sEGa8QySB41BjFqZ4spjQYxhsr+2LjIMUkSAqVnUoa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZtPa/UfN5rZowXOT3P0gdKjJWnYCBwGahcbW1ZOR+y8ys4cscevPGuAl2uE+Mgdb0rk9/Aeyjdh07gv/0rUwCrlGP89+gZvZe9H31qy4/D1+b9J23TRiFnmGgdruhlQiblOc4UaNSrcejAlhbXIJCw7hqcFiIzanDyNbfVKOQ+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LDqGYqSi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2BB3C4CEF0;
	Fri, 19 Sep 2025 10:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758276322;
	bh=sEGa8QySB41BjFqZ4spjQYxhsr+2LjIMUkSAqVnUoa0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LDqGYqSi8mm3OlTsQhGhlrHiBLaSuHu8R13V1akS45a7JQ0F0qEA+rr+a5yC7C+4r
	 DWuhmNK/TP1PE8L+469QTo49Gpk4YqzKC9GAH46ucCaVw4RZ+6aeLHKP+Mpuxu2UPz
	 M7XJm/qAmYf2mW0ejGJu7B8t7N+JxgrvGqlFtCtqYDnU/6v0I5YfkpQST9F9sC8uI5
	 KqdIR16Z1nANmnT5t8RscZcYUKHVjkkIOCVasdsKgnuUsICz8/kly+UYL4++qwNNEM
	 CY2eSZKdP0SmeBnrpVXBjqb7+XAol7lMHWHGitrHBS0Y6tpSYPDRZsC7YInKRXNexZ
	 r5SOY6snGunvA==
Date: Fri, 19 Sep 2025 12:05:16 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, Lennart Poettering <mzxreary@0pointer.de>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, Jakub Kicinski <kuba@kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH 2/9] mnt: expose pointer to init_mnt_ns
Message-ID: <20250919-sense-evaluieren-eade772e2e6c@brauner>
References: <20250917-work-namespace-ns_common-v1-0-1b3bda8ef8f2@kernel.org>
 <20250917-work-namespace-ns_common-v1-2-1b3bda8ef8f2@kernel.org>
 <oqtggwqink4kthsxiv6tv6q6l7tgykosz3tenek2vejqfiuqzl@drczxzwwucfi>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="bc6bz2tyopwtmiho"
Content-Disposition: inline
In-Reply-To: <oqtggwqink4kthsxiv6tv6q6l7tgykosz3tenek2vejqfiuqzl@drczxzwwucfi>


--bc6bz2tyopwtmiho
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Wed, Sep 17, 2025 at 06:28:37PM +0200, Jan Kara wrote:
> On Wed 17-09-25 12:28:01, Christian Brauner wrote:
> > There's various scenarios where we need to know whether we are in the
> > initial set of namespaces or not to e.g., shortcut permission checking.
> > All namespaces expose that information. Let's do that too.
> > 
> > Signed-off-by: Christian Brauner <brauner@kernel.org>

I've changed this so it behaves exactly like all the other init
namespaces. See appended.

--bc6bz2tyopwtmiho
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="v2-0001-mnt-expose-pointer-to-init_mnt_ns.patch"

From 1bf2ddb7bdd1f686d4e083380412e826a211c57d Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 17 Sep 2025 12:28:01 +0200
Subject: [PATCH v2] mnt: expose pointer to init_mnt_ns

There's various scenarios where we need to know whether we are in the
initial set of namespaces or not to e.g., shortcut permission checking.
All namespaces expose that information. Let's do that too.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c                | 27 ++++++++++++++++-----------
 include/linux/mnt_namespace.h |  2 ++
 2 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index a68998449698..f0bddc9cf2a6 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -6008,27 +6008,32 @@ SYSCALL_DEFINE4(listmount, const struct mnt_id_req __user *, req,
 	return ret;
 }
 
+struct mnt_namespace init_mnt_ns = {
+	.ns.inum	= PROC_MNT_INIT_INO,
+	.ns.ops		= &mntns_operations,
+	.user_ns	= &init_user_ns,
+	.ns.count	= REFCOUNT_INIT(1),
+	.passive	= REFCOUNT_INIT(1),
+	.mounts		= RB_ROOT,
+	.poll		= __WAIT_QUEUE_HEAD_INITIALIZER(init_mnt_ns.poll),
+};
+
 static void __init init_mount_tree(void)
 {
 	struct vfsmount *mnt;
 	struct mount *m;
-	struct mnt_namespace *ns;
 	struct path root;
 
 	mnt = vfs_kern_mount(&rootfs_fs_type, 0, "rootfs", NULL);
 	if (IS_ERR(mnt))
 		panic("Can't create rootfs");
 
-	ns = alloc_mnt_ns(&init_user_ns, true);
-	if (IS_ERR(ns))
-		panic("Can't allocate initial namespace");
-	ns->ns.inum = PROC_MNT_INIT_INO;
 	m = real_mount(mnt);
-	ns->root = m;
-	ns->nr_mounts = 1;
-	mnt_add_to_ns(ns, m);
-	init_task.nsproxy->mnt_ns = ns;
-	get_mnt_ns(ns);
+	init_mnt_ns.root = m;
+	init_mnt_ns.nr_mounts = 1;
+	mnt_add_to_ns(&init_mnt_ns, m);
+	init_task.nsproxy->mnt_ns = &init_mnt_ns;
+	get_mnt_ns(&init_mnt_ns);
 
 	root.mnt = mnt;
 	root.dentry = mnt->mnt_root;
@@ -6036,7 +6041,7 @@ static void __init init_mount_tree(void)
 	set_fs_pwd(current->fs, &root);
 	set_fs_root(current->fs, &root);
 
-	ns_tree_add(ns);
+	ns_tree_add(&init_mnt_ns);
 }
 
 void __init mnt_init(void)
diff --git a/include/linux/mnt_namespace.h b/include/linux/mnt_namespace.h
index 70b366b64816..6d1c4c218c14 100644
--- a/include/linux/mnt_namespace.h
+++ b/include/linux/mnt_namespace.h
@@ -11,6 +11,8 @@ struct fs_struct;
 struct user_namespace;
 struct ns_common;
 
+extern struct mnt_namespace init_mnt_ns;
+
 extern struct mnt_namespace *copy_mnt_ns(unsigned long, struct mnt_namespace *,
 		struct user_namespace *, struct fs_struct *);
 extern void put_mnt_ns(struct mnt_namespace *ns);
-- 
2.47.3


--bc6bz2tyopwtmiho--

