Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC08699FDD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Feb 2023 23:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjBPWs5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Feb 2023 17:48:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjBPWs4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Feb 2023 17:48:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81764DE2A;
        Thu, 16 Feb 2023 14:48:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B1976101A;
        Thu, 16 Feb 2023 22:48:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76DAFC433EF;
        Thu, 16 Feb 2023 22:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676587713;
        bh=E/BFcZ7pxuvJ1Xs7xD2fR6js/GJDBA0TgFlPDbXG9pw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BxhOI/bkb6VmLVqaqSYUmTmjHyp9ZONiDz9BoALBhUrAXiYztxdT99HCS+36wtd4f
         vpsDFN5ZrYHlRwr9T8iBMKvadshdY5Zto1dPyfHS4G40tBVEhqtrOjF8Dvt54uar52
         kRul/jh790qhnks03RQMevi2JMga6i57g465SV7MPh1lqgEjbq7mf0wnPcHouNSReR
         90Avf1huPf4vuwXqqIPmoXexB3tO+RSULTaQrnjxbLJfWAxkAzWMtwcoiYY3dAOKI7
         rhwmte2hnwX0yjsJcFcwHxRs3enZaWzq1DYjPKmIYA5Zv8Q9Oc72PrdWJ0o9fIbxuZ
         qnM3MfkOje37A==
Date:   Thu, 16 Feb 2023 14:48:32 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Allison Henderson <allison.henderson@oracle.com>
Cc:     Catherine Hoang <catherine.hoang@oracle.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        Chandan Babu <chandan.babu@oracle.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>
Subject: Re: [PATCH 10/14] xfs: document full filesystem scans for online fsck
Message-ID: <Y+6ywAO0fdddf79C@magnolia>
References: <167243825144.682859.12802259329489258661.stgit@magnolia>
 <167243825302.682859.6563684998299886921.stgit@magnolia>
 <81d41ce2c183f8bbb7c28d5aa688e23348c87bdc.camel@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <81d41ce2c183f8bbb7c28d5aa688e23348c87bdc.camel@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 16, 2023 at 03:47:20PM +0000, Allison Henderson wrote:
