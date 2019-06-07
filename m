Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D153138870
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2019 13:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbfFGLEa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jun 2019 07:04:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:57526 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728115AbfFGLE3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jun 2019 07:04:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0B6BFAE91;
        Fri,  7 Jun 2019 11:04:27 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 41D0F1E3FCA; Fri,  7 Jun 2019 13:04:26 +0200 (CEST)
Date:   Fri, 7 Jun 2019 13:04:26 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Jan Kara <jack@suse.cz>, Dan Williams <dan.j.williams@intel.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Jeff Layton <jlayton@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-ext4@vger.kernel.org,
        linux-mm@kvack.org, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH RFC 00/10] RDMA/FS DAX truncate proposal
Message-ID: <20190607110426.GB12765@quack2.suse.cz>
References: <20190606014544.8339-1-ira.weiny@intel.com>
 <20190606104203.GF7433@quack2.suse.cz>
 <20190606220329.GA11698@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606220329.GA11698@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 06-06-19 15:03:30, Ira Weiny wrote:
> On Thu, Jun 06, 2019 at 12:42:03PM +0200, Jan Kara wrote:
> > On Wed 05-06-19 18:45:33, ira.weiny@intel.com wrote:
> > > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > So I'd like to actually mandate that you *must* hold the file lease until
> > you unpin all pages in the given range (not just that you have an option to
> > hold a lease). And I believe the kernel should actually enforce this. That
> > way we maintain a sane state that if someone uses a physical location of
> > logical file offset on disk, he has a layout lease. Also once this is done,
> > sysadmin has a reasonably easy way to discover run-away RDMA application
> > and kill it if he wishes so.
> 
> Fair enough.
> 
> I was kind of heading that direction but had not thought this far forward.  I
> was exploring how to have a lease remain on the file even after a "lease
> break".  But that is incompatible with the current semantics of a "layout"
> lease (as currently defined in the kernel).  [In the end I wanted to get an RFC
> out to see what people think of this idea so I did not look at keeping the
> lease.]
> 
> Also hitch is that currently a lease is forcefully broken after
> <sysfs>/lease-break-time.  To do what you suggest I think we would need a new
> lease type with the semantics you describe.

I'd do what Dave suggested - add flag to mark lease as unbreakable by
truncate and teach file locking core to handle that. There actually is
support for locks that are not broken after given timeout so there
shouldn't be too many changes need.
 
> Previously I had thought this would be a good idea (for other reasons).  But
> what does everyone think about using a "longterm lease" similar to [1] which
> has the semantics you proppose?  In [1] I was not sure "longterm" was a good
> name but with your proposal I think it makes more sense.

As I wrote elsewhere in this thread I think FL_LAYOUT name still makes
sense and I'd add there FL_UNBREAKABLE to mark unusal behavior with
truncate.

> > - probably I'd just transition all gup_longterm()
> > users to a saner API similar to the one we have in mm/frame_vector.c where
> > we don't hand out page pointers but an encapsulating structure that does
> > all the necessary tracking.
> 
> I'll take a look at that code.  But that seems like a pretty big change.

I was looking into that yesterday before proposing this and there aren't
than many gup_longterm() users and most of them anyway just stick pages
array into their tracking structure and then release them once done. So it
shouldn't be that complex to convert to a new convention (and you have to
touch all gup_longterm() users anyway to teach them track leases etc.).

> > Removing a lease would need to block until all
> > pins are released - this is probably the most hairy part since we need to
> > handle a case if application just closes the file descriptor which would
> > release the lease but OTOH we need to make sure task exit does not deadlock.
> > Maybe we could block only on explicit lease unlock and just drop the layout
> > lease on file close and if there are still pinned pages, send SIGKILL to an
> > application as a reminder it did something stupid...
> 
> As presented at LSFmm I'm not opposed to killing a process which does not
> "follow the rules".  But I'm concerned about how to handle this across a fork.
> 
> Limiting the open()/LEASE/GUP/close()/SIGKILL to a specific pid "leak"'s pins
> to a child through the RDMA context.  This was the major issue Jason had with
> the SIGBUS proposal.
> 
> Always sending a SIGKILL would prevent an RDMA process from doing something
> like system("ls") (would kill the child unnecessarily).  Are we ok with that?

I answered this in another email but system("ls") won't kill anybody.
fork(2) just creates new file descriptor for the same file and possibly
then closes it but since there is still another file descriptor for the
same struct file, the "close" code won't trigger.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
