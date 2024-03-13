Return-Path: <linux-fsdevel+bounces-14297-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E96C487A9FE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 16:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1E3AB2262E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 15:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8B746430;
	Wed, 13 Mar 2024 15:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="u4TINEae"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0983545BEC;
	Wed, 13 Mar 2024 15:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710342293; cv=none; b=Z3UkJ+6xAb5IrvtYOuGsHSiCeN13msux/dk2jGmepDpKojTCLFiufaU2APeGPHys8KaQmd5Zdpjrvfpww/TpoeoZnQuFEq7E2GEAtE+f5C4GIORA7AXShu7dZIT31xTGon54LNHtqyJEVVvmCv3dlDhSUKp/0MX5u5/RNsXHu60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710342293; c=relaxed/simple;
	bh=mEZSaX1JcOlnF+YV8hHDQGh4aTWrB0MRoLH9GvaDuc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=po5gPQFq0GVawbB5ul9QXVcg6V9Qx037T+Q1z5P2yALEpSTPj0xH/jaDn50emqYymGowRpW3Ofub+bZcadp1hSCNrly7YqCrycX4pjiNXLvR1a4kjuOGyiDwmcGAUvUrMmxdI4YyWUD6tZvsNApwNNk40y2OpaUQfYGuFyxEEXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=u4TINEae; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BNxK5EuN2z1du2u9zHs8dUJAhvJjbhbwG8RbEiAeClc=; b=u4TINEaeR8pBfu92hqQSLLqbw1
	brpvAqC+UAYMwivkfgs4750GbK7A0qwui27QEc2QH9iUDu5HAbvxzTVnDcFLyemP/XUIx9MpoFbPi
	q4IVLXkwKfK0hyxYOhjsEbyDlhqHvslhIMnMIWKJYzFQxuE5veIEox3shpukVhJnJOi9hLp44r+EM
	DfO73+5LdareoKzomTSUfKrn8QRIKkQrbx5fl0+DUtdOpn8MXP/hU/JOuGLEbRDpiIk2OiOzBuZml
	hSNWxtuUjaxB+C0meEeMqttlRscGDUvIcxO795C5WNAIzRQjXMNkZ2PfpYOcF19WaReKmjCOY/R0S
	0uWwi/1Q==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkQ9R-00000005dNK-1tqa;
	Wed, 13 Mar 2024 15:04:17 +0000
Date: Wed, 13 Mar 2024 15:04:17 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com,
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev,
	mgorman@suse.de, dave@stgolabs.net, liam.howlett@oracle.com,
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net,
	void@manifault.com, peterz@infradead.org, juri.lelli@redhat.com,
	catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, peterx@redhat.com, david@redhat.com,
	axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
	nathan@kernel.org, dennis@kernel.org, jhubbard@nvidia.com,
	tj@kernel.org, muchun.song@linux.dev, rppt@kernel.org,
	paulmck@kernel.org, pasha.tatashin@soleen.com,
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com,
	hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org,
	ndesaulniers@google.com, vvvvvv@google.com,
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
	vschneid@redhat.com, cl@linux.com, penberg@kernel.org,
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com,
	elver@google.com, dvyukov@google.com, shakeelb@google.com,
	songmuchun@bytedance.com, jbaron@akamai.com, aliceryhl@google.com,
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com,
	kernel-team@android.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-modules@vger.kernel.org,
	kasan-dev@googlegroups.com, cgroups@vger.kernel.org
Subject: Re: [PATCH v5 20/37] mm: fix non-compound multi-order memory
 accounting in __free_pages
Message-ID: <ZfHAcVwJ6w9b1x0Z@casper.infradead.org>
References: <20240306182440.2003814-1-surenb@google.com>
 <20240306182440.2003814-21-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306182440.2003814-21-surenb@google.com>

On Wed, Mar 06, 2024 at 10:24:18AM -0800, Suren Baghdasaryan wrote:
> When a non-compound multi-order page is freed, it is possible that a
> speculative reference keeps the page pinned. In this case we free all
> pages except for the first page, which will be freed later by the last
> put_page(). However put_page() ignores the order of the page being freed,
> treating it as a 0-order page. This creates a memory accounting imbalance
> because the pages freed in __free_pages() do not have their own alloc_tag
> and their memory was accounted to the first page. To fix this the first
> page should adjust its allocation size counter when "tail" pages are freed.

It's not "ignored".  It's not available!

Better wording:

However the page passed to put_page() is indisinguishable from an
order-0 page, so it cannot do the accounting, just as it cannot free
the subsequent pages.  Do the accounting here, where we free the pages.

(I'm sure further improvements are possible)

> +static inline void pgalloc_tag_sub_bytes(struct alloc_tag *tag, unsigned int order)
> +{
> +	if (mem_alloc_profiling_enabled() && tag)
> +		this_cpu_sub(tag->counters->bytes, PAGE_SIZE << order);
> +}

This is a terribly named function.  And it's not even good for what we
want to use it for.

static inline void pgalloc_tag_sub_pages(struct alloc_tag *tag, unsigned int nr)
{
	if (mem_alloc_profiling_enabled() && tag)
		this_cpu_sub(tag->counters->bytes, PAGE_SIZE * nr);
}

> +++ b/mm/page_alloc.c
> @@ -4697,12 +4697,21 @@ void __free_pages(struct page *page, unsigned int order)
>  {
>  	/* get PageHead before we drop reference */
>  	int head = PageHead(page);
> +	struct alloc_tag *tag = pgalloc_tag_get(page);
>  
>  	if (put_page_testzero(page))
>  		free_the_page(page, order);
>  	else if (!head)
> -		while (order-- > 0)
> +		while (order-- > 0) {
>  			free_the_page(page + (1 << order), order);
> +			/*
> +			 * non-compound multi-order page accounts all allocations
> +			 * to the first page (just like compound one), therefore
> +			 * we need to adjust the allocation size of the first
> +			 * page as its order is ignored when put_page() frees it.
> +			 */
> +			pgalloc_tag_sub_bytes(tag, order);

-	else if (!head
+	else if (!head) {
+		pgalloc_tag_sub_pages(1 << order - 1);
		while (order-- > 0)
			free_the_page(page + (1 << order), order);
+	}

It doesn't need a comment, it's obvious what you're doing.


