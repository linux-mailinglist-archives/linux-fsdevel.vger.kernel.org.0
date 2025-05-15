Return-Path: <linux-fsdevel+bounces-49129-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9620EAB8531
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 13:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4D1F189BDE6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 11:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586A4298270;
	Thu, 15 May 2025 11:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="jgn2MYcF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E20298C04
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 May 2025 11:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747309673; cv=none; b=rIrLtgmPJZ8kvnlz8/smkFfKclD3wIIMSVDDLCiMjkfa7dlcDOk9m8g2tXB0Yh1jTsQqm6eXvs/TtwL71243XKuWywTBU2/BTiPEeJURv5bho0ZUVv8xKA1QZt9I2mQ0auvYDnRLM/9gq5sYM58B9qwP1kriE+o3O2XACThhED8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747309673; c=relaxed/simple;
	bh=P1I9uhKfYvEDW0qgKXrQ5uScwMoirTJLI7Ai5OsQ4kM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E3DYVkkbZAMU0Iz/k5OwH5wRts6RViNoUYTFWooHxikJi9+RE0kQNxuXHogkJH+d7+vX9WxFIXiXse/Wng2MfPEiIq7kHMulTBIq68IdnBjlH4EAO8lTuypLOouo97CJ73HZTveS02DV/GKrkv1Sxd9Qje42GhR+bXkwXNNlqLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=jgn2MYcF; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Swvn9thR/C6Zud7DP31bhDjjp3ALsyOpnC0xIhmeYrM=; b=jgn2MYcF8P3dH0Hs9wqjnLunjp
	5IEeuFJdtcYCDIPuqz/F9bpiVCbkjFiv8UjQjj/1A9KWHZiU3i2GomVtnSmLr5pUFbMf3x+kWo6K1
	PyO+F9gX/xdh/3NaNaOpQ7nOVKPRF/UxQpbAfM97iUzhFeebOmKdp5Snni0dzctfoKOkHjjqu1vyA
	neW5W0Tg4HyKvnDRz3AK+uMF08znClryxjfTifVBNwMwSwvvpCsIYAGrAzXcqGP9JgZX4+R8qv4E8
	2vTSigMOoXfEW+TBg7DuzNf87vOHEumZjMTcDVYE2qKh6LDxEMisdO+jA2arJZmiRw1KAeg3M0kPa
	VU4wocRw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFX41-0000000DZNj-11GR;
	Thu, 15 May 2025 11:47:49 +0000
Date: Thu, 15 May 2025 12:47:49 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [BUG] propagate_umount() breakage
Message-ID: <20250515114749.GB3221059@ZenIV>
References: <20250511232732.GC2023217@ZenIV>
 <87jz6m300v.fsf@email.froward.int.ebiederm.org>
 <20250513035622.GE2023217@ZenIV>
 <20250515114150.GA3221059@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515114150.GA3221059@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, May 15, 2025 at 12:41:50PM +0100, Al Viro wrote:
> On Tue, May 13, 2025 at 04:56:22AM +0100, Al Viro wrote:
> 
> > And yes, it's going to be posted along with the proof of correctness -
> > I've had it with the amount of subtle corner cases in that area ;-/
> 
> FWIW, it seems to survive testing; it's _not_ final - I'm still editing
> the promised proof, but by this point it's stylistic work.  I hadn't
> touched that kind of formal writing for quite a while, so the text is clumsy.
> The code changes are pretty much in the final shape.  Current diff of
> code (all in fs/pnode.*) relative to mainline:

... and the current notes are below; they obviously need more editing ;-/

-----
Umount propagation starts with a set of mounts we are already going to
take out.  Ideally, we would like to add all downstream cognates to
that set - anything with the same mountpoint as one of the removed
mounts and with parent that would receive events from the parent of that
mount.  However, there are some constraints the resulting set must
satisfy.

It is convenient to define several properties of sets of mounts:

1) A set S of mounts is non-shifting if for any mount X belonging
to S all subtrees mounted strictly inside of X (i.e. not overmounting
the root of X) contain only elements of S.

2) A set S is non-revealing if all locked mounts that belong to S have
parents that also belong to S.

3) A set S is closed if it contains all children of its elements.

The set of mounts taken out by umount(2) must be non-shifting and
non-revealing; the first constraint is what allows to reparent
any remaining mounts and the second is what prevents the exposure
of any concealed mountpoints.

