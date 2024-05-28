Return-Path: <linux-fsdevel+bounces-20357-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3678D206C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 17:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F4D01C231EB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 15:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B918617083A;
	Tue, 28 May 2024 15:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BpU9rBQA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22D413AD3E
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 May 2024 15:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716910352; cv=none; b=ssP+44qwcU9o51RlAfKjCl7YlVaIn/oS1QCyjg8TufDd8VJoYCGX4Th7hXMa2fvrNsNDYUniQiu+Wq+QIgecFoPuaVcX/Bq90lSd2S7hYz0QHa4ErCPd8IDgTdIwC+By037+oOEeI63YZrJSlvjnaoKjRsZjpJ0TebidPNKstAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716910352; c=relaxed/simple;
	bh=UFjeiiyRTSAPlP8Z30egdkFCfIOQ0fe61d9r1nNQaFg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version:References; b=UNnXwpSq6fS9ZVshXjIf+4jOBYB6gzlyQE6/oqBuZZkITQmWL7vhIv12X8IwE2wkfZkW54fqHR55h2twv1n31YrtYE7sNdpxDr3ZeGbUQ3wsZGQid5u8cKSaqBVEt/ndX7EY1baRzSmWdYCfHzqpMgkKipduB50NUYITYVVwaFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=BpU9rBQA; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240528152341euoutp023ca443f8de06c1786b8a0f7fad508800~TsGLMgbzA1957719577euoutp02c
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 May 2024 15:23:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240528152341euoutp023ca443f8de06c1786b8a0f7fad508800~TsGLMgbzA1957719577euoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1716909821;
	bh=GOWqkzE625zVzrnr6gmTlsOXEK4aCs/rT+AEKWG310g=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=BpU9rBQAZSopP8JeqB5tAGzaeqwwouk28CrXUFcJ5qSsYOpjZsccOb04iQAFUwFkK
	 qdXpom2sjsNySxeJHjKusJWogghHsIRtm/nbzZ81E36ajBgTEHSGH6/dbpT/S+5Zzf
	 JLIyk1omEXUDijz55E/ppZO8xY2aV3uwJW+c2hFw=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240528152341eucas1p1793aa45fad26502f9c59613851676eeb~TsGK_Kbzo0199301993eucas1p18;
	Tue, 28 May 2024 15:23:41 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id CA.7B.09620.CF6F5566; Tue, 28
	May 2024 16:23:40 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240528152340eucas1p17ba2ad78d8ea869ef44cdeedb2601f80~TsGKoDAch2284122841eucas1p1O;
	Tue, 28 May 2024 15:23:40 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240528152340eusmtrp15b70716387565ba854fb3c6ae924b78d~TsGKnMI-e0935709357eusmtrp1j;
	Tue, 28 May 2024 15:23:40 +0000 (GMT)
X-AuditID: cbfec7f5-d1bff70000002594-51-6655f6fc4e64
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 42.D3.09010.CF6F5566; Tue, 28
	May 2024 16:23:40 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240528152340eusmtip276fdf57e16a6609cb6a99cfd1f444501~TsGKdhPNK2079320793eusmtip2b;
	Tue, 28 May 2024 15:23:40 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) by
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
	Server (TLS) id 15.0.1497.2; Tue, 28 May 2024 16:23:40 +0100
Received: from CAMSVWEXC01.scsc.local ([::1]) by CAMSVWEXC01.scsc.local
	([fe80::7d73:5123:34e0:4f73%13]) with mapi id 15.00.1497.012; Tue, 28 May
	2024 16:23:40 +0100
From: Daniel Gomez <da.gomez@samsung.com>
To: Christoph Hellwig <hch@lst.de>
CC: Trond Myklebust <trond.myklebust@hammerspace.com>, Anna Schumaker
	<anna@kernel.org>, Matthew Wilcox <willy@infradead.org>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 1/2] filemap: Convert generic_perform_write() to support
 large folios
Thread-Topic: [PATCH 1/2] filemap: Convert generic_perform_write() to
	support large folios
