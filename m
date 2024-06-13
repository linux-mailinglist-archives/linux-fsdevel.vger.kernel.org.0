Return-Path: <linux-fsdevel+bounces-21605-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3582906555
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 09:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 056D71C22EF7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 07:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4442513C3FC;
	Thu, 13 Jun 2024 07:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRWxTdej"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294BA136997;
	Thu, 13 Jun 2024 07:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718264341; cv=none; b=TTivP3ZHbsgt1afQFIyA2fHRgSwgpRDnMplK41cBXtJTQrglZkJfsyH1n8Gyv87GB1QUB2GRa2efH97wTVdADnnNn0Z9FdI8VmtuiIdpT8Xk82mLreOsw92wxFNFYngcPLi76X+ythbm76dsE3tbjr3s6/w11fU5LDcWlgu6QOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718264341; c=relaxed/simple;
	bh=dvG7FqSwDu5lrIi/fqvjZ/j9B9W5Iep3sa2oGhXDAWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BoeFvLAgBNQwRKauiTrCpZBm3OyYuTbXyvRwGBZxmYFp1uuKW8Y20DtfuRAfA898ETyLOPMm551E2ZLP9D/bmlAFkPBooqjGuYGB1d13d4KvyTrx7Hd0eOp0Bo2ag3oXydofO3rrPLqLmkYsMcQ9kB47io6ovD1rXscZgN+BLuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nRWxTdej; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6b065d12e81so3859576d6.0;
        Thu, 13 Jun 2024 00:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718264339; x=1718869139; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1E6AzK51xf6iKhcHDUiW9xjjWQsQmJ90eNQKU5H/LL0=;
        b=nRWxTdejPPnpF7GoeT5OXx99M+wgZW3ORtwhybCbrGa5+1ugeAaoCizNj0MPT2O7fa
         EWvy1dabOi/lDtWwrjikJ1QwEH73OaPurEnAXAqZjRt/lkyN/V5jDZKrZPT2E44qBqfW
         qAv7dVjYhKPib/YiZFFHU9pX46udXphC363nVjyFxdBLPFjB5AOyeVfT7cR17PfTDAeA
         aLlUDenFnEnh1VWyh8/ZFBExnSJfnHZqHwT3KBokxqbd+sZShC7sO6s9r94d8HQlrjiA
         vOGj7JI0YWBzhAH+oVsGnEIFyQ9S98ex0jETCLfjEhyHVk/BUn8o1mmniXRGp/quidoL
         5RCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718264339; x=1718869139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1E6AzK51xf6iKhcHDUiW9xjjWQsQmJ90eNQKU5H/LL0=;
        b=bizUsJr0TEwJyQ8wJJE89DUmeoWbhod26YvtdadRvaIPEhwEwdnDYz+vUwZ/BfuhwI
         AWF/CSHWJmFKljdmsYv1BahMDEzdux2HGAXi+hXkXrv9FBUxrye4z9RP8I3sibmPt0Nj
         p8WS1FuhVI+Psm4+SiDdGYycpnQMyUNRxHVPl4FH4ticcDIi1VtVmSQZwLph70C0usxe
         hsBQiC7BbivFK/DHZtE4B/l6EF3kfJq3G0McIWsC2fvvWKfkb9r73Kqy7k+dEO2BFk2v
         IrfNfnK+5gQfZtnLhVZAzt9VlVg2gSgvIIk05tHgZlKaYgBP4Oqn85ipRqZnbOjXw+Aa
         2Z8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVOF9H1dazz6lYL9aDm/QsESdq0Hviy3IrRZM1sMKlZd6uUJE3bwgihYKphJd1hQ8uuD381Y2F0mPjv7EZ7JxdejXGnH/zbgFbd/0vZ3i34CCZF81x+jn1W/0OWBqQGbyinE6PoH580yWDGMAfV0qG9cDyneqMk0hnLbo6ycNYlsbqaW1Pi+g==
X-Gm-Message-State: AOJu0YzTAFMqj8BB6EdUOc8XrRIhPUd2Sxy6eih88BaAbeRPmEHDtt2y
	ybT+ciRr7XPeIsGANzwKLqFZ5OOZ0j/2JrLdP+YSNERKZQBAUG+ojCOtnsdy1M/OAuh3w9FGdN0
	8lFHQ9CjrgOe9sj+LC23sUBopJWQ=
