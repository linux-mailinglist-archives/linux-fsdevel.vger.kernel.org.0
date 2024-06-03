Return-Path: <linux-fsdevel+bounces-20846-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7828D8597
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 16:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D290C1C2199B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 14:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91891304AA;
	Mon,  3 Jun 2024 14:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZXEotzMy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A397712FF70
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Jun 2024 14:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717426595; cv=none; b=q5WhE9iQCfO8iuD3XmZH4GWZ1qYl9XdzMg4rYLN/+KEqL/DkuENbPFotI+waypl3BrrsPf2U4VhvmfIIQJxjN5rgXiNzQG/WtzZJzhNmpXxrJV0oiFmbHNiNSwxVc68D/XENXCB056RlqOZ9xGRsXwu9IQ96f1vh8TxBhb+NsTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717426595; c=relaxed/simple;
	bh=zsunStNizZpH1wJCbjihQBz/Lf2Sb/tdk5WMo5Ik728=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jo3ha31JeO3Wf7HxuXmP8xqHYwrnIQz965jOW2Qcxp811DG+aHiXrBnDDO/c8wAPYN3u4e2EVE2L+QUZ4IaV8PxUjyRkSX5USmH0ayVGlR4L8TsD1iJjUroSdastOUq9fRH9T2txlc0mQv/QNMLRkc+RKqSErNyZEiCDxY3pzwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZXEotzMy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717426592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cggaNwi/VVDlA3tnNNTmKDDBi+NGhkQ+YrckBWZAHm0=;
	b=ZXEotzMynSS7ztKOjiaNNyOt1L49YqUqAPfUlwa/euRtF6zjMg8ZwX/G7dDbdEWYEjZJNb
	MUu8UowFSqP69MtTzc79jeEQ237jBw0XbTa80Ek/Gg/phiN18TpSwwzh4tPuUHBR2VaZIf
	9HNf8pThiIRA+seRPgyEN1v6W2MhxxU=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-6Ifo9Ba5M7uIYdSuXm2XYw-1; Mon, 03 Jun 2024 10:56:28 -0400
X-MC-Unique: 6Ifo9Ba5M7uIYdSuXm2XYw-1
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-2507b790177so3558735fac.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Jun 2024 07:56:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717426587; x=1718031387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cggaNwi/VVDlA3tnNNTmKDDBi+NGhkQ+YrckBWZAHm0=;
        b=j5wNEbvtDLWdFlhqlKC/NtnU/xSe7Q4ablyhB+YiN3GRKSI7YTn9UFHBrihf/VBokP
         8e4Xc7stFhLlrWZIFn++kLv5LJi8DNJWsTya+i4zfYhtkw8rJ6tRc17CL9VAqAO1MdS+
         BAZ28X/inOoDGywNV6PAK92OezIsMtPDyAeP8Q5H2umMquMKZsrbe9cxcE+elDcxrc4x
         BAsBJP5QzP5tkQc//XYmyY5ROj/VTV8TxXZZeYRrndtxtB/FY3Zs5jN7PQewOoNIvmfB
         EAxmXM39MNa5Ou9bE5s9qmHzOsR3UV4BL7yYYtxr/UNoX8k/P5CNIcDpcdfK/8xfNNCw
         9eQg==
X-Forwarded-Encrypted: i=1; AJvYcCUAGJq3Fhjcz2t1ed09MIPWZ1wOwYsOCbf5tUJa89EbT/FDDIzdRGj2QnYXjbLeE5/6rCh+kUB2H+AeT7r+HTcjElmnIT2k/MKs7ewaFQ==
X-Gm-Message-State: AOJu0YycA7C0ccknt2vPb3P7jbrtajEUZ6IypvYkTaANo5iAqv1FBol0
	Z9xYOaEPEzMZNSrA0Q861PDuAjyI42W3fqQYK/vW48h8KrJ4SL1k4BdVooJnhnUm/qUVtzia6+H
	wBb1OSVZOecqR9O2doV6n5sCQPQMMnnl1v2S4yG1vCqhvMhUmrKNh4HDSg77XZLhISn9aYB8OFY
	61WcLmJ9v7sz9UgtAa85lxto15ndGD5Krdg6Ly2A==
