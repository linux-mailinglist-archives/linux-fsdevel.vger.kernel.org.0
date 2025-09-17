Return-Path: <linux-fsdevel+bounces-61906-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A77B7EAE5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 14:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 19FE74E2FF8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 10:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE637369337;
	Wed, 17 Sep 2025 10:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZpdSPUX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7B630F55F;
	Wed, 17 Sep 2025 10:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758104945; cv=none; b=jNsHWL+M62Jrlif7WanyyQGg2xZST45WXw2jQQuJzX9mXAFdnPNKOnBmK+dJgCE08itcMpyvnpE6MwkVlw9eBcl2/3riDMncFYdjn2ji2zUaQxDmSVWGkxDLwBH01WEbrCKH7RIPQpdi5HXAeFPOXPuOjvYnb080TT3QOISHD0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758104945; c=relaxed/simple;
	bh=f298TfwuvucZhjfVOeyD006aIc08Nj0ksyFjV9TrheE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VylywV4NWrt6FwCzOyBWbax4osfJi+k84oxs1aAziFfj5FsPUQczFEMczWb25p0FaBZcjqyRvMIxst1a16SrgJUs8mRph93Yc3a0Z7r1xb9JVt97FowDShcRT9XKBoJEEG5tfTVqfBnGPZs203uuNFhDCRtA+EQyNrqdYLUS+A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZpdSPUX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E9DCC4CEF0;
	Wed, 17 Sep 2025 10:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758104944;
	bh=f298TfwuvucZhjfVOeyD006aIc08Nj0ksyFjV9TrheE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AZpdSPUXb6GPTxoFoMx/SlfoQ4N2zP6FvEiU2hQoND291C+TOhQ1Did/LdhrDaohx
	 6cNj2GTRY+4JcyRhatogOCUPbsa2Z4h8RPPTSPNlWBnifkoT+Ez78UesRljoqRmAx8
	 TKdFnQW6LAOk5MzN03tZhA54xfE80Heh9ceGyic3CRmxZof9bK337KN8NxilA033OB
	 yXgrmxmaKF3yE7ujQwJsZqnFUgGXOit6geSeLkxY14rnlRgzYLwWnddheRb+i4cNO3
	 3SFfwfPTqhd/lzHK76c+FRYdqiBvDid6bI4FU7rCkzRqvZaJ9im65p4yVtJy9+RRMp
	 AxFT6GyApDAkw==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 17 Sep 2025 12:28:05 +0200
Subject: [PATCH 6/9] mnt: simplify ns_common_init() handling
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-work-namespace-ns_common-v1-6-1b3bda8ef8f2@kernel.org>
References: <20250917-work-namespace-ns_common-v1-0-1b3bda8ef8f2@kernel.org>
In-Reply-To: <20250917-work-namespace-ns_common-v1-0-1b3bda8ef8f2@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Lennart Poettering <mzxreary@0pointer.de>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, cgroups@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-56183
X-Developer-Signature: v=1; a=openpgp-sha256; l=1817; i=brauner@kernel.org;
 h=from:subject:message-id; bh=f298TfwuvucZhjfVOeyD006aIc08Nj0ksyFjV9TrheE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSc6vWbzt/s5PnEzvc8yxQn3gdyQu9VuB9ctdjlLvwr8
 NdUm6mqHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABN5eonhr+CiQut/3KfPX6u/
 9VjisEl3Zf4UxnbHfZcuR2urMJkyTGf4Z7u83vvT2+1fc2Y+mj355bH7ViemWk64vyMqdIn1tjW
 muuwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Assign the reserved MNT_NS_ANON_INO sentinel to anonymous mount
namespaces and cleanup the initial mount ns allocation. This is just a
preparatory patch and the ns->inum check in ns_common_init() will be
dropped in the next patch.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c    | 7 ++++---
 kernel/nscommon.c | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index c8251545d57e..09e4ecd44972 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4104,6 +4104,8 @@ static struct mnt_namespace *alloc_mnt_ns(struct user_namespace *user_ns, bool a
 		return ERR_PTR(-ENOMEM);
 	}
 
+	if (anon)
+		new_ns->ns.inum = MNT_NS_ANON_INO;
 	ret = ns_common_init(&new_ns->ns, &mntns_operations, !anon);
 	if (ret) {
 		kfree(new_ns);
@@ -6020,10 +6022,9 @@ static void __init init_mount_tree(void)
 	if (IS_ERR(mnt))
 		panic("Can't create rootfs");
 
-	ns = alloc_mnt_ns(&init_user_ns, true);
+	ns = alloc_mnt_ns(&init_user_ns, false);
 	if (IS_ERR(ns))
 		panic("Can't allocate initial namespace");
-	ns->ns.inum = PROC_MNT_INIT_INO;
 	m = real_mount(mnt);
 	ns->root = m;
 	ns->nr_mounts = 1;
@@ -6037,7 +6038,7 @@ static void __init init_mount_tree(void)
 	set_fs_pwd(current->fs, &root);
 	set_fs_root(current->fs, &root);
 
-	ns_tree_add(ns);
+	ns_tree_add_raw(ns);
 	init_mnt_ns = ns;
 }
 
diff --git a/kernel/nscommon.c b/kernel/nscommon.c
index ebf4783d0505..e10fad8afe61 100644
--- a/kernel/nscommon.c
+++ b/kernel/nscommon.c
@@ -5,7 +5,7 @@
 int ns_common_init(struct ns_common *ns, const struct proc_ns_operations *ops,
 		   bool alloc_inum)
 {
-	if (alloc_inum) {
+	if (alloc_inum && !ns->inum) {
 		int ret;
 		ret = proc_alloc_inum(&ns->inum);
 		if (ret)

-- 
2.47.3


