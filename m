Return-Path: <linux-fsdevel+bounces-20369-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BAD8D23A5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 21:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 749E81C22F1A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 19:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B8116FF4F;
	Tue, 28 May 2024 19:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ttWKuENY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4122E400
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 May 2024 19:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716922912; cv=none; b=ivN4AarvosKBRFtblf8wnvKEyMBIbXJOEBfiQIN6pFTHRhBdm0ZBbTb3WmBeRHHp7EwLPusdupPgfP238as+yNI+fsbmBybwUp8LlP9mQIaEM/c7BtG2xQ2eb32jCb4tCR6g4NXPGFVhrI0djyEJzgASZbi2rRrPyJC6dQesK6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716922912; c=relaxed/simple;
	bh=szsGN+n4B4xKlfhfk5iJPwEe9R8vejDxpsv0h4Nf7oU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version:References; b=DiwOmYuxcvkxDr+GIZU0TYpJq+Zs1cHJ19BJGONdGjFkpJMNqLBIK2RHXiRjAUfAb6iMlPGgB+uEDBedoGRmhWeGROHgS0yS2XDN2tJ033/QVK7gKx/8xIm8zTiYvcxMpa4Po6dTWli6U/tosqMd/8ZdcVj42b6kwPo8wtLnsDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ttWKuENY; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240528190147euoutp02a2bf2f2138186d1fb55ddef49bbed705~TvEmh0wvC0823508235euoutp02T
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 May 2024 19:01:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240528190147euoutp02a2bf2f2138186d1fb55ddef49bbed705~TvEmh0wvC0823508235euoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1716922907;
	bh=HoBAqzCYnFZWUFCnY9A1juVwqBBHmfP+U4Tja7baPBM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=ttWKuENYwmCb0DgUfiqwHZ94nEfyl+MY6nkZ+dzYylzJ3U/4vTcfVzKPEAexDaIXS
	 WNZXgCLBrMqgfV3IDxB/4GGO3OI7ue9uprm+GKCuodGt61zEjhpIok7nOPSVInfreE
	 piRnJvzQC4D80NKg6Zikvn4XN2b/2v4WqhsH8Seo=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240528190146eucas1p2299f2e87c3ab0067b02c0a9a943d9f56~TvElcyrX11587915879eucas1p2a;
	Tue, 28 May 2024 19:01:46 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id E6.06.09624.A1A26566; Tue, 28
	May 2024 20:01:46 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240528190145eucas1p1481c99394a28dc2ce06adb60f411b73d~TvElEqUqg2782127821eucas1p13;
	Tue, 28 May 2024 19:01:45 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240528190145eusmtrp2ead789bc1e8f3770264c3bfa9898812a~TvElEMaIP0986809868eusmtrp2U;
	Tue, 28 May 2024 19:01:45 +0000 (GMT)
X-AuditID: cbfec7f2-bfbff70000002598-e6-66562a1a5574
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id B4.22.08810.91A26566; Tue, 28
	May 2024 20:01:45 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240528190145eusmtip2b1c04cf777bbc989ac9b037d53b9c4e0~TvEkwDrWx0757207572eusmtip20;
	Tue, 28 May 2024 19:01:45 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) by
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
	Server (TLS) id 15.0.1497.2; Tue, 28 May 2024 20:01:44 +0100
Received: from CAMSVWEXC01.scsc.local ([::1]) by CAMSVWEXC01.scsc.local
	([fe80::7d73:5123:34e0:4f73%13]) with mapi id 15.00.1497.012; Tue, 28 May
	2024 20:01:44 +0100
From: Daniel Gomez <da.gomez@samsung.com>
To: Matthew Wilcox <willy@infradead.org>
CC: Christoph Hellwig <hch@lst.de>, Trond Myklebust
	<trond.myklebust@hammerspace.com>, Anna Schumaker <anna@kernel.org>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 1/2] filemap: Convert generic_perform_write() to support
 large folios
Thread-Topic: [PATCH 1/2] filemap: Convert generic_perform_write() to
	support large folios
