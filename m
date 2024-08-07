Return-Path: <linux-fsdevel+bounces-25229-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F16ED949FE5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 08:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7401D1F23105
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 06:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617991B86C5;
	Wed,  7 Aug 2024 06:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTNFHFWY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0855D1B582D;
	Wed,  7 Aug 2024 06:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723012844; cv=none; b=awdtt+6SAmLJhOM165ZwI7f7FW37oA4/v31I1T17f4ihQR6u6fQTOxdWcFn7TQKoAA26KP66pIx6Bq40XSaJJPV7WhgWaReufsCaE0McvxKmNI7B0zCFiF0y4Zt9ptojuxuyQviy+WSaeLZSffo1EquvFCbyroWb24kF4zMS1N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723012844; c=relaxed/simple;
	bh=Goi2i4ugpxtSNMpoLVVVDIAJoWEDpyXfKPm8meln3lM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JHjsp0X+TaiaKLMh3AAXRW/EJAiYJVs9OkX1m30kYWyscfL2PQe1oN8Zhj91iNDAwItACfvE0bORjlz5rUawB1QjXkgrvgoet2eZ9g7YFiARYJhFxTm02G3d47khbqqmrMdrFUAkC1Z7hbpRQglJHCanhAjs8oCruNo5qsmO3Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gTNFHFWY; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f029e9c9cfso21393221fa.2;
        Tue, 06 Aug 2024 23:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723012841; x=1723617641; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7UGR4vb0ZNGZdQ8i6yuMwV1hdqlVxcG1Qey+Ih/wAxo=;
        b=gTNFHFWYxPsF3g3Hk8Jig0poPK4nqcKkEKdylyyTkIM7hSgl2q9VsHD2tDIqxhYO4U
         P51Z9pEWDvsEDJ+oMzd7jzOS+Mycay1hcfU6pmy1Jl5vB/qkvepySHUrQt/erfRoAI7b
         l3mVI/nXAznkBazPYf4SmDdcyPZ7Mtq+taW0P2xZiGmURb32PR+5iBi1C/g0iiL0xmJ7
         5u/G4zYbk1AygqWZUhWHHhuuygyGTjz+ChhSdcyxVe+/4FonTn9G/M770fN+9K3YleTu
         kxgo4zlpvFhncGGWldqdw5voSoLuKhfSno43x9Jgjp1z4ujRNZ98mVTfW2cWYIhlLZp+
         jGLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723012841; x=1723617641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7UGR4vb0ZNGZdQ8i6yuMwV1hdqlVxcG1Qey+Ih/wAxo=;
        b=srL6OVvTEj6wc2JCKA5GtD3jKiey8Z3Y402qBHL2VawVpKsvXEM3QzDHTKlpywvk0H
         zJ+zgfYnM09Y9k8hoKbg6ZRBnHoG+376HGmqRonGRDHESgX2FkTyokyVqNisgqHz8xeT
         yjopZZ5lNgRNGy40/OqBro15f33sXjzeYSLUwunMVnDtNagfsuax2WBlPcbwg2qjd0Y4
         xIenoSGHIAaR1Z3VJrXCnvwUr9c5CUnZK1lQO6Y92XwnzpqyUz+1dyKHEu3ahmqWOPxy
         k66OAo6wqOggi5OfrNW3rnYUMBbFB211DGcPDEFzGGzjgTFwyGVwwse8E75MKN+KYQtV
         mSNw==
X-Forwarded-Encrypted: i=1; AJvYcCVnkKf/itoVfLoOf+VojCYH7+ENGnEVdWNKiIgXWyzygcmA4cEfcWNZgUY/t7OpfE3JhFfbGd0x7IWpf+G3RvaAhcufYJCZVk42eGwBy/RKwzsOg3kAw7hepLfnkvQS2uFqE66kIoywV1uuPw==
X-Gm-Message-State: AOJu0Yw7mDzGbC6QsSDAcCVxNansd2E2Xo76vazeoefClw03Nam5DPQ1
	sHn8INWTtcQI+l1uhm94riEwvLLS89c3VwW67gLreYdbzg+C6A7mIfyYQyi7jkx4wJVtIz/Bnfs
	/a33KtHMzzSmp5WRTEL4W6IIPWSk=
