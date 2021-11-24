Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03F8445B6D4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Nov 2021 09:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233758AbhKXIrO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Nov 2021 03:47:14 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:57100 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241436AbhKXIqY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Nov 2021 03:46:24 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D5B4021959;
        Wed, 24 Nov 2021 08:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637743393; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AaW2/94xFEFY81k6qhflOE63X/xcjLk/Nn9FfoW09KM=;
        b=SEngNy0UOSzXo0fcXZVbmAu1VGT8yHC9geby1rzzhcCjqMZgxH/HNef57QI4Cgz9Q5k6+Y
        y5eA+Vid/D9IzO7EEfaz+UWBaxmmBk8tNqhUF2BaGatFBqb8bdg7dJm3X+EgG7GKesMGNY
        +azvVVM5qEuteXHYS/7j34a3oInyqko=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 905AEA3B81;
        Wed, 24 Nov 2021 08:43:13 +0000 (UTC)
Date:   Wed, 24 Nov 2021 09:43:12 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Dave Chinner <david@fromorbit.com>, Neil Brown <neilb@suse.de>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v2 2/4] mm/vmalloc: add support for __GFP_NOFAIL
Message-ID: <YZ37IJq3+DrVhAcD@dhcp22.suse.cz>
References: <20211122153233.9924-1-mhocko@kernel.org>
 <20211122153233.9924-3-mhocko@kernel.org>
 <YZ06nna7RirAI+vJ@pc638.lan>
 <20211123170238.f0f780ddb800f1316397f97c@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123170238.f0f780ddb800f1316397f97c@linux-foundation.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 23-11-21 17:02:38, Andrew Morton wrote:
> On Tue, 23 Nov 2021 20:01:50 +0100 Uladzislau Rezki <urezki@gmail.com> wrote:
> 
> > On Mon, Nov 22, 2021 at 04:32:31PM +0100, Michal Hocko wrote:
> > > From: Michal Hocko <mhocko@suse.com>
> > > 
> > > Dave Chinner has mentioned that some of the xfs code would benefit from
> > > kvmalloc support for __GFP_NOFAIL because they have allocations that
> > > cannot fail and they do not fit into a single page.
> 
> Perhaps we should tell xfs "no, do it internally".  Because this is a
> rather nasty-looking thing - do we want to encourage other callsites to
> start using it?

This is what xfs is likely going to do if we do not provide the
functionality. I just do not see why that would be a better outcome
though. My longterm experience tells me that whenever we ignore
requirements by other subsystems then those requirements materialize in
some form in the end. In many cases done either suboptimaly or outright
wrong. This might be not the case for xfs as the quality of
implementation is high there but this is not the case in general.

Even if people start using vmalloc(GFP_NOFAIL) out of lazyness or for
any other stupid reason then what? Is that something we should worry
about? Retrying within the allocator doesn't make the things worse. In
fact it is just easier to find such abusers by grep which would be more
elaborate with custom retry loops.
 
[...]
> > > +		if (nofail) {
> > > +			schedule_timeout_uninterruptible(1);
> > > +			goto again;
> > > +		}
> 
> The idea behind congestion_wait() is to prevent us from having to
> hard-wire delays like this.  congestion_wait(1) would sleep for up to
> one millisecond, but will return earlier if reclaim events happened
> which make it likely that the caller can now proceed with the
> allocation event, successfully.
> 
> However it turns out that congestion_wait() was quietly broken at the
> block level some time ago.  We could perhaps resurrect the concept at
> another level - say by releasing congestion_wait() callers if an amount
> of memory newly becomes allocatable.  This obviously asks for inclusion
> of zone/node/etc info from the congestion_wait() caller.  But that's
> just an optimization - if the newly-available memory isn't useful to
> the congestion_wait() caller, they just fail the allocation attempts
> and wait again.

vmalloc has two potential failure modes. Depleted memory and vmalloc
space. So there are two different events to wait for. I do agree that
schedule_timeout_uninterruptible is both ugly and very simple but do we
really need a much more sophisticated solution at this stage?
-- 
Michal Hocko
SUSE Labs
