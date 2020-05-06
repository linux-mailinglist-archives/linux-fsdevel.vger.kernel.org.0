Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28AAC1C78DE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 May 2020 20:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729631AbgEFSDb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 May 2020 14:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727872AbgEFSDb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 May 2020 14:03:31 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35C8C061A0F;
        Wed,  6 May 2020 11:03:30 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id q8so2140947eja.2;
        Wed, 06 May 2020 11:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cr6ABbOcAj5/Vp1Y9NcSiEi2mo0kADAGjNrqyHtiq9A=;
        b=oCbWVJ+gSQksrSbx5++3DarHBSgTNJoXOBxIml2gdrIjaMIuqn8yXRj+CHsZTlcFXe
         slYP7AVlLvcVm+P/5/0BZSggyDGeseiKNbqCDPFf2FjDhS6nEoH8DCAJpIMsqXRJLhl3
         DY5RBT7vtn7jOlO617HQ98NhwaYYwzRse8wY34SL7BLNqG7BDGLSnZ5ctsjFYv+HvL12
         WV4fTqxiZYk27n2UeBpKf85dGZGaoOhhlI8AYCjK3ZlXxh9AKt3k0kknEIFhFPfSFagD
         yg8Vhl1N9oXUt5vyQtzXQhkGCqPvrjUaWWlk31sBrl0Ge+01bgGfYh6ggAch1s3jUCZJ
         bElw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cr6ABbOcAj5/Vp1Y9NcSiEi2mo0kADAGjNrqyHtiq9A=;
        b=aWPEdR46UJTbXue39Wmjf5ifIXgtcI8XtvhI4kRvgRVb9fNSqGo8sUdvj7AoXe6aTA
         vGZzPVvFGw57lod6JrVZcyoULnouEpjS7DeoKYGgI4L99cwnPA85yo1w0vGFHiAIcmJV
         XxvRRsqP97Dm96EzGj1jx27mHIioG98+tz+GRsi1UP1aa/epu2vGbWRqz8sO5AQvWLVI
         wjHwmZvdZPf2eFDv/5J/p9IkPhHtH4Xn3JnAzEU8Jmx1EujRZtGrHsw6TWuTgF6eudNF
         XgSUyzJBZ2JWFi4UeiVU/UJl0MfA1JsMcrw594WvothiZKHFCk2X98tmrSGcgXrweL5i
         5nyQ==
X-Gm-Message-State: AGi0PubfTBITZ+B5S0pyMTqTtJ3PEaUO118PwQN+C5o3XdtuYcaHC20F
        3kVouuJ/YJLFtjSZEwPEBR8FWA49VfasBWdEnmI=
X-Google-Smtp-Source: APiQypIAKVQp9vj0c0GnmeeFGukCjSSe2/89qm1fYOJldHfWurXMbgDzTLRWDFFoSCej8aEZM37NmA3qyS2TqNCstLY=
X-Received: by 2002:a17:906:1e47:: with SMTP id i7mr8785472ejj.61.1588788209559;
 Wed, 06 May 2020 11:03:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200429133657.22632-1-willy@infradead.org> <20200429133657.22632-18-willy@infradead.org>
In-Reply-To: <20200429133657.22632-18-willy@infradead.org>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 6 May 2020 11:03:06 -0700
Message-ID: <CAHbLzkrEmEvVXmhPfngjkLP5iT_GH2SyRhDbHAiC7D2De8xyjw@mail.gmail.com>
Subject: Re: [PATCH v3 17/25] mm: Add __page_cache_alloc_order
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 29, 2020 at 6:37 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
>
> This new function allows page cache pages to be allocated that are
> larger than an order-0 page.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  include/linux/pagemap.h | 24 +++++++++++++++++++++---
>  mm/filemap.c            | 12 ++++++++----
>  2 files changed, 29 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 55199cb5bd66..1169e2428dd7 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -205,15 +205,33 @@ static inline int page_cache_add_speculative(struct page *page, int count)
>         return __page_cache_add_speculative(page, count);
>  }
>
> +static inline gfp_t thp_gfpmask(gfp_t gfp)
> +{
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +       /* We'd rather allocate smaller pages than stall a page fault */
> +       gfp |= GFP_TRANSHUGE_LIGHT;

This looks not correct. GFP_TRANSHUGE_LIGHT may set GFP_FS, but some
filesystem may expect GFP_NOFS, i.e. in readahead path.

> +       gfp &= ~__GFP_DIRECT_RECLAIM;
> +#endif
> +       return gfp;
> +}
> +
>  #ifdef CONFIG_NUMA
> -extern struct page *__page_cache_alloc(gfp_t gfp);
> +extern struct page *__page_cache_alloc_order(gfp_t gfp, unsigned int order);
>  #else
> -static inline struct page *__page_cache_alloc(gfp_t gfp)
> +static inline
> +struct page *__page_cache_alloc_order(gfp_t gfp, unsigned int order)
>  {
> -       return alloc_pages(gfp, 0);
> +       if (order == 0)
> +               return alloc_pages(gfp, 0);
> +       return prep_transhuge_page(alloc_pages(thp_gfpmask(gfp), order));
>  }
>  #endif
>
> +static inline struct page *__page_cache_alloc(gfp_t gfp)
> +{
> +       return __page_cache_alloc_order(gfp, 0);
> +}
> +
>  static inline struct page *page_cache_alloc(struct address_space *x)
>  {
>         return __page_cache_alloc(mapping_gfp_mask(x));
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 23a051a7ef0f..9abba062973a 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -941,24 +941,28 @@ int add_to_page_cache_lru(struct page *page, struct address_space *mapping,
>  EXPORT_SYMBOL_GPL(add_to_page_cache_lru);
>
>  #ifdef CONFIG_NUMA
> -struct page *__page_cache_alloc(gfp_t gfp)
> +struct page *__page_cache_alloc_order(gfp_t gfp, unsigned int order)
>  {
>         int n;
>         struct page *page;
>
> +       if (order > 0)
> +               gfp = thp_gfpmask(gfp);
> +
>         if (cpuset_do_page_mem_spread()) {
>                 unsigned int cpuset_mems_cookie;
>                 do {
>                         cpuset_mems_cookie = read_mems_allowed_begin();
>                         n = cpuset_mem_spread_node();
> -                       page = __alloc_pages_node(n, gfp, 0);
> +                       page = __alloc_pages_node(n, gfp, order);
> +                       prep_transhuge_page(page);
>                 } while (!page && read_mems_allowed_retry(cpuset_mems_cookie));
>
>                 return page;
>         }
> -       return alloc_pages(gfp, 0);
> +       return prep_transhuge_page(alloc_pages(gfp, order));
>  }
> -EXPORT_SYMBOL(__page_cache_alloc);
> +EXPORT_SYMBOL(__page_cache_alloc_order);
>  #endif
>
>  /*
> --
> 2.26.2
>
>
