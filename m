Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5190A0AAD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2019 21:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfH1TqO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Aug 2019 15:46:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60686 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbfH1TqO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Aug 2019 15:46:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=hgz1R5QUT/3HwdqWiBoXJEjgsTAkIAv2dRGNBsyqnxk=; b=Rm8Ri2tEMBapDNdB3tS8NGKJBM
        z5Rq8Hj5vRSAxcFpyrTIzaG/+MT4NsQnvWV7/mV2hJF6gRa7y6uflXN/pKocPsEW3+1uIDcqhDT/d
        nVn5GK/ST6ZnS4k1deCvzxjlhOzDyvPUBhbmsaCbiqSy4yWGM5TlmlSbxvkYeV7PUGjKfq11w4O6d
        B6K21kFHA5FEY7Y5poC9Rbup6llyf0SFLQyUZGcPNKUtyKUUKmtqXMwj9rmC4ynL+BB6is1FCaG0v
        5RDdSskGb5hOH0jTQ1cq94H/Lpm3HBF4RN3Hl/sqRH3RcAUqISgadxnEhq3e2+jm9c50kgmalm08Y
        v6mF9MJw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i33tQ-0004Z6-3n; Wed, 28 Aug 2019 19:46:08 +0000
Date:   Wed, 28 Aug 2019 12:46:08 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Christopher Lameter <cl@linux.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Ming Lei <ming.lei@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mm, sl[aou]b: guarantee natural alignment for
 kmalloc(power-of-two)
Message-ID: <20190828194607.GB6590@bombadil.infradead.org>
References: <20190826111627.7505-1-vbabka@suse.cz>
 <20190826111627.7505-3-vbabka@suse.cz>
 <0100016cd98bb2c1-a2af7539-706f-47ba-a68e-5f6a91f2f495-000000@email.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0100016cd98bb2c1-a2af7539-706f-47ba-a68e-5f6a91f2f495-000000@email.amazonses.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 28, 2019 at 06:45:07PM +0000, Christopher Lameter wrote:
> > Ideally we should provide to mm users what they need without difficult
> > workarounds or own reimplementations, so let's make the kmalloc() alignment to
> > size explicitly guaranteed for power-of-two sizes under all configurations.
> 
> The objection remains that this will create exceptions for the general
> notion that all kmalloc caches are aligned to KMALLOC_MINALIGN which may

Hmm?  kmalloc caches will be aligned to both KMALLOC_MINALIGN and the
natural alignment of the object.

> be suprising and it limits the optimizations that slab allocators may use
> for optimizing data use. The SLOB allocator was designed in such a way
> that data wastage is limited. The changes here sabotage that goal and show
> that future slab allocators may be similarly constrained with the
> exceptional alignents implemented. Additional debugging features etc etc
> must all support the exceptional alignment requirements.

While I sympathise with the poor programmer who has to write the
fourth implementation of the sl*b interface, it's more for the pain of
picking a new letter than the pain of needing to honour the alignment
of allocations.

There are many places in the kernel which assume alignment.  They break
when it's not supplied.  I believe we have a better overall system if
the MM developers provide stronger guarantees than the MM consumers have
to work around only weak guarantees.

> > * SLOB has no implicit alignment so this patch adds it explicitly for
> >   kmalloc(). The potential downside is increased fragmentation. While
> >   pathological allocation scenarios are certainly possible, in my testing,
> >   after booting a x86_64 kernel+userspace with virtme, around 16MB memory
> >   was consumed by slab pages both before and after the patch, with difference
> >   in the noise.
> 
> This change to slob will cause a significant additional use of memory. The
> advertised advantage of SLOB is that *minimal* memory will be used since
> it is targeted for embedded systems. Different types of slab objects of
> varying sizes can be allocated in the same memory page to reduce
> allocation overhead.

Did you not read the part where he said the difference was in the noise?

> The result of this patch is just to use more memory to be safe from
> certain pathologies where one subsystem was relying on an alignment that
> was not specified. That is why this approach should not be called
> �natural" but "implicit alignment". The one using the slab cache is not
> aware that the slab allocator provides objects aligned in a special way
> (which is in general not needed. There seems to be a single pathological
> case that needs to be addressed and I thought that was due to some
> brokenness in the hardware?).

It turns out there are lots of places which assume this, including the
pmem driver, the ramdisk driver and a few other similar drivers.

> It is better to ensure that subsystems that require special alignment
> explicitly tell the allocator about this.

But it's not the subsystems which have this limitation which do the
allocation; it's the subsystems who allocate the memory that they then
pass to the subsystems.  So you're forcing communication of these limits
up & down the stack.

> I still think implicit exceptions to alignments are a bad idea. Those need
> to be explicity specified and that is possible using kmem_cache_create().

I swear we covered this last time the topic came up, but XFS would need
to create special slab caches for each size between 512 and PAGE_SIZE.
Potentially larger, depending on whether the MM developers are willing to
guarantee that kmalloc(PAGE_SIZE * 2, GFP_KERNEL) will return a PAGE_SIZE
aligned block of memory indefinitely.
