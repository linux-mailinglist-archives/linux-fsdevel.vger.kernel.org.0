Return-Path: <linux-fsdevel+bounces-31356-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 595E9995465
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 18:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2251B2544D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 16:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24971E0DBB;
	Tue,  8 Oct 2024 16:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJMv+CLT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8890C1DC046
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Oct 2024 16:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728404829; cv=none; b=i91RVN3RX5mV4WTTmxIGmXgdVdalwkBzHs1pNUaPVRBqW9To462U9AKqxmJxfohJMDEVELyKaHVl6F/qDE7hqr77z1ZXg8WiZE6HTXhIsLuETpGQWk1XaWeQ9EHtp31RFMET+GDIWDxAlnqJiE5zzVmW0aNpCORxS5EQXge515U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728404829; c=relaxed/simple;
	bh=p79qSCK8G6ustNgChigqEGGr8ZFkqxPuxhMUma2ggAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OkMnY60/T1aDoovBo1xD0N9W5wVKb/Q+R6znO+6Xfxtq3XM6LcaIERo8zmoFrNPoX/rjHfXBDBXIAjiHyPeIrQ1qUTSW7gInYzuZfqW5nVlYPFEH0Q65hsW31HYU5CoMn9CrmfDj3P3FBUsl0ee/PNGueeTbV3HP46KzwK+MHG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EJMv+CLT; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e28e6a1b11eso1476547276.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Oct 2024 09:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728404826; x=1729009626; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=os0Ua/pn/fLHN9xbfYloeFMbssLkyMlY/kHvzXMd/Ts=;
        b=EJMv+CLT5VWIvxlc8U+Y82MnNOuU+BrimMk8HDjYWNALUOPXRcCzubC5TklDg7OYM8
         Vr8fNvGteNBuaORS1aBTf6mxs9WQ/IVTVJAz5HBXoXEaCl7Sm0W01A83s2jSa+zBHKI9
         E0RxTAKWrvdV3Iac6ZcaQFdqrxanwSbr9sPrCa6hPulx5p0f9Vn2jnXHaqeNNvRho3Hu
         acedVpsywlXT/t7hWxgFVDftBgVAqan/n6OLFjyvFeDgp7VmYCE6mFrHgftOzZYKPdEs
         1KLTbsFuBml43iakChgANI3mWPX35/Giue3xT/Ka83wUbxEX0ouf369sfZQZdW0Ir69P
         9zvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728404826; x=1729009626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=os0Ua/pn/fLHN9xbfYloeFMbssLkyMlY/kHvzXMd/Ts=;
        b=fAf4G3QLIuY5q0k9wERR3Wo1bGd6G8hoCPpOkGvJbWMUGnE0yBykTOoeF4NEqNMrai
         dgP5RPXoCeqbsPKVp5aeIANdqZtuUxh2kIutCzxzjkjKpggCq+SzbQz+z+ncGmHuzuhY
         D3VRGFrX97q7Xt2BG39URMcKGRSxVyF6WCmlCNfQJUr/UvWbX6E+x49GYyN/U02Ly2QE
         atNpdZSgIDqu7DC0EgpR3NFT8avF53AGa9DPGVhqvi8RacsDyJ635p6AHso+Q+bfAdzx
         IWlIxVl/8gavbUv8rGeKftG+dfeMnc0z9YtoW5oGn6Yn/yGtfCEiv4oNJJn4XGeHu7fl
         x3cg==
X-Forwarded-Encrypted: i=1; AJvYcCUkdApKfpNRNAInuicpIhAFlW+TmLpOCHZR1dTzI+N9LJWh8yZDuSibeh+cdalkMegueHfnUa/u1nE/K5Nw@vger.kernel.org
X-Gm-Message-State: AOJu0Yx28XTXVyHv5mTyJRV9LawfMHETsdn4ws9I4IDxjPRdRSH9E+f1
	XkcGzJgDFpaWDzKtEbxEn6DzhdGIIzJvisLWkkZ2tLHeFl06B7zq9C6hiSKxXReV0y3dJAfyM36
	clK8mtUKzH+mSfavYDaf7sb9WsXTB/mNW
X-Google-Smtp-Source: AGHT+IEdnYL+w/NvPCTVVGxlEBWW3YoOYyT3aTmiu992SHNDho3tkpI2/NTuKIy7rY1sk/yYWndnuUSgmf9M3yiRzE0=
X-Received: by 2002:a05:6902:188a:b0:e25:8411:5fcd with SMTP id
 3f1490d57ef6-e2893922469mr13930592276.44.1728404826357; Tue, 08 Oct 2024
 09:27:06 -0700 (PDT)
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
 <CAJnrk1btbP-jDVttuh-skyAQyHR80to+u55g7BANzqW2af_+Qw@mail.gmail.com> <ebc29d73-ad5a-4fba-b892-1cea7f1b44d0@fastmail.fm>
In-Reply-To: <ebc29d73-ad5a-4fba-b892-1cea7f1b44d0@fastmail.fm>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 8 Oct 2024 09:26:55 -0700
Message-ID: <CAJnrk1aqiJbzsDkXtc_-Nfb4dcx2pULYOKSHQvX92q4A60RG5A@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] fuse: add optional kernel-enforced timeout for requests
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	jefflexu@linux.alibaba.com, laoar.shao@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 1:02=E2=80=AFPM Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
>
> On 10/7/24 20:39, Joanne Koong wrote:
> > On Tue, Oct 1, 2024 at 10:03=E2=80=AFAM Joanne Koong <joannelkoong@gmai=
l.com> wrote:
> >>
> >> On Sat, Sep 28, 2024 at 1:43=E2=80=AFAM Bernd Schubert
> >> <bernd.schubert@fastmail.fm> wrote:
> >>>
> >>> Hi Joanne,
> >>>
> >>> On 9/27/24 21:36, Joanne Koong wrote:
> >>>> On Mon, Sep 2, 2024 at 3:38=E2=80=AFAM Miklos Szeredi <miklos@szered=
i.hu> wrote:
> >>>>>
> >>>>> On Fri, 30 Aug 2024 at 18:27, Joanne Koong <joannelkoong@gmail.com>=
 wrote:
