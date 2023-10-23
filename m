Return-Path: <linux-fsdevel+bounces-902-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB087D2B47
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 09:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6B02281510
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 07:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A01D101E3;
	Mon, 23 Oct 2023 07:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="vWYv5YdI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17941101D4
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 07:27:33 +0000 (UTC)
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774C0D6B;
	Mon, 23 Oct 2023 00:27:31 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231023072728epoutp016f16d270b9d58d77a3df83a636430be8~Qq_JRhUIp1250612506epoutp01L;
	Mon, 23 Oct 2023 07:27:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231023072728epoutp016f16d270b9d58d77a3df83a636430be8~Qq_JRhUIp1250612506epoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1698046048;
	bh=yQ0o45G+VG1R4BSnMeP2FwuyP8TuVxRSYxt30sCvGNU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vWYv5YdIqTb8esz/7oR57rVdrqQiQW9bXDca8BNdaR4ZY3WdofGJiE8CuQjHf2HLk
	 CksB44uQ7Cwl6cRBx5dgShygTWEKAZiKeokXTu4VPGDUWLw+tj7S9/6kDD0WvlC+iM
	 //7xf1s/6FWok/KbWp9xlHw5Xn6dt7rRjL6/WqUI=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTP id
	20231023072727epcas2p4eb120f3e7d6e0b6a0a76ae809bcf413e~Qq_I3l0GM2774427744epcas2p4m;
	Mon, 23 Oct 2023 07:27:27 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.101]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4SDRbg0FN6z4x9Q1; Mon, 23 Oct
	2023 07:27:27 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
	epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	7D.5A.10006.E5026356; Mon, 23 Oct 2023 16:27:26 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
	20231023072726epcas2p22a956be89b7f25f9edf2faff418e507a~Qq_HuFV_g1856218562epcas2p2J;
	Mon, 23 Oct 2023 07:27:26 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231023072726epsmtrp243c3957bce73fbbad6710deba8333a18~Qq_Hsw4u43069830698epsmtrp2B;
	Mon, 23 Oct 2023 07:27:26 +0000 (GMT)
X-AuditID: b6c32a45-3ebfd70000002716-b6-6536205e5a1e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	3C.BF.08755.E5026356; Mon, 23 Oct 2023 16:27:26 +0900 (KST)
Received: from tiffany (unknown [10.229.95.142]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20231023072725epsmtip1ca6761ce4659bf69cb32b5496d0bcbf8~Qq_HPonl_2906329063epsmtip1Q;
	Mon, 23 Oct 2023 07:27:25 +0000 (GMT)
Date: Mon, 23 Oct 2023 16:16:56 +0900
From: Hyesoo Yu <hyesoo.yu@samsung.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Alexandru Elisei <alexandru.elisei@arm.com>, will@kernel.org,
	oliver.upton@linux.dev, maz@kernel.org, james.morse@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com, arnd@arndb.de,
	akpm@linux-foundation.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com, mhiramat@kernel.org,
	rppt@kernel.org, hughd@google.com, pcc@google.com, steven.price@arm.com,
	anshuman.khandual@arm.com, vincenzo.frascino@arm.com, david@redhat.com,
	eugenis@google.com, kcc@google.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH RFC 06/37] mm: page_alloc: Allocate from movable pcp
 lists only if ALLOC_FROM_METADATA
