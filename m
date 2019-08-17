Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF47D90C28
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2019 04:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbfHQC1U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Aug 2019 22:27:20 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:48957 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726032AbfHQC1U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Aug 2019 22:27:20 -0400
Received: from dread.disaster.area (pa49-195-190-67.pa.nsw.optusnet.com.au [49.195.190.67])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id D0D423617AF;
        Sat, 17 Aug 2019 12:27:10 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hyoPr-0000Wh-58; Sat, 17 Aug 2019 12:26:03 +1000
Date:   Sat, 17 Aug 2019 12:26:03 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        John Hubbard <jhubbard@nvidia.com>,
        Michal Hocko <mhocko@suse.com>, linux-xfs@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-ext4@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v2 00/19] RDMA/FS DAX truncate proposal V1,000,002 ;-)
Message-ID: <20190817022603.GW6129@dread.disaster.area>
References: <20190809225833.6657-1-ira.weiny@intel.com>
 <20190814101714.GA26273@quack2.suse.cz>
 <20190814180848.GB31490@iweiny-DESK2.sc.intel.com>
 <20190815130558.GF14313@quack2.suse.cz>
 <20190816190528.GB371@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190816190528.GB371@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0
        a=TR82T6zjGmBjdfWdGgpkDw==:117 a=TR82T6zjGmBjdfWdGgpkDw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=FmdZ9Uzk2mMA:10
        a=7-415B0cAAAA:8 a=r7a9GJFEl8VWeONERSwA:9 a=QEXdDO2ut3YA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 16, 2019 at 12:05:28PM -0700, Ira Weiny wrote:
> On Thu, Aug 15, 2019 at 03:05:58PM +0200, Jan Kara wrote:
> > On Wed 14-08-19 11:08:49, Ira Weiny wrote:
> > > On Wed, Aug 14, 2019 at 12:17:14PM +0200, Jan Kara wrote:
> 2) Second reason is that I thought I did not have a good way to tell if the
>    lease was actually in use.  What I mean is that letting the lease go should
>    be ok IFF we don't have any pins...  I was thinking that without John's code
>    we don't have a way to know if there are any pins...  But that is wrong...
>    All we have to do is check
> 
> 	!list_empty(file->file_pins)
> 
> So now with this detail I think you are right, we should be able to hold the
> lease through the struct file even if the process no longer has any
> "references" to it (ie closes and munmaps the file).

I really, really dislike the idea of zombie layout leases. It's a
nasty hack for poor application behaviour. This is a "we allow use
after layout lease release" API, and I think encoding largely
untraceable zombie objects into an API is very poor design.

From the fcntl man page:

LEASES
	Leases are associated with an open file description (see
	open(2)).  This means that duplicate file descriptors
	(created by, for example, fork(2) or dup(2))  re‐ fer  to
	the  same  lease,  and this lease may be modified or
	released using any of these descriptors.  Furthermore, the
	lease is released by either an explicit F_UNLCK operation on
	any of these duplicate file descriptors, or when all such
	file descriptors have been closed.

Leases are associated with *open* file descriptors, not the
lifetime of the struct file in the kernel. If the application closes
the open fds that refer to the lease, then the kernel does not
guarantee, and the application has no right to expect, that the
lease remains active in any way once the application closes all
direct references to the lease.

IOWs, applications using layout leases need to hold the lease fd
open for as long as the want access to the physical file layout. It
is a also a requirement of the layout lease that the holder releases
the resources it holds on the layout before it releases the layout
lease, exclusive lease or not. Closing the fd indicates they do not
need access to the file any more, and so the lease should be
reclaimed at that point.

I'm of a mind to make the last close() on a file block if there's an
active layout lease to prevent processes from zombie-ing layout
leases like this. i.e. you can't close the fd until resources that
pin the lease have been released.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
