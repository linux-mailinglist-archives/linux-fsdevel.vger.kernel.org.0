Return-Path: <linux-fsdevel+bounces-15608-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A49890A68
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 20:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5D5DB239CB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 19:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A809513AD32;
	Thu, 28 Mar 2024 19:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oWnTZB6k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C70413AD30
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Mar 2024 19:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711655743; cv=none; b=uV5k721ATZzvRgzE6Dw4kXXRKVoNQSkEKQzzDyQxFbGCi5oqnEo/lgyEw92YcWIk1yMr2SZzmwHRQIUl6EzxRR30vpQAnZBAfT5nYEZh7KxP/6ixvWfPjX54/9Wul/8DjpkVQ9aX0qYd0YSv+W5P236nO88dmN+35tVOLjTpMOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711655743; c=relaxed/simple;
	bh=3dm7hXsEyv3o3RpQMnPL3+cUR/Meb3nCFGnidYwVRSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D3keWkPvRjrbHOvAJCljLpT+zIdUpIgicz6MK+ky0Bb0JVNl2d2k+k+UdapQWCSbaJyoyG02Db91e9fQAwbUM0/KtbzoNpje31tnlU+w0Cr/Mu4s4fYQIghO507TjZeMJzDzXn0nB1nHMaEf0t/bkWZwhAace2+CTEsh12upwxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oWnTZB6k; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 28 Mar 2024 15:55:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711655740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qZtbR5ybrM4VN5GkPPv/g85e7nM016zaozBUPlrxiOw=;
	b=oWnTZB6kB9RObBVUWC/hoNPZhiMDaIS4FrtDJC3YG581FBvbZRo8QPodfZzy1XDijlrlj2
	P6YB8HOLpxFyGwFBccNqr0Jiz+2zMdON2s77rPR4nar3PWbDLXIMyV/gdCigVUGLt9wZdP
	TAamaZnrSzR9I7ilSTIl2Rr1LRdSwVk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: Kemeng Shi <shikemeng@huaweicloud.com>, akpm@linux-foundation.org, 
	willy@infradead.org, jack@suse.cz, bfoster@redhat.com, dsterba@suse.com, 
	mjguzik@gmail.com, dhowells@redhat.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] Improve visibility of writeback
Message-ID: <wgec7wbhdn7ilvwddcalkbgxzjutp6h7dgfrijzffb64pwpksz@e6tqcybzfu2f>
References: <20240327155751.3536-1-shikemeng@huaweicloud.com>
 <qyzaompqkxwdquqtofmqghvpi4m3twkrawn26rxs56aw4n2j3o@kt32f47dkjtu>
 <ZgXFrabAqunDctVp@slm.duckdns.org>
 <n2znv2ioy62rrrzz4nl2x7x5uighuxf2fgozhpfdkj6ialdiqe@a3mnfez7mitl>
 <ZgXJH9XQNqda7fpz@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgXJH9XQNqda7fpz@slm.duckdns.org>
X-Migadu-Flow: FLOW_OUT

On Thu, Mar 28, 2024 at 09:46:39AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Thu, Mar 28, 2024 at 03:40:02PM -0400, Kent Overstreet wrote:
> > Collecting latency numbers at various key places is _enormously_ useful.
> > The hard part is deciding where it's useful to collect; that requires
> > intimate knowledge of the code. Once you're defining those collection
> > poitns statically, doing it with BPF is just another useless layer of
> > indirection.
> 
> Given how much flexibility helps with debugging, claiming it useless is a
> stretch.

Well, what would it add?

> > The time stats stuff I wrote is _really_ cheap, and you really want this
> > stuff always on so that you've actually got the data you need when
> > you're bughunting.
> 
> For some stats and some use cases, always being available is useful and
> building fixed infra for them makes sense. For other stats and other use
> cases, flexibility is pretty useful too (e.g. what if you want percentile
> distribution which is filtered by some criteria?). They aren't mutually
> exclusive and I'm not sure bdi wb instrumentation is on top of enough
> people's minds.
> 
> As for overhead, BPF instrumentation can be _really_ cheap too. We often run
> these programs per packet.

The main things I want are just
 - elapsed time since last writeback IO completed, so we can see at a
   glance if it's stalled
 - time stats on writeback io initiation to completion

The main value of this one will be tracking down tail latency issues and
finding out where in the stack they originate.

