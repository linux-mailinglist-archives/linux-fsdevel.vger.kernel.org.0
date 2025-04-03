Return-Path: <linux-fsdevel+bounces-45678-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D145DA7A961
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 20:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6FEE3A7FA0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 18:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C77F25290B;
	Thu,  3 Apr 2025 18:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pr/Hcdy5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84187151992
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Apr 2025 18:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743705033; cv=none; b=EOo8N4RA+/wJC7+2wRZAaCxBtOQEfy2H1Clydm02XnsS9RMy5OsdT3HsOQpJEevFYNbPvhKmgocICtV/gud/ClC+liVc/WYPSQC6lgWHGCSQYUWARzZvsjeCICCbrHevZUvr7vcs8gj/euYlHOxYkCie1Om+ZJGJBCMFUBVsazk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743705033; c=relaxed/simple;
	bh=1HlXRlQ+sRx+EKY6oH+sBIE+XiXRr0ftEttdjZz/qLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DKn8th+TJqtpKrqLBB8Ag3cTB2mWQbTOPgTDWpiOomKCnxgf+6QaRwVfehnISIktXvd/HENbr7R57ZlHDMPWkx1pPAB5MKIYLgPS++uR4FV0ulGwCWxXlHqhng7S4SugfSlThgQYCE08DfAl1C2b+RtMTWB3Qj0KOqdcVEYoAYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pr/Hcdy5; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 3 Apr 2025 11:30:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743705029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ArYKiUFMnEOVml+ahZzr+rsVltz9Am8Fwrx6AQaomzI=;
	b=pr/Hcdy5U+g8jz5usJ4LCnof/q9gv8w3IYRENXLye3PGpA1C+lLUknPgex7+yH2vJyb2Ar
	kcUAn6OVbfkdg3+MQDBiq6/rE7BInTiX6vqujAODHnVOQucHSMbbszBa1fYHe5oERwY0mP
	Ywxc1xrb4yQ+R3J0PxdhY1SFyMGISwM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Michal Hocko <mhocko@suse.com>
Cc: Dave Chinner <david@fromorbit.com>, Yafang Shao <laoar.shao@gmail.com>, 
	Harry Yoo <harry.yoo@oracle.com>, Kees Cook <kees@kernel.org>, joel.granados@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm: kvmalloc: make kmalloc fast path real fast path
Message-ID: <hqoa4rhguuzytikznc3xahhwv25w5wcafjquif5nzuhct7e5bc@7or627iuuf2g>
References: <20250401073046.51121-1-laoar.shao@gmail.com>
 <3315D21B-0772-4312-BCFB-402F408B0EF6@kernel.org>
 <Z-y50vEs_9MbjQhi@harry>
 <CALOAHbBSvMuZnKF_vy3kGGNOCg5N2CgomLhxMxjn8RNwMTrw7A@mail.gmail.com>
 <Z-0gPqHVto7PgM1K@dread.disaster.area>
 <Z-0sjd8SEtldbxB1@tiehlicka>
 <zeuszr6ot5qdi46f5gvxa2c5efy4mc6eaea3au52nqnbhjek7o@l43ps2jtip7x>
 <Z-43Q__lSUta2IrM@tiehlicka>
 <Z-48K0OdNxZXcnkB@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-48K0OdNxZXcnkB@tiehlicka>
X-Migadu-Flow: FLOW_OUT

On Thu, Apr 03, 2025 at 09:43:39AM +0200, Michal Hocko wrote:
> There are users like xfs which need larger allocations with NOFAIL
> sementic. They are not using kvmalloc currently because the current
> implementation tries too hard to allocate through the kmalloc path
> which causes a lot of direct reclaim and compaction and that hurts
> performance a lot (see 8dc9384b7d75 ("xfs: reduce kvmalloc overhead for
> CIL shadow buffers") for more details).
> 
> kvmalloc does support __GFP_RETRY_MAYFAIL semantic to express that
> kmalloc (physically contiguous) allocation is preferred and we should go
> more aggressive to make it happen. There is currently no way to express
> that kmalloc should be very lightweight and as it has been argued [1]
> this mode should be default to support kvmalloc(NOFAIL) with a
> lightweight kmalloc path which is currently impossible to express as
> __GFP_NOFAIL cannot be combined by any other reclaim modifiers.
> 
> This patch makes all kmalloc allocations GFP_NOWAIT unless
> __GFP_RETRY_MAYFAIL is provided to kvmalloc. This allows to support both
> fail fast and retry hard on physically contiguous memory with vmalloc
> fallback.
> 
> There is a potential downside that relatively small allocations (smaller
> than PAGE_ALLOC_COSTLY_ORDER) could fallback to vmalloc too easily and
> cause page block fragmentation. We cannot really rule that out but it
> seems that xlog_cil_kvmalloc use doesn't indicate this to be happening.
> 
> [1] https://lore.kernel.org/all/Z-3i1wATGh6vI8x8@dread.disaster.area/T/#u
> Signed-off-by: Michal Hocko <mhocko@suse.com>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

