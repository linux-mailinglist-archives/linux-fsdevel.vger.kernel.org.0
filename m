Return-Path: <linux-fsdevel+bounces-22201-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B060F913A57
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Jun 2024 14:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E38791C205E1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Jun 2024 12:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DCF181301;
	Sun, 23 Jun 2024 12:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QD4RnW7s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1863146A68;
	Sun, 23 Jun 2024 12:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719144313; cv=none; b=hbjTG8SrVnDgwIF6dddZV9G7vBGNLfb9BRxSwVmEZVJEkmohK74CCq06oi06TJhOvhFoKsIu4g3pDJVp1EEOwlv01d9nF3X2uC/4dQ+/02ssJ6IK1DZV6jsOIbwiXVukA388aX1XlI4W/EmvMT84eSnb2DpQ2e43GoRUC6N4L54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719144313; c=relaxed/simple;
	bh=x0eu6FzDbqlmTCln+0TmPTvoiebXfz9YLshcASu2zFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=coM2u2Yxf3xaCV0qySvaqMXOrh3RI4RTpR21prPlPp0FzSbwWstw+JQ97rUo0y7ZC+1bPBUhy0uN7310fRvw7BKUpDZtDT+XrHWbCSAxRNKu0YvotWUu+xRQJzs8fX5tJwcUFmxpQ4l6c8IGsNVp36EyPSlD1L0wAioMUhDr1I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QD4RnW7s; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57cb9a370ddso3829304a12.1;
        Sun, 23 Jun 2024 05:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719144308; x=1719749108; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v+9HDK5irEOHKoyqqTJ0d+J1J6qDyFAy5UodcdX0Ris=;
        b=QD4RnW7s76nf8zOhFreyLrW9jGJ3xqD5xhIbMqOf98PuNpoMUz5RYM3y5XaaNeWMWd
         6f6SsuaiJPPaLKVN3LTQtzN26bxmv4DhAO/dpmpUiEUyB5nPobOJft5TMt5Ev5xJiOCS
         zuQ2yAPkW6rQrtDJfl7E8fChctRg1UhGeSTVG7+qUm4hAYnG3Y5oigpJxvvSF1kqmLvK
         s+txDmVZhDrDey5n0WrqKB/YxSQ4e6pLVPECcpmvb1EDTrqbkzHYe/sC3sNgR7k0Nm0c
         Fq/bJ1io5SuQbiIVryCS4YvcumhFwxzh+RRlpAOPKcLL8JXaKiUYWl8fjRwzH5l3BNcN
         qqwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719144308; x=1719749108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v+9HDK5irEOHKoyqqTJ0d+J1J6qDyFAy5UodcdX0Ris=;
        b=TRVdLEY/xfQQucf6vNGJcqRoU3pCyZkwPvWC68mCTa82faTEh4JoE0sDlG7maiMIHb
         aeoYKlWPeancdiX8ik2XnAvrcFwZUqSezeis5NCy8sNSVzbuTIRWO4LSRxkomydlgWPk
         BeB07LgK3VEY+lEqvoE/vvY9RN9pCU79HbhNoqakeC4fQLBvvbe7KWXjjDPhZTfS5CTn
         1oeKulAQY2HbtFmOGBXKnzLcnJdXY2NYd2c63zWSZntLrUiXGtU0FKqfMb4ID5HfwXq8
         uQ18erOoUUahnBQqa+cCW5XQDW1JCh1iCe0lYrjuiKe8WH9xqBAg0ecIGpkKFVAEGrOB
         NUeg==
X-Forwarded-Encrypted: i=1; AJvYcCWCiM3YYSmHOa9U/mbW9QWDX8zplKKwNxekCuyVk8hFKS1kIxJdwFug8Qy8MQun+0bZanAU8+2eWq2vTr3tYUwAT3Mltqi/eWtHolbmPl7HA9QrO256OdNMTJ4IgPAx7Fsf4qPVb030LJgx3Y8E27bEp0iXs0hAHO8d099VArEq+I9RXBt+hFy3voJOLSi1tuBh8muyH23wXt7e4LOVQ2EWtshYv6C1KkxULfU=
X-Gm-Message-State: AOJu0YwgxKa4HzW/Ll4ls6GhMvrT1kGqqfC6OgoTg28X8ihhAZ1DdmAN
	MnJPYk/hMFLC3labgHLQ+5cJVSv1YffIKCh+zJPzqDhZXA2HCMfj1b0ymw40nD5foTpHpmjr+Io
	2XlJNrgPx+9+GXXCxGbu/6X3M7Og=
X-Google-Smtp-Source: AGHT+IFnMUqp7z8qfKjLX2GW9CbGe8fI9/rJ6aZbm+NwS/Y0v7CD9JEwChA4DcxpDHqQwuxtifZ4PvJaigG3mMmzT9w=
X-Received: by 2002:aa7:d393:0:b0:57d:5600:2c94 with SMTP id
 4fb4d7f45d1cf-57d56003448mr135481a12.0.1719144308088; Sun, 23 Jun 2024
 05:05:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240622105621.7922-1-xry111@xry111.site> <kslf3yc7wnwhxzv5cejaqf52bdr6yxqaqphtjl7d4iaph23y6v@ssyq7vrdwx56>
 <CAHk-=wgj6h97Ro6oQcOq5YTG0JcKRLN0CtXgYCW_Ci6OSzL5NA@mail.gmail.com>
 <eeb7e9895aca92fa5a8d11d9f37b283428185278.camel@xry111.site>
 <CAGudoHFofUZ0Nb9UtV=Q3uQ0K+JnBHPrgLxNYuj7nSLF-=ue8g@mail.gmail.com> <9d1512b57683a68a7176ae8221562657fb0231a3.camel@xry111.site>
