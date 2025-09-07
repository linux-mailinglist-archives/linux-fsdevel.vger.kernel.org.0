Return-Path: <linux-fsdevel+bounces-60463-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55536B47F1A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Sep 2025 22:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 112703C2455
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Sep 2025 20:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA80621ADAE;
	Sun,  7 Sep 2025 20:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="nLAX9yjJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1E42139C9
	for <linux-fsdevel@vger.kernel.org>; Sun,  7 Sep 2025 20:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757277181; cv=none; b=CWdouMXMgyulmIAFaMQbwUmk+mUu9BNSb6nWuEzuDQxSwcARvYiK1FgG6ZCRfI1zWdltAMLJgJX1WRZLU/SDPAtF2qDgKohwDsA8qUENz7JTPCqU8hBVM87EKCccpau5CXuwKeosChVPJrfowllesp4Bms0tZJS2T/tNDZY+7fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757277181; c=relaxed/simple;
	bh=Q8ghGbCrqeI+FP5slEjAs7rd7yTqjOoXn4QVkTvS+tE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=j7n2AlmTfB1bQXqx+J4/0/GeAaWGnKXwpxAHWIMXGv8+fvnNBbONWWQYvbgh40tGOaK/T2OzipwA9Ux29CQboyyCSuqWTv5C9iPS/oeWMAWXVNTBFgUM0G12S3NeQmS1dABuqjZNBPuWvQUquPJKPO7Wolz9ZkjxcMAulqsa9/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=nLAX9yjJ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=x7N2/fU1DHGRxp4RG09CbvDoj0nycVGrVVE+FmaC96o=; b=nLAX9yjJJWDxo4PufGhvNzNBwv
	BWPO1u9oUSUXQmWf6YxHdov3i7F542nCR0K5c/zPPGmXIQRypQBVtoQHJpZtH4fOU+ZAOA7ZN0nbH
	CPcaHcP1mlQiuzhuNmgu5E+CBiaZAtm0iZYatR/wuulKErc055LD69KjkgMWKIGoRbEFtjUm6Gd7c
	oglZje0Dr2jgA2RWBxXJ5oh5omqAt4b8/cb4NThgiN52NAFTqHRqEMg2AhWaELPKH72S4skJTrnKc
	AtwsDXHOxYsrtvqu5IIBYjBaizYwHqTipk+oliqwJElA87XyHRx7BL0BCek0Y2upIlqQAw7pPvMrd
	sgo3euvQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvM4F-00000008D3i-0QbG;
	Sun, 07 Sep 2025 20:32:55 +0000
Date: Sun, 7 Sep 2025 21:32:55 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
	Jan Kara <jack@suse.cz>, NeilBrown <neil@brown.name>
Subject: [RFC] a possible way of reducing the PITA of ->d_name audits
Message-ID: <20250907203255.GE31600@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

	I would like to discuss a flagday change to calling conventions
of ->create()/->unlink()/->rename()/etc. - all directory methods.
It would have no impact on the code generation, it would involve
quite a bit of localized churn and it would allow to deal with catching
->d_name races on compiler level.

	A bit of background:

	Unlike file->f_path, dentry->d_name *can* change for a live
dentry.  We had quite a few bugs where it had been used unsafely and
new ones almost certainly will crop up.

	A part of a problem is that locking rules are fairly
convoluted; they do cover most of the uses in filesystem code these days
(->d_revalidate() was the last major source of headache), but they are
not fun to verify.  I've no better solution than a code audit once in a while,
and every time it's really unpleasant.

	It starts with verifying that ->d_name contents of a live dentry
can only be changed by __d_move().  The next step is tracing the callers
of that and verifying several predicates regarding the locks held
by callers.  Next we need to go over the places that access ->d_name
and check that locking in those does give sufficient exclusion.
That's about 800 locations to look through right now, and examining those
(and the call chains leading to them) is very distinctly Not Fun(tm).

	It used to be worse; reducing the number of places that needed
to be examined is something I'd been doing for quite a while (debugfs
bunch was the latest mostly taken out).  The problem is, most of the
remaining stuff is genuinely needed - foofs_unlink() *does* need to
know which directory entry to remove, etc.

	The typical part of that audit goes like that:
* foo_do_something(whatever, dentry, flags) uses dentry->d_name.{name,len}.
* we need to examine all callchains that might lead to it and prove
  that locking environment in each of those is sufficient to stabilize
  these values.  Note that locking environments may vary between the
  callchains, with their intersection being too weak.
