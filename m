Return-Path: <linux-fsdevel+bounces-15909-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CD4895A3F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 18:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7753F1C2279D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 16:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A39215AAAC;
	Tue,  2 Apr 2024 16:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="flY0qNFD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08E9159905
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Apr 2024 16:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712076791; cv=none; b=RYhbwG5Nu3k1ON4A7QzK/A3yKx3XO228XpR3eR0w3dniZ9scdTn2VgNALTquL9u5lXsqeR3R7W+dieE+hfArvsfoFO2Pzm8jyO6eK8BiMeRYu7BmfiB11FuEHGfMiSfHrFt9/RBVvCuMNTfRqN6vyTM+fRy6fF+H6uf/G+ls1MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712076791; c=relaxed/simple;
	bh=w1agtdsBR2SBdNti78hup0vYua/xnGou7f1zPIFVCAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=ShbxlncXPeDefRDqYtG7Fhv4Bzk01vE/uVZ/G3r98unQagWIDhL6jMZ93SyV/LO9GrKN/bwz4+dQ4m+ae8WlO/eV8IkjJt6LPM164ErCwlSzDGeVf2wQy84kQGneFyTQJuha53qoFj0sc/sESfO10/Vvaya4Z6qCc40e3dKxlks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=flY0qNFD; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240402165302epoutp04f570d77b72a98f83e5cdaf40f78d2744~ChMMrI5HZ2559825598epoutp04f
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Apr 2024 16:53:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240402165302epoutp04f570d77b72a98f83e5cdaf40f78d2744~ChMMrI5HZ2559825598epoutp04f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1712076782;
	bh=iuaTxcxUEp7fJFawWDMUL8hK6IywSgaftE+bl2qq/mI=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=flY0qNFDIwcbaAyevzvG150NnFJA9ft26wpuPLleqXp3Qfp4RpPVJ/ukonTATtwkp
	 xCAjjIJkxnIeKrQksSt4vlMJ7gwY9c1nNRZRsD7kHIwyJccC1aH/VlYFmF9HdQn98g
	 IdJyKNKi3YTo2Ip88MJckK6m13waCh4YoCj/OEmA=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240402165301epcas5p118eeadca6db77164336f83d57bb39c0f~ChML3fEQZ0379203792epcas5p1I;
	Tue,  2 Apr 2024 16:53:01 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4V8DTR4kXgz4x9Pv; Tue,  2 Apr
	2024 16:52:59 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	A0.27.08600.BE73C066; Wed,  3 Apr 2024 01:52:59 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240402165259epcas5p4b4917095a759a6a75975243872aa6518~ChMKDo-dz0272402724epcas5p4e;
	Tue,  2 Apr 2024 16:52:59 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240402165259epsmtrp235c085bdfebdecc1dee6291f82530d49~ChMKC9zN42557125571epsmtrp2X;
	Tue,  2 Apr 2024 16:52:59 +0000 (GMT)
X-AuditID: b6c32a44-921fa70000002198-58-660c37ebb9e7
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	29.61.08390.BE73C066; Wed,  3 Apr 2024 01:52:59 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240402165257epsmtip264e7b7edaef56996fe8c2605b894c760~ChMIf-jpQ1857018570epsmtip2g;
	Tue,  2 Apr 2024 16:52:57 +0000 (GMT)
Message-ID: <0c54aed5-c1f1-ef83-9da9-626fdf399731@samsung.com>
Date: Tue, 2 Apr 2024 22:22:56 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [Lsf-pc] [LSF/MM/BPF ATTEND][LSF/MM/BPF TOPIC]
 Meta/Integrity/PI improvements
