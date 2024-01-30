Return-Path: <linux-fsdevel+bounces-9533-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D05C7842631
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 14:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0130C1C24ABE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 13:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC1A6BB5C;
	Tue, 30 Jan 2024 13:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPwWLaTV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A20F6BB32;
	Tue, 30 Jan 2024 13:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706621349; cv=none; b=YlgL/6eO2TJi/JDs7NepP6iCKNsbeAOHb62+6JBPhsjcuebctI1ojoH0dim0ZCswGxP3w+W05Oy7zJPUTIbWtuofhB1FFglMna6oOhSJRVk+cMfvJ8bNNoTPNrfWKjcWZjMlpUTlg7ty/vF9m4SShoE69yRR9QIKV8cHVZ3nfTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706621349; c=relaxed/simple;
	bh=hbKH7djk4AiGxd5/vC3QpWkmDp8pVWbbKObLalbElnQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F0OnH5uGJJM+1h2bMpzRvQlJHGCUGBY2sqYNKysCnluNkphxjyi9/uThDpeIUrtfARppMhTZjq95x3U9NxShqupto5LjcDlcF4iAu/FM8lDpLf1y+WgdbV5YzQuIG7PAgGabL6Ut7AyEVawXn+ZZ/3liboOWym3Y5qsURO/TQ8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jPwWLaTV; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2cf4fafa386so43051111fa.1;
        Tue, 30 Jan 2024 05:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706621344; x=1707226144; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dNLcEGX4A9fxdoh3pmT0Jg1o9swAaHX5RacLSzjUp9g=;
        b=jPwWLaTVhSPEQcq4NPhbQRH4uUXCbeA2RTeCQj8in+CJYqs8h/8XM363DI8xbYmi6p
         L5Z8NBZ9tXoPts0ilFICNGkPp4RrqSda/TXsfSYrtRVMNTPtN+/sfYc+i8uEKNf7gPCV
         EWwZCMQRNI4TrRHXDxALJN2g0JT3YF0Bk3xuxB4oM4i3Ooqs7ZQpjR+73U8i2PhHXqlT
         sYG0dRSUvbjkV005bgTCyf88RXfaXyolbUal57Q6gI5nusuj4XY7yZFdibctAgpneOtb
         9Xbk/lVMa8K/E0y91e7Yq7vMcFXvC3y7W61XbCvvaqNZurrZT48WixH7QWMYP0z6+nOM
         U/ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706621344; x=1707226144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dNLcEGX4A9fxdoh3pmT0Jg1o9swAaHX5RacLSzjUp9g=;
        b=H0kmnujat7EcmI8ZN6WEaUuB9Ked5DG7db+SZXOMbxbekV+X+Bna2bwvUAGt+bzXSc
         OVivzz9EdpPmVmINO8wwUoVdRQt55EesOPxiovVxS4u5Dl1ZY/ov25Z5fQFYU/aokwk/
         GKR+PqcP2zSftp+t13JCrANqIHy7ZzxjgJpvTnBuABeqB9B2BBEHR3VRYvlddQw/O81X
         bkSsZgy6nW4R39OLjEsFHUPkwC1eDW/V3BTuegexKX+ChVsocvQdBUpS5IcexYMU6wqR
         eUgMzEjfthyib0GKyvbEYoFxbQy/qy3H2X+1t7u+wgZdrFa9+xAFQeKCHs150qRc6a+D
         nzTQ==
X-Gm-Message-State: AOJu0Yxql6/kUUYFeNJLygpJpqfWAgNmGGXOExq9uRjOYdHKMBs/IgRr
	a8v2bx0C5P6aWNcH9bLtNqjMJ8YuRomjPALIojdApo9mlptUcIqS6j4tLOyrhjD3bxZ7C0FNI0B
	rheXVLVe4ME7iZCPhUULpJD4GJf4=
X-Google-Smtp-Source: AGHT+IGZWpx8hDNjBl1tmnZdSd/zfw3n6nm0qEZM/nJ1HEozV4ymoFI0oxV2t5qVZQtwfBtUHwqgDCzcH1fz0frX7MU=
X-Received: by 2002:a05:651c:1a29:b0:2cf:1ae2:dca with SMTP id
 by41-20020a05651c1a2900b002cf1ae20dcamr6506212ljb.16.1706621343828; Tue, 30
 Jan 2024 05:29:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130084207.3760518-1-zhaoyang.huang@unisoc.com>
 <aa307901-d20a-4301-8774-97287d7192e9@kernel.org> <CAGWkznFG003aQ3-XAzdmGev7FP6x5pvp=xS8Z9sZknUHZEGHow@mail.gmail.com>
 <a538044b-5fc2-4259-9cad-3fc67feaae6d@kernel.org>
