Return-Path: <linux-fsdevel+bounces-49548-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B16ABE7E4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 01:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A0847A2E6A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 23:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B93257AEE;
	Tue, 20 May 2025 23:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="PTYFd7wx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966B21E25EB
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 May 2025 23:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747782544; cv=none; b=ZMnPMdhE0dI8tqd0SjMKi8VEEa9aO4nyBJKJG2b5I91qYhXkcWRr3naZFMGpoqLK0mxjOhH9KWsVfrowLlxzeUIm+D37i5A9+1BVJsPMe0ambwCv7gCYCMjnqHPUobBeVfKMH309oinCB9j5qC4IbCeHZajMuB+a1d5Ty9yJNhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747782544; c=relaxed/simple;
	bh=3XUezhbjmcy4y3Lm2bqL1K5hDVPL7iMZ14TUZ0CBG0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n38N3Yzzr9qDcEOS85y9xCyEzF2YlDJOHcxN9IDy5co1FIX13SLcvTj5JRv7GxOc9hGz77Sv4LTyDi9pJR7Zr9t63ixXUQrCHnJUoTKir8fS6f1b7cICs9mcPsMt17LPAkuohKrGvL7PYtIlSTfl7XwoatYfh7HJPJp9jEDrizk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=PTYFd7wx; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vHqBo30ovk0JeoMy+I3zcA5wHKB3SGfB1Mb+O8kjQOo=; b=PTYFd7wxxx70vV4hboM/O77N4m
	/5tl3S1nbrUQnAjL8+/alfSIOzYfiR7nxFOGXktWimr5lZg55PrwcOZa5wHFEXnbRZhgnTTjQnyQD
	bSzrukJ24BqKWzU0J6I8wMl6ZUs5zh4gXSzLNu4PBuDfbwwgSgaGnr8LBuKZa5ktj0Dj8a59d82F7
	3fpWoR+tZc2vTVK1VvPPyunS56F5Boe7Pm4WNPf7VBD/8hadNQPqvxFrjOw9Wo+2/wHovVSrysQdg
	5EwbhpMstkObwtIAI75MJ6sgWhqFV4e8o1H2Y9lx7VdgsYpaRsZ/8eBViBxDjeKpqYIlMQKdZEedu
	y9uF0wvQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHW4x-000000048C3-0E4U;
	Tue, 20 May 2025 23:08:59 +0000
Date: Wed, 21 May 2025 00:08:59 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [RFC][CFT][PATCH] Rewrite of propagate_umount() (was Re: [BUG]
 propagate_umount() breakage)
Message-ID: <20250520230859.GE2023217@ZenIV>
References: <20250511232732.GC2023217@ZenIV>
 <87jz6m300v.fsf@email.froward.int.ebiederm.org>
 <20250513035622.GE2023217@ZenIV>
 <20250515114150.GA3221059@ZenIV>
 <20250515114749.GB3221059@ZenIV>
 <20250516052139.GA4080802@ZenIV>
 <CAHk-=wi1r1QFu=mfr75VtsCpx3xw_uy5yMZaCz2Cyxg0fQh4hg@mail.gmail.com>
 <20250519213508.GA2023217@ZenIV>
 <87wmaancic.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wmaancic.fsf@email.froward.int.ebiederm.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, May 20, 2025 at 05:27:55PM -0500, Eric W. Biederman wrote:

> I have only skimmed this so far, and I am a bit confused what we
> are using MNT_MARK for.   I would think we should be able to use
> MNT_MARK instead of stealing another bit.

MNT_MARK is used to avoid walking the same ancestry chain again and
again - once we have done that once and removed all non-overmounts,
we no longer will run into any when reaching that chain.  Otherwise
we can run into unpleasant situation: 1000-long chain of overmounts,
with a bush on top of it.  Basically, when we see something in
that bush with strictly internal non-candidate, we need to take out
all non-overmounts in the chain of ancestor candidates.  Walking
the same 1000-long chunk for each of those would be not only pointless,
it would give O(N^2) worst case time complexity.

Anyway, I have something I believe is a more readable approach -
have an explicit MNT_UMOUNT_CANDIDATE set by gather_candidates(),
use it for is_candidate(m) and instead of remove_candidate() in
trim_ancestors() just clean the MNT_UMOUNT_CANDIDATE there.

Then, in the beginning of trim_one() *and* handle_locked() have
	if (!is_candidate(m)) {
		remove_from_candidate_list(m);
		return;
	}

