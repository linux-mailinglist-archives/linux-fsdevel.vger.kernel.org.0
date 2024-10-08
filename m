Return-Path: <linux-fsdevel+bounces-31364-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFA4995753
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 21:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 801FDB23E0B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 19:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C1C212F11;
	Tue,  8 Oct 2024 19:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FVHLw9yR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB8A20CCE3
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Oct 2024 19:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728414054; cv=none; b=l2H8ymYJ44F1ELMV6+p9ssN64E1/NPK3+T6VaIKPlSUlgw++FpY0EPWc58vxKw1rQwopFP+Rfvy76n/BXIO3Lllu0/ORUwZgokNFKZ/EWLfuu9atSerSBQaEE5GUHKfUGp3K4X/RmvwzmmvHKjm+d8Na6KsUSlpLOWjwl07OTXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728414054; c=relaxed/simple;
	bh=H1z5D9amXzr9ZFNWtcTs2meVxW3zikWgLHEjK+YobfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NhdgaCqslaaDULG9cMbKrbDNYZm9IqADBFNr8Hv7UBFBOqWVmx06mvjs6Rq/RR7t6dyVO6suObZTWqZYyYBarrCENg9rln7P8dOYZ7vpM+Q63eRIdkeiCxKCddjly9umf8vWFVPE5OudRNc98/azu04IEPbR6veUl8XCTOY4QHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FVHLw9yR; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-45f091bf433so1964561cf.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Oct 2024 12:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728414051; x=1729018851; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PM5EScssvnu4iQUm+gnmxja4N6Xs8nkBrG1P0ES5izc=;
        b=FVHLw9yR9PbaNeSmTMVw4pFjbUuMuR9WhOEb6IneDNrxaZycNnHtXN8kTSYssxd9eH
         C4uXtuMJydrnRTSO/TITH3E0Emncq54fWbB0MrxGar9/h0cOZV07Ijs8OY+8axPJVNm0
         8VFlx8JkJPrT0EeYHwhhuEKj4esojSjBbjsU/CtougKVBcjcYzxih4mLWOIzyxDy7f2X
         qowqukQ2We5v9Iq+Nb/jfIBiOpPygv3VYH1OuoS+7hz12nPtGsqmos8pX1xI2u/5AmCQ
         7s95skwKBRDx0hjnalqkbiMCyoXkyHloqYVq7RlIecIzozyno/xhxTjzHURQlKxtcuMd
         84rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728414051; x=1729018851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PM5EScssvnu4iQUm+gnmxja4N6Xs8nkBrG1P0ES5izc=;
        b=m4oJE8GNVy8XIeuJ7JWocdgCx6GNlbyAsFx7skCm4qY3rZlJ/So5/5bJ4+RXl55CGU
         OalznmfBrrrUz1hrTI7TgMU8SjIJjk/WMLStSz05TMUBbBaidUPNnl8SJv4l64GIZvsb
         P//PszIMPmmwrDb8hKMOSo6HOYAJi+PC6usf1PzMUJDYLC/Uef0Hu0ZDK7xKi+rKCjR6
         Wlw0SCwZ+kkahDH5EslCzph36Hj4eD1HptFSe5JTfMLwnfXZ+vE/YE2eLIWptEzWItjo
         YfIcYs6UUe+Fi0n02x7o37+EjnAsYf44wHD7La35ihfn1zyFlQHo7LaJHgt22a0a0QsG
         cs/w==
X-Forwarded-Encrypted: i=1; AJvYcCVAw9v2rw0VHIvwGdJt7pyS9ZuoVH6APife+BxPQfKdI3rtPdNHAOLu5f9IZZKHidVn0zUjKyzzA9P+2WGq@vger.kernel.org
X-Gm-Message-State: AOJu0YzRDfdGRXMXEckq4mQwHri7mN7PJ9vO5/HDjBDEkUdGBFZln9Z0
	v4aQlAHaEp/lajpgOxaCBgNdgp3dKpcYE1jEPrbKL67uA8CsY3t3eDTH7Lyqkrr7rz1/H01l0F7
	dyucNB8EnikW8Utjzqf2Wgdlr0HE=
