Return-Path: <linux-fsdevel+bounces-2608-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 461BE7E7049
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 18:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 202091C20C87
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 17:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62D8225D6;
	Thu,  9 Nov 2023 17:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+JcFIb8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B75A2232C
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 17:29:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8B6BC433C7;
	Thu,  9 Nov 2023 17:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699550966;
	bh=MRAvsoOlvUkSL8fQrIZ/xhJ3q47nI5cjxKJWoDX5BF4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N+JcFIb8jRkyvYmHdWbYR913TocLugRR3HnlvQ4jKa6iw8SOHJkqFwfQQ7Ojcqqxg
	 VNwosEfQahskD3SUEIdZSOLAjMPO+PTQUjs7XggUjhzbRgYe5x+zI4rKnml5zleZWH
	 7GuGKDEs2C6ndV0Ak3YWDh14YsHZfPmxozmRbuX5qptPebMg2R8H0On5xU7RZEW32p
	 uHGQQsCA+shgSY7xQfdc6joxM1+QvYXnigvuNrgT+AE56FnliLlzFqlRUrYojjhWLj
	 kq/BT+b5t2AORNk7S7m3XgVWyxeRdyLVCu8ZqdZHIBoR4jvxVIb3c4g8wZblD8iyE+
	 ZHuyBunzOcDEQ==
Date: Thu, 9 Nov 2023 18:29:22 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 19/22] to_shrink_list(): call only if refcount is 0
Message-ID: <20231109-vielsagend-serienweise-aad410be557e@brauner>
References: <20231109061932.GA3181489@ZenIV>
 <20231109062056.3181775-1-viro@zeniv.linux.org.uk>
 <20231109062056.3181775-19-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231109062056.3181775-19-viro@zeniv.linux.org.uk>

On Thu, Nov 09, 2023 at 06:20:53AM +0000, Al Viro wrote:
> The only thing it does if refcount is not zero is d_lru_del(); no
> point, IMO, seeing that plain dput() does nothing of that sort...
> 
> Note that 2 of 3 current callers are guaranteed that refcount is 0.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Ok, I don't fully understand this one but I see nothing obviously wrong
with it so,

Acked-by: Christian Brauner <brauner@kernel.org>

>  fs/dcache.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/dcache.c b/fs/dcache.c
> index aa9f7ee7a603..49585f2ad896 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -915,8 +915,7 @@ __must_hold(&dentry->d_lock)
>  	if (!(dentry->d_flags & DCACHE_SHRINK_LIST)) {
>  		if (dentry->d_flags & DCACHE_LRU_LIST)
>  			d_lru_del(dentry);
> -		if (!dentry->d_lockref.count)
> -			d_shrink_add(dentry, list);
> +		d_shrink_add(dentry, list);
>  	}
>  }
>  
> @@ -1110,10 +1109,8 @@ EXPORT_SYMBOL(d_prune_aliases);
>  static inline void shrink_kill(struct dentry *victim, struct list_head *list)
>  {
>  	struct dentry *parent = victim->d_parent;
> -	if (parent != victim) {
> -		--parent->d_lockref.count;
> +	if (parent != victim && !--parent->d_lockref.count)
>  		to_shrink_list(parent, list);
> -	}
>  	__dentry_kill(victim);
>  }
>  
> -- 
> 2.39.2
> 

