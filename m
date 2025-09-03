Return-Path: <linux-fsdevel+bounces-60130-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4DBB4186F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 10:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C95833B0D1D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 08:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245172EBDC2;
	Wed,  3 Sep 2025 08:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="gQ8n9DV8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DCC2EB879
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 08:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756888112; cv=none; b=b+KADqfbvOIouakIVeFQ+wdl+WnpiaXlTJjkkTuT046jic/X/8Oi9Z1VZG1YmktrX4AcXci5GMXI3zgV+CQ/hJ9OrZvKSzj443JT+U7zLacB/cZVtnRi/6nT1ZKLRC+2v+wLXGyg9XoKUsLtOi8vYdlD32Fh0pNZH6OAmnnaudU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756888112; c=relaxed/simple;
	bh=fiIV5iCnxTVLl0kbKnQRDz6LgUwnj50LzskxwIhPreA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WhL1ZbiP8e3YV8Wc75OZ8dne+iR/V04BEdUgg4RtdZNsUbkQxWDjWkvfkm72N8zC8wC32hDDXFLSUqWyM8oQAg1zZdMm2O+rnxMVI7MTNWusZ37RDC8cMAQLzIimWQe2pLaUCCG2V4Ua6R4vBItYM3run9zAGwKezqO6GatWQjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=gQ8n9DV8; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7452b1964f3so5021353a34.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Sep 2025 01:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756888110; x=1757492910; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X4Gk0WkO/ltGDuq5EYSYDJNW0uN5qNSvxVpuSLyFD1c=;
        b=gQ8n9DV8X8wB71Mf/KEU0+4WwezsvstFwK9RMULNUPelurPhnCUlb6OS5lzZfXbkfj
         JKaoyI9OkMihPRu9XhXjCJDcpZrZgegvS2vnroZIdhVVG4mwad4WTSU0i9em+AMNKKMd
         oacA6eNy/Qlm5iwnP/cZ84It21i2P+mCx/zmSiXkAJxlyirbblvkGPHd2jhovjI9eSAW
         LT6al7jCb8YE28tRkIcqemQHzb0P9b4f0QadZHgPOS1CeiAcAVc6aH2MzQz96xSRlicQ
         7TZ+CcDmdhGWoKkcCmTsEXKoDj/AOzKZspE9jmglT1MwjXUsO6YzoPBbh6Sh8vnThQjt
         dOfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756888110; x=1757492910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X4Gk0WkO/ltGDuq5EYSYDJNW0uN5qNSvxVpuSLyFD1c=;
        b=pkpJnG5Y84sF5FntUqK5k6URuGG7MuCs5ZFaRnghma0ibDuMl9Ib2zjC/wx+QdtEhI
         9oD88qBgjWxMeC5osZ0Ku3Y6WetGr5XbUlBK4CXRd7gaOHa7FJ0BjOA3zzEY951QhYXF
         T2NCUFajT+B7XqboIkoOOVzw8Wz38xkIUlmuYAasEdzmpsPA6aogxteQWIOEE016bjJP
         zTkLu0KP08ye3CeyqqAWUnWiLFIz9q5q5qYsBFanr4ER6Rho0ySHrCIJJMRAWCUqwTef
         z/USV8MT+icCA02ZVP5GBsOsmfdvThFHTHuLL143Bmu+uf5AbetW6ZPppdtHqqNCb38L
         7vHw==
X-Forwarded-Encrypted: i=1; AJvYcCVFPd0ZyI9j7Tbenm1S1CmUbc2RCc0k8EWVNPcOWCbWUw9Sk/bcFvKbOjRLIN9foovAuQfAAbA8JgLrccBM@vger.kernel.org
X-Gm-Message-State: AOJu0YxbMUIenk5DF6h9AivipsRLCZOrc9uNgNsXLHjj3Z85P8NaWjys
	jRjtwsmdsxBT5eGWIsBxQuTtz7TR/p/nSI1ZbZlk9OEpEvoF2R/V5xc72Ae5NY7zz8p+WY4TUCh
	2a7ecWfSvjS3Xu5O1Ky7IXgYd5aU24jKCxXEq7QZp+w==
X-Gm-Gg: ASbGnctp8vPEckvnkiLkHRukrGii7rd/tO7W7Xm5kubmthJTKXR9EtHIx05okrvTIRl
	p0ATeelrkB264kiLcVThZoAkZJXW0ziJNrr3y3/WUZgHdr56asXv2kOMtd8A2B8WR3dKInjrEgG
	fBhwMlJEUfU1GIw3rm1W87aLbRQNx0d5/yU0zRSvTKwpUR5Nz7XXIFNrnXxqOfrporuJOtI/d+U
	U+pADaTq/bt806R