X-Google-Smtp-Source: AGHT+IHkxiOwPFzx9JCLgrU3w0PCzESuHeu7Tk/116otpIxE7s1tdBKId/A7QzWmkRknAZIZsfJFOMoavWy5rZ+7iwY=
X-Received: by 2002:a05:622a:2a19:b0:45e:fd94:7e37 with SMTP id
 d75a77b69052e-45efd947f25mr34399911cf.60.1728414051017; Tue, 08 Oct 2024
 12:00:51 -0700 (PDT)
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
 <CAJnrk1btbP-jDVttuh-skyAQyHR80to+u55g7BANzqW2af_+Qw@mail.gmail.com>
 <ebc29d73-ad5a-4fba-b892-1cea7f1b44d0@fastmail.fm> <CAJnrk1aqiJbzsDkXtc_-Nfb4dcx2pULYOKSHQvX92q4A60RG5A@mail.gmail.com>
In-Reply-To: <CAJnrk1aqiJbzsDkXtc_-Nfb4dcx2pULYOKSHQvX92q4A60RG5A@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 8 Oct 2024 12:00:40 -0700
Message-ID: <CAJnrk1ao1ycR+Y7nVj3xQOAKmsOa0zzqgcJQ6piqgmzF0MOUUA@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] fuse: add optional kernel-enforced timeout for requests
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	jefflexu@linux.alibaba.com, laoar.shao@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 9:26=E2=80=AFAM Joanne Koong <joannelkoong@gmail.com=
> wrote:
>
> On Mon, Oct 7, 2024 at 1:02=E2=80=AFPM Bernd Schubert
> <bernd.schubert@fastmail.fm> wrote:
> >
> > On 10/7/24 20:39, Joanne Koong wrote:
> > > On Tue, Oct 1, 2024 at 10:03=E2=80=AFAM Joanne Koong <joannelkoong@gm=
ail.com> wrote:
> > >>
> > >> On Sat, Sep 28, 2024 at 1:43=E2=80=AFAM Bernd Schubert
> > >> <bernd.schubert@fastmail.fm> wrote:
> > >>>
> > >>> Hi Joanne,
> > >>>
> > >>> On 9/27/24 21:36, Joanne Koong wrote:
> > >>>> On Mon, Sep 2, 2024 at 3:38=E2=80=AFAM Miklos Szeredi <miklos@szer=
edi.hu> wrote:
> > >>>>>
> > >>>>> On Fri, 30 Aug 2024 at 18:27, Joanne Koong <joannelkoong@gmail.co=
m> wrote:
> > >>>>>>
> > >>>>>> There are situations where fuse servers can become unresponsive =
or
> > >>>>>> stuck, for example if the server is in a deadlock. Currently, th=
ere's
> > >>>>>> no good way to detect if a server is stuck and needs to be kille=
d
> > >>>>>> manually.
> > >>>>>>
> > >>>>>> This commit adds an option for enforcing a timeout (in seconds) =
on
> > >>>>>> requests where if the timeout elapses without a reply from the s=
erver,
> > >>>>>> the connection will be automatically aborted.
> > >>>>>
> > >>>>> Okay.
> > >>>>>
> > >>>>> I'm not sure what the overhead (scheduling and memory) of timers,=
 but
> > >>>>> starting one for each request seems excessive.
> > >>>>
> > >>>> I ran some benchmarks on this using the passthrough_ll server and =
saw
> > >>>> roughly a 1.5% drop in throughput (from ~775 MiB/s to ~765 MiB/s):
> > >>>> fio --name randwrite --ioengine=3Dsync --thread --invalidate=3D1
> > >>>> --runtime=3D300 --ramp_time=3D10 --rw=3Drandwrite --size=3D1G --nu=
mjobs=3D4
> > >>>> --bs=3D4k --alloc-size 98304 --allrandrepeat=3D1 --randseed=3D1234=
5
> > >>>> --group_reporting=3D1 --directory=3D/root/fuse_mount
> > >>>>
> > >>>> Instead of attaching a timer to each request, I think we can inste=
ad
> > >>>> do the following:
> > >>>> * add a "start_time" field to each request tracking (in jiffies) w=
hen
> > >>>> the request was started
> > >>>> * add a new list to the connection that all requests get enqueued
> > >>>> onto. When the request is completed, it gets dequeued from this li=
st
> > >>>> * have a timer for the connection that fires off every 10 seconds =
or
> > >>>> so. When this timer is fired, it checks if "jiffies > req->start_t=
ime
> > >>>> + fc->req_timeout" against the head of the list to check if the
> > >>>> timeout has expired and we need to abort the request. We only need=
 to
