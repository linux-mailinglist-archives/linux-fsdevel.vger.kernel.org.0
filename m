Return-Path: <linux-fsdevel+bounces-9531-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8134842535
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 13:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08C451C223FF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 12:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14876A328;
	Tue, 30 Jan 2024 12:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbRRDLAi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFFB6A00B;
	Tue, 30 Jan 2024 12:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706618627; cv=none; b=j64n8BEJEHbrlS6VNLsHjz+e19TUY6bUtgEk5Z/o6pN9TdRuYeN1+pYQpJ7TimAALVAlRCeh+UhY1KqkAt71eoP+qjwvflWFLGowV8pjfaDiQHKlpq5nefLo9wGKxJlIbOI/fwImrca+t0w5IDdG/RJmghQ7u+S9BYUePr2TiwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706618627; c=relaxed/simple;
	bh=1Uo/xkN+9gaezyc46SJZCG6Zr5dQ/lioCn+STM36yRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TRLZAVm1wWew4Aclfs+pb93ZIrZkvbAjQwn4NFxTaUduNUzwBGFeOL/fw8CSkuDs1wPcSZWFTiHhNSXNRaduuxEyYuFVKXV8eS7+lMQ+b2jfKcgbq+wTSxQGD5qEZFf+IcNeUWQGH1Fj2TEFno6IWiGxv42VAXmUU9aP9al5eBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kbRRDLAi; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-510322d5275so4218888e87.1;
        Tue, 30 Jan 2024 04:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706618623; x=1707223423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=91W+fME9cqf0T58AHOP/Uaxln00I+MGl8kanW36xXY8=;
        b=kbRRDLAiLvUvDzwnuIT0RX62aJ1Bzcg6D8ds3o541ubqTqx+oX1vVa1fdioiJPQs49
         8fV7Ti+rmnsy42xeT/CHZSo2vXMnvBHgIDPpeWJ2n+tthptqyAAlgOJljO1Knm21DzyZ
         Cw0e/UVnmCNnna/GRU/mBS172lOUWyZ4BlWEsRkPPKjckkowCK0dYajlxCMg6eIMOLyW
         Ai8f+Bo39ZINf8FdQYRUZpTs0dgcAyAxAOChhbv7YjKP0QYp8xer2ifNwUdNqQUrj0x4
         JwhImSwhBygBppxT6Ul7XXpKjGaKl3oic647LXOcI1Ztw6lNdCR9HobcGFNE1iQUT9nG
         Xkog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706618623; x=1707223423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=91W+fME9cqf0T58AHOP/Uaxln00I+MGl8kanW36xXY8=;
        b=rFo2iKwKNCS1w0Yq4maW5VFTF1XPxIHV9CEQkKiLzr7BQQHvtSdDDQcQPU6FooOZ4X
         EasnksXXX77iWDBpTULY123cq8oJFJ7ql4FNj0VxbPRfJWAzBhiohxAlDtSz5JiLJWxy
         A0uApUxa/rCycBfpeDhCenTM1VWCuzOTnJxggzISkmzUs50d9h8MzP6fs7nSXUEHZpT+
         cP4Iy8xumSn2jeCi1SfCmELPsBRgJImeAXz8NTmae5DbzJtzgItQJUF7ZYB5aH873KVM
         WrbqK3AGJKMmLJeqCLRhJtnjmqQ9KlC3ndWE0z6rNAqJUETupnCclylUnf4yDkUnmBKN
         O1lA==
X-Gm-Message-State: AOJu0YyPqtSAUtAPJHCEKdZukmlZMuse+m4fwjIUC2P5L/PgvF8rZdIG
	jPYrhuAPhALNAYBs8dUBe38Vw9Z9nr6SGeCMh4u/Ot2oo7z2QGwitgPzekhl7LHWjzWjUxxdkMR
	Uf8rws38uDjrZBTqYF88dhO7VQvo=
