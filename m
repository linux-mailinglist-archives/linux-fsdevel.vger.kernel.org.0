Return-Path: <linux-fsdevel+bounces-37482-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D45B9F2E1F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 11:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EFDE1888E9A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 10:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AA32036F3;
	Mon, 16 Dec 2024 10:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hUVhrB4a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189952036EC
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Dec 2024 10:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734344632; cv=none; b=Fp8N4erwpBf7Up/JWhCNdDW8o9A7AOufX2VgmM2hRvJxKwCmwDzTJLQ45udYO16H1uwYDsLEKPusfU0UKtnxSx8EIPKbT6kwNVmPZWGZn2OVCoLcIlszXT1Y93V/lixJ6Y6QiizYhxN+RfGfliHjWZHXVP+beogQCM/tK1wILqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734344632; c=relaxed/simple;
	bh=2XX3E0IH8ishDR9MK6kWsOiO7vDqmqVnxmnRnxHXd1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XOksbufev+woowuFJlTkUjw12xAIQxU8SiKrVO/V/1axRw8qoRPhBR35oJr4vJJalPXwHNkbjdW0EGsgh2cNRkHwLSEzDcfyAZbMbo9VCjQKSAfdT1+V1gyuZvBXqyMxabisVuou7zvc4Vu/I70CGkgDuucsC3FWWoiG+5g4dwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hUVhrB4a; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734344629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vJcwxIokippDLEGmOLSsMdzfJJziVp7aAF/Ta+P0mDo=;
	b=hUVhrB4aaVtQNgMU88CMnozzOaOdywNVw5wgHOLU6njYAmH6AB0Qsm5foQINvvsGb8s8ck
	mQNsmq/8dzUQu/cgytB31wzGNyoIOUhBcIH765uM4uhCxGKiO8tbpL9L2kyBA83cwQcJZq
	u8A4tx8G1VKgb9xWvJYgE/dAEN4tOms=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-V1SPnYe4O46P-9pKl2wmkA-1; Mon, 16 Dec 2024 05:23:48 -0500
X-MC-Unique: V1SPnYe4O46P-9pKl2wmkA-1
X-Mimecast-MFC-AGG-ID: V1SPnYe4O46P-9pKl2wmkA
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-4b03fdeda53so2869207137.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Dec 2024 02:23:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734344628; x=1734949428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vJcwxIokippDLEGmOLSsMdzfJJziVp7aAF/Ta+P0mDo=;
        b=uuGcTMxcxVJNCq8e59KKBWZJzl9YRWTdsp1+GkOwi2zjA+6BWRqNoZzCMcOTmLhb5V
         Otri+33lV29Ombrwric7BjHryOnRrBR30coazbi/OYBRg2wpGeTmAEPiOfUBWjDZDVQk
         yrBVI92R0Faz3TgO/dxUpP0/AJ/MX9wWcShzA9Bqrr9FX6tbjBQnf+MmcB44JKZWCS5k
         ws4UqVdAa2oOEsYM3weu3A09QiP+fCl6rY8TWSlXxEAe3pAwOOujhA/qcNr+veePmcox
         md4mbwBYxdv5XWI3r0t438Ejw8BotHvJvHZAE5mN0+24OPscyzu05icOQ9MfUH76q2Gq
         WUkA==
X-Forwarded-Encrypted: i=1; AJvYcCW/tjLCNFz5jLogxl+5iTKxLlTMvakIWHFBgIXWBRYGq4UZoTRR4LwC7zlgH14eULMkqGgdFaNWD3MB9eSg@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3tdKFEO6IZ4SrNLXwYqJS9klssvPTKEVGOGAKGgvvlIzQMEdg
	zyaBc3mFDE0ibLeo5lyiaT7N8ZI4CLzDO12ALPnz8TlUP0JfVmZg+jwnq3MzZgaVuSqOWE7aeGN
	xP+XTAn6P+iWSi1Oj9TFtBTXSNPoiytHrPQuRijzzG+0OUO/l2JiKWnkU17A49Vfa7cM5ipKkFt
	TqxzyM26OBEJVHXzmtHP+n1j0HiOJ07orGsKYHsQ==
