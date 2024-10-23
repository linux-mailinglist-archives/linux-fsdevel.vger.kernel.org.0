Return-Path: <linux-fsdevel+bounces-32677-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7029AD3C3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 20:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACCBE1F22FF8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 18:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9791D1F60;
	Wed, 23 Oct 2024 18:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JZrZdHGQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02431D14E9
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Oct 2024 18:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729707390; cv=none; b=TTfpKFenGlmgUvLITeeTcqNTRHBJNie0Xhfbg4gMvlubMITLACy3LUU82wO5ppsBY4RP5AsiDfyauRLPCQyR8yybLrfkfaV6AW7C/KE4N1IW1GuzbZcLm3ZsLRst+Q81wmjo6rcBa7N4Pm882y777ZFUDg3rxnNifTXaRJsDt3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729707390; c=relaxed/simple;
	bh=6yO2piS0HmIIYQIVHC9faKpYYJZLj3Onaqd5+osUSpk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LS1ZrEyNuwmlidDnyEW6BDdOEma8X6w8/zeRkV3DkUcEZHBcjeROo5YyhKFIZTdEjs9A9Sb6DZ3R5Qr66+md2XvPLwHzPV3Zw4iKNvG2oOWVI6vw8pj6aU1BaxZ/O8uaB5Oi6AQSnfB9M/WdQLA6/rw50zSKZiq2drpwMtOHszI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JZrZdHGQ; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5cb72918bddso60205a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Oct 2024 11:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729707387; x=1730312187; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SwCuA4yImROJvhJywn+YK8+uWaKia67TwRqA6S/vp1A=;
        b=JZrZdHGQfONu9ylh5XqcctOHUnNzy+S5RFzMyvDWv7rVFuq++dA6jkTjiEwQbQLScH
         w4lCx01YIEtpta+xm0qAEPwAiOaCJygzb+fny9Aiqp0RlLJeArGx9WbGQYms1KfqGGtE
         n3IyNJxP7e1RzLKuTtFiL3i1/2oXoTnlq+G0pmQ52e5osw0CJU7osepXSK4tYFOoebJ7
         NvUn0EMfLp7Rxxcrez6tLLwNQVxvVuvLEse3X6cmWY66zYP9NOUPwrefZVy5K3q/QXgU
         okHJ7rxoZdQlUdGnPsL7t45Ci9r8+JUQI3YM9SQ7gl3O0VGk+rAuzBsn9O9DwxWSKfox
         WXKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729707387; x=1730312187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SwCuA4yImROJvhJywn+YK8+uWaKia67TwRqA6S/vp1A=;
        b=lKv1EEqBnOdZv54XaiWtkhPhtLXFRFAWU/qxFQGDz2IJHSCSC/EuKAbnIfcqI4/kXh
         HAEjuelQjWS9N/xYIkfkFSVTPL+Y8TvwxkJh+XxskxUEcB8N+OWhYjMlzddoN4LLWG8E
         l7phdOdzHxTTQxduJYNZq+UypC7hIDCZX1VQzOOyX1I/gm74LTQWO839Q+rpcGVl5Ynh
         AWtyDzyyrY0zcO/WC/wodh8UHNSKPtlCHAfz6x3J4XdgXPVgf5c750eshC0Zl96fMHEr
         fScVFlkwGSMhutk49QuDzEfgTU3qISpfSDudPHQGt+eZuLgXM89X0QxdWXZI0+A4TLkH
         v9dA==
X-Forwarded-Encrypted: i=1; AJvYcCUUqohAb5706W+XB9pGnSWJLixRIPf+qeR+nzAH9SOGiwNuhmpBAQZDIoW7iITVCAYIU3AuVYI1RBsd86PU@vger.kernel.org
X-Gm-Message-State: AOJu0Yy27X5AcLBPJIFbC5sXkCGrcWuiu4DeGIFSxHuIGPOXWGq7FePA
	Oz225nfeqtC35hguogwmxNbj5tBRhz3RwMg+zJsLnQW6pLSoF14/7WOdERVn20H0idRUJHOf1Cr
	nQsKz4C8WpLXWHYiluxcDcVRSTdzz8rZCV5zB
