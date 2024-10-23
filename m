Return-Path: <linux-fsdevel+bounces-32633-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FB59ABAC5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 02:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A8691F2415F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 00:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9FE1F941;
	Wed, 23 Oct 2024 00:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xmM+pHu5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66F51AAC4
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Oct 2024 00:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729645060; cv=none; b=u90NSDRqRuxu/v8kQghTUrLL38fvSa+YVPCoLYQ28nYkQZFTYLnWog8iyMlddW3nVV/sZKvVu/AdJRDtjL84mOkb/OOqXP7nQZo95Q8jcp1d1vf3xI585mqtSmYoLRB3mk/lASPO6s0bWjPKKU2iSXyneF90nd6Tsn36O/KyOAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729645060; c=relaxed/simple;
	bh=WKMg7r5uv6sja/nST2kyGAzJQXI3GsCqP8GL/I7PYa4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SScRfIV6u41Lgv5KCCWsa/C0ZCkkQ9QTPqc7FbjL0ZoUNECvdu38/NaMIeUr1puTLNltQ+rMS78mvHOqIvNB2bdOJKsIbJUsKoFVgwSSDeYE+USBW9L5PFGJXuxqd6UEoajBXySVZl9yooVSKt2+d6jkRIQQvenPe1qPJ8mn1K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xmM+pHu5; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539fb49c64aso8775841e87.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Oct 2024 17:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729645055; x=1730249855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MeXSAL+y+3H2wvc+euef7BeJQcQ0H2qAVwYECCHhQc4=;
        b=xmM+pHu5k90e41TNGj1TnZ4SFuFg2EBsHWXAA0O+Roi3xiOOpUY/2GonfCDr0/f/Pr
         4RZQtcwBRhzUW1hBNe/EvRVjIj4PxyUAJPgHN2VJyhSXRcp3mFKqjkY2WO0w4qBboQ8q
         svdOwsc1NvjkkaoviBAS6qMvB90Lx14OEwLvlyh+9Y+dwIaZK0t3Jm6qCR4flmteu4N2
         ESR3NfTEWCQGpusJp0OZX529/uhoVmOgwoWAK7ZLb/VVY0qFZQ80zVRhPwclWeblPhKO
         tYfz89Xt1bCWAGEQ1151N8TrVEKD5vhRNqQkwUvisNjUq6yg+AhnSTJQ5Lz0Y22T9LMv
         zikw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729645055; x=1730249855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MeXSAL+y+3H2wvc+euef7BeJQcQ0H2qAVwYECCHhQc4=;
        b=rgywJxxFmo6AOqMSPzNAzSwz4EK3UpPCgqbCDdqJZeOzyfjoiEEPA/YsDILsTWQmLh
         sp+nOQ2rXyN3vSa3/VoaXftD4uNRi2h33ZN6senOkzlJmV27Q/1hmYtRt2Iz6xRkqEHm
         FTxJB59kcHFE2c9NHtNfcqZDOAcTAdCvLw1VcX4oXiuDe5Sg/c8aurdYEerdRupE/peX
         hFHO4gA1Qok6SE114+DwU3bGDFbEwQZVu25cgB6x8RKpyZC9mdc1OoGp7ru+AoTBzuMk
         IHhUefTAgFl6PCu9XzHLZNDQZPSi0vn3Uq4am83RSgwbkis9dy4gOkJ3QD6pGwDPpqkS
         jrxA==
X-Forwarded-Encrypted: i=1; AJvYcCWmxGEvohGj1kKHnXU4iuLO5KQ6zArMtW75gTvA5vcf7uhmkE6Iz/99c0BiyMP1qL/bYTMOG1mWIRdbIog8@vger.kernel.org
X-Gm-Message-State: AOJu0YzjPNyNjnWVVqwrppgKlHYiYX+pOiyjGP+FAZK3QIb/f8CxecLr
	cD5ji5T/vhDKQH9+ITUb/4V3VUxJK6JArDPPXgUqiR2oHZG5vw3ZJzM9M1kDO7xXD/p8Vfg64Vd
	CNhcW1re14mgbRNSqGf/rUP5zKESlWpWr4r+W
