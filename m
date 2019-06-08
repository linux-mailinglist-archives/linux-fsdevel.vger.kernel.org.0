Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2D3399D8
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Jun 2019 02:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730955AbfFHALo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jun 2019 20:11:44 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:38024 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729685AbfFHALo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jun 2019 20:11:44 -0400
Received: from dread.disaster.area (pa49-195-189-25.pa.nsw.optusnet.com.au [49.195.189.25])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 946BC43E794;
        Sat,  8 Jun 2019 10:11:34 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hZOwO-0001iX-35; Sat, 08 Jun 2019 10:10:36 +1000
Date:   Sat, 8 Jun 2019 10:10:36 +1000
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
Message-ID: <20190608001036.GF14308@dread.disaster.area>
References: <20190606014544.8339-1-ira.weiny@intel.com>
 <20190606104203.GF7433@quack2.suse.cz>
 <20190606220329.GA11698@iweiny-DESK2.sc.intel.com>
 <20190607110426.GB12765@quack2.suse.cz>
 <20190607182534.GC14559@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607182534.GC14559@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=P6RKvmIu c=1 sm=1 tr=0 cx=a_idp_d
        a=K5LJ/TdJMXINHCwnwvH1bQ==:117 a=K5LJ/TdJMXINHCwnwvH1bQ==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=dq6fvYVFJ5YA:10
        a=QyXUC8HyAAAA:8 a=7-415B0cAAAA:8 a=q-LccRbQMXva6PWEi7oA:9
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 07, 2019 at 11:25:35AM -0700, Ira Weiny wrote:
> On Fri, Jun 07, 2019 at 01:04:26PM +0200, Jan Kara wrote:
> > On Thu 06-06-19 15:03:30, Ira Weiny wrote:
> > > On Thu, Jun 06, 2019 at 12:42:03PM +0200, Jan Kara wrote:
> > > > On Wed 05-06-19 18:45:33, ira.weiny@intel.com wrote:
> > > > > From: Ira Weiny <ira.weiny@intel.com>
> > > > 
> > > > So I'd like to actually mandate that you *must* hold the file lease until
> > > > you unpin all pages in the given range (not just that you have an option to
> > > > hold a lease). And I believe the kernel should actually enforce this. That
> > > > way we maintain a sane state that if someone uses a physical location of
> > > > logical file offset on disk, he has a layout lease. Also once this is done,
> > > > sysadmin has a reasonably easy way to discover run-away RDMA application
> > > > and kill it if he wishes so.
> > > 
> > > Fair enough.
> > > 
> > > I was kind of heading that direction but had not thought this far forward.  I
> > > was exploring how to have a lease remain on the file even after a "lease
> > > break".  But that is incompatible with the current semantics of a "layout"
> > > lease (as currently defined in the kernel).  [In the end I wanted to get an RFC
> > > out to see what people think of this idea so I did not look at keeping the
> > > lease.]
> > > 
> > > Also hitch is that currently a lease is forcefully broken after
> > > <sysfs>/lease-break-time.  To do what you suggest I think we would need a new
> > > lease type with the semantics you describe.
> > 
> > I'd do what Dave suggested - add flag to mark lease as unbreakable by
> > truncate and teach file locking core to handle that. There actually is
> > support for locks that are not broken after given timeout so there
> > shouldn't be too many changes need.
> >  
> > > Previously I had thought this would be a good idea (for other reasons).  But
> > > what does everyone think about using a "longterm lease" similar to [1] which
> > > has the semantics you proppose?  In [1] I was not sure "longterm" was a good
> > > name but with your proposal I think it makes more sense.
> > 
> > As I wrote elsewhere in this thread I think FL_LAYOUT name still makes
> > sense and I'd add there FL_UNBREAKABLE to mark unusal behavior with
> > truncate.
> 
> Ok I want to make sure I understand what you and Dave are suggesting.
> 
> Are you suggesting that we have something like this from user space?
> 
> 	fcntl(fd, F_SETLEASE, F_LAYOUT | F_UNBREAKABLE);

Rather than "unbreakable", perhaps a clearer description of the
policy it entails is "exclusive"?

i.e. what we are talking about here is an exclusive lease that
prevents other processes from changing the layout. i.e. the
mechanism used to guarantee a lease is exclusive is that the layout
becomes "unbreakable" at the filesystem level, but the policy we are
actually presenting to uses is "exclusive access"...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
