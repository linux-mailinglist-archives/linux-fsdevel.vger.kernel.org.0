Return-Path: <linux-fsdevel+bounces-2519-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 061557E6C0A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 15:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31D041C20BB8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 14:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28B61E52F;
	Thu,  9 Nov 2023 14:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bxnQJM14"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF781DFFF
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 14:06:00 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079F430CF;
	Thu,  9 Nov 2023 06:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/R3RSbCO/oRPxhx3RiVNx3CrxYoruIxF6lvTHy2TD3k=; b=bxnQJM14jc9o0SmLCxJIDDEv4L
	ldPRMuM9UXEyLkSG2XJJaSmHb9SLCJkBf8Bte7XYtweKd8tz8Pklta3mPmfHDY50y2wUBhhrw/UGj
	ZUhgjxgRjrlO5/9fEtPeoDIe/mA8TaAnXICAK5fIAAte62ArNyBkYUhsCigdwym0oUpWn2+ArW7nS
	0lGvUS0qc8+uTnicl4zFFASJRo3DCUP1f//0xIoh4Xn3Z1AAmf+M/0bOiZiafn2nAMNXrkDcrVsaA
	Gfm3kFV4te2frXDmFje2i/xxlEnoy2rTnqOFyry+X6ik+MYjp98B8tIOdwNK8LYcq8cLqIDiggC8y
	Bc53b1iQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r15fC-007elN-3C; Thu, 09 Nov 2023 14:05:42 +0000
Date: Thu, 9 Nov 2023 14:05:42 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jeff Xie <jeff.xie@linux.dev>
Cc: akpm@linux-foundation.org, iamjoonsoo.kim@lge.com, vbabka@suse.cz,
	cl@linux.com, penberg@kernel.org, rientjes@google.com,
	roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	chensong_2000@189.cn, xiehuan09@gmail.com
Subject: Re: [RFC][PATCH 2/4] mm, slub: implement slub allocate post callback
 for page_owner
Message-ID: <ZUznNn42H5vRUF0r@casper.infradead.org>
References: <20231109032521.392217-1-jeff.xie@linux.dev>
 <20231109032521.392217-3-jeff.xie@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109032521.392217-3-jeff.xie@linux.dev>

On Thu, Nov 09, 2023 at 11:25:19AM +0800, Jeff Xie wrote:
> +#ifdef CONFIG_PAGE_OWNER
> +static int slab_alloc_post_page_owner(struct folio *folio, struct task_struct *tsk,
> +			void *data, char *kbuf, size_t count)
> +{
> +	int ret;
> +	struct kmem_cache *kmem_cache = data;
> +
> +	ret = scnprintf(kbuf, count, "SLAB_PAGE slab_name:%s\n", kmem_cache->name);
> +
> +	return ret;
> +}
> +#endif

Or we could do this typesafely ...

	struct slab *slab = folio_slab(folio);
	struct kmem_cache *kmem_cache = slab->slab_cache;

... and then there's no need to pass in a 'data' to the function.