propagate_umount() takes the original set as an argument and tries to
extend that set.  The original set is a full subtree and its root is
unlocked; what matters is that it's closed and non-revealing.
Resulting set may not be closed; there might still be mounts outside
of that set, but only on top of stacks of root-overmounting elements
of set.  They can be reparented to the place where the bottom of
stack is attached to a mount that will survive.  NOTE: doing that
will violate a constraint on having no more than one mount with
the same parent/mountpoint pair; however, the caller (umount_tree())
will immediately remedy that - it may keep unmounted element attached
to parent, but only if the parent itself is unmounted.  Since all
conflicts created by reparenting have common parent *not* in the
set and one side of the conflict (bottom of the stack of overmounts)
is in the set, it will be resolved.  However, we rely upon umount_tree()
doing that pretty much immediately after the call of propagate_umount().

Algorithm is based on two statements:
	1) for any set S, there is a maximal non-shifting subset of S
and it can be calculated in O(#S) time.
	2) for any non-shifting set S, there is a maximal non-revealing
subset of S.  That subset is also non-shifting and it can be calculated
in O(#S) time.

		Finding candidates.

We are given a closed set U and we want to find all mounts that have
the same mountpoint as some mount m in U *and* whose parent receives
propagation from the parent of the same mount m.  Naive implementation
would be
	S = {}
	for each m in U
		add m to S
		p = parent(m)
		for each q in Propagation(p) - {p}
			child = look_up(q, mountpoint(m))
			if child
				add child to S
but that can lead to excessive work - there might be propagation among the
subtrees of U, in which case we'd end up examining the same candidates
many times.  Since propagation is transitive, the same will happen to
everything downstream of that candidate and it's not hard to construct
cases where the approach above leads to the time quadratic by the actual
number of candidates.

Note that if we run into a candidate we'd already seen, it must've been
added on an earlier iteration of the outer loop - all additions made
during one iteration of the outer loop have different parents.  So
if we find a child already added to the set, we know that everything
in Propagation(parent(child)) with the same mountpoint has been already
added.
	S = {}
	for each m in U
		if m in S
			continue
		add m to S
		p = parent(m)
		q = propagation_next(p, p)
		while q
			child = look_up(q, mountpoint(m))
			if child
				if child in S
					q = skip_them(q, p)
					continue;
				add child to S
			q = propagation_next(q, p)
where
skip_them(q, p)
	keep walking Propagation(p) from q until we find something
	not in Propagation(q)

would get rid of that problem, but we need a sane implementation of
skip_them().  That's not hard to do - split propagation_next() into
"down into mnt_slave_list" and "forward-and-up" parts, with the
skip_them() being "repeat the forward-and-up part until we get NULL
or something that isn't a peer of the one we are skipping".

Note that there can be no absolute roots among the extra candidates -
they all come from mount lookups.  Absolute root among the original
set is _currently_ impossible, but it might be worth protecting
against.

		Maximal non-shifting subsets.

To prove (1), consider the following operation:
	Trim(S, T) = S - {x : there is a sequence (x_0,...,x_k), such that
				k >= 1,
				for all i < k  x_i is the parent of x_{i+1},
				for all i < k  x_i belongs to S,
				x_k does not belong to S,
				mountpoint(x_1) != root(x_0),
				x = x_0,
				x_{k-1} belongs to T}

In other words, we remove an element x if there is a chain of descendents
starting at x, _not_ overmounting root of x and leaving S right after it
passes through some element of T.

Properties:

	A) for any element x that belongs to S - Trim(S, T) there is
a subtree mounted strictly inside x and containing some elements that
do not belong to S.  Directly from definition - subtree that consists
of x_1 and all its descendents will satisfy our conditions.

	B) if U is a non-shifting subset of S, U is a subset of Trim(S, T).
Indeed, suppose U is not a subset of Trim(S, T).  Then there is an element
u that belongs both to U and S - Trim(S, T).  By (A) there must be a subtree
mounted strictly inside u and containing elements that do not belong to S.
But U is non-shifting by assumption, so all elements of such subtree
will belong to U, which is a subset of S.  Contradiction.

	C) Trim(Trim(S, T1), T2) = Trim(S, union of T1 and T2).
[would be easier with pictures... ;-/]

