Return-Path: <linux-fsdevel+bounces-907-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6EE7D2C22
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 10:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E21D8B20E0A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 08:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D891118F;
	Mon, 23 Oct 2023 08:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="C2i54pr8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D82D10954;
	Mon, 23 Oct 2023 08:03:05 +0000 (UTC)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C9D10C4;
	Mon, 23 Oct 2023 01:03:00 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20231023080258epoutp0415e688a9ab35ee365957a92bdd5d060e~QrdI9hV2X0433704337epoutp04k;
	Mon, 23 Oct 2023 08:02:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20231023080258epoutp0415e688a9ab35ee365957a92bdd5d060e~QrdI9hV2X0433704337epoutp04k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1698048178;
	bh=AACSYwStM2Fj3YRgCcuvQYmMDqXUgVQCwVuy+yFJJfU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=C2i54pr8WrkMTXO05efoz5ahzb1e8OynmLqKGA7rV+1xNvaXw7aRGtdqzYfw9BcMf
	 ySljRnS5a3+rjcTLGpCHhQ2eP47qr3UKvE5JWgCLFMAVNcykcukaZNmeurE9ddZ6tt
	 fQSgrIlyAdvoXGT/bMR+yjqCVUKFgxbrul8jZtFw=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTP id
	20231023080257epcas2p3d49beb068b29d8d3bfa396d29ad9f634~QrdIpeO570450704507epcas2p3Q;
	Mon, 23 Oct 2023 08:02:57 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.69]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4SDSNd05j1z4x9Q9; Mon, 23 Oct
	2023 08:02:57 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
	epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	D7.76.09622.0B826356; Mon, 23 Oct 2023 17:02:56 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
	20231023080256epcas2p327a8a17e7d92f5c58e010d0b7e153be0~QrdHhRHlZ2526025260epcas2p3C;
	Mon, 23 Oct 2023 08:02:56 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231023080256epsmtrp2f6390c094fa52e7b213a55464083f04b~QrdHfpZG61878518785epsmtrp2Q;
	Mon, 23 Oct 2023 08:02:56 +0000 (GMT)
X-AuditID: b6c32a46-fcdfd70000002596-5a-653628b0189b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	D0.DF.18939.0B826356; Mon, 23 Oct 2023 17:02:56 +0900 (KST)
Received: from tiffany (unknown [10.229.95.142]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20231023080256epsmtip22527cb7f5cd0fc263896ab2c4f53fa14~QrdHH64gP1774517745epsmtip2i;
	Mon, 23 Oct 2023 08:02:56 +0000 (GMT)
Date: Mon, 23 Oct 2023 16:52:29 +0900
From: Hyesoo Yu <hyesoo.yu@samsung.com>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev,
	maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, arnd@arndb.de, akpm@linux-foundation.org,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
	bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
	vschneid@redhat.com, mhiramat@kernel.org, rppt@kernel.org, hughd@google.com,
	pcc@google.com, steven.price@arm.com, anshuman.khandual@arm.com,
	vincenzo.frascino@arm.com, david@redhat.com, eugenis@google.com,
	kcc@google.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 04/37] mm: Add MIGRATE_METADATA allocation policy
