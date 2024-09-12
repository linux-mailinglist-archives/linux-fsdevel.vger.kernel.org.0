Return-Path: <linux-fsdevel+bounces-29186-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE4F976E2E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 17:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14C26B221F1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 15:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C8C1BA872;
	Thu, 12 Sep 2024 15:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="CNy+vh8O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A74918DF90
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Sep 2024 15:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726156316; cv=none; b=lg2aQimhajtMs5gN+zfdgzyyylXWefOIBCN1NAvvA9i30w9Q+F5wFdGbaFzCxzoVMnGMTRCXOavQu50JOVpJtPUyCu5uylLy81XOrPhHdnrNrgFev4SiLMyu5xAOfIlpCk9NFP+ETpg1Uo0WZdtVveVmZAH3Yswn76IlmT9Bn+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726156316; c=relaxed/simple;
	bh=wTbyb4JSIxQua3Fg7BaVU6hlgv1ALo+han+v5ye8Ixs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=k4gysOD8y4nmljQM6mBtwMXOzqbRb7dnJTsTfQnC+QkBZYQpzeVLIijiugDyooCBevLNclVFwoaA1EnGW8eYyLxrTbv0Ai2azxOoOKesFqvZILkTAohRpbLraROD+414ZMVClb6+VguHnGSFgsA9oA75dTToxQHmPgxTbq/xsGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=CNy+vh8O; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240912155153epoutp046a418ca9b5abe99bd8dfe26b0754a00c~0igWGkpxp2414424144epoutp04T
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Sep 2024 15:51:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240912155153epoutp046a418ca9b5abe99bd8dfe26b0754a00c~0igWGkpxp2414424144epoutp04T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1726156313;
	bh=ogD3VarmZBqofCaEhBwy37cocHeN78bYb6jQ6Uf7V6o=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=CNy+vh8OlfAUQU6STxylZt3rOtST0gX7ocpkvXt9QFUBTNhJy8bxHRJElGmGABruf
	 HDeZkmkVkUTjX6d7UUq2Y5BafYfGhlkZVDWJbjkQAeta3dcaOxL2dSe+OCWtYbJQhX
	 zk83T9FA2dKm6sAUqBRC42B9iRUDRPvqZkywoo+U=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240912155152epcas5p47c5b3d0ebbc56d4fd78e412f672a032e~0igU3thP41863618636epcas5p48;
	Thu, 12 Sep 2024 15:51:52 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.178]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4X4MPg0hHXz4x9Pt; Thu, 12 Sep
	2024 15:51:51 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	81.FB.09640.61E03E66; Fri, 13 Sep 2024 00:51:50 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240912155150epcas5p47d1adaf8b89a69cdebdac6ebfad00663~0igTZuNAW0514805148epcas5p46;
	Thu, 12 Sep 2024 15:51:50 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240912155150epsmtrp2ee57b040836e07263dc1e25e003501ec~0igTYzFHe3192931929epsmtrp2E;
	Thu, 12 Sep 2024 15:51:50 +0000 (GMT)
X-AuditID: b6c32a49-a57ff700000025a8-2d-66e30e164cb8
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	49.30.08456.61E03E66; Fri, 13 Sep 2024 00:51:50 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240912155147epsmtip2d84c7ce9c50e2549b6ff95529e30eb1f~0igQkXeS-0142101421epsmtip2g;
	Thu, 12 Sep 2024 15:51:47 +0000 (GMT)