Message-ID: <20231023071656.GA344850@tiffany>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZS5hXFHs08zQOboi@arm.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0xbVRj39N7eFgQtjOEZSybr5hTk0SItZwbYsiG5OmcwEolOxAo3tFBK
	1xajMgQW5LFsg4FM3mLmYCCPpYBAVwpSXgXC5pZN3jgeBYlQYY5m4JgXLjP77/f9Ht93Hvm4
	mKOJ48KVKTSUSiGR8wlb/BejG/L81FVMCRbSECqpryHQ91V3CGToi0SPc3s46PbMXZr6MxVH
	lorzAD2sX8fQXE4Thn4tX8bR3OpFHE0ZKlloIjsfR83mJRZabDTiKFP3EEfamXtspG8z4eiO
	roRAkzVP2Ki1xMRGectmgK5UHkK3O8pZKP/RXwTKHv+dQL0XOljIkPkHC3XVN7NQapeFQIVj
	YwBldq1hqG3zEY6auq0clDYuQiNXr3OOHiRrymoAubGeC8g0wyiHLNcmkGldS2yy4Zo7qa3O
	Ikjtai6HHL+nJ8i+gg2c/DElHyMbfkomFxoKAWkx3CXIhoFE8oF2Xwjv41h/KSWJolSulCIy
	PkqmiA7gn/gg4niESCwQegoPIz++q0ISRwXwg94N8QyWyel35Lt+IZEn0FSIRK3mewf6q+IT
	NJSrNF6tCeBTyii50k/ppZbEqRMU0V4KSvOmUCDwEdHGz2Kl88UnlEsvfmkxnUoBs3bngA0X
	8nyh+fwUfg7Ych15LQBOVk5jTLEK4CVL4Y6yBmBGRzbnaaR7zEIwQhuA/1Tp2EwxB2DKoJm1
	5cJ5r8CVDv12guC9CvsaK8AWduJ5wlvp3223xXg6AlpNWnxL2MWTw5xp3bbJnjY1behZDHaA
	psLZbY8N3eiutRFshSEv3RbWZ5lpgUMXQbDlJHO6XXCxt3HnpC7wwXIbweBYOLGSs4M1sG4w
	ZcfzBiwyZ2yPxXhSqDfcou/PpfkDsGsUZ+gXYKbxMYeh7WFmuiOTPADbK8pwBu+B07UZbMZC
	wqyVZOZFrrJge5qRnQP2FT1zl6JnhjHYA5bfWCWK6DjG2wsrN7kMdIP1Ou9ywK4GzpRSHRdN
	qX2Uwv9/NzI+Tgu2d8r9rRaQt/S3VydgcUEngFyM72RfHOZLOdpHSb76mlLFR6gS5JS6E4jo
	n7mEueyOjKeXUqGJEPoeFviKxUI/H5HAj/+S/eS3pVGOvGiJhoqlKCWleppjcW1cUlivBwXL
	k6rOfPLytbHTxUNhRr8ZTox1JEkluJlwUXev7pCHl5ODtS7JOnQ6PFL/nne7SOZc1qrH+z8f
	jCnYxNknW21q3xeP5ThmhEe2KTx/W+k+q4+SxSqcZOv2x68fXRi2C7hidnq+f0/S8OiK24VQ
	N1ne7g0C24xxdgh3ST47bmf1EQxUr7Y5/4x9FDjiccYU6jAbWu0XflnxTXR9wN7guqFhpf+N
	y9a1qYNqq5FddKz/uQmxtLly1rb3w3f4nsLE0nmtc0/wkzhLg9f9Hq6oJDjVrlR85AfNfMXN
	QONrYVL/niMDBWH3RcX+ik5ZSXNio6H21NtzIfvj8kr6/l1sOsbH1VKJ0B1TqSX/AZTw3Tfc
	BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sb0wbdRjH/d1dr0dN41lmuP0JNnUbQkYHzcQnbBqjb04TErO5LWFmesIF
	iG2pLWwTY+gyZAw3V7F1Fhh2wVFGOoG2CNZSEcqg/DFbJ5sbVJw4LI2jUAQGRLSlMe7dN8/n
	+3meNw+FS4yCLVSRuoTXqjmljBQR3/TJktOPSrP4jHuXBFDfaiPhwpWbJHgG8+DvmmtC8E+N
	RUczJwkIN51FsNi6isN9QwcOP1hmCbgf+YSASY8Vg8B5EwGd0w8wCDn7CKhyLRJgn7olAHe3
	j4CbrnoSfrH9I4Bv630C+Gx2GkGjdSf4eywYmFb+JOH8xG0SBs71YOCp+hUDb2snBie9YRLM
	4+MIqrxLOHSvrxDQ0b8shIqJ5+DO5TbhS9tZW4MNsWurNYit8NwVshZ7KVvhfSBgHc1prL3l
	DMnaIzVCduKWm2QHv1gj2Et6E846vipngw4zYsOeMZJ1DH/ALtiTX6dzRfvyeWXRMV67+8W3
	RYWh7kpcc1V8wuufQ3rULapGCRRD72H6x8NkNRJREvo7xDSaKlEcbGZqF3xYPCcykxVeQbw0
	hZjFhggRAwS9g5nvcQtjmaRTmEFn04a8iU5nrlcaiZiA026SqV65S8ZAIq1kDL+5NkriaKlj
	zY3Ft1oxxlhnFcTBk4zP/PvGBZxOY35en4mWqGjeyljXqdg4IXpsbNmJDIiufcSofcSo/d+w
	ILwFbeY1OlWBSpepyVTzx+U6TqUrVRfI84pVdrTxOGmpXaizZU7eizAK9SKGwmWbxHWH9/AS
	cT73fhmvLX5LW6rkdb1oK0XIksRJwXP5ErqAK+Hf5XkNr/2PYlTCFj32qTP34ILzna/9bTMX
	PFd72hWGU2ek5aMmedbTWV1m5VnV86FrhZn20NDxMBbufCJP1VypHO43u9tzZw1yJvuiRR/Y
	ZSdfeKwvRdLWmPFKgPtpqSHljYD4KcuhVFej+rKkbGmIHVb3Gl/7a/+4edfI6qHbOdukkm3t
	ftNufmAtwq0nCovDzx7UU59/dPrDBt/RvUklzVyT1KS5kZPjatk5Gmg/XahWlH2pvvNe6rSt
	nyia304oRg/M/nEi+9jQyIHsGwM/ll9cLrn+TCQo3aeYL3YYj4yYPuYWku89vvdI8PuOpZfr
	cucmHza9+VDRtcM7U5Oe3vqqOyP5VFBTHwkldckIXSGXmYZrddy/l57xSKcDAAA=
