Return-Path: <linux-fsdevel+bounces-14234-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B9B879BFF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 20:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02029B20A6E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 19:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD9B142631;
	Tue, 12 Mar 2024 18:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tfqxM+dB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044E213A89F;
	Tue, 12 Mar 2024 18:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710269991; cv=none; b=BLrIxVkTrjHxxI5n5oBUwosytze0+ZpU77B+HZMbyQEASIxL6dCcfDcAuhUeRH7nPl56sIFAcki/khd/iLNjre/DSa1tDwD7w2FqR/TXm7chRMgxWjOpK4lvYV43+qZUM+xxEIqwZsRkMTiXZ4gFEklH9/e5YnNp772PLhCUQDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710269991; c=relaxed/simple;
	bh=pN850QA4G3vEdGjQiE/SsZ+b17jJ6CTV9AJAa/Pj50o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D5HmaNnCVoeqe8G5WEhXoUrcOpEe3D9SMeJnDWp74P3P99BJ6IuLvGjzVM+nw/j0aTNWzajyMWnbb11ULBtuY6ZuPJaayDP0ve+4psFsv/TL8Yl1O3yMDbiYV6ZwoJ9AhtRWN8NiYm+1CTNargoTPsqXQItkhN2wOrDNbEXLMGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tfqxM+dB; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=l7YjmToYxJzJPfPfvLPjqw7S83YnAmsGWN4NCSQKexo=; b=tfqxM+dBai/CGBKtNFjAO7g/kG
	m81UQM/6TR+5G7dylh6b4Sh3POGAQ5Cnsify746H46CIFAVQ13xhh/N2cKZlZSOqeWg7REeB1+XxE
	7q6ENdm3bqEwiTOVbg22zgyKfItgIsHDUG7qBWEB4K9vgxFIgyGUlNQrb7tQVGIOI+NqEmfTAZ407
	l3qsWMigWWO/8FKujwDig+0xETqvRwIar7RtD0zNizs9NrFjjATdRmQSAQtjZyq54u9/FgpvbeEuY
	rh392WWdoTAovRTxHA7GPUit10/KHiyH36qakY3RO46g02w/SHFSPrrlT3EFGBLrff3rd/DJcr/++
	qiIF7M8w==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rk7Ld-00000003gRr-0sAR;
	Tue, 12 Mar 2024 18:59:37 +0000
Date: Tue, 12 Mar 2024 18:59:37 +0000
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
Subject: Re: [PATCH RFC 1/4] mm, slab: move memcg charging to post-alloc hook
Message-ID: <ZfCmGYmvJlHAPiRz@casper.infradead.org>
References: <20240301-slab-memcg-v1-0-359328a46596@suse.cz>
 <20240301-slab-memcg-v1-1-359328a46596@suse.cz>
 <ZfCkfpogPQVMZnIG@P9FQF9L96D>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfCkfpogPQVMZnIG@P9FQF9L96D>

On Tue, Mar 12, 2024 at 11:52:46AM -0700, Roman Gushchin wrote:
> On Fri, Mar 01, 2024 at 06:07:08PM +0100, Vlastimil Babka wrote:
> > @@ -1926,71 +1939,51 @@ static bool __memcg_slab_pre_alloc_hook(struct kmem_cache *s,
> >  			return false;
> >  	}
> >  
> > -	if (obj_cgroup_charge(objcg, flags, objects * obj_full_size(s)))
> > +	if (obj_cgroup_charge(objcg, flags, size * obj_full_size(s)))
> >  		return false;
> >  
> > -	*objcgp = objcg;
> > +	for (i = 0; i < size; i++) {
> > +		slab = virt_to_slab(p[i]);
> 
> Not specific to this change, but I wonder if it makes sense to introduce virt_to_slab()
> variant without any extra checks for this and similar cases, where we know for sure
> that p resides on a slab page. What do you think?

You'd only save a single test_bit() ... is it really worth doing?
Cache misses are the expensive thing, not instructions.  And debugging
time: if somehow p[i] becomes not-on-a-slab-anymore, getting a NULL
pointer splat here before we go any further might be worth all the CPU
time wasted doing that test_bit().

