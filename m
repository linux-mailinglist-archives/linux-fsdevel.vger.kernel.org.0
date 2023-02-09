Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 859BE69143F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Feb 2023 00:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbjBIXOy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Feb 2023 18:14:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjBIXOx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Feb 2023 18:14:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3248627AF;
        Thu,  9 Feb 2023 15:14:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6CC1F61B30;
        Thu,  9 Feb 2023 23:14:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF955C433D2;
        Thu,  9 Feb 2023 23:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675984489;
        bh=marhPHM64YQ/Cf7P66psxuiCrgCSy0StLtODID4QjvU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=plT23Saz2+mcBa8duU7+RFX1OyyolsFDMuax/Hx3oSjg97Y8htPnheGneqrM1niGP
         jjOjfFjrxprENddWSSQ7MgKs4hW11eQ+kS7M0FLLSf8v+yBUYlMOGZnQ2ZxIjRasCm
         sWT2MFFMxFGL6fcD+3MTYd+Fzm7QE9ob1QPNMoG3KDPhtGEvm2QH+50CfOP34Dq1Kb
         /dfy1Do7vgG/YP2LKiS+vhZrnLe8I/RDQhijKBc5fqSsKYKE4YLvFKSmkuKdJzil7o
         D2vFyogp+fxn/3RD1vFa0jscm7fOXMmz0W1Q5yo5RBfTw2jQtsT6meK/2N3Wnyz+It
         /sFDJ9iAVEtuA==
Date:   Thu, 9 Feb 2023 15:14:49 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Allison Henderson <allison.henderson@oracle.com>
Cc:     Catherine Hoang <catherine.hoang@oracle.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        Chandan Babu <chandan.babu@oracle.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>
Subject: Re: [PATCH 07/14] xfs: document pageable kernel memory
Message-ID: <Y+V+acznpk2LiT6m@magnolia>
References: <167243825144.682859.12802259329489258661.stgit@magnolia>
 <167243825260.682859.10235142095680268936.stgit@magnolia>
 <50fe53916b09566a2738db3bcba01a96f0a0de1f.camel@oracle.com>
 <Y9xD4LexgdPPeT7N@magnolia>
 <cea28efd65c1fa70b859209b342edafab5fd0fb7.camel@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cea28efd65c1fa70b859209b342edafab5fd0fb7.camel@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 09, 2023 at 05:41:22AM +0000, Allison Henderson wrote:
