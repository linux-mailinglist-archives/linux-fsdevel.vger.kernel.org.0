Return-Path: <linux-fsdevel+bounces-14460-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6805A87CEC1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 15:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E353BB20F7A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 14:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC7938FB2;
	Fri, 15 Mar 2024 14:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="g6icv7vD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8E61A38E1;
	Fri, 15 Mar 2024 14:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710512689; cv=none; b=rqA6wMhr31kltIz8Mav4gBr6VP0m1ycTA0jlE6QDJPC3HVyOHjQJH4xriFSw3U7OPC0bjZC56vg6ZGZL7eZpJkIvUZ/gf7mwYF7oaC6KU2+/aNomuP4MqH3MtCDjrX/Ejqxu96/a6qu+yS9MD8U/4BgKTBgQtHY3yCrsmB7pvKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710512689; c=relaxed/simple;
	bh=XvjSAIxe0XWX6keCOkIyeqiUrgXg5gc6pqVeS3VEo0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TIMEsJVar7eeXJSAWz5qqUsR+CZuwwZVpGl3k6qnKhV1sFsIzIPbRIouKhdzCLwnyeInf2VOn3QUt5607pmFoA3umUBJqoJNpOJf0Tqw7ZxJHKgl/iUJmHLsdYwernP4850X9nJsxeVUFHV5LGi1jGo5/ZSWMbhtWwqqgNT/0MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=g6icv7vD; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VRGW8z0NhLdznShUoOOXXxWys2yQ2J3P11bCMfJSNHA=; b=g6icv7vDDLgeuYr8NztGa/YyRL
	qFIBEY0IPpP1+bYI49n7SxU4bgxjkR3IrM9+Be4Fri5gtC1NtP3VH/d1pGvIeP1i2RlnVDiZtoJZn
	udcdVqfzdogl745CVcYKrrixMkz8s/WeJyK34trcBUP489ORyWp6kWDYJ43k+tSGlRwYJpnF9jjEa
	6ROrZUs/r8mqk2pR6H8I00TlCDMwoZm7KXZSFrVn3W8HTtptAlIsHnKm46b0orWAfeK+lJbYXrim+
	BdImz0lHoczac+PwFVjN8iCsjg9amJPItwdzikKwlWk9QjADmbcL4kAKoXNzxRHdIITfu2bZ5K/8d
	vQqsjzkA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rl8Tc-0000000AQWv-1Isj;
	Fri, 15 Mar 2024 14:24:04 +0000
Date: Fri, 15 Mar 2024 14:24:04 +0000
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
Subject: Re: [PATCH v5 14/37] lib: introduce support for page allocation
 tagging
Message-ID: <ZfRaBJ8nq57TAG6L@casper.infradead.org>
References: <20240306182440.2003814-1-surenb@google.com>
 <20240306182440.2003814-15-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306182440.2003814-15-surenb@google.com>

On Wed, Mar 06, 2024 at 10:24:12AM -0800, Suren Baghdasaryan wrote:
> +static inline void pgalloc_tag_add(struct page *page, struct task_struct *task,
> +				   unsigned int order)

If you make this "unsigned int nr" instead of order, (a) it won't look
completely insane (what does adding an order even mean?) and (b) you
can reuse it from the __free_pages path.

> @@ -1101,6 +1102,7 @@ __always_inline bool free_pages_prepare(struct page *page,
>  		/* Do not let hwpoison pages hit pcplists/buddy */
>  		reset_page_owner(page, order);
>  		page_table_check_free(page, order);
> +		pgalloc_tag_sub(page, order);

Obviously you'll need to make sure all the callers now pass in 1 <<
order instead of just order.


