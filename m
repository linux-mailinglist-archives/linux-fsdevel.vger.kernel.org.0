Return-Path: <linux-fsdevel+bounces-47942-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA21BAA7943
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 20:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44EFB1C012C8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 18:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05281C5D59;
	Fri,  2 May 2025 18:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jD1cLd7h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570D115350B
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 May 2025 18:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746210510; cv=none; b=kihHX62mfhg7LY/wqq3gXWJ/PZezwrWsBwSujVj4IPMP2H7A049Nbtxy6qPhh3CJJguzX/LsrnVv6j9mf4n+HZFZ+Uw3k/oyikK//caJ3MMsGPN/BOKsV/bgpSx5njGHuu+Qw0Llma3Od3FwExULxmQGqPDBJmON0lpFRTiXgjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746210510; c=relaxed/simple;
	bh=xvy1FfbxQM9d9qFd5CGNp+nvHTVyx9zfNYzOfm36GdE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m+/UmiO0m5LrCYm/5q2F5b0w58iLWZ0yg2GRdgq4a1pPuqYghrTJyyGLg9QKLkCoIbCGS+2jubm+jUPBBKyAgcE6x9DLHX4N1ge0B7fDtzrY94Uz5SglZn15BwUjjgFtmS5z2nA8NMxG2EzfXYKccKhXu/Bay6oTi2xhm2L6Udk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jD1cLd7h; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e5e22e6ed2so3579950a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 May 2025 11:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746210506; x=1746815306; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6xSEMRwxbiLo5gm1cRYiKWnfR5HcCM4wYfSLURQH3NE=;
        b=jD1cLd7hs5cqUrAf91+8uI0ZxEaqh7ypLRFEK3DTiJ9OcL5JvwkOgsWoFS8T7/Jmwk
         mqylJtS7J2ILK8wR3NHjjocstXydTPYVx8ZhdJCVhw4r8DaBnoDYi+Mfxl6LSod7E5CG
         qqSZiVRcXVLOH7gsTvEXuaLJdpXagh5Whl7yiuG0dmXS9rEHTs5mbZUvnYlQQCEkfETG
         Cyve0TaAedChcG758c/Ne7AMaG9J9QwfIt4I4n5079LLso3CBkgQSI2KXqPeX0fdrikl
         w1gmi1I/PqV+bb1ssb8qcryBw6UC750ft09EV259MAz62NIF8S9o56A+HDjk4gO7+cBc
         8QSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746210506; x=1746815306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6xSEMRwxbiLo5gm1cRYiKWnfR5HcCM4wYfSLURQH3NE=;
        b=Si575Budc6kLdC+dm4aOlp9ZGnaFAajX7pzXSMMagEk9NuMGUpseE6QKFg08sJC38p
         FqCVT05nR+30aJG6LJoiUfvnEX7SAguUmJTq9qaH3Bl5YLi3v8gDQ3C1JGDwf+qsZcmH
         j+IFSCrd6jqjOjLltdwamUZ+r8xljFM4UmbxD2HDW0MiIPu0rwQgyFLhMTdbZ5j0VmQa
         GOPXzfQLpxUrwrFNJTkxk4KSL2PeSiNo1GzOFJoNi5wLw5TzlYCijopNaACsi2M/Fb2D
         cRD5UbGhnsCc8bvE8eyt5j1tiQPRqaywRfzP9Rj49iR5TWMj/EneeFLfD81pMFH8+SKq
         cw9A==
X-Forwarded-Encrypted: i=1; AJvYcCVqNG7g6Z3sefQ/Jp9hddmlI4m8TdRiQFu/e+wUUAEYUzHb9EuMPXNf0/GlDrzgRf6upSwliue2JTXuwQtU@vger.kernel.org
X-Gm-Message-State: AOJu0YxwRNjA5AujmyLuc6jRPn6LFn4zIyRkRQzEpZNTZgcM+GFCz9dX
	33SH/xnu1Ium/6gMwjkcB7eH3rdu+APH1XFNUHy+zVopLWbLG1seF/rm9pTaOJwM/DwJi7FsZtF
	q+YL0jLWtWwIxKQ4s/FWff7B6UBUlvQ==