X-Google-Smtp-Source: AGHT+IHVzT36nvZbeajaCGP82pKfL+ox3iyFWA+hBahWjErp+dD2xAJfXvYA0YrMJktsuFxVdiilx5R2GTaOGm2z8dI=
X-Received: by 2002:a05:6214:3282:b0:6b0:7327:c45b with SMTP id
 6a1803df08f44-6b191c50ed9mr28334476d6.16.1718264338926; Thu, 13 Jun 2024
 00:38:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171817619547.14261.975798725161704336@noble.neil.brown.name>
 <CAOQ4uxidUYY02xry+y5VpRWfBjCmAt0CnmJ3JbgLTLkZ6nn1sA@mail.gmail.com> <171819286884.14261.11045203598673536466@noble.neil.brown.name>
In-Reply-To: <171819286884.14261.11045203598673536466@noble.neil.brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 13 Jun 2024 10:38:47 +0300
Message-ID: <CAOQ4uxh357o5H-PQK9KY949s5pg_aaH9nMd-NzMAu_kx0WCn1Q@mail.gmail.com>
Subject: Re: [PATCH v2] VFS: generate FS_CREATE before FS_OPEN when
 ->atomic_open used.
To: NeilBrown <neilb@suse.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	James Clark <james.clark@arm.com>, ltp@lists.linux.it, linux-nfs@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 2:47=E2=80=AFPM NeilBrown <neilb@suse.de> wrote:
>
> On Wed, 12 Jun 2024, Amir Goldstein wrote:
> > On Wed, Jun 12, 2024 at 10:10=E2=80=AFAM NeilBrown <neilb@suse.de> wrot=
e:
> > >
> > >
> > > When a file is opened and created with open(..., O_CREAT) we get
> > > both the CREATE and OPEN fsnotify events and would expect them in tha=
t
> > > order.   For most filesystems we get them in that order because
> > > open_last_lookups() calls fsnofify_create() and then do_open() (from
> > > path_openat()) calls vfs_open()->do_dentry_open() which calls
> > > fsnotify_open().
> > >
> > > However when ->atomic_open is used, the
> > >    do_dentry_open() -> fsnotify_open()
> > > call happens from finish_open() which is called from the ->atomic_ope=
n
> > > handler in lookup_open() which is called *before* open_last_lookups()
> > > calls fsnotify_create.  So we get the "open" notification before
> > > "create" - which is backwards.  ltp testcase inotify02 tests this and
> > > reports the inconsistency.
> > >
> > > This patch lifts the fsnotify_open() call out of do_dentry_open() and
> > > places it higher up the call stack.  There are three callers of
> > > do_dentry_open().
> > >
> > > For vfs_open() and kernel_file_open() the fsnotify_open() is placed
> > > directly in that caller so there should be no behavioural change.
> > >
> > > For finish_open() there are two cases:
> > >  - finish_open is used in ->atomic_open handlers.  For these we add a
> > >    call to fsnotify_open() at the top of do_open() if FMODE_OPENED is
> > >    set - which means do_dentry_open() has been called.
> > >  - finish_open is used in ->tmpfile() handlers.  For these a similar
> > >    call to fsnotify_open() is added to vfs_tmpfile()
> >
> > Any handlers other than ovl_tmpfile()?
>
> Local filesystems tend to call finish_open_simple() which is a trivial
> wrapper around finish_open().
> Every .tmpfile handler calls either finish_open() or finish_open_simple()=
.
>
> > This one is a very recent and pretty special case.
> > Did open(O_TMPFILE) used to emit an OPEN event before that change?
>
> I believe so, yes.
>

Right. Thanks for clarifying.

