Return-Path: <linux-fsdevel+bounces-8543-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32270838E9F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 13:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9890F1F24482
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 12:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14D15EE69;
	Tue, 23 Jan 2024 12:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="r7fBM9uD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9980033097
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jan 2024 12:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706013329; cv=none; b=rNsctj3bliUDLEpjUyrU6HcFermKWrf0udtYwZuOHKUzFPan/BMCpAX1AdTsjCFOAyffoNAw9sYAW8p08OF4SiBdZ+GKlUCl49tDE9L8QFrgTu6QLNcWPPIm8Vg06CR8wyLPH9kjzAXBOlKSYe7ymq8LlAimzUNviFfDNv4Rd6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706013329; c=relaxed/simple;
	bh=uRcDaSX8pQOjFvpMbwd+Qqqh1KHfII7npQaq0Zvxi2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=TZQfs2RJtPfjNA2/3RSMBj4hfbNoPS75FQ48BAYc6rRCh0PxnOJQyvopmoYhjGTxx6lpsaCPP1CnvdNxymXqX/aQzZXwkWhXrInkWUM+OTN6VSOJWOiduM4LMp5CPgd39nIqLCKRNaaJzhG03SiXAPl12muNsmRbhhj2CgXcmIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=r7fBM9uD; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240123123524epoutp04958a1f44eac8cff39b78c952760bb041~s_hRqRokq2949729497epoutp04F
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jan 2024 12:35:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240123123524epoutp04958a1f44eac8cff39b78c952760bb041~s_hRqRokq2949729497epoutp04F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1706013324;
	bh=70SPJJ09DqOmq0RndSWWIGhcQMCBvqgHmTzILun0NEw=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=r7fBM9uDmrEhHhgE2TS4GARwh9O5qaiMmXSRrLMQuoOiFB0xMxb6dj3ML8P4ypvp4
	 e/uKWwJAm6IvjKHpOMn30gAuYyAO3eDWp0J9V3kOYKulps9cXnw2GHYevOKx+cjRWg
	 hRzEZ9pkWabLWjNbrSs6Ss8JA/D2KGv31bi/8+oY=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240123123524epcas5p4d776589a67a43a2e1d2cfb47c4269820~s_hRPPwjX3008930089epcas5p4h;
	Tue, 23 Jan 2024 12:35:24 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4TK64V3hPcz4x9Pr; Tue, 23 Jan
	2024 12:35:22 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	22.9A.08567.A82BFA56; Tue, 23 Jan 2024 21:35:22 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240123123521epcas5p4eb80663a96018e5b48e1d1ba25d15f87~s_hOpE2kW0461204612epcas5p4l;
	Tue, 23 Jan 2024 12:35:21 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240123123521epsmtrp2e005b1d3fd4e6b49e05dfed7418773e2~s_hOoVvxT1911919119epsmtrp2n;
	Tue, 23 Jan 2024 12:35:21 +0000 (GMT)
X-AuditID: b6c32a44-617fd70000002177-2e-65afb28a7420
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	DC.05.07368.982BFA56; Tue, 23 Jan 2024 21:35:21 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240123123519epsmtip23bdc2c34d99109452755ad0392dee0e9~s_hNL-C1d2923529235epsmtip2C;
	Tue, 23 Jan 2024 12:35:19 +0000 (GMT)
