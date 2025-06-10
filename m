Return-Path: <linux-fsdevel+bounces-51129-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C1BAD3003
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 10:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B730218951DE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 08:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80657283144;
	Tue, 10 Jun 2025 08:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="vLlFmVhl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E28280327
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jun 2025 08:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749543714; cv=none; b=RI54M6mugpOXAs0cIQCog+60s4kZxXzy+JZyTFepuVKo5bL984yAxy50MdCpmyPtVdAI1cg0Lf0Ga+DYqZYIAbZBEetwg155fgJQ0XDEAMuZ9XBwp4RdA8jA/7kbNRJZtY7Ko4dLhrW6mpej2QadGHbwrx1OO6f9ywlekr1Ii3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749543714; c=relaxed/simple;
	bh=PtQZ6hSEK/jzdFi+P9MeH33iv9Kof3V7F3aqsXk8Y9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f46fD1XL9wKXhnnn0kCAXpzTDAVvOP+6YilJ/qjJKIxUScezy2WzjYNx/vZxghbcMsF60OVx/lv64ICZVKtyNGDdPDSmVt8qInO6J/d8HPB6stvOu3zpRelVWJTxyQr0pVaoMsrDc8J6lnKJepYZo33QDcSs9+ClBvKlYeXn1dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=vLlFmVhl; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=gB08QDGAOotsazx+lnP48zv/UcZDnos8q2BUIOP9AEk=; b=vLlFmVhlYfdf+Iyv++hbXBv4jS
	s+x51Qh+SzHotT4V/KkLXrCatDlLWxv/iKgwTFMvdsfrIrKdAEiWb4mpRavTClXIA4FGsieRnkD8k
	Vr4tRe41CvoVkmAqt1A+9eZM/S3AIV6kgBB9UGSG3smX707gP/x+rLTP8G8P90JhqemzVZfiREfCH
	IQwK3QHrJ/77dqMdvbkcCrDdAkQKsoq39GLFvqTqK8QPqyGPJJI6M1EgdjcA7Nn1c9MBU7Ps0CTXd
	4D749W2QkArVYL4UNUbmpQONy0lB9LkVBpT2H5wA06L1dZ7nS4O940dSSefaSIoyXYLvnDwtDLa09
	HI8qDpZA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOuEx-00000004jNB-0Loa;
	Tue, 10 Jun 2025 08:21:51 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH 13/26] attach_mnt(): expand in attach_recursive_mnt(), then lose the flag argument
Date: Tue, 10 Jun 2025 09:21:35 +0100
Message-ID: <20250610082148.1127550-13-viro@zeniv.linux.org.uk>
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

simpler that way - all but one caller pass false as 'beneath' argument,
and that one caller is actually happier with the call expanded - the
logics with choice of mountpoint is identical for 'moving' and 'attaching'
cases, and now that is no longer hidden.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 37 ++++++++++++-------------------------
 1 file changed, 12 insertions(+), 25 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 1ec7b1d63e94..409ffbf35d7d 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1115,16 +1115,10 @@ static void __attach_mnt(struct mount *mnt, struct mount *parent)
  * @parent:  the parent
  * @mnt:     the new mount
  * @mp:      the new mountpoint
- * @beneath: whether to mount @mnt beneath or on top of @parent
  *
- * If @beneath is false, mount @mnt at @mp on @parent. Then attach @mnt
+ * Mount @mnt at @mp on @parent. Then attach @mnt
  * to @parent's child mount list and to @mount_hashtable.
  *
- * If @beneath is true, remove @mnt from its current parent and
- * mountpoint and mount it on @mp on @parent, and mount @parent on the
- * old parent and old mountpoint of @mnt. Finally, attach @parent to
- * @mnt_hashtable and @parent->mnt_parent->mnt_mounts.
- *
  * Note, when __attach_mnt() is called @mnt->mnt_parent already points
  * to the correct parent.
  *
@@ -1132,18 +1126,9 @@ static void __attach_mnt(struct mount *mnt, struct mount *parent)
  *          to have been acquired in that order.
  */
 static void attach_mnt(struct mount *mnt, struct mount *parent,
-		       struct mountpoint *mp, bool beneath)
+		       struct mountpoint *mp)
 {
-	if (beneath)
-		mnt_set_mountpoint_beneath(mnt, parent, mp);
-	else
-		mnt_set_mountpoint(parent, mp, mnt);
-	/*
-	 * Note, @mnt->mnt_parent has to be used. If @mnt was mounted
-	 * beneath @parent then @mnt will need to be attached to
-	 * @parent's old parent, not @parent. IOW, @mnt->mnt_parent
-	 * isn't the same mount as @parent.
-	 */
+	mnt_set_mountpoint(parent, mp, mnt);
 	__attach_mnt(mnt, mnt->mnt_parent);
 }
 
@@ -1156,7 +1141,7 @@ void mnt_change_mountpoint(struct mount *parent, struct mountpoint *mp, struct m
 	hlist_del_init(&mnt->mnt_mp_list);
 	hlist_del_init_rcu(&mnt->mnt_hash);
 
-	attach_mnt(mnt, parent, mp, false);
+	attach_mnt(mnt, parent, mp);
 
 	put_mountpoint(old_mp);
 	mnt_add_count(old_parent, -1);
@@ -2308,7 +2293,7 @@ struct mount *copy_tree(struct mount *src_root, struct dentry *dentry,
 			if (src_mnt->mnt.mnt_flags & MNT_LOCKED)
 				dst_mnt->mnt.mnt_flags |= MNT_LOCKED;
 			list_add_tail(&dst_mnt->mnt_list, &res->mnt_list);
-			attach_mnt(dst_mnt, dst_parent, src_parent->mnt_mp, false);
+			attach_mnt(dst_mnt, dst_parent, src_parent->mnt_mp);
 			unlock_mount_hash();
 		}
 	}
@@ -2701,10 +2686,12 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 	}
 
 	if (moving) {
-		if (beneath)
-			dest_mp = smp;
 		unhash_mnt(source_mnt);
-		attach_mnt(source_mnt, top_mnt, dest_mp, beneath);
+		if (beneath)
+			mnt_set_mountpoint_beneath(source_mnt, top_mnt, smp);
+		else
+			mnt_set_mountpoint(top_mnt, dest_mp, source_mnt);
+		__attach_mnt(source_mnt, source_mnt->mnt_parent);
 		mnt_notify_add(source_mnt);
 		touch_mnt_namespace(source_mnt->mnt_ns);
 	} else {
@@ -4783,9 +4770,9 @@ SYSCALL_DEFINE2(pivot_root, const char __user *, new_root,
 		root_mnt->mnt.mnt_flags &= ~MNT_LOCKED;
 	}
 	/* mount old root on put_old */
-	attach_mnt(root_mnt, old_mnt, old_mp, false);
+	attach_mnt(root_mnt, old_mnt, old_mp);
 	/* mount new_root on / */
-	attach_mnt(new_mnt, root_parent, root_mp, false);
+	attach_mnt(new_mnt, root_parent, root_mp);
 	mnt_add_count(root_parent, -1);
 	touch_mnt_namespace(current->nsproxy->mnt_ns);
 	/* A moved mount should not expire automatically */
-- 
2.39.5


