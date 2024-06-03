Return-Path: <linux-fsdevel+bounces-20814-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7F68D81A2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 13:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12E741C22039
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 11:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F5D86243;
	Mon,  3 Jun 2024 11:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fP+DAI06"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEA286244
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Jun 2024 11:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717415608; cv=none; b=aGjThTXzTqLq66xsnEa4OB1kiZDG87SYgYDALl1vKqBcYpeD/rHR/I7QsVDo9IMh7irw3RlJomRte4MplcUIKB+Tnenv/iUQGr8XW+DGE7Ryj7mauNxLJeJYmGAhwQG/K3NO/4mDJAqO1pFI69AsW5aB8PFX1sp0O38dYgyVAx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717415608; c=relaxed/simple;
	bh=yyNUMLw/GbUO1MJCYZB6GVLkpbdu8CsKGpnKsH8egEY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=T35Qqi6jm0clg0AzTmoirI/78KUwZupEyzaUZjA+AhrDEnxrUG7I4Mn3B0jcgsmgVZvzdtJnWzJEoNYtiQVS7CrNXBRgmoqJdKpDvS9NTmlgQnA18ZCR1ws3PLCf68j9E2ZM/Zl4XdPIWmf1xgPNXaCLRMVAWXP9XWpMAv38HE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=fP+DAI06; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240603115325epoutp04a093e431921148ed529fcf8a0816b760~VfGTKVKUk1294912949epoutp04L
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Jun 2024 11:53:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240603115325epoutp04a093e431921148ed529fcf8a0816b760~VfGTKVKUk1294912949epoutp04L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1717415605;
	bh=LcKYgdyDMyHXraxQxmDzCTSZymeakJlnkz6ezAKVGEQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fP+DAI06tMvyyGgS+6+6Qj6y6AqIJI7EZrwW9N4siuCnFMedcp7Zhy7EIaZvXRn/H
	 79eXl+75vclvvIIC+AN09nC/4fS9TvF8Ex9PdqdE4/4XWxETKR1R3gDq3d99KcTcqo
	 AhSZzxjQZl+OP+6vV+bmak+KBgEv179sfmqmAJAQ=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240603115324epcas5p3e77764cde13ea6a0ae34e3ca3687866b~VfGSjgeNx2720327203epcas5p3H;
	Mon,  3 Jun 2024 11:53:24 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4VtBv73FtVz4x9Q6; Mon,  3 Jun
	2024 11:53:23 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	01.06.19174.3BEAD566; Mon,  3 Jun 2024 20:53:23 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240603114332epcas5p26f0bff3af640acf73819b485b02ea318~Ve9qyqWb91520015200epcas5p2R;
	Mon,  3 Jun 2024 11:43:32 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240603114332epsmtrp227d5502c0abfcd0cc2120278ca9eff6f~Ve9qwgjRP2552225522epsmtrp2V;
	Mon,  3 Jun 2024 11:43:32 +0000 (GMT)
X-AuditID: b6c32a50-87fff70000004ae6-c4-665daeb3ffe2
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	EA.8E.08622.36CAD566; Mon,  3 Jun 2024 20:43:31 +0900 (KST)
Received: from nj.shetty?samsung.com (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240603114328epsmtip217510b9a96c0c468e513a20910da8803~Ve9nGlrbV2032820328epsmtip2V;
	Mon,  3 Jun 2024 11:43:28 +0000 (GMT)
Date: Mon, 3 Jun 2024 11:43:40 +0000
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
	gost.dev@samsung.com, Javier Gonz??lez <javier.gonz@samsung.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v20 07/12] nvme: add copy offload support
