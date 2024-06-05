Return-Path: <linux-fsdevel+bounces-21051-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7ED8FD18A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 17:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1B201F25198
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 15:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26AE614B97F;
	Wed,  5 Jun 2024 15:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TyzZE7+a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4921863F;
	Wed,  5 Jun 2024 15:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717601014; cv=none; b=VttwKyOyDW/EpqCzxK56aAvV8ImoCyZqBC3iCfbalOn2X6ZhcEEmk2LavnEwKlFoggp39u5e1ncmqDhJyVI5J1J1hXjrJ8/IUQwyg/KFISZs67UPB7ATqscZR1eoNeQWOvqSxiQDu96FacbbVa2S0PWvkmUBv+0AFCXVvNulf0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717601014; c=relaxed/simple;
	bh=v4UM6UpxFPuhKL3HSNjCFRF+z2qRDKJeWwJdR9zTztY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MYhdgwiI5ooZBI++aV9LZzcJpxIDrJK8t8XmmYkGBAJgqha1kRv6tSbaHCzqS8bRx5S27toe9yhzzyJKRjDaA3UPW9rwe+NQyVUFvXFN8oT34BI9vv2Q7XheXkda/J/QfWXMxAQYHE0I5UsmFmFXseiG4llLv3+yFUtsaQ6V3N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TyzZE7+a; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a634e03339dso803188566b.3;
        Wed, 05 Jun 2024 08:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717601011; x=1718205811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GyXWLGWJnAlN5+/WvyT0BjxTu5PVnAj76f9V03b+3uE=;
        b=TyzZE7+auqWzi9exdc+Xd5rQAAtjoASnaTdJgE5wFR0VKgpjIj906Q4UHihbggilUR
         7O4O9WTx8h2Y9BHhbME87Vvc7/F+IQIiB19bS7zv2MB0Dl2jVdeQXfs/Oke9scWk7oq3
         0GLaf5/3VbEG4L2nh9Dh5yasP4yvd7jMtz6ScctCaJO28X4fTEmh88A4CB7qQSwP5BZB
         jx71jQ8dpsb1yJI/m/dT1xm21lD1kE3zdIHjsUndOsqMku09YDNVlpmVc7kax88/2LYJ
         ayUqRaUc9NO+zL+E7+IjqjFOHcyJ9LRxfI9blUi/M9HECwjHgxQc/1k05jPvcmDRkGbp
         aMNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717601011; x=1718205811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GyXWLGWJnAlN5+/WvyT0BjxTu5PVnAj76f9V03b+3uE=;
        b=busPPnKSDpVZNWsVB7+P9UOVNWrLAqexF3ZRg/sFF349Z2G9kZ/aEjB1bizWvZKY3N
         z3LEw6W8BuDDUQw7op7+/Yx14IcGnTYc2h8f6xvSw1MbY5IGOZopXjHXBGIlq/OeL0pn
         4v5rKzCMBZsndzcxz+aHyD9T1SCgefbENNiyBXccG2A8iwe9NcTT3s81tOvpdoJTTzKs
         gIxwayG+5SNKD79LuKaHZkuRSjv5ecjLzkKTKB+pAWCGTy9kDwgd+yVujzJbAeAJR6MI
         og0PEeyJU64Mcg59FZ994LdS31gBAr2VIMdm58NRbYK67EA/lVQ34BXBrB8c56FmbSoe
         1VqQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4xiBINyCixuXbXgb7XD0tapNmjyaK+Kcpgm14bBj0UIjBCweSZv/HmFRneptXjJzrBP1rjjfDEm0CwpdtMgDQa8lfjQ1ZRh3yzBYaDr35i62hvqbWxEXF8nTxQ4RJWoWKpAP9qJ1pJBImYw==
X-Gm-Message-State: AOJu0YxK5lzJQWaqHMCYkYW2anmCjIFdgrQtMNwsmOx5/do1Fxz6NL4I
	F/ZDkonmVxBfzEE54a5ujy1JJMNhkYKBLGa+EMsVe8oaq12NYNMBc6CjrqaLypLMu05Ux1uagju
	ZLLZDInmfvcGrwDqxwr3YnTnJqF8=
