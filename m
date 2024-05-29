Return-Path: <linux-fsdevel+bounces-20404-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D75F8D2D57
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 08:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BDC01C23598
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 06:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBE015FD19;
	Wed, 29 May 2024 06:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KPzAStJm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5871B806
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 May 2024 06:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716964454; cv=none; b=oVoZ+3pFfVNigDtl1Xi29+cYa19sy+3lal+pp3ygug4oQ7uExzwL9+/KyLodVZ626vBCYJgq+OpQiNCYR3IKWQ/t03PubB/rK+CADbxIEuQqMQ1EyZHpkwSKrqKGV5FXxO3EnFTXlVb7xdZBu4vQbP385vcaGBJMx/0XhpYTBso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716964454; c=relaxed/simple;
	bh=NsZzfbV06rLVjw7w9bEi8ENxd4QN9ta1b5bIXmsHmVs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=KCmVYAJtqe1ROvbzAAqzOZQWBJTDUNgyc0DJmgnwtfEdLad1zTdyjcqH1xwJvkUSuoBQPkFpSWWj8NdK1zq7FhWSt+jtYkvkuso50cVRife2/NJrIlbhQ2cpYHuL4A68vqeeATAn8XGxLsB08cd38SB6oO3prcNRH99BclzXCfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=KPzAStJm; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240529063410epoutp0202576528d234955f43e2131793fc53e7~T4hIJFK4C0523305233epoutp02B
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 May 2024 06:34:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240529063410epoutp0202576528d234955f43e2131793fc53e7~T4hIJFK4C0523305233epoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1716964450;
	bh=NsZzfbV06rLVjw7w9bEi8ENxd4QN9ta1b5bIXmsHmVs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KPzAStJm81IIWFHBjGYYT3sAf9/t9O1m+nKO/iQQOcUxAhJN64KEBQRkGJEvo8dHy
	 OlmKX7NMGK9xd8QErxb2LR/sSYkypsvHiqMUlzvMmcdIZEXl3CLLMSa6daD7cSToAv
	 ty+haNNJ6altNKNaapd7BVDqWYj5OMe+opqfiLgc=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240529063409epcas5p369e3e08e61e1803a1c01b61eff6512e0~T4hHdSVi11875018750epcas5p3u;
	Wed, 29 May 2024 06:34:09 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4Vq03332XYz4x9Q9; Wed, 29 May
	2024 06:34:07 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	28.84.09989.F5CC6566; Wed, 29 May 2024 15:34:07 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240529062441epcas5p35df44836a06016c39d889a70bb41fe55~T4Y2ctZzx0620706207epcas5p3g;
	Wed, 29 May 2024 06:24:41 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240529062441epsmtrp1670219f5f568e1de070e9a2af6946b10~T4Y2aSjsA1911319113epsmtrp1O;
	Wed, 29 May 2024 06:24:41 +0000 (GMT)
X-AuditID: b6c32a4a-bffff70000002705-f7-6656cc5ffad1
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	6B.C2.08336.82AC6566; Wed, 29 May 2024 15:24:41 +0900 (KST)
Received: from nj.shetty?samsung.com (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240529062436epsmtip18af8d6e6bfb03e340ee76cb5830a2d09~T4YyWBPL92138321383epsmtip1q;
	Wed, 29 May 2024 06:24:36 +0000 (GMT)
Date: Wed, 29 May 2024 06:17:36 +0000
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>, Alasdair
	Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka
	<mpatocka@redhat.com>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig
	<hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni
	<kch@nvidia.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
	Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	martin.petersen@oracle.com, david@fromorbit.com, hare@suse.de,
	damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com, joshi.k@samsung.com,
	nitheshshetty@gmail.com, gost.dev@samsung.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v20 02/12] Add infrastructure for copy offload in block
 and request layer.
