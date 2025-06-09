Return-Path: <linux-fsdevel+bounces-50994-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B672AD19A6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 10:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B5BB169E4C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 08:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32673257AFE;
	Mon,  9 Jun 2025 08:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ob/mjXOr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F08825C836
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Jun 2025 08:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749456843; cv=none; b=WDHKOPLRHBGaafZppohI+Ug5QWXeMrfT2+m+F0vE+drMuxjJjSW5y9985wIGKCiywP0+NAB6hsn73naazYr4MLzoCUimYAWpjN9zTCFLHLjk3SIoJrAnSDQiHKUzLFNCVMwm+8Gfc4a+8FLWjc3nD/GgmX9E2K3ewiFbI4m1cYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749456843; c=relaxed/simple;
	bh=zNKl3U3dHaXvJedC7CBW4IKq8mdGAu83rCXgouPQo6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=p6hr9Lvk25HiTvieVSCVU44yF2PNzrNmZ1NUthfcnm1Z/u0BCdHXWx0En3QWzxuXyvXmSngcj/M8cjklRH6uKSeZnMD6XVFlV8LaJRVh/sKElACiT1nncW4lMfcvihujYDGbUwA/vB5GcPIPpkHT5wa5zpBmQuW9OrZqY53tBh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ob/mjXOr; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250609081400epoutp02880eff8de2ee220e2f64819ff361902e~HUbosjxy01536215362epoutp02j
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Jun 2025 08:14:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250609081400epoutp02880eff8de2ee220e2f64819ff361902e~HUbosjxy01536215362epoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1749456840;
	bh=nd3nbXroVvdFN2Vroi9kcMBp3nK8ErzQ9aS/wDU8b/I=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=ob/mjXOrctEKTDO90vTIrC0lqe3dTO/6ynkokUhl9014b+rpn+tpvtnyGOQUrSDUL
	 3DwwYIh+2zUwBSLp2kijVSjSpj8MxaN9mocQy3LFeAwB+8VCavyHwGrN+PHSpAYhk/
	 f+408A9TRNZYIx8vxikfE8e8GCEn/JOiVAIpIRi4=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250609081359epcas5p3636a48707e7bcf478eb1f34c15bc990b~HUboG2GRt2663226632epcas5p35;
	Mon,  9 Jun 2025 08:13:59 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.179]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4bG4Sj4z8qz6B9m6; Mon,  9 Jun
	2025 08:13:57 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250609054449epcas5p4e10bd9dd5fe95a87af810918b9e5c825~HSZYwJlez1767917679epcas5p4F;
	Mon,  9 Jun 2025 05:44:49 +0000 (GMT)
Received: from [107.122.10.194] (unknown [107.122.10.194]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250609054447epsmtip12d2bf0d18f5f82599edfbcc11cf573e1~HSZXHBZqj1487614876epsmtip1C;
	Mon,  9 Jun 2025 05:44:47 +0000 (GMT)
Message-ID: <e044bbcf-bfd6-48da-a7cf-e5993287f288@samsung.com>
Date: Mon, 9 Jun 2025 11:14:42 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next v2 2/2] fs: add ioctl to query protection info
 capabilities
To: Christoph Hellwig <hch@infradead.org>, "Martin K. Petersen"
	<martin.petersen@oracle.com>
Cc: vincent.fu@samsung.com, jack@suse.cz, anuj1072538@gmail.com,
	axboe@kernel.dk, viro@zeniv.linux.org.uk, brauner@kernel.org,
	ebiggers@kernel.org, adilger@dilger.ca, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, joshi.k@samsung.com
Content-Language: en-US
From: Anuj Gupta/Anuj Gupta <anuj20.g@samsung.com>
In-Reply-To: <aEZe79nes2fmJs6N@infradead.org>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250609054449epcas5p4e10bd9dd5fe95a87af810918b9e5c825
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250605150746epcas5p1cf96907472d8a27b0d926b9e2f943e70
References: <20250605150729.2730-1-anuj20.g@samsung.com>
	<CGME20250605150746epcas5p1cf96907472d8a27b0d926b9e2f943e70@epcas5p1.samsung.com>
	<20250605150729.2730-3-anuj20.g@samsung.com>
	<yq1a56lbpsc.fsf@ca-mkp.ca.oracle.com> <aEZe79nes2fmJs6N@infradead.org>

On 6/9/2025 9:41 AM, Christoph Hellwig wrote:
> On Thu, Jun 05, 2025 at 10:07:00PM -0400, Martin K. Petersen wrote:
>>
>> Hi Anuj!
>>
>>> A new structure struct fs_pi_cap is introduced, which contains the
>>> following fields:
>>
>> Maybe fs_metadata_cap and then fmd_ as prefix in the struct?
> 
> Yeah, that does sound better.
> 
> 
Based on the recent discussion and suggestion from Martin [1] I was
planning to use logical_block_metadata_cap instead. Does that idea sound
fine to you?

[1] 
https://lore.kernel.org/linux-block/20250605150729.2730-1-anuj20.g@samsung.com/

