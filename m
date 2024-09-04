Return-Path: <linux-fsdevel+bounces-28465-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3425596B033
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 06:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66D241C238A8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 04:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E278E823AC;
	Wed,  4 Sep 2024 04:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GCYtQSM7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536B5635
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 04:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725425841; cv=none; b=iayC1P0bUbW68aObhkPRLxSwCxGK8vKISV/0I777/NekexuqFjna8y1xReClbkTrnhTaBr+Wi8lQ3Fqkn9FYumDnvwf0C+PfFhMLJ3RV0w0Er6pco88AHdYnG3+HIdsG920HiHQcDlD1Z/WxcyL0cRY8SWuei1iLG/rmZYyOxic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725425841; c=relaxed/simple;
	bh=2y+DJZFNKmliFw8DrO+uDxsKwo6inzzDw6rLq2yGUFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J2RfZtvUkFUI60bO/QYave+0F3sfwW+kMmaPmGA33lhPhLLhmzlmtpUgU/CQNLYibFcIhVh+Fl9OhSOK6NIIcjf/ojkuhKeXKbHvJaxQ9ENVOVwo8WMV20Hi+sx1lVoIEjUGUdrfq1onSVuB6QdCEwxOrT0OZTXsTrDHVYva/oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GCYtQSM7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88DE0C4CEC2;
	Wed,  4 Sep 2024 04:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725425841;
	bh=2y+DJZFNKmliFw8DrO+uDxsKwo6inzzDw6rLq2yGUFA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GCYtQSM7gSAoGINO6wdU9VVI6Ybf9K2YQ7x598s57M3xTqeQmbwAXAHeu2f4mgQL0
	 gWgwKF5rBoxcRzZiQgG1uSOWBT0ZVPeFWdeVmfn0Y7Y+xbLyZZmLoRgKU8XS0CSJ2m
	 rq01CiT0YBWxKNLIuRWnkubQuBiEYqijdyP6mDECczyrs0X5lFGYj9K0jKxttjpcSZ
	 dALGSbTTQTfPp5l5R0rLQTwsoEzl4YTSj2/I0+WHZbnhnDvmvJ3CdB/FDbCZ/XRkIY
	 mZY0YcZDN0+qFTVKef7vhIFhg9dpyYf4mK9Y/ZWT8OP4PjrVu1QB3nGG4U2gs8aAqW
	 hAI29/0MWK8YA==
Date: Wed, 4 Sep 2024 07:54:34 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Jens Axboe <axboe@kernel.dk>,
	Jann Horn <jannh@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 02/15] slab: add struct kmem_cache_args
Message-ID: <ZtfoCjZw9_4XF_AH@kernel.org>
References: <20240903-work-kmem_cache_args-v2-0-76f97e9a4560@kernel.org>
 <20240903-work-kmem_cache_args-v2-2-76f97e9a4560@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903-work-kmem_cache_args-v2-2-76f97e9a4560@kernel.org>

On Tue, Sep 03, 2024 at 04:20:43PM +0200, Christian Brauner wrote:
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  include/linux/slab.h | 21 ++++++++++++++++
>  mm/slab_common.c     | 67 +++++++++++++++++++++++++++++++++++++++-------------
>  2 files changed, 72 insertions(+), 16 deletions(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 5b2da2cf31a8..79d8c8bca4a4 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -240,6 +240,27 @@ struct mem_cgroup;
>   */
>  bool slab_is_available(void);
>  
> +/**
> + * @align: The required alignment for the objects.
> + * @useroffset: Usercopy region offset
> + * @usersize: Usercopy region size
> + * @freeptr_offset: Custom offset for the free pointer in RCU caches
> + * @use_freeptr_offset: Whether a @freeptr_offset is used
> + * @ctor: A constructor for the objects.
> + */
> +struct kmem_cache_args {
> +	unsigned int align;
> +	unsigned int useroffset;
> +	unsigned int usersize;
> +	unsigned int freeptr_offset;
> +	bool use_freeptr_offset;
> +	void (*ctor)(void *);
> +};
> +
> +struct kmem_cache *__kmem_cache_create_args(const char *name,
> +					    unsigned int object_size,
> +					    struct kmem_cache_args *args,
> +					    slab_flags_t flags);

I'd name it __kmem_cache_create() and then
s/kmem_cache_create/_kmem_cache_create/ in patch 12.

Other than that

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

>  struct kmem_cache *kmem_cache_create(const char *name, unsigned int size,
>  			unsigned int align, slab_flags_t flags,
>  			void (*ctor)(void *));

-- 
Sincerely yours,
Mike.

