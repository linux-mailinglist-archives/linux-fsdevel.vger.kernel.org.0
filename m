Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63E4C3EAF20
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Aug 2021 06:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234013AbhHMERS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Aug 2021 00:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbhHMERR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Aug 2021 00:17:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF07FC061756;
        Thu, 12 Aug 2021 21:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=y3X3sVuY3L2FWlXGWvS23PeS1/gxpP+T9Fv+274OjwQ=; b=jYyxgMzfWOQo+Hrse33LD/l0b7
        nQq/CeYf/jACRw9Z0bVKWTY6/czLjNvVAThT5svKXzaod41mg4cW/ONz2GemN0+sza0zjwSUcLvE1
        x0VV35IYX/v6vwlpn9p+UA1v44PpBFl2AI5H6fSP+PWH+qZIK/ADPC3e38qg4+mBznVxhEgIiNJmC
        hU3OYQfDEXqnZ4FXEmGbq9FH2YEpNDUtl9DNORCm8eOu0mLtPTMWJS6+FGz5SxPgoedYKajpCMd5W
        KiNVWytYJDFoxuGY0+2MEcyQGfL5AdPZnTdE3n9Qomz1atbKv4XZZTDVD4bESR8ZbUrnkUIeJYzRp
        /Si23TJQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mEOcM-00FIVR-6R; Fri, 13 Aug 2021 04:16:33 +0000
Date:   Fri, 13 Aug 2021 05:16:26 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 062/138] mm/migrate: Add folio_migrate_copy()
Message-ID: <YRXyGg7MWZTLA+YU@casper.infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-63-willy@infradead.org>
 <b9c3038a-56af-95e9-b5dd-8e88f508719e@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9c3038a-56af-95e9-b5dd-8e88f508719e@suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 12, 2021 at 01:56:24PM +0200, Vlastimil Babka wrote:
> On 7/15/21 5:35 AM, Matthew Wilcox (Oracle) wrote:
> > This is the folio equivalent of migrate_page_copy(), which is retained
> > as a wrapper for filesystems which are not yet converted to folios.
> > Also convert copy_huge_page() to folio_copy().
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> 
> The way folio_copy() avoids cond_resched() for single page would IMHO deserve a
> comment though, so it's not buried only in this thread.

I think folio_copy() deserves kernel-doc.

/**
 * folio_copy - Copy the contents of one folio to another.
 * @dst: Folio to copy to.
 * @src: Folio to copy from.
 *
 * The bytes in the folio represented by @src are copied to @dst.
 * Assumes the caller has validated that @dst is at least as large as @src.
 * Can be called in atomic context for order-0 folios, but if the folio is
 * larger, it may sleep.
 */

