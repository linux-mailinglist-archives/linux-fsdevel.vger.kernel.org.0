Return-Path: <linux-fsdevel+bounces-51132-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF2BAD3006
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 10:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C46F718843C3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 08:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20DE5283C87;
	Tue, 10 Jun 2025 08:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="XdZ7SVdd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F9D22DFBB
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jun 2025 08:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749543715; cv=none; b=u3DaRPCYeud6khE/V0zIvWP+/2T3Nsi2wKuJTIfINDee+dEH3D1sQnndktXi42THyjt+FpmB01VOcXTvhLXMZ7NOQl1vaacmroTj/CDywunqf7P+WeLdSA2Ln1k0NmORMwzhoEfrv0vLcDzm2fVLrfPhnJxjZUgrq/FuOur7g2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749543715; c=relaxed/simple;
	bh=CUC5B56ibYtbRP4yQ3j9jIJMZYOadm/EsskGzKBIKvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I0X0Anx1qLMy26oC1Zht5FuVP3JZHKTEXuV2b4jsgYa4h0V8vHlRN3/L40iDmRrKdWAkDQK4wZeFsQC4qhUZuRxGfjOyp+bXgLt87ypM+MjBYG9rpv/JOq6GyZI0vA6BC+7HdOk7jj7NwVqlziHQGbLyslfPZeIdm1iwnFJTSb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=XdZ7SVdd; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=tIJKAEoKuk4SpHaY1twxekj8Ols/fVjxItntaOVVSoU=; b=XdZ7SVdd15l2UJl8w6MZmQ++aT
	hW+Ot6NuzGKokxkVNrUIVxhQmROsa2HEt1haeKB0Uzmv9vCRTXLG2sQjkRiNIo33hx78M8t7rCbOi
	j6gFL5q8Q7IkSYznaQuKt19ORA9Yl6QREKFoKa3grqGDOY5D4kDoZVkbosieZaaJ++AODWqpaT4SF
	7DDR8mCUM2MPyCYGAetBW3nTuYFQVtXon5ij9TERUG7YhWUX5pj9Uyi+EhQ8/hIRfN1/LT0UKpBA4
	mhhUUbINCkTUCV141M6Np9P/6R64d63wwhlaC3PxW/3RXIxuw4PBLJ5YiiV0ACqeG1S+j8TzY60Es
	KqIL4iOQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOuEx-00000004jNW-1Ngf;
	Tue, 10 Jun 2025 08:21:51 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH 16/26] make commit_tree() usable in same-namespace move case
Date: Tue, 10 Jun 2025 09:21:38 +0100
Message-ID: <20250610082148.1127550-16-viro@zeniv.linux.org.uk>
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

Once attach_recursive_mnt() has created all copies of original subtree,
it needs to put them in place(s).

Steps needed for those are slightly different:
	1) in 'move' case, original copy doesn't need any rbtree
manipulations (everything's already in the same namespace where it will
be), but it needs to be detached from the current location
	2) in 'attach' case, original may be in anon namespace; if it is,
all those mounts need to removed from their current namespace before
insertion into the target one
	3) additional copies have a couple of extra twists - in case
of cross-userns propagation we need to lock everything other the root of
subtree and in case when we end up inserting under an existing mount,
that mount needs to be found (for original copy we have it explicitly
passed by the caller).

Quite a bit of that can be unified; as the first step, make commit_tree()
helper (inserting mounts into namespace, hashing the root of subtree
and marking the namespace as updated) usable in all cases; (2) and (3)
are already using it and for (1) we only need to make the insertion of
mounts into namespace conditional.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 22bbc30a2da1..50c46c084b13 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1166,15 +1166,17 @@ static void commit_tree(struct mount *mnt)
 
 	BUG_ON(parent == mnt);
 
-	list_add_tail(&head, &mnt->mnt_list);
-	while (!list_empty(&head)) {
-		m = list_first_entry(&head, typeof(*m), mnt_list);
-		list_del(&m->mnt_list);
+	if (!mnt_ns_attached(mnt)) {
+		list_add_tail(&head, &mnt->mnt_list);
+		while (!list_empty(&head)) {
+			m = list_first_entry(&head, typeof(*m), mnt_list);
+			list_del(&m->mnt_list);
 
-		mnt_add_to_ns(n, m);
+			mnt_add_to_ns(n, m);
+		}
+		n->nr_mounts += n->pending_mounts;
+		n->pending_mounts = 0;
 	}
-	n->nr_mounts += n->pending_mounts;
-	n->pending_mounts = 0;
 
 	__attach_mnt(mnt, parent);
 	touch_mnt_namespace(n);
@@ -2660,12 +2662,7 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 
 	if (moving) {
 		umount_mnt(source_mnt);
-		mnt_set_mountpoint(dest_mnt, dest_mp, source_mnt);
-		if (beneath)
-			mnt_change_mountpoint(source_mnt, smp, top_mnt);
-		__attach_mnt(source_mnt, source_mnt->mnt_parent);
 		mnt_notify_add(source_mnt);
-		touch_mnt_namespace(source_mnt->mnt_ns);
 	} else {
 		if (source_mnt->mnt_ns) {
 			LIST_HEAD(head);
@@ -2675,12 +2672,13 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 				move_from_ns(p, &head);
 			list_del_init(&head);
 		}
-		mnt_set_mountpoint(dest_mnt, dest_mp, source_mnt);
-		if (beneath)
-			mnt_change_mountpoint(source_mnt, smp, top_mnt);
-		commit_tree(source_mnt);
 	}
 
+	mnt_set_mountpoint(dest_mnt, dest_mp, source_mnt);
+	if (beneath)
+		mnt_change_mountpoint(source_mnt, smp, top_mnt);
+	commit_tree(source_mnt);
+
 	hlist_for_each_entry_safe(child, n, &tree_list, mnt_hash) {
 		struct mount *q;
 		hlist_del_init(&child->mnt_hash);
-- 
2.39.5