> On Fri, 2022-12-30 at 14:10 -0800, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > Certain parts of the online fsck code need to scan every file in the
> > entire filesystem.  It is not acceptable to block the entire
> > filesystem
> > while this happens, which means that we need to be clever in allowing
> > scans to coordinate with ongoing filesystem updates.  We also need to
> > hook the filesystem so that regular updates propagate to the staging
> > records.
> > 
> > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > ---
> >  .../filesystems/xfs-online-fsck-design.rst         |  677
> > ++++++++++++++++++++
> >  1 file changed, 677 insertions(+)
> > 
> > 
> > diff --git a/Documentation/filesystems/xfs-online-fsck-design.rst
> > b/Documentation/filesystems/xfs-online-fsck-design.rst
> > index a658da8fe4ae..c0f08a773f08 100644
> > --- a/Documentation/filesystems/xfs-online-fsck-design.rst
> > +++ b/Documentation/filesystems/xfs-online-fsck-design.rst
> > @@ -3018,3 +3018,680 @@ The proposed patchset is the
> >  `summary counter cleanup
> >  <
> > https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/
> > log/?h=repair-fscounters>`_
> >  series.
> > +
> > +Full Filesystem Scans
> > +---------------------
> > +
> > +Certain types of metadata can only be checked by walking every file
> > in the
> > +entire filesystem to record observations and comparing the
> > observations against
> > +what's recorded on disk.
> > +Like every other type of online repair, repairs are made by writing
> > those
> > +observations to disk in a replacement structure and committing it
> > atomically.
> > +However, it is not practical to shut down the entire filesystem to
> > examine
> > +hundreds of billions of files because the downtime would be
> > excessive.
> > +Therefore, online fsck must build the infrastructure to manage a
> > live scan of
> > +all the files in the filesystem.
> > +There are two questions that need to be solved to perform a live
> > walk:
> > +
> > +- How does scrub manage the scan while it is collecting data?
> > +
> > +- How does the scan keep abreast of changes being made to the system
> > by other
> > +  threads?
> > +
> > +.. _iscan:
> > +
> > +Coordinated Inode Scans
> > +```````````````````````
> > +
> > +In the original Unix filesystems of the 1970s, each directory entry
> > contained
> > +an index number (*inumber*) which was used as an index into on
> > ondisk array
> > +(*itable*) of fixed-size records (*inodes*) describing a file's
> > attributes and
> > +its data block mapping.
> > +This system is described by J. Lions, `"inode (5659)"
> > +<http://www.lemis.com/grog/Documentation/Lions/>`_ in *Lions'
> > Commentary on
> > +UNIX, 6th Edition*, (Dept. of Computer Science, the University of
> > New South
> > +Wales, November 1977), pp. 18-2; and later by D. Ritchie and K.
> > Thompson,
> > +`"Implementation of the File System"
> > +<https://archive.org/details/bstj57-6-1905/page/n8/mode/1up>`_, from
> > *The UNIX
> > +Time-Sharing System*, (The Bell System Technical Journal, July
> > 1978), pp.
> > +1913-4.
> > +
> > +XFS retains most of this design, except now inumbers are search keys
> > over all
> > +the space in the data section filesystem.
> > +They form a continuous keyspace that can be expressed as a 64-bit
> > integer,
> > +though the inodes themselves are sparsely distributed within the
> > keyspace.
> > +Scans proceed in a linear fashion across the inumber keyspace,
> > starting from
> > +``0x0`` and ending at ``0xFFFFFFFFFFFFFFFF``.
> > +Naturally, a scan through a keyspace requires a scan cursor object
> > to track the
> > +scan progress.
> > +Because this keyspace is sparse, this cursor contains two parts.
> > +The first part of this scan cursor object tracks the inode that will
> > be
> > +examined next; call this the examination cursor.
> > +Somewhat less obviously, the scan cursor object must also track
> > which parts of
> > +the keyspace have already been visited, which is critical for
> > deciding if a
> > +concurrent filesystem update needs to be incorporated into the scan
> > data.
> > +Call this the visited inode cursor.
> > +
> > +Advancing the scan cursor is a multi-step process encapsulated in
> > +``xchk_iscan_iter``:
> > +
> > +1. Lock the AGI buffer of the AG containing the inode pointed to by
> > the visited
> > +   inode cursor.
> > +   This guarantee that inodes in this AG cannot be allocated or
> > freed while
> > +   advancing the cursor.
> > +
> > +2. Use the per-AG inode btree to look up the next inumber after the
> > one that
> > +   was just visited, since it may not be keyspace adjacent.
> > +
> > +3. If there are no more inodes left in this AG:
> > +
> > +   a. Move the examination cursor to the point of the inumber
> > keyspace that
> > +      corresponds to the start of the next AG.
> > +
> > +   b. Adjust the visited inode cursor to indicate that it has
> > "visited" the
> > +      last possible inode in the current AG's inode keyspace.
> > +      XFS inumbers are segmented, so the cursor needs to be marked
> > as having
> > +      visited the entire keyspace up to just before the start of the
> > next AG's
> > +      inode keyspace.
> > +
> > +   c. Unlock the AGI and return to step 1 if there are unexamined
> > AGs in the
> > +      filesystem.
> > +
> > +   d. If there are no more AGs to examine, set both cursors to the
> > end of the
> > +      inumber keyspace.
> > +      The scan is now complete.
> > +
> > +4. Otherwise, there is at least one more inode to scan in this AG:
> > +
> > +   a. Move the examination cursor ahead to the next inode marked as
> > allocated
> > +      by the inode btree.
> > +
> > +   b. Adjust the visited inode cursor to point to the inode just
> > prior to where
> > +      the examination cursor is now.
> > +      Because the scanner holds the AGI buffer lock, no inodes could
> > have been
> > +      created in the part of the inode keyspace that the visited
> > inode cursor
> > +      just advanced.
> > +
> > +5. Get the incore inode for the inumber of the examination cursor.
> > +   By maintaining the AGI buffer lock until this point, the scanner
> > knows that
> > +   it was safe to advance the examination cursor across the entire
> > keyspace,
> > +   and that it has stabilized this next inode so that it cannot
> > disappear from
> > +   the filesystem until the scan releases the incore inode.
> > +
> > +6. Drop the AGI lock and return the incore inode to the caller.
> > +
> > +Online fsck functions scan all files in the filesystem as follows:
> > +
> > +1. Start a scan by calling ``xchk_iscan_start``.
> Hmm, I actually did not find xchk_iscan_start in the below branch, I
> found xchk_iscan_iter in "xfs: implement live inode scan for scrub",
> but it doesnt look like anything uses it yet, at least not in that
> branch.

<nod> The topic branch linked below has the implementation, but no
users.  The first user is online quotacheck, which is in the next branch
after that:

https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=repair-quotacheck

Specifically, this patch:

https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/commit/?h=repair-quotacheck&id=3640515b9282514d91a407b6aa8d8b73caa123c5

I'll restate what you probably saw in the commit message for this
email discussion:

This "one branch to introduce a new infrastructure and a second branch
to actually use it" pattern is a result of reviewer requests for smaller
more focused branches.  This has turned out to be useful in practice
because it's easier to move just these pieces up and down in the branch
as needed.  The inode scan was originally developed for rmapbt repair
(which comes *much* later) and moved it up once I realized that
quotacheck has far fewer dependencies and hence all of this could come
earlier.

