Return-Path: <linux-fsdevel+bounces-60172-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5ACB4261F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 18:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B77667A98C2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 15:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC87B299A90;
	Wed,  3 Sep 2025 16:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="A/ARcP6s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FCA29ACF7
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 16:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756915222; cv=none; b=B7Sy7oy6vn9OGFSnkm7cooCTXOJwq1F8v+GPDXFdbq7I9uYapbXWINCruei0JJkQhe2xR4ppduqDI191SG5hfhOdNmP97GHRFOUY6mxZC5b7pq07XzUBiZA2A2wW96QCD/BjrVIpkDwGasEHsYV7mSnWeH2XjvoLQV7cI1unZ5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756915222; c=relaxed/simple;
	bh=VzTEB4bQWY8fWAQTgqOF+HS9WXqmiqpiTrodHwtJGNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nb4+1xYkZy9I7I42s5tRkjFYq50APAKP7glJBiuDjeebI4y1F85tUnzCy+wd1TyKaSLPMPeZMbkLSm+pWxrHKqY+IrXsL/xYfn6JmSOp8kaCG6xwjz6OVru35vNZbY62KsiaclIRtOaIxLWBsDbGuB0V+sBbFHx+4uJYKguGJB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=A/ARcP6s; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4b58b1b17d7so73751cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Sep 2025 09:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1756915219; x=1757520019; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VzTEB4bQWY8fWAQTgqOF+HS9WXqmiqpiTrodHwtJGNM=;
        b=A/ARcP6sfrpy7CHp8keZw+/WTMMqeXLYRA6dj2gBMPovsEkXi2Jbt6IkDh8gdtzhJF
         ZDOkmfVTK1B4cnDiQCc9hJWrsWQ3Gr/Cu0AHk6kPrKsP/VaKm/vpWCGZAsfdpDoMxWZZ
         fHvCu6KjaRAQDLJqLwl+ekdc2pvJTngvXlhOk0obJlOu7OVtk2BgjjjsppVatR6vxq6/
         MC8wV2bM42270aakESITxN7g539CMri0MALnetN073CGAbVDoB68/AWFRekDCfSnyLZJ
         6F9i/GbQrLjJiGEtbhkvDpVupAmfzKJGaslvuCnqgA6fFl2sqig0cus7u77Cv9Fts6ra
         Beiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756915219; x=1757520019;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VzTEB4bQWY8fWAQTgqOF+HS9WXqmiqpiTrodHwtJGNM=;
        b=hbDXvXcFrrFBh7zvpesDpxjjTK9RWsXS7uiKwYv/jZLs4RfGv/Jm1SxdpZcCE9I1zP
         jDjTbcEbKrCb2YCth7fmi0/9ndy368H7z3k1r52DICWKGH7mi6YilavKPkiFdkF6jGPS
         ALnWDSI/2CC35WuB0bkfE5yBpCmNx42bwU44agOEHiHYItjwLVRkwtW3LGp0oIuQf56v
         zBZ1HWx8fJhoDqqqD5dct2B/w8NLWY+DKxAYeP+TgEyhXTDJ6ril5SCr2yQUT9L5yb/o
         DmbuAYSmSmitfk7seOB7fm4jWLlGvcD+n2fAWWNi8eTEjUV1pYa85P+mvoPoe0qoZ6Q6
         MPEA==
X-Forwarded-Encrypted: i=1; AJvYcCXvfX67xMbE+vdKKsJLtU51PsIFmGcDfQli3/X64Vy4ysJ9w4jKMrUk9/cAHRis5fRUZA8wPA9/MN3l5VSn@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0GIcbP6Jt16aPzYQH+h0LEPSVEvFbvb1pHAvo8dd/FXHRNrDb
	UdU2zkCuTyKaEjdNciF6qThrHyp+9kRCyQOHYjf1RuWORhjo8/yPBfZJ5eT1d8JCDLIkGmO1uW8
	CUb4ITC0SfVYhyOHRIE+3vZ+NxcoMAefyp2hcjzFy1Q==
X-Gm-Gg: ASbGnctbX9TawkxDdVrLbWS8Fofr83jz3q1ik0TXFzOVHWsTn6cYW0b7ceNfQWOz2nm
	K/4kAX3Grd3vzueJxMoYu3u7QGlObdlLd1EofpM6PCcI9z8d3g40mkC5iFkYwk8p6B3ZBflwgR8
	3JbWfvTPIkDnFhEOTwwQE/FyGr4t11NAkXpyzkeev2bZBOlpG0ZjukNZb3K3G8TmYDuwK3/pFz4
	QG3XrOX7SzdgQQ=
