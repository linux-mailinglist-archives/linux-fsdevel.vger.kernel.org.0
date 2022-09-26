Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 873595E976F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Sep 2022 02:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233215AbiIZAhL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Sep 2022 20:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233245AbiIZAgx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Sep 2022 20:36:53 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1ABEA2EF07;
        Sun, 25 Sep 2022 17:35:56 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-106-210.pa.nsw.optusnet.com.au [49.181.106.210])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id C06F01101031;
        Mon, 26 Sep 2022 10:34:31 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1occ4s-00CB1p-34; Mon, 26 Sep 2022 10:34:30 +1000
Date:   Mon, 26 Sep 2022 10:34:30 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, akpm@linux-foundation.org,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 05/18] xfs: Add xfs_break_layouts() to the inode
 eviction path
Message-ID: <20220926003430.GB3600936@dread.disaster.area>
References: <20220918225731.GG3600936@dread.disaster.area>
 <632894c4738d8_2a6ded294a@dwillia2-xfh.jf.intel.com.notmuch>
 <20220919212959.GL3600936@dread.disaster.area>
 <6329ee04c9272_2a6ded294bf@dwillia2-xfh.jf.intel.com.notmuch>
 <20220921221416.GT3600936@dread.disaster.area>
 <YyuQI08LManypG6u@nvidia.com>
 <20220923001846.GX3600936@dread.disaster.area>
 <632d00a491d0d_4a67429488@dwillia2-xfh.jf.intel.com.notmuch>
 <20220923021012.GZ3600936@dread.disaster.area>
 <Yy2pC/upZNEkVmc5@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yy2pC/upZNEkVmc5@nvidia.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=6330f398
        a=j6JUzzrSC7wlfFge/rmVbg==:117 a=j6JUzzrSC7wlfFge/rmVbg==:17
        a=kj9zAlcOel0A:10 a=xOM3xZuef0cA:10 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8
        a=7-415B0cAAAA:8 a=KjmkecRBzVTVnQtmf_MA:9 a=CjuIK1q_8ugA:10
        a=AjGcO6oz07-iQ99wixmX:22 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 23, 2022 at 09:39:39AM -0300, Jason Gunthorpe wrote:
> On Fri, Sep 23, 2022 at 12:10:12PM +1000, Dave Chinner wrote:
> 
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
> 
> The read() will do GUP and get a pined page, next the memunmap()/close
> will release the inode the VMA was holding open. The read() FD is NOT
> a DAX FD.
>
> We are now UAFing the DAX storage. There is no SEGV.

Yes, but what happens *after* the read().

The userspace application now tries to access the mmap() region to
access the data that was read, only to find that it's been unmapped.
That triggers a SEGV, yes?

IOWs, there's nothing *useful* a user application can do with a
pattern like this. All it provides is a vector for UAF of the DAX
storage. Now replace the read() with write(), and tell me why this
can't cause data corruption and/or fatal filesystem corruption that
can take the entire system down.....

> It is not about sane applications, it is about kernel security against
> hostile userspace.

Turning this into a UAF doesn't provide any security at all. It
makes this measurable worse from a security POV as it provides a
channel for data leakage (read() case) or system unstability or
compromise (the write() case).

> > i.e. The underlying problem here is that memunmap() frees the VMA
> > while there are still active task-based references to the pages in
> > that VMA. IOWs, the VMA should not be torn down until the O_DIRECT
> > read has released all the references to the pages mapped into the
> > task address space.
> 
> This is Jan's suggestion, I think we are still far from being able to
> do that for O_DIRECT paths.
> 
> Even if you fix the close() this way, doesn't truncate still have the
> same problem?

It sure does. Also fallocate().

The deja vu is strong right now.

If something truncate()s a file, the only safe thing for an
application that is using fsdax to directly access the underying
storage is to unmap the file and remap it once the layout change
operation has completed.

We've been doing this safely with pNFS for remote RDMA-based
direct access to the storage hardware for years. We have the
layout lease infrastructure already there for it...

I've pointed this out every time this conversation comes up. We have
a solution for this problem pretty much ready to go - it just needs
a UAPI to be defined for it. i.e. nothing has changed in the past 5
years - we have the same problems, we have the same solutions ready
to be hooked up and used....

> At the end of the day the rule is a DAX page must not be re-used until
> its refcount is 0. At some point the FS should wait for.

The page is *not owned by DAX*. How many times do I have to say that
FSDAX != DAX.

The *storage media* must not be reused until the filesystem says it
can be reused. And for that to work, nothing is allowed to keep an
anonymous, non-filesystem reference to the storage media. It has
nothing to do with struct page reference counts, and everything to
do with ensuring that filesystem objects are correctly referenced
while the storage media is in direct use by an application.

I gave up on FSDAX years ago because nobody was listening to me.
Here we are again, years down the track, with exactly the same
issues as we had years ago, with exactly the same people repeating
the same arguments for and against fixing the page reference
problems. I don't have time to repeat history all over again, so
I'm going to walk away from this train-wreck again so I can maintain
some semblence of my remaining sanity....

-Dave.
-- 
Dave Chinner
david@fromorbit.com
