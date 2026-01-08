Return-Path: <linux-fsdevel+bounces-72842-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 32385D03E99
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 16:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09319334B0C7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 15:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16C44A28A4;
	Thu,  8 Jan 2026 13:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESjcFKh/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DC54A1584;
	Thu,  8 Jan 2026 13:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767879454; cv=none; b=F2bLPjBsk7w4QWR56tT+J+DtLZ702JErT1MsQFNKc3Mwatp1KChBSfsGPetK7h6ZFfHe26mdhRr3OspRWOg3uxUg/LB/RT4D7p7h61qzEdSPREIDxGvcegR7B7UgiJPxZzhMlnqRRXFoYAKMJ6K00IN00wkZkmgpyKJGVfj8yKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767879454; c=relaxed/simple;
	bh=jnpE+GOhx5EoNWwHLxdul7nCM/ZBv6dkrLJ9V7znT+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K6FZikcVC2LBT7L6ifp18EIhXFkY3/znXIOi6r2ZcGyUfFAmpJYRKi/JWId3DLO/Zj3HZ4Hq7z6agviYIx8lDQ/+e4lQea3K2C9l79yiTHgl2ONrqoekSXThumDyURAzT6vf2DKazZkLxErxlmTC9QcFGHogfgjEOjfjyjdBuf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ESjcFKh/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42FBFC116C6;
	Thu,  8 Jan 2026 13:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767879452;
	bh=jnpE+GOhx5EoNWwHLxdul7nCM/ZBv6dkrLJ9V7znT+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ESjcFKh/efIQ6whZlcl+onsojTWGS56BuRCs2vjUpMzL8tLDuIpVwg1VXGSASrKpB
	 8A5LZpTizY9b5iva872+8PCNj1iXevJLXPVE07NRxCG+vd7KYVQns07TnSbYMaPl6d
	 KA5AJ3YEbABxyOMAQhUUFX7DBld1NXIHgmEX9sL+2MZH9lr8IJ4Jdv/Xj2eKAz+EWj
	 xMYu+H0UoeLDEtEP3ubLyJ0RU/SHLATNJtN6WwYBqEkvU5geu3rBAZ+9Nz/1/66/sl
	 Yk+RdnjIf4AI9ON+ntrj9rTk76YstuslTtQCJgVupNGyPUDSCpBiOIUEy6n73I2fWc
	 2TQFTG+ePsYuw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 4/4] btrfs: use may_create_dentry() in btrfs_mksubvol()
Date: Thu,  8 Jan 2026 13:35:34 +0000
Message-ID: <a56191f13dc946951f94ddec1dc714991576d38f.1767801889.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1767801889.git.fdmanana@suse.com>
References: <cover.1767801889.git.fdmanana@suse.com>
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


