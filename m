Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B8253F389
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jun 2022 03:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235682AbiFGBtl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jun 2022 21:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235459AbiFGBtY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jun 2022 21:49:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1DA6898C;
        Mon,  6 Jun 2022 18:49:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 75AF4B81C51;
        Tue,  7 Jun 2022 01:49:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B62CC385A9;
        Tue,  7 Jun 2022 01:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654566558;
        bh=ND/5FwDc8dQgu9hVMlZeZlyVpyCE1zAvuf8N0Wh+LXI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=UiUImD1qTniBc6M2MkN+0QC1qAOjkJY0TC1MwBHHqFc2qSNUZZfi6z/G2PR9obff2
         SxY1nBOeKxYREg4RhtG7mW9Soq/BuLg4RLPzDcbCKsrh+V6dvA/B1XVO8+lyP/6Z39
         esUR8zaSCcsA/1sVh9KI7kyXKfjdlnxBYgNX3OBAKrhQ5H73lgZj6UZXXaM6ZuC3N7
         5k2n0PK+szJdoZp5CuYHO1k8LV2sMmBxpOaIGjCkjV0tbY/dPeLEUOur6MHmmArMD1
         YEAsgGjYMne9albFE7br0EKdc+Yh71CnHCdV49j624CyNh6Bxyg4GOKimpx/dQ2ggJ
         OECJNo+zIj+6Q==
Subject: [PATCH 6/8] xfs: document technical aspects of kernel space file
 repair code
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, willy@infradead.org,
        chandan.babu@oracle.com, allison.henderson@oracle.com,
        linux-fsdevel@vger.kernel.org, hch@infradead.org,
        catherine.hoang@oracle.com
Date:   Mon, 06 Jun 2022 18:49:17 -0700
Message-ID: <165456655761.167418.74621695851350771.stgit@magnolia>
In-Reply-To: <165456652256.167418.912764930038710353.stgit@magnolia>
References: <165456652256.167418.912764930038710353.stgit@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

Add to the fifth chapter of the online fsck design documentation, where
we discuss the details of the data structures and algorithms used by the
kernel to repair file metadata.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 .../filesystems/xfs-online-fsck-design.rst         | 1279 ++++++++++++++++++++
 1 file changed, 1279 insertions(+)


diff --git a/Documentation/filesystems/xfs-online-fsck-design.rst b/Documentation/filesystems/xfs-online-fsck-design.rst
index 18d63aa089cd..d9662c9653c9 100644
--- a/Documentation/filesystems/xfs-online-fsck-design.rst
+++ b/Documentation/filesystems/xfs-online-fsck-design.rst
@@ -2104,3 +2104,1282 @@ The allocation group free block list (AGFL) is repaired as follows:
    other owner, to avoid re-adding crosslinked blocks to the AGFL.
 4. Once the AGFL is full, reap any blocks leftover.
 5. The next operation to fix the freelist will right-size the list.