X-Google-Smtp-Source: AGHT+IF4UEmrRhjIlbtGWa81MoTbxoRdBd5botAhosqlKJWcq9ld67eM1ZXWrrmloPnHZeSED5Xqm1DxaRCBX2N5r4w=
X-Received: by 2002:a05:6512:10c4:b0:530:b773:b4ce with SMTP id
 2adb3069b0e04-53b1a34e1camr501661e87.33.1729645054540; Tue, 22 Oct 2024
 17:57:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018064101.336232-1-kanchana.p.sridhar@intel.com>
In-Reply-To: <20241018064101.336232-1-kanchana.p.sridhar@intel.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 22 Oct 2024 17:56:58 -0700
Message-ID: <CAJD7tkamDPn8LKTd-0praj+MMJ3cNVuF3R0ivqHCW=2vWBQ_Yw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 00/13] zswap IAA compress batching
To: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, hannes@cmpxchg.org, 
	nphamcs@gmail.com, chengming.zhou@linux.dev, usamaarif642@gmail.com, 
	ryan.roberts@arm.com, ying.huang@intel.com, 21cnbao@gmail.com, 
	akpm@linux-foundation.org, linux-crypto@vger.kernel.org, 
	herbert@gondor.apana.org.au, davem@davemloft.net, clabbe@baylibre.com, 
	ardb@kernel.org, ebiggers@google.com, surenb@google.com, 
	kristen.c.accardi@intel.com, zanussi@kernel.org, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, mcgrof@kernel.org, kees@kernel.org, 
	joel.granados@kernel.org, bfoster@redhat.com, willy@infradead.org, 
	linux-fsdevel@vger.kernel.org, wajdi.k.feghali@intel.com, 
	vinodh.gopal@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 11:41=E2=80=AFPM Kanchana P Sridhar
<kanchana.p.sridhar@intel.com> wrote:
>
>
> IAA Compression Batching:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>
> This RFC patch-series introduces the use of the Intel Analytics Accelerat=
or
> (IAA) for parallel compression of pages in a folio, and for batched recla=
im
> of hybrid any-order batches of folios in shrink_folio_list().
>
> The patch-series is organized as follows:
>
>  1) iaa_crypto driver enablers for batching: Relevant patches are tagged
>     with "crypto:" in the subject:
>
>     a) async poll crypto_acomp interface without interrupts.
>     b) crypto testmgr acomp poll support.
>     c) Modifying the default sync_mode to "async" and disabling
>        verify_compress by default, to facilitate users to run IAA easily =
for
>        comparison with software compressors.
>     d) Changing the cpu-to-iaa mappings to more evenly balance cores to I=
AA
>        devices.
>     e) Addition of a "global_wq" per IAA, which can be used as a global
>        resource for the socket. If the user configures 2WQs per IAA devic=
e,
>        the driver will distribute compress jobs from all cores on the
>        socket to the "global_wqs" of all the IAA devices on that socket, =
in
>        a round-robin manner. This can be used to improve compression
>        throughput for workloads that see a lot of swapout activity.
>
>  2) Migrating zswap to use async poll in zswap_compress()/decompress().
>  3) A centralized batch compression API that can be used by swap modules.
>  4) IAA compress batching within large folio zswap stores.
>  5) IAA compress batching of any-order hybrid folios in
>     shrink_folio_list(). The newly added "sysctl vm.compress-batchsize"
>     parameter can be used to configure the number of folios in [1, 32] to
>     be reclaimed using compress batching.

I am still digesting this series but I have some high level questions
that I left on some patches. My intuition though is that we should
drop (5) from the initial proposal as it's most controversial.
Batching reclaim of unrelated folios through zswap *might* make sense,
but it needs a broader conversation and it needs justification on its
own merit, without the rest of the series.

