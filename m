Return-Path: <linux-fsdevel+bounces-47941-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA76AA7909
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 20:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E09044E2830
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 18:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F0F25D54B;
	Fri,  2 May 2025 18:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EjsFu+Dv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3021DE4EC
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 May 2025 18:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746208918; cv=none; b=oXjtCd43b5nyGX/03cBmsBp7dEGykzFSPwlBAMvJnlT6pjz4557MgwndHfpQzhpmfQTbbTcjBRq1BZC3HzGF7pxtWwmWPx+x+L518gFNE9ekjtOO7fVtYHSHZmiBOrPiVaKtyuiZ3Wgpv4DkLN4SS/VO0gw756XkiOwofilhw8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746208918; c=relaxed/simple;
	bh=WdTwdTLFvmt70ohNSziIhqitAq3hQZ3YAK1/71MuvKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eUWL+QMT8ENJA4ipTV0PIciEzqACM++AA5vURxawrfKR3B9FdoU19Zh5tvmNXD+wBAqwwDoccV+w/Xaw7HamdQJmrrvwzXxfkR0KCuAl0/Gaxm/+tXtall7xK8BM7sqTx6EJnqinxSsjh2i68Eoi0vfnbysX7SrDW2zlAZnQkIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EjsFu+Dv; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5f62ef3c383so4165643a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 May 2025 11:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746208915; x=1746813715; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WdTwdTLFvmt70ohNSziIhqitAq3hQZ3YAK1/71MuvKk=;
        b=EjsFu+DvFxNmFpaVG6CQg+WFC+629CzOfIv+yP5Ha63uxErmyicKnyCDviVITWaEga
         4aUbQrZcYBUZ8bpsiuM0J4+4jr/b8xkPqrWe4dr+7I6GQIB3OX/0GQbZ0jbYYoxRDC/z
         acG/xXpM1jpAFVBgZaZrClCE5lVuIkcDC+/JYRyrIYFpBTcdPdl/Xda556Bi/RByZwRZ
         pGy42VTOT0H2a2kMnGxDLLBGaRXvt0Pq5yRUhiJYAS65A7YNfEbiaMnj6qLUv+HgOa/E
         Rcc0QL04TaZKagLJICWbNc8TNy3t/ljDMb6oPLhGwQLqeVQYQBaCLI5B8pYrovya1uKq
         ChoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746208915; x=1746813715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WdTwdTLFvmt70ohNSziIhqitAq3hQZ3YAK1/71MuvKk=;
        b=PiVPUIluHQOLW2XbT6hWTTM/3yD/oYyIu4gR2Tv170WhMNDt6K8rjpZqRYlXlCJT5T
         lHVbLXnQsYnPtIIGJ++Zm9r1ohuug/6rRmDuDD2lvH/KOZLbFA7fwZzKRUUNIDJLjxpY
         WyMHVIChyrkceCIl4PX/6HqUt74n1rZsBZ4VZMHZEpzldT+39YhvttbQHGLyNnafiJc9
         jeFOFiQxvrsm+LS5TtAK4pSDlZnzBPBFxLz1OKu+gk+tLthT9XihebG+lFHypLI+3GAW
         rPkhXrvNMMwc/PVLToe3BCUJu568bI5WCQTAg4ZQjc+oAlezDJeJM4V6rvU0ykQ7hTgi
         JEfw==
X-Forwarded-Encrypted: i=1; AJvYcCX5nf3kLgnZy5zaHQxx2QTlKv1g9rY59XdmzC19b8/jWxJsp48VM36ZOD5qwkBXeZMeZymi0PfIeGKqEYtz@vger.kernel.org
X-Gm-Message-State: AOJu0YxRwuG15G0XwXFTM01A7zX2dL3jONBGbPB01AkasxKAGzEfNM8G
	CC/zT+XPM4EvvBXCddUVL8MCfuX9KjRKFd4r59wWpuECtyJPJbG8kuUHVS6MhQvHtZdggD4BjE9
	GXusPw2R26bTy0aQawdxXlSlXdcwiqw==
X-Gm-Gg: ASbGncu6YIvxF2RiZVWMmkPkPwD6cJiaa2zKisec3xObrW2Q6sj1Y33VSu12iD3/HR8
	r7FqmP2xuSSpkS0BIhm0jn9cQNA8It06HiHZCctibVUo0v2AluEg566/pmMFpc9hM2mpddehF+D
	ySbNMih054N6dZiaN320I=
X-Google-Smtp-Source: AGHT+IEKd5P9TkuU6P8Duf6Kk9ZQwuFk/rLbhNBQhF/LMLjTBNFAy9rBc7Fp0Pao8MlLiroZ04/gBQDX6BPnnbECjBw=
X-Received: by 2002:a05:6402:1e92:b0:5e7:b02b:5ae with SMTP id
 4fb4d7f45d1cf-5fa7890e6b5mr3052485a12.31.1746208914639; Fri, 02 May 2025
 11:01:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGudoHFULfaG4h-46GG2cJG9BDCKX0YoPEpQCpgefpaSBYk4hw@mail.gmail.com>
 <idlhgryyp4336ybkmtjdxotb5agos3h44vkp2p7cg6dvc2uefg@no4dm6c6vyzd> <CAGudoHE6kBTWa9Pqs5Dnc4JF4Oijc--eg+aXCkmcgm0o13Gt4Q@mail.gmail.com>
