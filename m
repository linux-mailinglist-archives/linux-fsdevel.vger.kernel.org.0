Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B884A7A6760
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 16:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbjISO4U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 10:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232939AbjISO4T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 10:56:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835CFBC;
        Tue, 19 Sep 2023 07:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2GQeIiRUKD4nsrNUykiLVbM9yjvFtlWyxIuMA0styQw=; b=mYXMTEUYvjYarfrIoWNE1eWN5R
        8WwC95BlE+kx6ltsaGQakYglIP1k6qMTH6MOj88Wov1/go+LalpF9lxPFjXvwvKc589jM3dHlxOZx
        UVq2shksI+3BvJStlyR0SUnSYBrEclR1IrnZMoHjXxboY49+wFfZsV3HJLDJmtE1cTEUqJOBs6NxO
        hEGDK4E0yztgTsON2dYq5ZW3NkBrAeiGfaLWNmeRtWzYVcTVAd02a8RnhOiE/gkrLOtajXEnwLGEI
        C7UZYmCokNtEysQXI6F+1F8/fDohbsnnUCKv0Q+EXMs1sHEmCVAxSGxJwtGDkPY26nXkC1B/vP9FV
        wf1C1G/A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qic8y-000DqW-3x; Tue, 19 Sep 2023 14:56:04 +0000
Date:   Tue, 19 Sep 2023 15:56:04 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Daniel Gomez <da.gomez@samsung.com>
Cc:     "minchan@kernel.org" <minchan@kernel.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "hughd@google.com" <hughd@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v2 2/6] shmem: return freed pages in shmem_free_swap
Message-ID: <ZQm2hIj7W1kJ8C7n@casper.infradead.org>
References: <20230919135536.2165715-1-da.gomez@samsung.com>
 <CGME20230919135549eucas1p1f67e7879a14a87724a9462fb8dd635bf@eucas1p1.samsung.com>
 <20230919135536.2165715-3-da.gomez@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919135536.2165715-3-da.gomez@samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 19, 2023 at 01:55:47PM +0000, Daniel Gomez wrote:
> +++ b/mm/shmem.c
> @@ -846,16 +846,18 @@ static void shmem_delete_from_page_cache(struct folio *folio, void *radswap)
>  /*
>   * Remove swap entry from page cache, free the swap and its page cache.
>   */
> -static int shmem_free_swap(struct address_space *mapping,
> +static long shmem_free_swap(struct address_space *mapping,
>  			   pgoff_t index, void *radswap)
>  {
>  	void *old;
>  
>  	old = xa_cmpxchg_irq(&mapping->i_pages, index, radswap, NULL, 0);
>  	if (old != radswap)
> -		return -ENOENT;
> +		return 0;
> +
>  	free_swap_and_cache(radix_to_swp_entry(radswap));
> -	return 0;
> +
> +	return folio_nr_pages((struct folio *)radswap);
>  }

Oh my goodness.  I have led you astray; my apologies.

shmem_free_swap() is called when the 'folio' is NOT actually a folio.
It's an 'exceptional' / 'value' entry.  We can't do this.

Do we encode the size of the swap entry in the swp_entry_t or do
we have to get that information from the XArray (which no longer
knows it after we've stored a NULL there)?