X-Google-Smtp-Source: AGHT+IGUvvrppGtG1b57rdeHaSiYrKoWR2zDdxP4f2sst1gRYZU9mJydTMTHa3dbQMIvAkDpljehxf8NHxP5W7ORuv0=
X-Received: by 2002:a05:6512:1d1:b0:510:25f0:3c01 with SMTP id
 f17-20020a05651201d100b0051025f03c01mr7233117lfp.13.1706618622750; Tue, 30
 Jan 2024 04:43:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130084207.3760518-1-zhaoyang.huang@unisoc.com> <aa307901-d20a-4301-8774-97287d7192e9@kernel.org>
In-Reply-To: <aa307901-d20a-4301-8774-97287d7192e9@kernel.org>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Tue, 30 Jan 2024 20:43:31 +0800
Message-ID: <CAGWkznFG003aQ3-XAzdmGev7FP6x5pvp=xS8Z9sZknUHZEGHow@mail.gmail.com>
Subject: Re: [PATCHv5 1/1] block: introduce content activity based ioprio
To: Damien Le Moal <dlemoal@kernel.org>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Jens Axboe <axboe@kernel.dk>, Matthew Wilcox <willy@infradead.org>, Yu Zhao <yuzhao@google.com>, 
	Niklas Cassel <niklas.cassel@wdc.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, 
	Hannes Reinecke <hare@suse.de>, Linus Walleij <linus.walleij@linaro.org>, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 5:17=E2=80=AFPM Damien Le Moal <dlemoal@kernel.org>=
 wrote:
>
> On 1/30/24 17:42, zhaoyang.huang wrote:
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> > Currently, request's ioprio are set via task's schedule priority(when n=
o
> > blkcg configured), which has high priority tasks possess the privilege =
on
> > both of CPU and IO scheduling.
> > This commit works as a hint of original policy by promoting the request=
 ioprio