X-Google-Smtp-Source: AGHT+IEBG75AIzTLwjG8DXanfQrQhDHyFWNyyAF3nj9sqLW5HoayN1Q/NgwI4iNEH5OKPamMUJWe3GLmsHaTlCxHEmE=
X-Received: by 2002:a17:906:cc82:b0:a69:1137:120a with SMTP id
 a640c23a62f3a-a69a002257bmr195705666b.51.1717601010877; Wed, 05 Jun 2024
 08:23:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240604132448.101183-1-mjguzik@gmail.com> <20240605-zeitraffer-fachzeitschrift-e74730507b59@brauner>
In-Reply-To: <20240605-zeitraffer-fachzeitschrift-e74730507b59@brauner>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 5 Jun 2024 17:23:18 +0200
Message-ID: <CAGudoHEE44AdG1_KiomDxQYoTQhcqox7Dr+u5nBnSJz_Q17bMA@mail.gmail.com>
Subject: Re: [HACK PATCH] fs: dodge atomic in putname if ref == 1
To: Christian Brauner <brauner@kernel.org>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, axboe@kernel.dk, daclash@linux.microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 5:20=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> On Tue, Jun 04, 2024 at 03:24:48PM +0200, Mateusz Guzik wrote:
> > The struct used to be refcounted with regular inc/dec ops, atomic usage
> > showed up in commit 03adc61edad4 ("audit,io_uring: io_uring openat
> > triggers audit reference count underflow").
> >
> > If putname spots a count of 1 there is no legitimate way of anyone to
> > bump it and these modifications are low traffic (names are not heavily)
> > shared, thus one can do a load first and if the value of 1 is found the
> > atomic can be elided -- this is the last reference..
> >
> > When performing a failed open this reduces putname on the profile from
> > ~1.60% to ~0.2% and bumps the syscall rate by just shy of 1% (the
> > discrepancy is due to now bigger stalls elsewhere).
>
> I suspect you haven't turned audit on in general because that would give
> you performance impact in a bunch of places. Can't we just do something
> where we e.g., use plain refcounts if audit isn't turned on?
> (audit_dummy_context() or whatever it's called).
>

That would still give atomics for audit users which don't play with io_urin=
g.

The part below --- describes one idea what to do with this.

> >
> > Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> > ---
> >
> > This is a lazy hack.
> >
> > The race is only possible with io_uring which has a dedicated entry
> > point, thus a getname variant which takes it into account could store
> > the need to use atomics as a flag in struct filename. To that end
> > getname could take a boolean indicating this, fronted with some inlines
> > and the current entry point renamed to __getname_flags to hide it.
> >
> > Option B is to add a routine which "upgrades" to atomics after getname
> > returns, but that's a littly fishy vs audit_reusename.
> >
> > At the end of the day all spots which modify the ref could branch on th=
e
> > atomics flag.
> >
> > I opted to not do it since the hack below undoes the problem for me.
> >
> > I'm not going to fight for this hack though, it is merely a placeholder
> > until someone(tm) fixes things.
> >
> > If the hack is considered a no-go and the appraoch described above is
> > considered fine, I can submit a patch some time this month to sort it
> > out, provided someone tells me how to name a routine which grabs a ref
> > -- the op is currently opencoded and "getname" allocates instead of
> > merely refing. would "refname" do it?
> >
> >  fs/namei.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/fs/namei.c b/fs/namei.c
> > index 37fb0a8aa09a..f9440bdb21d0 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -260,11 +260,13 @@ void putname(struct filename *name)
> >       if (IS_ERR(name))
> >               return;
> >
> > -     if (WARN_ON_ONCE(!atomic_read(&name->refcnt)))
> > -             return;
> > +     if (unlikely(atomic_read(&name->refcnt) !=3D 1)) {
> > +             if (WARN_ON_ONCE(!atomic_read(&name->refcnt)))
> > +                     return;
> >
> > -     if (!atomic_dec_and_test(&name->refcnt))
> > -             return;
> > +             if (!atomic_dec_and_test(&name->refcnt))
> > +                     return;
> > +     }
> >
> >       if (name->name !=3D name->iname) {
> >               __putname(name->name);
> > --
> > 2.39.2
> >



--=20
Mateusz Guzik <mjguzik gmail.com>

