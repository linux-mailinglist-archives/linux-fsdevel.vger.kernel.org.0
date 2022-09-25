Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA1E5E96FB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Sep 2022 01:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbiIYXyR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Sep 2022 19:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiIYXyQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Sep 2022 19:54:16 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 24A0F23162;
        Sun, 25 Sep 2022 16:54:15 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-106-210.pa.nsw.optusnet.com.au [49.181.106.210])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id B069E1100D90;
        Mon, 26 Sep 2022 09:54:09 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ocbRn-00CADQ-Ot; Mon, 26 Sep 2022 09:54:07 +1000
Date:   Mon, 26 Sep 2022 09:54:07 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>, akpm@linux-foundation.org,
        Matthew Wilcox <willy@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 05/18] xfs: Add xfs_break_layouts() to the inode
 eviction path
Message-ID: <20220925235407.GA3600936@dread.disaster.area>
References: <20220918225731.GG3600936@dread.disaster.area>
 <632894c4738d8_2a6ded294a@dwillia2-xfh.jf.intel.com.notmuch>
 <20220919212959.GL3600936@dread.disaster.area>
 <6329ee04c9272_2a6ded294bf@dwillia2-xfh.jf.intel.com.notmuch>
 <20220921221416.GT3600936@dread.disaster.area>
 <YyuQI08LManypG6u@nvidia.com>
 <20220923001846.GX3600936@dread.disaster.area>
 <632d00a491d0d_4a67429488@dwillia2-xfh.jf.intel.com.notmuch>
 <20220923021012.GZ3600936@dread.disaster.area>
 <20220923093803.nroajmvn7twuptez@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220923093803.nroajmvn7twuptez@quack3>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=6330ea24
        a=j6JUzzrSC7wlfFge/rmVbg==:117 a=j6JUzzrSC7wlfFge/rmVbg==:17
        a=kj9zAlcOel0A:10 a=xOM3xZuef0cA:10 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8
        a=7-415B0cAAAA:8 a=6WIxVItXUT_raNPUQEAA:9 a=CjuIK1q_8ugA:10
        a=AjGcO6oz07-iQ99wixmX:22 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 23, 2022 at 11:38:03AM +0200, Jan Kara wrote:
> On Fri 23-09-22 12:10:12, Dave Chinner wrote:
> > On Thu, Sep 22, 2022 at 05:41:08PM -0700, Dan Williams wrote:
> > > Dave Chinner wrote:
> > > > On Wed, Sep 21, 2022 at 07:28:51PM -0300, Jason Gunthorpe wrote:
> > > > > On Thu, Sep 22, 2022 at 08:14:16AM +1000, Dave Chinner wrote:
> > > > > 
> > > > > > Where are these DAX page pins that don't require the pin holder to
> > > > > > also hold active references to the filesystem objects coming from?
> > > > > 
> > > > > O_DIRECT and things like it.
> > > > 
> > > > O_DIRECT IO to a file holds a reference to a struct file which holds
> > > > an active reference to the struct inode. Hence you can't reclaim an
> > > > inode while an O_DIRECT IO is in progress to it. 
> > > > 
> > > > Similarly, file-backed pages pinned from user vmas have the inode
> > > > pinned by the VMA having a reference to the struct file passed to
> > > > them when they are instantiated. Hence anything using mmap() to pin
> > > > file-backed pages (i.e. applications using FSDAX access from
> > > > userspace) should also have a reference to the inode that prevents
> > > > the inode from being reclaimed.
> > > > 
> > > > So I'm at a loss to understand what "things like it" might actually
> > > > mean. Can you actually describe a situation where we actually permit
> > > > (even temporarily) these use-after-free scenarios?
> > > 
> > > Jason mentioned a scenario here:
> > > 
> > > https://lore.kernel.org/all/YyuoE8BgImRXVkkO@nvidia.com/
> > > 
> > > Multi-thread process where thread1 does open(O_DIRECT)+mmap()+read() and
> > > thread2 does memunmap()+close() while the read() is inflight.
> > 
> > And, ah, what production application does this and expects to be
> > able to process the result of the read() operation without getting a
> > SEGV?
> > 
> > There's a huge difference between an unlikely scenario which we need
> > to work (such as O_DIRECT IO to/from a mmap() buffer at a different
> > offset on the same file) and this sort of scenario where even if we
> > handle it correctly, the application can't do anything with the
> > result and will crash immediately....
> 
> I'm not sure I fully follow what we are concerned about here. As you've
> written above direct IO holds reference to the inode until it is completed
> (through kiocb->file->inode chain). So direct IO should be safe?

