Return-Path: <linux-fsdevel+bounces-30267-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0372988AC9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 21:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2962E1F21C25
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 19:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C411C2435;
	Fri, 27 Sep 2024 19:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCwrWm2K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F67C1C2423
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Sep 2024 19:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727465796; cv=none; b=fsesfoRIILDQGnsXgR3PfKQxRtlpaqd9XPLnZ8rzwYV+Y+QK0+Gco3H/d30ZkkkhXaHe3YeeyJY+AXFYCSVFuNdzR9pNxEdFqeGFHj5qxs9FHqkrrUDWtHVqSCr10cWQkF+ISRYTtAbGZWsliInSOicTN4IOWTZ4h3qgOyhSXow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727465796; c=relaxed/simple;
	bh=zUo9wOCoIBs9s0ZdzUKGlJzqiHjEL+tQX9vLN6loJYc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RL1sPvjt3nQvzKHymZnhrm1ikJpGa8fn0x29WRK/TLUQ4xM5cenLytDkzgYvZKJeVpk5ILwOqw7SDKVRu1C+v9DyhZFFVorhGt5AJoZTm6uGYyEBqSYOMdefGHqrjBfh3GlvnMqo0Z490WzmaUIRWVDKx7rizTljD6sDcYpsm4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dCwrWm2K; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3e03f8ecef8so1608305b6e.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Sep 2024 12:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727465794; x=1728070594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WNNPcl3DbNV2mUhfBdIqHgHZZo3XF893dzeGD4R0/xU=;
        b=dCwrWm2K5GVYR8Tj9S6X0KAQFx52Lgb2y7Yrn4y0ILTWGBUqUqQbEGxCgFDMJ+79dr
         zQhpqerLHwwoEGH7rjJ0QfKv6mIKlRHgo72Cm0AmAX4qaa0hRAWsxaW2dHASPO3FETdu
         VVHpWtnji6ig0gXmLI0iNqBaOtXDCHxm1PfNUonIsMr9Z60av8xCJwW0BSPn85oiaF5L
         kPTAIgTFRMSRdNXNcnRNPNoqPy5brUQKFhw1zX8hPP2gI35kKtRfB6kMIU9uErXhQ+MD
         /hLRA2hn858UbIG2jhUcVokn0gtbjLLYH6OoE5xT+uzo1KMkt+cc6lKg0hSyM0ZH4gk2
         zFyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727465794; x=1728070594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WNNPcl3DbNV2mUhfBdIqHgHZZo3XF893dzeGD4R0/xU=;
        b=v6Yel/a+zEYWFBm7p1IiDFJkKSsq+H2vUpvUnlLyRPkiy6fbfRX8Idu52dLKl3o0nP
         8skF/SjP+AkGJHOKAwZIBBzHErnQ6LriLTvgd0X5hi9mNiE2TvH/ny69g7lNp+WfT9i1
         T9PATKAfnsYza8B5TwvMP1oZ3aiBkHTYxOr6fjuuAKVy9aXQ9ggrKnTc4yRceeTAv2V7
         suBquoCJJmrEKxgrTdH1zJeUivtA8Q0kXWMde0HuYaG1WoTdJ4cmnQ0txOK8E0x8BBKd
         dlMVqM7n1A94XAWthonyPDMyO+CWlYhyqpnn47r2RlwAGj57o6jjlGm0UhrqZsE9s45U
         MtRQ==
X-Gm-Message-State: AOJu0Yxm8rDl4XcOwdYZwyqZiSxuyoTKNh814jwtTL9EteCtFrxtfKNv
	BzzoJOUQgX2lEX2d6ZGy34K9M/HvvJsUT0jC+s1wMn+MZSnIklwzenwZsQS6CCTZvx7x4pO6TjX
	P86+UnA0/CBZ8GCTh7DIuLiK4jgU=
