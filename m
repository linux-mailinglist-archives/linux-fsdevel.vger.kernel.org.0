Return-Path: <linux-fsdevel+bounces-52119-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2ABADF817
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 22:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2798E1892EA4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 20:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66B121CFF4;
	Wed, 18 Jun 2025 20:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="am33uwK8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131011B78F3
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 20:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750280034; cv=none; b=U+47+EM0oHx2tPO6UFbUq/alZxfhB4Si3n/ieoq1fIOcxchY28kOiaJPzSo7Thju8cXQMwuGeGOozuEZv/O6yQdVShwN6XaYS9Pza6DoTYL5q1AgudTBIn/IaVIZjXhskIr5g4vjvVBBQpjJFYO/qqc3bPG96q5pDje4WWEEFU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750280034; c=relaxed/simple;
	bh=S3KQgxjP8ukMLpt3/tkVFetgsJ+rIEWVjl61OyN601I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YeKvbPCeF7oFco6kjgrsPGwspLq6HyUC+BG5O7ywrPlftWt3Ja1k9LhrBs5ijlBU70YCAz7LcXulQGauVB6eBptxcKbPEy1cPqT30hD7WErxVCTxRu//AbajUSroFUDnI+XUC0t2HRGbPc0Yhk3fueXv+QKYOwyKL731xA1UjYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=am33uwK8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92A6EC4CEEF;
	Wed, 18 Jun 2025 20:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750280033;
	bh=S3KQgxjP8ukMLpt3/tkVFetgsJ+rIEWVjl61OyN601I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=am33uwK8Hpv1t34lok9ky8c1jPwXTYcRBTdDT1TnPZSOlO5t+Zp0mnzucGnku7OmO
	 xZChDWPriwSxxIagDqoXZO+Ko6HeD2dIlwLSPJDqCDg/PW7Ax1ZrEx+9kK5xbEtw0U
	 3lP3/sLNjtPZLfPfGSTKZWFRSzETVyO9r9vVnAlcfp/8Zmmp9SmWlSElfAWO2g1foL
	 s6iNMR39U+50s4t3CpDP6MVjdupVjr+YTW+AiiPyG+xRV46F+dRUee1sfr635QoR/Z
	 aaIZ4y/Q1hio5X7XlVzJjzzFEM4b6lPXls7ez0YnLI1mmI6VbnBnjPr47L1DXPtfe4
	 Zupp/CRIw9m1w==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 18 Jun 2025 22:53:36 +0200
Subject: [PATCH v2 02/16] libfs: massage path_from_stashed() to allow
 custom stashing behavior
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-work-pidfs-persistent-v2-2-98f3456fd552@kernel.org>
References: <20250618-work-pidfs-persistent-v2-0-98f3456fd552@kernel.org>
In-Reply-To: <20250618-work-pidfs-persistent-v2-0-98f3456fd552@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
 Lennart Poettering <lennart@poettering.net>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.15-dev-262a7
X-Developer-Signature: v=1; a=openpgp-sha256; l=3222; i=brauner@kernel.org;
 h=from:subject:message-id; bh=S3KQgxjP8ukMLpt3/tkVFetgsJ+rIEWVjl61OyN601I=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQEq0ces2zmbjus2adRK/8nQFskvrrwfMmsmU+z2c0kz
 yzPEJzfUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJEiZ0aGO5yuyWW2eiyNc3Lz
 Tzr85Iq3iA1UYZjGnj7hood8YTgfI8MVhWm9/SY1kR7HBW8FLOSqeT6TtVzGWUxeIoXpam5cIhc A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

* Add a callback to struct stashed_operations so it's possible to
  implement custom behavior for pidfs and allow for it to return errors.

* Teach stashed_dentry_get() to handle error pointers.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/internal.h |  3 +++
 fs/libfs.c    | 27 ++++++++++++++++++++-------
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index 393f6c5c24f6..22ba066d1dba 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -322,12 +322,15 @@ struct mnt_idmap *alloc_mnt_idmap(struct user_namespace *mnt_userns);
 struct mnt_idmap *mnt_idmap_get(struct mnt_idmap *idmap);
 void mnt_idmap_put(struct mnt_idmap *idmap);
 struct stashed_operations {
+	struct dentry *(*stash_dentry)(struct dentry **stashed,
+				       struct dentry *dentry);
 	void (*put_data)(void *data);
 	int (*init_inode)(struct inode *inode, void *data);
 };
 int path_from_stashed(struct dentry **stashed, struct vfsmount *mnt, void *data,
 		      struct path *path);
 void stashed_dentry_prune(struct dentry *dentry);
+struct dentry *stash_dentry(struct dentry **stashed, struct dentry *dentry);
 struct dentry *stashed_dentry_get(struct dentry **stashed);
 /**
  * path_mounted - check whether path is mounted
diff --git a/fs/libfs.c b/fs/libfs.c
index 9ea0ecc325a8..3541e22c87b5 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -2128,6 +2128,8 @@ struct dentry *stashed_dentry_get(struct dentry **stashed)
 	dentry = rcu_dereference(*stashed);
 	if (!dentry)
 		return NULL;
+	if (IS_ERR(dentry))
+		return dentry;
 	if (!lockref_get_not_dead(&dentry->d_lockref))
 		return NULL;
 	return dentry;
@@ -2176,8 +2178,7 @@ static struct dentry *prepare_anon_dentry(struct dentry **stashed,
 	return dentry;
 }
 
-static struct dentry *stash_dentry(struct dentry **stashed,
-				   struct dentry *dentry)
+struct dentry *stash_dentry(struct dentry **stashed, struct dentry *dentry)
 {
 	guard(rcu)();
 	for (;;) {
@@ -2218,12 +2219,15 @@ static struct dentry *stash_dentry(struct dentry **stashed,
 int path_from_stashed(struct dentry **stashed, struct vfsmount *mnt, void *data,
 		      struct path *path)
 {
-	struct dentry *dentry;
+	struct dentry *dentry, *res;
 	const struct stashed_operations *sops = mnt->mnt_sb->s_fs_info;
 
 	/* See if dentry can be reused. */
-	path->dentry = stashed_dentry_get(stashed);
-	if (path->dentry) {
+	res = stashed_dentry_get(stashed);
+	if (IS_ERR(res))
+		return PTR_ERR(res);
+	if (res) {
+		path->dentry = res;
 		sops->put_data(data);
 		goto out_path;
 	}
@@ -2234,8 +2238,17 @@ int path_from_stashed(struct dentry **stashed, struct vfsmount *mnt, void *data,
 		return PTR_ERR(dentry);
 
 	/* Added a new dentry. @data is now owned by the filesystem. */
-	path->dentry = stash_dentry(stashed, dentry);
-	if (path->dentry != dentry)
+	if (sops->stash_dentry)
+		res = sops->stash_dentry(stashed, dentry);
+	else
+		res = stash_dentry(stashed, dentry);
+	if (IS_ERR(res)) {
+		dput(dentry);
+		return PTR_ERR(res);
+	}
+	path->dentry = res;
+	/* A dentry was reused. */
+	if (res != dentry)
 		dput(dentry);
 
 out_path:

-- 
2.47.2


