Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B941DA8D6E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2019 21:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731599AbfIDQy1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Sep 2019 12:54:27 -0400
Received: from mga07.intel.com ([134.134.136.100]:23377 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbfIDQy1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Sep 2019 12:54:27 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2019 09:54:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,467,1559545200"; 
   d="scan'208";a="185171841"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga003.jf.intel.com with ESMTP; 04 Sep 2019 09:54:25 -0700
Date:   Wed, 4 Sep 2019 09:54:25 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        John Hubbard <jhubbard@nvidia.com>,
        Michal Hocko <mhocko@suse.com>, linux-xfs@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-ext4@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v2 00/19] RDMA/FS DAX truncate proposal V1,000,002 ;-)
Message-ID: <20190904165425.GB31319@iweiny-DESK2.sc.intel.com>
References: <20190821185703.GB5965@iweiny-DESK2.sc.intel.com>
 <20190821194810.GI8653@ziepe.ca>
 <20190821204421.GE5965@iweiny-DESK2.sc.intel.com>
 <20190823032345.GG1119@dread.disaster.area>
 <20190823120428.GA12968@ziepe.ca>
 <20190824001124.GI1119@dread.disaster.area>
 <20190824050836.GC1092@iweiny-DESK2.sc.intel.com>
 <20190826055510.GL1119@dread.disaster.area>
 <20190829020230.GA18249@iweiny-DESK2.sc.intel.com>
 <20190902222618.GR1119@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902222618.GR1119@dread.disaster.area>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 03, 2019 at 08:26:18AM +1000, Dave Chinner wrote:
> On Wed, Aug 28, 2019 at 07:02:31PM -0700, Ira Weiny wrote:
> > On Mon, Aug 26, 2019 at 03:55:10PM +1000, Dave Chinner wrote:
> > > On Fri, Aug 23, 2019 at 10:08:36PM -0700, Ira Weiny wrote:
> > > > On Sat, Aug 24, 2019 at 10:11:24AM +1000, Dave Chinner wrote:
> > > > > On Fri, Aug 23, 2019 at 09:04:29AM -0300, Jason Gunthorpe wrote:
> > > > "Leases are associated with an open file description (see open(2)).  This means
> > > > that duplicate file descriptors (created by, for example, fork(2) or dup(2))
> > > > refer to the same lease, and this lease may be modified or released using any
> > > > of these descriptors.  Furthermore,  the lease is released by either an
> > > > explicit F_UNLCK operation on any of these duplicate file descriptors, or when
> > > > all such file descriptors have been closed."
> > > 
> > > Right, the lease is attached to the struct file, so it follows
> > > where-ever the struct file goes. That doesn't mean it's actually
> > > useful when the struct file is duplicated and/or passed to another
> > > process. :/
> > > 
> > > AFAICT, the problem is that when we take another reference to the
> > > struct file, or when the struct file is passed to a different
> > > process, nothing updates the lease or lease state attached to that
> > > struct file.
> > 
> > Ok, I probably should have made this more clear in the cover letter but _only_
> > the process which took the lease can actually pin memory.
> 
> Sure, no question about that.
> 
> > That pinned memory _can_ be passed to another process but those sub-process' can
> > _not_ use the original lease to pin _more_ of the file.  They would need to
> > take their own lease to do that.
> 
> Yes, they would need a new lease to extend it. But that ignores the
> fact they don't have a lease on the existing pins they are using and
> have no control over the lease those pins originated under.  e.g.
> the originating process dies (for whatever reason) and now we have
> pins without a valid lease holder.

Define "valid lease holder"?

> 
> If something else now takes an exclusive lease on the file (because
> the original exclusive lease no longer exists), it's not going to
> work correctly because of the zombied page pins caused by closing
> the exclusive lease they were gained under. IOWs, pages pinned under
> an exclusive lease are no longer "exclusive" the moment the original
> exclusive lease is dropped, and pins passed to another process are
> no longer covered by the original lease they were created under.

The page pins are not zombied the lease is.  The lease still exists, it can't
be dropped while the pins are in place.  I need to double check the
implementation but that was the intent.

Yep just did a quick check, I have a test for that.  If the page pins exist
then the lease can _not_ be released.  Closing the FD will "zombie" the lease
but it and the struct file will still exist until the pins go away.

Furthermore, a "zombie" lease is _not_ sufficient to pin more pages.  (I have a
test for this too.)  I apologize that I don't have something to submit to
xfstests.  I'm new to that code base.

I'm happy to share the code I have which I've been using to test...  But it is
pretty rough as it has undergone a number of changes.  I think it would be
better to convert my test series to xfstests.

However, I don't know if it is ok to require RDMA within those tests.  Right
now that is the only sub-system I have allowed to create these page pins.  So
I'm not sure what to do at this time.  I'm open to suggestions.

> 
> > Sorry for not being clear on that.
> 
> I know exactly what you are saying. What I'm failing to get across
> is that file layout leases don't actually allow the behaviour you
> want to have.

Not currently, no.  But we are discussing the semantics to allow them _to_ have
the behavior needed.

> 
> > > As such, leases that require callbacks to userspace are currently
> > > only valid within the process context the lease was taken in.
> > 
> > But for long term pins we are not requiring callbacks.
> 
> Regardless, we still require an active lease for long term pins so
> that other lease holders fail operations appropriately. And that
> exclusive lease must follow the process that pins the pages so that
> the life cycle is the same...

I disagree.  See below.

> 
> > > Indeed, even closing the fd the lease was taken on without
> > > F_UNLCKing it first doesn't mean the lease has been torn down if
> > > there is some other reference to the struct file. That means the
> > > original lease owner will still get SIGIO delivered to that fd on a
> > > lease break regardless of whether it is open or not. ANd if we
> > > implement "layout lease not released within SIGIO response timeout"
> > > then that process will get killed, despite the fact it may not even
> > > have a reference to that file anymore.
> > 
> > I'm not seeing that as a problem.  This is all a result of the application
> > failing to do the right thing.
> 
> How is that not a problem?

The application has taken an exclusive lease and they don't have to let it go.

IOW, there is little difference between the application closing the FD and
creating a zombie lease vs keeping the FD open with a real lease.  Because no
SIGIO is sent and there is no need to react to it anyway as the intention is to
keep the lease active and the layout pinned "indefinitely".

Furthermore, in both cases the admin must kill the application to change the
layout forcibly.  Basically applications don't _have_ to do the right thing but
the kernel and the filesystem is still protected while the admin has a way to
correct the situation given a bad application.

Therefore, from the POV of the kernel and file system I don't see a problem.

Ira

