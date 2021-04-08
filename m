Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFB73588AF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Apr 2021 17:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbhDHPlK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Apr 2021 11:41:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:50090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231480AbhDHPlJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Apr 2021 11:41:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9115361107;
        Thu,  8 Apr 2021 15:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617896458;
        bh=AJAhG9HtEG365Wu9Zim+Won8T5Q6ni5Sm8/8FSGl46M=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=mCnWfyO7IND/OHZmnxZl2VF0iLoxxJ1lS9+aewL/NgkKc+N3YJQCWUgrS6zi2bzrz
         zgxG2ec2VtC+Gj7HR5UsL7Oj78cjLaBOcr0uEPeTUTrY3+BY4y5IWBKM/yTX6bDkCS
         nkL0uGHBdGs1bJ/GpHhZc9ptsUcCa7Ld7Ic861XFupstYuYExF5k854PlZ8hzFKRlk
         rfEGKJ8xWhU8qUTgL1SS+0WRFt0WZcm9/a1gAaG0EpzqQvqGODNzeyE0UzhPFTnG7u
         IeK0OY5rLK4bxKle50GQu0BMcxJr5qk7Q2EDlEcf4Ly0Eiz3YVYVinfafVtHEtwpwm
         oo3zW8WpCSLiA==
Message-ID: <b6ab8a21f59309a101bbea3b094c0aa3ef2eedb0.camel@kernel.org>
Subject: Re: [PATCH v6 00/30] Network fs helper library & fscache kiocb API
From:   Jeff Layton <jlayton@kernel.org>
To:     David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-cifs@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Mike Marshall <hubcap@omnibond.com>,
        linux-afs@lists.infradead.org,
        v9fs-developer@lists.sourceforge.net,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, linux-nfs@vger.kernel.org,
        linux-cachefs@redhat.com, ceph-devel@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        David Wysochanski <dwysocha@redhat.com>,
        linux-kernel@vger.kernel.org