X-Google-Smtp-Source: AGHT+IGCmULQPRqXwY751nUtLh+1D5afI8G1snYcO3jggywuAFC7i00tRMmVTYcG+Y2fl7Iou0UE3uogU/1EnR3FqSA=
X-Received: by 2002:a05:6808:bc4:b0:433:fe9c:686d with SMTP id
 5614622812f47-437f7d016d5mr5934622b6e.21.1756888109793; Wed, 03 Sep 2025
 01:28:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822082606.66375-1-changfengnan@bytedance.com>
 <20250822150550.GP7942@frogsfrogsfrogs> <aKiP966iRv5gEBwm@casper.infradead.org>
 <877byv9w6z.fsf@gmail.com> <aKif_644529sRXhN@casper.infradead.org>
 <874ityad1d.fsf@gmail.com> <CAPFOzZufTPCT_56-7LCc6oGHYiaPixix30yFNEsiFfN1s9ySMQ@mail.gmail.com>
 <aKwq_QoiEvtK89vY@infradead.org> <CAPFOzZvBvHWHUwNLnH+Ss90OMdu91oZsSD0D7_ncjVh0pF29rQ@mail.gmail.com>
 <878qj6qb2m.fsf@gmail.com>
In-Reply-To: <878qj6qb2m.fsf@gmail.com>
From: Fengnan Chang <changfengnan@bytedance.com>
Date: Wed, 3 Sep 2025 16:28:19 +0800
X-Gm-Features: Ac12FXzcH3FvBYuIMHRcDxMXndXly-fnK62pQIHzDq-Gs-RJzqJjIKfLMgOwLoE
Message-ID: <CAPFOzZsbEgmogYMdt7Koau-GzRf9vu8qF7615VNRjW9cLUREKw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] iomap: allow iomap using the per-cpu bio cache
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, "Darrick J. Wong" <djwong@kernel.org>, brauner@kernel.org, 
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ritesh Harjani <ritesh.list@gmail.com> =E4=BA=8E2025=E5=B9=B48=E6=9C=8827=
=E6=97=A5=E5=91=A8=E4=B8=89 01:26=E5=86=99=E9=81=93=EF=BC=9A
>
> Fengnan Chang <changfengnan@bytedance.com> writes:
>
> > Christoph Hellwig <hch@infradead.org> =E4=BA=8E2025=E5=B9=B48=E6=9C=882=
5=E6=97=A5=E5=91=A8=E4=B8=80 17:21=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> On Mon, Aug 25, 2025 at 04:51:27PM +0800, Fengnan Chang wrote:
> >> > No restrictions for now, I think we can enable this by default.
> >> > Maybe better solution is modify in bio.c?  Let me do some test first=
.
>
> If there are other implications to consider, for using per-cpu bio cache
> by default, then maybe we can first get the optimizations for iomap in
> for at least REQ_ALLOC_CACHE users and later work on to see if this
> can be enabled by default for other users too.
> Unless someone else thinks otherwise.
>
> Why I am thinking this is - due to limited per-cpu bio cache if everyone
> uses it for their bio submission, we may not get the best performance
> where needed. So that might require us to come up with a different
> approach.

Agree, if everyone uses it for their bio submission, we can not get the bes=
t
performance.

>
> >>
> >> Any kind of numbers you see where this makes a different, including
> >> the workloads would also be very valuable here.
> > I'm test random direct read performance on  io_uring+ext4, and try
> > compare to io_uring+ raw blkdev,  io_uring+ext4 is quite poor, I'm try =
to
> > improve this, I found ext4 is quite different with blkdev when run
> > bio_alloc_bioset. It's beacuse blkdev ext4  use percpu bio cache, but e=
xt4
> > path not. So I make this modify.
>
> I am assuming you meant to say - DIO with iouring+raw_blkdev uses
> per-cpu bio cache where as iouring+(ext4/xfs) does not use it.
> Hence you added this patch which will enable the use of it - which
> should also improve the performance of iouring+(ext4/xfs).

Yes. DIO+iouring+raw_blkdev vs DIO+iouring+(ext4/xfs).

>
> That make sense to me.
>
> > My test command is:
> > /fio/t/io_uring -p0 -d128 -b4096 -s1 -c1 -F1 -B1 -R1 -X1 -n1 -P1 -t0
> > /data01/testfile
> > Without this patch:
> > BW is 1950MB
> > with this patch
> > BW is 2001MB.
>
> Ok. That's around 2.6% improvement.. Is that what you were expecting to
> see too? Is that because you were testing with -p0 (non-polled I/O)?

I don't have a quantitative target for expectations, 2.6% seems reasonable.
Not related to -p0, with -p1, about 3.1% improvement.
Why we can't get 5-6% improvement? I think the biggest bottlenecks are
in ext4/xfs, most in ext4_es_lookup_extent.

>
> Looking at the numbers here [1] & [2], I was hoping this could give
> maybe around 5-6% improvement ;)
>
> [1]: https://lore.kernel.org/io-uring/cover.1666347703.git.asml.silence@g=
mail.com/
> [2]: https://lore.kernel.org/all/20220806152004.382170-3-axboe@kernel.dk/
>
>
> -ritesh

