Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 370757606CD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jul 2023 05:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbjGYDmD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 23:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjGYDmD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 23:42:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ABEA1725;
        Mon, 24 Jul 2023 20:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PD7F/GgFgl7LQTbflpAkcaqyjD+rYME0tJ2KPALznEw=; b=nRmFKamUBZ7Wz3GXaHnzbrWX0A
        +unM0RpFYz6QzvMCfR9sAExj/gdu8M5xnf1ZPxmCGnZ/HuN7wpuQM2O3jMzWP53eSEIHiucbfMsNC
        CiX91bsCCqo1yDr7COJj76rTSMXMO85zp3ktDEKqS3OmMZz3GoBgFWJ7onJKs48av4kVbaVjQHFag
        wNwYzKVOWvqA7I/w0NLY9+F2Z/nOwLjWY5Eyi3AqyEM7YTJcAf9WTFdkuIOQTPYtu/XNgtZPNxNyN
        xnr1mdgRlWQPSjunWEcX6/CxUozad0U/TKB9fZNRhrYFEEvMl3nk343se7hU1MYnr4GJL03bc1BJH
        BRCY38YA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qO8vu-00568t-TI; Tue, 25 Jul 2023 03:41:58 +0000
Date:   Tue, 25 Jul 2023 04:41:58 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Daniel Dao <dqminh@cloudflare.com>, linux-fsdevel@vger.kernel.org,
        kernel-team <kernel-team@cloudflare.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, djwong@kernel.org
Subject: Re: Kernel NULL pointer deref and data corruptions with xfs on 6.1
Message-ID: <ZL9EhledFQbN9djT@casper.infradead.org>
References: <CA+wXwBRGab3UqbLqsr8xG=ZL2u9bgyDNNea4RGfTDjqB=J3geQ@mail.gmail.com>
 <CA+wXwBR6S3StBwJJmo8Fu6KdPW5Q382N7FwnmfckBJo4e6ZD_A@mail.gmail.com>
 <ZL7w9dEH8BSXRzyu@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZL7w9dEH8BSXRzyu@dread.disaster.area>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 25, 2023 at 07:45:25AM +1000, Dave Chinner wrote:
> On Mon, Jul 24, 2023 at 12:23:31PM +0100, Daniel Dao wrote:
> > Hi again,
> > 
> > We had another example of xarray corruption involving xfs and zsmalloc. We are
> > running zram as swap. We have 2 tasks deadlock waiting for page to be released
> 
> Do your problems on 6.1 go away if you stop using zram as swap?

I think zram is the victim here, not the culprit.  I think what's
going on is that -- somehow -- there are stale pointers in the xarray.
zram allocates these pages (I suspect most of the memory in this machine
is allocated to zram or page cache) and then we blow up when finding
a folio in the page cache which has a ->mapping that is actually a
movable_ops structure.

But how do we get stale pointers in the xarray?  I've been worrying at
that problem for months.  At some point, the refcount must go down to
zero:

static inline void folio_put(struct folio *folio)
{
        if (folio_put_testzero(folio))
                __folio_put(folio);
}

(assume we're talking about a large folio; everything seems to point
that way):

__folio_put_large:
        if (!folio_test_hugetlb(folio))
                __page_cache_release(folio);
        destroy_large_folio(folio);

destroy_large_folio:
	free_transhuge_page()
free_transhuge_page:
        free_compound_page(page);
free_compound_page:
        free_the_page(page, compound_order(page));
free_the_page:
                __free_pages_ok(page, order, FPI_NONE);
__free_pages_ok:
        if (!free_pages_prepare(page, order, fpi_flags))
free_pages_prepare:
       if (PageMappingFlags(page))
                page->mapping = NULL;
(doesn't trigger; PageMappingFlags are false for page cache)
        if (is_check_pages_enabled()) {
                if (free_page_is_bad(page))
free_page_is_bad:
        if (likely(page_expected_state(page, PAGE_FLAGS_CHECK_AT_FREE)))
                return false;

        /* Something has gone sideways, find it */
        free_page_is_bad_report(page);
page_expected_state:
        if (unlikely((unsigned long)page->mapping | ...
                return false;

free_page_is_bad_report:
        bad_page(page,
                 page_bad_reason(page, PAGE_FLAGS_CHECK_AT_FREE));
page_bad_reason:
        if (unlikely(page->mapping != NULL))
                bad_reason = "non-NULL mapping";

So (assuming that Daniel has check_pages_enabled set and isn't ignoring
important parts of dmesg, which seem like reasonable assumptions), the
last put of a folio must be after the folio has had its ->mapping cleared

But we remove the folio from the page cache in page_cache_delete(),
right before we set the mapping to NULL.  And again in
delete_from_page_cache_batch() (in the other order; I don't think that's
relevant?)

So where do we set folio->mapping to NULL without removing folio from
the XArray?  I'm beginning to suspect it's a mishandled failure in
split_huge_page(), so I'll re-review that code path tomorrow.