In-Reply-To: <9d1512b57683a68a7176ae8221562657fb0231a3.camel@xry111.site>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Sun, 23 Jun 2024 14:04:54 +0200
Message-ID: <CAGudoHGsumzEukjQg=TxQgzjBcZ4a+TsdNVtFp4dpaSw6BzaSA@mail.gmail.com>
Subject: Re: [PATCH] vfs: Add AT_EMPTY_PATH_NOCHECK as unchecked AT_EMPTY_PATH
To: Xi Ruoyao <xry111@xry111.site>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alejandro Colomar <alx@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@loongson.cn>, 
	Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
	Icenowy Zheng <uwu@icenowy.me>, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 23, 2024 at 3:22=E2=80=AFAM Xi Ruoyao <xry111@xry111.site> wrot=
e:
>
> On Sun, 2024-06-23 at 03:07 +0200, Mateusz Guzik wrote:
> > On Sun, Jun 23, 2024 at 2:59=E2=80=AFAM Xi Ruoyao <xry111@xry111.site> =
wrote:
> > >
> > > On Sat, 2024-06-22 at 15:41 -0700, Linus Torvalds wrote:
> > >
> > > > I do think that we should make AT_EMPTY_PATH with a NULL path
> > > > "JustWork(tm)", because the stupid "look if the pathname is empty" =
is
> > > > horrible.
> > > >
> > > > But moving that check into getname() is *NOT* the right answer,
> > > > because by the time you get to getname(), you have already lost.
> > >
> > > Oops.  I'll try to get around of getname() too...
> > >
> > > > So the short-cut in vfs_fstatat() to never get a pathname is
> > > > disgusting - people should have used 'fstat()' - but it's _importan=
t_
> > > > disgusting.
> > >
> > > The problem is we don't have fstat() for LoongArch, and it'll be
> > > unusable on all 32-bit arch after 2037.
> > >
> > > And Arnd hates the idea adding fstat() for LoongArch because there wo=
uld
> > > be one more 32-bit arch broken in 2037.
> > >
> > > Or should we just add something like "fstat_2037()"?
> > >
> >
> > In that case fstat is out of the question, but no problem.
> >
> > It was suggested to make AT_EMPTY_PATH + NULL pathname do the right
> > thing and have the syscalls short-circuit as needed.
> >
> > for statx it would look like this (except you are going to have
> > implement do_statx_by_fd):
> >
> > diff --git a/fs/stat.c b/fs/stat.c
> > index 16aa1f5ceec4..0afe72b320cc 100644
> > --- a/fs/stat.c
> > +++ b/fs/stat.c
> > @@ -710,6 +710,9 @@ SYSCALL_DEFINE5(statx,
> >         int ret;
> >         struct filename *name;
> >
> > +       if (flags =3D=3D AT_EMPTY_PATH && filename =3D=3D NULL)
> > +               return do_statx_by_fd(...);
> > +
> >         name =3D getname_flags(filename, getname_statx_lookup_flags(fla=
gs));
> >         ret =3D do_statx(dfd, name, flags, mask, buffer);
> >         putname(name);
> >
> > and so on
> >
> > Personally I would prefer if fstatx was added instead, fwiw most
> > massaging in the area will be the same regardless.
>
> I do agree.  But if we do it *now* would it be "breaking the userspace"
> if some stupid program relies on fstatx() to return some error when the
> path is NULL?  The "stupid programs" may just exist in the wild...
>

You mean statx? fstatx would not accept a path to begin with.

Worry about some code breaking is why I suggested a dedicated flag
(AT_NO_PATH) myself in case fstatx is a no-go.

I am not convinced messing with AT_* flags is justified to begin with.
Any syscall which does not have a fd-only variant and is found to be
routinely used with AT_EMPTY_PATH should get one instead.

As far as I know that's only stat(due to a perf bug in glibc, now
fixed) and increasingly statx.

Suppose AT_EMPTY_PATH + NULL are to land and stat + statx get the
treatment. What about all the other syscalls? Sorting all that out is
quite a big of churn which is probably not worth it. But then there is
a feature gap in that they EFAULT for this pair while the stat* ones
don't and that's bound to raise confusion. Then one could add the
check in the bowels of path lookup in similar way you do did to
maintain the same behavior (but without per-syscall churn) and a big
fat warning that anyone getting there often needs to get patched with
short-circuiting the entire thing. So I think that's either a lot of
churn or nasty additions.

Regardless, as noted above, either making fstatx a thing or
short-circuiting mostly the same patching has to be done for
statx-related stuff.

However, this is not my call to make.

--=20
Mateusz Guzik <mjguzik gmail.com>

