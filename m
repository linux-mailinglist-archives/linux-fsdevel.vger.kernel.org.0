Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B345C5FBF0B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Oct 2022 04:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiJLCK2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Oct 2022 22:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJLCK1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Oct 2022 22:10:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A7958B76;
        Tue, 11 Oct 2022 19:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ltf4dJuknYq1aeSDzdYdSUaogV1udCGybDwY678E2LY=; b=U/HGBGDTDewxLUAi+ooNbqbX3D
        nczouEN7D5OJRiJTSnegeHyJPTZDNHcEHZp3fM4+RR3wtLu66MIMXovJcy/vAU1VeVpEO5uY7AGWK
        6u1T4RFsrVES1SNa6YmBxXwFOORtwxrDkjUkTHAStlhDePZSNKl/vaSNzUzaMzzcjJ3kAX0YoQMJv
        RB29NaI+w0yP1KZrPc5PBYPvgt4TMICXovXNFSrnDZADfw2NSQnD1I+IaPqsHimf16AxO+lBs4DNL
        r7uNPD/gz9v9VXhMpl7tY1w8WGe89A03K4PMxtOEb6ZR99nGDU4ncua1+am3lMzWCqnT+BaQBWcm6
        EoNkPBzg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oiRCU-005TLD-Hh; Wed, 12 Oct 2022 02:10:26 +0000
Date:   Wed, 12 Oct 2022 03:10:26 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc:     akpm@linux-foundation.org, hughd@google.com,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] filemap: find_lock_entries() now updates start offset
Message-ID: <Y0YiEon0G3b/00dG@casper.infradead.org>
References: <20221011215634.478330-1-vishal.moola@gmail.com>
 <20221011215634.478330-2-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221011215634.478330-2-vishal.moola@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 11, 2022 at 02:56:31PM -0700, Vishal Moola (Oracle) wrote:
> @@ -2116,7 +2118,16 @@ unsigned find_lock_entries(struct address_space *mapping, pgoff_t start,
>  		folio_put(folio);
>  	}
>  	rcu_read_unlock();
> +	nr = folio_batch_count(fbatch);
> +
> +	if (nr) {
> +		folio = fbatch->folios[nr - 1];
> +		nr = folio_nr_pages(folio);
>  
> +		if (folio_test_hugetlb(folio))
> +			nr = 1;
> +		*start = folio->index + nr;
> +	}

Hmm ... this is going to go wrong if the folio is actually a shadow
entry, isn't it?

> +++ b/mm/shmem.c
> @@ -922,21 +922,18 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
>  
>  	folio_batch_init(&fbatch);
>  	index = start;
> -	while (index < end && find_lock_entries(mapping, index, end - 1,
> +	while (index < end && find_lock_entries(mapping, &index, end - 1,
>  			&fbatch, indices)) {
>  		for (i = 0; i < folio_batch_count(&fbatch); i++) {
>  			folio = fbatch.folios[i];
>  
> -			index = indices[i];
> -
>  			if (xa_is_value(folio)) {
>  				if (unfalloc)
>  					continue;
>  				nr_swaps_freed += !shmem_free_swap(mapping,
> -								index, folio);
> +							folio->index, folio);

We know this is a value entry, so we definitely can't look at
folio->index.  This should probably be:

+							indices[i], folio);

> @@ -510,20 +509,18 @@ unsigned long invalidate_mapping_pagevec(struct address_space *mapping,
>  	int i;
>  
>  	folio_batch_init(&fbatch);
> -	while (find_lock_entries(mapping, index, end, &fbatch, indices)) {
> +	while (find_lock_entries(mapping, &index, end, &fbatch, indices)) {
>  		for (i = 0; i < folio_batch_count(&fbatch); i++) {
>  			struct folio *folio = fbatch.folios[i];
>  
>  			/* We rely upon deletion not changing folio->index */
> -			index = indices[i];
>  
>  			if (xa_is_value(folio)) {
>  				count += invalidate_exceptional_entry(mapping,
> -								      index,
> -								      folio);
> +								  folio->index,
> +								  folio);

Same here.  I'd fix the indent while you're at it to get more on that
second line and not need a third line.