Message-ID: <20231023075229.GB344850@tiffany>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZS0vRz6PlUJM8MN9@monolith>
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTdxTHvY/eFhbctSj7rTOGXaNDFGgrjx8GlsURchdZgnPJJmzDpr2j
	CJSmLcxhFkBAKuhAHOMhsjoQmBZw5Y2UZycvTQYEjLxUkAbJoI7HkJeucNH43+ec3/fke37n
	5PAwfi9XwAtTaBiVQhJBEbZ4TfsB6HLbyZMR/pblAfMr9ATM/qOfgE2dUrieeZcL+yYGrKln
	CTi0FF9E4GLFCgYnM6ox2KqbxeHk3M84fNRUgsLR9Cwc1ppnUDhd1Y5DbcMiDg0TgxzYaOzC
	YX9DPgHH9K840FRxH4f1+V0ceGXWjMDCkv2wr0WHwqzlfwiYPvKAgB2XWlDYpH2MWrW1KEww
	WQiYOzyMQK3pPwwaXy7jsPqvJS5MGvGAD2/c5n6yj9YX6BF6dSUToZOahri0zhBNJ5lmOHRl
	qTNtuHmBoA1zmVx6ZLCRoDtzVnH6enwWRlcWxdFTlbkIbWkaIOjKnrP0vGFPIBkU7iNnJDJG
	5cgopFGyMEWoL3XsRMinIR6eQpGLyBt6UY4KSSTjS/kFBLr4h0VYh0k5xkgioq2pQIlaTbl9
	7KOKitYwjvIotcaXYpSyCKWX0lUtiVRHK0JdFYzmiEgoFHtYhafC5Ql9TzjKooNnFhLNaDxS
	RqUiNjxAuoOhmhwiFbHl8ck6BKwNryNsMIeAkuYV4k3wPPE+93WJSbuObzCfrEfAi+XvWNEk
	Asw5LZsinNwHjKkXsQ0myI9AZ1UxssE7STcwXj29aYGR3QQYvXoP3XiwJz8DWZaETbYjXUBZ
	oQFjeQfoyn1qdePxbEgnULPMbNQCMtUWzFZMc9iO/MD1+UcYy/ZguqNqq1MBmJ81EiyHg9F/
	M7ZYA8rvxW9pDoM8c8pmcxgpB3mjDZwNL0DuBaYhnE1vB9r2dS6btgPa83y2ci9oLi7AWX4f
	jJelbHVDA0OPEWVnokVBT1opkYHsyXvrN3lvubF8COjuzBF5VguM/ACUvOSxeABUNLjpEM5N
	xIFRqiNDGbVYKX6zYGlUpAHZvC1n/zrkl5nnrm0IykPaEMDDqJ12V79yZ/h2MsmPsYwqKkQV
	HcGo2xAP624uY4Jd0ijrcSo0ISJ3b6G7p6fIS+wh9KLesxtLvibjk6ESDRPOMEpG9boO5dkI
	4tGieUpvYYxyXF8bpFPt3p0Miw9XdH9rzE6v9Qw6/qFM2VIvGzKNSLN9+VfmwGT2/CGt/0T1
	QOzJoyWl54xHErIzyCSX8e11nrrBqonyvsdd9msB3aeeLjyrFR998cC7/LwoKbh95DSzyp+O
	yTstuxVu6vQOPlHs6/cDb1H/au2b35e8XM/5mR3wVuGto5o/L/xEfb/tpPTajgDdrjvliaZ8
	h/A0Nb8zblAOv/6y/11BWmLjFwLbs4LAu5MzT9xqkhd/1WreiS3Yn1Q15fR3b3C3Je5SdGDr
	DfFxKsWSG+Oz2jjZ3HMmYigS70hp5izHFB4EU8aF4Lax3m2fL9HHYuBDClfLJSJnTKWW/A+g
	MGdE5AQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEKsWRmVeSWpSXmKPExsWy7bCSvO4GDbNUg6k7+S3mrF/DZjF95WU2
	i30nki3+TjrGbnHp8VWg0MtGFov3y3oYLb6u/8Vs8XTCVmaLgwvesVg8/dTHYnF/33Imi7v9
	U1kstj97y2TxasthFouOXV9ZLDY9vsZqsWfvSRaLy7vmsFncW/Of1eLI+rMsFjvnnGS1mPzu
	GaPF4uVqFpcOLGCymPrzDZtF/53rbBbHew8wWezreMAEVLudyaLxyHs2i5m3bzNadBz5xmyx
	999PFoutR7+zW7TcMbW4uXQDu4Oqx5p5axg9fv+axOjRsu8Wu8eCTaUeLUfesnpsXqHlsWlV
	J5vHpk+T2D3uXNvD5nFixm8Wj4UNU5k9Ni+p93ixeSajx/t9V9k8Np+u9vi8SS5AIIrLJiU1
	J7MstUjfLoEro3faDraCJxoVB+e/ZW9gbFPoYuTkkBAwkTjS8ZcFxBYS2M4o8eBTPkRcUmLW
	55NMELawxP2WI6xdjFxANY8ZJaZsnskKkmARUJXY29XDDGKzCahLnNiyjBHEFhHQl3i09RUj
	SAOzwBk2ib7Vs8AahAU8Jaa+bwSbyiugK7F28SZmiM1dTBKtJ30h4oISJ2c+AbuIWUBL4sa/
	l0D1HEC2tMTyfxwgJqeAhsS2n6kTGAVmIWmYhaRhFkLDAkbmVYyiqQXFuem5yQWGesWJucWl
	eel6yfm5mxjByUYraAfjsvV/9Q4xMnEwHmKU4GBWEuGdHW6SKsSbklhZlVqUH19UmpNafIhR
	moNFSZxXOaczRUggPbEkNTs1tSC1CCbLxMEp1cCkGqW3+q7KBPn7OtGcT1fMNi5XlD/2ZmLH
	lPXPslTCTtZfE3Ep8xD5ZZT4ITzginPRoz8rnI63mMkKmSue/WghVr6vVFQgfVHxH60DCSUK
	IpEfGFSWGv3b/unGxj2sC6TWuMcFluqo35P4GMlePfWOr/89Jhez4xmnVfWnV5grXeibP2dB
	3okpH8LFV3wvDvOTur+58n5b34OFfhPmb2DaH3k9XDb88OlFGhvmae7mbmx1YJvP29Hp9POU
	qv9dm4ajTU3fa6Jn25pr/VsanqN38qr8sQm7J0128Z26uWSSnMqf97oHlfacF5vq/ryqw6F4
	w7q6zKyz+TyZG6ccdiwNLkl5PZlFu/Tw9XgtkQ1KLMUZiYZazEXFiQCNL+iFpQMAAA==
