Return-Path: <linux-fsdevel+bounces-65292-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F03CC00885
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 12:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 77CBB505A0D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 10:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76378286D53;
	Thu, 23 Oct 2025 10:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="Y2TNMu1R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bkGTLclj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b4-smtp.messagingengine.com (flow-b4-smtp.messagingengine.com [202.12.124.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF6330C608;
	Thu, 23 Oct 2025 10:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761215714; cv=none; b=cJrAVrIUVHDGaAZztV21Lrn3DZ479amlwswiD4OW1AjZ3avxPxxqJg1QfAl7otUqnvIJymLdOgw5UazuydkRwUHt8Bqt27rzz/rV+/OF+Lf71lvF2SnxIuIyg5vtBHeqfmjJoqDHNn/t4YteJHvBQzsUHDRFIA3zqONyOMZlwSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761215714; c=relaxed/simple;
	bh=Yp4AGbwTjJRWVu/TDxMsNtoFpRIA8iKOS9hFiOKLKuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q0Hlf0/TMJ/IyCUgYeF97tfO6vhxU29R+lMKZAzlWqI/YQhdtkYlRG1kG0UbgO8B8ovMNaLLtUkmn3WTzT9g9lNnrfKHcQfnkxNoTADsCmQ5BTkphSSdNrcQ0dfQAHUp+X1d0wTZ4UKVUoeAtl6vD+97DjjBZCO3kAqffmtKHUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=Y2TNMu1R; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bkGTLclj; arc=none smtp.client-ip=202.12.124.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id B3F211300A8F;
	Thu, 23 Oct 2025 06:35:10 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 23 Oct 2025 06:35:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1761215710; x=
	1761222910; bh=bYmq2ugvpkpXSrVwqUBpprPYISDR+qbKwRgzp5kUFsU=; b=Y
	2TNMu1R/Hmaxixa7EY9KFKJn7u9r7hsO+JQ5asjhvqpcB46WSh3NNlgph4rDacf6
	t8KM0o7BdHtBNDPB9oZthNfJ6FPpGAz82uOtOiGrqJnjCC6LcsPXjJGbQ/jfg1OG
	H68EfJeTwjAx06MJoqNTply+A5OgftFdEDieXOG7xbiYYdzmWyU7rKPrEclNf6XG
	+9e449UpGPkJMs0ybRbPEmAgdyeiiVPKJ32HH9jXnQ93cLfa6MHBnH4PbP2gFTca
	TYOC8wdC7nwtqGYnfwtNaE2IymNCC3sG17+zTUELRe3CXMGNQnejWEB7WcNwQtV4
	wkGaTMqOy1AO7ZGG9wHlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761215710; x=1761222910; bh=bYmq2ugvpkpXSrVwqUBpprPYISDR+qbKwRg
	zp5kUFsU=; b=bkGTLcljrPmX4vdyZOKSSNoYkIcFwE89tt6AJEXq6lmrM6pm+8m
	FHY+XlvDM/lU+lgNd+u/lBo46MuFbFVua907mZFqRTI0EFJO+GWVwn5QY5LXQa8P
	99tqgFzZn3vFhkCPnveTuhgRwg55IwlNxox7iKuh5WyeFdTjgvxoY+iPo5MlV0lx
	kl1znRafVbu6k5KHQBMhavXxq7tYpJn3Gpd6B/IJ8o5hrD+/YvGHBQyliZTO1rGh
	4P1ZV7czuMwqgQv0G6eQwJShWQsiB2M5KzI3oPhwU1iYF0lkLEC/oaUT6nFLrkXq
	gKpx2sM3pJc74HKyEY7XX1/4wjRq9ch+13w==
X-ME-Sender: <xms:3QT6aDgv3Xg8jV1cRGYBv2byRNBlDfxiZNTnYKqRsj2026byvJzSeA>
    <xme:3QT6aBiHAAgUxITThuMDB2_jMTdSUBo4qN1ZLu_WvxQ5UBHpryXYun8R1rvzo4yca
    ebRlfi_-zuHMBT4UHGjS0tFyY11c9Y_nQpmoFJcg4lIva1jvx22wQs>
