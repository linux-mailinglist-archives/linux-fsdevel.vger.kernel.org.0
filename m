Return-Path: <linux-fsdevel+bounces-31247-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F084C993665
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 20:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 205991C23B40
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 18:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38091DE2A7;
	Mon,  7 Oct 2024 18:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DblzEoDl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9994C1D968B
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Oct 2024 18:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728326380; cv=none; b=RAOsP0jrdpmo5DQzRPd0VQ0REbepzaFAr49aoHGi53QnUIac+3bryBkpjG0gLnkab6rzIbXUm0Hq9paPNJLnjRSJ+q9vPsxK9BWXEMzi0/Au/dp8v8VqclhEi1sL3NPc/XY8FraaKGj07n4ad+3N5Avb+VfBHa0IkC75LR0AdWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728326380; c=relaxed/simple;
	bh=qXRRqv1FU4SgubgXZqLCEvDplB+d/oq1jdZqFvgoSQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dKjFJMYTwL62HDqteQYLtfyfX1hA7NuK+J5ScsXLQWycTPEunhbReHsfBGnAoH+ojlQoKOp5PjTrCVX2qa29hE56nCvh272723qmG7XfVButaRbV/18HBll+vxsvBXkRczjdrsZWFEbq1UP19yh1X/ChH0VCk2p04krf+ExOmuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DblzEoDl; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-458311b338eso39700551cf.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Oct 2024 11:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728326377; x=1728931177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rty/untGdg0geTPl+4jT82YQ+u8+t0s+TOFl+MzBcYg=;
        b=DblzEoDlSfh5cIiP2FHYHnjuHkw5eqcRuLHBOlCkiAZen2K1IJLU6Ib6JSQKmDkMMi
         WQO/lzWs2WXSiOGkTXksejwPTMIOovURDh68mple9xektO8DiAswj8EHwAnYeps6uZXb
         ueDmdHbIpTZoSDgVvbDRSRkoRvXteNE5zwOOZfFuARh5uSdZOnUEGT0tJLRJI4WUwh0U
         3iLJ+zxNHz6LrxV8Xn0p8AxOEsNWpo3wW9WlfGa02qndbIT0w83PPMOHKzv92MMk1auK
         0vWfLQ0neeDRSQDi5fKqmd1d863HPdUtQxYME3Hy8ADq022J92r9fe7I/gzh/GVDzhmK
         PBwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728326377; x=1728931177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rty/untGdg0geTPl+4jT82YQ+u8+t0s+TOFl+MzBcYg=;
        b=ULUURThUP8FgdVSL3me0IE1y1lF4Jc2b/OKA1mKPLbQSrMLeW9FS5OUyIbA8f6bqEy
         NT63pk0h7RMbS3pxmJgQyg/3MdpSA6Pb0WBZmKUxdr62iinL8JXz+OwQG16/dmuGpZxX
         eRwlrJp7It7FMZOoPVzymAKwft/rbLmQUpBQo8VwNeEYQxkX6VFAVcYsv2qFjubIOecM
         4YQpb3yTaMeE7IKc6yEmB84xUJhFE7d8BVlC+m4rk5WWC7zkWoJ+VQ/hB7Sac4BWCmoH
         ntJskyT9I4vJu2oeGr4UqiSyoWvur3/EcGyMFfo5j42HAIw8FeKzSIQefgPUyoTntPPS
         y40A==
X-Forwarded-Encrypted: i=1; AJvYcCVVcaQ9+e7HAibTZOrfdPydNLKQJEDs6jxheVL2/Z4MRue4I1YqgfNJShgjIwilo7GC8v99WWSs5IVzXOh8@vger.kernel.org
X-Gm-Message-State: AOJu0YymDWNTQ7DC1ouIOPWAXAUY+N8hpxEMzwNecaWvLUpL1H4fZFcB
	HdU0dd1Np3uaTzVzpAl8C/kYGz6cUd+5vs5WGemesvkLZ8yjMiZ2YoX7Zd9FS9/eNl4snCgzjSJ
	q+WSoPKmZOnOXMOp75pPEsKrrkYg=
X-Google-Smtp-Source: AGHT+IEAfbW9r2VAdj7KDnJUPJcMlggDl515yhGBNstck2FF1wmVsy46U+y9772GRKrPkPkG3w7eoeyy0YkVtn6PVYk=
X-Received: by 2002:a05:622a:1313:b0:458:3fec:e743 with SMTP id
 d75a77b69052e-45d9babe0b4mr183348681cf.47.1728326377461; Mon, 07 Oct 2024
 11:39:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830162649.3849586-1-joannelkoong@gmail.com>
 <20240830162649.3849586-2-joannelkoong@gmail.com> <CAJfpegug0MeX7HYDkAGC6fn9HaMtsWf2h3OyuepVQar7E5y0tw@mail.gmail.com>
 <CAJnrk1bdyDq+4jo29ZbyjdcbFiU2qyCGGbYbqQc_G23+B_Xe_Q@mail.gmail.com>
 <7d609efd-9e0e-45b1-8793-872161a24318@fastmail.fm> <CAJnrk1ZSoHq2Qg94z8NLDg5OLk6ezVA_aFjKEibSi7H5KDM+3Q@mail.gmail.com>
