Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED93150C10
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2020 17:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730512AbgBCQdD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Feb 2020 11:33:03 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58296 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730509AbgBCQdD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:33:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9mmU41PNtqfjM0UzqehLWGZJ7M0wNiYwKFnFe1cQyos=; b=NvEKgCygNlJXuolMwzkMtPEqV7
        Bt9PeJ1uvU6Byw8lQn9NATtWZOxPInFtaBW530qSVgp9oQO/jQkMMhgk2lZtVdSq1zVAPHuQkjla3
        K9gLoDhXt1nf1V8kHSe3oKdRA8+CGhMwz0AFSgC0Wxyx86oAy3wEhb/SNH/wz8QQWjsRy26wOIg0P
        Y25QKVpVZY7XbZHznIyoi0j6ihShj7KMvMerk928BoThZ88AV0mi67OueQo88Jp8ljnFid0uq6Z6U
        2PEiaj54kjgFlEveEdNqTCzM4N3lQIRcFCy0PIiKXqSlBQX1vGs4GIdXyIoyXRkqvmgw4V5qCLIfP
        ota4H3Fw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iyeej-0002wW-3u; Mon, 03 Feb 2020 16:33:01 +0000
Date:   Mon, 3 Feb 2020 08:33:01 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: Race in xarray tagged iteration
Message-ID: <20200203163301.GJ8731@bombadil.infradead.org>
References: <20200203140937.GA18591@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200203140937.GA18591@quack2.suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 03, 2020 at 03:09:37PM +0100, Jan Kara wrote:
> Hello Matthew!
> 
> Lately I've been looking into speeding up page cache truncation that got
> slowed down by the conversion of page cache to xarray as we spoke about
> back in February / March [1]. Now I have relatively simple patch giving me
> around 6% improvement in truncation speeds on my test machine but when
> testing it and debugging issues, I've found out that current xarray tagged
> iteration is racy:
> 
> TASK1					TASK2
> page_cache_delete()			find_get_pages_range_tag()
> 					  xas_for_each_marked()
> 					    xas_find_marked()
> 					      off = xas_find_chunk()
> 
>   xas_store(&xas, NULL)
>     xas_init_marks(&xas);
>     ...
>     rcu_assign_pointer(*slot, NULL);
> 					      entry = xa_entry(off);
> 
> So xas_for_each_marked() can return NULL entries as tagged thus aborting
> xas_for_each_marked() iteration prematurely (data loss possible).
> 
> Now I have a patch to change xas_for_each_marked() to not get confused by
> NULL entries (because that is IMO a fragile design anyway and easy to avoid
> AFAICT) but that still leaves us with find_get_pages_range_tag() getting
> NULL as tagged entry and that causes oops there.
> 
> I see two options how to fix this and I'm not quite decided which is
> better:
> 
> 1) Just add NULL checking to find_get_pages_range_tag() similarly to how it
> currently checks xa_is_value(). Quick grepping seems to show that that
> place is the only place that uses tagged iteration under RCU. It is cheap
> but kind of ugly.
> 
> 2) Make sure xas_find_marked() and xas_next_marked() do recheck marks after
> loading the entry. This is more convenient for the callers but potentially
> more expensive since we'd have to add some barriers there.
> 
> What's your opinion? I'm leaning more towards 1) but I'm not completely
> decided...

Thanks for debugging that!  This must've been the problem I was hitting
when I originally tried to solve that problem.

I prefer a third choice ... continue to iterate forward if we find a NULL
entry that used to have a tag set on it.  That should be cheap.
