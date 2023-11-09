Return-Path: <linux-fsdevel+bounces-2538-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E877E6D78
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 16:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F4E21C209EB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 15:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3F02031E;
	Thu,  9 Nov 2023 15:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I+7dxyoh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22B22031D
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 15:34:30 +0000 (UTC)
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355A935AB
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 07:34:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1699544067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fh5FxdhqxyPMFvq7DwpOb62I2S3xPmOM/5undUGaLs8=;
	b=I+7dxyohR20zDvsdodZRebLKR6MvQj2wWNnaWNN2hCEoIGx9P+RBWSSqNJhXagEizarlYt
	SABIRD5ZWbmiZL5h5Dg6c65s7yNoaa//gElgYzkpQmu36bT73cAsC2bjZ7ZF2eEnB6cfU4
	Io5I2qjGy4YR/De6h5wz7vEU8y8CgV8=
Date: Thu, 09 Nov 2023 15:34:25 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: jeff.xie@linux.dev
Message-ID: <58b99c29425dd61130f04b41be14e3609daf5a91@linux.dev>
TLS-Required: No
Subject: Re: [RFC][PATCH 2/4] mm, slub: implement slub allocate post callback
 for page_owner
To: "Matthew Wilcox" <willy@infradead.org>
Cc: akpm@linux-foundation.org, iamjoonsoo.kim@lge.com, vbabka@suse.cz,
 cl@linux.com, penberg@kernel.org, rientjes@google.com,
 roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 chensong_2000@189.cn, xiehuan09@gmail.com
In-Reply-To: <ZUznNn42H5vRUF0r@casper.infradead.org>
References: <ZUznNn42H5vRUF0r@casper.infradead.org>
 <20231109032521.392217-1-jeff.xie@linux.dev>
 <20231109032521.392217-3-jeff.xie@linux.dev>
X-Migadu-Flow: FLOW_OUT

November 9, 2023 at 10:05 PM, "Matthew Wilcox" <willy@infradead.org> wrot=
e:


>=20
>=20On Thu, Nov 09, 2023 at 11:25:19AM +0800, Jeff Xie wrote:
>=20
>=20>=20
>=20> +#ifdef CONFIG_PAGE_OWNER
> >  +static int slab_alloc_post_page_owner(struct folio *folio, struct t=
ask_struct *tsk,
> >  + void *data, char *kbuf, size_t count)
> >  +{
> >  + int ret;
> >  + struct kmem_cache *kmem_cache =3D data;
> >  +
> >  + ret =3D scnprintf(kbuf, count, "SLAB_PAGE slab_name:%s\n", kmem_ca=
che->name);
> >  +
> >  + return ret;
> >  +}
> >  +#endif
> >=20
>=20
> Or we could do this typesafely ...
>=20
>=20 struct slab *slab =3D folio_slab(folio);
>  struct kmem_cache *kmem_cache =3D slab->slab_cache;
>=20
>=20... and then there's no need to pass in a 'data' to the function.
>

I accidentally replied using my other email (xiehuan09@gmail.com) just no=
w.=20
Thank=20you for your advice. Indeed, the "data" didn't serve any purpose =
here.

--
Jeff Xie

