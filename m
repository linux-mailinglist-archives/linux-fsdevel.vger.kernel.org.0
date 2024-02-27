Return-Path: <linux-fsdevel+bounces-12966-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BEA869B36
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 16:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A76461F24A22
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 15:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45701145B2A;
	Tue, 27 Feb 2024 15:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AETDdD1Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB111EEE6
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Feb 2024 15:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709049180; cv=none; b=tUCugTCfcrmu16grK9pJdAekvTxGLhbnvnhzWBlcdR3VLgmzvQhbOk0F4iHQ4N/NCDM/NBbntL4+t+9FRXHoRkb+XoIcMNQEyt/SiMulVby9ndtocKG6BmxYWP5nb/2D7+TEfQOa0PjRCQAINbUHb6XdvwD66tmRy6Y0SW8HvAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709049180; c=relaxed/simple;
	bh=amQutT0FN5yaVgIVDU5c+Xxyykhph4KvVc/yQUJj8zs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W88MHcVzSccw6RrJlpRDrk95lq7kIMa2PtjP6JPNjBcSWmln1QEA7cj1ndGVwgKrETEnrQbh3aJd+1tmqmkLzX3f0UMCM38/yiZGAiGGKJlUASTzNJ1Zoj+FoDku90EiKMBQ1XZAmJ5Adt2S9ECThoWAyC+ODofLN/xe5KAPu1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AETDdD1Y; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 27 Feb 2024 10:52:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709049176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C39b/mCt7F7Qjgbxzc0LW6hLxEjJK9uDWuCglP11aLs=;
	b=AETDdD1YfVpSQ9mcro7CXy6SYi55/8zWIIFU16nIlSCtS1Xb+O8x8UoyR1c3gXtmQ7QUcn
	ZkrVASO8yHgPMwy/nZCGssvOB4TgAhjudBm5oe/RAiHejuiUBk/hvMmL3Dxjk36eoS28bj
	UKSBZ56setJKxyR5QAjxdag5Lri++/4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, linux-mm <linux-mm@kvack.org>, 
	Daniel Gomez <da.gomez@samsung.com>, Pankaj Raghav <p.raghav@samsung.com>, 
	Jens Axboe <axboe@kernel.dk>, Dave Chinner <david@fromorbit.com>, 
	Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [LSF/MM/BPF TOPIC] Measuring limits and enhancing buffered IO
Message-ID: <qclzh7gjlnuagsjiqemwvfnkxca2345zxansc7x463bguhsmm2@zl2cwv5fh5sv>
References: <upnvhnqaitifuwwbxcpa4zgf2hribfrtqzxtcrv5djbyjs2ond@axetql2wrwnt>
 <fb4d944e-fde7-423b-a376-25db0b317398@paulmck-laptop>
 <5c6ueuv5vlyir76yssuwmfmfuof3ukxz6h5hkyzfvsm2wkncrl@7wvkfpmvy2gp>
 <efb40e53-dae5-44c8-9e15-3cbf3a0cf537@paulmck-laptop>
 <oraht3mt3iu7u6q22pvb3du3xjpgei5cncbu4a22mz5scamsq5@fooyqelkfy6u>
 <49354148-4dea-4c89-b591-76b21ed4a5d1@paulmck-laptop>
 <ldpltrnfmf4a3xs43hfjnhrfidrbd7t5k6i5i3ysuzken2zeql@wm2ivk45hitj>
 <df68c44e-1ab3-485d-a0d6-0c37a06ab4ff@paulmck-laptop>
 <6xpyltamnbd7q7nesntqspyfjfq3jexkmfyj2fekrk2mrhktcr@73vij67d5vne>
 <ff8c0f56-6778-47e4-b365-d9c1ef75bbae@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff8c0f56-6778-47e4-b365-d9c1ef75bbae@paulmck-laptop>
X-Migadu-Flow: FLOW_OUT

On Tue, Feb 27, 2024 at 07:32:32AM -0800, Paul E. McKenney wrote:
> I could simply use the same general approach that I use within RCU
> itself, which currently has absolutely no idea how much memory (if any)
> that each callback will free.  Especially given that some callbacks
> free groups of memory blocks, while other free nothing.  ;-)
> 
> Alternatively, we could gather statistics on the amount of memory freed
> by each callback and use that as an estimate.
> 
> But we should instead step back and ask exactly what we are trying to
> accomplish here, which just might be what Dave Chinner was getting at.
> 
> At a ridiculously high level, reclaim is looking for memory to free.
> Some read-only memory can often be dropped immediately on the grounds
> that its data can be read back in if needed.  Other memory can only be
> dropped after being written out, which involves a delay.  There are of
> course many other complications, but this will do for a start.
> 
> So, where does RCU fit in?
> 
> RCU fits in between the two.  With memory awaiting RCU, there is no need
> to write anything out, but there is a delay.  As such, memory waiting
> for an RCU grace period is similar to memory that is to be reclaimed
> after its I/O completes.
> 
> One complication, and a complication that we are considering exploiting,
> is that, unlike reclaimable memory waiting for I/O, we could often
> (but not always) have some control over how quickly RCU's grace periods
> complete.  And we already do this programmatically by using the choice
> between sychronize_rcu() and synchronize_rcu_expedited().  The question
> is whether we should expedite normal RCU grace periods during reclaim,
> and if so, under what conditions.
> 
> You identified one potential condition, namely the amount of memory
> waiting to be reclaimed.  One complication with this approach is that RCU
> has no idea how much memory each callback represents, and for call_rcu(),
> there is no way for it to find out.  For kfree_rcu(), there are ways,
> but as you know, I am questioning whether those ways are reasonable from
> a performance perspective.  But even if they are, we would be accepting
> more error from the memory waiting via call_rcu() than we would be
> accepting if we just counted blocks instead of bytes for kfree_rcu().

You're _way_ overcomplicating this.

The relevant thing to consider is the relative cost of __ksize() and
kfree_rcu(). __ksize() is already pretty cheap, and with slab gone and
space available in struct slab we can get it down to a single load.

> Let me reiterate that:  The estimation error that you are objecting to
> for kfree_rcu() is completely and utterly unavoidable for call_rcu().

hardly, callsites manually freeing memory manually after an RCU grace
period can do the accounting manually - if they're hot enough to matter,
most aren.t

and with memory allocation profiling coming, which also tracks # of
allocations, we'll also have an easy way to spot those.