Content-Language: en-US
To: Dongyang Li <dongyangli@ddn.com>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>
Cc: "hch@lst.de" <hch@lst.de>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>, "kbusch@kernel.org"
	<kbusch@kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <ab32d8be16bf9fd5862e50b9a01018aa634c946a.camel@ddn.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOJsWRmVeSWpSXmKPExsWy7bCmuu5rc540gzmXVCxW3+1nszjf/4Pd
	YuXqo0wWfx4aWkw6dI3RYu8tbYs9e0+yWMxf9pTdYt/rvcwWy4//Y3Lg8pjytI/d4/LZUo9N
	qzrZPDYvqfeYfGM5o8fumw1sHh+f3mLxmLB5I6vH501yAZxR2TYZqYkpqUUKqXnJ+SmZeem2
	St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QFcqKZQl5pQChQISi4uV9O1sivJLS1IV
	MvKLS2yVUgtScgpMCvSKE3OLS/PS9fJSS6wMDQyMTIEKE7IzTs99yFgwU6Di+axljA2M/3m6
	GDk5JARMJL4su8raxcjFISSwm1Fi7YFLjBDOJ0aJ6SfmQGW+MUp8fXWMCabl1p1V7BCJvYwS
	fZMuMYMkhATeMkrMWOIJYvMK2Ek83zqLFcRmEVCReNXUxAoRF5Q4OfMJC4gtKpAs8bPrAFsX
	IweHsECMxLN9riBhZgFxiVtP5oPtEhFIlLi24wcrRHwDs8S546og5WwCmhIXJpeChDkFXCUe
	HH3EBFEiL7H97RxmkNMkBA5wSHz9OIEV4mYXicezZ0PZwhKvjm9hh7ClJD6/28sGYSdLXJp5
	DurHEonHew5C2fYSraf6mUH2MgPtXb9LH2IXn0Tv7ydMIGEJAV6JjjYhiGpFiXuTnkJtEpd4
	OGMJlO0h8ePyCTZIQAGD8/HR6AmMCrOQwmQWkudnIflmFsLiBYwsqxglUwuKc9NTk00LDPNS
	y+GxnZyfu4kRnIK1XHYw3pj/T+8QIxMH4yFGCQ5mJRHen96caUK8KYmVValF+fFFpTmpxYcY
	TYGRM5FZSjQ5H5gF8kriDU0sDUzMzMxMLI3NDJXEeV+3zk0REkhPLEnNTk0tSC2C6WPi4JRq
	YDKO67hQnf+N7++3DSdd4/jPJaVYSmTwbAyUUm648/D9vz2G/T895K81bJYJMlkmFTvreIIr
	19TbIW8e5k6vujV/aY+1sB3Luhmz3v7cuCRI0uAI0+1lTaXzlxQqhN9WuJEXcdBvxbUikz/X
	ZJ882ebhlHp1gd3HVquKu79eP2Gv+cmuq19mwhfpc1YqbUdjhpDB0rR526YLPUo5/mNeWX3X
	likvf72ZcUqovdUqo3HmlCf2hyznOm/QOcdmdI771byksic7T61R3blDNc/pY/stnz8rHj0I
	UGdZ8XzBp3926ysaVlf91/v/83N91PpGd3+JWZ7d8923vhRcdbJ9Mu/qh3HsE9w1Z2xMPyGz
	frWsEktxRqKhFnNRcSIAEe1UQEoEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCIsWRmVeSWpSXmKPExsWy7bCSvO5rc540g233OCxW3+1nszjf/4Pd
	YuXqo0wWfx4aWkw6dI3RYu8tbYs9e0+yWMxf9pTdYt/rvcwWy4//Y3Lg8pjytI/d4/LZUo9N
	qzrZPDYvqfeYfGM5o8fumw1sHh+f3mLxmLB5I6vH501yAZxRXDYpqTmZZalF+nYJXBmn5z5k
	LJgpUPF81jLGBsb/PF2MnBwSAiYSt+6sYu9i5OIQEtjNKDHjyWsmiIS4RPO1H+wQtrDEyn/P
	wWwhgdeMEvM+aYPYvAJ2Es+3zmIFsVkEVCReNTWxQsQFJU7OfMICYosKJEu8/DMRrFdYIEZi
	77b1YHFmoPm3nswH2sXBISKQKLFsmzzIDcwCm5glHl/5xgSx6xujxPdZ+iA1bAKaEhcml4KE
	OQVcJR4cfcQEMcZMomtrFyOELS+x/e0c5gmMQrOQXDELybZZSFpmIWlZwMiyilEytaA4Nz23
	2LDAKC+1XK84Mbe4NC9dLzk/dxMjOOK0tHYw7ln1Qe8QIxMH4yFGCQ5mJRHen96caUK8KYmV
	ValF+fFFpTmpxYcYpTlYlMR5v73uTRESSE8sSc1OTS1ILYLJMnFwSjUw7Tq4KPJc82LHK9kX
	Y57ntwZcdtjwpnOdwdqvVReubW7u0wlaEHjv/BzFkO1cTGd3b788572u37rt1/PmH5ZTn/X6
	EfN+l9LHkx9qWy88nfE47OqcZaenFhwta2ne+rDkldBHWYc2PWuGtauv1bYu0Jtx6oz3cZEk
	L95jBw9L7pBa9upLX3ruhws6RzoUpLkfMxzf/vVPW7EeZ+LeBUmS7ibay91eK9hf6Hh9U1bE
	Y4eGiLA5m/gB06rEfxWiVbx/9xwLW7GFuauaZwH/7+UNM1Ovts2LC3gQcVX7wITY7JvaVWxn
	Dqn2rd6TcmzjhIxJ7Qkcq1cVm8pz/K7xupFrXBSsX/5m6xxmtTSuQzf+PlFiKc5INNRiLipO
	BADEA0okJwMAAA==