X-Gm-Gg: ASbGncvKtM5ijzW2InB5Sw3HkoUm3ceAEpYBYqcjQc7Z6zg8VSKOsx04KyuYKYRIpPX
	F0xKUweL7L+ey4LLcv7iiXufdUbKKLfm1oKn6jLwtvz8KI+zsiWHki6bs+yyDEtSDmGvC2abESx
	Jdye5CwLIR2QSF443u2K4=
X-Google-Smtp-Source: AGHT+IGFClWrUTTQLvKI6FnZcAWmTElcEmvhAkJl4qd99ZO5C5IlrKFOzv9QVo/t9bu80ZPp0afS4AiTWf1ePbHkLk4=
X-Received: by 2002:a05:6402:4313:b0:5ec:9e9e:3c3 with SMTP id
 4fb4d7f45d1cf-5fa77fd5839mr3090904a12.6.1746210506183; Fri, 02 May 2025
 11:28:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGudoHFULfaG4h-46GG2cJG9BDCKX0YoPEpQCpgefpaSBYk4hw@mail.gmail.com>
 <idlhgryyp4336ybkmtjdxotb5agos3h44vkp2p7cg6dvc2uefg@no4dm6c6vyzd>
 <CAGudoHE6kBTWa9Pqs5Dnc4JF4Oijc--eg+aXCkmcgm0o13Gt4Q@mail.gmail.com> <CAGudoHHHVG7sX+ukMNc8feRkE+YrWknmCWjQ95W1xkYkSycwrQ@mail.gmail.com>
In-Reply-To: <CAGudoHHHVG7sX+ukMNc8feRkE+YrWknmCWjQ95W1xkYkSycwrQ@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Fri, 2 May 2025 20:28:13 +0200
X-Gm-Features: ATxdqUEft9-6ICHcgUGwXAhBwLdWeqkvmUHiydTPzOS2En8MDIAJDmeZ1HAuIic
Message-ID: <CAGudoHGAdTVVv-K7tOgLyPE2K=qG4VaZU=qrAaieqcO_sNn6+A@mail.gmail.com>
Subject: Re: [RFF] realpathat system call
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 2, 2025 at 8:01=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> wr=
ote:
>
> On Fri, May 2, 2025 at 7:35=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> =
wrote:
> >
> > On Fri, May 2, 2025 at 2:34=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Wed 30-04-25 22:50:23, Mateusz Guzik wrote:
> > > > Before I explain why the system call and how, I'm noting a signific=
ant
> > > > limitation upfront: in my proposal the system call is allowed to fa=
il
> > > > with EAGAIN. It's not inherent, but I think it's the sane thing to =
do.
> > > > Why I think that's sensible and why it does not defeat the point is
> > > > explained later.
> > > >
> > > > Why the system call: realpath(3) is issued a lot for example by gcc
> > > > (mostly for header files). libc implements it as a series of
> > > > readlinks(!) and it unsurprisingly looks atrocious:
> > > > [pid 1096382] readlink("/usr", 0x7fffbac84f90, 1023) =3D -1 EINVAL
> > > > (Invalid argument)
> > > > [pid 1096382] readlink("/usr/local", 0x7fffbac84f90, 1023) =3D -1 E=
INVAL
> > > > (Invalid argument)
> > > > [pid 1096382] readlink("/usr/local/include", 0x7fffbac84f90, 1023) =
=3D
> > > > -1 EINVAL (Invalid argument)
> > > > [pid 1096382] readlink("/usr/local/include/bits", 0x7fffbac84f90,
> > > > 1023) =3D -1 ENOENT (No such file or directory)
> > > > [pid 1096382] readlink("/usr", 0x7fffbac84f90, 1023) =3D -1 EINVAL
> > > > (Invalid argument)
> > > > [pid 1096382] readlink("/usr/include", 0x7fffbac84f90, 1023) =3D -1
> > > > EINVAL (Invalid argument)
> > > > [pid 1096382] readlink("/usr/include/x86_64-linux-gnu",
> > > > 0x7fffbac84f90, 1023) =3D -1 EINVAL (Invalid argument)
> > > > [pid 1096382] readlink("/usr/include/x86_64-linux-gnu/bits",
> > > > 0x7fffbac84f90, 1023) =3D -1 EINVAL (Invalid argument)
> > > > [pid 1096382] readlink("/usr/include/x86_64-linux-gnu/bits/types",
> > > > 0x7fffbac84f90, 1023) =3D -1 EINVAL (Invalid argument)
> > > > [pid 1096382] readlink("/usr/include/x86_64-linux-gnu/bits/types/FI=
LE.h",
> > > > 0x7fffbac84f90, 1023) =3D -1 EINVAL (Invalid argument)
> > > >
> > > > and so on. This converts one path lookup to N (by path component). =
Not
> > > > only that's terrible single-threaded, you may also notice all these
> > > > lookups bounce lockref-containing cachelines for every path compone=
nt
> > > > in face of gccs running at the same time (and highly parallel
> > > > compilations are not rare, are they).
> > > >
> > > > One way to approach this is to construct the new path on the fly. T=
he
> > > > problem with that is that it would require some rototoiling and mor=
e
> > > > importantly is highly error prone (notably due to symlinks). This i=
s
> > > > the bit I'm trying to avoid.
> > > >
> > > > A very pleasant way out is to instead walk the path forward, then
> > > > backward on the found dentry et voila -- all the complexity is hand=
led
> > > > for you. There is however a catch: no forward progress guarantee.
> > >
> > > So AFAIU what you describe here is doing a path lookup and then calli=
ng
> > > d_path() on the result - actually prepend_path() as I'm glancing in y=
our
> > > POC code.
> > >
> >
> > Ye that's the gist.
> >
> > > > rename seqlock is needed to guarantee correctness, otherwise if
> > > > someone renamed a dir as you were resolving the path forward, by th=
e
> > > > time you walk it backwards you may get a path which would not be
> > > > accessible to you -- a result which is not possible with userspace
> > > > realpath.
> > >
> > > In presence of filesystem mutations paths are always unreliable, aren=
't
> > > they? I mean even with userspace realpath() implementation the moment=
 the
