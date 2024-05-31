Return-Path: <linux-fsdevel+bounces-20629-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF4B8D63FC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 16:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C3C31F2667D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 14:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3261115B99F;
	Fri, 31 May 2024 14:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nH1rEpv6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E7615AAB6;
	Fri, 31 May 2024 14:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717164283; cv=none; b=brikfm0nH3LT7A8ePvZWO5OMEGE/+tfWAtevoavFXtzMf3ovp+9F2UGUlTcl+OL2Y2W3bL1bnmNh45FkiSkpym/e7+jWQlX7OcxVhdxzq1EB6bxjaEpeRbzs9G3Uo2jRvUDap8RyRItdjgj8qK91XFpEynSCpdH/RCA97q8VZ0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717164283; c=relaxed/simple;
	bh=b5qIPlknK8jeWDh3WleCY1vRy0w4FGugICdq2Y4YMvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bX73YZsVLZ9z/QxvSRkdaxKfCJnhQ8lW91r75C2pgyA0ZnFmad+z3HXnhWpF9HH3MtDzd6awuO1doucnFG3Z4os9OPyYpSy0ndL0MuDGE1N0N1fgsA9w9sqY17tMsIV/8Fwf+74RocVyRw7t4ctQNXtBQh6s3k+KDkTRTx5/CNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nH1rEpv6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22FC9C116B1;
	Fri, 31 May 2024 14:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717164283;
	bh=b5qIPlknK8jeWDh3WleCY1vRy0w4FGugICdq2Y4YMvM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nH1rEpv61HPwulSaOR9famkQ9Xic/cw0ly3cU/keRssOQgODRyvAQ8PV7WBD87yXU
	 cFaFlfhSjKPQXGoNF1Zu94DAx40IXm2wtejn87Tvd+367xlR+fpKgCMu+88M2hdoLo
	 986X5yaH4gi3KaZVPOZ+5b/zpWKOli1UvgsNSLXqEz3zZxYThmHgfhkUvDYPPHARJs
	 PnY16UKVc9dfmQMLhvt/ZhJWQaz6gkxa3qSF1pm7lgMYaUdFvRvsDZD/LM2Teie5D6
	 4Iu2Dwzc3/3/vJ3ju+2RoVpW02Srb29a9VzpvZ2oa/Un5KVIBm5l85gP1JGqn+LH0k
	 2QziNQ48nuVXw==
Date: Fri, 31 May 2024 07:04:42 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, hch@infradead.org, brauner@kernel.org,
	david@fromorbit.com, chandanbabu@kernel.org, jack@suse.cz,
	willy@infradead.org, yi.zhang@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: Re: [RFC PATCH v4 2/8] math64: add rem_u64() to just return the
 remainder
Message-ID: <20240531140442.GG52987@frogsfrogsfrogs>
References: <20240529095206.2568162-1-yi.zhang@huaweicloud.com>
 <20240529095206.2568162-3-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529095206.2568162-3-yi.zhang@huaweicloud.com>

On Wed, May 29, 2024 at 05:52:00PM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Add a new helper rem_u64() to only get the remainder of unsigned 64bit
> divide with 32bit divisor.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Modulo hch's comments,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  include/linux/math64.h | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/include/linux/math64.h b/include/linux/math64.h
> index d34def7f9a8c..618df4862091 100644
> --- a/include/linux/math64.h
> +++ b/include/linux/math64.h
> @@ -3,6 +3,7 @@
>  #define _LINUX_MATH64_H
>  
>  #include <linux/types.h>
> +#include <linux/log2.h>
>  #include <linux/math.h>
>  #include <asm/div64.h>
>  #include <vdso/math64.h>
> @@ -12,6 +13,20 @@
>  #define div64_long(x, y) div64_s64((x), (y))
>  #define div64_ul(x, y)   div64_u64((x), (y))
>  
> +/**
> + * rem_u64 - remainder of unsigned 64bit divide with 32bit divisor
> + * @dividend: unsigned 64bit dividend
> + * @divisor: unsigned 32bit divisor
> + *
> + * Return: dividend % divisor
> + */
> +static inline u32 rem_u64(u64 dividend, u32 divisor)
> +{
> +	if (is_power_of_2(divisor))
> +		return dividend & (divisor - 1);
> +	return dividend % divisor;
> +}
> +
>  /**
>   * div_u64_rem - unsigned 64bit divide with 32bit divisor with remainder
>   * @dividend: unsigned 64bit dividend
> @@ -86,6 +101,15 @@ static inline s64 div64_s64(s64 dividend, s64 divisor)
>  #define div64_long(x, y) div_s64((x), (y))
>  #define div64_ul(x, y)   div_u64((x), (y))
>  
> +#ifndef rem_u64
> +static inline u32 rem_u64(u64 dividend, u32 divisor)
> +{
> +	if (is_power_of_2(divisor))
> +		return dividend & (divisor - 1);
> +	return do_div(dividend, divisor);
> +}
> +#endif
> +
>  #ifndef div_u64_rem
>  static inline u64 div_u64_rem(u64 dividend, u32 divisor, u32 *remainder)
>  {
> -- 
> 2.39.2
> 
> 

