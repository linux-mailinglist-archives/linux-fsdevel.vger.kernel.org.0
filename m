Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1960720BAC7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jun 2020 22:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbgFZU5R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Jun 2020 16:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgFZU5R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Jun 2020 16:57:17 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB0FC03E979;
        Fri, 26 Jun 2020 13:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=/j1J3VNoc3X3k3mp9U8TxyNrfgAwisW2njcwJM52V4Q=; b=h4grfjDq/NXOFrzYJ8Q9SYUaVM
        hpTYkJPtCel8/BPsyPaXQ1uGcjQKq8GagRfM5oJ8kF/noKfuwo9KTWtyTQcnjuaLRmH/gNmknta55
        imKlS0xVZTeIm1JUf4F4zWPkONPx/1TwCRfQk+Q/JvexALVRJ7j5tG1RQpowHmAoNtL8mgj0n+kdE
        IhZXaAcFVRdtkA21ALxvzNry1AuLo92nKVzsmS1tFOw57xmhGTd44FQyLxzzJaP86QFGa4hveOCdN
        1rJR7mvidfJnrpqg0R7l4WLdbbH6Zi+vt/m1Z0R2bfa5jVpT1f6Zel9A1eB+iTlR+LPRXIU+qDsD9
        7OWn8Ghg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jovP2-0002Ub-TT; Fri, 26 Jun 2020 20:56:57 +0000
Subject: Re: [PATCH] slab: Fix misplaced __free_one()
To:     Kees Cook <keescook@chromium.org>, akpm@linux-foundation.org
Cc:     broonie@kernel.org, mhocko@suse.cz, sfr@canb.auug.org.au,
        linux-next@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        mm-commits@vger.kernel.org
References: <202006261306.0D82A2B@keescook>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <1de6b098-a759-dd96-df5d-9a282b2a991b@infradead.org>
Date:   Fri, 26 Jun 2020 13:56:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <202006261306.0D82A2B@keescook>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/26/20 1:07 PM, Kees Cook wrote:
> The implementation of __free_one() was accidentally placed inside a
> CONFIG_NUMA #ifdef. Move it above.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Link: https://lore.kernel.org/lkml/7ff248c7-d447-340c-a8e2-8c02972aca70@infradead.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
> This a fix for slab-add-naive-detection-of-double-free.patch
> ---
>  mm/slab.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/slab.c b/mm/slab.c
> index bbff6705ab2b..5ccb151a6e8f 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -588,6 +588,16 @@ static int transfer_objects(struct array_cache *to,
>  	return nr;
>  }
>  
> +/* &alien->lock must be held by alien callers. */
> +static __always_inline void __free_one(struct array_cache *ac, void *objp)
> +{
> +	/* Avoid trivial double-free. */
> +	if (IS_ENABLED(CONFIG_SLAB_FREELIST_HARDENED) &&
> +	    WARN_ON_ONCE(ac->avail > 0 && ac->entry[ac->avail - 1] == objp))
> +		return;
> +	ac->entry[ac->avail++] = objp;
> +}
> +
>  #ifndef CONFIG_NUMA
>  
>  #define drain_alien_cache(cachep, alien) do { } while (0)
> @@ -749,16 +759,6 @@ static void drain_alien_cache(struct kmem_cache *cachep,
>  	}
>  }
>  
> -/* &alien->lock must be held by alien callers. */
> -static __always_inline void __free_one(struct array_cache *ac, void *objp)
> -{
> -	/* Avoid trivial double-free. */
> -	if (IS_ENABLED(CONFIG_SLAB_FREELIST_HARDENED) &&
> -	    WARN_ON_ONCE(ac->avail > 0 && ac->entry[ac->avail - 1] == objp))
> -		return;
> -	ac->entry[ac->avail++] = objp;
> -}
> -
>  static int __cache_free_alien(struct kmem_cache *cachep, void *objp,
>  				int node, int page_node)
>  {
> 


-- 
~Randy
