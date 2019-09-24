Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E995BD4AF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2019 23:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633544AbfIXVyD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Sep 2019 17:54:03 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:42653 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728183AbfIXVyD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Sep 2019 17:54:03 -0400
Received: from dread.disaster.area (pa49-181-226-196.pa.nsw.optusnet.com.au [49.181.226.196])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 1A2C543EFAD;
        Wed, 25 Sep 2019 07:53:55 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.2)
        (envelope-from <david@fromorbit.com>)
        id 1iCskr-0005bn-N3; Wed, 25 Sep 2019 07:53:53 +1000
Date:   Wed, 25 Sep 2019 07:53:53 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>, dsterba@suse.cz,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Ming Lei <ming.lei@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-btrfs@vger.kernel.org, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH v2 2/2] mm, sl[aou]b: guarantee natural alignment for
 kmalloc(power-of-two)
Message-ID: <20190924215353.GG16973@dread.disaster.area>
References: <20190826111627.7505-1-vbabka@suse.cz>
 <20190826111627.7505-3-vbabka@suse.cz>
 <df8d1cf4-ff8f-1ee1-12fb-cfec39131b32@suse.cz>
 <20190923171710.GN2751@twin.jikos.cz>
 <20190923175146.GT2229799@magnolia>
 <172b2ed8-f260-6041-5e10-502d1c91f88c@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172b2ed8-f260-6041-5e10-502d1c91f88c@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=P6RKvmIu c=1 sm=1 tr=0
        a=dRuLqZ1tmBNts2YiI0zFQg==:117 a=dRuLqZ1tmBNts2YiI0zFQg==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=J70Eh1EUuV4A:10
        a=7-415B0cAAAA:8 a=8DDTXLWI6Pjby6uLqAQA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 24, 2019 at 11:19:29PM +0200, Vlastimil Babka wrote:
> On 9/23/19 7:51 PM, Darrick J. Wong wrote:
> > On Mon, Sep 23, 2019 at 07:17:10PM +0200, David Sterba wrote:
> >> On Mon, Sep 23, 2019 at 06:36:32PM +0200, Vlastimil Babka wrote:
> >>> So if anyone thinks this is a good idea, please express it (preferably
> >>> in a formal way such as Acked-by), otherwise it seems the patch will be
> >>> dropped (due to a private NACK, apparently).
> > 
> > Oh, I didn't realize  ^^^^^^^^^^^^ that *some* of us are allowed the
> > privilege of gutting a patch via private NAK without any of that open
> > development discussion incovenience. <grumble>
> > 
> > As far as XFS is concerned I merged Dave's series that checks the
> > alignment of io memory allocations and falls back to vmalloc if the
> > alignment won't work, because I got tired of scrolling past the endless
> > discussion and bug reports and inaction spanning months.
> 
> I think it's a big fail of kmalloc API that you have to do that, and
> especially with vmalloc, which has the overhead of setting up page
> tables, and it's a waste for allocation requests smaller than page size.
> I wish we could have nice things.

I don't think the problem here is the code. The problem here is that
we have a dysfunctional development community and there are no
processes we can follow to ensure architectural problems in core
subsystems are addressed in a timely manner...

And this criticism isn't just of the mm/ here - this alignment
problem is exacerbated by exactly the same issue on the block layer
side. i.e. the block layer and drivers have -zero- bounds checking
to catch these sorts of things and the block layer maintainer will
not accept patches for runtime checks that would catch these issues
and make them instantly visible to us.

These are not code problems: we can fix the problems with code (and
I have done so to demonstrate "this is how we do what you say is
impossible").  The problem here is people in positions of
control/power are repeatedly demonstrating an inability to
compromise to reach a solution that works for everyone.

It's far better for us just to work around bullshit like this in XFS
now, then when the core subsystems get they act together years down
the track we can remove the workaround from XFS. Users don't care
how we fix the problem, they just want it fixed. If that means we
have to route around dysfunctional developer groups, then we'll just
have to do that....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