>
> IAA compress batching can be enabled only on platforms that have IAA, by
> setting this config variable:
>
>  CONFIG_ZSWAP_STORE_BATCHING_ENABLED=3D"y"
>
> The performance testing data with usemem 30 instances shows throughput
> gains of up to 40%, elapsed time reduction of up to 22% and sys time
> reduction of up to 30% with IAA compression batching.
>
> Our internal validation of IAA compress/decompress batching in highly
> contended Sapphire Rapids server setups with workloads running on 72 core=
s
> for ~25 minutes under stringent memory limit constraints have shown up to
> 50% reduction in sys time and 3.5% reduction in workload run time as
> compared to software compressors.
>
>
> System setup for testing:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> Testing of this patch-series was done with mm-unstable as of 10-16-2024,
> commit 817952b8be34, without and with this patch-series.
> Data was gathered on an Intel Sapphire Rapids server, dual-socket 56 core=
s
> per socket, 4 IAA devices per socket, 503 GiB RAM and 525G SSD disk
> partition swap. Core frequency was fixed at 2500MHz.
>
> The vm-scalability "usemem" test was run in a cgroup whose memory.high
> was fixed at 150G. The is no swap limit set for the cgroup. 30 usemem
> processes were run, each allocating and writing 10G of memory, and sleepi=
ng
> for 10 sec before exiting:
>
> usemem --init-time -w -O -s 10 -n 30 10g
>
> Other kernel configuration parameters:
>
>     zswap compressor : deflate-iaa
>     zswap allocator   : zsmalloc
>     vm.page-cluster   : 2,4
>
> IAA "compression verification" is disabled and the async poll acomp
> interface is used in the iaa_crypto driver (the defaults with this
> series).
>
>
> Performance testing (usemem30):
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>
>  4K folios: deflate-iaa:
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  ------------------------------------------------------------------------=
-------
>                 mm-unstable-10-16-2024  shrink_folio_list()  shrink_folio=
_list()
>                                          batching of folios   batching of=
 folios
>  ------------------------------------------------------------------------=
-------
>  zswap compressor          deflate-iaa          deflate-iaa          defl=
ate-iaa
>  vm.compress-batchsize             n/a                    1              =
     32
>  vm.page-cluster                     2                    2              =
      2
>  ------------------------------------------------------------------------=
-------
>  Total throughput            4,470,466            5,770,824            6,=
363,045
>            (KB/s)
>  Average throughput            149,015              192,360              =
212,101
>            (KB/s)
>  elapsed time                   119.24               100.96              =
  92.99
>         (sec)
>  sys time (sec)               2,819.29             2,168.08             1=
,970.79
>
>  ------------------------------------------------------------------------=
-------
>  memcg_high                    668,185              646,357              =
613,421
>  memcg_swap_fail                     0                    0              =
      0
>  zswpout                    62,991,796           58,275,673           53,=
070,201
>  zswpin                            431                  415              =
    396
>  pswpout                             0                    0              =
      0
>  pswpin                              0                    0              =
      0
>  thp_swpout                          0                    0              =
      0
>  thp_swpout_fallback                 0                    0              =
      0
>  pgmajfault                      3,137                3,085              =
  3,440
>  swap_ra                            99                  100              =
     95
>  swap_ra_hit                        42                   44              =
     45
>  ------------------------------------------------------------------------=
-------
>
>
>  16k/32/64k folios: deflate-iaa:
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>  All three large folio sizes 16k/32/64k were enabled to "always".
>
>  ------------------------------------------------------------------------=
-------
>                 mm-unstable-  zswap_store()      + shrink_folio_list()
>                   10-16-2024    batching of         batching of folios
>                                    pages in
>                                large folios
>  ------------------------------------------------------------------------=
-------
>  zswap compr     deflate-iaa     deflate-iaa          deflate-iaa
>  vm.compress-            n/a             n/a         4          8        =
     16
>  batchsize
>  vm.page-                  2               2         2          2        =
      2
>   cluster
>  ------------------------------------------------------------------------=
-------
>  Total throughput   7,182,198   8,448,994    8,584,728    8,729,643    8,=
775,944
>            (KB/s)
>  Avg throughput       239,406     281,633      286,157      290,988      =
292,531
>          (KB/s)
>  elapsed time           85.04       77.84        77.03        75.18      =
  74.98
