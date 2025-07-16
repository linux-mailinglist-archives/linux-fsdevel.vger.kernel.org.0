Return-Path: <linux-fsdevel+bounces-55084-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 243FAB06C7E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 05:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 362CC504537
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 03:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56864244691;
	Wed, 16 Jul 2025 03:55:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D503211A35;
	Wed, 16 Jul 2025 03:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752638109; cv=none; b=at0P/CU7YMymrR3R9xjhQJErK+eth92iKjoNJh4/j3BlhVltt6ZpMc+9lv0f00H+A2L+XcPebMjeb5Bc4nd199Wom+IT2n8wCzo0rbizPkDOaD2X44tE7zcfI88VKzEA01e3dvdcQW4KFx6ggoY/48pbCDa0PLhvtkpsiOBhHO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752638109; c=relaxed/simple;
	bh=Xnz0hk/bX/KBHAkfGrVlSqLxaE9TPP4B6T0NZ835CZo=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=UEqZs61NuQDjhbaLMQyrIDkB0wBTaTsj+Yq3w2dE6x8kApUiEXlVEacg5Ol5ufI/C9lk/kUUxMuHlZV9FXNvRrIneVUCRQujPvCpR+Z5ImLbpmNv2c/a3w7CZizzUGyAVrOaIkxRIwaCYPfDv/AniQWEzNBYOfcu/QdbUq2tUv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ubtEU-002B2e-Cp;
	Wed, 16 Jul 2025 03:55:04 +0000
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
Cc: "Christian Brauner" <brauner@kernel.org>,
 "Miklos Szeredi" <miklos@szeredi.hu>,
 "overlayfs" <linux-unionfs@vger.kernel.org>,
 "linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
 "Al Viro" <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>
Subject: Re: parent_lock/unlock (Was: [PATCH 01/20] ovl: simplify an error
 path in ovl_copy_up_workdir())
In-reply-to:
 <CAOQ4uxjf=ig-t4GFPXzmKn1C26F3L9UAt1WKapLQ=nXbE8fOTQ@mail.gmail.com>
References:
 <>, <CAOQ4uxjf=ig-t4GFPXzmKn1C26F3L9UAt1WKapLQ=nXbE8fOTQ@mail.gmail.com>
Date: Wed, 16 Jul 2025 13:55:03 +1000
Message-id: <175263810368.2234665.188631625272611484@noble.neil.brown.name>

