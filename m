Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D7E4C3AFC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Feb 2022 02:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234976AbiBYBbn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Feb 2022 20:31:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbiBYBbm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Feb 2022 20:31:42 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656E92692F5
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Feb 2022 17:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bxUWNXJPmP2dqlG2R2ijTql/9SV3EFcmDkRPpJMxdmc=; b=Dhqn5x9/achbCcLtY66/uH3rnd
        tvCnjubomQ8obLO2PVh1TI/iUgi1WwXCjtCksCpIh8ObCEyqORtZxFgYH0y3vKr2tb3nxQH0iF9xJ
        8Dxyc2zE0DhBofYkEgsc9/RWI9NJDSR5BP/fry0CcQl/ZdDMfJPE5YjJAyH2Dftyt/cOw8xbd8lIa
        waajnOcjc7foaCSteCPjqJYIDV6fTD0GEIS/yVlkn0WSv4OGHfKULCDOT1GYQhUq49sIWaXBmFRi5
        ehc91XPgNi7JWaHPMiFtzYNT0N0jCViKssxzh6xfPFQjgfMnz9tDYyzc4ziXUjZKYePGAphyFgMrM
        ABrAZ2tQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nNPRt-005LW0-FA; Fri, 25 Feb 2022 01:31:09 +0000
Date:   Fri, 25 Feb 2022 01:31:09 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 04/10] mm/truncate: Replace page_mapped() call in
 invalidate_inode_page()
Message-ID: <YhgxXaDKX415lBlW@casper.infradead.org>
References: <20220214200017.3150590-1-willy@infradead.org>
 <20220214200017.3150590-5-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214200017.3150590-5-willy@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 14, 2022 at 08:00:11PM +0000, Matthew Wilcox (Oracle) wrote:
> folio_mapped() is expensive because it has to check each page's mapcount
> field.  A cheaper check is whether there are any extra references to
> the page, other than the one we own and the ones held by the page cache.
> The call to remove_mapping() will fail in any case if it cannot freeze
> the refcount, but failing here avoids cycling the i_pages spinlock.

This is the patch that's causing ltp's readahead02 test to break.
Haven't dug into why yet, but it happens without large folios, so
I got something wrong.

> diff --git a/mm/truncate.c b/mm/truncate.c
> index b73c30c95cd0..d67fa8871b75 100644
> --- a/mm/truncate.c
> +++ b/mm/truncate.c
> @@ -287,7 +287,7 @@ int invalidate_inode_page(struct page *page)
>  		return 0;
>  	if (folio_test_dirty(folio) || folio_test_writeback(folio))
>  		return 0;
> -	if (page_mapped(page))
> +	if (folio_ref_count(folio) > folio_nr_pages(folio) + 1)
>  		return 0;
>  	if (folio_has_private(folio) && !filemap_release_folio(folio, 0))
>  		return 0;
> -- 
> 2.34.1
> 
