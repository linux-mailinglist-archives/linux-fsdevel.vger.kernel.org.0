Return-Path: <linux-fsdevel+bounces-29469-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C08A997A312
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 15:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3D921C222F6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 13:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D90A156887;
	Mon, 16 Sep 2024 13:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qd+4bIdJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAC0155359
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Sep 2024 13:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726494579; cv=none; b=nNJA3Drq+/oO2KJHbvHlD3qbIvNvqFUgMe0PRzW11fZ0rSB+15Ami2Lf9gHCQoZCbU4XaZKxTnBQUuL7aF2h0Q4CbkNGeEHLhKKoZSCPGpGolmFDfLuU67J7hansqqCLeL6MQfZQYFrSs6PL7IQpIp8BM3d0xa2CkpwmMFzyVbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726494579; c=relaxed/simple;
	bh=G8Oz+Ug+9Wk/KwV2QARt398HRFbV6Qtlxo8ZxcG9hkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=PaauaNwVFzx/nE4Qu8SbHJ58mHQB5ygLzMRNALQSlpDnoNExqX4WlJOaRc+9gWIjeM6Aq7T6zfD/p+6E6L1aVVOYFeJH/CwaTtaHK235wT5W40fw8mys0cSDT9Oeh1OTHwkDHAOyQlTM2kG7J6nwTC+3sw7/n1hU7P3P/hhrNPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=qd+4bIdJ; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240916134929epoutp0150e4e90b88bc1da047fa9e8250863eb1~1van06N6j0226802268epoutp01Z
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Sep 2024 13:49:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240916134929epoutp0150e4e90b88bc1da047fa9e8250863eb1~1van06N6j0226802268epoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1726494569;
	bh=BFqkL5mVC2rMqwvnxCQzzd01AUlbkq9ItY512dFJKEU=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=qd+4bIdJ5q+l6jSQ5QaQB2B32T7O+8lGcAi85+xiuHx/55y70FSUDNRQBiO+3tS8K
	 3Y2URf6yxbnA8zbFAicMRuWuztpI5y9bujEku0fFoKPTfbUNXKqaciOsVKU/D7YQTF
	 ENrWrWEa4/vRtkarxuN1MmGKdtamyUML4+TtQNKs=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240916134927epcas5p26a35ee17ef7995c6f226ca8d18e05809~1vamGwbwN0311103111epcas5p2h;
	Mon, 16 Sep 2024 13:49:27 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4X6mVZ2M2Dz4x9Pv; Mon, 16 Sep
	2024 13:49:26 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	6C.32.09640.66738E66; Mon, 16 Sep 2024 22:49:26 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240916134925epcas5p3771dd61e689dd5669b51c1183e382f4b~1vajzurKW0738707387epcas5p3V;
	Mon, 16 Sep 2024 13:49:25 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240916134925epsmtrp237639dd21ae5f1aede967bd1a37e60ad~1vajyzvUl1077710777epsmtrp2D;
	Mon, 16 Sep 2024 13:49:25 +0000 (GMT)
X-AuditID: b6c32a49-a57ff700000025a8-7f-66e8376665a5
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	16.1F.08964.56738E66; Mon, 16 Sep 2024 22:49:25 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240916134922epsmtip21edf3a4cb3ab814ba4bb88bd4261e273~1vag57usc2461424614epsmtip22;
	Mon, 16 Sep 2024 13:49:22 +0000 (GMT)