* one callchain is
	call of ->i_op->symlink() hits foo_symlink()
	foo_symlink() calls foo_mknod()
	foo_mknod() call foo_create_object()
	foo_create_object() calls foo_do_something()
  with dentry in the last one coming from the third argument of ->symlink().
  All callers of ->symlink() guarantee the sufficient locking environment
  for stability of that argument - both its ->d_name and ->d_parent are
  not going to change under us (that, BTW, is a separate audit, thankfully
  a much smaller one).  Therefore we know that this callchain is OK.
  Lather, rinse, repeat...

	None of that is all that complicated (well, unless you are looking
at something with obscene call chains *cough*ceph*cough*).  The trouble
is, there are literally hundreds of places to examine, and that needs to
be multiplied by the number of callchains.  Doing that manually is bloody
painful; "AI" (s)tools are worse than useless in that area - verifying the
output is actually _harder_ than doing the whole thing manually.

	We need some annotations ("this dentry is guaranteed to be stable"),
some way to verify their correctness and helpers that would give access
to members in question (both ->d_name and ->d_parent), with some way to
check that they are only used for stable ones.  IMO that's a good fit for
type system.  And AFAICS, the C type system, weak as it is, can be used
for that.

	Suppose we introduce something like
struct stable_dentry {
	struct dentry *__touch_that_and_suffer;
};

static inline struct stable_dentry claim_stability(struct dentry *dentry)
{
	return (struct stable_dentry){dentry};
}

static inline struct dentry *unwrap_dentry(struct stable_dentry v)
{
	/* this would better be the only place using that identifier */
	return v.__touch_that_and_suffer;
}

static const struct qstr *dentry_name(struct stable_dentry v)
{
	return &unwrap_dentry(v)->d_name;
}

static struct dentry *dentry_parent(struct stable_dentry v)
{
	return unwrap_dentry(v)->d_parent;
}

	Those things get passed as argument and returned in the same way
dentry pointers are, AFAICS on all ABIs we care about.  And they can
serve as annotations - to pass such object (by value) instead of passing
a dentry reference == claim that dentry in question is stable and will
remain such for duration of call.

	So we can do a series of patches along the lines of
* switch ->symlink() to use of struct stable_dentry
* replace
static int ramfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
			 struct dentry *dentry, const char *symname)
{
with
static int ramfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
			 struct stable_dentry child, const char *symname)
{
	struct dentry *dentry = unwrap_dentry(child);
and similar for all instances
* replace the caller(s) (there's only one, in this case - in vfs_symlink())
so that
	error = dir->i_op->symlink(idmap, dir, dentry, oldname);
becomes
	error = dir->i_op->symlink(idmap, dir, claim_stability(dentry), oldname);
possibly with a followup that switches vfs_symlink() to stable_dentry as well
(in which case claim_stability() shifts to the callers).
* Add to D/f/porting.rst:
**mandatory**

->symlink() takes struct stable_dentry now; if you are affected, replace
the third argument with struct stable_dentry and use unwrap_dentry()
to obtain the dentry reference from it.  If your ->symlink() instance
happens to be called directly, wrap the argument into claim_stability()
at the call site (and check that you *do* have sufficient locking
environment there - if you didn't, it's a bug right there and you'd
need to fix it first, so that it could be backported without dragging
the calling conventions change along).

That's the flagday part; it would be fairly mechanical, with very easy
way to conform for anything outside of mainline tree.

Once that is done, we can eliminate the direct uses of ->d_name
- dentry_name(child) would do it; might make sense to propagate
stable_dentry down into helpers - depends upon the filesystem.

What we get out of that is a much smaller set of places to audit, all
easily catchable by grep.
	1) claim_stability() calls.  There are _far_ fewer of those,
and each does need to be verified anyway.
	2) places where we use ->d_name in filesystems.  Hopefully to
be much reduced.  Something that e.g. grabs ->d_lock and looks at ->d_name
is safe, and that ->d_lock would typically be taken within a few lines
before the use.
	3) places that simulate claim_stability; catchable by grep -
that can be defeated by preprocessor-level obfuscation, but anything
like _that_ would be a confession of malicious intent.  And sparse would
not be hard to teach catching those anyway.
Everything else would be caught by compiler.

IMO getting rid of that headache (several days of unpleasant mechanical
work every time) would be very tempting.  OTOH, it is a flagday change
and such calling conventions changes risk the bikeshedding fest from hell...

Comments?

