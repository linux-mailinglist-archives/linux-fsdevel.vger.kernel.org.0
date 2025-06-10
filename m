Return-Path: <linux-fsdevel+bounces-51144-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1149AD301D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 10:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B4633B69F8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 08:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A513D284B39;
	Tue, 10 Jun 2025 08:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="oj4RstIg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3668280A2C
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jun 2025 08:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749543717; cv=none; b=GZbayRFAeBZe+bzr6LHRJ2ekYjo4ym8d6tX5AX27c4F2EMLn2U3TXWlNYivwYh7oeIsPzJjtWu9BsSRb2q34x2C7rioDCjSU1bDBq/2GjfZP/fIrcJIVQH3AEf47voa7+nIG+ZxP3lzyn8BMKmmiLd+N8WrIfLHGgVw5zFM/s/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749543717; c=relaxed/simple;
	bh=4iMrjZL47lrvJQDHUq8+1L+eBq3xwXtALm7e9Gll+iQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oxdUn1hCZYv+hoE7wTwVNVIhR6Zrz94MCPAb+Wd1nQAfpXX6/p7skWG8eK9RWHFEX3DgFgxxVY8k97HKSa18X1xPpmki9k7ZqgxoOh7mEhtm+nApX15P0+cURXsqWYWKwn4kPtZSdDMn+edvQ5zwADs+Yi2V7l01GwAI7SOEoOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=oj4RstIg; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ZGJA5qub7qzb5Wnp13wevly16zxlr8pfy+X2qajIn1I=; b=oj4RstIg0FFYHJbd25Et6jztjP
	vAub96k9cHhBw5KcgURzG7oYA3smNGbm4IztGtb70h/KuLp62JkGlpPuD4UCz4zfQTfub1CLZV0wp
	aOvTJqNpyjiLLKBeLl8C8q5CLfRSEct7Li2VKboPI0p5JGbttEkLqTXKleIMuic9XlhYOPtZ8poqk
	U/uTMZ98LM8QTAIRHZVMYNGqRxGCJ+oSsR+m+11Hg87YFkBaxatLrF3xlPwpQrEEzrSoast+vagcU
	LhiSmFrPK4+DH60yfi5bLcxqZmqnegvdp6RNuok/EcMIAJlEbq/JueXeO0jYgOdGmcrL6JV0qnelx
	WmxO47ZA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOuEw-00000004jN2-3eAr;
	Tue, 10 Jun 2025 08:21:50 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH 12/26] Rewrite of propagate_umount()
Date: Tue, 10 Jun 2025 09:21:34 +0100
Message-ID: <20250610082148.1127550-12-viro@zeniv.linux.org.uk>
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