Message-ID: <51194dc8-dd4d-1b0b-f6c1-4830ea3a63e9@samsung.com>
Date: Tue, 23 Jan 2024 18:05:18 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH v8 05/19] block, fs: Restore the per-bio/request data
 lifetime fields
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>, "Martin K . Petersen"
	<martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, Christoph
	Hellwig <hch@lst.de>, Daejun Park <daejun7.park@samsung.com>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <bbaf780c-2807-44df-93b4-f3c9f6c43fad@acm.org>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCJsWRmVeSWpSXmKPExsWy7bCmlm7XpvWpBjdaJSxW3+1ns3h9+BOj
	xbQPP5ktVj0It1i5+iiTxd5b2hZ79p5ksei+voPNYvnxf0wW5/8eZ3Xg8rh8xdvj8tlSj02r
	Otk8dt9sYPP4+PQWi0ffllWMHp83yXlsevKWKYAjKtsmIzUxJbVIITUvOT8lMy/dVsk7ON45
	3tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB+hAJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmt
	UmpBSk6BSYFecWJucWleul5eaomVoYGBkSlQYUJ2xtH+l6wFTwQqzq+cx9LAOJuvi5GTQ0LA
	ROLBo3PMILaQwG5Gif0/+bsYuYDsT4wSU25PY4dwvjFKrLiwkh2m4/DTN+wQHXsZJQ5f0IIo
	esso8efQC7BRvAJ2Emu6JzGC2CwCqhJXWyazQMQFJU7OfAJmiwokSfy6OgesRlggWqJt5USw
	ocwC4hK3nsxnArFFBOIkWme9YgRZwCwwg0li3etrQEUcHGwCmhIXJpeC1HAKWEssX/CREaJX
	XqJ562xmkHoJgR0cEofXHWWCuNpFYt6tT4wQtrDEq+NboL6Rkvj8bi8bhJ0scWnmOaj6EonH
	ew5C2fYSraf6mUH2MgPtXb9LH2IXn0Tv7ydMIGEJAV6JjjYhiGpFiXuTnrJC2OISD2csgbI9
	JC6/esgMCavFTBJTrrYzTmBUmIUULLOQvD8LyTuzEDYvYGRZxSiZWlCcm56abFpgmJdaDo/v
	5PzcTYzg5KvlsoPxxvx/eocYmTgYDzFKcDArifDekFyXKsSbklhZlVqUH19UmpNafIjRFBg/
	E5mlRJPzgek/ryTe0MTSwMTMzMzE0tjMUEmc93Xr3BQhgfTEktTs1NSC1CKYPiYOTqkGJmn1
	fzJ1j5WZ4mZY73u+yODJoTN9167XqB2sT36lbRvEbvNf/tGNo2u6LDN3rS+cM6sh2nb+Jqtn
	s84dqr6w1vZykpt30HnVyIWSa4ODFF8UM1ZEB4e1f3ffbHnpIg/TEttmzpdNDicW+4bvn7hF
	jkvkqoqpyJsH509aHxBRcJN2ZpBL3eBiGfrcyGpB6f8nnIfPGvJdfS/alpP87MyFfeychbZ7
	/p5l32D3hr3hVsxHg6ipdybNtLd0eXR/yqR94q6PlJlnV4mLv1Y4dShSVf/Bc0GO/JA93hMK
	DaKvPOM/OEFRcPIj86qA5O9bl86Zmc7KWni+RzXj2H/DmA9Bp4NMHr+wDIvZx8HS48Y6S4ml
	OCPRUIu5qDgRAFikcCZHBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIIsWRmVeSWpSXmKPExsWy7bCSvG7npvWpBot62C1W3+1ns3h9+BOj
	xbQPP5ktVj0It1i5+iiTxd5b2hZ79p5ksei+voPNYvnxf0wW5/8eZ3Xg8rh8xdvj8tlSj02r
	Otk8dt9sYPP4+PQWi0ffllWMHp83yXlsevKWKYAjissmJTUnsyy1SN8ugSvjaP9L1oInAhXn
	V85jaWCczdfFyMkhIWAicfjpG/YuRi4OIYHdjBLfd19hhkiISzRf+8EOYQtLrPz3HKroNaPE
	r9+tLCAJXgE7iTXdkxhBbBYBVYmrLZOh4oISJ2c+AbNFBZIk9txvZAKxhQWiJdpWTgQbygy0
	4NaT+WBxEYE4icP7b4AtYBaYxSTx/PxDNpCEkMBiJoklF6K6GDk42AQ0JS5MLgUJcwpYSyxf
	8JERYo6ZRNfWLihbXqJ562zmCYxCs5CcMQvJullIWmYhaVnAyLKKUTK1oDg3PTfZsMAwL7Vc
	rzgxt7g0L10vOT93EyM41rQ0djDem/9P7xAjEwfjIUYJDmYlEd4bkutShXhTEiurUovy44tK
	c1KLDzFKc7AoifMazpidIiSQnliSmp2aWpBaBJNl4uCUamDS2C339WqqyOqbRRNfX2C9M6fq
	nPNkq4MGDIGvU5oUFdQuhgXeTflxePfRk83vsy6tasu9tHPF0aTfDvvK5l1gXnp/wuXu/frf
	vlqyt1x7OvsI75LYzb+CV0mZbDkmMcPm7ONaSRMtnR2WRamqAms9GAOW9m7q93OdIdqjOGX3
	nq9p2sGH47/4aO2/EBJaqLJ9Vc4LxpCeYPN9r3bGr/P6k8opJfQj02+Z3wY516mr1Kw3rJjc
	3PHhue/jghkcLQ8W7hLJ/bj47sTtKfsYHKt5fqzflq9/5sLjk89X9GYfuilz98dvweOLu9ey
	vjmm93XJBz5z5g9ZjqwslnqSj9wqDjMcPHRj9kQP/tavL4I1VyuxFGckGmoxFxUnAgAck4zk
	JAMAAA==
