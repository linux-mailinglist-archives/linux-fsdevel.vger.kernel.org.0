Return-Path: <linux-fsdevel+bounces-11424-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EC3853B78
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 20:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD6141C26E3B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 19:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E2C60DC6;
	Tue, 13 Feb 2024 19:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcmjU3gs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425AF60BBE
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Feb 2024 19:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707853573; cv=none; b=fk5ZmnQNK4s7MhzoA4ExgBNnbQ1aRyWMS0bnIddjVm0lJqxHwDipQz28ClXjMBZYB7+w9vQjWuk6fQVfD5M4KoiguAL3VmwzFT3QFpgax/hs0+qwjx6Xe1fuJb62/wW+N5z8maedjyyaLKqeQYUlKlohJftImWMTWJtMc8jGwRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707853573; c=relaxed/simple;
	bh=RbDfP/KMGEth+3kSTcU1xLC7L1GOl5iMPziXMCk9WRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s8aE9SRAb7jhwSQz4+mlzCkGpG4YZHKhbtVlXu6nHyzVmwX0IsORSP8HcLkXv46Y4JGbQNvGkkm+EUkr7RTU4ClN/G6CoLlMpXBAC+ylANSYyirN2CzdCBBzdi14SpkMacEZFVf3opRWH8JS1JNxL0fyuopKs26VpRXKv+xZeQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KcmjU3gs; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a3be744df3fso500797566b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Feb 2024 11:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707853569; x=1708458369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uQx4By0jSDouJwi4s5NdwNmViJCcNqrnaQajLGkTfGQ=;
        b=KcmjU3gsgJzCbKQsLRFb933PD5fYFECsk2Cdl8Uhc4KXdtX/GSTIbO0/4+JH7VCCF7
         kljafDo3L5mCrl321oXuX6GEAF4D3VMDHKZbSrf4k6cNYwdALa27+OLbNNDjoyYqq+0j
         uizdVbLjLqCIg9sR4gM3sAY6pB8yn116wmXQKElC29jIUf1mkuNuU7wDObEy1f6z/7nX
         lqZvub/fHIJxVCOjP2Z9+Lzt0IaTvrx8Nny86/U/uiqDP6XkRBWQ2royHwS1Qsk8KteA
         kEsWdMlbplic5Ri3WV0uGG9/WCHwzWDL6gUYujihnEBrGlDD1dj9O+PB30EpZa3ToQJk
         p+1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707853569; x=1708458369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uQx4By0jSDouJwi4s5NdwNmViJCcNqrnaQajLGkTfGQ=;
        b=r9ejl/o+7VehrELif3YVQiackrtQdEiTA72RrByGL9275T+9dViEOXQa6neA+1TUkR
         3fnNDwRFwRlDJ/iC9IUJpOpdMpED7OOfBF6hoXAUYQub2cgfhficy7Yvwze48DW6vENl
         KcY3yQBvaZmVschi6SLcXiprzH8QIo7qWoNf4JvqIWDpqsSxdCrdxRoWHVzbbc8V77fY
         1Jd0N58+I6/T6SdQqHnz6iwVVaMI9I2iIyoMoAxntC9XzNJMbprgihIKZ5mmRJcOMOQz
         Do25oXXZ/bP/y7p/DU0LIxWRU6/AY76YnpSOvA8TWu1Vd7KNxTPl/sh64hg45Bw7Zsk/
         +vDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuVhcDVJIKxbhXmt4sOP09+ioOgsEYINDnWqzS0AHwKSsB4OWYE0ChAOWJl0JLdy33gieARIjTqZK17G1vFQF1VvhJ7IfslYbUTFpFZA==
X-Gm-Message-State: AOJu0YwynoF1C9eeiJpYYlm6LpIXn7ESYPi3smNXZPk8nZUUa9CGiQWa
	PYcvjcFc1Es1lafH5gc7w7kfXEZHKdI7pv1lQmpC46sXlXvzyR6fWToT8Pqbf4oNazW7qKywYRd
	/NQRE2OgpkJ7//iDRBHaDJHFjmIBtWf2OWpE=
X-Google-Smtp-Source: AGHT+IHF/GOwf2HV5tfGJ29p5vTYmP1MIsT9LmMsGvbeGPNrAHuIULT7OTtX4FCYkcrII5Zt2v5MH2ZeRlTUYginhtw=
X-Received: by 2002:a17:906:d111:b0:a38:350:bbdd with SMTP id
 b17-20020a170906d11100b00a380350bbddmr214077ejz.48.1707853569255; Tue, 13 Feb
 2024 11:46:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116113247.758848-1-amir73il@gmail.com> <20240116120434.gsdg7lhb4pkcppfk@quack3>
 <CAOQ4uxjioTjpxueE8OF_SjgqknDAsDVmCbG6BSmGLB_kqXRLmg@mail.gmail.com>
 <20240124160758.zodsoxuzfjoancly@quack3> <CAOQ4uxiDyULTaJcBsYy_GLu8=DVSRzmntGR2VOyuOLsiRDZPhw@mail.gmail.com>