X-CMS-MailID: 20240402165259epcas5p4b4917095a759a6a75975243872aa6518
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240222193304epcas5p318426c5267ee520e6b5710164c533b7d
References: <CGME20240222193304epcas5p318426c5267ee520e6b5710164c533b7d@epcas5p3.samsung.com>
	<aca1e970-9785-5ff4-807b-9f892af71741@samsung.com>
	<yq14jdu7t2u.fsf@ca-mkp.ca.oracle.com>
	<ab32d8be16bf9fd5862e50b9a01018aa634c946a.camel@ddn.com>

On 4/2/2024 4:15 PM, Dongyang Li wrote:
> Martin, Kanchan,
>>
>> Kanchan,
>>
>>> - Generic user interface that user-space can use to exchange meta.
>>> A
>>> new io_uring opcode IORING_OP_READ/WRITE_META - seems feasible for
>>> direct IO.
>>
>> Yep. I'm interested in this too. Reviving this effort is near the top
>> of
>> my todo list so I'm happy to collaborate.
> If we are going to have a interface to exchange meta/integrity to user-
> space, we could also have a interface in kernel to do the same?

Not sure if I follow.
Currently when blk-integrity allocates/attaches the meta buffer, it 
decides what to put in it and how to go about integrity 
generation/verification.
When user-space is sending the meta buffer, it will decide what to 
put/verify. Passed meta buffer will be used directly, and blk-integrity 
will only facilitate that without doing any in-kernel 
generation/verification.

> It would be useful for some network filesystem/block device drivers
> like nbd/drbd/NVMe-oF to use blk-integrity as network checksum, and the
> same checksum covers the I/O on the server as well.
> 
> The integrity can be generated on the client and send over network,
> on server blk-integrity can just offload to storage.
> Verify follows the same principle: on server blk-integrity gets
> the PI from storage using the interface, and send over network,
> on client we can do the usual verify.
> 
> In the past we tried to achieve this, there's patch to add optional
> generate/verify functions and they take priority over the ones from the
> integrity profile, and the optional generate/verify functions does the
> meta/PI exchange, but that didn't get traction. It would be much better
> if we can have an bio interface for this.

Any link to the patches?
I am not sure what this bio interface is for. Does this mean 
verify/generate functions to be specified for each bio?
Now also in-kernel users can add the meta buffer to the bio. It is up to 
the bio owner to implement any custom processing on this meta buffer.

