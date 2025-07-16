Return-Path: <linux-fsdevel+bounces-55045-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E10B06A56
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 02:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A33434E433E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 00:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498D820ED;
	Wed, 16 Jul 2025 00:13:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A5B10E4;
	Wed, 16 Jul 2025 00:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752624794; cv=none; b=CWIZsQlu7HGu/1nekgsenHSiPd+v3NXnC0yeaWXghIUgLisSsqi2QayTYFUiAnGG4MvSL5hMmF4jrKEptw9CHTznthu3my6r85dEJ5h8UZ7O8i8bmDNtCoRUbOij7CW2zDf3keu96+AVzmrWOxVVr9BgBfU0HpM5ptGQgIPFn74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752624794; c=relaxed/simple;
	bh=+/HDhExDF7Yx4AOGidioC6Y1nFyqT9UG8EJ6qDHo30g=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=ndU4L7lqLthFnpXlQMV9fBwyy0cK5Qe34xblREaWGYThhJDUQ2k/Wxgowcmrqfqn6OEEAPsGhel1aYvYmg1Hz6FacD/phYAkNh4mw6xMLIu5S+1Nn9STCbYg60qghFZqFACMne4YgifrreLE+QOY2zp0Y6o9WLBIBluv2y4vS3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ubpld-002A43-5S;
	Wed, 16 Jul 2025 00:13:02 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Amir Goldstein" <amir73il@gmail.com>
Cc: "Miklos Szeredi" <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, "Christian Brauner" <brauner@kernel.org>,
 "Al Viro" <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>
Subject: Re: [PATCH 00/20 v2] ovl: narrow regions protected by i_rw_sem
In-reply-to:
 <CAOQ4uxhkAgJR0ALwVjUugYxNyu4JCkYFaZimOE6G--_AJi65mA@mail.gmail.com>
References:
 <>, <CAOQ4uxhkAgJR0ALwVjUugYxNyu4JCkYFaZimOE6G--_AJi65mA@mail.gmail.com>
Date: Wed, 16 Jul 2025 10:13:02 +1000
Message-id: <175262478253.2234665.1520483414112717438@noble.neil.brown.name>

On Mon, 14 Jul 2025, Amir Goldstein wrote:
> [CC vfs maintainers]
>=20
> On Fri, Jul 11, 2025 at 6:41=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
> >
> > On Fri, Jul 11, 2025 at 1:21=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
> > >
> > > This is a revised set of patches following helpful feedback.  There are
> > > now more patches, but they should be a lot easier to review.
> >
> > I confirm that this set was "reviewable" :)
> >
> > No major comments on my part, mostly petty nits.
> >
> > I would prefer to see parent_lock/unlock helpers in vfs for v3,
> > but if you prefer to keep the prep patches internal to ovl, that's fine t=
oo.
> > In that case I'd prefer to use ovl_parent_lock/unlock, but if that's too
> > painful, don't bother.
> >
> > Thanks,
> > Amir.
> >
> > >
> > > These patches are all in a git tree at
> > >    https://github.com/neilbrown/linux/commits/pdirops
> > > though there a lot more patches there too - demonstrating what is to co=
me.
> > > 0eaa1c629788 ovl: rename ovl_cleanup_unlocked() to ovl_cleanup()
> > > is the last in the series posted here.
> > >
> > > I welcome further review.
> > >
> > > Original description:
> > >
> > > This series of patches for overlayfs is primarily focussed on preparing
> > > for some proposed changes to directory locking.  In the new scheme we
> > > will lock individual dentries in a directory rather than the whole
> > > directory.
> > >
> > > ovl currently will sometimes lock a directory on the upper filesystem
> > > and do a few different things while holding the lock.  This is
> > > incompatible with the new scheme.
> > >
> > > This series narrows the region of code protected by the directory lock,
> > > taking it multiple times when necessary.  This theoretically open up the
> > > possibilty of other changes happening on the upper filesytem between the
> > > unlock and the lock.  To some extent the patches guard against that by
> > > checking the dentries still have the expect parent after retaking the
> > > lock.  In general, I think ovl would have trouble if upperfs were being
> > > changed independantly, and I don't think the changes here increase the
> > > problem in any important way.
> > >
> > > I have tested this with fstests, both generic and unionfs tests.  I
> > > wouldn't be surprised if I missed something though, so please review
> > > carefully.
> > >
> > > After this series (with any needed changes) lands I will resubmit my
> > > change to vfs_rmdir() behaviour to have it drop the lock on error.  ovl
> > > will be much better positioned to handle that change.  It will come with
> > > the new "lookup_and_lock" API that I am proposing.
> > >
>=20
> Slightly off topic. As I know how much ovl code currently depends on
> (perhaps even abuses) the directory inode lock beyond its vfs uses
> (e.g. to synchronize internal ovl dir cache changes) just an idea that
> came to my head for your followup patches -
> Consider adding an assertion in WRAP_DIR_ITER() that disallows
> i_op->no_dir_lock.
> Not that any of the current users of WRAP_DIR_ITER() are candidates
> for parallel dir ops (?), but its an easy assertion to add.

Thanks a sensible suggestion - thanks.
Though removing the need for WRAP_DIR_ITER() would be nice too... Not an
easy task for course.

Thanks,
NeilBrown

