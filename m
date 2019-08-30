Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7BEA2B6A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2019 02:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbfH3A3p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Aug 2019 20:29:45 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:46998 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727182AbfH3A3p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Aug 2019 20:29:45 -0400
Received: from dread.disaster.area (pa49-181-255-194.pa.nsw.optusnet.com.au [49.181.255.194])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 319E743EA68;
        Fri, 30 Aug 2019 10:29:37 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1i3UnH-0001yY-Mw; Fri, 30 Aug 2019 10:29:35 +1000
Date:   Fri, 30 Aug 2019 10:29:35 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christopher Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Ming Lei <ming.lei@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mm, sl[aou]b: guarantee natural alignment for
 kmalloc(power-of-two)
Message-ID: <20190830002935.GX1119@dread.disaster.area>
References: <20190826111627.7505-1-vbabka@suse.cz>
 <20190826111627.7505-3-vbabka@suse.cz>
 <0100016cd98bb2c1-a2af7539-706f-47ba-a68e-5f6a91f2f495-000000@email.amazonses.com>
 <20190828194607.GB6590@bombadil.infradead.org>
 <20190828222422.GL1119@dread.disaster.area>
 <be70bf94-a63f-cc19-4958-0e7eed10859b@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be70bf94-a63f-cc19-4958-0e7eed10859b@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=FNpr/6gs c=1 sm=1 tr=0
        a=YO9NNpcXwc8z/SaoS+iAiA==:117 a=YO9NNpcXwc8z/SaoS+iAiA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=FmdZ9Uzk2mMA:10
        a=7-415B0cAAAA:8 a=3jipp7y0vy340d0hbX8A:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 29, 2019 at 09:56:13AM +0200, Vlastimil Babka wrote:
> On 8/29/19 12:24 AM, Dave Chinner wrote:
> > On Wed, Aug 28, 2019 at 12:46:08PM -0700, Matthew Wilcox wrote:
> >> On Wed, Aug 28, 2019 at 06:45:07PM +0000, Christopher Lameter wrote:
> >>> I still think implicit exceptions to alignments are a bad idea. Those need
> >>> to be explicity specified and that is possible using kmem_cache_create().
> >>
> >> I swear we covered this last time the topic came up, but XFS would need
> >> to create special slab caches for each size between 512 and PAGE_SIZE.
> >> Potentially larger, depending on whether the MM developers are willing to
> >> guarantee that kmalloc(PAGE_SIZE * 2, GFP_KERNEL) will return a PAGE_SIZE
> >> aligned block of memory indefinitely.
> > 
> > Page size alignment of multi-page heap allocations is ncessary. The
> > current behaviour w/ KASAN is to offset so a 8KB allocation spans 3
> > pages and is not page aligned. That causes just as much in way
> > of alignment problems as unaligned objects in multi-object-per-page
> > slabs.
> 
> Ugh, multi-page (power of two) allocations *at the page allocator level*
> simply have to be aligned, as that's how the buddy allocator has always
> worked, and it would be madness to try relax that guarantee and require
> an explicit flag at this point. The kmalloc wrapper with SLUB will pass
> everything above 8KB directly to the page allocator, so that's fine too.
> 4k and 8k are the only (multi-)page sizes still managed as SLUB objects.

On a 4kB page size box, yes.

On a 64kB page size system, 4/8kB allocations are still sub-page
objects and will have alignment issues. Hence right now we can't
assume a 4/8/16/32kB allocation will be page size aligned
anywhere, because they are heap allocations on 64kB page sized
machines.

> I would say that these sizes are the most striking example that it's
> wrong not to align them without extra flags or special API variant.

Yup, just pointing out that they aren't guaranteed alignment right
now on x86-64.

> > As I said in the lastest discussion of this problem on XFS (pmem
> > devices w/ KASAN enabled), all we -need- is a GFP flag that tells the
> > slab allocator to give us naturally aligned object or fail if it
> > can't. I don't care how that gets implemented (e.g. another set of
> > heap slabs like the -rcl slabs), I just don't want every high level
> 
> Given alignment is orthogonal to -rcl and dma-, would that be another
> three sets? Or we assume that dma- would want it always, and complicate
> the rules further? Funilly enough, SLOB would be the simplest case here.

Not my problem. :) All I'm pointing out is that the minimum
functionality we require is specifying individual allocations as
needing alignment. I've just implemented that API in XFS, so
whatever happens in the allocation infrastructure from this point
onwards is really just implementation optimisation for us now....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
