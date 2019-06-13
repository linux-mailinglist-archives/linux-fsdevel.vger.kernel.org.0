Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9C244D80
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2019 22:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729927AbfFMUcx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jun 2019 16:32:53 -0400
Received: from mga01.intel.com ([192.55.52.88]:54105 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbfFMUcq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jun 2019 16:32:46 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jun 2019 13:32:46 -0700
X-ExtLoop1: 1
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Jun 2019 13:32:45 -0700
Date:   Thu, 13 Jun 2019 13:34:06 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
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
Message-ID: <20190613203406.GB32404@iweiny-DESK2.sc.intel.com>
References: <20190606014544.8339-1-ira.weiny@intel.com>
 <20190606104203.GF7433@quack2.suse.cz>
 <20190606220329.GA11698@iweiny-DESK2.sc.intel.com>
 <20190607110426.GB12765@quack2.suse.cz>
 <20190607182534.GC14559@iweiny-DESK2.sc.intel.com>
 <20190608001036.GF14308@dread.disaster.area>
 <20190612123751.GD32656@bombadil.infradead.org>
 <20190612233024.GD14336@iweiny-DESK2.sc.intel.com>
 <20190613005552.GI14363@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613005552.GI14363@dread.disaster.area>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 13, 2019 at 10:55:52AM +1000, Dave Chinner wrote:
> On Wed, Jun 12, 2019 at 04:30:24PM -0700, Ira Weiny wrote:
> > On Wed, Jun 12, 2019 at 05:37:53AM -0700, Matthew Wilcox wrote:
> > > On Sat, Jun 08, 2019 at 10:10:36AM +1000, Dave Chinner wrote:
> > > > On Fri, Jun 07, 2019 at 11:25:35AM -0700, Ira Weiny wrote:
> > > > > Are you suggesting that we have something like this from user space?
> > > > > 
> > > > > 	fcntl(fd, F_SETLEASE, F_LAYOUT | F_UNBREAKABLE);
> > > > 
> > > > Rather than "unbreakable", perhaps a clearer description of the
> > > > policy it entails is "exclusive"?
> > > > 
> > > > i.e. what we are talking about here is an exclusive lease that
> > > > prevents other processes from changing the layout. i.e. the
> > > > mechanism used to guarantee a lease is exclusive is that the layout
> > > > becomes "unbreakable" at the filesystem level, but the policy we are
> > > > actually presenting to uses is "exclusive access"...
> > > 
> > > That's rather different from the normal meaning of 'exclusive' in the
> > > context of locks, which is "only one user can have access to this at
> > > a time".  As I understand it, this is rather more like a 'shared' or
> > > 'read' lock.  The filesystem would be the one which wants an exclusive
> > > lock, so it can modify the mapping of logical to physical blocks.
> > > 
> > > The complication being that by default the filesystem has an exclusive
> > > lock on the mapping, and what we're trying to add is the ability for
> > > readers to ask the filesystem to give up its exclusive lock.
> > 
> > This is an interesting view...
> > 
> > And after some more thought, exclusive does not seem like a good name for this
> > because technically F_WRLCK _is_ an exclusive lease...
> > 
> > In addition, the user does not need to take the "exclusive" write lease to be
> > notified of (broken by) an unexpected truncate.  A "read" lease is broken by
> > truncate.  (And "write" leases really don't do anything different WRT the
> > interaction of the FS and the user app.  Write leases control "exclusive"
> > access between other file descriptors.)
> 
> I've been assuming that there is only one type of layout lease -
> there is no use case I've heard of for read/write layout leases, and
> like you say there is zero difference in behaviour at the filesystem
> level - they all have to be broken to allow a non-lease truncate to
> proceed.
> 
> IMO, taking a "read lease" to be able to modify and write to the
> underlying mapping of a file makes absolutely no sense at all.
> IOWs, we're talking exaclty about a revokable layout lease vs an
> exclusive layout lease here, and so read/write really doesn't match
> the policy or semantics we are trying to provide.

I humbly disagree, at least depending on how you look at it...  :-D

The patches as they stand expect the user to take a "read" layout lease which
indicates they are currently using "reading" the layout as is.  They are not
changing ("writing" to) the layout.  They then pin pages which locks parts of
the layout and therefore they expect no "writers" to change the layout.

The "write" layout lease breaks the "read" layout lease indicating that the
layout is being written to.  Should the layout be pinned in such a way that the
layout can't be changed the "layout writer" (truncate) fails.

In fact, this is what NFS does right now.  The lease it puts on the file is of
"read" type.

nfs4layouts.c:
static int
nfsd4_layout_setlease(struct nfs4_layout_stateid *ls)
{
...
        fl->fl_flags = FL_LAYOUT;
        fl->fl_type = F_RDLCK;
...
}

I was not changing that much from the NFS patter which meant the break lease
code worked.

Jans proposal is solid but it means that there is no breaking of the lease.  I
tried to add an "exclusive" flag to the "write" lease but the __break_lease()
code gets weird.  I'm not saying it is not possible.  Just that I have not
seen a good way to do it.

> 
> > Another thing to consider is that this patch set _allows_ a truncate/hole punch
> > to proceed _if_ the pages being affected are not actually pinned.  So the
> > unbreakable/exclusive nature of the lease is not absolute.
> 
> If you're talking about the process that owns the layout lease
> running the truncate, then that is fine.
> 
> However, if you are talking about a process that does not own the
> layout lease being allowed to truncate a file without first breaking
> the layout lease, then that is fundamentally broken.

In both cases (local or remote process) the lease is broken prior to the
attempt to truncate.

> 
> i.e. If you don't own a layout lease, the layout leases must be
> broken before the truncate can proceed.

Agreed.

>
> If it's an exclusive lease,
> then you cannot break the lease and the truncate *must fail before
> it is started*. i.e.  the layout lease state must be correctly
> resolved before we start an operation that may modify a file layout.
> 
> Determining if we can actually do the truncate based on page state
> occurs /after/ the lease says the truncate can proceed....

That makes a lot of sense and that is the way the patch currently works.

I need to think on this some more.  Keeping the lease may not be critical.  As
discussed with Jan; dealing with close() is best dealt with by tracking the
actual pins on the file.  If that works then we could potentially keep the
lease semantics closer to what you and I are talking about here.

Ira

> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 
