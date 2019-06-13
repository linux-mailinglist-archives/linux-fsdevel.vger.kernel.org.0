Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8FF43BF0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2019 17:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbfFMPcj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jun 2019 11:32:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41576 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728462AbfFMKrr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jun 2019 06:47:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GEs9TuIKz96lXRS7FnLGyqSMFlOm6a6Nuvp5RkrDbpg=; b=iMC2hvEIOcyryH8ttvBTFCIwJ
        +/UTOZxleRRIx/Qk3yqPfUzPCOda7GErke13ZzFQak5ewSoRm8WulpfqNH7Zcz8Q/4E8j/T6eNEmH
        zqn/a0VQTD+joB/VdqCU1xYbOG/t0Yt1iH7D4MVcM+JnmapUwUFZ9n9jOt8V0iESGcP+afyjOL9pH
        +Z800XzTY/YS/+CM4flrqhchMwkDHfagPOomV5WMld5ChIy1boYvTjVntNNzTcy5LKpr/Bsx2mf7S
        S446zK0y8A3V0fwGhTmnFSvXqbCAHfkut7f3C9ZExu7tOQe+5MbplKDwi6MAkqGaZIAtnEYCa3p8M
        bMZjvH0qQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hbNGh-0007DC-6o; Thu, 13 Jun 2019 10:47:43 +0000
Date:   Thu, 13 Jun 2019 03:47:43 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Jeff Layton <jlayton@kernel.org>, linux-xfs@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-ext4@vger.kernel.org,
        linux-mm@kvack.org, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH RFC 00/10] RDMA/FS DAX truncate proposal
Message-ID: <20190613104743.GH32656@bombadil.infradead.org>
References: <20190606014544.8339-1-ira.weiny@intel.com>
 <20190606104203.GF7433@quack2.suse.cz>
 <20190606220329.GA11698@iweiny-DESK2.sc.intel.com>
 <20190607110426.GB12765@quack2.suse.cz>
 <20190607182534.GC14559@iweiny-DESK2.sc.intel.com>
 <20190608001036.GF14308@dread.disaster.area>
 <20190612123751.GD32656@bombadil.infradead.org>
 <20190613002555.GH14363@dread.disaster.area>
 <20190613032320.GG32656@bombadil.infradead.org>
 <20190613043649.GJ14363@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613043649.GJ14363@dread.disaster.area>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 13, 2019 at 02:36:49PM +1000, Dave Chinner wrote:
> On Wed, Jun 12, 2019 at 08:23:20PM -0700, Matthew Wilcox wrote:
> > On Thu, Jun 13, 2019 at 10:25:55AM +1000, Dave Chinner wrote:
> > > On Wed, Jun 12, 2019 at 05:37:53AM -0700, Matthew Wilcox wrote:
> > > > That's rather different from the normal meaning of 'exclusive' in the
> > > > context of locks, which is "only one user can have access to this at
> > > > a time".
> > > 
> > > Layout leases are not locks, they are a user access policy object.
> > > It is the process/fd which holds the lease and it's the process/fd
> > > that is granted exclusive access.  This is exactly the same semantic
> > > as O_EXCL provides for granting exclusive access to a block device
> > > via open(), yes?
> > 
> > This isn't my understanding of how RDMA wants this to work, so we should
> > probably clear that up before we get too far down deciding what name to
> > give it.
> > 
> > For the RDMA usage case, it is entirely possible that both process A
> > and process B which don't know about each other want to perform RDMA to
> > file F.  So there will be two layout leases active on this file at the
> > same time.  It's fine for IOs to simultaneously be active to both leases.
> 
> Yes, it is.
> 
> > But if the filesystem wants to move blocks around, it has to break
> > both leases.
> 
> No, the _lease layer_ needs to break both leases when the filesystem
> calls break_layout().

That's a distinction without a difference as far as userspace is
concerned.  If process A asks for an exclusive lease (and gets it),
then process B asks for an exclusive lease (and gets it), that lease
isn't exclusive!  It's shared.

I think the example you give of O_EXCL is more of a historical accident.
It's a relatively recent Linuxism that O_EXCL on a block device means
"this block device is not part of a filesystem", and I don't think
most userspace programmers are aware of what it means when not paired
with O_CREAT.

> > If Process C tries to do a write to file F without a lease, there's no
> > problem, unless a side-effect of the write would be to change the block
> > mapping,
> 
> That's a side effect we cannot predict ahead of time. But it's
> also _completely irrelevant_ to the layout lease layer API and
> implementation.(*)

It's irrelevant to the naming, but you brought it up as part of the
semantics.

