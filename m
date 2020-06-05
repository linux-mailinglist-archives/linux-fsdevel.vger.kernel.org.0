Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1879C1EEF0D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jun 2020 03:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgFEBak (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Jun 2020 21:30:40 -0400
Received: from mail106.syd.optusnet.com.au ([211.29.132.42]:50240 "EHLO
        mail106.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726060AbgFEBaj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Jun 2020 21:30:39 -0400
Received: from dread.disaster.area (pa49-180-124-177.pa.nsw.optusnet.com.au [49.180.124.177])
        by mail106.syd.optusnet.com.au (Postfix) with ESMTPS id CA2095AB25B;
        Fri,  5 Jun 2020 11:30:32 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jh1Bf-00026O-Bh; Fri, 05 Jun 2020 11:30:23 +1000
Date:   Fri, 5 Jun 2020 11:30:23 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Ruan Shiyang <ruansy.fnst@cn.fujitsu.com>,
        Matthew Wilcox <willy@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "hch@lst.de" <hch@lst.de>, "rgoldwyn@suse.de" <rgoldwyn@suse.de>,
        "Qi, Fuli" <qi.fuli@fujitsu.com>,
        "Gotou, Yasunori" <y-goto@fujitsu.com>
Subject: Re: =?utf-8?B?5Zue5aSNOiBSZQ==?= =?utf-8?Q?=3A?= [RFC PATCH 0/8]
 dax: Add a dax-rmap tree to support reflink
Message-ID: <20200605013023.GZ2040@dread.disaster.area>
References: <20200427084750.136031-1-ruansy.fnst@cn.fujitsu.com>
 <20200427122836.GD29705@bombadil.infradead.org>
 <em33c55fa5-15ca-4c46-8c27-6b0300fa4e51@g08fnstd180058>
 <20200428064318.GG2040@dread.disaster.area>
 <153e13e6-8685-fb0d-6bd3-bb553c06bf51@cn.fujitsu.com>
 <20200604145107.GA1334206@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200604145107.GA1334206@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
        a=k3aV/LVJup6ZGWgigO6cSA==:117 a=k3aV/LVJup6ZGWgigO6cSA==:17
        a=IkcTkHD0fZMA:10 a=nTHF0DUjJn0A:10 a=5KLPUuaC_9wA:10 a=JfrnYn6hAAAA:8
        a=7-415B0cAAAA:8 a=Ta0clAhtVI-YSBJ3DlQA:9 a=J8Q19hsgq330FmqU:21
        a=uNIap141QPGCy0-l:21 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 04, 2020 at 07:51:07AM -0700, Darrick J. Wong wrote:
> On Thu, Jun 04, 2020 at 03:37:42PM +0800, Ruan Shiyang wrote:
> > 
> > 
> > On 2020/4/28 下午2:43, Dave Chinner wrote:
> > > On Tue, Apr 28, 2020 at 06:09:47AM +0000, Ruan, Shiyang wrote:
> > > > 
> > > > 在 2020/4/27 20:28:36, "Matthew Wilcox" <willy@infradead.org> 写道:
> > > > 
> > > > > On Mon, Apr 27, 2020 at 04:47:42PM +0800, Shiyang Ruan wrote:
> > > > > >   This patchset is a try to resolve the shared 'page cache' problem for
> > > > > >   fsdax.
> > > > > > 
> > > > > >   In order to track multiple mappings and indexes on one page, I
> > > > > >   introduced a dax-rmap rb-tree to manage the relationship.  A dax entry
> > > > > >   will be associated more than once if is shared.  At the second time we
> > > > > >   associate this entry, we create this rb-tree and store its root in
> > > > > >   page->private(not used in fsdax).  Insert (->mapping, ->index) when
> > > > > >   dax_associate_entry() and delete it when dax_disassociate_entry().
> > > > > 
> > > > > Do we really want to track all of this on a per-page basis?  I would
> > > > > have thought a per-extent basis was more useful.  Essentially, create
> > > > > a new address_space for each shared extent.  Per page just seems like
> > > > > a huge overhead.
> > > > > 
> > > > Per-extent tracking is a nice idea for me.  I haven't thought of it
> > > > yet...
> > > > 
> > > > But the extent info is maintained by filesystem.  I think we need a way
> > > > to obtain this info from FS when associating a page.  May be a bit
> > > > complicated.  Let me think about it...
> > > 
> > > That's why I want the -user of this association- to do a filesystem
> > > callout instead of keeping it's own naive tracking infrastructure.
> > > The filesystem can do an efficient, on-demand reverse mapping lookup
> > > from it's own extent tracking infrastructure, and there's zero
> > > runtime overhead when there are no errors present.
> > 
> > Hi Dave,
> > 
> > I ran into some difficulties when trying to implement the per-extent rmap
> > tracking.  So, I re-read your comments and found that I was misunderstanding
> > what you described here.
> > 
> > I think what you mean is: we don't need the in-memory dax-rmap tracking now.
> > Just ask the FS for the owner's information that associate with one page
> > when memory-failure.  So, the per-page (even per-extent) dax-rmap is
> > needless in this case.  Is this right?
> 
> Right.  XFS already has its own rmap tree.

*nod*

> > Based on this, we only need to store the extent information of a fsdax page
> > in its ->mapping (by searching from FS).  Then obtain the owners of this
> > page (also by searching from FS) when memory-failure or other rmap case
> > occurs.
> 
> I don't even think you need that much.  All you need is the "physical"
> offset of that page within the pmem device (e.g. 'this is the 307th 4k
> page == offset 1257472 since the start of /dev/pmem0') and xfs can look
> up the owner of that range of physical storage and deal with it as
> needed.

Right. If we have the dax device associated with the page that had
the failure, then we can determine the offset of the page into the
block device address space and that's all we need to find the owner
of the page in the filesystem.

Note that there may actually be no owner - the page that had the
fault might land in free space, in which case we can simply zero
the page and clear the error.

> > So, a fsdax page is no longer associated with a specific file, but with a
> > FS(or the pmem device).  I think it's easier to understand and implement.

Effectively, yes. But we shouldn't need to actually associate the
page with anything at the filesystem level because it is already
associated with a DAX device at a lower level via a dev_pagemap.
The hardware page fault already runs thought this code
memory_failure_dev_pagemap() before it gets to the DAX code, so
really all we need to is have that function pass us the page, offset
into the device and, say, the struct dax_device associated with that
page so we can get to the filesystem superblock we can then use for
rmap lookups on...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
