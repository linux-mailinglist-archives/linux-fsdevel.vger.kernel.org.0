Return-Path: <linux-fsdevel+bounces-14245-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E39879CFB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 21:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A39CD1C2160A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 20:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A9A143729;
	Tue, 12 Mar 2024 20:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sMCEXAm5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02082142909
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Mar 2024 20:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710275726; cv=none; b=XskW/v84+c5TTREXmHXbzmd9Ua7lp78EZ6CrpWABKF3OZ2F68q6eR6oJGfXGeEqgT5hn95dlG2cWqZ6vvrWy/CHlVCCIYJ4HecbYAd4dDdgtRNkSgh0zvroBXda3bCv/S6g4TCev3dRu7kYEkfKbJWf18i9bi33rjN/6RTMUYYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710275726; c=relaxed/simple;
	bh=KXsVonS76Gx1v4lFtZ/aoukbRIl1jUwSZIPUAIXbK9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZzE/SdaXD7g8C1UoVp39csFjeALokzgd5DMKdqr4VFaY66jks5ghb+gIQTfrfiznoxa031st6+0NaZC8DJ1v+IiBieuAHuvqluYEx3eeBjBQaVHPnFriDFDMsuBxAV4mpBCieVlhYqeVkQlaRgWlDKJzJsbmYU8JLMYutit5KBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sMCEXAm5; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 12 Mar 2024 13:35:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710275721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ie4azhdaO7XyuGP1SvLiJCvS/cPbUc5GBchc5hu2vaM=;
	b=sMCEXAm5xCpiFPEB39C6K1DXlo0Ho5H5L+dlH2uLxMvPdEQRsv99r9YtsgCv9WgRZqG4tL
	VxNUGBPsCa75bzqnUBFcy8TdrLlI57sU+4v6e9SdmPRfHtG+pEdA9/AWeUgtroM6lfBmcw
	O4nP2IRw0rf+l+2B4fx3Br5iKQE0IwM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Matthew Wilcox <willy@infradead.org>
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
Message-ID: <ZfC8gIgWOkEVanSJ@P9FQF9L96D>
References: <20240301-slab-memcg-v1-0-359328a46596@suse.cz>
 <20240301-slab-memcg-v1-1-359328a46596@suse.cz>
 <ZfCkfpogPQVMZnIG@P9FQF9L96D>
 <ZfCmGYmvJlHAPiRz@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfCmGYmvJlHAPiRz@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT

On Tue, Mar 12, 2024 at 06:59:37PM +0000, Matthew Wilcox wrote:
> On Tue, Mar 12, 2024 at 11:52:46AM -0700, Roman Gushchin wrote:
> > On Fri, Mar 01, 2024 at 06:07:08PM +0100, Vlastimil Babka wrote:
> > > @@ -1926,71 +1939,51 @@ static bool __memcg_slab_pre_alloc_hook(struct kmem_cache *s,
> > >  			return false;
> > >  	}
> > >  
> > > -	if (obj_cgroup_charge(objcg, flags, objects * obj_full_size(s)))
> > > +	if (obj_cgroup_charge(objcg, flags, size * obj_full_size(s)))
> > >  		return false;
> > >  
> > > -	*objcgp = objcg;
> > > +	for (i = 0; i < size; i++) {
> > > +		slab = virt_to_slab(p[i]);
> > 
> > Not specific to this change, but I wonder if it makes sense to introduce virt_to_slab()
> > variant without any extra checks for this and similar cases, where we know for sure
> > that p resides on a slab page. What do you think?
> 
> You'd only save a single test_bit() ... is it really worth doing?
> Cache misses are the expensive thing, not instructions.

I agree here, unlikely it will produce a significant difference.

> And debugging
> time: if somehow p[i] becomes not-on-a-slab-anymore, getting a NULL
> pointer splat here before we go any further might be worth all the CPU
> time wasted doing that test_bit().

Well, Idk if it's a feasible concern here, hard to imagine how p[i]
wouldn't belong to a slab page without something like a major memory
corruption.

Overall I agree it's not a big deal and the current code is fine.

Thanks!

