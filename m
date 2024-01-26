Return-Path: <linux-fsdevel+bounces-9043-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 661DE83D589
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 10:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E75711F26B8D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 09:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1773C65BB9;
	Fri, 26 Jan 2024 08:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TpCt1fl9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5454C612CF;
	Fri, 26 Jan 2024 08:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706256004; cv=none; b=gY2jBLb2xSQsvaufuaXLko3IEeos8FVltqev6+8sny/Hwk396C8FmcoEJSLSNcZmKJR4xayR29I+Jowv9W5VENWkOomNX0e1EqDPU2AksKJg/H5Z/o4MiQEAHSQg7iYd2MbdFUxAjuN2BgusNOa5w5U5obGTfDoSHHrnjt4uw2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706256004; c=relaxed/simple;
	bh=o9UrlAal6G/S30iXQfnVq2nuTTFQ/4b02ogSKoB6WBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H14W4rtSCnKQaGL76U99bDxccqVCtklqt1XyJL9o8GkVxMHoBMxu5ShCwsz/+9R6fxyMdNQggr0h+07FIZ3gw7K+iAPZNM3GcU4RhfEBywjtKb8JlRDLXCTCOJ6pCiYrNoGvCwrbHB8lUr3ndgXpvvy/97B9oNR8zhFJ0ZTSceQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TpCt1fl9; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-51005675963so554768e87.0;
        Fri, 26 Jan 2024 00:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706256000; x=1706860800; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/8hqt2SFHfJ4q86HFT49vy1zOoWWvxgjVKCrnK0jkDQ=;
        b=TpCt1fl90zR69h8nJqU3s3NTg9A6eXcV0E91mqQcFFtpyV8uQDYMFGj8HYd7UCOkTf
         3LfU6xMKjc8eGldgFGrDkaFUGw7c2ZCayo1Vj8sDj81/PwP5tN2FP2iZrCQRLdMZ1vyZ
         79P21548woaiWQQy9wb8SkWVT3j1IhEtTC2Vpu/RXaPo7SHxVVGyv5hxqPkMq8gSAKkQ
         0KLzjHTx9KXCbWz01d0ESaKqoyp6INxiCO5sTQB+kplCqqj4vPME7gIp5c3Y0XClbD9r
         lygcSd8vNaJkj6/vC/DKrWNiBkTAvi1KtpS2ePvdEuxGfPD0SnQFXN56y2cAKliFKBNU
         Sk/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706256000; x=1706860800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/8hqt2SFHfJ4q86HFT49vy1zOoWWvxgjVKCrnK0jkDQ=;
        b=FmTL5eVRPiTkFR4FqqDvDNWvA2mUiKdRq05XvEM8KlaGL6iMlJsrqmcnkdTMn+OuBk
         O1vCgnECZcVeoO4LYEw8IELP1HNtsqIae/kyrAToiexrj9suBdnlXxWpT2WskhjVh2YT
         sPENs+K7MfedC3wN/eKOoApoORV7RK/9I1nnUcXlt4X1UPYcL14GmKHkhGORW4nRuZwQ
         ySkhvrl8NXd3LhOKT2ZIG5aXtoKTC5fngxZgAbU1ZGJwCb+Jn0Z/GfH9GghUWHIN3wd+
         EJcej24BlgfXztSKHXqViyKS3u8gzJRrZTyTDXNNryE+6FF5US8dHSyNzRb4bOHs9zJ5
         QC8A==
X-Gm-Message-State: AOJu0YwgcEVz9IBKDFuKbh89YHYT6/rg0fvlfCOXBr5pxRbgltaZszi3
	v2BDu/F+DaWyh/BZj8/RcRWsPNEw9xmKlL0B/hJrxzPD/UbHsjixNfRF/ofE4RpH31U9aGxNpyP
	YSsEp1Ij1+OhkgMZ9+0VCzyHoobo=
X-Google-Smtp-Source: AGHT+IHCgCuxb4c2ngXVrYMFx9oVSfgBF9mfeeCBMXL3orNFZBA2hzGGkT7mfAZ9oxWspVLQvpi/MzClMoasYmg7sck=
X-Received: by 2002:a19:ad08:0:b0:510:11de:c384 with SMTP id
 t8-20020a19ad08000000b0051011dec384mr325378lfc.55.1706255999939; Thu, 25 Jan
 2024 23:59:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125071901.3223188-1-zhaoyang.huang@unisoc.com>