+
+Inode and Quota Record Repairs
+------------------------------
+
+Inode records (dinodes) and quota records (dquots) must be handled carefully,
+because they have both ondisk metadata and an in-memory ("cached")
+representation.
+There is a very high potential for cache coherency issues if we do not act
+carefully to access the ondisk metadata *only* when the ondisk metadata is so
+badly damaged that the kernel won't load the in-memory representation.
+When scrub does this, it must use specialized resource acquisition functions
+that return either the in-memory representation *or* a lock on whichever object
+is necessary to prevent any update to the ondisk location.
+Similarly, the only repairs we want to do to the ondisk metadata is whatever is
+necessary to get the in-core structure loaded.
+Once the in-memory representation is loaded, we lock it and can subject it to
+whatever comprehensive checks, repairs, and optimizations that we want.
+
+Proposed patchsets include the
+`inode
+<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=repair-inodes>`_ and
+`quota
+<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=repair-quota>`_
+repair series.
+
+.. _fscounters:
+
+Semi-Freezing to Fix Summary Counters
+-------------------------------------
+
+Filesystem summary counters track availability of filesystem resources such
+as free blocks, free inodes, and allocated inodes.
+This information could be compiled by walking the free space and inode indexes,
+but this is a slow process, so XFS maintains a copy in the ondisk superblock
+that (roughly) reflect the ondisk metadata.
+For performance reasons, XFS also maintains incore copies of those counters,
+which are key to enabling resource reservations for active transactions.
+Writer threads reserve the worst-case quantities of resources from the
+incore counter and give back whatever they don't use at commit time.
+It is therefore only necessary to serialize on the superblock when the
+superblock is being committed to disk.
+
+The lazy superblock counter feature introduced in XFS v5 took this even further
+by training log recovery to recompute the summary counters from the AG headers,
+which eliminated the need for most transactions even to touch the superblock.
+The only time XFS commits the summary counters is at filesystem unmount.
+To reduce contention even further, the incore counter is implemented as a
+percpu counter, which means that each CPU is allocated a batch of blocks from a
+global incore counter and can satisfy small allocations from the local batch.
+
+The high-performance nature of the summary counters makes it difficult for
+online fsck to check them, since there is no way to quiesce a percpu counter
+while the system is running.
+Although online fsck can read the filesystem metadata to compute the correct
+values of the summary counters, there's no good way to hold the value of a
+percpu counter stable, so it's quite possible that the counter will be out of
+date by the time the walk is complete.
+Earlier versions of online scrub would return to userspace with an incomplete
+scan flag, but this is not a satisfying outcome for a system administrator.
+For repairs, we must stabilize the counters while we walk the filesystem
+metadata to get an accurate reading and install it in the percpu counter.
+
+To satisfy this requirement, online fsck must prevent other programs in the
+system from initiating new writes to the filesystem, it must disable background
+garbage collection threads, and it must wait for existing writer programs to
+exit the kernel.
+Once that has been established, we can walk the AG free space indexes, the
+inode btrees, and the realtime bitmap to compute the correct value of all
+four summary counters.
+Astute readers may already be thinking that this sounds very similar to
+freezing the filesystem, and that is more or less the solution that will be
+presented here.
+
+The initial implementation used the actual VFS filesystem freeze mechanism to
+quiesce filesystem activity.
+With the filesystem frozen, it is possible to resolve the counter values with
+exact precision, but there are many problems with calling the VFS methods
+directly:
+
+- Other programs can unfreeze the filesystem without our knowledge.
+  This leads to incorrect scan results and incorrect repairs.
+
+- Adding an extra lock to prevent others from thawing the filesystem required
+  the addition of a ``->freeze_super`` function to wrap ``freeze_fs()``.
+  This in turn caused other subtle problems because it turns out that the VFS
+  ``freeze_super`` and ``thaw_super`` functions can drop the last reference to
+  the VFS superblock, and any subsequent access becomes a UAF bug!
+  This can happen if the filesystem is unmounted while the underlying block
+  device has frozen the filesystem.
+  This problem could be solved by grabbing extra references to the superblock,
+  but it felt suboptimal given the other inadequacies of this approach:
+
+- We don't need to quiesce the log to check the summary counters, but a VFS
+  freeze initiates one anyway.
+  This adds unnecessary runtime to live fscounter fsck operations.
+
+- Quiescing the log means that we flush the (possibly incorrect) counters to
+  disk in the form of log cleaning transactions, only to correct them.
+
+- A bug in the VFS meant that freeze could complete even when sync_filesystem
+  fails to flush the filesystem and returns an error.
+  This bug was fixed in Linux 5.17.
+
+The author established that the only component of online fsck that requires the
+ability to freeze the filesystem is the fscounter scrubber, so the code for
+this could be localized to that source file.
+fscounter freeze behaves the same as the VFS freeze method, except:
+
+- The final freeze state is set one higher than ``SB_FREEZE_COMPLETE`` to
+  prevent other threads from thawing the filesystem.
+
+- Fsck aborts if the filesystem flush produces errors.
+  Granted, this was fixed in the VFS in early 2022.
+
+- We don't quiesce the log.
+
+With this code in place, it is now possible to pause the filesystem for just
+long enough to check and correct the summary counters.
+
+The proposed patchset is the
+`summary counter cleanup
+<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=repair-fscounters>`_
+series.
+
+Full Filesystem Scans
+---------------------
+
+Certain types of metadata can only be checked by walking every file in the
+entire filesystem to record observations and comparing the observations against
+what's recorded on disk.
+Repairs will be made by writing those observations to disk in a replacement
+structure.
+However, it is not practical to shut down the entire filesystem to examine
+hundreds of millions of files because the downtime would be excessive.
+Therefore, online fsck must build the infrastructure to manage a live scan of
+all the files in the filesystem.
+There are two questions that need to be solved to perform a live walk:
+
+- How do we manage the scan cursor while we're collecting data?
+
+- How does the scan keep abreast of changes being made to the system by other
+  threads?
+
+.. _iscan:
+
+Coordinated Inode Scans
+```````````````````````
+
+Inode numbers are search keys that filesystems use to identify files uniquely.
+XFS inode numbers form a continuous keyspace that can be expressed as a 64-bit
+integer.
+Note that the inode records themselves are sparsely distributed within the
+keyspace.
+Scans therefore proceed in a linear fashion across the keyspace, starting from
+0 and ending at 0xFFFFFFFFFFFFFFFF.
+Naturally, we need a scan coordinator that can track the inode that we want to
+scan; call this the examination cursor.
+Somewhat less obviously, the scan coordinator must also track which parts of
+the keyspace we've already scanned, which is key to deciding if a concurrent
+filesystem update needs to be incorporated into the scan data.
+Call this the scanned inode cursor.
+
+Advancing the scan is a multi-step process:
+
+1. Lock the AGI buffer of the AG containing the inode pointed to by the scanned
+   inode cursor.
+   This guarantee that inodes in this AG cannot be allocated or freed while we
+   are moving the cursor.
+
+2. Use the per-AG inode btree to look up the next inode after the one that we
+   have just scanned, since it may not be keyspace adjacent to the one just
+   examined.
+
+3. If there are no more inodes left in this AG:
+
+   a. Move the examination cursor to the start of the next AG.
+
+   b. Adjust the scanned inode cursor to indicate that we have "scanned" the
+      last possible inode in this AG's inode keyspace.
+      Recall that XFS inode numbers are segmented, so we need to mark as
+      scanned the entire keyspace up to just before the start of the next AG's
+      inode keyspace.
+
+   c. Unlock the AGI and return to step 1 if there are unexamined AGs in the
+      filesystem.
+
+4. Otherwise, there is at least one more inode to scan in this AG:
+
+   a. Move the examination cursor ahead to the next inode marked as allocated
+      by the inode btree.
+
+   b. Adjust the scanned inode cursor to point to the inode just prior to where
+      the examination cursor is now.
+      We know there were no inodes in the part of the inode keyspace that we
+      just covered.
+
+5. Load the incore inode for the selected ondisk inode.
+   By maintaining the AGI lock until this point, we know that it was safe to
+   advance the cursor across the entire keyspace, and that we have stabilized
+   the next inode so that it cannot disappear from memory during the scan.
+
+6. Drop the AGI lock and return the incore inode to the caller.
+
+The caller then examines the inode:
+
+1. Lock the incore inode to prevent updates during the scan.
+
+2. Scan the inode.
+
+3. While still holding the inode lock, adjust the scanned inode cursor to point
+   to this inode.
+
+4. Unlock the incore inode.
+
+5. Advance the scan.
+
+There are subtleties with the inode cache that complicate grabbing the incore
+inode for the caller.
+Obviously, it is an absolute requirement that the inode metadata be consistent
+enough to load it into the inode cache.
+Second, if the incore inode is stuck in some intermediate state, the scan
+coordinator must release the AGI and push the main filesystem to get the inode
+back into a loadable state.
+
+The proposed patches are in the
+`online quotacheck
+<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=repair-quota>`_
+series.
+
+Inode Management
+````````````````
+
+Normally, XFS incore inodes are always grabbed (``xfs_iget``) and released
+(``xfs_irele``) outside of transaction context, because transactions are not
+a VFS-level concept.
+The one exception to the first rule is during inode creation because we must
+ensure the atomicity of the ondisk inode index and the initialization of the
+actual ondisk inode.
+``irele`` is never run in transaction context because there are a handful of
+activities that might require ondisk updates:
+
+- The VFS may decide to kick off writeback as part of a ``DONTCACHE`` inode
+  release
+- Speculative preallocations need to be unreserved
+- An unlinked file may have lost its last reference, in which case the entire
+  file must be inactivated, which involves releasing all of its resources in
+  the ondisk metadata
+
+During normal operation, resource acquisition for an update follows this order
+to avoid deadlocks:
+
+1. Inode reference (``iget``).
+2. Filesystem freeze protection, if repairing (``mnt_want_write_file``).
+3. Inode ``IOLOCK`` (VFS ``i_rwsem``) lock to control file IO.
+4. Inode ``MMAPLOCK`` (page cache ``invalidate_lock``) lock for operations that
+   can update page cache mappings.
+5. Transaction log space grant.
+6. Space on the data and realtime devices for the transaction.
+7. Incore dquot references, if a file is being repaired.  Note that they are
+   not locked, merely acquired.
+8. Inode ``ILOCK`` for file metadata updates.
+9. AG header buffer locks / Realtime metadata inode ILOCK.
+10. Realtime metadata buffer locks, if applicable.
+
+Resources are usually released in the reverse order.
+However, online fsck is a very different animal from most regular XFS
+operations, because we may be examining an object that normally is acquired
+late in the above order, and we may need to cross-reference it with something
+that is acquired earlier in the order.
+The next few sections detail the specific ways in which online fsck must be
+*very* careful to avoid deadlocks.
+
+iget and irele
+^^^^^^^^^^^^^^
+
+An inode scan performed on behalf of a scrub operation runs in transaction
+context, and possibly with resources already locked and bound to it.
+This isn't much of a problem for ``iget`` since it can operate in the context
+of an existing transaction.
+
+When the VFS ``iput`` function is given a linked inode with no other
+references, it normally puts the inode on an LRU list in the hope that it can
+save time if another process re-opens the file before the system runs out
+of memory and frees it.
+Filesystem callers can short-circuit the LRU process by setting a ``DONTCACHE``
+flag on the inode to cause the kernel to try to drop the inode into the
+inactivation machinery immediately.
+If the inode is instead unlinked (or unconnected after a file handle
+operation), it will always drop the inode into the inactivation machinery
+immediately.
+Inactivation has two parts -- the VFS part, where it initiates writeback on
+all dirty file pages, and the XFS part, where we need to clean up XFS-private
+information (speculative preallocations for appends and copy on write) and
+free the inode if it was unlinked.
+
+In the past, inactivation was always done from the process that dropped the
+inode, which was a problem for scrub because scrub may already hold a
+transaction, and XFS does not support nesting transactions.
+On the other hand, if scrub already dropped the transaction because it is
+exiting to userspace, it is desirable to drop otherwise unused inodes
+immediately to avoid polluting caches.
+To capture these nuances, the online fsck code has a separate ``xchk_irele``
+function to set or clear the ``DONTCACHE`` flag to get the required release
+behavior.
+
+Proposed patchsets include fixing
+`scrub iget usage
+<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=scrub-iget-fixes>`_ and
+`dir iget usage
+<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=scrub-dir-iget-fixes>`_.
+
+Locking
+^^^^^^^
+
+Inode lock acquisition must also be done carefully during a coordinated inode
+scan.
+Normally, the VFS and XFS will acquire multiple IOLOCK locks in a well-known
+order: parent -> child when updating the directory tree and inode number order
+otherwise.
+Due to the structure of existing filesystem code, IOLOCKs must be acquired
+before transactions are allocated.
+Online fsck upends both of these conventions, because for a directory tree
+scanner, the scrub process holds the ILOCK of the file being scanned and it
+needs to take the IOLOCK of the file at the other end of the directory link.
+In the case of a corrupt directory tree containing a cycle, we cannot guarantee
+that another thread won't trap us in an ABBA deadlock.
+
+Solving both of these problems is straightforward -- any time online fsck
+deviates from the accepted acquisition order, it uses trylock loops for
+resource acquisition to avoid ABBA deadlocks.
+If the first trylock fails, scrub must drop all inode locks and use trylock
+loops to (re)acquire all necessary resources.
+Trylock loops enable scrub to check for pending fatal signals, which is how
+scrub avoids deadlocking the filesystem or becoming an unresponsive process.
+However, trylock loops means that online fsck must be prepared to measure the
+resource being scrubbed before and after the lock cycle to detect changes and
+react accordingly.
+
+.. _dirparent:
+
+Case Study: Finding a Directory Parent
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Consider the directory parent pointer repair code as an example.
+Online fsck must verify that the dotdot entry of a directory points to exactly
+one parent directory that contains exactly one entry pointing to the child
+directory.
+Validating this relationship (and repairing it if possible) requires a walk of
+every directory on the filesystem while directory tree updates are being
+written.
+The inode scan coordinator provides a way to walk the filesystem without the
+possibility of missing an inode.
+The parent pointer scanner uses a neat trick to avoid the need for live update
+hooks: moving or renaming a directory resets the dotdot entry.
+The child directory is kept locked to prevent updates, but if the scanner
+fails to lock a parent, it can drop and relock both inodes.
+Concurrent updates are detected by watching for a change in the dotdot entry;
+if one is detected, the scan can exit early.
+
+The proposed patchset is the
+`directory repair
+<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=repair-dirs>`_
+series.
+
+.. _liveupdate:
+
+Live Update Hooks
+`````````````````
+
+The second piece of support that checking functions need during a full
+filesystem scan is the ability to stay informed about updates being made by
+other threads in the filesystem, since comparisons against the past are useless
+in a dynamic environment.
+Two pieces of Linux kernel infrastructure enable online fsck to monitor regular
+filesystem operations: notifier call chains and jump labels.
+
+Notifier call chains are used to convey information about a filesystem update
+to a running online fsck function.
+In other words, they're a filesystem hook.
+Call chains are a dynamic list, which means that they can be configured at
+run time.
+In theory there can be multiple checking functions subscribed to a chain
+at any given time, though in practice this is rare.
+Because these hooks are private to the XFS module, the struct passed along
+contains exactly what the checking function needs to update its observations.
+
+Jump labels replace calls to the notifier call chain code with NOP sleds when
+online fsck is not running, thereby minimizing runtime overhead.
+Although jump labels are not supported on all architectures that Linux service,
+they exist on the primary targets for XFS filesystems.
+Lack of jump labels on a platform results in higher but still minimal overhead.
+
+The code paths of the online fsck scanning code and the hooked filesystem code
+look like this::
+
+            other program
+                  ↓
+            inode lock ←────────────────────┐
+                  ↓                         │
+            AG header lock                  │
+                  ↓                         │
+            filesystem function             │
+                  ↓                         │
+            notifier call chain             │    same
+                  ↓                         ├─── inode
+            scrub hook function             │    lock
+                  ↓                         │
+            scan data mutex ←──┐    same    │
+                  ↓            ├─── scan    │
+            update scan data   │    lock    │
+                  ↑            │            │
+            scan data mutex ←──┘            │
+                  ↑                         │
+            inode lock ←────────────────────┘
+                  ↑
+            scrub function
+                  ↑
+            inode scanner
+                  ↑
+            xfs_scrub
+
+These rules must be followed to ensure correct interactions between the
+checking code and the code making an update to the filesystem:
+
+- Prior to invoking the notifier call chain, the filesystem function being
+  hooked must acquire the same lock that the scrub scanning function acquires
+  to scan the inode.
+
+- The scanning function and the scrub hook function must coordinate access to
+  the scan data by acquiring a lock on the scan data.
+
+- The scrub hook function must not allocate a new transaction or acquire any
+  locks that might conflict with the filesystem function being hooked.
+
+- If the hook function adds items to the transaction context of the filesystem
+  function being hooked, it must detach those items before exiting.
+  In other words, the caller's state must be preserved exactly.
+
+- The hook function must not add the live update information to the scan
+  observations unless the inode being updated has already been scanned.
+  The scan coordinator has a helper predicate for this.
+
+- The hook function can abort the inode scan to avoid breaking the other rules.
+
+Notifier call chain functions allow passing of an ``unsigned long`` and a
+pointer to a structure.
+This is sufficient for current users to pass an operation code and some other
+details.
+
+The proposed patches are at the start of the
+`online quotacheck
+<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=repair-quota>`_
+series.
+
+.. _quotacheck:
+
+Case Study: Live Quota Counter Checking
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+As a concrete example, let us compare the mount time quotacheck code to the
+online repair quotacheck code.
+Mount time quotacheck does not have to contend with concurrent operations, so
+it does the following:
+
+1. Make sure the ondisk dquots are in good enough shape that all the incore
+   dquots will actually load, and zero the resource usage counters in the
+   ondisk buffer.
+
+2. Walk every inode in the filesystem.
+   Add each file's resource usage to the incore dquot.
+
+3. Walk each incore dquot.
+   If the incore dquot is not being flushed, add the ondisk buffer backing the
+   incore dquot to a delayed write (delwri) list.
+
+4. Write the buffer list to disk.
+
+Obviously, online quotacheck (and repair) cannot do this.
+The strategy for handling both is to create a shadow dquot index using a sparse
+``xfarray`` and walk the filesystem to account file resource usage to each
+shadow dquot.
+However, scrub cannot stop the filesystem while it does this, so it must use
+live updates.
+Handling the live updates, however, is tricky because transactional dquot
+resource usage updates are handled in phases:
+
+1. The inodes involved are joined and locked to a transaction.
+
+2. For each dquot attached to the file:
+
+   a. The dquot is locked.
+
+   b. A quota reservation associated with the dquot is made and added to the
+      transaction.
+
+   c. The dquot is unlocked.
+
+3. Changes in dquot resource usage are tracked by the transaction.
+
+4. At transaction commit time, each dquot is examined again:
+
+   a. The dquot is locked again.
+
+   b. Quota usage changes are logged and unused reservation is given back to
+      the dquot.
+
+   c. The dquot is unlocked.
+
+For live quotacheck, hooks are placed in steps 2 and 4.
+The step 2 hook creates a shadow version of the transaction dquot context
+(``dqtrx``) that operates in a similar manner to the regular code.
+The step 4 hook commits the shadow quota changes to the shadow dquots.
+Notice that both hooks are called with the inode locked, which is how the
+live update coordinates with the inode scanner.
+
+Checking the counters in the dquot records is a simple matter of locking both
+the real and the shadow dquots and comparing the resource counts.
+Live updates are key to being able to walk every quota records without
+needing to hold any locks between quota records.
+If repairs are desired, the real and shadow dquots are locked and their
+resource counts are set to the values in the shadow dquot.
+
+The proposed patchset is the
+`online quotacheck
+<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=repair-quota>`_
+series.
+
+.. _nlinks:
+
+Case Study: File Link Count Checking
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+File link count checking is a second usage of live update hooks.
+The coordinated inode scanner is used to visit all directories on the
+filesystem, and per-file link count records are stored in a sparse ``xfarray``
+indexed by inode number.
+During the scanning phase, each entry in a directory generates observation
+data as follows:
+
+1. If the entry is a dotdot (``'..'``) entry of the root directory, the
+   directory's parent link count is bumped because the root directory's dotdot
+   entry is self referential.
+
+2. If the entry is a dotdot entry of a subdirectory, the parent's backref
+   count is bumped.
+
+3. If the entry is neither a dot nor a dotdot entry, the target file's parent
+   count is bumped.
+
+4. If the target is a subdirectory, the parent's child link count is bumped.
+
+A crucial point to understand about how the inode scanner interacts with
+the live update hooks is that the scan cursor tracks which *parent directories*
+have been scanned.
+In other words, the live updates ignore any update about ``A -> B`` when A has
+not been scanned, even if B has been scanned.
+Furthermore, a subdirectory A with a dotdot entry pointing back to B is
+accounted as a backref counter in the shadow data for A, since child dotdot
+entries affect the parent's link count.
+Live update hooks are carefully placed in all parts of the filesystem that
+create, change, or remove directory entries, since those operations involve
+bumplink and droplink.
+
+For any file, the correct link count is the number of parents plus the number
+of child subdirectories.
+The backref information is used to detect inconsistencies in the number of
+links pointing to child subdirectories and the number of dotdot entries
+pointing back.
+
+Checking the link counts of a file is a simple matter of locking the inode and
+the shadow link count table and comparing the link counts.
+Live updates are key to being able to walk every inode without needing to hold
+any locks between inodes.
+If repairs are desired, the inode's link count is set to the value in the
+shadow information.
+If no parents are found, the file must be :ref:`reparented <orphanage>` to the
+orphanage to prevent the file from being lost forever.
+
+The proposed patchset is the
+`file link count repair
+<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=scrub-nlinks>`_
+series.
+
+.. _xfbtree:
+
+In-Memory Staging B+Trees
+-------------------------
+
+Most repair functions lock resources and use an
+:ref:`in-memory array <xfarray>` to store gathered observations for the new
+data structure.
+The primary advantage of this approach is the simplicity of the repair code --
+it is entirely contained within the scrub module, requires no hooks in the main
+filesystem, is usually the most efficient in its memory use, and guarantees
+that once we've decided a structure is corrupt, no other threads can access
+the metadata until we've finished repairing and revalidating the metadata.
+Unfortunately, linear arrays have a major disadvantage: because they do not
+enforce ordering of their records, they are not suitable for use with live
+updates, which require indexed lookups for performance reasons.
+
+The reverse mapping btree cannot use the "standard" btree repair strategy
+because it must scan every file in the filesystem without incurring extended
+downtime.
+Live file scans imply live updates to staged data, which means that rmap
+rebuilding requires the ability to perform indexed lookups into the staging
+structure.
+Conveniently, we already have code to create and maintain ordered reverse
+mapping information: the existing rmap btree code!
+
+Observe that the :ref:`xfile <xfile>` abstraction represents memory pages as a
+file, which means that virtual kernel memory are now linearly byte-addressable.
+This in turn means that we can adapt the XFS buffer cache to direct its
+attentions to an xfile instead of a block device.
+Since the existing XFS reverse mapping code talks to the buffer cache, online
+repair can construct an in-memory rmap btree and live updates can update it
+as neede until fsck is ready to write the new reverse mapping index to disk.
+The next few sections describe how ``xfbtree`` actually works.
+
+The proposed patchset is the
+`in-memory btree
+<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=in-memory-btrees>`_
+series.
+
+Using xfiles as a Buffer Cache Target
+`````````````````````````````````````
+
+Two modifications are necessary to support xfiles as a buffer cache target.
+The first is to make it possible for the ``struct xfs_buftarg`` structure to
+host the ``struct xfs_buf`` rhashtable, because normally those are held by a
+per-AG structure.
+The second change is to add an ``ioapply`` function that can "read" cached
+pages from the xfile and "write" cached pages back to the xfile.
+Other than that, users of the xfile-backed buffer cache can use exactly the
+same APIs as users of the disk-backed buffer cache.
+This imposes the overhead of using more memory pages than is absolutely
+necessary because the xfile and the buffer cache do not share memory pages.
+However, this is more than made up for by reducing the need for new code.
+
+Space Management with an xfile Btree
+````````````````````````````````````
+
+Space management for an xfile is very simple -- btree blocks must be one memory
+page in size.
+When we free a btree block, we use ``FALLOC_FL_PUNCH_HOLE`` to remove the
+memory page from the xfile.
+When we need to allocate a btree block, we use ``SEEK_HOLE`` to find a gap in
+the file, fallocate it, and hand it back.
+If no holes are found, we extend the length of the xfile by one page, fallocate
+it, and hand it back.
+
+In-memory btree blocks have the same header as a regular btree, which is
+perhaps overkill for an ephemeral structure since we don't care about CRCs
+or filesystem UUIDs.
+That is a small price to pay to reuse existing code.
+
+.. _xfbtree_commit:
+
+Committing Logged xfile Buffers
+```````````````````````````````
+
+Although it is a clever hack to reuse the rmap btree code to handle the staging
+structure, there is another downside -- because the in-memory btree is by
+definition ephemeral, we must not allow the XFS transaction manager to commit
+logged buffer items for buffers backed by an xfile.
+Doing so could result in transaction overruns and ephemeral data incorrectly
+being written to the ondisk log, and a lot of confusion for the AIL and log
+recovery.
+
+In other words, users of in-memory btrees must perform the following prior
+to committing a transaction:
+
+1. Find each buffer log item whose buffer targets the xfile.
+2. Record the dirty/ordered status of the log item.
+3. Detach the log item from the buffer.
+4. Queue the buffer to a special delwri list.
+5. Clear the transaction dirty flag if the only dirty log items were the ones
+   we detached.
+6. Submit the delwri list to commit the changes to the xfile.
+
+Log intent items are not currently needed for in-memory btree updates.
+After removing xfile logged buffers from the transaction, the transaction can
+be committed.
+
+.. _rmap_repair:
+
+Case Study: Gathering Reverse Mapping Records
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Collecting reverse mapping records requires the use of the
+:ref:`inode scanner <iscan>`, the :ref:`live update hooks <liveupdate>`, and
+an :ref:`in-memory rmap btree <xfbtree>`.
+
+1. While we still hold the AGI and AGF buffers locked from when we ran the
+   scrub, generate reverse mappings for all AG metadata: inodes, btrees, and
+   the log.
+
+2. Set up an inode scanner.
+
+3. Hook into rmap updates for the AG that we're interested in, so that we can
+   receive live updates to the rmap btree while we're scanning the filesystem.
+
+4. For each space mapping found in either forks of each file scanned,
+   decide if the mapping matches the AG we're interested in.
+   If so:
+
+   a. Create a btree cursor for the in-memory btree.
+   b. Use the rmap code to add the record to the in-memory btree.
+   c. Use the :ref:`special commit function <xfbtree_commit>` to write the
+      xfile.
+
+5. For each live update received via the hook, decide if we've already scanned
+   the owner in question.
+   If so, we need to absorb the live update:
+
+   a. Create a btree cursor for the in-memory btree.
+   b. Replay the operation into the in-memory btree.
+   c. Use the :ref:`special commit function <xfbtree_commit>` to write the
+      xfile without altering the hooked transaction.
+
+6. Once we've finished the inode scan, create a new scrub transaction and
+   relock the two AG headers.
+
+7. Perform the usual btree bulk loading and commit to install the new rmap
+   btree.
+
+8. Reap the old rmap btree blocks as discussed in the case study about how
+   to :ref:`reap after rmap btree repair <rmap_reap>`.
+
+The proposed patchset is the
+`rmap repair
+<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=repair-rmap-btree>`_
+series.
+
+Temporary XFS Files
+-------------------
+
+XFS stores a substantial amount of metadata in file forks: directories,
+extended attributes, free space bitmaps and summary information for the
+realtime volume, and quota records.
+File forks map 64-bit logical file fork space extents to physical storage space
+extents, similar to how a memory management unit maps 64-bit virtual addresses
+to physical memory addresses.
+Therefore, file-based tree structures (such as directories and extended
+attributes) use blocks mapped in the file fork offset address space that point
+to other blocks mapped within that same address space, and file-based linear
+structures (such as bitmaps and quota records) compute array element offsets in
+the file fork offset address space.
+
+In the initial iteration of the design of file metadata repair design, the
+damaged metadata blocks would be scanned for salvageable data; the extents in
+the file fork would be reaped; and then a new structure would be built in its
+place.
+This strategy did not survive the introduction of the atomic repair requirement
+expressed earlier in this document.
+The second iteration explored building a second structure at a high offset
+in the fork from the salvage data, reaping the old extents, and using a
+``COLLAPSE_RANGE`` operation to slide the new extents into place.
+This had many drawbacks:
+
+- Array structures are linearly addressed, and the regular filesystem codebase
+  does not have the concept of a linear offset that could be applied to the
+  record offset computation to build an alternate copy.
+
+- Extended attributes are allowed to use the entire file fork offset address
+  space.
+
+- Even if we could build an alternate copy of a data structure in a different
+  part of the fork address space, the atomic repair commit requirement means
+  that online repair would have to be able to perform a log assisted
+  ``COLLAPSE_RANGE`` operation to ensure that the old structure was completely
+  replaced.
+
+- A crash after construction of the secondary tree but before the range
+  collapse would leave unreachable blocks in the file fork.
+  This would likely confuse things further.
+
+- Reaping blocks after a repair is not a simple operation, and initiating a
+  reap operation from a restarted range collapse operation during log recovery
+  is daunting.
+
+- Directory entry blocks and quota records record the file fork offset in the
+  header area of each block.
+  An atomic range collapse operation would have to rewrite this part of each
+  block header.
+  Rewriting a single field in block headers is not a huge problem, but it's
+  something to be aware of.
+
+- Each block in a directory or extended attributes btree index contains sibling
+  and child block pointers.
+  Were the atomic commit to use a range collapse operation, each block would
+  have to be rewritten very carefully to preserve the graph structure.
+  Doing this means rewriting a large number of blocks repeatedly, which is not
+  conducive to quick repairs.
+
+The third iteration of the design for file metadata repair went for a totally
+new strategy -- create a temporary file in the XFS filesystem, write a new
+structure at the correct offsets into the temporary file, and atomically swap
+the fork mappings to commit the repair.
+Once the repair is complete, the old fork can be reaped as necessary; if the
+system goes down during the reap, the iunlink code will delete the blocks
+during recovery.
+
+Swapping extents with a temporary file still requires a rewrite of the owner
+field of the block headers, but this is *much* simpler than moving tree blocks
+individually.
+Furthermore, the buffer verifiers do not verify owner fields (since they are not
+aware of the inode that owns the block), which makes reaping of old file blocks
+much simpler.
+Extent swapping requires that AG space metadata and the file fork metadata of
+the file being repaired are all consistent with respect to each other, but
+that's already a requirement of the filesystem in general.
+There is, however, a slight downside -- if the system crashes during the reap
+phase and the fork extents are crosslinked, the iunlink processing will fail
+because freeing space will find the extra reverse mappings and abort.
+
+Temporary files created for repair are similar to ``O_TMPFILE`` files created
+by userspace.
+They are not linked into a directory and the entire file will be reaped when
+the last reference to the file is lost.
+The key differences are that these files must have no access permission outside
+the kernel at all, they must be specially marked to prevent them from being
+opened by handle, and they must never be linked into the directory tree.
+
+The proposed patches are in the
+`realtime summary repair
+<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=repair-rtsummary>`_
+series.
+
+Atomic Extent Swapping
+----------------------
+
+Once we have a temporary file with a new data structure freshly written into
+it, we must commit the new changes into the existing file in such a way that
+log recovery can finish the operation if the system goes down.
+To satisfy that requirement, we need to create a deferred operation and a new
+type of log intent item so that the log can track the progress of the extent
+swap operation.
+The existing fork swap code used by ``xfs_fsr`` is not sufficient here because
+it can only swap extents incrementally when the reverse mapping btree is
+enabled, and it is assumed that the file contents are byte-for-byte identical.
+This is never true when rebuilding an inconsistent data structure.
+However, the atomic extent swapping code is an evolution on the existing
+incremental swap method for filesystems with reverse mapping.
+
+The proposed patchset is the
+`atomic extent swap
+<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=atomic-file-updates>`_
+series.
+
+Mechanics of an Extent Swap
+```````````````````````````
+
+Swapping entire file forks is a complex task.
+We want to exchange all file fork mappings between two file fork offset ranges.
+There are likely to be many extent mappings in each fork, and the offsets of
+the mappings aren't necessarily aligned.
+Furthermore, there may be other updates that need to happen after the swap,
+such as exchanging file sizes or inode flags.
+This is roughly the format of the new deferred extent swap work item:
+
+.. code-block:: c
+
+	struct xfs_swapext_intent {
+	    /* Inodes participating in the operation. */
+	    struct xfs_inode    *sxi_ip1;
+	    struct xfs_inode    *sxi_ip2;
+
+	    /* File offset range information. */
+	    xfs_fileoff_t       sxi_startoff1;
+	    xfs_fileoff_t       sxi_startoff2;
+	    xfs_filblks_t       sxi_blockcount;
+
+	    /* Set these file sizes after the operation, unless negative. */
+	    xfs_fsize_t         sxi_isize1;
+	    xfs_fsize_t         sxi_isize2;
+
+	    /* XFS_SWAP_EXT_* log operation flags */
+	    uint64_t            sxi_flags;
+	};
+
+Observe that the new log intent item contains enough information to track two
+logical fork offset ranges: ``(inode1, startoff1, blockcount)`` and
+``(inode2, startoff2, blockcount)``.
+After each step in the swap operation, the two startoff fields are incremented
+and the blockcount field is decremented to reflect the progress made.
+The flags field captures behavioral parameters such as swapping the attr fork
+instead of the data fork and other work to be done after the extent swap.
+The two isize fields are used to swap the file size at the end of the operation,
+if the file data fork is the target of the swap operation.
+
+When the extent swap is initiated, the sequence of operations is as follows:
+
+1. Create a deferred work item for the extent swap.
+   At the start, it should contain the entirety of the file ranges to be
+   swapped.
+
+2. At some point, ``xfs_defer_finish`` is called to start processing of the
+   extent swap.
+   This will log an extent swap intent item to the transaction for the deferred
+   extent swap work item.
+
+3. Until ``sxi_blockcount`` of the deferred extent swap work item is zero,
+
+   a. Read the block maps of both file ranges starting at ``sxi_startoff1`` and
+      ``sxi_startoff2``, respectively, and compute the longest extent that we
+      can swap in a single step.
+      This is the minimum of the two ``br_blockcount`` s in the mappings.
+      Keep advancing through the file forks until at least one of the mappings
+      contains written blocks.
+
+      For the next few steps, we will refer to the mapping that came from
+      file 1 as "map1", and the mapping that came from file 2 as "map2".
+
+   b. Create a deferred block mapping update to unmap map1 from file 1.
+
+   c. Create a deferred block mapping update to unmap map2 from file 2.
+
+   d. Create a deferred block mapping update to map map1 into file 2.
+
+   e. Create a deferred block mapping update to map map2 into file 1.
+
+   f. Log the block, quota, and extent count updates for both files.
+
+   g. Extend the ondisk size of either file if necessary.
+
+   h. Log an extent swap done log item for the extent swap intent log item
+      that we read at the start of step 3.
+
+   i. Compute the amount of file range we just covered.
+      This quantity is ``(map1.br_startoff + map1.br_blockcount -
+      sxi_startoff1)``, because step 3a could have skipped holes.
+
+   j. Increase the starting offsets of ``sxi_startoff1`` and ``sxi_startoff2``
+      by the number of blocks we just computed, and decrease ``sxi_blockcount``
+      by the same quantity.
+      This moves the cursor forward.
+
+   k. Log an extent swap done log item for the extent swap intent log item
+      that we read at the start of step 3.
+   l. Log a new extent swap intent log item reflecting the work item state,
+      now that we have advanced it.
+
+   m. Return the proper error code (EAGAIN) to the deferred operation manager
+      to inform it that there is more work to be done.
+      The operation manager completes the deferred work in steps 3b-3e before
+      moving us back to the start of step 3.
+
+4. Perform any post-processing.
+   This will be discussed in more detail in subsequent sections.
+
+5. Reap all the extents in the temporary file's fork.
+
+If the filesystem goes down in the middle of an operation, log recovery will
+find the most recent unfinished extent swap log intent item and restart from
+there.
+This is how we guarantee that an outside observer will either see the old
+broken structure or the new one, and never a mismash of both.
+
+Extent Swapping with Regular User Files
+```````````````````````````````````````
+
+As mentioned earlier, XFS has long had the ability to swap extents between
+files, which is used almost exclusively by ``xfs_fsr`` to defragment files.
+The earliest form of this was the fork swap mechanism, where the entire
+contents of data forks could be exchanged between two files by exchanging the
+raw bytes in each inode's immediate area.
+When XFS v5 came along with self-describing metadata, this old mechanism grew
+some log support to continue rewriting the owner fields of BMBT blocks during
+log recovery.
+When the reverse mapping btree was later added to XFS, the only way to maintain
+the consistency of the fork mappings with the reverse mapping index was to
+develop an iterative mechanism that used deferred bmap and rmap operations to
+swap mappings one at a time.
+This mechanism is identical to steps 2-4 from the procedure above, because the
+atomic extent swap mechanism is an iteration of an existing mechanism and not
+something totally novel.
+For the narrow case of file defragmentation, we require the file contents to be
+identical, so the recovery guarantees are not much of a gain.
+
+In a broader context, however, atomic extent swapping is much more flexible
+than the existing swapext operation because it can guarantee that the caller
+never sees a mix of old and new contents even after a crash, and it can operate
+on two arbitrary file fork ranges.
+The extra flexibility enables several new use cases:
+
+- **Atomic commit of file writes**: A userspace process opens a file that it
+  wants to update.
+  Next, it opens a temporary file and calls the file clone operation to reflink
+  the first file's contents into the temporary file.
+  Writes to the original file should instead be written to the temporary file.
+  Finally, the process calls the atomic extent swap system call
+  (``FIEXCHANGE_RANGE``) to exchange the file contents, thereby committing all
+  of the updates to the original file, or none of them.
+
+- **Transactional file updates**: The same mechanism as above, but the caller
+  only wants the commit to occur if the original file's contents have not
+  changed.
+  To make this happen, the calling process snapshots the file modification and
+  change timestamps of the original file before reflinking its data to the
+  temporary file.
+  When the program is ready to commit the changes, it passes the timestamps
+  into the kernel as arguments to the atomic extent swap system call.
+  The kernel only commits the changes if the provided timestamps match the
+  original file.
+
+- **Emulation of atomic block device writes**: Export a block device with a
+  logical sector size matching the filesystem block size to force all writes
+  to be aligned to the filesystem block size.
+  A flag is passed into atomic extent swap system call to indicate that holes
+  in the temporary file should be ignored.
+  This emulates an atomic device write without the overhead of the initial file
+  clone operation.
+
+Preparation for Extent Swapping
+```````````````````````````````
+
+There are a few things that need to be taken care of before initiating an
+atomic extent swap operation.
+Atomic extent swapping for regular files requires the page cache to be flushed
+to disk before the operation begins.
+Like any filesystem operation, we must determine the maximum amount of disk
+space and quota that can be consumed on behalf of both files in the operation,
+and reserve that quantity of resources to avoid an unrecoverable out of space
+failure once we start dirtying metadata.
+Specifically, we need to scan the ranges of both files to estimate:
+
+- Data device blocks needed to handle the repeated updates to the fork
+  mappings.
+- Change in data and realtime block counts for both files.
+- Increase in quota usage for both files, if the two files do not share the
+  same set of quota ids.
+- The number of extent mappings that we're going to add to each file.
+- Whether or not there are partially written realtime extents.
+  If there's a chance that the operation could fail to run to completion,
+  we do not want to expose to userspace a realtime file extent that maps to
+  different extents on the realtime volume.
+
+The need for precise estimation increases the run time of the swap operation,
+but it is very important that we maintain correct accounting.
+We cannot ever run the filesystem completely out of free space, nor can we ever
+add more extent mappings to a fork than it can support.
+Regular users are required to abide the quota limits, though metadata repair
+will exceed quota to resolve inconsistencies.
+
+Special Features for Swapping Metadata File Extents
+```````````````````````````````````````````````````
+
+Extended attributes, symbolic links, and directories are allowed to set the
+fork format to "local" and treat the fork as a literal area for data storage.
+For a metadata repair, we must take some extra steps to support these cases:
+
+- If both forks are in local format and the fork areas are large enough, the
+  swap can be performed by copying the incore fork contents, logging both
+  forks, and committing.
+  The atomic extent swap mechanism is not necessary.
+
+- If both forks map blocks, then the regular atomic extent swap can be used.
+
+- Otherwise, the local format forks must be converted to blocks to perform
+  the swap.
+  The conversions to block format should be done in the same transaction that
+  logs the initial extent swap intent log item.
+  The regular atomic extent swap is used to exchange the mappings.
+  Special flags are set on the swap operation so that the transaction can be
+  rolled on emore time to convert the two forks back to local format if
+  possible.
+
+Extended attributes and directories stamp the owning inode into every block,
+but nowhere in the buffer verifiers do we actually check the inode number!
+Prior to performing the extent swap, we must walk every block in the new data
+structure to update the owner field and flush the buffer to disk.
+
+After a successful swap operation, the repair operation must reap the old fork
+blocks by processing each fork mapping through the standard
+:ref:`extent reaping <reaping>` mechanism that is done post-repair.
+If the filesystem should go down during the reap part of the repair, the
+iunlink processing at the end of recovery will free both the temporary file and
+whatever blocks were not reaped.
+
+Case Study: Repairing the Realtime Summary File
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+The realtime summary file has a relationship with the realtime free space
+bitmap that is similar to the one between the free space by count (cntbt) btree
+and the free space by block (bnobt) btree.
+In other words, the summary file provides a fast way to find free space extents
+by length.
+The summary file itself is a flat file (with no block headers or checksums!)
+partitioned into ``log2(total rt extents)`` sections containing enough 32-bit
+counters to match the number of blocks in the rt bitmap.
+Each counter records the number of free extents that start in that bitmap block
+and can satisfy a power-of-two allocation request.
+
+To check the summary file against the bitmap, we walk the free space extents
+recorded in the bitmap and construct a new summary file in an :ref:`xfile
+<xfile>`.
+When the incore summary is complete, we compare the contents of the two files
+to find any discrepancies.
+Repairing the summary file involves us writing the xfile contents into the
+temporary file and using atomic extent swap to commit the new contents.
+The temporary file is then reaped.
+
+The proposed patchset is the
+`realtime summary repair
+<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=repair-rtsummary>`_
+series.
+
+Case Study: Salvaging Extended Attributes
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+In XFS, extended attributes are implemented as a namespaced name-value store.
+Values are limited in size to 64KiB, but there is no limit in the number of
+names.
+The attribute fork is unpartitioned, which means that the root of the attribute
+structure is always in logical block zero, but attribute leaf blocks, dabtree
+index blocks, and remote value blocks are intermixed.
+Attribute leaf blocks contain variable-sized records that associate
+user-provided names with the user-provided values.
+Values larger than a block are allocated separate extents and written there.
+If the leaf information expands beyond a single block, a directory/attribute
+btree (``dabtree``) is created to map hashes of attribute names to entries
+for fast lookup.
+
+Salvaging extended attributes is done as follows:
+
+1. Walk the attr fork of the file being repaired to find the attribute leaf
+   blocks.
+   When one is found,
+
+   a. The leaf block is walked linearly to find candidate names.
+      When a name is found with no obvious problems,
+
+      1. Retrieve the value.
+         If that succeeds, add the name and value to the extended attributes of
+         the temporary file.
+
+Next, the extended attribute block headers in the temporary file must be
+rewritten with the new inode number.
+The heterogeneous nature of attr fork blocks makes this a little complex, since
+remote value buffers span all blocks in the extent, whereas the leaf blocks and
+the name index dabtree blocks are each a single filesystem block.
+
+2. Walk every attribute name in the temporary file to find the names with
+   remote values.
+
+   a. Read the remote value block.
+   b. Change the owner field.
+   c. Write it to disk.
+   d. Remember the file fork offset range of this remote value.
+
+3. Walk every extent in the attr fork of the temporary file, excluding the
+   blocks excluded in step 2d.
+   These are the blocks of the leaf blocks and the attribute name index
+   dabtree.
+
+   a. Read the block.
+   b. Change the owner field.
+   c. Attach the buffer to the transaction as an ordered buffer to force it to
+      disk before the new fork is committed.
+
+4. Use atomic extent swapping to exchange the new and old extended attribute
+   structures.
+   The old attribute blocks are now attached to the temporary file.
+
+5. Reap the temporary file.
+
+The proposed patchset is the
+`extended attribute repair
+<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=repair-xattrs>`_
+series.
+
+Case Study: Salvaging Directories
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Directories are implemented in XFS as a file containing three 32GB partitions.
+The first partition contains directory entry data blocks.
+Each data block contains variable-sized records associating a user-provided
+name with an inode number and a file type.
+If the directory entry data grows beyond one block, the second partition
+(post-EOF space) is populated to store an index of the names and free space.
+This makes directory name lookups very fast.
+If this second partition grows beyond one block, the third partition is
+populated to store a linear array of free space information for faster
+expansions.
+If the free space has been separated and the second partition grows again
+beyond one block, then a dabtree is used to map hashes of entry names to
+directory entry locations.
+
+At this time, XFS does not support the ability to have child files point back
+to the parent(s) that contain the files.
+This means that we can only salvage directories; we cannot rebuild them by
+scanning the filesystem.
+This gap will be closed when the parent pointer feature is merged.
+
+Fortunately, directory blocks are all the same size, so salvaging directories
+is straightforward:
+
+1. Find the parent of the directory.
+   If the dotdot entry is not unreadable, try to confirm that the alleged
+   parent has a child entry pointing back to the directory being repaired.
+   Otherwise, walk the filesystem to find it.
+
+2. Walk the first partition of data fork of the directory to find the directory
+   entry data blocks.
+   When one is found,
+
+   a. The data block is walked linearly to find candidate entries.
+      When a directory entry is found with no obvious problems,
+
+      i. Retrieve the inode number and the inode.
+         If that succeeds, add the name, inode number, and file type to the
+         directory entries of the the temporary file.
+
+Next, the directory block headers must be rewritten with the new inode number
+for completeness, even though the main filesystem never checks.
+
+3. Walk every extent in the temporary file's data fork.
+
+   a. Read the block.
+   b. Change the owner field.
+   c. Attach the buffer to the transaction as an ordered buffer to force it to
+      disk before the new fork is committed.
+
+4. Use atomic extent swapping to exchange the new and old directory structures.
+   The old directory blocks are now attached to the temporary file.
+
+5. Reap the temporary file.
+
+**Question**: Do we need to invalidate dentries when we rebuild a directory?
+**Question**: Can the dentry cache know about a directory entry that we then
+cannot salvage?
+
+The proposed patchset is the
+`directory repair
+<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=repair-dirs>`_
+series.
+
+.. _orphanage:
+
+The Orphanage
+-------------
+
+Filesystems present files as a directed, and hopefully acyclic, graph.
+The root of the filesystem is a directory, and each entry in a directory points
+downwards either to more subdirectories or to non-directory files.
+Unfortunately, a disruption in the directory graph pointers result in a
+disconnected graph, which makes files impossible to access via regular path
+resolution.
+The directory parent pointer online scrub code can detect a dotdot entry
+pointing to a parent directory that doesn't have a link back to the child
+directory, and the file link count checker can detect a file with positive link
+count that isn't pointed to by any directory in the filesystem.
+If the file in question has a positive link count, we know that the file in
+question is an orphan.
+
+The question is, how does XFS reconnect these files to the directory tree?
+Offline fsck solves the problem by attaching unconnected files into
+``/lost+found``, and so does online repair.
+This process is a little more involved in the kernel than it is in userspace:
+we have to use the regular VFS mechanisms to create the orphanage directory
+before we initiate repairs to directories or to file link counts.
+As a result, the orphanage will be created with all the necessary security
+attributes, just like any other root-owned directory.
+Files are reconnected with their inode number as the directory entry name,
+since XFS does not currently store universal directory parent pointers.
+This naming policy is the same as offline fsck's.
+Reparenting a file to the orphanage does not reset any of its permissions or
+ACLs.
+
+**Question**: Do we need to invalidate negative dentries when we add something
+to the orphanage?
+**Question**: Do we need to update the parent/child links in the dentry cache
+when we move something to the orphanage?
+In theory, no, because we scan the dentry cache to try to find a parent.
+
+The proposed patches are in the
+`directory repair
+<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=repair-dirs>`_
+series.

