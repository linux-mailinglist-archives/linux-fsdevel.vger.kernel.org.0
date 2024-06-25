Return-Path: <linux-fsdevel+bounces-22348-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0626E9168A2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 15:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DEB71F244AD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 13:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4EC15FA72;
	Tue, 25 Jun 2024 13:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WwEs+IFo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAF8158D87;
	Tue, 25 Jun 2024 13:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719321100; cv=none; b=sk5Qk5CwQULgthKGT6dlhF9cErj15d1xZ15GLhoZciGk4vRktH3hTb2IeX3hkzQIW8NBWSL/YXg4ialSziViEE1+4MHltbZa0AYweGiHaIah0p2BjeckvN6HJsBm3ObtmKyt7WWE5akNLmcXecZNHYZQ6Ze9+etTmNbp55DVtqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719321100; c=relaxed/simple;
	bh=mWEEZel7l1d5CSaNut48Y0qx86GVbPZFkaEJPX8uWl4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MO04E0BpXKiwXEExBcTiuyuE5EWAfUekiSLPnm8sYcEPR/V7Wa9M7QaKaEpdvPC3jdfOwjca9TlutbnI2IfJ1YcGwv/nulwUG2Ml20GvFefFDZEcpRfANMaWzD4fhRLDfXE3BO5NNn7WQOgQCLJOVLdNzhkRwRq11IhmxCagwqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WwEs+IFo; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a72420e84feso393263066b.0;
        Tue, 25 Jun 2024 06:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719321097; x=1719925897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6wr3p295UEwSYOEpwt/9wftFpPzQBsmRnJbvPXu4c8c=;
        b=WwEs+IFoC5EB+wh0oYOw4SmIw/ZHQmkVVPxGGXvhqoTdNVMT2MJbxloAjXMaiLSqiY
         vnjLKF5c9Q83QzZNNwaFCx5ONrA87f8/MrU8uUaxGlTimJvhpCNVCxbMjMYmooS9TuPp
         1y2S/cxVRL2qTpWzetgPFPi8+hyi2McjosMaUoZetD2KUjlKcqKdkH2MlOAnHrnz2jXx
         lXmdtiIMK5fDTidKkdPDKHdiScfVoNVFsysNUunxt9zydkzyAOurXKeGkLnKER0/FAOv
         tsklQmjtv1FtqlhmiBzy+FZ6Rf2QyKMC4hWglFJCz60BVp/ZszPRQrE7G4mEUgWb2j6w
         WvPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719321097; x=1719925897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6wr3p295UEwSYOEpwt/9wftFpPzQBsmRnJbvPXu4c8c=;
        b=POAKXt4kvBOhXWHnayo8CLxt+o0dL8rplwEZc3N0KMF+2Lt/gQgiFaQKlT8lBEaMeH
         GeKl3xXSpMV9+GAEg/UgWuz3IywQ8ozjTgI3BUrHSmaK43Eg7HA2pEjssc2PJyhnKulB
         Oj1MoiyUGcx5xUm0i/aCZNprzZaVoLeeacdKJM1V/7159lUSHnFaYJhaCeUwFoQypCan
         f+YUEuPE41YHWUJ+Mu9hme9Mxja29PRQrbAzh/8E3QhG7SuUqhIm4mcpsHFQj9bU4jBI
         n/5777RxBGMjUWa9sCEWK32uHf909f6CgPAhlF88Qs7tuUDo/056zvtbKAmkljzo3QF6
         TEsA==
X-Forwarded-Encrypted: i=1; AJvYcCVlwt4eeWFb2JVAEXxTNq9atsntX0xu+4WH2hwqTaO9p5/xoaGqp298/+7j+Zdu1SvPefn48cXWNbeKKFg0D+9GI05y8eiWuOAqXwMxk1aXPeBLarl1w8VvJWM2tNIP+Yt/1WQmhI8IVA2Gww==
X-Gm-Message-State: AOJu0YzsPuP0holJIu4fpK9Jp1VOLPZbKy0fzEJ9JXebBxYAm3EDoJ62
	I/29m2Py46sNgX2XVFiuzFrS+nFAMvXpQFoWFGlRDtIhjNvJVuQM6oNdE7uIBkD40EmfFyXa7cG
	92Ne98Dap4gNkxDbCgtWYyl8GR2NtX5yl
X-Google-Smtp-Source: AGHT+IG7p2YJ/F6c9tKjjYHf3885kaiSX+bpet95Ij+C3p1F0wQAmFVx+/gruqykOWw/oLnvmYN2gOWSoUvUvUWqegc=
X-Received: by 2002:a17:906:2a89:b0:a6f:5f:8b7 with SMTP id
 a640c23a62f3a-a7245ba39bbmr550632766b.21.1719321096501; Tue, 25 Jun 2024
 06:11:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614163416.728752-1-yu.ma@intel.com> <20240622154904.3774273-1-yu.ma@intel.com>
 <20240622154904.3774273-4-yu.ma@intel.com> <20240625120834.rhkm3p5by5jfc3bw@quack3>
 <CAGudoHGYQwigyQSqm97zyUafxaOCo0VoHZmcYzF1KtqmX=npUg@mail.gmail.com>
