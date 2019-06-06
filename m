Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9491371E8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2019 12:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbfFFKmG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jun 2019 06:42:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:57984 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726935AbfFFKmG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jun 2019 06:42:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 00FC1AEF3;
        Thu,  6 Jun 2019 10:42:03 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 464A01E3F51; Thu,  6 Jun 2019 12:42:03 +0200 (CEST)
Date:   Thu, 6 Jun 2019 12:42:03 +0200
From:   Jan Kara <jack@suse.cz>
To:     ira.weiny@intel.com
Cc:     Dan Williams <dan.j.williams@intel.com>, Jan Kara <jack@suse.cz>,
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
Message-ID: <20190606104203.GF7433@quack2.suse.cz>
References: <20190606014544.8339-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606014544.8339-1-ira.weiny@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 05-06-19 18:45:33, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> ... V1,000,000   ;-)
> 
> Pre-requisites:
> 	John Hubbard's put_user_pages() patch series.[1]
> 	Jan Kara's ext4_break_layouts() fixes[2]
> 
> Based on the feedback from LSFmm and the LWN article which resulted.  I've
> decided to take a slightly different tack on this problem.
> 
> The real issue is that there is no use case for a user to have RDMA pinn'ed
> memory which is then truncated.  So really any solution we present which:
> 
> A) Prevents file system corruption or data leaks
> ...and...
> B) Informs the user that they did something wrong
> 
> Should be an acceptable solution.
> 
> Because this is slightly new behavior.  And because this is gonig to be
> specific to DAX (because of the lack of a page cache) we have made the user
> "opt in" to this behavior.
> 
> The following patches implement the following solution.
> 
> 1) The user has to opt in to allowing GUP pins on a file with a layout lease
>    (now made visible).
> 2) GUP will fail (EPERM) if a layout lease is not taken
> 3) Any truncate or hole punch operation on a GUP'ed DAX page will fail.
> 4) The user has the option of holding the layout lease to receive a SIGIO for
>    notification to the original thread that another thread has tried to delete
>    their data.  Furthermore this indicates that if the user needs to GUP the
>    file again they will need to retake the Layout lease before doing so.
> 
> 
> NOTE: If the user releases the layout lease or if it has been broken by
> another operation further GUP operations on the file will fail without
> re-taking the lease.  This means that if a user would like to register
> pieces of a file and continue to register other pieces later they would
> be advised to keep the layout lease, get a SIGIO notification, and retake
> the lease.
> 
> NOTE2: Truncation of pages which are not actively pinned will succeed.
> Similar to accessing an mmap to this area GUP pins of that memory may
> fail.

So after some through I'm willing accept the fact that pinned DAX pages
will just make truncate / hole punch fail and shove it into a same bucket
of situations like "user can open a file and unlink won't delete it" or
"ETXTBUSY when user is executing a file being truncated".  The problem I
have with this proposal is a lack of visibility from sysadmin POV. For
ETXTBUSY or "unlinked but open file" sysadmin can just do lsof, find the
problematic process and kill it. There's nothing like that with your
proposal since currently once you hold page reference, you can unmap the
file, drop layout lease, close the file, and there's no trace that you're
responsible for the pinned page anymore.

So I'd like to actually mandate that you *must* hold the file lease until
you unpin all pages in the given range (not just that you have an option to
hold a lease). And I believe the kernel should actually enforce this. That
way we maintain a sane state that if someone uses a physical location of
logical file offset on disk, he has a layout lease. Also once this is done,
sysadmin has a reasonably easy way to discover run-away RDMA application
and kill it if he wishes so.

The question is on how to exactly enforce that lease is taken until all
pages are unpinned. I belive it could be done by tracking number of
long-term pinned pages within a lease. Gup_longterm could easily increment
the count when verifying the lease exists, gup_longterm users will somehow
need to propagate corresponding 'filp' (struct file pointer) to
put_user_pages_longterm() callsites so that they can look up appropriate
lease to drop reference - probably I'd just transition all gup_longterm()
users to a saner API similar to the one we have in mm/frame_vector.c where
we don't hand out page pointers but an encapsulating structure that does
all the necessary tracking. Removing a lease would need to block until all
pins are released - this is probably the most hairy part since we need to
handle a case if application just closes the file descriptor which would
release the lease but OTOH we need to make sure task exit does not deadlock.
Maybe we could block only on explicit lease unlock and just drop the layout
lease on file close and if there are still pinned pages, send SIGKILL to an
application as a reminder it did something stupid...

What do people think about this?

								Honza