You're right that this section ought to point to an actual user of the
functionality.  Will fix. :)

> Also, it took me a bit to figure out that "initial user" meant "calling
> function"

Er... are you talking about the sentence "...new code is split out as a
separate patch from its initial user" in the patch commit message?

Maybe I should reword that:

"This new code is a separate patch from the patches adding callers for
the sake of enabling the author to move patches around his tree..."

> > +
> > +2. Advance the scan cursor (``xchk_iscan_iter``) to get the next
> > inode.
> > +   If one is provided:
> > +
> > +   a. Lock the inode to prevent updates during the scan.
> > +
> > +   b. Scan the inode.
> > +
> > +   c. While still holding the inode lock, adjust the visited inode
> > cursor
> > +      (``xchk_iscan_mark_visited``) to point to this inode.
> > +
> > +   d. Unlock and release the inode.
> > +
> > +8. Call ``xchk_iscan_finish`` to complete the scan.
> > +
> > +There are subtleties with the inode cache that complicate grabbing
> > the incore
> > +inode for the caller.
> > +Obviously, it is an absolute requirement that the inode metadata be
> > consistent
> > +enough to load it into the inode cache.
> > +Second, if the incore inode is stuck in some intermediate state, the
> > scan
> > +coordinator must release the AGI and push the main filesystem to get
> > the inode
> > +back into a loadable state.
> > +
> > +The proposed patches are the
> > +`inode scanner
> > +<
> > https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/
> > log/?h=scrub-iscan>`_
> > +series.
> > +
> > +Inode Management
> > +````````````````
> > +
> > +In regular filesystem code, references to allocated XFS incore
> > inodes are
> > +always obtained (``xfs_iget``) outside of transaction context
> > because the
> > +creation of the incore context for ane xisting file does not require
> an existing

Corrected, thank you.

> > metadata
> > +updates.
> > +However, it is important to note that references to incore inodes
> > obtained as
> > +part of file creation must be performed in transaction context
> > because the
> > +filesystem must ensure the atomicity of the ondisk inode btree index
> > updates
> > +and the initialization of the actual ondisk inode.
> > +
> > +References to incore inodes are always released (``xfs_irele``)
> > outside of
> > +transaction context because there are a handful of activities that
> > might
> > +require ondisk updates:
> > +
> > +- The VFS may decide to kick off writeback as part of a
> > ``DONTCACHE`` inode
> > +  release.
> > +
> > +- Speculative preallocations need to be unreserved.
> > +
> > +- An unlinked file may have lost its last reference, in which case
> > the entire
> > +  file must be inactivated, which involves releasing all of its
> > resources in
> > +  the ondisk metadata and freeing the inode.
> > +
> > +These activities are collectively called inode inactivation.
> > +Inactivation has two parts -- the VFS part, which initiates
> > writeback on all
> > +dirty file pages, and the XFS part, which cleans up XFS-specific
> > information
> > +and frees the inode if it was unlinked.
> > +If the inode is unlinked (or unconnected after a file handle
> > operation), the
> > +kernel drops the inode into the inactivation machinery immediately.
> > +
> > +During normal operation, resource acquisition for an update follows
> > this order
> > +to avoid deadlocks:
> > +
> > +1. Inode reference (``iget``).
> > +
> > +2. Filesystem freeze protection, if repairing
> > (``mnt_want_write_file``).
> > +
> > +3. Inode ``IOLOCK`` (VFS ``i_rwsem``) lock to control file IO.
> > +
> > +4. Inode ``MMAPLOCK`` (page cache ``invalidate_lock``) lock for
> > operations that
> > +   can update page cache mappings.
> > +
> > +5. Log feature enablement.
> > +
> > +6. Transaction log space grant.
> > +
> > +7. Space on the data and realtime devices for the transaction.
> > +
> > +8. Incore dquot references, if a file is being repaired.
> > +   Note that they are not locked, merely acquired.
> > +
> > +9. Inode ``ILOCK`` for file metadata updates.
> > +
> > +10. AG header buffer locks / Realtime metadata inode ILOCK.
> > +
> > +11. Realtime metadata buffer locks, if applicable.
> > +
> > +12. Extent mapping btree blocks, if applicable.
> > +
> > +Resources are often released in the reverse order, though this is
> > not required.
> > +However, online fsck differs from regular XFS operations because it
> > may examine
> > +an object that normally is acquired in a later stage of the locking
> > order, and
> > +then decide to cross-reference the object with an object that is
> > acquired
> > +earlier in the order.
> > +The next few sections detail the specific ways in which online fsck
> > takes care
> > +to avoid deadlocks.
> > +
> > +iget and irele During a Scrub
> > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > +
> > +An inode scan performed on behalf of a scrub operation runs in
> > transaction
> > +context, and possibly with resources already locked and bound to it.
> > +This isn't much of a problem for ``iget`` since it can operate in
> > the context
> > +of an existing transaction, as long as all of the bound resources
> > are acquired
> > +before the inode reference in the regular filesystem.
> > +
> > +When the VFS ``iput`` function is given a linked inode with no other
> > +references, it normally puts the inode on an LRU list in the hope
> > that it can
> > +save time if another process re-opens the file before the system
> > runs out
> > +of memory and frees it.
> > +Filesystem callers can short-circuit the LRU process by setting a
> > ``DONTCACHE``
> > +flag on the inode to cause the kernel to try to drop the inode into
> > the
> > +inactivation machinery immediately.
> > +
> > +In the past, inactivation was always done from the process that
> > dropped the
> > +inode, which was a problem for scrub because scrub may already hold
> > a
> > +transaction, and XFS does not support nesting transactions.
> > +On the other hand, if there is no scrub transaction, it is desirable
> > to drop
> > +otherwise unused inodes immediately to avoid polluting caches.
> > +To capture these nuances, the online fsck code has a separate
> > ``xchk_irele``
> > +function to set or clear the ``DONTCACHE`` flag to get the required
> > release
> > +behavior.
> > +
> > +Proposed patchsets include fixing
> > +`scrub iget usage
> > +<
> > https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/
> > log/?h=scrub-iget-fixes>`_ and
> > +`dir iget usage
> > +<
> > https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/
> > log/?h=scrub-dir-iget-fixes>`_.
> > +
> > +Locking Inodes
> > +^^^^^^^^^^^^^^
> > +
> > +In regular filesystem code, the VFS and XFS will acquire multiple
> > IOLOCK locks
> > +in a well-known order: parent → child when updating the directory
> > tree, and
> > +``struct inode`` address order otherwise.
> > +For regular files, the MMAPLOCK can be acquired after the IOLOCK to
> > stop page
> > +faults.
> > +If two MMAPLOCKs must be acquired, they are acquired in 
> 
> 
> > ``struct
> > +address_space`` order.
> the order of their memory address
> 
> ?

