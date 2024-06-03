Return-Path: <linux-fsdevel+bounces-20884-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D84568FA8C9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 05:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4577D1F269A1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 03:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7A613D88F;
	Tue,  4 Jun 2024 03:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="tNcvNOlR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF7713D628
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jun 2024 03:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717471737; cv=none; b=lSvDekNe8exPYzkOv5MyPsadAvwVmnTc3MLA/tjkS889XNwjN+SF9vL56Vg5ysjiMsxuskBD6onEtAjCTxA6jjkJglgAL+BgQzwihUJ3G29ns4Xb7M1tyV8CQJwukRywl+VrmoMJ4OBgn49puzqcq21A1C+UWfcYXjqPGFCEcrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717471737; c=relaxed/simple;
	bh=BmnSM780gtlucE+xybG8Q/hhbxyboU3CWExMeE8IYw8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=e5datEnU+/D/Jyg/a0zaMaU4Rz8EPfd1jmt9X13wSIJbQ5GP1xcTYoHjiySPJH53yIB5nRPSB69LEqchP460SfnUFR88krSYzTxm6YJZLIosDAdsI4XNAV9+PeF4V0XTMIoI9oBm9P3ioqw+aKopa6Fvuok6FrhXmBFNIWcTWWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=tNcvNOlR; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240604032847epoutp02361b63f44621c4f1e9a04718a8745d7a~Vr2-EZ4mp3006130061epoutp02X
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jun 2024 03:28:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240604032847epoutp02361b63f44621c4f1e9a04718a8745d7a~Vr2-EZ4mp3006130061epoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1717471727;
	bh=7VN6ZUoN/sVx9OFQYPCvCDso3Uou5inchmMvd4vuq5E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tNcvNOlRXnI5bedxJ26y9w6TRzG50YcynA+2cGwniUTGpbgpPHphBAsVudbrcN6WS
	 Fpv7ucxsfE765eTLhxyisAVREhNHMPqO/FB5cH81xO6io/wNvfYuyBtGTssgD1G/vj
	 9fPq3lfnRj7akJXFtacojDMp/JpXoMaqAMTH/PV8=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240604032846epcas5p1f1c03e377b238d49df5eb58251bf4543~Vr29wVx_50292302923epcas5p1T;
	Tue,  4 Jun 2024 03:28:46 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.177]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4VtbfN3yFfz4x9Pv; Tue,  4 Jun
	2024 03:28:44 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	46.70.08853.CE98E566; Tue,  4 Jun 2024 12:28:44 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240603065101epcas5p2acde37ff1854ff6f455f51ec940caf65~Va_R6KOZ01423114231epcas5p2p;
	Mon,  3 Jun 2024 06:51:01 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240603065101epsmtrp18e7b805f6f3c250176196fb7d0105d49~Va_R3vysa1582915829epsmtrp1i;
	Mon,  3 Jun 2024 06:51:01 +0000 (GMT)
X-AuditID: b6c32a44-fc3fa70000002295-08-665e89ec9f67
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	B8.4E.07412.5D76D566; Mon,  3 Jun 2024 15:51:01 +0900 (KST)
Received: from nj.shetty?samsung.com (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240603065058epsmtip19af2886049d9888391a19a98b3e4be4f~Va_OP59sS2735927359epsmtip1k;
	Mon,  3 Jun 2024 06:50:57 +0000 (GMT)
Date: Mon, 3 Jun 2024 06:43:56 +0000
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>, Alasdair
	Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka
	<mpatocka@redhat.com>, Keith Busch <kbusch@kernel.org>, Sagi Grimberg
	<sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
	<jack@suse.cz>, martin.petersen@oracle.com, bvanassche@acm.org,
	david@fromorbit.com, hare@suse.de, damien.lemoal@opensource.wdc.com,
	anuj20.g@samsung.com, joshi.k@samsung.com, nitheshshetty@gmail.com,
	gost.dev@samsung.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v20 01/12] block: Introduce queue limits and sysfs for
 copy-offload support