> > based on the page/folio's activity. The original idea comes from LRU_GE=
N
> > which provides more precised folio activity than before. This commit tr=
y
> > to adjust the request's ioprio when certain part of its folios are hot,
> > which indicate that this request carry important contents and need be
> > scheduled ealier.
> >
> > This commit is verified on a v6.6 6GB RAM android14 system via 4 test c=
ases
> > by changing the bio_add_page/folio API in erofs, ext4 and f2fs in
> > another commit.
> >
> > Case 1:
> > script[a] which get significant improved fault time as expected[b]
> > where dd's cost also shrink from 55s to 40s.
> > (1). fault_latency.bin is an ebpf based test tool which measure all tas=
k's
> >    iowait latency during page fault when scheduled out/in.
> > (2). costmem generate page fault by mmaping a file and access the VA.
> > (3). dd generate concurrent vfs io.
> >
> > [a]
> > ./fault_latency.bin 1 5 > /data/dd_costmem &
> > costmem -c0 -a2048000 -b128000 -o0 1>/dev/null &
> > costmem -c0 -a2048000 -b128000 -o0 1>/dev/null &
> > costmem -c0 -a2048000 -b128000 -o0 1>/dev/null &
> > costmem -c0 -a2048000 -b128000 -o0 1>/dev/null &
> > dd if=3D/dev/block/sda of=3D/data/ddtest bs=3D1024 count=3D2048000 &
> > dd if=3D/dev/block/sda of=3D/data/ddtest1 bs=3D1024 count=3D2048000 &
> > dd if=3D/dev/block/sda of=3D/data/ddtest2 bs=3D1024 count=3D2048000 &
> > dd if=3D/dev/block/sda of=3D/data/ddtest3 bs=3D1024 count=3D2048000
> > [b]
> >                        mainline               commit
> > io wait                836us            156us
> >
> > Case 2:
> > fio -filename=3D/dev/block/by-name/userdata -rw=3Drandread -direct=3D0 =
-bs=3D4k -size=3D2000M -numjobs=3D8 -group_reporting -name=3Dmytest
> > mainline: 513MiB/s
> > READ: bw=3D531MiB/s (557MB/s), 531MiB/s-531MiB/s (557MB/s-557MB/s), io=
=3D15.6GiB (16.8GB), run=3D30137-30137msec
> > READ: bw=3D543MiB/s (569MB/s), 543MiB/s-543MiB/s (569MB/s-569MB/s), io=
=3D15.6GiB (16.8GB), run=3D29469-29469msec
> > READ: bw=3D474MiB/s (497MB/s), 474MiB/s-474MiB/s (497MB/s-497MB/s), io=
=3D15.6GiB (16.8GB), run=3D33724-33724msec
> > READ: bw=3D535MiB/s (561MB/s), 535MiB/s-535MiB/s (561MB/s-561MB/s), io=
=3D15.6GiB (16.8GB), run=3D29928-29928msec
> > READ: bw=3D523MiB/s (548MB/s), 523MiB/s-523MiB/s (548MB/s-548MB/s), io=
=3D15.6GiB (16.8GB), run=3D30617-30617msec
> > READ: bw=3D492MiB/s (516MB/s), 492MiB/s-492MiB/s (516MB/s-516MB/s), io=
=3D15.6GiB (16.8GB), run=3D32518-32518msec
> > READ: bw=3D533MiB/s (559MB/s), 533MiB/s-533MiB/s (559MB/s-559MB/s), io=
=3D15.6GiB (16.8GB), run=3D29993-29993msec
> > READ: bw=3D524MiB/s (550MB/s), 524MiB/s-524MiB/s (550MB/s-550MB/s), io=
=3D15.6GiB (16.8GB), run=3D30526-30526msec
> > READ: bw=3D529MiB/s (554MB/s), 529MiB/s-529MiB/s (554MB/s-554MB/s), io=
=3D15.6GiB (16.8GB), run=3D30269-30269msec
> > READ: bw=3D449MiB/s (471MB/s), 449MiB/s-449MiB/s (471MB/s-471MB/s), io=
=3D15.6GiB (16.8GB), run=3D35629-35629msec
> >
> > commit: 633MiB/s
> > READ: bw=3D668MiB/s (700MB/s), 668MiB/s-668MiB/s (700MB/s-700MB/s), io=
=3D15.6GiB (16.8GB), run=3D23952-23952msec
> > READ: bw=3D589MiB/s (618MB/s), 589MiB/s-589MiB/s (618MB/s-618MB/s), io=
=3D15.6GiB (16.8GB), run=3D27164-27164msec
> > READ: bw=3D638MiB/s (669MB/s), 638MiB/s-638MiB/s (669MB/s-669MB/s), io=
=3D15.6GiB (16.8GB), run=3D25071-25071msec
> > READ: bw=3D714MiB/s (749MB/s), 714MiB/s-714MiB/s (749MB/s-749MB/s), io=
=3D15.6GiB (16.8GB), run=3D22409-22409msec
> > READ: bw=3D600MiB/s (629MB/s), 600MiB/s-600MiB/s (629MB/s-629MB/s), io=
=3D15.6GiB (16.8GB), run=3D26669-26669msec
> > READ: bw=3D592MiB/s (621MB/s), 592MiB/s-592MiB/s (621MB/s-621MB/s), io=
=3D15.6GiB (16.8GB), run=3D27036-27036msec
> > READ: bw=3D691MiB/s (725MB/s), 691MiB/s-691MiB/s (725MB/s-725MB/s), io=
=3D15.6GiB (16.8GB), run=3D23150-23150msec
> > READ: bw=3D569MiB/s (596MB/s), 569MiB/s-569MiB/s (596MB/s-596MB/s), io=
=3D15.6GiB (16.8GB), run=3D28142-28142msec
> > READ: bw=3D563MiB/s (590MB/s), 563MiB/s-563MiB/s (590MB/s-590MB/s), io=
=3D15.6GiB (16.8GB), run=3D28429-28429msec
> > READ: bw=3D712MiB/s (746MB/s), 712MiB/s-712MiB/s (746MB/s-746MB/s), io=
=3D15.6GiB (16.8GB), run=3D22478-22478msec
> >
> > Case 3:
> > This commit is also verified by the case of launching camera APP which =
is
> > usually considered as heavy working load on both of memory and IO, whic=
h
> > shows 12%-24% improvement.
> >
> >               ttl =3D 0         ttl =3D 50        ttl =3D 100
> > mainline        2267ms                2420ms          2316ms
> > commit          1992ms          1806ms          1998ms
> >
> > case 4:
> > androbench has no improvment as well as regression which supposed to be
> > its test time is short which MGLRU hasn't take effect yet.
> >
> > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > ---
> > change of v2: calculate page's activity via helper function
> > change of v3: solve layer violation by move API into mm
> > change of v4: keep block clean by removing the page related API
> > change of v5: introduce the macros of bio_add_folio/page for read dir.
> > ---
> > ---
> >  include/linux/act_ioprio.h  | 60 +++++++++++++++++++++++++++++++++++++
> >  include/uapi/linux/ioprio.h | 38 +++++++++++++++++++++++
> >  mm/Kconfig                  |  8 +++++
> >  3 files changed, 106 insertions(+)
> >  create mode 100644 include/linux/act_ioprio.h
> >
> > diff --git a/include/linux/act_ioprio.h b/include/linux/act_ioprio.h
> > new file mode 100644
> > index 000000000000..ca7309b85758
> > --- /dev/null
> > +++ b/include/linux/act_ioprio.h
> > @@ -0,0 +1,60 @@
> > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > +#ifndef _ACT_IOPRIO_H
> > +#define _ACT_IOPRIO_H
> > +
> > +#ifdef CONFIG_CONTENT_ACT_BASED_IOPRIO
> > +#include <linux/bio.h>
> > +
> > +static __maybe_unused
> > +bool act_bio_add_folio(struct bio *bio, struct folio *folio, size_t le=
n,
> > +             size_t off)
> > +{
> > +     int class, level, hint, activity;
> > +     bool ret;
> > +
> > +     ret =3D bio_add_folio(bio, folio, len, off);
> > +     if (bio_op(bio) =3D=3D REQ_OP_READ && ret) {
> > +             class =3D IOPRIO_PRIO_CLASS(bio->bi_ioprio);
> > +             level =3D IOPRIO_PRIO_LEVEL(bio->bi_ioprio);
> > +             hint =3D IOPRIO_PRIO_HINT(bio->bi_ioprio);
> > +             activity =3D IOPRIO_PRIO_ACTIVITY(bio->bi_ioprio);
> > +             activity +=3D (activity < IOPRIO_NR_ACTIVITY &&
> > +                             folio_test_workingset(folio)) ? 1 : 0;
> > +             if (activity >=3D bio->bi_vcnt / 2)
> > +                     class =3D IOPRIO_CLASS_RT;
> > +             else if (activity >=3D bio->bi_vcnt / 4)
> > +                     class =3D max(IOPRIO_PRIO_CLASS(get_current_iopri=
o()), IOPRIO_CLASS_BE);
> > +             activity =3D min(IOPRIO_NR_ACTIVITY - 1, activity);
> > +             bio->bi_ioprio =3D IOPRIO_PRIO_VALUE_ACTIVITY(class, leve=
l, hint, activity);
> > +     }
> > +     return ret;
> > +}
>
> Big non-inline functions in a header file... That is unusual, to say the =
least.
> So every FS that includes this will get its own copy of the binary for th=
ese
> functions. That is not exactly optimal.
Thanks for quick reply:D
This is a trade-off method for having both the block layer and fs be
clean and do no modification. There is less calling bio_add_xxx within
fs actually.
>
> > +
> > +static __maybe_unused
> > +int act_bio_add_page(struct bio *bio, struct page *page,
> > +             unsigned int len, unsigned int offset)
> > +{
> > +     int class, level, hint, activity;
> > +     int ret =3D 0;
> > +
> > +     ret =3D bio_add_page(bio, page, len, offset);
> > +     if (bio_op(bio) =3D=3D REQ_OP_READ && ret > 0) {
> > +             class =3D IOPRIO_PRIO_CLASS(bio->bi_ioprio);
> > +             level =3D IOPRIO_PRIO_LEVEL(bio->bi_ioprio);
> > +             hint =3D IOPRIO_PRIO_HINT(bio->bi_ioprio);
> > +             activity =3D IOPRIO_PRIO_ACTIVITY(bio->bi_ioprio);
> > +             activity +=3D (activity < IOPRIO_NR_ACTIVITY &&
> > +                             PageWorkingset(page)) ? 1 : 0;
> > +             if (activity >=3D bio->bi_vcnt / 2)
> > +                     class =3D IOPRIO_CLASS_RT;
> > +             else if (activity >=3D bio->bi_vcnt / 4)
> > +                     class =3D max(IOPRIO_PRIO_CLASS(get_current_iopri=
o()), IOPRIO_CLASS_BE);
> > +             activity =3D min(IOPRIO_NR_ACTIVITY - 1, activity);
> > +             bio->bi_ioprio =3D IOPRIO_PRIO_VALUE_ACTIVITY(class, leve=
l, hint, activity);
> > +     }
> > +     return ret;
> > +}
> > +#define bio_add_folio(bio, folio, len, off)     act_bio_add_folio(bio,=
 folio, len, off)
