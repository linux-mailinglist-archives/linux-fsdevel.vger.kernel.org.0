Return-Path: <linux-fsdevel+bounces-54802-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C31ACB0362E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 07:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD3D8189AFCE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 05:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F307226CF1;
	Mon, 14 Jul 2025 05:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dk2qIZme"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8775B1EFF9B;
	Mon, 14 Jul 2025 05:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752471765; cv=none; b=pmNEkrfzFWZa7Nabb8KZsHhIMzShUCN8FwgE/qaODXjfONCpM8mJifF/nEuiQbPl3lRCdOhf4U3No9RNoTSVPNUD4rIH+NR3w9vdyiwRsBIIbIihOGgl4jR7WZwzm6R4zlQhbGa2WRPswQSd+Acf07nNOmVISGAcMowzRfj5/TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752471765; c=relaxed/simple;
	bh=RT0pp7iFDoxCUwPaOyuV44gIHWNJekmnqvt3HmpQ0zA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H4Ak6GiC1Aj5N1x0dkBsS0IDXELSdaHwFOMtd/5eVBgm+qNFVV/va22ytqyLAcFglAA1H1NN4aMIyNOSJ4ijfzzB1iOtKVtyZXO4NIOJ018Imxyk1QkCyn+0HpqZASVYZNmFsnBDubZC27lm2nthFEDl+ULMzytuBlDjNUrZ7Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dk2qIZme; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ad572ba1347so538247066b.1;
        Sun, 13 Jul 2025 22:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752471762; x=1753076562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IN51k3PG7P1PxKfyDC1D6YDwvqOFAxcGIBO3H1d/nuA=;
        b=Dk2qIZmeVjAL5I30ANB+Ul6GWg532+ntWXwJrw2eE8cGQWh7q8DduRQGmHTGtwnZYV
         LAbOyJ5s4brzT0ytxKOqSDKSzUtNxDBPVmFe6mAXILTvg72QD1PE2u5LNsFGTHJRgHqa
         0jCPtY8NjQ2DwGuNou35YQraE7qy1EOH2OYpwJf7yknnJa2xvu+29YYXH3ZRcxjedxE6
         5+qxaPKwLVsa5VbMjY9lt+5oChctH5FL6fefZogxGLHFAQ/F2LXTcjsnTvPs09UnjU0+
         bnSuFhWmw2B8cUjg4N7MhrYhiLROC/m/ZImL22/W6KKeXzuHcc6iM5fKYdSn8MtHbfyF
         V3HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752471762; x=1753076562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IN51k3PG7P1PxKfyDC1D6YDwvqOFAxcGIBO3H1d/nuA=;
        b=jwC8IBDoIyjDGz/htQXeSe5O7pathq2Bjc6wcnZ8ikGcSEEep00Yz2mIi7E23KpMyr
         GOSohPu5EyOppz8eh99aYSuJlUZS+uK+Y34vydP5lDWznTvZ20ZnLhom9BBWI2ybaM+q
         4gVfKKLj+HjH5KR2Do4SD+QZabOK9YODnsOTekyR3REjqAYOqL4YbL7xsYUswO+xAzHb
         ZAyNRTNBD8Fa0p8oAUDPHACtPnmucl0GXJoC96SvwwO0RYTAcOKiYIzzP+bL4CRjd+zR
         VpI5wlsJVCRL/cYmqHqAsYjeT01nReOKhEGKsVTsMe0UQzWv1tkRip+otIog/4BrlEoC
         b6RQ==
X-Forwarded-Encrypted: i=1; AJvYcCUljYqoNBL9Um0l7ZgSM4CW5wzejpmUqjMOdHiTwYbiBkDsFZ3kYpJdMr+c7Crnn7t7B/qSkBVpnDJmiGSw@vger.kernel.org, AJvYcCWPjSV5iTyYcxGuEvnfMYww+dOrwRulgUTClMJYQrh3z6GgK4tM4ENv1KCg56g2uTb6tv/DEMRnqVWsdzbL/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxaVJtDmJ5UiWs657cDw4KjeLtTWXUuXV9hU0au4wHqZOqlGsWN
	OjGa57VnWx7fkQ5OQCW77Ad7gqbMe0j9hSogndW9/P9HWh9z2AFDG8DTwuxLXM5VSSxwbBlSWlx
	n38nB/B/lBMunZV8HCnebt4o8JPulSn4=
