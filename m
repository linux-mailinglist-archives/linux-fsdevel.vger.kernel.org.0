Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6894767DC1E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jan 2023 03:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbjA0CGw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 21:06:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233466AbjA0CGa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 21:06:30 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B320520D31
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jan 2023 18:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CCo6CcOIMdKlo3WLVq6nzoGfLepaU37Js9DWTNsO9Fw=; b=ZubqXbAX/iWh0ihOuMt9SDBHj2
        Pv4qOw9MHHh4xzYaqfKBBNsurvccE3kkKwwOPI4z/MmIuuhmfA9dL6LOSn2+VelWUoLq2PtvTPOI8
        I3v2bV6rP0Iqcb87QiPCDj4v1qfF6PrAfsTtV3qjDF9hpgOuF46hafn6pPSY2OzHhePBfUeRPeh38
        s0G09tEnelzytxV/uFfpJLq8isoxMbA4aJdJXXYipw9pN1JiJ/EU0GSkQUlU7/5r+FlOYMJ2rNSY7
        1v1O52xCcVoUIagGOnBs4q6+18YPV3aGran5zy2UdX/mabd062q1qfStpID6GgRAGwBCRkcNBBYgJ
        CyORKCgg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pLE6L-007H43-Fl; Fri, 27 Jan 2023 02:04:25 +0000
Date:   Fri, 27 Jan 2023 02:04:25 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] mm: Add memcpy_from_file_folio()
Message-ID: <Y9MxKclIVqHMvpmL@casper.infradead.org>
References: <20230126201552.1681588-1-willy@infradead.org>
 <20230126154152.898a1bdfd7d729627e2a6bf4@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126154152.898a1bdfd7d729627e2a6bf4@linux-foundation.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 26, 2023 at 03:41:52PM -0800, Andrew Morton wrote:
> > + * Return: The number of bytes copied from the folio.

> > +static inline size_t memcpy_from_file_folio(char *to, struct folio *folio,
> > +		loff_t pos, size_t len)
> > +{
> > +	size_t offset = offset_in_folio(folio, pos);
> > +	char *from = kmap_local_folio(folio, offset);
> > +
> > +	if (folio_test_highmem(folio))
> > +		len = min(len, PAGE_SIZE - offset);
> > +	else
> > +		len = min(len, folio_size(folio) - offset);
> 
> min() blows up on arm allnoconfig.
> 
> ./include/linux/highmem.h: In function 'memcpy_from_file_folio':
> ./include/linux/minmax.h:20:35: warning: comparison of distinct pointer types lacks a cast
>    20 |         (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
>       |                                   ^~
> ./include/linux/minmax.h:26:18: note: in expansion of macro '__typecheck'
>    26 |                 (__typecheck(x, y) && __no_side_effects(x, y))
>       |                  ^~~~~~~~~~~
> ./include/linux/minmax.h:36:31: note: in expansion of macro '__safe_cmp'
>    36 |         __builtin_choose_expr(__safe_cmp(x, y), \
>       |                               ^~~~~~~~~~
> ./include/linux/minmax.h:67:25: note: in expansion of macro '__careful_cmp'
>    67 | #define min(x, y)       __careful_cmp(x, y, <)
>       |                         ^~~~~~~~~~~~~
> ./include/linux/highmem.h:435:23: note: in expansion of macro 'min'
>   435 |                 len = min(len, PAGE_SIZE - offset);
>       |                       ^~~

Oh, right, PAGE_SIZE is size_t everywhere except on ARM.

> We could use min_t(), but perhaps and explanatorialy named variable is
> nicer?

But buggy because we return the number of bytes copied.

> --- a/include/linux/highmem.h~mm-add-memcpy_from_file_folio-fix
> +++ a/include/linux/highmem.h
> @@ -430,13 +430,14 @@ static inline size_t memcpy_from_file_fo
>  {
>  	size_t offset = offset_in_folio(folio, pos);
>  	char *from = kmap_local_folio(folio, offset);
> +	size_t remaining;
>  
>  	if (folio_test_highmem(folio))
> -		len = min(len, PAGE_SIZE - offset);
> +		remaining = PAGE_SIZE - offset;
>  	else
> -		len = min(len, folio_size(folio) - offset);
> +		remaining = folio_size(folio) - offset;

I don't think remaining is a great name for this.  The key thing is
that for any platform we care about folio_test_highmem() is constant false,
so this just optimises away the min() call.

You could salvage this approach by doing

	len = min(remaining, len);
	memcpy(to, from, len);
	return len;

but I think it's probably better to just do min_t on the PAGE_SIZE line.
Stupid ARM.

> -	memcpy(to, from, len);
> +	memcpy(to, from, min(len, remaining));
>  	kunmap_local(from);
>  
>  	return len;
> _
> 
