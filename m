Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8286138077
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2019 00:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbfFFWVS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jun 2019 18:21:18 -0400
Received: from mga03.intel.com ([134.134.136.65]:65321 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbfFFWVR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jun 2019 18:21:17 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jun 2019 15:21:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,560,1557212400"; 
   d="scan'208";a="182472132"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga002.fm.intel.com with ESMTP; 06 Jun 2019 15:21:16 -0700
Date:   Thu, 6 Jun 2019 15:22:28 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
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
        linux-mm@kvack.org
Subject: Re: [PATCH RFC 00/10] RDMA/FS DAX truncate proposal
Message-ID: <20190606222228.GB11698@iweiny-DESK2.sc.intel.com>
References: <20190606014544.8339-1-ira.weiny@intel.com>
 <20190606104203.GF7433@quack2.suse.cz>
 <20190606195114.GA30714@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606195114.GA30714@ziepe.ca>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 06, 2019 at 04:51:15PM -0300, Jason Gunthorpe wrote:
> On Thu, Jun 06, 2019 at 12:42:03PM +0200, Jan Kara wrote:
> 
> > So I'd like to actually mandate that you *must* hold the file lease until
> > you unpin all pages in the given range (not just that you have an option to
> > hold a lease). And I believe the kernel should actually enforce this. That
> > way we maintain a sane state that if someone uses a physical location of
> > logical file offset on disk, he has a layout lease. Also once this is done,
> > sysadmin has a reasonably easy way to discover run-away RDMA application
> > and kill it if he wishes so.
> > 
> > The question is on how to exactly enforce that lease is taken until all
> > pages are unpinned. I belive it could be done by tracking number of
> > long-term pinned pages within a lease. Gup_longterm could easily increment
> > the count when verifying the lease exists, gup_longterm users will somehow
> > need to propagate corresponding 'filp' (struct file pointer) to
> > put_user_pages_longterm() callsites so that they can look up appropriate
> > lease to drop reference - probably I'd just transition all gup_longterm()
> > users to a saner API similar to the one we have in mm/frame_vector.c where
> > we don't hand out page pointers but an encapsulating structure that does
> > all the necessary tracking. Removing a lease would need to block until all
> > pins are released - this is probably the most hairy part since we need to
> > handle a case if application just closes the file descriptor which
> > would
> 
> I think if you are going to do this then the 'struct filp' that
> represents the lease should be held in the kernel (ie inside the RDMA
> umem) until the kernel is done with it.

Yea there seems merit to this.  I'm still not resolving how this helps track
who has the pin across a fork.

> 
> Actually does someone have a pointer to this userspace lease API, I'm
> not at all familiar with it, thanks

man fcntl
	search for SETLEASE

But I had to add the F_LAYOUT lease type.  (Personally I'm for calling it
F_LONGTERM at this point.  I don't think LAYOUT is compatible with what we are
proposing here.)

Anyway, yea would be a libc change at lease for man page etc...  But again I
want to get some buy in before going through all that.

> 
> And yes, a better output format from GUP would be great..
> 
> > Maybe we could block only on explicit lease unlock and just drop the layout
> > lease on file close and if there are still pinned pages, send SIGKILL to an
> > application as a reminder it did something stupid...
> 
> Which process would you SIGKILL? At least for the rdma case a FD is
> holding the GUP, so to do the put_user_pages() the kernel needs to
> close the FD. I guess it would have to kill every process that has the
> FD open? Seems complicated...

Tending to agree...  But I'm still not opposed to killing bad actors...  ;-)

NOTE: Jason I think you need to be more clear about the FD you are speaking of.
I believe you mean the FD which refers to the RMDA context.  That is what I
called it in my other email.

Ira

> 
> Regards,
> Jason
