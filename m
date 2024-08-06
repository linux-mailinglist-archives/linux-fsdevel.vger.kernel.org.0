Return-Path: <linux-fsdevel+bounces-25135-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B7294955D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 18:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE7111F2569D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 16:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F2640855;
	Tue,  6 Aug 2024 16:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/fBeprb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46E23BB50;
	Tue,  6 Aug 2024 16:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722960881; cv=none; b=nRBuwzGYLZ3pc2efEft3et6LVKrQUcAkMiMzKWE6XyoX2fYe74klJF7vmMFzBn//EgQnvv7R2ifqhOuC/Ox50ah4g7+o8XdlrldXHLmLfU11D8nfysxdl+WcSW1LLsOH9LXKlv47/06euh5fGv1y2/JjigEoUib6MP5RoRipO1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722960881; c=relaxed/simple;
	bh=tB2/mRC5gXwf9PgAyMWnZSWxfpCfU9uD7nfvwxfjMps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VrxKYatq4uW05fNLMNUjbHLVqlMzisLxDxQAvcAafv9Hpolu6lNboqiv03JnWPiaaZqW0CuCtRX3NeP/RVkxGDykkrJsyiSnZmznw9RQJnL57V8/bEvWVPvSb34jDTto+8H9EAFjZh+UPKWwe+o6Zk/NxSoyaVZdecvaTEeYR4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E/fBeprb; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5a79df5af51so11691a12.0;
        Tue, 06 Aug 2024 09:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722960878; x=1723565678; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cMBfg9FIsivhQ6JKhfKMaojGWty23eYwk42EPlBel+4=;
        b=E/fBeprbgIR3Ef12Xr74GkaNk4VbdAHgEBrL2gkc7TKxan6oKXRAjTsAzjbfD532QW
         D+7GziIUsjKsSwJtF5pFJiMQkYCi4kJWkXoFmK9TgIReyS5RHCQdew9b8AywV0UoP+m6
         Wjdi58t/zVJ4kgwIAicRW5wbGw86SJ1TOPSP2L+gSOCcYZuM4MTnxEQZ4jD5qwbQ6JUt
         qQE40WXNHgpqKM7uU3CJoZRqCYDMc3h6gG29RfWgk5UJQErthwXuOeXtAStexMMuVqun
         8xyATLHnN08FqA9w+yvi19NpTX2SuGYX6KGsFTFqkQumNkfiNdQIxV8DLgM2nJ0vsAQD
         k3iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722960878; x=1723565678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cMBfg9FIsivhQ6JKhfKMaojGWty23eYwk42EPlBel+4=;
        b=rEefwtUeXosrFVogmMeKiwONlZz4cReBKRh9QvojPWErc7T6yt2J5ieAmQb3UEcyS9
         kBpfAOhOf0x8Jkh6cfFssnJz3APivDIsF4G9AOzC5bxdBIuFkVJD0tHVGAgO/qNdOGRT
         YTMyr8pR6g63iVpBSFcCm1XdocYaY6y8lqfRMLd5aQrd7BQiath2NJtWdfWEKIHwinEL
         AUFUEvezvg6Y85esIpPrcgsc1lM+i4oM4ae+GRjZhlPnDpAKtAY0kd+OBIAa+w7ezorP
         2IEY1+kFMdKgYfitxr7bCr8s/2FrCcrUGZZoXTZHKrhITQ8YXy0Raxl/tu+uN+k1a1G6
         JE8w==
X-Forwarded-Encrypted: i=1; AJvYcCUa5NTDZMBf4wKkMV+VyybM1qOW/f6sSAzCK8GY5T+fYPixQzRCL0d263C8+gqLxaCQ+W5SfgpecHitL1I8Tujpw1kwzeA3kzTNxeEojnEaeAPzwjayf7/lDnn04Qbw0G3lsSa1ZTunel/5bw==
X-Gm-Message-State: AOJu0YyYuK8KGfSHJCk59n4gBG2POIT9+hOboWKiiDeMxT1KfqaSG82w
	aPNz48y3r4SzDqlQlKU+IqU5ukJZn3NZ231gwy2fiUOrZL2AKzfwiREB9p76dtwH1JM6oI74Dgv
	jrKff54qC+5UXn2irtt/YB0+E3jVjaph/
X-Google-Smtp-Source: AGHT+IF7aNIoH7Vem0bRffzYy3YmNf3B0CnM42zo97vm1GDIbE1l0b586HyrAmRth2DwSzMI8CIQq+vgBTa1HGJf8/A=
X-Received: by 2002:a17:907:9689:b0:a7a:a557:454e with SMTP id
 a640c23a62f3a-a7dc5f66fe1mr1431973866b.2.1722960877593; Tue, 06 Aug 2024
 09:14:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806144628.874350-1-mjguzik@gmail.com> <20240806155319.GP5334@ZenIV>
 <CAGudoHFgtM8Px4mRNM_fsmi3=vAyCMPC3FBCzk5uE7ma7fdbdQ@mail.gmail.com>
