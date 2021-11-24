Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B866C45B0F8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Nov 2021 02:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbhKXBFu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 20:05:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:35774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230026AbhKXBFu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 20:05:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 34C5F60FC1;
        Wed, 24 Nov 2021 01:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1637715761;
        bh=Me3tqnGGECSs5MhNWzdUoWhGdYXDGmCnffeBIGGiRKw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RZdV0TuEM7ewScTwvMQSNHCN58BRBV/QDwWyHPk33/JJfp6q/GAG3S6IJv5YyCA3i
         rbfJuyZlhvyj/iBXbfSRMJX1ZEa65/IsTir//czSMJQRp5p/Aq1VK/yhXMD53SF5vF
         IWzobwZHBwz9W2eQomdYoQhNX7cxmrUf3W35R6rk=
Date:   Tue, 23 Nov 2021 17:02:38 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Dave Chinner <david@fromorbit.com>, Neil Brown <neilb@suse.de>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v2 2/4] mm/vmalloc: add support for __GFP_NOFAIL
Message-Id: <20211123170238.f0f780ddb800f1316397f97c@linux-foundation.org>
In-Reply-To: <YZ06nna7RirAI+vJ@pc638.lan>
References: <20211122153233.9924-1-mhocko@kernel.org>
        <20211122153233.9924-3-mhocko@kernel.org>
        <YZ06nna7RirAI+vJ@pc638.lan>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 23 Nov 2021 20:01:50 +0100 Uladzislau Rezki <urezki@gmail.com> wrote:

> On Mon, Nov 22, 2021 at 04:32:31PM +0100, Michal Hocko wrote:
> > From: Michal Hocko <mhocko@suse.com>
> > 
> > Dave Chinner has mentioned that some of the xfs code would benefit from
> > kvmalloc support for __GFP_NOFAIL because they have allocations that
> > cannot fail and they do not fit into a single page.

Perhaps we should tell xfs "no, do it internally".  Because this is a
rather nasty-looking thing - do we want to encourage other callsites to
start using it?

> > The large part of the vmalloc implementation already complies with the
> > given gfp flags so there is no work for those to be done. The area
> > and page table allocations are an exception to that. Implement a retry
> > loop for those.
> > 
> > Add a short sleep before retrying. 1 jiffy is a completely random
> > timeout. Ideally the retry would wait for an explicit event - e.g.
> > a change to the vmalloc space change if the failure was caused by
> > the space fragmentation or depletion. But there are multiple different
> > reasons to retry and this could become much more complex. Keep the retry
> > simple for now and just sleep to prevent from hogging CPUs.
> > 

Yes, the horse has already bolted.  But we didn't want that horse anyway ;)

I added GFP_NOFAIL back in the mesozoic era because quite a lot of
sites were doing open-coded try-forever loops.  I thought "hey, they
shouldn't be doing that in the first place, but let's at least
centralize the concept to reduce code size, code duplication and so
it's something we can now grep for".  But longer term, all GFP_NOFAIL
sites should be reworked to no longer need to do the retry-forever
thing.  In retrospect, this bright idea of mine seems to have added
license for more sites to use retry-forever.  Sigh.

> > +		if (nofail) {
> > +			schedule_timeout_uninterruptible(1);
> > +			goto again;
> > +		}

The idea behind congestion_wait() is to prevent us from having to
hard-wire delays like this.  congestion_wait(1) would sleep for up to
one millisecond, but will return earlier if reclaim events happened
which make it likely that the caller can now proceed with the
allocation event, successfully.

However it turns out that congestion_wait() was quietly broken at the
block level some time ago.  We could perhaps resurrect the concept at
another level - say by releasing congestion_wait() callers if an amount
of memory newly becomes allocatable.  This obviously asks for inclusion
of zone/node/etc info from the congestion_wait() caller.  But that's
just an optimization - if the newly-available memory isn't useful to
the congestion_wait() caller, they just fail the allocation attempts
and wait again.

> well that is sad...
> I have raised two concerns in our previous discussion about this change,

Can you please reiterate those concerns here?
