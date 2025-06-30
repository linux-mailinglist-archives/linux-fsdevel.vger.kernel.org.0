Return-Path: <linux-fsdevel+bounces-53249-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0798CAED28F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 04:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5B2516F29F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 02:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB301D88D0;
	Mon, 30 Jun 2025 02:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="wVurX4qb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E37117A2E1
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 02:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751251979; cv=none; b=Bxgy3fMuR1RVGK3kX3hmeWP9jU28ozCPwmv5r+JMHaIr96MIAtk9Nv3UluUhAe/dirld7fd4MGS7fWWymM6ANG4iJ8ex0LkbhXjzCkD1q9uwylhotIGC9lGwjrT2D6G3yvKD3Q2HpR5pCZsZkf/NwYwZQxvGa3+GMZZoeCPXzCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751251979; c=relaxed/simple;
	bh=zJ/OvRQIjANEa7R9ZpFQarwecDu84m5XpOiUcOgNn0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D7vAbq+W5LrNoibSqzwlKRdF7+xfKq3N/DHpeSFGqC8KZ+ESQmPKILNODZhndMjt4pQotT8F9pKpGbzrArTeqUylilqVeVaFCyhc2vyBgYDnn/7Z1AoBhEbyzqyP30LumGrAufVb8gQQkjvldoLb2mLHY1mGcLb7HWqaFO0AWww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=wVurX4qb; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=1OFYHkW8EdEnhL6WppTokCyfYRSvZpVudQK8QGQWeS4=; b=wVurX4qbYVEg+5O2kFrbbheWSZ
	6aXq3p0DPt9IvviEV7/p2raD5rISWDXIsE6nLEjfi90ZCljY1ANRldijQUpInRf1GW0cY0n9iB3ZQ
	UoZ8+nJC4sQTSLoi+e07JWAeUXAy6890spWLKTJ7CKcKULcPakRlBb/qY/+2k8KbxztLgELbtGezp
	IdNwcmf3/SQfS/g8PuDn5nn467KleyH8H1FgIQ5Gik9x5GO8LBtbBOM9KC5RpOAI4NN99EQgThQ1h
	0Oldwa0E5QxSyDDe6cAKRjgQBxQ0JFgyRjCj2sPeCr9oYv+1QcfWiRdL1VRx6KWz4FgDWY5U033XH
	FdH79Qow==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uW4db-00000005ovz-2xlK;
	Mon, 30 Jun 2025 02:52:55 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 03/48] prevent mount hash conflicts
Date: Mon, 30 Jun 2025 03:52:10 +0100
Message-ID: <20250630025255.1387419-3-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250630025255.1387419-1-viro@zeniv.linux.org.uk>
References: <20250630025148.GA1383774@ZenIV>
 <20250630025255.1387419-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Currently it's still possible to run into a pathological situation when
two hashed mounts share both parent and mountpoint.  That does not work
well, for obvious reasons.

We are not far from getting rid of that; the only remaining gap is
attach_recursive_mnt() not being careful enough when sliding a tree
under existing mount (for propagated copies or in 'beneath' case for
the original one).

