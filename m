Return-Path: <linux-fsdevel+bounces-51127-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7E6AD3001
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 10:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 166C0172642
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 08:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FDE9283149;
	Tue, 10 Jun 2025 08:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="hWuLF6W1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D9328000A
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jun 2025 08:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749543713; cv=none; b=DPgWkKZ09Tb9fSNGztY4N7gGPH0EKfYNoPS9tOPeVXmxv9Kidfrpb4uY80Ek960D07kaLsQeiwbB0WokOiQjkE4EFv73aojA5bBXu8/+leAfBfuGhkxBF37cHE3iLPwufYtEOtmwoctVFbiwztfrTCW6px+sI15c7EdjuD6+QXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749543713; c=relaxed/simple;
	bh=jK9Ylkd0A8nbfdhyOtq9LRb3Urn9W6M7AocUQtMPvJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q4oS4bP82JPTgTfcvyPMCmAb4tnIpNYLl7m/Iqt3cHc1Su3+SCHj0f+3LWdMwKp58IibSxhEaBnAiSuw1S5biArHUAna8NHS9wC027NthAk00S2zhHxll+g70tYxHSL3vP0m2MKO7jzd563/CFTaEMEcXb8ZEw8fEtRaNhyuj+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=hWuLF6W1; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=h0zPmOVUsgT/CZPfplgJTi5rMLuU8LPtq/r2HVqe6L8=; b=hWuLF6W1kWpHvKE0PKJIn2lrxH
	I3kmSHeR2RalS8tJ+tFxZw954WRmovXJFmhDbtbj1a6JEXiFL8mYaFUD201Trit2z28Bgj1M6DSwZ
	2kFriA/uI0BBwdr2Fx7PyVOuteEolAmI+PbwcRMJwF1P3qAyqT/8ausmNM7oao78alWc0FPJCCToG
	G4GKxrOVU1UH0WnXHczQLRrITHLuHntw8s/sIwY2Cs3f8vRFhxGThLySBqT8FYZnNWHisNEERFlXb
	TumwCRzTC4rgPS9jmD5TZPyZtrNqD3QiKgPx976zCD9VVbNSgByOclG/wGb4Zau0EPaxF8G6A9xtW
	CTWFqo9Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOuEw-00000004jLW-0Eac;
	Tue, 10 Jun 2025 08:21:50 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH 06/26] new predicate: anon_ns_root(mount)
Date: Tue, 10 Jun 2025 09:21:28 +0100
Message-ID: <20250610082148.1127550-6-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610082148.1127550-1-viro@zeniv.linux.org.uk>
References: <20250610081758.GE299672@ZenIV>
 <20250610082148.1127550-1-viro@zeniv.linux.org.uk>
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

NB: comment in do_mount_setattr() appears to be very confused...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/mount.h     |  7 +++++++
 fs/namespace.c | 17 +++--------------
 2 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/fs/mount.h b/fs/mount.h
index 9fe06e901cc8..18fa88ad752a 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -160,6 +160,13 @@ static inline bool is_anon_ns(struct mnt_namespace *ns)
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
index 2fb5b9fcd2cd..b229f74762de 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2485,9 +2485,7 @@ struct vfsmount *clone_private_mount(const struct path *path)
 	 * loops get created.
 	 */
 	if (!check_mnt(old_mnt)) {
-		if (!is_mounted(&old_mnt->mnt) ||
-			!is_anon_ns(old_mnt->mnt_ns) ||
-			mnt_has_parent(old_mnt))
+		if (!anon_ns_root(old_mnt))
 			return ERR_PTR(-EINVAL);
 
 		if (!check_for_nsfs_mounts(old_mnt))
@@ -3657,9 +3655,6 @@ static int do_move_mount(struct path *old_path,
 	ns = old->mnt_ns;
 
 	err = -EINVAL;
-	/* The thing moved must be mounted... */
-	if (!is_mounted(&old->mnt))
-		goto out;
 
 	if (check_mnt(old)) {
 		/* if the source is in our namespace... */
@@ -3672,10 +3667,8 @@ static int do_move_mount(struct path *old_path,
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
@@ -5036,10 +5029,6 @@ static int do_mount_setattr(struct path *path, struct mount_kattr *kattr)
 	err = -EINVAL;
 	lock_mount_hash();
 
-	/* Ensure that this isn't anything purely vfs internal. */
-	if (!is_mounted(&mnt->mnt))
-		goto out;
-
 	/*
 	 * If this is an attached mount make sure it's located in the callers
 	 * mount namespace. If it's not don't let the caller interact with it.
@@ -5051,7 +5040,7 @@ static int do_mount_setattr(struct path *path, struct mount_kattr *kattr)
 	 * neither has a parent nor is it a detached mount so we cannot
 	 * unconditionally check for detached mounts.
 	 */
-	if ((mnt_has_parent(mnt) || !is_anon_ns(mnt->mnt_ns)) && !check_mnt(mnt))
+	if (!anon_ns_root(mnt) && !check_mnt(mnt))
 		goto out;
 
 	/*
-- 
2.39.5