On Mon, 14 Jul 2025, Amir Goldstein wrote:
> [CC vfs maintainers who were not personally CCed on your patches
> and changed the subject to focus on the topic at hand.]
>=20
> On Mon, Jul 14, 2025 at 2:13=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
> >
> > On Fri, 11 Jul 2025, Amir Goldstein wrote:
> > > On Fri, Jul 11, 2025 at 1:21=E2=80=AFAM NeilBrown <neil@brown.name> wro=
te:
> > > >
> > > > If ovl_copy_up_data() fails the error is not immediately handled but =
the
> > > > code continues on to call ovl_start_write() and lock_rename(),
> > > > presumably because both of these locks are needed for the cleanup.
> > > > On then (if the lock was successful) is the error checked.
> > > >
> > > > This makes the code a little hard to follow and could be fragile.
> > > >
> > > > This patch changes to handle the error immediately.  A new
> > > > ovl_cleanup_unlocked() is created which takes the required directory
> > > > lock (though it doesn't take the write lock on the filesystem).  This
> > > > will be used extensively in later patches.
> > > >
> > > > In general we need to check the parent is still correct after taking =
the
> > > > lock (as ovl_copy_up_workdir() does after a successful lock_rename())=
 so
> > > > that is included in ovl_cleanup_unlocked() using new lock_parent() and
> > > > unlock_parent() calls (it is planned to move this API into VFS code
> > > > eventually, though in a slightly different form).
> > >
> > > Since you are not planning to move it to VFS with this name
> > > AND since I assume you want to merge this ovl cleanup prior
> > > to the rest of of patches, please use an ovl helper without
> > > the ovl_ namespace prefix and you have a typo above
> > > its parent_lock() not lock_parent().
> >
> > I think you mean "with" rather than "without" ?
>=20
> Yeh.
>=20
> > But you separately say you would much rather this go into the VFS code
> > first.
>=20
> On second thought. no strong feeling either way.
> Using an internal ovl helper without ovl_ prefix is not good practice,
> but I can also live with that for a short while, or at the very least
> I am willing to defer the decision to the vfs maintainers.
>=20
> Pasting the helper here for context:
>=20
> > > > +
> > > > +int parent_lock(struct dentry *parent, struct dentry *child)
> > > > +{
> > > > +       inode_lock_nested(parent->d_inode, I_MUTEX_PARENT);
> > > > +       if (!child || child->d_parent =3D=3D parent)
> > > > +               return 0;
> > > > +
> > > > +       inode_unlock(parent->d_inode);
> > > > +       return -EINVAL;
> > > > +}
>=20
> FWIW, as I mentioned before, this helper could be factored out
> of the first part of lock_rename_child().
>=20
> >
> > For me a core issue is how the patches will land.  If you are happy for
> > these patches (once they are all approved of course) to land via the vfs
> > tree, then I can certainly submit the new interfaces in VFS code first,
> > then the ovl cleanups that use them.
> >
> > However I assumed that they were so substantial that you would want them
> > to land via an ovl tree.  In that case I wouldn't want to have to wait
> > for a couple of new interfaces to land in VFS before you could take the
> > cleanups.
> >
> > What process do you imagine?
> >
>=20
> Whatever process we choose is going to be collaborated with the vfs
> maintainers.
>=20
> Right now, there are a few ovl patches on Cristian's vfs-6.17.file
> branch and zero patches on overlayfs-next branch.
>=20
> What I would like to do is personally apply and test your patches
> (based on vfs-6.17.file).
>=20
> Then I will either send a PR to Christian before the merge window
> or send the PR to Linux during the merge window and after vfs-6.17.file
> PR lands.
>=20
> Within these options we have plenty of freedom to decide if we want
> to keep parent_lock/unlock internal ovl helpers or vfs helpers.
> It's really up to the vfs maintainers.

My preference is for the ovl patches to land somewhere with an
ovl_parent_lock() helper which is expected to be short-lived.
(have have today posted a new set of patches to fs-devel and elsewhere).

Then I can send patches to introduce new VFS APIs and we can have name
discussion then.  Meanwhile I'l revise my name choice based on your
input.

Thanks,
NeilBrown

>=20
> > >
> > > And apropos lock helper names, at the tip of your branch
>=20
> Reference for people who just joined:
>=20
>    https://github.com/neilbrown/linux/commits/pdirops
>=20
> > > the lock helpers used in ovl_cleanup() are named:
> > > lock_and_check_dentry()/dentry_unlock()
> > >
> > > I have multiple comments on your choice of names for those helpers:
> > > 1. Please use a consistent name pattern for lock/unlock.
> > >     The pattern <obj-or-lock-type>_{lock,unlock}_* is far more common
> > >     then the pattern lock_<obj-or-lock-type> in the kernel, but at least
> > >     be consistent with dentry_lock_and_check() or better yet
> > >     parent_lock() and later parent_lock_get_child()
> >
> > dentry_lock_and_check() does make sense - thanks.
> >
> > > 2. dentry_unlock() is a very strange name for a helper that
> > >     unlocks the parent. The fact that you document what it does
> > >     in Kernel-doc does not stop people reading the code using it
> > >     from being confused and writing bugs.
> >
> > The plan is that dentry_lookup_and_lock() will only lock the parent durin=
g a
> > short interim period.  Maybe there will be one full release where that
> > is the case.  As soon a practical (and we know this sort of large change
> > cannot move quickly) dentry_lookup_and_lock() etc will only lock the
> > dentry, not the directory.  The directory will only get locked
> > immediately before call the inode_operations - for filesystems that
> > haven't opted out.  Thus patches in my git tree don't full reflect this
> > yet (Though the hints are there are the end) but that is my current
> > plan, based on most recent feedback from Al Viro.
> >
> > > 3. Why not call it parent_unlock() like I suggested and like you
> > >     used in this patch set and why not introduce it in VFS to begin wit=
h?
> > >     For that matter parent_unlock_{put,return}_child() is more clear IM=
O.
> >
> > Because, as I say about, it is only incidentally about the parent. It is
> > primarily about the dentry.
>=20
> When you have a helper named dentry_unlock() that unlocks the
> parent inode, it's not good naming IMO.
>=20
> When you have a helper called parent_unlock_put_child()
> or dentry_put_and_unlock_parent() there is no ambiguity about
> the subject of the operations.
>=20
> >
> > > 4. The name dentry_unlock_rename(&rd) also does not balance nicely with
> > >     the name lookup_and_lock_rename(&rd) and has nothing to do with the
> > >     dentry_ prefix. How about lookup_done_and_unlock_rename(&rd)?
> >
> > The is probably my least favourite name....  I did try some "done"
> > variants (following one from done_path_create()).  But if felt it should
> > be "done_$function-that-started-this-interaction()" and that resulted in
> >    done_dentry_lookup_and_lock()
> > or similar, and having "lock" in an unlock function was weird.
> > Your "done_and_unlock" addresses this but results and long name that
> > feels clumsy to me.
> >
> > I chose the dentry_ prefix before I decided to pass the renamedata
> > around (and I'm really happy about that latter choice).  So
> > reconsidering the name is definitely appropriate.
> > Maybe  renamedata_lock() and renamedata_unlock() ???
> > renamedata_lock() can do lookups as well as locking, but maybe that is
> > implied by the presense of old_last and new_last in renamedata...
> >
>=20
> My biggest complaint was about the non balanced lock/unlock name pattern.
> renamedata_lock/unlock() is fine by me and aligns very well with existing
> lock helper name patterns.
>=20
> Thanks,
> Amir.
>=20