In-Reply-To: <a538044b-5fc2-4259-9cad-3fc67feaae6d@kernel.org>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Tue, 30 Jan 2024 21:28:52 +0800
Message-ID: <CAGWkznHk2GBrpc6w1az5Q59xj5BoVNrCoD4c=BQ4Jqe2QmkoVg@mail.gmail.com>
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

On Tue, Jan 30, 2024 at 9:17=E2=80=AFPM Damien Le Moal <dlemoal@kernel.org>=
 wrote:
>
> On 1/30/24 21:43, Zhaoyang Huang wrote:
> > On Tue, Jan 30, 2024 at 5:17=E2=80=AFPM Damien Le Moal <dlemoal@kernel.=
org> wrote:
> >>
> >> On 1/30/24 17:42, zhaoyang.huang wrote:
> >>> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >>>
> >>> Currently, request's ioprio are set via task's schedule priority(when=
 no
> >>> blkcg configured), which has high priority tasks possess the privileg=
e on
> >>> both of CPU and IO scheduling.
> >>> This commit works as a hint of original policy by promoting the reque=
st ioprio
> >>> based on the page/folio's activity. The original idea comes from LRU_=
GEN
> >>> which provides more precised folio activity than before. This commit =
try
> >>> to adjust the request's ioprio when certain part of its folios are ho=
t,
> >>> which indicate that this request carry important contents and need be
> >>> scheduled ealier.
> >>>
> >>> This commit is verified on a v6.6 6GB RAM android14 system via 4 test=
 cases
