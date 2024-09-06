Return-Path: <linux-fsdevel+bounces-28804-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C850396E6AD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 02:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E378B23A3D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 00:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5EDC8FF;
	Fri,  6 Sep 2024 00:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="W3fh84xM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B90D442C
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Sep 2024 00:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725581716; cv=none; b=dTvy1vc/+m7c8PG0yAH58RnZDrHXYXycdjyN35KEDyMoIQ1M/x4nGFK9b7T/IgEOxSpY+Jhsz6yhthLtuLKFdxeT9V16zVwBdQbkA4VsprL+4SGiyULi6lcLPRhbvH0lEFFAtmNDVJVwjQLFtdKPrrrC+822f6X1v2YKpBUnsOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725581716; c=relaxed/simple;
	bh=1pYcngFK78AD11SF2w/OSipFbj3KPWJ1lHXWFFcGnj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lmALXVCiJqg4K9l9vZRszMuqG4z08mkMNIGHp+qoDOYkgPCnk+do51FugHWOuaH3ieoKi7jLOYPwsHWvfr7mNfC376cgO0mD1gfQO1LtSMZiFjxX8RN1B8ywqTRXNRr6cUQO88acX5s2JzP09d0E8wvNnOoriwo0WXqkpVJwoC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=W3fh84xM; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 6 Sep 2024 00:15:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725581713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5+2Pibvrlz+QfETZflGLoh0C2TJXNiA3gyTi0XyefyY=;
	b=W3fh84xMtn9KXwKm+/0pJxoC693OXhkEKaeUDlgiyKADSfFZc1ptotr/eof5p8Avo7DPSN
	9tk1XULaBHRSkRjkd1uwaEXGR3H65UjGbM/o+CbuqFiJSvZWP7Qh2f9z5NdVvQAcO3YXgW
	W6SHz7PF6dppM4cy8/gcWZkQ/Hv+Xr8=
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
Subject: Re: [PATCH v4 02/17] slab: add struct kmem_cache_args
Message-ID: <ZtpJjJ_H-YljAeZP@google.com>
References: <20240905-work-kmem_cache_args-v4-0-ed45d5380679@kernel.org>
 <20240905-work-kmem_cache_args-v4-2-ed45d5380679@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905-work-kmem_cache_args-v4-2-ed45d5380679@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Thu, Sep 05, 2024 at 09:56:45AM +0200, Christian Brauner wrote:
> Currently we have multiple kmem_cache_create*() variants that take up to
> seven separate parameters with one of the functions having to grow an
> eigth parameter in the future to handle both usercopy and a custom
> freelist pointer.
> 
> Add a struct kmem_cache_args structure and move less common parameters
> into it. Core parameters such as name, object size, and flags continue
> to be passed separately.
> 
> Add a new function __kmem_cache_create_args() that takes a struct
> kmem_cache_args pointer and port do_kmem_cache_create_usercopy() over to
> it.
> 
> In follow-up patches we will port the other kmem_cache_create*()
> variants over to it as well.
> 
> Reviewed-by: Kees Cook <kees@kernel.org>
> Reviewed-by: Jens Axboe <axboe@kernel.dk>
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

