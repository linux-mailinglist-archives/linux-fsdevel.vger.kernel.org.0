Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43D4C7A200E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 15:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235452AbjIONpM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 09:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235355AbjIONpL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 09:45:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FFD10D;
        Fri, 15 Sep 2023 06:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jxXdIOJ+m4CtsjucCCh39wV02TblO2va85pXUJ/Yaxs=; b=CTCz3ai5firDQReWo5r4TuUiQ5
        kXQQkghy72n5L1ex9TNzv7XVPoz7XD1X/f4lUJw6/m0VHAYNSn4JFAZdNIg63Iw0KrL7KWX3vcgAx
        336pifuSjH+xM+zHDElonJnmXzzpuBlrs5mnC8uUqMiByFLIra2P6PhSwdcj8kw9DqYFwT2mWN60c
        rjdTqjQdO3DCAiPOHCcaZ+264z9lBI1+gwt6DAWEvcjr6IY9u/XyP7zThcu4f35rOUVTHaONEnXzL
        vqVWgPjQFWsYclK8Ujfwc0jZPFSB/w80mArxsYa6YL6oS1PNSCORzHNNh5lBGLJ5Z/5BF0wT72g/T
        Jr9A9NWQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qh97y-00A1dO-Lq; Fri, 15 Sep 2023 13:44:58 +0000
Date:   Fri, 15 Sep 2023 14:44:58 +0100
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
Subject: Re: [PATCH 3/6] shmem: account for large order folios
Message-ID: <ZQRf2pGWurrE0uO+@casper.infradead.org>
References: <20230915095042.1320180-1-da.gomez@samsung.com>
 <CGME20230915095128eucas1p2885c3add58d82413d9c1d17832d3d281@eucas1p2.samsung.com>
 <20230915095042.1320180-4-da.gomez@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915095042.1320180-4-da.gomez@samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 15, 2023 at 09:51:26AM +0000, Daniel Gomez wrote:
> +	xas_for_each(&xas, folio, max) {
> +		if (xas_retry(&xas, folio))
>  			continue;
> -		if (xa_is_value(page))
> -			swapped++;
> +		if (xa_is_value(folio))
> +			swapped += (folio_nr_pages(folio));

Unnecessary parens.

> @@ -1006,10 +1006,12 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
>  			folio = fbatch.folios[i];
>  
>  			if (xa_is_value(folio)) {
> +				long swaps_freed;
>  				if (unfalloc)
>  					continue;
> -				nr_swaps_freed += !shmem_free_swap(mapping,
> -							indices[i], folio);
> +				swaps_freed = folio_nr_pages(folio);
> +				if (!shmem_free_swap(mapping, indices[i], folio))
> +					nr_swaps_freed += swaps_freed;

Broader change (indeed, in a separate patch), why not make
shmem_free_swap() return the number of pages freed, rather than
returning an errno?

> @@ -1075,14 +1077,16 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
>  			folio = fbatch.folios[i];
>  
>  			if (xa_is_value(folio)) {
> +				long swaps_freed;
>  				if (unfalloc)
>  					continue;
> +				swaps_freed = folio_nr_pages(folio);
>  				if (shmem_free_swap(mapping, indices[i], folio)) {
>  					/* Swap was replaced by page: retry */
>  					index = indices[i];
>  					break;
>  				}
> -				nr_swaps_freed++;
> +				nr_swaps_freed += swaps_freed;
>  				continue;

... seems like both callers would prefer that.