> >>> by changing the bio_add_page/folio API in erofs, ext4 and f2fs in
> >>> another commit.
> >>>
> >>> Case 1:
> >>> script[a] which get significant improved fault time as expected[b]
> >>> where dd's cost also shrink from 55s to 40s.
> >>> (1). fault_latency.bin is an ebpf based test tool which measure all t=
ask's
> >>>    iowait latency during page fault when scheduled out/in.
> >>> (2). costmem generate page fault by mmaping a file and access the VA.
> >>> (3). dd generate concurrent vfs io.
> >>>
> >>> [a]
> >>> ./fault_latency.bin 1 5 > /data/dd_costmem &
> >>> costmem -c0 -a2048000 -b128000 -o0 1>/dev/null &
> >>> costmem -c0 -a2048000 -b128000 -o0 1>/dev/null &
> >>> costmem -c0 -a2048000 -b128000 -o0 1>/dev/null &
> >>> costmem -c0 -a2048000 -b128000 -o0 1>/dev/null &
> >>> dd if=3D/dev/block/sda of=3D/data/ddtest bs=3D1024 count=3D2048000 &
> >>> dd if=3D/dev/block/sda of=3D/data/ddtest1 bs=3D1024 count=3D2048000 &
> >>> dd if=3D/dev/block/sda of=3D/data/ddtest2 bs=3D1024 count=3D2048000 &
> >>> dd if=3D/dev/block/sda of=3D/data/ddtest3 bs=3D1024 count=3D2048000
> >>> [b]
> >>>                        mainline               commit
> >>> io wait                836us            156us
> >>>
> >>> Case 2:
> >>> fio -filename=3D/dev/block/by-name/userdata -rw=3Drandread -direct=3D=
0 -bs=3D4k -size=3D2000M -numjobs=3D8 -group_reporting -name=3Dmytest
> >>> mainline: 513MiB/s
> >>> READ: bw=3D531MiB/s (557MB/s), 531MiB/s-531MiB/s (557MB/s-557MB/s), i=
o=3D15.6GiB (16.8GB), run=3D30137-30137msec
> >>> READ: bw=3D543MiB/s (569MB/s), 543MiB/s-543MiB/s (569MB/s-569MB/s), i=
o=3D15.6GiB (16.8GB), run=3D29469-29469msec
> >>> READ: bw=3D474MiB/s (497MB/s), 474MiB/s-474MiB/s (497MB/s-497MB/s), i=
o=3D15.6GiB (16.8GB), run=3D33724-33724msec
> >>> READ: bw=3D535MiB/s (561MB/s), 535MiB/s-535MiB/s (561MB/s-561MB/s), i=
o=3D15.6GiB (16.8GB), run=3D29928-29928msec
> >>> READ: bw=3D523MiB/s (548MB/s), 523MiB/s-523MiB/s (548MB/s-548MB/s), i=
o=3D15.6GiB (16.8GB), run=3D30617-30617msec
> >>> READ: bw=3D492MiB/s (516MB/s), 492MiB/s-492MiB/s (516MB/s-516MB/s), i=
o=3D15.6GiB (16.8GB), run=3D32518-32518msec
> >>> READ: bw=3D533MiB/s (559MB/s), 533MiB/s-533MiB/s (559MB/s-559MB/s), i=
o=3D15.6GiB (16.8GB), run=3D29993-29993msec
> >>> READ: bw=3D524MiB/s (550MB/s), 524MiB/s-524MiB/s (550MB/s-550MB/s), i=
o=3D15.6GiB (16.8GB), run=3D30526-30526msec
> >>> READ: bw=3D529MiB/s (554MB/s), 529MiB/s-529MiB/s (554MB/s-554MB/s), i=
o=3D15.6GiB (16.8GB), run=3D30269-30269msec
> >>> READ: bw=3D449MiB/s (471MB/s), 449MiB/s-449MiB/s (471MB/s-471MB/s), i=
o=3D15.6GiB (16.8GB), run=3D35629-35629msec
> >>>
> >>> commit: 633MiB/s
> >>> READ: bw=3D668MiB/s (700MB/s), 668MiB/s-668MiB/s (700MB/s-700MB/s), i=
o=3D15.6GiB (16.8GB), run=3D23952-23952msec
> >>> READ: bw=3D589MiB/s (618MB/s), 589MiB/s-589MiB/s (618MB/s-618MB/s), i=
o=3D15.6GiB (16.8GB), run=3D27164-27164msec
> >>> READ: bw=3D638MiB/s (669MB/s), 638MiB/s-638MiB/s (669MB/s-669MB/s), i=
o=3D15.6GiB (16.8GB), run=3D25071-25071msec
> >>> READ: bw=3D714MiB/s (749MB/s), 714MiB/s-714MiB/s (749MB/s-749MB/s), i=
o=3D15.6GiB (16.8GB), run=3D22409-22409msec
> >>> READ: bw=3D600MiB/s (629MB/s), 600MiB/s-600MiB/s (629MB/s-629MB/s), i=
o=3D15.6GiB (16.8GB), run=3D26669-26669msec
> >>> READ: bw=3D592MiB/s (621MB/s), 592MiB/s-592MiB/s (621MB/s-621MB/s), i=
o=3D15.6GiB (16.8GB), run=3D27036-27036msec
> >>> READ: bw=3D691MiB/s (725MB/s), 691MiB/s-691MiB/s (725MB/s-725MB/s), i=
o=3D15.6GiB (16.8GB), run=3D23150-23150msec
> >>> READ: bw=3D569MiB/s (596MB/s), 569MiB/s-569MiB/s (596MB/s-596MB/s), i=
o=3D15.6GiB (16.8GB), run=3D28142-28142msec
> >>> READ: bw=3D563MiB/s (590MB/s), 563MiB/s-563MiB/s (590MB/s-590MB/s), i=
o=3D15.6GiB (16.8GB), run=3D28429-28429msec
> >>> READ: bw=3D712MiB/s (746MB/s), 712MiB/s-712MiB/s (746MB/s-746MB/s), i=
o=3D15.6GiB (16.8GB), run=3D22478-22478msec
> >>>
> >>> Case 3:
> >>> This commit is also verified by the case of launching camera APP whic=
h is
> >>> usually considered as heavy working load on both of memory and IO, wh=
ich
> >>> shows 12%-24% improvement.
> >>>
> >>>               ttl =3D 0         ttl =3D 50        ttl =3D 100
> >>> mainline        2267ms                2420ms          2316ms
> >>> commit          1992ms          1806ms          1998ms
> >>>
> >>> case 4:
> >>> androbench has no improvment as well as regression which supposed to =
be
> >>> its test time is short which MGLRU hasn't take effect yet.
> >>>
> >>> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >>> ---
> >>> change of v2: calculate page's activity via helper function
> >>> change of v3: solve layer violation by move API into mm
> >>> change of v4: keep block clean by removing the page related API
> >>> change of v5: introduce the macros of bio_add_folio/page for read dir=
.
> >>> ---
> >>> ---
> >>>  include/linux/act_ioprio.h  | 60 +++++++++++++++++++++++++++++++++++=
++
> >>>  include/uapi/linux/ioprio.h | 38 +++++++++++++++++++++++
> >>>  mm/Kconfig                  |  8 +++++
> >>>  3 files changed, 106 insertions(+)
> >>>  create mode 100644 include/linux/act_ioprio.h
> >>>
> >>> diff --git a/include/linux/act_ioprio.h b/include/linux/act_ioprio.h
> >>> new file mode 100644
> >>> index 000000000000..ca7309b85758
> >>> --- /dev/null
> >>> +++ b/include/linux/act_ioprio.h
> >>> @@ -0,0 +1,60 @@
> >>> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> >>> +#ifndef _ACT_IOPRIO_H
> >>> +#define _ACT_IOPRIO_H
> >>> +
> >>> +#ifdef CONFIG_CONTENT_ACT_BASED_IOPRIO
> >>> +#include <linux/bio.h>
> >>> +
> >>> +static __maybe_unused
> >>> +bool act_bio_add_folio(struct bio *bio, struct folio *folio, size_t =
len,
> >>> +             size_t off)
> >>> +{
> >>> +     int class, level, hint, activity;
> >>> +     bool ret;
> >>> +
> >>> +     ret =3D bio_add_folio(bio, folio, len, off);
> >>> +     if (bio_op(bio) =3D=3D REQ_OP_READ && ret) {
> >>> +             class =3D IOPRIO_PRIO_CLASS(bio->bi_ioprio);
> >>> +             level =3D IOPRIO_PRIO_LEVEL(bio->bi_ioprio);
> >>> +             hint =3D IOPRIO_PRIO_HINT(bio->bi_ioprio);
> >>> +             activity =3D IOPRIO_PRIO_ACTIVITY(bio->bi_ioprio);
> >>> +             activity +=3D (activity < IOPRIO_NR_ACTIVITY &&
> >>> +                             folio_test_workingset(folio)) ? 1 : 0;
> >>> +             if (activity >=3D bio->bi_vcnt / 2)
> >>> +                     class =3D IOPRIO_CLASS_RT;
> >>> +             else if (activity >=3D bio->bi_vcnt / 4)
> >>> +                     class =3D max(IOPRIO_PRIO_CLASS(get_current_iop=
rio()), IOPRIO_CLASS_BE);
> >>> +             activity =3D min(IOPRIO_NR_ACTIVITY - 1, activity);
> >>> +             bio->bi_ioprio =3D IOPRIO_PRIO_VALUE_ACTIVITY(class, le=
vel, hint, activity);
> >>> +     }
> >>> +     return ret;
> >>> +}
> >>
> >> Big non-inline functions in a header file... That is unusual, to say t=
he least.
> >> So every FS that includes this will get its own copy of the binary for=
 these