X-Google-Smtp-Source: AGHT+IHVAKCECOC0KJ8fJKkAkXNSPo+288Gg90zCq2LGMcm+TGeGhyRhrpuXilallzb5kB2jvhDuogzKXVGev81EoO4=
X-Received: by 2002:a2e:9dc2:0:b0:2ef:2ba5:d214 with SMTP id
 38308e7fff4ca-2f15aa88c3dmr141362201fa.4.1723012840650; Tue, 06 Aug 2024
 23:40:40 -0700 (PDT)
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
In-Reply-To: <20240807063350.GV5334@ZenIV>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 7 Aug 2024 08:40:28 +0200
Message-ID: <CAGudoHH29otD9u8Eaxhmc19xuTK2yBdQH4jW11BoS4BzGqkvOw@mail.gmail.com>
Subject: Re: [PATCH] vfs: avoid spurious dentry ref/unref cycle on open
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 8:33=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
>
> On Wed, Aug 07, 2024 at 07:23:00AM +0100, Al Viro wrote:
> >       After having looked at the problem, how about the following
> > series:
> >
> > 1/5) lift path_get() *AND* path_put() out of do_dentry_open()
> > into the callers.  The latter - conditional upon "do_dentry_open()
> > has not set FMODE_OPENED".  Equivalent transformation.
> >
> > 2/5) move path_get() we'd lifted into the callers past the
> > call of do_dentry_open(), conditionally collapse it with path_put().
> > You'd get e.g.
> > int vfs_open(const struct path *path, struct file *file)
> > {
> >         int ret;
> >
> >         file->f_path =3D *path;
> >         ret =3D do_dentry_open(file, NULL);
> >         if (!ret) {
> >                 /*
> >                  * Once we return a file with FMODE_OPENED, __fput() wi=
ll call
> >                  * fsnotify_close(), so we need fsnotify_open() here fo=
r
> >                  * symmetry.
> >                  */
> >                 fsnotify_open(file);
> >         }
> >       if (file->f_mode & FMODE_OPENED)
> >               path_get(path);
> >         return ret;
> > }
> >
> > Equivalent transformation, provided that nobody is playing silly
> > buggers with reassigning ->f_path in their ->open() instances.
> > They *really* should not - if anyone does, we'd better catch them
> > and fix them^Wtheir code.  Incidentally, if we find any such,
> > we have a damn good reason to add asserts in the callers.  As
> > in, "if do_dentry_open() has set FMODE_OPENED, it would bloody
> > better *not* modify ->f_path".  <greps> Nope, nobody is that
> > insane.
> >
> > 3/5) split vfs_open_consume() out of vfs_open() (possibly
> > named vfs_open_borrow()), replace the call in do_open() with
> > calling the new function.
> >
> > Trivially equivalent transformation.
> >
> > 4/5) Remove conditional path_get() from vfs_open_consume()
> > and finish_open().  Add
> >               if (file->f_mode & FMODE_OPENED)
> >                       path_get(&nd->path);
> > before terminate_walk(nd); in path_openat().
> >
> > Equivalent transformation - see
> >         if (file->f_mode & (FMODE_OPENED | FMODE_CREATED)) {
> >                 dput(nd->path.dentry);
> >                 nd->path.dentry =3D dentry;
> >                 return NULL;
> >         }
> > in lookup_open() (which is where nd->path gets in sync with what
> > had been given to do_dentry_open() in finish_open()); in case
> > of vfs_open_consume() in do_open() it's in sync from the very
> > beginning.  And we never modify nd->path after those points.
> > So we can move grabbing it downstream, keeping it under the
> > same condition (which also happens to be true only if we'd
> > called do_dentry_open(), so for all other paths through the
> > whole thing it's a no-op.
> >
> > 5/5) replace
> >               if (file->f_mode & FMODE_OPENED)
> >                       path_get(&nd->path);
> >               terminate_walk(nd);
> > with
> >               if (file->f_mode & FMODE_OPENED) {
> >                       nd->path.mnt =3D NULL;
> >                       nd->path.dentry =3D NULL;
> >               }
> >               terminate_walk(nd);
> > Again, an obvious equivalent transformation.
>
> BTW, similar to that, with that we could turn do_o_path()
> into
>
>         struct path path;
>         int error =3D path_lookupat(nd, flags, &path);
>         if (!error) {
>                 audit_inode(nd->name, path.dentry, 0);
>                 error =3D vfs_open_borrow(&path, file);
>                 if (!(file->f_mode & FMODE_OPENED))
>                         path_put(&path);
>         }
>         return error;
> }
>
> and perhaps do something similar in the vicinity of
> vfs_tmpfile() / do_o_tmpfile().

That's quite a bit of churn, but if you insist I can take a stab.

fwiw I do think the weird error condition in do_dentry_open can be
used to simplify stuff, which I still do in my v2.

with my approach there is never a path_put needed to backpedal (it was
already done by do_dentry_open *or* it is going to be done by whoever
doing last fput)

then do_o_path would be:
        struct path path;
        int error =3D path_lookupat(nd, flags, &path);
        if (!error) {
                audit_inode(nd->name, path.dentry, 0);
                error =3D vfs_open_consume(&path, file);
        }
        return error;


--=20
Mateusz Guzik <mjguzik gmail.com>

