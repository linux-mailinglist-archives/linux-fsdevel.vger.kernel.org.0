Return-Path: <linux-fsdevel+bounces-74357-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FEAD39C4A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 03:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8FCBA30012DE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 02:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB742417E0;
	Mon, 19 Jan 2026 02:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="RwckYvGb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA96234966
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jan 2026 02:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768788782; cv=none; b=rvGQstu1+kUlfyVZCImDAV2d01ciq77HM1Bxf1D3jDCUODJY5aBnpoStlvYfBuKRM/zJW0BUOupq5GKZhKlJ240uOylsrUoCfJlQHh4ZaGd1AzP4bcmL7aJ3dzVNg1z3g7iWoVMLhXHk/fKn7A5naFmDHkSdhzdnPVUC0qC347U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768788782; c=relaxed/simple;
	bh=sJZDBpMLcVEW9Eza/lhTfKK2Hk0aqOloljdt6R7E6Vc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DvipyokQ0f09qOyVlosLE/lbpC4iib0293X4pHVb2/SrWkl7HdCktusBxzdxAvuQxBTZArpfcb9aKklsQibBdSNd6FrTB4KSSR8Z8rP2bz3e7KHEqKM4rupAzzURuFwmIHkhFmKbx1z27ISis5r15PjY9FMB4zesACxt4xxm4Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=RwckYvGb; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768788771; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Bvdzt1zN2zKFogOTL8NG/cGZGV9u9qvigTSETu1RQ5M=;
	b=RwckYvGbhhw0Io83LgcGrGNFXe0Zxl45i86TAllYZ89qB0wtobaJKpIoI1OVHOU7bCCNwQSiT0vXy4aoY/av6hw71P9k0IlGwofm2thBY4m5OY6xwnF8xD/6xADCZdolx18aZbpP/vHYkbGHcsWGvYBW1ImFR66S5uSwH3fsO/E=
Received: from 30.221.145.251(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WxHKQXm_1768788770 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 19 Jan 2026 10:12:51 +0800
Message-ID: <2295ba7e-b830-4177-bccb-250fca11b142@linux.alibaba.com>
Date: Mon, 19 Jan 2026 10:12:50 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] fuse: use DIV_ROUND_UP() for page count
 calculations
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org
References: <20260116235606.2205801-1-joannelkoong@gmail.com>
 <20260116235606.2205801-2-joannelkoong@gmail.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20260116235606.2205801-2-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/17/26 7:56 AM, Joanne Koong wrote:
> Use DIV_ROUND_UP() instead of manually computing round-up division
> calculations.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/fuse/dev.c  | 6 +++---
>  fs/fuse/file.c | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 6d59cbc877c6..698289b5539e 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -1814,7 +1814,7 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
>  
>  		folio_offset = ((index - folio->index) << PAGE_SHIFT) + offset;
>  		nr_bytes = min_t(unsigned, num, folio_size(folio) - folio_offset);
> -		nr_pages = (offset + nr_bytes + PAGE_SIZE - 1) >> PAGE_SHIFT;
> +		nr_pages = DIV_ROUND_UP(offset + nr_bytes, PAGE_SIZE);
>  
>  		err = fuse_copy_folio(cs, &folio, folio_offset, nr_bytes, 0);
>  		if (!folio_test_uptodate(folio) && !err && offset == 0 &&

IMHO, could we drop page offset, instead just update the file offset and
re-calculate folio index and folio offset for each loop, i.e. something
like what [1] did?

This could make the code simpler and cleaner.

BTW, it seems that if the grabbed folio is newly created on hand and the
range described by the store notify doesn't cover the folio completely,
the folio won't be set as Uptodate and thus the written data may be
missed?  I'm not sure if this is in design.

[1]
https://lore.kernel.org/linux-fsdevel/20260115023607.77349-1-jefflexu@linux.alibaba.com/


> @@ -1883,7 +1883,7 @@ static int fuse_retrieve(struct fuse_mount *fm, struct inode *inode,
>  	else if (outarg->offset + num > file_size)
>  		num = file_size - outarg->offset;
>  
> -	num_pages = (num + offset + PAGE_SIZE - 1) >> PAGE_SHIFT;
> +	num_pages = DIV_ROUND_UP(num + offset, PAGE_SIZE);
>  	num_pages = min(num_pages, fc->max_pages);
>  	num = min(num, num_pages << PAGE_SHIFT);
>  
> @@ -1918,7 +1918,7 @@ static int fuse_retrieve(struct fuse_mount *fm, struct inode *inode,
>  
>  		folio_offset = ((index - folio->index) << PAGE_SHIFT) + offset;
>  		nr_bytes = min(folio_size(folio) - folio_offset, num);
> -		nr_pages = (offset + nr_bytes + PAGE_SIZE - 1) >> PAGE_SHIFT;
> +		nr_pages = DIV_ROUND_UP(offset + nr_bytes, PAGE_SIZE);
>  
>  		ap->folios[ap->num_folios] = folio;
>  		ap->descs[ap->num_folios].offset = folio_offset;

Ditto.

> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index eba70ebf6e77..a4342b269cb9 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -2170,7 +2170,7 @@ static bool fuse_folios_need_send(struct fuse_conn *fc, loff_t pos,
>  	WARN_ON(!ap->num_folios);
>  
>  	/* Reached max pages */
> -	if ((bytes + PAGE_SIZE - 1) >> PAGE_SHIFT > fc->max_pages)
> +	if (DIV_ROUND_UP(bytes, PAGE_SIZE) > fc->max_pages)
>  		return true;
>  
>  	if (bytes > max_bytes)

-- 
Thanks,
Jingbo