X-CMS-MailID: 20240123123521epcas5p4eb80663a96018e5b48e1d1ba25d15f87
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231219000844epcas5p277a34c3a0e212b4a3abec0276ea9e6c6
References: <20231219000815.2739120-1-bvanassche@acm.org>
	<CGME20231219000844epcas5p277a34c3a0e212b4a3abec0276ea9e6c6@epcas5p2.samsung.com>
	<20231219000815.2739120-6-bvanassche@acm.org>
	<23354a9b-dd1e-5eed-f537-6a2de9185d7a@samsung.com>
	<bbaf780c-2807-44df-93b4-f3c9f6c43fad@acm.org>

On 1/23/2024 1:35 AM, Bart Van Assche wrote:
> On 1/22/24 01:23, Kanchan Joshi wrote:
>> On 12/19/2023 5:37 AM, Bart Van Assche wrote:
>>
>>> diff --git a/block/fops.c b/block/fops.c
>>> index 0abaac705daf..787ce52bc2c6 100644
>>> --- a/block/fops.c
>>> +++ b/block/fops.c
>>> @@ -73,6 +73,7 @@ static ssize_t __blkdev_direct_IO_simple(struct 
>>> kiocb *iocb,
>>>            bio_init(&bio, bdev, vecs, nr_pages, dio_bio_write_op(iocb));
>>>        }
>>>        bio.bi_iter.bi_sector = pos >> SECTOR_SHIFT;
>>> +    bio.bi_write_hint = file_inode(iocb->ki_filp)->i_write_hint;
>>>        bio.bi_ioprio = iocb->ki_ioprio;
>>>        ret = bio_iov_iter_get_pages(&bio, iter);
>>> @@ -203,6 +204,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb 
>>> *iocb, struct iov_iter *iter,
>>>        for (;;) {
>>>            bio->bi_iter.bi_sector = pos >> SECTOR_SHIFT;
>>> +        bio->bi_write_hint = file_inode(iocb->ki_filp)->i_write_hint;
>>>            bio->bi_private = dio;
>>>            bio->bi_end_io = blkdev_bio_end_io;
>>>            bio->bi_ioprio = iocb->ki_ioprio;
>>> @@ -321,6 +323,7 @@ static ssize_t __blkdev_direct_IO_async(struct 
>>> kiocb *iocb,
>>>        dio->flags = 0;
>>>        dio->iocb = iocb;
>>>        bio->bi_iter.bi_sector = pos >> SECTOR_SHIFT;
>>> +    bio->bi_write_hint = file_inode(iocb->ki_filp)->i_write_hint;
>>
>> This (and two more places above) should rather be changed to:
>>
>> bio.bi_write_hint = bdev_file_inode(iocb->ki_filp)->i_write_hint;
>>
>> Note that at other places too (e.g., blkdev_fallocate, blkdev_mmap,
>> blkdev_lseek) bdev inode is used and not file inode.
> 
> Why should this code be changed?

Because this file is for raw block IO, and bdev_file_inode is the right 
inode to be used.

> The above code has been tested and
> works fine.

At the cost of inviting some extra work. Because this patch used 
file_inode, the patch 6 needs to set the hint on two inodes.
If we use bdev_file_inode, this whole thing becomes clean.