X-Gm-Gg: ASbGncttWMX+0qonVOgyXtymwvPrsFQa9YW9EHEDVJYalIOoOxbj6dyGgXbjC7AbMrS
	uuRqrpq0kmJv7xJrNoppE9OGv9o2bIn2lMXoC35j0GG6OZTThnCu0Nyb1FN2W/Muxsx9qtMYP4K
	G/31KGMV+tvnPjEf9f2D2crmylvZozD0mAcoBDNxMditukhwsaWSiJ2nDW+NCM0Sd7I4L4TFPfy
	6Mg3W4=
X-Google-Smtp-Source: AGHT+IF0NgrPv+wmrzyAGg8A04hpjzuc+YNcIgh/JfG9JoS988gB4qYFs7ce7ZRs/sGGJyysOtMIHyI9mzXGG9z+ImU=
X-Received: by 2002:a17:906:c14b:b0:ae3:d108:afa with SMTP id
 a640c23a62f3a-ae6fcacc9bbmr1096111466b.45.1752471761242; Sun, 13 Jul 2025
 22:42:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQ4uxh6fb6GQcC0_mj=Ft5NbLco7Nb0brhn9d3f7LzMLkRYaw@mail.gmail.com>
 <175245198838.2234665.15268828706322164079@noble.neil.brown.name>
In-Reply-To: <175245198838.2234665.15268828706322164079@noble.neil.brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 14 Jul 2025 07:42:30 +0200
X-Gm-Features: Ac12FXy4Kd3GNjyQqz3oWyiBROvmU0sSUqzQzKXkeOJ7TZQhJNSO9t1JehjcjVQ
Message-ID: <CAOQ4uxjf=ig-t4GFPXzmKn1C26F3L9UAt1WKapLQ=nXbE8fOTQ@mail.gmail.com>
Subject: Re: parent_lock/unlock (Was: [PATCH 01/20] ovl: simplify an error
 path in ovl_copy_up_workdir())
To: NeilBrown <neil@brown.name>, Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, overlayfs <linux-unionfs@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[CC vfs maintainers who were not personally CCed on your patches
and changed the subject to focus on the topic at hand.]