Message-ID: <20240529061736.rubnzwkkavgsgmie@nj.shetty@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <eda6c198-3a29-4da4-94db-305cfe28d3d6@acm.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA01TaVBTVxSe+17yEpTQ1wB6SaaAQabsJLL0Yo21xeW10CmDxZk6diATHoQB
	kjSPRbvIJlipgCDoGMWy7wIqExbBWhDQAGWmgC1YlLbQUqlCtbUsgzTwoOO/737LPXPOmcPH
	hRU8ET9KHUfr1IoYCbGJY+hydnYP7T8UIR2/bIUajD04Sj2zjKPa8RwCzXQ9Bejc3AKOJm+d
	BGhpYBBHTT0PACoqKeSg0VutGGovycNQdW03hi6eT8NQ98pjAuV13gNoakSPoY4xV1ScUcZB
	7R13OWio7RKBvq6Y4qHK3hcYyv1yBEMtkykA1c/MctCdMTEaXO7l7hFTQ8MBlLEEUq36cR41
	+OAqhxoaiKeu1ZwiqOtlSdT09QuAujGaTFCl2We5VFbaE4JqTX/Ipf6aGuNQszdHCCq7qQZQ
	/UW3eUGWh6N3qWhFOK2zp9VKTXiUOlIuCTgY6h/q4yuVucv80BsSe7UilpZL9gYGue+PijEN
	R2KfoIiJN1FBCoaReO7epdPEx9H2Kg0TJ5fQ2vAYrbfWg1HEMvHqSA81HbdTJpXu8DEZw6JV
	ZbPtXO13wqMjxXMgGfS9kgnM+JD0hjOt3bxMsIkvJG8AmDNczlsVhORTAMsvCljhOYDnqp5x
	NxJlVZXriQ4AfzF+i7GPZyZXXduai0M6wtSMBTwT8PkE6Qr7VvirtBXpBJ9PVHJW/ThZTMCf
	fpzHVwVLMgw+NuauZQWkP6xunOWw+FV498LkGjYj34SVDZfWwpD83gymdLBhSO6Fhux2jMWW
	8FFvE4/FIvhHTsY6ToTV+VUEGz4BoP4HPWCFt2C6MWftI5xUwfzSeYLlX4MFxnqM5S1g1tLk
	egEBbLm8gR1gXUPRut8G3vs3hVjtGJIUvF9nx07lCYCTvxXhZ4Ct/qWG9C+VY/FOeGoulas3
	xXFSDCtf8FnoDBvaPIsAtwbY0FomNpJmfLQ71HTi/1tWamKvgbWDcXmvBfw8MefRCTA+6ASQ
	j0usBP15IRFCQbji2Ke0ThOqi4+hmU7gY1pQLi6yVmpMF6eOC5V5+0m9fX19vf28fGWSrYKZ
	9MJwIRmpiKOjaVpL6zZyGN9MlIy5VYuuhKZR9Vmub2fxGjsGZvcP/H24f1vUqXxnm7Nzdol2
	W7qtjkl9bR5ZH1lymAnsafu1OfyzZnmEYfSDhw0h85oThkA3/Z7j92ULqarF0RXx5mLxIacV
	EZVwMrjGvytyn9M3/5g72+YalLz6RmmrxenhAklXonXA0cHbLhZeW/rkf44NO3iSu282f4K5
	M+MJnPLNSt4RT2af+zvbJ80FV7+wNT9QKL6TpAkICJ7+yKwu/yCpXPzdbfhjO3nwIrNSerxp
	ukXr9NX86ex5R91yw+vqA/IKm4p3A1oKJ5J6+LVT0Dlsm1SHzhflfdgV5mW4ohSW+UdtDWl3
	FIs+L39/u7RAwmFUCpkLrmMU/wG1wdKPuQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02SeUxTWRjFve+9vj6IjU/AcKUjaqMRNFbreuMgbmiuUeMyStSQaLWPRWip
	LR3EmShKxC2I1i20VZCtQ4lWgaCUCqQK1YKishhQ6wZDI8oihkhIQSka/e/kO+d3zj8fQ/q4
	qAAmRpHAqRTSOBHtTZXeEwXODnaER85NKSeR2VFDoqNn3SQqfJVOo857nwG61DNAoraq4wAN
	PqonUUmNE6Cs7CsUaqkqI5A1W0uggsJqAukvpxCoevgTjbS2ZoDam3QEuts6C11LzaWQ9e5D
	CjVYDDTKzG/nI6N9iEDnTjQR6E7bEYBudHZT6EGrENW77bzlQtzQuA47siEu073i43rnLQo3
	PNLgItNJGhfnHsau4gyAy1uSaZxz5jwPp6V00bjs2Gse7m1vpXB3RRONz5SYAK7Lus/f5LvT
	O0TGxcX8zanmhO72jh5yvgTKZPbAl/9vEMngsuAU8GIguwDm/mfknwLejA9bDqD9QSZ/1JgI
	8933yVHtCwuGOn6EegH8mN7PGzEodjo8mjrwPcQwNDsL1g4zI2c/Ngj2vzFSI3mSzaPh08pB
	T6kvuxt+cpzzsAJ2FSy42U2NlnYBeOLJY/6oMR4+zGijRjTJLoJXi996BkhWCI1DngEv9k9o
	NBuos4DV/UbofiN0v4gsQJrARE6plkfJ1RKlRMElitVSuVqjiBLvjZcXAc8zzAy+A26besQ2
	QDDABiBDivwEddptkT4CmTTpIKeK36XSxHFqGxAylMhf4O9Kk/mwUdIELpbjlJzqp0swXgHJ
	xNT5hjmqnpCW0gORYflyqcVWOa1v8HSvZY8scPOLDMPYl9ttE5QfqmJ6/6quOB/vUnhtXexa
	GSgrujR5WUVdY1oeU6kdPpR4fcAJDCub816Mm/a0OKLuZN+aBk1kaHBi//zWDSvG1QZuehYx
	+WDo2A/hYfMMzinXiOdfw9amlkp1G/WZOX1x7uOa/QHUkvH49ZOmz3J/8frai1bJDt5HMuzf
	xZ0bTOEzdIUlFy5s0TXHmm36nOtBPIvBDv8QhQRH1SR1pflJGi3iNtPq9Ahxxxe945l5eYbC
	ql8S5FLbFyalvhswPv5nS6y4zE6+X6rdt79jkjvh9FfhGOvCaPP7t7nzRJQ6WiqZSarU0m/z
	cG5+ewMAAA==
