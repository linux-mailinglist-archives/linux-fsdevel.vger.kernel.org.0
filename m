Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E128E67DCCB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jan 2023 05:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbjA0EPK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 23:15:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbjA0EPI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 23:15:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870B72202E;
        Thu, 26 Jan 2023 20:15:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2158D61967;
        Fri, 27 Jan 2023 04:15:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50197C433D2;
        Fri, 27 Jan 2023 04:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674792906;
        bh=I/iWNTCtJPDBT/oGNlsjYsZBT7qI9NV3uq0HE7DGgoA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A0J3NNHqQL0lSV+wChX1Kobcdv8/uwonrq6YSZa3nCIdX5CMB5M79S2gggBg9yPQY
         3WTeE4ldbGCs0NQ0z0Qs9CZKMNcwqkzUlFvdxEETqKiXEynxNQIEHBmrUQgCP/1Dcr
         OrURHJOxZ3Rpvb62ON02zPud4CC4SWn8/8LahLv39f3T4Si879uussUlMoIcZ1EAzI
         nHFYyiRpRtnKC1g82icp3Y8Ooknv1jt7Rf7iiVQMSRdV26pcMmHlzqsZwk02LQP4Eo
         XbQu9C1N6xk8LmcYltvmrDa9fg1ngACBV0au5OJaPEaKUMrmgmQ8PvgjYyZx77pYvq
         2i0S87pJ88M8Q==
Date:   Thu, 26 Jan 2023 20:15:04 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Theodore Tso <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 24/31] ext4: Convert ext4_mpage_readpages() to work on
 folios
Message-ID: <Y9NPyMThUWG5hxX6@sol.localdomain>
References: <20230126202415.1682629-1-willy@infradead.org>
 <20230126202415.1682629-25-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126202415.1682629-25-willy@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 26, 2023 at 08:24:08PM +0000, Matthew Wilcox (Oracle) wrote:
>  int ext4_mpage_readpages(struct inode *inode,
> -		struct readahead_control *rac, struct page *page)
> +		struct readahead_control *rac, struct folio *folio)
>  {
>  	struct bio *bio = NULL;
>  	sector_t last_block_in_bio = 0;
> @@ -247,16 +247,15 @@ int ext4_mpage_readpages(struct inode *inode,
>  		int fully_mapped = 1;
>  		unsigned first_hole = blocks_per_page;
>  
> -		if (rac) {
> -			page = readahead_page(rac);
> -			prefetchw(&page->flags);
> -		}
> +		if (rac)
> +			folio = readahead_folio(rac);
> +		prefetchw(&folio->flags);

Unlike readahead_page(), readahead_folio() puts the folio immediately.  Is that
really safe?

> @@ -299,11 +298,11 @@ int ext4_mpage_readpages(struct inode *inode,
>  
>  				if (ext4_map_blocks(NULL, inode, &map, 0) < 0) {
>  				set_error_page:
> -					SetPageError(page);
> -					zero_user_segment(page, 0,
> -							  PAGE_SIZE);
> -					unlock_page(page);
> -					goto next_page;
> +					folio_set_error(folio);
> +					folio_zero_segment(folio, 0,
> +							  folio_size(folio));
> +					folio_unlock(folio);
> +					continue;

This is 'continuing' the inner loop, not the outer loop as it should.

- Eric