In-Reply-To: <CAJnrk1ZSoHq2Qg94z8NLDg5OLk6ezVA_aFjKEibSi7H5KDM+3Q@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 7 Oct 2024 11:39:26 -0700
Message-ID: <CAJnrk1btbP-jDVttuh-skyAQyHR80to+u55g7BANzqW2af_+Qw@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] fuse: add optional kernel-enforced timeout for requests
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	jefflexu@linux.alibaba.com, laoar.shao@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 10:03=E2=80=AFAM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> On Sat, Sep 28, 2024 at 1:43=E2=80=AFAM Bernd Schubert
> <bernd.schubert@fastmail.fm> wrote:
> >
> > Hi Joanne,
> >
> > On 9/27/24 21:36, Joanne Koong wrote:
> > > On Mon, Sep 2, 2024 at 3:38=E2=80=AFAM Miklos Szeredi <miklos@szeredi=
.hu> wrote:
> > >>
> > >> On Fri, 30 Aug 2024 at 18:27, Joanne Koong <joannelkoong@gmail.com> =
wrote:
> > >>>
> > >>> There are situations where fuse servers can become unresponsive or
> > >>> stuck, for example if the server is in a deadlock. Currently, there=
's
> > >>> no good way to detect if a server is stuck and needs to be killed
> > >>> manually.
> > >>>
> > >>> This commit adds an option for enforcing a timeout (in seconds) on
> > >>> requests where if the timeout elapses without a reply from the serv=
er,
> > >>> the connection will be automatically aborted.
> > >>
> > >> Okay.
> > >>
> > >> I'm not sure what the overhead (scheduling and memory) of timers, bu=
t
> > >> starting one for each request seems excessive.
> > >
> > > I ran some benchmarks on this using the passthrough_ll server and saw
> > > roughly a 1.5% drop in throughput (from ~775 MiB/s to ~765 MiB/s):
> > > fio --name randwrite --ioengine=3Dsync --thread --invalidate=3D1
> > > --runtime=3D300 --ramp_time=3D10 --rw=3Drandwrite --size=3D1G --numjo=
bs=3D4
> > > --bs=3D4k --alloc-size 98304 --allrandrepeat=3D1 --randseed=3D12345
> > > --group_reporting=3D1 --directory=3D/root/fuse_mount
> > >
> > > Instead of attaching a timer to each request, I think we can instead
> > > do the following:
> > > * add a "start_time" field to each request tracking (in jiffies) when
> > > the request was started
> > > * add a new list to the connection that all requests get enqueued
> > > onto. When the request is completed, it gets dequeued from this list
> > > * have a timer for the connection that fires off every 10 seconds or
> > > so. When this timer is fired, it checks if "jiffies > req->start_time
> > > + fc->req_timeout" against the head of the list to check if the
> > > timeout has expired and we need to abort the request. We only need to
> > > check against the head of the list because we know every other reques=
t
> > > after this was started later in time. I think we could even just use
> > > the fc->lock for this instead of needing a separate lock. In the wors=
t
> > > case, this grants a 10 second upper bound on the timeout a user
> > > requests (eg if the user requests 2 minutes, in the worst case the
> > > timeout would trigger at 2 minutes and 10 seconds).
> > >
> > > Also, now that we're aborting the connection entirely on a timeout
> > > instead of just aborting the request, maybe it makes sense to change
> > > the timeout granularity to minutes instead of seconds. I'm envisionin=
g
> > > that this timeout mechanism will mostly be used as a safeguard agains=
t
> > > malicious or buggy servers with a high timeout configured (eg 10
> > > minutes), and minutes seems like a nicer interface for users than the=
m
> > > having to convert that to seconds.
> > >
> > > Let me know if I've missed anything with this approach but if not,
> > > then I'll submit v7 with this change.
> >
> >
> > sounds great to me. Just, could we do this per fuse_dev to avoid a
> > single lock for all cores?
> >
>
> Will do! thanks for the suggestion - in that case, I'll add its own
> spinlock for it too then.

I realized while working on v7 that we can't do this per fuse device
because the request is only associated with a device once it's read in
by the server (eg fuse_dev_do_read).

I ran some rough preliminary benchmarks with
./libfuse/build/example/passthrough_ll  -o writeback -o max_threads=3D4
-o source=3D~/fstests ~/fuse_mount
and
fio --name randwrite --ioengine=3Dsync --thread --invalidate=3D1
--runtime=3D300 --ramp_time=3D10 --rw=3Drandwrite --size=3D1G --numjobs=3D4
--bs=3D4k --alloc-size 98304 --allrandrepeat=3D1 --randseed=3D12345
--group_reporting=3D1 --directory=3Dfuse_mount

and didn't see any noticeable difference in throughput (~37 MiB/sec on
my system) with vs without the timeout.


Thanks,
Joanne

>
> Thanks,
> Joanne
>
> >
> > Thanks,
> > Bernd