Message-ID: <4a39215a-1b0e-3832-93bd-61e422705f8b@samsung.com>
Date: Mon, 16 Sep 2024 19:19:21 +0530
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
In-Reply-To: <20240913080659.GA30525@lst.de>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta0xTZxjed07pRQY7Fjo+ybjYyYIwLh2lfDhgSzR6XF1Csi1MjEKFw2WU
	tukFdY5Y5jYEBAYycRUGKKDUxSo4BQq4cQnRcIuoVQSG2CrIGNdoGDLW9rCNf8/7fs/zPe8l
	LxvnZrPc2akyNaWUSaR85gbG9Y6tvgFJYRNJwZ3zzujSSCETTXXMA3R6dglHqyPPMPTw1yYM
	1V3qwtDZ0uMYMht0OLpayEZPhhdYaKlWz0LF7fcBah3yR3fO7UItrbcYqKLWwkJ5pkYmutD9
	N4auL1fg6PLUDAP1r3Q7oH5dGevDN8nBu2Kyf/QqgzxdfJtJDvZqyHp9DpNsqD5GGisXMNL4
	UMsk5yxDDLLgmh6QPZWdLHKh3pOsN09j0U6xaREplCSRUnpTsgR5YqosOZIv/iRue1yoKFgQ
	IAhHYXxvmSSdiuTv2BMdsDNVau2Z750hkWqsqWiJSsUPiopQyjVqyjtFrlJH8ilFolQhVASq
	JOkqjSw5UEaptwmCg98LtRLj01Ke/VLCVHzjc/jc5BKuBdUeuYDNhoQQZvdtygUb2FzCCOCD
	CQOLDuYBHCxbwOjgBYCLRQ0gF3Dsiqbh8wz6oRXAE8snAR1MA1jR0MawsZyIKFhvNDrYMIPw
	gfcLh1l0fiO89aPZzuERB+Ff98rsv7oQkTAv32TP44QbHDJXYDbsSvCh5Xmv3QAnahmwZq6f
	aSucSWyFA6c0Ng6HeBcuPbntQGu94I3pMtzGh4SBA7tNE0y67B3QVPQ7i8Yu8Hn3tTXsDhf+
	bF3jpMGx8TEGjb+CjQ0FDjT+AGpfPXCw+eJWX0NzEO3lDPOXzRg9Ryd44jsuzd4MR4sta0o3
	+PhMtQNNIWFX1tqor2Bwpmmc9T3w1q2bim5d97p13ej+N64EDD3YRClU6cmUKlQhkFGH/tt3
	gjy9Htgvwm93IxgZmw1sBxgbtAPIxvmuTpHLliSuU6LkyJeUUh6n1EgpVTsIta6nCHfnJcit
	JyVTxwmE4cFCkUgkDA8RCfhuTlPflidyiWSJmkqjKAWl/FeHsTnuWizwaLemvXa+jCuFrvLJ
	lbZDztv9oxxvGGuqXGJCs4ZnnuZP6OfffuuMWmoQ64VH8Xz/3b5hLZ+bPh196mgxdpUEfXzq
	ck6vN3dvdukfdarVmPDNkx4os1TPyTWEvJitPz+n4+3p9d02ffi39J6vP3L8ovxm7MtXPgMx
	eMe+ldWbLQNnVzKzXs8IFw8diQ3r8VkM+WH/1E/z4i1e71z5LHf8kdfPBbhnrXuV4QIrotnT
	a7HczzNm71LORu2jClG8b7F0X+PFqaoSt6S2ZnjcIy7nIqsS8UbMWyaXa5h3D2qVuzJfHovo
	yz+ws+HeNE/cnoeZOftfKzDV9T2OB+/zMjoP3HmDz1ClSAR+uFIl+QfgcR/PmgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsWy7bCSvG6q+Ys0g+9vRCxW3+1ns3h9+BOj
	xbQPP5kt/t99zmRx88BOJouVq48yWcye3sxk8WT9LGaLjf0cFo/vfGa3+LlsFbvFpEPXGC32
	3tK2uLTI3WLP3pMsFvOXPWW36L6+g81i+fF/TBbbfs9ntlj3+j2Lxfm/x1ktzs+aw+4g5nH5
	irfH+XsbWTymTTrF5nH5bKnHplWdbB6bl9R77F7wmclj980GNo+PT2+xePRtWcXocWbBEXaP
	z5vkPDY9ecsUwBvFZZOSmpNZllqkb5fAlfF86xS2ghbVikUvfzI3MC6R7WLk5JAQMJHYeWcx
	SxcjF4eQwG5GifVHn7NAJMQlmq/9YIewhSVW/nvODlH0mlHi5t5mNpAEr4CdxKbdu1lBbBYB
	VYlr/XfYIeKCEidnPgEbJCqQJLHnfiMTiC0sYCvR3XsdLM4MtODWk/lgcREBJYmnr84ygixg
	FljGInFwylsmiG0bmCT+H94NNJWDg01AU+LC5FKQBk4BHYmfj0+xQgwyk+ja2sUIYctLbH87
	h3kCo9AsJHfMQrJvFpKWWUhaFjCyrGKUTC0ozk3PLTYsMMxLLdcrTswtLs1L10vOz93ECE4J
	Wpo7GLev+qB3iJGJg/EQowQHs5IIr+3vp2lCvCmJlVWpRfnxRaU5qcWHGKU5WJTEecVf9KYI
	CaQnlqRmp6YWpBbBZJk4OKUamK4l+DNkGAsZRG8ubjnim8D7Rp7vkYI+f8jxkouH2a/mPT1z
	55laSfmznO+LJ3T7rLydb2Q4Q4U9Zt0/xtkzP66L++S19Hu5v1Tsqiij5FtG+vL7IxX/ivlE
	ynRdjDH6vYRzylExAYYT+humPaiYwpw4eXa7dGbvrDhXIfPrx5Uv+ffL1y4Peq16ZIb8P/uu
	xza13xmeKtmn8m9Lajw5dUrWtokukbXL2b9OK79T9V5GUqzRquOS4at/Um/1rVnv5Csv37jz
	aeajaEHhwxL67jrTO7sf8KokpvAXtt3V+nlIke2dwfHorMKDOqJ/lDf/lLA/cWp7ZmLsBaci
	mct5Tu72LtLsqm/FfjV8UalTYinOSDTUYi4qTgQArd2N5XgDAAA=