In-Reply-To: <CAGudoHGYQwigyQSqm97zyUafxaOCo0VoHZmcYzF1KtqmX=npUg@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 25 Jun 2024 15:11:23 +0200
Message-ID: <CAGudoHH4ixO6n2BgMGx7EEYvLS2Agb8WBz_RM55HjCWBQ5tMLg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] fs/file.c: remove sanity_check from alloc_fd()
To: Jan Kara <jack@suse.cz>
Cc: Yu Ma <yu.ma@intel.com>, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	edumazet@google.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, pan.deng@intel.com, tianyou.li@intel.com, 
	tim.c.chen@intel.com, tim.c.chen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 3:09=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
>
> On Tue, Jun 25, 2024 at 2:08=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> >
> > On Sat 22-06-24 11:49:04, Yu Ma wrote:
> > > alloc_fd() has a sanity check inside to make sure the struct file map=
ping to the
> > > allocated fd is NULL. Remove this sanity check since it can be assure=
d by
> > > exisitng zero initilization and NULL set when recycling fd.
> >   ^^^ existing  ^^^ initialization
> >
> > Well, since this is a sanity check, it is expected it never hits. Yet
> > searching the web shows it has hit a few times in the past :). So would
> > wrapping this with unlikely() give a similar performance gain while kee=
ping
> > debugability? If unlikely() does not help, I agree we can remove this s=
ince
> > fd_install() actually has the same check:
> >
> > BUG_ON(fdt->fd[fd] !=3D NULL);
> >
> > and there we need the cacheline anyway so performance impact is minimal=
.
> > Now, this condition in alloc_fd() is nice that it does not take the ker=
nel
> > down so perhaps we could change the BUG_ON to WARN() dumping similar ki=
nd
> > of info as alloc_fd()?
> >
>
> Christian suggested just removing it.
>
> To my understanding the problem is not the branch per se, but the the
> cacheline bounce of the fd array induced by reading the status.
>
> Note the thing also nullifies the pointer, kind of defeating the
> BUG_ON in fd_install.
>
> I'm guessing it's not going to hurt to branch on it after releasing
> the lock and forego nullifying, more or less:
> diff --git a/fs/file.c b/fs/file.c
> index a3b72aa64f11..d22b867db246 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -524,11 +524,11 @@ static int alloc_fd(unsigned start, unsigned
> end, unsigned flags)
>          */
>         error =3D -EMFILE;
>         if (fd >=3D end)
> -               goto out;
> +               goto out_locked;
>
>         error =3D expand_files(files, fd);
>         if (error < 0)
> -               goto out;
> +               goto out_locked;
>
>         /*
>          * If we needed to expand the fs array we
> @@ -546,15 +546,15 @@ static int alloc_fd(unsigned start, unsigned
> end, unsigned flags)
>         else
>                 __clear_close_on_exec(fd, fdt);
>         error =3D fd;
> -#if 1
> -       /* Sanity check */
> -       if (rcu_access_pointer(fdt->fd[fd]) !=3D NULL) {
> +       spin_unlock(&files->file_lock);
> +
> +       if (unlikely(rcu_access_pointer(fdt->fd[fd]) !=3D NULL)) {
>                 printk(KERN_WARNING "alloc_fd: slot %d not NULL!\n", fd);
> -               rcu_assign_pointer(fdt->fd[fd], NULL);
>         }
> -#endif

Now that I sent it it is of course not safe to deref without
protection from either rcu or the lock, so this would have to be
wrapped with rcu_read_lock, which makes it even less appealing.

Whacking the thing as in the submitted patch seems like the best way
forward here. :)

>
> -out:
> +       return error;
> +
> +out_locked:
>         spin_unlock(&files->file_lock);
>         return error;
>  }
>
>
>
> >                                                                 Honza
> >
> > > Combined with patch 1 and 2 in series, pts/blogbench-1.1.0 read impro=
ved by
> > > 32%, write improved by 17% on Intel ICX 160 cores configuration with =
v6.10-rc4.
> > >
> > > Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
> > > Signed-off-by: Yu Ma <yu.ma@intel.com>
> > > ---
> > >  fs/file.c | 7 -------
> > >  1 file changed, 7 deletions(-)
> > >
> > > diff --git a/fs/file.c b/fs/file.c
> > > index b4d25f6d4c19..1153b0b7ba3d 100644
> > > --- a/fs/file.c
> > > +++ b/fs/file.c
> > > @@ -555,13 +555,6 @@ static int alloc_fd(unsigned start, unsigned end=
, unsigned flags)
> > >       else
> > >               __clear_close_on_exec(fd, fdt);
> > >       error =3D fd;
> > > -#if 1
> > > -     /* Sanity check */
> > > -     if (rcu_access_pointer(fdt->fd[fd]) !=3D NULL) {
> > > -             printk(KERN_WARNING "alloc_fd: slot %d not NULL!\n", fd=
);
> > > -             rcu_assign_pointer(fdt->fd[fd], NULL);
> > > -     }
> > > -#endif
> > >
> > >  out:
> > >       spin_unlock(&files->file_lock);
> > > --
> > > 2.43.0
> > >
> > --
> > Jan Kara <jack@suse.com>
> > SUSE Labs, CR
>
>
>
> --
> Mateusz Guzik <mjguzik gmail.com>



--=20
Mateusz Guzik <mjguzik gmail.com>

