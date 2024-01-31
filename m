Return-Path: <linux-fsdevel+bounces-9661-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB853844267
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 16:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45A981F2E253
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 15:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DC212C520;
	Wed, 31 Jan 2024 14:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="F/ReZtMc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC44D12BEA8
	for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jan 2024 14:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706712781; cv=none; b=eo3tIW5aeuRvXth4D2gi8DSriMYwuU8RcS5K7SaLpLqTHgyoOxl5ESl/B1aJv3/XgldBdq6zb5NVqMcsbzqpSiWS9cxqKPAn7oIr9QfUKpTgkbj57WLo4gv9I9l/REGgvGdC4TgwpalBZPT4rro+COBLXGlcNXbnEDo0b2F4SUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706712781; c=relaxed/simple;
	bh=uft1gHtDLKyBo69IKEW/L8x3RRPAj48+yRmpIelI21M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=HBD/NhHYu+vKFqjuyN6TUt6kB5ur07ahgGpNtCI7mSW7/u329CyMyiXK9AahjpTEt7s+wUCwNzxAX8rZwUp867pp/kt+s3YJQCyZvF5GL5ayHVZ5+YbiPRpV8oZIQ3uUSHdUq1dRGwshqVEKDBzg5PtuEnvbaFY8hQqUgvnSQ50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=F/ReZtMc; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240131145257epoutp0290b363bc57f2ba30b594b66a4cbdfdf4~vdjpoIR8A0581005810epoutp02v
	for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jan 2024 14:52:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240131145257epoutp0290b363bc57f2ba30b594b66a4cbdfdf4~vdjpoIR8A0581005810epoutp02v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1706712777;
	bh=uft1gHtDLKyBo69IKEW/L8x3RRPAj48+yRmpIelI21M=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=F/ReZtMczVNOJaFAUDFM2BbWG15gxX20Jc/5VBp+/WaanQOD/eZD01+lCCP2kpZZm
	 NMI9jLzfKncBBOVyYKmab9GrsGLLUdQW+bUGQJNnTpXTKSppwvk9JYBk7Epw+iX0aY
	 Kh+P8SxkcvZyDiosQpRGmK2z6uryfrVUh+HYcgKc=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240131145255epcas5p3e577d500208576ec72e9d8cbbeb2169b~vdjoUgYWz0387003870epcas5p3Y;
	Wed, 31 Jan 2024 14:52:55 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4TQ4lR5pL1z4x9Ps; Wed, 31 Jan
	2024 14:52:51 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	64.A7.19369.3CE5AB56; Wed, 31 Jan 2024 23:52:51 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240131145251epcas5p15549659a7889b43e7f6481d3e3cbdf44~vdjkbYzq80791207912epcas5p1J;
	Wed, 31 Jan 2024 14:52:51 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240131145251epsmtrp1651e758391488a112781c8602f44c557~vdjkalp5v1177711777epsmtrp1E;
	Wed, 31 Jan 2024 14:52:51 +0000 (GMT)
X-AuditID: b6c32a50-c99ff70000004ba9-b0-65ba5ec3d994
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	79.37.08817.3CE5AB56; Wed, 31 Jan 2024 23:52:51 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240131145249epsmtip20048d43c9125fbb488a1827a31ae2cec~vdjij0grJ0592005920epsmtip2V;
	Wed, 31 Jan 2024 14:52:49 +0000 (GMT)
