Return-Path: <linux-fsdevel+bounces-25629-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D94D94E620
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 07:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2FB2B20B36
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 05:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC12E14B940;
	Mon, 12 Aug 2024 05:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westnet.com.au header.i=@westnet.com.au header.b="K/OPDwy9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from omr000.pc5.atmailcloud.com (omr000.pc5.atmailcloud.com [103.150.252.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FA943AA1
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2024 05:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.150.252.0
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723440115; cv=none; b=EpysPRNTOLrcGsGPSCLnqKZcxWYpBFWenoGn5QICpz+3XPsMm6ujvaZVQItG9XsZJ95g49BW2vjtzZa2Tj9d1gOYhsqEoudz21ChDccU6nk+rkLexq+8LAZg7Px8NeN+rm1Ngu80Rnz/r7NAEM2FnCrUZs0+TnSemwtCL3U2VeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723440115; c=relaxed/simple;
	bh=h9V1gKwBinnV+XKmck3MYnRqujBJYafL4Schx2hArJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QHlNte6enMh3SpeqO3sfOvXip6DsOmW3bwJbjIED90w+9WU2oBX4XXFcGULNeTNqYseYro1oq1lkdEOwe99N/sBm+UVzxhPQtHu2FEyGfig2TWvgdzzqujs48s5P7hDdv6IVL73rxx5BSN81FG9ktUCc66HNVIjQ6Tdwli0Mvdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=westnet.com.au; spf=pass smtp.mailfrom=westnet.com.au; dkim=pass (2048-bit key) header.d=westnet.com.au header.i=@westnet.com.au header.b=K/OPDwy9; arc=none smtp.client-ip=103.150.252.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=westnet.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westnet.com.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=westnet.com.au; s=202309; h=Content-Type:From:To:Subject:MIME-Version:Date:
	Message-ID; bh=AaDYcRfKXTyEZ6jBMotVIQU3FKYuF/9zV7sS8dzbx98=; b=K/OPDwy9z0W5cX
	be8AIXhPqWpZj7CCNaW4lp5gMvGTvPQtI1A0xGtOIHr9Vpzvw7lXOglSUcPprvP4Bv9N5VEmHyu04
	FE5aUjsrR5KRdV3nwsa/Kgocd8nm7pqJiVtaREcb6aJfpd9F5pn8TXcJ9t1jFFDQphs9eTCfuPi0N
	W7QuMwQSfQY2PPP/fJdOAiACH1Re4EanlIeGfZT47RKA/e47lmOhAFW4lpYIO8PTrXnQTqINMyOI4
	7o6ii4XdsWLMYnPTzJLMtEcmw0Q93iO1QS3pdIEGhQ4aQq/FwHkLqFN3si/wYgTq8G+wtxl4sY315
	5AKqb7uQG58weMNqSQ8w==;
Received: from CMR-KAKADU04.i-0c3ae8fd8bf390367
	 by OMR.i-0e491b094b8af55fe with esmtps
	(envelope-from <gregungerer@westnet.com.au>)
	id 1sdMnj-0002B6-Vd;
	Mon, 12 Aug 2024 04:36:59 +0000
Received: from [27.33.250.67] (helo=[192.168.0.22])
	 by CMR-KAKADU04.i-0c3ae8fd8bf390367 with esmtpsa
	(envelope-from <gregungerer@westnet.com.au>)
	id 1sdMnj-0006Il-1y;
	Mon, 12 Aug 2024 04:36:59 +0000
Message-ID: <bafe6129-209b-4172-996e-5d79389fc496@westnet.com.au>
Date: Mon, 12 Aug 2024 14:36:57 +1000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/16] romfs: Convert romfs_read_folio() to use a folio
To: Matthew Wilcox <willy@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
References: <20240530202110.2653630-1-willy@infradead.org>
 <20240530202110.2653630-13-willy@infradead.org>
 <597dd1bb-43ee-4531-8869-c46b38df56bd@westnet.com.au>
 <ZrmBvo6c1N7YnJ6y@casper.infradead.org>
Content-Language: en-US
From: Greg Ungerer <gregungerer@westnet.com.au>
In-Reply-To: <ZrmBvo6c1N7YnJ6y@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Atmail-Id: gregungerer@westnet.com.au
X-atmailcloud-spam-action: no action
X-Cm-Analysis: v=2.4 cv=fLk/34ae c=1 sm=1 tr=0 ts=66b9916b a=Pz+tuLbDt1M46b9uk18y4g==:117 a=Pz+tuLbDt1M46b9uk18y4g==:17 a=IkcTkHD0fZMA:10 a=yoJbH4e0A30A:10 a=80-xaVIC0AIA:10 a=x7bEGLp0ZPQA:10 a=Kl0MfWnbE3h2Nfpd_ZgA:9 a=QEXdDO2ut3YA:10
X-Cm-Envelope: MS4xfADQzl3K9idOr25qStOsqBkihoPFnJIsVdDwUb5CnwGkZEI33CFICTl/pc8aLAF16NAitkkZV6PZfgGRu2nata0xRdjCw/GGmcUiopnPDVZltto6ZWYj z40DuTHR5U+ZeDUHiztlEAlLmRN1quRJ4pTk55yfjZ/ZZGqKvcb6EOSVdEIbLOQuc3wxlELHkbSXUg==
X-atmailcloud-route: unknown


On 12/8/24 13:30, Matthew Wilcox wrote:
> On Mon, Aug 12, 2024 at 11:46:34AM +1000, Greg Ungerer wrote:
>>> @@ -125,20 +121,14 @@ static int romfs_read_folio(struct file *file, struct folio *folio)
>>>    		ret = romfs_dev_read(inode->i_sb, pos, buf, fillsize);
>>>    		if (ret < 0) {
>>> -			SetPageError(page);
>>>    			fillsize = 0;
>>>    			ret = -EIO;
>>>    		}
>>>    	}
>>> -	if (fillsize < PAGE_SIZE)
>>> -		memset(buf + fillsize, 0, PAGE_SIZE - fillsize);
>>> -	if (ret == 0)
>>> -		SetPageUptodate(page);
>>> -
>>> -	flush_dcache_page(page);
>>> -	kunmap(page);
>>> -	unlock_page(page);
>>> +	buf = folio_zero_tail(folio, fillsize, buf);
> 
> I think this should have been:
> 
> 	buf = folio_zero_tail(folio, fillsize, buf + fillsize);
> 
> Can you give that a try?

Yep, that fixes it.

Thanks
Greg