> > +#define bio_add_page(bio, page, len, offset)    act_bio_add_page(bio, =
page, len, offset)
>
> These functions are *NOT* part of the block layer. So please do not prete=
nd they
> are. Why don't you simply write a function equivalent to what you have in=
side
> the "if" above and have the FS call that after bio_add_Page() ?
The iteration of bio is costly(could be maximum to 256 pages) and
needs fs's code modification. I will implement a version as you
suggested.
>
> And I seriously doubt that all compilers will be happy with these macro n=
ames
> clashing with real function names...
>
> > +#endif
> > +#endif
> > diff --git a/include/uapi/linux/ioprio.h b/include/uapi/linux/ioprio.h
> > index bee2bdb0eedb..64cf5ff0ac5f 100644
> > --- a/include/uapi/linux/ioprio.h
> > +++ b/include/uapi/linux/ioprio.h
> > @@ -71,12 +71,24 @@ enum {
> >   * class and level.
> >   */
> >  #define IOPRIO_HINT_SHIFT            IOPRIO_LEVEL_NR_BITS
> > +#ifdef CONFIG_CONTENT_ACT_BASED_IOPRIO
> > +#define IOPRIO_HINT_NR_BITS          3
> > +#else
> >  #define IOPRIO_HINT_NR_BITS          10
> > +#endif
> >  #define IOPRIO_NR_HINTS                      (1 << IOPRIO_HINT_NR_BITS=
)
> >  #define IOPRIO_HINT_MASK             (IOPRIO_NR_HINTS - 1)
> >  #define IOPRIO_PRIO_HINT(ioprio)     \
> >       (((ioprio) >> IOPRIO_HINT_SHIFT) & IOPRIO_HINT_MASK)
> >
> > +#ifdef CONFIG_CONTENT_ACT_BASED_IOPRIO
> > +#define IOPRIO_ACTIVITY_SHIFT                (IOPRIO_HINT_NR_BITS + IO=
PRIO_LEVEL_NR_BITS)
> > +#define IOPRIO_ACTIVITY_NR_BITS              7
>
> I already told you that taking all the free hint bits for yourself, leavi=
ng no
> room fo future IO hints, is not nice. Do you really need 7 bits for your =
thing ?
> Why does the activity even need to be part of the IO priority ? From the =
rather
> short explanation in the commit message, it seems that activity should si=
mply
> raise the priority (either class or level or both). I do not see why that
> activity number needs to be in the ioprio. Who in the kernel will look at=
 it ?
