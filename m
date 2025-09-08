Return-Path: <linux-fsdevel+bounces-60481-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75018B487C5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 11:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 520267AC965
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 09:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4012F0661;
	Mon,  8 Sep 2025 09:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="iM3zfs6z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87832F0C6F
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Sep 2025 09:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757322362; cv=none; b=TdoS62uC1pJ+EcplWslczoKBBKH8ONEdU5QIpK0cl9Ud3PQJMuymcTleOPBRcf5UIFvIUaJqWXBecbvjrUdSPLP/LDLmL2XS6odI6y+BTnKqkBIsF6Q0qhe7jmHgxFJfik+tnhcmXndxKGTy5FC1koHWT4Qt6q9XIAkLsIX+b5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757322362; c=relaxed/simple;
	bh=oSA263G/clmVuqJxhuSKJYjljHe31B19cdth0t9LBe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m4L0h6UbsgXrmuHIiCsq9dbF6bFwQ7piohk4/2B7/gNw2bArLpNjD0SvSCR/r+KosdVD9JwaN4ZE7iylEe8f0P5CpEkoWPVOOZN1sMsBVCJniFMClK6xzvYHqgiGQyF1bLhv7tDMrO+fIqWE87F0mLGzY7b0r6X7knrHTwcd+54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=iM3zfs6z; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=D8yr0r29YtuJ1LYj5SuoQpkleN/cSqbgnbvU7s0ET0k=; b=iM3zfs6zjVquK2OnLGBhHHVKUN
	GxtiV5X3z9tqnWrvbChf32naf09YocQp7i6FYbwrRbKq9EDDR9frAJT3xiIbxqe7HVT37/vL6HWkj
	MSjFNAJ2+mO5ir3Nj5g41sdZuAbTBx7ZBz+Z5mJSbw5u8tXPRbrujnT0jpTWHixsYW0fDano62+Pe
	+rne/hscUypk3QIHOXlaZHdlIapgc1xuV4Jjn8V0zDRRCr/gyZuJgKgWs7hZu1KpYG7poJHGIZczm
	6jxfKMohlbVcesvVH2uYZL0qTpsA58YWdFjrKUu8XinxcQiIOa18zvn99EL7uuMPE42AxDNcpZfAK
	k3hyl79g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvXoz-0000000H8tj-2NIJ;
	Mon, 08 Sep 2025 09:05:57 +0000
Date: Mon, 8 Sep 2025 10:05:57 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neil@brown.name>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [RFC] a possible way of reducing the PITA of ->d_name audits
Message-ID: <20250908090557.GJ31600@ZenIV>
References: <>
 <20250908051951.GI31600@ZenIV>
 <175731272688.2850467.5386978241813293277@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175731272688.2850467.5386978241813293277@noble.neil.brown.name>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Sep 08, 2025 at 04:25:26PM +1000, NeilBrown wrote:

> Might the locking rules be too complex?  Are they even documented?

For ->d_name and ->d_parent?  Very poorly.  That's the absolute worst
part of struct dentry locking rules.  _That_ is the place where attempts
to write a coherent documentation stall every time, often diverting
into yet another side story from hell.  ->d_revalidate() calling convention
change came from one of those; at least that got dealt with for good
now - and took a couple of years in the making, what with getting sidetracked
to other stuff.

Keep in mind that there are weird filesystems that manage to get away with
playing very odd games.  Or do not manage, really - apparmorfs is the
most recent weird thing.  Locking of their own, *interspersed* between
the directory locks.  With ->mkdir() and ->rmdir() both unlocking and
relocking the parent.  At least apparmor folks have finally admitted that
there's a problem...

I don't believe that any of us can get away with imposing changes that
would break configfs (another weird horror).  Or apparmor.  Or autofs,
for that matter...

Anyway, the current rules are:
	* only __d_move() ever changes name/parent of live dentry (there's
d_mark_tmpfile(), but that's done to a dentry that is invisible to anyone
other than caller - it flips name from "/" to "#<inumber>" just before
attaching the inode to it; part of ->tmpfile())
	* any change happens under rename_lock.
	* any change happens under ->d_lock on everything involved (parent(s)
included).
	* move from one parent to another happens only under ->s_vfs_rename_mutex.
	* exclusive lock on directory is enough to prevent moves to or from
that directory.
	* only positive dentries ever get moved/renamed
	* d_splice_alias() may move an existing directory dentry, but no
non-directory is going to be touched by it.
	* with a couple of exceptions (told you it's messy) d_move() and d_exchange()
are called in locking conditions equivalent to vfs_rename() - ->s_vfs_rename_mutex
if cross-directory, parent(s) exclusive, etc.  Exceptions are vfat_lookup()
and exfat_lookup() - both would be in trouble if ->link() was supported there.

What it boils down to for filesystems is
	* any dentry passed to directory-modifying operation has stable ->d_name
and ->d_parent.  That also applies to ->atomic_open() even without O_CREAT in
flags, except for the mess with directories in some cases (without O_CREAT
if you are given an in-lookup dentry and it turns out to be a directory,
from that point on you have no promise that it won't be reparented by d_splice_alias();
whether it can actually happens depends upon the filesystem, but instances tend to
just call finish_no_open() in that case and bugger off).
	* any dentry passed to ->lookup() has stable ->d_name/->d_parent until it
had been passed to d_splice_alias() (which is normally the last time we look at
it).
	* ->d_revalidate() and ->d_compare() get stable name passed as argument;
they should not look at dentry->d_name at all.

> As you know I want to change directory locking so that a ->d_flags bit
> locks a dentry in much the same way that locking the parent directory
> currently does.
> 
> I had wondered why vfs_link() locks the inode being linked and thought it was
> only to protect ->i_nlink.  If it is needed to protect against rename
> too, that could usefully be documented - or we could use the same
> ->d_flags bit to ensure that lock.

We could.  FWIW, I *like* the notion of "dentry that is held in place and won't
go away/get renamed/dropped until we say so".  That's the major reason why I'm
interested in your patchset, actually.

> I guess I'm a bit concerned that your goal here is to transition from
> "lots of auditing" to "much less auditing" and I would rather it was "no
> auditing needed" - one day you won't want to (or be able to) audit any
> more.
> 
> Fudging some type-state with C may well be useful but I suspect it is at
> most part of a solution.  Simplification, documentation, run-time checks
> might also be important parts.  As the type-state flag-day is a big
> thing, maybe it shouldn't be first.

All of that requires being able to answer questions about what's there in
the existing filesystems.  Which is pretty much the same problem as
those audits, obviously.  And static annotations are way easier to
reason about.

Anyway, I'm about to fall asleep (it's nearly 5am here); I've put an
initial sketch of infrastructure and of symlink calling conventions change
to #experimenta.stable_dentry, but it's very raw at the moment - and lacks
the followups that would make use of that stuff.  I'll continue tomorrow
(right now I've got ->create() half-done as well), but by now one thing
I'm certain about is that it will be trivial to reorder wrt your stuff -
in either direction.  So that worry can be discarded - change might or
might not be a good idea, but as flagdays go it's trivial.

