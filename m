Return-Path: <linux-fsdevel+bounces-29626-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5018497B939
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 10:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CF881F25151
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 08:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49AA917A5B2;
	Wed, 18 Sep 2024 08:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="W3aO/XXY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35174176AAE
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Sep 2024 08:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726647537; cv=none; b=Jl4VbpRKl2UMIyNnclw4yOsZRmIXwHF4YRSSzW2LvRgSHzato0CKt/YKAwzbc2ChSadERgSCy3zft0JqHBcsafyNo1Y7Zf4Ed47I7iZ2/kWIp70p7UU06EVzHxhtJ4qm5tOs2lD2kXc+D26y2OZlhvqxqikUQ4DPlcAwnakfRHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726647537; c=relaxed/simple;
	bh=hVS5/dLEpOOKYrRO9sHjVFV8c2Fp1IrgklMi3vZotYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=MxdVOzK8eslg/wYmhHUCXZHbX/rL/CfIkkw8UGm7hJA1uDnncximZfb+dYTTRJWf5BQlaIJOf7ggWwVhX8taMzJPIk3ryMprkSsUom+yEnv5LEXOkcQI/mRPUGlt3tm9vQ3k1x4IXQekycRJhi8OkwLHB2yzHRxfjTrM2hdwxD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=W3aO/XXY; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240918081259epoutp04c265e515e4a56cfb46525f6438392859~2SHYUWU4o1374213742epoutp04U
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Sep 2024 08:12:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240918081259epoutp04c265e515e4a56cfb46525f6438392859~2SHYUWU4o1374213742epoutp04U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1726647179;
	bh=FoClbYiaISSy4tE9A/eMkUtSrOUByd+2+OMRpBKthhQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=W3aO/XXY8kdv50riW7NNgh22FeVNbrsdEJK5EOR2GxPimr+vhWpzIvGHoMljFTNUo
	 aDvSqSeyn8++P4WKaSD2qPPbxI/CZepf5fnBXeRHL+1l0e1Z0l7AGxOmvg9bUd91A3
	 JbwUZfi5chpTViM/uhMO0dTai/T/Jut9Fx12IO9o=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240918081258epcas5p1823dac2b9a9e6de8274eb13f917c7f68~2SHXsXn9c2910929109epcas5p1C;
	Wed, 18 Sep 2024 08:12:58 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.178]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4X7rxN46Jdz4x9Pw; Wed, 18 Sep
	2024 08:12:56 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	17.5C.09642.88B8AE66; Wed, 18 Sep 2024 17:12:56 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240918081255epcas5p274303a976333fd9a6c74ae0ff2147342~2SHUxomyX0868808688epcas5p21;
	Wed, 18 Sep 2024 08:12:55 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240918081255epsmtrp26af4e1a22d02d7d933be6f1d3f42a37c~2SHUwqAVe0537805378epsmtrp29;
	Wed, 18 Sep 2024 08:12:55 +0000 (GMT)
X-AuditID: b6c32a4b-879fa700000025aa-94-66ea8b886ab7
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	71.6F.19367.78B8AE66; Wed, 18 Sep 2024 17:12:55 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240918081252epsmtip18dd83ba1309566b2e110c9a05d3ffe5d~2SHR36ysF1791217912epsmtip1_;
	Wed, 18 Sep 2024 08:12:52 +0000 (GMT)
