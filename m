Return-Path: <linux-fsdevel+bounces-8320-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB8E832DAB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 18:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F0781F247AC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 17:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B3455C29;
	Fri, 19 Jan 2024 17:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aAs5qV0R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C9B4C624;
	Fri, 19 Jan 2024 17:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705683900; cv=none; b=TpS3suaInW+SPgr0a2IY0+9u0pOT33eZh0fUjP7090mpJhOVo9HKI5Ax2Px09xDGlckkwe8pZKoJhc+XDZIOso8rBpVQJX/RAFavCGwqjH7RtSQP0bm0ISe9yrGgzKX0wGnrFUgyU6tF1PWu06IOrfJ+6xomUIQP1x1QxTsbDlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705683900; c=relaxed/simple;
	bh=OQZrjxKzIhKg+foJNv2n8JT3D+7G1NjqrJIhys/Imjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L43Db3HMiWYIxApRLPSecL7KT2AJ3j+6pp5KK0qwlwv8Q0GHafNVBniTQLwE8Hn1Wpr4x5rmP1/QRokeLI5U01Wnxv49eBv/sMpD5v9sYik+Z8g9SMcItHCnvanH7BBdGkB0A3ItfPbl08QSN+tp9H8b64WO1cr/l87LZD/a63s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aAs5qV0R; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LLJKl+AAhGh5Pf+cmVaB+vB6xM+m/TjxoqlPtwqp82Y=; b=aAs5qV0R1R25DORcXY14HSEdj1
	yyfgveXeG8pK/B7oxJxjhIL8/ufipq4KtMZLgZZVeS/ydew7vUWSjXdq+Vt2fGJXGTrGL2a50LpyL
	1f06jFZRfy95zgVSMZSD/VDD370A4n7N54iUA+dt0ge/EHwRxvne//fbHSXQ0RHAJ5S/pX2FeqlRU
	XRbUz+8iw/JkjoouqeQzedGdwpD/kIyhBAbfUjqpbO6dOgeGNV7v55Gl5UhDC6ow1liWD+FSr222R
	Q36hS3jw/qp0gcifKR7Zo7vBznlQF4usXtVtdlRsrqdJCD+S7P9yo9l6Y5IVPhHvPnR5+aVzbGGkH
	RZCtTnSA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rQsIa-00000005ofX-2S7M;
	Fri, 19 Jan 2024 17:04:56 +0000
Date: Fri, 19 Jan 2024 17:04:56 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] idr test suite: Remove usage of the deprecated
 ida_simple_xx() API
Message-ID: <ZaqruGVz734zjxrZ@casper.infradead.org>
References: <81f44a41b7ccceb26a802af473f931799445821a.1705683269.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81f44a41b7ccceb26a802af473f931799445821a.1705683269.git.christophe.jaillet@wanadoo.fr>

On Fri, Jan 19, 2024 at 05:54:44PM +0100, Christophe JAILLET wrote:
> ida_alloc() and ida_free() should be preferred to the deprecated
> ida_simple_get() and ida_simple_remove().
> 
> Note that the upper limit of ida_simple_get() is exclusive, but the one of
> ida_alloc_range()/ida_alloc_max() is inclusive. But because of the ranges
> used for the tests, there is no need to adjust them.
> 
> While at it remove some useless {}.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> It should be a question of weeks now before being able to remove the
> ida_simple_*() API.
> So it is time to convert the testing framework.

Oh, that's fantastic news!  Thank you for finishing off this conversion!

I don't have anything pending for the IDA/IDR/XArray right now.  Either
Andrew can grab this as a misc patch, or we can leave it for a cycle and
I'll put it in along with the removal of the rest of the simple API.  If
the former,

Acked-by: Matthew Wilcox (Oracle) <willy@infradead.org>

> ---
>  tools/testing/radix-tree/idr-test.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/radix-tree/idr-test.c b/tools/testing/radix-tree/idr-test.c
> index ca24f6839d50..bb41e93e2acd 100644
> --- a/tools/testing/radix-tree/idr-test.c
> +++ b/tools/testing/radix-tree/idr-test.c
> @@ -503,14 +503,12 @@ void ida_simple_get_remove_test(void)
>  	DEFINE_IDA(ida);
>  	unsigned long i;
>  
> -	for (i = 0; i < 10000; i++) {
> -		assert(ida_simple_get(&ida, 0, 20000, GFP_KERNEL) == i);
> -	}
> -	assert(ida_simple_get(&ida, 5, 30, GFP_KERNEL) < 0);
> +	for (i = 0; i < 10000; i++)
> +		assert(ida_alloc_max(&ida, 20000, GFP_KERNEL) == i);
> +	assert(ida_alloc_range(&ida, 5, 30, GFP_KERNEL) < 0);
>  
> -	for (i = 0; i < 10000; i++) {
> -		ida_simple_remove(&ida, i);
> -	}
> +	for (i = 0; i < 10000; i++)
> +		ida_free(&ida, i);
>  	assert(ida_is_empty(&ida));
>  
>  	ida_destroy(&ida);
> -- 
> 2.43.0
> 

