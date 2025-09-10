Return-Path: <linux-fsdevel+bounces-60729-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB964B50BC1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 04:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 303083BAA95
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 02:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3DB258ED8;
	Wed, 10 Sep 2025 02:45:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62652580EC
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Sep 2025 02:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757472347; cv=none; b=jyTsSvnf0VDqIKQTsjWDX84bVvhTf8edjomIU/N6zOUdoRDoIpakiBuV+4vELfvcSbBRqKt+VytkjHnSlBoRRlRQfNRQ8l403bQYqvO+7N+cm/K9M+6XVxw0F2Jli3WfQEUDDtUl+J6ADC23X5voq/PqwEgW/i7zUROtjY5Fq+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757472347; c=relaxed/simple;
	bh=Tk+hbfiuvgPbD6MYvuBFRU+bnhg3AAeAbI3Ke5RncBM=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=MOU1h9xSmnFOMrnXCsyTxojTz0YqEGb++dslAO4iNeAHKodKLJz1qVzHvRyr6n0wldxqh5hTqm4zSQxs0WBziFiFIulHWB55TbUrgmJrdKPBn/Kf/+a8nu36uppowmowKyuKfinFT378YiT4WqEe6rzJZkWgB9uTuDZbNNf6HV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uwAq3-008th2-Ti;
	Wed, 10 Sep 2025 02:45:41 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Al Viro" <viro@zeniv.linux.org.uk>
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Christian Brauner" <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 "Jan Kara" <jack@suse.cz>
Subject: Re: [RFC] a possible way of reducing the PITA of ->d_name audits
In-reply-to: <20250908090557.GJ31600@ZenIV>
References: <>, <20250908090557.GJ31600@ZenIV>
Date: Wed, 10 Sep 2025 12:45:41 +1000
Message-id: <175747234137.2850467.15661817300242450115@noble.neil.brown.name>

