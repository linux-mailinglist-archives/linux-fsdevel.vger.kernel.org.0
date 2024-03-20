Return-Path: <linux-fsdevel+bounces-14918-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F6E88179E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 20:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DBBB1F21D82
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 19:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2F785623;
	Wed, 20 Mar 2024 19:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uVkdqq+v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118FF1E4AD
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Mar 2024 19:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710961669; cv=none; b=UG9/ex61OHFC8KJjhzQi2hBGL/MhJ1xTZ98/EP2KhgDxR3XiGmzQ+/ovUyqyOEDdaSNVWC8a4Gxj/St79xWNwgAGddHsCGyBRdmqr/2NJvpp2BHtbXAKwTh3+fo36c6eveF5G+lp9PjuVG57sMTKdzgVv3DuIjRNM4h0TdQ9JTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710961669; c=relaxed/simple;
	bh=yhr/DhYcxx8K/8O2yqcZep5424bwowe8x8j7RHZjqyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U5hzMlGT1cIC+LB7NeYUcJJ2fSsGoJcDy9biiDclbbwb+fnfE0Aym//WUMP4xAxFcbnmhm3bCR6SNWf+qdXcKm3hw5n/07TMioDHHZVW//Fiw4/Moxfx2G0XAorm0EieEdbwSjkTd9Z9A2jGpuD/xCvWxEjH46cNKDfcuROLvrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uVkdqq+v; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 20 Mar 2024 15:07:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710961663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XJ0NYuFg/q2B1ANSblHyG8qmIIczfvXTcYkfiw2c7Qw=;
	b=uVkdqq+vQ/qxrJf8g5ECTYJnk4onWvuqP3T8gjAd0S4/jen8oaWMpQubT4bP/xzO6twbi2
	S7aDURNxgaHliFfluYn7D55fElf95LZ0jYMNtXpFstOBDtKkZS3hWlbWvsy902bq/K6d7/
	WoDjjAp6sukBx1hlOKaR9MzjvYVgj+c=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Matthew Wilcox <willy@infradead.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, 
	Dan Carpenter <dan.carpenter@linaro.org>, NeilBrown <neilb@suse.de>, Dave Chinner <david@fromorbit.com>, 
	Amir Goldstein <amir73il@gmail.com>, paulmck@kernel.org, lsf-pc@lists.linux-foundation.org, 
	linux-mm@kvack.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Jan Kara <jack@suse.cz>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Reclamation interactions with RCU
Message-ID: <fqaedupymxnx23fo4k34obzahzubbjxgoka7uta2j7zyh2hg63@h2aupn6atmdh>
References: <170925937840.24797.2167230750547152404@noble.neil.brown.name>
 <ZeFtrzN34cLhjjHK@dread.disaster.area>
 <pv2chxwnrufut6wecm47q2z7222tzdl3gi6s5wgvmk3b2gq3n5@d23qr5odwyxl>
 <170933687972.24797.18406852925615624495@noble.neil.brown.name>
 <xbjw7mn57qik3ica2k6o7ykt7twryod6rt3uvu73w6xahrrrql@iaplvz7t5tgv>
 <170950594802.24797.17587526251920021411@noble.neil.brown.name>
 <a7862cf1-1ed2-4c2c-8a27-f9d950ff4da5@suse.cz>
 <aaea1147-f015-423b-8a42-21fc18930c8f@moroto.mountain>
 <73533d54-2b92-4794-818e-753aaea887f9@suse.cz>
 <ZfsxKOA5vfa9yo76@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfsxKOA5vfa9yo76@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Mar 20, 2024 at 06:55:36PM +0000, Matthew Wilcox wrote:
> On Wed, Mar 20, 2024 at 07:48:01PM +0100, Vlastimil Babka wrote:
> > On 3/20/24 19:32, Dan Carpenter wrote:
> > > On Tue, Mar 12, 2024 at 03:46:32PM +0100, Vlastimil Babka wrote:
> > >> But if we change it to effectively mean GFP_NOFAIL (for non-costly
> > >> allocations), there should be a manageable number of places to change to a
> > >> variant that allows failure.
> > > 
> > > What does that even mean if GFP_NOFAIL can fail for "costly" allocations?
> > > I thought GFP_NOFAIL couldn't fail at all...
> > 
> > Yeah, the suggestion was that GFP_KERNEL would act as GFP_NOFAIL but only
> > for non-costly allocations. Anything marked GFP_NOFAIL would still be fully
> > nofail.
> 
> GFP_NOFAIL should still fail for allocations larger than KMALLOC_MAX_SIZE.
> Or should we interpret that as "die now"?  Or "go into an unkillable
> sleep"?  If the caller really has taken the opportunity to remove their
> error handling path, returning NULL will lead to a crash and a lot of
> beard stroking trying to understand why a GFP_NOFAIL allocation has
> returned NULL.  May as well BUG_ON(size > KMALLOC_MAX_SIZE) and give
> the developer a clear indication of what they did wrong.

Why do we even need KMALLOC_MAX_SIZE...?

Given that kmalloc internally switches to the page allocator when
needed, I would think that that's something we can do away with.

