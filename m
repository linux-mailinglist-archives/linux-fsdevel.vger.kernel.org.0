Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2E173B3350
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jun 2021 17:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbhFXQAp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Jun 2021 12:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232348AbhFXQAp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Jun 2021 12:00:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42C4C061574;
        Thu, 24 Jun 2021 08:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5SsNt/I69pkIIwALnIwaHK6F5Hk6SuiLKMVHSsDe2Xw=; b=YXQBLqNPNqi7Xp4GbmtgEOT+hv
        Az/Yb5b1ypKxI6nTu7z8z286kZl9KlziYJWdBfY+IApxJMjpuYPZDYvCFkRhMTZ1f3YApu8FhUgGT
        bM9DRQ5M+oHa/CPr8yCC96MMEquryO1rzogBU7mvjhRfWjasDBH7N4ZrPGuSITvPsdCApULKcDKhp
        1m2Mt7355XSegr/FwbJ7xrvE4gquBnpUsQR2vJXUj/BI/p+xcZCbLdWOh3penEtepM978zTGso/1T
        wgrgyiQMMZqRK2pCZ3feUXi3AhQejuRDScpVhdudFjGU5tDR6D8X7cirYiWuA+sfHpGCcEKEfD2P/
        9YTFeHsg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwRjN-00GjtA-Ty; Thu, 24 Jun 2021 15:57:56 +0000
Date:   Thu, 24 Jun 2021 16:57:29 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/46] mm: Add arch_make_folio_accessible()
Message-ID: <YNSraZoSxNTCZf5b@casper.infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
 <20210622121551.3398730-6-willy@infradead.org>
 <YNLqJXTG6HwKRvdh@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNLqJXTG6HwKRvdh@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 23, 2021 at 10:00:37AM +0200, Christoph Hellwig wrote:
> On Tue, Jun 22, 2021 at 01:15:10PM +0100, Matthew Wilcox (Oracle) wrote:
> > As a default implementation, call arch_make_page_accessible n times.
> > If an architecture can do better, it can override this.
> > 
> > Also move the default implementation of arch_make_page_accessible()
> > from gfp.h to mm.h.
> 
> Can we wait with introducing arch hooks until we have an actual user
> lined up?

This one gets used in __folio_end_writeback() which is patch 24 in this
series.
