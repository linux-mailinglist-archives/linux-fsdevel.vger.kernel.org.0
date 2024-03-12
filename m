Return-Path: <linux-fsdevel+bounces-14246-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0043A879CFF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 21:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9455E1F21AE1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 20:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B25514291B;
	Tue, 12 Mar 2024 20:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HZXpeDYD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2883382
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Mar 2024 20:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710275837; cv=none; b=meCI+9wnhBYiJPDYUYkJL+2J/nicyt+dLsQ5L6rjaV4WNk68g9VlN3uGf+Pc41J1w1I001y2gMejjosxp7jfFCFhM8Ktzvioe+FGKTLPleIc31/rIbdRSVnrYzyql5jhTyxguEo6zxQIHVMeUM2cbu933npN+H12dDkLKYtneyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710275837; c=relaxed/simple;
	bh=KRIT8RSl8j92RKVbXYm+JfThLcRNkmtbFfcf0XKauR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ql7htFmqhUnm/gwXZk2Cjrl4IYnirwGt5jXQrOKz7tin+Si2UkeYHZzAzqlLvf4QzqcxcreFWTnPmnORDWRrwarzO7vMayFScSCtDlqcyDmX4p1peWdgewCSfMZg787gtz4raIBwlg5WrgGnmGDyyRbQTSiaS9zC5qqIyWsoGzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HZXpeDYD; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 12 Mar 2024 13:36:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710275834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uAqALqr1rdPH8sdbmVB4VkVDqs3g9V4IllJSBYc1FHc=;
	b=HZXpeDYD0w65xyXfNRa7nKoN85fwgSPBYCylhns9hpHruUJ3UL5pTGeoeVWfGN0tweYVBf
	UKF4GnESETxQFudkc7MEA5P8Gg2KhzWNWGMn9Lt+P+7G6a+/J/s22SGiV6rW7oKL1P7Q5h
	p8LVxeur3vJydFpomBcAYoJToGWwexQ=
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
Subject: Re: [PATCH RFC 2/4] mm, slab: move slab_memcg hooks to
 mm/memcontrol.c
Message-ID: <ZfC85o4ed4IAZ-4h@P9FQF9L96D>
References: <20240301-slab-memcg-v1-0-359328a46596@suse.cz>
 <20240301-slab-memcg-v1-2-359328a46596@suse.cz>
 <ZfClX_CJBYRW-cCc@P9FQF9L96D>
 <ZfCt6TKEENN_Rq_C@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfCt6TKEENN_Rq_C@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT

On Tue, Mar 12, 2024 at 07:32:57PM +0000, Matthew Wilcox wrote:
> On Tue, Mar 12, 2024 at 11:56:31AM -0700, Roman Gushchin wrote:
> > On Fri, Mar 01, 2024 at 06:07:09PM +0100, Vlastimil Babka wrote:
> > > The hooks make multiple calls to functions in mm/memcontrol.c, including
> > > to th current_obj_cgroup() marked __always_inline. It might be faster to
> > > make a single call to the hook in mm/memcontrol.c instead. The hooks
> > > also don't use almost anything from mm/slub.c. obj_full_size() can move
> > > with the hooks and cache_vmstat_idx() to the internal mm/slab.h
> > > 
> > > Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> > > ---
> > >  mm/memcontrol.c |  90 ++++++++++++++++++++++++++++++++++++++++++++++++++
> > >  mm/slab.h       |  10 ++++++
> > >  mm/slub.c       | 100 --------------------------------------------------------
> > >  3 files changed, 100 insertions(+), 100 deletions(-)
> > 
> > Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
> > 
> > Btw, even before your change:
> > $ cat mm/memcontrol.c | wc -l
> > 8318
> > so I wonder if soon we might want to split it into some smaller parts.
> 
> If we are going to split it, perhaps a mm/memcg-v1.c would make sense,
> because I certainly don't have a good idea about what's v1 and what's
> v2.  And maybe we could even conditionally compile the v1 file ;-)

Good call.
We already have cgroup/cgroup-v1.c and cgroup/legacy_freezer.c.

Thanks!

