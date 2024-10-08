Return-Path: <linux-fsdevel+bounces-31308-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B9E994514
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 12:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 296AF1C22635
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 10:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2A41925B2;
	Tue,  8 Oct 2024 10:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20230601.gappssmtp.com header.i=@owltronix-com.20230601.gappssmtp.com header.b="rm+U7v10"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4321318C036
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Oct 2024 10:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728382028; cv=none; b=HyqM9CYWLm8I1+QyA+Z7n5lCfuCvoxCo0vkdeSrtkYXiRESfkZogVAX96X68g+rEj+Y4sLKsdYH20kgI5w9Oh4Cop3JegvUwfDsGQSRPk+VxOlCzWcuOqS0l8ZJ5X/pWamqGE/1up6tPVVk+0KUVSMz5hlzbVXdH4Gadzsb1HWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728382028; c=relaxed/simple;
	bh=5+kIA463T/JCkYD1c6V+J0eXY+pDrs1mF0Fej4l2a54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cOhK/ExVZVtZkPlHTL93S9pKh4IzZ8CSmTHTvFJTk7YPtku/1SBqHV93MOr8yNZrOY3/fjZT8OOxpowZD6Wb7EBEkaKekRw3EGveMBNY4p+C6NnKQ/2qNPPvQoBObQpvWfaM3IPrQdL566lLs6VwMmW1un9OEv+AGBo6e+yLgFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=owltronix.com; spf=none smtp.mailfrom=owltronix.com; dkim=pass (2048-bit key) header.d=owltronix-com.20230601.gappssmtp.com header.i=@owltronix-com.20230601.gappssmtp.com header.b=rm+U7v10; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=owltronix.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=owltronix.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5398fb1a871so5331346e87.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Oct 2024 03:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20230601.gappssmtp.com; s=20230601; t=1728382024; x=1728986824; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F14OcwqLVp3hHp+0VqT30x2kelDO/WiLYxpL7cfOOhI=;
        b=rm+U7v10g0ImfPZJouUISPe75YogUL/ImWFP4/J98iFlNPsm7Y40nGcT2wvUPAZGtF
         jYEsTZcCKYRmHxckDDFU3/J0u4pBvcnU+H9j3EsxWwjptV/0/jylhQyD/r5IkeEbbris
         mzcFLT2GJmThxbvGoePUiVHGkQXWhU6+MQbIHZqMoFlHVO3U9Nu/Vdw+ikG2sECDlPXm
         LZyGTGpDtXNnpuCbuArb7nw67RWanvEU8AdXKLk6djbNSGx3zqXbbHDAF8mrDxf4cNVi
         oMKk9cLQ6efcc23OsOYpkUZQtNhmiAxZ0bUVYzW0A4WXWxbTCs73IpYUKeHSybdt8rIH
         c6kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728382024; x=1728986824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F14OcwqLVp3hHp+0VqT30x2kelDO/WiLYxpL7cfOOhI=;
        b=WFEu3NTEvU1LBrh6IyyB8j45CVkUyRpZc2CfBYipaeRDasNO1uZxeQztVnPhkVgn7Z
         QvCvzCB+3jr5+zdzN4yLmiWYbECqeVoNY6fBvRgQNWHc/sxxKLyiy4GSdzq8HE0jxpRU
         NVYeL3bjZAjal66AL06jfr2r+grNNYxXcXW7vw+/MYrsrpb6iw72fooib/0N4Kd1USxh
         nCLlvnckxlBqjtyxlq7gqVxeSeTZGq0V2sK4EO7ILfc01bUDBdLen9EMERDkHoGHFtzN
         2K44KBedmYJs0ZX4xOxhfgd/RihcK1gRw5Ey+J+eDWCnDz2PgTY0r0kCWbXeSsc9wv/o
         j8Hg==
X-Forwarded-Encrypted: i=1; AJvYcCU1dnFplWWvxXEZf9x1BcuQJUhlxFs7SwC/b7fRrClEEbPd9b2ulAfADTT+NgoqcVitqwRz9O0+K7E3ZUza@vger.kernel.org
X-Gm-Message-State: AOJu0YxAUcX3N8dDpd85V92M62oL76ClmG82VJsc1s6Uu1vGmIRrQoym
	nWytCmuOq/nceuU8BKZyf32beAuANxNwURC8rOnH5ZncDirgFiKJEVY7cEq4ZdTizeBn+Y4ohT3
	tscmjZbQSK06FPrVmZkmHtiPA2x4r7mxiMKJP6A==
X-Google-Smtp-Source: AGHT+IHEOz/KdzlVozdD6OTXUfqUHVvxbJDxNr/5ySZvwaMHkV92VlsUI1hujJ58x1Kd6zWF/HBp1CPSJYsPE68+4OU=
X-Received: by 2002:a05:6512:3088:b0:539:9746:2d77 with SMTP id
 2adb3069b0e04-539ab9c704fmr6383065e87.61.1728382024131; Tue, 08 Oct 2024
 03:07:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002151949.GA20877@lst.de> <yq17caq5xvg.fsf@ca-mkp.ca.oracle.com>
 <20241003125400.GB17031@lst.de> <c68fef87-288a-42c7-9185-8ac173962838@kernel.dk>
 <CGME20241004053129eucas1p2aa4888a11a20a1a6287e7a32bbf3316b@eucas1p2.samsung.com>
 <20241004053121.GB14265@lst.de> <20241004061811.hxhzj4n2juqaws7d@ArmHalley.local>
 <20241004062733.GB14876@lst.de> <20241004065233.oc5gqcq3lyaxzjhz@ArmHalley.local>
 <20241004123027.GA19168@lst.de> <20241007101011.boufh3tipewgvuao@ArmHalley.local>