X-CMS-MailID: 20231023072726epcas2p22a956be89b7f25f9edf2faff418e507a
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----kpWfbNyO0dZ94JZMx8UaZzOLaVw4Eds-FlcQ7ND7-zj3ifPP=_5344b_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231012013524epcas2p4b50f306e3e4d0b937b31f978022844e5
References: <20230823131350.114942-1-alexandru.elisei@arm.com>
	<20230823131350.114942-7-alexandru.elisei@arm.com>
	<CGME20231012013524epcas2p4b50f306e3e4d0b937b31f978022844e5@epcas2p4.samsung.com>
	<20231010074823.GA2536665@tiffany> <ZS0va9nICZo8bF03@monolith>
	<ZS5hXFHs08zQOboi@arm.com>

------kpWfbNyO0dZ94JZMx8UaZzOLaVw4Eds-FlcQ7ND7-zj3ifPP=_5344b_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Tue, Oct 17, 2023 at 11:26:36AM +0100, Catalin Marinas wrote:
> On Mon, Oct 16, 2023 at 01:41:15PM +0100, Alexandru Elisei wrote:
> > On Thu, Oct 12, 2023 at 10:25:11AM +0900, Hyesoo Yu wrote:
> > > I don't think it would be effcient when the majority of movable pages
> > > do not use GFP_TAGGED.
> > > 
> > > Metadata pages have a low probability of being in the pcp list
> > > because metadata pages is bypassed when freeing pages.
> > > 
> > > The allocation performance of most movable pages is likely to decrease
> > > if only the request with ALLOC_FROM_METADATA could be allocated.
> > 
> > You're right, I hadn't considered that.
> > 
> > > 
> > > How about not including metadata pages in the pcp list at all ?
> > 
> > Sounds reasonable, I will keep it in mind for the next iteration of the
> > series.
> 
> BTW, I suggest for the next iteration we drop MIGRATE_METADATA, only use
> CMA and assume that the tag storage itself supports tagging. Hopefully
> it makes the patches a bit simpler.
> 

I am curious about the plan for the next iteration.

Does tag storage itself supports tagging? Will the following version be unusable
if the hardware does not support it? The document of google said that 
"If this memory is itself mapped as Tagged Normal (which should not happen!)
then tag updates on it either raise a fault or do nothing, but never change the
contents of any other page."
(https://github.com/google/sanitizers/blob/master/mte-dynamic-carveout/spec.md)

The support of H/W is very welcome because it is good to make the patches simpler.
But if H/W doesn't support it, Can't the new solution be used?

Thanks,
Regards.

> -- 
> Catalin
> 

------kpWfbNyO0dZ94JZMx8UaZzOLaVw4Eds-FlcQ7ND7-zj3ifPP=_5344b_
Content-Type: text/plain; charset="utf-8"


------kpWfbNyO0dZ94JZMx8UaZzOLaVw4Eds-FlcQ7ND7-zj3ifPP=_5344b_--