>          (sec)
>  sys time (sec)      1,730.77    1,527.40     1,528.52     1,473.76     1=
,465.97
>
>  ------------------------------------------------------------------------=
-------
>  memcg_high           648,125     694,188      696,004      699,728      =
724,887
>  memcg_swap_fail        1,550       2,540        1,627        1,577      =
  1,517
>  zswpout           57,606,876  56,624,450   56,125,082    55,999,42   57,=
352,204
>  zswpin                   421         406          422          400      =
    437
>  pswpout                    0           0            0            0      =
      0
>  pswpin                     0           0            0            0      =
      0
>  thp_swpout                 0           0            0            0      =
      0
>  thp_swpout_fallback        0           0            0            0      =
      0
>  16kB-mthp_swpout_          0           0            0            0      =
      0
>           fallback
>  32kB-mthp_swpout_          0           0            0            0      =
      0
>           fallback
>  64kB-mthp_swpout_      1,550       2,539        1,627        1,577      =
  1,517
>           fallback
>  pgmajfault             3,102       3,126        3,473        3,454      =
  3,134
>  swap_ra                  107         144          109          124      =
    181
>  swap_ra_hit               51          88           45           66      =
    107
>  ZSWPOUT-16kB               2           3            4            4      =
      3
>  ZSWPOUT-32kB               0           2            1            1      =
      0
>  ZSWPOUT-64kB       3,598,889   3,536,556    3,506,134    3,498,324    3,=
582,921
>  SWPOUT-16kB                0           0            0            0      =
      0
>  SWPOUT-32kB                0           0            0            0      =
      0
>  SWPOUT-64kB                0           0            0            0      =
      0