> IO scheduler ? the storage device ?
As I explained above, 7 bits(128 of 256) within ioprio is the minimum
number for counting active pages carried by this bio and will end at
the IO scheduler. bio has to be enlarged a new member to log these if
we don't use ioprio.
>
> > +#define IOPRIO_NR_ACTIVITY           (1 << IOPRIO_ACTIVITY_NR_BITS)
> > +#define IOPRIO_ACTIVITY_MASK         (IOPRIO_NR_ACTIVITY - 1)
> > +#define IOPRIO_PRIO_ACTIVITY(ioprio) \
> > +     (((ioprio) >> IOPRIO_ACTIVITY_SHIFT) & IOPRIO_ACTIVITY_MASK)
> > +#endif
> >  /*
> >   * I/O hints.
> >   */
> > @@ -104,6 +116,7 @@ enum {
> >
> >  #define IOPRIO_BAD_VALUE(val, max) ((val) < 0 || (val) >=3D (max))
> >
> > +#ifndef CONFIG_CONTENT_ACT_BASED_IOPRIO
> >  /*
> >   * Return an I/O priority value based on a class, a level and a hint.
> >   */
> > @@ -123,5 +136,30 @@ static __always_inline __u16 ioprio_value(int prio=
class, int priolevel,
> >       ioprio_value(prioclass, priolevel, IOPRIO_HINT_NONE)
> >  #define IOPRIO_PRIO_VALUE_HINT(prioclass, priolevel, priohint)       \
> >       ioprio_value(prioclass, priolevel, priohint)
> > +#else
> > +/*
> > + * Return an I/O priority value based on a class, a level, a hint and
> > + * content's activities
> > + */
> > +static __always_inline __u16 ioprio_value(int prioclass, int priolevel=
,
> > +             int priohint, int activity)
> > +{
> > +     if (IOPRIO_BAD_VALUE(prioclass, IOPRIO_NR_CLASSES) ||
> > +                     IOPRIO_BAD_VALUE(priolevel, IOPRIO_NR_LEVELS) ||
> > +                     IOPRIO_BAD_VALUE(priohint, IOPRIO_NR_HINTS) ||
> > +                     IOPRIO_BAD_VALUE(activity, IOPRIO_NR_ACTIVITY))
> > +             return IOPRIO_CLASS_INVALID << IOPRIO_CLASS_SHIFT;
> >
> > +     return (prioclass << IOPRIO_CLASS_SHIFT) |
> > +             (activity << IOPRIO_ACTIVITY_SHIFT) |
> > +             (priohint << IOPRIO_HINT_SHIFT) | priolevel;
> > +}
> > +
> > +#define IOPRIO_PRIO_VALUE(prioclass, priolevel)                      \
> > +     ioprio_value(prioclass, priolevel, IOPRIO_HINT_NONE, 0)
> > +#define IOPRIO_PRIO_VALUE_HINT(prioclass, priolevel, priohint)       \
> > +     ioprio_value(prioclass, priolevel, priohint, 0)
> > +#define IOPRIO_PRIO_VALUE_ACTIVITY(prioclass, priolevel, priohint, act=
ivity) \
> > +     ioprio_value(prioclass, priolevel, priohint, activity)
> > +#endif
> >  #endif /* _UAPI_LINUX_IOPRIO_H */
> > diff --git a/mm/Kconfig b/mm/Kconfig
> > index 264a2df5ecf5..e0e5a5a44ded 100644
> > --- a/mm/Kconfig
> > +++ b/mm/Kconfig
> > @@ -1240,6 +1240,14 @@ config LRU_GEN_STATS
> >         from evicted generations for debugging purpose.
> >
> >         This option has a per-memcg and per-node memory overhead.
> > +
> > +config CONTENT_ACT_BASED_IOPRIO
> > +     bool "Enable content activity based ioprio"
> > +     depends on LRU_GEN
> > +     default n
> > +     help
> > +       This item enable the feature of adjust bio's priority by
> > +       calculating its content's activity.
> >  # }
> >
> >  config ARCH_SUPPORTS_PER_VMA_LOCK
>
> --
> Damien Le Moal
> Western Digital Research
>

