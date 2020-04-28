Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54B291BBC5C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 13:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgD1LYt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 07:24:49 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:45524 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726482AbgD1LYs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 07:24:48 -0400
Received: from dread.disaster.area (pa49-195-157-175.pa.nsw.optusnet.com.au [49.195.157.175])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id C431082144B;
        Tue, 28 Apr 2020 21:24:42 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jTOLx-0004Ur-Rg; Tue, 28 Apr 2020 21:24:41 +1000
Date:   Tue, 28 Apr 2020 21:24:41 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Ruan Shiyang <ruansy.fnst@cn.fujitsu.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "hch@lst.de" <hch@lst.de>, "rgoldwyn@suse.de" <rgoldwyn@suse.de>,
        "Qi, Fuli" <qi.fuli@fujitsu.com>,
        "Gotou, Yasunori" <y-goto@fujitsu.com>
Subject: Re: =?utf-8?B?5Zue5aSNOiBSZQ==?= =?utf-8?Q?=3A?= [RFC PATCH 0/8]
 dax: Add a dax-rmap tree to support reflink
Message-ID: <20200428112441.GH2040@dread.disaster.area>
References: <20200427084750.136031-1-ruansy.fnst@cn.fujitsu.com>
 <20200427122836.GD29705@bombadil.infradead.org>
 <em33c55fa5-15ca-4c46-8c27-6b0300fa4e51@g08fnstd180058>
 <20200428064318.GG2040@dread.disaster.area>
 <259fe633-e1ff-b279-cd8c-1a81eaa40941@cn.fujitsu.com>
 <20200428111636.GK29705@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200428111636.GK29705@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
        a=ONQRW0k9raierNYdzxQi9Q==:117 a=ONQRW0k9raierNYdzxQi9Q==:17
        a=IkcTkHD0fZMA:10 a=cl8xLZFz6L8A:10 a=5KLPUuaC_9wA:10 a=JfrnYn6hAAAA:8
        a=7-415B0cAAAA:8 a=cxSUJwBmEXFeedIZ3DoA:9 a=QEXdDO2ut3YA:10
        a=1CNFftbPRP8L7MoqJWF3:22 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 28, 2020 at 04:16:36AM -0700, Matthew Wilcox wrote:
> On Tue, Apr 28, 2020 at 05:32:41PM +0800, Ruan Shiyang wrote:
> > On 2020/4/28 下午2:43, Dave Chinner wrote:
> > > On Tue, Apr 28, 2020 at 06:09:47AM +0000, Ruan, Shiyang wrote:
> > > > 在 2020/4/27 20:28:36, "Matthew Wilcox" <willy@infradead.org> 写道:
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
> > > 
> > > At the moment, this "dax association" is used to "report" a storage
> > > media error directly to userspace. I say "report" because what it
> > > does is kill userspace processes dead. The storage media error
> > > actually needs to be reported to the owner of the storage media,
> > > which in the case of FS-DAX is the filesytem.
> > 
> > Understood.
> > 
> > BTW, this is the usage in memory-failure, so what about rmap?  I have not
> > found how to use this tracking in rmap.  Do you have any ideas?
> > 
> > > 
> > > That way the filesystem can then look up all the owners of that bad
> > > media range (i.e. the filesystem block it corresponds to) and take
> > > appropriate action. e.g.
> > 
> > I tried writing a function to look up all the owners' info of one block in
> > xfs for memory-failure use.  It was dropped in this patchset because I found
> > out that this lookup function needs 'rmapbt' to be enabled when mkfs.  But
> > by default, rmapbt is disabled.  I am not sure if it matters...
> 
> I'm pretty sure you can't have shared extents on an XFS filesystem if you
> _don't_ have the rmapbt feature enabled.  I mean, that's why it exists.

You're confusing reflink with rmap. :)

rmapbt does all the reverse mapping tracking, reflink just does the
shared data extent tracking.

But given that anyone who wants to use DAX with reflink is going to
have to mkfs their filesystem anyway (to turn on reflink) requiring
that rmapbt is also turned on is not a big deal. Especially as we
can check it at mount time in the kernel...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
