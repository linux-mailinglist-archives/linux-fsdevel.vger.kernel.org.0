Return-Path: <linux-fsdevel+bounces-17206-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30DF48A8D7F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 23:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E14FE2836A2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 21:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867B04CB5B;
	Wed, 17 Apr 2024 21:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="f3YACdPB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB89D481A8
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Apr 2024 21:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713388097; cv=none; b=soxrErT9+uXem/exZ4UO3H17JLyk0p46F9o6gafDdDLZxMsang6wJWeDJSQWRDUYowYF4/EzuKfQJ5YeLO7yxnyPQXf+vhOdeyIeeBJzh+Xu5ClRrfqsnyrE/jGoT8Gjl8d/TyJ+aoHtxppAyoUac1z3V7B7Rruo1WPdEeqCOUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713388097; c=relaxed/simple;
	bh=Dzk1ZvwM61CnWwCmlm9LN5b+eODMlo7uCq+ekDMxnac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JP6P4D3t5W194ELvslCK/XLNGtcVwLMmgyclQCkLFtBZUqDz4nl647CV7BhVKPc+Bsx2kGuhC130D5RiB02WkEB4J0xJFh4cbNQF59mEJDDRmtjMtkMYy39lvuNIz8Ppk/iHVgBGEZbT3d/+7YHxiXHxElKtjQwkgH0qQiPXQo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=f3YACdPB; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 17 Apr 2024 17:08:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713388092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PKCCqyrQSQVqll4wIMyErhi0FHa0a9AXkGURxmziZuk=;
	b=f3YACdPB+2vWCj8f16+SJ/SWg0w2YHyvlr5Lj8UGABu15Jr8/KPXIswqiJD8kujihU4Kob
	DZ2QMztcYz1FNirII8gSl49u+9upkPjAOVaX7s2R8KBuC9CNQ6FylqpTYL6n2j1bqr3nP4
	3w/6ob6t/mhrkaSlL24Fg4CtYHHRzYI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Matthew Wilcox <willy@infradead.org>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
	lsf-pc@lists.linux-foundation.org, kernel-team@fb.com
Subject: Re: [LSF/MM/BPF TOPIC] Changing how we do file system maintenance
Message-ID: <c7jgzgwy74tr4e2l53mrp7p76kmtthkexnydtuigipmqzgjuu4@edux2yftjn7p>
References: <20240416180414.GA2100066@perftesting>
 <Zh7g5ws68IkJ1vo3@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zh7g5ws68IkJ1vo3@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT

On Tue, Apr 16, 2024 at 09:34:47PM +0100, Matthew Wilcox wrote:
> On Tue, Apr 16, 2024 at 02:04:14PM -0400, Josef Bacik wrote:
> > I would like to propose we organize ourselves more akin to the other
> > large subsystems.  We are one of the few where everybody sends their
> > own PR to Linus, so oftentimes the first time we're testing eachothers
> > code is when we all rebase our respective trees onto -rc1.  I think
> > we could benefit from getting more organized amongst ourselves, having
> > a single tree we all flow into, and then have that tree flow into Linus.
> 
> This sounds like a great idea to me.  As someone who does a lot of
> changes that touch a lot of filesystems, I'd benefit from this model.
> It's very frustrating to be told "Oh, submit patches against tree X
> which isn't included in linux-next".

I think an even better starting point would just be (more) common test
infrastructure. We've already got fstests, what we need is a shared
cluster (two racks of machines?) that is dedicated to automated testing
on _any_ kernel filesystem.

I've got the code for this all ready to go, as soon as someone is
willing to pony up on hardware.

That would mean people like Willy who are doing cross filesystem testing
would have a _lot_ less manual work to do, and having a cluster that
watches our git branches and kicks off tests when someone pushes (i.e.
what I already have, just on a bigger scale) would mean that we'd be
full test suite results back in 5-10 minutes after writing the code and
pushing. That sort of thing is amazing for productivity... no more
sitting around twiddling thumbs waiting for the evening test run...

