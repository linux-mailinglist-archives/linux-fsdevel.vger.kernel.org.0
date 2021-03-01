Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D17303294D5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Mar 2021 23:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238258AbhCAWVQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Mar 2021 17:21:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244516AbhCAWQr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Mar 2021 17:16:47 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87259C061756;
        Mon,  1 Mar 2021 14:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=zxZIlcc7PFkSOXfb8Azdcpif4NIGsuIagSgxJ7r+Dx0=; b=INpsQoCF19J5S1IqbMocDI7zho
        DbkuSxFu6JX1zFwJYXpA3CAYN56R+uVcSOfzBGeIT1zBIaRJfNoL1+T59hKtSfbcFiKeVL2NE4PvP
        iJ737y3mQso609/FgDStoFIHnZzo+dSbGnfGYjCPTJRmoKdUGRCxwRmMftQC1Lw4SpBTalZX2SgGU
        aqXPq1lmkhgG8Vi86a7UmBdfiwfwxRhNY31P9nu1ow0Wjkh2wz29dwiKjeBwP2K45VGZcs3ic0yDQ
        OFpb6nXGP4cw/njjSj+ZC6ZwnUsB6DKAbqlCKFp5zfF1jQlMocI8WoklflXnJQThFtqVAA1QG+Nhz
        R8ahroeg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lGqpN-00GIQj-PG; Mon, 01 Mar 2021 22:16:01 +0000
Date:   Mon, 1 Mar 2021 22:15:45 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Zi Yan <ziy@nvidia.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 03/25] mm/vmstat: Add folio stat wrappers
Message-ID: <20210301221545.GV2723601@casper.infradead.org>
References: <20210128070404.1922318-1-willy@infradead.org>
 <20210128070404.1922318-4-willy@infradead.org>
 <FED22A41-FCD3-4777-9433-69990C145C7F@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <FED22A41-FCD3-4777-9433-69990C145C7F@nvidia.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 01, 2021 at 04:17:39PM -0500, Zi Yan wrote:
> On 28 Jan 2021, at 2:03, Matthew Wilcox (Oracle) wrote:
> > Allow page counters to be more readily modified by callers which have
> > a folio.  Name these wrappers with 'stat' instead of 'state' as requested
>
> Shouldn’t we change the stats with folio_nr_pages(folio) here? And all
> changes below. Otherwise one folio is always counted as a single page.

That's a good point.  Looking through the changes in my current folio
tree (which doesn't get as far as the thp tree did; ie doesn't yet allocate
multi-page folios, so hasn't been tested with anything larger than a
single page), the callers are ...

@@ -2698,3 +2698,3 @@ int clear_page_dirty_for_io(struct page *page)
-               if (TestClearPageDirty(page)) {
-                       dec_lruvec_page_state(page, NR_FILE_DIRTY);
-                       dec_zone_page_state(page, NR_ZONE_WRITE_PENDING);
+               if (TestClearFolioDirty(folio)) {
+                       dec_lruvec_folio_stat(folio, NR_FILE_DIRTY);
+                       dec_zone_folio_stat(folio, NR_ZONE_WRITE_PENDING);
@@ -2432,3 +2433,3 @@ void account_page_dirtied(struct page *page, struct addres
s_space *mapping)
-               __inc_lruvec_page_state(page, NR_FILE_DIRTY);
-               __inc_zone_page_state(page, NR_ZONE_WRITE_PENDING);
-               __inc_node_page_state(page, NR_DIRTIED);
+               __inc_lruvec_folio_stat(folio, NR_FILE_DIRTY);
+               __inc_zone_folio_stat(folio, NR_ZONE_WRITE_PENDING);
+               __inc_node_folio_stat(folio, NR_DIRTIED);
@@ -891 +890 @@ noinline int __add_to_page_cache_locked(struct page *page,
-                       __inc_lruvec_page_state(page, NR_FILE_PAGES);
+                       __inc_lruvec_folio_stat(folio, NR_FILE_PAGES);
@@ -2759,2 +2759,2 @@ int test_clear_page_writeback(struct page *page)
-               dec_zone_page_state(page, NR_ZONE_WRITE_PENDING);
-               inc_node_page_state(page, NR_WRITTEN);
+               dec_zone_folio_stat(folio, NR_ZONE_WRITE_PENDING);
+               inc_node_folio_stat(folio, NR_WRITTEN);

I think it's clear from this that I haven't found all the places
that I need to change yet ;-)

Looking at the places I did change in the thp tree, there are changes
like this:

@@ -860,27 +864,30 @@ noinline int __add_to_page_cache_locked(struct page *page,
-               if (!huge)
-                       __inc_lruvec_page_state(page, NR_FILE_PAGES);
+               if (!huge) {
+                       __mod_lruvec_page_state(page, NR_FILE_PAGES, nr);
+                       if (nr > 1)
+                               __mod_node_page_state(page_pgdat(page),
+                                               NR_FILE_THPS, nr);
+               }

... but I never did do some of the changes which the above changes imply
are needed.  So the thp tree probably had all kinds of bad statistics
that I never noticed.

So ... at least some of the users are definitely going to want to
cache the 'nr_pages' and use it multiple times, including calling
__mod_node_folio_state(), but others should do what you suggested.
Thanks!  I'll make that change.
