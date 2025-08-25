Return-Path: <linux-fsdevel+bounces-58927-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E50B33571
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 06:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EE1304E2593
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 04:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21898283C9C;
	Mon, 25 Aug 2025 04:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="RpX6nNr0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAF527A919
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 04:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756097043; cv=none; b=LTimOxdItovsV63JEWhi12bWMG/MT5wn3PED4wOVnozR4WdELpIpz9CDUWfSGawVkuksbd4rQVPjAJiGHq+IzzxpoV1Lgf+51nbIZLtCAnPoLyxj0O9GSYVidoMgpNhtDnL/S0RWJPSnScoWT7Z5mDu+Z0IAoDUhOkYOjvccnS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756097043; c=relaxed/simple;
	bh=ZpMjrO4BMqXTsU7J2vaGX35IgtcD+5XZ1hpqmyzewSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dHtoJzMY/6ZlUd8mKZ4cgj5WUiI+jFKeYVv9DmRyYN7GwmYRr2Lg8iWo0qaAayX3s0H3mQihkwgtGNSaharOKiq5gdKMeYdh2g4c2rOu3wPnBJjhyX1bkQ2Else9CFRBiMvr0U/hKwIGoPYxSByitBpc7x2YcTzOWicvC3o0pvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=RpX6nNr0; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=QRD+jSvoEmEbb+ynOCDxC1py+C0HDlvNpzPGNvaJnXE=; b=RpX6nNr0MwTf/9qz9qm9Vy3LWH
	XuBpTD7mmTJtVARkSe/7XY4QgMc77+/m7cPxmSib2wa1bhb63YWhrvHP2zV8MF1LZ9i4sUupsQUwf
	HzLlfhRzUOglsR6WFs6O2hId2Kvd5L4G5qT8M2NWArq+/ZIkAjMtZnxLp4jj0Uc4C1F/IYMiI+S8w
	RLM2D7DcNiXjm5Q4WJLNuebhMWrkuxx0PRjhW6i7RVrhC0bpcr54cRKhG2QOmU0q/43IVauip1/RY
	BrKmBhsQsD9c1RkcTyxQdGG0aeGW1MFivoDVzqTuPsAbT8kCBxsFq6CY8L4s0w3Zd4UkDCH2O2fH1
	dszjk3XQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqP3n-00000006TCN-0GUH;
	Mon, 25 Aug 2025 04:43:59 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH 28/52] do_move_mount(): use the parent mount returned by do_lock_mount()
Date: Mon, 25 Aug 2025 05:43:31 +0100
Message-ID: <20250825044355.1541941-28-viro@zeniv.linux.org.uk>
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

After successful do_lock_mount() call, mp.parent is set to either
real_mount(path->mnt) (for !beneath case) or to ->mnt_parent of that
(for beneath).  p is set to real_mount(path->mnt) and after
several uses it's made equal to mp.parent.  All uses prior to that
care only about p->mnt_ns and since p->mnt_ns == parent->mnt_ns,
we might as well use mp.parent all along.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 8d6e26e2c97a..05019dde25a0 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3571,7 +3571,6 @@ static inline bool may_use_mount(struct mount *mnt)
 static int do_move_mount(struct path *old_path,
 			 struct path *new_path, enum mnt_tree_flags_t flags)
 {
-	struct mount *p;
 	struct mount *old = real_mount(old_path->mnt);
 	int err;
 	bool beneath = flags & MNT_TREE_BENEATH;
@@ -3586,8 +3585,6 @@ static int do_move_mount(struct path *old_path,
 	if (IS_ERR(mp.parent))
 		return PTR_ERR(mp.parent);
 
-	p = real_mount(new_path->mnt);
-
 	if (check_mnt(old)) {
 		/* if the source is in our namespace... */
 		/* ... it should be detachable from parent */
@@ -3597,7 +3594,7 @@ static int do_move_mount(struct path *old_path,
 		if (IS_MNT_SHARED(old->mnt_parent))
 			return -EINVAL;
 		/* ... and the target should be in our namespace */
-		if (!check_mnt(p))
+		if (!check_mnt(mp.parent))
 			return -EINVAL;
 	} else {
 		/*
@@ -3610,13 +3607,13 @@ static int do_move_mount(struct path *old_path,
 		 * subsequent checks would've rejected that, but they lose
 		 * some corner cases if we check it early.
 		 */
-		if (old->mnt_ns == p->mnt_ns)
+		if (old->mnt_ns == mp.parent->mnt_ns)
 			return -EINVAL;
 		/*
 		 * Target should be either in our namespace or in an acceptable
 		 * anon namespace, sensu check_anonymous_mnt().
 		 */
-		if (!may_use_mount(p))
+		if (!may_use_mount(mp.parent))
 			return -EINVAL;
 	}
 
@@ -3624,22 +3621,20 @@ static int do_move_mount(struct path *old_path,
 		err = can_move_mount_beneath(old, new_path, mp.mp);
 		if (err)
 			return err;
-
-		p = p->mnt_parent;
 	}
 
 	/*
 	 * Don't move a mount tree containing unbindable mounts to a destination
 	 * mount which is shared.
 	 */
-	if (IS_MNT_SHARED(p) && tree_contains_unbindable(old))
+	if (IS_MNT_SHARED(mp.parent) && tree_contains_unbindable(old))
 		return -EINVAL;
 	if (!check_for_nsfs_mounts(old))
 		return -ELOOP;
-	if (mount_is_ancestor(old, p))
+	if (mount_is_ancestor(old, mp.parent))
 		return -ELOOP;
 
-	return attach_recursive_mnt(old, p, mp.mp);
+	return attach_recursive_mnt(old, mp.parent, mp.mp);
 }
 
 static int do_move_mount_old(struct path *path, const char *old_name)
-- 
2.47.2


