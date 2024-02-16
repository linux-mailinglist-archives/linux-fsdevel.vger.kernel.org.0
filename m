Return-Path: <linux-fsdevel+bounces-11871-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E62C85835F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 18:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A73A284C53
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 17:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B9B130E34;
	Fri, 16 Feb 2024 17:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Sfqp2+ZZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C428130E29
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Feb 2024 17:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708103043; cv=none; b=MhuZaA+GZJEk5Co1LQ4MAW7lzA4mnZsY7DODkfZhFESOtxlWlCkiPebwHnPpJx4IM1/EasKcrbn6iTlP6Hj7uRDAZ31myxvu1py3iau+I2k0zqXS+nzcIvyfh8lIPePe0jL0SGGw5ReL6POqLPD7xhCRhjFdDTYLXKsVwxze8eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708103043; c=relaxed/simple;
	bh=Tm9Sh/qsOAnc+BdDWsSqYDD3wfqtjXBcQ5Oq8JkqoXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F1qpjBErztca3JsqOTJmqotkKmJDT4s+oE8IYPmhi8vJebD+bP9R++khAW27iGl3a1KhD+bpeqVMMy6qGGHpIDgerlqrf6Wp/Cpi3yy1O8X9ZuQwDU8ppPDntZB6gr5vr/PMQQqD7voh4hyL6tPiYsBSnjkEjqk63cPEM/H3pZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Sfqp2+ZZ; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 16 Feb 2024 12:03:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708103039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HmJQIqc4/OgO89xq5HkfBIYteF7nE9kIo+o5Vkmf1w0=;
	b=Sfqp2+ZZDoruaTeHE15NGTvQrR4vxcPG9Isnojl94qpEL7wBG/AIUx9L8x2ZzdD04C4Xko
	QKE1GYS1wRReUz51hBdQZagUBBoyBvwAx04UnSHcQ28MYep/Re3HUavlqnV7CN74fW6Hzt
	L4hhIlJhg7UCheW4IzGJzoMdLrgkDvs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org, 
	mhocko@suse.com, hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, corbet@lwn.net, 
	void@manifault.com, peterz@infradead.org, juri.lelli@redhat.com, 
	catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de, tglx@linutronix.de, 
	mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, hughd@google.com, 
	andreyknvl@gmail.com, keescook@chromium.org, ndesaulniers@google.com, 
	vvvvvv@google.com, gregkh@linuxfoundation.org, ebiggers@google.com, 
	ytcoode@gmail.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, 
	cl@linux.com, penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, 
	glider@google.com, elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, minchan@google.com, 
	kaleshsingh@google.com, kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-modules@vger.kernel.org, 
	kasan-dev@googlegroups.com, cgroups@vger.kernel.org
Subject: Re: [PATCH v3 22/35] mm/slab: enable slab allocation tagging for
 kmalloc and friends
Message-ID: <axbekdy2s36zuvhacrikgp3yl2a2j3po5cw6zrgspem2cdabry@ypsxxzx3ve72>
References: <20240212213922.783301-1-surenb@google.com>
 <20240212213922.783301-23-surenb@google.com>
 <a27189a9-b0fc-4705-bdd5-3ee0a5c23dd5@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a27189a9-b0fc-4705-bdd5-3ee0a5c23dd5@suse.cz>
X-Migadu-Flow: FLOW_OUT

On Fri, Feb 16, 2024 at 05:52:34PM +0100, Vlastimil Babka wrote:
> On 2/12/24 22:39, Suren Baghdasaryan wrote:
> > Redefine kmalloc, krealloc, kzalloc, kcalloc, etc. to record allocations
> > and deallocations done by these functions.
> > 
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > Co-developed-by: Kent Overstreet <kent.overstreet@linux.dev>
> > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> 
> 
> > -}
> > +#define kvmalloc(_size, _flags)			kvmalloc_node(_size, _flags, NUMA_NO_NODE)
> > +#define kvzalloc(_size, _flags)			kvmalloc(_size, _flags|__GFP_ZERO)
> >  
> > -static inline __alloc_size(1, 2) void *kvmalloc_array(size_t n, size_t size, gfp_t flags)
> 
> This has __alloc_size(1, 2)
> 
> > -{
> > -	size_t bytes;
> > -
> > -	if (unlikely(check_mul_overflow(n, size, &bytes)))
> > -		return NULL;
> > +#define kvzalloc_node(_size, _flags, _node)	kvmalloc_node(_size, _flags|__GFP_ZERO, _node)
> >  
> > -	return kvmalloc(bytes, flags);
> > -}
> > +#define kvmalloc_array(_n, _size, _flags)						\
> > +({											\
> > +	size_t _bytes;									\
> > +											\
> > +	!check_mul_overflow(_n, _size, &_bytes) ? kvmalloc(_bytes, _flags) : NULL;	\
> > +})
> 
> But with the calculation now done in a macro, that's gone?
> 
> > -static inline __alloc_size(1, 2) void *kvcalloc(size_t n, size_t size, gfp_t flags)
> 
> Same here...
> 
> > -{
> > -	return kvmalloc_array(n, size, flags | __GFP_ZERO);
> > -}
> > +#define kvcalloc(_n, _size, _flags)		kvmalloc_array(_n, _size, _flags|__GFP_ZERO)
> 
> ... transitively?
> 
> But that's for Kees to review, I'm just not sure if he missed it or it's fine.

I think this is something we want to keep - we'll fix it

