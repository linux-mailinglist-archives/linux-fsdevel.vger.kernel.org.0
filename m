Return-Path: <linux-fsdevel+bounces-61979-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D8FB813CA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 19:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACA081B24904
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 17:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926F02FF650;
	Wed, 17 Sep 2025 17:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jeY/UcoJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121052FD7A4
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 17:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758131502; cv=none; b=AkSzA4VEifygB95QSd2yuDZ0eSND6+02MM34Pl3A4jWym9PPINF0/ezxqvOxEJKPAJLi4x/necFYawfc54OPJtqxOnLA+SwaoKAFvesTVbXI3p9ENK6AgWsMYko0hBOKmQtnN+TAKj4AAUm+zUmq1iIYHbWnT6T1/U2peTz706U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758131502; c=relaxed/simple;
	bh=lwYM5yV+rA8wCXcb7ym8mP3byszQ5HJdrWo5ZtcFy3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UOQ8P7GXB7zFb9k/Ow6mFtIe04UnjIL4ozmYsOm/rTw2/nD5/7b1+/fsAa3IqKezohCQj3hNNLU8CT0wDnhyYfKh/Du60GPyCYX5bOQdpiL/olaN1cprZgdGGek28NwqiZ2DCxrkJCCu6UG6wtOjnfsQdLVw5LW13Mz0xZxCVYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jeY/UcoJ; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-62598fcf41aso19412a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 10:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758131497; x=1758736297; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CVZDTplKTBkx/iNe0pd5CFw6WM06GEQXThZQXf38JJY=;
        b=jeY/UcoJpNDL7YTCpU9N5OwDJW4pIqI2bn2vQfO8dMscdsWCgZgXEK/NWv9IfjN+RG
         o/QcXSaSCDO0na3umRmMuH+KX4RVJLSebk8t6LyZiKh+k5sBk4rJ3YZYR8mqcVujhf2P
         jJIkT0Xxg3O0F01sao8K1Zcfhy0IUbO3UFvLF0v/IN8l68wRIMmQEAvdaYFpdpx2maef
         OpzAdOgkdfPr7gnMx8OnmTmaXDWPEs8pVvDXs9k4VIAtJzzJLnkwWrkOP5Qv+w7krdkF
         6+WAkVDL0mboK/Qp8Tqbxd0T6J3KHR/awQXDBFmK/ejdBEkDMG7M84jKJJDx+RuHBTJI
         0HZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758131497; x=1758736297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CVZDTplKTBkx/iNe0pd5CFw6WM06GEQXThZQXf38JJY=;
        b=GZb4Y3SLK/1DJwazoCWYEsiEyOxkz/OgJQeE0X3FSl2d/HnewdE5pIneCwWwRBxAMQ
         4b9u12tWom//p6AGI5Fpo6UP/MrFnYZ7tMRa7euCa4EzsFqNEjCN7W2oVIFyomcENibN
         32XcKl+/E0Cm6vZYDRiiyv5Tv0CgYhlDOM3/MvOmipPXrT244watQXT4yFwa2yNCaK9S
         6PQkGgT/UPfAZWUgY63T0xoAvF7+YkvUv1y8AvdkhsA4RMQmjf7ZayDEQgcIVubLog3i
         cwD00g/3JmrhPzwa95OT8UaiJ37a/jG8UaVSuPRqr8hsxl56B0XGeoWYoOeIU2dyeJ3m
         bhLg==
X-Forwarded-Encrypted: i=1; AJvYcCVvbCQbVYzi4GN1BVRRqeZanQ49IDgaM9hYNnPU3JiDsILuEeHcLR2oNDLc+tafvbrvtWLuY/7riBHxLkL+@vger.kernel.org
X-Gm-Message-State: AOJu0YwhEkdrYaJzB7RTd3jikl/f4BbI4RY1UIXw2TfOhAFNFUYoUH4G
	T2Wxl2vx/UuuKQMFPO4bTE+UlclHE6l4XcSwg9pRgE29v9Mj61/r0r4J/CbeV6D2OxfTxBvlnGa
	rLiVWebSbrNKuv63nQwwLO7WxAnD0Q+c=
X-Gm-Gg: ASbGncutVfnkGJjwQJCc8cwjzHZhTze/fxXvFvEdVzzerXcwbsqGvlnoKv7OF78lFv2
	nxqvleyORNYpUnRZyNnFo2EzpFu4Sf2EA2FbyCpXa6M2I73csKdYnz5Iw0u04rP9pApwv0ZQ9zT
	MVjPQkVyAHeovSqfevviiAK15Feok0NV94TkttCjc2e29F4wEpEtOc6LqBjw1hGrGp95uoTg62S
	cZzQhjKGci/NK6Nu88RS9/C1ntslXPxnzhToegc8A==