X-Gm-Gg: ASbGncuUFot7Vo6W7/XNdabxHRmNj2uEiXsv48CNLjBuuI9xeY3Ws3b88Qix5WrmXqT
	k38IzyVjQpRHaQ9U67w2sgCbBjUSvr8R5FdRuKuk=
X-Received: by 2002:a05:6102:4429:b0:4b2:49ff:e470 with SMTP id ada2fe7eead31-4b25db3af8dmr10656207137.21.1734344628071;
        Mon, 16 Dec 2024 02:23:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGWgSqRtLOuNkBzntYjpPcstXq1/HmQRBLuSGUi/bM5OVCIjhSFTH920y7viqRb3c8aGdcrUoqEC78K21wnR44=
X-Received: by 2002:a05:6102:4429:b0:4b2:49ff:e470 with SMTP id
 ada2fe7eead31-4b25db3af8dmr10656192137.21.1734344627848; Mon, 16 Dec 2024
 02:23:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241214031050.1337920-1-mcgrof@kernel.org> <20241214031050.1337920-10-mcgrof@kernel.org>
 <9fadee49-b545-440e-b0c9-e552bec1f079@oracle.com> <CAFj5m9J0Lkr9hYx_3Vm2krC9Ja5+-xjmqkqjVjY0jvimjWbmTw@mail.gmail.com>
 <f872429f-9c81-444b-a4ea-ecb5af495e51@oracle.com>
In-Reply-To: <f872429f-9c81-444b-a4ea-ecb5af495e51@oracle.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Mon, 16 Dec 2024 18:23:37 +0800
Message-ID: <CAFj5m9JOOS8yQSk1jksJdYz-wqQT8aAAQG08J-wWg2OF2jc3nQ@mail.gmail.com>
Subject: Re: [RFC v2 09/11] block/bdev: lift block size restrictions and use
 common definition
To: John Garry <john.g.garry@oracle.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, willy@infradead.org, hch@lst.de, hare@suse.de, 
	dave@stgolabs.net, david@fromorbit.com, djwong@kernel.org, 
	ritesh.list@gmail.com, kbusch@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-mm@kvack.org, linux-block@vger.kernel.org, 
	gost.dev@samsung.com, p.raghav@samsung.com, da.gomez@samsung.com, 
	kernel@pankajraghav.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 6:14=E2=80=AFPM John Garry <john.g.garry@oracle.com=
> wrote:
>
> On 16/12/2024 09:19, Ming Lei wrote:
> > On Mon, Dec 16, 2024 at 4:58=E2=80=AFPM John Garry <john.g.garry@oracle=
.com> wrote:
> >>
> >> On 14/12/2024 03:10, Luis Chamberlain wrote:
> >>> index 167d82b46781..b57dc4bff81b 100644
> >>> --- a/block/bdev.c
> >>> +++ b/block/bdev.c
> >>> @@ -157,8 +157,7 @@ int set_blocksize(struct file *file, int size)
> >>>        struct inode *inode =3D file->f_mapping->host;
> >>>        struct block_device *bdev =3D I_BDEV(inode);
> >>>
> >>> -     /* Size must be a power of two, and between 512 and PAGE_SIZE *=
/
> >>> -     if (size > PAGE_SIZE || size < 512 || !is_power_of_2(size))
> >>> +     if (blk_validate_block_size(size))
> >>>                return -EINVAL;
> >>
> >> I suppose that this can be sent as a separate patch to be merged now.
> >
> > There have been some bugs found in case that PAGE_SIZE =3D=3D 64K, and =
I
> > think it is bad to use PAGE_SIZE for validating many hw/queue limits, w=
e might
> > have to fix them first.
>
> I am just suggesting to remove duplicated code, as these checks are same
> as blk_validate_block_size()

My fault, misunderstood your point as pushing this single patch only.

>
> >
> > Such as:
>
> Aren't the below list just enforcing block layer requirements? And so
> only block drivers need fixing for PAGE_SIZE > 4K (or cannot be used for
> PAGE_SIZE > 4K), right?

It is block layer which should be fixed to support  PAGE_SIZE > 4K.

Thanks,