Message-ID: <197b2c1a-66d2-5f5a-c258-7e2f35eff8e4@samsung.com>
Date: Wed, 18 Sep 2024 13:42:51 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH v5 4/5] sd: limit to use write life hints
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, kbusch@kernel.org, sagi@grimberg.me,
	martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
	brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	jaegeuk@kernel.org, jlayton@kernel.org, chuck.lever@oracle.com,
	bvanassche@acm.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
	gost.dev@samsung.com, vishak.g@samsung.com, javier.gonz@samsung.com, Nitesh
	Shetty <nj.shetty@samsung.com>
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20240918064258.GA32627@lst.de>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te1BUdRSe3713X4wLlxXiByNCl8oweawu9MMBskHzjlSD08OJmYINLo8W
	dnf2QUaOgQ6o0IJiAa0UZAjDQhKPlOeUEBIKw2NBZAWGxzICOxiPqMzCdvei8d93znzfOd85
	Zw4fF2XxPPjJcg2jkktTKK4Dca3Td5ff2dzFhMB7tyGqnsjnIkvnKkCFyw9x9HjiPobGfm7G
	UFV1F4YuFZ3GkLlWj6O6fD6aHV/joYcVBh4q6LgDULvpJTR0+TBqa+8hUGnFHA/ljjZxUWX3
	BoauPSrF0VXLbwTq/7ebg/r1JbwDz9DG4Ui6f7KOoAsLbnFpY5+Wrjec49IN5Z/RrWVrGN06
	lsGlV+ZMBJ3XaAB0b9kvPHqtfiddb17CooTRstAkRhrPqLwZeZwiPlmeGEZFvhUTERMUHCj2
	E4eglylvuTSVCaMOvh7l91pyinVmyjtNmqK1pqKkajUVEB6qUmg1jHeSQq0JoxhlfIpSovRX
	S1PVWnmiv5zR7BcHBu4NshJjZUmfDw5wlNcdjj+utYAM0MDPAQI+JCVwuLgXzwEOfBHZCmDj
	jSYuG6wCOJRVjT8NFn7P5D2RfDNfRdiwiGwG8NSQgsVLAFb1ptqwkAyHv07m2PkE+TxcqPmO
	x+adYc9XZrvWlfwQ/j1SAmx4OxkGc3Wj9jxOukGTuRSzYReSgnOLfcBmAicrCHhlpd9qj8/n
	kr5w4KLWxhGQe2Cd7jKP1XrB60sldtOQrBTAm/Umjo0PyYOwrS+C9b8dLnY3bs7iAdcetHNZ
	LINTM1MEi0/ApoY8DotfgRn/3LWXwa1ta1sC2FaOUPfIjLHVhfBstohlPwsnC+Y2lW5wurh8
	0wANuzLd2W1O4NBiMPLOA2/9lqXotwyv3zKM/v/GZYAwAHdGqU5NZNRByn1y5uOn145TpNYD
	+z/sjmwCM1PL/h0A44MOAPk45SJ0W15IEAnjpZ+kMypFjEqbwqg7QJD1OhdwD9c4hfWh5JoY
	sSQkUBIcHCwJ2RcsptyElqyv40VkolTDyBhGyaie6DC+wCMDa+vb8ULV6R/y704fvXXMvfe9
	FaVO5i6oLs/D4978oDLHs0szfiTnfcvoqFC/d6yiPFOOe01/75jsEuN8ONx5ZjXgAPBZ93Eu
	bPG4GXvIOO7+9kbRydmWvFNpsaGjdETBxfOHRiTvOKzmmiLGa350ZH7aP1PXqJB9aijNPhYN
	3cadPjqhKPpSt61wCKu8Gu6aftSpMyFWULto7DPtrLnhy9lBLomcj6Q7tFfNEsPpJx+sc0e+
	9do10a1xjV7OOXNpz/35jXc3BoSv3uEgT6QxXwh/UWI8LhyUXfmi47n5cz1U7BtTqvV7s91n
	PNuW/mgu99ElVBQPDv/lhJtuT61mj6Rt+5Mi1ElS8W5cpZb+B0mzXdSYBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0xSYRzGe885co401pE032WzIq1RaNnF3nX/0NZZrVZtWatlUp7IKegO
	YYq5rFwlFF1nkywdGYW2DKywhV0085KmaVNy0WVBF5kVUZmVmcDa/Pbb8+x5/s+HP4ULXxPj
	qRTFbpZTSNNEPD5xq04UGXNY27tzlsE2GlU4jvOQu+4rQIVfBnA05HiPoef3b2PIVFGPoXNn
	D2LIWanHkfk4hd6+8JJowFhOolO1XQDV9MxAHYYVyFbTRKASo4tE2u5qHrrc8BdDt36X4Oia
	+zOB2gYbglCbvphcNo7pfLaKaXtpJpjCU808prNVxVjKC3hMVdk+5k6pF2PuPM/jMR5XD8Ho
	bpQDpqX0Icl4LZGMxdmHrRVs5i9KZtNSMllu5pIk/q6jT9uDMqz8rKFKN8gDVZQGBFOQngsv
	fDARGsCnhLQVwP5ObVDACIcHu36SAR4LTX/f+1lIuwG0GeN8LKCXwMaXGr9O0NHw49WLZEAP
	gU1FTsLHYfR2aHu1H/PxWHox1B7r9uv4cH+Ps8Svh9Ii6OptBb4ROG0k4IMzfVhgkQOH7/44
	hxdRFI8Ww/bTKl8gmJZA8zEDGSiKh5qbGhDgidDaV4yfAEL9iB36Eff0IyL6EZFSQJSDMDZD
	KZfJd2TExSqlcqVKIYvdkS63AP8TTF9fDYyVg7G1AKNALYAULgoVhH/5uFMoSJZmq1kufRun
	SmOVtSCCIkThgilpBclCWibdzaaybAbL/XcxKnh8HlaRvdQiGVKIPwzUGa5MjioLCsmLmOC5
	aq1yL9R52iOrtZ9WRqoULR6r6lJLIp4Yn33v5ALdr4Jp0ed/mFB0uupNroT6OmrO4/6obml+
	yJ4962aoc3TXWsMatZy2CJZcT/085ltWgiL3gHrl5B+DOtMRA9cFKvd6vQydk7P8Ebaow47P
	T1xQH5WUVUyKtq45i3lWV9dH1HfaJ9ibWvuLUprncfn7xF0bzKXBktDmu9pMdVRFzbtDWzY5
	XDaz2iWWm97EfLe0NxZvrbkbo39gP8/MnirWC2+Eo8aGTLFsf+8TicPUcs4qm7vxSrw9blnf
	7/SkwwlrxuUy2KQV150iQrlLGjcd55TSfwfhi8FzAwAA
