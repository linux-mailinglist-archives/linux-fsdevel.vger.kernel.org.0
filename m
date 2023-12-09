Return-Path: <linux-fsdevel+bounces-5412-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBD280B5D1
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Dec 2023 19:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B464F1C209C9
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Dec 2023 18:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06A2199DA;
	Sat,  9 Dec 2023 18:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CfBV/dbC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE540DF
	for <linux-fsdevel@vger.kernel.org>; Sat,  9 Dec 2023 10:10:43 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3b9df0a6560so1879448b6e.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 09 Dec 2023 10:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1702145443; x=1702750243; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V11xL9Aa8YvYVLJTFNDlpelK2kGiXG8JTWvzX3erx2Q=;
        b=CfBV/dbCoLIkKW33mbXJOKOv69BPyDL6+2DaBmJIDfNyVFzmfnxV7Xpfle0afOYmoL
         kEunDxt+1Onuue2i8RcMu1fcHihZe3sjCT5ujHqcvdDzWGJuThxHwpQeZ9+6/4UZYfFg
         EYdJZk5aeRKnyo6YW3pseEdvk0hRqINfe+zNph05edWTGNtn0yUwSiEqFmB0DP/l40g3
         Yu7DmQM4SL4T++yOjh8azaZ1SFK6MxjMB82+h4xQ7VZaL8nK+ide72jv5PC82m8BwdOq
         lzNfnaL3wunvMqWxTz6aM4MFYLp6JZgMYqOuh+u5FnGtSTVfHLDN3EaJHPz3f4hr7jFx
         CRig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702145443; x=1702750243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V11xL9Aa8YvYVLJTFNDlpelK2kGiXG8JTWvzX3erx2Q=;
        b=fEq3WXSGx50xApmEhP0isMmznpKKpSEtq+FfiACs0b8nbamg4Ln/8JIwQQrhJ6EmpC
         ztSJt4u5uJ6AhQmaLQLC4cgj9xmx6lj92z7jFOjNyaOtvgRm26HA0dILpD8ypqzAzWFw
         Vix5/xkFFplSgvZDiTVv4W4wFjsQyn2+0vIdCCCYh7LoVFP9iKNJ4yAGyP5jHzmRrMPn
         71vZa3G2PCDu2GXyKNnVfT4pwKfNnY+fQgSk2c/rwPO4QrFaYOmgsZXIDDdO23YL6BKh
         yrZxRIr6RllWvZ4qMKkZQ+b4V4SsmzABlD1E8HJi+mBbbsnUvZgPgjMsBy4JQ7zMZUn6
         7+1g==
X-Gm-Message-State: AOJu0YzY8aEoT79tTWGXtRl3w9JEDpe5pEsUHx32OTmsNccPkiAdwLG0
	JR8bEl2nSMnV3Ni+zLpVKG9YPf+v0JyPxMVhukgf
X-Google-Smtp-Source: AGHT+IFEZQH73etgGzx5usHInucm01qu2+LECAk3oHtHXPrm52VYBiLQxUI/dRbppotdD+u1BlfffFQWBfn7p4LosHA=
X-Received: by 2002:a05:6808:1b11:b0:3b2:db86:209 with SMTP id
 bx17-20020a0568081b1100b003b2db860209mr2008922oib.38.1702145443139; Sat, 09
 Dec 2023 10:10:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7ba17c0d-49c6-4322-b196-3ecb7a371c62@schaufler-ca.com> <20231209011042.29059-1-kamatam@amazon.com>
In-Reply-To: <20231209011042.29059-1-kamatam@amazon.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sat, 9 Dec 2023 13:10:32 -0500
Message-ID: <CAHC9VhSiyZ_keXs7s9Me19YWrdb7hcRY7XecMPdEcj7Den9Cbw@mail.gmail.com>
Subject: Re: Fw: [PATCH] proc: Update inode upon changing task security attribute
To: Munehisa Kamata <kamatam@amazon.com>
Cc: casey@schaufler-ca.com, adobriyan@gmail.com, akpm@linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 8, 2023 at 8:11=E2=80=AFPM Munehisa Kamata <kamatam@amazon.com>=
 wrote:
> On Sat, 2023-12-09 00:24:42 +0000, Casey Schaufler wrote:
> > On 12/8/2023 3:32 PM, Paul Moore wrote:
> > > On Fri, Dec 8, 2023 at 6:21=E2=80=AFPM Casey Schaufler <casey@schaufl=
er-ca.com> wrote:
> > >> On 12/8/2023 2:43 PM, Paul Moore wrote:
> > >>> On Thu, Dec 7, 2023 at 9:14=E2=80=AFPM Munehisa Kamata <kamatam@ama=
zon.com> wrote:
> > >>>> On Tue, 2023-12-05 14:21:51 -0800, Paul Moore wrote:
> > >>> ..
> > >>>
> > >>>>> I think my thoughts are neatly summarized by Andrew's "yuk!" comm=
ent
> > >>>>> at the top.  However, before we go too much further on this, can =
we
> > >>>>> get clarification that Casey was able to reproduce this on a stoc=
k
> > >>>>> upstream kernel?  Last I read in the other thread Casey wasn't se=
eing
> > >>>>> this problem on Linux v6.5.
> > >>>>>
> > >>>>> However, for the moment I'm going to assume this is a real proble=
m, is
> > >>>>> there some reason why the existing pid_revalidate() code is not b=
eing
> > >>>>> called in the bind mount case?  From what I can see in the origin=
al
> > >>>>> problem report, the path walk seems to work okay when the file is
> > >>>>> accessed directly from /proc, but fails when done on the bind mou=
nt.
> > >>>>> Is there some problem with revalidating dentrys on bind mounts?
> > >>>> Hi Paul,
> > >>>>
> > >>>> https://lkml.kernel.org/linux-fsdevel/20090608201745.GO8633@ZenIV.=
linux.org.uk/
> > >>>>
> > >>>> After reading this thread, I have doubt about solving this in VFS.
> > >>>> Honestly, however, I'm not sure if it's entirely relevant today.
> > >>> Have you tried simply mounting proc a second time instead of using =
a bind mount?
> > >>>
> > >>>  % mount -t proc non /new/location/for/proc
> > >>>
> > >>> I ask because from your description it appears that proc does the
> > >>> right thing with respect to revalidation, it only becomes an issue
> > >>> when accessing proc through a bind mount.  Or did I misunderstand t=
he
> > >>> problem?
> > >> It's not hard to make the problem go away by performing some simple
> > >> action. I was unable to reproduce the problem initially because I
> > >> checked the Smack label on the bind mounted proc entry before doing
> > >> the cat of it. The problem shows up if nothing happens to update the
> > >> inode.
> > > A good point.
> > >
> > > I'm kinda thinking we just leave things as-is, especially since the
> > > proposed fix isn't something anyone is really excited about.
> >
> > "We have to compromise the performance of our sandboxing tool because o=
f
> > a kernel bug that's known and for which a fix is available."
> >
> > If this were just a curiosity that wasn't affecting real development I
> > might agree. But we've got a real world problem, and I don't see ignori=
ng
> > it as a good approach. I can't see maintainers of other LSMs thinking s=
o
> > if this were interfering with their users.
>
> We do bind mount to make information exposed to the sandboxed task as lit=
tle
> as possible. We also create a separate PID namespace for each sandbox, bu=
t
> still want to bind mount even with it to hide system-wide and pid 1
> information from the task.
>
> So, yeah, I see this as a real problem for our use case and want to seek =
an
> opinion about a possibly better fix.

First, can you confirm that this doesn't happen if you do a second
proc mount instead of a bind mount of the original /proc as requested
previously?

--=20
paul-moore.com

