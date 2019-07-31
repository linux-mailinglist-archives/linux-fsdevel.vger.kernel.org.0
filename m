Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C69B67D10A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2019 00:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbfGaWUZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Jul 2019 18:20:25 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:58498 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726125AbfGaWUZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Jul 2019 18:20:25 -0400
Received: from dread.disaster.area (pa49-195-139-63.pa.nsw.optusnet.com.au [49.195.139.63])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id BE57336111A;
        Thu,  1 Aug 2019 08:20:18 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hswwB-00027e-CG; Thu, 01 Aug 2019 08:19:11 +1000
Date:   Thu, 1 Aug 2019 08:19:11 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Bob Kasten <robert.a.kasten@intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Chad Mynhier <chad.mynhier@oracle.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Johannes Weiner <jweiner@fb.com>
Subject: Re: [PATCH v3 0/2] mm,thp: Add filemap_huge_fault() for THP
Message-ID: <20190731221911.GA7689@dread.disaster.area>
References: <20190731082513.16957-1-william.kucharski@oracle.com>
 <20190731102053.GZ7689@dread.disaster.area>
 <20190731113221.GE4700@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731113221.GE4700@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=P6RKvmIu c=1 sm=1 tr=0 cx=a_idp_d
        a=fNT+DnnR6FjB+3sUuX8HHA==:117 a=fNT+DnnR6FjB+3sUuX8HHA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=FmdZ9Uzk2mMA:10
        a=7-415B0cAAAA:8 a=1UT5xkaULuNUDC-A2zkA:9 a=0OXPVnBbH5FFKjg_:21
        a=0NBTTMARi36R3mQB:21 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 31, 2019 at 04:32:21AM -0700, Matthew Wilcox wrote:
> On Wed, Jul 31, 2019 at 08:20:53PM +1000, Dave Chinner wrote:
> > On Wed, Jul 31, 2019 at 02:25:11AM -0600, William Kucharski wrote:
> > > This set of patches is the first step towards a mechanism for automatically
> > > mapping read-only text areas of appropriate size and alignment to THPs
> > > whenever possible.
> > > 
> > > For now, the central routine, filemap_huge_fault(), amd various support
> > > routines are only included if the experimental kernel configuration option
> > > 
> > > 	RO_EXEC_FILEMAP_HUGE_FAULT_THP
> > > 
> > > is enabled.
> > > 
> > > This is because filemap_huge_fault() is dependent upon the
> > > address_space_operations vector readpage() pointing to a routine that will
> > > read and fill an entire large page at a time without poulluting the page
> > > cache with PAGESIZE entries
> > 
> > How is the readpage code supposed to stuff a THP page into a bio?
> > 
> > i.e. Do bio's support huge pages, and if not, what is needed to
> > stuff a huge page in a bio chain?
> 
> I believe that the current BIO code (after Ming Lei's multipage patches
> from late last year / earlier this year) is capable of handling a
> PMD-sized page.
> 
> > Once you can answer that question, you should be able to easily
> > convert the iomap_readpage/iomap_readpage_actor code to support THP
> > pages without having to care about much else as iomap_readpage()
> > is already coded in a way that will iterate IO over the entire THP
> > for you....
> 
> Christoph drafted a patch which illustrates the changes needed to the
> iomap code.  The biggest problem is:
> 
> struct iomap_page {
>         atomic_t                read_count;
>         atomic_t                write_count;
>         DECLARE_BITMAP(uptodate, PAGE_SIZE / 512);
> };
> 
> All of a sudden that needs to go from a single unsigned long bitmap (or
> two on 64kB page size machines) to 512 bytes on x86 and even larger on,
> eg, POWER.

The struct iomap_page is dynamically allocated, so the bitmap itself
can be sized appropriate to the size of the page the structure is
being allocated for. The current code is simple because we have a
bound PAGE_SIZE so the structure size is always small.

Making it dynamically sized would also reduce the size of the bitmap
because it only needs to track filesystem blocks, not sectors. The
fact it is hard coded means it has to support the worst case of
tracking uptodata state for 512 byte block sizes, hence the "128
bits on 64k pages" static size.

i.e. huge pages on a 4k block size filesystem only requires 512
*bits* for a 2MB page, not 512 * 8 bits.  And when I get back to the
64k block size on 4k page size support for XFS+iomap, that will go
down even further. i.e. the huge page will only have to track 32
filesystem blocks, not 512, and we're back to fitting in the
existing static iomap_page....

So, yeah, I think the struct iomap_page needs to be dynamically
sized to support 2MB (or larger) pages effectively.

/me wonders what is necessary for page invalidation to work
correctly for these huge pages. e.g. someone does a direct IO
write to a range within a cached read only huge page....

Which reminds me, I bet there are assumptions in some of the iomap
code (or surrounding filesystem code) that assume if filesystem
block size = PAGE_SIZE there will be no iomap_page attached to the
page. And that if there is a iomap_page attached, then the block
size is < PAGE_SIZE. And do't make assumptions about block size
being <= PAGE_SIZE, as I have a patchset to support block size >
PAGE_SIZE for the iomap and XFS code which I'll be getting back to
Real Soon.

> It's egregious because no sane filesystem is going to fragment a PMD
> sized page into that number of discontiguous blocks,

It's not whether a sane filesytem will do that, the reality is that
it can happen and so it needs to work. Anyone using 512 byte block
size filesysetms and expecting PMD sized pages to be *efficient* has
rocks in their head. We just need to make it work.

> so we never need
> to allocate the 520 byte data structure this suddenly becomes.  It'd be
> nice to have a more efficient data structure (maybe that tracks uptodate
> by extent instead of by individual sector?)

Extents can still get fragmented, and we have to support the worst
case fragmentation that can occur. Which is single filesystem
blocks. And that fragmentation can change during the life of the
page (punch out blocks, allocate different ones, COW, etc) so we
have to allocate the worst case up front even if we rarely (if
ever!) need it.

> But I don't understand the
> iomap layer at all, and I never understood buggerheads, so I don't have
> a useful contribution here.

iomap is a whole lot easier - the only thing we need to track at the
"page cache" level is which parts of the page contain valid data and
that's what the struct iomap_page is for when more than one bit of
uptodate information needs to be stored. the iomap infrastructure
does everything else through the filesystem and so only requires the
caching layer to track the valid data ranges in each page...

IOWs, all we need to worry about for PMD faults in iomap is getting
the page sizes right, iterating IO ranges to fill/write back full
PMD pages and tracking uptodate state in the page on a filesystem
block granularity. Everything else should just work....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
