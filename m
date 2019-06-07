Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E26D38E10
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2019 16:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbfFGOvB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jun 2019 10:51:01 -0400
Received: from mga18.intel.com ([134.134.136.126]:24997 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728446AbfFGOvB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jun 2019 10:51:01 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jun 2019 07:51:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,563,1557212400"; 
   d="scan'208";a="182683628"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga002.fm.intel.com with ESMTP; 07 Jun 2019 07:51:00 -0700
Date:   Fri, 7 Jun 2019 07:52:13 -0700
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
Message-ID: <20190607145213.GB14559@iweiny-DESK2.sc.intel.com>
References: <20190606014544.8339-1-ira.weiny@intel.com>
 <20190606104203.GF7433@quack2.suse.cz>
 <20190606195114.GA30714@ziepe.ca>
 <20190606222228.GB11698@iweiny-DESK2.sc.intel.com>
 <20190607103636.GA12765@quack2.suse.cz>
 <20190607121729.GA14802@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607121729.GA14802@ziepe.ca>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 07, 2019 at 09:17:29AM -0300, Jason Gunthorpe wrote:
> On Fri, Jun 07, 2019 at 12:36:36PM +0200, Jan Kara wrote:
> 
> > Because the pins would be invisible to sysadmin from that point on. 
> 
> It is not invisible, it just shows up in a rdma specific kernel
> interface. You have to use rdma netlink to see the kernel object
> holding this pin.
> 
> If this visibility is the main sticking point I suggest just enhancing
> the existing MR reporting to include the file info for current GUP
> pins and teaching lsof to collect information from there as well so it
> is easy to use.
> 
> If the ownership of the lease transfers to the MR, and we report that
> ownership to userspace in a way lsof can find, then I think all the
> concerns that have been raised are met, right?

I was contemplating some new lsof feature yesterday.  But what I don't think we
want is sysadmins to have multiple tools for multiple subsystems.  Or even have
to teach lsof something new for every potential new subsystem user of GUP pins.

I was thinking more along the lines of reporting files which have GUP pins on
them directly somewhere (dare I say procfs?) and teaching lsof to report that
information.  That would cover any subsystem which does a longterm pin.

> 
> > ugly to live so we have to come up with something better. The best I can
> > currently come up with is to have a method associated with the lease that
> > would invalidate the RDMA context that holds the pins in the same way that
> > a file close would do it.
> 
> This is back to requiring all RDMA HW to have some new behavior they
> currently don't have..
> 
> The main objection to the current ODP & DAX solution is that very
> little HW can actually implement it, having the alternative still
> require HW support doesn't seem like progress.
> 
> I think we will eventually start seein some HW be able to do this
> invalidation, but it won't be universal, and I'd rather leave it
> optional, for recovery from truely catastrophic errors (ie my DAX is
> on fire, I need to unplug it).

Agreed.  I think software wise there is not much some of the devices can do
with such an "invalidate".

Ira

