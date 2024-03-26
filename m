Return-Path: <linux-fsdevel+bounces-15276-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7AA888B826
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 04:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87BE51F3F069
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 03:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C981292F2;
	Tue, 26 Mar 2024 03:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SCLuPgk5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CB357314;
	Tue, 26 Mar 2024 03:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711422793; cv=none; b=b8l+RZyQNKuVhJCP8p57XO2l2LgvOVMgKSKmNx8CHfqyiiWhV2gCxY7L5cQJS+QSXMMGQaevOuSQYr6Ym7YIAysiMYO/Y0we0zyde9mgkttFIvZZJjh+LDx8GJuaii7NiHxvWY5UIL8IaxdYICmUxvKnA5Jz4MXqmg2SPc6SlZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711422793; c=relaxed/simple;
	bh=FwGoHomiC96TQlvY/JajBwhK2/NC3YF4AOwU6GXj5Nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GO/bxbpU8acTQ71fF+2QUhPZBq43earJUHlDi2doOzyH5F8lzuP9+RMPLOgzJp5hwrxGDEUTuNlqMOi2Hmms94oYOI0c56nCG6Z6fSZfRX/xu/oGtyy0Q6yIn/sESKlzEmfxRLyFmQVxqG/3BKsAG8v/BgKALcBgvYW/tjbzb4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SCLuPgk5; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oyTIYfAEgFR5EqikXW3EqaVFHy5A7Gf0H+FFygqy/tY=; b=SCLuPgk5eGRHTeejI7Po8CxJNS
	bbsYrw4YA1RuHwQTN3lJSqv0cJSQcoH3NsUnHsCLUTRrfJWekmABSNIEgOKhEMlB8dnHghsjIdFjH
	tbov3PTpb0mXI/yE5w3u/IVAXlC1QXni5Bz5wSTdDFmtmk3/lUQVqBMRUB9JCEGMaZRxGPpLSKzI8
	AkEU50g2pNUrPdELPskDeHhnLyEAClZf8W9he7Cc9V+7bQe2F0mZfyzWa1l9zDCSP6kaY+j2mVk7o
	yGjKWP4eAvQ2SZs4EGAA8NkZAxQg0NaXHyaK9US3OwjCxbPOUVpB0PZEswh/elWS8A6JeJkH0GU+N
	ub3NBf9A==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1roxEn-00000000Lm5-3f0u;
	Tue, 26 Mar 2024 03:12:34 +0000
Date: Tue, 26 Mar 2024 03:12:33 +0000
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
Subject: Re: [PATCH v6 14/37] lib: introduce support for page allocation
 tagging
Message-ID: <ZgI9Iejn6DanJZ-9@casper.infradead.org>
References: <20240321163705.3067592-1-surenb@google.com>
 <20240321163705.3067592-15-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321163705.3067592-15-surenb@google.com>

On Thu, Mar 21, 2024 at 09:36:36AM -0700, Suren Baghdasaryan wrote:
> +++ b/include/linux/pgalloc_tag.h
> @@ -0,0 +1,78 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * page allocation tagging
> + */
> +#ifndef _LINUX_PGALLOC_TAG_H
> +#define _LINUX_PGALLOC_TAG_H
> +
> +#include <linux/alloc_tag.h>
> +
> +#ifdef CONFIG_MEM_ALLOC_PROFILING
> +
> +#include <linux/page_ext.h>
> +
> +extern struct page_ext_operations page_alloc_tagging_ops;
> +extern struct page_ext *page_ext_get(struct page *page);
> +extern void page_ext_put(struct page_ext *page_ext);

Why are you duplicating theses two declarations?

I just deleted them locally and don't see any build problems.  tested with
x86-64 defconfig (full build), allnoconfig full build and allmodconfig
mm/ and fs/ (nobody has time to build allmodconfig drivers/)

