Return-Path: <linux-fsdevel+bounces-13156-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCBB86BFF3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 05:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32A9D28786B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 04:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB1F38F80;
	Thu, 29 Feb 2024 04:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="O8h4leuX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2FE37700
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Feb 2024 04:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709181852; cv=none; b=HxuXtZKedfAuMUyCOUx4l7fQy6aWl27KHGo5KL1xGYWf78/i/wmrCe8QcEcOPIvaTPjq14s+nkoW1JgZtQbpmqooxlWckEBCFbM1m/ZFQIDdNebSjn/znBQmfwv3kiBEK6AjzGNEmu9U7gofRQaHkaE1GDGkIqZ/xU/g09HBweo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709181852; c=relaxed/simple;
	bh=H2jVPetb2Jm2Mc7E4QMsjUfJ8L8qSwggNRkUKXHvSLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bWAkeBtxgxwSCf3LDzVQC3h1wHWban1yS0kf+MC3bxgFJVaU8y0UMB+7DH+pqkvqSuf1cOgB7/vson/83NJ0ZTH0B3LeTIL9HBPpNOI7YalAKVuYqy0cb+kL/L6rJezSAoop4e0402eOdJal7GCZ+1c5xvJYabOHZZE8eAVyK6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=O8h4leuX; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 28 Feb 2024 23:44:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709181848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5hpfWgC5IYjIxXvFKtiaQ0NzJ+pS3LY6ypvLK/34uy0=;
	b=O8h4leuXrMp2skvrLwTkhIn/YdbeKVHiJxWWOtkilZ3MyW4SP2+PIddtMq25DNQZWfprOa
	rQKE/PLjOevz761Tq3Tk206du11zIhqifpZf7KOc+1SceMoOOcy02wulvvURx2x1OSZSz+
	5JqEcYFBCVSQ2J7mSw2NXiQ7KKVQh2I=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Matthew Wilcox <willy@infradead.org>
Cc: Amir Goldstein <amir73il@gmail.com>, paulmck@kernel.org, 
	lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Reclamation interactions with RCU
Message-ID: <nhyvkpz6bhk7ocqzyhj73wr7kbqay4oipso56r6dzwmlvdpb35@hc4af4i6uwnf>
References: <c6321dd1-ec0e-4fed-87cc-50d297d2be30@paulmck-laptop>
 <CAOQ4uxhiOizDDDJZ+hth4KDvUAYSyM6FRr_uqErAvzQ-=2VydQ@mail.gmail.com>
 <Zd-LljY351NCrrCP@casper.infradead.org>
 <sd7cximu7qzguhtstpc4xhgwwvfjg3zttwhy7oz7gzrgrmov6t@gjy2wplad6vy>
 <ZeAHFL3dOFrxA586@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeAHFL3dOFrxA586@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 29, 2024 at 04:24:52AM +0000, Matthew Wilcox wrote:
> On Wed, Feb 28, 2024 at 11:17:33PM -0500, Kent Overstreet wrote:
> > On Wed, Feb 28, 2024 at 07:37:58PM +0000, Matthew Wilcox wrote:
> > > Perhaps broaden this slightly.  On the THP Cabal call we just had a
> > > conversation about the requirements on filesystems in the writeback
> > > path.  We currently tell filesystem authors that the entire writeback
> > > path must avoid allocating memory in order to prevent deadlock (or use
> > > GFP_MEMALLOC).  Is this appropriate?  It's a lot of work to assure that
> > > writing pagecache back will not allocate memory in, eg, the network stack,
> > > the device driver, and any other layers the write must traverse.
> > 
> > Why would you not simply mark the writeback path with
> > memalloc_nofs_save()?
> 
> It's not about preventing recursion, it's about guaranteeing forward
> progres.  If you can't allocate a bio, you can't clean memory.

Err, what? We have to be able to allocate bios in order to do writeback,
_period_. And not just bios, sometimes we have to bounce the entire IO.

I keep noticing the mm people developing weird, crazy ideas about it
being "unsafe" to allocate memory in various contexts. That's wrong;
attempting to allocate memory is always a _safe_ operation, provided you
tell the allocator what it's allowed to do. The allocation might fail,
and that's ok.

If code must succeed for the system to operate it must have fallbacks if
allocations fail, but we don't limit ourselves to those fallbacks
("avoid allocating memory") because then performance would be shit.

The PF_MEMALLOC suggestion is even weirder.

mm people are high on something...

