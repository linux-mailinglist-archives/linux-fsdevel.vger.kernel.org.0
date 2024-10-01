Return-Path: <linux-fsdevel+bounces-30561-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D21C98C423
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 19:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 151B01F2624F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 17:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBABB1CB318;
	Tue,  1 Oct 2024 17:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RCLOrnH6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3E718CC0B
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Oct 2024 17:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727802242; cv=none; b=boN2ZQlasvtr+kPUP9FyMD9U60at2BzguQiLKHT8zfcoNRR6IO7RJNG8D8EihHnH4XoWOxBiM1guWvHTR1rl9dEo4sxdGCDql+GLDRRThW+6TjV4IJoONkVRz/vHEuBjqEMg86QNR2DOPSheiuGjYFPajUQqrqUxoHy2hTYrO+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727802242; c=relaxed/simple;
	bh=6REJ+xFyEG4dbNPD0x4fmKGRmOIUIBib4oc+Sm9YGUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uyslOJIJepMHCipth5l3rqBF9wBO2m5d7wMbUGp89Kojo6AAtfCcKyxUBG5njlNLgFC0az+dXgWYLwG5LbNtpWOX6UUlycn+Kxz4ZU366moiBsN4l0OWiGBWY7G0KXnLGyQyuKihRQOYZf98L40t6maFIeRMjlqaNAaDyQBuWCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RCLOrnH6; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4581d2b0fbaso43477991cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Oct 2024 10:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727802239; x=1728407039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6REJ+xFyEG4dbNPD0x4fmKGRmOIUIBib4oc+Sm9YGUo=;
        b=RCLOrnH67Y91/vt81c4ycMF6IpOW0bLBdHCp/75iSWc4l+QMf+KO4odPEnVhE50v3j
         rfs7gafMWg/WR27W9ymFygwcbnxSGP1QockmpFe8b0AIpUAVrZHg5KeszYEQMnRpnZEa
         KGlH4LYG+HIdGr/pehk2ZwrS/g2XyG9uHojaD3Zn+TCJZ3tRa5UEIkncr1Uds2gomeFw
         twgMIAtnFEyu4MBTTUqyKyc+MNVPHxgek3xXNcDwV8W+85KLIyeoX1jD/TpiWQTGYQOy
         Uv5mF+aIEdIcQgXF67unPHPLs6l/udgDriaskfEvUrIWXhwS9mQwihFlnt0mzQyFLu8q
         DcYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727802239; x=1728407039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6REJ+xFyEG4dbNPD0x4fmKGRmOIUIBib4oc+Sm9YGUo=;
        b=BuPP3wHlXCWB0GuTvHwo4yg6zRONsoc8MWE7vsAvW/TB1WPosDxE00idWHB6ppJNx+
         6f6Syvkc38jBXwTjKhiNdVAENQEu6qlLakFt1dNxY7P6+KX3dKPkFXpgyjpzBrF2NtsB
         1ZzM7dA97a5Jidvf9gz0SL9L6WQWzSwBx4XOy3R2RT1OtOA8qdfx3+3lUWurTzVOyZjh
         KZToolpq+s8n5aGKVYEep95K+ADD/NqfyyE9oo6PG9nYoX/C1snn79qz5c8Q3ikWZMWk
         d+z+PeM7LDjyqp/bSKgMJFgfrvWZ+91JUWJYWtHTpTmQzxd7GDEC4czNnFuFZ0erYbdX
         +LMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUH7UOOYjSqToNdfCmVdxy4b2nb6OC4HQo56WpuGdqMrylAm2Yw9igl5ZUlsmAwAKqtkBuXExpSpJauPMKn@vger.kernel.org
X-Gm-Message-State: AOJu0YxOP4aFhyuRT68EIAjHiO/A8DxYLMgkCa2iJU4kBWCm09mBltMd
	d0t6/7SpzID6hAmzHBu6E+38K1DB2GDSTDYXh+eMh2awkpVfHEt48MXb0KcZ9xhtMadmLcXRX/o
	dp4l/cSr44xpljGtRelkYfqPBoOk=