Message-ID: <20240603114340.5rvx3o57h2zojfjs@nj.shetty@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240601062219.GB6221@lst.de>
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTVxzHc+5tbwsOcwUWz+qLFNxABrSTsgODKZHMm0gysmUzkTmo9NIi
	pS19KO4PLfIYj4HgcEARRWBD3u+Np5MiIEWCjoGB8AqWbQJTXsMZAqylsO2/z+97fu9fDhu3
	LWdx2BEyNa2UCaVcwprxY6eLs1t91dlw3u1Fe1Rt6MbR1Yx1HJWPXyPQXOcSQN8tvMaR8f7X
	AK31D+CooXsCoILCfAYaud+MobbC6xgqLe/CUF52HIaejS2zUNfmnwS6rh8GaGZIh6H2UVd0
	J7GYgdraexlosOUmgW7/MMNCJT0bGMpMGsJQkzEWoKq5lwz0cHQfGljvYR7fTw3+eooyFEKq
	WTfOogYmahnUYL+GqitLJqj64ivUH/W5gGod0RJUUfq3TCot7gVBNSdMMqnFmVEG9fLeEEGl
	N5QB6lHBA1aQ3ZlIXwktFNFKB1oWJhdFyMR+3FOfhpwIEXjx+G58b/Q+10EmjKL9uAGBQW4f
	RUhNG+I6XBBKNSYpSKhScT0+9FXKNWraQSJXqf24tEIkVXgq3FXCKJVGJnaX0WofPo/3nsDk
	GBop2ch4SCj+2h2zWjHD0gL9GynAig1JT/h9+s9ECrBm25JtAP7UeBezGEsAdg42MS3GKoAp
	HVX4TshK4hjDzLZkO4DxC7TFaRnAip5azPzAIJ3gVHMJKwWw2QTpCvs22WbZnuTCmdl+YPbH
	yQ4CJizmbCW1I/1g6uMaYGYb8gTsy0/d5j2wN9e4VczKlKfrceNWR5ActoJxuVqWpaMA2D3R
	ASxsB2d7GrZ1Dlx+0U5Y+CIszbpLWILjAdQ91W0HHIMJhmu4uVOclMDW5BCLfADeMFRtDYOT
	u2HamhGz6Daw6dYOO8KK6oLt/G/B4Vex20zB8vguYNnKGIBpHZlEBjio+99Auv/K6bZK+MDk
	hatMi7wPlmywLegCq1s8CgCzDHBohSpKTIcJFHw3GX3x3yuHyaPqwNavORLUBMpr1t31AGMD
	PYBsnGtvk345ONzWRiS89BWtlIcoNVJapQcC04Eycc6bYXLTt5OpQ/ie3jxPLy8vT++jXnzu
	Xpu5hHyRLSkWqulImlbQyp04jG3F0WLOv/jmlMW0ygsD0z3rRvytxZzYXbnOgRlPj2k+Od3g
	314VOnE6SmqfuktQp71RvHxu2uPc9Osp68DJw8yKPXG+KzftW4gx2Hh+1CBYLepaOZTzeX9b
	KGfjQdzzPu/MgP3zktbz4hkf/QdTssUn2ZEnYypnsyuNzq8+PuTYEGHnv3ynwRh98lKvk93f
	tZXfzM7D3/YSpUVanuiCUTInfnLvnfVp77MxgUkHDj/Kqn63pN0pezM6L0udwB1qWZtW35Im
	tQoOhrumBFP6vKVCxxr49rOW4Uh15LWgM9FftM0PqFzwlMuV5JdXYng63bhHbuJnEeX5k8ex
	o4ai4PjnrYO/z3VyGSqJkH8EV6qE/wCfm8hgvgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLIsWRmVeSWpSXmKPExsWy7bCSvG7ymtg0g7PrzS3WnzrGbNE04S+z
	xeq7/WwWrw9/YrSY9uEns8WTA+2MFr/Pnme22HLsHqPFgkVzWSxuHtjJZLFn0SQmi5WrjzJZ
	zJ7ezGTx+M5ndouj/9+yWUw6dI3R4unVWUwWe29pWyxsW8JisWfvSRaLy7vmsFnMX/aU3WL5
	8X9MFhM7rjJZ7HjSyGix7vV7FosTt6Qtzv89zuog43H5irfHqUUSHjtn3WX3OH9vI4vH5bOl
	HptWdbJ5bF5S7/Fi80xGj903G9g8FvdNZvXobX7H5rGz9T6rx8ent1g83u+7yubRt2UVo8eZ
	BUfYA4SjuGxSUnMyy1KL9O0SuDK2NS1hLVjOU/G6fxV7A2MfVxcjJ4eEgInEl7Y7LF2MXBxC
	ArsZJVY9u80IkZCUWPb3CDOELSyx8t9zdoiij4wStyeeZANJsAioSDzYuRwowcHBJqAtcfo/
	B0hYREBJ4umrs4wg9cwCR9kkFm6YDDZIWMBWovvCBrAFvALOEqfndjNCDL3HKPFt+xqohKDE
	yZlPWEBsZgEziXmbHzKDLGAWkJZY/g9sASfQrqMXtrJOYBSYhaRjFpKOWQgdCxiZVzFKphYU
	56bnFhsWGOWllusVJ+YWl+al6yXn525iBKcILa0djHtWfdA7xMjEwXiIUYKDWUmEt68uOk2I
	NyWxsiq1KD++qDQntfgQozQHi5I477fXvSlCAumJJanZqakFqUUwWSYOTqkGpqMVaxNYnjGW
	z4n4EqYgctqC8yTzjKyqjcW+yn/08rZbvm7dMc2s2XfRr17vlx/kbdXZag+VS1XpiJmonmXZ
	catLhauorJrX1zjY5bJF+M2V8h9yKrhEiuZNVfBoVKpkMPaNWOAzSe92i7rF87Kce+5vzVxr
	ezQOXZOzcahc5HHYx0Uw4kjxBbGiZ556V6eYJsfvf7k11J1z4cmX4uE1EzRZbh4OfOf4Ivv6
	uSdzFDf+bW6YePRaxSG/Gv8um02dIU6LpZgWeDFdnMyx/83UqVGV9g2nXi5rSb1bO/3Ex08V
	7D9OPpX7MS3c4akJb3h3inztRrNvjqciKs4+vvzQJUnD9GzfrH8ii7dfLTBTYinOSDTUYi4q
	TgQARi3hiYADAAA=
