Return-Path: <linux-fsdevel+bounces-51669-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5AFDAD9E60
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Jun 2025 19:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6DDC1899031
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Jun 2025 17:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19F71C68A6;
	Sat, 14 Jun 2025 17:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CqODnVwi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CB02E11CC
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Jun 2025 17:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749920638; cv=none; b=J5wY8QYIi0hbwmqOjXvdsUUxpQ199AY8+lTAtMYOynMYke5n7J8G55NcCnf0Iz53lnkMSRueqUNkPuar2IYixUHTWyJ51xD8QfIxnyBN8FvxB/LcU0o+fToeHS7ote3H9xZwGO/6mCcD6zT7sFaDy7/u4m0MdC5tVvvkCtsd2bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749920638; c=relaxed/simple;
	bh=yA389I0lCLaO7sq6BrOSjnmnLTw+vyk+Yzh+vuHQTOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TNDnrlMg5ubKtvDw8Vn2IT0654M4AQ9qUJmxryBCMCUacxbtaCLJgqe4MI1IcEPwenEdesgT7lSVgCPJ+5O5bD189QNtLNTtF6bcyUf4+pGIljO58tliFjvz9/mmniNUiG0wfrjYPMSBdnvpx8ck9IAm5R5kKJv/GeakL3VRg9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CqODnVwi; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-adb2bb25105so541979766b.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 Jun 2025 10:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749920634; x=1750525434; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0KKCkLvW+Wv0c41e7ukQbp5j6fqtEiVW7ZaoIaZEpVI=;
        b=CqODnVwiEW6xg7fUP6sXNFXrljJLqcpkcha8E2oMgp+hpi7e6UGtzA3oSM2OhSw1dG
         ymbu7TlpZKhjnLjPuhVJxlw6z6zCUuhY1NtrhEWq3KkKjUrgeIO9zY2RcL9Nd0/3sWPU
         id6Qiyc1gFauog4/Zq2gBx5U+aN0djvzjwd7GdJbJTqasldb/Lj/QEIR8nmaSZ9E8xvL
         kTolSSmNu+3ERAkGj+8eN5X5zM6Y+f0cRrqoz2zDinShidLDCt5HubJqbBRP7YwZEqOz
         MR9YssDjkRod9DynFiFtrYa70U58uACt4Ilh7Q64Moxgo8/IRJYvowUjhKrsu2cTLG3h
         XIpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749920634; x=1750525434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0KKCkLvW+Wv0c41e7ukQbp5j6fqtEiVW7ZaoIaZEpVI=;
        b=c00BcYNcrNAzn/oJKEWJoyaMGXDRESSvysUlyyoC7PKm0SC9g7IqPu9wkrfn0QIve/
         K+4HXOb8aju/58N2r/x52R1mwODwA2ByERwjCCLD4B0hCMgcXiekkDG6X9Bkwhm1pVIo
         EGAvkeSI/cALGyJMyD21ju5segtiHIiCxMmUFP0s6BChTO06Bmxng9FUTYtxVaTqcd/9
         hl3nG5fVrQ3Et8UB9Bgspdw2O2kH51ZLoxTENJiMDNjlEvVrHcHnTrM0h9WQ0yO1RlYz
         3OzGLW5AjC530Z8lOK2O1hBsvi5UTfnyBS4NIwsdHIiIbW/2v4BjupyIGSk8n60eiAAx
         IzfA==
X-Forwarded-Encrypted: i=1; AJvYcCWP+cm588hWbKXgKtAlUaj69rPeCLdsUYJ+ThClcFNXdatjZbMdC3mWU5Z7LDOB2Luuou0ioYrTX6bPqmGP@vger.kernel.org
X-Gm-Message-State: AOJu0YxJkNxsj4Wiy9MD4rNjhGmbcOAa+8+SLmpTt1PjTax6K7ODyiBj
	ff4wwv8Uecs0WolEOWjkxs25dn2wBFnQW4NvqzTvW5WXA8RWyBfXg+7n8SMbDI14bz4tk9TD5oN
	d950QKZuj2fujbkgcKGNC+nszCXqEr8U=
X-Gm-Gg: ASbGncvjYrKPwnSfSAyQf+7nYqihXbDdInyDzVmpxppc9O9yhcC7i9D0XA8gwIwkiRB
	GKM4UKe/MbYW7YZVnGR2tYbYG7T0uuZF2IqbQFQu3/6wo/uKqXhJpWdn8BOXbeOcoiGztU1U0X1
	nnl5zC4KfgmWljgZQss9UIK2EMCi4pGEiogGy9hf+xvoU=
