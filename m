Return-Path: <linux-fsdevel+bounces-22202-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2FE913A8C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Jun 2024 14:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A6491C2093B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Jun 2024 12:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F811181319;
	Sun, 23 Jun 2024 12:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="lwci9HTV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4475912E1DC;
	Sun, 23 Jun 2024 12:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719145600; cv=none; b=OLIKqZSIJFblt8m6AeBsjtEx3Zgrzu5asG+aLI4XmT5htihxG7OojGIwTctU5ek5z1LJQXDzCa1b21aEMNbUcXBb8lTorZtYdQ/7fzA1l5stxVSzKzWkEABtzTpSPbn31dfAwQ6D5PXGybbZBTfC7B2utNtH1kR/eRQFqAznHhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719145600; c=relaxed/simple;
	bh=mIqfBCvqzwdHOW8Oo2iYgxApTMfLroYEglXYxWIf7l0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tEcBPwo+8WXJSAaKOcLRmIBgwDPfFavkoBq1CKPehAiUR1/oUpzqaNAgYlEAAgevXrZoRHEPdBzOc9pqVfE4jTH3o0xfS/Qviv5pyyAJ+k9XzzMLl3Umt4xc1Vrsc7hMdCkWGLH4Kwmi055IqJwAvwncK5x1khYavNVnEglNvY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=lwci9HTV; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1719145589;
	bh=mIqfBCvqzwdHOW8Oo2iYgxApTMfLroYEglXYxWIf7l0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=lwci9HTVc/95e270r9YWQBQ6RWGLIvCZfKxIbsTe1jqcjqZvnQ6Clbnos9baCmaVv
	 NCBk00KhCIbm0K4STKp5YdpLavGxByDfE2tsKBNP85WI8x0oJ0flw/OzqdE5e556gu
	 RHeQWfzdIs9S+U0NRAWcTA4iQMCKzXlmy1n6OE7U=
