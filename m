Return-Path: <linux-fsdevel+bounces-49127-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33877AB851B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 13:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 684813B12B6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 11:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC78929671C;
	Thu, 15 May 2025 11:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="C4gYHNBv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04293819
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 May 2025 11:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747309316; cv=none; b=Y4QhYhzIFSXqNFdbB2yBvfEUaSe9mtVrV7MvhIDiOG4qnJzgYvC+Rm3Vtjoro5vjRD8fsEU5DPxZ16eFGk7XayloDrO1WgSM0QTI2JHChEbfCrxBc0mYfdovUkGeDU+JNAfqHcnUkSSHMhZdlKdZmwwkVhUsav35YM6CqlwDE3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747309316; c=relaxed/simple;
	bh=ul8QlzlMSgxiDpgwFYbuW4jvXQ4NvfkH9ZdLKeC5y50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O+xq+fyQM7PwGjxAKSDVkmR2r+iy+DkLpH7qfsmgrTo38dgK1onWH6EsXg2gIDbxOWbqxdorPUOKx+SUTi6B+C0/v0k6I+2aC6NXvm1n1Lku5lp5gk/NmPW3Qq2cQBvB3P1bcbcEV0JISyDbrRNaZzNVzUAwaXUKBDLzyVd8l/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=C4gYHNBv; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WCvtuW2oWiTWn5OaykPrTg5fXw/3DqFm06SUGnd3WPg=; b=C4gYHNBviW4L1WhcbGJOBuuJYr
	VYsoNy4Dgj/eWYesbNYVVhDLibWOoHBUbPSL3zT172FOKBc0iLJ/TLFoDFNgy355gwqcF9GbtJZTV
	Cdq2rgLQLEuEejCiJh0mrY+Z9guqxUyqAfjpKhvSVNb6KFcqXQFdNEAlKFje4rHNH18XQR7blvfZR
	XhQg7OGeESFuUfZg4wBmw+inpcCNkAgzhoiFYW1gUEvm5R+QFoMbm3Z5zTSuTs+A2t2q5dZm9HAQH
	NUBz2hNc3btmj05aq/ilFAf4GSxIQWir2jpxKVS90bHzm408mWs1CTL3EE9WYnS4AGB1hi97LPSh7
	aPR6sv2Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFWyE-0000000DY7v-2MF7;
	Thu, 15 May 2025 11:41:50 +0000
Date: Thu, 15 May 2025 12:41:50 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [BUG] propagate_umount() breakage
Message-ID: <20250515114150.GA3221059@ZenIV>
References: <20250511232732.GC2023217@ZenIV>
 <87jz6m300v.fsf@email.froward.int.ebiederm.org>
 <20250513035622.GE2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513035622.GE2023217@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, May 13, 2025 at 04:56:22AM +0100, Al Viro wrote:

> And yes, it's going to be posted along with the proof of correctness -
> I've had it with the amount of subtle corner cases in that area ;-/

FWIW, it seems to survive testing; it's _not_ final - I'm still editing
the promised proof, but by this point it's stylistic work.  I hadn't
touched that kind of formal writing for quite a while, so the text is clumsy.
The code changes are pretty much in the final shape.  Current diff of
code (all in fs/pnode.*) relative to mainline:

diff --git a/fs/pnode.c b/fs/pnode.c
index fb77427df39e..32ecebbc1d19 100644
--- a/fs/pnode.c
+++ b/fs/pnode.c
@@ -24,11 +24,6 @@ static inline struct mount *first_slave(struct mount *p)
 	return list_entry(p->mnt_slave_list.next, struct mount, mnt_slave);
 }
 
-static inline struct mount *last_slave(struct mount *p)
-{
-	return list_entry(p->mnt_slave_list.prev, struct mount, mnt_slave);
-}
-
 static inline struct mount *next_slave(struct mount *p)
 {
 	return list_entry(p->mnt_slave.next, struct mount, mnt_slave);
@@ -136,6 +131,23 @@ void change_mnt_propagation(struct mount *mnt, int type)
 	}
 }
 