In-Reply-To: <20241007101011.boufh3tipewgvuao@ArmHalley.local>
From: Hans Holmberg <hans@owltronix.com>
Date: Tue, 8 Oct 2024 12:06:53 +0200
Message-ID: <CANr-nt3TA75MSvTNWP3SwBh60dBwJYztHJL5LZvROa-j9Lov7g@mail.gmail.com>
Subject: Re: [PATCH v7 0/3] FDP and per-io hints
To: =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier.gonz@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Keith Busch <kbusch@kernel.org>, 
	Kanchan Joshi <joshi.k@samsung.com>, hare@suse.de, sagi@grimberg.me, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, jack@suse.cz, jaegeuk@kernel.org, bcrl@kvack.org, 
	dhowells@redhat.com, bvanassche@acm.org, asml.silence@gmail.com, 
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	io-uring@vger.kernel.org, linux-block@vger.kernel.org, linux-aio@kvack.org, 
	gost.dev@samsung.com, vishak.g@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 12:10=E2=80=AFPM Javier Gonz=C3=A1lez <javier.gonz@s=
amsung.com> wrote:
>
> On 04.10.2024 14:30, Christoph Hellwig wrote:
> >On Fri, Oct 04, 2024 at 08:52:33AM +0200, Javier Gonz=C3=A1lez wrote:
> >> So, considerign that file system _are_ able to use temperature hints a=
nd
> >> actually make them work, why don't we support FDP the same way we are
> >> supporting zones so that people can use it in production?
> >
> >Because apparently no one has tried it.  It should be possible in theory=
,
> >but for example unless you have power of 2 reclaim unit size size it
> >won't work very well with XFS where the AGs/RTGs must be power of two
> >aligned in the LBA space, except by overprovisioning the LBA space vs
> >the capacity actually used.
>
> This is good. I think we should have at least a FS POC with data
> placement support to be able to drive conclusions on how the interface
> and requirements should be. Until we have that, we can support the
> use-cases that we know customers are asking for, i.e., block-level hints
> through the existing temperature API.
>
> >
> >> I agree that down the road, an interface that allows hints (many more
> >> than 5!) is needed. And in my opinion, this interface should not have
> >> semintics attached to it, just a hint ID, #hints, and enough space to
> >> put 100s of them to support storage node deployments. But this needs t=
o
> >> come from the users of the hints / zones / streams / etc,  not from
> >> us vendors. We do not have neither details on how they deploy these
> >> features at scale, nor the workloads to validate the results. Anything
> >> else will probably just continue polluting the storage stack with more
> >> interfaces that are not used and add to the problem of data placement
> >> fragmentation.
> >
> >Please always mentioned what layer you are talking about.  At the syscal=
l
> >level the temperatur hints are doing quite ok.  A full stream separation
> >would obviously be a lot better, as would be communicating the zone /
> >reclaim unit / etc size.
>
> I mean at the syscall level. But as mentioned above, we need to be very
> sure that we have a clear use-case for that. If we continue seeing hints
> being use in NVMe or other protocols, and the number increase
> significantly, we can deal with it later on.
>
> >
> >As an interface to a driver that doesn't natively speak temperature
> >hint on the other hand it doesn't work at all.
> >
> >> The issue is that the first series of this patch, which is as simple a=
s
> >> it gets, hit the list in May. Since then we are down paths that lead
> >> nowhere. So the line between real technical feedback that leads to
> >> a feature being merged, and technical misleading to make people be a
> >> busy bee becomes very thin. In the whole data placement effort, we hav=
e
> >> been down this path many times, unfortunately...
> >
> >Well, the previous round was the first one actually trying to address th=
e
> >fundamental issue after 4 month.  And then after a first round of feedba=
ck
> >it gets shutdown somehow out of nowhere.  As a maintainer and review tha=
t
> >is the kinda of contributors I have a hard time taking serious.
>
> I am not sure I understand what you mean in the last sentece, so I will
> not respond filling blanks with a bad interpretation.
>
> In summary, what we are asking for is to take the patches that cover the
> current use-case, and work together on what might be needed for better
> FS support. For this, it seems you and Hans have a good idea of what you
> want to have based on XFS. We can help review or do part of the work,
> but trying to guess our way will only delay existing customers using
> existing HW.

After reading the whole thread, I end up wondering why we need to rush the
support for a single use case through instead of putting the architecture
in place for properly supporting this new type of hardware from the start
throughout the stack.

Even for user space consumers of raw block devices, is the last version
of the patch set good enough?

* It severely cripples the data separation capabilities as only a handful o=
f
  data placement buckets are supported

* It just won't work if there is more than one user application per storage
  device as different applications data streams will be mixed at the nvme
  driver level..

While Christoph has already outlined what would be desirable from a
file system point of view, I don't have the answer to what would be the ove=
rall
best design for FDP. I would like to say that it looks to me like we need t=
o
consider more than more than the early adoption use cases and make sure we
make the most of the hardware capabilities via logical abstractions that
would be compatible with a wider range of storage devices.

Figuring the right way forward is tricky, but why not just let it take the =
time
that is needed to sort this out while early users explore how to use FDP
drives and share the results?