> >> functions. That is not exactly optimal.
> > Thanks for quick reply:D
> > This is a trade-off method for having both the block layer and fs be
> > clean and do no modification. There is less calling bio_add_xxx within
> > fs actually.
> >>
> >>> +
> >>> +static __maybe_unused
> >>> +int act_bio_add_page(struct bio *bio, struct page *page,
> >>> +             unsigned int len, unsigned int offset)
> >>> +{
> >>> +     int class, level, hint, activity;
> >>> +     int ret =3D 0;
> >>> +
> >>> +     ret =3D bio_add_page(bio, page, len, offset);
> >>> +     if (bio_op(bio) =3D=3D REQ_OP_READ && ret > 0) {
> >>> +             class =3D IOPRIO_PRIO_CLASS(bio->bi_ioprio);
> >>> +             level =3D IOPRIO_PRIO_LEVEL(bio->bi_ioprio);
> >>> +             hint =3D IOPRIO_PRIO_HINT(bio->bi_ioprio);
> >>> +             activity =3D IOPRIO_PRIO_ACTIVITY(bio->bi_ioprio);
> >>> +             activity +=3D (activity < IOPRIO_NR_ACTIVITY &&
> >>> +                             PageWorkingset(page)) ? 1 : 0;
> >>> +             if (activity >=3D bio->bi_vcnt / 2)
> >>> +                     class =3D IOPRIO_CLASS_RT;
> >>> +             else if (activity >=3D bio->bi_vcnt / 4)
> >>> +                     class =3D max(IOPRIO_PRIO_CLASS(get_current_iop=
rio()), IOPRIO_CLASS_BE);
> >>> +             activity =3D min(IOPRIO_NR_ACTIVITY - 1, activity);
> >>> +             bio->bi_ioprio =3D IOPRIO_PRIO_VALUE_ACTIVITY(class, le=
vel, hint, activity);
> >>> +     }
> >>> +     return ret;
> >>> +}
> >>> +#define bio_add_folio(bio, folio, len, off)     act_bio_add_folio(bi=
o, folio, len, off)
> >>> +#define bio_add_page(bio, page, len, offset)    act_bio_add_page(bio=
, page, len, offset)
> >>
> >> These functions are *NOT* part of the block layer. So please do not pr=
etend they
> >> are. Why don't you simply write a function equivalent to what you have=
 inside
