Return-Path: <linux-fsdevel+bounces-10250-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87031849610
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 10:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D25B287096
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 09:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD9712B6D;
	Mon,  5 Feb 2024 09:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZBcbNO2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFF8125A4;
	Mon,  5 Feb 2024 09:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707124189; cv=none; b=Zm8NlZtgH63gOo0Vcw+vHSpBI7BWrMfLKYu5L3bSjHxO7Yp5YLBLakcp1K1DfDc+PsVVTEvKM/MOu9RE0q+I2iWgQKVrQWxEC4TuyYHkqkzCAiPgJNetOfTtg/KE7QiOgRVV5yMBKzcfcBFY4bv9vMRcsTjHxcPxMiayM4MmVec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707124189; c=relaxed/simple;
	bh=i6f2X23X+uCcTe9YICOWAooGvVviOVmq0LOsLJRDpAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MQhAxhII4mz1tCK0qVkRuo2Egll7wWQr69wRJs4932rUPhrQZ2y7d3ExUV5MB0BYFniAeaPDs8PrxOdgPnCBZu/o6NyitdG/texWVcR7UVFYuDAZWAtectX/Tw7EypKFE+vWPiaXnedmmlUafk+2Qu4Z1EQRWfI4VgKN3dItkz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QZBcbNO2; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-511344235c6so4676503e87.0;
        Mon, 05 Feb 2024 01:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707124185; x=1707728985; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s8w06G0X7yIoSXZScOxoBiqjUMaYjQk83NXqtXbrmGo=;
        b=QZBcbNO2Q72Ufawve9c1mTkMrS/ZCVtYfDwDFKTT/mEjPCRr7qfNxsmg5lboS7jGki
         K5mMvYjoXDhNTDx+oz2l2gtgQj8ZO0z7DGIqvMQFD3vym7dmxRLz6cCrd5bSbsuZLtU2
         FBMfrSgLeqyAmMrTtoqMiCZ72Hss8U3GFUE7vJOFAqxAZiDWOLdjpHU0EdL6XOcRnaWt
         fJxKitFu178faFBUKAq20VOpDInES2ChOPgZuqodCwEYsM0Iu/qcO3Z/8SI0MiPJiYeU
         tRLFSdeoPYL/9gIAgBEnku/38H66EJELTMhXvzIjAN/ANEskIEZb70G9ocmAH19m6MAP
         vdlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707124185; x=1707728985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s8w06G0X7yIoSXZScOxoBiqjUMaYjQk83NXqtXbrmGo=;
        b=o5nGPZ8A39qUtTyJ7aJvZxFYmzC7i4jekusQF3fnJIKvZJzI4f0Ny+o61npChoHdjr
         PT9B/5Pw1XUkHSpR9ZHrSHN7BBVoJu/5vlcZek6Hs1A2euveLNew0gNCbViqJQrHaJto
         OEZ5Y17BqxGCsImXmC/+F4go9f2+WCrff/j3hBZdMH+SKkwqQRuwrMpvwKVBC0BfEmhX
         wNBJBQDggy5StDkAbultwjYcvF4TybWwPwq4QQ0w0wwe1Ege9O0r3Lrs/ei9SyXv1Foj
         xE0F2qaYuojtHOtYX4xrLVR8/on2qoyN/L0Qs9ILabJcJxB4Fgf4tFAWtyGZ4b2LN8IC
         N4og==
X-Gm-Message-State: AOJu0YxjUwdP92ROHJvqhLAgwxZfBVxLOwUrGH2W60lqghYjGYWMWLJy
	uOV4fhjev1ydc/D0+FvpJufipbrFt2B7l5n+Kc6KWIbDrOHG+fhbgomRQ8NxuacMhi0mVa7arKj
	umJXy9LaXp4T/NGYCn1g7Uyno36V9gCeS04Y=
X-Google-Smtp-Source: AGHT+IEp2Fyw3kyCRgzHv0QN+TXUrgMZYK8Pb9IXx6JU+xD8Prc10dCnTzdL9bmyansE1HXl74VmcISttMHmm7OiSrU=
X-Received: by 2002:a05:6512:3d87:b0:511:18f5:947a with SMTP id
 k7-20020a0565123d8700b0051118f5947amr6950020lfv.65.1707124185098; Mon, 05 Feb
 2024 01:09:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205090552.40567-1-zhaoyang.huang@unisoc.com>
