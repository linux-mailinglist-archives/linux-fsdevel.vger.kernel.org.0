Return-Path: <linux-fsdevel+bounces-30381-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5CA98A6E9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 16:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF2542828FE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 14:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CEC190688;
	Mon, 30 Sep 2024 14:23:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7F52CA5;
	Mon, 30 Sep 2024 14:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727706185; cv=none; b=OvuSk5uJ2PBc0mgkrxavau1HTt6BXvdfRJ+lLU0eumPKOg4iM3Y8Ckaq3g/Bm+0i7qtmXXWm0zRNOdS96h4/aXQO1W9//j9jOidJYvn7Jm9hjOWdvoZUpwtbby1zKG7c/lX1ugIBCXJxSce4N3PfZZMAYlAwV48abh6qzWSfuww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727706185; c=relaxed/simple;
	bh=PP7YcUhsIi+utu31RkQv3pnqlWmA+DDtA6v7wf31oT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H/tn9+aASDBJu7xR2JLypKjnTzlXz/n++NiXxlzyStAJXPmsoqAZ4fs1VPJfixdpJZuMVjZOn7K/k/jF9gnOnqJ83OvEQ086x3NlzBqPHaTyX+TSzEALpren87t6pCzk67JrZjAl6drBajcFKz3L2n7KmOabA5LEUfkRMzIXYHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e03caab48a2so3495420276.1;
        Mon, 30 Sep 2024 07:23:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727706181; x=1728310981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cr/EtosCTi+osAYF0gtgC9Zdrd07pNfm4NnYKdP5ZWs=;
        b=ffHNHn2lJVp92AStm+x9Pj4r6c95eFt1biVf/4EGcbKfTUWTi6Q4wfPZP4l/7BGWB2
         f35Dod0qUIcgD8w+PlSSh9WkQLrycXdKsTwcrVamP744QN5KBReQPbUAgcZLWgZtQN+k
         Qy2tkFHe+kv/Cxv/lhk7AM6I/GSEkzi7O6hecv5Te8TIOkX1Nq4FShs8Yyg86s0cjCtU
         ER+IBI1feHRB69UgMhvQGirSvZEn2OK6DzzMk8vL1+z9GBjPmaYKfzzn3eUKgC43b8t5
         yhK1jOujxO2QVJDiLjpyuofkBLG4lnebTh/Oc9nqN8hlf2vvyJ53qavwiLaXAT12w81N
         KJqA==
X-Forwarded-Encrypted: i=1; AJvYcCVtuXvR2pS+wFJWKVa+eetjHvjVbXB+rKwFWElyR2feczyrEJIDFsBzai09Q/l/CFzXiXFJgfTrZRm0yzpo@vger.kernel.org, AJvYcCWOJunKBmpLQi6VxXfzJ9cBF21sDcVHAqxc36B0T8V7yyRT8bLwM75DSaPkHfPGFp2yw0uLLhvNPe8tBtox@vger.kernel.org
X-Gm-Message-State: AOJu0YyjSkT5LHMzAXYEvytSyJdbv8iPnnNvqxwO7OFQgcEWX4VvtEUP
	JFiGd2CBLrckOdX4urpSmv+Cg9OXwQtkUf5firEqDbuxT0e7zOydb5nIqI1G
X-Google-Smtp-Source: AGHT+IEetcUEoGQufw0Ff3zP/g1mpAEAlXaV0Oy1iQBZtgE+yk6XaAdXNESGqxQBKRshTHAkJYmOTA==
X-Received: by 2002:a05:6902:27c3:b0:e26:18f0:5f7b with SMTP id 3f1490d57ef6-e2618f0707cmr2892355276.0.1727706180930;
        Mon, 30 Sep 2024 07:23:00 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e25e6c3285esm2256800276.64.2024.09.30.07.23.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 07:23:00 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e116d2f5f7fso4189092276.1;
        Mon, 30 Sep 2024 07:23:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUCf8MRYJHINUw+yD5wyZCkb4Z7EUTxzIWuMMILeZv6w8JSrx9GsUiKciMHP53u94JFv/ki7g49oabaK0Qp@vger.kernel.org, AJvYcCUdNRB3KIoIHr/l6rOO8R4vtCIrDvYheOxMbOxnnonpRjSq8KycSzHRRrbXyz/w/4/XU9N12kc+dbICu+7C@vger.kernel.org
X-Received: by 2002:a05:690c:55c6:b0:6dd:c6a8:5778 with SMTP id
 00721157ae682-6e245386765mr82710077b3.14.1727706179826; Mon, 30 Sep 2024
 07:22:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830032840.3783206-1-hsiangkao@linux.alibaba.com>
 <CAMuHMdVqa2Mjqtqv0q=uuhBY1EfTaa+X6WkG7E2tEnKXJbTkNg@mail.gmail.com> <20240930141819.tabcwa3nk5v2mkwu@quack3>