+static struct mount *__propagation_next(struct mount *m,
+					 struct mount *origin)
+{
+	while (1) {
+		struct mount *master = m->mnt_master;
+
+		if (master == origin->mnt_master) {
+			struct mount *next = next_peer(m);
+			return (next == origin) ? NULL : next;
+		} else if (m->mnt_slave.next != &master->mnt_slave_list)
+			return next_slave(m);
+
+		/* back at master */
+		m = master;
+	}
+}
+
 /*
  * get the next mount in the propagation tree.
  * @m: the mount seen last
@@ -153,31 +165,26 @@ static struct mount *propagation_next(struct mount *m,
 	if (!IS_MNT_NEW(m) && !list_empty(&m->mnt_slave_list))
 		return first_slave(m);
 
-	while (1) {
-		struct mount *master = m->mnt_master;
-
-		if (master == origin->mnt_master) {
-			struct mount *next = next_peer(m);
-			return (next == origin) ? NULL : next;
-		} else if (m->mnt_slave.next != &master->mnt_slave_list)
-			return next_slave(m);
+	return __propagation_next(m, origin);
+}
 
-		/* back at master */
-		m = master;
-	}
+static inline bool peers(const struct mount *m1, const struct mount *m2)
+{
+	return m1->mnt_group_id == m2->mnt_group_id && m1->mnt_group_id;
 }
 
 static struct mount *skip_propagation_subtree(struct mount *m,
 						struct mount *origin)
 {
 	/*
-	 * Advance m such that propagation_next will not return
-	 * the slaves of m.
+	 * Advance m past everything that gets propagation from it.
 	 */
-	if (!IS_MNT_NEW(m) && !list_empty(&m->mnt_slave_list))
-		m = last_slave(m);
+	struct mount *p = __propagation_next(m, origin);
 
-	return m;
+	while (p && peers(m, p))
+		p = __propagation_next(p, origin);
+
+	return p;
 }
 
 static struct mount *next_group(struct mount *m, struct mount *origin)
@@ -216,11 +223,6 @@ static struct mount *next_group(struct mount *m, struct mount *origin)
 static struct mount *last_dest, *first_source, *last_source, *dest_master;
 static struct hlist_head *list;
 
-static inline bool peers(const struct mount *m1, const struct mount *m2)
-{
-	return m1->mnt_group_id == m2->mnt_group_id && m1->mnt_group_id;
-}
-
 static int propagate_one(struct mount *m, struct mountpoint *dest_mp)
 {
 	struct mount *child;
@@ -463,109 +465,144 @@ void propagate_mount_unlock(struct mount *mnt)
 	}
 }
 
-static void umount_one(struct mount *mnt, struct list_head *to_umount)
+static LIST_HEAD(to_umount);
+static LIST_HEAD(candidates);
+
+static inline struct mount *first_candidate(void)
 {
-	CLEAR_MNT_MARK(mnt);
-	mnt->mnt.mnt_flags |= MNT_UMOUNT;
-	list_del_init(&mnt->mnt_child);
-	list_del_init(&mnt->mnt_umounting);
-	move_from_ns(mnt, to_umount);
+	if (list_empty(&candidates))
+		return NULL;
+	return list_first_entry(&candidates, struct mount, mnt_umounting);
 }
 
-/*
- * NOTE: unmounting 'mnt' naturally propagates to all other mounts its
- * parent propagates to.
- */
-static bool __propagate_umount(struct mount *mnt,
-			       struct list_head *to_umount,
-			       struct list_head *to_restore)
+static inline bool is_candidate(struct mount *m)
 {
-	bool progress = false;
-	struct mount *child;
-
-	/*
-	 * The state of the parent won't change if this mount is
-	 * already unmounted or marked as without children.
-	 */
-	if (mnt->mnt.mnt_flags & (MNT_UMOUNT | MNT_MARKED))
-		goto out;
+	return !list_empty(&m->mnt_umounting);
+}
 
-	/* Verify topper is the only grandchild that has not been
-	 * speculatively unmounted.
-	 */
-	list_for_each_entry(child, &mnt->mnt_mounts, mnt_child) {
-		if (child->mnt_mountpoint == mnt->mnt.mnt_root)
-			continue;
-		if (!list_empty(&child->mnt_umounting) && IS_MNT_MARKED(child))
-			continue;
-		/* Found a mounted child */
-		goto children;
-	}
+static inline bool will_be_unmounted(struct mount *m)
+{
+	return m->mnt.mnt_flags & MNT_UMOUNT;
+}
 
-	/* Mark mounts that can be unmounted if not locked */
-	SET_MNT_MARK(mnt);
-	progress = true;
+static void umount_one(struct mount *m)
+{
+	m->mnt.mnt_flags |= MNT_UMOUNT;
+	list_del_init(&m->mnt_child);
+	move_from_ns(m, &to_umount);
+}
 