In-Reply-To: <20240205090552.40567-1-zhaoyang.huang@unisoc.com>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Mon, 5 Feb 2024 17:09:33 +0800
Message-ID: <CAGWkznEGKFWdvSfa87BveT_=yfQQpzerOCFn=x+a7PJTDNJUYA@mail.gmail.com>
Subject: Re: [PATCHv8 1/1] block: introduce content activity based ioprio
To: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc: Jens Axboe <axboe@kernel.dk>, Matthew Wilcox <willy@infradead.org>, Yu Zhao <yuzhao@google.com>, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 5:06=E2=80=AFPM zhaoyang.huang <zhaoyang.huang@uniso=
c.com> wrote:
>
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>
> Currently, request's ioprio are set via task's schedule priority(when no
> blkcg configured), which has high priority tasks possess the privilege on
> both of CPU and IO scheduling. Furthermore, most of the write requestes
> are launched asynchronosly from kworker which can't know the submitter's
> priorities.
> This commit works as a hint of original policy by promoting the request
> ioprio based on the page/folio's activity. The original idea comes from
> LRU_GEN which provides more precised folio activity than before. This
> commit try to adjust the request's ioprio when certain part of its folios
> are hot, which indicate that this request carry important contents and
> need be scheduled ealier.
>
> This commit provide two sets of exclusive APIs.
>
> *counting activities by iterating the bio's pages
> The filesystem should call bio_set_active_ioprio() before submit_bio on t=
he
> spot where they want(buffered read/write/sync etc).
>
> *counting activities during each call
> The filesystem should call bio_set_active_ioprio_page/folio() after
> calling bio_add_page/folio. Please be noted that this set of API can not
> handle bvec_try_merge_page cases.
>
> This commit is verified on a v6.6 6GB RAM android14 system via 4 test cas=
es
> by calling bio_set_active_ioprio in erofs, ext4, f2fs and blkdev(raw
> partition of gendisk)
>
> Case 1:
> script[a] which get significant improved fault time as expected[b]*
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
> io wait                736us            523us
>
> * provide correct result for test case 1 in v7 which was compared between
> EMMC and UFS wrongly.
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
> androbench has no improvment as well as regression in RD/WR test item
> while make a 3% improvement in sqlite items.
>
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
> change of v2: calculate page's activity via helper function
> change of v3: solve layer violation by move API into mm
> change of v4: keep block clean by removing the page related API
> change of v5: introduce the macros of bio_add_folio/page for read dir.
> change of v6: replace the macro of bio_add_xxx by submit_bio which
>                 iterating the bio_vec before launching bio to block layer
> change of v7: introduce the function bio_set_active_ioprio
>               provide updated test result
> change of v8: provide two sets of APIs for bio_set_active_ioprio_xxx
> ---
> ---
>  block/Kconfig             | 27 +++++++++++
>  block/bio.c               | 94 +++++++++++++++++++++++++++++++++++++++
>  include/linux/bio.h       |  3 ++
>  include/linux/blk_types.h |  7 ++-
>  4 files changed, 130 insertions(+), 1 deletion(-)
>
> diff --git a/block/Kconfig b/block/Kconfig
> index f1364d1c0d93..5e721678ea3d 100644
> --- a/block/Kconfig
> +++ b/block/Kconfig
> @@ -228,6 +228,33 @@ config BLOCK_HOLDER_DEPRECATED
>  config BLK_MQ_STACKING
>         bool
>
> +config BLK_CONT_ACT_BASED_IOPRIO
> +       bool "Enable content activity based ioprio"
> +       depends on LRU_GEN
> +       default n
> +       help
> +         This item enable the feature of adjust bio's priority by
> +         calculating its content's activity.
> +         This feature works as a hint of original bio_set_ioprio
> +         which means rt task get no change of its bio->bi_ioprio
> +         while other tasks have the opportunity to raise the ioprio
> +         if the bio take certain numbers of active pages.
> +         The file system should use this by modifying their buffered
> +         read/write/sync function to raise the bio->bi_ioprio before
> +         calling submit_bio or after bio_add_page/folio
> +
> +config BLK_CONT_ACT_BASED_IOPRIO_ITER_BIO
> +       bool "Counting bio's activity by iterating bio's pages"
> +       depends on BLK_CONT_ACT_BASED_IOPRIO
> +       help
> +         The API under this config counts bio's activity by iterating th=
e bio.
> +
> +config BLK_CONT_ACT_BASED_IOPRIO_ADD_PAGE
> +       bool "Counting bio's activity when adding page or folio"
> +       depends on BLK_CONT_ACT_BASED_IOPRIO && !BLK_CONT_ACT_BASED_IOPRI=
O_ITER_BIO
> +       help
> +         The API under this config count activity during each call buy c=
an't
> +          handle bvec_try_merge_page cases, please be sure you are ok wi=
th that.
counting activities during each call can not handle
bvec_try_merge_page cases as it returns the valid value. So I provide
two sets of exclusive APIs by keeping the iteration one
int bio_add_page(struct bio *bio, struct page *page,
                 unsigned int len, unsigned int offset)
{
        bool same_page =3D false;

        if (WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED)))
                return 0;
        if (bio->bi_iter.bi_size > UINT_MAX - len)
                return 0;

        if (bio->bi_vcnt > 0 &&
            bvec_try_merge_page(&bio->bi_io_vec[bio->bi_vcnt - 1],
                                page, len, offset, &same_page)) {
                bio->bi_iter.bi_size +=3D len;
                return len;
        }

        if (bio->bi_vcnt >=3D bio->bi_max_vecs)
                return 0;
        __bio_add_page(bio, page, len, offset);
        return len;
}