X-CMS-MailID: 20240916134925epcas5p3771dd61e689dd5669b51c1183e382f4b
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

On 9/13/2024 1:36 PM, Christoph Hellwig wrote:
> On Thu, Sep 12, 2024 at 10:01:00PM +0530, Kanchan Joshi wrote:
>> Please see the response in patch #1. My worries were:
>> (a) adding a new field and propagating it across the stack will cause
>> code duplication.
>> (b) to add a new field we need to carve space within inode, bio and
>> request.
>> We had a hole in request, but it is set to vanish after ongoing
>> integrity refactoring patch of Keith [1]. For inode also, there is no
>> liberty at this point [2].
>>
>> I think current multiplexing approach is similar to ioprio where
>> multiple io priority classes/values are expressed within an int type.
>> And few kernel components choose to interpret certain ioprio values at will.
>>
>> And all this is still in-kernel details. Which can be changed if/when
>> other factors start helping.
> 
> Maybe part of the problem is that the API is very confusing.  A smal
> part of that is of course that the existing temperature hints already
> have some issues, but this seems to be taking them make it significantly
> worse.

Can you explain what part is confusing. This is a simple API that takes 
type/value pair. Two types (and respective values) are clearly defined 
currently, and more can be added in future.

> Note: this tries to include highlevel comments from the discussion of
> the previous patches instead of splitting them over multiple threads.
> 
> F_{S,G}ET_RW_HINT works on arbitrary file descriptors with absolutely no
> check for support by the device or file system and not check for the
> file type.  That's not exactly good API design, but not really a major
> because they are clearly designed as hints with a fixed number of
> values, allowing the implementation to map them if not enough are
> supported.
> 
> But if we increase this to a variable number of hints that don't have
> any meaning (and even if that is just the rough order of the temperature
> hints assigned to them), that doesn't really work.  We'll need an API
> to check if these stream hints are supported and how many of them,
> otherwise the applications can't make any sensible use of them.

- Since writes are backward compatible, nothing bad happens if the 
passed placement-hint value is not supported. Maybe desired outcome (in 
terms of WAF reduction) may not come but that's not a kernel problem 
anyway. It's rather about how well application is segregating and how 
well device is doing its job.

- Device is perfectly happy to work with numbers (0 to 256 in current 
spec) to produce some value (i.e., WAF reduction). Any extra 
semantics/abstraction on these numbers only adds to the work without 
increasing that value. If any application needs that, it's free to 
attach any meaning/semantics to these numbers.

Extra abstraction has already been done with temperature-hint (over 
multi-stream numbers). If that's useful somehow, we should consider 
going back to using those (v3)? But if we are doing a new placement 
hint, it's better to use plain numbers without any semantics. That will 
be (a) more scalable, (b) be closer to what device can readily accept, 
(c) justify why placement should be a different hint-type, and (d) help 
Kernel because it has to do less (no intermediate mapping/transformation 
etc).

IMHO sticking to the existing hint model and doing less (in terms of 
abstraction, reporting and stuff) in kernel maybe a better path.

> If these aren't just stream hints of the file system but you actually
> want them as an abstract API for FDP you'll also need to actually
> expose even more information like the reclaim unit size, but let's
> ignore that for this part of the discssion.
> 
> Back the the API: the existing lifetime hints have basically three
> layers:
> 
>   1) syscall ABI
>   2) the hint stored in the inode
>   3) the hint passed in the bio
> 
> 1) is very much fixed for the temperature API, we just need to think if
>     we want to support it at the same time as a more general hints API.
>     Or if we can map one into another.  Or if we can't support them at
>     the same time how that is communicated.
> 
> For 2) and 3) we can use an actual union if we decide to not support
> both at the same time, keyed off a flag outside the field, but if not
> we simply need space for both.
> 

Right, if there were space, we probably would have kept both.
But particularly for these two types (temperature and placement) it's 
probably fine if one overwrites the another. This is not automatic and 
will happen only at the behest of user. And that's something we can 
clearly document in the man page of the new fcntl. Hope that sounds fine?

