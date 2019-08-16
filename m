Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBC259058B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2019 18:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbfHPQOY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Aug 2019 12:14:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:45384 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726550AbfHPQOY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Aug 2019 12:14:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BDA24ABF6;
        Fri, 16 Aug 2019 16:14:21 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id F03601E4009; Fri, 16 Aug 2019 18:13:55 +0200 (CEST)
Date:   Fri, 16 Aug 2019 18:13:55 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     Jan Kara <jack@suse.cz>, Vlastimil Babka <vbabka@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] mm/gup: introduce vaddr_pin_pages_remote()
Message-ID: <20190816161355.GL3041@quack2.suse.cz>
References: <a1044a0d-059c-f347-bd68-38be8478bf20@nvidia.com>
 <90e5cd11-fb34-6913-351b-a5cc6e24d85d@nvidia.com>
 <20190814234959.GA463@iweiny-DESK2.sc.intel.com>
 <2cbdf599-2226-99ae-b4d5-8909a0a1eadf@nvidia.com>
 <ac834ac6-39bd-6df9-fca4-70b9520b6c34@nvidia.com>
 <20190815132622.GG14313@quack2.suse.cz>
 <20190815133510.GA21302@quack2.suse.cz>
 <0d6797d8-1e04-1ebe-80a7-3d6895fe71b0@suse.cz>
 <20190816154404.GF3041@quack2.suse.cz>
 <20190816155220.GC3149@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816155220.GC3149@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 16-08-19 11:52:20, Jerome Glisse wrote:
> On Fri, Aug 16, 2019 at 05:44:04PM +0200, Jan Kara wrote:
> > On Fri 16-08-19 10:47:21, Vlastimil Babka wrote:
> > > On 8/15/19 3:35 PM, Jan Kara wrote:
> > > >> 
> > > >> So when the GUP user uses MMU notifiers to stop writing to pages whenever
> > > >> they are writeprotected with page_mkclean(), they don't really need page
> > > >> pin - their access is then fully equivalent to any other mmap userspace
> > > >> access and filesystem knows how to deal with those. I forgot out this case
> > > >> when I wrote the above sentence.
> > > >> 
> > > >> So to sum up there are three cases:
> > > >> 1) DIO case - GUP references to pages serving as DIO buffers are needed for
> > > >>    relatively short time, no special synchronization with page_mkclean() or
> > > >>    munmap() => needs FOLL_PIN
> > > >> 2) RDMA case - GUP references to pages serving as DMA buffers needed for a
> > > >>    long time, no special synchronization with page_mkclean() or munmap()
> > > >>    => needs FOLL_PIN | FOLL_LONGTERM
> > > >>    This case has also a special case when the pages are actually DAX. Then
> > > >>    the caller additionally needs file lease and additional file_pin
> > > >>    structure is used for tracking this usage.
> > > >> 3) ODP case - GUP references to pages serving as DMA buffers, MMU notifiers
> > > >>    used to synchronize with page_mkclean() and munmap() => normal page
> > > >>    references are fine.
> > > 
> > > IMHO the munlock lesson told us about another one, that's in the end equivalent
> > > to 3)
> > > 
> > > 4) pinning for struct page manipulation only => normal page references
> > > are fine
> > 
> > Right, it's good to have this for clarity.
> > 
> > > > I want to add that I'd like to convert users in cases 1) and 2) from using
> > > > GUP to using differently named function. Users in case 3) can stay as they
> > > > are for now although ultimately I'd like to denote such use cases in a
> > > > special way as well...
> > > 
> > > So after 1/2/3 is renamed/specially denoted, only 4) keeps the current
> > > interface?
> > 
> > Well, munlock() code doesn't even use GUP, just follow_page(). I'd wait to
> > see what's left after handling cases 1), 2), and 3) to decide about the
> > interface for the remainder.
> > 
> 
> For 3 we do not need to take a reference at all :) So just forget about 3
> it does not exist. For 3 the reference is the reference the CPU page table
> has on the page and that's it. GUP is no longer involve in ODP or anything
> like that.

Yes, I understand. But the fact is that GUP calls are currently still there
e.g. in ODP code. If you can make the code work without taking a page
reference at all, I'm only happy :)

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