X-CMS-MailID: 20240603114332epcas5p26f0bff3af640acf73819b485b02ea318
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----Fualeei1.f5fhWGYL679EBd0hH5-OLgtfrOtH6wInDZGwDEe=_52166_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240520102940epcas5p2b5f38ceabe94bed3905fb386a0d65ec7
References: <20240520102033.9361-1-nj.shetty@samsung.com>
	<CGME20240520102940epcas5p2b5f38ceabe94bed3905fb386a0d65ec7@epcas5p2.samsung.com>
	<20240520102033.9361-8-nj.shetty@samsung.com> <20240601062219.GB6221@lst.de>

------Fualeei1.f5fhWGYL679EBd0hH5-OLgtfrOtH6wInDZGwDEe=_52166_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 01/06/24 08:22AM, Christoph Hellwig wrote:
>On Mon, May 20, 2024 at 03:50:20PM +0530, Nitesh Shetty wrote:
>> +	if (blk_rq_nr_phys_segments(req) != BLK_COPY_MAX_SEGMENTS)
>> +		return BLK_STS_IOERR;
>
>This sounds like BLK_COPY_MAX_SEGMENTS is misnamed.  Right now this is
>not a max segments, but the exact number of segments required.
>
We will move this check to block layer, with name
BLK_COPY_TOTAL_SEGMENTS.

>>  /*
>>   * Recommended frequency for KATO commands per NVMe 1.4 section 7.12.1:
>> - *
>> + *
>
>Please submit this whitespace fix separately.
>
>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>> index 8b1edb46880a..1c5974bb23d5 100644
>> --- a/include/linux/blkdev.h
>> +++ b/include/linux/blkdev.h
>> @@ -1287,6 +1287,7 @@ static inline unsigned int bdev_discard_granularity(struct block_device *bdev)
>>
>>  /* maximum copy offload length, this is set to 128MB based on current testing */
>>  #define BLK_COPY_MAX_BYTES		(1 << 27)
>> +#define BLK_COPY_MAX_SEGMENTS		2
>
>... and this doesn't belong into a NVMe patch.  I'd also expect that
>the block layer would verify this before sending of the request to the driver.
>
Acked

>> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
>> index 425573202295..5275a0962a02 100644
>> --- a/include/linux/nvme.h
>> +++ b/include/linux/nvme.h
>
>Note that we've usually kept adding new protocol bits to nvme.h separate
>from the implementation in the host or target code.
>
Acked, will move it to a separate patch.

Thank you,
Nitesh Shetty

------Fualeei1.f5fhWGYL679EBd0hH5-OLgtfrOtH6wInDZGwDEe=_52166_
Content-Type: text/plain; charset="utf-8"


------Fualeei1.f5fhWGYL679EBd0hH5-OLgtfrOtH6wInDZGwDEe=_52166_--