Thread-Index: AQHasRMEv8C0Tteo9UiuY4wdfWDY+A==
Date: Tue, 28 May 2024 15:23:39 +0000
Message-ID: <gh7wdpeqorbtvbywigkzy3fakb7a4e46y6h6nrusn6rmup6yfm@2rjq4ltwmdq4>
In-Reply-To: <20240527163616.1135968-2-hch@lst.de>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5CDE07DF0F56364FAE2F6E98A8927FE5@scsc.local>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA02SaUwTURSFfTPTmQGtGcp23bUGF8QKiloT4oqmGoySuGOUkQ5LhEI64hoN
	xi0gMYgapKJlrVBF0yrKrlalElfihkQlYpXFDUFRlrQyjJr++947955z78ujcVmxZDgdo9nG
	aTVsrJx0Ja7VdD+e2te1OtJf1xikPFTmIJRFF+5iysqqWkL59qJDonxy875E6aifp+z9nUXO
	p1R9FhOlulLoqzIbk0mVuSOdUlW8SiJVnebRK8kNrkFqLjZmO6edNjfcNbrTZqMS6kbtPHZy
	XRI65p2CaBqYQNA1kCnIlZYxhQhaU6/jKcil//ADQcHZ2aLQiSD9h0MiCEJDSd17TBTOI3Cc
	KiX/V+X2PJeI7Q8QZH0EUShC8Ky5ChMEkpkM1bVmSmAPRg4f2h4igXHGiEGK1V1gdyYM+izv
	SLFmI9jzTYTICrjcYh2oJxgf0OtPkMIOUmY5vDImCNcuzHTILs8aaEXMKGgq6qFEe29osOkx
	cQM3yD1TiYvsBfZyMQoYP3j40oZE9oeSgmpC5PHQkv9aIvr4QXZFBynyHDB2VvwdfwoYcj4N
	eEr7/WszbYSwOzANLqA73U6JRsFgqLH+fUZ3aLNepdKQn85pPp1Ths4pQ+eUoXPKyEYSI/Lm
	Evm4KI6foeF2KHg2jk/URCki4uPMqP9H3bdbf5aiwrbvCgvCaGRBQONyD+mD9NWRMqma3bWb
	08Zv1ibGcrwFjaAJubfURz2GkzFR7DZuK8clcNp/Kka7DE/CpNc/L32R6ManlXrUzZB5lq3J
	zdnfPjIgm1T4BrGtuH7ShYD67oY3j0oM8rWhaXcVfKamTBvvaDRsXFYT4nneVHnuSL2lS48f
	fdp+awHWq2qcGf7tSeDLPK3fta6zTYc9vyy5t3AWlqfsbqpL7Vtf0IjHTlBvCWPDVp1J7d2X
	mTENWm9v3xQROknjFVl5qbkUMiIO7dn37mBTRaj790Gwt/h3XvhxDVZla8mvNr2Nz2GSx03x
	L/RQb817XcvfSG8lv4x9f2fPIBQek2y0+wSaFg8JnkVuuDEiejFluCQb9mLw1xWL0ljHFUX5
	umKZ/6nmjF+fe4baew+0ex0OOVAwsWOHnOCj2QBfXMuzfwAs45+zwAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOKsWRmVeSWpSXmKPExsVy+t/xe7p/voWmGSy+qWHRuvM/i8XK1UeZ
	LPbsPclicW/Nf1aLCwdOs1r8v2Fv8fvHHDYHdo8/hzaye2xeoeWxaVUnm8emT5PYPXbfbGDz
	+LxJLoAtSs+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8u
	QS/j85Mn7AUXZSv6pkQ0MPaJdzFyckgImEhsvfiYqYuRi0NIYCmjxKrtf5ggEjISG79cZYWw
	hSX+XOtigyj6yChx7uI5dgjnDKPEvXVHGSGclYwSXdvnMoK0sAloSuw7uYkdxBYRUJJ4+uos
	WJxZYBWTRNdxYRBbWCBa4s+hh2wQNTESx7ZPZYaw9STWvzgOVs8ioCoxf/5koBoODl4BX4mb
	qwpAwkICkRLTdnWDlXAKGEks2DUHbAyjgKzEo5W/2CFWiUvcejIf6hsBiSV7zjND2KISLx//
	g/pMR+Ls9SeMELaBxNal+1ggbGWJF0vusELM0ZFYsPsTG4RtKbHq826oV7Qlli18DTaTV0BQ
	4uTMJywTGGVmIVk9C0n7LCTts5C0z0LSvoCRdRWjSGppcW56brGRXnFibnFpXrpecn7uJkZg
	Ctp27OeWHYwrX33UO8TIxMF4iFGCg1lJhPfMpNA0Id6UxMqq1KL8+KLSnNTiQ4ymwKCbyCwl
	mpwPTIJ5JfGGZgamhiZmlgamlmbGSuK8ngUdiUIC6YklqdmpqQWpRTB9TBycUg1McvMlLHdu
	fDffftnxg/auR+evOP0i57/32taedGeh7/MdDx5I+RW4ZWHsluR/Qq9P+WxoqIybkvnU5L+q
	2aqu62ZOYZ61oX53Gp5JRnYsE6rNW3Ax4eU6Ls5CZt6NDXPObCltk5axSX8SUXD/kczzp/Xr
	hb65lj+O+rWsTmxP+iN3Zn6BibatxjO3HZ3NoyoV/zbBPc3mzSn9U1Ebj0zcvGX3dxZ2DvsA
	0zOLfPhnMymlc6585cviVToz76t+48ntx4WzuPQ8KlZ4xKicNBNfGbDioFsKg3tXaWPQbd3T
	bqvSPf8ENtk843h3XHWCi6CM1PO09T82rty5zWPmmY5L+3z3HzSqWHdt77bEQ4qTlViKMxIN
	tZiLihMB+xD6ocoDAAA=