X-Google-Smtp-Source: AGHT+IEt31RESgiqF7AyjCPe7bxP29/f2XcyC3yNA9DrNXUcssSqGbRlVaHXeYozRvGDtobwboAYgwdDefa4Xch1ZNQ=
X-Received: by 2002:a17:907:3e0a:b0:a9a:6ab:c93b with SMTP id
 a640c23a62f3a-a9abf9b5984mr302142766b.62.1729707386560; Wed, 23 Oct 2024
 11:16:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018064101.336232-1-kanchana.p.sridhar@intel.com>
 <CAJD7tkamDPn8LKTd-0praj+MMJ3cNVuF3R0ivqHCW=2vWBQ_Yw@mail.gmail.com> <SJ0PR11MB56784C5C542E84014525BA8CC94D2@SJ0PR11MB5678.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB56784C5C542E84014525BA8CC94D2@SJ0PR11MB5678.namprd11.prod.outlook.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 23 Oct 2024 11:15:50 -0700
Message-ID: <CAJD7tkZ9VLNrwyeRQf0AXdQAG8vW_ZL_y0rfU77p5HMZnch=mw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 00/13] zswap IAA compress batching
To: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>, "nphamcs@gmail.com" <nphamcs@gmail.com>, 
	"chengming.zhou@linux.dev" <chengming.zhou@linux.dev>, 
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>, 
	"Huang, Ying" <ying.huang@intel.com>, "21cnbao@gmail.com" <21cnbao@gmail.com>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, 
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, 
	"herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>, "davem@davemloft.net" <davem@davemloft.net>, 
	"clabbe@baylibre.com" <clabbe@baylibre.com>, "ardb@kernel.org" <ardb@kernel.org>, 
	"ebiggers@google.com" <ebiggers@google.com>, "surenb@google.com" <surenb@google.com>, 
	"Accardi, Kristen C" <kristen.c.accardi@intel.com>, "zanussi@kernel.org" <zanussi@kernel.org>, 
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "brauner@kernel.org" <brauner@kernel.org>, 
	"jack@suse.cz" <jack@suse.cz>, "mcgrof@kernel.org" <mcgrof@kernel.org>, "kees@kernel.org" <kees@kernel.org>, 
	"joel.granados@kernel.org" <joel.granados@kernel.org>, "bfoster@redhat.com" <bfoster@redhat.com>, 
	"willy@infradead.org" <willy@infradead.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"Feghali, Wajdi K" <wajdi.k.feghali@intel.com>, "Gopal, Vinodh" <vinodh.gopal@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 7:53=E2=80=AFPM Sridhar, Kanchana P