X-Google-Smtp-Source: AGHT+IFxzv/QZIfceSdpHD9T2M11cT7vrQ0tXihtU+CF2FCtHBJ0wy3eO09tXf/ruuk4kcoJQRgiCM0eJP8c5pRhM2g=
X-Received: by 2002:a17:907:3e06:b0:adb:e08:5e71 with SMTP id
 a640c23a62f3a-adfad3261f8mr267629466b.17.1749920634119; Sat, 14 Jun 2025
 10:03:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250604160918.2170961-1-amir73il@gmail.com> <e2rcmelzasy6q4vgggukdjb2s2qkczcgapknmnjb33advglc6y@jvi3haw7irxy>
 <CAOQ4uxg1k7DZazPDRuRfhnHmps_Oc8mmb1cy55eH-gzB9zwyjw@mail.gmail.com>
In-Reply-To: <CAOQ4uxg1k7DZazPDRuRfhnHmps_Oc8mmb1cy55eH-gzB9zwyjw@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 14 Jun 2025 19:03:42 +0200
X-Gm-Features: AX0GCFsywwvtTl4Pf8H02BiYq0GpwD3J4osjaUxa-KuFuKxAjrwLm_gPtKOZ1uA
Message-ID: <CAOQ4uxhxsmWC75yg09kjTzCy8dAGNe90SC_aX9rgNivepzTyCA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/3] fanotify HSM events for directories
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 5:25=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Tue, Jun 10, 2025 at 3:49=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> >
> > Hi Amir!
> >
>
> Hi Jan!
>
> Thanks for taking the time to read my long email ;)
>
> > On Wed 04-06-25 18:09:15, Amir Goldstein wrote:
> > > In v1 there was only patch 1 [1] to allow FAN_PRE_ACCESS events
> > > on readdir (with FAN_ONDIR).
> > >
> > > Following your feedback on v1, v2 adds support for FAN_PATH_ACCESS
> > > event so that a non-populated directory could be populted either on
> > > first readdir or on first lookup.
> >
> > OK, it's good that now we have a bit more wider context for the discuss=
ion
> > :). First, when reading this I've started wondering whether we need bot=
h
> > FAN_PRE_ACCESS on directories and FAN_PATH_ACCESS (only on directories)=
.
> > Firstly, I don't love adding more use to the FAN_ONDIR flag when creati=
ng
> > marks because you can only specify you want FAN_PRE_ACCESS on files,
> > FAN_PRE_ACCESS on files & dirs but there's no way to tell you care only
> > about FAN_PRE_ACCESS on dirs. You have to filter that when receiving
> > events. Secondly, the distinction between FAN_PRE_ACCESS and
> > FAN_PATH_ACCESS is somewhat weak - it's kind of similar to the situatio=
n
> > with regular files when we notify about access to the whole file vs onl=
y to
> > a specific range.  So what if we had an event like FAN_PRE_DIR_ACCESS t=
hat
> > would report looked up name on lookup and nothing on readdir meaning yo=
u
> > need to fetch everything?
> >
>
> This makes a lot of  sense to me. and I also like the suggested event nam=
e.
> Another advantage is that FAN_PRE_ACCESS can always expect a range
> (as documented)
>

Hi Jan,

I started looking at combining readdir() and lookup() to generate
FAN_PRE_DIR_ACCESS and I hit  this problem:

Currently, FAN_PRE_ACCESS is an event that is FS_EVENTS_POSS_ON_CHILD,
so watching a parent with FAN_EVENT_ON_CHILD can report this event
on files.

The same is true for FAN_OPEN, FAN_ACCESS and FAN_OPEN_PERM events,
but in that case, also true for an opened/access directory.

I do not think it is right to generate pre-content lookup events in
subdir when watching
a parent directory. I don't think that generating pre-content readdir
events on subdir
when watching a parent dir is very useful, but if you do not allow
that, we deviate
from the behavior of the event FAN_ACCESS | FAN_ONDIR which also happens
on readdir.

Honestly, I always found it a bit confusing that when reporting DFID_NAME o=
f
events FAN_OPEN | FAN_ONDIR and FAN_ACCESS | FAN_ONDIR, when
watching the parent, we do not report the name of the subdir (like
inotify does),
but I still think it was the right thing to do.

Do you understand my dilemma?
Do you think it is fine for FAN_PRE_DIR_ACCESS to break out of this
confusing pattern and not be reported for subdirs on a watches parent?
Do you think we should report pre-content lookup events in subdir
with a watched parent?
Do you have an idea how to make this less confusing to users?
Or should we drop the idea of unifying the readdir/lookup events
and keep the legacy semantics for pre-readdir.

Thanks,
Amir.

