Return-Path: <linux-fsdevel+bounces-31505-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EEF9979C0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 02:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71FC71F2214D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 00:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53BED26D;
	Thu, 10 Oct 2024 00:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6oFv1b1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5829B646
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Oct 2024 00:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728521109; cv=none; b=XpzrV51QUldigzsTxRklGSbrSZ54o115xKHB3sLKpkXWuUh2lHfXocOfeNfRyy93TAPw0g5C2jchlLk8CV8kj88Xpj6mnjGJCyr/b8rpNjWaNkthBS1dD1DGYBvw2f3X2Ltejtz7+GodHwz5gDr9x3hKqtxT9ZgDvAbEl975fdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728521109; c=relaxed/simple;
	bh=3KBw4BPdx+TWSrB3/HJEmFrEokJVU56oESfgEK2ZxSw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XdUFwhQ5s/oLhHIoWtMmPs1/wOINT5xKD2GTr1hIGfH+fXSmHC3+ZZnV5P6HdqYUCkXVFZWKytFM7KRCWWhLZxuMXNcSF57P4seZ0TckS4BAOSA2CWto3TkcZflrcnXscr/6GFCf5l63aDE0Gga8E/oHghrE1yDon/+dMKP+SsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E6oFv1b1; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7afcf96affaso16400385a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Oct 2024 17:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728521106; x=1729125906; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rMSz4Wygzj84MjtTR6ZBV/1YeGdGNMYedHmWy7WbDgo=;
        b=E6oFv1b1MrfQaaYvFayCYVIAcchn11iqnWDw/AZCQxU2PCm6hyno+/JWmqIeRwcCqj
         uQE1yFYXxIssP5v3Lnd9ubPE0scqd6dZt0S+EAziis8vR/FU/6er+mKXl8i2ZAwklOeA
         WNxWJkavs99otAoZsHB2oy59i7pVcnXC17U/f016E7mpiDcJcUf4sJI3nvZhiuqQhoO2
         mRnKKhdjJ9v7YiLlCzWPuTOa+cCS4azgq0hjSs54MDrb0Mm0ghPOmUDx0lu6tGW58smE
         Ga7f6CH1No4+wqorJV9gE2wSDZpOWUHRmxzCGBWeWqOExDWEORi2C6seaqCsp2L+NM78
         dWNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728521106; x=1729125906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rMSz4Wygzj84MjtTR6ZBV/1YeGdGNMYedHmWy7WbDgo=;
        b=vt6hg36DvOXCL8S69SHnYmuQFCLDUtPPMYstJ0JbBmtIFWSzEXtzVCUq/qwmIRAmGs
         G2uNTil4evksis3BM3uhqzugcxJwCtmA31mAo9tGi/FJZxsndWZoqzu04+2Sd7KjreHw
         YjIzECsqU1r1VomsJPd1BKZD1naoP90pRliZoqSz44gUdEAXwBbuh/bH2vSGZF6gqfop
         ljhufjmXjpW3+Q2Du+ejtYFIViAnjL3AE+7MGcAVN8wjJShXL7x8c55ySz/p1Fhs5RYv
         FAc36uXabXVboyBUayWFLhi1FHy3zlcemY3hhllytaDPw9ayMypo4Rc8zSYiuq4AFgK7
         +gYw==
X-Gm-Message-State: AOJu0YwlN/uA6PJ7CST8S+A+vENQumCpAv4bfQCUN5YAVEQS5lascmXn
	jSWMgwcvLReDEPgxFW7LWqzhqHYceSuJFNDE5hy/sY1st5KjiTb5+bNRf+LFzidtxBS3eKEhT7P
	WFa4kM8IWyCk41YtruIHXgoXKp/I=
