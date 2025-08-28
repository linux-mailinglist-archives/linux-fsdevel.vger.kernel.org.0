Return-Path: <linux-fsdevel+bounces-59549-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8490DB3AE0C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 01:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CB30583A10
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 23:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59AA82EE61A;
	Thu, 28 Aug 2025 23:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="kSB10+ma"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFCE2D29DF
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 23:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756422493; cv=none; b=SVLBxkiHJP1XgIA153L7hi7P0X7GzYgrhSc00n2IZXfOQ+oFbVVN5HkqqumTTfWQUTtmcgkkCYiAKyOx+e6KWAdjcRP3oy102uv1+j1mDeg950rLrFmbq9TdgDKuh5tmzMSmt8RzmuJ8GNTjTilkNi3Al/Np4t9WNd7Jqss8C1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756422493; c=relaxed/simple;
	bh=m/coEnNbH+P7SylpfJg8DyX7lDlWzw9afVduL5nIfGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dvbv7arRUx3wipxsKg92TZxwm1KbTT19ybKIN6lpbWXLjsaIPXTsJGpCUS3I1JKwAOXlZz1TOU8v2CjHdFDjBF/ZZSFhI1954s9A0oLpA4MoXX53bYK6/F1t7XDNYc/XafuZN2vlQ0Bwsr7i8YPZhOKDS3wo6h8Ludy1bNutXec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=kSB10+ma; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=CZHBGSSTTw1zKK6/3B3cf90IWt/OO6Vekbco0kTSI3E=; b=kSB10+maBkMj1aQW3CuahRL9B7
	Yeh90oa2lIgVKXMqtsmMphC6CbD2qh5ivYJwWmCL9/excUTltK727P2PMmzrmTsD7Ke3m8oZ9PK09
	h1aOphhJQKUmSBefcCqkB81OXze5WnMiqSCDmEUmXk4pCVqQ/rTWSYvI0nnLCrWeiZQRv9NkFxwGR
	bX+xWbN123caPDAdDfLsMjj1v9Dr2Aa/uqcG7Vw87tEUnnFKd3NdXqn4bi9hzRIRfAZfJ8LnksFdR
	BtK+0qoXdgTC1sQTRdiIZ4jWLYLEim1yde54yigvqiBU4O7DUCLua0yKUUJ7MFznsXxeJiaNm/P2E
	dOXj77cQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urliz-0000000F23w-1SSs;
	Thu, 28 Aug 2025 23:08:09 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 21/63] move_mount(2): take sanity checks in 'beneath' case into do_lock_mount()
Date: Fri, 29 Aug 2025 00:07:24 +0100
Message-ID: <20250828230806.3582485-21-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
References: <20250828230706.GA3340273@ZenIV>
 <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
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

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 74c67ea1b5a8..86c6dd432b13 100644
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


