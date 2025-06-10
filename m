Return-Path: <linux-fsdevel+bounces-51136-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F66AD300F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 10:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8C5F18854C6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 08:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29BA283FE9;
	Tue, 10 Jun 2025 08:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="GrQNOG7W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B651327AC4C
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jun 2025 08:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749543715; cv=none; b=QBIxAJNyjcIUbAPK7r5CNKnwg8SSbUpt4VNgN3vFE0IiDNeswmZBkItnyE5pkWmxyaVSjJfI1NagSx1eSKtA/gt3p7lN979/IY9nuHu1oyKEFSr2KRbqTdNI/oVkRHwUHKHBv0gKdOeG2MSXxZqj/q2tfw4cZ+s2vmO32aHZINQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749543715; c=relaxed/simple;
	bh=DsughnHk1P0UepytSh6CNEgMwPNaSODbyHbsWpmvuDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oLdcYZ1HEb0zg1HjwBPpD3K1F6oDWrDD+TDkDPib5D0zj+qzqeuligwTWZNh+YO1DVLMQcxwKWnE/Y7tLxanIyF//7d0s553VC3CMPnzrlkoG3X0ACF/V6I/fegUtgCg6RkCL3U5CzahasHOZPodU9shNnJdkYvG+nr8Y4cL/5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=GrQNOG7W; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=3mqt/srhAkRHCOawbOeBz4lLg7tqlL7lvVNPfc6GPHE=; b=GrQNOG7WGHVbHltv0Z46uosK0o
	jcU+ZpEsKXu+tqPT+RYFj6AiX3swzDfWLaIT1L/PlI0HYAZOn+BsMt5Q5wI9qn5wezyCMr1VKW47f
	KyXzEmTgKLvInQ5WDkBMm6re0zEvrnc1BpEUxOQSX9MdHdS/0b3fbqBRc6S8vwRsNgOteqqrGUq5Q
	WjHs0PoyZOAsduKwSl59SGKXcI73H4ODcBoJ94HLkbQSb4LSyovpA/FYfr+kY2frLXs3FAac6jwkU
	ULX/PvsH4DfWjaJc0bmEht7Jj6JjbZys1t8XtvSi0Xa95A9atOYaL9G5xVbmJgFFslQK8GjKi5lzS
	QkU+et1A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOuEx-00000004jNP-12Nu;
	Tue, 10 Jun 2025 08:21:51 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH 15/26] get rid of mnt_set_mountpoint_beneath()
Date: Tue, 10 Jun 2025 09:21:37 +0100
Message-ID: <20250610082148.1127550-15-viro@zeniv.linux.org.uk>
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

mnt_set_mountpoint_beneath() consists of attaching new mount side-by-side
with the one we want to mount beneath (by mnt_set_mountpoint()), followed
by mnt_change_mountpoint() shifting the the top mount onto the new one
(by mnt_change_mountpoint()).

Both callers of mnt_set_mountpoint_beneath (both in attach_recursive_mnt())
have the same form - in 'beneath' case we call mnt_set_mountpoint_beneath(),
otherwise - mnt_set_mountpoint().

The thing is, expressing that as unconditional mnt_set_mountpoint(),
followed, in 'beneath' case, by mnt_change_mountpoint() is just as easy.
And these mnt_change_mountpoint() callers are similar to the ones we
do when it comes to attaching propagated copies, which will allow more
cleanups in the next commits.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 37 ++++---------------------------------
 1 file changed, 4 insertions(+), 33 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index b176075ad833..22bbc30a2da1 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1075,33 +1075,6 @@ void mnt_set_mountpoint(struct mount *mnt,
 	hlist_add_head(&child_mnt->mnt_mp_list, &mp->m_list);
 }
 
-/**
- * mnt_set_mountpoint_beneath - mount a mount beneath another one
- *
- * @new_parent: the source mount
- * @top_mnt:    the mount beneath which @new_parent is mounted
- * @new_mp:     the new mountpoint of @top_mnt on @new_parent
- *
- * Remove @top_mnt from its current mountpoint @top_mnt->mnt_mp and
- * parent @top_mnt->mnt_parent and mount it on top of @new_parent at
- * @new_mp. And mount @new_parent on the old parent and old
- * mountpoint of @top_mnt.
- *
- * Context: This function expects namespace_lock() and lock_mount_hash()
- *          to have been acquired in that order.
- */
-static void mnt_set_mountpoint_beneath(struct mount *new_parent,
-				       struct mount *top_mnt,
-				       struct mountpoint *new_mp)
-{
-	struct mount *old_top_parent = top_mnt->mnt_parent;
-	struct mountpoint *old_top_mp = top_mnt->mnt_mp;
-
-	mnt_set_mountpoint(old_top_parent, old_top_mp, new_parent);
-	mnt_change_mountpoint(new_parent, new_mp, top_mnt);
-}
-
-
 static void __attach_mnt(struct mount *mnt, struct mount *parent)
 {
 	hlist_add_head_rcu(&mnt->mnt_hash,
@@ -2687,10 +2660,9 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 
 	if (moving) {
 		umount_mnt(source_mnt);
+		mnt_set_mountpoint(dest_mnt, dest_mp, source_mnt);
 		if (beneath)
-			mnt_set_mountpoint_beneath(source_mnt, top_mnt, smp);
-		else
-			mnt_set_mountpoint(top_mnt, dest_mp, source_mnt);
+			mnt_change_mountpoint(source_mnt, smp, top_mnt);
 		__attach_mnt(source_mnt, source_mnt->mnt_parent);
 		mnt_notify_add(source_mnt);
 		touch_mnt_namespace(source_mnt->mnt_ns);
@@ -2703,10 +2675,9 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 				move_from_ns(p, &head);
 			list_del_init(&head);
 		}
+		mnt_set_mountpoint(dest_mnt, dest_mp, source_mnt);
 		if (beneath)
-			mnt_set_mountpoint_beneath(source_mnt, top_mnt, smp);
-		else
-			mnt_set_mountpoint(dest_mnt, dest_mp, source_mnt);
+			mnt_change_mountpoint(source_mnt, smp, top_mnt);
 		commit_tree(source_mnt);
 	}
 
-- 
2.39.5