X-Google-Smtp-Source: AGHT+IFBitHHZOm1SStov4xyx1baTGuGAeg2VFBG8U3v3irN5gQcpUPB5uPmFXlYFhQzJGoh9IGLkQr9RLMPHgimrHE=
X-Received: by 2002:a05:6402:35d5:b0:62f:5995:3c4d with SMTP id
 4fb4d7f45d1cf-62f8422e360mr3087992a12.17.1758131497093; Wed, 17 Sep 2025
 10:51:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915101510.7994-1-acsjakub@amazon.de> <CAOQ4uxgXvwumYvJm3cLDFfx-TsU3g5-yVsTiG=6i8KS48dn0mQ@mail.gmail.com>
 <x4q65t5ar5bskvinirqjbrs4btoqvvvdsce2bdygoe33fnwdtm@eqxfv357dyke>
 <CAOQ4uxhbDwhb+2Brs1UdkoF0a3NSdBAOQPNfEHjahrgoKJpLEw@mail.gmail.com>
 <gdovf4egsaqighoig3xg4r2ddwthk2rujenkloqep5kdub75d4@7wkvfnp4xlxx>
 <CAOQ4uxhOMcaVupVVGXV2Srz_pAG+BzDc9Gb4hFdwKUtk45QypQ@mail.gmail.com>
 <scmyycf2trich22v25s6gpe3ib6ejawflwf76znxg7sedqablp@ejfycd34xvpa>
 <CAOQ4uxgSQPQ6Vx4MLECPPxn35m8--1iL7_rUFEobBuROfEzq_A@mail.gmail.com> <3gpfceywinbzsbgslwsywzv4qqubab6gcftlzag6drhl5vhmb6@iupru3v7wsey>
In-Reply-To: <3gpfceywinbzsbgslwsywzv4qqubab6gcftlzag6drhl5vhmb6@iupru3v7wsey>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 17 Sep 2025 19:51:25 +0200
X-Gm-Features: AS18NWDBsJ4C82gViL9mSQEzTDPfB5F8ZVO8437bScWXIr45-5HTnQQRw5MMdjI
Message-ID: <CAOQ4uxg6w1JDE9ERChC80kkGsTSTx4rAj5b_ro7tNKmpQ29osA@mail.gmail.com>
Subject: Re: [PATCH] ovl: check before dereferencing s_root field
To: Jan Kara <jack@suse.cz>
Cc: Jakub Acs <acsjakub@amazon.de>, linux-unionfs@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 4:42=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 17-09-25 13:07:45, Amir Goldstein wrote:
> > On Wed, Sep 17, 2025 at 11:25=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
> > > On Tue 16-09-25 15:29:35, Amir Goldstein wrote:
> > > > On Tue, Sep 16, 2025 at 1:30=E2=80=AFPM Jan Kara <jack@suse.cz> wro=
te:
> > > > >
> > > > > On Mon 15-09-25 17:29:40, Amir Goldstein wrote:
> > > > > > On Mon, Sep 15, 2025 at 4:07=E2=80=AFPM Jan Kara <jack@suse.cz>=
 wrote:
> > > > > > > > > diff --git a/fs/overlayfs/export.c b/fs/overlayfs/export.=
c
> > > > > > > > > index 83f80fdb1567..424c73188e06 100644
> > > > > > > > > --- a/fs/overlayfs/export.c
> > > > > > > > > +++ b/fs/overlayfs/export.c
> > > > > > > > > @@ -195,6 +195,8 @@ static int ovl_check_encode_origin(st=
ruct inode *inode)
> > > > > > > > >         if (!ovl_inode_lower(inode))
> > > > > > > > >                 return 0;
> > > > > > > > >
> > > > > > > > > +       if (!inode->i_sb->s_root)
> > > > > > > > > +               return -ENOENT;
> > > > > > > >
> > > > > > > > For a filesystem method to have to check that its own root =
is still alive sounds
> > > > > > > > like the wrong way to me.
> > > > > > > > That's one of the things that should be taken for granted b=
y fs code.
> > > > > > > >
> > > > > > > > I don't think this is an overlayfs specific issue, because =
other fs would be
> > > > > > > > happy if encode_fh() would be called with NULL sb->s_root.
> > > > > > >
> > > > > > > Actually, I don't see where that would blow up? Generally ref=
erences to
> > > > > > > sb->s_root in filesystems outside of mount / remount code are=
 pretty rare.