On Mon, Jul 14, 2025 at 2:13=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
>
> On Fri, 11 Jul 2025, Amir Goldstein wrote:
> > On Fri, Jul 11, 2025 at 1:21=E2=80=AFAM NeilBrown <neil@brown.name> wro=
te:
> > >
> > > If ovl_copy_up_data() fails the error is not immediately handled but =
the
> > > code continues on to call ovl_start_write() and lock_rename(),
> > > presumably because both of these locks are needed for the cleanup.
> > > On then (if the lock was successful) is the error checked.
> > >
> > > This makes the code a little hard to follow and could be fragile.
> > >
> > > This patch changes to handle the error immediately.  A new
> > > ovl_cleanup_unlocked() is created which takes the required directory
> > > lock (though it doesn't take the write lock on the filesystem).  This
> > > will be used extensively in later patches.
> > >
> > > In general we need to check the parent is still correct after taking =
the
> > > lock (as ovl_copy_up_workdir() does after a successful lock_rename())=
 so
> > > that is included in ovl_cleanup_unlocked() using new lock_parent() an=
d
> > > unlock_parent() calls (it is planned to move this API into VFS code
> > > eventually, though in a slightly different form).
> >
> > Since you are not planning to move it to VFS with this name
> > AND since I assume you want to merge this ovl cleanup prior
> > to the rest of of patches, please use an ovl helper without
> > the ovl_ namespace prefix and you have a typo above
> > its parent_lock() not lock_parent().
>
> I think you mean "with" rather than "without" ?

Yeh.

> But you separately say you would much rather this go into the VFS code
> first.

On second thought. no strong feeling either way.
Using an internal ovl helper without ovl_ prefix is not good practice,
but I can also live with that for a short while, or at the very least
I am willing to defer the decision to the vfs maintainers.

Pasting the helper here for context:

> > > +
> > > +int parent_lock(struct dentry *parent, struct dentry *child)
> > > +{
> > > +       inode_lock_nested(parent->d_inode, I_MUTEX_PARENT);
> > > +       if (!child || child->d_parent =3D=3D parent)
> > > +               return 0;
> > > +
> > > +       inode_unlock(parent->d_inode);
> > > +       return -EINVAL;
> > > +}

FWIW, as I mentioned before, this helper could be factored out
of the first part of lock_rename_child().

>
> For me a core issue is how the patches will land.  If you are happy for
> these patches (once they are all approved of course) to land via the vfs
> tree, then I can certainly submit the new interfaces in VFS code first,
> then the ovl cleanups that use them.
>
> However I assumed that they were so substantial that you would want them
> to land via an ovl tree.  In that case I wouldn't want to have to wait
> for a couple of new interfaces to land in VFS before you could take the
> cleanups.
>
> What process do you imagine?
>

Whatever process we choose is going to be collaborated with the vfs
maintainers.

Right now, there are a few ovl patches on Cristian's vfs-6.17.file
branch and zero patches on overlayfs-next branch.

What I would like to do is personally apply and test your patches
(based on vfs-6.17.file).

Then I will either send a PR to Christian before the merge window
or send the PR to Linux during the merge window and after vfs-6.17.file
PR lands.

Within these options we have plenty of freedom to decide if we want
to keep parent_lock/unlock internal ovl helpers or vfs helpers.
It's really up to the vfs maintainers.

> >
> > And apropos lock helper names, at the tip of your branch

Reference for people who just joined:

   https://github.com/neilbrown/linux/commits/pdirops

> > the lock helpers used in ovl_cleanup() are named:
> > lock_and_check_dentry()/dentry_unlock()
> >
> > I have multiple comments on your choice of names for those helpers:
> > 1. Please use a consistent name pattern for lock/unlock.
> >     The pattern <obj-or-lock-type>_{lock,unlock}_* is far more common
> >     then the pattern lock_<obj-or-lock-type> in the kernel, but at leas=
t
> >     be consistent with dentry_lock_and_check() or better yet
> >     parent_lock() and later parent_lock_get_child()
>
> dentry_lock_and_check() does make sense - thanks.
>
> > 2. dentry_unlock() is a very strange name for a helper that
> >     unlocks the parent. The fact that you document what it does
> >     in Kernel-doc does not stop people reading the code using it
> >     from being confused and writing bugs.
>
> The plan is that dentry_lookup_and_lock() will only lock the parent durin=
g a
> short interim period.  Maybe there will be one full release where that
> is the case.  As soon a practical (and we know this sort of large change
> cannot move quickly) dentry_lookup_and_lock() etc will only lock the
> dentry, not the directory.  The directory will only get locked
> immediately before call the inode_operations - for filesystems that
> haven't opted out.  Thus patches in my git tree don't full reflect this
> yet (Though the hints are there are the end) but that is my current
> plan, based on most recent feedback from Al Viro.
>
> > 3. Why not call it parent_unlock() like I suggested and like you
> >     used in this patch set and why not introduce it in VFS to begin wit=
h?
> >     For that matter parent_unlock_{put,return}_child() is more clear IM=
O.
>
> Because, as I say about, it is only incidentally about the parent. It is
> primarily about the dentry.

When you have a helper named dentry_unlock() that unlocks the
parent inode, it's not good naming IMO.

When you have a helper called parent_unlock_put_child()
or dentry_put_and_unlock_parent() there is no ambiguity about
the subject of the operations.

>
> > 4. The name dentry_unlock_rename(&rd) also does not balance nicely with
> >     the name lookup_and_lock_rename(&rd) and has nothing to do with the
> >     dentry_ prefix. How about lookup_done_and_unlock_rename(&rd)?
>
> The is probably my least favourite name....  I did try some "done"
> variants (following one from done_path_create()).  But if felt it should
> be "done_$function-that-started-this-interaction()" and that resulted in
>    done_dentry_lookup_and_lock()
> or similar, and having "lock" in an unlock function was weird.
> Your "done_and_unlock" addresses this but results and long name that
> feels clumsy to me.
>
> I chose the dentry_ prefix before I decided to pass the renamedata
> around (and I'm really happy about that latter choice).  So
> reconsidering the name is definitely appropriate.
> Maybe  renamedata_lock() and renamedata_unlock() ???
> renamedata_lock() can do lookups as well as locking, but maybe that is
> implied by the presense of old_last and new_last in renamedata...
>

My biggest complaint was about the non balanced lock/unlock name pattern.
renamedata_lock/unlock() is fine by me and aligns very well with existing
lock helper name patterns.

Thanks,
Amir.