Date:   Thu, 08 Apr 2021 11:40:55 -0400
In-Reply-To: <161789062190.6155.12711584466338493050.stgit@warthog.procyon.org.uk>
References: <161789062190.6155.12711584466338493050.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2021-04-08 at 15:03 +0100, David Howells wrote:
> Here's a set of patches to do two things:
> 
>  (1) Add a helper library to handle the new VM readahead interface.  This
>      is intended to be used unconditionally by the filesystem (whether or
>      not caching is enabled) and provides a common framework for doing
>      caching, transparent huge pages and, in the future, possibly fscrypt
>      and read bandwidth maximisation.  It also allows the netfs and the
>      cache to align, expand and slice up a read request from the VM in
>      various ways; the netfs need only provide a function to read a stretch
>      of data to the pagecache and the helper takes care of the rest.
> 
>  (2) Add an alternative fscache/cachfiles I/O API that uses the kiocb
>      facility to do async DIO to transfer data to/from the netfs's pages,
>      rather than using readpage with wait queue snooping on one side and
>      vfs_write() on the other.  It also uses less memory, since it doesn't
>      do buffered I/O on the backing file.
> 
>      Note that this uses SEEK_HOLE/SEEK_DATA to locate the data available
>      to be read from the cache.  Whilst this is an improvement from the
>      bmap interface, it still has a problem with regard to a modern
>      extent-based filesystem inserting or removing bridging blocks of
>      zeros.  Fixing that requires a much greater overhaul.
> 
> This is a step towards overhauling the fscache API.  The change is opt-in
> on the part of the network filesystem.  A netfs should not try to mix the
> old and the new API because of conflicting ways of handling pages and the
> PG_fscache page flag and because it would be mixing DIO with buffered I/O.
> Further, the helper library can't be used with the old API.
> 
> This does not change any of the fscache cookie handling APIs or the way
> invalidation is done.
> 
> In the near term, I intend to deprecate and remove the old I/O API
> (fscache_allocate_page{,s}(), fscache_read_or_alloc_page{,s}(),
> fscache_write_page() and fscache_uncache_page()) and eventually replace
> most of fscache/cachefiles with something simpler and easier to follow.
> 
> The patchset contains the following parts:
> 
>  (1) Some helper patches, including provision of an ITER_XARRAY iov
>      iterator and a function to do readahead expansion.
> 
>  (2) Patches to add the netfs helper library.
> 
>  (3) A patch to add the fscache/cachefiles kiocb API.
> 
>  (4) Patches to add support in AFS for this.
> 
> Jeff Layton has patches to add support in Ceph for this.
> 
> With this, AFS without a cache passes all expected xfstests; with a cache,
> there's an extra failure, but that's also there before these patches.
> Fixing that probably requires a greater overhaul.  Ceph also passes the
> expected tests.
> 
> The netfs lib and fscache/cachefiles patches can be found also on:
> 
> 	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=netfs-lib
> 
> The afs patches can be found on:
> 
> 	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=afs-netfs-lib
> 
> 
> Changes
> =======
> 
> ver #6:
>       Merged in some fixes and added an additional tracepoint[8], including
>       fixing the amalgamation of contiguous subrequests that are to be
>       written to the cache.
> 
>       Added/merged some patches from Matthew Wilcox to make
>       readahead_expand() appropriately adjust the trigger for the next
>       readahead[9].  Also included is a patch to kerneldocify the
>       file_ra_state struct.
> 
>       Altered netfs_write_begin() to use DEFINE_READAHEAD()[10].
> 
>       Split the afs patches out into their own branch.
> 
> ver #5:
>       Fixed some review comments from Matthew Wilcox:
> 
>       - Put a comment into netfs_readahead() to indicate why there's a loop
>         that puts, but doesn't unlock, "unconsumed" pages at the end when
>         it could just return said pages to the caller to dispose of[6].
>         (This is because where those pages are marked consumed).
> 
>       - Use the page_file_mapping() and page_index() helper functions
>       	rather than accessing the page struct directly[6].
> 
>       - Better names for wrangling functions for PG_private_2 and
>         PG_fscache wrangling functions[7].  Came up with
>         {set,end,wait_for}_page_private_2() and aliased these for fscache.
> 
>       Moved the taking of/dropping a page ref for the PG_private_2 flag
>       into the set and end functions.
> 
> ver #4:
>       Fixed some review comments from Christoph Hellwig, including dropping
>       the export of rw_verify_area()[3] and some minor stuff[4].
> 
>       Moved the declaration of readahead_expand() to a better location[5].
> 
>       Rebased to v5.12-rc2 and added a bunch of references into individual
>       commits.
> 
>       Dropped Ceph support - that will go through the maintainer's tree.
> 
>       Added interface documentation for the netfs helper library.
> 
> ver #3:
>       Rolled in the bug fixes.
> 
>       Adjusted the functions that unlock and wait for PG_fscache according
>       to Linus's suggestion[1].
> 
>       Hold a ref on a page when PG_fscache is set as per Linus's
>       suggestion[2].
> 
>       Dropped NFS support and added Ceph support.
> 
> ver #2:
>       Fixed some bugs and added NFS support.
> 
> Link: https://lore.kernel.org/r/CAHk-=wh+2gbF7XEjYc=HV9w_2uVzVf7vs60BPz0gFA=+pUm3ww@mail.gmail.com/ [1]
> Link: https://lore.kernel.org/r/CAHk-=wjgA-74ddehziVk=XAEMTKswPu1Yw4uaro1R3ibs27ztw@mail.gmail.com/ [2]
> Link: https://lore.kernel.org/r/20210216102614.GA27555@lst.de/ [3]
> Link: https://lore.kernel.org/r/20210216084230.GA23669@lst.de/ [4]
> Link: https://lore.kernel.org/r/20210217161358.GM2858050@casper.infradead.org/ [5]
> Link: https://lore.kernel.org/r/20210321014202.GF3420@casper.infradead.org/ [6]
> Link: https://lore.kernel.org/r/20210321105309.GG3420@casper.infradead.org/ [7]
> Link: https://lore.kernel.org/r/161781041339.463527.18139104281901492882.stgit@warthog.procyon.org.uk/ [8]
> Link: https://lore.kernel.org/r/20210407201857.3582797-1-willy@infradead.org/ [9]
> Link: https://lore.kernel.org/r/1234933.1617886271@warthog.procyon.org.uk/ [10]
> 
> References
> ==========
> 
> These patches have been published for review before, firstly as part of a
> larger set:
> 
> Link: https://lore.kernel.org/r/158861203563.340223.7585359869938129395.stgit@warthog.procyon.org.uk/
> 
> Link: https://lore.kernel.org/r/159465766378.1376105.11619976251039287525.stgit@warthog.procyon.org.uk/
> Link: https://lore.kernel.org/r/159465784033.1376674.18106463693989811037.stgit@warthog.procyon.org.uk/
> Link: https://lore.kernel.org/r/159465821598.1377938.2046362270225008168.stgit@warthog.procyon.org.uk/
> 
> Link: https://lore.kernel.org/r/160588455242.3465195.3214733858273019178.stgit@warthog.procyon.org.uk/
> 
> Then as a cut-down set:
> 
> Link: https://lore.kernel.org/r/161118128472.1232039.11746799833066425131.stgit@warthog.procyon.org.uk/ # v1
> 
> Link: https://lore.kernel.org/r/161161025063.2537118.2009249444682241405.stgit@warthog.procyon.org.uk/ # v2
> 
> Link: https://lore.kernel.org/r/161340385320.1303470.2392622971006879777.stgit@warthog.procyon.org.uk/ # v3
> 
> Link: https://lore.kernel.org/r/161539526152.286939.8589700175877370401.stgit@warthog.procyon.org.uk/ # v4
> 
> Link: https://lore.kernel.org/r/161653784755.2770958.11820491619308713741.stgit@warthog.procyon.org.uk/ # v5
> 
> Proposals/information about the design has been published here:
> 
> Link: https://lore.kernel.org/r/24942.1573667720@warthog.procyon.org.uk/
> Link: https://lore.kernel.org/r/2758811.1610621106@warthog.procyon.org.uk/
> Link: https://lore.kernel.org/r/1441311.1598547738@warthog.procyon.org.uk/
> Link: https://lore.kernel.org/r/160655.1611012999@warthog.procyon.org.uk/
> 
> And requests for information:
> 
> Link: https://lore.kernel.org/r/3326.1579019665@warthog.procyon.org.uk/
> Link: https://lore.kernel.org/r/4467.1579020509@warthog.procyon.org.uk/
> Link: https://lore.kernel.org/r/3577430.1579705075@warthog.procyon.org.uk/
> 
> I've posted partial patches to try and help 9p and cifs along:
> 
> Link: https://lore.kernel.org/r/1514086.1605697347@warthog.procyon.org.uk/
> Link: https://lore.kernel.org/r/1794123.1605713481@warthog.procyon.org.uk/
> Link: https://lore.kernel.org/r/241017.1612263863@warthog.procyon.org.uk/
> Link: https://lore.kernel.org/r/270998.1612265397@warthog.procyon.org.uk/
> 
> David
> ---
> David Howells (28):
>       iov_iter: Add ITER_XARRAY
>       mm: Add set/end/wait functions for PG_private_2
>       mm: Implement readahead_control pageset expansion
>       netfs: Make a netfs helper module
>       netfs: Documentation for helper library
>       netfs, mm: Move PG_fscache helper funcs to linux/netfs.h
>       netfs, mm: Add set/end/wait_on_page_fscache() aliases
>       netfs: Provide readahead and readpage netfs helpers
>       netfs: Add tracepoints
>       netfs: Gather stats
>       netfs: Add write_begin helper
>       netfs: Define an interface to talk to a cache
>       netfs: Add a tracepoint to log failures that would be otherwise unseen
>       fscache, cachefiles: Add alternate API to use kiocb for read/write to cache
>       afs: Disable use of the fscache I/O routines
>       afs: Pass page into dirty region helpers to provide THP size
>       afs: Print the operation debug_id when logging an unexpected data version
>       afs: Move key to afs_read struct
>       afs: Don't truncate iter during data fetch
>       afs: Log remote unmarshalling errors
>       afs: Set up the iov_iter before calling afs_extract_data()
>       afs: Use ITER_XARRAY for writing
>       afs: Wait on PG_fscache before modifying/releasing a page
>       afs: Extract writeback extension into its own function
>       afs: Prepare for use of THPs
>       afs: Use the fs operation ops to handle FetchData completion
>       afs: Use new netfs lib read helper API
>       afs: Use the netfs_write_begin() helper
> 
> Matthew Wilcox (Oracle) (2):
>       mm/filemap: Pass the file_ra_state in the ractl
>       fs: Document file_ra_state
> 
> 
>  Documentation/filesystems/index.rst         |    1 +
>  Documentation/filesystems/netfs_library.rst |  526 ++++++++
>  fs/Kconfig                                  |    1 +
>  fs/Makefile                                 |    1 +
>  fs/afs/Kconfig                              |    1 +
>  fs/afs/dir.c                                |  225 ++--
>  fs/afs/file.c                               |  483 ++------
>  fs/afs/fs_operation.c                       |    4 +-
>  fs/afs/fsclient.c                           |  108 +-
>  fs/afs/inode.c                              |    7 +-
>  fs/afs/internal.h                           |   59 +-
>  fs/afs/rxrpc.c                              |  150 +--
>  fs/afs/write.c                              |  657 +++++-----
>  fs/afs/yfsclient.c                          |   82 +-
>  fs/cachefiles/Makefile                      |    1 +
>  fs/cachefiles/interface.c                   |    5 +-
>  fs/cachefiles/internal.h                    |    9 +
>  fs/cachefiles/io.c                          |  420 +++++++
>  fs/ext4/verity.c                            |    2 +-
>  fs/f2fs/file.c                              |    2 +-
>  fs/f2fs/verity.c                            |    2 +-
>  fs/fscache/Kconfig                          |    1 +
>  fs/fscache/Makefile                         |    1 +
>  fs/fscache/internal.h                       |    4 +
>  fs/fscache/io.c                             |  116 ++
>  fs/fscache/page.c                           |    2 +-
>  fs/fscache/stats.c                          |    1 +
>  fs/netfs/Kconfig                            |   23 +
>  fs/netfs/Makefile                           |    5 +
>  fs/netfs/internal.h                         |   97 ++
>  fs/netfs/read_helper.c                      | 1185 +++++++++++++++++++
>  fs/netfs/stats.c                            |   59 +
>  include/linux/fs.h                          |   24 +-
>  include/linux/fscache-cache.h               |    4 +
>  include/linux/fscache.h                     |   50 +-
>  include/linux/netfs.h                       |  234 ++++
>  include/linux/pagemap.h                     |   41 +-
>  include/net/af_rxrpc.h                      |    2 +-
>  include/trace/events/afs.h                  |   74 +-
>  include/trace/events/netfs.h                |  261 ++++
>  mm/filemap.c                                |   63 +-
>  mm/internal.h                               |    7 +-
>  mm/readahead.c                              |   97 +-
>  net/rxrpc/recvmsg.c                         |    9 +-
>  44 files changed, 3998 insertions(+), 1108 deletions(-)
>  create mode 100644 Documentation/filesystems/netfs_library.rst
>  create mode 100644 fs/cachefiles/io.c
>  create mode 100644 fs/fscache/io.c
>  create mode 100644 fs/netfs/Kconfig
>  create mode 100644 fs/netfs/Makefile
>  create mode 100644 fs/netfs/internal.h
>  create mode 100644 fs/netfs/read_helper.c
>  create mode 100644 fs/netfs/stats.c
>  create mode 100644 include/linux/netfs.h
>  create mode 100644 include/trace/events/netfs.h
> 
> 

You can add this to 1-16:

    Tested-by: Jeff Layton <jlayton@kernel.org>

Tested with xfstests with fscache enabled on my local machine.