> > > function call is returning the path the filesystem can be modified so=
 that
> > > the path stops being valid. With kernel it is the same. So I don't se=
e any
> > > strong reason to bother with handling parallel filesystem modificatio=
ns.
> > > But maybe I'm missing some practically important case...
> > >
> >
> > The concern is not that the result is stale, but that it was not
> > legitimately obtainable at any point by the caller doing the current
> > realpath walk.
> >
> > Consider the following tree:
> > /foo/file
> > /bar
> >
> > where foo is 755, bar is 700 and both are owned by root, while the
> > user issuing realpath has some other uid
> >
> > if root renames /foo/file to /bar/file while racing against realpath
> > /foo/file, there is a time window where the user will find the dentry
> > and by the time they d_path the result is /bar/file. but they never
> > would get /bar/file with the current implementation.
> >
>
> That said, if this is considered fine, the entire thing turns a
> trivial patch for sure.
>

To elaborate,  the result is not obtainable in two ways, one of which
has a security angle to it.

Let's grab the tree again:
/foo/file
/bar

except both foo and bar are 755

with userspace realpath the following results are possible when racing
against rename /foo/file /bar/file:
- success, the path is returned as /foo/file
- ENOENT

with kernel realpath not checking for rename ENOENT is off the table,
instead you get:
- success, the path is returned as /bar/file

Suppose that's fine and maybe even considered an improvement.

Now consider a case where bar is 700 and the user issuing realpath
can't traverse on it.

The user would *not* get the path even if they realpath /bar/file as
they don't have perms. You could argue the user does not have the
rights to know where the file after said rename.

So I stand by the need to check rename seq.

However, I wonder if it would be tolerable to redo the lookup with the
*new* path and check if we got the same dentry at the end. If so, we
know the path was obtainable by traversal.
--=20
Mateusz Guzik <mjguzik gmail.com>