In-Reply-To: <20240125071901.3223188-1-zhaoyang.huang@unisoc.com>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Fri, 26 Jan 2024 15:59:48 +0800
Message-ID: <CAGWkznGpW=bUxET8yZGu4dNTBfsj7n79yXsTD23fE5-SWkdjfA@mail.gmail.com>
Subject: Re: [PATCHv3 1/1] block: introduce content activity based ioprio
To: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Matthew Wilcox <willy@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, 
	Yu Zhao <yuzhao@google.com>, Damien Le Moal <dlemoal@kernel.org>, 
	Niklas Cassel <niklas.cassel@wdc.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, 
	Hannes Reinecke <hare@suse.de>, Linus Walleij <linus.walleij@linaro.org>, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

loop more mm and fs guys for more comments

On Thu, Jan 25, 2024 at 3:22=E2=80=AFPM zhaoyang.huang
<zhaoyang.huang@unisoc.com> wrote:
>
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>
> Currently, request's ioprio are set via task's schedule priority(when no
> blkcg configured), which has high priority tasks possess the privilege on
> both of CPU and IO scheduling.
> This commit works as a hint of original policy by promoting the request i=
oprio
> based on the page/folio's activity. The original idea comes from LRU_GEN
> which provides more precised folio activity than before. This commit try
> to adjust the request's ioprio when certain part of its folios are hot,
> which indicate that this request carry important contents and need be
> scheduled ealier.
>
> This commit is verified on a v6.6 6GB RAM android14 system via 4 test cas=
es
> by changing the bio_add_page/folio API in ext4 and f2fs.
>
> Case 1:
> script[a] which get significant improved fault time as expected[b]
> where dd's cost also shrink from 55s to 40s.
> (1). fault_latency.bin is an ebpf based test tool which measure all task'=
s
>    iowait latency during page fault when scheduled out/in.
> (2). costmem generate page fault by mmaping a file and access the VA.
> (3). dd generate concurrent vfs io.
>
> [a]
> ./fault_latency.bin 1 5 > /data/dd_costmem &
> costmem -c0 -a2048000 -b128000 -o0 1>/dev/null &
> costmem -c0 -a2048000 -b128000 -o0 1>/dev/null &
> costmem -c0 -a2048000 -b128000 -o0 1>/dev/null &
> costmem -c0 -a2048000 -b128000 -o0 1>/dev/null &
> dd if=3D/dev/block/sda of=3D/data/ddtest bs=3D1024 count=3D2048000 &
> dd if=3D/dev/block/sda of=3D/data/ddtest1 bs=3D1024 count=3D2048000 &
> dd if=3D/dev/block/sda of=3D/data/ddtest2 bs=3D1024 count=3D2048000 &
> dd if=3D/dev/block/sda of=3D/data/ddtest3 bs=3D1024 count=3D2048000
> [b]
>                        mainline         commit
> io wait                836us            156us
>
> Case 2:
> fio -filename=3D/dev/block/by-name/userdata -rw=3Drandread -direct=3D0 -b=
s=3D4k -size=3D2000M -numjobs=3D8 -group_reporting -name=3Dmytest
> mainline: 513MiB/s
> READ: bw=3D531MiB/s (557MB/s), 531MiB/s-531MiB/s (557MB/s-557MB/s), io=3D=
15.6GiB (16.8GB), run=3D30137-30137msec
> READ: bw=3D543MiB/s (569MB/s), 543MiB/s-543MiB/s (569MB/s-569MB/s), io=3D=
15.6GiB (16.8GB), run=3D29469-29469msec
> READ: bw=3D474MiB/s (497MB/s), 474MiB/s-474MiB/s (497MB/s-497MB/s), io=3D=
15.6GiB (16.8GB), run=3D33724-33724msec
> READ: bw=3D535MiB/s (561MB/s), 535MiB/s-535MiB/s (561MB/s-561MB/s), io=3D=
15.6GiB (16.8GB), run=3D29928-29928msec
> READ: bw=3D523MiB/s (548MB/s), 523MiB/s-523MiB/s (548MB/s-548MB/s), io=3D=
15.6GiB (16.8GB), run=3D30617-30617msec
> READ: bw=3D492MiB/s (516MB/s), 492MiB/s-492MiB/s (516MB/s-516MB/s), io=3D=
15.6GiB (16.8GB), run=3D32518-32518msec
> READ: bw=3D533MiB/s (559MB/s), 533MiB/s-533MiB/s (559MB/s-559MB/s), io=3D=
15.6GiB (16.8GB), run=3D29993-29993msec
> READ: bw=3D524MiB/s (550MB/s), 524MiB/s-524MiB/s (550MB/s-550MB/s), io=3D=
15.6GiB (16.8GB), run=3D30526-30526msec
> READ: bw=3D529MiB/s (554MB/s), 529MiB/s-529MiB/s (554MB/s-554MB/s), io=3D=
15.6GiB (16.8GB), run=3D30269-30269msec
> READ: bw=3D449MiB/s (471MB/s), 449MiB/s-449MiB/s (471MB/s-471MB/s), io=3D=
15.6GiB (16.8GB), run=3D35629-35629msec
>
> commit: 633MiB/s
> READ: bw=3D668MiB/s (700MB/s), 668MiB/s-668MiB/s (700MB/s-700MB/s), io=3D=
15.6GiB (16.8GB), run=3D23952-23952msec
> READ: bw=3D589MiB/s (618MB/s), 589MiB/s-589MiB/s (618MB/s-618MB/s), io=3D=
15.6GiB (16.8GB), run=3D27164-27164msec
> READ: bw=3D638MiB/s (669MB/s), 638MiB/s-638MiB/s (669MB/s-669MB/s), io=3D=
15.6GiB (16.8GB), run=3D25071-25071msec
> READ: bw=3D714MiB/s (749MB/s), 714MiB/s-714MiB/s (749MB/s-749MB/s), io=3D=
15.6GiB (16.8GB), run=3D22409-22409msec
> READ: bw=3D600MiB/s (629MB/s), 600MiB/s-600MiB/s (629MB/s-629MB/s), io=3D=
15.6GiB (16.8GB), run=3D26669-26669msec
> READ: bw=3D592MiB/s (621MB/s), 592MiB/s-592MiB/s (621MB/s-621MB/s), io=3D=
15.6GiB (16.8GB), run=3D27036-27036msec
> READ: bw=3D691MiB/s (725MB/s), 691MiB/s-691MiB/s (725MB/s-725MB/s), io=3D=
15.6GiB (16.8GB), run=3D23150-23150msec
> READ: bw=3D569MiB/s (596MB/s), 569MiB/s-569MiB/s (596MB/s-596MB/s), io=3D=
15.6GiB (16.8GB), run=3D28142-28142msec
> READ: bw=3D563MiB/s (590MB/s), 563MiB/s-563MiB/s (590MB/s-590MB/s), io=3D=
15.6GiB (16.8GB), run=3D28429-28429msec
> READ: bw=3D712MiB/s (746MB/s), 712MiB/s-712MiB/s (746MB/s-746MB/s), io=3D=
15.6GiB (16.8GB), run=3D22478-22478msec
>
> Case 3:
> This commit is also verified by the case of launching camera APP which is
> usually considered as heavy working load on both of memory and IO, which
> shows 12%-24% improvement.
>
>                 ttl =3D 0         ttl =3D 50        ttl =3D 100
> mainline        2267ms          2420ms          2316ms
> commit          1992ms          1806ms          1998ms
>
> case 4:
> androbench has no improvment as well as regression which supposed to be
> its test time is short which MGLRU hasn't take effect yet.
>
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
> change of v2: calculate page's activity via helper function
> change of v3: solve layer violation by move API into mm
> change of v4: keep block clean by removing the page related API
> ---
> ---
>  include/linux/act_ioprio.h  | 62 +++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/ioprio.h | 44 +++++++++++++++++++++++---
>  mm/Kconfig                  |  8 +++++
>  3 files changed, 110 insertions(+), 4 deletions(-)
>  create mode 100644 include/linux/act_ioprio.h
>
> diff --git a/include/linux/act_ioprio.h b/include/linux/act_ioprio.h
> new file mode 100644
> index 000000000000..8cfb3df270bd
> --- /dev/null
> +++ b/include/linux/act_ioprio.h
> @@ -0,0 +1,62 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +#ifndef _ACT_IOPRIO_H
> +#define _ACT_IOPRIO_H
> +
> +#include <linux/bio.h>
> +
> +#ifdef CONFIG_CONTENT_ACT_BASED_IOPRIO
> +bool BIO_ADD_FOLIO(struct bio *bio, struct folio *folio, size_t len,
> +               size_t off)
> +{
> +       int class, level, hint, activity;
> +
> +       if (len > UINT_MAX || off > UINT_MAX)
> +               return false;
> +
> +       class =3D IOPRIO_PRIO_CLASS(bio->bi_ioprio);
> +       level =3D IOPRIO_PRIO_LEVEL(bio->bi_ioprio);
> +       hint =3D IOPRIO_PRIO_HINT(bio->bi_ioprio);
> +       activity =3D IOPRIO_PRIO_ACTIVITY(bio->bi_ioprio);
> +
> +       activity +=3D (bio->bi_vcnt + 1 <=3D IOPRIO_NR_ACTIVITY &&
> +                       PageWorkingset(&folio->page)) ? 1 : 0;
> +       if (activity >=3D bio->bi_vcnt / 2)
> +               class =3D IOPRIO_CLASS_RT;
> +       else if (activity >=3D bio->bi_vcnt / 4)
> +               class =3D max(IOPRIO_PRIO_CLASS(get_current_ioprio()), IO=
PRIO_CLASS_BE);
> +
> +       bio->bi_ioprio =3D IOPRIO_PRIO_VALUE_ACTIVITY(class, level, hint,=
 activity);
> +
> +       return bio_add_page(bio, &folio->page, len, off) > 0;
> +}
> +
> +int BIO_ADD_PAGE(struct bio *bio, struct page *page,
> +               unsigned int len, unsigned int offset)
> +{
> +       int class, level, hint, activity;
> +
> +       if (bio_add_page(bio, page, len, offset) > 0) {
> +               class =3D IOPRIO_PRIO_CLASS(bio->bi_ioprio);
> +               level =3D IOPRIO_PRIO_LEVEL(bio->bi_ioprio);
> +               hint =3D IOPRIO_PRIO_HINT(bio->bi_ioprio);
> +               activity =3D IOPRIO_PRIO_ACTIVITY(bio->bi_ioprio);
> +               activity +=3D (bio->bi_vcnt <=3D IOPRIO_NR_ACTIVITY && Pa=
geWorkingset(page)) ? 1 : 0;
> +               bio->bi_ioprio =3D IOPRIO_PRIO_VALUE_ACTIVITY(class, leve=
l, hint, activity);
> +       }
> +
> +       return len;
> +}
> +#else
> +bool BIO_ADD_FOLIO(struct bio *bio, struct folio *folio, size_t len,
> +               size_t off)
> +{
> +       return bio_add_folio(bio, folio, len, off);
> +}
> +
> +int BIO_ADD_PAGE(struct bio *bio, struct page *page,
> +               unsigned int len, unsigned int offset)
> +{
> +       return bio_add_page(bio, page, len, offset);
> +}
> +#endif
> +#endif
> diff --git a/include/uapi/linux/ioprio.h b/include/uapi/linux/ioprio.h
> index bee2bdb0eedb..f933af54d71e 100644
> --- a/include/uapi/linux/ioprio.h
> +++ b/include/uapi/linux/ioprio.h
> @@ -71,12 +71,24 @@ enum {
>   * class and level.
>   */
>  #define IOPRIO_HINT_SHIFT              IOPRIO_LEVEL_NR_BITS
> +#ifdef CONFIG_CONTENT_ACT_BASED_IOPRIO
> +#define IOPRIO_HINT_NR_BITS            3
> +#else
>  #define IOPRIO_HINT_NR_BITS            10
> +#endif
>  #define IOPRIO_NR_HINTS                        (1 << IOPRIO_HINT_NR_BITS=
)
>  #define IOPRIO_HINT_MASK               (IOPRIO_NR_HINTS - 1)
>  #define IOPRIO_PRIO_HINT(ioprio)       \
>         (((ioprio) >> IOPRIO_HINT_SHIFT) & IOPRIO_HINT_MASK)
>
> +#ifdef CONFIG_CONTENT_ACT_BASED_IOPRIO
> +#define IOPRIO_ACTIVITY_SHIFT          (IOPRIO_HINT_NR_BITS + IOPRIO_LEV=
EL_NR_BITS)
> +#define IOPRIO_ACTIVITY_NR_BITS                7
> +#define IOPRIO_NR_ACTIVITY             (1 << IOPRIO_ACTIVITY_NR_BITS)
> +#define IOPRIO_ACTIVITY_MASK           (IOPRIO_NR_ACTIVITY - 1)
> +#define IOPRIO_PRIO_ACTIVITY(ioprio)   \
> +       (((ioprio) >> IOPRIO_ACTIVITY_SHIFT) & IOPRIO_ACTIVITY_MASK)
> +#endif
>  /*
>   * I/O hints.
>   */
> @@ -104,24 +116,48 @@ enum {
>
>  #define IOPRIO_BAD_VALUE(val, max) ((val) < 0 || (val) >=3D (max))
>
> +#ifndef CONFIG_CONTENT_ACT_BASED_IOPRIO
>  /*
>   * Return an I/O priority value based on a class, a level and a hint.
>   */
>  static __always_inline __u16 ioprio_value(int prioclass, int priolevel,
> -                                         int priohint)
> +               int priohint)
>  {
>         if (IOPRIO_BAD_VALUE(prioclass, IOPRIO_NR_CLASSES) ||
> -           IOPRIO_BAD_VALUE(priolevel, IOPRIO_NR_LEVELS) ||
> -           IOPRIO_BAD_VALUE(priohint, IOPRIO_NR_HINTS))
> +                       IOPRIO_BAD_VALUE(priolevel, IOPRIO_NR_LEVELS) ||
> +                       IOPRIO_BAD_VALUE(priohint, IOPRIO_NR_HINTS))
>                 return IOPRIO_CLASS_INVALID << IOPRIO_CLASS_SHIFT;
>
>         return (prioclass << IOPRIO_CLASS_SHIFT) |
>                 (priohint << IOPRIO_HINT_SHIFT) | priolevel;
>  }
> -
>  #define IOPRIO_PRIO_VALUE(prioclass, priolevel)                        \
>         ioprio_value(prioclass, priolevel, IOPRIO_HINT_NONE)
>  #define IOPRIO_PRIO_VALUE_HINT(prioclass, priolevel, priohint) \
>         ioprio_value(prioclass, priolevel, priohint)
> +#else
> +/*
> + * Return an I/O priority value based on a class, a level and a hint.
> + */
> +static __always_inline __u16 ioprio_value(int prioclass, int priolevel,
> +               int priohint, int activity)
> +{
> +       if (IOPRIO_BAD_VALUE(prioclass, IOPRIO_NR_CLASSES) ||
> +                       IOPRIO_BAD_VALUE(priolevel, IOPRIO_NR_LEVELS) ||
> +                       IOPRIO_BAD_VALUE(priohint, IOPRIO_NR_HINTS) ||
> +                       IOPRIO_BAD_VALUE(activity, IOPRIO_NR_ACTIVITY))
> +               return IOPRIO_CLASS_INVALID << IOPRIO_CLASS_SHIFT;
>
> +       return (prioclass << IOPRIO_CLASS_SHIFT) |
> +               (activity << IOPRIO_ACTIVITY_SHIFT) |
> +               (priohint << IOPRIO_HINT_SHIFT) | priolevel;
> +}
> +
> +#define IOPRIO_PRIO_VALUE(prioclass, priolevel)                        \
> +       ioprio_value(prioclass, priolevel, IOPRIO_HINT_NONE, 0)
> +#define IOPRIO_PRIO_VALUE_HINT(prioclass, priolevel, priohint) \
> +       ioprio_value(prioclass, priolevel, priohint, 0)
> +#define IOPRIO_PRIO_VALUE_ACTIVITY(prioclass, priolevel, priohint, activ=
ity)   \
> +       ioprio_value(prioclass, priolevel, priohint, activity)
> +#endif
>  #endif /* _UAPI_LINUX_IOPRIO_H */
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 264a2df5ecf5..e0e5a5a44ded 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -1240,6 +1240,14 @@ config LRU_GEN_STATS
>           from evicted generations for debugging purpose.
>
>           This option has a per-memcg and per-node memory overhead.
> +
> +config CONTENT_ACT_BASED_IOPRIO
> +       bool "Enable content activity based ioprio"
> +       depends on LRU_GEN
> +       default n
> +       help
> +         This item enable the feature of adjust bio's priority by
> +         calculating its content's activity.
>  # }
>
>  config ARCH_SUPPORTS_PER_VMA_LOCK
> --
> 2.25.1
>

