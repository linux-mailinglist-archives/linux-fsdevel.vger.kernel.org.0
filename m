Return-Path: <linux-fsdevel+bounces-23059-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A89092676F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 19:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD2491C22AE6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 17:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3230B185088;
	Wed,  3 Jul 2024 17:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmQ2yvYJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5461C68D
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jul 2024 17:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720028984; cv=none; b=D0WaV//lRYn0TdqFbD9gDJ/I1uKGSuPJp6wwNSQwmfff45yE8MEX2g2QRcjTr9Ge6SwXkJ/wN/JANxynEmb03U2L52TDYFxezXTigIyiSHav9yir/dZIfMbMazq04Nzgt3nCExQ0RxYXWGa0hwqyoNYi6zSwE/aZKcT3T4yji54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720028984; c=relaxed/simple;
	bh=ChpfPyrkoSjg4URxapSgdXkSVpUgBeDoPJekAD4BHc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QLwvzWbhxjwson7xalCJjOC62nF2SUV0us02T37OODoJ1DkuYUXVjtiH2+TsnR1X3LBiv9UxVVqlXnGBMznL3S9pL/cCD7zjHdVzwE6WiqKy/l3/pQS6sT5luOtDYda3lribp6YhhI2BgyJIoyKSOWbZfn90N+EX0eGbhEpbHTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dmQ2yvYJ; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4463682e944so35115391cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jul 2024 10:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720028982; x=1720633782; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=koYlFFsPjbxhLWytdSmiIClHFBZC7zJJBYQtCKHUpRg=;
        b=dmQ2yvYJgtWsRfR6sQooAAT5Cj0zw1ZjlRJyVqYhr8vBM6Grgw3YfChpqRRwlcTrQV
         p2zPuZQMc/WSI/B0/r9LyRP2Q88QHDMPn6iDVnXz4t0yb+TSjI+dqeEpdN6eIv1s/YNk
         6BKeZuW9ul2E9CQ1cE4v+/J7mbqDFDxL1AuR4oQ8JF6ghwYfzCiWSOvnWOrWyH4J8jjd
         ISuQvnU4VqeV3AyNZVQxT7O7RE0ZdS0Pm/JN0ONcCURYWt/imIuJZ6HxT1G+sBtMubLK
         M4vZ5vxpoy+Ue/s7xGg6lRkHjPJesF3KFmhTqrATpMMS9BVfQ0J8mGetxAUCYrAcFFkb
         n63w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720028982; x=1720633782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=koYlFFsPjbxhLWytdSmiIClHFBZC7zJJBYQtCKHUpRg=;
        b=AWBwQU8YQX6til243MPqGtHCAhyqxeZbt6R6QpERhUYffUO0PofALWgjkxbQqDNNA8
         ouFq36JvrzCJzkWGICEDpDbESSo15VqpC5dDmq86yCWUafmzsNIitWdWEtAz+PLlMqxP
         uO51lGirty/rqxQtXcgvApXfQbvFYm8vQanvdQj47Ki3SR7Z7dmImRduHsaImRYS4Tzt
         w1q+MHssPkhlP9s2VnbaHxn5hTYczl2NxWjQhNDoEOiHK7V1aiRq/3zfWR/7lX6ySZDZ
         Obn+ofR9wFkkbdvYRYLnbkvf+K2atUt2950Ue3wI4NhUfNTDz37rCKoRnIFHH4CQP0Sk
         9qrg==
X-Forwarded-Encrypted: i=1; AJvYcCU2q9WcwrLx+VJstZ8X6HOpTcIF3q0s7FntCiqkUeCjxgQ9pSt9AlmNybm7LvIswWPQaGAZ4JxqKQTl7Y/CWGqhWbdQjRlfgfZxQpeomw==
X-Gm-Message-State: AOJu0Yz20MST5Ro/o7d+R6wmxr0WB2GLlEgftk1S22LJEZrTLVLGFVy5
	2iFo65vDLg095hoyR/FsZMvhaoC0Fmt6B+yv3EvOjn6uhTY+aV8fE9Ovnem7LzfKUuaRFAD4mmT
	5cba7wyEvOh59K2oXK7plkkIp09/iuKuY