> > > > > > > Also most of the code should be unreachable by the time we se=
t sb->s_root
> > > > > > > to NULL because there are no open files at that moment, no ex=
ports etc. But
> > > > > > > as this report shows, there are occasional surprises (I remem=
ber similar
> > > > > > > issue with ext4 sysfs files handlers using s_root without che=
cking couple
> > > > > > > years back).
> > > > > > >
> > > > > >
> > > > > > I am not sure that I understand what you are arguing for.
> > > > > > I did a very naive grep s_root fs/*/export.c and quickly found:
> > > > >
> > > > > You're better with grep than me ;). I was grepping for '->s_root'=
 as well
> > > > > but all the hits I had looked into were related to mounting and s=
imilar and
> > > > > eventually I got bored. Restricting the grep to export ops indeed=
 shows
> > > > > ceph, gfs2 and overlayfs are vulnerable to this kind of problem.
> >
> > As far as I can tell, ceph uses s_root only in decode_fh methods.
>
> True. But ceph also uses d_find_alias() in ceph_encode_snapfh() which cou=
ld
> race with shrink_dcache_for_umount()->do_one_tree() and trigger:
>
>         WARN(1, "BUG: Dentry %p{i=3D%lx,n=3D%pd} "
>                         " still in use (%d) [unmount of %s %s]\n",
>
> > ovl and gfs2 only want to know for an inode if it is the root inode,
> > they do not strictly need to dereference s_root for that purpose.
> > (see patch below)
> >
> > > So there are not many cases where this can happen but enough that I'd=
 say
> > > that handling some events specially to avoid encoding fh on fs while =
it is
> > > unmounted is fragile and prone to breaking again sooner or later.
> > >
> > > > How about skipping fsnotify_inoderemove() in case sb is in shutdown=
?
> > >
> > > Also how would you like to handle that in a race-free manner? We'd ne=
ed to
> > > hold s_umount for that which we cannot really afford in that context.=
 But
> > > maybe you have some better idea...
> > >
> >
> > I was only thinking about this code path:
> >
> > generic_shutdown_super()
> >   shrink_dcache_for_umount()
> >     ...
> >       __dentry_kill()
> >         dentry_unlink_inode()
> >
> > This is supposed to be the last dput of all remaining dentries
> > and I don't think a deferred unlink should be expected in that case.
>
> I see.
>
> > But I realize now that you mean delayed unlink from another context
> > which races with shutdown.
>
> Yes, I've meant that.
>
> > > > > > > > Can we change the order of generic_shutdown_super() so that
> > > > > > > > fsnotify_sb_delete(sb) is called before setting s_root to N=
ULL?
> > > > > > > >
> > > > > > > > Or is there a better solution for this race?
> > > > > > >
> > > > > > > Regarding calling fsnotify_sb_delete() before setting s_root =
to NULL:
> > > > > > > In 2019 (commit 1edc8eb2e9313 ("fs: call fsnotify_sb_delete a=
fter
> > > > > > > evict_inodes")) we've moved the call after evict_inodes() bec=
ause otherwise
> > > > > > > we were just wasting cycles scanning many inodes without watc=
hes. So moving
> > > > > > > it earlier wouldn't be great...
> > > > > >
> > > > > > Yes, I noticed that and I figured there were subtleties.
> > > > >
> > > > > Right. After thinking more about it I think calling fsnotify_sb_d=
elete()
> > > > > earlier is the only practical choice we have (not clearing sb->s_=
root isn't
> > > > > much of an option - we need to prune all dentries to quiesce the =
filesystem
> > > > > and leaving s_root alive would create odd corner cases). But you =
don't want
> > > > > to be iterating millions of inodes just to clear couple of marks =
so we'll
> > > > > have to figure out something more clever there.
> > > >
> > > > I think we only need to suppress the fsnotify_inoderemove() call.
> > > > It sounds doable and very local to fs/super.c.
> > > >
> > > > Regarding show_mark_fhandle() WDYT about my suggestion to
> > > > guard it with super_trylock_shared()?
> > >
> > > Yes, super_trylock_shared() for that callsite looks like a fine solut=
ion
> > > for that call site. Occasional random failures in encoding fh because=
 the
> > > trylock fails are unlikely to have any bad consequences there. But I =
think
> > > we need to figure out other possibly racing call-sites as well first.
> > >
> >
> > Might something naive as this be enough?
>
> It looks like it should be good for the problems with gfs2 & overlayfs bu=
t
> it doesn't solve the problem with ceph and as Jakub writes there's a ques=
tion
> whether we won't hit more problems later.
>
> I'm sorry for poking holes into your solutions. The more I look into this
> the more problems I find :-|
>

On the contrary, Thank you for shooting down my bad ideas ;)

> As I'm thinking about it I'm slowly leaning towards implementing a list o=
f
> connectors per sb (so that we can quickly reclaim on umount). It seems
> stupid just for these corner cases but longer term we can also implement
> what Dave once suggested [1] so that fsnotify doesn't need to pin inodes =
in
> memory at all which should more that make up for the additional memory fo=
r
> inode connector members.
>
>                                                                 Honza
>
> [1] https://lore.kernel.org/linux-fsdevel/ZwXDzKGj6Bp28kYe@dread.disaster=
.area/
>

Interesting.
I'll wait for you to think this over.
If you think that it might take some time, maybe we should
apply the super_trylock_shared() band aid to show_mark_fhandle()
in the meantime. Whatever you think is right.

Thanks,
Amir.