X-CMS-MailID: 20240529062441epcas5p35df44836a06016c39d889a70bb41fe55
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----u98hW3AvpxW_WMqzG8XaJinKydZ84Ygy6oP0sovTVoTPagnQ=_119f1_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240520102842epcas5p4949334c2587a15b8adab2c913daa622f
References: <20240520102033.9361-1-nj.shetty@samsung.com>
	<CGME20240520102842epcas5p4949334c2587a15b8adab2c913daa622f@epcas5p4.samsung.com>
	<20240520102033.9361-3-nj.shetty@samsung.com>
	<eda6c198-3a29-4da4-94db-305cfe28d3d6@acm.org>

------u98hW3AvpxW_WMqzG8XaJinKydZ84Ygy6oP0sovTVoTPagnQ=_119f1_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 24/05/24 01:33PM, Bart Van Assche wrote:
>On 5/20/24 03:20, Nitesh Shetty wrote:
>>We add two new opcode REQ_OP_COPY_DST, REQ_OP_COPY_SRC.
>>Since copy is a composite operation involving src and dst sectors/lba,
>>each needs to be represented by a separate bio to make it compatible
>>with device mapper.
>>We expect caller to take a plug and send bio with destination information,
>>followed by bio with source information.
>>Once the dst bio arrives we form a request and wait for source
>>bio. Upon arrival of source bio we merge these two bio's and send
>>corresponding request down to device driver.
>>Merging non copy offload bio is avoided by checking for copy specific
>>opcodes in merge function.
>
>In this patch I don't see any changes for blk_attempt_bio_merge(). Does
>this mean that combining REQ_OP_COPY_DST and REQ_OP_COPY_SRC will never
>happen if the QUEUE_FLAG_NOMERGES request queue flag has been set?
>
Yes, in this case copy won't work, as both src and dst bio reach driver
as part of separate requests.
We will add this as part of documentation.

>Can it happen that the REQ_NOMERGE flag is set by __bio_split_to_limits()
>for REQ_OP_COPY_DST or REQ_OP_COPY_SRC bios? Will this happen if the
>following condition is met?
>
>dst_bio->nr_phys_segs + src_bio->nr_phys_segs > max_segments
>
No, this should not happen. We don't use bio_split_rw for copy.
We have added a separate function to check for split incase of
copy(bio_split_copy), which doesn't allow copy bio splits,
hence REQ_NOMERGE flag won't be set.

>Is it allowed to set REQ_PREFLUSH or REQ_FUA for REQ_OP_COPY_DST or
>REQ_OP_COPY_SRC bios? I'm asking this because these flags disable merging.
>
>From include/linux/blk_types.h:
>
>#define REQ_NOMERGE_FLAGS (REQ_NOMERGE | REQ_PREFLUSH | REQ_FUA)
>
No, setting these flags won't allow copy bio's to merge and hence copy
won't work.
We suggest to use helper API blkdev_copy_offload to achieve the
copy which won't be setting these flags.

Thank You,
Nitesh Shetty

------u98hW3AvpxW_WMqzG8XaJinKydZ84Ygy6oP0sovTVoTPagnQ=_119f1_
Content-Type: text/plain; charset="utf-8"


------u98hW3AvpxW_WMqzG8XaJinKydZ84Ygy6oP0sovTVoTPagnQ=_119f1_--

