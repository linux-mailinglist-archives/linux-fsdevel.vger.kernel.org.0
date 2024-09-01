Return-Path: <linux-fsdevel+bounces-28186-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1F5967C25
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2024 22:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03B041F2175A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2024 20:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD4B54662;
	Sun,  1 Sep 2024 20:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="k1nSyWgA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB36273F9
	for <linux-fsdevel@vger.kernel.org>; Sun,  1 Sep 2024 20:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725223339; cv=none; b=Fpt/53wWUtIUjdDTEbghzW7C9NUjteIEGTSbZXTJqjj3wk4iyyLo/Xgp6ZAYhfpBSfkJdxUFhnB/R4J2SrlWmY+EVIPJBK9D17G+JDaxkr/LhQB1dPn166v/3rK8InUvDgQirfJ3vJcCvQf7Fz/f8+uOfiFxC3aw/Ff455ds25w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725223339; c=relaxed/simple;
	bh=/GuTKv22Im6Wh9wyljBHUKoVfSQQIP3IdmOsI6H3lFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KlAP4bbV9NaUdmILS+1a0yZHrqlBDHHFxZ68KcT5LcXwmUFuP903KaBCbya0KRTUfGi7yUtydAbKPqLdDTtlr7sPRiEZJNB4upfUf71enTeeVuFc/7tyL99B5cSDkLMqtbLifc4Hh73K9CFlnkXlJ3G/fj704cii/I4W5QGmizs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=k1nSyWgA; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 1 Sep 2024 16:42:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725223331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ju2Vw4zS6l91fQdiljroWqhw5t4I6GfCQlefI9QxVRw=;
	b=k1nSyWgACCW+lGtSB9wQKyoALfT4ihGKN0YMI59UjmpGEWdLtERmab0izk9fmYoi7ZOXl6
	s/1a0Fk2SXzTsiOhpgxVZL5+egB+NDUw+V9qkBiiBaWv1JOmThqq5gSSa4TUgslIqddSfi
	tVFlutyDy+wFjhm4sZhj6V5fQMHL04c=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Yafang Shao <laoar.shao@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, akpm@linux-foundation.org, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, david@fromorbit.com, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 1/2] mm: Add memalloc_nowait_{save,restore}
Message-ID: <r6iwejkfkg4ijzvgt2zwy4myv23jingckdpnc4eyb73cfucnmm@r2jklzmbjxeo>
References: <20240812090525.80299-1-laoar.shao@gmail.com>
 <20240812090525.80299-2-laoar.shao@gmail.com>
 <Zrn0FlBY-kYMftK4@infradead.org>
 <CALOAHbBd2oCVKsMwcH_YGUWT5LGLWmNSUAZzRPp8j7bBaqc1PQ@mail.gmail.com>
 <ZroMalgcQFUowTLX@infradead.org>
 <CALOAHbC=fB0h-YgS9Fr6aTavhPFWKLJzzfM4huYjVaa9+97Y4g@mail.gmail.com>
 <ZrxASkumlaXWftJ8@infradead.org>
 <CALOAHbCu05WWUo9FpU92Ls2Us3x2+7U8PBxOGza4g+hkaXViuQ@mail.gmail.com>
 <9390b0ab-fd2c-45e3-b48f-94796ecbbbda@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9390b0ab-fd2c-45e3-b48f-94796ecbbbda@suse.cz>
X-Migadu-Flow: FLOW_OUT

On Sun, Sep 01, 2024 at 10:24:10PM GMT, Vlastimil Babka wrote:
> On 8/14/24 09:33, Yafang Shao wrote:
> > On Wed, Aug 14, 2024 at 1:27 PM Christoph Hellwig <hch@infradead.org> wrote:
> >>
> >> > There are already memalloc_noreclaim_{save,restore} which imply __GFP_MEMALLOC:
> >> >
> >> >   memalloc_noreclaim_save - Marks implicit __GFP_MEMALLOC scope.
> >>
> >> .. and those are horrible misnamed :(
> 
> Yes I agree, sorry about that.
> 
> > What about renaming it to memalloc_memalloc_save ?
> 
> While it looks weird, it could be indeed better than the current name. It's
> not obvious, so it should force the user to read the description.
> memalloc_noreclaim_save() might look too obviously "this disables reclaim"
> but it's misleading as that's not the full story of PF_MEMALLOC.

I was actually thinking about killing the helpers in favor of just
memalloc_flags_save() - I don't think the extra names get us anything

