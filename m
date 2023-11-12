Return-Path: <linux-fsdevel+bounces-2780-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F02267E916C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Nov 2023 16:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 989E31F20F8C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Nov 2023 15:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B03814AA2;
	Sun, 12 Nov 2023 15:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fwDKDwer"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9044A14288
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 Nov 2023 15:31:15 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71FF26A4;
	Sun, 12 Nov 2023 07:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zUEpPvccKq1228cqSGVqzulj2S9OqfksLKj73WE+Ea8=; b=fwDKDwerXQt+5I6Oq5CpT5NEV6
	dIODJwyfSfESZ1FA0Upu3ke9D3NTr4V+Bya/Eo8ivD6t1FCzZJnbWrHsyRoG24PeDhWg5jX5VdH7l
	8JeQphD7K59GH0q9VKSxGwsE7RbSD+aXXjb75XPuIV4cGuLxjaS+nolKvDA+7wH3nwFgENlmFsqE6
	fsOOqIOZqy/Nuh3fC+J/WJqM2fO84CsWHTnjFOI+VUP0ZCTZeQWZrlgBhfWSdh5QJOw/cDBN5bpWq
	z/PrfJjs/ajEJ8GorbuEQHVgU6C8BOJUE54IIEIZLbgPJtVC7w7DpAaK8kRP4jWEF+WN1nec7RwTw
	kbFN5gjw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r2CQY-008nil-SV; Sun, 12 Nov 2023 15:31:10 +0000
Date: Sun, 12 Nov 2023 15:31:10 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "shiqiang.deng" <shiqiang.deng213@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] test_ida: Fix compilation errors
Message-ID: <ZVDvvpuD98G+oioL@casper.infradead.org>
References: <20231112070840.327190-1-shiqiang.deng213@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231112070840.327190-1-shiqiang.deng213@gmail.com>

On Sun, Nov 12, 2023 at 03:08:40PM +0800, shiqiang.deng wrote:
> In lib/test_ida.c, we found that IDA_BUG_ON
> uses the ida_dump() function. When __ Kernel__ is not defined,
> a missing-prototypes error will occur during compilation.
> Fix it now.

I'm confused.  What were you doing to get this error?

> Signed-off-by: shiqiang.deng <shiqiang.deng213@gmail.com>
> ---
>  include/linux/idr.h | 4 ++++
>  lib/idr.c           | 2 +-
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/idr.h b/include/linux/idr.h
> index a0dce14090a9..e091efdc0cf7 100644
> --- a/include/linux/idr.h
> +++ b/include/linux/idr.h
> @@ -109,6 +109,10 @@ static inline void idr_set_cursor(struct idr *idr, unsigned int val)
>  #define idr_unlock_irqrestore(idr, flags) \
>  				xa_unlock_irqrestore(&(idr)->idr_rt, flags)
>  
> +#ifndef __KERNEL__
> +void ida_dump(struct ida *ida);
> +#endif
> +
>  void idr_preload(gfp_t gfp_mask);
>  
>  int idr_alloc(struct idr *, void *ptr, int start, int end, gfp_t);
> diff --git a/lib/idr.c b/lib/idr.c
> index 13f2758c2377..66d0c6e30588 100644
> --- a/lib/idr.c
> +++ b/lib/idr.c
> @@ -589,7 +589,7 @@ static void ida_dump_entry(void *entry, unsigned long index)
>  	}
>  }
>  
> -static void ida_dump(struct ida *ida)
> +void ida_dump(struct ida *ida)
>  {
>  	struct xarray *xa = &ida->xa;
>  	pr_debug("ida: %p node %p free %d\n", ida, xa->xa_head,
> -- 
> 2.30.0
> 