Ta-da - trim_one() can be used with list_for_each_entry_safe() now,
so it doesn't need to return anything.

gather_candidates() doesn't need the list of already seen elements 
of original set - we just set MNT_UMOUNT_CANDIDATE on encountered
mounts, still put the ones not in original set on candidates and
and leave the original ones on the original list.  Instead of
dissolving linkage in 'visited' we loop through the original set
and remove those MNT_UMOUNT_CANDIDATE there.

What's more, that allows to kill mnt_umounting linkage - we never
use both at the same time now, so 'candidates' can use mnt_list
linkage instead.

I've started tests right now, will update D/f/propagate_umount.txt,
convert away from global lists and push if it survives the tests.

In the meanwhile, the incremental I'm testing right now is this:

diff --git a/fs/mount.h b/fs/mount.h
index 7aecf2a60472..65275d031e61 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -84,7 +84,6 @@ struct mount {
 		struct hlist_node mnt_mp_list;	/* list mounts with the same mountpoint */
 		struct hlist_node mnt_umount;
 	};
-	struct list_head mnt_umounting; /* list entry for umount propagation */
 #ifdef CONFIG_FSNOTIFY
 	struct fsnotify_mark_connector __rcu *mnt_fsnotify_marks;
 	__u32 mnt_fsnotify_mask;
diff --git a/fs/namespace.c b/fs/namespace.c
index 34b47bd82c38..028db59e2b26 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -382,7 +382,6 @@ static struct mount *alloc_vfsmnt(const char *name)
 		INIT_LIST_HEAD(&mnt->mnt_slave_list);
 		INIT_LIST_HEAD(&mnt->mnt_slave);
 		INIT_HLIST_NODE(&mnt->mnt_mp_list);
-		INIT_LIST_HEAD(&mnt->mnt_umounting);
 		INIT_HLIST_HEAD(&mnt->mnt_stuck_children);
 		RB_CLEAR_NODE(&mnt->mnt_node);
 		mnt->mnt.mnt_idmap = &nop_mnt_idmap;
diff --git a/fs/pnode.c b/fs/pnode.c
index 9b2f1ac80f25..605bb22011e0 100644
--- a/fs/pnode.c
+++ b/fs/pnode.c
@@ -470,14 +470,12 @@ static LIST_HEAD(candidates);	// undecided unmount candidates
 
 static inline struct mount *first_candidate(void)
 {
-	if (list_empty(&candidates))
-		return NULL;
-	return list_first_entry(&candidates, struct mount, mnt_umounting);
+	return list_first_entry_or_null(&candidates, struct mount, mnt_list);
 }
 
 static inline bool is_candidate(struct mount *m)
 {
-	return !list_empty(&m->mnt_umounting);
+	return m->mnt.mnt_flags & MNT_UMOUNT_CANDIDATE;
 }
 
 static inline bool will_be_unmounted(struct mount *m)
@@ -492,29 +490,26 @@ static void umount_one(struct mount *m)
 	move_from_ns(m, &to_umount);
 }
 
