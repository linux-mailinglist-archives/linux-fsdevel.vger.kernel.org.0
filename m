Return-Path: <linux-fsdevel+bounces-27491-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A71A6961C38
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 04:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BB1C1F248BB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 02:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601A476034;
	Wed, 28 Aug 2024 02:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CHXijeje"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3A5288B1
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 02:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724812936; cv=none; b=PdQsJiY/jMYSUyjBBglYTbQ4vhoWSGUS0Rehl4oxoYwyQOndQmPbeP8iThkjQ38ATzTx0HdIdmMtLoe1BUfXf1lEYzIh/fbkcJIlQQY/2vJuYymfkL+U99tjZgjPrDD9b84pjW7V44Y8QnbBOEVbrKzTVFgAumejFYwnr0Af8FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724812936; c=relaxed/simple;
	bh=witl1MkCQiuxKFFxhdE+RFVKuX9PEUNsLxhxvy8GGuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hAARkY0zmitH3bBxHDDcnluGuq0v0kSY6fH5nKVS0w7cxNtwli9vAIG8YvoOWTQB2rGCJwge1TZVvc8MbviU58RJOEtVlxtXjYf2sNobRbew1gzLU/+8cf5mVnzQFx1bp5UwF0vP186rU1RDF7XzdO6bNwpacdE1y/TQic+77Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CHXijeje; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 27 Aug 2024 22:42:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724812933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tmuII7hQ9ekox8gX+3Eyt9Apec88eBQCZ5MKKI3oR6E=;
	b=CHXijejetQ0RMCgVRW4jX9Bdqm9/GTaDSN6owYiVcIDcXuOLqHooUvVvDN6xDSOfTLwGQS
	+pgL1JCo0LYs4PL+h3dTTVay5NST3YtY+sMSuWvJSkkcn6o69ItwZrtnDzaSgfU9sFFMUR
	kDf5Kt7k4LxzQi20sYE4ap6OhEbsgMQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Dave Chinner <david@fromorbit.com>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [PATCH 03/10] mm: shrinker: Add new stats for .to_text()
Message-ID: <4hbbj5humpek7tou2q36t7x4kekodp3lsacrpyhvnrfz5kwnbb@vxk54hbuxyw2>
References: <20240824191020.3170516-1-kent.overstreet@linux.dev>
 <20240824191020.3170516-4-kent.overstreet@linux.dev>
 <Zs6NGGWZrw6ddDum@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs6NGGWZrw6ddDum@dread.disaster.area>
X-Migadu-Flow: FLOW_OUT

On Wed, Aug 28, 2024 at 12:36:08PM GMT, Dave Chinner wrote:
> Doing this inside the tight loop (adding 3 atomics and two calls to
> ktime_get_ns()) is total overkill. Such fine grained accounting
> doesn't given any extra insight into behaviour compared to
> accounting the entire loop once.
> 
> e.g. the actual time the shrinker takes to run is the time the whole
> loop takes to run, not only the individual shrinker->scan_objects
> call.
> 
> The shrinker code already calculates the total objects scanned and
> the total objects freed by the entire loop, so there is no reason to
> be calculating this again using much more expensive atomic
> operations.
> 
> And these are diagnostic stats - the do not need to be perfectly
> correct and so atomics are unnecessary overhead the vast majority of
> the time.  This code will have much lower impact on runtime overhead
> written like this:
> 
> 	start_time = ktime_get_ns();
> 
> 	while (total_scan >= batch_size ||
>                total_scan >= freeable) {
> 	.....
> 	}
> 
> 	shrinker->objects_requested_to_free += scanned;
> 	shrinker->objects_freed += freed;
> 
> 	end_time = ktime_get_ns();
> 	shrinker->ns_run += end_time - start_time;
> 	shrinker->last_scanned = end_time;
> 	if (freed)
> 		shrinker->last_freed = end_time;
> 
> And still give pretty much the exact same debug information without
> any additional runtime overhead....

*nod*

This is all going to be noise compared to the expense of ->scan()
itself, but there's no reason not to, I'll make the change...