> >> the "if" above and have the FS call that after bio_add_Page() ?
> > The iteration of bio is costly(could be maximum to 256 pages) and
> > needs fs's code modification. I will implement a version as you
> > suggested.
> >>
> >> And I seriously doubt that all compilers will be happy with these macr=
o names
> >> clashing with real function names...
> >>
> >>> +#endif
> >>> +#endif
> >>> diff --git a/include/uapi/linux/ioprio.h b/include/uapi/linux/ioprio.=
h
> >>> index bee2bdb0eedb..64cf5ff0ac5f 100644
> >>> --- a/include/uapi/linux/ioprio.h
> >>> +++ b/include/uapi/linux/ioprio.h
> >>> @@ -71,12 +71,24 @@ enum {
> >>>   * class and level.
> >>>   */
> >>>  #define IOPRIO_HINT_SHIFT            IOPRIO_LEVEL_NR_BITS
> >>> +#ifdef CONFIG_CONTENT_ACT_BASED_IOPRIO
> >>> +#define IOPRIO_HINT_NR_BITS          3
> >>> +#else
> >>>  #define IOPRIO_HINT_NR_BITS          10
> >>> +#endif
> >>>  #define IOPRIO_NR_HINTS                      (1 << IOPRIO_HINT_NR_BI=
TS)
> >>>  #define IOPRIO_HINT_MASK             (IOPRIO_NR_HINTS - 1)
> >>>  #define IOPRIO_PRIO_HINT(ioprio)     \
> >>>       (((ioprio) >> IOPRIO_HINT_SHIFT) & IOPRIO_HINT_MASK)
> >>>
> >>> +#ifdef CONFIG_CONTENT_ACT_BASED_IOPRIO
> >>> +#define IOPRIO_ACTIVITY_SHIFT                (IOPRIO_HINT_NR_BITS + =
IOPRIO_LEVEL_NR_BITS)
> >>> +#define IOPRIO_ACTIVITY_NR_BITS              7
> >>
> >> I already told you that taking all the free hint bits for yourself, le=
aving no
> >> room fo future IO hints, is not nice. Do you really need 7 bits for yo=
ur thing ?
> >> Why does the activity even need to be part of the IO priority ? From t=
he rather
> >> short explanation in the commit message, it seems that activity should=
 simply
> >> raise the priority (either class or level or both). I do not see why t=
hat
> >> activity number needs to be in the ioprio. Who in the kernel will look=
 at it ?
