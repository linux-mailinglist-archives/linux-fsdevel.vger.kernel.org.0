Return-Path: <linux-fsdevel+bounces-15017-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA27C885EDD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 17:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC0BC1C2336B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 16:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1158132C3B;
	Thu, 21 Mar 2024 16:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gGi8xJlV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF69A18AE8;
	Thu, 21 Mar 2024 16:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711039767; cv=none; b=bhpLsmamGzj3K5uLsPmqq4c2oAj8/6kOjwdKBGIXrGZUnkyl81L3EOM9KjSVifbmokUcvo4lo45pz7G0uFUlXMGAZhZlf7JZbue/szYF0LOQDGuugZ0ZBFbMCn4haJOO3srV+Vr+h45kbLz3Ocpt0Z/J24CNT6e8kew7X9x7DMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711039767; c=relaxed/simple;
	bh=+nZPFZSgmWagI1A3CCJDLhLURWtV5kOkFvKlclMvVCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SUfBtNQiUvTYACv5CLU4kYvC9Raad4qR0XaClQIVKcfG1ZfCRSEVcdd0s+RfBo2d+p9J9h9mVvI4NmB3SAhk6wpJWnHxMHw8+7pj3oLfEMYcqdn2HwbRgwgtyS6zZ6rFKPEyOuE8dUZv7b3LOog5SsOHqK5BR8v7yOAKOPauLxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gGi8xJlV; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=V9mrRuAn6P0CI166dm0Zpc+lSpGuhBwRxOMqznP0Qc8=; b=gGi8xJlVLOIZ3mUkkfMoCqE6+p
	GYatoWTGuIQd5mIJqoYod0ls6FiejI1yWosjlReTKpX/4QcfgRsdMndn7H2he5AtOEWNIEMdv6DPj
	ZRkrHCddWZIHbCcvrE7/i9TnUatU/rJkC1W5mkzmB2GMm50FbmFnSbKcERrsBngy84FyJ5zDJA3ue
	b28mrMSpQRD3X9KSoKdZo5dJvgVF7WsSod91+d2J7u195+hFp7vmMB1eLvYgh26B8RIToR3Z1idYQ
	7DqIqZWDxe4h3KOCq8qN6htm+cvV2ALDrz/yfvX53nfhNfOQ9l3tfg2VOFzpq0RrFF/sMMqgsASJ6
	2EI1+HZQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnLb3-0000000793s-1qG7;
	Thu, 21 Mar 2024 16:48:53 +0000
Date: Thu, 21 Mar 2024 16:48:53 +0000
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
	elver@google.com, dvyukov@google.com, songmuchun@bytedance.com,
	jbaron@akamai.com, aliceryhl@google.com, rientjes@google.com,
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-arch@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com,
	cgroups@vger.kernel.org
Subject: Re: [PATCH v6 20/37] mm: fix non-compound multi-order memory
 accounting in __free_pages
Message-ID: <Zfxk9aFhF7O_-T3c@casper.infradead.org>
References: <20240321163705.3067592-1-surenb@google.com>
 <20240321163705.3067592-21-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321163705.3067592-21-surenb@google.com>

On Thu, Mar 21, 2024 at 09:36:42AM -0700, Suren Baghdasaryan wrote:
>  static inline void pgalloc_tag_add(struct page *page, struct task_struct *task,
>  				   unsigned int nr) {}
>  static inline void pgalloc_tag_sub(struct page *page, unsigned int nr) {}
>  static inline void pgalloc_tag_split(struct page *page, unsigned int nr) {}
> +static inline struct alloc_tag *pgalloc_tag_get(struct page *page) { return NULL; }
> +static inline void pgalloc_tag_sub_pages(struct alloc_tag *tag, unsigned int nr) {}
>  
>  #endif /* CONFIG_MEM_ALLOC_PROFILING */
>  
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index fd1cc5b80a56..00e0ae4cbf2d 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4700,12 +4700,15 @@ void __free_pages(struct page *page, unsigned int order)
>  {
>  	/* get PageHead before we drop reference */
>  	int head = PageHead(page);
> +	struct alloc_tag *tag = pgalloc_tag_get(page);
>  
>  	if (put_page_testzero(page))
>  		free_the_page(page, order);
> -	else if (!head)
> +	else if (!head) {
> +		pgalloc_tag_sub_pages(tag, (1 << order) - 1);
>  		while (order-- > 0)
>  			free_the_page(page + (1 << order), order);
> +	}

Why do you need these new functions instead of just:

+	else if (!head) {
+		pgalloc_tag_sub(page, (1 << order) - 1);
		while (order-- > 0)
			free_the_page(page + (1 << order), order);
+	}