X-CMS-MailID: 20231023080256epcas2p327a8a17e7d92f5c58e010d0b7e153be0
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----QkVgGvrvWiyli5pqMJpqhgOu5Z7YYftLzn.eTqKOKf81mxr7=_53dc1_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231012013834epcas2p28ff3162673294077caef3b0794b69e72
References: <20230823131350.114942-1-alexandru.elisei@arm.com>
	<20230823131350.114942-5-alexandru.elisei@arm.com>
	<CGME20231012013834epcas2p28ff3162673294077caef3b0794b69e72@epcas2p2.samsung.com>
	<20231012012824.GA2426387@tiffany> <ZS0vRz6PlUJM8MN9@monolith>

------QkVgGvrvWiyli5pqMJpqhgOu5Z7YYftLzn.eTqKOKf81mxr7=_53dc1_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Mon, Oct 16, 2023 at 01:40:39PM +0100, Alexandru Elisei wrote:
> Hello,
> 
> On Thu, Oct 12, 2023 at 10:28:24AM +0900, Hyesoo Yu wrote:
> > On Wed, Aug 23, 2023 at 02:13:17PM +0100, Alexandru Elisei wrote:
> > > Some architectures implement hardware memory coloring to catch incorrect
> > > usage of memory allocation. One such architecture is arm64, which calls its
> > > hardware implementation Memory Tagging Extension.
> > > 
> > > So far, the memory which stores the metadata has been configured by
> > > firmware and hidden from Linux. For arm64, it is impossible to to have the
> > > entire system RAM allocated with metadata because executable memory cannot
> > > be tagged. Furthermore, in practice, only a chunk of all the memory that
> > > can have tags is actually used as tagged. which leaves a portion of
> > > metadata memory unused. As such, it would be beneficial to use this memory,
> > > which so far has been unaccessible to Linux, to service allocation
> > > requests. To prepare for exposing this metadata memory a new migratetype is
> > > being added to the page allocator, called MIGRATE_METADATA.
> > > 
> > > One important aspect is that for arm64 the memory that stores metadata
> > > cannot have metadata associated with it, it can only be used to store
> > > metadata for other pages. This means that the page allocator will *not*
> > > allocate from this migratetype if at least one of the following is true:
> > > 
> > > - The allocation also needs metadata to be allocated.
> > > - The allocation isn't movable. A metadata page storing data must be
> > >   able to be migrated at any given time so it can be repurposed to store
> > >   metadata.
> > > 
> > > Both cases are specific to arm64's implementation of memory metadata.
> > > 
> > > For now, metadata storage pages management is disabled, and it will be
> > > enabled once the architecture-specific handling is added.
> > > 
> > > Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> > > ---
> > > [..]
> > > @@ -2144,6 +2156,15 @@ __rmqueue(struct zone *zone, unsigned int order, int migratetype,
> > >  		if (alloc_flags & ALLOC_CMA)
> > >  			page = __rmqueue_cma_fallback(zone, order);
> > >  
> > > +		/*
> > > +		 * Allocate data pages from MIGRATE_METADATA only if the regular
> > > +		 * allocation path fails to increase the chance that the
> > > +		 * metadata page is available when the associated data page
> > > +		 * needs it.
> > > +		 */
> > > +		if (!page && (alloc_flags & ALLOC_FROM_METADATA))
> > > +			page = __rmqueue_metadata_fallback(zone, order);
> > > +
> > 
> > Hi!
> > 
> > I guess it would cause non-movable page starving issue as CMA.
> 
> I don't understand what you mean by "non-movable page starving issue as
> CMA". Would you care to elaborate?
> 

Before below patch, I frequently encountered situations where there was free CMA memory
available but the allocation of unmovable page failed. That patch has improved this
issue. ("mm,page_alloc,cma: conditionally prefer cma pageblocks for movable allocations)
https://lore.kernel.org/linux-mm/20200306150102.3e77354b@imladris.surriel.com/

I guess it would be beneficial to add a policy for effectively utilizing the metadata
area as well. I think migration is cheaper than app killing or swap in terms
of performance.

But, if the next iteration tries to use only cma, as discussed in recent mailing lists,
I think this concern would be fine.

Thanks,
Regards.

> > The metadata pages cannot be used for non-movable allocations.
> > Metadata pages are utilized poorly, non-movable allocations may end up
> > getting starved if all regular movable pages are allocated and the only
> > pages left are metadata. If the system has a lot of CMA pages, then
> > this problem would become more bad. I think it would be better to make
> > use of it in places where performance is not critical, including some
> > GFP_METADATA ?
> 
> GFP_METADATA pages must be used only for movable allocations. The kernel
> must be able to migrate GFP_METADATA pages (if they have been allocated)
> when they are reserved to serve as tag storage for a newly allocated tagged
> page.
> 
> If you are referring to the fact that GFP_METADATA pages are allocated only
> when there are no more free pages in the zone, then yes, I can understand
> that that might be an issue. However, it's worth keeping in mind that if a
> GFP_METADATA page is in use when it needs to be repurposed to serve as tag
> storage, its contents must be migrated first, and this is obviously slow.
> 
> To put it another way, the more eager the page allocator is to allocate
> from GFP_METADATA, the slower it will be to allocate tagged pages because
> reserving the corresponding tag storage will be slow due to migration.
> 
> Before making a decision, I think it would be very helpful to run
> performance tests with different allocation policies for GFP_METADATA. But I
> would say that it's a bit premature for that, and I think it would be best
> to wait until the series stabilizes.
> 
> And thank you for the feedback!
> 
> Alex
> 
> > 
> > Thanks,
> > Hyesoo Yu.
> 

------QkVgGvrvWiyli5pqMJpqhgOu5Z7YYftLzn.eTqKOKf81mxr7=_53dc1_
Content-Type: text/plain; charset="utf-8"


------QkVgGvrvWiyli5pqMJpqhgOu5Z7YYftLzn.eTqKOKf81mxr7=_53dc1_--

