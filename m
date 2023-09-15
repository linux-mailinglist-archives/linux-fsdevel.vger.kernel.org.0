Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B797A26BE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 21:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236848AbjIOTAS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 15:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236897AbjIOTAO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 15:00:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58540B2;
        Fri, 15 Sep 2023 12:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3p6LB8CUVtVpbNZXHYcZX6Y+ucECGrNpDuWVv6vgFXg=; b=dNxhWAjfCz0PbN7mvJZP6JwFY5
        5fCPxIkPJOoCSBE85XQGJvvRkZC2/YAQxa/+f5Vv6bKKfu81JKW58q9ZhErtujzXMWWsN3Y4vJ89O
        F2rAR1D6mK5LHeBUsq2HM/KUiCkia0SIHKzi4txeFdrF0AAwVO3ryczOHA8RNYzFyEySKyMs9ZaWN
        UZ2BzBig0eC0X9vDFqF2kHgJBmiU4+25LnK6Buvpm9KjqCath/hceLMcD7jqherGHfno4EW3liwgf
        KLVKD+FlFd6igEsNbCDpz7t5PFR56mmng7nwR+9R2NPGD9P9oMpAqrlCNKbiMMBjq2G5HSljBsQhu
        9GcC7+uQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qhE2w-00BSCj-T7; Fri, 15 Sep 2023 19:00:06 +0000
Date:   Fri, 15 Sep 2023 20:00:06 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Pankaj Raghav <kernel@pankajraghav.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        p.raghav@samsung.com, david@fromorbit.com, da.gomez@samsung.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        djwong@kernel.org, linux-mm@kvack.org, chandan.babu@oracle.com,
        mcgrof@kernel.org, gost.dev@samsung.com
Subject: Re: [RFC 03/23] filemap: add folio with at least mapping_min_order
 in __filemap_get_folio
Message-ID: <ZQSpthmXGzHDbx1h@casper.infradead.org>
References: <20230915183848.1018717-1-kernel@pankajraghav.com>
 <20230915183848.1018717-4-kernel@pankajraghav.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915183848.1018717-4-kernel@pankajraghav.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 15, 2023 at 08:38:28PM +0200, Pankaj Raghav wrote:
> +++ b/mm/filemap.c
> @@ -1862,6 +1862,10 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
>  		fgf_t fgp_flags, gfp_t gfp)
>  {
>  	struct folio *folio;
> +	int min_order = mapping_min_folio_order(mapping);
> +	int nr_of_pages = (1U << min_order);
> +
> +	index = round_down(index, nr_of_pages);
>  
>  repeat:
>  	folio = filemap_get_entry(mapping, index);
> @@ -1929,8 +1933,14 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
>  			err = -ENOMEM;
>  			if (order == 1)
>  				order = 0;
> +			if (order < min_order)
> +				order = min_order;

... oh, you do something similar here to what I recommend in my previous
response.  I don't understand why you need the previous patch.

> +			if (min_order)
> +				VM_BUG_ON(index & ((1UL << order) - 1));

You don't need the 'if' here; index & ((1 << 0) - 1) becomes false.

