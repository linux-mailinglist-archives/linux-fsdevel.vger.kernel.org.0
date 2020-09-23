Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB7A2754FA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Sep 2020 11:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgIWJ5t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Sep 2020 05:57:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:52714 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726674AbgIWJ5m (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Sep 2020 05:57:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4DCB9AFFB;
        Wed, 23 Sep 2020 09:58:17 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 968EF1E12E3; Wed, 23 Sep 2020 11:57:39 +0200 (CEST)
Date:   Wed, 23 Sep 2020 11:57:39 +0200
From:   Jan Kara <jack@suse.cz>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Eric Sandeen <esandeen@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        "Kani, Toshi" <toshi.kani@hpe.com>,
        "Norton, Scott J" <scott.norton@hpe.com>,
        "Tadakamadla, Rajesh (DCIG/CDI/HPS Perf)" 
        <rajesh.tadakamadla@hpe.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Subject: Re: NVFS XFS metadata (was: [PATCH] pmem: export the symbols
 __copy_user_flushcache and __copy_from_user_flushcache)
Message-ID: <20200923095739.GC6719@quack2.suse.cz>
References: <alpine.LRH.2.02.2009151216050.16057@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2009151332280.3851@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2009160649560.20720@file01.intranet.prod.int.rdu2.redhat.com>
 <CAPcyv4gW6AvR+RaShHdQzOaEPv9nrq5myXDmywuoCTYDZxk-hw@mail.gmail.com>
 <alpine.LRH.2.02.2009161254400.745@file01.intranet.prod.int.rdu2.redhat.com>
 <CAPcyv4gD0ZFkfajKTDnJhEEjf+5Av-GH+cHRFoyhzGe8bNEgAA@mail.gmail.com>
 <alpine.LRH.2.02.2009161359540.20710@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2009191336380.3478@file01.intranet.prod.int.rdu2.redhat.com>
 <20200922050314.GB12096@dread.disaster.area>
 <alpine.LRH.2.02.2009220815420.16480@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2009220815420.16480@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 22-09-20 12:46:05, Mikulas Patocka wrote:
> > mapping 2^21 blocks requires a 5 level indirect tree. Which one if going 
> > to be faster to truncate away - a single record or 2 million individual 
> > blocks?
> > 
> > IOWs, we can take afford to take an extra cacheline miss or two on a
> > tree block search, because we're accessing and managing orders of
> > magnitude fewer records in the mapping tree than an indirect block
> > tree.
> > 
> > PMEM doesn't change this: extents are more time and space efficient
> > at scale for mapping trees than indirect block trees regardless
> > of the storage medium in use.
> 
> PMEM doesn't have to be read linearly, so the attempts to allocate large 
> linear space are not needed. They won't harm but they won't help either.
> 
> That's why NVFS has very simple block allocation alrogithm - it uses a 
> per-cpu pointer and tries to allocate by a bit scan from this pointer. If 
> the group is full, it tries a random group with above-average number of 
> free blocks.

I agree with Dave here. People are interested in 2MB or 1GB contiguous
allocations for DAX so that files can be mapped at PMD or event PUD levels
thus saving a lot of CPU time on page faults and TLB.

> EXT4 uses bit scan for allocations and people haven't complained that it's 
> inefficient, so it is probably OK.

Yes, it is more or less OK but once you get to 1TB filesystem size and
larger, the number of block groups grows enough that it isn't that great
anymore. We are actually considering new allocation schemes for ext4 for
this large filesystems...

> If you think that the lack of journaling is show-stopper, I can implement 
> it. But then, I'll have something that has complexity of EXT4 and 
> performance of EXT4. So that there will no longer be any reason why to use 
> NVFS over EXT4. Without journaling, it will be faster than EXT4 and it may 
> attract some users who want good performance and who don't care about GID 
> and UID being updated atomically, etc.

I'd hope that your filesystem offers more performance benefits than just
what you can get from a lack of journalling :). ext4 can be configured to
run without a journal as well - mkfs.ext4 -O ^has_journal. And yes, it does
significantly improve performance for some workloads but you have to have
some way to recover from crashes so it's mostly used for scratch
filesystems (e.g. in build systems, Google uses this feature a lot for some
of their infrastructure as well).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
