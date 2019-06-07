Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C75BC38828
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2019 12:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbfFGKqj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jun 2019 06:46:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:54822 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727537AbfFGKqi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jun 2019 06:46:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 471C9AF0A;
        Fri,  7 Jun 2019 10:46:36 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id DDD771E3FCA; Fri,  7 Jun 2019 12:36:36 +0200 (CEST)
Date:   Fri, 7 Jun 2019 12:36:36 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
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
        linux-mm@kvack.org
Subject: Re: [PATCH RFC 00/10] RDMA/FS DAX truncate proposal
Message-ID: <20190607103636.GA12765@quack2.suse.cz>
References: <20190606014544.8339-1-ira.weiny@intel.com>
 <20190606104203.GF7433@quack2.suse.cz>
 <20190606195114.GA30714@ziepe.ca>
 <20190606222228.GB11698@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606222228.GB11698@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 06-06-19 15:22:28, Ira Weiny wrote:
> On Thu, Jun 06, 2019 at 04:51:15PM -0300, Jason Gunthorpe wrote:
> > On Thu, Jun 06, 2019 at 12:42:03PM +0200, Jan Kara wrote:
> > 
> > > So I'd like to actually mandate that you *must* hold the file lease until
> > > you unpin all pages in the given range (not just that you have an option to
> > > hold a lease). And I believe the kernel should actually enforce this. That
> > > way we maintain a sane state that if someone uses a physical location of
> > > logical file offset on disk, he has a layout lease. Also once this is done,
> > > sysadmin has a reasonably easy way to discover run-away RDMA application
> > > and kill it if he wishes so.
> > > 
> > > The question is on how to exactly enforce that lease is taken until all
> > > pages are unpinned. I belive it could be done by tracking number of
> > > long-term pinned pages within a lease. Gup_longterm could easily increment
> > > the count when verifying the lease exists, gup_longterm users will somehow
> > > need to propagate corresponding 'filp' (struct file pointer) to
> > > put_user_pages_longterm() callsites so that they can look up appropriate
> > > lease to drop reference - probably I'd just transition all gup_longterm()
> > > users to a saner API similar to the one we have in mm/frame_vector.c where
> > > we don't hand out page pointers but an encapsulating structure that does
> > > all the necessary tracking. Removing a lease would need to block until all
> > > pins are released - this is probably the most hairy part since we need to
> > > handle a case if application just closes the file descriptor which
> > > would
> > 
> > I think if you are going to do this then the 'struct filp' that
> > represents the lease should be held in the kernel (ie inside the RDMA
> > umem) until the kernel is done with it.
> 
> Yea there seems merit to this.  I'm still not resolving how this helps track
> who has the pin across a fork.

Yes, my thought was that gup_longterm() would return a structure that would
be tracking filp (or whatever is needed) and that would be embedded inside
RDMA umem.

> > Actually does someone have a pointer to this userspace lease API, I'm
> > not at all familiar with it, thanks
> 
> man fcntl
> 	search for SETLEASE
> 
> But I had to add the F_LAYOUT lease type.  (Personally I'm for calling it
> F_LONGTERM at this point.  I don't think LAYOUT is compatible with what we are
> proposing here.)

I think F_LAYOUT still expresses it pretty well. The lease is pinning
logical->physical file offset mapping, i.e. the file layout.

> > 
> > And yes, a better output format from GUP would be great..
> > 
> > > Maybe we could block only on explicit lease unlock and just drop the layout
> > > lease on file close and if there are still pinned pages, send SIGKILL to an
> > > application as a reminder it did something stupid...
> > 
> > Which process would you SIGKILL? At least for the rdma case a FD is
> > holding the GUP, so to do the put_user_pages() the kernel needs to
> > close the FD. I guess it would have to kill every process that has the
> > FD open? Seems complicated...
> 
> Tending to agree...  But I'm still not opposed to killing bad actors...  ;-)
> 
> NOTE: Jason I think you need to be more clear about the FD you are speaking of.
> I believe you mean the FD which refers to the RMDA context.  That is what I
> called it in my other email.

I keep forgetting that the file with RDMA context may be held by multiple
processes so thanks for correcting me. My proposal with SIGKILL was jumping
to conclusion too quickly :) We have two struct files here: A file with RDMA
context that effectively is the owner of the page pins (let's call it
"context file") and a file which is mapped and on which we hold the lease and
whose blocks (pages) we are pinning (let's call it "buffer file"). Now once
buffer file is closed (and this means that all file descriptors pointing to
this struct file are closed - so just one child closing the file descriptor
won't trigger this) we need to release the lease and I want to have a way
of safely releasing remaining pins associated with this lease as well.
Because the pins would be invisible to sysadmin from that point on. Now if
the context file would be open only by the process closing the buffer file,
SIGKILL would work as that would close the buffer file as a side effect.
But as you properly pointed out, that's not necessarily the case. Walking
processes that have the context file open is technically complex and too
ugly to live so we have to come up with something better. The best I can
currently come up with is to have a method associated with the lease that
would invalidate the RDMA context that holds the pins in the same way that
a file close would do it.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