>  source "block/Kconfig.iosched"
>
>  endif # BLOCK
> diff --git a/block/bio.c b/block/bio.c
> index 816d412c06e9..73916a6c319f 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1476,6 +1476,100 @@ void bio_set_pages_dirty(struct bio *bio)
>  }
>  EXPORT_SYMBOL_GPL(bio_set_pages_dirty);
>
> +/*
> + * bio_set_active_ioprio() is helper function for fs to adjust the bio's=
 ioprio via
> + * calculating the content's activity which measured from MGLRU.
> + * The file system should call this function before submit_bio for the b=
uffered
> + * read/write/sync.
> + */
> +#ifdef CONFIG_BLK_CONT_ACT_BASED_IOPRIO
> +#ifdef CONFIG_BLK_CONT_ACT_BASED_IOPRIO_ITER_BIO
> +void bio_set_active_ioprio(struct bio *bio)
> +{
> +       struct bio_vec bv;
> +       struct bvec_iter iter;
> +       struct page *page;
> +       int class, level, hint;
> +       int activity =3D 0;
> +       int cnt =3D 0;
> +
> +       class =3D IOPRIO_PRIO_CLASS(bio->bi_ioprio);
> +       level =3D IOPRIO_PRIO_LEVEL(bio->bi_ioprio);
> +       hint =3D IOPRIO_PRIO_HINT(bio->bi_ioprio);
> +       /*apply legacy ioprio policy on RT task*/
> +       if (task_is_realtime(current)) {
> +               bio->bi_ioprio =3D IOPRIO_PRIO_VALUE_HINT(IOPRIO_CLASS_RT=
, level, hint);
> +               return;
> +       }
> +       bio_for_each_bvec(bv, bio, iter) {
> +               page =3D bv.bv_page;
> +               activity +=3D PageWorkingset(page) ? 1 : 0;
> +               cnt++;
> +               if (activity > bio->bi_vcnt / 2) {
> +                       class =3D IOPRIO_CLASS_RT;
> +                       break;
> +               } else if (activity > bio->bi_vcnt / 4) {
> +                       /*
> +                        * all itered pages are all active so far
> +                        * then raise to RT directly
> +                        */
> +                       if (activity =3D=3D cnt) {
> +                               class =3D IOPRIO_CLASS_RT;
> +                               break;
> +                       } else
> +                               class =3D max(IOPRIO_PRIO_CLASS(get_curre=
nt_ioprio()),
> +                                               IOPRIO_CLASS_BE);
> +               }
> +       }
> +       if (!class && activity > cnt / 2)
> +               class =3D IOPRIO_CLASS_RT;
> +       else if (!class && activity > cnt / 4)
> +               class =3D max(IOPRIO_PRIO_CLASS(get_current_ioprio()), IO=
PRIO_CLASS_BE);
> +
> +       bio->bi_ioprio =3D IOPRIO_PRIO_VALUE_HINT(class, level, hint);
> +}
> +void bio_set_active_ioprio_folio(struct bio *bio, struct folio *folio) {=
}
> +void bio_set_active_ioprio_page(struct bio *bio, struct page *page) {}
> +#endif
> +#ifdef CONFIG_BLK_CONT_ACT_BASED_IOPRIO_ADD_PAGE
> +/*
> + * bio_set_active_ioprio_page/folio are helper functions for counting
> + * the bio's activity during each all. However, it can't handle the
> + * scenario of bvec_try_merge_page. The submitter can use them if there
> + * is no such case in the system(block size < page size)
> + */
> +void bio_set_active_ioprio_page(struct bio *bio, struct page *page)
> +{
> +       int class, level, hint;
> +
> +       class =3D IOPRIO_PRIO_CLASS(bio->bi_ioprio);
> +       level =3D IOPRIO_PRIO_LEVEL(bio->bi_ioprio);
> +       hint =3D IOPRIO_PRIO_HINT(bio->bi_ioprio);
> +       bio->bi_cont_act +=3D PageWorkingset(page) ? 1 : 0;
> +
> +       if (bio->bi_cont_act > bio->bi_vcnt / 2)
> +               class =3D IOPRIO_CLASS_RT;
> +       else if (bio->bi_cont_act > bio->bi_vcnt / 4)
> +               class =3D max(IOPRIO_PRIO_CLASS(get_current_ioprio()), IO=
PRIO_CLASS_BE);
> +
> +       bio->bi_ioprio =3D IOPRIO_PRIO_VALUE_HINT(class, level, hint);
> +}
> +
> +void bio_set_active_ioprio_folio(struct bio *bio, struct folio *folio)
> +{
> +       bio_set_active_ioprio_page(bio, &folio->page);
> +}
> +void bio_set_active_ioprio(struct bio *bio) {}
> +#endif
> +#else
> +void bio_set_active_ioprio(struct bio *bio) {}
> +void bio_set_active_ioprio_page(struct bio *bio, struct page *page) {}
> +void bio_set_active_ioprio_folio(struct bio *bio, struct folio *folio) {=
}
> +#endif
> +EXPORT_SYMBOL_GPL(bio_set_active_ioprio);
> +EXPORT_SYMBOL_GPL(bio_set_active_ioprio_page);
> +EXPORT_SYMBOL_GPL(bio_set_active_ioprio_folio);
> +
>  /*
>   * bio_check_pages_dirty() will check that all the BIO's pages are still=
 dirty.
>   * If they are, then fine.  If, however, some pages are clean then they =
must
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index 41d417ee1349..35221ee3dd54 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -487,6 +487,9 @@ void bio_iov_bvec_set(struct bio *bio, struct iov_ite=
r *iter);
>  void __bio_release_pages(struct bio *bio, bool mark_dirty);
>  extern void bio_set_pages_dirty(struct bio *bio);
>  extern void bio_check_pages_dirty(struct bio *bio);
> +extern void bio_set_active_ioprio(struct bio *bio);
> +extern void bio_set_active_ioprio_folio(struct bio *bio, struct folio *f=
olio);
> +extern void bio_set_active_ioprio_page(struct bio *bio, struct page *pag=
e);
>
>  extern void bio_copy_data_iter(struct bio *dst, struct bvec_iter *dst_it=
er,
>                                struct bio *src, struct bvec_iter *src_ite=
r);
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index d5c5e59ddbd2..a3a18b9a5168 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -314,7 +314,12 @@ struct bio {
>         struct bio_vec          *bi_io_vec;     /* the actual vec list */
>
>         struct bio_set          *bi_pool;
> -
> +#ifdef CONFIG_BLK_CONT_ACT_BASED_IOPRIO
> +       /*
> +        * bi_cont_act record total activities of bi_io_vec->pages
> +        */
> +       u64                     bi_cont_act;
> +#endif
>         /*
>          * We can inline a number of vecs at the end of the bio, to avoid
>          * double allocations for a small number of bio_vecs. This member
> --
> 2.25.1
>

