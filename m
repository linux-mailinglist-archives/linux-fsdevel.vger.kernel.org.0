Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61C73150E1F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2020 17:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbgBCQtf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Feb 2020 11:49:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:49292 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727794AbgBCQtf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:49:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 79BDAAD95;
        Mon,  3 Feb 2020 16:49:33 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 2CCA41E0D5D; Mon,  3 Feb 2020 17:49:33 +0100 (CET)
Date:   Mon, 3 Feb 2020 17:49:33 +0100
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: Race in xarray tagged iteration
Message-ID: <20200203164933.GH18591@quack2.suse.cz>
References: <20200203140937.GA18591@quack2.suse.cz>
 <20200203163301.GJ8731@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200203163301.GJ8731@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 03-02-20 08:33:01, Matthew Wilcox wrote:
> On Mon, Feb 03, 2020 at 03:09:37PM +0100, Jan Kara wrote:
> > Hello Matthew!
> > 
> > Lately I've been looking into speeding up page cache truncation that got
> > slowed down by the conversion of page cache to xarray as we spoke about
> > back in February / March [1]. Now I have relatively simple patch giving me
> > around 6% improvement in truncation speeds on my test machine but when
> > testing it and debugging issues, I've found out that current xarray tagged
> > iteration is racy:
> > 
> > TASK1					TASK2
> > page_cache_delete()			find_get_pages_range_tag()
> > 					  xas_for_each_marked()
> > 					    xas_find_marked()
> > 					      off = xas_find_chunk()
> > 
> >   xas_store(&xas, NULL)
> >     xas_init_marks(&xas);
> >     ...
> >     rcu_assign_pointer(*slot, NULL);
> > 					      entry = xa_entry(off);
> > 
> > So xas_for_each_marked() can return NULL entries as tagged thus aborting
> > xas_for_each_marked() iteration prematurely (data loss possible).
> > 
> > Now I have a patch to change xas_for_each_marked() to not get confused by
> > NULL entries (because that is IMO a fragile design anyway and easy to avoid
> > AFAICT) but that still leaves us with find_get_pages_range_tag() getting
> > NULL as tagged entry and that causes oops there.
> > 
> > I see two options how to fix this and I'm not quite decided which is
> > better:
> > 
> > 1) Just add NULL checking to find_get_pages_range_tag() similarly to how it
> > currently checks xa_is_value(). Quick grepping seems to show that that
> > place is the only place that uses tagged iteration under RCU. It is cheap
> > but kind of ugly.
> > 
> > 2) Make sure xas_find_marked() and xas_next_marked() do recheck marks after
> > loading the entry. This is more convenient for the callers but potentially
> > more expensive since we'd have to add some barriers there.
> > 
> > What's your opinion? I'm leaning more towards 1) but I'm not completely
> > decided...
> 
> Thanks for debugging that!  This must've been the problem I was hitting
> when I originally tried to solve that problem.
> 
> I prefer a third choice ... continue to iterate forward if we find a NULL
> entry that used to have a tag set on it.  That should be cheap.

Yep, fair enough. I'll add this to the series I'm preparing and see whether
xfstests now pass.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
