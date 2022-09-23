Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0DF5E71C2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Sep 2022 04:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbiIWCKU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Sep 2022 22:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232173AbiIWCKT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Sep 2022 22:10:19 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 69F2A81685;
        Thu, 22 Sep 2022 19:10:16 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-106-210.pa.nsw.optusnet.com.au [49.181.106.210])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id C1A911100A56;
        Fri, 23 Sep 2022 12:10:14 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1obY8q-00B1Gp-Qs; Fri, 23 Sep 2022 12:10:12 +1000
Date:   Fri, 23 Sep 2022 12:10:12 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, akpm@linux-foundation.org,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 05/18] xfs: Add xfs_break_layouts() to the inode
 eviction path
Message-ID: <20220923021012.GZ3600936@dread.disaster.area>
References: <166329930818.2786261.6086109734008025807.stgit@dwillia2-xfh.jf.intel.com>
 <166329933874.2786261.18236541386474985669.stgit@dwillia2-xfh.jf.intel.com>
 <20220918225731.GG3600936@dread.disaster.area>
 <632894c4738d8_2a6ded294a@dwillia2-xfh.jf.intel.com.notmuch>
 <20220919212959.GL3600936@dread.disaster.area>
 <6329ee04c9272_2a6ded294bf@dwillia2-xfh.jf.intel.com.notmuch>
 <20220921221416.GT3600936@dread.disaster.area>
 <YyuQI08LManypG6u@nvidia.com>
 <20220923001846.GX3600936@dread.disaster.area>
 <632d00a491d0d_4a67429488@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <632d00a491d0d_4a67429488@dwillia2-xfh.jf.intel.com.notmuch>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=632d1587
        a=j6JUzzrSC7wlfFge/rmVbg==:117 a=j6JUzzrSC7wlfFge/rmVbg==:17
        a=kj9zAlcOel0A:10 a=xOM3xZuef0cA:10 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8
        a=7-415B0cAAAA:8 a=-v9MXSeZNPeA8zCCQKoA:9 a=CjuIK1q_8ugA:10
        a=AjGcO6oz07-iQ99wixmX:22 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 22, 2022 at 05:41:08PM -0700, Dan Williams wrote:
> Dave Chinner wrote:
> > On Wed, Sep 21, 2022 at 07:28:51PM -0300, Jason Gunthorpe wrote:
> > > On Thu, Sep 22, 2022 at 08:14:16AM +1000, Dave Chinner wrote:
> > > 
> > > > Where are these DAX page pins that don't require the pin holder to
> > > > also hold active references to the filesystem objects coming from?
> > > 
> > > O_DIRECT and things like it.
> > 
> > O_DIRECT IO to a file holds a reference to a struct file which holds
> > an active reference to the struct inode. Hence you can't reclaim an
> > inode while an O_DIRECT IO is in progress to it. 
> > 
> > Similarly, file-backed pages pinned from user vmas have the inode
> > pinned by the VMA having a reference to the struct file passed to
> > them when they are instantiated. Hence anything using mmap() to pin
> > file-backed pages (i.e. applications using FSDAX access from
> > userspace) should also have a reference to the inode that prevents
> > the inode from being reclaimed.
> > 
> > So I'm at a loss to understand what "things like it" might actually
> > mean. Can you actually describe a situation where we actually permit
> > (even temporarily) these use-after-free scenarios?
> 
> Jason mentioned a scenario here:
> 
> https://lore.kernel.org/all/YyuoE8BgImRXVkkO@nvidia.com/
> 
> Multi-thread process where thread1 does open(O_DIRECT)+mmap()+read() and
> thread2 does memunmap()+close() while the read() is inflight.

And, ah, what production application does this and expects to be
able to process the result of the read() operation without getting a
SEGV?

There's a huge difference between an unlikely scenario which we need
to work (such as O_DIRECT IO to/from a mmap() buffer at a different
offset on the same file) and this sort of scenario where even if we
handle it correctly, the application can't do anything with the
result and will crash immediately....

> Sounds plausible to me, but I have not tried to trigger it with a focus
> test.

If there really are applications this .... broken, then it's not the
responsibility of the filesystem to paper over the low level page
reference tracking issues that cause it.

i.e. The underlying problem here is that memunmap() frees the VMA
while there are still active task-based references to the pages in
that VMA. IOWs, the VMA should not be torn down until the O_DIRECT
read has released all the references to the pages mapped into the
task address space.

This just doesn't seem like an issue that we should be trying to fix
by adding band-aids to the inode life-cycle management.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