Thread-Index: AQHasRMEv8C0Tteo9UiuY4wdfWDY+LGsy3MAgAAklwA=
Date: Tue, 28 May 2024 19:01:43 +0000
Message-ID: <t3dcn6yduaje2n4jhy3ru74bwy6e3jfpllws2w7rpmmxl2d4vy@5thpd63k5gc5>
In-Reply-To: <ZlYLZDG_D74AtW5M@casper.infradead.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B06AAF4A7A624749867E4EAD7E55F679@scsc.local>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA02SaUwTURSF8zpLpzXVoaC9YpBYlyhCxSVaF8QfRuuORk1cEm1kCihUM6W4
	olUjKBqExgWqSEEsAoZgBdOqoFZREVzjAiguWIyCmMqigEJlGEj677v33HvPecmjMGkh4UtF
	aWMZVquOlpNi/PqDzmdBvgFrNcF3LYTyiN2NK/MKygXKW6UVuPLDFTehfH6nklC6q0OVfzvO
	k/OEqn+Oq0LVtcsBKmv+MVJlbTEKVTdrDKSq1ToyjFwvnhPOREfFMeykuZvFkY8aHMIdOeJd
	pw+/Iw0olUpCIgroaXAq5bggCYkpKX0ZQXepDeOLNgQNz22IL1oR2E48JQZWLpQWEbyQi6A1
	/TvGCX1TqR/ieK5CcH7gbh4CY24L4gSSngBlFVZhEqIoH3o8/Ciews1gdI4APjbUk9yMN70B
	/jk+97EPvRF6cq7iPM+CpsYyktvF6bGQ3KHm2hJ6GbyxlPe1Rb3hEg0s10a0H9TndQk5xmgZ
	1DozBXx+L8g+dwvjeRj03OCdgA6EJ2+diOdgKLlUhvM8Gr7lvCf4O4FgvtlC8jwTnhQ0C3ie
	CJasJoyP4wUV6U6cexbQ9SK4fvB0v8F8sBov9rM3ND4sFqagQJNHPpOHh8nDw+ThYfLwMCMi
	H8kYvS4mgtFN1jI7FTp1jE6vjVBs2R5jRb1fqrLnYYsNZTT+UjiQgEIOBBQm95FUGddopJJw
	9e49DLt9E6uPZnQONILC5TLJ2HB/RkpHqGOZbQyzg2EHVAEl8jUIMuWsvrq+eV2HX23i/TTX
	ScXhonLj3q8Tc4ce3Z1l3JdgXc24Fi2dG1aS4Fqj0Za0ddV1nijLeFyTvFijcfv6v2DzPoXV
	iJ9OPyQMIRbag1tFrmcHCgsDLDL7q6Abo15erAuy6rfNaD+zbmFDl+Vk7RBn2Jmp0h/Dj1WZ
	g/+62jfaGsm7ivjAQ1l2x/3383elxb+VOZd7Jcnz65b8+S0pnrJ12ewX8V/GfZZ5h17o1mVL
	QzS2fKYpO9Xs99ESvspJ1Q4Kaq+OPXv79dLxhkr/EM21A35xePOm5Snxdmm2PLRowejB5e6a
	lfdeZuw3p6zKNUiWrPg5prNkhmNoQXdyZtydNjmui1RPDsBYnfo/2KHx4MEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOKsWRmVeSWpSXmKPExsVy+t/xe7qSWmFpBn8naFm07vzPYrFy9VEm
	iz17T7JY3Fvzn9XiwoHTrBb/b9hb/P4xh82B3ePPoY3sHptXaHlsWtXJ5rHp0yR2j903G9g8
	Pm+SC2CL0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL
	0Ms48fQQe8ESroqpzbfZGhgncnQxcnJICJhIzNu7gbWLkYtDSGApo8S+ng1sEAkZiY1frrJC
	2MISf651gcWFBD4ySnz9JQnRcIZRYs6u50wQzkpGifdLN4FVsQloSuw7uYm9i5GDQ0RAQ+LN
	FiOQGmaBJUwS958+AqsRFoiW+HPoIZgtIhAjcWz7VGYI20ri9at9bCC9LAKqEn0/EkHCvAK+
	EteWHWWD2DWbSaJr6zVWkBpOoBfaG4pAahgFZCUerfzFDmIzC4hL3HoynwniAQGJJXvOM0PY
	ohIvH/+DekxH4uz1J4wQtoHE1qX7WCBsZYkXS+6wQszRkViw+xMbhG0pcXb1WyYIW1ti2cLX
	zBC3CUqcnPmEZQKjzCwkq2chaZ+FpH0WkvZZSNoXMLKuYhRJLS3OTc8tNtQrTswtLs1L10vO
	z93ECExB24793LyDcd6rj3qHGJk4GA8xSnAwK4nwnpkUmibEm5JYWZValB9fVJqTWnyI0RQY
	dBOZpUST84FJMK8k3tDMwNTQxMzSwNTSzFhJnNezoCNRSCA9sSQ1OzW1ILUIpo+Jg1OqgSm6
	UcjgmGn3cpfPZWtPJhp2HROY+zCExWxq36zeFzO6zGM6Tx7u8SzaPuXhr6dukQ/Ni4/N4jm1
	Ov/ZzEiWlh93N+33mrqOSeK8ccb1fXvNmcPvW1b0rWx7saAqJ1flx4SwCs8aleyFH0L27Cmy
	D9ZyZnoSvm2ZeqLqid91xYvmmy9/pnpX627Ub9VzlSp35Gesinb4HRBnd8Lt/yXNN+UKhb9/
	5H6QE/m8qao5ec/O799/PtlY9nplYVpx6BVOr3n8xUY90ZIvVYRl1SK1j17U1GJIkrov4TdZ
	8xrTQavdBzXrAi8v+R9nMG2zwuO0PRbR70WMLBiVGt215+8/47y68MfG61kCi8+mKG+/nqfE
	UpyRaKjFXFScCADgEUOcygMAAA==
