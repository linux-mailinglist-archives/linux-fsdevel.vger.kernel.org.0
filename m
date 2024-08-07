Return-Path: <linux-fsdevel+bounces-25233-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75ECE94A194
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 09:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3639A284F09
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 07:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91731C7B84;
	Wed,  7 Aug 2024 07:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFEL3Mgx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8865D2868D;
	Wed,  7 Aug 2024 07:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723015395; cv=none; b=V3N1WXLOu8cplJt34Gt/TXottQk+N/zhxyvguip5xEDeBWKP7V89bi1J6A7uvZqrWVXp/iT/H9dXTrshuQI41L4qhznaT1zaoMt3FE/s5qKe9ErvCg4jCBdcxr5/na9AnGsVWco7jsVa1CedQrL73y4/S/hVadUo9+d5LQke7/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723015395; c=relaxed/simple;
	bh=UzA5DKQG+Nw/YH0+Q4tUQBRkKenGjEhF8bEWkAWMiLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PlP+ZQBkzO/zfXWLJLrodpyORfa6HG86r2NM0k1Q3BwSaEJ7Jb9rShFCuevm/pTtjwXxueC06qTxs+eBiIHppc15E/48pAxeB59Nl7SaAt+mTjRkY+FUQuQw7TPrs3pvJ7dZy2AP8Ayvwojo6rAJ5RPlj9z71Nbrsuc3RLjPdts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FFEL3Mgx; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5bba25c1e15so841085a12.2;
        Wed, 07 Aug 2024 00:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723015392; x=1723620192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IBaGLVE74qXEKngc0svhqubDQrT8z2ECLY/dDfQleuo=;
        b=FFEL3MgxzTbAER9LbLoY3DeauM7B9JF5Sf5EFjgHWu6Fv9KaQTzNeUSvg1FQrr7K3b
         HBJ0GsRCuT/DjKd8/99W63jVcxtIdc8/AbGidWmxVV7dE/xLkdnHQp01hgubpksZMbaE
         3LzJZvNpXmCF9cVpmX/O/8GpEJLDDtIpuXwSJ+v6h0IaoV1bZzPv2TjJcue1GRTnjCAX
         wPbllu/rkK1fIWOeNrNTdtC+Yyp35dTzLn2ELtIhrOy7ngudwg6kVSOmdQqsbM4EY+oL
         0/tm1DPalg6uD10acjnCni552WQUdyP4+3DAqxlSXQjy6vqFaLNIKuKEk150XSUDw9xT
         qqyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723015392; x=1723620192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IBaGLVE74qXEKngc0svhqubDQrT8z2ECLY/dDfQleuo=;
        b=UtVNwRBqdb9s1vVJW/JyqsDm6eewp8PHXRokszSyXGCt0gXbyFSWDr+Gwqyxuf+Z6f
         epOzHLzNOTF4ape0rpaxb7q04aAAGHIGmhjHCjfp0tfU60VyCX7gJI4BPuix2Rmo3Lo2
         jSrQgfYPGdlvm1Ui9rdRJ4stUGBI9RyXT38DXFBrCZqwV+/JSk3nLW9TsJulchjU04El
         6+s4fw80icoD0qsVPw3cpvTAbmSUyvfoeXStKPBml+jdxJMUdkwfe1c+HqOmiZFvig90
         5AHAPE0LuUkG7U8mTSs1CZTARkxcgjHACcFx0uupCvCGxAy7nhyBR9VJhSL7GrZIGR8E
         p5EQ==
X-Forwarded-Encrypted: i=1; AJvYcCWB12jG9jZb8m/aRXvFiE15ZxF0uv7AXr3xwlb5tZ53U00UPTtCusp0sXAOjE7vdHcTsg5YuGCfgfFfLIG3AXqi2DBCVMy5YfNc2BEy9pEw+KkKbFeAGE52d0NdVaqni1KdigbKPRtkvQGvRg==
X-Gm-Message-State: AOJu0YzYYlo7VhgaIc5TGytGispeLIu+yqoqJswRohwsL+6pklKLvJ8U
	8ech/NnSdtzMH065S1xwoCkTWwkITupU/Iv8yhB1+SztFSVQitIbUZ/rhKszsEmL9tAWagvVTuq
	olrEztI/Cd54CNwkYrken20El6WI=
X-Google-Smtp-Source: AGHT+IE26TekbEoibYDRyirpSQF7bdV0ZZ+UMh+SiZg0xVIrCBSW4yftDsUgMa4J4DLkcvY46iofkHLo4um26rmdd30=
X-Received: by 2002:a17:906:c156:b0:a77:d1ea:ab26 with SMTP id
 a640c23a62f3a-a7dc5105151mr1261977266b.65.1723015391544; Wed, 07 Aug 2024
 00:23:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806144628.874350-1-mjguzik@gmail.com> <20240806155319.GP5334@ZenIV>
 <CAGudoHFgtM8Px4mRNM_fsmi3=vAyCMPC3FBCzk5uE7ma7fdbdQ@mail.gmail.com>
 <20240807033820.GS5334@ZenIV> <CAGudoHFJe0X-OD42cWrgTObq=G_AZnqCHWPPGawy0ur1b84HGw@mail.gmail.com>
 <20240807062300.GU5334@ZenIV> <20240807063350.GV5334@ZenIV>
 <CAGudoHH29otD9u8Eaxhmc19xuTK2yBdQH4jW11BoS4BzGqkvOw@mail.gmail.com> <20240807070552.GW5334@ZenIV>