X-Google-Smtp-Source: AGHT+IEMKjgt+vqQPkKTB6qupFGEkRUuxazyZLXZDf037AJ6QMeny3WTUTVd4YNYMuFolcPxob3Mt/bEAACWQ3R7f/8=
X-Received: by 2002:a05:620a:4590:b0:7af:cd33:33b3 with SMTP id
 af79cd13be357-7b0874b2ee5mr655352685a.42.1728521106493; Wed, 09 Oct 2024
 17:45:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007184258.2837492-1-joannelkoong@gmail.com>
 <20241007184258.2837492-3-joannelkoong@gmail.com> <CAJfpegs9A7iBbZpPMF-WuR48Ho_=z_ZWfjrLQG2ob0k6NbcaUg@mail.gmail.com>
In-Reply-To: <CAJfpegs9A7iBbZpPMF-WuR48Ho_=z_ZWfjrLQG2ob0k6NbcaUg@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 9 Oct 2024 17:44:55 -0700
Message-ID: <CAJnrk1b7bfAWWq_pFP=4XH3ddc_9GtAM2mE7EgWnx2Od+UUUjQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] fuse: add optional kernel-enforced timeout for requests
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, laoar.shao@gmail.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 1:14=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu> w=
rote:
>
> On Mon, 7 Oct 2024 at 20:43, Joanne Koong <joannelkoong@gmail.com> wrote:
> >
> > There are situations where fuse servers can become unresponsive or
> > stuck, for example if the server is deadlocked. Currently, there's no
> > good way to detect if a server is stuck and needs to be killed manually=
.
> >
> > This commit adds an option for enforcing a timeout (in minutes) for
> > requests where if the timeout elapses without the server responding to
> > the request, the connection will be automatically aborted.
> >
> > Please note that these timeouts are not 100% precise. The request may
> > take an extra FUSE_TIMEOUT_TIMER_FREQ seconds beyond the set max timeou=
t
> > due to how it's internally implemented.
>
> One thing I worry about is adding more roadblocks on the way to making
> request queuing more scalable.
>
> Currently there's fc->num_waiting that's touched on all requests and
> bg_queue/bg_lock that are touched on background requests.  We should
> be trying to fix these bottlenecks instead of adding more.
>
> Can't we use the existing lists to scan requests?

Hi Miklos,

The existing lists we have are:
* fiq pending list (per connection)
* fpq io list and fpq processing (for its associated hash) list (per fuse d=
ev)
* bg queue (per connection)

If we wanted to reuse existing lists, we could do this in the timeout handl=
er:
* grab the fiq lock, check the head entry of the pending list, release the =
lock
* grab the bg lock, check the head entry of the bg_queue, release the lock
* for each connection's fuse dev, grab the fpq lock, check the head
entry of the fpq->io list, iterate through the fpq->processing's lists
for 256 hashes and check against the head entry, release the lock

but some requests could slip through for the following cases:
-- resend:
* Request is on the resend's to_queue list when the timeout handler
check runs, in which case if that request is expired we won't get to
that until the next time the timeout handler kicks in
* A re-sent request may be moved to the head of the fiq->pending list,
but have a creation time newer than other entries on the fiq->pending
list , in which case we would not time out and abort the connection
when we should be doing so
-- transitioning between lists
* A request that is between lists (eg fpq->io and fpq->processing)
could be missed when the timeout handler check runs (but will probably
be caught the next time the timeout handler kicks in. We could also
modify the logic in dev_do_read to use list_move to avoid this case).

I think it's fine for these edge cases to slip through since most of
them will be caught eventually by the subsequent timeout handler runs,
but I was more worried about the increased lock contention while
iterating through all hashes of the fpq->processing list. But I think
for that we could just increase the timeout frequency to run less
frequently (eg once every 5 minutes instead of once every minute)

Do you think something like this sounds more reasonable?

Alternatively, I also still like the idea of something looser with
just periodically (according to whatever specified timeout) checking
if any requests are being serviced at all when fc->num-waiting is
non-zero. However, this would only protect against fully deadlocked
servers and miss malicious ones or half-deadlocked ones (eg
multithreaded fuse servers where only some threads are deadlocked).


Thanks,
Joanne
>
> It's more complex, obviously, but at least it doesn't introduce yet
> another per-fc list to worry about.
>
> Thanks,
> Miklos

