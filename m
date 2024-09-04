Return-Path: <linux-fsdevel+bounces-28477-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C311F96B068
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 07:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46143B21BFF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 05:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9840082866;
	Wed,  4 Sep 2024 05:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OSFplgDz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0553A54BD4
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 05:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725427071; cv=none; b=HehfWXSPXcytE71sCM+UeaDqoBRyrQuIXscKyNsGoBudERDljTZEHWazcuw3XKsou1SlXnurvZF0gkt5GKQbQ2VywaeSs1VrzBt/9hkw1oahjop7JGHwpWS6TN7Lcfa8uDPo8ii8HFoofX6AWCUNtmbXOupaNwPpseWB63v0G58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725427071; c=relaxed/simple;
	bh=zeGaL8E1K5vXvWQZ/9ojHDXnsR4kl57ug+P3voJOOVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TkXyVtoAYhJno0ASgeHqJgqTve/NB9WICeP43OC/jnwyndgj1lLnajAVmf2+K4Hmu0TlRwLzOTOMhwH7tkJlRYv7u3GGDy7qvkGdduGsjp4si3E4XPiK29I731Wbmb86HdVfnkU3UmTSm4Au7aNMyZZauzKEdmDp3CmljiuZZ0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OSFplgDz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB46DC4CEC2;
	Wed,  4 Sep 2024 05:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725427070;
	bh=zeGaL8E1K5vXvWQZ/9ojHDXnsR4kl57ug+P3voJOOVw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OSFplgDzUdiYVeTcX1uJL4RRGLlC9b5huriXpazTQtmzwSmtr/Y8/E8nhdOGfNE8z
	 lY7mVREOHc289hfL0/JZEa1pxzdTKMdkY47K/qsY61MzbctgAuWU3UNtYqsAazLjqs
	 5f9/6sEa+ozCmVLyiXIo2plVtRaqcaB0aUJu6W1ml3Nxt/eJrCuDe+CfIocqW/Amkw
	 z2A/z2FmWHBesehlygwYn734zuZwKoG5BcO7SiyJaL4zk79X1e9AthtkL0oOEWMI2j
	 2s/maKENy/WtWOOi0ncpsYWEL22RHNuxvj7ecUZakFtekIoVnzqsU1+C+MPgDy6mfh
	 3Ere0qASZeXbQ==
Date: Wed, 4 Sep 2024 08:15:04 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Jens Axboe <axboe@kernel.dk>,
	Jann Horn <jannh@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 13/15] file: port to struct kmem_cache_args
Message-ID: <Ztfs2I3W3fh_2av4@kernel.org>
References: <20240903-work-kmem_cache_args-v2-0-76f97e9a4560@kernel.org>
 <20240903-work-kmem_cache_args-v2-13-76f97e9a4560@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903-work-kmem_cache_args-v2-13-76f97e9a4560@kernel.org>

On Tue, Sep 03, 2024 at 04:20:54PM +0200, Christian Brauner wrote:
> Port filp_cache to struct kmem_cache_args.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  fs/file_table.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/file_table.c b/fs/file_table.c
> index 3ef558f27a1c..861c03608e83 100644
> --- a/fs/file_table.c
> +++ b/fs/file_table.c
> @@ -511,9 +511,14 @@ EXPORT_SYMBOL(__fput_sync);
>  
>  void __init files_init(void)
>  {
> -	filp_cachep = kmem_cache_create_rcu("filp", sizeof(struct file),
> -				offsetof(struct file, f_freeptr),
> -				SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_ACCOUNT);
> +	struct kmem_cache_args args = {
> +		.use_freeptr_offset = true,
> +		.freeptr_offset = offsetof(struct file, f_freeptr),
> +	};
> +
> +	filp_cachep = kmem_cache_create("filp", sizeof(struct file), &args,
> +				SLAB_HWCACHE_ALIGN | SLAB_PANIC |
> +				SLAB_ACCOUNT | SLAB_TYPESAFE_BY_RCU);
>  	percpu_counter_init(&nr_files, 0, GFP_KERNEL);
>  }
>  
> 
> -- 
> 2.45.2
> 

-- 
Sincerely yours,
Mike.

