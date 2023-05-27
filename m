Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF31713646
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 May 2023 21:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbjE0TqM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 May 2023 15:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjE0TqK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 May 2023 15:46:10 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2354BE;
        Sat, 27 May 2023 12:46:04 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3093d10442aso1117690f8f.1;
        Sat, 27 May 2023 12:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685216763; x=1687808763;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yScXvAOo/xUmomxE33DkwJiq9zbdLwNtpoWsDl3jelk=;
        b=gcr+i/Oe2B/fp27UmbsngDZwfGTLNeLqWKY5Gxg7SD/h4R7bkbR9gSYMnb3GG+4/GA
         xg5Th5Kjpje2q0zbpBKEblCxios13UBcRT6/lYgYw221LcSV5g2Z7kWwiL8+cuF8KT/I
         Q4PUbQYuI8LTmRMNTj8eRBkNXVNRBVFaZtLWAztiv4G/1mIvO6nBjLa/6O0OC3jeZ6mp
         PM87Vo+eBj2sr1lJzHeGnOHb5HV5umbeOMhXcVDrd2M6GPjkHcawsRu79fyYkZIeNhH2
         tq7RRqppBi7g+cs3jNZEWXIfbWpp5nYwo+YybNFvNEr/CsDOXEYu5ofn82CZM5WjUj3Z
         orTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685216763; x=1687808763;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yScXvAOo/xUmomxE33DkwJiq9zbdLwNtpoWsDl3jelk=;
        b=KBTLD8A5+YCGvm3cw9xShENiQTy+cneLrYZ2MpQNJ+AaE1sOlMeg9LLbUbp5sUn2Dr
         cL+pVOi8gUbgjZLppnOZARfysLl2BB8EqLQNF9255QdwylooRfMBeldOSJJIsoaoXKeA
         NwQFFoTuYIzSeOaY8Eqjt5y7bA5tjDMlp7/PKDvIQxMWSI6V6QAKoLSoB8NF1ao2y8xU
         NtL1KDwUym5Evr3pCmdtxicFCcS8GsRgEVfENeVCKhlyGdGvBFLqmj9Ien4YnUeVDBkR
         fKHe+FzeJDgPDGapEplXkkMotXq/t0gMxqtV/yGGXM295oXN4neoTiPh3zNZeCjZwW1a
         Gskw==
X-Gm-Message-State: AC+VfDyfme51eW0qagrIjFwv9l6981PLETeu1C7K5TdPWsDy02IfoRLQ
        PT3eMaY06Ry4wCAk840LGcs=
X-Google-Smtp-Source: ACHHUZ6HI+9ndP9jA2w0d+e7jXcwjj7zyjBoMOcS+oeZ1wbojrMqinOs2X09wzBcOzCtDZ9DZNBguw==
X-Received: by 2002:a05:6000:11c4:b0:306:2fab:1f81 with SMTP id i4-20020a05600011c400b003062fab1f81mr4453730wrx.21.1685216763120;
        Sat, 27 May 2023 12:46:03 -0700 (PDT)
Received: from localhost (host81-154-179-160.range81-154.btcentralplus.com. [81.154.179.160])
        by smtp.gmail.com with ESMTPSA id u18-20020adfed52000000b003079986fd71sm8897412wro.88.2023.05.27.12.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 May 2023 12:46:02 -0700 (PDT)
Date:   Sat, 27 May 2023 20:46:01 +0100
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
Subject: Re: [PATCH v4 1/3] mm: Don't pin ZERO_PAGE in pin_user_pages()
Message-ID: <c6bfafa5-a4ba-477b-99a2-dd14a25fc634@lucifer.local>
References: <20230526214142.958751-1-dhowells@redhat.com>
 <20230526214142.958751-2-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526214142.958751-2-dhowells@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 26, 2023 at 10:41:40PM +0100, David Howells wrote:
> Make pin_user_pages*() leave a ZERO_PAGE unpinned if it extracts a pointer
> to it from the page tables and make unpin_user_page*() correspondingly
> ignore a ZERO_PAGE when unpinning.  We don't want to risk overrunning a
> zero page's refcount as we're only allowed ~2 million pins on it -
> something that userspace can conceivably trigger.
>
> Add a pair of functions to test whether a page or a folio is a ZERO_PAGE.
>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Christoph Hellwig <hch@infradead.org>
> cc: David Hildenbrand <david@redhat.com>
> cc: Lorenzo Stoakes <lstoakes@gmail.com>
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
>     ver #3)
>      - Move is_zero_page() and is_zero_folio() to mm.h for dependency reasons.
>      - Add more comments and adjust the docs.
>
>     ver #2)
>      - Fix use of ZERO_PAGE().
>      - Add is_zero_page() and is_zero_folio() wrappers.
>      - Return the zero page obtained, not ZERO_PAGE(0) unconditionally.
>
>  Documentation/core-api/pin_user_pages.rst |  6 +++++
>  include/linux/mm.h                        | 26 +++++++++++++++++--
>  mm/gup.c                                  | 31 ++++++++++++++++++++++-
>  3 files changed, 60 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/core-api/pin_user_pages.rst b/Documentation/core-api/pin_user_pages.rst
> index 9fb0b1080d3b..d3c1f6d8c0e0 100644
> --- a/Documentation/core-api/pin_user_pages.rst
> +++ b/Documentation/core-api/pin_user_pages.rst
> @@ -112,6 +112,12 @@ pages:
>  This also leads to limitations: there are only 31-10==21 bits available for a
>  counter that increments 10 bits at a time.
>
> +* Because of that limitation, special handling is applied to the zero pages
> +  when using FOLL_PIN.  We only pretend to pin a zero page - we don't alter its
> +  refcount or pincount at all (it is permanent, so there's no need).  The
> +  unpinning functions also don't do anything to a zero page.  This is
> +  transparent to the caller.
> +

Great! Cheers. :)