Received: from [192.168.124.13] (unknown [113.200.174.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 6B02767608;
	Sun, 23 Jun 2024 08:26:23 -0400 (EDT)
Message-ID: <33f9ffadecbd5f189cb312f91373bf6a64e7ef9c.camel@xry111.site>
Subject: Re: [PATCH] vfs: Add AT_EMPTY_PATH_NOCHECK as unchecked
 AT_EMPTY_PATH
From: Xi Ruoyao <xry111@xry111.site>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner
	 <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara
	 <jack@suse.cz>, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
	 <mhiramat@kernel.org>, Alejandro Colomar <alx@kernel.org>, Arnd Bergmann
	 <arnd@arndb.de>, Huacai Chen <chenhuacai@loongson.cn>, Xuerui Wang
	 <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, Icenowy Zheng
	 <uwu@icenowy.me>, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Date: Sun, 23 Jun 2024 20:26:18 +0800
In-Reply-To: <CAGudoHGsumzEukjQg=TxQgzjBcZ4a+TsdNVtFp4dpaSw6BzaSA@mail.gmail.com>
References: <20240622105621.7922-1-xry111@xry111.site>
	 <kslf3yc7wnwhxzv5cejaqf52bdr6yxqaqphtjl7d4iaph23y6v@ssyq7vrdwx56>
	 <CAHk-=wgj6h97Ro6oQcOq5YTG0JcKRLN0CtXgYCW_Ci6OSzL5NA@mail.gmail.com>
	 <eeb7e9895aca92fa5a8d11d9f37b283428185278.camel@xry111.site>
	 <CAGudoHFofUZ0Nb9UtV=Q3uQ0K+JnBHPrgLxNYuj7nSLF-=ue8g@mail.gmail.com>
	 <9d1512b57683a68a7176ae8221562657fb0231a3.camel@xry111.site>
	 <CAGudoHGsumzEukjQg=TxQgzjBcZ4a+TsdNVtFp4dpaSw6BzaSA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-06-23 at 14:04 +0200, Mateusz Guzik wrote:
> On Sun, Jun 23, 2024 at 3:22=E2=80=AFAM Xi Ruoyao <xry111@xry111.site> wr=
ote:
> >=20
> > On Sun, 2024-06-23 at 03:07 +0200, Mateusz Guzik wrote:
> > > On Sun, Jun 23, 2024 at 2:59=E2=80=AFAM Xi Ruoyao <xry111@xry111.site=
>
> > > wrote:
> > > >=20
> > > > On Sat, 2024-06-22 at 15:41 -0700, Linus Torvalds wrote:
> > > >=20
> > > > > I do think that we should make AT_EMPTY_PATH with a NULL path
> > > > > "JustWork(tm)", because the stupid "look if the pathname is
> > > > > empty" is
> > > > > horrible.
> > > > >=20
> > > > > But moving that check into getname() is *NOT* the right
> > > > > answer,
> > > > > because by the time you get to getname(), you have already
> > > > > lost.
> > > >=20
> > > > Oops.=C2=A0 I'll try to get around of getname() too...
> > > >=20
> > > > > So the short-cut in vfs_fstatat() to never get a pathname is
> > > > > disgusting - people should have used 'fstat()' - but it's
> > > > > _important_
> > > > > disgusting.
> > > >=20
> > > > The problem is we don't have fstat() for LoongArch, and it'll be
> > > > unusable on all 32-bit arch after 2037.
> > > >=20
> > > > And Arnd hates the idea adding fstat() for LoongArch because
> > > > there would
> > > > be one more 32-bit arch broken in 2037.
> > > >=20
> > > > Or should we just add something like "fstat_2037()"?
> > > >=20
> > >=20
> > > In that case fstat is out of the question, but no problem.
> > >=20
> > > It was suggested to make AT_EMPTY_PATH + NULL pathname do the
> > > right
> > > thing and have the syscalls short-circuit as needed.
> > >=20
> > > for statx it would look like this (except you are going to have
> > > implement do_statx_by_fd):
> > >=20
> > > diff --git a/fs/stat.c b/fs/stat.c
> > > index 16aa1f5ceec4..0afe72b320cc 100644
> > > --- a/fs/stat.c
> > > +++ b/fs/stat.c
> > > @@ -710,6 +710,9 @@ SYSCALL_DEFINE5(statx,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct filename *name;
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (flags =3D=3D AT_EMPTY_PATH =
&& filename =3D=3D NULL)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return do_statx_by_fd(...);
> > > +
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name =3D getname_flags(fil=
ename,
> > > getname_statx_lookup_flags(flags));
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D do_statx(dfd, name=
, flags, mask, buffer);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 putname(name);
> > >=20
> > > and so on
> > >=20
> > > Personally I would prefer if fstatx was added instead, fwiw most
> > > massaging in the area will be the same regardless.
> >=20
> > I do agree.=C2=A0 But if we do it *now* would it be "breaking the
> > userspace"
> > if some stupid program relies on fstatx() to return some error when
> > the
> > path is NULL?=C2=A0 The "stupid programs" may just exist in the wild...
> >=20
>=20
> You mean statx? fstatx would not accept a path to begin with.

Yes I mean statx.

> Worry about some code breaking is why I suggested a dedicated flag
> (AT_NO_PATH) myself in case fstatx is a no-go.

I agree a dedicated flag will be better but I only came up with nasty
names like it AT_FORCE_EMPTY_PATH or AT_EMPTY_PATH_NOCHECK.  I think
your AT_NO_PATH is a better name.

> I am not convinced messing with AT_* flags is justified to begin with.
> Any syscall which does not have a fd-only variant and is found to be
> routinely used with AT_EMPTY_PATH should get one instead.
>=20
> As far as I know that's only stat(due to a perf bug in glibc, now
> fixed) and increasingly statx.

And you mean fstatat instead of stat, I guess.

> Suppose AT_EMPTY_PATH + NULL are to land and stat + statx get the
> treatment. What about all the other syscalls? Sorting all that out is
> quite a big of churn which is probably not worth it. But then there is
> a feature gap in that they EFAULT for this pair while the stat* ones
> don't and that's bound to raise confusion. Then one could add the
> check in the bowels of path lookup in similar way you do did to
> maintain the same behavior (but without per-syscall churn) and a big
> fat warning that anyone getting there often needs to get patched with
> short-circuiting the entire thing. So I think that's either a lot of
> churn or nasty additions.
>=20
> Regardless, as noted above, either making fstatx a thing or
> short-circuiting mostly the same patching has to be done for
> statx-related stuff.
>=20
> However, this is not my call to make.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

