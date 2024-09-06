Return-Path: <linux-fsdevel+bounces-28811-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B57D96E701
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 02:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6230A286D3D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 00:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D35C12E7E;
	Fri,  6 Sep 2024 00:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YCYtj4+K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17CB171CD
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Sep 2024 00:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725584070; cv=none; b=bYHHJIsli9/huZXU/zV6THXPOmUOSrEhNDvPPsA3hSKc5yJXwYb4jgMllyBiCf8zMQrXDDD14+xSRK6mbMdg5Q/KJFMVeLOzJfJjhAZxgjLHp2fyIRaG8fmXKQfuTJF/bsBA51TfKU61EPl+n4uamUEwzDUOPBJmoYotXbnZrJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725584070; c=relaxed/simple;
	bh=U6cvKumuP663NSd8Jcx8sfbAXBKukeysCOH2YTM5W4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bk9sE695VRUtKi+gzmJWaj7nBsL7UzFSnut3eguD6R+MREUU0MjmmNSPyvf/4FMjAaxqAEEyX0XjO3yb6IIINqK29PE9iIYrrIBxaxVk4DiUYIi8kfq+EZjMqplwUqIQ3IOlWDaUu0MQ1i9tQmphGK6yvykMkyQRnn+H28UsWMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YCYtj4+K; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 6 Sep 2024 00:54:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725584065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6NU1MZJkCaBTZZ9tJcaKcj5Vusv1Uhs1Gyu763ke3bA=;
	b=YCYtj4+Knj87rAXE9RfLoQ7Hdi9iOvJUNwPVGd0O/dCgk5/cKtKtfrLbGM5xcT06Gt28yo
	AdJVpQ9UBUI9sq69lOYRKrJ2q8ZUrFsNS0I8UzhTIqw9ggwkNX6A+/WLFnUV3AQQ87RzVH
	ChFXsm28DyCfnRCXu6u+boW///6Rky8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Christian Brauner <brauner@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Jens Axboe <axboe@kernel.dk>,
	Jann Horn <jannh@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>, Kees Cook <kees@kernel.org>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 08/17] slab: pass struct kmem_cache_args to
 do_kmem_cache_create()
Message-ID: <ZtpSvF4jLufqkfDy@google.com>
References: <20240905-work-kmem_cache_args-v4-0-ed45d5380679@kernel.org>
 <20240905-work-kmem_cache_args-v4-8-ed45d5380679@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905-work-kmem_cache_args-v4-8-ed45d5380679@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Thu, Sep 05, 2024 at 09:56:51AM +0200, Christian Brauner wrote:
> and initialize most things in do_kmem_cache_create(). In a follow-up
> patch we'll remove rcu_freeptr_offset from struct kmem_cache.
> 
> Reviewed-by: Kees Cook <kees@kernel.org>
> Reviewed-by: Jens Axboe <axboe@kernel.dk>
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