In-Reply-To: <CAGudoHE6kBTWa9Pqs5Dnc4JF4Oijc--eg+aXCkmcgm0o13Gt4Q@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Fri, 2 May 2025 20:01:42 +0200
X-Gm-Features: ATxdqUGB70ELU95n1m52XKWHina0pfEJlOWdad11uxxupuxHL7c9RuQ5nL-FgKg
Message-ID: <CAGudoHHHVG7sX+ukMNc8feRkE+YrWknmCWjQ95W1xkYkSycwrQ@mail.gmail.com>
Subject: Re: [RFF] realpathat system call
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 2, 2025 at 7:35=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> wr=
ote:
>
> On Fri, May 2, 2025 at 2:34=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> >
> > On Wed 30-04-25 22:50:23, Mateusz Guzik wrote:
> > > Before I explain why the system call and how, I'm noting a significan=
t
> > > limitation upfront: in my proposal the system call is allowed to fail
> > > with EAGAIN. It's not inherent, but I think it's the sane thing to do=
.
> > > Why I think that's sensible and why it does not defeat the point is
> > > explained later.
> > >
> > > Why the system call: realpath(3) is issued a lot for example by gcc
> > > (mostly for header files). libc implements it as a series of
> > > readlinks(!) and it unsurprisingly looks atrocious:
> > > [pid 1096382] readlink("/usr", 0x7fffbac84f90, 1023) =3D -1 EINVAL
> > > (Invalid argument)
> > > [pid 1096382] readlink("/usr/local", 0x7fffbac84f90, 1023) =3D -1 EIN=
VAL
> > > (Invalid argument)
> > > [pid 1096382] readlink("/usr/local/include", 0x7fffbac84f90, 1023) =
=3D
> > > -1 EINVAL (Invalid argument)
> > > [pid 1096382] readlink("/usr/local/include/bits", 0x7fffbac84f90,
> > > 1023) =3D -1 ENOENT (No such file or directory)
> > > [pid 1096382] readlink("/usr", 0x7fffbac84f90, 1023) =3D -1 EINVAL
> > > (Invalid argument)
> > > [pid 1096382] readlink("/usr/include", 0x7fffbac84f90, 1023) =3D -1
> > > EINVAL (Invalid argument)
> > > [pid 1096382] readlink("/usr/include/x86_64-linux-gnu",
> > > 0x7fffbac84f90, 1023) =3D -1 EINVAL (Invalid argument)
> > > [pid 1096382] readlink("/usr/include/x86_64-linux-gnu/bits",
> > > 0x7fffbac84f90, 1023) =3D -1 EINVAL (Invalid argument)
> > > [pid 1096382] readlink("/usr/include/x86_64-linux-gnu/bits/types",
> > > 0x7fffbac84f90, 1023) =3D -1 EINVAL (Invalid argument)
> > > [pid 1096382] readlink("/usr/include/x86_64-linux-gnu/bits/types/FILE=
.h",
> > > 0x7fffbac84f90, 1023) =3D -1 EINVAL (Invalid argument)
> > >
> > > and so on. This converts one path lookup to N (by path component). No=
t
> > > only that's terrible single-threaded, you may also notice all these
> > > lookups bounce lockref-containing cachelines for every path component
> > > in face of gccs running at the same time (and highly parallel
> > > compilations are not rare, are they).
> > >
> > > One way to approach this is to construct the new path on the fly. The
> > > problem with that is that it would require some rototoiling and more
> > > importantly is highly error prone (notably due to symlinks). This is
> > > the bit I'm trying to avoid.
> > >
> > > A very pleasant way out is to instead walk the path forward, then
> > > backward on the found dentry et voila -- all the complexity is handle=
d
> > > for you. There is however a catch: no forward progress guarantee.
> >
> > So AFAIU what you describe here is doing a path lookup and then calling
> > d_path() on the result - actually prepend_path() as I'm glancing in you=
r
> > POC code.
> >
>
> Ye that's the gist.
>
> > > rename seqlock is needed to guarantee correctness, otherwise if
> > > someone renamed a dir as you were resolving the path forward, by the
> > > time you walk it backwards you may get a path which would not be
> > > accessible to you -- a result which is not possible with userspace
> > > realpath.
> >
> > In presence of filesystem mutations paths are always unreliable, aren't
> > they? I mean even with userspace realpath() implementation the moment t=
he
> > function call is returning the path the filesystem can be modified so t=
hat
> > the path stops being valid. With kernel it is the same. So I don't see =
any
> > strong reason to bother with handling parallel filesystem modifications=
.
> > But maybe I'm missing some practically important case...
> >
>
> The concern is not that the result is stale, but that it was not
> legitimately obtainable at any point by the caller doing the current
> realpath walk.
>
> Consider the following tree:
> /foo/file
> /bar
>
> where foo is 755, bar is 700 and both are owned by root, while the
> user issuing realpath has some other uid
>
> if root renames /foo/file to /bar/file while racing against realpath
> /foo/file, there is a time window where the user will find the dentry
> and by the time they d_path the result is /bar/file. but they never
> would get /bar/file with the current implementation.
>

That said, if this is considered fine, the entire thing turns a
trivial patch for sure.

--=20
Mateusz Guzik <mjguzik gmail.com>