X-CMS-MailID: 20240528152340eucas1p17ba2ad78d8ea869ef44cdeedb2601f80
X-Msg-Generator: CA
X-RootMTR: 20240528152340eucas1p17ba2ad78d8ea869ef44cdeedb2601f80
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240528152340eucas1p17ba2ad78d8ea869ef44cdeedb2601f80
References: <20240527163616.1135968-1-hch@lst.de>
	<20240527163616.1135968-2-hch@lst.de>
	<CGME20240528152340eucas1p17ba2ad78d8ea869ef44cdeedb2601f80@eucas1p1.samsung.com>

Hi Christoph, Matthew,
On Mon, May 27, 2024 at 06:36:08PM +0200, Christoph Hellwig wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
>=20
> Modelled after the loop in iomap_write_iter(), copy larger chunks from
> userspace if the filesystem has created large folios.
>=20
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> [hch: use mapping_max_folio_size to keep supporting file systems that do
>  not support large folios]
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  mm/filemap.c | 40 +++++++++++++++++++++++++---------------
>  1 file changed, 25 insertions(+), 15 deletions(-)
>=20
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 382c3d06bfb10c..860728e26ccf32 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3981,21 +3981,24 @@ ssize_t generic_perform_write(struct kiocb *iocb,=
 struct iov_iter *i)
>  	loff_t pos =3D iocb->ki_pos;
>  	struct address_space *mapping =3D file->f_mapping;
>  	const struct address_space_operations *a_ops =3D mapping->a_ops;
> +	size_t chunk =3D mapping_max_folio_size(mapping);
>  	long status =3D 0;
>  	ssize_t written =3D 0;
> =20
>  	do {
>  		struct page *page;
> -		unsigned long offset;	/* Offset into pagecache page */
> -		unsigned long bytes;	/* Bytes to write to page */
> +		struct folio *folio;
> +		size_t offset;		/* Offset into folio */
> +		size_t bytes;		/* Bytes to write to folio */
>  		size_t copied;		/* Bytes copied from user */
>  		void *fsdata =3D NULL;
> =20
> -		offset =3D (pos & (PAGE_SIZE - 1));
> -		bytes =3D min_t(unsigned long, PAGE_SIZE - offset,
> -						iov_iter_count(i));
> +		bytes =3D iov_iter_count(i);
> +retry:
> +		offset =3D pos & (chunk - 1);
> +		bytes =3D min(chunk - offset, bytes);
> +		balance_dirty_pages_ratelimited(mapping);
> =20
> -again:
>  		/*
>  		 * Bring in the user page that we will copy from _first_.
>  		 * Otherwise there's a nasty deadlock on copying from the
> @@ -4017,11 +4020,16 @@ ssize_t generic_perform_write(struct kiocb *iocb,=
 struct iov_iter *i)
>  		if (unlikely(status < 0))
>  			break;
> =20
> +		folio =3D page_folio(page);
> +		offset =3D offset_in_folio(folio, pos);
> +		if (bytes > folio_size(folio) - offset)
> +			bytes =3D folio_size(folio) - offset;
> +
>  		if (mapping_writably_mapped(mapping))
> -			flush_dcache_page(page);
> +			flush_dcache_folio(folio);
> =20
> -		copied =3D copy_page_from_iter_atomic(page, offset, bytes, i);
> -		flush_dcache_page(page);
> +		copied =3D copy_folio_from_iter_atomic(folio, offset, bytes, i);
> +		flush_dcache_folio(folio);
> =20
>  		status =3D a_ops->write_end(file, mapping, pos, bytes, copied,
>  						page, fsdata);

I have the same patch for shmem and large folios tree. That was the last pi=
ece
needed for getting better performance results. However, it is also needed t=
o
support folios in the write_begin() and write_end() callbacks. In order to =
avoid
making them local to shmem, how should we do the transition to folios in th=
ese
2 callbacks? I was looking into aops->read_folio approach but what do you t=
hink?

> @@ -4039,14 +4047,16 @@ ssize_t generic_perform_write(struct kiocb *iocb,=
 struct iov_iter *i)
>  			 * halfway through, might be a race with munmap,
>  			 * might be severe memory pressure.
>  			 */
> -			if (copied)
> +			if (chunk > PAGE_SIZE)
> +				chunk /=3D 2;
> +			if (copied) {
>  				bytes =3D copied;
> -			goto again;
> +				goto retry;
> +			}
> +		} else {
> +			pos +=3D status;
> +			written +=3D status;
>  		}
> -		pos +=3D status;
> -		written +=3D status;
> -
> -		balance_dirty_pages_ratelimited(mapping);
>  	} while (iov_iter_count(i));
> =20
>  	if (!written)
> --=20
> 2.43.0
>=20

Daniel=