X-Google-Smtp-Source: AGHT+IHZhaRkYXKZAKEJzwlMVZg7iU1Ac7VsadliXtIT6enC8olI2j1hc5Z+J7m2LNpPuliqTvh+K7plaEzjU1k1zeY=
X-Received: by 2002:a05:6808:10c1:b0:3e2:8483:dbe3 with SMTP id
 5614622812f47-3e3939d4684mr3709364b6e.35.1727465794146; Fri, 27 Sep 2024
 12:36:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830162649.3849586-1-joannelkoong@gmail.com>
 <20240830162649.3849586-2-joannelkoong@gmail.com> <CAJfpegug0MeX7HYDkAGC6fn9HaMtsWf2h3OyuepVQar7E5y0tw@mail.gmail.com>
In-Reply-To: <CAJfpegug0MeX7HYDkAGC6fn9HaMtsWf2h3OyuepVQar7E5y0tw@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 27 Sep 2024 12:36:23 -0700
Message-ID: <CAJnrk1bdyDq+4jo29ZbyjdcbFiU2qyCGGbYbqQc_G23+B_Xe_Q@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] fuse: add optional kernel-enforced timeout for requests
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, laoar.shao@gmail.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 2, 2024 at 3:38=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu> w=
rote:
>
> On Fri, 30 Aug 2024 at 18:27, Joanne Koong <joannelkoong@gmail.com> wrote=
:
> >
> > There are situations where fuse servers can become unresponsive or
> > stuck, for example if the server is in a deadlock. Currently, there's
> > no good way to detect if a server is stuck and needs to be killed
> > manually.
> >
> > This commit adds an option for enforcing a timeout (in seconds) on
> > requests where if the timeout elapses without a reply from the server,
> > the connection will be automatically aborted.
>
> Okay.
>
> I'm not sure what the overhead (scheduling and memory) of timers, but
> starting one for each request seems excessive.

I ran some benchmarks on this using the passthrough_ll server and saw
roughly a 1.5% drop in throughput (from ~775 MiB/s to ~765 MiB/s):
fio --name randwrite --ioengine=3Dsync --thread --invalidate=3D1
--runtime=3D300 --ramp_time=3D10 --rw=3Drandwrite --size=3D1G --numjobs=3D4
--bs=3D4k --alloc-size 98304 --allrandrepeat=3D1 --randseed=3D12345
--group_reporting=3D1 --directory=3D/root/fuse_mount

Instead of attaching a timer to each request, I think we can instead
do the following:
* add a "start_time" field to each request tracking (in jiffies) when
the request was started
* add a new list to the connection that all requests get enqueued
onto. When the request is completed, it gets dequeued from this list
* have a timer for the connection that fires off every 10 seconds or
so. When this timer is fired, it checks if "jiffies > req->start_time
+ fc->req_timeout" against the head of the list to check if the
timeout has expired and we need to abort the request. We only need to
check against the head of the list because we know every other request
after this was started later in time. I think we could even just use
the fc->lock for this instead of needing a separate lock. In the worst
case, this grants a 10 second upper bound on the timeout a user
requests (eg if the user requests 2 minutes, in the worst case the
timeout would trigger at 2 minutes and 10 seconds).

Also, now that we're aborting the connection entirely on a timeout
instead of just aborting the request, maybe it makes sense to change
the timeout granularity to minutes instead of seconds. I'm envisioning
that this timeout mechanism will mostly be used as a safeguard against
malicious or buggy servers with a high timeout configured (eg 10
minutes), and minutes seems like a nicer interface for users than them
having to convert that to seconds.

Let me know if I've missed anything with this approach but if not,
then I'll submit v7 with this change.


Thanks,
Joanne

>
> Can we make the timeout per-connection instead of per request?
>
> I.e. When the first request is sent, the timer is started. When a
> reply is received but there are still outstanding requests, the timer
> is reset.  When the last reply is received, the timer is stopped.
>
> This should handle the frozen server case just as well.  It may not
> perfectly handle the case when the server is still alive but for some
> reason one or more requests get stuck, while others are still being
> processed.   The latter case is unlikely to be an issue in practice,
> IMO.
>
> Thanks,
> Miklos

