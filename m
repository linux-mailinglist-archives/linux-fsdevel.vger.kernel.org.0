Return-Path: <linux-fsdevel+bounces-48498-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FE3AB0346
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 20:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0705D4E5B25
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 18:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1611428750D;
	Thu,  8 May 2025 18:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pTYr4bSE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C7B287506
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 May 2025 18:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746730614; cv=none; b=KoMwbdlyQvDF9pgi5p5/78REJWHIqmgsHjb22P0pHzgEJxGJqQag6sqRYrUW/7EhtQYeucpAktkAqmNcc9d5A7mcjfzeEtquBpmhXp9KZHihKxV46vuo3vEEYwRjn+yO+fWkD3dLBaON7fkWjfQKQ+I5xjqSlSzyVMopk8+sSG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746730614; c=relaxed/simple;
	bh=mrzavZ1gxnCp1mmwLywbMeH4RaJ1eiZMxQuk2xlvYEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ut5I99II/lqjWnGJmXxri1+rwCCYdMZKoQwhypZI3HhPv9Hceww7EY1bnbcSbw6X3utJfZ5rR5DgIeqsNs7uXjov6dtssgYiDvg6pexV3jXDsNvxL6jaO86Of2KURgtpYOZWLU6J/uWUvMoScop3VlZK8P0Et7SuxtjRwwzHMcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pTYr4bSE; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 8 May 2025 11:56:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746730600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MMmfDH4IRv0kSMYYEeSF7wbuv8V83KA7+nWbg4KkXT4=;
	b=pTYr4bSED8CWaDlWFYtkvE85WC0AnXNvsThBZDvtZ3EcOG8KTVp33GDvSkvAyiq3OPM2tQ
	jUoiy2JG4e1Ym+7KcyIEwAJtNdGISOf9RfJH4cBHlpeCPGKfnaf5l6+r2QTcYGuZM60mbx
	3XNUJY9CNrom+Y+1sqVGLydoB7C5Ujc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: xu.xin16@zte.com.cn
Cc: akpm@linux-foundation.org, david@redhat.com, 
	linux-kernel@vger.kernel.org, wang.yaxin@zte.com.cn, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, yang.yang29@zte.com.cn
Subject: Re: [PATCH v2 0/9] support ksm_stat showing at cgroup level
Message-ID: <t7q2d73nxdd75sghobnpmzi7bsbvden6lbrtejkxyoqfl2xilv@4ewvm2od2sf3>
References: <ir2s6sqi6hrbz7ghmfngbif6fbgmswhqdljlntesurfl2xvmmv@yp3w2lqyipb5>
 <20250506130925568unpXQ7vLOEaRX4iDWSow2@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250506130925568unpXQ7vLOEaRX4iDWSow2@zte.com.cn>
X-Migadu-Flow: FLOW_OUT

On Tue, May 06, 2025 at 01:09:25PM +0800, xu.xin16@zte.com.cn wrote:
> > > Users can obtain the KSM information of a cgroup just by:
> > > 
> > > # cat /sys/fs/cgroup/memory.ksm_stat
> > > ksm_rmap_items 76800
> > > ksm_zero_pages 0
> > > ksm_merging_pages 76800
> > > ksm_process_profit 309657600
> > > 
> > > Current implementation supports both cgroup v2 and cgroup v1.
> > > 
> > 
> > Before adding these stats to memcg, add global stats for them in
> > enum node_stat_item and then you can expose them in memcg through
> > memory.stat instead of a new interface.
> 
> Dear shakeel.butt,
> 
> If adding these ksm-related items to enum node_stat_item and bringing extra counters-updating
> code like __lruvec_stat_add_folio()... embedded into KSM procudure, it increases extra
> CPU-consuming while normal KSM procedures happen.

How is it more expensive than traversing all processes?
__lruvec_stat_add_folio() and related functions are already called in many
performance critical code paths, so I don't see any issue to call in the
ksm.

> Or, we can just traversal all processes of
> this memcg and sum their ksm'counters like the current patche set implmentation.
> 
> If only including a single "KSM merged pages" entry in memory.stat, I think it is reasonable as
> it reflects this memcg's KSM page count. However, adding the other three KSM-related metrics is
> less advisable since they are strongly coupled with KSM internals and would primarily interest
> users monitoring KSM-specific behavior.

We can discuss and decide each individual ksm stat if it makes sense to
added to memcg or not.

> 
> Last but not least, the rationale for adding a ksm_stat entry to memcg also lies in maintaining
> structural consistency with the existing /proc/<pid>/ksm_stat interface.

Sorry, I don't agree with this rationale. This is a separate interface
and can be different from exisiting ksm interface. We can define however
we think is right way to do for memcg and yes there can be stats overlap
with older interface.

For now I would say start with the ksm metrics that are appropriate to
be exposed globally and then we can see if those are fine for memcg as
well.

