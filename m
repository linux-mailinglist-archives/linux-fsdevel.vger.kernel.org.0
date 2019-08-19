Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C618D91D31
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2019 08:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbfHSGeQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Aug 2019 02:34:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:44952 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725768AbfHSGeP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Aug 2019 02:34:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id ED46FAC26;
        Mon, 19 Aug 2019 06:34:12 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 4D0DC1E155E; Mon, 19 Aug 2019 08:34:12 +0200 (CEST)
Date:   Mon, 19 Aug 2019 08:34:12 +0200
From:   Jan Kara <jack@suse.cz>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <20190819063412.GA20455@quack2.suse.cz>
References: <20190809225833.6657-1-ira.weiny@intel.com>
 <20190814101714.GA26273@quack2.suse.cz>
 <20190814180848.GB31490@iweiny-DESK2.sc.intel.com>
 <20190815130558.GF14313@quack2.suse.cz>
 <20190816190528.GB371@iweiny-DESK2.sc.intel.com>
 <20190817022603.GW6129@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190817022603.GW6129@dread.disaster.area>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat 17-08-19 12:26:03, Dave Chinner wrote:
> On Fri, Aug 16, 2019 at 12:05:28PM -0700, Ira Weiny wrote:
> > On Thu, Aug 15, 2019 at 03:05:58PM +0200, Jan Kara wrote:
> > > On Wed 14-08-19 11:08:49, Ira Weiny wrote:
> > > > On Wed, Aug 14, 2019 at 12:17:14PM +0200, Jan Kara wrote:
> > 2) Second reason is that I thought I did not have a good way to tell if the
> >    lease was actually in use.  What I mean is that letting the lease go should
> >    be ok IFF we don't have any pins...  I was thinking that without John's code
> >    we don't have a way to know if there are any pins...  But that is wrong...
> >    All we have to do is check
> > 
> > 	!list_empty(file->file_pins)
> > 
> > So now with this detail I think you are right, we should be able to hold the
> > lease through the struct file even if the process no longer has any
> > "references" to it (ie closes and munmaps the file).
> 
> I really, really dislike the idea of zombie layout leases. It's a
> nasty hack for poor application behaviour. This is a "we allow use
> after layout lease release" API, and I think encoding largely
> untraceable zombie objects into an API is very poor design.
> 
> From the fcntl man page:
> 
> LEASES
> 	Leases are associated with an open file description (see
> 	open(2)).  This means that duplicate file descriptors
> 	(created by, for example, fork(2) or dup(2))  re‐ fer  to
> 	the  same  lease,  and this lease may be modified or
> 	released using any of these descriptors.  Furthermore, the
> 	lease is released by either an explicit F_UNLCK operation on
> 	any of these duplicate file descriptors, or when all such
> 	file descriptors have been closed.
> 
> Leases are associated with *open* file descriptors, not the
> lifetime of the struct file in the kernel. If the application closes
> the open fds that refer to the lease, then the kernel does not
> guarantee, and the application has no right to expect, that the
> lease remains active in any way once the application closes all
> direct references to the lease.
> 
> IOWs, applications using layout leases need to hold the lease fd
> open for as long as the want access to the physical file layout. It
> is a also a requirement of the layout lease that the holder releases
> the resources it holds on the layout before it releases the layout
> lease, exclusive lease or not. Closing the fd indicates they do not
> need access to the file any more, and so the lease should be
> reclaimed at that point.
> 
> I'm of a mind to make the last close() on a file block if there's an
> active layout lease to prevent processes from zombie-ing layout
> leases like this. i.e. you can't close the fd until resources that
> pin the lease have been released.

Yeah, so this was my initial though as well [1]. But as the discussion in
that thread revealed, the problem with blocking last close is that kernel
does not really expect close to block. You could easily deadlock e.g. if
the process gets SIGKILL, file with lease has fd 10, and the RDMA context
holding pages pinned has fd 15. Or you could wait for another process to
release page pins and blocking SIGKILL on that is also bad. So in the end
the least bad solution we've come up with were these "zombie" leases as you
call them and tracking them in /proc so that userspace at least has a way
of seeing them. But if you can come up with a different solution, I'm
certainly not attached to the current one...

								Honza

[1] https://lore.kernel.org/lkml/20190606104203.GF7433@quack2.suse.cz
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