> >>>>>>
> >>>>>> There are situations where fuse servers can become unresponsive or
> >>>>>> stuck, for example if the server is in a deadlock. Currently, ther=
e's
> >>>>>> no good way to detect if a server is stuck and needs to be killed
> >>>>>> manually.
> >>>>>>
> >>>>>> This commit adds an option for enforcing a timeout (in seconds) on
> >>>>>> requests where if the timeout elapses without a reply from the ser=
ver,
> >>>>>> the connection will be automatically aborted.
> >>>>>
> >>>>> Okay.
> >>>>>
> >>>>> I'm not sure what the overhead (scheduling and memory) of timers, b=
ut
> >>>>> starting one for each request seems excessive.
> >>>>
> >>>> I ran some benchmarks on this using the passthrough_ll server and sa=
w
> >>>> roughly a 1.5% drop in throughput (from ~775 MiB/s to ~765 MiB/s):
> >>>> fio --name randwrite --ioengine=3Dsync --thread --invalidate=3D1
> >>>> --runtime=3D300 --ramp_time=3D10 --rw=3Drandwrite --size=3D1G --numj=
obs=3D4
> >>>> --bs=3D4k --alloc-size 98304 --allrandrepeat=3D1 --randseed=3D12345
> >>>> --group_reporting=3D1 --directory=3D/root/fuse_mount
> >>>>
> >>>> Instead of attaching a timer to each request, I think we can instead
> >>>> do the following:
> >>>> * add a "start_time" field to each request tracking (in jiffies) whe=
n
> >>>> the request was started
> >>>> * add a new list to the connection that all requests get enqueued
> >>>> onto. When the request is completed, it gets dequeued from this list
> >>>> * have a timer for the connection that fires off every 10 seconds or
> >>>> so. When this timer is fired, it checks if "jiffies > req->start_tim=
e
> >>>> + fc->req_timeout" against the head of the list to check if the
> >>>> timeout has expired and we need to abort the request. We only need t=
o
> >>>> check against the head of the list because we know every other reque=
st
> >>>> after this was started later in time. I think we could even just use
> >>>> the fc->lock for this instead of needing a separate lock. In the wor=
st
> >>>> case, this grants a 10 second upper bound on the timeout a user
> >>>> requests (eg if the user requests 2 minutes, in the worst case the
> >>>> timeout would trigger at 2 minutes and 10 seconds).
> >>>>
> >>>> Also, now that we're aborting the connection entirely on a timeout
> >>>> instead of just aborting the request, maybe it makes sense to change
> >>>> the timeout granularity to minutes instead of seconds. I'm envisioni=
ng
> >>>> that this timeout mechanism will mostly be used as a safeguard again=
st
> >>>> malicious or buggy servers with a high timeout configured (eg 10
> >>>> minutes), and minutes seems like a nicer interface for users than th=
em
> >>>> having to convert that to seconds.
> >>>>
> >>>> Let me know if I've missed anything with this approach but if not,
> >>>> then I'll submit v7 with this change.
> >>>
> >>>
> >>> sounds great to me. Just, could we do this per fuse_dev to avoid a
> >>> single lock for all cores?
> >>>
> >>
> >> Will do! thanks for the suggestion - in that case, I'll add its own
> >> spinlock for it too then.
> >
> > I realized while working on v7 that we can't do this per fuse device
> > because the request is only associated with a device once it's read in
> > by the server (eg fuse_dev_do_read).
> >
> > I ran some rough preliminary benchmarks with
> > ./libfuse/build/example/passthrough_ll  -o writeback -o max_threads=3D4
> > -o source=3D~/fstests ~/fuse_mount
> > and
> > fio --name randwrite --ioengine=3Dsync --thread --invalidate=3D1
> > --runtime=3D300 --ramp_time=3D10 --rw=3Drandwrite --size=3D1G --numjobs=
=3D4
> > --bs=3D4k --alloc-size 98304 --allrandrepeat=3D1 --randseed=3D12345
> > --group_reporting=3D1 --directory=3Dfuse_mount
> >
> > and didn't see any noticeable difference in throughput (~37 MiB/sec on
> > my system) with vs without the timeout.
> >
>
>
> That is not much, isn't your limit the backend? I wonder what would happe=
n
> with 25GB/s I'm testing with. Wouldn't it make sense for this to test wit=
h
> sequential large IO? And possibly with the passthrough-hp branch that
> bypasses IO? And a NUMA system probably would be helpful as well.
> I.e. to test the effect on the kernel side without having an IO limited
> system?
>

The preliminary benchmarks yesterday were run on a VM because I had
trouble getting consistent results between baseline runs (on origin
w/out my changes) on my usual test machine. I'm going to get this
sorted out and run some tests again.

What are you testing on that's giving you 25 GB/s?

>
> With the io-uring interface requests stay in queues from the in-coming CP=
U
> so easier to achieve there, although I wonder for your use-case if it
> wouldn't be sufficient to start the timer only when the request is on
> the way to fuse-server? One disadvantage I see is that virtiofs would nee=
d
> to be specially handled.

Unfortunately I don't think it suffices to only start the timer when
the request is on the way to the fuse server. If there's a malicious
or deadlocked server, they might not read from /dev/fuse, but we would
want to abort the connection in those cases as well.


Thanks,
Joanne

>
>
> Thanks,
> Bernd
>
>

