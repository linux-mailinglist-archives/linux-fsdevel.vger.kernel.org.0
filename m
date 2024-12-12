Return-Path: <linux-fsdevel+bounces-37118-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C98E59EDD3E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 02:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C5B1168184
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 01:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFE67DA6F;
	Thu, 12 Dec 2024 01:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="iS1BRYjS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B25BB640
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 01:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733968428; cv=none; b=pXSLIIibTh873L5MoqkPy28T6PA7tqeuoRHh5EbUMMZgYKAVKq35FlqTpBKFZIpqPpfQEOQ82ys1q5K9evIgWqM13BdipW7SJzDNheW+f9jLG07XWDuwt5sYCUWMle8CfQOE2xjyZp0YV/68KNrSeJ70BpZZLSFfTjQ+NL6oEoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733968428; c=relaxed/simple;
	bh=HR+E4zYVLbP2S9Jx8MLHVbsFWqbZ2+YpZjLEWASUvAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A7/QDs0iHOBE1Z56weVgcqCqA8QNZUR8O9dI6gutwgvtHw8oj8zyO9j8qD+W03+y0wE2BrVh2lJxzQAnJPtikQgbIFZpTxzel1TDnZQbY0A3swqJy7OVOkV2FMHm0sQYg5I5SHPv4e5S0IX8SMYjTb0Qm0ZpQyd5RkWzrZ8Oxa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=iS1BRYjS; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733968423; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=z0nrUyAMirsA2RFjJKp52uL59zSoBSmoj2v2aHJn32k=;
	b=iS1BRYjSKJaG9uVmLVGxCg026sCfIO+l6jpUJu3oXRRbhzZPraa80w2S7aGa8UGqtIfh8Tk+r2uKG19em5ButtA9VYXDtSvpor+XljwAG1JkM/Pah2Q37NCQXkdV7GST65V/81NIakeNxL15Dn+B8t5chsePhvoUr10qKdw+Joc=
Received: from 30.221.145.8(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WLJwA2n_1733968421 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 12 Dec 2024 09:53:42 +0800
Message-ID: <6e3da2fa-c6a2-4c15-b480-ece29351cd88@linux.alibaba.com>
Date: Thu, 12 Dec 2024 09:53:40 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] fuse: fix direct io folio offset and length
 calculation
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu,
 linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com, bernd.schubert@fastmail.fm,
 malte.schroeder@tnxip.de, willy@infradead.org, kent.overstreet@linux.dev,
 kernel-team@meta.com
References: <20241211205556.1754646-1-joannelkoong@gmail.com>
 <20241211205556.1754646-2-joannelkoong@gmail.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20241211205556.1754646-2-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/12/24 4:55 AM, Joanne Koong wrote:
> For the direct io case, the pages from userspace may be part of a huge
> folio, even if all folios in the page cache for fuse are small.
> 
> Fix the logic for calculating the offset and length of the folio for
> the direct io case, which currently incorrectly assumes that all folios
> encountered are one page size.
> 
> Fixes: 3b97c3652d91 ("fuse: convert direct io to use folios")
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/fuse/file.c | 28 ++++++++++++++++------------
>  1 file changed, 16 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 88d0946b5bc9..15b08d6a5739 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1557,18 +1557,22 @@ static int fuse_get_user_pages(struct fuse_args_pages *ap, struct iov_iter *ii,
>  
>  		nbytes += ret;
>  
> -		ret += start;
> -		/* Currently, all folios in FUSE are one page */
> -		nfolios = DIV_ROUND_UP(ret, PAGE_SIZE);
> -
> -		ap->descs[ap->num_folios].offset = start;
> -		fuse_folio_descs_length_init(ap->descs, ap->num_folios, nfolios);
> -		for (i = 0; i < nfolios; i++)
> -			ap->folios[i + ap->num_folios] = page_folio(pages[i]);
> -
> -		ap->num_folios += nfolios;
> -		ap->descs[ap->num_folios - 1].length -=
> -			(PAGE_SIZE - ret) & (PAGE_SIZE - 1);
> +		nfolios = DIV_ROUND_UP(ret + start, PAGE_SIZE);
> +
> +		for (i = 0; i < nfolios; i++) {
> +			struct folio *folio = page_folio(pages[i]);
> +			unsigned int offset = start +
> +				(folio_page_idx(folio, pages[i]) << PAGE_SHIFT);
> +			unsigned int len = min_t(unsigned int, ret, PAGE_SIZE - start);
> +
> +			ap->descs[ap->num_folios].offset = offset;
> +			ap->descs[ap->num_folios].length = len;
> +			ap->folios[ap->num_folios] = folio;
> +			start = 0;
> +			ret -= len;
> +			ap->num_folios++;
> +		}
> +
>  		nr_pages += nfolios;
>  	}
>  	kfree(pages);

LGTM.

Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>

-- 
Thanks,
Jingbo