X-Google-Smtp-Source: AGHT+IFySVnMf0QQQEGKXbrLX05moi1WymrIaR4+zyEZRSWzyfmxhwBzqejeYt/QbQlmUNxzY77EPsMlooYiOnp/Z1U=
X-Received: by 2002:a05:622a:2ca:b0:458:5ea0:c799 with SMTP id
 d75a77b69052e-45d80493df6mr3949791cf.3.1727802239459; Tue, 01 Oct 2024
 10:03:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830162649.3849586-1-joannelkoong@gmail.com>
 <20240830162649.3849586-2-joannelkoong@gmail.com> <CAJfpegug0MeX7HYDkAGC6fn9HaMtsWf2h3OyuepVQar7E5y0tw@mail.gmail.com>
 <CAJnrk1bdyDq+4jo29ZbyjdcbFiU2qyCGGbYbqQc_G23+B_Xe_Q@mail.gmail.com> <7d609efd-9e0e-45b1-8793-872161a24318@fastmail.fm>
In-Reply-To: <7d609efd-9e0e-45b1-8793-872161a24318@fastmail.fm>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 1 Oct 2024 10:03:48 -0700
Message-ID: <CAJnrk1ZSoHq2Qg94z8NLDg5OLk6ezVA_aFjKEibSi7H5KDM+3Q@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] fuse: add optional kernel-enforced timeout for requests
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	jefflexu@linux.alibaba.com, laoar.shao@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 28, 2024 at 1:43=E2=80=AFAM Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
>
> Hi Joanne,
>
> On 9/27/24 21:36, Joanne Koong wrote:
> > On Mon, Sep 2, 2024 at 3:38=E2=80=AFAM Miklos Szeredi <miklos@szeredi.h=
u> wrote:
> >>
> >> On Fri, 30 Aug 2024 at 18:27, Joanne Koong <joannelkoong@gmail.com> wr=
ote:
> >>>
> >>> There are situations where fuse servers can become unresponsive or
> >>> stuck, for example if the server is in a deadlock. Currently, there's
> >>> no good way to detect if a server is stuck and needs to be killed
> >>> manually.
> >>>
> >>> This commit adds an option for enforcing a timeout (in seconds) on
> >>> requests where if the timeout elapses without a reply from the server=
,
> >>> the connection will be automatically aborted.
> >>
> >> Okay.
> >>
> >> I'm not sure what the overhead (scheduling and memory) of timers, but
> >> starting one for each request seems excessive.
> >
> > I ran some benchmarks on this using the passthrough_ll server and saw
> > roughly a 1.5% drop in throughput (from ~775 MiB/s to ~765 MiB/s):
> > fio --name randwrite --ioengine=3Dsync --thread --invalidate=3D1
> > --runtime=3D300 --ramp_time=3D10 --rw=3Drandwrite --size=3D1G --numjobs=
=3D4
> > --bs=3D4k --alloc-size 98304 --allrandrepeat=3D1 --randseed=3D12345
> > --group_reporting=3D1 --directory=3D/root/fuse_mount
> >
> > Instead of attaching a timer to each request, I think we can instead
> > do the following:
> > * add a "start_time" field to each request tracking (in jiffies) when
> > the request was started
> > * add a new list to the connection that all requests get enqueued
> > onto. When the request is completed, it gets dequeued from this list
> > * have a timer for the connection that fires off every 10 seconds or
> > so. When this timer is fired, it checks if "jiffies > req->start_time
> > + fc->req_timeout" against the head of the list to check if the
> > timeout has expired and we need to abort the request. We only need to
> > check against the head of the list because we know every other request
> > after this was started later in time. I think we could even just use
> > the fc->lock for this instead of needing a separate lock. In the worst
> > case, this grants a 10 second upper bound on the timeout a user
> > requests (eg if the user requests 2 minutes, in the worst case the
> > timeout would trigger at 2 minutes and 10 seconds).
> >
> > Also, now that we're aborting the connection entirely on a timeout
> > instead of just aborting the request, maybe it makes sense to change
> > the timeout granularity to minutes instead of seconds. I'm envisioning
> > that this timeout mechanism will mostly be used as a safeguard against
> > malicious or buggy servers with a high timeout configured (eg 10
> > minutes), and minutes seems like a nicer interface for users than them
> > having to convert that to seconds.
> >
> > Let me know if I've missed anything with this approach but if not,
> > then I'll submit v7 with this change.
>
>
> sounds great to me. Just, could we do this per fuse_dev to avoid a
> single lock for all cores?
>

Will do! thanks for the suggestion - in that case, I'll add its own
spinlock for it too then.

Thanks,
Joanne

>
> Thanks,
> Bernd

