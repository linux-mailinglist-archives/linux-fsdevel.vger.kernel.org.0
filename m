Return-Path: <linux-fsdevel+bounces-60069-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE08CB413DF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 06:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C457681105
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 04:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775A12D8375;
	Wed,  3 Sep 2025 04:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="i/HuxdTA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898F62D594B
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 04:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756875346; cv=none; b=U28g0QjZEiTH5q7dM0cDo/QEbTSt+Wow4AeTFIxOhqC1Me9/zwROpzhhq7v3FhBAUHc5p7cbSzolkCdwP7fA7N1jsCGOAGOOMaPVi6vWwI7BvbQI7o7W2oVwAqy9k7cMCvMk+lUcLmPgYryuOkXr2dMoFezonllrHjmy49+dhlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756875346; c=relaxed/simple;
	bh=Ebi705O7wzOf9AvE8cWGfE5/8bgRF2oS2bLUhu5QmOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LDk4BYChymIj7In8WahHlV9rcJfW6m4tPqurT0skEpEfJFOAk97VTwtNQ8XfPyQPiGRbItb4hHh8Q3/lTYRr1eDAsc36Px/e5XC7+swP+uO411LkqFUQUkUpoMktx2KhxkVxqVD10sY8EXg7QrYU7n739CqyWQDrQgxXsgR4vlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=i/HuxdTA; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=380zyv1VqMalkeEnrbrRayJcFs16FD5qTXiGHqel9WE=; b=i/HuxdTACb2OrRNlpZ6wJc+sUW
	9hE4PEXHEMhOWo2ahzpCTOwsZmHidmczmHXuhtS0scPqsyguDvTq8wE2CAjKDiQkxy42GiPwXeYfr
	KsrGdrivqeUHFHTpKYaZ3hbU8QvEHWyetGvCKF33Zd5c8lURK3mYypjVQyDQcr0pYdTnRv/RPSFHV
	Bd5KhRRRWn0D7JtAbeSVavbav8mmGedcN+Tlv1J5/KH2znZ6q223cYdCsHy0s9E0USkmhF1vudGam
	ZXWDSZOVX0cFjat1DUm2Hu1RBE52gqr6cHW91P4XlHZPGj4XsZZZJ4hkowboo8KnUcQL6ngQDZH4u
	StbMkd0A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utfX4-0000000ApAL-3WOR;
	Wed, 03 Sep 2025 04:55:42 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 29/65] do_move_mount(): use the parent mount returned by do_lock_mount()
Date: Wed,  3 Sep 2025 05:54:51 +0100
Message-ID: <20250903045537.2579614-30-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250903045537.2579614-1-viro@zeniv.linux.org.uk>
References: <20250903045432.GH39973@ZenIV>
 <20250903045537.2579614-1-viro@zeniv.linux.org.uk>
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

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 952e66bdb9bb..d57e727962da 100644
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