Message-ID: <20240603064356.nujnjbtje3vjnti2@nj.shetty@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240601055323.GB5613@lst.de>
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te1BUVRzHO3fv3r1YS5eHcVgmh7nSFO9dWeDgiDVBdiebEXPGHHvACpdH
	7Kt9aOAMgYiKBCvyilXj2RJgkkLyTmMFAsOdIEAQqCG2SCKIxqBBoIULjf99ft/ze//mkDxH
	k0BEJih1rEYpk9PENvym2dPT94/M92PFE2MuqK63i4dOXVjhodpxA4FmzAsAFc7/y0NTt88C
	tNxn4aGGrgmASsuv4GjkdjOG2sovYqi6thNDl4rSMdS5Nkugix1DAFkHjRhqH/VGZWcqcdTW
	3oOjgZbLBCoxWQWoqnsVQ7nnBjHUNJUG0LWZORx9N+qGLCvd/FfcmIEf9zO95ZBpNo4LGMvE
	dZwZ6NMzN2oyCaa+8mNmur4YMK0jqQRTkZPHZ7LT/ySY5oyf+Mxf1lGcmftmkGByGmoA833p
	HUGE09HEPfGsLIbVuLPKaFVMgjIulN5/KDIsMjBILPGVhKBg2l0pU7ChdPibEb77EuS25dDu
	x2VyvU2KkGm1tP/ePRqVXse6x6u0ulCaVcfI1VK1n1am0OqVcX5KVrdbIhbvCrQ5RiXGD+Xm
	EOoml4+WUx+AVHDZ6TywIyElhYbGbOI82EY6Uq0Amq63YpyxYDNquvmc8Q+A5ol6sBUyXFDF
	4x7aAVypz8U5428A+/v6BeteOOUBR0x9NiZJgvKGd9fIddmZoqH1Yd9GIh5VQMA1o9s6O1Ey
	WDXSvqELqTA435DK59gB9hRP4etsZ0tjqf4NrNeClNkOdt0twdfzQyocDjTSXHNO8GF3g4Bj
	EfzdcGaTT8Dq/C8ILvY0gMZh4+Y0L8OMXgOPaygeThuaN/XnYUHvNYzT7WH28hTG6ULY9NkW
	74RX60oJjl3h0GLaJjPwktW8uccxANubR4gLYIfxiYGMT9TjeDfMnD/FN9rm4VFusGqV5NAT
	1rX4lwJ+DXBl1VpFHBsdqJYo2RP/XzlapbgBNj6MV3gTuF+y6tcBMBJ0AEjyaGdhTso7sY7C
	GFlSMqtRRWr0clbbAQJt98nlibZHq2w/TqmLlEhDxNKgoCBpSECQhHYRzmRciXGk4mQ6NpFl
	1axmKw4j7USpmNbhhaIM/x37rMdGH096e/RGer8OF6ZKBhZe1VdbzvmW2S+99O4PC4uxB1qy
	8O3DFSaHR1SQ988+gcVzTsSXT0fLVvL1hx8veS2W+3j0BVTy3eSubrOFSQejzaFRDj4ftpc3
	HFz61kQeD//1tChX+uCWpL86eWz6yNfBj5JffHb4lmtN8lMnG1Wiyp7X8kZO7m1+65muubiZ
	A8E6C23+tKzLPiSrRGLubCtO/4ScrZisXYHiqGBBRlpjvn/YB8OfKwwBR2OdQrRnj1Ue0jt/
	9UvKnY6hhTcUeT5Fh7N2Ls1O7up2vPreTUHpkdnkzKSU+jihIF5xr+i+6G2DOOBhoTx/vPbe
	czSujZdJvHgarew/c/aterkEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa1BMYRzGveeczp5KzbGFN2vEYQyhbLm8bg3pwyG5fHC/rjptxm7lHJGI
	Te4Ry5A2tdmy22VEl2mkwoRSrGUS2lJkl6ZGchmTtGGL4dtvnmd+z//Ln8LF74gR1LaInRwf
	IVMwpBNRcpcZNaVevjFsaqraG12rrcLRwTM2HOW9Ok2ijrufAbrQ9R1HljtHAfphNOGouKoZ
	oAxdGoEa7pRiqFx3FkM5efcxlJqcgKH7Pz+Q6Gzlc4Cs9RoMVZgnoctHsghUXlFDoLqbl0ik
	1VtFyFDdhyH1sXoM3bDEA5Tf8ZFAD8wSZLJVO8yXsHXPgthaHWRLNa9ErKm5gGDrjNFsYe5x
	ki3KOsC2FaUAtqxBRbKZSecc2FMJnSRberjFgf1kNRPsx1v1JJtUnAvYRxn3RMvd1jnNDeUU
	23ZxvI//Fqfwruuv8ah295ib3V8IFWijTwBHCtLT4IvzBvwEcKLEdBmAVxKywUDhAfW2e/gA
	u8GcvvciO4vpTwDGl0XbmaDHwQa98XdOUSQ9CT78Sdljd5qB1nZj/wxOp5DwkVZpZzdaBg0N
	Ff25C70QdhWrHAbuNgNY01vypxgCa1IsxIA8A6YXvcHt+zgtgYa+/n3H36dMOe/BGUBr/jM0
	/xmaf0YGwHOBBxclKOXKEGmUNILb7S3IlEJ0hNw7JFJZCPpfwWvCDdCs7fOuBBgFKgGkcMbd
	JWn/+jCxS6hsTyzHR27moxWcUAkkFMEMd5FeTA0V03LZTm47x0Vx/N8WoxxHqLAnr0s8Dab8
	HYOFdml25ju3mF3hwTHg3OygC641TSPfjI50DnRfuSy4VzK0HDsd19p5e6Rv+u1GV7WlZ30h
	o57o17bEjxcWrs5sKpuXtT/3pbOGyWiM6clp8dN5JQtjtQFKcUpHYkCLdebe+Yf4VYpbBZvG
	zYzfNyNZsXzNrMTW2N6tcdN1vk+bwiaO7VmRPV5fsEXDLYBV5rql7f6iOSHINoyIm+ATaYv1
	T0+bM+Zq59vjlpA8n1W+rtb8tEBPc+rswK/axsXTHq+t/abu3mw+/FxuuxLsMciTmTylep+q
	V7ge1prw42T2kw0feH2tsWqrYdHVtaODlN+htYlx7vYJiGMIIVwm9cJ5QfYLXINCcHkDAAA=
