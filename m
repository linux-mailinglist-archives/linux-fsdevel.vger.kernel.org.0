Return-Path: <linux-fsdevel+bounces-29953-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89018984209
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 11:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 027301F23C66
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 09:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125AC177992;
	Tue, 24 Sep 2024 09:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="DRzdAs3Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF441714CC
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Sep 2024 09:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727169912; cv=none; b=V5hgqhpXkNRNi0wcMgTq90gwiH/t9kaAi/W9nE0gMTHsnM+gr2vS+KrTBqVaZq4a108gdG/3Pm2gRp8mTkm6WPkk/SMBN6YDjNUO8VmRoOF4NkGQAXoHdAiCmIFaTdlr+i300fOhG8h161vvYgQPdd4rh9bbk2FAS18LNyIoJZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727169912; c=relaxed/simple;
	bh=dNHi3O2X2k099XP44w2M/mi53+tBlMIsNqguMCPtdWw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=F3qzg2aFOQQFO4eL5Cj0IeV9f6Kr4amF2IkOAbOQjhTSRNolY9eL38h25swno91jWFWGRMSRAO/KL53N87DhnEXcfyAmMxqBT5tomUUbtYECz/e4YINQ20HysiCra5d9MWjmdvF3GL9o4UrC6yLVLO5W5ihv//cDPy+jx9feAJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=DRzdAs3Q; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240924092502epoutp04e8dc5063bb7b4b6460ec3e5db42d2656~4I_A1mYQ01410314103epoutp04f
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Sep 2024 09:25:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240924092502epoutp04e8dc5063bb7b4b6460ec3e5db42d2656~4I_A1mYQ01410314103epoutp04f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1727169903;
	bh=ujjozdZ0S6smtIOf2Eo64izQZAki0Dpgi2fL4KYD0eo=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=DRzdAs3QWhKDnHH2NVAMWRA7Ft3n+f+xxAm724jDu+lihzspJUgS+Y9br3V8hxIH+
	 Z3QVZHILd0aBm29DI4/sRJSTG5oBDL8ME2M0JaL+P3k18e87exOVmbIsbb0n39KtKj
	 DKauxVWTJIBdoRvHwLO64WyEwmHUWE6e3Of7LM6Q=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240924092501epcas5p3f637377fab6c1cc78535ad611ec3c268~4I9-tP-SU2625526255epcas5p3P;
	Tue, 24 Sep 2024 09:25:01 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4XCZFm1yQRz4x9Q8; Tue, 24 Sep
	2024 09:25:00 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	AE.0F.08855.C6582F66; Tue, 24 Sep 2024 18:25:00 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240924092459epcas5p23e41d7dfa92acf415d9dab1d0e433842~4I9918t0b2825728257epcas5p2N;
	Tue, 24 Sep 2024 09:24:59 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240924092459epsmtrp2deb043bef0671cc130aa36af932e5811~4I991DpJu0725707257epsmtrp2I;
	Tue, 24 Sep 2024 09:24:59 +0000 (GMT)
X-AuditID: b6c32a44-15fb870000002297-2f-66f2856cb18c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	AF.28.19367.B6582F66; Tue, 24 Sep 2024 18:24:59 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240924092456epsmtip18d685cf23e102be2cbcceaf47e18117b~4I960RNvX2191221912epsmtip1D;
	Tue, 24 Sep 2024 09:24:56 +0000 (GMT)