> On Thu, 2023-02-02 at 15:14 -0800, Darrick J. Wong wrote:
> > On Thu, Feb 02, 2023 at 07:14:22AM +0000, Allison Henderson wrote:
> > > On Fri, 2022-12-30 at 14:10 -0800, Darrick J. Wong wrote:
> > > > From: Darrick J. Wong <djwong@kernel.org>
> > > > 
> > > > Add a discussion of pageable kernel memory, since online fsck
> > > > needs
> > > > quite a bit more memory than most other parts of the filesystem
> > > > to
> > > > stage
> > > > records and other information.
> > > > 
> > > > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > > > ---
> > > >  .../filesystems/xfs-online-fsck-design.rst         |  490
> > > > ++++++++++++++++++++
> > > >  1 file changed, 490 insertions(+)
> > > > 
> > > > 
> > > > diff --git a/Documentation/filesystems/xfs-online-fsck-design.rst
> > > > b/Documentation/filesystems/xfs-online-fsck-design.rst
> > > > index 419eb54ee200..9d7a2ef1d0dd 100644
> > > > --- a/Documentation/filesystems/xfs-online-fsck-design.rst
> > > > +++ b/Documentation/filesystems/xfs-online-fsck-design.rst
> > > > @@ -383,6 +383,8 @@ Algorithms") of Srinivasan.
> > > >  However, any data structure builder that maintains a resource
> > > > lock
> > > > for the
> > > >  duration of the repair is *always* an offline algorithm.
> > > >  
> > > > +.. _secondary_metadata:
> > > > +
> > > >  Secondary Metadata
> > > >  ``````````````````
> > > >  
> > > > @@ -1746,3 +1748,491 @@ Scrub teardown disables all static keys
> > > > obtained by ``xchk_fshooks_enable``.
> > > >  
> > > >  For more information, please see the kernel documentation of
> > > >  Documentation/staging/static-keys.rst.
> > > > +
> > > > +.. _xfile:
> > > > +
> > > > +Pageable Kernel Memory
> > > > +----------------------
> > > > +
> > > > +Demonstrations of the first few prototypes of online repair
> > > > revealed
> > > > new
> > > > +technical requirements that were not originally identified.
> > > > +For the first demonstration, the code walked whatever filesystem
> > > > +metadata it needed to synthesize new records and inserted
> > > > records
> > > > into a new
> > > > +btree as it found them.
> > > > +This was subpar since any additional corruption or runtime
> > > > errors
> > > > encountered
> > > > +during the walk would shut down the filesystem.
> > > > +After remount, the blocks containing the half-rebuilt data
> > > > structure
> > > > would not
> > > > +be accessible until another repair was attempted.
> > > > +Solving the problem of half-rebuilt data structures will be
> > > > discussed in the
> > > > +next section.
> > > > +
> > > > +For the second demonstration, the synthesized records were
> > > > instead
> > > > stored in
> > > > +kernel slab memory.
> > > > +Doing so enabled online repair to abort without writing to the
> > > > filesystem if
> > > > +the metadata walk failed, which prevented online fsck from
> > > > making
> > > > things worse.
> > > > +However, even this approach needed improving upon.
> > > > +
> > > > +There are four reasons why traditional Linux kernel memory
> > > > management isn't
> > > > +suitable for storing large datasets:
> > > > +
> > > > +1. Although it is tempting to allocate a contiguous block of
> > > > memory
> > > > to create a
> > > > +   C array, this cannot easily be done in the kernel because it
> > > > cannot be
> > > > +   relied upon to allocate multiple contiguous memory pages.
> > > > +
> > > > +2. While disparate physical pages can be virtually mapped
> > > > together,
> > > > installed
> > > > +   memory might still not be large enough to stage the entire
> > > > record
> > > > set in
> > > > +   memory while constructing a new btree.
> > > > +
> > > > +3. To overcome these two difficulties, the implementation was
> > > > adjusted to use
> > > > +   doubly linked lists, which means every record object needed
> > > > two
> > > > 64-bit list
> > > > +   head pointers, which is a lot of overhead.
> > > > +
> > > > +4. Kernel memory is pinned, which can drive the system out of
> > > > memory, leading
> > > > +   to OOM kills of unrelated processes.
> > > > +
> > > I think I maybe might just jump to what ever the current plan is
> > > instead of trying to keep a record of the dev history in the
> > > document.
> > > I'm sure we're not done yet, dev really never is, so in order for
> > > the
> > > documentation to be maintained, it would just get bigger and bigger
> > > to
> > > keep documenting it this way.  It's not that the above isnt
> > > valuable,
> > > but maybe a different kind of document really.
> > 
> > OK, I've shortened this introduction to outline the requirements, and
> > trimmed the historical information to a sidebar:
> > 
> > "Some online checking functions work by scanning the filesystem to
> > build
> > a shadow copy of an ondisk metadata structure in memory and comparing
> > the two copies. For online repair to rebuild a metadata structure, it
> > must compute the record set that will be stored in the new structure
> > before it can persist that new structure to disk. Ideally, repairs
> > complete with a single atomic commit that introduces a new data
> > structure. To meet these goals, the kernel needs to collect a large
> > amount of information in a place that doesn’t require the correct
> > operation of the filesystem.
> > 
> > "Kernel memory isn’t suitable because:
> > 
> > *   Allocating a contiguous region of memory to create a C array is
> > very
> >     difficult, especially on 32-bit systems.
> > 
> > *   Linked lists of records introduce double pointer overhead which
> > is
> >     very high and eliminate the possibility of indexed lookups.
> > 
> > *   Kernel memory is pinned, which can drive the system into OOM
> >     conditions.
> > 
> > *   The system might not have sufficient memory to stage all the
> >     information.
> > 
> > "At any given time, online fsck does not need to keep the entire
> > record
> > set in memory, which means that individual records can be paged out
> > if
> > necessary. Continued development of online fsck demonstrated that the
> > ability to perform indexed data storage would also be very useful.
> > Fortunately, the Linux kernel already has a facility for
> > byte-addressable and pageable storage: tmpfs. In-kernel graphics
> > drivers
> > (most notably i915) take advantage of tmpfs files to store
> > intermediate
> > data that doesn’t need to be in memory at all times, so that usage
> > precedent is already established. Hence, the xfile was born!
> > 
> > Historical Sidebar
> > ------------------
> > 
> > "The first edition of online repair inserted records into a new btree
> > as
> > it found them, which failed because filesystem could shut down with a
> > built data structure, which would be live after recovery finished.
> > 
> > "The second edition solved the half-rebuilt structure problem by
> > storing
> > everything in memory, but frequently ran the system out of memory.
> > 
> > "The third edition solved the OOM problem by using linked lists, but
> > the
> > list overhead was extreme."
> Ok, I think that's cleaner
> 
> > 
> > > 
> > > 
> > > > +For the third iteration, attention swung back to the possibility
> > > > of
> > > > using
> > > 
> > > Due to the large volume of metadata that needs to be processed,
> > > ofsck
> > > uses...
> > > 
> > > > +byte-indexed array-like storage to reduce the overhead of in-
> > > > memory
> > > > records.
> > > > +At any given time, online repair does not need to keep the
> > > > entire
> > > > record set in
> > > > +memory, which means that individual records can be paged out.
> > > > +Creating new temporary files in the XFS filesystem to store
> > > > intermediate data
> > > > +was explored and rejected for some types of repairs because a
> > > > filesystem with
> > > > +compromised space and inode metadata should never be used to fix
> > > > compromised
> > > > +space or inode metadata.
> > > > +However, the kernel already has a facility for byte-addressable
> > > > and
> > > > pageable
> > > > +storage: shmfs.
> > > > +In-kernel graphics drivers (most notably i915) take advantage of
> > > > shmfs files
> > > > +to store intermediate data that doesn't need to be in memory at
> > > > all
> > > > times, so
> > > > +that usage precedent is already established.
> > > > +Hence, the ``xfile`` was born!
> > > > +
> > > > +xfile Access Models
> > > > +```````````````````
> > > > +
> > > > +A survey of the intended uses of xfiles suggested these use
> > > > cases:
> > > > +
> > > > +1. Arrays of fixed-sized records (space management btrees,
> > > > directory
> > > > and
> > > > +   extended attribute entries)
> > > > +
> > > > +2. Sparse arrays of fixed-sized records (quotas and link counts)
> > > > +
> > > > +3. Large binary objects (BLOBs) of variable sizes (directory and
> > > > extended
> > > > +   attribute names and values)
> > > > +
> > > > +4. Staging btrees in memory (reverse mapping btrees)
> > > > +
> > > > +5. Arbitrary contents (realtime space management)
> > > > +
> > > > +To support the first four use cases, high level data structures
> > > > wrap
> > > > the xfile
> > > > +to share functionality between online fsck functions.
> > > > +The rest of this section discusses the interfaces that the xfile
> > > > presents to
> > > > +four of those five higher level data structures.
> > > > +The fifth use case is discussed in the :ref:`realtime summary
> > > > <rtsummary>` case
> > > > +study.
> > > > +
> > > > +The most general storage interface supported by the xfile
> > > > enables
> > > > the reading
> > > > +and writing of arbitrary quantities of data at arbitrary offsets
> > > > in
> > > > the xfile.
> > > > +This capability is provided by ``xfile_pread`` and
> > > > ``xfile_pwrite``
> > > > functions,
> > > > +which behave similarly to their userspace counterparts.
> > > > +XFS is very record-based, which suggests that the ability to
> > > > load
> > > > and store
> > > > +complete records is important.
> > > > +To support these cases, a pair of ``xfile_obj_load`` and
> > > > ``xfile_obj_store``
> > > > +functions are provided to read and persist objects into an
> > > > xfile.
> > > > +They are internally the same as pread and pwrite, except that
> > > > they
> > > > treat any
> > > > +error as an out of memory error.
> > > > +For online repair, squashing error conditions in this manner is
> > > > an
> > > > acceptable
> > > > +behavior because the only reaction is to abort the operation
> > > > back to
> > > > userspace.
> > > > +All five xfile usecases can be serviced by these four functions.
> > > > +
> > > > +However, no discussion of file access idioms is complete without
> > > > answering the
> > > > +question, "But what about mmap?"
> > > I actually wouldn't spend too much time discussing solutions that
> > > didn't work for what ever reason, unless someones really asking for
> > > it.
> > >  I think this section would read just fine to trim off the last
> > > paragraph here
> > 
> > Since I wrote this, I've been experimenting with wiring up the tmpfs
> > file page cache folios to the xfs buffer cache.  Pinning the folios
> > in
> > this manner makes it so that online fsck can (more or less) directly
> > access the xfile contents.  Much to my surprise, this has actually
> > held
> > up in testing, so ... it's no longer a solution that "didn't really
> > work". :)
> > 
> > I also need to s/page/folio/ now that willy has finished that
> > conversion.  This section has been rewritten as such:
> > 
> > "However, no discussion of file access idioms is complete without
> > answering the question, “But what about mmap?” It is convenient to
> > access storage directly with pointers, just like userspace code does
> > with regular memory. Online fsck must not drive the system into OOM
> > conditions, which means that xfiles must be responsive to memory
> > reclamation. tmpfs can only push a pagecache folio to the swap cache
> > if
> > the folio is neither pinned nor locked, which means the xfile must
> > not
> > pin too many folios.
> > 
> > "Short term direct access to xfile contents is done by locking the
> > pagecache folio and mapping it into kernel address space.
> > Programmatic
> > access (e.g. pread and pwrite) uses this mechanism. Folio locks are
> > not
> > supposed to be held for long periods of time, so long term direct
> > access
> > to xfile contents is done by bumping the folio refcount, mapping it
> > into
> > kernel address space, and dropping the folio lock. These long term
> > users
> > must be responsive to memory reclaim by hooking into the shrinker
> > infrastructure to know when to release folios.
> > 
> > "The xfile_get_page and xfile_put_page functions are provided to
> > retrieve the (locked) folio that backs part of an xfile and to
> > release
> > it. The only code to use these folio lease functions are the xfarray
> > sorting algorithms and the in-memory btrees."
> Alrighty, sounds like a good upate then
> 
> > 
> > > > +It would be *much* more convenient if kernel code could access
> > > > pageable kernel
> > > > +memory with pointers, just like userspace code does with regular
> > > > memory.
> > > > +Like any other filesystem that uses the page cache, reads and
> > > > writes
> > > > of xfile
> > > > +data lock the cache page and map it into the kernel address
> > > > space
> > > > for the
> > > > +duration of the operation.
> > > > +Unfortunately, shmfs can only write a file page to the swap
> > > > device
> > > > if the page
> > > > +is unmapped and unlocked, which means the xfile risks causing
> > > > OOM
> > > > problems
> > > > +unless it is careful not to pin too many pages.
> > > > +Therefore, the xfile steers most of its users towards
> > > > programmatic
> > > > access so
> > > > +that backing pages are not kept locked in memory for longer than
> > > > is
> > > > necessary.
> > > > +However, for callers performing quick linear scans of xfile
> > > > data,
> > > > +``xfile_get_page`` and ``xfile_put_page`` functions are provided
> > > > to
> > > > pin a page
> > > > +in memory.
> > > > +So far, the only code to use these functions are the xfarray
> > > > :ref:`sorting
> > > > +<xfarray_sort>` algorithms.
> > > > +
> > > > +xfile Access Coordination
> > > > +`````````````````````````
> > > > +
> > > > +For security reasons, xfiles must be owned privately by the
> > > > kernel.
> > > > +They are marked ``S_PRIVATE`` to prevent interference from the
> > > > security system,
> > > > +must never be mapped into process file descriptor tables, and
> > > > their
> > > > pages must
> > > > +never be mapped into userspace processes.
> > > > +
> > > > +To avoid locking recursion issues with the VFS, all accesses to
> > > > the
> > > > shmfs file
> > > > +are performed by manipulating the page cache directly.
> > > > +xfile writes call the ``->write_begin`` and ``->write_end``
> > > > functions of the
> > > > +xfile's address space to grab writable pages, copy the caller's
> > > > buffer into the
> > > > +page, and release the pages.
> > > > +xfile reads call ``shmem_read_mapping_page_gfp`` to grab pages
> > > xfile readers
> > 
> > OK.
> > 
> > > > directly before
> > > > +copying the contents into the caller's buffer.
> > > > +In other words, xfiles ignore the VFS read and write code paths
> > > > to
> > > > avoid
> > > > +having to create a dummy ``struct kiocb`` and to avoid taking
> > > > inode
> > > > and
> > > > +freeze locks.
> > > > +
> > > > +If an xfile is shared between threads to stage repairs, the
> > > > caller
> > > > must provide
> > > > +its own locks to coordinate access.
> > > Ofsck threads that share an xfile between stage repairs will use
> > > their
> > > own locks to coordinate access with each other.
> > > 
> > > ?
> > 
> > Hm.  I wonder if there's a misunderstanding here?
> > 
> > Online fsck functions themselves are single-threaded, which is to say
> > that they themselves neither queue workers nor start kthreads. 
> > However,
> > an xfile created by a running fsck function can be accessed from
> > other
> > thread if the fsck function also hooks itself into filesystem code.
> > 
> > The live update section has a nice diagram of how that works:
> > https://djwong.org/docs/xfs-online-fsck-design/#filesystem-hooks
> > 
> 
> Oh ok, I think I got hung up on who the callers were.  How about
> "xfiles shared between threads running from hooked filesystem functions
> will use their own locks to coordinate access with each other."

I don't want to mention filesystem hooks before the chapter that
introduces them.  How about:

"For example, if a scrub function stores scan results in an xfile and
needs other threads to provide updates to the scanned data, the scrub
function must provide a lock for all threads to share."

--D
