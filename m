Return-Path: <linux-fsdevel+bounces-58914-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8BAB3356A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 06:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 488521B20D58
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 04:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5243D27F749;
	Mon, 25 Aug 2025 04:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="kWr3FtT0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690352741DA
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 04:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756097041; cv=none; b=i7qE8KMcVD/+pLwP/dTA5b8uaylyNyOMP9HWB9cTtS81MmAuZ4/15p7ZYMhZ6/g3C+sXDUgMfMj7UJzQ3w0vcATw+mDLT045iMdNpZMu95es8dyPTWDDptsya2I1Glj2kD7ndl+0t0rtb0vSKVkFJkVYdPnXU2/1BTv0CSIKg4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756097041; c=relaxed/simple;
	bh=oR45W6gRlfJHXk3Ec2Sj7FwsD3pHFb5uVEn4abNixbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M0ZO59WSaNpNZq+/sRBQ25iAWWUw7k/j27Gp0WlaKvehW5T7LKGx9fDdYuRnUfVxQGcj+zyQTbBSM9DfctsfslPOykeY4Nnwm29QLr2C1s2upgplSRVpGrcbO3eWfTLSjgnwQlg/kAWgPe93WPACmAgL1gBjk34rycay/tbBo0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=kWr3FtT0; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=gCyoDUN7abVX9zBac4xc0rxChijjoSJVaDo0Fyel2eM=; b=kWr3FtT0ZT/z5kSl5vtGQM05bQ
	tJvqAO++T48oDCuWzGcNFdLvYaWYt10a3ZZM5Ve/wxVAcE+t7u+ylWXmRZ8xiwvdCFHT6iSFmA6/6
	Nd5p+1UwO6Vyrn6+ilplYbKip8gqf3k0l4oFvw29SvqzsM8Q3bzczN2U2QRQt6GgH3ZmSrKOq71bv
	QyHZsqRfPCskXj6+O+NI9OvXUWMUEfD8SfmZ7z3Gp+3a13pP0jWv8VKa7zCmTjRjODbGE0WY7dwys
	Iat1Sov4z7Vr6r6bffgywMxJ+FKNq3jnyrCNpxnek3jyym+qsd9sq+xJLe9YpFWVkRvPmWpZym10z
	RM0cK9yA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqP3m-00000006TB6-06az;
	Mon, 25 Aug 2025 04:43:58 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH 20/52] move_mount(2): take sanity checks in 'beneath' case into do_lock_mount()
Date: Mon, 25 Aug 2025 05:43:23 +0100
Message-ID: <20250825044355.1541941-20-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

We want to mount beneath the given location.  For that operation to
make sense, location must be the root of some mount that has something
under it.  Currently we let it proceed if those requirements are not met,
with rather meaningless results, and have that bogosity caught further
down the road; let's fail early instead - do_lock_mount() doesn't make
sense unless those conditions hold, and checking them there makes
things simpler.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 42ef0d0c3d40..9e04133d81dd 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2768,12 +2768,19 @@ static int do_lock_mount(struct path *path, struct pinned_mountpoint *pinned, bo
 	struct path under = {};
 	int err = -ENOENT;
 
+	if (unlikely(beneath) && !path_mounted(path))
+		return -EINVAL;
+
 	for (;;) {
 		struct mount *m = real_mount(mnt);
 
 		if (beneath) {
 			path_put(&under);
 			read_seqlock_excl(&mount_lock);
+			if (unlikely(!mnt_has_parent(m))) {
+				read_sequnlock_excl(&mount_lock);
+				return -EINVAL;
+			}
 			under.mnt = mntget(&m->mnt_parent->mnt);
 			under.dentry = dget(m->mnt_mountpoint);
 			read_sequnlock_excl(&mount_lock);
@@ -3437,8 +3444,6 @@ static bool mount_is_ancestor(const struct mount *p1, const struct mount *p2)
  * @to:   mount under which to mount
  * @mp:   mountpoint of @to
  *
- * - Make sure that @to->dentry is actually the root of a mount under
- *   which we can mount another mount.
  * - Make sure that nothing can be mounted beneath the caller's current
  *   root or the rootfs of the namespace.
  * - Make sure that the caller can unmount the topmost mount ensuring
@@ -3459,12 +3464,6 @@ static int can_move_mount_beneath(struct mount *mnt_from,
 	struct mount *mnt_to = real_mount(to->mnt),
 		     *parent_mnt_to = mnt_to->mnt_parent;
 
-	if (!mnt_has_parent(mnt_to))
-		return -EINVAL;
-
-	if (!path_mounted(to))
-		return -EINVAL;
-
 	if (IS_MNT_LOCKED(mnt_to))
 		return -EINVAL;
 
-- 
2.47.2


