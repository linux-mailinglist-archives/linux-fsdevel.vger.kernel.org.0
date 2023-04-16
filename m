Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8BC6E3B99
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Apr 2023 21:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjDPTpB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Apr 2023 15:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjDPTo7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Apr 2023 15:44:59 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBE426B7
        for <linux-fsdevel@vger.kernel.org>; Sun, 16 Apr 2023 12:44:58 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-54ee0b73e08so401417507b3.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 16 Apr 2023 12:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681674296; x=1684266296;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fE9QU8ssRHfrkp+Qs6Jt2adPN0B10qQBjFxitvUur5w=;
        b=pTFh9YoYONT2cKveKNA6jETiwf92HtqU0CX8Fb+eU6YKNATL4+NSIe9LuB571YVQQ2
         FvSwcvWgTww19tc9Rn0y+4sCK5LZLj6N0yzT1FA5tlasgFfufKUaYPfhYO9DEP9ZDcYL
         HchzUVzvPelw0Q4huckH+4NhHZRPQrzs+FZc7TS9g0u1uCXZ7Gh7Rx0t1vw6xeO3fjB1
         ias0ybZKgaEzEMgV3MEOgwIBoeyu5n0/3eqYzjsLLft3tmdEYqDpNZ5I986azDXD11KD
         q/h6ljYEwHQnadmPQUM7nqloQwRDf9UjRpTnWnfKFqeIYHT89pXApVgoyTjabBqFP5wG
         a3Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681674296; x=1684266296;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fE9QU8ssRHfrkp+Qs6Jt2adPN0B10qQBjFxitvUur5w=;
        b=KlBt1ZNctEZC9Un5LoYwHqMrVQfQ4p5DQnY3zWW8W/nABY2zzPZ5rkI40h+R9U1CKh
         6mTbvxCCN47abS/TMEOuFdPx/adRW9cJyQOEvf+jR54ADBSmy0FwcIzp7V2PMsc7QtP3
         2FrRZ8tKnCvj7qUrXGJV2Dbeyt7nalSSNqQAtMkKTAb5YlwOb5xTdkDJo20GprW5aaza
         srW9VCFbxhr0J8RH3onWIgTijFVriQMJPZ3YPoscwHe6My8fxae+mSzDDFte+dRu/rja
         QyGhVbP2sCgjN9tCrtXGHUg6jixGhO97i04aAq2v/OkXRiMzj7cEcrsbQFO1JLh6OHMB
         QanQ==
X-Gm-Message-State: AAQBX9dZBr/1OK+2oCn/Or6/z8mNT9STjzLuS8jCaHi8YJn2rmVqrcGa
        g7+xRe3lrElez5vQJZfm+FFdBQ==
X-Google-Smtp-Source: AKy350YDG3M9wmj9++Fuic4VEWPyfPHGcxyaI9iRZK4qaFSHnn38pvTPQQqEXoMJ3JmakygaSbceaA==
X-Received: by 2002:a81:7782:0:b0:543:b06a:19de with SMTP id s124-20020a817782000000b00543b06a19demr12158258ywc.3.1681674295681;
        Sun, 16 Apr 2023 12:44:55 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id b186-20020a811bc3000000b0054eff15530asm2650453ywb.90.2023.04.16.12.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 12:44:55 -0700 (PDT)
Date:   Sun, 16 Apr 2023 12:44:53 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Zi Yan <ziy@nvidia.com>
cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>, Yu Zhao <yuzhao@google.com>,
        linux-mm@kvack.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        =?ISO-8859-15?Q?Michal_Koutn=FD?= <mkoutny@suse.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Zach O'Keefe <zokeefe@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 6/7] mm: truncate: split huge page cache page to a
 non-zero order if possible.
In-Reply-To: <20230403201839.4097845-7-zi.yan@sent.com>
Message-ID: <9dd96da-efa2-5123-20d4-4992136ef3ad@google.com>
References: <20230403201839.4097845-1-zi.yan@sent.com> <20230403201839.4097845-7-zi.yan@sent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 3 Apr 2023, Zi Yan wrote:

> From: Zi Yan <ziy@nvidia.com>
> 
> To minimize the number of pages after a huge page truncation, we do not
> need to split it all the way down to order-0. The huge page has at most
> three parts, the part before offset, the part to be truncated, the part
> remaining at the end. Find the greatest common divisor of them to
> calculate the new page order from it, so we can split the huge
> page to this order and keep the remaining pages as large and as few as
> possible.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>  mm/truncate.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/truncate.c b/mm/truncate.c
> index 86de31ed4d32..817efd5e94b4 100644
> --- a/mm/truncate.c
> +++ b/mm/truncate.c
> @@ -22,6 +22,7 @@
>  #include <linux/buffer_head.h>	/* grr. try_to_release_page */
>  #include <linux/shmem_fs.h>
>  #include <linux/rmap.h>
> +#include <linux/gcd.h>

Really?

>  #include "internal.h"
>  
>  /*
> @@ -211,7 +212,8 @@ int truncate_inode_folio(struct address_space *mapping, struct folio *folio)
>  bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
>  {
>  	loff_t pos = folio_pos(folio);
> -	unsigned int offset, length;
> +	unsigned int offset, length, remaining;
> +	unsigned int new_order = folio_order(folio);
>  
>  	if (pos < start)
>  		offset = start - pos;
> @@ -222,6 +224,7 @@ bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
>  		length = length - offset;
>  	else
>  		length = end + 1 - pos - offset;
> +	remaining = folio_size(folio) - offset - length;
>  
>  	folio_wait_writeback(folio);
>  	if (length == folio_size(folio)) {
> @@ -236,11 +239,25 @@ bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
>  	 */
>  	folio_zero_range(folio, offset, length);
>  
> +	/*
> +	 * Use the greatest common divisor of offset, length, and remaining
> +	 * as the smallest page size and compute the new order from it. So we
> +	 * can truncate a subpage as large as possible. Round up gcd to
> +	 * PAGE_SIZE, otherwise ilog2 can give -1 when gcd/PAGE_SIZE is 0.
> +	 */
> +	new_order = ilog2(round_up(gcd(gcd(offset, length), remaining),
> +				   PAGE_SIZE) / PAGE_SIZE);

Gosh.  In mm/readahead.c I can see "order = __ffs(index)",
and I think something along those lines would be more appropriate here.

But, if there's any value at all to choosing intermediate orders here in
truncation, I don't think choosing a single order is the right approach -
more easily implemented, yes, but is it worth doing?

What you'd actually want (if anything) is to choose the largest orders
possible, with smaller and smaller orders filling in the rest (I expect
there's a technical name for this, but I don't remember - bin packing
is something else, I think).

As this code stands, truncate a 2M huge page at 1M and you get two 1M
pieces (one then discarded) - nice; but truncate it at 1M+1 and you get
lots of order 2 (forced up from 1) pieces.  Seems weird, and not worth
the effort.

Hugh

> +
> +	/* order-1 THP not supported, downgrade to order-0 */
> +	if (new_order == 1)
> +		new_order = 0;
> +
> +
>  	if (folio_has_private(folio))
>  		folio_invalidate(folio, offset, length);
>  	if (!folio_test_large(folio))
>  		return true;
> -	if (split_folio(folio) == 0)
> +	if (split_huge_page_to_list_to_order(&folio->page, NULL, new_order) == 0)
>  		return true;
>  	if (folio_test_dirty(folio))
>  		return false;
> -- 
> 2.39.2
