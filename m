Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75EB41867BE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Mar 2020 10:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730321AbgCPJVs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Mar 2020 05:21:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:59258 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730293AbgCPJVs (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Mar 2020 05:21:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C9F4DAFCA;
        Mon, 16 Mar 2020 09:21:46 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 9165F1E10DA; Mon, 16 Mar 2020 10:21:46 +0100 (CET)
Date:   Mon, 16 Mar 2020 10:21:46 +0100
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 2/8] xarray: Provide xas_erase() helper
Message-ID: <20200316092146.GB12783@quack2.suse.cz>
References: <20200204142514.15826-1-jack@suse.cz>
 <20200204142514.15826-3-jack@suse.cz>
 <20200314195453.GS22433@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200314195453.GS22433@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat 14-03-20 12:54:53, Matthew Wilcox wrote:
> On Tue, Feb 04, 2020 at 03:25:08PM +0100, Jan Kara wrote:
> > Currently xas_store() clears marks when stored value is NULL. This is
> > somewhat counter-intuitive and also causes measurable performance impact
> > when mark clearing is not needed (e.g. because marks are already clear).
> > So provide xas_erase() helper (similarly to existing xa_erase()) which
> > stores NULL at given index and also takes care of clearing marks. Use
> > this helper from __xa_erase() and item_kill_tree() in tools/testing.  In
> > the following patches, callers that use the mark-clearing property of
> > xas_store() will be converted to xas_erase() and remaining users can
> > enjoy better performance.
> 
> I (finally!) figured out what I don't like about this series.  You're
> changing the semantics of xas_store() without changing the name, so
> if we have any new users in flight they'll use the new semantics when
> they're expecting the old.
> 
> Further, while you've split the patches nicely for review, they're not
> good for bisection because the semantic change comes right at the end
> of the series, so any problem due to this series is going to bisect to
> the end, and not tell us anything useful.

OK, fair enough.

> What I think this series should do instead is:
> 
> Patch 1:
> +#define xas_store(xas, entry)	xas_erase(xas, entry)
> -void *xas_store(struct xa_state *xas, void *entry)
> +void *__xas_store(struct xa_state *xas, void *entry)
> -	if (!entry)
> -		xas_init_marks(xas);
> +void *xas_erase(struct xa_state *xas, void *entry)
> +{
> +	xas_init_marks(xas);
> +	return __xas_store(xas, entry);
> +}
> (also documentation changes)
> 
> Patches 2-n:
> Change each user of xas_store() to either xas_erase() or __xas_store()
> 
> Patch n+1:
> -#define xas_store(xas, entry)  xas_erase(xas, entry)
> 
> Does that make sense?  I'll code it up next week unless you want to.

Fine by me and I agree the change is going to be more robust this way. I
just slightly dislike that you end up with __xas_store() with two
underscores which won't have a good meaning after the series is done but I
can certainly live with that :). If you've time to reorganize the series
this week, then go ahead. I've just returned from a week of vacation so it
will take a while for me to catch up... Thanks for having a look!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