Message-ID: <edcbf69e-9ae9-06df-60c0-47393371fcd8@samsung.com>
Date: Tue, 24 Sep 2024 14:54:51 +0530
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
In-Reply-To: <20240918120159.GA20658@lst.de>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xbdRTH/d17e1saO69ljB9FgTVqNgasVcAfDIZmZLtuU0gWQ+LcaqUX
	SugrfTCdJMLIUNfBBs2YVATmkM4iMhhBXiXIRthEHg6UR4UAlm2ullcTsw1FW8om/33OOd/z
	O6/8ODj/E7aAk6XSM1qVVCEkuUTL9Z3hkYrTKxmiEQsb1U2dI5Hz+gpAZUsPcfTv1F0MTXS3
	Yeibul4MfXGxAEOOBjOOGs9x0O+/udnoYa2VjUp7fgXINrkL3f7qAOq03SJQVe08GxnHWklk
	6VvDUMtqFY6+cy4SaOifPhYaMlewX9tGj4weooemGwm6rPRHkh4ZMNBN1s9I+lrNx3RHtRuj
	OybySHp5fpKgi5utgP6p+gabdjeF0E0OF5bKeyc7Qc5IZYw2jFGlq2VZqsxE4aEjkn2SmFiR
	OFIch14VhqmkSiZRmHw4NXJ/lsIzszAsR6oweFypUp1OuHtvglZt0DNhcrVOnyhkNDKFJloT
	pZMqdQZVZpSK0ceLRaKXYzzC97LlQ6MuUjPI/WB+roudB7o4Z4AfB1LRsPxKOTgDuBw+1QHg
	iDOP8BkrAA7XL4InRvFAG+txyoVTi5gv0Aagq2WV9Ab4lAvA/AcyL/OovdDoGsa9TFAvwlO2
	i6TP/yy8Ve4gvBxAvQ8f/VIBvOxPJUJj0di6H6cC4aSjCvPyVkoI5+8PrHeBU7UE/Hp5yPMQ
	h0NSO+GwyeDV+FER8I+1ReDLDYXfuypwrx5SFj9ou9C60XUytDknNtgf3u9rZvtYAN0LNtLH
	2XBmbobwcS5svVa8oU+CeX+Ps7x1cU/dhvbdvlpbYNGqA/O6IcWDnxbyfertcLp0fiMzEM5+
	XsPySWjYmx/kW1shAecmb2DnQZh501bMm6Y3b5rG/H/hakBYQRCj0SkzmfQYjVjFnHhy73S1
	sgms/4jw5FYwXrUW1QMwDugBkIMLt/JKJ5Yz+DyZ9MOTjFYt0RoUjK4HxHjOU4ILAtLVni+l
	0kvE0XGi6NjY2Oi4V2LFwkCe8/SXMj6VKdUz2QyjYbSP8zCOnyAPu6t/w3RTYqvr739hPN60
	ULS9Pi05KoNu2HOwpb7/0dlBZ1JpGstwnpVfWddqMpUcGSvY8lffYpkycs+9whS3wGI/2t0u
	LzwccbnT/hJ3ind89s6DHzJudqgGk+yX3vyoqzFn2BTvnzIYvFTC4L1zTWOSSt2BJSLtyvPJ
	RdxdRMIzIfaoqw72ytsdx6dn7sVlPXXMOPFtMGkNKrB0GizD7bWjEe6COvaCQL6tDTydItDu
	mJ2qoHszjLhAeSnnas3+fQG5K7f77gDn2csDq9VH/1zrzrX/XBJUFiIKbh4PPtHy+sBYEbeT
	KGXsb6W8W2yrPBaaayzpPHlwh7UsIC30uXohoZNLxeG4Vif9D9ch+QCaBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIIsWRmVeSWpSXmKPExsWy7bCSnG5266c0gxeflC1W3+1ns3h9+BOj
	xbQPP5kt/t99zmRx88BOJouVq48yWcye3sxk8WT9LGaLjf0cFo/vfGa3+LlsFbvFpEPXGC32
	3tK2uLTI3WLP3pMsFvOXPWW36L6+g81i+fF/TBbbfs9ntlj3+j2Lxfm/x1ktzs+aw+4g5nH5
	irfH+XsbWTymTTrF5nH5bKnHplWdbB6bl9R77F7wmclj980GNo+PT2+xePRtWcXocWbBEXaP
	z5vkPDY9ecsUwBvFZZOSmpNZllqkb5fAlXH+ylu2gnNcFU8f7WNvYNzH0cXIySEhYCIxtek9
	UxcjF4eQwHZGiUlTGtghEuISzdd+QNnCEiv/PWeHKHrNKLH/wkqwBK+AnUT32wvMIDaLgKpE
	097pbBBxQYmTM5+wgNiiAkkSe+43MoHYwgK2Et2918HizEALbj2ZDxYXEVCSePrqLCPIAmaB
	ZSwSB6e8hTqpjUXi/bKjQA4HB5uApsSFyaUgDZwCOhIv/71nhBhkJtG1tQvKlpfY/nYO8wRG
	oVlI7piFZN8sJC2zkLQsYGRZxSiaWlCcm56bXGCoV5yYW1yal66XnJ+7iRGcCrSCdjAuW/9X
	7xAjEwfjIUYJDmYlEd5JNz+mCfGmJFZWpRblxxeV5qQWH2KU5mBREudVzulMERJITyxJzU5N
	LUgtgskycXBKNTAxZTk/npb9vf5JxJxFZb9sdj2UtDTnCmw+l8dk8PN8MC+T9RfWPctrZj9S
	PX7t0yQ1jUUFqyMD9z5PDMopqF18XUXtz88XHkqdcqLX5XY/eOIh21hXIX36RapCxrUlBx12
	MvA+qUg40M7/dIqBwcGpefNPVjzysw+7Y375/MlQhsXC1jv41+3i/HvW7W1SOvfJpwxdZzr9
	95642n47dO0pn8n6f176ZOY2tFSHhOi8Dexm7V5YyXpQ6dHEbfl35D6dneP0b7uBi6Qov5tM
	xJS3vfHv+G05uzawr63p3fv/2DbLYJ0Fi2/yN9rmbjtamu4e9ObqQ7uj8q5Lfp37G+FuW/D1
	9Lu9U19esHq+otJFiaU4I9FQi7moOBEAityLA3QDAAA=