In-Reply-To: <CAGudoHFgtM8Px4mRNM_fsmi3=vAyCMPC3FBCzk5uE7ma7fdbdQ@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 6 Aug 2024 18:14:25 +0200
Message-ID: <CAGudoHEvkxf3uLL=RkgsMkUa3A6vYP6FOCfi5UwWU1nOK_qGBQ@mail.gmail.com>
Subject: Re: [PATCH] vfs: avoid spurious dentry ref/unref cycle on open
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 6:09=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> wr=
ote:
>
> On Tue, Aug 6, 2024 at 5:53=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> =
wrote:
> >
> > On Tue, Aug 06, 2024 at 04:46:28PM +0200, Mateusz Guzik wrote:
> >
> > > The flag thing is optional and can be dropped, but I think the genera=
l
> > > direction should be to add *more* asserts and whatnot (even if they a=
re
> > > to land separately). A debug-only variant would not hurt.
> >
> > Asserts do *not* clarify anything; if you want your optional flag,
> > come up with clear description of its semantics.  In terms of state,
> > _not_ control flow.
> >
>
> It is supposed to indicate that both nd->path.mnt and nd->path.dentry
> are no longer usable and must not even be looked at. Ideally code
> which *does* look at them despite the flag (=3D=3D there is a bug) traps.
>
> However, I did not find a handy macro or anything of the sort to
> "poison" these pointers. Instead I found tons of NULL checks all over,
> including in lookup clean up.
>
> So as is I agree the flag adds next to nothing as is, but the intent
> was to catch any use of the above pointers after what they point to
> got consumed. Perhaps I should just drop the flag for the time being
> and only propose it with a more fleshed out scheme later.
>
> > > @@ -3683,6 +3685,7 @@ static const char *open_last_lookups(struct nam=
eidata *nd,
> > >  static int do_open(struct nameidata *nd,
> > >                  struct file *file, const struct open_flags *op)
> > >  {
> > > +     struct vfsmount *mnt;
> > >       struct mnt_idmap *idmap;
> > >       int open_flag =3D op->open_flag;
> > >       bool do_truncate;
> > > @@ -3720,11 +3723,22 @@ static int do_open(struct nameidata *nd,
> > >               error =3D mnt_want_write(nd->path.mnt);
> > >               if (error)
> > >                       return error;
> > > +             /*
> > > +              * We grab an additional reference here because vfs_ope=
n_consume()
> > > +              * may error out and free the mount from under us, whil=
e we need
> > > +              * to undo write access below.
> > > +              */
> > > +             mnt =3D mntget(nd->path.mnt);
> >
> > It's "after vfs_open_consume() we no longer own the reference in nd->pa=
th.mnt",
> > error or no error...
> >
>
> ok
>
> > >               do_truncate =3D true;
> >
> >
> > >       }
> > >       error =3D may_open(idmap, &nd->path, acc_mode, open_flag);
> > > -     if (!error && !(file->f_mode & FMODE_OPENED))
> > > -             error =3D vfs_open(&nd->path, file);
> > > +     if (!error && !(file->f_mode & FMODE_OPENED)) {
> > > +             BUG_ON(nd->state & ND_PATH_CONSUMED);
> > > +             error =3D vfs_open_consume(&nd->path, file);
> > > +             nd->state |=3D ND_PATH_CONSUMED;
> > > +             nd->path.mnt =3D NULL;
> > > +             nd->path.dentry =3D NULL;
> >
> > Umm...  The thing that feels wrong here is that you get an extra
> > asymmetry with ->atomic_open() ;-/  We obviously can't do that
> > kind of thing there (if nothing else, we have the parent directory's
> > inode to unlock, error or no error).
> >
> > I don't hate that patch, but it really feels like the calling
> > conventions are not right.  Let me try to tweak it a bit and
> > see if anything falls out...
>

fwiw if you are looking to have vfs_open_${keyword} which accepts
nameidata and "consumes" it, I did not go for it because vfs_open is
in another file and I did not want to "leak" the struct there.

> Should you write your own patch I'm happy to give it a spin to
> validate the win is about the same.
>
> I forgot to note some stuff when sending the patch, so here it is:
> perf is highly unstable between re-runs of the benchmark because
> struct inode itself is not aligned to anything and at least ext4 plops
> it in in a rather arbitrary place and uses a kmem cache without any
> magic alignment guarantees. This results in false sharing showing up
> and disappearing depending on how (un)lucky one gets. For reported
> results I picked the worst case.
>
> I had to patch one sucker for constantly getting in:
> https://lore.kernel.org/linux-security-module/20240806133607.869394-1-mjg=
uzik@gmail.com/T/#u
>
> --
> Mateusz Guzik <mjguzik gmail.com>



--=20
Mateusz Guzik <mjguzik gmail.com>

