Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD905652D4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Jul 2022 12:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233691AbiGDK43 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Jul 2022 06:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233121AbiGDK4Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jul 2022 06:56:25 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7C7F5BC
        for <linux-fsdevel@vger.kernel.org>; Mon,  4 Jul 2022 03:56:23 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id y141so8620277pfb.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Jul 2022 03:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CXQfpYTDQSPQk5n85TMF5Rtc8fjIvsWXa8Dgsig58ac=;
        b=Bp2IHpgWFvsjVPLdIykEUTI6E62rNcXQ1Qqs+kBE0ofKgsRCSjGPqjUiszcAFTH8sk
         srzUVlPKcuxjQuahsuvWr9Vp+Eoegd4/LBZrvv8mm/Iuq5yfReWHvWwKmp8M7I/Kt9k7
         btxI7NFaYQbE5kkpesVGFRY+TCtBn130gljZFXT3XlzG3nWfQyMg4pCBfu4tGjqVgx3V
         Epsbxi5Mi5ILXuhvvnngWCarZ+VLTWRlHQ6+UVUvp5ad/4oDaBf5Y0ZqzK6wVkV3Nugw
         vB/QyqZLvCVUn0FJXiupvXPszkB98MVXCfwCFIuOIkyd6y6YgKAmAKt75CiToINptW7M
         K/mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CXQfpYTDQSPQk5n85TMF5Rtc8fjIvsWXa8Dgsig58ac=;
        b=c0v40JoYNENefovpCUkArrzegKUorrxUW+95clrGBtCjlpCg+loeG4cIcXdC3AfhyZ
         /ok/Js4V8SZ9SN1CjDnQzi7FR87E1g2q3u1dluJJWWYVJbogvo4aDnUjzjyqLGbnMpd+
         W8w/O+yPl8kFoelMMp7NaTso0VvEkbjdo1WcOOvNWZopjzDLBmjzGb+WISiCSJHXeqCc
         WxPxNDdrr0pUD10YGjjud0fV4P5AKykJQRnMH1I9lMmllFXnVpfkhbQtYMSbUSsyIDuV
         B8wZbhcEOOSylpO21WJMBIhM4jf2yOugk6khmThx48VxAAHIfqjYT13QORNIokkpS9he
         WXPg==
X-Gm-Message-State: AJIora/GLKvWYYYk5jgOHDOOJDrtKE2TPmZXGtscZ+Fzi66zhZ7roGd/
        xgoSPp5hcqy3Wlv6aLSGNdhDY0/F36HyjBrU
X-Google-Smtp-Source: AGRyM1tfnUur7TuwOQxmJlxXtmywkayWT23lDh1TS6mNt5d9dgW0FSIZYivIOlrTCPT21ttAkbBfaA==
X-Received: by 2002:a05:6a00:1808:b0:528:3ec:543a with SMTP id y8-20020a056a00180800b0052803ec543amr27281869pfa.70.1656932183295;
        Mon, 04 Jul 2022 03:56:23 -0700 (PDT)
Received: from localhost ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id s23-20020a170902a51700b001690d283f52sm20554943plq.158.2022.07.04.03.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 03:56:23 -0700 (PDT)
Date:   Mon, 4 Jul 2022 18:56:19 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, jgg@ziepe.ca, jhubbard@nvidia.com,
        william.kucharski@oracle.com, dan.j.williams@intel.com,
        jack@suse.cz, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev
Subject: Re: [PATCH] mm: fix missing wake-up event for FSDAX pages
Message-ID: <YsLHUxNjXLOumaIy@FVFYT0MHHV2J.usts.net>
References: <20220704074054.32310-1-songmuchun@bytedance.com>
 <YsLDGEiVSHN3Xx/g@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsLDGEiVSHN3Xx/g@casper.infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 04, 2022 at 11:38:16AM +0100, Matthew Wilcox wrote:
> On Mon, Jul 04, 2022 at 03:40:54PM +0800, Muchun Song wrote:
> > FSDAX page refcounts are 1-based, rather than 0-based: if refcount is
> > 1, then the page is freed.  The FSDAX pages can be pinned through GUP,
> > then they will be unpinned via unpin_user_page() using a folio variant
> > to put the page, however, folio variants did not consider this special
> > case, the result will be to miss a wakeup event (like the user of
> > __fuse_dax_break_layouts()).
> 
> Argh, no.  The 1-based refcounts are a blight on the entire kernel.
> They need to go away, not be pushed into folios as well.  I think

