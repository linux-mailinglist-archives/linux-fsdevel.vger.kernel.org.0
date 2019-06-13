Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18A714442C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2019 18:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392323AbfFMQfR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jun 2019 12:35:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:38932 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730730AbfFMHoD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jun 2019 03:44:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 920EBAB91;
        Thu, 13 Jun 2019 07:44:00 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B5C631E4328; Thu, 13 Jun 2019 09:43:59 +0200 (CEST)
Date:   Thu, 13 Jun 2019 09:43:59 +0200
From:   Jan Kara <jack@suse.cz>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jan Kara <jack@suse.cz>, Ira Weiny <ira.weiny@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Theodore Ts'o <tytso@mit.edu>,
        Jeff Layton <jlayton@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Subject: Re: [PATCH RFC 00/10] RDMA/FS DAX truncate proposal
Message-ID: <20190613074359.GB26505@quack2.suse.cz>
References: <20190606014544.8339-1-ira.weiny@intel.com>
 <20190606104203.GF7433@quack2.suse.cz>
 <20190606195114.GA30714@ziepe.ca>
 <20190606222228.GB11698@iweiny-DESK2.sc.intel.com>
 <20190607103636.GA12765@quack2.suse.cz>
 <20190607121729.GA14802@ziepe.ca>
 <20190607145213.GB14559@iweiny-DESK2.sc.intel.com>
 <20190612102917.GB14578@quack2.suse.cz>
 <CAPcyv4jSyTjC98UsWb3-FnZekV0oyboiSe9n1NYDC2TSKAqiqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4jSyTjC98UsWb3-FnZekV0oyboiSe9n1NYDC2TSKAqiqw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 12-06-19 11:49:52, Dan Williams wrote:
> On Wed, Jun 12, 2019 at 3:29 AM Jan Kara <jack@suse.cz> wrote:
> >
> > On Fri 07-06-19 07:52:13, Ira Weiny wrote:
> > > On Fri, Jun 07, 2019 at 09:17:29AM -0300, Jason Gunthorpe wrote:
> > > > On Fri, Jun 07, 2019 at 12:36:36PM +0200, Jan Kara wrote:
> > > >
> > > > > Because the pins would be invisible to sysadmin from that point on.
> > > >
> > > > It is not invisible, it just shows up in a rdma specific kernel
> > > > interface. You have to use rdma netlink to see the kernel object
> > > > holding this pin.
> > > >
> > > > If this visibility is the main sticking point I suggest just enhancing
> > > > the existing MR reporting to include the file info for current GUP
> > > > pins and teaching lsof to collect information from there as well so it
> > > > is easy to use.
> > > >
> > > > If the ownership of the lease transfers to the MR, and we report that
> > > > ownership to userspace in a way lsof can find, then I think all the
> > > > concerns that have been raised are met, right?
> > >
> > > I was contemplating some new lsof feature yesterday.  But what I don't
> > > think we want is sysadmins to have multiple tools for multiple
> > > subsystems.  Or even have to teach lsof something new for every potential
> > > new subsystem user of GUP pins.
> >
> > Agreed.
> >
> > > I was thinking more along the lines of reporting files which have GUP
> > > pins on them directly somewhere (dare I say procfs?) and teaching lsof to
> > > report that information.  That would cover any subsystem which does a
> > > longterm pin.
> >
> > So lsof already parses /proc/<pid>/maps to learn about files held open by
> > memory mappings. It could parse some other file as well I guess. The good
> > thing about that would be that then "longterm pin" structure would just hold
> > struct file reference. That would avoid any needs of special behavior on
> > file close (the file reference in the "longterm pin" structure would make
> > sure struct file and thus the lease stays around, we'd just need to make
> > explicit lease unlock block until the "longterm pin" structure is freed).
> > The bad thing is that it requires us to come up with a sane new proc
> > interface for reporting "longterm pins" and associated struct file. Also we
> > need to define what this interface shows if the pinned pages are in DRAM
> > (either page cache or anon) and not on NVDIMM.
> 
> The anon vs shared detection case is important because a longterm pin
> might be blocking a memory-hot-unplug operation if it is pinning
> ZONE_MOVABLE memory, but I don't think we want DRAM vs NVDIMM to be an
> explicit concern of the interface. For the anon / cached case I expect
> it might be useful to put that communication under the memory-blocks
> sysfs interface. I.e. a list of pids that are pinning that
> memory-block from being hot-unplugged.

Yes, I was thinking of memory hotplug as well. But I don't think the
distinction is really shared vs anon - a pinned page cache page can be
blocking your memory unplug / migration the same way as a pinned anon page.
So the information for a pin we need to convey is the "location of
resources" being pinned - that is pfn (both for DRAM and NVDIMM) - but then
also additional mapping information (which is filename for DAX page, not
sure about DRAM). Also a separate question is how to expose this
information so that it is efficiently usable by userspace. For lsof, a file
in /proc/<pid>/xxx with information would be probably the easiest to use
plus all the issues with file access permissions and visibility among
different user namespaces is solved out of the box. And I believe it would
be reasonably usable for memory hotplug usecase as well. A file in sysfs
would be OK for memory hotplug I guess, but not really usable for lsof and
so I'm not sure we really need it when we are going to have one in procfs.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
