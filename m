Return-Path: <linux-fsdevel+bounces-73429-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0349D18E02
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 13:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 65DE63025D4E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 12:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039983921EE;
	Tue, 13 Jan 2026 12:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PF4llJeA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4012C3921C1;
	Tue, 13 Jan 2026 12:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768308007; cv=none; b=G167z4Z46MBzdOgz4bbA1MqroPLzPt5r1Veq1eaWBahIQTO722rlYfdV4/zclyFEvNZGpNUP0hroHr/rARlC1yY40BoLrZA9DzDHMckgUsPt0O+c5BQJMGBPAq4mmZ1CqROlMOlFJdv/R+fC/5FhzqKvqTgQqjksRs0beLs8CZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768308007; c=relaxed/simple;
	bh=Lv5aQYt1S+AsybwYIda35LYrIfpv0CIsobN+r+TjrEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HNd+NGO9EptPwlX7qk7Dt7S42WiUjFYBN7fT35qhtxD3K2FFWqosZFdtfvpYkZ0NDAQF6rhIoOq/bXRFo/vRqVTXrxx2pEJYqvBQUXeiGtFxOsqnlOZPwvnoRl1c+jDr7Mn5Y49r2/4V6QpreTlcdz3ymP9anf/oJqu5K4/dwTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PF4llJeA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD828C19424;
	Tue, 13 Jan 2026 12:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768308007;
	bh=Lv5aQYt1S+AsybwYIda35LYrIfpv0CIsobN+r+TjrEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PF4llJeAjq2SOcyk9iogo6ks/ORW+RJpMNUwszELSw8qjborZb8dkzcdJpRwPI02o
	 kV2XcnuncFsD5g97m2zDae7GHWDYHcf5Y3g8tGYe5cmC+a9JnnZnnJpec+t+CUCGVT
	 yQjVpfTbIk4I23zXQXOUw98GBz55WHmIeCCHMH+/E+5vuSHpBSFclxrE5sn5SzAAgF
	 /HnHyfKt0+MoAJx53HYvpSnwaEukyAHQwlcGvW9D/zduMOl6WcEt7+IP7jzPcdBUqD
	 VbibPN3PfnUCFCs2J80NU0t8KX3EnzybdWr+jQEwOoj3LULNSmVrBhiaYpGZQWFL76
	 FAUkrbMGseZxQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	dsterba@suse.com,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v2 4/4] btrfs: use may_create_dentry() in btrfs_mksubvol()
Date: Tue, 13 Jan 2026 12:39:53 +0000
Message-ID: <adf8c802c77ec1c855ea9fe12491120ccc29a294.1768307858.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1768307858.git.fdmanana@suse.com>
References: <cover.1768307858.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There is no longer the need to use btrfs_may_create(), which was a copy
of the VFS private function may_create(), since now that functionality
is exported by the VFS as a function named may_create_dentry(). So change
btrfs_mksubvol() to use the VFS function and remove btrfs_may_create().

Note that the btrfs copy was missing an audit_inode_child() call that we
have in the VFS function. This only reinforces the need to use a common
function, as it's very easy for the btrfs copy to get out of sync and
therefore a maintenance burden.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ioctl.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 0cb3cd3d05a5..9cf37459ef6d 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -815,19 +815,6 @@ static int create_snapshot(struct btrfs_root *root, struct inode *dir,
 	return ret;
 }
 
-/* copy of may_create in fs/namei.c() */
-static inline int btrfs_may_create(struct mnt_idmap *idmap,
-				   struct inode *dir, const struct dentry *child)
-{
-	if (d_really_is_positive(child))
-		return -EEXIST;
-	if (IS_DEADDIR(dir))
-		return -ENOENT;
-	if (!fsuidgid_has_mapping(dir->i_sb, idmap))
-		return -EOVERFLOW;
-	return inode_permission(idmap, dir, MAY_WRITE | MAY_EXEC);
-}
-
 /*
  * Create a new subvolume below @parent.  This is largely modeled after
  * sys_mkdirat and vfs_mkdir, but we only do a single component lookup
@@ -849,7 +836,7 @@ static noinline int btrfs_mksubvol(struct dentry *parent,
 	if (IS_ERR(dentry))
 		return PTR_ERR(dentry);
 
-	ret = btrfs_may_create(idmap, dir, dentry);
+	ret = may_create_dentry(idmap, dir, dentry);
 	if (ret)
 		goto out_dput;
 
-- 
2.47.2