X-ME-Received: <xmr:3QT6aLuj0fAmu5U_e8ZOKYsXnJnyfFmOvNEMqGDocytIYTTyoHV-8e1O57wWxQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeeivdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgeqnecugg
    ftrfgrthhtvghrnhepjeehueefuddvgfejkeeivdejvdegjefgfeeiteevfffhtddvtdel
    udfhfeefffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhopeeg
    iedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrvhhiugesfhhrohhmohhrsg
    hithdrtghomhdprhgtphhtthhopehjrggtkhesshhushgvrdgtiidprhgtphhtthhopegr
    khhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepuggrvh
    hiugesrhgvughhrghtrdgtohhmpdhrtghpthhtohephhhughhhugesghhoohhglhgvrdgt
    ohhmpdhrtghpthhtohepfihilhhlhiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtth
    hopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtghpthhtohepsghr
    rghunhgvrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhorhgvnhiiohdrshhtoh
    grkhgvshesohhrrggtlhgvrdgtohhm
X-ME-Proxy: <xmx:3QT6aCTLGULRLFLKch7HbZR4TKR9zTiyjLngH7649pjWnJ2k1Agl2Q>
    <xmx:3QT6aEEQLhacD3wRELmrGgrBxzKQU8aJK1m0APZ5MhYVX7LI870guw>
    <xmx:3QT6aEiX_vBkQ4dzeoH32eZgFFhm5d_pjAhMCiEJDDsHDgS-8a2ZHw>
    <xmx:3QT6aCgQEOejXwzF0EJlnh_6rx8N6289dCUVp_oSVPIRU-Ti6ao_kA>
    <xmx:3gT6aGrl_OOIC_ym-3o_L0rAdx9CNBYWTKFTHCmpPaqJKiK-E8avBF_A>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Oct 2025 06:35:08 -0400 (EDT)
Date: Thu, 23 Oct 2025 11:35:06 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>, 
	Harry Yoo <harry.yoo@oracle.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Darrick J. Wong" <djwong@kernel.org>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [RFC, PATCH 0/2] Large folios vs. SIGBUS semantics
Message-ID: <lv74va34dbeyacenvdzulfudgsvntuu2u7jutpjjysfl42kkro@vvkzmctnilnp>
References: <20251020163054.1063646-1-kirill@shutemov.name>
 <aPbFgnW1ewPzpBGz@dread.disaster.area>
 <d7s4dpxtfwf2kdp4zd7szy22lxrhdjilxrsrtpm7ckzsnosdmo@bq43jwx7omq3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7s4dpxtfwf2kdp4zd7szy22lxrhdjilxrsrtpm7ckzsnosdmo@bq43jwx7omq3>

On Tue, Oct 21, 2025 at 07:16:33AM +0100, Kiryl Shutsemau wrote:
> On Tue, Oct 21, 2025 at 10:28:02AM +1100, Dave Chinner wrote:
> > In critical paths like truncate, correctness and safety come first.
> > Performance is only a secondary consideration.  The overlap of
> > mmap() and truncate() is an area where we have had many, many bugs
> > and, at minimum, the current POSIX behaviour largely shields us from
> > serious stale data exposure events when those bugs (inevitably)
> > occur.
> 
> How do you prevent writes via GUP racing with truncate()?
> 
> Something like this:
> 
> 	CPU0				CPU1
> fd = open("file")
> p = mmap(fd)
> whatever_syscall(p)
>   get_user_pages(p, &page)
>   				truncate("file");
>   <write to page>
>   put_page(page);
> 
> The GUP can pin a page in the middle of a large folio well beyond the
> truncation point. The folio will not be split on truncation due to the
> elevated pin.
> 
> I don't think this issue can be fundamentally fixed as long as we allow
> GUP for file-backed memory.
> 
> If the filesystem side cannot handle a non-zeroed tail of a large folio,
> this SIGBUS semantics only hides the issue instead of addressing it.
> 
> And the race above does not seem to be far-fetched to me.

Any comments?

Jan, I remember you worked a lot on making GUP semantics sanish for file
pages. Any clues if I imagine a problem here?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

