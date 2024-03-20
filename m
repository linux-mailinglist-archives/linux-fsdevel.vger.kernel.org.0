Return-Path: <linux-fsdevel+bounces-14922-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF10D8817F0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 20:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69E6F285D43
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 19:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008798564F;
	Wed, 20 Mar 2024 19:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="g9+3i0OJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0645485266
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Mar 2024 19:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710963205; cv=none; b=B/1w1UHWatksiTnvc4CQFLLKSKfBN9QLeV/4h1VuYJyi6KjniRXI50s66BSwe4tr2K6WKXWF3iN6si2Z18SehvJu9CnKf1Eyb3rs+4Sb8WHIhiEta3TLJ8HfHCnJDr3KIVhUXGn0cEh7on8kmaKCLUyylbjBZ9auhk8MPTkE1oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710963205; c=relaxed/simple;
	bh=nN5+ywBmRc+r5vpgYmdumpD7NYsf4980nJhhgV58+L0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F8z6so0SJaPBQQT+ad834N9qQX6qYRkJWbYKNWRlNnL1d8uLVsbvAIO5jKTMF/YlQoz+4ddotF16kuUvAWJDuxqDQ8OvAehGPQdBz90Hx+fQGMFP9XBolLxbe7JklA/CvEi1XZ+mf6vFOdiCcdYEaMKBIrKV/WlEKeUHNWjAuVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=g9+3i0OJ; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 20 Mar 2024 15:33:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710963202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4Z2+kj8E7dAZztXoz7TRBvcmNS+JTIHwOPikowIfTEE=;
	b=g9+3i0OJJrgmxAhAeq8rmqn2Wwjk6Gay8gBdl83Tki5UyIDBeoY63LmE6oEDamNJS4utNR
	8RKIqITtxfNuktlWZYFMUtvaag9ofsmId5ryGZvBWkZPw/olhPWo8RP3hwqeTQUEnoyrWI
	6WtbgoKpWXBEHUbXB7nhvCzco/WRXoQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Matthew Wilcox <willy@infradead.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, 
	Dan Carpenter <dan.carpenter@linaro.org>, NeilBrown <neilb@suse.de>, Dave Chinner <david@fromorbit.com>, 
	Amir Goldstein <amir73il@gmail.com>, paulmck@kernel.org, lsf-pc@lists.linux-foundation.org, 
	linux-mm@kvack.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Jan Kara <jack@suse.cz>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Reclamation interactions with RCU
Message-ID: <tbrlw2ypn4sb5dolib4lyilfhintg6nsmxiozdxx7p6trjmybz@oev26466nnhf>
References: <pv2chxwnrufut6wecm47q2z7222tzdl3gi6s5wgvmk3b2gq3n5@d23qr5odwyxl>
 <170933687972.24797.18406852925615624495@noble.neil.brown.name>
 <xbjw7mn57qik3ica2k6o7ykt7twryod6rt3uvu73w6xahrrrql@iaplvz7t5tgv>
 <170950594802.24797.17587526251920021411@noble.neil.brown.name>
 <a7862cf1-1ed2-4c2c-8a27-f9d950ff4da5@suse.cz>
 <aaea1147-f015-423b-8a42-21fc18930c8f@moroto.mountain>
 <73533d54-2b92-4794-818e-753aaea887f9@suse.cz>
 <ZfsxKOA5vfa9yo76@casper.infradead.org>
 <fqaedupymxnx23fo4k34obzahzubbjxgoka7uta2j7zyh2hg63@h2aupn6atmdh>
 <Zfs1m3VGvGh4OhX_@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zfs1m3VGvGh4OhX_@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Mar 20, 2024 at 07:14:35PM +0000, Matthew Wilcox wrote:
> On Wed, Mar 20, 2024 at 03:07:38PM -0400, Kent Overstreet wrote:
> > On Wed, Mar 20, 2024 at 06:55:36PM +0000, Matthew Wilcox wrote:
> > > GFP_NOFAIL should still fail for allocations larger than KMALLOC_MAX_SIZE.
> > > Or should we interpret that as "die now"?  Or "go into an unkillable
> > > sleep"?  If the caller really has taken the opportunity to remove their
> > > error handling path, returning NULL will lead to a crash and a lot of
> > > beard stroking trying to understand why a GFP_NOFAIL allocation has
> > > returned NULL.  May as well BUG_ON(size > KMALLOC_MAX_SIZE) and give
> > > the developer a clear indication of what they did wrong.
> > 
> > Why do we even need KMALLOC_MAX_SIZE...?
> > 
> > Given that kmalloc internally switches to the page allocator when
> > needed, I would think that that's something we can do away with.
> 
> ... maybe check what I said before replying?
> 
> /*
>  * SLUB directly allocates requests fitting in to an order-1 page
>  * (PAGE_SIZE*2).  Larger requests are passed to the page allocator.
>  */
> #define KMALLOC_SHIFT_MAX       (MAX_PAGE_ORDER + PAGE_SHIFT)
> 
> You caan't allocate larger than that without going to CMA or some other
> custom allocator.

Ahh, my recollection was out of date - I believe that was 128k at one
time?