>  * Callers must specifically request "dma-pinned tracking of pages". In other
>    words, just calling get_user_pages() will not suffice; a new set of functions,
>    pin_user_page() and related, must be used.
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 27ce77080c79..3c2f6b452586 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1910,6 +1910,28 @@ static inline bool page_needs_cow_for_dma(struct vm_area_struct *vma,
>  	return page_maybe_dma_pinned(page);
>  }
>
> +/**
> + * is_zero_page - Query if a page is a zero page
> + * @page: The page to query
> + *
> + * This returns true if @page is one of the permanent zero pages.
> + */
> +static inline bool is_zero_page(const struct page *page)
> +{
> +	return is_zero_pfn(page_to_pfn(page));
> +}
> +
> +/**
> + * is_zero_folio - Query if a folio is a zero page
> + * @folio: The folio to query
> + *
> + * This returns true if @folio is one of the permanent zero pages.
> + */
> +static inline bool is_zero_folio(const struct folio *folio)
> +{
> +	return is_zero_page(&folio->page);
> +}
> +
>  /* MIGRATE_CMA and ZONE_MOVABLE do not allow pin pages */
>  #ifdef CONFIG_MIGRATION
>  static inline bool is_longterm_pinnable_page(struct page *page)
> @@ -1920,8 +1942,8 @@ static inline bool is_longterm_pinnable_page(struct page *page)
>  	if (mt == MIGRATE_CMA || mt == MIGRATE_ISOLATE)
>  		return false;
>  #endif
> -	/* The zero page may always be pinned */
> -	if (is_zero_pfn(page_to_pfn(page)))
> +	/* The zero page can be "pinned" but gets special handling. */
> +	if (is_zero_page(page))
>  		return true;
>
>  	/* Coherent device memory must always allow eviction. */
> diff --git a/mm/gup.c b/mm/gup.c
> index bbe416236593..ad28261dcafd 100644
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
> + * Note that if a zero_page is amongst the returned pages, it will not have
> + * pins in it and unpin_user_page() will not remove pins from it.
>   */
>  int pin_user_pages_fast(unsigned long start, int nr_pages,
>  			unsigned int gup_flags, struct page **pages)
> @@ -3110,6 +3130,9 @@ EXPORT_SYMBOL_GPL(pin_user_pages_fast);
>   *
>   * FOLL_PIN means that the pages must be released via unpin_user_page(). Please
>   * see Documentation/core-api/pin_user_pages.rst for details.
> + *
> + * Note that if a zero_page is amongst the returned pages, it will not have
> + * pins in it and unpin_user_page*() will not remove pins from it.
>   */
>  long pin_user_pages_remote(struct mm_struct *mm,
>  			   unsigned long start, unsigned long nr_pages,
> @@ -3143,6 +3166,9 @@ EXPORT_SYMBOL(pin_user_pages_remote);
>   *
>   * FOLL_PIN means that the pages must be released via unpin_user_page(). Please
>   * see Documentation/core-api/pin_user_pages.rst for details.
> + *
> + * Note that if a zero_page is amongst the returned pages, it will not have
> + * pins in it and unpin_user_page*() will not remove pins from it.
>   */
>  long pin_user_pages(unsigned long start, unsigned long nr_pages,
>  		    unsigned int gup_flags, struct page **pages,
> @@ -3161,6 +3187,9 @@ EXPORT_SYMBOL(pin_user_pages);
>   * pin_user_pages_unlocked() is the FOLL_PIN variant of
>   * get_user_pages_unlocked(). Behavior is the same, except that this one sets
>   * FOLL_PIN and rejects FOLL_GET.
> + *
> + * Note that if a zero_page is amongst the returned pages, it will not have
> + * pins in it and unpin_user_page*() will not remove pins from it.
>   */
>  long pin_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
>  			     struct page **pages, unsigned int gup_flags)
>

All looks good, thanks for adding comments/updating doc!

Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
