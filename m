Return-Path: <linux-fsdevel+bounces-16882-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C868A405B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Apr 2024 06:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1A261C20C65
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Apr 2024 04:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A905E1AACB;
	Sun, 14 Apr 2024 04:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bd27Pkbs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4EC17993
	for <linux-fsdevel@vger.kernel.org>; Sun, 14 Apr 2024 04:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713070559; cv=none; b=hP/F7FZ7ZRibMJbQaqCHGsXznlFCfK4xyEW5VoD/pH7M3VakuSThh7Oju9HPvIiGxMtxFooPsur2ASqNUpX6XoJjapL//dH5PtnV01kWvGi8SIjROdOg5zDyFAvrn3RPiVVIcrkoWEt0yU1FufTJw78/Wsmc8QE6wS/yI76wnaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713070559; c=relaxed/simple;
	bh=y2j7KoDsaeJBqN/VpTEyT+mxqBwI9JziatVanbwDF44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bF1Pf/GfCfbA4ySd3U0NXKR1o90z7GBhR3z5KAC27ppOkLsSWHPyOUv9VWOI3yfBgiGo2IWb0gIn3h/UoHi3XC9Q8P+uCAZaFk4jovaFrYu5h0JeAVNEHBuHV7a7GpBnP1/bJRyEIfhrmGf44XunUX2h+yzKnsWcjxC3jMgITKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bd27Pkbs; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 13 Apr 2024 21:55:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713070555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6sSjcJpVJMu7l0K8sOsNBgOrRR0o2lGErM0v7V0igqw=;
	b=bd27PkbsnoxmQ2TUkrCF3MouPnq9Y+/aw2Dy9bJ+DermcBQP4Qe9rrqilLbDsMOG6YAJF6
	7MxBTTcLwXcF1PNaQTmmdQOjDP/deb32P7eYNvy4DDjsOtFMHKIEBY2p8vUOE8OWkSQxXr
	uSpQR8u66hq1ax5RnUSk8bbZ0VKp3DM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Kees Cook <kees@kernel.org>, Christoph Lameter <cl@linux.com>, 
	Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Chengming Zhou <chengming.zhou@linux.dev>
Subject: Re: [PATCH v2 1/2] mm, slab: move memcg charging to post-alloc hook
Message-ID: <sgzta3zm3os6nraxtb37affiz4itbz32qm2ceadh2wgwk6o33p@cenn36d6dqfa>
References: <20240325-slab-memcg-v2-0-900a458233a6@suse.cz>
 <20240325-slab-memcg-v2-1-900a458233a6@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325-slab-memcg-v2-1-900a458233a6@suse.cz>
X-Migadu-Flow: FLOW_OUT

On Mon, Mar 25, 2024 at 09:20:32AM +0100, Vlastimil Babka wrote:
> The MEMCG_KMEM integration with slab currently relies on two hooks
> during allocation. memcg_slab_pre_alloc_hook() determines the objcg and
> charges it, and memcg_slab_post_alloc_hook() assigns the objcg pointer
> to the allocated object(s).
> 
> As Linus pointed out, this is unnecessarily complex. Failing to charge
> due to memcg limits should be rare, so we can optimistically allocate
> the object(s) and do the charging together with assigning the objcg
> pointer in a single post_alloc hook. In the rare case the charging
> fails, we can free the object(s) back.
> 
> This simplifies the code (no need to pass around the objcg pointer) and
> potentially allows to separate charging from allocation in cases where
> it's common that the allocation would be immediately freed, and the
> memcg handling overhead could be saved.
> 
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Link: https://lore.kernel.org/all/CAHk-=whYOOdM7jWy5jdrAm8LxcgCMFyk2bt8fYYvZzM4U-zAQA@mail.gmail.com/
> Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
> Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

