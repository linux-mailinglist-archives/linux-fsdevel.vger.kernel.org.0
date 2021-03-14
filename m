Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAEF33A296
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Mar 2021 05:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234946AbhCNEM1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 13 Mar 2021 23:12:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234941AbhCNEMJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 13 Mar 2021 23:12:09 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE863C061574;
        Sat, 13 Mar 2021 20:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=02jgM/7ByYHgEtTryAQckCxQUmrHridrlm+xFZ5jOkE=; b=Vh9jIURFq7H64sfFuYM3dyj+gH
        EqZ+P5PatjvVgG8RRjDFxFsp0IETWf19ZavYwd07/Gz1Ud6lFQxi6eM/LHblG/UgvFvU6JtpGqNJ9
        s3WeyRblL8QMjOJ2NYycDb0xLkzf6J+ZwlooyrTNhn7jxATSLTVqJb/zjkADLikWEfTURw61zA6Wd
        nZzsogrO9XIe5wMZ7De4MVDE/neCSSdd2uDpM4pTGWOfsYphEOvId51WaS/O2TrqrJscPugCLz/9S
        moBQ4oJfeY0bK8sJ4Cn4aEnLtvfaEu7gbqRMfsZHWiszkyPlcy+CokVNTnumseEdjJessOwVgq+QF
        1mj2H7lA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lLI6d-00FWm2-Ih; Sun, 14 Mar 2021 04:11:57 +0000
Date:   Sun, 14 Mar 2021 04:11:55 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 03/25] mm/vmstat: Add functions to account folio
 statistics
Message-ID: <20210314041155.GP2577561@casper.infradead.org>
References: <20210305041901.2396498-1-willy@infradead.org>
 <20210305041901.2396498-4-willy@infradead.org>
 <20210313123707.231fe9852872b269a00fcc89@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210313123707.231fe9852872b269a00fcc89@linux-foundation.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 13, 2021 at 12:37:07PM -0800, Andrew Morton wrote:
> On Fri,  5 Mar 2021 04:18:39 +0000 "Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:
> 
> > Allow page counters to be more readily modified by callers which have
> > a folio.  Name these wrappers with 'stat' instead of 'state' as requested
> > by Linus here:
> > https://lore.kernel.org/linux-mm/CAHk-=wj847SudR-kt+46fT3+xFFgiwpgThvm7DJWGdi4cVrbnQ@mail.gmail.com/
> > 
> > --- a/include/linux/vmstat.h
> > +++ b/include/linux/vmstat.h
> > @@ -402,6 +402,54 @@ static inline void drain_zonestat(struct zone *zone,
> >  			struct per_cpu_pageset *pset) { }
> >  #endif		/* CONFIG_SMP */
> >  
> > +static inline
> > +void __inc_zone_folio_stat(struct folio *folio, enum zone_stat_item item)
> > +{
> > +	__mod_zone_page_state(folio_zone(folio), item, folio_nr_pages(folio));
> > +}
> 
> The naming is unfortunate.  We expect
> 
> inc: add one to
> dec: subtract one from
> mod: modify by signed quantity
> 
> So these are inconsistent.  Perhaps use "add" and "sub" instead.  At
> least to alert people to the fact that these are different.
> 
> And, again, it's nice to see the subsystem's name leading the
> identifiers, so "zone_folio_stat_add()".

I thought this was a 'zone stat', so __zone_stat_add_folio()?
I'm not necessarily signing up to change the existing
__inc_node_page_state(), but I might.  If so, __node_stat_add_page()?