To deal with that cleanly we need to be able to find overmounts
(i.e. mounts on top of parent's root); we could do hash lookups or scan
the list of children but either would be costly.  Since one of the results
we get from that will be prevention of multiple parallel overmounts, let's
just bite the bullet and store a (non-counting) reference to overmount
in struct mount.

With that done, closing the hole in attach_recursive_mnt() becomes easy
- we just need to follow the chain of overmounts before we change the
mountpoint of the mount we are sliding things under.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/mount.h     |  1 +
 fs/namespace.c | 27 ++++++++++++++++++++++-----
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/fs/mount.h b/fs/mount.h
index ad7173037924..b8beafdd6d24 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -92,6 +92,7 @@ struct mount {
 	int mnt_expiry_mark;		/* true if marked for expiry */
 	struct hlist_head mnt_pins;
 	struct hlist_head mnt_stuck_children;
+	struct mount *overmount;	/* mounted on ->mnt_root */
 } __randomize_layout;
 
 #define MNT_NS_INTERNAL ERR_PTR(-EINVAL) /* distinct from any mnt_namespace */
diff --git a/fs/namespace.c b/fs/namespace.c
index 888816289154..9b732d74c2cc 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1043,6 +1043,9 @@ static void __touch_mnt_namespace(struct mnt_namespace *ns)
 static struct mountpoint *unhash_mnt(struct mount *mnt)
 {
 	struct mountpoint *mp;
+	struct mount *parent = mnt->mnt_parent;
+	if (unlikely(parent->overmount == mnt))
+		parent->overmount = NULL;
 	mnt->mnt_parent = mnt;
 	mnt->mnt_mountpoint = mnt->mnt.mnt_root;
 	list_del_init(&mnt->mnt_child);
@@ -1078,6 +1081,8 @@ void mnt_set_mountpoint(struct mount *mnt,
 
 static void __attach_mnt(struct mount *mnt, struct mount *parent)
 {
+	if (unlikely(mnt->mnt_mountpoint == parent->mnt.mnt_root))
+		parent->overmount = mnt;
 	hlist_add_head_rcu(&mnt->mnt_hash,
 			   m_hash(&parent->mnt, mnt->mnt_mountpoint));
 	list_add_tail(&mnt->mnt_child, &parent->mnt_mounts);
@@ -2660,7 +2665,9 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 	HLIST_HEAD(tree_list);
 	struct mnt_namespace *ns = top_mnt->mnt_ns;
 	struct mountpoint *smp;
+	struct mountpoint *secondary = NULL;
 	struct mount *child, *dest_mnt, *p;
+	struct mount *top;
 	struct hlist_node *n;
 	int err = 0;
 	bool moving = flags & MNT_TREE_MOVE, beneath = flags & MNT_TREE_BENEATH;
@@ -2669,9 +2676,15 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 	 * Preallocate a mountpoint in case the new mounts need to be
 	 * mounted beneath mounts on the same mountpoint.
 	 */
-	smp = get_mountpoint(source_mnt->mnt.mnt_root);
+	for (top = source_mnt; unlikely(top->overmount); top = top->overmount) {
+		if (!secondary && is_mnt_ns_file(top->mnt.mnt_root))
+			secondary = top->mnt_mp;
+	}
+	smp = get_mountpoint(top->mnt.mnt_root);
 	if (IS_ERR(smp))
 		return PTR_ERR(smp);
+	if (!secondary)
+		secondary = smp;
 
 	/* Is there space to add these mounts to the mount namespace? */
 	if (!moving) {
@@ -2704,7 +2717,7 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 		unhash_mnt(source_mnt);
 		mnt_set_mountpoint(dest_mnt, dest_mp, source_mnt);
 		if (beneath)
-			mnt_change_mountpoint(source_mnt, smp, top_mnt);
+			mnt_change_mountpoint(top, smp, top_mnt);
 		__attach_mnt(source_mnt, source_mnt->mnt_parent);
 		mnt_notify_add(source_mnt);
 		touch_mnt_namespace(source_mnt->mnt_ns);
@@ -2719,7 +2732,7 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 		}
 		mnt_set_mountpoint(dest_mnt, dest_mp, source_mnt);
 		if (beneath)
-			mnt_change_mountpoint(source_mnt, smp, top_mnt);
+			mnt_change_mountpoint(top, smp, top_mnt);
 		commit_tree(source_mnt);
 	}
 
@@ -2732,8 +2745,12 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 		child->mnt.mnt_flags &= ~MNT_LOCKED;
 		q = __lookup_mnt(&child->mnt_parent->mnt,
 				 child->mnt_mountpoint);
-		if (q)
-			mnt_change_mountpoint(child, smp, q);
+		if (q) {
+			struct mount *r = child;
+			while (unlikely(r->overmount))
+				r = r->overmount;
+			mnt_change_mountpoint(r, secondary, q);
+		}
 		commit_tree(child);
 	}
 	put_mountpoint(smp);
-- 
2.39.5