> >> IO scheduler ? the storage device ?
> > As I explained above, 7 bits(128 of 256) within ioprio is the minimum
> > number for counting active pages carried by this bio and will end at
> > the IO scheduler. bio has to be enlarged a new member to log these if
> > we don't use ioprio.
>
> That information does not belong to the ioprio. And which scheduler acts =
on a
> number of pages anyway ? The scheduler sees requests and BIOs. It can det=
ermine
> the number of pages they have if that is an information it needs to make
> scheduling decisison. Using ioprio to pass that information down is a dir=
ty hack.
No. IO scheduler acts on IOPRIO_CLASS which is transferred from the
page's activity by the current method. I will implement another
version of iterating pages before submit_bio and feed back to the list
>
> >>
> >>> +#define IOPRIO_NR_ACTIVITY           (1 << IOPRIO_ACTIVITY_NR_BITS)
> >>> +#define IOPRIO_ACTIVITY_MASK         (IOPRIO_NR_ACTIVITY - 1)
> >>> +#define IOPRIO_PRIO_ACTIVITY(ioprio) \
> >>> +     (((ioprio) >> IOPRIO_ACTIVITY_SHIFT) & IOPRIO_ACTIVITY_MASK)
> >>> +#endif
> >>>  /*
> >>>   * I/O hints.
> >>>   */
> >>> @@ -104,6 +116,7 @@ enum {
> >>>
> >>>  #define IOPRIO_BAD_VALUE(val, max) ((val) < 0 || (val) >=3D (max))
> >>>
> >>> +#ifndef CONFIG_CONTENT_ACT_BASED_IOPRIO
> >>>  /*
> >>>   * Return an I/O priority value based on a class, a level and a hint=
.
> >>>   */
> >>> @@ -123,5 +136,30 @@ static __always_inline __u16 ioprio_value(int pr=
ioclass, int priolevel,
> >>>       ioprio_value(prioclass, priolevel, IOPRIO_HINT_NONE)
> >>>  #define IOPRIO_PRIO_VALUE_HINT(prioclass, priolevel, priohint)      =
 \
> >>>       ioprio_value(prioclass, priolevel, priohint)
> >>> +#else
> >>> +/*
> >>> + * Return an I/O priority value based on a class, a level, a hint an=
d
> >>> + * content's activities
> >>> + */
> >>> +static __always_inline __u16 ioprio_value(int prioclass, int priolev=
el,
> >>> +             int priohint, int activity)
> >>> +{
> >>> +     if (IOPRIO_BAD_VALUE(prioclass, IOPRIO_NR_CLASSES) ||
> >>> +                     IOPRIO_BAD_VALUE(priolevel, IOPRIO_NR_LEVELS) |=
|
> >>> +                     IOPRIO_BAD_VALUE(priohint, IOPRIO_NR_HINTS) ||
> >>> +                     IOPRIO_BAD_VALUE(activity, IOPRIO_NR_ACTIVITY))
> >>> +             return IOPRIO_CLASS_INVALID << IOPRIO_CLASS_SHIFT;
> >>>
> >>> +     return (prioclass << IOPRIO_CLASS_SHIFT) |
> >>> +             (activity << IOPRIO_ACTIVITY_SHIFT) |
> >>> +             (priohint << IOPRIO_HINT_SHIFT) | priolevel;
> >>> +}
> >>> +
> >>> +#define IOPRIO_PRIO_VALUE(prioclass, priolevel)                     =
 \
> >>> +     ioprio_value(prioclass, priolevel, IOPRIO_HINT_NONE, 0)
> >>> +#define IOPRIO_PRIO_VALUE_HINT(prioclass, priolevel, priohint)      =
 \
> >>> +     ioprio_value(prioclass, priolevel, priohint, 0)
> >>> +#define IOPRIO_PRIO_VALUE_ACTIVITY(prioclass, priolevel, priohint, a=
ctivity) \
> >>> +     ioprio_value(prioclass, priolevel, priohint, activity)
> >>> +#endif
> >>>  #endif /* _UAPI_LINUX_IOPRIO_H */
> >>> diff --git a/mm/Kconfig b/mm/Kconfig
> >>> index 264a2df5ecf5..e0e5a5a44ded 100644
> >>> --- a/mm/Kconfig
> >>> +++ b/mm/Kconfig
> >>> @@ -1240,6 +1240,14 @@ config LRU_GEN_STATS
> >>>         from evicted generations for debugging purpose.
> >>>
> >>>         This option has a per-memcg and per-node memory overhead.
> >>> +
> >>> +config CONTENT_ACT_BASED_IOPRIO
> >>> +     bool "Enable content activity based ioprio"
> >>> +     depends on LRU_GEN
> >>> +     default n
> >>> +     help
> >>> +       This item enable the feature of adjust bio's priority by
> >>> +       calculating its content's activity.
> >>>  # }
> >>>
> >>>  config ARCH_SUPPORTS_PER_VMA_LOCK
> >>
> >> --
> >> Damien Le Moal
> >> Western Digital Research
> >>
>
> --
> Damien Le Moal
> Western Digital Research
>

