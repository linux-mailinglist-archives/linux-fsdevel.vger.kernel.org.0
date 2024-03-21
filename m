Return-Path: <linux-fsdevel+bounces-15018-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70453885F3D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 18:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C0D6281422
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 17:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040CC133400;
	Thu, 21 Mar 2024 17:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KvEPlgWf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66344136987;
	Thu, 21 Mar 2024 17:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711040676; cv=none; b=qt9bviJcKKW3Up84bm87z6LegY4SJWV3r/CSDIP4vieK8ldMajdKpAKYFYQQM+zB3EanUgvRsFKlhajWlbMaBeRo6Nr4LyjR0VwEzeLJPA7LH7xRKfrGBv9BPYOz+8k8+a1Qz2r/F1soKqc01otNm/0y3r2CPlLcdbS3kf5ypVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711040676; c=relaxed/simple;
	bh=3a9JT906FSpCQ7vJqxUgfHklkTuG5j6K5wk2J4O7OhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qyKmGMjcA+RUQm0P5E49w5sHuuqsffLNm6tfh2eeYS7d8RayIKC1l5fXtv2SFnUJDiNNv2C+is0VeFWhLQ50gQPp4xD13/ovoyOe8sajAWRgbwBZCu91BIc7VY4jjYLdE3jVErp4P2KRD3IOWmwO+E6AqXvQOjVuUkDbZeX2Uzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KvEPlgWf; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=grrtrTSALnjlmhusaSmHuxgXHvy0PaqBERbW2XOksq0=; b=KvEPlgWfmkZUIIq92E2QZaaPjt
	VZnhAGfpOn0TI3GH3pJGkjjDKFGgCnRVoZXS0BnLBMeD1ysCOzMVESTZFH2ZdWFKAFjnnJlrR5uI5
	zf/WrZhxkWHn8GwTIdG1zh3HdqNwj7dYkA4xHqWXF2ODLbgR0RW1k0j0tjtwj8yFbkmKVhWzVS3Y6
	TOQjkHw4Zx3NY/0ztZG4Etw6zBRqBCBnusj92jv7s9yw0pEcoFBeAfAg1WXXNifPuRvLrVhXYEOSk
	xN0Lo7fv/rEgNH7tG5XAA+oXF4lQKAZALSzMZaggWOEPJTF9gdOPdlAxh7rTpUSFkYhhy2AZFvZTI
	zY4tyT5A==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnLpl-00000007AzI-40SJ;
	Thu, 21 Mar 2024 17:04:06 +0000
Date: Thu, 21 Mar 2024 17:04:05 +0000
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
Message-ID: <ZfxohXDDCx-_cJYa@casper.infradead.org>
References: <20240321163705.3067592-1-surenb@google.com>
 <20240321163705.3067592-21-surenb@google.com>
 <Zfxk9aFhF7O_-T3c@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zfxk9aFhF7O_-T3c@casper.infradead.org>

On Thu, Mar 21, 2024 at 04:48:53PM +0000, Matthew Wilcox wrote:
> On Thu, Mar 21, 2024 at 09:36:42AM -0700, Suren Baghdasaryan wrote:
> > +++ b/mm/page_alloc.c
> > @@ -4700,12 +4700,15 @@ void __free_pages(struct page *page, unsigned int order)
> >  {
> >  	/* get PageHead before we drop reference */
> >  	int head = PageHead(page);
> > +	struct alloc_tag *tag = pgalloc_tag_get(page);
> >  
> >  	if (put_page_testzero(page))
> >  		free_the_page(page, order);
> > -	else if (!head)
> > +	else if (!head) {
> > +		pgalloc_tag_sub_pages(tag, (1 << order) - 1);
> >  		while (order-- > 0)
> >  			free_the_page(page + (1 << order), order);
> > +	}
> 
> Why do you need these new functions instead of just:
> 
> +	else if (!head) {
> +		pgalloc_tag_sub(page, (1 << order) - 1);
> 		while (order-- > 0)
> 			free_the_page(page + (1 << order), order);
> +	}

Actually, I'm not sure this is safe (I don't fully understand codetags,
so it may be safe).  What can happen is that the put_page() can come in
before the pgalloc_tag_sub(), and then that page can be allocated again.  
Will that cause confusion?


