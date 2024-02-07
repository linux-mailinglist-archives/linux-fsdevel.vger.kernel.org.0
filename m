Return-Path: <linux-fsdevel+bounces-10543-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A1C84C188
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 01:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5D031C24369
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 00:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD19C8C4;
	Wed,  7 Feb 2024 00:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZlMfGoxO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A884A1B;
	Wed,  7 Feb 2024 00:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707267083; cv=none; b=GCoVEkO5hd8GxPm1GGIDw4+bNp02EROoic5W6TRe3H62kyuVW0zrHySCFu2Olh6Yqb84jJBS7UTYdfNek8W/ZALMIv+9tor0fdotYPilvGcPMPvKlwdvY4Qw2npLT9CTbJJNcVkYgJwxSzPAX+3i1JDzYRcyoyzRQ81TK7v3gvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707267083; c=relaxed/simple;
	bh=4AO/+UsepqAx8tpPjNVWsbXWuvjnjCrfhVLpqhMoGcE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZOUyyJC9A6eK33C2+Xp1rayrKTN1+TGo7q9kt2maVqSpx9kacWBKy6xblba1Nl+FTCGLV4xcYt7eWvA+/3hgCIussgC4UfBHgnFM6871YCBTkHBWruMaPr/d4cFDXtrtte4TzFOGXvsgzu5V+0XQJ6dY4hWDEBGpEDD7+KnY+Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZlMfGoxO; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2cf4d2175b2so1058381fa.0;
        Tue, 06 Feb 2024 16:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707267078; x=1707871878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h1B+J6u5jhg4RLeG3CC53Y7+wHzqP87W36OesHElAkc=;
        b=ZlMfGoxOJPLffGfWFU786GXz+nB+2czZ2mOk1Ul+NLENHgoCSLIfZycv4NihouHJTk
         Llol4aUDWyBWGtZi2akSCB2sg46gSlwQx5taaGweS9Qdc4kQ7RZLcy3PDAhbj+VT6AWl
         CQPOMWWrI60rTwFzkJ3Jbra5Q/fKg5AP0mZ9I4c/DyQi4tRL9864TdAAgttTFyX1Q2QG
         DI9Is61mE96/IaMX7dJi0Z8Ivjb25QpJOv8CWWGXB1Sfc/ra/aiOELnMum625N5BP4rU
         1m4VnCCiOWHajDCglUoxSpzowTsAHP3T9w8b5PXMBpMa1u1FoUJqJ9SCkDqCiSk6TfrT
         41TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707267078; x=1707871878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h1B+J6u5jhg4RLeG3CC53Y7+wHzqP87W36OesHElAkc=;
        b=LHuuR+vK9Cax6G9BM6cYwdJCcGtk5zt3wzLr4s01sK3kAWx/XTdt4GLVmOxMqI0vah
         kLtCUJMP2YuRxSvzAoPlWHF9ZmOX11Xt81qMz09wETIKnnvL36FmIolh2dBI4FXxJWNY
         jk2AvcfOlVG4nxJ+Pfg54aCnH94dbRANuqN6V7FoZOy41yxyr/0S65OP8jD6EVv5HT26
         lYBxbQtyMhVyCQdvqsYHjEd5GpfHK21VJjwk0iS+aC/na3nLTC/7elnmh7RHheH6aHjO
         9CCBDervgUBg6XojLXMgzIeNL9WNPXAKzKtdcdnzc91xFL5mjQseYQHUAGUfFy8TR8GX
         09sg==
X-Gm-Message-State: AOJu0Yx3+wn/+i1i/Fnt2skFw5XRLqOGJd7dsXZR9ntMZ3VQ9nEi/p2D
	Cs8bieEOrRjtbxlcax44WIIG1f4FTZyi9st00MnNt7Jl1OQ50JPa0HyQDzc4h98muXKRn2vK4Jk
	RCEoGZMGNpCaE6wYpstMzMBER8DA=
X-Google-Smtp-Source: AGHT+IGGeMHFUyqeCOF6yL8wa0QoHskikr5vyK/TGm3rz7xqTeKUcnLH7NVLUwjVyA3iN5nfb77SnbV/uWZTlm0u9pI=
X-Received: by 2002:a2e:b903:0:b0:2d0:b3c4:5113 with SMTP id
 b3-20020a2eb903000000b002d0b3c45113mr2537860ljb.11.1707267077915; Tue, 06 Feb
 2024 16:51:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206023740.81351-1-zhaoyang.huang@unisoc.com>