X-CMS-MailID: 20240918081255epcas5p274303a976333fd9a6c74ae0ff2147342
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240910151057epcas5p3369c6257a6f169b4caa6dd59548b538c
References: <20240910150200.6589-1-joshi.k@samsung.com>
	<CGME20240910151057epcas5p3369c6257a6f169b4caa6dd59548b538c@epcas5p3.samsung.com>
	<20240910150200.6589-5-joshi.k@samsung.com> <20240912130235.GB28535@lst.de>
	<e6ae5391-ae84-bae4-78ea-4983d04af69f@samsung.com>
	<20240913080659.GA30525@lst.de>
	<4a39215a-1b0e-3832-93bd-61e422705f8b@samsung.com>
	<20240917062007.GA4170@lst.de>
	<b438dddd-f940-dd2b-2a6c-a2dbbc4ee67f@samsung.com>
	<20240918064258.GA32627@lst.de>

On 9/18/2024 12:12 PM, Christoph Hellwig wrote:
>>> If the device (or file system, which really needs to be in control
>>> for actual files vs just block devices) does not support all 256
>>> we need to reduce them to less than that.  The kernel can help with
>>> that a bit if the streams have meanings (collapsing temperature levels
>>> that are close), but not at all if they don't have meanings.
>> Current patch (nvme) does what you mentioned above.
>> Pasting the fragment that maps potentially large placement-hints to the
>> last valid placement-id.
>>
>> +static inline void nvme_assign_placement_id(struct nvme_ns *ns,
>> +					struct request *req,
>> +					struct nvme_command *cmd)
>> +{
>> +	u8 h = umin(ns->head->nr_plids - 1,
>> +				WRITE_PLACEMENT_HINT(req->write_hint));
>> +
>> +	cmd->rw.control |= cpu_to_le16(NVME_RW_DTYPE_DPLCMT);
>> +	cmd->rw.dsmgmt |= cpu_to_le32(ns->head->plids[h] << 16);
>> +}
>>
>> But this was just an implementation choice (and not a failure avoidance
>> fallback).
> And it completely fucks thing up as I said.  If I have an application
> that wants to separate streams I need to know how many stream I
> have available, and not fold all higher numbers into the last one
> available.

Would you prefer a new queue attribute (say nr_streams) that tells that?

