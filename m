Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D73A4C0F18
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Sep 2019 03:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbfI1BMv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Sep 2019 21:12:51 -0400
Received: from gentwo.org ([3.19.106.255]:49786 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725990AbfI1BMu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Sep 2019 21:12:50 -0400
Received: by gentwo.org (Postfix, from userid 1002)
        id 438FF3EEC9; Sat, 28 Sep 2019 01:12:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 413B93E8CB;
        Sat, 28 Sep 2019 01:12:49 +0000 (UTC)
Date:   Sat, 28 Sep 2019 01:12:49 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Vlastimil Babka <vbabka@suse.cz>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Sterba <dsterba@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Ming Lei <ming.lei@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-btrfs@vger.kernel.org, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH v2 2/2] mm, sl[aou]b: guarantee natural alignment for
 kmalloc(power-of-two)
In-Reply-To: <6a28a096-0e65-c7ea-9ca9-f72d68948e10@suse.cz>
Message-ID: <alpine.DEB.2.21.1909272251190.21341@www.lameter.com>
References: <20190826111627.7505-1-vbabka@suse.cz> <20190826111627.7505-3-vbabka@suse.cz> <df8d1cf4-ff8f-1ee1-12fb-cfec39131b32@suse.cz> <20190923171710.GN2751@twin.jikos.cz> <alpine.DEB.2.21.1909242048020.17661@www.lameter.com>
 <20190924165425.a79a2dafbaf37828a931df2b@linux-foundation.org> <alpine.DEB.2.21.1909260005060.1508@www.lameter.com> <6a28a096-0e65-c7ea-9ca9-f72d68948e10@suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 26 Sep 2019, Vlastimil Babka wrote:

> > - It will only work for special cases like the kmalloc array
> > without extras like metadata at the end of objects.
>
> I don't understand what you mean here? The kmalloc caches are special
> because they don't have metadata at the end of objects? Others do?

Yes.

> > - These alignments are only needed in exceptional cases but with the patch
> > we will provide the alignment by default even if the allocating subsystem
> > does not need it.
>
> True. This is where we have to make the decision whether to make things
> simpler for those that don't realize they need the alignment, and
> whether that's worth the cost. We have evidence of those cases, and the
> cost is currently zero in the common cases (SLAB, SLUB without debug
> runtime-enabled).

The cost is zero for a particular layout of the objects in a page using a
particular allocator and hardware configuration.

However, the layout may be different due to another allocator that prefers
to arrange things differently (SLOB puts multiple objects of different
types in the same page to save memory), if we need to add data to these
objects (debugging info, new metadata about the object, maybe the memcg
pointer, maybe other things that may come up), or other innovative
approaches (such as putting data of different kmem caches that are
commonly used together in the same page to improve locality).

The cost is an unnecessary petrification of the data layout of the memory
allocators.

> > - We have mechanisms to detect alignment problems using debug kernels and
> > debug options that have been available for years. These were not used for
> > testing in these cases it seems before the patches hit mainline. Once in
> > mainly someone ran a debug kernel and found the issue.
>
> Debugging options are useful if you know there's a bug and you want to
> find it. AFAIK the various bots/CIs that do e.g. randconfig, or enable
> debug options explicitly, run those kernels in a VM, so I guess that's
> why potential breakage due to alignment can lurk in a hw-specific driver.

That is not my experience. You need to run debugging to verify that a
patch does not cause locking problems, memory corruption etc etc. And
upstream code is tested by various people with debugging kernels so they
will locate the bugs that others introduce. This is usually not because
there was a focus on a particular bug. If you have a hw specific thing
that is not generally tested and skip the debugging tests well yes then we
have a problem.

What I have seen with developers is that they feel the debugging steps are
unnecessary for conveniences sake. I have seen build environments that had
proper steps for verification with a debug kernel. However, someone
disabled them "some months ago" and "nothing happened". Then strange
failures in production systems occur.
