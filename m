Return-Path: <linux-fsdevel+bounces-59559-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2603B3AE1B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 01:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7227518982E7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 23:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09ED72DFF12;
	Thu, 28 Aug 2025 23:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="UiGZKOJL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DDA2E03EC
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 23:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756422494; cv=none; b=Y65ostCn4Xt+udBr9TnZPyBV1CGQQ+ww8XGYCA32vkmIPuLYOZjkSu6xIKQKiZWuuG9co2nmO4ErdHPVdJGgAvDyVbb8pZPNlaimxvzRTWt6ynaLpsMmvXQpWb8ALGmLAehzrigv04CvImGO49gYKYOOnIwwmHr9D4UTVfWIlxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756422494; c=relaxed/simple;
	bh=RVtWQ5vWE8Vht1mKEXsEmm7qfk2gpbXDP2udH92rdzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TUU4kF+A1fxyxpSdF2Tv9BT/MygXFZlesUQ8AIFoQJdDWcSLH68NsmOuGzJyiw7cizig7uUCX6drtCVjb42YIMv7h+6lWCKHu/ISDQx9zhRFqaiYqJwO488ysV57g42zNsN/VjmT5fF3bXIAs/HbZrMLGoHtY0UIqx3zZgvTdM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=UiGZKOJL; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=WV3VLrhHJIDjN9eEskWeka4Qtw0KvRn0auerYjfoz3Q=; b=UiGZKOJLPrY6cIuwnnm1m3QWQl
	ITghHU4dLjKifRN5UKEj0eXGhXTclwITKvLZe/qBVIipFYHZfy+qpRqcaaQRI6pEEbYQHXhPUMYf0
	y9GPnUqiPQLsBgonAe6+u5nC6wJ1yPTc7vIj06zQrtTwm9ZQhKGH06L/bSJfdW2TGkRQmjgn3k6u4
	1xIB2rZrC1XlJws0zEsDdDIa5BncqsI9ll99klAuaHmGBOiWYTeSo6C5JC3vLNMzaKNtnBW717Zsg
	xarMDiJ8XdVmsgh4/hkRRqQDtW4kZyzMbYIf96ij4eJSpT+K7CZAcbgrNAnVXvYqqDT1APxdgNy1h
	D6mfIYzQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urlj0-0000000F25F-1Izn;
	Thu, 28 Aug 2025 23:08:10 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 29/63] do_move_mount(): use the parent mount returned by do_lock_mount()
Date: Fri, 29 Aug 2025 00:07:32 +0100
Message-ID: <20250828230806.3582485-29-viro@zeniv.linux.org.uk>
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


