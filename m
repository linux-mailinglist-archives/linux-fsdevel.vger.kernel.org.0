Return-Path: <linux-fsdevel+bounces-52440-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 326D0AE3470
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 06:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF24C16D333
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 04:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A5D1DE8AF;
	Mon, 23 Jun 2025 04:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="wRttHsnQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1752A1C84CD
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 04:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750654473; cv=none; b=EUnIdbxLybjMieA43BqrZ2KYPg8giSWmXid7mBTyqE2VPBUQHIYyVqG6kAHA0IeLhRyqgsfLSB1HqvguZwwPByjFZajto+aI3tNR0BBOje3usmdQFKfVaSnYqsbe3Ky4uN3frNq4YEB1bIRJ90rzoznUwSljSMD3FNFX6ph7uJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750654473; c=relaxed/simple;
	bh=NlXA/eg+5iMW3PXZyHxz1FTPk/yPhMGecITCqytXFfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Omy3LS0mMBLU7HxiPoS++UvR+daQcsP3eh0JYTCZEq5l/eD688AE06xOK5kIbbXgt2jv1urOOxQHe4atHPWMU2gPWxh55IY9AdXG2RemK3DqxEtrqzBcHEIv078bN9SFNP2KrUrvYE+0w2JWoDiPezRDFj6vKEE4zuGJkLG7xMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=wRttHsnQ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ZofnoN7QO2ii2G5Zg6nAlPIpUxu30vwjNXNGExyMcFA=; b=wRttHsnQKsI4WmxbA/xnxyeq7X
	+zgdJPLgfdhF0ZJLLoapOSmB0T1ssKpf4NSsDPhZlznzJWTXjen70URNU/10Epcn6qdI2QTWXN5ln
	1rgaApI5fjD9nrRYJAMPBZ1Bw9huGChVVdXVrAtbNGMQFOkYbArC/bMSHlExtSVv3QXDq2jqmfgTc
	3BHidSssieNgaXaVpHnvWoS7eE5oq7MZhNg3QlxXdt1iVRZOBXQlGo0oF+3fmk9tE+foS3TAKa+QA
	mKAffx59xFbuAyZ54apoO+i61eDYpms6ndnctow3CERcCQpzOqJamGapSx6rgnWF9ouvq0Ml2+ftq
	oqwIJ2Pw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTZCP-00000005KpN-1tQV;
	Mon, 23 Jun 2025 04:54:29 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 11/35] new predicate: anon_ns_root(mount)
Date: Mon, 23 Jun 2025 05:54:04 +0100
Message-ID: <20250623045428.1271612-11-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623045428.1271612-1-viro@zeniv.linux.org.uk>
References: <20250623044912.GA1248894@ZenIV>
 <20250623045428.1271612-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

checks if mount is the root of an anonymouns namespace.
Switch open-coded equivalents to using it.

For mounts that belong to anon namespace !mnt_has_parent(mount)
is the same as mount == ns->root, and intent is more obvious in
the latter form.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/mount.h     |  7 +++++++
 fs/namespace.c | 28 +++-------------------------
 2 files changed, 10 insertions(+), 25 deletions(-)

diff --git a/fs/mount.h b/fs/mount.h
index f10776003643..f20e6ed845fe 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -161,6 +161,13 @@ static inline bool is_anon_ns(struct mnt_namespace *ns)
 	return ns->seq == 0;
 }
 
+static inline bool anon_ns_root(const struct mount *m)
+{
+	struct mnt_namespace *ns = READ_ONCE(m->mnt_ns);
+
+	return !IS_ERR_OR_NULL(ns) && is_anon_ns(ns) && m == ns->root;
+}
+
 static inline bool mnt_ns_attached(const struct mount *mnt)
 {
 	return !RB_EMPTY_NODE(&mnt->mnt_node);
diff --git a/fs/namespace.c b/fs/namespace.c
index 1d68bfc3dc35..82791f636442 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2480,9 +2480,7 @@ struct vfsmount *clone_private_mount(const struct path *path)
 	 * loops get created.
 	 */
 	if (!check_mnt(old_mnt)) {
-		if (!is_mounted(&old_mnt->mnt) ||
-			!is_anon_ns(old_mnt->mnt_ns) ||
-			mnt_has_parent(old_mnt))
+		if (!anon_ns_root(old_mnt))
 			return ERR_PTR(-EINVAL);
 
 		if (!check_for_nsfs_mounts(old_mnt))
@@ -3649,9 +3647,6 @@ static int do_move_mount(struct path *old_path,
 	ns = old->mnt_ns;
 
 	err = -EINVAL;
-	/* The thing moved must be mounted... */
-	if (!is_mounted(&old->mnt))
-		goto out;
 
 	if (check_mnt(old)) {
 		/* if the source is in our namespace... */
@@ -3664,10 +3659,8 @@ static int do_move_mount(struct path *old_path,
 	} else {
 		/*
 		 * otherwise the source must be the root of some anon namespace.
-		 * AV: check for mount being root of an anon namespace is worth
-		 * an inlined predicate...
 		 */
-		if (!is_anon_ns(ns) || mnt_has_parent(old))
+		if (!anon_ns_root(old))
 			goto out;
 		/*
 		 * Bail out early if the target is within the same namespace -
@@ -5028,22 +5021,7 @@ static int do_mount_setattr(struct path *path, struct mount_kattr *kattr)
 	err = -EINVAL;
 	lock_mount_hash();
 
-	/* Ensure that this isn't anything purely vfs internal. */
-	if (!is_mounted(&mnt->mnt))
-		goto out;
-
-	/*
-	 * If this is an attached mount make sure it's located in the callers
-	 * mount namespace. If it's not don't let the caller interact with it.
-	 *
-	 * If this mount doesn't have a parent it's most often simply a
-	 * detached mount with an anonymous mount namespace. IOW, something
-	 * that's simply not attached yet. But there are apparently also users
-	 * that do change mount properties on the rootfs itself. That obviously
-	 * neither has a parent nor is it a detached mount so we cannot
-	 * unconditionally check for detached mounts.
-	 */
-	if ((mnt_has_parent(mnt) || !is_anon_ns(mnt->mnt_ns)) && !check_mnt(mnt))
+	if (!anon_ns_root(mnt) && !check_mnt(mnt))
 		goto out;
 
 	/*
-- 
2.39.5


