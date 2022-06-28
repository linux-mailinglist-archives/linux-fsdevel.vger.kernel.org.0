Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0DC855F008
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 22:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiF1U5N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 16:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiF1U5M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 16:57:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1724838DA8;
        Tue, 28 Jun 2022 13:57:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CD56DB81F8C;
        Tue, 28 Jun 2022 20:57:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86F0DC341C8;
        Tue, 28 Jun 2022 20:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656449829;
        bh=JYjpGNT6iEQTqD1KKuuhn/8Y9wh6ZQGSQyJkPuIoo+8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZvOztGuB2lWfBDSlogHmcoiTa/KqdhlmdFnYHIGLR/JnJA89NgtoYgugSdXnJzAYy
         xs4vORpyPVQqXK63ZGVHbgXzSnZ8lDPULFeXe2t9hIrQTOp5ZSEU/lh7t+M+mQKJQr
         7OO8yBZEr1tgdZcLSEfDDnJVPR1BVRHvssPcSLJ5TmRF89QdniFCZO12YAhFFQD3LN
         a1uc5cO/+uXCRpjkv8EXGyF0Am+kHLfyj9r6gVPCXhJZV/vekNCssNF8CHgZDXPhij
         VWjyOD5cpcC+KSQLJHCwyHl6XALIgaf5Yz0X6Wl8aZkeSQCeUyYNsYHKLdPusdl6qK
         ktmiW5J2fPNwQ==
Date:   Tue, 28 Jun 2022 13:57:09 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org
Subject: Re: Multi-page folio issues in 5.19-rc4 (was [PATCH v3 25/25] xfs:
 Support large folios)
Message-ID: <YrtrJRxg8ZoSr3kr@magnolia>
References: <20211216210715.3801857-1-willy@infradead.org>
 <20211216210715.3801857-26-willy@infradead.org>
 <YrO243DkbckLTfP7@magnolia>
 <Yrku31ws6OCxRGSQ@magnolia>
 <Yrm6YM2uS+qOoPcn@casper.infradead.org>
 <YrosM1+yvMYliw2l@magnolia>
 <20220628073120.GI227878@dread.disaster.area>
 <YrrlrMK/7pyZwZj2@casper.infradead.org>
 <Yrrmq4hmJPkf5V7s@casper.infradead.org>
 <Yrr/oBlf1Eig8uKS@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yrr/oBlf1Eig8uKS@casper.infradead.org>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 28, 2022 at 02:18:24PM +0100, Matthew Wilcox wrote:
> On Tue, Jun 28, 2022 at 12:31:55PM +0100, Matthew Wilcox wrote:
> > On Tue, Jun 28, 2022 at 12:27:40PM +0100, Matthew Wilcox wrote:
> > > On Tue, Jun 28, 2022 at 05:31:20PM +1000, Dave Chinner wrote:
> > > > So using this technique, I've discovered that there's a dirty page
> > > > accounting leak that eventually results in fsx hanging in
> > > > balance_dirty_pages().
> > > 
> > > Alas, I think this is only an accounting error, and not related to
> > > the problem(s) that Darrick & Zorro are seeing.  I think what you're
> > > seeing is dirty pages being dropped at truncation without the
> > > appropriate accounting.  ie this should be the fix:
> > 
> > Argh, try one that actually compiles.
> 
> ... that one's going to underflow the accounting.  Maybe I shouldn't
> be writing code at 6am?

I dunno, it's been running on my test VMs for 160 minutes (same debug
setup as yesterday) and 100 minutes (regular g/522, no -C/-I flags to
fsx, no debugging junk) and neither have reported corruptions.

$ grep Dirty /proc/meminfo
Dirty:               100 kB

So, pretty good for writing code at 6am while on holiday.  I'll let this
run overnight, but I think you've fixed the problem, at least for me...

--D

> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index f7248002dad9..4eec6ee83e44 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -18,6 +18,7 @@
>  #include <linux/shrinker.h>
>  #include <linux/mm_inline.h>
>  #include <linux/swapops.h>
> +#include <linux/backing-dev.h>
>  #include <linux/dax.h>
>  #include <linux/khugepaged.h>
>  #include <linux/freezer.h>
> @@ -2439,11 +2440,15 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>  		__split_huge_page_tail(head, i, lruvec, list);
>  		/* Some pages can be beyond EOF: drop them from page cache */
>  		if (head[i].index >= end) {
> -			ClearPageDirty(head + i);
> -			__delete_from_page_cache(head + i, NULL);
> +			struct folio *tail = page_folio(head + i);
> +
>  			if (shmem_mapping(head->mapping))
>  				shmem_uncharge(head->mapping->host, 1);
> -			put_page(head + i);
> +			else if (folio_test_clear_dirty(tail))
> +				folio_account_cleaned(tail,
> +					inode_to_wb(folio->mapping->host));
> +			__filemap_remove_folio(tail, NULL);
> +			folio_put(tail);
>  		} else if (!PageAnon(page)) {
>  			__xa_store(&head->mapping->i_pages, head[i].index,
>  					head + i, 0);