Message-ID: <fccc2e54-a854-d6af-845b-dac27ed736f3@samsung.com>
Date: Thu, 12 Sep 2024 21:21:46 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH v5 2/5] fcntl: rename rw_hint_* to rw_lifetime_hint_*
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, kbusch@kernel.org, sagi@grimberg.me,
	martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
	brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	jaegeuk@kernel.org, jlayton@kernel.org, chuck.lever@oracle.com,
	bvanassche@acm.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
	gost.dev@samsung.com, vishak.g@samsung.com, javier.gonz@samsung.com
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20240912125438.GB28068@lst.de>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TfVBUdRTt997b3QfT6nOR+MFIwJuhERTYjWV9ECCVxlM0mSH/URlc4AnE
	8nZnPyocGtEUjApkG1A2iA9JAxN1AQFxR0IawkJADNu1BYJdaUDAYKhAwfYDi//OvXPOPXPu
	nYujguM8LzyDVTNKViojua7Y9dsBm4NeWTd+RFg8E0ldMhdxqanbc4AqfbKIUs/NEwhl7GhD
	qLpLPyDUV2c/QSjLFR1KXSvCqfHf5nnU4oV6HqXtHAKUwbSFulcTS9009GBU5QUrj/rsQSuX
	uti9glANU7MY1bfczaH6dOW8GHd68H4c3Td8DaNLtXe49GCvhtbXf8qlG2uP0e1V8wjdbszl
	0n9aTRhd2FQP6J+runj0vP5VWm+ZRuL5BzIj0xlpKqP0ZdgUeWoGmxZFxiUkvZ0UJhGKgkTh
	1DbSl5VmMVHkjj3xQe9kyGxxSd8PpDKNrRUvVanIkOhIpVyjZnzT5Sp1FMkoUmUKsSJYJc1S
	adi0YJZRR4iEwtfDbMTDmeknGwIUVt5H+t5naC6o5hYAFxwSYlhZO8grAK64gGgHcOREKeIs
	5gDsNz7gOou/AOwaesp7IdEZHwI7FhAGAJdrQpykaQAHLlsdJD4RDX+sbkHsGCP8oWmkbrW/
	AfaUWTA7dieS4dIv5Y5BbsQueLVxzMFBCQ9oslQ6tBsJElone4HdACWWUbj89zCnAOA4lwiA
	/V9q7BwXYitc+acAdWp9YMt0OWrnQ+KiC+w1HOfa+ZDYAfXfxjkDuMHJ7qbVMF5wfsawuotM
	ODo2ijlxDmxtLOQ48XaY++xXhy1qs71yI8RptQ5+8dSCOKfz4ek8gZPtB4e11lWlB/z9XO0q
	pqFxtonjXJURQL1Jj50Bvro1W9GtSa9bk0b3v3MVwOqBJ6NQZaUxqjCFiGU+/O/cKfIsPXD8
	QuCuVmAefRLcCRAcdAKIo+RGvpY7dkTAT5VmH2WU8iSlRsaoOkGY7TzFqJd7itz2TKw6SSQO
	F4olEok4PFQiIj34U6cqUgVEmlTNZDKMglG+0CG4i1cuAvivbX0TnWx4DDdlJ9yqmI1+NBXl
	5z1bUhPZdrqL2bLz5cd+wUbikODz/cnJOa4l1ftUwUXrEzbFzPhZxAtLe9Th+/due7fOXzt+
	tVmi9jfl9gzclEx/fzivXbg5dsTvbIqr4nqJt6Rvn3l7hyC0LCJ74jvOuPxcnMXzjcDmkqEN
	zWdMC/7dRxPdgoofecdZ5u4Wxp7M3+vD9ssvG/ntS4d29xx8P0+WOj15ntMvXq4zo4kR+MM6
	08pBICXRtxYm/D0X23D+iXt3hgzCzJjn39ydrch5yTNRW3nsVsd5n6qPzX/caJMJftodeyp0
	pqj5PfY+ZmbTvi7PN2rzD7QMlK0PIDFVulQUiCpV0n8BX9Ejc5QEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRmVeSWpSXmKPExsWy7bCSvK4Y3+M0gz37pC1W3+1ns3h9+BOj
	xbQPP5kt/t99zmRx88BOJouVq48yWcye3sxk8WT9LGaLjf0cFo/vfGa3+LlsFbvFpEPXGC32
	3tK2uLTI3WLP3pMsFvOXPWW36L6+g81i+fF/TBbrXr9nsTj/9zirxflZc9gdRD0uX/H2OH9v
	I4vHtEmn2Dwuny312LSqk81j85J6j90LPjN57L7ZwObx8ektFo++LasYPc4sOMLu8XmTnMem
	J2+ZAnijuGxSUnMyy1KL9O0SuDJa1mkWPGWv2HT2D3MD40K2LkZODgkBE4lZN28zdjFycQgJ
	7GaUOPrhIQtEQlyi+doPdghbWGLlv+dgtpDAa0aJKVNdQGxeATuJEwu3M4HYLAKqErfur2SH
	iAtKnJz5BGyOqECSxJ77jWA1wgKeEhs2PwKrYQaaf+vJfLC4iICSxNNXZ8GOYBb4yyyx+vMv
	qItuMkr8OrSPuYuRg4NNQFPiwuRSkAZOAR2Jfz+6mCEGmUl0be1ihLDlJba/ncM8gVFoFpI7
	ZiHZNwtJyywkLQsYWVYxSqYWFOem5xYbFhjlpZbrFSfmFpfmpesl5+duYgQnAS2tHYx7Vn3Q
	O8TIxMF4iFGCg1lJhHcS26M0Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4rzfXvemCAmkJ5akZqem
	FqQWwWSZODilGphkraZsaaoo/81ur8Jzn333hJZlD1qVKv1PKz+Oj/V2Y3nzTWXq4eoOofly
	H5+IXuLNvv7YwFdDSK7ptg6nv5f41rcv7DZaxT3rtvp1c+mSiluO7VPLWj+taOu53++lVdPf
	NM31/tSPP3dkF85VicvrNA1LYprxM4zbfNGB78wzft+1Ndkm7nF/+7bj3Mtidf913k1p77/L
	0Xzlycv8rbY/LzU1/LjK6GxganWo7cZzvrd9aR/CBTXupG1XnNe21cr5+m3Hay0eerxhD4un
	zhStfGdeeOTEDMEvv80mzmfgkdFmfniOf/mPNDO7lwlvbq06vLdJ4YDLF3VT5tVfPRa9dTRb
	d+uygPPUU0wxAlOVWIozEg21mIuKEwHcVuI6cQMAAA==