>  ------------------------------------------------------------------------=
-------
>
>
>  2M folios: deflate-iaa:
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  ------------------------------------------------------------------------=
-------
>                    mm-unstable-10-16-2024    zswap_store() batching of pa=
ges
>                                                       in pmd-mappable fol=
ios
>  ------------------------------------------------------------------------=
-------
>  zswap compressor             deflate-iaa                deflate-iaa
>  vm.compress-batchsize                n/a                        n/a
>  vm.page-cluster                        2                          2
>  ------------------------------------------------------------------------=
-------
>  Total throughput               7,444,592                 8,916,349
>            (KB/s)
>  Average throughput               248,153                   297,211
>            (KB/s)
>  elapsed time                       86.29                     73.44
>         (sec)
>  sys time (sec)                  1,833.21                  1,418.58
>
>  ------------------------------------------------------------------------=
-------
>  memcg_high                        81,786                    89,905
>  memcg_swap_fail                       82                       395
>  zswpout                       58,874,092                57,721,884
>  zswpin                               422                       458
>  pswpout                                0                         0
>  pswpin                                 0                         0
>  thp_swpout                             0                         0
>  thp_swpout_fallback                   82                       394
>  pgmajfault                        14,864                    21,544
>  swap_ra                           34,953                    53,751
>  swap_ra_hit                       34,895                    53,660
>  ZSWPOUT-2048kB                   114,815                   112,269
>  SWPOUT-2048kB                          0                         0
>  ------------------------------------------------------------------------=
-------
>
> Since 4K folios account for ~0.4% of all zswapouts when pmd-mappable foli=
os
> are enabled for usemem30, we cannot expect much improvement from reclaim
> batching.
>
>
> Performance testing (Kernel compilation):
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> As mentioned earlier, for workloads that see a lot of swapout activity, w=
e
> can benefit from configuring 2 WQs per IAA device, with compress jobs fro=
m
> all same-socket cores being distributed toothe wq.1 of all IAAs on the
> socket, with the "global_wq" developed in this patch-series.
>
> Although this data includes IAA decompress batching, which will be
> submitted as a separate RFC patch-series, I am listing it here to quantif=
y
> the benefit of distributing compress jobs among all IAAs. The kernel
> compilation test with "allmodconfig" is able to quantify this well:
>
>
>  4K folios: deflate-iaa: kernel compilation to quantify crypto patches
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>
>  ------------------------------------------------------------------------=
------
>                    IAA shrink_folio_list() compress batching and
>                        swapin_readahead() decompress batching
>
>                                       1WQ      2WQ (distribute compress j=
obs)
>
>                         1 local WQ (wq.0)    1 local WQ (wq.0) +
>                                   per IAA    1 global WQ (wq.1) per IAA
>
>  ------------------------------------------------------------------------=
------
>  zswap compressor             deflate-iaa         deflate-iaa
>  vm.compress-batchsize                 32                  32
>  vm.page-cluster                        4                   4
>  ------------------------------------------------------------------------=
------
>  real_sec                          746.77              745.42
>  user_sec                       15,732.66           15,738.85
>  sys_sec                         5,384.14            5,247.86
>  Max_Res_Set_Size_KB            1,874,432           1,872,640
>
>  ------------------------------------------------------------------------=
------
>  zswpout                      101,648,460         104,882,982
>  zswpin                        27,418,319          29,428,515
>  pswpout                              213                  22
>  pswpin                               207                   6
>  pgmajfault                    21,896,616          23,629,768
>  swap_ra                        6,054,409           6,385,080
>  swap_ra_hit                    3,791,628           3,985,141
>  ------------------------------------------------------------------------=
------
>
> The iaa_crypto wq stats will show almost the same number of compress call=
s
> for wq.1 of all IAA devices. wq.0 will handle decompress calls exclusivel=
y.
> We see a latency reduction of 2.5% by distributing compress jobs among al=
l
> IAA devices on the socket.
>
> I would greatly appreciate code review comments for the iaa_crypto driver
> and mm patches included in this series!
>
> Thanks,
> Kanchana
>
>
>
> Kanchana P Sridhar (13):
>   crypto: acomp - Add a poll() operation to acomp_alg and acomp_req
>   crypto: iaa - Add support for irq-less crypto async interface
>   crypto: testmgr - Add crypto testmgr acomp poll support.
>   mm: zswap: zswap_compress()/decompress() can submit, then poll an
>     acomp_req.
>   crypto: iaa - Make async mode the default.
>   crypto: iaa - Disable iaa_verify_compress by default.
>   crypto: iaa - Change cpu-to-iaa mappings to evenly balance cores to
>     IAAs.
>   crypto: iaa - Distribute compress jobs to all IAA devices on a NUMA
>     node.
>   mm: zswap: Config variable to enable compress batching in
>     zswap_store().
>   mm: zswap: Create multiple reqs/buffers in crypto_acomp_ctx if
>     platform has IAA.
>   mm: swap: Add IAA batch compression API
>     swap_crypto_acomp_compress_batch().
>   mm: zswap: Compress batching with Intel IAA in zswap_store() of large
>     folios.
>   mm: vmscan, swap, zswap: Compress batching of folios in
>     shrink_folio_list().
>
>  crypto/acompress.c                         |   1 +
>  crypto/testmgr.c                           |  70 +-
>  drivers/crypto/intel/iaa/iaa_crypto_main.c | 467 +++++++++++--
>  include/crypto/acompress.h                 |  18 +
>  include/crypto/internal/acompress.h        |   1 +
>  include/linux/fs.h                         |   2 +
>  include/linux/mm.h                         |   8 +
>  include/linux/writeback.h                  |   5 +
>  include/linux/zswap.h                      | 106 +++
>  kernel/sysctl.c                            |   9 +
>  mm/Kconfig                                 |  12 +
>  mm/page_io.c                               | 152 +++-
>  mm/swap.c                                  |  15 +
>  mm/swap.h                                  |  96 +++
>  mm/swap_state.c                            | 115 +++
>  mm/vmscan.c                                | 154 +++-
>  mm/zswap.c                                 | 771 +++++++++++++++++++--
>  17 files changed, 1870 insertions(+), 132 deletions(-)
>
>
> base-commit: 817952b8be34aad40e07f6832fb9d1fc08961550
> --
> 2.27.0
>
>