In-Reply-To: <20240206023740.81351-1-zhaoyang.huang@unisoc.com>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Wed, 7 Feb 2024 08:51:06 +0800
Message-ID: <CAGWkznFPjKKUeTbzVwSbihK7KWo_duhNL++MLGfvjvHK-2vYQw@mail.gmail.com>
Subject: Re: [PATCHv9 1/1] block: introduce content activity based ioprio
To: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc: Jens Axboe <axboe@kernel.dk>, Matthew Wilcox <willy@infradead.org>, Yu Zhao <yuzhao@google.com>, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I would like to state more thoughts here. That is, the RT tasks have
had privilege on CPU resources as more cpu time and scheduled earlier
via which they could generally launch the bio earlier than CFS tasks
do. This commit just wants to improve this a little by letting CFS
tasks have the opportunity to raise their bio's ioprio by judging the
content's activities.

On Tue, Feb 6, 2024 at 10:40=E2=80=AFAM zhaoyang.huang
<zhaoyang.huang@unisoc.com> wrote:
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
> The filesystem should call bio_set_active_ioprio_folio() after
> calling bio_add_folio. Please be noted that this set of API can not
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
> Suggested-by: Matthew Wilcox <willy@infradead.org>
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
> change of v9: modify the code according to Matthew's opinion, leave
>               bio_set_active_ioprio_folio only
> ---
> ---
>  block/Kconfig       | 15 +++++++++++++++
>  block/bio.c         | 33 +++++++++++++++++++++++++++++++++
>  include/linux/bio.h |  1 +
>  3 files changed, 49 insertions(+)
>
> diff --git a/block/Kconfig b/block/Kconfig
> index f1364d1c0d93..fb3a888194c0 100644
> --- a/block/Kconfig
> +++ b/block/Kconfig
> @@ -228,6 +228,21 @@ config BLOCK_HOLDER_DEPRECATED
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
> +         The file system should use the API after bio_add_folio for
> +         their buffered read/write/sync function to adjust the
> +         bio->bi_ioprio.
> +
>  source "block/Kconfig.iosched"
>
>  endif # BLOCK
> diff --git a/block/bio.c b/block/bio.c
> index 816d412c06e9..2c0b8f2ae4d4 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1476,6 +1476,39 @@ void bio_set_pages_dirty(struct bio *bio)
>  }
>  EXPORT_SYMBOL_GPL(bio_set_pages_dirty);
>
> +/*
> + * bio_set_active_ioprio_folio is helper function to count the bio's
> + * content's activities which measured by MGLRU.
> + * The file system should call this function after bio_add_page/folio fo=
r
> + * the buffered read/write/sync.
> + */
> +#ifdef CONFIG_BLK_CONT_ACT_BASED_IOPRIO
> +void bio_set_active_ioprio_folio(struct bio *bio, struct folio *folio)
> +{
> +       int class, level, hint;
> +       int activities;
> +
> +       /*
> +        * use bi_ioprio to record the activities, assume no one will set=
 it
> +        * before submit_bio
> +        */
> +       bio->bi_ioprio +=3D folio_test_workingset(folio) ? 1 : 0;
> +       activities =3D IOPRIO_PRIO_DATA(bio->bi_ioprio);
> +       level =3D IOPRIO_PRIO_LEVEL(bio->bi_ioprio);
> +       hint =3D IOPRIO_PRIO_HINT(bio->bi_ioprio);
> +
> +       if (activities > bio->bi_vcnt / 2)
> +               class =3D IOPRIO_CLASS_RT;
> +       else if (activities > bio->bi_vcnt / 4)
> +               class =3D max(IOPRIO_PRIO_CLASS(get_current_ioprio()), IO=
PRIO_CLASS_BE);
> +
> +       bio->bi_ioprio =3D IOPRIO_PRIO_VALUE_HINT(class, level, hint);
> +}
> +#else
> +void bio_set_active_ioprio_folio(struct bio *bio, struct folio *folio) {=
}
> +#endif
> +EXPORT_SYMBOL_GPL(bio_set_active_ioprio_folio);
> +
>  /*
>   * bio_check_pages_dirty() will check that all the BIO's pages are still=
 dirty.
>   * If they are, then fine.  If, however, some pages are clean then they =
must
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index 41d417ee1349..6c36546f6b9b 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -487,6 +487,7 @@ void bio_iov_bvec_set(struct bio *bio, struct iov_ite=
r *iter);
>  void __bio_release_pages(struct bio *bio, bool mark_dirty);
>  extern void bio_set_pages_dirty(struct bio *bio);
>  extern void bio_check_pages_dirty(struct bio *bio);
> +void bio_set_active_ioprio_folio(struct bio *bio, struct folio *folio);
>
>  extern void bio_copy_data_iter(struct bio *dst, struct bvec_iter *dst_it=
er,
>                                struct bio *src, struct bvec_iter *src_ite=
r);
> --
> 2.25.1
>