> Thanks,
> NeilBrown
>
> >
> > >
> > > With this patch NFSv3 is restored to its previous behaviour (before
> > > ->atomic_open support was added) of generating CREATE notifications
> > > before OPEN, and NFSv4 now has that same correct ordering that is has
> > > not had before.  I haven't tested other filesystems.
> > >
> > > Fixes: 7c6c5249f061 ("NFS: add atomic_open for NFSv3 to handle O_TRUN=
C correctly.")
> > > Reported-by: James Clark <james.clark@arm.com>
> > > Closes: https://lore.kernel.org/all/01c3bf2e-eb1f-4b7f-a54f-d2a05dd3d=
8c8@arm.com
> > > Signed-off-by: NeilBrown <neilb@suse.de>
> > > ---
> > >  fs/namei.c |  5 +++++
> > >  fs/open.c  | 19 ++++++++++++-------
> > >  2 files changed, 17 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/fs/namei.c b/fs/namei.c
> > > index 37fb0a8aa09a..057afacc4b60 100644
> > > --- a/fs/namei.c
> > > +++ b/fs/namei.c
> > > @@ -3612,6 +3612,9 @@ static int do_open(struct nameidata *nd,
> > >         int acc_mode;
> > >         int error;
> > >
> > > +       if (file->f_mode & FMODE_OPENED)
> > > +               fsnotify_open(file);
> > > +
> > >         if (!(file->f_mode & (FMODE_OPENED | FMODE_CREATED))) {
> > >                 error =3D complete_walk(nd);
> > >                 if (error)
> > > @@ -3700,6 +3703,8 @@ int vfs_tmpfile(struct mnt_idmap *idmap,
> > >         mode =3D vfs_prepare_mode(idmap, dir, mode, mode, mode);
> > >         error =3D dir->i_op->tmpfile(idmap, dir, file, mode);
> > >         dput(child);
> > > +       if (file->f_mode & FMODE_OPENED)
> > > +               fsnotify_open(file);
> > >         if (error)
> > >                 return error;
> > >         /* Don't check for other permissions, the inode was just crea=
ted */
> > > diff --git a/fs/open.c b/fs/open.c
> > > index 89cafb572061..970f299c0e77 100644
> > > --- a/fs/open.c
> > > +++ b/fs/open.c
> > > @@ -1004,11 +1004,6 @@ static int do_dentry_open(struct file *f,
> > >                 }
> > >         }
> > >
> > > -       /*
> > > -        * Once we return a file with FMODE_OPENED, __fput() will cal=
l
> > > -        * fsnotify_close(), so we need fsnotify_open() here for symm=
etry.
> > > -        */
> > > -       fsnotify_open(f);
> > >         return 0;
> > >
> > >  cleanup_all:
> > > @@ -1085,8 +1080,17 @@ EXPORT_SYMBOL(file_path);
> > >   */
> > >  int vfs_open(const struct path *path, struct file *file)
> > >  {
> > > +       int ret;
> > > +
> > >         file->f_path =3D *path;
> > > -       return do_dentry_open(file, NULL);
> > > +       ret =3D do_dentry_open(file, NULL);
> > > +       if (!ret)
> > > +               /*
> > > +                * Once we return a file with FMODE_OPENED, __fput() =
will call
> > > +                * fsnotify_close(), so we need fsnotify_open() here =
for symmetry.
> > > +                */
> > > +               fsnotify_open(file);
> >
> > I agree that this change preserves the logic, but (my own) comment
> > above is inconsistent with the case of:
> >
> >         if ((f->f_flags & O_DIRECT) && !(f->f_mode & FMODE_CAN_ODIRECT)=
)
> >                 return -EINVAL;
> >
> > Which does set FMODE_OPENED, but does not emit an OPEN event.
>
> If I understand correctly, that case doesn't emit an OPEN event before
> my patch, but will result in a CLOSE event.
> After my patch ... I think it still doesn't emit OPEN.
>
> I wonder if, instead of adding the the fsnotify_open() in do_open(), we
> should put it in the\
>         if (file->f_mode & (FMODE_OPENED | FMODE_CREATED)) {
> case of open_last_lookups().
>

We cannot do that.
See the reasoning for 7b8c9d7bb457 ("fsnotify: move fsnotify_open() hook in=
to
do_dentry_open()") - we need the events for other callers of vfs_open(),
like overlayfs and nfsd.

> Or maybe it really doesn't hurt to have a CLOSE event without and OPEN.
> OPEN without CLOSE would be problematic, but the other way around
> shouldn't matter....  It feels untidy, but maybe we don't care.
>

We have had unmatched CLOSE events for a very long time before
7b8c9d7bb457 ("fsnotify: move fsnotify_open() hook into do_dentry_open()")
and I do not know of any complaints.

When I made this change, its purpose was not to match all OPEN/CLOSE
but to add missing OPEN events. However, I did try to avoid unmatched
CLOSE at least for the common cases.

Thanks,
Amir.

