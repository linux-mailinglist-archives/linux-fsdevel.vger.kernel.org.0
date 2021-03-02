Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5471C32B4A4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Mar 2021 06:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234820AbhCCFXm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Mar 2021 00:23:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351207AbhCBNgn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Mar 2021 08:36:43 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ECCFC0617A9;
        Tue,  2 Mar 2021 05:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YAXtL7G+ODJGViyx1Mmuan7J8bHV3q/uQ/e9jGUFsl4=; b=R2xHCj+zzbgtgx5t6uWCUKSWY8
        buNdvpZPyaLugiJQ+bbHlIPtr7jk0ZKDag1XY1B/TmLY/fYWiisCATy6tiLpCYJ2G85hdq0OdSbAm
        jKhsJOHkMB7HBWKTD7AUOOl9tuVjh6GMBk6xLQYqnwJK6z/lKkIUEzjQdgQkQCenuZ1OZCIxm9Dnm
        afilmZ+rkmcM2kpF80r0caGEdEtvSieh0V4+J/LNlimrVGYDn6j2ZLBsSm4i3n9ddC+yoQa+5h31b
        xZIdHhX5Jvh7akAdU65ymoXN+TcB9GxYfBBE13yYgfHPa46NT06u5Kit7RBLDC4Wgu5TuRwJQuQL1
        7EEqB1jQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lH4zB-00HAov-9N; Tue, 02 Mar 2021 13:22:50 +0000
Date:   Tue, 2 Mar 2021 13:22:49 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Zi Yan <ziy@nvidia.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH v3 01/25] mm: Introduce struct folio
Message-ID: <20210302132249.GX2723601@casper.infradead.org>
References: <20210128070404.1922318-1-willy@infradead.org>
 <20210128070404.1922318-2-willy@infradead.org>
 <68723D50-AFD1-4F25-8F10-81EC11045BE5@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68723D50-AFD1-4F25-8F10-81EC11045BE5@nvidia.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 01, 2021 at 03:26:11PM -0500, Zi Yan wrote:
> > +static inline struct folio *next_folio(struct folio *folio)
> > +{
> > +	return folio + folio_nr_pages(folio);
> 
> Are you planning to make hugetlb use folio too?
> 
> If yes, this might not work if we have CONFIG_SPARSEMEM && !CONFIG_SPARSEMEM_VMEMMAP
> with a hugetlb folio > MAX_ORDER, because struct page might not be virtually contiguous.
> See the experiment I did in [1].

Actually, how about proofing this against a future change?

static inline struct folio *next_folio(struct folio *folio)
{
#if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
	pfn_t next_pfn = page_to_pfn(&folio->page) + folio_nr_pages(folio);
	return (struct folio *)pfn_to_page(next_pfn);
#else
	return folio + folio_nr_pages(folio);
#endif
}

(not compiled)

