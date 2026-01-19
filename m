Return-Path: <linux-fsdevel+bounces-74403-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A940D3A106
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 09:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F31973032AED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 08:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E18E33B6E8;
	Mon, 19 Jan 2026 08:11:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63E333987B
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jan 2026 08:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768810287; cv=none; b=DuIvG4XVuB+wsm+zSejw/7pbnc4X37EavJ4WVK61HTjwVPLU87WsoF5oEU+weqQrKo2tLP0d48aoKUFwqRxmE4NGj7oUXZJhMyuGeDwboayoExqcj8CBlUv4UfVGkbzAz1QXLYZYD+4wza7wQphdi+4e4M2cCL/WQkFA9myoXPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768810287; c=relaxed/simple;
	bh=R9mGXe0YtqXqBfrHBHmckzaEzFztxk6jB72ys9GdZWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lJuxmt+f+jFzCrJpZpoj3oIRFP+ZdjbTOiyhZwN7Fay3PgKu4lz1enRt7uCtaPECmaPHlqdzHgg44Us6LsnItsXSg/4MqbeAtZdjvKC9jbLjGT6V2Aix2100e2M6wZd7D8X2pcp1IJNYSZFN73yn03PkkPgMXhh9dhi5mGPHE8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu; spf=pass smtp.mailfrom=ustc.edu; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ustc.edu
Received: from [10.26.132.114] (gy-adaptive-ssl-proxy-4-entmail-virt151.gy.ntes [101.226.143.241])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3119d5bfe;
	Mon, 19 Jan 2026 12:41:54 +0800 (GMT+08:00)
Message-ID: <041320b0-c11a-4332-965b-b0698ac89092@ustc.edu>
Date: Mon, 19 Jan 2026 12:41:54 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] fuse: use offset_in_folio() for large folio offset
 calculations
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org, jefflexu@linux.alibaba.com
References: <20260116235606.2205801-1-joannelkoong@gmail.com>
 <20260116235606.2205801-3-joannelkoong@gmail.com>
From: Chunsheng Luo <luochunsheng@ustc.edu>
In-Reply-To: <20260116235606.2205801-3-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9bd48f38b303a2kunm26382180309229
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZH05OVkNLQhhLSx9PQhlJQ1YeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKS0pVSUlNVUpPSFVJT0pZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0hVSktLVU
	pCS0tZBg++



On 1/17/26 7:56 AM, Joanne Koong wrote:
> Use offset_in_folio() instead of manually calculating the folio offset.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>   fs/fuse/dev.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 698289b5539e..4dda4e24cc90 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -1812,7 +1812,7 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
>   		if (IS_ERR(folio))
>   			goto out_iput;
>   
> -		folio_offset = ((index - folio->index) << PAGE_SHIFT) + offset;
> +		folio_offset = offset_in_folio(folio, outarg.offset);

offset is a loop variable, and later offset will be set to 0. Replacing 
it with outarg.offset here would change the behavior. The same applies 
to the cases below. Will there be any problem here?

Thanks,
Chunsheng Luo

>   		nr_bytes = min_t(unsigned, num, folio_size(folio) - folio_offset);
>   		nr_pages = DIV_ROUND_UP(offset + nr_bytes, PAGE_SIZE);
>   
> @@ -1916,7 +1916,7 @@ static int fuse_retrieve(struct fuse_mount *fm, struct inode *inode,
>   		if (IS_ERR(folio))
>   			break;
>   
> -		folio_offset = ((index - folio->index) << PAGE_SHIFT) + offset;
> +		folio_offset = offset_in_folio(folio, outarg->offset);
>   		nr_bytes = min(folio_size(folio) - folio_offset, num);
>   		nr_pages = DIV_ROUND_UP(offset + nr_bytes, PAGE_SIZE);
>   