First, let's show that Trim(Trim(S, T1), T2) is a subset of
Trim(S, union of T1 and T2).  Suppose there is an element x
of Trim(Trim(S, T1), T2) that does not belong to
Trim(S, union of T1 and T2).  Since Trim(Trim(S, T1), T2) is
a subset of Trim(S, T1), x must be an element of Trim(S, T1).

Since it doesn't belong to Trim(S, union of T1 and T2), there is a
chain of descent (x_0 = x, x_1, ..., x_k) such that
	x_1 does not overmount root of x_0
	x_0, ..., x_{k-1} all belong to S
	x_k doesn't belong to S
	x_{k-1} belongs to T1 or to T2.
If some of x_0,...,x_{k-1} do not belong to Trim(S, T1), let x_i
be the first such element.  Since x is an element of Trim(S, T1),
i can't be 0.  But then concatenation of (x_0, ..., x_{i-1})
with the chain that has lead to exclusion of x_i from Trim(S, T1)
would yield a chain excluding x itself from Trim(S, T1).  Since
x belongs to Trim(S, T1), we have shown that
	x_0, ..., x_{k-1} all belong to Trim(S, T1)
Since our chain does not exclude x from Trim(S, T1), x_{k-1} can't
be an element of T1.
So we have
	x_{k-1} belongs to T2
and
	x_k doesn't belong to S, let alone Trim(S, T1)
i.e. our chain excludes x from Trim(Trim(S, T1), T2).  Contradiction.

To prove the inclusion in opposite direction, suppose there is an
element x that belongs to Trim(S, union of T1 and T2) but not to
Trim(Trim(S, T1), T2).  x must belong to Trim(S, T1), since any chain
that would exclude it from Trim(S, T1) would've excluded it from
Trim(S, union of T1 and T2) as well.

Since x belongs to Trim(S, T1), but not Trim(Trim(S, T1), T2), there
must be a chain of descent (x_0 = x, x_1, ..., x_k) such that
	x_1 does not overmount root of x_0
	x_0, ..., x_{k-1} all belong to Trim(S, T1)
	x_k doesn't belong to Trim(S, T1)
	x_{k-1} belongs to T2.
x_k must belong to S, otherwise that chain would've excluded x
from Trim(S, union of T1 and T2).  But concatenation of
(x_0, ..., x_{k-1}) with the chain that excluded x_k from
Trim(S, T1) will yield a chain that excludes x from
Trim(S, union of T1 and T2).  Contradition.

	D) Trim(S, T) = S when S does not intersect with T.
Trivial from definition - for removing something it requires a chain
with next-to-last element belonging both to T and S.  If S and T do
not intersect, nothing get removed...

	E) Trim(S, S) is a non-shifting subset of S that contains any
non-shifting subset of S.
Suppose Trim(S, S) is *not* non-shifting.  Then it must be an element
x belonging to Trim(S, S) and a subtree mounted strictly inside x,
with some of its elements not belonging to Trim(S, S).  Let y be
one of the subtree elements that do not belong to Trim(S, S).
Let (x_0 = x, x_1, ..., x_k = y) be its chain of descent.
Without loss of generality we can assume that all of x_0,...,x_{k-1}
belong to Trim(S, S).
	y must belong to S, since otherwise that chain would've
excluded x from Trim(S, S).  Consider the chain excluding y from
Trim(S, S); its concatenation with (x_0, ..., x_{k-1}) yields
a chain that excludes x from Trim(S, S).  Contradiction.
The second part immediately follows from (B).

	F) Let U be a closed subset of S.  Then U will be a subset of
Trim(S, {x}) for any x.
Follows from (B), since any such U will be non-shifting.

	G) Let U be a closed subset of S.  Then Trim(S, {u}) = S for
any u belonging to U.
Follows directly from definition - if the next-to-last element of a
descent chain is equal to u, its last element belongs to U and thus to S.

Implementation:

	H1) Let S be an ordered set.  Then the following calculates
its maximal non-shifting subset:
Max_Non_Shifting(S)
	if S is empty
		return S
	x = first(S)
	V = S
	while true
		V = Trim(V, {x})
		if there are elements of V greater than x
			x = first of such elements
		else
			return V
Let M be the set of all values of x we have observed in the loop.
Consider the final value of V.  By (C) it's equal to Trim(S, M)
and by (B) it contains any non-shifting subset of S.  But for any
element that has remained in V until the end there must have been
an iteration with x equal to that element, so V is a subset of M.
In other words,
	Trim(V, V) = Trim(Trim(S, M), V)
		   = Trim(S, union of M and V)
		   = Trim(S, M)
		   = V