X-CMS-MailID: 20240528190145eucas1p1481c99394a28dc2ce06adb60f411b73d
X-Msg-Generator: CA
X-RootMTR: 20240528152340eucas1p17ba2ad78d8ea869ef44cdeedb2601f80
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240528152340eucas1p17ba2ad78d8ea869ef44cdeedb2601f80
References: <20240527163616.1135968-1-hch@lst.de>
	<20240527163616.1135968-2-hch@lst.de>
	<CGME20240528152340eucas1p17ba2ad78d8ea869ef44cdeedb2601f80@eucas1p1.samsung.com>
	<gh7wdpeqorbtvbywigkzy3fakb7a4e46y6h6nrusn6rmup6yfm@2rjq4ltwmdq4>
	<ZlYLZDG_D74AtW5M@casper.infradead.org>

On Tue, May 28, 2024 at 05:50:44PM +0100, Matthew Wilcox wrote:
> On Tue, May 28, 2024 at 03:23:39PM +0000, Daniel Gomez wrote:
> > I have the same patch for shmem and large folios tree. That was the las=
t piece
> > needed for getting better performance results. However, it is also need=
ed to
> > support folios in the write_begin() and write_end() callbacks.
>=20
> I don't think it's *needed*.  It's nice!  But clearly not necessary
> since Christoph made nfs work without doing that.

I see. We send anyway the length with bytes and the folio allocated inside
write_begin() is retrieved with folio_page().

I did test this patch (+mapping_max_folio_size() patch) for shmem an it wor=
ks fine for me.
>=20
> > In order to avoid
> > making them local to shmem, how should we do the transition to folios i=
n these
> > 2 callbacks? I was looking into aops->read_folio approach but what do y=
ou think?
>=20
> See the v2 of buffer_write_operations that I just posted.  I was waiting
> for feedback from Christoph on the revised method for passing fsdata
> around, but I may as well just post a v2 and see what happens.

Interesting. I think it makes sense to convert tmpfs to
buffered_write_operations as well. Can you add me to the v2 so I can add/re=
view
it for tmpfs?

Thanks=