X-CMS-MailID: 20240603065101epcas5p2acde37ff1854ff6f455f51ec940caf65
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----Fualeei1.f5fhWGYL679EBd0hH5-OLgtfrOtH6wInDZGwDEe=_50408_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240520102830epcas5p27274901f3d0c2738c515709890b1dec4
References: <20240520102033.9361-1-nj.shetty@samsung.com>
	<CGME20240520102830epcas5p27274901f3d0c2738c515709890b1dec4@epcas5p2.samsung.com>
	<20240520102033.9361-2-nj.shetty@samsung.com> <20240601055323.GB5613@lst.de>

------Fualeei1.f5fhWGYL679EBd0hH5-OLgtfrOtH6wInDZGwDEe=_50408_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 01/06/24 07:53AM, Christoph Hellwig wrote:
>On Mon, May 20, 2024 at 03:50:14PM +0530, Nitesh Shetty wrote:
>> Add device limits as sysfs entries,
>> 	- copy_max_bytes (RW)
>> 	- copy_max_hw_bytes (RO)
>>
>> Above limits help to split the copy payload in block layer.
>> copy_max_bytes: maximum total length of copy in single payload.
>> copy_max_hw_bytes: Reflects the device supported maximum limit.
>
>That's a bit of a weird way to phrase the commit log as the queue_limits
>are the main thing (and there are three of them as required for the
>scheme to work).  The sysfs attributes really are just an artifact.
>
Acked, we will update commit log.

>> @@ -231,10 +237,11 @@ int blk_set_default_limits(struct queue_limits *lim)
>>  {
>>  	/*
>>  	 * Most defaults are set by capping the bounds in blk_validate_limits,
>> -	 * but max_user_discard_sectors is special and needs an explicit
>> -	 * initialization to the max value here.
>> +	 * but max_user_discard_sectors and max_user_copy_sectors are special
>> +	 * and needs an explicit initialization to the max value here.
>
>s/needs/need/
>
Acked.

>> +/*
>> + * blk_queue_max_copy_hw_sectors - set max sectors for a single copy payload
>> + * @q:	the request queue for the device
>> + * @max_copy_sectors: maximum number of sectors to copy
>> + */
>> +void blk_queue_max_copy_hw_sectors(struct request_queue *q,
>> +				   unsigned int max_copy_sectors)
>> +{
>> +	struct queue_limits *lim = &q->limits;
>> +
>> +	if (max_copy_sectors > (BLK_COPY_MAX_BYTES >> SECTOR_SHIFT))
>> +		max_copy_sectors = BLK_COPY_MAX_BYTES >> SECTOR_SHIFT;
>> +
>> +	lim->max_copy_hw_sectors = max_copy_sectors;
>> +	lim->max_copy_sectors =
>> +		min(max_copy_sectors, lim->max_user_copy_sectors);
>> +}
>> +EXPORT_SYMBOL_GPL(blk_queue_max_copy_hw_sectors);
>
>Please don't add new blk_queue_* helpers, everything should go through
>the atomic queue limits API now.  Also capping the hardware limit
>here looks odd.
>
This was a mistake, we are not using this function. We will remove this
function in next version.

>> +	if (max_copy_bytes & (queue_logical_block_size(q) - 1))
>> +		return -EINVAL;
>
>This should probably go into blk_validate_limits and just round down.
>
Bart also pointed out similar thing. We do same check before issuing
copy offload, so we will remove this check.

>Also most block limits are in kb.  Not that I really know why we are
>doing that, but is there a good reason to deviate from that scheme?
>
We followed discard as a reference, but we can move to kb, if that helps
with overall readability.

Thank you,
Nitesh Shetty

------Fualeei1.f5fhWGYL679EBd0hH5-OLgtfrOtH6wInDZGwDEe=_50408_
Content-Type: text/plain; charset="utf-8"


------Fualeei1.f5fhWGYL679EBd0hH5-OLgtfrOtH6wInDZGwDEe=_50408_--