The variant currently in the tree has problems; trying to prove
correctness has caught at least one class of bugs (reparenting
that ends up moving the visible location of reparented mount, due
to not excluding some of the counterparts on propagation that
should've been included).

I tried to prove that it's the only bug there; I'm still not sure
whether it is.  If anyone can reconstruct and write down an analysis
of the mainline implementation, I'll gladly review it; as it is,
I ended up doing a different implementation.  Candidate collection
phase is similar, but trimming the set down until it satisfies the
constraints turned out pretty different.

I hoped to do transformation as a massage series, but that turns out
to be too convoluted.  So it's a single patch replacing propagate_umount()
and friends in one go, with notes and analysis in D/f/propagate_umount.txt
(in addition to inline comments).

As far I can tell, it is provably correct and provably linear by the number
of mounts we need to look at in order to decide what should be unmounted.
It even builds and seems to survive testing...

Another nice thing that fell out of that is that ->mnt_umounting is no longer
needed.

Compared to the first version:
	* explicit MNT_UMOUNT_CANDIDATE flag for is_candidate()
	* trim_ancestors() only clears that flag, leaving the suckers on list
	* trim_one() and handle_locked() take the stuff with flag cleared off
the list.  That allows to iterate with list_for_each_entry_safe() when calling
trim_one() - it removes at most one element from the list now.
	* no globals - I didn't bother with any kind of context, not worth it.

	* Notes updated accordingly; I have not touch the terms yet.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 .../filesystems/propagate_umount.txt          | 484 ++++++++++++++++++
 fs/mount.h                                    |   1 -
 fs/namespace.c                                |   1 -
 fs/pnode.c                                    | 363 +++++++------
 fs/pnode.h                                    |   2 +-
 include/linux/mount.h                         |   3 +-
 6 files changed, 686 insertions(+), 168 deletions(-)
 create mode 100644 Documentation/filesystems/propagate_umount.txt

diff --git a/Documentation/filesystems/propagate_umount.txt b/Documentation/filesystems/propagate_umount.txt
new file mode 100644
index 000000000000..5b48540b4059
--- /dev/null
+++ b/Documentation/filesystems/propagate_umount.txt
@@ -0,0 +1,484 @@
+	Notes on propagate_umount()
+
+Umount propagation starts with a set of mounts we are already going to
+take out.  Ideally, we would like to add all downstream cognates to
+that set - anything with the same mountpoint as one of the removed
+mounts and with parent that would receive events from the parent of that
+mount.  However, there are some constraints the resulting set must
+satisfy.
+
+It is convenient to define several properties of sets of mounts:
+
+1) A set S of mounts is non-shifting if for any mount X belonging
+to S all subtrees mounted strictly inside of X (i.e. not overmounting
+the root of X) contain only elements of S.
+
+2) A set S is non-revealing if all locked mounts that belong to S have
+parents that also belong to S.
+
+3) A set S is closed if it contains all children of its elements.
+
+The set of mounts taken out by umount(2) must be non-shifting and
+non-revealing; the first constraint is what allows to reparent
+any remaining mounts and the second is what prevents the exposure
+of any concealed mountpoints.
+
+propagate_umount() takes the original set as an argument and tries to
+extend that set.  The original set is a full subtree and its root is
+unlocked; what matters is that it's closed and non-revealing.
+Resulting set may not be closed; there might still be mounts outside
+of that set, but only on top of stacks of root-overmounting elements
+of set.  They can be reparented to the place where the bottom of
+stack is attached to a mount that will survive.  NOTE: doing that
+will violate a constraint on having no more than one mount with
+the same parent/mountpoint pair; however, the caller (umount_tree())
+will immediately remedy that - it may keep unmounted element attached
+to parent, but only if the parent itself is unmounted.  Since all
+conflicts created by reparenting have common parent *not* in the
+set and one side of the conflict (bottom of the stack of overmounts)
+is in the set, it will be resolved.  However, we rely upon umount_tree()
+doing that pretty much immediately after the call of propagate_umount().
+
+Algorithm is based on two statements:
+	1) for any set S, there is a maximal non-shifting subset of S
+and it can be calculated in O(#S) time.
+	2) for any non-shifting set S, there is a maximal non-revealing
+subset of S.  That subset is also non-shifting and it can be calculated
+in O(#S) time.
+
+		Finding candidates.
+
+We are given a closed set U and we want to find all mounts that have
+the same mountpoint as some mount m in U *and* whose parent receives
+propagation from the parent of the same mount m.  Naive implementation
+would be
+	S = {}
+	for each m in U
+		add m to S
+		p = parent(m)
+		for each q in Propagation(p) - {p}
+			child = look_up(q, mountpoint(m))
+			if child
+				add child to S
+but that can lead to excessive work - there might be propagation among the
+subtrees of U, in which case we'd end up examining the same candidates
+many times.  Since propagation is transitive, the same will happen to
+everything downstream of that candidate and it's not hard to construct
+cases where the approach above leads to the time quadratic by the actual
+number of candidates.
+
+Note that if we run into a candidate we'd already seen, it must've been
+added on an earlier iteration of the outer loop - all additions made
+during one iteration of the outer loop have different parents.  So
+if we find a child already added to the set, we know that everything
+in Propagation(parent(child)) with the same mountpoint has been already
+added.
+	S = {}
+	for each m in U
+		if m in S
+			continue
+		add m to S
+		p = parent(m)
+		q = propagation_next(p, p)
+		while q
+			child = look_up(q, mountpoint(m))
+			if child
+				if child in S
+					q = skip_them(q, p)
+					continue;
+				add child to S
+			q = propagation_next(q, p)
+where
+skip_them(q, p)
+	keep walking Propagation(p) from q until we find something
+	not in Propagation(q)
+
+would get rid of that problem, but we need a sane implementation of
+skip_them().  That's not hard to do - split propagation_next() into
+"down into mnt_slave_list" and "forward-and-up" parts, with the
+skip_them() being "repeat the forward-and-up part until we get NULL
+or something that isn't a peer of the one we are skipping".
+
+Note that there can be no absolute roots among the extra candidates -
+they all come from mount lookups.  Absolute root among the original
+set is _currently_ impossible, but it might be worth protecting
+against.
+
+		Maximal non-shifting subsets.
+
+Let's call a mount m in a set S forbidden in that set if there is a
+subtree mounted strictly inside m and containing mounts that do not
+belong to S.
+
+The set is non-shifting when none of its elements are forbidden in it.
+
+If mount m is forbidden in a set S, it is forbidden in any subset S' it
+belongs to.  In other words, it can't belong to any of the non-shifting
+subsets of S.  If we had a way to find a forbidden mount or show that
+there's none, we could use it to find the maximal non-shifting subset
+simply by finding and removing them until none remain.
+
+Suppose mount m is forbidden in S; then any mounts forbidden in S - {m}
+must have been forbidden in S itself.  Indeed, since m has descendents
+that do not belong to S, any subtree that fits into S will fit into
+S - {m} as well.
+
+So in principle we could go through elements of S, checking if they
+are forbidden in S and removing the ones that are.  Removals will
+not invalidate the checks done for earlier mounts - if they were not
+forbidden at the time we checked, they won't become forbidden later.
+It's too costly to be practical, but there is a similar approach that
+is linear by size of S.
+
+Let's say that mount x in a set S is forbidden by mount y, if
+	* both x and y belong to S.
+	* there is a chain of mounts starting at x and leaving S
+	  immediately after passing through y, with the first
+	  mountpoint strictly inside x.
+Note 1: x may be equal to y - that's the case when something not
+belonging to S is mounted strictly inside x.
+Note 2: if y does not belong to S, it can't forbid anything in S.
+Note 3: if y has no children outside of S, it can't forbid anything in S.
+
+It's easy to show that mount x is forbidden in S if and only if x is
+forbidden in S by some mount y.  And it's easy to find all mounts in S
+forbidden by a given mount.
+
+Consider the following operation:
+	Trim(S, m) = S - {x : x is forbidden by m in S}
+
+Note that if m does not belong to S or has no children outside of S we
+are guaranteed that Trim(S, m) is equal to S.
+
+The following is true: if x is forbidden by y in Trim(S, m), it was
+already forbidden by y in S.
+
+Proof: Suppose x is forbidden by y in Trim(S, m).  Then there is a
+chain of mounts (x_0 = x, ..., x_k = y, x_{k+1} = r), such that x_{k+1}
+is the first element that doesn't belong to Trim(S, m) and the
+mountpoint of x_1 is strictly inside x.  If mount r belongs to S, it must
+have been removed by Trim(S, m), i.e. it was forbidden in S by m.
+Then there was a mount chain from r to some child of m that stayed in
+S all the way until m, but that's impossible since x belongs to Trim(S, m)
+and prepending (x_0, ..., x_k) to that chain demonstrates that x is also
+prohibited in S by m, and thus can't belong to Trim(S, m).
+Therefore r can not belong to S and our chain demonstrates that
+x is prohibited by y in S.  QED.
+
+Corollary: no mount is forbidden by m in Trim(S, m).  Indeed, any
+such mount would have been forbidden by m in S and thus would have been
+in the part of S removed in Trim(S, m).
+
+Corollary: no mount is forbidden by m in Trim(Trim(S, m), n).  Indeed,
+any such would have to have been forbidden by m in Trim(S, m), which
+is impossible.
+
+Corollary: after
+	S = Trim(S, x_1)
+	S = Trim(S, x_2)
+	...
+	S = Trim(S, x_k)
+no mount remaining in S will be forbidden by either of x_1,...,x_k.
+
+The following will reduce S to its maximal non-shifting subset:
+	visited = {}
+	while S contains elements not belonging to visited
+		let m be an arbitrary such element of S
+		S = Trim(S, m)
+		add m to visited
+
+S never grows, so the number of elements of S not belonging to visited
+decreases at least by one on each iteration.  When the loop terminates,
+all mounts remaining in S belong to visited.  It's easy to see that at
+the beginning of each iteration no mount remaining in S will be forbidden
+by any element of visited.  In other words, no mount remaining in S will
+be forbidden, i.e. final value of S will be non-shifting.  It will be
+the maximal non-shifting subset, since we were removing only forbidden
+elements.
+
+	There are two difficulties in implementing the above in linear
+time, both due to the fact that Trim() might need to remove more than one
+element.  Naive implementation of Trim() is vulnerable to running into a
+long chain of mounts, each mounted on top of parent's root.  Nothing in
+that chain is prohibited, so nothing gets removed from it.  We need to
+recognize such chains and avoid walking them again on subsequent calls of
+Trim(), otherwise we will end up with worst-case time being quadratic by
+the number of elements in S.  Another difficulty is in implementing the
+outer loop - we need to iterate through all elements of a shrinking set.
+That would be trivial if we never removed more than one element at a time
+(linked list, with list_for_each_entry_safe for iterator), but we may
+need to remove more than one entry, possibly including the ones we have
+already visited.
+
+	Let's start with naive algorithm for Trim():
+
+Trim_one(m)
+	found = false
+	for each n in children(m)
+		if n not in S
+			found = true
+			if (mountpoint(n) != root(m))
+				remove m from S
+				break
+	if found
+		Trim_ancestors(m)
+
+Trim_ancestors(m)
+	for (; parent(m) in S; m = parent(m)) {
+		if (mountpoint(m) != root(parent(m)))
+			remove parent(m) from S
+	}
+
+If m belongs to S, Trim_one(m) will replace S with Trim(S, m).
+Proof:
+	Consider the chains excluding elements from Trim(S, m).  The last
+two elements in such chain are m and some child of m that does not belong
+to S.  If m has no such children, Trim(S, m) is equal to S.
+	m itself is removed if and only if the chain has exactly two
+elements, i.e. when the last element does not overmount the root of m.
+In other words, that happens when m has a child not in S that does not
+overmount the root of m.
+	All other elements to remove will be ancestors of m, such that
+the entire descent chain from them to m is contained in S.  Let
+(x_0, x_1, ..., x_k = m) be the longest such chain.  x_i needs to be
+removed if and only if x_{i+1} does not overmount its root.  It's easy
+to see that Trim_ancestors(m) will iterate through that chain from
+x_k to x_1 and that it will remove exactly the elements that need to be
+removed.
+
+	Note that if the loop in Trim_ancestors() walks into an already
+visited element, we are guaranteed that remaining iterations will see
+only elements that had already been visited and remove none of them.
+That's the weakness that makes it vulnerable to long chains of full
+overmounts.
+
+	It's easy to deal with, if we can afford setting marks on
+elements of S; we would mark all elements already visited by
+Trim_ancestors() and have it bail out as soon as it sees an already
+marked element.
+
+	The problems with iterating through the set can be dealt with in
+several ways, depending upon the representation we choose for our set.
+One useful observation is that we are given a closed subset in S - the
+original set passed to propagate_umount().  Its elements can neither
+prohibit anything nor be prohibited by anything - all their descendents
+belong to S, so they can not occur anywhere in any excluding chain.
+In other words, the elements of that subset will remain in S until
+the end and Trim_one(S, m) is a no-op for all m from that subset.
+
+	That suggests keeping S as a disjoint union of a closed set U
+('will be unmounted, no matter what') and the set of all elements of
+S that do not belong to U.  That set ('candidates') is all we need
+to iterate through.  Let's represent it as a subset in a cyclic list,
+consisting of all list elements that are marked as candidates (initially -
+all of them).  Then we could have Trim_ancestors() only remove the mark,
+leaving the elements on the list.  Then Trim_one() would never remove
+anything other than its argument from the containing list, allowing to
+use list_for_each_entry_safe() as iterator.
+
+	Assuming that representation we get the following:
+
+	list_for_each_entry_safe(m, ..., Candidates, ...)
+		Trim_one(m)
+where
+Trim_one(m)
+	if (m is not marked as a candidate)
+		strip the "seen by Trim_ancestors" mark from m
+		remove m from the Candidates list
+		return
+		
+	remove_this = false
+	found = false
+	for each n in children(m)
+		if n not in S
+			found = true
+			if (mountpoint(n) != root(m))
+				remove_this = true
+				break
+	if found
+		Trim_ancestors(m)
+	if remove_this
+		strip the "seen by Trim_ancestors" mark from m
+		strip the "candidate" mark from m
+		remove m from the Candidate list
+
+Trim_ancestors(m)
+	for (p = parent(m); p is marked as candidate ; m = p, p = parent(p)) {
+		if m is marked as seen by Trim_ancestors
+			return
+		mark m as seen by Trim_ancestors
+		if (mountpoint(m) != root(p))
+			strip the "candidate" mark from p
+	}
+
+	Terminating condition in the loop in Trim_ancestors() is correct,
+since that that loop will never run into p belonging to U - p is always
+an ancestor of argument of Trim_one() and since U is closed, the argument
+of Trim_one() would also have to belong to U.  But Trim_one() is never
+called for elements of U.  In other words, p belongs to S if and only
+if it belongs to candidates.
+
+	Time complexity:
+* we get no more than O(#S) calls of Trim_one()
+* the loop over children in Trim_one() never looks at the same child
+twice through all the calls.
+* iterations of that loop for children in S are no more than O(#S)
+in the worst case
+* at most two children that are not elements of S are considered per
+call of Trim_one().
+* the loop in Trim_ancestors() sets its mark once per iteration and
+no element of S has is set more than once.
+
+	In the end we may have some elements excluded from S by
+Trim_ancestors() still stuck on the list.  We could do a separate
+loop removing them from the list (also no worse than O(#S) time),
+but it's easier to leave that until the next phase - there we will
+iterate through the candidates anyway.
+
+	The caller has already removed all elements of U from their parents'
+lists of children, which means that checking if child belongs to S is
+equivalent to checking if it's marked as a candidate; we'll never see
+the elements of U in the loop over children in Trim_one().
+
+	What's more, if we see that children(m) is empty and m is not
+locked, we can immediately move m into the committed subset (remove
+from the parent's list of children, etc.).  That's one fewer mount we'll
+have to look into when we check the list of children of its parent *and*
+when we get to building the non-revealing subset.
+
+		Maximal non-revealing subsets
+
+If S is not a non-revealing subset, there is a locked element x in S
+such that parent of x is not in S.
+
+Obviously, no non-revealing subset of S may contain x.  Removing such
+elements one by one will obviously end with the maximal non-revealing
+subset (possibly empty one).  Note that removal of an element will
+require removal of all its locked children, etc.
+
+If the set had been non-shifting, it will remain non-shifting after
+such removals.
+Proof: suppose S was non-shifting, x is a locked element of S, parent of x
+is not in S and S - {x} is not non-shifting.  Then there is an element m
+in S - {x} and a subtree mounted strictly inside m, such that m contains
+an element not in in S - {x}.  Since S is non-shifting, everything in
+that subtree must belong to S.  But that means that this subtree must
+contain x somewhere *and* that parent of x either belongs that subtree
+or is equal to m.  Either way it must belong to S.  Contradiction.
+
+// same representation as for finding maximal non-shifting subsets:
+// S is a disjoint union of a non-revealing set U (the ones we are committed
+// to unmount) and a set of candidates, represented as a subset of list
+// elements that have "is a candidate" mark on them.
+// Elements of U are removed from their parents' lists of children.
+// In the end candidates becomes empty and maximal non-revealing non-shifting
+// subset of S is now in U
+	while (Candidates list is non-empty)
+		handle_locked(first(Candidates))
+
+handle_locked(m)
+	if m is not marked as a candidate
+		strip the "seen by Trim_ancestors" mark from m
+		remove m from the list
+		return
+	cutoff = m
+	for (p = m; p in candidates; p = parent(p)) {
+		strip the "seen by Trim_ancestors" mark from p
+		strip the "candidate" mark from p
+		remove p from the Candidates list
+		if (!locked(p))
+			cutoff = parent(p)
+	}
+	if p in U
+		cutoff = p
+	while m != cutoff
+		remove m from children(parent(m))
+		add m to U
+		m = parent(m)
+
+Let (x_0, ..., x_n = m) be the maximal chain of descent of m within S.
+* If it contains some elements of U, let x_k be the last one of those.
+Then union of U with {x_{k+1}, ..., x_n} is obviously non-revealing.
+* otherwise if all its elements are locked, then none of {x_0, ..., x_n}
+may be elements of a non-revealing subset of S.
+* otherwise let x_k be the first unlocked element of the chain.  Then none
+of {x_0, ..., x_{k-1}} may be an element of a non-revealing subset of
+S and union of U and {x_k, ..., x_n} is non-revealing.
+
+handle_locked(m) finds which of these cases applies and adjusts Candidates
+and U accordingly.  U remains non-revealing, union of Candidates and
+U still contains any non-revealing subset of S and after the call of
+handle_locked(m) m is guaranteed to be not in Candidates list.  So having
+it called for each element of S would suffice to empty Candidates,
+leaving U the maximal non-revealing subset of S.
+
+However, handle_locked(m) is a no-op when m belongs to U, so it's enough
+to have it called for elements of Candidates list until none remain.
+
+Time complexity: number of calls of handle_locked() is limited by
+#Candidates, each iteration of the first loop in handle_locked() removes
+an element from the list, so their total number of executions is also
+limited by #Candidates; number of iterations in the second loop is no
+greater than the number of iterations of the first loop.
+
+
+		Reparenting
+
+After we'd calculated the final set, we still need to deal with
+reparenting - if an element of the final set has a child not in it,
+we need to reparent such child.
+
+Such children can only be root-overmounting (otherwise the set wouldn't
+be non-shifting) and their parents can not belong to the original set,
+since the original is guaranteed to be closed.
+
+
+		Putting all of that together
+
+The plan is to
+	* find all candidates
+	* trim down to maximal non-shifting subset
+	* trim down to maximal non-revealing subset
+	* reparent anything that needs to be reparented
+	* return the resulting set to the caller
+
+For the 2nd and 3rd steps we want to separate the set into growing
+non-revealing subset, initially containing the original set ("U" in
+terms of the pseudocode above) and everything we are still not sure about
+("candidates").  It means that for the output of the 1st step we'd like
+the extra candidates separated from the stuff already in the original set.
+For the 4th step we would like the additions to U separate from the
+original set.
+
+So let's go for
+	* original set ("set").  Linkage via mnt_list
+	* undecided candidates ("candidates").  Subset of a list,
+consisting of all its elements marked with a new flag (MNT_UMOUNT_CANDIDATE).
+Initially all elements of the list will be marked that way; in the
+end the list will become empty and no mounts will remain marked with
+that flag.
+	* Reuse MNT_MARKED for "has been already seen by trim_ancestors()".
+	* anything in U that hadn't been in the original set - elements of
+candidates will gradually be either discarded or moved there.  In other
+words, it's the candidates we have already decided to unmount.	Its role
+is reasonably close to the old "to_umount", so let's use that name.
+Linkage via mnt_list.
+
+For gather_candidates() we'll need to maintain both candidates (S -
+set) and intersection of S with set.  Use MNT_UMOUNT_CANDIDATE for
+all elements we encounter, putting the ones not already in the original
+set into the list of candidates.  When we are done, strip that flag from
+all elements of the original set.  That gives a cheap way to check
+if element belongs to S (in gather_candidates) and to candidates
+itself (at later stages).  Call that predicate is_candidate(); it would
+be m->mnt_flags & MNT_UMOUNT_CANDIDATE.
+
+All elements of the original set are marked with MNT_UMOUNT and we'll
+need the same for elements added when joining the contents of to_umount
+to set in the end.  Let's set MNT_UMOUNT at the time we add an element
+to to_umount; that's close to what the old 'umount_one' is doing, so
+let's keep that name.  It also gives us another predicate we need -
+"belongs to union of set and to_umount"; will_be_unmounted() for now.
+
+Removals from the candidates list should strip both MNT_MARKED and
+MNT_UMOUNT_CANDIDATE; call it remove_from_candidates_list().
diff --git a/fs/mount.h b/fs/mount.h
index 18fa88ad752a..9b3de2eef68a 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -79,7 +79,6 @@ struct mount {
 		struct hlist_node mnt_mp_list;	/* list mounts with the same mountpoint */
 		struct hlist_node mnt_umount;
 	};
-	struct list_head mnt_umounting; /* list entry for umount propagation */
 #ifdef CONFIG_FSNOTIFY
 	struct fsnotify_mark_connector __rcu *mnt_fsnotify_marks;
 	__u32 mnt_fsnotify_mask;
diff --git a/fs/namespace.c b/fs/namespace.c
index 166d60a6f66b..1ec7b1d63e94 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -383,7 +383,6 @@ static struct mount *alloc_vfsmnt(const char *name)
 		INIT_LIST_HEAD(&mnt->mnt_slave_list);
 		INIT_LIST_HEAD(&mnt->mnt_slave);
 		INIT_HLIST_NODE(&mnt->mnt_mp_list);
-		INIT_LIST_HEAD(&mnt->mnt_umounting);
 		INIT_HLIST_HEAD(&mnt->mnt_stuck_children);
 		RB_CLEAR_NODE(&mnt->mnt_node);
 		mnt->mnt.mnt_idmap = &nop_mnt_idmap;
diff --git a/fs/pnode.c b/fs/pnode.c
index aa187144e389..f1752dd499af 100644
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
@@ -153,31 +165,21 @@ static struct mount *propagation_next(struct mount *m,
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
-
-		/* back at master */
-		m = master;
-	}
+	return __propagation_next(m, origin);
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
+
+	while (p && peers(m, p))
+		p = __propagation_next(p, origin);
 
-	return m;
+	return p;
 }
 
 static struct mount *next_group(struct mount *m, struct mount *origin)
@@ -458,181 +460,214 @@ void propagate_mount_unlock(struct mount *mnt)
 	}
 }
 
-static void umount_one(struct mount *mnt, struct list_head *to_umount)
+static inline bool is_candidate(struct mount *m)
 {
-	CLEAR_MNT_MARK(mnt);
-	mnt->mnt.mnt_flags |= MNT_UMOUNT;
-	list_del_init(&mnt->mnt_child);
-	list_del_init(&mnt->mnt_umounting);
-	move_from_ns(mnt, to_umount);
+	return m->mnt.mnt_flags & MNT_UMOUNT_CANDIDATE;
 }
 
-/*
- * NOTE: unmounting 'mnt' naturally propagates to all other mounts its
- * parent propagates to.
- */
-static bool __propagate_umount(struct mount *mnt,
-			       struct list_head *to_umount,
-			       struct list_head *to_restore)
+static inline bool will_be_unmounted(struct mount *m)
 {
-	bool progress = false;
-	struct mount *child;
+	return m->mnt.mnt_flags & MNT_UMOUNT;
+}
 
-	/*
-	 * The state of the parent won't change if this mount is
-	 * already unmounted or marked as without children.
-	 */
-	if (mnt->mnt.mnt_flags & (MNT_UMOUNT | MNT_MARKED))
-		goto out;
+static void umount_one(struct mount *m, struct list_head *to_umount)
+{
+	m->mnt.mnt_flags |= MNT_UMOUNT;
+	list_del_init(&m->mnt_child);
+	move_from_ns(m, to_umount);
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
+static void remove_from_candidate_list(struct mount *m)
+{
+	m->mnt.mnt_flags &= ~(MNT_MARKED | MNT_UMOUNT_CANDIDATE);
+	list_del_init(&m->mnt_list);
+}
 
-	/* Mark mounts that can be unmounted if not locked */
-	SET_MNT_MARK(mnt);
-	progress = true;
+static void gather_candidates(struct list_head *set,
+			      struct list_head *candidates)
+{
+	struct mount *m, *p, *q;
 
-	/* If a mount is without children and not locked umount it. */
-	if (!IS_MNT_LOCKED(mnt)) {
-		umount_one(mnt, to_umount);
-	} else {
-children:
-		list_move_tail(&mnt->mnt_umounting, to_restore);
+	list_for_each_entry(m, set, mnt_list) {
+		if (is_candidate(m))
+			continue;
+		m->mnt.mnt_flags |= MNT_UMOUNT_CANDIDATE;
+		p = m->mnt_parent;
+		q = propagation_next(p, p);
+		while (q) {
+			struct mount *child = __lookup_mnt(&q->mnt,
+							   m->mnt_mountpoint);
+			if (child) {
+				/*
+				 * We might've already run into this one.  That
+				 * must've happened on earlier iteration of the
+				 * outer loop; in that case we can skip those
+				 * parents that get propagation from q - there
+				 * will be nothing new on those as well.
+				 */
+				if (is_candidate(child)) {
+					q = skip_propagation_subtree(q, p);
+					continue;
+				}
+				child->mnt.mnt_flags |= MNT_UMOUNT_CANDIDATE;
+				if (!will_be_unmounted(child))
+					list_add(&child->mnt_list, candidates);
+			}
+			q = propagation_next(q, p);
+		}
 	}
-out:
-	return progress;
+	list_for_each_entry(m, set, mnt_list)
+		m->mnt.mnt_flags &= ~MNT_UMOUNT_CANDIDATE;
 }
 
-static void umount_list(struct list_head *to_umount,
-			struct list_head *to_restore)
+/*
+ * We know that some child of @m can't be unmounted.  In all places where the
+ * chain of descent of @m has child not overmounting the root of parent,
+ * the parent can't be unmounted either.
+ */
+static void trim_ancestors(struct mount *m)
 {
-	struct mount *mnt, *child, *tmp;
-	list_for_each_entry(mnt, to_umount, mnt_list) {
-		list_for_each_entry_safe(child, tmp, &mnt->mnt_mounts, mnt_child) {
-			/* topper? */
-			if (child->mnt_mountpoint == mnt->mnt.mnt_root)
-				list_move_tail(&child->mnt_umounting, to_restore);
-			else
-				umount_one(child, to_umount);
-		}
+	struct mount *p;
+
+	for (p = m->mnt_parent; is_candidate(p); m = p, p = p->mnt_parent) {
+		if (IS_MNT_MARKED(m))	// all candidates beneath are overmounts
+			return;
+		SET_MNT_MARK(m);
+		if (m->mnt_mountpoint != p->mnt.mnt_root)
+			p->mnt.mnt_flags &= ~MNT_UMOUNT_CANDIDATE;
 	}
 }
 
-static void restore_mounts(struct list_head *to_restore)
+/*
+ * Find and exclude all umount candidates forbidden by @m
+ * (see Documentation/filesystems/propagate_umount.txt)
+ * If we can immediately tell that @m is OK to unmount (unlocked
+ * and all children are already committed to unmounting) commit
+ * to unmounting it.
+ * Only @m itself might be taken from the candidates list;
+ * anything found by trim_ancestors() is marked non-candidate
+ * and left on the list.
+ */
+static void trim_one(struct mount *m, struct list_head *to_umount)
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
-		}
-		if (parent != mnt->mnt_parent) {
-			mnt_change_mountpoint(parent, mp, mnt);
-			mnt_notify_add(mnt);
+	bool remove_this = false, found = false, umount_this = false;
+	struct mount *n;
+
+	if (!is_candidate(m)) { // trim_ancestors() left it on list
+		remove_from_candidate_list(m);
+		return;
+	}
+
+	list_for_each_entry(n, &m->mnt_mounts, mnt_child) {
+		if (!is_candidate(n)) {
+			found = true;
+			if (n->mnt_mountpoint != m->mnt.mnt_root) {
+				remove_this = true;
+				break;
+			}
 		}
 	}
+	if (found) {
+		trim_ancestors(m);
+	} else if (!IS_MNT_LOCKED(m) && list_empty(&m->mnt_mounts)) {
+		remove_this = true;
+		umount_this = true;
+	}
+	if (remove_this) {
+		remove_from_candidate_list(m);
+		if (umount_this)
+			umount_one(m, to_umount);
+	}
 }
 
-static void cleanup_umount_visitations(struct list_head *visited)
+static void handle_locked(struct mount *m, struct list_head *to_umount)
 {
-	while (!list_empty(visited)) {
-		struct mount *mnt =
-			list_first_entry(visited, struct mount, mnt_umounting);
-		list_del_init(&mnt->mnt_umounting);
+	struct mount *cutoff = m, *p;
+
+	if (!is_candidate(m)) { // trim_ancestors() left it on list
+		remove_from_candidate_list(m);
+		return;
+	}
+	for (p = m; is_candidate(p); p = p->mnt_parent) {
+		remove_from_candidate_list(p);
+		if (!IS_MNT_LOCKED(p))
+			cutoff = p->mnt_parent;
+	}
+	if (will_be_unmounted(p))
+		cutoff = p;
+	while (m != cutoff) {
+		umount_one(m, to_umount);
+		m = m->mnt_parent;
 	}
 }
 
 /*
- * collect all mounts that receive propagation from the mount in @list,
- * and return these additional mounts in the same list.
- * @list: the list of mounts to be unmounted.
+ * @m is not to going away, and it overmounts the top of a stack of mounts
+ * that are going away.  We know that all of those are fully overmounted
+ * by the one above (@m being the topmost of the chain), so @m can be slid
+ * in place where the bottom of the stack is attached.
  *
- * vfsmount lock must be held for write
+ * NOTE: here we temporarily violate a constraint - two mounts end up with
+ * the same parent and mountpoint; that will be remedied as soon as we
+ * return from propagate_umount() - its caller (umount_tree()) will detach
+ * the stack from the parent it (and now @m) is attached to.  umount_tree()
+ * might choose to keep unmounted pieces stuck to each other, but it always
+ * detaches them from the mounts that remain in the tree.
  */
-int propagate_umount(struct list_head *list)
+static void reparent(struct mount *m)
 {
-	struct mount *mnt;
-	LIST_HEAD(to_restore);
-	LIST_HEAD(to_umount);
-	LIST_HEAD(visited);
-
-	/* Find candidates for unmounting */
-	list_for_each_entry_reverse(mnt, list, mnt_list) {
-		struct mount *parent = mnt->mnt_parent;
-		struct mount *m;
+	struct mount *p = m;
+	struct mountpoint *mp;
 
-		/*
-		 * If this mount has already been visited it is known that it's
-		 * entire peer group and all of their slaves in the propagation
-		 * tree for the mountpoint has already been visited and there is
-		 * no need to visit them again.
-		 */
-		if (!list_empty(&mnt->mnt_umounting))
-			continue;
+	do {
+		mp = p->mnt_mp;
+		p = p->mnt_parent;
+	} while (will_be_unmounted(p));
 
-		list_add_tail(&mnt->mnt_umounting, &visited);
-		for (m = propagation_next(parent, parent); m;
-		     m = propagation_next(m, parent)) {
-			struct mount *child = __lookup_mnt(&m->mnt,
-							   mnt->mnt_mountpoint);
-			if (!child)
-				continue;
+	mnt_change_mountpoint(p, mp, m);
+	mnt_notify_add(m);
+}
 
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
+/**
+ * propagate_umount - apply propagation rules to the set of mounts for umount()
+ * @set: the list of mounts to be unmounted.
+ *
+ * Collect all mounts that receive propagation from the mount in @set and have
+ * no obstacles to being unmounted.  Add these additional mounts to the set.
+ *
+ * See Documentation/filesystems/propagate_umount.txt if you do anything in
+ * this area.
+ *
+ * Locks held:
+ * mount_lock (write_seqlock), namespace_sem (exclusive).
+ */
+void propagate_umount(struct list_head *set)
+{
+	struct mount *m, *p;
+	LIST_HEAD(to_umount);	// committed to unmounting
+	LIST_HEAD(candidates);	// undecided umount candidates
 
-			/* Check the child and parents while progress is made */
-			while (__propagate_umount(child,
-						  &to_umount, &to_restore)) {
-				/* Is the parent a umount candidate? */
-				child = child->mnt_parent;
-				if (list_empty(&child->mnt_umounting))
-					break;
-			}
-		}
+	// collect all candidates
+	gather_candidates(set, &candidates);
+
+	// reduce the set until it's non-shifting
+	list_for_each_entry_safe(m, p, &candidates, mnt_list)
+		trim_one(m, &to_umount);
+
+	// ... and non-revealing
+	while (!list_empty(&candidates)) {
+		m = list_first_entry(&candidates,struct mount, mnt_list);
+		handle_locked(m, &to_umount);
 	}
 
-	umount_list(&to_umount, &to_restore);
-	restore_mounts(&to_restore);
-	cleanup_umount_visitations(&visited);
-	list_splice_tail(&to_umount, list);
+	// now to_umount consists of all acceptable candidates
+	// deal with reparenting of remaining overmounts on those
+	list_for_each_entry(m, &to_umount, mnt_list) {
+		while (!list_empty(&m->mnt_mounts)) // should be at most one
+			reparent(list_first_entry(&m->mnt_mounts,
+						  struct mount, mnt_child));
+	}
 
-	return 0;
+	// and fold them into the set
+	list_splice_tail_init(&to_umount, set);
 }
diff --git a/fs/pnode.h b/fs/pnode.h
index b728b5de4adc..bfc10c095cbf 100644
--- a/fs/pnode.h
+++ b/fs/pnode.h
@@ -44,7 +44,7 @@ static inline bool peers(const struct mount *m1, const struct mount *m2)
 void change_mnt_propagation(struct mount *, int);
 int propagate_mnt(struct mount *, struct mountpoint *, struct mount *,
 		struct hlist_head *);
-int propagate_umount(struct list_head *);
+void propagate_umount(struct list_head *);
 int propagate_mount_busy(struct mount *, int);
 void propagate_mount_unlock(struct mount *);
 void mnt_release_group_id(struct mount *);
diff --git a/include/linux/mount.h b/include/linux/mount.h
index 1d30041b37e1..cae7324650b6 100644
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -40,6 +40,7 @@ enum mount_flags {
 
 	MNT_INTERNAL	= 0x4000,
 
+	MNT_UMOUNT_CANDIDATE	= 0x020000,
 	MNT_LOCK_ATIME		= 0x040000,
 	MNT_LOCK_NOEXEC		= 0x080000,
 	MNT_LOCK_NOSUID		= 0x100000,
@@ -66,7 +67,7 @@ enum mount_flags {
 
 	MNT_INTERNAL_FLAGS = MNT_SHARED | MNT_WRITE_HOLD | MNT_INTERNAL |
 			     MNT_DOOMED | MNT_SYNC_UMOUNT | MNT_MARKED |
-			     MNT_LOCKED,
+			     MNT_LOCKED | MNT_UMOUNT_CANDIDATE,
 };
 
 struct vfsmount {
-- 
2.39.5


