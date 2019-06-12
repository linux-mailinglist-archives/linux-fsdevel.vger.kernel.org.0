Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDC242274
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2019 12:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbfFLK3V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jun 2019 06:29:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:42614 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726851AbfFLK3V (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jun 2019 06:29:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 16DA0AE07;
        Wed, 12 Jun 2019 10:29:19 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id BA8661E4328; Wed, 12 Jun 2019 12:29:17 +0200 (CEST)
Date:   Wed, 12 Jun 2019 12:29:17 +0200
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
Message-ID: <20190612102917.GB14578@quack2.suse.cz>
References: <20190606014544.8339-1-ira.weiny@intel.com>
 <20190606104203.GF7433@quack2.suse.cz>
 <20190606195114.GA30714@ziepe.ca>
 <20190606222228.GB11698@iweiny-DESK2.sc.intel.com>
 <20190607103636.GA12765@quack2.suse.cz>
 <20190607121729.GA14802@ziepe.ca>
 <20190607145213.GB14559@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607145213.GB14559@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 07-06-19 07:52:13, Ira Weiny wrote:
> On Fri, Jun 07, 2019 at 09:17:29AM -0300, Jason Gunthorpe wrote:
> > On Fri, Jun 07, 2019 at 12:36:36PM +0200, Jan Kara wrote:
> > 
> > > Because the pins would be invisible to sysadmin from that point on. 
> > 
> > It is not invisible, it just shows up in a rdma specific kernel
> > interface. You have to use rdma netlink to see the kernel object
> > holding this pin.
> > 
> > If this visibility is the main sticking point I suggest just enhancing
> > the existing MR reporting to include the file info for current GUP
> > pins and teaching lsof to collect information from there as well so it
> > is easy to use.
> > 
> > If the ownership of the lease transfers to the MR, and we report that
> > ownership to userspace in a way lsof can find, then I think all the
> > concerns that have been raised are met, right?
> 
> I was contemplating some new lsof feature yesterday.  But what I don't
> think we want is sysadmins to have multiple tools for multiple
> subsystems.  Or even have to teach lsof something new for every potential
> new subsystem user of GUP pins.

Agreed.

> I was thinking more along the lines of reporting files which have GUP
> pins on them directly somewhere (dare I say procfs?) and teaching lsof to
> report that information.  That would cover any subsystem which does a
> longterm pin.

So lsof already parses /proc/<pid>/maps to learn about files held open by
memory mappings. It could parse some other file as well I guess. The good
thing about that would be that then "longterm pin" structure would just hold
struct file reference. That would avoid any needs of special behavior on
file close (the file reference in the "longterm pin" structure would make
sure struct file and thus the lease stays around, we'd just need to make
explicit lease unlock block until the "longterm pin" structure is freed).
The bad thing is that it requires us to come up with a sane new proc
interface for reporting "longterm pins" and associated struct file. Also we
need to define what this interface shows if the pinned pages are in DRAM
(either page cache or anon) and not on NVDIMM.

> > > ugly to live so we have to come up with something better. The best I can
> > > currently come up with is to have a method associated with the lease that
> > > would invalidate the RDMA context that holds the pins in the same way that
> > > a file close would do it.
> > 
> > This is back to requiring all RDMA HW to have some new behavior they
> > currently don't have..
> > 
> > The main objection to the current ODP & DAX solution is that very
> > little HW can actually implement it, having the alternative still
> > require HW support doesn't seem like progress.
> > 
> > I think we will eventually start seein some HW be able to do this
> > invalidation, but it won't be universal, and I'd rather leave it
> > optional, for recovery from truely catastrophic errors (ie my DAX is
> > on fire, I need to unplug it).
> 
> Agreed.  I think software wise there is not much some of the devices can do
> with such an "invalidate".

So out of curiosity: What does RDMA driver do when userspace just closes
the file pointing to RDMA object? It has to handle that somehow by aborting
everything that's going on... And I wanted similar behavior here.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
