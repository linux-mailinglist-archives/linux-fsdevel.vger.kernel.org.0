Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAAD67121E3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 10:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242465AbjEZIMt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 May 2023 04:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236852AbjEZIMs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 May 2023 04:12:48 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07AC9D9;
        Fri, 26 May 2023 01:12:47 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f6042d605dso3046385e9.2;
        Fri, 26 May 2023 01:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685088765; x=1687680765;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IQNRjhK3jlaLYFDGbUON4IVN8F+sSVQXRFYbktw9Bqw=;
        b=rRXX6w93fiNwxOUzxA3p521bhc6sXRRDR6a9hSjs8VyyKTyaLYWiqCG/ij2C9D+V7r
         5uxqrHE+lzRyXHPmzknbRPeb8PFPhwUtn7ifW6sePg5jM0wvfu0tM3toGeAmRTwQA3WA
         qM+YLiaKz97SliWHC6SUNW5GmZ625q+8y6e5CPvhOuDIvcV9xhNz0rsqWhNUbz+aTE50
         PNGE3IyLV7nwcpf10cg78FJ26zlBBiZAKOCa3NC1/gll4+XAXo17XdnibkMuYI9zvg1q
         3Le4b+D2Zr4gIUSZPG4f/YUPfPu/B1Lw54nMHhZbRMP+H0QlPnPkgaBpH8Tssvbv/93+
         q7SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685088765; x=1687680765;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQNRjhK3jlaLYFDGbUON4IVN8F+sSVQXRFYbktw9Bqw=;
        b=WYDEd7S1J2nl0upRkMp9OlCZMyP7gPJIL2QGpuWqbNQlW77QNLbRzCIFSA3WV4Lm1B
         TEUr1yGQ6gDdrP6e6Vm10A4YrfwhjvPKCzefrUD8HqBglgeYF5aP08G0LVaPVwaDM/Rg
         9g3vDxtiwFsNP/6eTkE5GJyh/pJyyWdEcXOm9rDKnoPHUsqYpOC/gv5/fFctOkBpr/nZ
         aZOc+jRZkJeD45uVHj7TknY4/a4wL6j51NHz2At4Tgi+35m1pJCx7sc7K6lqnxN/FK+5
         dOYJAI6dpf/+UHndnnrPP0kcBO4whRJvPPG4rDPbGzpkjg4+rHev9SCHzUuKhQ9mDUPv
         hvHg==
X-Gm-Message-State: AC+VfDwO9T4IrCQhQEXAAyae4n+Gn7IYGqZQE5JFnfdo3Pd9+yk5FuBK
        g55QXXxLYJe7LbV5SqGC394=
X-Google-Smtp-Source: ACHHUZ5+6bk9eUeMhvmG1njF28MYQkY/8d5vrsHCWk2yqoDh7SowQtY1F0FNyPmvYHsGjgcAqlnMbw==
X-Received: by 2002:a7b:cbc8:0:b0:3f6:464:4b32 with SMTP id n8-20020a7bcbc8000000b003f604644b32mr677742wmi.13.1685088765148;
        Fri, 26 May 2023 01:12:45 -0700 (PDT)
Received: from localhost (host81-154-179-160.range81-154.btcentralplus.com. [81.154.179.160])
        by smtp.gmail.com with ESMTPSA id c22-20020a7bc016000000b003f4285629casm4325988wmb.42.2023.05.26.01.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 01:12:44 -0700 (PDT)
Date:   Fri, 26 May 2023 09:10:33 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH v2 1/3] mm: Don't pin ZERO_PAGE in pin_user_pages()
Message-ID: <89c7f535-8fc5-4480-845f-de94f335d332@lucifer.local>
References: <20230525223953.225496-1-dhowells@redhat.com>
 <20230525223953.225496-2-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525223953.225496-2-dhowells@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 25, 2023 at 11:39:51PM +0100, David Howells wrote:
> Make pin_user_pages*() leave a ZERO_PAGE unpinned if it extracts a pointer
> to it from the page tables and make unpin_user_page*() correspondingly
> ignore a ZERO_PAGE when unpinning.  We don't want to risk overrunning a
> zero page's refcount as we're only allowed ~2 million pins on it -
> something that userspace can conceivably trigger.

I guess we're not quite as concerned about FOLL_GET because FOLL_GET should
be ephemeral and FOLL_PIN (horrifically) adds GUP_PIN_COUNTING_BIAS each
time?