> > >>>> check against the head of the list because we know every other req=
uest
> > >>>> after this was started later in time. I think we could even just u=
se
> > >>>> the fc->lock for this instead of needing a separate lock. In the w=
orst
> > >>>> case, this grants a 10 second upper bound on the timeout a user
> > >>>> requests (eg if the user requests 2 minutes, in the worst case the
> > >>>> timeout would trigger at 2 minutes and 10 seconds).
> > >>>>
> > >>>> Also, now that we're aborting the connection entirely on a timeout
> > >>>> instead of just aborting the request, maybe it makes sense to chan=
ge
> > >>>> the timeout granularity to minutes instead of seconds. I'm envisio=
ning
> > >>>> that this timeout mechanism will mostly be used as a safeguard aga=
inst
> > >>>> malicious or buggy servers with a high timeout configured (eg 10
> > >>>> minutes), and minutes seems like a nicer interface for users than =
them
> > >>>> having to convert that to seconds.
> > >>>>
> > >>>> Let me know if I've missed anything with this approach but if not,
> > >>>> then I'll submit v7 with this change.
> > >>>
> > >>>
> > >>> sounds great to me. Just, could we do this per fuse_dev to avoid a
> > >>> single lock for all cores?
> > >>>
> > >>
> > >> Will do! thanks for the suggestion - in that case, I'll add its own
> > >> spinlock for it too then.
> > >
> > > I realized while working on v7 that we can't do this per fuse device
> > > because the request is only associated with a device once it's read i=
n
> > > by the server (eg fuse_dev_do_read).
> > >
> > > I ran some rough preliminary benchmarks with
> > > ./libfuse/build/example/passthrough_ll  -o writeback -o max_threads=
=3D4
> > > -o source=3D~/fstests ~/fuse_mount
> > > and
> > > fio --name randwrite --ioengine=3Dsync --thread --invalidate=3D1
> > > --runtime=3D300 --ramp_time=3D10 --rw=3Drandwrite --size=3D1G --numjo=
bs=3D4
> > > --bs=3D4k --alloc-size 98304 --allrandrepeat=3D1 --randseed=3D12345
> > > --group_reporting=3D1 --directory=3Dfuse_mount
> > >
> > > and didn't see any noticeable difference in throughput (~37 MiB/sec o=
n
> > > my system) with vs without the timeout.
> > >
> >
> >
> > That is not much, isn't your limit the backend? I wonder what would hap=
pen
> > with 25GB/s I'm testing with. Wouldn't it make sense for this to test w=
ith
> > sequential large IO? And possibly with the passthrough-hp branch that
> > bypasses IO? And a NUMA system probably would be helpful as well.
> > I.e. to test the effect on the kernel side without having an IO limited
> > system?
> >
>
> The preliminary benchmarks yesterday were run on a VM because I had
> trouble getting consistent results between baseline runs (on origin
> w/out my changes) on my usual test machine. I'm going to get this
> sorted out and run some tests again.
>

I'll attach the updated benchmark numbers on this thread (v7 of the
timeout patchset) so that everything's in one place:
https://lore.kernel.org/linux-fsdevel/20241007184258.2837492-1-joannelkoong=
@gmail.com/T/#t

> What are you testing on that's giving you 25 GB/s?
>
> >
> > With the io-uring interface requests stay in queues from the in-coming =
CPU
> > so easier to achieve there, although I wonder for your use-case if it
> > wouldn't be sufficient to start the timer only when the request is on
> > the way to fuse-server? One disadvantage I see is that virtiofs would n=
eed
> > to be specially handled.
>
> Unfortunately I don't think it suffices to only start the timer when
> the request is on the way to the fuse server. If there's a malicious
> or deadlocked server, they might not read from /dev/fuse, but we would
> want to abort the connection in those cases as well.
>
>
> Thanks,
> Joanne
>
> >
> >
> > Thanks,
> > Bernd
> >
> >