<kanchana.p.sridhar@intel.com> wrote:
>
> Hi Yosry,
>
> > -----Original Message-----
> > From: Yosry Ahmed <yosryahmed@google.com>
> > Sent: Tuesday, October 22, 2024 5:57 PM
> > To: Sridhar, Kanchana P <kanchana.p.sridhar@intel.com>
> > Cc: linux-kernel@vger.kernel.org; linux-mm@kvack.org;
> > hannes@cmpxchg.org; nphamcs@gmail.com; chengming.zhou@linux.dev;
> > usamaarif642@gmail.com; ryan.roberts@arm.com; Huang, Ying
> > <ying.huang@intel.com>; 21cnbao@gmail.com; akpm@linux-foundation.org;
> > linux-crypto@vger.kernel.org; herbert@gondor.apana.org.au;
> > davem@davemloft.net; clabbe@baylibre.com; ardb@kernel.org;
> > ebiggers@google.com; surenb@google.com; Accardi, Kristen C
> > <kristen.c.accardi@intel.com>; zanussi@kernel.org; viro@zeniv.linux.org=
.uk;
> > brauner@kernel.org; jack@suse.cz; mcgrof@kernel.org; kees@kernel.org;
> > joel.granados@kernel.org; bfoster@redhat.com; willy@infradead.org; linu=
x-
> > fsdevel@vger.kernel.org; Feghali, Wajdi K <wajdi.k.feghali@intel.com>; =
Gopal,
> > Vinodh <vinodh.gopal@intel.com>
> > Subject: Re: [RFC PATCH v1 00/13] zswap IAA compress batching
> >
> > On Thu, Oct 17, 2024 at 11:41=E2=80=AFPM Kanchana P Sridhar
> > <kanchana.p.sridhar@intel.com> wrote:
> > >
> > >
> > > IAA Compression Batching:
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> > >
> > > This RFC patch-series introduces the use of the Intel Analytics Accel=
erator
> > > (IAA) for parallel compression of pages in a folio, and for batched r=
eclaim
> > > of hybrid any-order batches of folios in shrink_folio_list().
> > >
> > > The patch-series is organized as follows:
> > >
> > >  1) iaa_crypto driver enablers for batching: Relevant patches are tag=
ged
> > >     with "crypto:" in the subject:
> > >
> > >     a) async poll crypto_acomp interface without interrupts.
> > >     b) crypto testmgr acomp poll support.
> > >     c) Modifying the default sync_mode to "async" and disabling
> > >        verify_compress by default, to facilitate users to run IAA eas=
ily for
> > >        comparison with software compressors.
> > >     d) Changing the cpu-to-iaa mappings to more evenly balance cores =
to IAA
> > >        devices.
> > >     e) Addition of a "global_wq" per IAA, which can be used as a glob=
al
> > >        resource for the socket. If the user configures 2WQs per IAA d=
evice,
> > >        the driver will distribute compress jobs from all cores on the
> > >        socket to the "global_wqs" of all the IAA devices on that sock=
et, in
> > >        a round-robin manner. This can be used to improve compression
> > >        throughput for workloads that see a lot of swapout activity.
> > >
> > >  2) Migrating zswap to use async poll in zswap_compress()/decompress(=
).
> > >  3) A centralized batch compression API that can be used by swap modu=
les.
> > >  4) IAA compress batching within large folio zswap stores.
> > >  5) IAA compress batching of any-order hybrid folios in
> > >     shrink_folio_list(). The newly added "sysctl vm.compress-batchsiz=
e"
> > >     parameter can be used to configure the number of folios in [1, 32=
] to
> > >     be reclaimed using compress batching.
> >
> > I am still digesting this series but I have some high level questions
> > that I left on some patches. My intuition though is that we should
> > drop (5) from the initial proposal as it's most controversial.
> > Batching reclaim of unrelated folios through zswap *might* make sense,
> > but it needs a broader conversation and it needs justification on its
> > own merit, without the rest of the series.
>
> Thanks for these suggestions!  Sure, I can drop (5) from the initial patc=
h-set.
> Agree also, this needs a broader discussion.
>
> I believe the 4K folios usemem30 data in this patchset does bring across
> the batching reclaim benefits to provide justification on its own merit. =
I added
> the data on batching reclaim with kernel compilation as part of the 4K fo=
lios
> experiments in the IAA decompression batching patch-series [1].
> Listing it here as well. I will make sure to add this data in subsequent =
revs.
>
> -------------------------------------------------------------------------=
-
>  Kernel compilation in tmpfs/allmodconfig, 2G max memory:
>
>  No large folios          mm-unstable-10-16-2024       shrink_folio_list(=
)
>                                                        batching of folios
>  ------------------------------------------------------------------------=
--
>  zswap compressor         zstd       deflate-iaa       deflate-iaa
>  vm.compress-batchsize     n/a               n/a                32
>  vm.page-cluster             3                 3                 3
>  ------------------------------------------------------------------------=
--
>  real_sec               783.87            761.69            747.32
>  user_sec            15,750.07         15,716.69         15,728.39
>  sys_sec              6,522.32          5,725.28          5,399.44
>  Max_RSS_KB          1,872,640         1,870,848         1,874,432
>
>  zswpout            82,364,991        97,739,600       102,780,612
>  zswpin             21,303,393        27,684,166        29,016,252
>  pswpout                    13               222               213
>  pswpin                     12               209               202
>  pgmajfault         17,114,339        22,421,211        23,378,161
>  swap_ra             4,596,035         5,840,082         6,231,646
>  swap_ra_hit         2,903,249         3,682,444         3,940,420
>  ------------------------------------------------------------------------=
--
>
> The performance improvements seen does depend on compression batching in
> the swap modules (zswap). The implementation in patch 12 in the compress
> batching series sets up this zswap compression pipeline, that takes an ar=
ray of
> folios and processes them in batches of 8 pages compressed in parallel in=
 hardware.
> That being said, we do see latency improvements even with reclaim batchin=
g
> combined with zswap compress batching with zstd/lzo-rle/etc. I haven't do=
ne a
> lot of analysis of this, but I am guessing fewer calls from the swap laye=
r
> (swap_writepage()) into zswap could have something to do with this. If we=
 believe
> that batching can be the right thing to do even for the software compress=
ors,
> I can gather batching data with zstd for v2.

Thanks for sharing the data. What I meant is, I think we should focus
on supporting large folio compression batching for this series, and
only present figures for this support to avoid confusion.

Once this lands, we can discuss support for batching the compression
of different unrelated folios separately, as it spans areas beyond
just zswap and will need broader discussion.