Message-ID: <95c99572-3237-a549-3ee5-f1cb3742101d@samsung.com>
Date: Wed, 31 Jan 2024 20:22:48 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH v9 03/19] fs: Split fcntl_rw_hint()
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>, "Martin K . Petersen"
	<martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, Christoph
	Hellwig <hch@lst.de>, Daejun Park <daejun7.park@samsung.com>, Jeff Layton
	<jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, Stephen Rothwell
	<sfr@canb.auug.org.au>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
	Brauner <brauner@kernel.org>
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20240130214911.1863909-4-bvanassche@acm.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBJsWRmVeSWpSXmKPExsWy7bCmuu7huF2pBj836FqsvtvPZvH68CdG
	i2kffjJb/L/7nMli1YNwi5WrjzJZ/Fy2it1i7y1tiz17T7JYdF/fwWax/Pg/Joute6+yW5z/
	e5zVgdfj8hVvj8YbN9g8Lp8t9di0qpPNY/fNBjaPj09vsXj0bVnF6PF5k5zHpidvmQI4o7Jt
	MlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4COVlIoS8wp
	BQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUmBToFSfmFpfmpevlpZZYGRoYGJkCFSZkZ2xr
	nMZYcJux4t6FicwNjFsZuxg5OSQETCT+rVjI2sXIxSEksIdRYuLdPiYI5xOjxPI7u9lBqoQE
	vjFK3FkYAdPx9PosRoiivYwSayeeYoZw3jJKTN26kQWkilfATuLCjdVgO1gEVCW+Ln3ACBEX
	lDg58wlYjahAksSvq3PA4sIC5hKNq0+wgdjMAuISt57MZwKxRQTiJFpnvQLbxizQyyzx+sBh
	oJM4ONgENCUuTC4FMTkFrCTun6+EaJWX2P52Dtg9EgIXOCSeX7vGBFIjIeAi0bmPD+IBYYlX
	x7ewQ9hSEi/726DsZIlLM88xQdglEo/3HISy7SVaT/Uzg4xhBtq6fpc+xCo+id7fT6Cm80p0
	tAlBVCtK3Jv0lBXCFpd4OGMJlO0hMeXfTUSwTZi0imkCo8IspECZheT5WUi+mYWweQEjyypG
	qdSC4tz01GTTAkPdvNRyeHwn5+duYgQnaa2AHYyrN/zVO8TIxMF4iFGCg1lJhHel3M5UId6U
	xMqq1KL8+KLSnNTiQ4ymwOiZyCwlmpwPzBN5JfGGJpYGJmZmZiaWxmaGSuK8r1vnpggJpCeW
	pGanphakFsH0MXFwSjUwab6NOTFtWlOvnuP5Tdu5nP+pv7u9u+duWrvY3Btb1rjGp5y/zW0V
	ad7wZdbfY/N3iq5ZsuTrfDtV0S2hG1WO8DCUn2ZbXfIm90HfQgV+my/H63uMv1yf91HaiStF
	/NxCx3l5igtnRFtz/5sW9nJucYxH9D45l213/P89lEj8WV8lVtvceFghX+C60rvr+4LWKcXn
	8Abx5iTyhCjLv/u6n2v9Ot9AA93AR4uVaxenlWpM2Plo7sey1s2dr3cbiN25q5Zz5P6blgtW
	TOuWb9vS/0tc5WnoJ0np0ymixeneFxLMNfM7/3zevd7WqYLzyWLXj5+W7L/6iK1U83EzX+vM
	aev1qnJZ1NSMf8/ftsxwqxJLcUaioRZzUXEiALLTwVdbBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKIsWRmVeSWpSXmKPExsWy7bCSvO7huF2pBndei1qsvtvPZvH68CdG
	i2kffjJb/L/7nMli1YNwi5WrjzJZ/Fy2it1i7y1tiz17T7JYdF/fwWax/Pg/Joute6+yW5z/
	e5zVgdfj8hVvj8YbN9g8Lp8t9di0qpPNY/fNBjaPj09vsXj0bVnF6PF5k5zHpidvmQI4o7hs
	UlJzMstSi/TtErgytjVOYyy4zVhx78JE5gbGrYxdjJwcEgImEk+vzwKyuTiEBHYzSjy+9Y8d
	IiEu0XztB5QtLLHy33N2iKLXjBK/ts1iAknwCthJXLixGmwSi4CqxNelDxgh4oISJ2c+YQGx
	RQWSJPbcbwSrFxYwl2hcfYINxGYGWnDryXywuIhAnMTh/TfAFjAL9DNLzFn6hRVi215Gid41
	H4CmcnCwCWhKXJhcCmJyClhJ3D9fCTHHTKJraxcjhC0vsf3tHOYJjEKzkJwxC8m6WUhaZiFp
	WcDIsopRMrWgODc9t9iwwCgvtVyvODG3uDQvXS85P3cTIzgmtbR2MO5Z9UHvECMTB+MhRgkO
	ZiUR3pVyO1OFeFMSK6tSi/Lji0pzUosPMUpzsCiJ83573ZsiJJCeWJKanZpakFoEk2Xi4JRq
	YPL+2b5USr2402RTmLy+ic2tL3FdW9UuvrI7of3a++Pq33O94usMheRqt8x6MOG71/pjuf3l
	TNvrMi8vWpSdzB6f95nph/7dhvMpZ6ZWvPmp0pD+vXzeprrPC1s+eZmeX/TM2D+i9Oyaa1ME
	Taun/7G6le58xlLA+FfYYeWPbYs/3ntRNLPj3mLVLcbMF58U3nPcoLfgzr2Qvv5/1+e72ph/
	b8i9w3zbMuLX4Z93tPo9NFftVC6ZssskTjjdYXuf6ynvi9mKc7ed2vTtWdOiNT/9HeRnrl7M
	3fbFY/etd95PLu28fWfBoc8bujqv/Vmaw/jnlGGlI1txwcxqRaGdHQ+mGJ7UvGEUmj9/l8RR
	fuPfSizFGYmGWsxFxYkAh2fK5TgDAAA=
X-CMS-MailID: 20240131145251epcas5p15549659a7889b43e7f6481d3e3cbdf44
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240130214950epcas5p12a8599bf6d3490f33e4bb2a115dcbb48
References: <20240130214911.1863909-1-bvanassche@acm.org>
	<CGME20240130214950epcas5p12a8599bf6d3490f33e4bb2a115dcbb48@epcas5p1.samsung.com>
	<20240130214911.1863909-4-bvanassche@acm.org>

On 1/31/2024 3:18 AM, Bart Van Assche wrote:
> Split fcntl_rw_hint() such that there is one helper function per fcntl. No
> functionality is changed by this patch.

Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>