In-Reply-To: <CAOQ4uxiDyULTaJcBsYy_GLu8=DVSRzmntGR2VOyuOLsiRDZPhw@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 13 Feb 2024 21:45:56 +0200
Message-ID: <CAOQ4uxj-waY5KZ20-=F4Gb3F196P-2bc4Q1EDcr_GDraLZHsKQ@mail.gmail.com>
Subject: Re: [PATCH v3] fsnotify: optimize the case of no parent watcher
To: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 6:20=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Wed, Jan 24, 2024 at 6:08=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> >
> > On Tue 16-01-24 14:53:00, Amir Goldstein wrote:
> > > On Tue, Jan 16, 2024 at 2:04=E2=80=AFPM Jan Kara <jack@suse.cz> wrote=
:
> > > >
> > > > On Tue 16-01-24 13:32:47, Amir Goldstein wrote:
> > > > > If parent inode is not watching, check for the event in masks of
> > > > > sb/mount/inode masks early to optimize out most of the code in
> > > > > __fsnotify_parent() and avoid calling fsnotify().
> > > > >
> > > > > Jens has reported that this optimization improves BW and IOPS in =
an
> > > > > io_uring benchmark by more than 10% and reduces perf reported CPU=
 usage.
> > > > >
> > > > > before:
> > > > >
> > > > > +    4.51%  io_uring  [kernel.vmlinux]  [k] fsnotify
> > > > > +    3.67%  io_uring  [kernel.vmlinux]  [k] __fsnotify_parent
> > > > >
> > > > > after:
> > > > >
> > > > > +    2.37%  io_uring  [kernel.vmlinux]  [k] __fsnotify_parent
> > > > >
> > > > > Reported-and-tested-by: Jens Axboe <axboe@kernel.dk>
> > > > > Link: https://lore.kernel.org/linux-fsdevel/b45bd8ff-5654-4e67-90=
a6-aad5e6759e0b@kernel.dk/
> > > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > > ---
> > > > >
> > > > > Jan,
> > > > >
> > > > > Considering that this change looks like a clear win and it actual=
ly
> > > > > the change that you suggested, I cleaned it up a bit and posting =
for
> > > > > your consideration.
> > > >
> > > > Agreed, I like this. What did you generate this patch against? It d=
oes not
> > > > apply on top of current Linus' tree (maybe it needs the change sitt=
ing in
> > > > VFS tree - which is fine I can wait until that gets merged)?
> > > >
> > >
> > > Yes, it is on top of Christian's vfs-fixes branch.
> >
> > Merged your improvement now (and I've split off the cleanup into a sepa=
rate
> > change and dropped the creation of fsnotify_path() which seemed a bit
> > pointless with a single caller). All pushed out.
> >
>

Jan & Jens,

Although Jan has already queued this v3 patch with sufficient performance
improvement for Jens' workloads, I got a performance regression report from
kernel robot on will-it-scale microbenchmark (buffered write loop)
on my fan_pre_content patches, so I tried to improve on the existing soluti=
on.

I tried something similar to v1/v2 patches, where the sb keeps accounting
of the number of watchers for specific sub-classes of events.

I've made two major changes:
1. moved to counters into a per-sb state object fsnotify_sb_connector
    as Christian requested
2. The counters are by fanotify classes, not by specific events, so they
    can be used to answer the questions:
a) Are there any fsnotify watchers on this sb?
b) Are there any fanotify permission class listeners on this sb?
c) Are there any fanotify pre-content (a.k.a HSM) class listeners on this s=
b?

I think that those questions are very relevant in the real world, because
a positive answer to (b) and (c) is quite rare in the real world, so the
overhead on the permission hooks could be completely eliminated in
the common case.

If needed, we can further bisect the class counters per specific painful
events (e.g. FAN_ACCESS*), but there is no need to do that before
we see concrete benchmark results.

Jens,

If you feel like it, you can see if this branch further improves your
workloads:

https://github.com/amir73il/linux/commits/fsnotify-perf/

Jan,

Whenever you have the time, feel free to see if this is a valid direction,
if not for the perf optimization then we are going to need the
fsnotify_sb_connector container for other features as well.

Thanks!
Amir.