>
> Add a pair of functions to test whether a page or a folio is a ZERO_PAGE.
>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Christoph Hellwig <hch@infradead.org>
> cc: David Hildenbrand <david@redhat.com>
> cc: Andrew Morton <akpm@linux-foundation.org>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: Al Viro <viro@zeniv.linux.org.uk>
> cc: Matthew Wilcox <willy@infradead.org>
> cc: Jan Kara <jack@suse.cz>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: Jason Gunthorpe <jgg@nvidia.com>
> cc: Logan Gunthorpe <logang@deltatee.com>
> cc: Hillf Danton <hdanton@sina.com>
> cc: Christian Brauner <brauner@kernel.org>
> cc: Linus Torvalds <torvalds@linux-foundation.org>
> cc: linux-fsdevel@vger.kernel.org
> cc: linux-block@vger.kernel.org
> cc: linux-kernel@vger.kernel.org
> cc: linux-mm@kvack.org
> ---
>
> Notes:
>     ver #2)
>      - Fix use of ZERO_PAGE().
>      - Add is_zero_page() and is_zero_folio() wrappers.
>      - Return the zero page obtained, not ZERO_PAGE(0) unconditionally.
>
>  include/linux/pgtable.h | 10 ++++++++++
>  mm/gup.c                | 25 ++++++++++++++++++++++++-
>  2 files changed, 34 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index c5a51481bbb9..2b0431a11de2 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -1245,6 +1245,16 @@ static inline unsigned long my_zero_pfn(unsigned long addr)
>  }
>  #endif /* CONFIG_MMU */
>
> +static inline bool is_zero_page(const struct page *page)
> +{
> +	return is_zero_pfn(page_to_pfn(page));
> +}
> +
> +static inline bool is_zero_folio(const struct folio *folio)
> +{
> +	return is_zero_page(&folio->page);
> +}
> +
>  #ifdef CONFIG_MMU
>
>  #ifndef CONFIG_TRANSPARENT_HUGEPAGE
> diff --git a/mm/gup.c b/mm/gup.c
> index bbe416236593..69b002628f5d 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -51,7 +51,8 @@ static inline void sanity_check_pinned_pages(struct page **pages,
>  		struct page *page = *pages;
>  		struct folio *folio = page_folio(page);
>
> -		if (!folio_test_anon(folio))
> +		if (is_zero_page(page) ||
> +		    !folio_test_anon(folio))
>  			continue;
>  		if (!folio_test_large(folio) || folio_test_hugetlb(folio))
>  			VM_BUG_ON_PAGE(!PageAnonExclusive(&folio->page), page);
> @@ -131,6 +132,13 @@ struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags)
>  	else if (flags & FOLL_PIN) {
>  		struct folio *folio;
>
> +		/*
> +		 * Don't take a pin on the zero page - it's not going anywhere
> +		 * and it is used in a *lot* of places.
> +		 */
> +		if (is_zero_page(page))
> +			return page_folio(page);
> +

This will capture huge page cases too which have folio->_pincount and thus
don't suffer the GUP_PIN_COUNTING_BIAS issue, however it is equally logical
to simply skip these when pinning.

This does make me think that we should just skip pinning for FOLL_GET cases
too - there's literally no sane reason we should be pinning zero pages in
any case (unless I'm missing something!)

>  		/*
>  		 * Can't do FOLL_LONGTERM + FOLL_PIN gup fast path if not in a
>  		 * right zone, so fail and let the caller fall back to the slow
> @@ -180,6 +188,8 @@ struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags)
>  static void gup_put_folio(struct folio *folio, int refs, unsigned int flags)
>  {
>  	if (flags & FOLL_PIN) {
> +		if (is_zero_folio(folio))
> +			return;
>  		node_stat_mod_folio(folio, NR_FOLL_PIN_RELEASED, refs);
>  		if (folio_test_large(folio))
>  			atomic_sub(refs, &folio->_pincount);
> @@ -224,6 +234,13 @@ int __must_check try_grab_page(struct page *page, unsigned int flags)
>  	if (flags & FOLL_GET)
>  		folio_ref_inc(folio);
>  	else if (flags & FOLL_PIN) {
> +		/*
> +		 * Don't take a pin on the zero page - it's not going anywhere
> +		 * and it is used in a *lot* of places.
> +		 */
> +		if (is_zero_page(page))
> +			return 0;
> +
>  		/*
>  		 * Similar to try_grab_folio(): be sure to *also*
>  		 * increment the normal page refcount field at least once,
> @@ -3079,6 +3096,9 @@ EXPORT_SYMBOL_GPL(get_user_pages_fast);
>   *
>   * FOLL_PIN means that the pages must be released via unpin_user_page(). Please
>   * see Documentation/core-api/pin_user_pages.rst for further details.
> + *
> + * Note that if the zero_page is amongst the returned pages, it will not have
> + * pins in it and unpin_user_page() will not remove pins from it.
>   */
>  int pin_user_pages_fast(unsigned long start, int nr_pages,
>  			unsigned int gup_flags, struct page **pages)
> @@ -3161,6 +3181,9 @@ EXPORT_SYMBOL(pin_user_pages);
>   * pin_user_pages_unlocked() is the FOLL_PIN variant of
>   * get_user_pages_unlocked(). Behavior is the same, except that this one sets
>   * FOLL_PIN and rejects FOLL_GET.
> + *
> + * Note that if the zero_page is amongst the returned pages, it will not have
> + * pins in it and unpin_user_page() will not remove pins from it.
>   */
>  long pin_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
>  			     struct page **pages, unsigned int gup_flags)
>

Shouldn't this comment be added to pup() and pup_remote() also? Also I
think it's well worth updating Documentation/core-api/pin_user_pages.rst to
reflect this as that is explclitly referenced by a few comments and it's a
worthwhile corner case to cover.

Another nitty thing that I noticed is, in is_longterm_pinnable_page():-

	/* The zero page may always be pinned */
	if (is_zero_pfn(page_to_pfn(page)))
		return true;

Which, strictly speaking I suppose we are 'pinning' it or rather allowing
the pin to succeed without actually pinning, but to be super pedantic
perhaps it's worth updating this comment too.

Other than the pedantic nits, this patch looks good and makes a lot of
sense so:-

Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