In-Reply-To: <20240930141819.tabcwa3nk5v2mkwu@quack3>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 30 Sep 2024 16:22:47 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU8chLLwxMqwm8DE6_6894q1w=ePJ=hgD34HmNQfJE0PQ@mail.gmail.com>
Message-ID: <CAMuHMdU8chLLwxMqwm8DE6_6894q1w=ePJ=hgD34HmNQfJE0PQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] erofs: add file-backed mount support
To: Jan Kara <jack@suse.cz>
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org, 
	LKML <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Linux FS Devel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jan,

On Mon, Sep 30, 2024 at 4:18=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> On Tue 24-09-24 11:21:59, Geert Uytterhoeven wrote:
> > On Fri, Aug 30, 2024 at 5:29=E2=80=AFAM Gao Xiang <hsiangkao@linux.alib=
aba.com> wrote:
> > > It actually has been around for years: For containers and other sandb=
ox
> > > use cases, there will be thousands (and even more) of authenticated
> > > (sub)images running on the same host, unlike OS images.
> > >
> > > Of course, all scenarios can use the same EROFS on-disk format, but
> > > bdev-backed mounts just work well for OS images since golden data is
> > > dumped into real block devices.  However, it's somewhat hard for
> > > container runtimes to manage and isolate so many unnecessary virtual
> > > block devices safely and efficiently [1]: they just look like a burde=
n
> > > to orchestrators and file-backed mounts are preferred indeed.  There
> > > were already enough attempts such as Incremental FS, the original
> > > ComposeFS and PuzzleFS acting in the same way for immutable fses.  As
> > > for current EROFS users, ComposeFS, containerd and Android APEXs will
> > > be directly benefited from it.
> > >
> > > On the other hand, previous experimental feature "erofs over fscache"
> > > was once also intended to provide a similar solution (inspired by
> > > Incremental FS discussion [2]), but the following facts show file-bac=
ked
> > > mounts will be a better approach:
> > >  - Fscache infrastructure has recently been moved into new Netfslib
> > >    which is an unexpected dependency to EROFS really, although it
> > >    originally claims "it could be used for caching other things such =
as
> > >    ISO9660 filesystems too." [3]
> > >
> > >  - It takes an unexpectedly long time to upstream Fscache/Cachefiles
> > >    enhancements.  For example, the failover feature took more than
> > >    one year, and the deamonless feature is still far behind now;
> > >
> > >  - Ongoing HSM "fanotify pre-content hooks" [4] together with this wi=
ll
> > >    perfectly supersede "erofs over fscache" in a simpler way since
> > >    developers (mainly containerd folks) could leverage their existing
> > >    caching mechanism entirely in userspace instead of strictly follow=
ing
> > >    the predefined in-kernel caching tree hierarchy.
> > >
> > > After "fanotify pre-content hooks" lands upstream to provide the same
> > > functionality, "erofs over fscache" will be removed then (as an EROFS
> > > internal improvement and EROFS will not have to bother with on-demand
> > > fetching and/or caching improvements anymore.)
> > >
> > > [1] https://github.com/containers/storage/pull/2039
> > > [2] https://lore.kernel.org/r/CAOQ4uxjbVxnubaPjVaGYiSwoGDTdpWbB=3Dw_A=
eM6YM=3DzVixsUfQ@mail.gmail.com
> > > [3] https://docs.kernel.org/filesystems/caching/fscache.html
> > > [4] https://lore.kernel.org/r/cover.1723670362.git.josef@toxicpanda.c=
om
> > >
> > > Closes: https://github.com/containers/composefs/issues/144
> > > Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> >
> > Thanks for your patch, which is now commit fb176750266a3d7f
> > ("erofs: add file-backed mount support").
> >
> > > ---
> > > v2:
> > >  - should use kill_anon_super();
> > >  - add O_LARGEFILE to support large files.
> > >
> > >  fs/erofs/Kconfig    | 17 ++++++++++
> > >  fs/erofs/data.c     | 35 ++++++++++++---------
> > >  fs/erofs/inode.c    |  5 ++-
> > >  fs/erofs/internal.h | 11 +++++--
> > >  fs/erofs/super.c    | 76 +++++++++++++++++++++++++++++--------------=
--
> > >  5 files changed, 100 insertions(+), 44 deletions(-)
> > >
> > > diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
> > > index 7dcdce660cac..1428d0530e1c 100644
> > > --- a/fs/erofs/Kconfig
> > > +++ b/fs/erofs/Kconfig
> > > @@ -74,6 +74,23 @@ config EROFS_FS_SECURITY
> > >
> > >           If you are not using a security module, say N.
> > >
> > > +config EROFS_FS_BACKED_BY_FILE
> > > +       bool "File-backed EROFS filesystem support"
> > > +       depends on EROFS_FS
> > > +       default y
> >
> > I am a bit reluctant to have this default to y, without an ack from
> > the VFS maintainers.
>
> Well, we generally let filesystems do whatever they decide to do unless i=
t
> is a affecting stability / security / maintainability of the whole system=
.
> In this case I don't see anything that would be substantially different
> than if we go through a loop device. So although the feature looks somewh=
at
> unusual I don't see a reason to nack it or otherwise interfere with
> whatever the fs maintainer wants to do. Are you concerned about a
> particular problem?

I was just wondering if there are any issues with accessing files directly.
If you're fine with it, I am, too.
Thanks!

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

