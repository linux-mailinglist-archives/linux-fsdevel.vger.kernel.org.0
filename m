Return-Path: <linux-fsdevel+bounces-1962-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2667E0C06
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Nov 2023 00:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8080C281B9E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Nov 2023 23:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FD1250F7;
	Fri,  3 Nov 2023 23:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="LYEp8QYz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E491E24A05
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Nov 2023 23:13:17 +0000 (UTC)
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8FBD48
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Nov 2023 16:13:13 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20231103231301euoutp01e7190bd6ed7be21892346f1e64866380~UP93mt_ge1013410134euoutp01m
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Nov 2023 23:13:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20231103231301euoutp01e7190bd6ed7be21892346f1e64866380~UP93mt_ge1013410134euoutp01m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1699053181;
	bh=oHsO3OHKphhNYc2KKcSi9BXbYPXz/A7ETlyML/Q/00I=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=LYEp8QYzPDwiyxo0vJcR59grQQPKZw/jJGYxkBRhA1+xpmy1hXxufOiNL4gCdRgD1
	 baYL7KT4WACekSJU8eKAZUKlMSzZXdaMfjFIh/1eRzN6rxECFT4MjS44DLRRnLDAkk
	 79Fz/sGs8mH+Nb/lyRW47yIBA8MgRI6dHi4XOfPk=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20231103231301eucas1p192942ceb0cb6ebb63aee326a6f959e2d~UP92_LwPe0263002630eucas1p1C;
	Fri,  3 Nov 2023 23:13:01 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id A5.2B.42423.C7E75456; Fri,  3
	Nov 2023 23:13:00 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20231103231259eucas1p18e529693e4b47b5e0623271bf319a25f~UP915_fmj2687926879eucas1p1Z;
	Fri,  3 Nov 2023 23:12:59 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231103231259eusmtrp22251fecfaf13e569c815d97a704cbb52~UP911BCNL1325313253eusmtrp2c;
	Fri,  3 Nov 2023 23:12:59 +0000 (GMT)