AFAICT, it's the user buffer allocated by mmap() that the direct IO
is DMAing into/out of that is the issue here. i.e. mmap() a file
that is DAX enabled, pass the mmap region to DIO on a non-dax file,
GUP in the DIO path takes a page pin on user pages that are DAX
mapped, the userspace application then unmaps the file pages and
unlinks the FSDAX file.

At this point the FSDAX mapped inode has no active references, so
the filesystem frees the inode and it's allocated storage space, and
now the DIO or whatever is holding the GUP reference is
now a moving storage UAF violation. What ever is holding the GUP
reference doesn't even have a reference to the FSDAX filesystem -
the DIO fd could point to a file in a different filesystem
altogether - and so the fsdax filesytem could be unmounted at this
point whilst the application is still actively using the storage
underlying the filesystem.

That's just .... broken.

> I'd be more worried about stuff like vmsplice() that can add file pages
> into pipe without holding inode alive in any way and keeping them there for
> arbitrarily long time. Didn't we want to add FOLL_LONGTERM to gup executed
> from vmsplice() to avoid issues like this?

Yes, ISTR that was part of the plan - use FOLL_LONGTERM to ensure
FSDAX can't run operations that pin pages but don't take fs
references. I think that's how we prevented RDMA users from pinning
FSDAX direct mapped storage media in this way. It does not, however,
prevent the above "short term" GUP UAF situation from occurring.

> > > Sounds plausible to me, but I have not tried to trigger it with a focus
> > > test.
> > 
> > If there really are applications this .... broken, then it's not the
> > responsibility of the filesystem to paper over the low level page
> > reference tracking issues that cause it.
> > 
> > i.e. The underlying problem here is that memunmap() frees the VMA
> > while there are still active task-based references to the pages in
> > that VMA. IOWs, the VMA should not be torn down until the O_DIRECT
> > read has released all the references to the pages mapped into the
> > task address space.
> > 
> > This just doesn't seem like an issue that we should be trying to fix
> > by adding band-aids to the inode life-cycle management.
> 
> I agree that freeing VMA while there are pinned pages is ... inconvenient.
> But that is just how gup works since the beginning - the moment you have
> struct page reference, you completely forget about the mapping you've used
> to get to the page. So anything can happen with the mapping after that
> moment. And in case of pages mapped by multiple processes I can easily see
> that one of the processes decides to unmap the page (and it may well be
> that was the initial process that acquired page references) while others
> still keep accessing the page using page references stored in some internal
> structure (RDMA anyone?).

Yup, and this is why RDMA on FSDAX using this method of pinning pages
will end up corrupting data and filesystems, hence FOLL_LONGTERM
protecting against most of these situations from even arising. But
that's that workaround, not a long term solution that allows RDMA to
be run on FSDAX managed storage media.

I said on #xfs a few days ago:

[23/9/22 10:23] * dchinner is getting deja vu over this latest round
of "dax mappings don't pin the filesystem objects that own the
storage media being mapped"

And I'm getting that feeling again right now...

> I think it will be rather difficult to come up
> with some scheme keeping VMA alive while there are pages pinned without
> regressing userspace which over the years became very much tailored to the
> peculiar gup behavior.

Perhaps all we should do is add a page flag for fsdax mapped pages
that says GUP must pin the VMA, so only mapped pages that fall into
this category take the perf penalty of VMA management.

> I can imagine we would keep *inode* referenced while there are its pages
> pinned.

We can do that by pinning the VMA, yes?

> That should not be that difficult but at least in naive
> implementation that would put rather heavy stress on inode refcount under
> some loads so I don't think that's useful either.

Having the workaround be sub-optimal for high performance workloads
is a good way of discouraging applications from doing fundamentally
broken crap without actually breaking anything....

-Dave.

-- 
Dave Chinner
david@fromorbit.com