X-Received: by 2002:a05:6870:46a8:b0:24f:e6a4:9921 with SMTP id 586e51a60fabf-2508b827dedmr9787758fac.5.1717426587071;
        Mon, 03 Jun 2024 07:56:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/0baeTvo+mJQQjjuzQxRuwduq1k+gHDXHx300/tOtI0jM2UY0ltHW1JkmIEqDdZ9PIrecdy7zBJEB3paijE8=
X-Received: by 2002:a05:6870:46a8:b0:24f:e6a4:9921 with SMTP id
 586e51a60fabf-2508b827dedmr9787732fac.5.1717426586649; Mon, 03 Jun 2024
 07:56:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <SI2PR06MB53852C83901A0DDE55624063FFF32@SI2PR06MB5385.apcprd06.prod.outlook.com>
 <b55cb50b3ecf8d6132f8633ce346b6adc159b38c.camel@nvidia.com>
 <CAJfpegsppbYbbLaECO+K2xpg8v0XZaQKFRZRTj=gJc9p7swdvQ@mail.gmail.com>
 <bbf427150d16122da9dd2a8ebec0ab1c9a758b56.camel@nvidia.com>
 <CAJfpegshNFmJ-LVfRQW0YxNyWGyMMOmzLAoH65DLg4JxwBYyAA@mail.gmail.com> <20240603134427.GA1680150@fedora.redhat.com>
In-Reply-To: <20240603134427.GA1680150@fedora.redhat.com>
From: Miklos Szeredi <mszeredi@redhat.com>
Date: Mon, 3 Jun 2024 16:56:14 +0200
Message-ID: <CAOssrKfw4MKbGu=dXAdT=R3_2RX6uGUUVS+NEZp0fcfiNwyDWw@mail.gmail.com>
Subject: Re: Addressing architectural differences between FUSE driver and fs -
 Re: virtio-fs tests between host(x86) and dpu(arm64)
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Peter-Jan Gootzen <pgootzen@nvidia.com>, Idan Zach <izach@nvidia.com>, 
	Yoray Zack <yorayz@nvidia.com>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, Parav Pandit <parav@nvidia.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"bin.yang@jaguarmicro.com" <bin.yang@jaguarmicro.com>, Max Gurtovoy <mgurtovoy@nvidia.com>, 
	Eliav Bar-Ilan <eliavb@nvidia.com>, "mst@redhat.com" <mst@redhat.com>, 
	"lege.wang@jaguarmicro.com" <lege.wang@jaguarmicro.com>, Oren Duer <oren@nvidia.com>, 
	"angus.chen@jaguarmicro.com" <angus.chen@jaguarmicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 3:44=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.com=
> wrote:
>
> On Mon, Jun 03, 2024 at 11:06:19AM +0200, Miklos Szeredi wrote:
> > On Mon, 3 Jun 2024 at 10:53, Peter-Jan Gootzen <pgootzen@nvidia.com> wr=
ote:
> >
> > > We also considered this idea, it would kind of be like locking FUSE i=
nto
> > > being x86. However I think this is not backwards compatible. Currentl=
y
> > > an ARM64 client and ARM64 server work just fine. But making such a
> > > change would break if the client has the new driver version and the
> > > server is not updated to know that it should interpret x86 specifical=
ly.
> >
> > This would need to be negotiated, of course.
> >
> > But it's certainly simpler to just indicate the client arch in the
> > INIT request.   Let's go with that for now.
>
> In the long term it would be cleanest to choose a single canonical
> format instead of requiring drivers and devices to implement many
> arch-specific formats. I liked the single canonical format idea you
> suggested.
>
> My only concern is whether there are more commands/fields in FUSE that
> operate in an arch-specific way (e.g. ioctl)? If there really are parts
> that need to be arch-specific, then it might be necessary to negotiate
> an architecture after all.

How about something like this:

 - by default fall back to no translation for backward compatibility
 - server may request matching by sending its own arch identifier in
fuse_init_in
 - client sends back its arch identifier in fuse_init_out
 - client also sends back a flag indicating whether it will transform
to canonical or not

This means the client does not have to implement translation for every
architecture, only ones which are frequently used as guest.  The
server may opt to implement its own translation if it's lacking in the
client, or it can just fail.

We need to look at all the requests, if there are some other constants
that need to be transformed.

As for ioctl, the client cannot promise to transform everything, since
most are not interpreted by the kernel.  Ones which are, should be
transformed.

Thanks,
Miklos