> 
> 
> A general overview follows for background.
> 
> It should be noted that one solution for this problem is to use RDMA's On
> Demand Paging (ODP).  There are 2 big reasons this may not work.
> 
> 	1) The hardware being used for RDMA may not support ODP
> 	2) ODP may be detrimental to the over all network (cluster or cloud)
> 	   performance
> 
> Therefore, in order to support RDMA to File system pages without On Demand
> Paging (ODP) a number of things need to be done.
> 
> 1) GUP "longterm" users need to inform the other subsystems that they have
>    taken a pin on a page which may remain pinned for a very "long time".[3]
> 
> 2) Any page which is "controlled" by a file system needs to have special
>    handling.  The details of the handling depends on if the page is page cache
>    fronted or not.
> 
>    2a) A page cache fronted page which has been pinned by GUP long term can use a
>    bounce buffer to allow the file system to write back snap shots of the page.
>    This is handled by the FS recognizing the GUP long term pin and making a copy
>    of the page to be written back.
> 	NOTE: this patch set does not address this path.
> 
>    2b) A FS "controlled" page which is not page cache fronted is either easier
>    to deal with or harder depending on the operation the filesystem is trying
>    to do.
> 
> 	2ba) [Hard case] If the FS operation _is_ a truncate or hole punch the
> 	FS can no longer use the pages in question until the pin has been
> 	removed.  This patch set presents a solution to this by introducing
> 	some reasonable restrictions on user space applications.
> 
> 	2bb) [Easy case] If the FS operation is _not_ a truncate or hole punch
> 	then there is nothing which need be done.  Data is Read or Written
> 	directly to the page.  This is an easy case which would currently work
> 	if not for GUP long term pins being disabled.  Therefore this patch set
> 	need not change access to the file data but does allow for GUP pins
> 	after 2ba above is dealt with.
> 
> 
> This patch series and presents a solution for problem 2ba)
> 
> [1] https://github.com/johnhubbard/linux/tree/gup_dma_core
> 
> [2] ext4/dev branch:
> 
> - https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git/log/?h=dev
> 
> 	Specific patches:
> 
> 	[2a] ext4: wait for outstanding dio during truncate in nojournal mode
> 
> 	- https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git/commit/?h=dev&id=82a25b027ca48d7ef197295846b352345853dfa8
> 
> 	[2b] ext4: do not delete unlinked inode from orphan list on failed truncate
> 
> 	- https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git/commit/?h=dev&id=ee0ed02ca93ef1ecf8963ad96638795d55af2c14
> 
> 	[2c] ext4: gracefully handle ext4_break_layouts() failure during truncate
> 
> 	- https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git/commit/?h=dev&id=b9c1c26739ec2d4b4fb70207a0a9ad6747e43f4c
> 
> [3] The definition of long time is debatable but it has been established
> that RDMAs use of pages, minutes or hours after the pin is the extreme case
> which makes this problem most severe.
> 
> 
> Ira Weiny (10):
>   fs/locks: Add trace_leases_conflict
>   fs/locks: Export F_LAYOUT lease to user space
>   mm/gup: Pass flags down to __gup_device_huge* calls
>   mm/gup: Ensure F_LAYOUT lease is held prior to GUP'ing pages
>   fs/ext4: Teach ext4 to break layout leases
>   fs/ext4: Teach dax_layout_busy_page() to operate on a sub-range
>   fs/ext4: Fail truncate if pages are GUP pinned
>   fs/xfs: Teach xfs to use new dax_layout_busy_page()
>   fs/xfs: Fail truncate if pages are GUP pinned
>   mm/gup: Remove FOLL_LONGTERM DAX exclusion
> 
>  fs/Kconfig                       |   1 +
>  fs/dax.c                         |  38 ++++++---
>  fs/ext4/ext4.h                   |   2 +-
>  fs/ext4/extents.c                |   6 +-
>  fs/ext4/inode.c                  |  26 +++++--
>  fs/locks.c                       |  97 ++++++++++++++++++++---
>  fs/xfs/xfs_file.c                |  24 ++++--
>  fs/xfs/xfs_inode.h               |   5 +-
>  fs/xfs/xfs_ioctl.c               |  15 +++-
>  fs/xfs/xfs_iops.c                |  14 +++-
>  fs/xfs/xfs_pnfs.c                |  14 ++--
>  include/linux/dax.h              |   9 ++-
>  include/linux/fs.h               |   2 +-
>  include/linux/mm.h               |   2 +
>  include/trace/events/filelock.h  |  35 +++++++++
>  include/uapi/asm-generic/fcntl.h |   3 +
>  mm/gup.c                         | 129 ++++++++++++-------------------
>  mm/huge_memory.c                 |  12 +++
>  18 files changed, 299 insertions(+), 135 deletions(-)
> 
> -- 
> 2.20.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