Urghg.  I think I need to clarify this more:

"...they are acquired in numerical order of the addresses of their
``struct address_space`` objects."

See filemap_invalidate_lock_two.

> > +Due to the structure of existing filesystem code, IOLOCKs and
> > MMAPLOCKs must be
> > +acquired before transactions are allocated.
> > +If two ILOCKs must be acquired, they are acquired in inumber order.
> > +
> > +Inode lock acquisition must be done carefully during a coordinated
> > inode scan.
> > +Online fsck cannot abide these conventions, because for a directory
> > tree
> > +scanner, the scrub process holds the IOLOCK of the file being
> > scanned and it
> > +needs to take the IOLOCK of the file at the other end of the
> > directory link.
> > +If the directory tree is corrupt because it contains a cycle,
> > ``xfs_scrub``
> > +cannot use the regular inode locking functions and avoid becoming
> > trapped in an
> > +ABBA deadlock.
> > +
> > +Solving both of these problems is straightforward -- any time online
> > fsck
> > +needs to take a second lock of the same class, it uses trylock to
> > avoid an ABBA
> > +deadlock.
> > +If the trylock fails, scrub drops all inode locks and use trylock
> > loops to
> > +(re)acquire all necessary resources.
> > +Trylock loops enable scrub to check for pending fatal signals, which
> > is how
> > +scrub avoids deadlocking the filesystem or becoming an unresponsive
> > process.
> > +However, trylock loops means that online fsck must be prepared to
> > measure the
> > +resource being scrubbed before and after the lock cycle to detect
> > changes and
> > +react accordingly.
> > +
> > +.. _dirparent:
> > +
> > +Case Study: Finding a Directory Parent
> > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > +
> > +Consider the directory parent pointer repair code as an example.
> > +Online fsck must verify that the dotdot dirent of a directory points
> > up to a
> > +parent directory, and that the parent directory contains exactly one
> > dirent
> > +pointing down to the child directory.
> > +Fully validating this relationship (and repairing it if possible)
> > requires a
> > +walk of every directory on the filesystem while holding the child
> > locked, and
> > +while updates to the directory tree are being made.
> > +The coordinated inode scan provides a way to walk the filesystem
> > without the
> > +possibility of missing an inode.
> > +The child directory is kept locked to prevent updates to the dotdot
> > dirent, but
> > +if the scanner fails to lock a parent, it can drop and relock both
> > the child
> > +and the prospective parent.
> > +If the dotdot entry changes while the directory is unlocked, then a
> > move or
> > +rename operation must have changed the child's parentage, and the
> > scan can
> > +exit early.
> > +
> > +The proposed patchset is the
> > +`directory repair
> > +<
> > https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/
> > log/?h=repair-dirs>`_
> > +series.
> > +
> > +.. _fshooks:
> > +
> > +Filesystem Hooks
> > +`````````````````
> > +
> > +The second piece of support that online fsck functions need during a
> > full
> > +filesystem scan is the ability to stay informed about updates being
> > made by
> > +other threads in the filesystem, since comparisons against the past
> > are useless
> > +in a dynamic environment.
> > +Two pieces of Linux kernel infrastructure enable online fsck to
> > monitor regular
> > +filesystem operations: filesystem hooks and :ref:`static
> > keys<jump_labels>`.
> > +
> > +Filesystem hooks convey information about an ongoing filesystem
> > operation to
> > +a downstream consumer.
> > +In this case, the downstream consumer is always an online fsck
> > function.
> > +Because multiple fsck functions can run in parallel, online fsck
> > uses the Linux
> > +notifier call chain facility to dispatch updates to any number of
> > interested
> > +fsck processes.
> > +Call chains are a dynamic list, which means that they can be
> > configured at
> > +run time.
> > +Because these hooks are private to the XFS module, the information
> > passed along
> > +contains exactly what the checking function needs to update its
> > observations.
> > +
> > +The current implementation of XFS hooks uses SRCU notifier chains to
> > reduce the
> > +impact to highly threaded workloads.
> > +Regular blocking notifier chains use a rwsem and seem to have a much
> > lower
> > +overhead for single-threaded applications.
> > +However, it may turn out that the combination of blocking chains and
> > static
> > +keys are a more performant combination; more study is needed here.
> > +
> > +The following pieces are necessary to hook a certain point in the
> > filesystem:
> > +
> > +- A ``struct xfs_hooks`` object must be embedded in a convenient
> > place such as
> > +  a well-known incore filesystem object.
> > +
> > +- Each hook must define an action code and a structure containing
> > more context
> > +  about the action.
> > +
> > +- Hook providers should provide appropriate wrapper functions and
> > structs
> > +  around the ``xfs_hooks`` and ``xfs_hook`` objects to take
> > advantage of type
> > +  checking to ensure correct usage.
> > +
> > +- A callsite in the regular filesystem code must be chosen to call
> > +  ``xfs_hooks_call`` with the action code and data structure.
> > +  This place should be adjacent to (and not earlier than) the place
> > where
> > +  the filesystem update is committed to the transaction.
> > +  In general, when the filesystem calls a hook chain, it should be
> > able to
> > +  handle sleeping and should not be vulnerable to memory reclaim or
> > locking
> > +  recursion.
> > +  However, the exact requirements are very dependent on the context
> > of the hook
> > +  caller and the callee.
> > +
> > +- The online fsck function should define a structure to hold scan
> > data, a lock
> > +  to coordinate access to the scan data, and a ``struct xfs_hook``
> > object.
> > +  The scanner function and the regular filesystem code must acquire
> > resources
> > +  in the same order; see the next section for details.
> > +
> > +- The online fsck code must contain a C function to catch the hook
> > action code
> > +  and data structure.
> > +  If the object being updated has already been visited by the scan,
> > then the
> > +  hook information must be applied to the scan data.
> > +
> > +- Prior to unlocking inodes to start the scan, online fsck must call
> > +  ``xfs_hooks_setup`` to initialize the ``struct xfs_hook``, and
> > +  ``xfs_hooks_add`` to enable the hook.
> > +
> > +- Online fsck must call ``xfs_hooks_del`` to disable the hook once
> > the scan is
> > +  complete.
> > +
> > +The number of hooks should be kept to a minimum to reduce
> > complexity.
> > +Static keys are used to reduce the overhead of filesystem hooks to
> > nearly
> > +zero when online fsck is not running.
> > +
> > +.. _liveupdate:
> > +
> > +Live Updates During a Scan
> > +``````````````````````````
> > +
> > +The code paths of the online fsck scanning code and the
> > :ref:`hooked<fshooks>`
> > +filesystem code look like this::
> > +
> > +            other program
> > +                  ↓
> > +            inode lock ←────────────────────┐
> > +                  ↓                         │
> > +            AG header lock                  │
> > +                  ↓                         │
> > +            filesystem function             │
> > +                  ↓                         │
> > +            notifier call chain             │    same
> > +                  ↓                         ├─── inode
> > +            scrub hook function             │    lock
> > +                  ↓                         │
> > +            scan data mutex ←──┐    same    │
> > +                  ↓            ├─── scan    │
> > +            update scan data   │    lock    │
> > +                  ↑            │            │
> > +            scan data mutex ←──┘            │
> > +                  ↑                         │
> > +            inode lock ←────────────────────┘
> > +                  ↑
> > +            scrub function
> > +                  ↑
> > +            inode scanner
> > +                  ↑
> > +            xfs_scrub
> > +
> > +These rules must be followed to ensure correct interactions between
> > the
> > +checking code and the code making an update to the filesystem:
> > +
> > +- Prior to invoking the notifier call chain, the filesystem function
> > being
> > +  hooked must acquire the same lock that the scrub scanning function
> > acquires
> > +  to scan the inode.
> > +
> > +- The scanning function and the scrub hook function must coordinate
> > access to
> > +  the scan data by acquiring a lock on the scan data.
> > +
> > +- Scrub hook function must not add the live update information to
> > the scan
> > +  observations unless the inode being updated has already been
> > scanned.
> > +  The scan coordinator has a helper predicate
> > (``xchk_iscan_want_live_update``)
> > +  for this.
> > +
> > +- Scrub hook functions must not change the caller's state, including
> > the
> > +  transaction that it is running.
> > +  They must not acquire any resources that might conflict with the
> > filesystem
> > +  function being hooked.
> > +
> > +- The hook function can abort the inode scan to avoid breaking the
> > other rules.
> > +
> > +The inode scan APIs are pretty simple:
> > +
> > +- ``xchk_iscan_start`` starts a scan
> > +
> > +- ``xchk_iscan_iter`` grabs a reference to the next inode in the
> > scan or
> > +  returns zero if there is nothing left to scan
> > +
> > +- ``xchk_iscan_want_live_update`` to decide if an inode has already
> > been
> > +  visited in the scan.
> > +  This is critical for hook functions to decide if they need to
> > update the
> > +  in-memory scan information.
> > +
> > +- ``xchk_iscan_mark_visited`` to mark an inode as having been
> > visited in the
> > +  scan
> > +
> > +- ``xchk_iscan_finish`` to finish the scan
> > +
> > +The proposed patches are at the start of the
> > +`online quotacheck
> > +<
> > https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/
> > log/?h=repair-quota>`_
> > +series.
> Wrong link?  This looks like it goes to the section below.

Oops.  This one should link to scrub-iscan, and the next one should link
to repair-quotacheck.

> > +
> > +.. _quotacheck:
> > +
> > +Case Study: Quota Counter Checking
> > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > +
> > +It is useful to compare the mount time quotacheck code to the online
> > repair
> > +quotacheck code.
> > +Mount time quotacheck does not have to contend with concurrent
> > operations, so
> > +it does the following:
> > +
> > +1. Make sure the ondisk dquots are in good enough shape that all the
> > incore
> > +   dquots will actually load, and zero the resource usage counters
> > in the
> > +   ondisk buffer.
> > +
> > +2. Walk every inode in the filesystem.
> > +   Add each file's resource usage to the incore dquot.
> > +
> > +3. Walk each incore dquot.
> > +   If the incore dquot is not being flushed, add the ondisk buffer
> > backing the
> > +   incore dquot to a delayed write (delwri) list.
> > +
> > +4. Write the buffer list to disk.
> > +
> > +Like most online fsck functions, online quotacheck can't write to
> > regular
> > +filesystem objects until the newly collected metadata reflect all
> > filesystem
> > +state.
> > +Therefore, online quotacheck records file resource usage to a shadow
> > dquot
> > +index implemented with a sparse ``xfarray``, and only writes to the
> > real dquots
> > +once the scan is complete.
> > +Handling transactional updates is tricky because quota resource
> > usage updates
> > +are handled in phases to minimize contention on dquots:
> > +
> > +1. The inodes involved are joined and locked to a transaction.
> > +
> > +2. For each dquot attached to the file:
> > +
> > +   a. The dquot is locked.
> > +
> > +   b. A quota reservation is added to the dquot's resource usage.
> > +      The reservation is recorded in the transaction.
> > +
> > +   c. The dquot is unlocked.
> > +
> > +3. Changes in actual quota usage are tracked in the transaction.
> > +
> > +4. At transaction commit time, each dquot is examined again:
> > +
> > +   a. The dquot is locked again.
> > +
> > +   b. Quota usage changes are logged and unused reservation is given
> > back to
> > +      the dquot.
> > +
> > +   c. The dquot is unlocked.
> > +
> > +For online quotacheck, hooks are placed in steps 2 and 4.
> > +The step 2 hook creates a shadow version of the transaction dquot
> > context
> > +(``dqtrx``) that operates in a similar manner to the regular code.
> > +The step 4 hook commits the shadow ``dqtrx`` changes to the shadow
> > dquots.
> > +Notice that both hooks are called with the inode locked, which is
> > how the
> > +live update coordinates with the inode scanner.
> > +
> > +The quotacheck scan looks like this:
> > +
> > +1. Set up a coordinated inode scan.
> > +
> > +2. For each inode returned by the inode scan iterator:
> > +
> > +   a. Grab and lock the inode.
> > +
> > +   b. Determine that inode's resource usage (data blocks, inode
> > counts,
> > +      realtime blocks) 
> nit: move this list to the first appearance of "resource usage".  Step
> 2 of the first list I think

I don't understand this proposed change.  Are you talking about "2. For
each dquot attached to the file:" above?  That list describes the steps
taken by regular code wanting to allocate file space that's accounted to
quotas.  This list describes what online quotacheck does.  The two don't
mix.

> > and add that to the shadow dquots for the user, group,
> > +      and project ids associated with the inode.
> > +
> > +   c. Unlock and release the inode.
> > +
> > +3. For each dquot in the system:
> > +
> > +   a. Grab and lock the dquot.
> > +
> > +   b. Check the dquot against the shadow dquots created by the scan
> > and updated
> > +      by the live hooks.
> > +
> > +Live updates are key to being able to walk every quota record
> > without
> > +needing to hold any locks for a long duration.
> > +If repairs are desired, the real and shadow dquots are locked and
> > their
> > +resource counts are set to the values in the shadow dquot.
> > +
> > +The proposed patchset is the
> > +`online quotacheck
> > +<
> > https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/
> > log/?h=repair-quota>`_

Changed from repair-quota to repair-quotacheck.

> > +series.
> > +
> > +.. _nlinks:
> > +
> > +Case Study: File Link Count Checking
> > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > +
> > +File link count checking also uses live update hooks.
> > +The coordinated inode scanner is used to visit all directories on
> > the
> > +filesystem, and per-file link count records are stored in a sparse
> > ``xfarray``
> > +indexed by inumber.
> > +During the scanning phase, each entry in a directory generates
> > observation
> > +data as follows:
> > +
> > +1. If the entry is a dotdot (``'..'``) entry of the root directory,
> > the
> > +   directory's parent link count is bumped because the root
> > directory's dotdot
> > +   entry is self referential.
> > +
> > +2. If the entry is a dotdot entry of a subdirectory, the parent's
> > backref
> > +   count is bumped.
> > +
> > +3. If the entry is neither a dot nor a dotdot entry, the target
> > file's parent
> > +   count is bumped.
> > +
> > +4. If the target is a subdirectory, the parent's child link count is
> > bumped.
> > +
> > +A crucial point to understand about how the link count inode scanner
> > interacts
> > +with the live update hooks is that the scan cursor tracks which
> > *parent*
> > +directories have been scanned.
> > +In other words, the live updates ignore any update about ``A → B``
> > when A has
> > +not been scanned, even if B has been scanned.
> > +Furthermore, a subdirectory A with a dotdot entry pointing back to B
> > is
> > +accounted as a backref counter in the shadow data for A, since child
> > dotdot
> > +entries affect the parent's link count.
> > +Live update hooks are carefully placed in all parts of the
> > filesystem that
> > +create, change, or remove directory entries, since those operations
> > involve
> > +bumplink and droplink.
> > +
> > +For any file, the correct link count is the number of parents plus
> > the number
> > +of child subdirectories.
> > +Non-directories never have children of any kind.
> > +The backref information is used to detect inconsistencies in the
> > number of
> > +links pointing to child subdirectories and the number of dotdot
> > entries
> > +pointing back.
> > +
> > +After the scan completes, the link count of each file can be checked
> > by locking
> > +both the inode and the shadow data, and comparing the link counts.
> > +A second coordinated inode scan cursor is used for comparisons.
> > +Live updates are key to being able to walk every inode without
> > needing to hold
> > +any locks between inodes.
> > +If repairs are desired, the inode's link count is set to the value
> > in the
> > +shadow information.
> > +If no parents are found, the file must be :ref:`reparented
> > <orphanage>` to the
> > +orphanage to prevent the file from being lost forever.
> > +
> > +The proposed patchset is the
> > +`file link count repair
> > +<
> > https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/
> > log/?h=scrub-nlinks>`_
> > +series.
> > +
> > +.. _rmap_repair:
> > +
> > +Case Study: Rebuilding Reverse Mapping Records
> > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > +
> > +Most repair functions follow the same pattern: lock filesystem
> > resources,
> > +walk the surviving ondisk metadata looking for replacement metadata
> > records,
> > +and use an :ref:`in-memory array <xfarray>` to store the gathered
> > observations.
> > +The primary advantage of this approach is the simplicity and
> > modularity of the
> > +repair code -- code and data are entirely contained within the scrub
> > module,
> > +do not require hooks in the main filesystem, and are usually the
> > most efficient
> > +in memory use.
> > +A secondary advantage of this repair approach is atomicity -- once
> > the kernel
> > +decides a structure is corrupt, no other threads can access the
> > metadata until
> > +the kernel finishes repairing and revalidating the metadata.
> > +
> > +For repairs going on within a shard of the filesystem, these
> > advantages
> > +outweigh the delays inherent in locking the shard while repairing
> > parts of the
> > +shard.
> > +Unfortunately, repairs to the reverse mapping btree cannot use the
> > "standard"
> > +btree repair strategy because it must scan every space mapping of
> > every fork of
> > +every file in the filesystem, and the filesystem cannot stop.
> > +Therefore, rmap repair foregoes atomicity between scrub and repair.
> > +It combines a :ref:`coordinated inode scanner <iscan>`, :ref:`live
> > update hooks
> > +<liveupdate>`, and an :ref:`in-memory rmap btree <xfbtree>` to
> > complete the
> > +scan for reverse mapping records.
> > +
> > +1. Set up an xfbtree to stage rmap records.
> > +
> > +2. While holding the locks on the AGI and AGF buffers acquired
> > during the
> > +   scrub, generate reverse mappings for all AG metadata: inodes,
> > btrees, CoW
> > +   staging extents, and the internal log.
> > +
> > +3. Set up an inode scanner.
> > +
> > +4. Hook into rmap updates for the AG being repaired so that the live
> > scan data
> > +   can receive updates to the rmap btree from the rest of the
> > filesystem during
> > +   the file scan.
> > +
> > +5. For each space mapping found in either fork of each file scanned,
> > +   decide if the mapping matches the AG of interest.
> > +   If so:
> > +
> > +   a. Create a btree cursor for the in-memory btree.
> > +
> > +   b. Use the rmap code to add the record to the in-memory btree.
> > +
> > +   c. Use the :ref:`special commit function <xfbtree_commit>` to
> > write the
> > +      xfbtree changes to the xfile.
> > +
> > +6. For each live update received via the hook, decide if the owner
> > has already
> > +   been scanned.
> > +   If so, apply the live update into the scan data:
> > +
> > +   a. Create a btree cursor for the in-memory btree.
> > +
> > +   b. Replay the operation into the in-memory btree.
> > +
> > +   c. Use the :ref:`special commit function <xfbtree_commit>` to
> > write the
> > +      xfbtree changes to the xfile.
> > +      This is performed with an empty transaction to avoid changing
> > the
> > +      caller's state.
> > +
> > +7. When the inode scan finishes, create a new scrub transaction and
> > relock the
> > +   two AG headers.
> > +
> > +8. Compute the new btree geometry using the number of rmap records
> > in the
> > +   shadow btree, like all other btree rebuilding functions.
> > +
> > +9. Allocate the number of blocks computed in the previous step.
> > +
> > +10. Perform the usual btree bulk loading and commit to install the
> > new rmap
> > +    btree.
> > +
> > +11. Reap the old rmap btree blocks as discussed in the case study
> > about how
> > +    to :ref:`reap after rmap btree repair <rmap_reap>`.
> > +
> > +12. Free the xfbtree now that it not needed.
> > +
> > +The proposed patchset is the
> > +`rmap repair
> > +<
> > https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/
> > log/?h=repair-rmap-btree>`_
> > +series.
> > 
> 
> Mostly looks good nits aside, I do sort of wonder if this patch would
> do better to appear before patch 6 (or move 6 down), since it gets into
> more challenges concerning locks and hooks, where as here we are mostly
> discussing what they are and how they work.  So it might build better
> to move this patch up a little.

(I might be a tad confused here, bear with me.)

Patch 6, the section about eventual consistency?

Hmm.  The intent drains exist to quiesce intent chains targeting
specific AGs.  It briefly mentions "fshooks" in the context of using
jump labels to avoid the overhead of calling notify_all on the drain
waitqueue when scrub isn't running.  That's perhaps bad naming on my
part, since the other "fshooks" are jump labels to avoid bouncing
through the notifier chain code when scrub isn't running.  The jump
labels themselves are not hooks, they're structured dynamic code
patching.

I probably should've named those something else.  fsgates?

Or maybe you were talking specifically about "Case Study: Rebuilding
Reverse Mapping Records"?  In which case I remark that the case study
needs both the intent drains to quiesce the AG and the live scans to
work properly, which is why the case study of it couldn't come earlier.
The intent drains section still ought to come before the refcountbt
section, because it's the refcountbt scrubber that first hit the
coordination problem.

Things are getting pretty awkward like this because there are sooo many
interdependent pieces. :(

Regardless, thank you very much for slogging through.

--D

> Allison
> 
