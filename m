Return-Path: <linux-fsdevel+bounces-36904-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B8E9EAD26
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 10:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E41A16C2E3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 09:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D59225404;
	Tue, 10 Dec 2024 09:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bVF9l3e2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431F82153FB
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Dec 2024 09:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733824144; cv=none; b=HRH08E/IeaNdQ+tHjfwrLvrWkbIxJGgvNde+5yFTU3/0/u0cKvhmPDEqjZbXNIFEcvPGrLKdLPj8TJoGNN2bAoxHtrWPVxZyjKoEsOys+RD9uZL+zp/IkbysAzLjXY8Sbu5qIBC2Ny8BaRiOn4QlopyRZ+0yU1HYUnwM7ZwaSMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733824144; c=relaxed/simple;
	bh=WzweS7R3UqleqI/Pn2SAaQgtvrKVcw3r/aOsjEp0l/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P4TuG8iJANHh+e5mS8YlX5O50utjCHEn23MLhAiGd0sjcQBQBBEQMKVS7uG0R8UjQ1XWmdbgJxW21w8i8HpcbUs+TKkVvNw0LABG2WT5wGJ8NrMR2buJhG6mNCPM9rcaQ4AuhgLFpexOcVtVDjs5/Z8c238UR03oyJIEbUZaUh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bVF9l3e2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BB36C4CED6;
	Tue, 10 Dec 2024 09:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733824143;
	bh=WzweS7R3UqleqI/Pn2SAaQgtvrKVcw3r/aOsjEp0l/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bVF9l3e2pn3DBjbxnLO0jnzSy0kMwDpMb7wsvB4X+p8NmJnQjxM6gKvaI0hKmZEng
	 L7Uk4PKeKB6IA44s9+z6xpCZCpG5fR5xDT1VnUKiWjSb49Lje6at4TuJaSwJHkIKDi
	 uMHW7HAbf04y2zXfo+fFiXdbynk7Kb+xr/jq4Vtr7lSqJTnIeHxlfCNNAPKogfoAip
	 k5n+UZxllbJHIG3J+UF3WTr5vYfp+pL51ysEdksS6it20K4cuobgLFAPmTP/ootttr
	 Z1NA9MLLI+5S3wKbOihR5+JdVEDArveaKtQm5KANkh+pkJLvjoEPLcB4OmVL0aQec4
	 GoyBPW/kqrXSA==
Date: Tue, 10 Dec 2024 10:48:58 +0100
From: Christian Brauner <brauner@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, Karel Zak <kzak@redhat.com>, 
	Lennart Poettering <lennart@poettering.net>, Ian Kent <raven@themaw.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2] fanotify: notify on mount attach and detach
Message-ID: <20241210-symbol-komplett-37300fc8ce5c@brauner>
References: <20241206151154.60538-1-mszeredi@redhat.com>
 <20241207-zucken-bogen-7a3d015af168@brauner>
 <CAJfpegtdtKgA+JQY7q-bj0YkCaROQ7BRrJr+4ro16RWbcuD7Gg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpegtdtKgA+JQY7q-bj0YkCaROQ7BRrJr+4ro16RWbcuD7Gg@mail.gmail.com>

On Mon, Dec 09, 2024 at 06:02:06PM +0100, Miklos Szeredi wrote:
> On Sun, 8 Dec 2024 at 22:26, Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Fri, Dec 06, 2024 at 04:11:52PM +0100, Miklos Szeredi wrote:
> 
> > I wanted to see how feasible this would be and so I've added my changes
> > on top of your patch. Please see the appended UNTESTED DIFF.
> 
> Why a separate list for connected unmounts and for mounts?  Can't the
> same list be used for both?

Yes, they sure can. I was just being overly explicit.

> 
> > > +static void mnt_add_to_ns(struct mnt_namespace *ns, struct mount *mnt, struct list_head *notif)
> > > +{
> > > +     __mnt_add_to_ns(ns, mnt);
> > > +     queue_notify(ns, mnt, notif);
> >
> > All but one call to mnt_add_to_ns() passes NULL. I would just add a
> > mnt_add_to_ns_notify() helper and leave all the other callers as is.
> 
> Still need the else branch from queue_notify() otherwise the prev_ns
> logic breaks.

Yep.

> 
> >
> > >  void dissolve_on_fput(struct vfsmount *mnt)
> > >  {
> > >       struct mnt_namespace *ns;
> > > +     LIST_HEAD(notif);
> > > +
> > >       namespace_lock();
> > >       lock_mount_hash();
> > >       ns = real_mount(mnt)->mnt_ns;
> > >       if (ns) {
> > >               if (is_anon_ns(ns))
> > > -                     umount_tree(real_mount(mnt), UMOUNT_CONNECTED);
> > > +                     umount_tree(real_mount(mnt), &notif, UMOUNT_CONNECTED);
> >
> > This shouldn't notify as it's currently impossible to place mark on an
> > anonymous mount.
> 
> Yeah, I was first undecided whether to allow notification on anon
> namespaces, but then opted not to for simplicity.
> 
> > > @@ -1855,8 +1906,18 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
> > >               mnt = path.mnt;
> > >               if (mark_type == FAN_MARK_MOUNT)
> > >                       obj = mnt;
> > > -             else
> > > +             else if (mark_type == FAN_MARK_FILESYSTEM)
> > >                       obj = mnt->mnt_sb;
> > > +             else /* if (mark_type == FAN_MARK_MNTNS) */ {
> > > +                     mntns = get_ns_from_mnt(mnt);
> >
> > I would prefer to be strict here and require that an actual mount
> > namespace file descriptor is passed instead of allowing the mount
> > namespace to be derived from any file descriptor.
> 
> Okay.
> 
> >
> > > +                     ret = -EINVAL;
> > > +                     if (!mntns)
> > > +                             goto path_put_and_out;
> > > +                     /* don't allow anon ns yet */
> > > +                     if (is_anon_ns(mntns))
> > > +                             goto path_put_and_out;
> >
> > Watching an anoymous mount namespace doesn't yet make sense because you
> > currently cannot add or remove mounts in them apart from closing the
> > file descriptor and destroying the whole mount namespace. I just
> > remember that I have a pending patch series related to this comment. I
> > haven't had the time to finish it with tests yet though maybe I can find
> > a few days in December to finish the tests...
> 
> Okay.
> 
> >
> > > @@ -549,8 +549,10 @@ static void restore_mounts(struct list_head *to_restore)
> > >                       mp = parent->mnt_mp;
> > >                       parent = parent->mnt_parent;
> > >               }
> > > -             if (parent != mnt->mnt_parent)
> > > +             if (parent != mnt->mnt_parent) {
> > > +                     /* FIXME: does this need to trigger a MOVE fsnotify event */
> > >                       mnt_change_mountpoint(parent, mp, mnt);
> >
> > This is what I mentally always referred to as "rug-pulling umount
> > propagation". So basically for the case where we have a locked mount
> > (stuff that was overmounted when the mntns was created) or a mount with
> > children that aren't going/can't be unmounted. In both cases it's
> > necessary to reparent the mount.
> >
> > The watcher will see a umount event for the parent of that mount but
> > that's not enough information because the watcher could end up infering
> > that all child mounts of the mount have vanished as well which is
> > obviously not the case.
> >
> > So I think that we need to generate a FS_MNT_MOVE event for mounts that
> > got reparented.
> 
> Yep.
> 
> Thanks,
> Miklos