-static void remove_candidate(struct mount *m)
+static void remove_from_candidate_list(struct mount *m)
 {
-	CLEAR_MNT_MARK(m);	// unmark on removal from candidates
-	list_del_init(&m->mnt_umounting);
+	m->mnt.mnt_flags &= ~(MNT_MARKED | MNT_UMOUNT_CANDIDATE);
+	list_del_init(&m->mnt_list);
 }
 
 static void gather_candidates(struct list_head *set)
 {
-	LIST_HEAD(visited);
 	struct mount *m, *p, *q;
 
 	list_for_each_entry(m, set, mnt_list) {
 		if (is_candidate(m))
 			continue;
-		list_add(&m->mnt_umounting, &visited);
+		m->mnt.mnt_flags |= MNT_UMOUNT_CANDIDATE;
 		p = m->mnt_parent;
 		q = propagation_next(p, p);
 		while (q) {
 			struct mount *child = __lookup_mnt(&q->mnt,
 							   m->mnt_mountpoint);
 			if (child) {
-				struct list_head *head;
-
 				/*
 				 * We might've already run into this one.  That
 				 * must've happened on earlier iteration of the
@@ -526,17 +521,15 @@ static void gather_candidates(struct list_head *set)
 					q = skip_propagation_subtree(q, p);
 					continue;
 				}
-				if (will_be_unmounted(child))
-					head = &visited;
-				else
-					head = &candidates;
-				list_add(&child->mnt_umounting, head);
+				child->mnt.mnt_flags |= MNT_UMOUNT_CANDIDATE;
+				if (!will_be_unmounted(child))
+					list_add(&child->mnt_list, &candidates);
 			}
 			q = propagation_next(q, p);
 		}
 	}
-	while (!list_empty(&visited))	// empty visited
-		list_del_init(visited.next);
+	list_for_each_entry(m, set, mnt_list)
+		m->mnt.mnt_flags &= ~MNT_UMOUNT_CANDIDATE;
 }
 
 /*
@@ -553,7 +546,7 @@ static void trim_ancestors(struct mount *m)
 			return;
 		SET_MNT_MARK(m);
 		if (m->mnt_mountpoint != p->mnt.mnt_root)
-			remove_candidate(p);
+			p->mnt.mnt_flags &= ~MNT_UMOUNT_CANDIDATE;
 	}
 }
 
@@ -563,13 +556,19 @@ static void trim_ancestors(struct mount *m)
  * If we can immediately tell that @m is OK to unmount (unlocked
  * and all children are already committed to unmounting) commit
  * to unmounting it.
- * Returns the next candidate to be trimmed.
+ * Only @m itself might be taken from the candidates list;
+ * anything found by trim_ancestors() is marked non-candidate
+ * and left on the list.
  */
-static struct mount *trim_one(struct mount *m)
+static void trim_one(struct mount *m)
 {
 	bool remove_this = false, found = false, umount_this = false;
 	struct mount *n;
-	struct list_head *next;
+
+	if (!is_candidate(m)) { // trim_ancestors() left it on list
+		remove_from_candidate_list(m);
+		return;
+	}
 
 	list_for_each_entry(n, &m->mnt_mounts, mnt_child) {
 		if (!is_candidate(n)) {
@@ -586,24 +585,23 @@ static struct mount *trim_one(struct mount *m)
 		remove_this = true;
 		umount_this = true;
 	}
-	next = m->mnt_umounting.next;
 	if (remove_this) {
-		remove_candidate(m);
+		remove_from_candidate_list(m);
 		if (umount_this)
 			umount_one(m);
 	}
-	if (next == &candidates)
-		return NULL;
-
-	return list_entry(next, struct mount, mnt_umounting);
 }
 
 static void handle_locked(struct mount *m)
 {
 	struct mount *cutoff = m, *p;
 
+	if (!is_candidate(m)) { // trim_ancestors() left it on list
+		remove_from_candidate_list(m);
+		return;
+	}
 	for (p = m; is_candidate(p); p = p->mnt_parent) {
-		remove_candidate(p);
+		remove_from_candidate_list(p);
 		if (!IS_MNT_LOCKED(p))
 			cutoff = p->mnt_parent;
 	}
@@ -657,14 +655,14 @@ static void reparent(struct mount *m)
  */
 void propagate_umount(struct list_head *set)
 {
-	struct mount *m;
+	struct mount *m, *p;
 
 	// collect all candidates
 	gather_candidates(set);
 
 	// reduce the set until it's non-shifting
-	for (m = first_candidate(); m; m = trim_one(m))
-		;
+	list_for_each_entry_safe(m, p, &candidates, mnt_list)
+		trim_one(m);
 
 	// ... and non-revealing
 	while (!list_empty(&candidates))
diff --git a/include/linux/mount.h b/include/linux/mount.h
index dcc17ce8a959..33af9c4058fa 100644
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -50,10 +50,12 @@ struct path;
 #define MNT_ATIME_MASK (MNT_NOATIME | MNT_NODIRATIME | MNT_RELATIME )
 
 #define MNT_INTERNAL_FLAGS (MNT_SHARED | MNT_WRITE_HOLD | MNT_INTERNAL | \
-			    MNT_DOOMED | MNT_SYNC_UMOUNT | MNT_MARKED)
+			    MNT_DOOMED | MNT_SYNC_UMOUNT | MNT_MARKED | \
+			    MNT_UMOUNT_CANDIDATE)
 
 #define MNT_INTERNAL	0x4000
 
+#define MNT_UMOUNT_CANDIDATE	0x020000
 #define MNT_LOCK_ATIME		0x040000
 #define MNT_LOCK_NOEXEC		0x080000
 #define MNT_LOCK_NOSUID		0x100000