In-Reply-To: <20240807070552.GW5334@ZenIV>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 7 Aug 2024 09:22:59 +0200
Message-ID: <CAGudoHGMF=nt=Dr+0UDVOsd4nfGRr4xC8=oeQqs=Av9s0tXXXA@mail.gmail.com>
Subject: Re: [PATCH] vfs: avoid spurious dentry ref/unref cycle on open
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 9:05=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
>
> On Wed, Aug 07, 2024 at 08:40:28AM +0200, Mateusz Guzik wrote:
> > On Wed, Aug 7, 2024 at 8:33=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk=
> wrote:
> > >
> > > On Wed, Aug 07, 2024 at 07:23:00AM +0100, Al Viro wrote:
> > > >       After having looked at the problem, how about the following
> > > > series:
> > > >
> > > > 1/5) lift path_get() *AND* path_put() out of do_dentry_open()
> > > > into the callers.  The latter - conditional upon "do_dentry_open()
> > > > has not set FMODE_OPENED".  Equivalent transformation.
> > > >
> > > > 2/5) move path_get() we'd lifted into the callers past the
> > > > call of do_dentry_open(), conditionally collapse it with path_put()=
.
> > > > You'd get e.g.
> > > > int vfs_open(const struct path *path, struct file *file)
> > > > {
> > > >         int ret;
> > > >
> > > >         file->f_path =3D *path;
> > > >         ret =3D do_dentry_open(file, NULL);
> > > >         if (!ret) {
> > > >                 /*
> > > >                  * Once we return a file with FMODE_OPENED, __fput(=
) will call
> > > >                  * fsnotify_close(), so we need fsnotify_open() her=
e for
> > > >                  * symmetry.
> > > >                  */
> > > >                 fsnotify_open(file);
> > > >         }
> > > >       if (file->f_mode & FMODE_OPENED)
> > > >               path_get(path);
> > > >         return ret;
> > > > }
> > > >
> > > > Equivalent transformation, provided that nobody is playing silly
> > > > buggers with reassigning ->f_path in their ->open() instances.
> > > > They *really* should not - if anyone does, we'd better catch them
> > > > and fix them^Wtheir code.  Incidentally, if we find any such,
> > > > we have a damn good reason to add asserts in the callers.  As
> > > > in, "if do_dentry_open() has set FMODE_OPENED, it would bloody
> > > > better *not* modify ->f_path".  <greps> Nope, nobody is that
> > > > insane.
> > > >
> > > > 3/5) split vfs_open_consume() out of vfs_open() (possibly
> > > > named vfs_open_borrow()), replace the call in do_open() with
> > > > calling the new function.
> > > >
> > > > Trivially equivalent transformation.
> > > >
> > > > 4/5) Remove conditional path_get() from vfs_open_consume()
> > > > and finish_open().  Add
> > > >               if (file->f_mode & FMODE_OPENED)
> > > >                       path_get(&nd->path);
> > > > before terminate_walk(nd); in path_openat().
> > > >
> > > > Equivalent transformation - see
> > > >         if (file->f_mode & (FMODE_OPENED | FMODE_CREATED)) {
> > > >                 dput(nd->path.dentry);
> > > >                 nd->path.dentry =3D dentry;
> > > >                 return NULL;
> > > >         }
> > > > in lookup_open() (which is where nd->path gets in sync with what
> > > > had been given to do_dentry_open() in finish_open()); in case
> > > > of vfs_open_consume() in do_open() it's in sync from the very
> > > > beginning.  And we never modify nd->path after those points.
> > > > So we can move grabbing it downstream, keeping it under the
> > > > same condition (which also happens to be true only if we'd
> > > > called do_dentry_open(), so for all other paths through the
> > > > whole thing it's a no-op.
> > > >
> > > > 5/5) replace
> > > >               if (file->f_mode & FMODE_OPENED)
> > > >                       path_get(&nd->path);
> > > >               terminate_walk(nd);
> > > > with
> > > >               if (file->f_mode & FMODE_OPENED) {
> > > >                       nd->path.mnt =3D NULL;
> > > >                       nd->path.dentry =3D NULL;
> > > >               }
> > > >               terminate_walk(nd);
> > > > Again, an obvious equivalent transformation.
> > >
> > > BTW, similar to that, with that we could turn do_o_path()
> > > into
> > >
> > >         struct path path;
> > >         int error =3D path_lookupat(nd, flags, &path);
> > >         if (!error) {
> > >                 audit_inode(nd->name, path.dentry, 0);
> > >                 error =3D vfs_open_borrow(&path, file);
> > >                 if (!(file->f_mode & FMODE_OPENED))
> > >                         path_put(&path);
> > >         }
> > >         return error;
> > > }
> > >
> > > and perhaps do something similar in the vicinity of
> > > vfs_tmpfile() / do_o_tmpfile().
> >
> > That's quite a bit of churn, but if you insist I can take a stab.
>
> What I have in mind is something along the lines of COMPLETELY UNTESTED
> git.kernel.org:/pub/scm/linux/kernel/git/viro/vfs.git #experimental-for-m=
ateusz
>
> It needs saner commit messages, references to your analysis of the
> overhead, quite possibly a finer carve-up, etc.  And it's really
> completely untested - it builds, but I hadn't even tried to boot
> the sucker, let alone give it any kind of beating, so consider that
> as a quick illustration (slapped together at 3am, on top of 5 hours of
> sleep yesterday) to what I'd been talking about and no more than that.

Well it's your call, you wrote the thing and I need the problem out of
the way, so I'm not going to argue about the patchset.

I verified it boots and provides the expected perf win [I have to
repeat it is highly variable between re-runs because of ever-changing
offsets between different inode allocations resulting in different
false-sharing problems; i'm going to separately mail about that]

I think it will be fine to copy the result from my commit message and
denote it's from a different variant achieving the same goal.

That said feel free to use my commit message in whatever capacity,
there is no need to mention me.

Thanks for sorting this out.
--=20
Mateusz Guzik <mjguzik gmail.com>