On Mon, 08 Sep 2025, Al Viro wrote:
> On Mon, Sep 08, 2025 at 04:25:26PM +1000, NeilBrown wrote:
>=20
> > Might the locking rules be too complex?  Are they even documented?
>=20
> For ->d_name and ->d_parent?  Very poorly.  That's the absolute worst
> part of struct dentry locking rules.  _That_ is the place where attempts
> to write a coherent documentation stall every time, often diverting
> into yet another side story from hell.  ->d_revalidate() calling convention
> change came from one of those; at least that got dealt with for good
> now - and took a couple of years in the making, what with getting sidetrack=
ed
> to other stuff.
>=20
> Keep in mind that there are weird filesystems that manage to get away with
> playing very odd games.  Or do not manage, really - apparmorfs is the
> most recent weird thing.  Locking of their own, *interspersed* between
> the directory locks.  With ->mkdir() and ->rmdir() both unlocking and
> relocking the parent.  At least apparmor folks have finally admitted that
> there's a problem...
>=20
> I don't believe that any of us can get away with imposing changes that
> would break configfs (another weird horror).  Or apparmor.  Or autofs,
> for that matter...
>=20
> Anyway, the current rules are:
> 	* only __d_move() ever changes name/parent of live dentry (there's
> d_mark_tmpfile(), but that's done to a dentry that is invisible to anyone
> other than caller - it flips name from "/" to "#<inumber>" just before
> attaching the inode to it; part of ->tmpfile())
> 	* any change happens under rename_lock.
> 	* any change happens under ->d_lock on everything involved (parent(s)
> included).
> 	* move from one parent to another happens only under ->s_vfs_rename_mutex.
> 	* exclusive lock on directory is enough to prevent moves to or from
> that directory.
> 	* only positive dentries ever get moved/renamed
> 	* d_splice_alias() may move an existing directory dentry, but no
> non-directory is going to be touched by it.
> 	* with a couple of exceptions (told you it's messy) d_move() and d_exchang=
e()
> are called in locking conditions equivalent to vfs_rename() - ->s_vfs_renam=
e_mutex
> if cross-directory, parent(s) exclusive, etc.  Exceptions are vfat_lookup()
> and exfat_lookup() - both would be in trouble if ->link() was supported the=
re.
>=20
> What it boils down to for filesystems is
> 	* any dentry passed to directory-modifying operation has stable ->d_name
> and ->d_parent.  That also applies to ->atomic_open() even without O_CREAT =
in
> flags, except for the mess with directories in some cases (without O_CREAT
> if you are given an in-lookup dentry and it turns out to be a directory,
> from that point on you have no promise that it won't be reparented by d_spl=
ice_alias();
> whether it can actually happens depends upon the filesystem, but instances =
tend to
> just call finish_no_open() in that case and bugger off).
> 	* any dentry passed to ->lookup() has stable ->d_name/->d_parent until it
> had been passed to d_splice_alias() (which is normally the last time we loo=
k at
> it).
> 	* ->d_revalidate() and ->d_compare() get stable name passed as argument;
> they should not look at dentry->d_name at all.

So if we were to provide kdoc documentation for claim_stability() it
could say something like:

 It is only safe to claim_stability() for a dentry if:
   - ->d_parent->d_inode is locked exclusively
      This is guaranteed for target dentries passed to directory-modifying
      inode_operations, but not e.g. the old_dentry passed to ->link.
      It is also guaranteed for dentry passed to ->atomic_open when create it=
 set.
   - ->d_inode is locked exclusively. This is guaranteed for the
       old_dentry passed to ->link.
   - DCACHE_PAR_LOOKUP is set.  Dentries passed to ->lookup will
     either have this flag or the parent will be locked exclusively
   - dentry is negative and a shared lock is held on parent inode.
     This is guaranteed for dentries passed to ->atomic_open when create
     is NOT set.
   - the ->d_lock is held on the dentry or its ->d_parent

 All uses of claim_stability() should be preceded by a comment
 identifying which condition is claimed to be met.

>=20
> > As you know I want to change directory locking so that a ->d_flags bit
> > locks a dentry in much the same way that locking the parent directory
> > currently does.
> >=20
> > I had wondered why vfs_link() locks the inode being linked and thought it=
 was
> > only to protect ->i_nlink.  If it is needed to protect against rename
> > too, that could usefully be documented - or we could use the same
> > ->d_flags bit to ensure that lock.
>=20
> We could.  FWIW, I *like* the notion of "dentry that is held in place and w=
on't
> go away/get renamed/dropped until we say so".  That's the major reason why =
I'm
> interested in your patchset, actually.
>=20
> > I guess I'm a bit concerned that your goal here is to transition from
> > "lots of auditing" to "much less auditing" and I would rather it was "no
> > auditing needed" - one day you won't want to (or be able to) audit any
> > more.
> >=20
> > Fudging some type-state with C may well be useful but I suspect it is at
> > most part of a solution.  Simplification, documentation, run-time checks
> > might also be important parts.  As the type-state flag-day is a big
> > thing, maybe it shouldn't be first.
>=20
> All of that requires being able to answer questions about what's there in
> the existing filesystems.  Which is pretty much the same problem as
> those audits, obviously.  And static annotations are way easier to
> reason about.

And they are good places to encourage people to put comments.  I'm
liking this idea more because it provides a focus for documenting a
non-trivial dependency.

>=20
> Anyway, I'm about to fall asleep (it's nearly 5am here); I've put an
> initial sketch of infrastructure and of symlink calling conventions change
> to #experimenta.stable_dentry, but it's very raw at the moment - and lacks
> the followups that would make use of that stuff.  I'll continue tomorrow
> (right now I've got ->create() half-done as well), but by now one thing
> I'm certain about is that it will be trivial to reorder wrt your stuff -
> in either direction.  So that worry can be discarded - change might or
> might not be a good idea, but as flagdays go it's trivial.
>=20

One thing I don't like is the name "unwrap_dentry()".  It says what is
done rather than what it means or what the purpose is.
Maybe "access_dentry()" (a bit like rcu_access_pointer()).
Maybe "dentry_of()" - then we would want to call stable dentries
"stable_foo" or similar.  So:

 static int afs_symlink(struct mnt_idmap *idmap, struct inode *dir,
                      struct stable_dentry stable_child, const char *content)
 {
       struct dentry *dentry =3D dentry_of(stable_child);


Passing around a struct that contains a single pointer feels strange and
anything we can do to give it a more natural feel and make it easy to
read would likely be a win.

Thanks,
NeilBrown