X-CMS-MailID: 20240924092459epcas5p23e41d7dfa92acf415d9dab1d0e433842
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240910151057epcas5p3369c6257a6f169b4caa6dd59548b538c
References: <CGME20240910151057epcas5p3369c6257a6f169b4caa6dd59548b538c@epcas5p3.samsung.com>
	<20240910150200.6589-5-joshi.k@samsung.com> <20240912130235.GB28535@lst.de>
	<e6ae5391-ae84-bae4-78ea-4983d04af69f@samsung.com>
	<20240913080659.GA30525@lst.de>
	<4a39215a-1b0e-3832-93bd-61e422705f8b@samsung.com>
	<20240917062007.GA4170@lst.de>
	<b438dddd-f940-dd2b-2a6c-a2dbbc4ee67f@samsung.com>
	<20240918064258.GA32627@lst.de>
	<197b2c1a-66d2-5f5a-c258-7e2f35eff8e4@samsung.com>
	<20240918120159.GA20658@lst.de>

On 9/18/2024 5:31 PM, Christoph Hellwig wrote:
> On Wed, Sep 18, 2024 at 01:42:51PM +0530, Kanchan Joshi wrote:
>> Would you prefer a new queue attribute (say nr_streams) that tells that?
> 
> No.  For one because using the same file descriptors as the one used
> to set the hind actually makes it usable - finding the block device
> does not.  And second as told about half a dozend time for this scheme
> to actually work on a regular file the file system actually needs the
> arbiter, as it can work on top of multiple block devices, consumes
> streams, might export streams even if the underlying devices don't and
> so on.
> 

FS managed/created hints is a different topic altogether, and honestly 
that is not the scope of this series. That needs to be thought at per-FS 
level due to different data/meta layouts.
This scope of this series is to enable application-managed hints passing 
through the file system. FS only needs to pass what it receives. No 
active decision making (since application is doing that). Whether it 
works fine or not - is application's problem. But due to the simplicity 
it scales across filesystems. This is for the class of applications that 
know about their data and have decided to be in control.

Regardless, since placement-hints are not getting the reception I 
imagined, I will backtrack.

