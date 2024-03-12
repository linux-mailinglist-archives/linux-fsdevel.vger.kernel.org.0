Return-Path: <linux-fsdevel+bounces-14236-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6C2879C48
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 20:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D1751C21F03
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 19:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF208142903;
	Tue, 12 Mar 2024 19:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LqyDIbGj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA4114263A;
	Tue, 12 Mar 2024 19:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710271992; cv=none; b=GRhIQ3k/FizvD8et6Jn6M0HpAV2GdJ+lC8UgsZQUk/HyGzAQy3Q7IZOr12XkPvECFm8egP74qHSp8s4SKGirODVusI6cyqPdIXMJvOv9cQsntjTqZfrFpnAUtvcNlkAaGP9AV+j9jwBKLqFdtL42L0ToSfypmLEB5cYo4QUqjZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710271992; c=relaxed/simple;
	bh=YmQF7O6DR+mxRv2WxozK861oQq0jmfUGuyvloZmLcco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sDFtzn6Qlgg7wpMyZlW2YAxj4rdZs4c4SCubQJXZ58B7L1W9Vv9L8zr85gEA0vvj0qErHwP50flKqHL3wuycuYI4yVZf7XU60PSo4DOad+rlQ1nQWQrajML76AP/67kx2vLhrKrM8xXCajN+BZgcLTi59wI64Bz++J4jf0XUQ9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LqyDIbGj; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kubIgq/GdbJcvxgMJi1o1EH2/AWxnGiUKA6KgBSz0r4=; b=LqyDIbGj41wCOr/hh8HuGexIVM
	hKJs36dID9db94U5lPlL9RGQn4OGs56qUagNn3RN+BuhkHxSkWAPv8LGx46v43R6a3VnNNgJxraVA
	+oXI0XYJZEqr19DPK5pVw8C/rg4Xr0YPEjUebI2nI6xHRWb1ToC+vCRSA18CirbJbRCLKk/Bkf0TN
	SCijgrPz2C4jqtXvHv5z24xlvun8gekZrgxKprK3c3AC1DesTU8q4ym1m+mKVMZWhm117BGtWNXrp
	CF25rtoQzkJ++o1FL6ZsOlOnOP2JVkBHTbKIYNyEXpjm2ktIWzW6KeM25jO7j79hGY9+U5WuRoC7w
	0/+4mblg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rk7rt-00000003k5Z-3F5B;
	Tue, 12 Mar 2024 19:32:57 +0000
Date: Tue, 12 Mar 2024 19:32:57 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>, Kees Cook <kees@kernel.org>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 2/4] mm, slab: move slab_memcg hooks to
 mm/memcontrol.c
Message-ID: <ZfCt6TKEENN_Rq_C@casper.infradead.org>
References: <20240301-slab-memcg-v1-0-359328a46596@suse.cz>
 <20240301-slab-memcg-v1-2-359328a46596@suse.cz>
 <ZfClX_CJBYRW-cCc@P9FQF9L96D>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfClX_CJBYRW-cCc@P9FQF9L96D>

On Tue, Mar 12, 2024 at 11:56:31AM -0700, Roman Gushchin wrote:
> On Fri, Mar 01, 2024 at 06:07:09PM +0100, Vlastimil Babka wrote:
> > The hooks make multiple calls to functions in mm/memcontrol.c, including
> > to th current_obj_cgroup() marked __always_inline. It might be faster to
> > make a single call to the hook in mm/memcontrol.c instead. The hooks
> > also don't use almost anything from mm/slub.c. obj_full_size() can move
> > with the hooks and cache_vmstat_idx() to the internal mm/slab.h
> > 
> > Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> > ---
> >  mm/memcontrol.c |  90 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  mm/slab.h       |  10 ++++++
> >  mm/slub.c       | 100 --------------------------------------------------------
> >  3 files changed, 100 insertions(+), 100 deletions(-)
> 
> Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
> 
> Btw, even before your change:
> $ cat mm/memcontrol.c | wc -l
> 8318
> so I wonder if soon we might want to split it into some smaller parts.

If we are going to split it, perhaps a mm/memcg-v1.c would make sense,
because I certainly don't have a good idea about what's v1 and what's
v2.  And maybe we could even conditionally compile the v1 file ;-)