X-Google-Smtp-Source: AGHT+IGma0MbUpz4jR+o4WYXXkUGwpazyP51JvOOYoXgGueqYn8qfWJhxWN4DQ3kfWyiKB0PE3h1X2egdrctY7OXC1w=
X-Received: by 2002:a05:622a:11c9:b0:446:54e8:5260 with SMTP id
 d75a77b69052e-44662e4d547mr142267051cf.40.1720028982019; Wed, 03 Jul 2024
 10:49:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702163108.616342-1-bschubert@ddn.com> <20240703151549.GC734942@perftesting>
 <e6a58319-e6b1-40dc-81b8-11bd3641a9ca@fastmail.fm> <20240703173017.GB736953@perftesting>
In-Reply-To: <20240703173017.GB736953@perftesting>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 3 Jul 2024 10:49:31 -0700
Message-ID: <CAJnrk1bYf85ipt2Hf1id-OBOzaASOeegOxnn3vGtUxYHNp3xHg@mail.gmail.com>
Subject: Re: [PATCH] fuse: Allow to align reads/writes
To: Josef Bacik <josef@toxicpanda.com>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, Bernd Schubert <bschubert@ddn.com>, miklos@szeredi.hu, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 10:30=E2=80=AFAM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> On Wed, Jul 03, 2024 at 05:58:20PM +0200, Bernd Schubert wrote:
> >
> >
> > On 7/3/24 17:15, Josef Bacik wrote:
> > > On Tue, Jul 02, 2024 at 06:31:08PM +0200, Bernd Schubert wrote:
> > >> Read/writes IOs should be page aligned as fuse server
> > >> might need to copy data to another buffer otherwise in
> > >> order to fulfill network or device storage requirements.
> > >>
> > >> Simple reproducer is with libfuse, example/passthrough*
> > >> and opening a file with O_DIRECT - without this change
> > >> writing to that file failed with -EINVAL if the underlying
> > >> file system was using ext4 (for passthrough_hp the
> > >> 'passthrough' feature has to be disabled).
> > >>
> > >> Given this needs server side changes as new feature flag is
> > >> introduced.
> > >>
> > >> Disadvantage of aligned writes is that server side needs
> > >> needs another splice syscall (when splice is used) to seek
> > >> over the unaligned area - i.e. syscall and memory copy overhead.
> > >>
> > >> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> > >>
> > >> ---
> > >> From implementation point of view 'struct fuse_in_arg' /
> > >> 'struct fuse_arg' gets another parameter 'align_size', which has to
> > >> be set by fuse_write_args_fill. For all other fuse operations this
> > >> parameter has to be 0, which is guranteed by the existing
> > >> initialization via FUSE_ARGS and C99 style
> > >> initialization { .size =3D 0, .value =3D NULL }, i.e. other members =
are
> > >> zero.
> > >> Another choice would have been to extend fuse_write_in to
> > >> PAGE_SIZE - sizeof(fuse_in_header), but then would be an
> > >> arch/PAGE_SIZE depending struct size and would also require
> > >> lots of stack usage.
> > >
> > > Can I see the libfuse side of this?  I'm confused why we need the ali=
gn_size at
> > > all?  Is it enough to just say that this connection is aligned, negot=
iate what
> > > the alignment is up front, and then avoid sending it along on every w=
rite?
> >
> > Sure, I had forgotten to post it
> > https://github.com/bsbernd/libfuse/commit/89049d066efade047a72bcd1af8ad=
68061b11e7c
> >
> > We could also just act on fc->align_writes / FUSE_ALIGN_WRITES and alwa=
ys use
> > sizeof(struct fuse_in_header) + sizeof(struct fuse_write_in) in libfuse=
 and would
> > avoid to send it inside of fuse_write_in. We still need to add it to st=
ruct fuse_in_arg,
> > unless you want to check the request type within fuse_copy_args().
>
> I think I like this approach better, at the very least it allows us to us=
e the
> padding for other silly things in the future.
>

This approach seems cleaner to me as well.
I also like the idea of having callers pass in whether alignment
should be done or not to fuse_copy_args() instead of adding
"align_writes" to struct fuse_in_arg.

Thanks,
Joanne

> >
> > The part I don't like in general about current fuse header handling (be=
sides alignment)
> > is that any header size changes will break fuse server and therefore ne=
ed to be very
> > carefully handled. See for example libfuse commit 681a0c1178fa.
> >
>
> Agreed, if we could have the length of the control struct in the header t=
hen
> then things would be a lot simpler to extend later on, but here we are.  =
Thanks,
>
> Josef
>

