Return-Path: <linux-fsdevel+bounces-63927-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0178BD1E96
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 10:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B8E23B2AB9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 08:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E99D2EBBA6;
	Mon, 13 Oct 2025 08:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uEaoIvCz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD502EB5A3;
	Mon, 13 Oct 2025 08:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760342575; cv=none; b=hAt0uATVo0gwhIXrjMxjVaoRlXWOomE04pFkE++KLsEyI7I2L8cbU6hmDBcc1/XAsHxJFuA/SD7wCnJQAGQ8MqQzZcuPjHJt4hEWYscuUvUFN2rmsBbYq7u9kSfW/irZxZpidr8ub+47kDUuqX+W7ZK2cSwqPc/FJV7RCe51cGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760342575; c=relaxed/simple;
	bh=JmTNokf/Y0BVZcHoL0mzR2f+X5eoue5G/y7OJfo9XEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N9o6g5X8WDiZFoKgQU1TnyZq3qe3uqXallSqrqtL4tV9CL1wz2fO/bAYo4CqsN5NaVGegxx7+l8m3hRKjpDdOdopaWUkXs2+3kvgWLDAh3f8Doj7KWYIryN9f7/L36lt1Q+wg0lHD3BALSKbPwLfl+NubNu2xbMNIBnDNlT7gq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uEaoIvCz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA8AAC4CEE7;
	Mon, 13 Oct 2025 08:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760342575;
	bh=JmTNokf/Y0BVZcHoL0mzR2f+X5eoue5G/y7OJfo9XEY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uEaoIvCz69w/jGeDcmPCeRev/Gwhggq2w1BemWI2FV+vIIHgCZfedXZbDbxig3nz5
	 YEEvDrPMNVBhGkDcdL4D7+afM7BS+U46TjfzCfmMUbUq8wdnxVxu/rWwNSUsmNBrC0
	 7q4NDle476VCpxVswTJQZFdwb4gtB8qjIWs0OWDqhvqSyu+sejmM4W+nqXYX6OWB+w
	 3YX9DQddSWJp1CG+4QkrvP2HQBNffvVwG/IsXhshs81RHld94oUMNzNcn1Jpka4F1G
	 jioX/6pXoqtfgFVvtKO1hNkmKs4EOzqrcSvW3e8KZS4/9HC3na9qgqxYjI90ASKhh5
	 o2Hqr/Il6R4Mw==
Message-ID: <4e508d42-9cd4-481a-904f-535b1de0b765@kernel.org>
Date: Mon, 13 Oct 2025 17:02:50 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] mm: remove __filemap_fdatawrite
To: Christoph Hellwig <hch@lst.de>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov
 <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>,
 Christian Schoenebeck <linux_oss@crudebyte.com>, Chris Mason <clm@fb.com>,
 David Sterba <dsterba@suse.com>, Mark Fasheh <mark@fasheh.com>,
 Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
 Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org, v9fs@lists.linux.dev,
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
 ocfs2-devel@lists.linux.dev, linux-xfs@vger.kernel.org, linux-mm@kvack.org
References: <20251013025808.4111128-1-hch@lst.de>
 <20251013025808.4111128-8-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20251013025808.4111128-8-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025/10/13 11:58, Christoph Hellwig wrote:
> And rewrite filemap_fdatawrite to use filemap_fdatawrite_range instead
> to have a simpler call chain.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  mm/filemap.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index b95e71774131..bbd5d5eaa661 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -422,25 +422,19 @@ int __filemap_fdatawrite_range(struct address_space *mapping, loff_t start,
>  	return filemap_fdatawrite_wbc(mapping, &wbc);
>  }
>  
> -static inline int __filemap_fdatawrite(struct address_space *mapping,
> -	int sync_mode)
> +int filemap_fdatawrite_range(struct address_space *mapping, loff_t start,
> +		loff_t end)
>  {
> -	return __filemap_fdatawrite_range(mapping, 0, LLONG_MAX, sync_mode);
> +	return __filemap_fdatawrite_range(mapping, start, end, WB_SYNC_ALL);
>  }
> +EXPORT_SYMBOL(filemap_fdatawrite_range);
>  
>  int filemap_fdatawrite(struct address_space *mapping)
>  {
> -	return __filemap_fdatawrite(mapping, WB_SYNC_ALL);
> +	return filemap_fdatawrite_range(mapping, 0, LONG_MAX);

This should be LLONG_MAX, no ?

>  }
>  EXPORT_SYMBOL(filemap_fdatawrite);
>  
> -int filemap_fdatawrite_range(struct address_space *mapping, loff_t start,
> -				loff_t end)
> -{
> -	return __filemap_fdatawrite_range(mapping, start, end, WB_SYNC_ALL);
> -}
> -EXPORT_SYMBOL(filemap_fdatawrite_range);
> -
>  /**
>   * filemap_fdatawrite_range_kick - start writeback on a range
>   * @mapping:	target address_space
> @@ -470,7 +464,7 @@ EXPORT_SYMBOL_GPL(filemap_fdatawrite_range_kick);
>   */
>  int filemap_flush(struct address_space *mapping)
>  {
> -	return __filemap_fdatawrite(mapping, WB_SYNC_NONE);
> +	return filemap_fdatawrite_range_kick(mapping, 0, LLONG_MAX);
>  }
>  EXPORT_SYMBOL(filemap_flush);
>  


-- 
Damien Le Moal
Western Digital Research