so by (E) V is non-shifting.

	H2) The following is O(#S) equivalent of S = Max_Non_Shifting(S),
assuming we can mark the elements and originally no marks are set:

Trim_to_non_shifting
	for (x = first(S); x; x = Trim_one(x))
		;
where
Trim_one(m)
	remove_this = false;
	found = false;
	for each n in children(m) {
		if (n not in S) {
			found = true;
			if (mountpoint(n) != root(m)) {
				remove_this = true;
				break;
			}
		}
	}
	if (!found)
		return next(m);
	for (this = m, p = parent(m); !marked(this) && p in S; this = p, p = parent(p)) {
		mark(this);
		if (mountpoint(this) != root(p)) {
			unmark(p);
			remove p from S;
		}
	}
	res = next(m);
	if (remove_this) {
		unmark(m);
		remove m from S;
	}
	return res;

Trim_one(m) will
	* replace S with Trim(S, {m})
	* return NULL if no elements greater than m remain in S
	* return the smallest of such elements otherwise
	* maintain the following invariants:
		* only elements of S are marked
		* if p is marked and
		     (x_0, x_1, ..., x_k = p) is an ancestry chain and
		     all x_i belong to S
		  then
		     for any i > 0  x_i overmounts the root of x_{i-1}
Proof:
	Consider the chains excluding elements from Trim(S, {m}).
The last two elements in each are m and some child of m that does not
belong to S.  If no such children exist, Trim(S, {m}) is equal to S
and next(m) is the correct return value.
	m itself is removed if and only if the chain has exactly two
elements, i.e. when the last element does not overmount the root of
m.  In other words, if there is a child not in S that does not overmount
the root of m.  Once we are done looking at the children 'remove_this'
is true if and only if m itself needs to be removed.
	All other elements to remove will be ancestors of m, such that
the entire descent chain from them to m is contained in S.  Let
(x_0, x_1, ..., x_k = m) be the longest such chain.  x_i needs to
be removed if and only if x_{i+1} does not overmount its root.
	Note that due to the invariant for marks, finding x_{i+1}
marked means that none of its ancestors will qualify for removal.
What's more, after we have found and removed everything we needed,
all remaining elements of the chain can be marked - their nearest
ancestors that do not overmount their parent's root will be outside
of S.  Since ancestry chains can't loop, we can set the marks as
we go - we won't be looking at that element again until after all
removals.
	If Trim_one(m) needs to remove m, it does that after all
other removals.  Once those removals (if any) are done m is still
an element of our set, so the smallest remaining element greater
than m is equal to next(m).  Once it is found, we can finally remove
m itself.
	Time complexity:
* we get no more than O(#S) calls of Trim_one()
* the loop over children in Trim_one() never looks at the same child
twice through all the calls.
* iterations of that loop for children in S are no more than O(#S)
in the worst case
* at most two children that are not elements of S are considered per
call of Trim_one().
* the second loop in Trim_one() sets mark once per iteration and
no element of S has is set more than once.

	H3) In practice we have a large closed non-revealing subset in S.
It can be used to reduce the amount of work.  What's more, we can have
all elements of U removed from their parents' lists of children, which
considerably simplifies life.

// S is a represented as a disjoint union of an non-nrevealing closed
// set U and a set C.  Everything in U has been removed from their parents'
// lists of children.

Trim_to_non_shifting2
	for (x = first(C); x; x = Trim_one(x))
		;
where
Trim_one(m)
	remove_this = false;
	found = false;
	umount_this = false;
	for each n in children(m) {
		if (n not in C) {
			found = true;
			if (mountpoint(n) != root(m)) {
				remove_this = true;
				break;
			}
		}
	}
	if (found) {
		this = m;
		for (p = parent(this);
		     !marked(this) && p in C;
		     m = p, p = parent(p)) {
			mark(this);
			if (mountpoint(this) != root(p)) {
				unmark(p);
				remove p from C;
			}
		}
	} else if (!locked(m) && children(m) is empty) {
		remove_this = true;
		umount_this = true;
	}
	res = next(m);
	if (remove_this) {
		unmark(m);
		remove m from C;
		if (umount_this) {
			remove m from children(parent(m))
			add m to U;
		}
	}
	return res;

Equivalent to Trim_to_non_shifting, modulo representation.  We know
that Trim_one() is a no-op when its argument belongs to U, we won't
see any elements of U in lists of children, so we only need to check
for belonging to C and we know that parent of anything not in U can't
be in U, so the ancestor-trimming loop won't run into anything in U -
test for belonging to S is equivalent to test for belonging to C there.

Simple candidates for adding to U (not locked and no children
not in U) get moved from C to U - U remains closed non-revealing
and union remains unchanged.

Time complexity is O(#C) here.


		Maximal non-revealing subsets

If S is not a non-revealing subset, there is a locked element x
in S such that parent of x is not in S.

Obviously, no non-revealing subset of S may contain x.  Removing
such elements one by one will obviously end with the maximal
non-revealing subset (possibly empty one).  Note that removal
of an element will require removal of all its locked children,
etc.

If the set had been non-shifting, it will remain non-shifting
after such removals.
Proof: suppose S was non-shifting, x is a locked element of S,
parent of x is not in S and S - {x} is not non-shifting.  Then
there is an element m in S - {x} and a subtree mounted strictly
inside m, such that m contains an element not in in S - {x}.
Since S is non-shifting, everything in that subtree must belong
to S.  But that means that this subtree must contain x somewhere
*and* that parent of x either belongs that subtree or is
equal to m.  Either way it must belong to S.  Contradiction.

// same representation as for finding maximal non-shifting subsets:
// S is a disjoint union of non-revealing set U and a set C.
// Elements of U are removed from their parents' lists of children.
// in the end C becomes empty and maximal non-revealing non-shifting
// subset of S is now in U
Trim_locked
	while (C is non-empty)
		handle_locked(first(C))

handle_locked(m)
	cutoff = m
	for (p = m; p in C; p = parent(p)) {
		unmark(p);
		remove p from C;
		if (!locked(p))
			cutoff = parent(p)
	}
	if (p in U)
		cutoff = p
	while (m != cutoff) {
		remove m from children(parent(m));
		add m to U;
		m = parent(m);
	}

Let (x_0, ..., x_n = m) be the maximal chain of descent of
m within S.
* If it contains some elements of U, let x_k be the last one
of those.  Then union of U with {x_{k+1}, ..., x_n} is obviously
non-revealing.
* otherwise if all its elements are locked, then none of
{x_0, ..., x_n} may be elements of a non-revealing subset of S.
* otherwise let x_k be the first unlocked element of the chain.
Then none of {x_0, ..., x_{k-1}} may be an element of a non-revealing
subset of S and union of U and {x_k, ..., x_n} is non-revealing.

handle_locked(m) finds which of these cases applies and adjusts
C and U accordingly.  U remains non-revealing, union of C and U
still contains any non-revealing subset of S and after the
call of handle_locked(m) m is guaranteed to be not in C.
So having it called for each element of S would suffice to
empty C, leaving U the maximal non-revealing subset of S.

However, handle_locked(m) is a no-op when m belongs to U,
so it's enough to have it called for elements of C while there
are any.

Time complexity: number of calls of handle_locked() is
limited by #C, each iteration of the first loop in handle_locked()
removes an element for C, so their total number of executions is
also limited by #C; number of iterations in the second loop is
no greater than the number of iterations of the first loop.


		Reparenting

After we'd calculated the final set, we still need to deal with
reparenting - if an element of the final set has a child not
in it, we need to reparent such child.

Such children can only be root-overmounting (otherwise the
set wouldn't be non-shifting) and their parents can not belong
to the original set, since the original is guaranteed to
be closed.

		Putting all of that together

The plan is to
	* find all candidates
	* trim down to maximal non-shifting subset
	* trim down to maximal non-revealing subset
	* reparent anything that needs to be reparented
	* return the resulting set to the caller

For the 2nd and 3rd steps we want to separate the set into
growing non-revealing subset, initially containing the
original set ("U" in terms of the pseudocode above) and
everything we are still not sure about ("C").  It means
that for the output of the 1st step we'd like the extra
candidates separated from the stuff already in the original
set.  For the 4th step we would like the additions to U
separate from the original set.

So let's go for
	* original set ("set").  Linkage via mnt_list
	* unclassified candidates ("C").  Linkage via mnt_umounting.
	* anything in U that hadn't been in the original set -
elements of C will gradually be either discarded or moved
there.  In other words, it's the candidates we have already
decided to unmount.  Its role is reasonably close to the
old "to_umount", so let's use that name.  Linkage via mnt_list.

For gather_candidates() we'll need to maintain both C (S - set) and
intersection of S with set, with the latter emptied once we are done.
Use mnt_umounting for both, that'll give a cheap way to check belonging
to their union (in gather_candidates()) and to C itself (at later stages).
Call that predicate is_candidate(); it would be !list_empty(&m->mnt_umounting)

All elements of the original set are marked with MNT_UMOUNT and we'll need
the same for elements added when joining the contents of to_umount to set in
the end.  Let's set MNT_UMOUNT at the time we add an element to to_umount;
that's close to what the old 'umount_one' is doing, so let's keep that name.
It also gives us another predicate we need - "belongs to union of set and
to_umount"; will_be_unmounted() for now.

Another helper - unmark and remove from C; remove_candidate(m)

propagate_unmount(set)
{
	// C <- candidates
	gather_candidates(set);

	// make set + C + to_umount non-shifting
	for (m = first(C); m; m = trim_one(m))
		;

	// ... and non-revealing
	while (!empty(C))
		handle_locked(first(C));

	// now to_umount consists of all non-rejected candidates
	// deal with reparenting of remaining overmounts on those
	list_for_each_entry(m, to_umount, mnt_list) {
		while (!empty(children(m))) // should be at most one
			reparent(first(children(m)))
	}

	list_splice_tail_init(set, &to_umount);
}

gather_candidates(set)
{
	LIST_HEAD(visited)	// intersection of S with set
	C = {}			// S - set, i.e. candidates

	list_for_each_entry(m, set, mnt_list) {
		if (is_candidate(m))
			continue;
		list_add(&m->mnt_umounting, &visited);
		p = parent(m);
		q = propagation_next(p, p);
		while (q) {
			child = look_up(q, mountpoint(m));
			if (child) {
				if (is_candidate(child)) {
					q = skip_them(q, p);
					continue;
				}
				if (will_be_unmounted(child))
					head = &visited;
				else
					head = &C;
				list_add(&child->mnt_umounting, head);
			}
			q = propagation_next(q, p);
		}
	}
	while (!list_empty(&visited))	// empty visited
		list_del_init(visited.next);
}

trim_one(m)
{
	bool remove_this = false, found = false, umount_this = false;
	struct mount *res, *n;

	for each n in children(m) {
		if (!is_candidate(n)) {
			found = true;
			if (mountpoint(n) != root(m)) {
				remove_this = true;
				break;
			}
		}
	}
	if (found) {
		struct mount *this = m;
		for (struct mount *p = parent(this);
		     !marked(this) && is_candidate(p);
		     this = p, p = parent(p)) {
			mark(this);
			if (mountpoint(this) != root(p))
				remove_candidate(p);
		}
	} else if (!locked(m) && children(m) is empty) {
		remove_this = true;
		umount_this = true;
	}
	res = next(m);
	if (remove_this) {
		remove_candidate(m);
		if (umount_this)
			umount_one(m);
	}
	return res;
}

handle_locked(m)
{
	struct mount *cutoff = m, *p;

	for (p = m; is_candidate(p); p = parent(p)) {
		remove_candidate(p);
		if (!locked(p))
			cutoff = parent(p);
	}
	if (will_be_unmounted(p))
		cutoff = p;
	while (m != cutoff) {
		umount_one(m);
		m = parent(m);
	}
}

reparent(m)
{
	struct mount *p = m;

	do {
		mp = p->mnt_mp;
		p = parent(p);
	} while (will_be_unmounted(p));
	mnt_change_mountpoint(p, mp, m);
}

is_candidate(m)
	return !list_empty(&m->mnt_umounting);

will_be_unmounted(m)
	return m->mnt.mnt_flags & MNT_UMOUNT;

umount_one(m)	// does *not* unmark or remove from C, unlike the old namesake
{
	m->mnt.mnt_flags |= MNT_UMOUNT;
	list_del_init(&m->mnt_child); // remove from parent's list of children
	move_from_ns(m, &to_umount);
}

remove_candidate(m)
{
	unmark(m);
	list_del_init(&m->mnt_umounting); // remove m from C
}