-	/* If a mount is without children and not locked umount it. */
-	if (!IS_MNT_LOCKED(mnt)) {
-		umount_one(mnt, to_umount);
-	} else {
-children:
-		list_move_tail(&mnt->mnt_umounting, to_restore);
-	}
-out:
-	return progress;
+static void remove_candidate(struct mount *m)
+{
+	CLEAR_MNT_MARK(m);
+	list_del_init(&m->mnt_umounting);
 }
 
-static void umount_list(struct list_head *to_umount,
-			struct list_head *to_restore)
+static void gather_candidates(struct list_head *set)
 {
-	struct mount *mnt, *child, *tmp;
-	list_for_each_entry(mnt, to_umount, mnt_list) {
-		list_for_each_entry_safe(child, tmp, &mnt->mnt_mounts, mnt_child) {
-			/* topper? */
-			if (child->mnt_mountpoint == mnt->mnt.mnt_root)
-				list_move_tail(&child->mnt_umounting, to_restore);
-			else
-				umount_one(child, to_umount);
+	LIST_HEAD(visited);
+	struct mount *m, *p, *q;
+
+	list_for_each_entry(m, set, mnt_list) {
+		if (is_candidate(m))
+			continue;
+		list_add(&m->mnt_umounting, &visited);
+		p = m->mnt_parent;
+		q = propagation_next(p, p);
+		while (q) {
+			struct mount *child = __lookup_mnt(&q->mnt,
+							   m->mnt_mountpoint);
+			if (child) {
+				struct list_head *head;
+
+				if (is_candidate(child)) {
+					q = skip_propagation_subtree(q, p);
+					continue;
+				}
+				if (will_be_unmounted(child))
+					head = &visited;
+				else
+					head = &candidates;
+				list_add(&child->mnt_umounting, head);
+			}
+			q = propagation_next(q, p);
 		}
 	}
+	while (!list_empty(&visited))	// empty visited
+		list_del_init(visited.next);
 }
 
-static void restore_mounts(struct list_head *to_restore)
+static struct mount *trim_one(struct mount *m)
 {
-	/* Restore mounts to a clean working state */
-	while (!list_empty(to_restore)) {
-		struct mount *mnt, *parent;
-		struct mountpoint *mp;
-
-		mnt = list_first_entry(to_restore, struct mount, mnt_umounting);
-		CLEAR_MNT_MARK(mnt);
-		list_del_init(&mnt->mnt_umounting);
-
-		/* Should this mount be reparented? */
-		mp = mnt->mnt_mp;
-		parent = mnt->mnt_parent;
-		while (parent->mnt.mnt_flags & MNT_UMOUNT) {
-			mp = parent->mnt_mp;
-			parent = parent->mnt_parent;
+	bool remove_this = false, found = false, umount_this = false;
+	struct mount *n;
+	struct list_head *next;
+
+	list_for_each_entry(n, &m->mnt_mounts, mnt_child) {
+		if (!is_candidate(n)) {
+			found = true;
+			if (n->mnt_mountpoint != m->mnt.mnt_root) {
+				remove_this = true;
+				break;
+			}
 		}
-		if (parent != mnt->mnt_parent) {
-			mnt_change_mountpoint(parent, mp, mnt);
-			mnt_notify_add(mnt);
+	}
+	if (found) {
+		struct mount *this = m;
+		for (struct mount *p = this->mnt_parent;
+		     !IS_MNT_MARKED(this) && is_candidate(p);
+		     this = p, p = p->mnt_parent) {
+			SET_MNT_MARK(this);
+			if (this->mnt_mountpoint != p->mnt.mnt_root)
+				remove_candidate(p);
 		}
+	} else if (!IS_MNT_LOCKED(m) && list_empty(&m->mnt_mounts)) {
+		remove_this = true;
+		umount_this = true;
 	}
+	next = m->mnt_umounting.next;
+	if (remove_this) {
+		remove_candidate(m);
+		if (umount_this)
+			umount_one(m);
+	}
+	if (next == &candidates)
+		return NULL;
+
+	return list_entry(next, struct mount, mnt_umounting);
 }
 
-static void cleanup_umount_visitations(struct list_head *visited)
+static void handle_locked(struct mount *m)
 {
-	while (!list_empty(visited)) {
-		struct mount *mnt =
-			list_first_entry(visited, struct mount, mnt_umounting);
-		list_del_init(&mnt->mnt_umounting);
+	struct mount *cutoff = m, *p;
+
+	for (p = m; is_candidate(p); p = p->mnt_parent) {
+		remove_candidate(p);
+		if (!IS_MNT_LOCKED(p))
+			cutoff = p->mnt_parent;
+	}
+	if (will_be_unmounted(p))
+		cutoff = p;
+	while (m != cutoff) {
+		umount_one(m);
+		m = m->mnt_parent;
 	}
 }
 
+static void reparent(struct mount *m)
+{
+	struct mount *p = m;
+	struct mountpoint *mp;
+
+	do {
+		mp = p->mnt_mp;
+		p = p->mnt_parent;
+	} while (will_be_unmounted(p));
+
+	mnt_change_mountpoint(p, mp, m);
+	mnt_notify_add(m);
+}
+
 /*
  * collect all mounts that receive propagation from the mount in @list,
  * and return these additional mounts in the same list.
@@ -573,71 +610,27 @@ static void cleanup_umount_visitations(struct list_head *visited)
  *
  * vfsmount lock must be held for write
  */
-int propagate_umount(struct list_head *list)
+void propagate_umount(struct list_head *set)
 {
-	struct mount *mnt;
-	LIST_HEAD(to_restore);
-	LIST_HEAD(to_umount);
-	LIST_HEAD(visited);
+	struct mount *m;
 
-	/* Find candidates for unmounting */
-	list_for_each_entry_reverse(mnt, list, mnt_list) {
-		struct mount *parent = mnt->mnt_parent;
-		struct mount *m;
+	gather_candidates(set);
 
-		/*
-		 * If this mount has already been visited it is known that it's
-		 * entire peer group and all of their slaves in the propagation
-		 * tree for the mountpoint has already been visited and there is
-		 * no need to visit them again.
-		 */
-		if (!list_empty(&mnt->mnt_umounting))
-			continue;
+	// make it non-shifting
+	for (m = first_candidate(); m; m = trim_one(m))
+		;
 
-		list_add_tail(&mnt->mnt_umounting, &visited);
-		for (m = propagation_next(parent, parent); m;
-		     m = propagation_next(m, parent)) {
-			struct mount *child = __lookup_mnt(&m->mnt,
-							   mnt->mnt_mountpoint);
-			if (!child)
-				continue;
-
-			if (!list_empty(&child->mnt_umounting)) {
-				/*
-				 * If the child has already been visited it is
-				 * know that it's entire peer group and all of
-				 * their slaves in the propgation tree for the
-				 * mountpoint has already been visited and there
-				 * is no need to visit this subtree again.
-				 */
-				m = skip_propagation_subtree(m, parent);
-				continue;
-			} else if (child->mnt.mnt_flags & MNT_UMOUNT) {
-				/*
-				 * We have come across a partially unmounted
-				 * mount in a list that has not been visited
-				 * yet. Remember it has been visited and
-				 * continue about our merry way.
-				 */
-				list_add_tail(&child->mnt_umounting, &visited);
-				continue;
-			}
+	// ... and non-revealing
+	while (!list_empty(&candidates))
+		handle_locked(first_candidate());
 
-			/* Check the child and parents while progress is made */
-			while (__propagate_umount(child,
-						  &to_umount, &to_restore)) {
-				/* Is the parent a umount candidate? */
-				child = child->mnt_parent;
-				if (list_empty(&child->mnt_umounting))
-					break;
-			}
-		}
+	// now to_umount consists of all non-rejected candidates
+	// deal with reparenting of remaining overmounts on those
+	list_for_each_entry(m, &to_umount, mnt_list) {
+		while (!list_empty(&m->mnt_mounts)) // should be at most one
+			reparent(list_first_entry(&m->mnt_mounts,
+						  struct mount, mnt_child));
 	}
 
-	umount_list(&to_umount, &to_restore);
-	restore_mounts(&to_restore);
-	cleanup_umount_visitations(&visited);
-	list_splice_tail(&to_umount, list);
-
-	return 0;
+	list_splice_tail_init(&to_umount, set);
 }
diff --git a/fs/pnode.h b/fs/pnode.h
index 34b6247af01d..d84a397bfd43 100644
--- a/fs/pnode.h
+++ b/fs/pnode.h
@@ -39,7 +39,7 @@ static inline void set_mnt_shared(struct mount *mnt)
 void change_mnt_propagation(struct mount *, int);
 int propagate_mnt(struct mount *, struct mountpoint *, struct mount *,
 		struct hlist_head *);
-int propagate_umount(struct list_head *);
+void propagate_umount(struct list_head *);
 int propagate_mount_busy(struct mount *, int);
 void propagate_mount_unlock(struct mount *);
 void mnt_release_group_id(struct mount *);