X-CMS-MailID: 20240912155150epcas5p47d1adaf8b89a69cdebdac6ebfad00663
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240910151048epcas5p3c610d63022362ec5fcc6fc362ad2fb9f
References: <20240910150200.6589-1-joshi.k@samsung.com>
	<CGME20240910151048epcas5p3c610d63022362ec5fcc6fc362ad2fb9f@epcas5p3.samsung.com>
	<20240910150200.6589-3-joshi.k@samsung.com> <20240912125438.GB28068@lst.de>

On 9/12/2024 6:24 PM, Christoph Hellwig wrote:
> On Tue, Sep 10, 2024 at 08:31:57PM +0530, Kanchan Joshi wrote:
>> F_GET/SET_RW_HINT fcntl handlers query/set write life hints.
>> Rename the handlers/helpers to be explicit that write life hints are
>> being handled.
>>
>> This is in preparation to introduce a new interface that supports more
>> than one type of write hint.
> 
> Wouldn't it make more sense to stick with the name as exposed in the
> uapi? 

uapi used
for opcode: F_GET/SET_RW_HINT
for values: RWH_WRITE_LIFE_*.

The kernel handlers were using the name rw_hint_* (e.g., rw_hint_valid, 
fcntl_get/set_rw_hint etc.). Since rw_hint is generic term, it seemed 
clearer to call a spade a spade (e.g. rw_lifetime_hint_valid, 
fcntl_get/set_lifetime_hint).

  The same minda applies to the previous patch - in fact IFF we
> decide to do the rename I'd probably expect both parts to go together.
> 

Sure. I can merge both the patches if that's what you prefer.