X-Google-Smtp-Source: AGHT+IEwx1LONda4kuiaJ848y4hM0OUKd0p1JeEharACFnO+JnUd0aS8iQNuarNBHObxQXAJhaTUSynWXDSmvzGvt7Q=
X-Received: by 2002:a05:622a:1ba4:b0:4b3:1197:b93a with SMTP id
 d75a77b69052e-4b31dc8f67fmr234759261cf.34.1756915218859; Wed, 03 Sep 2025
 09:00:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <20250807014442.3829950-30-pasha.tatashin@soleen.com> <20250826162019.GD2130239@nvidia.com>
 <aLXIcUwt0HVzRpYW@kernel.org> <CA+CK2bC96fxHBb78DvNhyfdjsDfPCLY5J5cN8W0hUDt9KAPBJQ@mail.gmail.com>
 <mafs03496w0kk.fsf@kernel.org> <CA+CK2bAb6s=gUTCNjMrOqptZ3a_nj3teuVSZs86AvVymvaURQA@mail.gmail.com>
 <20250902113857.GB186519@nvidia.com>
In-Reply-To: <20250902113857.GB186519@nvidia.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 3 Sep 2025 15:59:40 +0000
X-Gm-Features: Ac12FXzyfAMIU2bzOrGlEX9a8opKhAuJo6gq5GdnRJV0XcXKQKHlYu1Dn3mOunw
Message-ID: <CA+CK2bB-CaEdvzxt9=c1SZwXBfy-nE202Q2mfHL_2K7spjf8rw@mail.gmail.com>
Subject: Re: [PATCH v3 29/30] luo: allow preserving memfd
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, Mike Rapoport <rppt@kernel.org>, jasonmiu@google.com, 
	graf@amazon.com, changyuanl@google.com, dmatlack@google.com, 
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org, 
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, ojeda@kernel.org, 
	aliceryhl@google.com, masahiroy@kernel.org, akpm@linux-foundation.org, 
	tj@kernel.org, yoann.congal@smile.fr, mmaurer@google.com, 
	roman.gushchin@linux.dev, chenridong@huawei.com, axboe@kernel.dk, 
	mark.rutland@arm.com, jannh@google.com, vincent.guittot@linaro.org, 
	hannes@cmpxchg.org, dan.j.williams@intel.com, david@redhat.com, 
	joel.granados@kernel.org, rostedt@goodmis.org, anna.schumaker@oracle.com, 
	song@kernel.org, zhangguopeng@kylinos.cn, linux@weissschuh.net, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	rafael@kernel.org, dakr@kernel.org, bartosz.golaszewski@linaro.org, 
	cw00.choi@samsung.com, myungjoo.ham@samsung.com, yesanishhere@gmail.com, 
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com, 
	aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, lennart@poettering.net, brauner@kernel.org, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, saeedm@nvidia.com, 
	ajayachandra@nvidia.com, parav@nvidia.com, leonro@nvidia.com, witu@nvidia.com
Content-Type: text/plain; charset="UTF-8"

> > > > The patch looks okay to me, but it doesn't support holes in vmap
> > > > areas. While that is likely acceptable for vmalloc, it could be a
> > > > problem if we want to preserve memfd with holes and using vmap
> > > > preservation as a method, which would require a different approach.
> > > > Still, this would help with preserving memfd.
> > >
> > > I agree. I think we should do it the other way round. Build a sparse
> > > array first, and then use that to build vmap preservation. Our emails
> >
> > Yes, sparse array support would help both: vmalloc and memfd preservation.
>
> Why? vmalloc is always full popoulated, no sparseness..

vmalloc is always fully populated, but if we add support for
preserving an area with holes, it can also be used for preserving
vmalloc. By the way, I don't like calling it *vmalloc* preservation
because we aren't preserving the original virtual addresses; we are
preserving a list of pages that are reassembled into a virtually
contiguous area. Maybe kho map, or kho page map, not sure, but vmalloc
does not sound right to me.

> And again in real systems we expect memfd to be fully populated too.

I thought so too, but we already have a use case for slightly sparse
memfd, unfortunately, that becomes *very* inefficient when fully
populated.

