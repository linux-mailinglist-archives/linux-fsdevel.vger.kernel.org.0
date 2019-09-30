Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E48F7C1DDB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2019 11:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729482AbfI3JXi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Sep 2019 05:23:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:40786 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726008AbfI3JXi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Sep 2019 05:23:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 84FC5B161;
        Mon, 30 Sep 2019 09:23:35 +0000 (UTC)
Date:   Mon, 30 Sep 2019 11:23:34 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
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
Message-ID: <20190930092334.GA25306@dhcp22.suse.cz>
References: <20190826111627.7505-1-vbabka@suse.cz>
 <20190826111627.7505-3-vbabka@suse.cz>
 <df8d1cf4-ff8f-1ee1-12fb-cfec39131b32@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df8d1cf4-ff8f-1ee1-12fb-cfec39131b32@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 23-09-19 18:36:32, Vlastimil Babka wrote:
> On 8/26/19 1:16 PM, Vlastimil Babka wrote:
> > In most configurations, kmalloc() happens to return naturally aligned (i.e.
> > aligned to the block size itself) blocks for power of two sizes. That means
> > some kmalloc() users might unknowingly rely on that alignment, until stuff
> > breaks when the kernel is built with e.g.  CONFIG_SLUB_DEBUG or CONFIG_SLOB,
> > and blocks stop being aligned. Then developers have to devise workaround such
> > as own kmem caches with specified alignment [1], which is not always practical,
> > as recently evidenced in [2].
> > 
> > The topic has been discussed at LSF/MM 2019 [3]. Adding a 'kmalloc_aligned()'
> > variant would not help with code unknowingly relying on the implicit alignment.
> > For slab implementations it would either require creating more kmalloc caches,
> > or allocate a larger size and only give back part of it. That would be
> > wasteful, especially with a generic alignment parameter (in contrast with a
> > fixed alignment to size).
> > 
> > Ideally we should provide to mm users what they need without difficult
> > workarounds or own reimplementations, so let's make the kmalloc() alignment to
> > size explicitly guaranteed for power-of-two sizes under all configurations.
> > What this means for the three available allocators?
> > 
> > * SLAB object layout happens to be mostly unchanged by the patch. The
> >   implicitly provided alignment could be compromised with CONFIG_DEBUG_SLAB due
> >   to redzoning, however SLAB disables redzoning for caches with alignment
> >   larger than unsigned long long. Practically on at least x86 this includes
> >   kmalloc caches as they use cache line alignment, which is larger than that.
> >   Still, this patch ensures alignment on all arches and cache sizes.
> > 
> > * SLUB layout is also unchanged unless redzoning is enabled through
> >   CONFIG_SLUB_DEBUG and boot parameter for the particular kmalloc cache. With
> >   this patch, explicit alignment is guaranteed with redzoning as well. This
> >   will result in more memory being wasted, but that should be acceptable in a
> >   debugging scenario.
> > 
> > * SLOB has no implicit alignment so this patch adds it explicitly for
> >   kmalloc(). The potential downside is increased fragmentation. While
> >   pathological allocation scenarios are certainly possible, in my testing,
> >   after booting a x86_64 kernel+userspace with virtme, around 16MB memory
> >   was consumed by slab pages both before and after the patch, with difference
> >   in the noise.
> > 
> > [1] https://lore.kernel.org/linux-btrfs/c3157c8e8e0e7588312b40c853f65c02fe6c957a.1566399731.git.christophe.leroy@c-s.fr/
> > [2] https://lore.kernel.org/linux-fsdevel/20190225040904.5557-1-ming.lei@redhat.com/
> > [3] https://lwn.net/Articles/787740/
> > 
> > Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> 
> So if anyone thinks this is a good idea, please express it (preferably
> in a formal way such as Acked-by), otherwise it seems the patch will be
> dropped (due to a private NACK, apparently).

Sigh.

An existing code to workaround the lack of alignment guarantee just show
that this is necessary. And there wasn't any real technical argument
against except for a highly theoretical optimizations/new allocator that
would be tight by the guarantee.

Therefore
Acked-by: Michal Hocko <mhocko@suse.com>

-- 
Michal Hocko
SUSE Labs
