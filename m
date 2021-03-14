Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 433C833A2B4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Mar 2021 05:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234927AbhCNEvZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 13 Mar 2021 23:51:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:50502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231756AbhCNEvI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 13 Mar 2021 23:51:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DDB6E64E62;
        Sun, 14 Mar 2021 04:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1615697468;
        bh=SdL+heiTbcrwP9pPgOGDk7GF8R9CH7ePb0egkT7rwIw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FjRiIGqmo+zm/qULvOhmtwzrstI0hO1a31TNzjvLXf1TifOBuzX5j2rJUUZ1YC8T7
         nvJGQ0hqZlUHgLYvFJWb4IheqwevpYe9QYhfWaIBk03i2DBfRyKgUizfPFMnlyznK9
         tWcf6AWxSi5u7FH95jjgGCX7R41X0ff/x7xJj0uE=
Date:   Sat, 13 Mar 2021 20:51:07 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 03/25] mm/vmstat: Add functions to account folio
 statistics
Message-Id: <20210313205107.673f342d4bef4b2932ecd55f@linux-foundation.org>
In-Reply-To: <20210314041155.GP2577561@casper.infradead.org>
References: <20210305041901.2396498-1-willy@infradead.org>
        <20210305041901.2396498-4-willy@infradead.org>
        <20210313123707.231fe9852872b269a00fcc89@linux-foundation.org>
        <20210314041155.GP2577561@casper.infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 14 Mar 2021 04:11:55 +0000 Matthew Wilcox <willy@infradead.org> wrote:

> On Sat, Mar 13, 2021 at 12:37:07PM -0800, Andrew Morton wrote:
> > On Fri,  5 Mar 2021 04:18:39 +0000 "Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:
> > 
> > > Allow page counters to be more readily modified by callers which have
> > > a folio.  Name these wrappers with 'stat' instead of 'state' as requested
> > > by Linus here:
> > > https://lore.kernel.org/linux-mm/CAHk-=wj847SudR-kt+46fT3+xFFgiwpgThvm7DJWGdi4cVrbnQ@mail.gmail.com/
> > > 
> > > --- a/include/linux/vmstat.h
> > > +++ b/include/linux/vmstat.h
> > > @@ -402,6 +402,54 @@ static inline void drain_zonestat(struct zone *zone,
> > >  			struct per_cpu_pageset *pset) { }
> > >  #endif		/* CONFIG_SMP */
> > >  
> > > +static inline
> > > +void __inc_zone_folio_stat(struct folio *folio, enum zone_stat_item item)
> > > +{
> > > +	__mod_zone_page_state(folio_zone(folio), item, folio_nr_pages(folio));
> > > +}
> > 
> > The naming is unfortunate.  We expect
> > 
> > inc: add one to
> > dec: subtract one from
> > mod: modify by signed quantity
> > 
> > So these are inconsistent.  Perhaps use "add" and "sub" instead.  At
> > least to alert people to the fact that these are different.
> > 
> > And, again, it's nice to see the subsystem's name leading the
> > identifiers, so "zone_folio_stat_add()".
> 
> I thought this was a 'zone stat', so __zone_stat_add_folio()?
> I'm not necessarily signing up to change the existing
> __inc_node_page_state(), but I might.  If so, __node_stat_add_page()?

That works.  It's the "inc means +1" and "dec means -1" whiplash that
struck me the most.

