Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16B5E3943E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2019 20:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731442AbfFGSYX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jun 2019 14:24:23 -0400
Received: from mga05.intel.com ([192.55.52.43]:54926 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729677AbfFGSYW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jun 2019 14:24:22 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jun 2019 11:24:21 -0700
X-ExtLoop1: 1
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga001.fm.intel.com with ESMTP; 07 Jun 2019 11:24:21 -0700
Date:   Fri, 7 Jun 2019 11:25:35 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Dan Williams <dan.j.williams@intel.com>,
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
Message-ID: <20190607182534.GC14559@iweiny-DESK2.sc.intel.com>
References: <20190606014544.8339-1-ira.weiny@intel.com>
 <20190606104203.GF7433@quack2.suse.cz>
 <20190606220329.GA11698@iweiny-DESK2.sc.intel.com>
 <20190607110426.GB12765@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607110426.GB12765@quack2.suse.cz>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 07, 2019 at 01:04:26PM +0200, Jan Kara wrote:
> On Thu 06-06-19 15:03:30, Ira Weiny wrote:
> > On Thu, Jun 06, 2019 at 12:42:03PM +0200, Jan Kara wrote:
> > > On Wed 05-06-19 18:45:33, ira.weiny@intel.com wrote:
> > > > From: Ira Weiny <ira.weiny@intel.com>
> > > 
> > > So I'd like to actually mandate that you *must* hold the file lease until
> > > you unpin all pages in the given range (not just that you have an option to
> > > hold a lease). And I believe the kernel should actually enforce this. That
> > > way we maintain a sane state that if someone uses a physical location of
> > > logical file offset on disk, he has a layout lease. Also once this is done,
> > > sysadmin has a reasonably easy way to discover run-away RDMA application
> > > and kill it if he wishes so.
> > 
> > Fair enough.
> > 
> > I was kind of heading that direction but had not thought this far forward.  I
> > was exploring how to have a lease remain on the file even after a "lease
> > break".  But that is incompatible with the current semantics of a "layout"
> > lease (as currently defined in the kernel).  [In the end I wanted to get an RFC
> > out to see what people think of this idea so I did not look at keeping the
> > lease.]
> > 
> > Also hitch is that currently a lease is forcefully broken after
> > <sysfs>/lease-break-time.  To do what you suggest I think we would need a new
> > lease type with the semantics you describe.
> 
> I'd do what Dave suggested - add flag to mark lease as unbreakable by
> truncate and teach file locking core to handle that. There actually is
> support for locks that are not broken after given timeout so there
> shouldn't be too many changes need.
>  
> > Previously I had thought this would be a good idea (for other reasons).  But
> > what does everyone think about using a "longterm lease" similar to [1] which
> > has the semantics you proppose?  In [1] I was not sure "longterm" was a good
> > name but with your proposal I think it makes more sense.
> 
> As I wrote elsewhere in this thread I think FL_LAYOUT name still makes
> sense and I'd add there FL_UNBREAKABLE to mark unusal behavior with
> truncate.

Ok I want to make sure I understand what you and Dave are suggesting.

Are you suggesting that we have something like this from user space?

	fcntl(fd, F_SETLEASE, F_LAYOUT | F_UNBREAKABLE);

> 
> > > - probably I'd just transition all gup_longterm()
> > > users to a saner API similar to the one we have in mm/frame_vector.c where
> > > we don't hand out page pointers but an encapsulating structure that does
> > > all the necessary tracking.
> > 
> > I'll take a look at that code.  But that seems like a pretty big change.
> 
> I was looking into that yesterday before proposing this and there aren't
> than many gup_longterm() users and most of them anyway just stick pages
> array into their tracking structure and then release them once done. So it
> shouldn't be that complex to convert to a new convention (and you have to
> touch all gup_longterm() users anyway to teach them track leases etc.).

I think in the direction we are heading this becomes more attractive for sure.
For me though it will take some time.

Should we convert the frame_vector over to this new mechanism?  (Or more
accurately perhaps, add to frame_vector and use it?)  It seems bad to have "yet
another object" returned from the pin pages interface...

And I think this is related to what Christoph Hellwig is doing with bio_vec and
dma.  Really we want drivers out of the page processing business.

So for now I'm going to move forward with the idea of handing "some object" to
the GUP callers and figure out the lsof stuff, and let bigger questions like
this play out a bit more before I try and work with that code.  Fair?

> 
> > > Removing a lease would need to block until all
> > > pins are released - this is probably the most hairy part since we need to
> > > handle a case if application just closes the file descriptor which would
> > > release the lease but OTOH we need to make sure task exit does not deadlock.
> > > Maybe we could block only on explicit lease unlock and just drop the layout
> > > lease on file close and if there are still pinned pages, send SIGKILL to an
> > > application as a reminder it did something stupid...
> > 
> > As presented at LSFmm I'm not opposed to killing a process which does not
> > "follow the rules".  But I'm concerned about how to handle this across a fork.
> > 
> > Limiting the open()/LEASE/GUP/close()/SIGKILL to a specific pid "leak"'s pins
> > to a child through the RDMA context.  This was the major issue Jason had with
> > the SIGBUS proposal.
> > 
> > Always sending a SIGKILL would prevent an RDMA process from doing something
> > like system("ls") (would kill the child unnecessarily).  Are we ok with that?
> 
> I answered this in another email but system("ls") won't kill anybody.
> fork(2) just creates new file descriptor for the same file and possibly
> then closes it but since there is still another file descriptor for the
> same struct file, the "close" code won't trigger.

Agreed.  I was wrong.  Sorry.

But if we can keep track of who has the pins in lsof can we agree no process
needs to be SIGKILL'ed?  Admins can do this on their own "killing" if they
really need to stop the use of these files, right?

Ira