X-AuditID: cbfec7f2-a51ff7000002a5b7-2a-65457e7cccea
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id C8.69.10549.B7E75456; Fri,  3
	Nov 2023 23:12:59 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20231103231259eusmtip2247fb3c78e71787af6a52bb65a4d74c0~UP91nknSd2294222942eusmtip2T;
	Fri,  3 Nov 2023 23:12:59 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) by
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) with Microsoft SMTP
	Server (TLS) id 15.0.1497.2; Fri, 3 Nov 2023 23:12:58 +0000
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
	([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Fri, 3 Nov
	2023 23:12:58 +0000
From: Daniel Gomez <da.gomez@samsung.com>
To: Matthew Wilcox <willy@infradead.org>
CC: "minchan@kernel.org" <minchan@kernel.org>, "senozhatsky@chromium.org"
	<senozhatsky@chromium.org>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"djwong@kernel.org" <djwong@kernel.org>, "hughd@google.com"
	<hughd@google.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"mcgrof@kernel.org" <mcgrof@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-xfs@vger.kernel.org"
	<linux-xfs@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"gost.dev@samsung.com" <gost.dev@samsung.com>, Pankaj Raghav
	<p.raghav@samsung.com>
Subject: Re: [RFC PATCH 01/11] XArray: add cmpxchg order test
Thread-Topic: [RFC PATCH 01/11] XArray: add cmpxchg order test
Thread-Index: AQHaCePk2/Onfe3eA0ia1dQGCoKrA7BhNHAAgAgOVAA=
Date: Fri, 3 Nov 2023 23:12:58 +0000
Message-ID: <20231103231254.bytltpzsc2qojlbw@sarkhan>
In-Reply-To: <ZT68dBiJKNLXLRZA@casper.infradead.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [106.110.32.103]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BE63A8201D5D3541A51BCEF17F33D0F1@scsc.local>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKKsWRmVeSWpSXmKPExsWy7djP87o1da6pBtNnW1nMWb+GzWL13X42
	i8tP+Cyefupjsdh7S9tiz96TLBaXd81hs7i35j+rxa4/O9gtbkx4ymix7Ot7dovdGxexWfz+
	MYfNgddjdsNFFo8Fm0o9Nq/Q8rh8ttRj06pONo9Nnyaxe5yY8ZvF4/MmuQCOKC6blNSczLLU
	In27BK6MzUd3Mxac5anY13GcsYFxJVcXIyeHhICJxInn79i6GLk4hARWMErs3HedBcL5wijR
	On8KE4TzmVHi9IJnLDAtzy/1MYLYQgLLGSXObGWCsIGKjn2Og2g4zShx99p9Jri5M+/sYwOp
	YhPQlNh3chN7FyMHh4iAhsSbLUYgNcwCR1kllqzdBLZBWMBWYv3WOcwgtoiAncTDWy/ZIWwr
	iVdfroPVsAioSLzY/hOshlfAVGLOtMVgNZxA1y3d/gnsIkYBWYlHK3+BxZkFxCVuPZnPBPGB
	oMSi2XuYIWwxiX+7HrJB2DoSZ68/YYSwDSS2Lt0H9bGSxJ+OhYwQc3QkFuz+xAZhW0o0nPwM
	FdeWWLbwNdQ9ghInZz4Bh6OEwFQuibVL50Etc5E4enA31BHCEq+Ob2GfwKgzC8l9s5DsmIVk
	xywkO2Yh2bGAkXUVo3hqaXFuemqxYV5quV5xYm5xaV66XnJ+7iZGYMo7/e/4px2Mc1991DvE
	yMTBeIhRgoNZSYTX0dslVYg3JbGyKrUoP76oNCe1+BCjNAeLkjivaop8qpBAemJJanZqakFq
	EUyWiYNTqoFJe/1Fy0W1vvNvn9m0sGwBX8O6OKlXSb+bhBRXbS+r/nhon/n38A1qr2PWCq1w
	eZuqWvJZVkc5+YTPWhuJW29FvPzu5ZWuUZ/7mn8Jr9wRjYfFfZpF7y8d61ycv1xqwS82xlVz
	jncdVwnd28jsLML86kjEG8t/ouK1z2P1RduT7Hu8czIPHV/049J81uW+HaumKMYkLryRa5hl
	XRY2WTX7Zvz6M/6X1/1o6blpXft3Y07ywstBt1bf+v00jvlIzIJ1c580/5K2O+Gw+XBbtoCu
	3by/b489++N7XzzMb4pkRY7AlLNp0Ukv2kzTbY0Odl5TK4z89vTJrh3FJrPbPl2Rtd21s8N5
	55sfMV3MPB5cSizFGYmGWsxFxYkAjGb8Z+gDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPKsWRmVeSWpSXmKPExsVy+t/xe7rVda6pBj1ztCzmrF/DZrH6bj+b
	xeUnfBZPP/WxWOy9pW2xZ+9JFovLu+awWdxb85/VYtefHewWNyY8ZbRY9vU9u8XujYvYLH7/
	mMPmwOsxu+Eii8eCTaUem1doeVw+W+qxaVUnm8emT5PYPU7M+M3i8XmTXABHlJ5NUX5pSapC
	Rn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7G5qO7GQvO8lTs6zjO
	2MC4kquLkZNDQsBE4vmlPsYuRi4OIYGljBInzsxjhEjISGz8cpUVwhaW+HOtiw2i6COjxPPJ
	21kgnNOMErP/XYPKrGCU6J/+kR2khU1AU2LfyU1ANgeHiICGxJstRiA1zAJHWSWWrN3EAlIj
	LGArsX7rHGYQW0TATuLhrZfsELaVxKsv18FqWARUJF5s/wlWwytgKjFn2mJ2iGVzmSTu/V4D
	luAEemLp9k9MIDajgKzEo5W/wAYxC4hL3HoynwniBwGJJXvOM0PYohIvH/+D+k1H4uz1J1A/
	G0hsXbqPBcJWkvjTsZARYo6OxILdn9ggbEuJhpOfoeLaEssWvoY6TlDi5MwnLBMYZWYhWT0L
	SfssJO2zkLTPQtK+gJF1FaNIamlxbnpusaFecWJucWleul5yfu4mRmBK23bs5+YdjPNefdQ7
	xMjEwXiIUYKDWUmE19HbJVWINyWxsiq1KD++qDQntfgQoykw8CYyS4km5wOTal5JvKGZgamh
	iZmlgamlmbGSOK9nQUeikEB6YklqdmpqQWoRTB8TB6dUA1O6tFrHju1ue1rd91ewfJFm2DIr
	SUL3Qctk7RUJ995WNb3ewfrr8O1eg/pEftWEjzqnNzUb3lVbJGAoeVv4yimVgs+tZWVb/299
	uZVhIvOnDse8ZGmfZRMDG0PzL8+M0d9+89ix+SzvGUqjmK6efXHmynkP2XkCW97HBDh2Seuf
	cv9o9Tn2/6xnZ5/X/Jv2Rscq+U2b4ZHlCxy3as/2MZp5V+HGXVMedpvPujeUilremL5k/HBH
	aYbB/ijmMw6zI61Y3IMqWe5Gsr2M2sJQnXjEvGF52AG7Nyfs3ef9NeXdvG1DduusvZ2sUtfj
	75Z6frBnenpb7Emiwdsz7Rb9J3st3v5b/jC7O2uZFrPo70dKLMUZiYZazEXFiQChzl1/8gMA
	AA==
X-CMS-MailID: 20231103231259eucas1p18e529693e4b47b5e0623271bf319a25f
X-Msg-Generator: CA
X-RootMTR: 20231028211538eucas1p186e33f92dbea7030f14f7f79aa1b8d54
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231028211538eucas1p186e33f92dbea7030f14f7f79aa1b8d54
References: <20230919135536.2165715-1-da.gomez@samsung.com>
	<20231028211518.3424020-1-da.gomez@samsung.com>
	<CGME20231028211538eucas1p186e33f92dbea7030f14f7f79aa1b8d54@eucas1p1.samsung.com>
	<20231028211518.3424020-2-da.gomez@samsung.com>
	<ZT68dBiJKNLXLRZA@casper.infradead.org>

On Sun, Oct 29, 2023 at 08:11:32PM +0000, Matthew Wilcox wrote:
> On Sat, Oct 28, 2023 at 09:15:35PM +0000, Daniel Gomez wrote:
> > +static noinline void check_cmpxchg_order(struct xarray *xa)
> > +{
> > +	void *FIVE =3D xa_mk_value(5);
> > +	unsigned int order =3D IS_ENABLED(CONFIG_XARRAY_MULTI) ? 15 : 1;
>
> ... have you tried this with CONFIG_XARRAY_MULTI deselected?
> I suspect it will BUG() because orders greater than 0 are not allowed.
>
> > +	XA_BUG_ON(xa, !xa_empty(xa));
> > +	XA_BUG_ON(xa, xa_store_index(xa, 5, GFP_KERNEL) !=3D NULL);
> > +	XA_BUG_ON(xa, xa_insert(xa, 5, FIVE, GFP_KERNEL) !=3D -EBUSY);
> > +	XA_BUG_ON(xa, xa_store_order(xa, 5, order, FIVE, GFP_KERNEL));
> > +	XA_BUG_ON(xa, xa_get_order(xa, 5) !=3D order);
> > +	XA_BUG_ON(xa, xa_get_order(xa, xa_to_value(FIVE)) !=3D order);
> > +	old =3D xa_cmpxchg(xa, 5, FIVE, NULL, GFP_KERNEL);
> > +	XA_BUG_ON(xa, old !=3D FIVE);
> > +	XA_BUG_ON(xa, xa_get_order(xa, 5) !=3D 0);
> > +	XA_BUG_ON(xa, xa_get_order(xa, xa_to_value(FIVE)) !=3D 0);
> > +	XA_BUG_ON(xa, xa_get_order(xa, xa_to_value(old)) !=3D 0);
> > +	XA_BUG_ON(xa, !xa_empty(xa));
>
> I'm not sure this is a great test.  It definitely does do what you claim
> it will, but for example, it's possible that we might keep that
> information for other orders.  So maybe we should have another entry at
> (1 << order) that keeps the node around and could theoretically keep
> the order information around for the now-NULL entry?

Thanks Matthew for the review. I'm sending a separate patch with the
fixes and improvements on the XArray cmpxchg test.=