I would be happy if this could go away.

> we're close to having that fixed, but until then, this should do
> the trick?
> 

The following fix looks good to me since it lowers the overhead as
much as possible

Thanks.

> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index cc98ab012a9b..4cef5e0f78b6 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1129,18 +1129,18 @@ static inline bool is_zone_movable_page(const struct page *page)
>  #if defined(CONFIG_ZONE_DEVICE) && defined(CONFIG_FS_DAX)
>  DECLARE_STATIC_KEY_FALSE(devmap_managed_key);
>  
> -bool __put_devmap_managed_page(struct page *page);
> -static inline bool put_devmap_managed_page(struct page *page)
> +bool __put_devmap_managed_page(struct page *page, int refs);
> +static inline bool put_devmap_managed_page(struct page *page, int refs)
>  {
>  	if (!static_branch_unlikely(&devmap_managed_key))
>  		return false;
>  	if (!is_zone_device_page(page))
>  		return false;
> -	return __put_devmap_managed_page(page);
> +	return __put_devmap_managed_page(page, refs);
>  }
>  
>  #else /* CONFIG_ZONE_DEVICE && CONFIG_FS_DAX */
> -static inline bool put_devmap_managed_page(struct page *page)
> +static inline bool put_devmap_managed_page(struct page *page, int refs)
>  {
>  	return false;
>  }
> @@ -1246,7 +1246,7 @@ static inline void put_page(struct page *page)
>  	 * For some devmap managed pages we need to catch refcount transition
>  	 * from 2 to 1:
>  	 */
> -	if (put_devmap_managed_page(&folio->page))
> +	if (put_devmap_managed_page(&folio->page, 1))
>  		return;
>  	folio_put(folio);
>  }
> diff --git a/mm/gup.c b/mm/gup.c
> index d1132b39aa8f..28df02121c78 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -88,7 +88,8 @@ static inline struct folio *try_get_folio(struct page *page, int refs)
>  	 * belongs to this folio.
>  	 */
>  	if (unlikely(page_folio(page) != folio)) {
> -		folio_put_refs(folio, refs);
> +		if (!put_devmap_managed_page(&folio->page, refs))
> +			folio_put_refs(folio, refs);
>  		goto retry;
>  	}
>  
> @@ -177,6 +178,8 @@ static void gup_put_folio(struct folio *folio, int refs, unsigned int flags)
>  			refs *= GUP_PIN_COUNTING_BIAS;
>  	}
>  
> +	if (put_devmap_managed_page(&folio->page, refs))
> +		return;
>  	folio_put_refs(folio, refs);
>  }
>  
> diff --git a/mm/memremap.c b/mm/memremap.c
> index b870a659eee6..b25e40e3a11e 100644
> --- a/mm/memremap.c
> +++ b/mm/memremap.c
> @@ -499,7 +499,7 @@ void free_zone_device_page(struct page *page)
>  }
>  
>  #ifdef CONFIG_FS_DAX
> -bool __put_devmap_managed_page(struct page *page)
> +bool __put_devmap_managed_page(struct page *page, int refs)
>  {
>  	if (page->pgmap->type != MEMORY_DEVICE_FS_DAX)
>  		return false;
> @@ -509,7 +509,7 @@ bool __put_devmap_managed_page(struct page *page)
>  	 * refcount is 1, then the page is free and the refcount is
>  	 * stable because nobody holds a reference on the page.
>  	 */
> -	if (page_ref_dec_return(page) == 1)
> +	if (page_ref_sub_return(page, refs) == 1)
>  		wake_up_var(&page->_refcount);
>  	return true;
>  }
> diff --git a/mm/swap.c b/mm/swap.c
> index c6194cfa2af6..94e42a9bab92 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -960,7 +960,7 @@ void release_pages(struct page **pages, int nr)
>  				unlock_page_lruvec_irqrestore(lruvec, flags);
>  				lruvec = NULL;
>  			}
> -			if (put_devmap_managed_page(&folio->page))
> +			if (put_devmap_managed_page(&folio->page, 1))
>  				continue;
>  			if (folio_put_testzero(folio))
>  				free_zone_device_page(&folio->page);
> 
