Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09812380C4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2019 00:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729356AbfFFW37 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jun 2019 18:29:59 -0400
Received: from mail106.syd.optusnet.com.au ([211.29.132.42]:41593 "EHLO
        mail106.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727297AbfFFW36 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jun 2019 18:29:58 -0400
Received: from dread.disaster.area (pa49-195-189-25.pa.nsw.optusnet.com.au [49.195.189.25])
        by mail106.syd.optusnet.com.au (Postfix) with ESMTPS id 868484EA85D;
        Fri,  7 Jun 2019 08:29:50 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hZ0sP-0000g2-35; Fri, 07 Jun 2019 08:28:53 +1000
Date:   Fri, 7 Jun 2019 08:28:53 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Jan Kara <jack@suse.cz>, Dan Williams <dan.j.williams@intel.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Jeff Layton <jlayton@kernel.org>,
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
Message-ID: <20190606222853.GD14308@dread.disaster.area>
References: <20190606014544.8339-1-ira.weiny@intel.com>
 <20190606104203.GF7433@quack2.suse.cz>
 <20190606220329.GA11698@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606220329.GA11698@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0 cx=a_idp_d
        a=K5LJ/TdJMXINHCwnwvH1bQ==:117 a=K5LJ/TdJMXINHCwnwvH1bQ==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=dq6fvYVFJ5YA:10
        a=QyXUC8HyAAAA:8 a=7-415B0cAAAA:8 a=-fIxr7oOWDDygYgkAT8A:9
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 06, 2019 at 03:03:30PM -0700, Ira Weiny wrote:
> On Thu, Jun 06, 2019 at 12:42:03PM +0200, Jan Kara wrote:
> > On Wed 05-06-19 18:45:33, ira.weiny@intel.com wrote:
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

That just requires a flag when gaining the layout lease to say it is
an "unbreakable layout lease". That gives the kernel the information
needed to determine whether it should attempt to break the lease on
truncate or just return ETXTBSY....

i.e. it allows gup-pinning applications that want to behave nicely
with other users to drop their gup pins and release the lease when
something else wants to truncate/hole punch the file rather than
have truncate return an error. e.g. to allow apps to cleanly interop
with other breakable layout leases (e.g. pNFS) on the same
filesystem.

FWIW, I'd also like to see the "truncate fails when unbreakable
layout lease is held" behaviour to be common across all
filesystem/storage types, not be confined to DAX only. i.e. truncate
should return ETXTBSY when an unbreakable layout lease is held
by an application, not just when "DAX+gup-pinned" is triggered....

Whatever we decide, the behaviour of truncate et al needs to be
predictable, consistent and easily discoverable...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
