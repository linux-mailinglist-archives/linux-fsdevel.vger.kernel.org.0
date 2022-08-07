Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A94258BC62
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Aug 2022 20:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235550AbiHGSaw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Aug 2022 14:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234227AbiHGSam (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Aug 2022 14:30:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE4FEB0;
        Sun,  7 Aug 2022 11:30:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 532D06101A;
        Sun,  7 Aug 2022 18:30:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F4EC433C1;
        Sun,  7 Aug 2022 18:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659897039;
        bh=pFmWil/S6LONwCzwOFM6sDohCLj8LSJDzpLr4ZsR/hQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=CxRmKOeebGpsRb18FYavDL8faT3C6A72REV1Uk5AFpmi9eDriduuKKKl+bvE8RHpp
         /ekCZ/mupltu1jf8tsYUZ8hrgmqW29y8y+FhzsRtOEIvcRKjJfjzQAfZ55RWniRg/F
         AjKl0DOBq5UfVeiPINB2eNQl2v4ceufF2XHUmam+f6nc6Hm0aRHQCJmPUoN/d6Z+AX
         042mpJdOWxCxEEehvLH21VNZRr9sq2TifX7D12RiGgGnybclj8L43VYQ2y4CBXDLYY
         nI8YUpFq8bL6FCNCjpMuKYe9rkHA4R5O2rf2MDMKwNdtReObg5hiQG3MSOQ5Ve5e18
         KLcqdA38sU9QA==
Subject: [PATCH 06/14] xfs: document how online fsck deals with eventual
 consistency
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, willy@infradead.org,
        chandan.babu@oracle.com, allison.henderson@oracle.com,
        linux-fsdevel@vger.kernel.org, hch@infradead.org,
        catherine.hoang@oracle.com
Date:   Sun, 07 Aug 2022 11:30:39 -0700
Message-ID: <165989703911.2495930.4767348676601233750.stgit@magnolia>
In-Reply-To: <165989700514.2495930.13997256907290563223.stgit@magnolia>
References: <165989700514.2495930.13997256907290563223.stgit@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

Writes to an XFS filesystem employ an eventual consistency update model
to break up complex multistep metadata updates into small chained
transactions.  This is generally good for performance and scalability
because XFS doesn't need to prepare for enormous transactions, but it
also means that online fsck must be careful not to attempt a fsck action
unless it can be shown that there are no other threads processing a
transaction chain.  This part of the design documentation covers the
thinking behind the consistency model and how scrub deals with it.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 .../filesystems/xfs-online-fsck-design.rst         |  307 ++++++++++++++++++++
 1 file changed, 307 insertions(+)


diff --git a/Documentation/filesystems/xfs-online-fsck-design.rst b/Documentation/filesystems/xfs-online-fsck-design.rst
index f45bf97fa9c4..7b783a0e85b9 100644
--- a/Documentation/filesystems/xfs-online-fsck-design.rst
+++ b/Documentation/filesystems/xfs-online-fsck-design.rst
@@ -1443,3 +1443,310 @@ This step is critical for enabling system administrator to monitor the status
 of the filesystem and the progress of any repairs.
 For developers, it is a useful means to judge the efficacy of error detection
 and correction in the online and offline checking tools.
+
+Eventual Consistency vs. Online Fsck
+------------------------------------
+
+Midway through the development of online scrubbing, the fsstress tests
+uncovered a misinteraction between online fsck and compound transaction chains
+created by other writer threads that resulted in false reports of metadata
+inconsistency.
+The root cause of these reports is the eventual consistency model introduced by
+the expansion of deferred work items and compound transaction chains when
+reverse mapping and reflink were introduced.
+
+Originally, transaction chains were added to XFS to avoid deadlocks when
+unmapping space from files.
+Deadlock avoidance rules require that AGs only be locked in increasing order,
+which makes it impossible (say) to use a single transaction to free a space
+extent in AG 7 and then try to free a now superfluous block mapping btree block
+in AG 3.
+To avoid these kinds of deadlocks, XFS creates Extent Freeing Intent (EFI) log
+items to commit to freeing some space in one transaction while deferring the
+actual metadata updates to a fresh transaction.
+The transaction sequence looks like this:
+
+1. The first transaction contains a physical update to the file's block mapping
+   structures to remove the mapping from the btree blocks.
+   It then attaches to the in-memory transaction an action item to schedule
+   deferred freeing of space.
+   Concretely, each transaction maintains a list of ``struct
+   xfs_defer_pending`` objects, each of which maintains a list of ``struct
+   xfs_extent_free_item`` objects.
+   Returning to the example above, the action item tracks the freeing of both
+   the unmapped space from AG 7 and the block mapping btree (BMBT) block from
+   AG 3.
+   Deferred frees recorded in this manner are committed in the log by creating
+   an EFI log item from the ``struct xfs_extent_free_item`` object and
+   attaching the log item to the transaction.
+   When the log is persisted to disk, the EFI item is written into the ondisk
+   transaction record.
+   EFIs can list up to 16 extents to free, all sorted in AG order.
+
+2. The second transaction contains a physical update to the free space btrees
+   of AG 3 to release the former BMBT block and a second physical update to the
+   free space btrees of AG 7 to release the unmapped file space.
+   Observe that the the physical updates are resequenced in the correct order
+   when possible.
+   Attached to the transaction is a an extent free done (EFD) log item.
+   The EFD contains a pointer to the EFI logged in transaction #1 so that log
+   recovery can tell if the EFI needs to be replayed.
+
+If the system goes down after transaction #1 is written back to the filesystem
+but before #2 is committed, a scan of the filesystem metadata would show
+inconsistent filesystem metadata because there would not appear to be any owner
+of the unmapped space.
+Happily, log recovery corrects this inconsistency for us -- when recovery finds
+an intent log item but does not find a corresponding intent done item, it will
+reconstruct the incore state of the intent item and finish it.
+In the example above, the log must replay both frees described in the recovered
+EFI to complete the recovery phase.
+
+There are two subtleties to XFS' transaction chaining strategy to consider.
+The first is that log items must be added to a transaction in the correct order
+to prevent conflicts with principal objects that are not held by the
+transaction.
+In other words, all per-AG metadata updates for an unmapped block must be
+completed before the last update to free the extent, and extents should not
+be reallocated until that last update commits to the log.
+The second subtlety comes from the fact that AG header buffers are (usually)
+released between each transaction in a chain.
+This means that other threads can observe an AG in an intermediate state,
+but as long as the first subtlety is handled, this should not affect the
+correctness of filesystem operations.
+Unmounting the filesystem flushes all pending work to disk, which means that
+offline fsck never sees the temporary inconsistencies caused by deferred work
+item processing.
+In this manner, XFS employs a form of eventual consistency to avoid deadlocks
+and increase parallelism.
+
+During the design phase of the reverse mapping and reflink features, it was
+decided that it was impractical to cram all the reverse mapping updates for a
+single filesystem change into a single transaction because a single file
+mapping operation can explode into many small updates:
+
+* The block mapping update itself
+* A reverse mapping update for the block mapping update
+* Fixing the freelist
+* A reverse mapping update for the freelist fix
+
+* A shape change to the block mapping btree
+* A reverse mapping update for the btree update
+* Fixing the freelist (again)
+* A reverse mapping update for the freelist fix
+
+* An update to the reference counting information
+* A reverse mapping update for the refcount update
+* Fixing the freelist (a third time)
+* A reverse mapping update for the freelist fix
+
+* Freeing any space that was unmapped and not owned by any other file
+* Fixing the freelist (a fourth time)
+* A reverse mapping update for the freelist fix
+
+* Freeing the space used by the block mapping btree
+* Fixing the freelist (a fifth time)
+* A reverse mapping update for the freelist fix
+
+Free list fixups are not usually needed more than once per AG per transaction
+chain, but it is theoretically possible if space is very tight.
+For copy-on-write updates this is even worse, because this must be done once to
+remove the space from a staging area and again to map it into the file!
+
+To deal with this explosion in a calm manner, XFS expands its use of deferred
+work items to cover most reverse mapping updates and all refcount updates.
+This reduces the worst case size of transaction reservations by breaking the
+work into a long chain of small updates, which increases the degree of eventual
+consistency in the system.
+Again, this generally isn't a problem because XFS orders its deferred work
+items carefully to avoid resource reuse conflicts between unsuspecting threads.
+
+However, online fsck changes the rules -- remember that although physical
+updates to per-AG structures are coordinated by locking the buffers for AG
+headers, buffer locks are dropped between transactions.
+Once scrub acquires resources and takes locks for a data structure, it must do
+all the validation work without releasing the lock.
+If the main lock for a space btree is an AG header buffer lock, scrub may have
+interrupted another thread that is midway through finishing a chain.
+For example, if a thread performing a copy-on-write has completed a reverse
+mapping update but not the corresponding refcount update, the two AG btrees
+will appear inconsistent to scrub and an observation of corruption will be
+recorded.  This observation will not be correct.
+If a repair is attempted in this state, the results will be catastrophic!
+
+Several solutions to this problem were evaluated upon discovery of this flaw:
+
+1. Add a higher level lock to allocation groups and require writer threads to
+   acquire the higher level lock in AG order before making any changes.
+   This would be very difficult to implement in practice because it is
+   difficult to determine which locks need to be obtained, and in what order,
+   without simulating the entire operation.
+   Performing a dry run of a file operation to discover necessary locks would
+   make the filesystem very slow.
+
+2. Make the deferred work coordinator code aware of consecutive intent items
+   targeting the same AG and have it hold the AG header buffers locked across
+   the transaction roll between updates.
+   This would introduce a lot of complexity into the coordinator since it is
+   only loosely coupled with the actual deferred work items.
+   It would also fail to solve the problem because deferred work items can
+   generate new deferred subtasks, but all subtasks must be complete before
+   work can start on a new sibling task.
+
+3. Teach online fsck to walk all transactions waiting for whichever lock(s)
+   protect the data structure being scrubbed to look for pending operations.
+   The checking and repair operations must factor these pending operations into
+   the evaluations being performed.
+   This solution is a nonstarter because it is *extremely* invasive to the main
+   filesystem.
+
+4. Recognize that only online fsck has this requirement of total consistency
+   of AG metadata, and that online fsck should be relatively rare as compared
+   to filesystem change operations.
+   For each AG, maintain a sloppy count of intent items targetting that AG.
+   When online fsck wants to examine an AG, it should lock the AG header
+   buffers to quiesce all transaction chains that want to modify that AG, and
+   only proceed with the scrub if the count is zero.
+   In other words, scrub only proceeds if it can lock the AG header buffers and
+   there can't possibly be any intents in progress.
+   This may lead to fairness and starvation issues, but regular filesystem
+   updates take precedence over online fsck activity.
+
+Intent Drains
+`````````````
+
+The fourth solution is implemented in the current iteration of online fsck,
+with percpu counters providing the "sloppy" counter.
+Updates to the percpu counter from normal writer threads are very fast, which
+is good for maintaining runtime performance.
+
+There are two key properties to the drain mechanism.
+First, the counter is incremented when a deferred work item is *queued* to a
+transaction, and it is decremented after the associated intent done log item is
+*committed* to another transaction.
+The second property is that deferred work can be added to a transaction without
+holding an AG header lock, but per-AG work items cannot be marked done without
+locking that AG header buffer to log the physical updates and the intent done
+log item.
+The first property enables scrub to yield to running transaction chains, which
+is an explicit deprioritization of online fsck to benefit file operations.
+The second property of the drain is key to the correct coordination of scrub,
+since scrub will always be able to decide if a conflict is possible.
+
+For regular filesystem code, the drain works as follows:
+
+1. Add a deferred item to a transaction.
+
+2. The deferred item manager calls the ``->add_item`` method of the item.
+
+3. The ``->add_item`` implementation calls ``xfs_drain_bump`` to increase the
+   sloppy counter.
+
+4. When the deferred item manager wants to finish the defeferred work, it calls
+   ``->finish_item`` to complete it.
+
+5. The ``->finish_item`` implementation logs some changes and calls
+   ``xfs_drain_drop`` to decrease the sloppy counter and wake up any threads
+   waiting on the drain.
+
+6. The subtransaction commits, which unlocks the resource associated with the
+   intent item.
+
+For scrub, the drain works as follows:
+
+1. Lock the resource(s) associated with the metadata being scrubbed.
+   For example, a scan of the refcount btree would lock the AGI and AGF header
+   buffers.
+
+2. If the sloppy counter is zero (``xfs_drain_busy`` returns false), there are
+   no chains in progress and the operation may proceed.
+
+3. Otherwise, release the resources grabbed in step 1.
+
+4. Wait for the intent counter to reach zero (``xfs_drain_intents``), then go
+   back to step 1 unless a signal has been caught.
+
+To avoid polling in step 4, the drain provides a waitqueue for scrub threads to
+be woken up whenever the intent count drops.
+
+The proposed patchset is the
+`scrub intent drain series
+<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=scrub-drain-intents>`_.
+
+.. _jump_labels:
+
+Static Keys (aka Jump Label Patching)
+`````````````````````````````````````
+
+Online fsck for XFS separates the regular filesystem from the checking and
+repair code as much as possible.
+However, there are a few parts of online fsck (such as the intent drains, and
+later, live update hooks) where it is useful for the online fsck code to know
+what's going on in the rest of the filesystem.
+Since it is not expected that online fsck will be constantly running in the
+background, it is very important to minimize the runtime overhead imposed by
+these hooks when online fsck is compiled into the kernel but not actively
+running on behalf of userspace.
+Taking locks in the hot path of a writer thread to access a data structure only
+to find that no further action is necessary is expensive -- on the author's
+computer, this have an overhead of 40-50ns per access.
+Fortunately, the kernel supports dynamic code patching, which enables XFS to
+replace a static branch to hook code with ``nop`` sleds when online fsck isn't
+running.
+This sled has an overhead of however long it takes the instruction decoder to
+skip past the sled, which seems to be on the order of less than 1ns and
+does not access memory outside of instruction fetching.
+
+When online fsck enables the static key, the sled is replaced with an
+unconditional branch to call the hook code.
+The switchover is quite expensive (~22000ns) but is paid entirely by the
+program that invoked online fsck, and can be amortized if multiple threads
+enter online fsck at the same time, or if multiple filesystems are being
+checked at the same time.
+Changing the branch direction requires taking the CPU hotplug lock, and since
+CPU initialization requires memory allocation, online fsck must be careful not
+to change a static key while holding any locks or resources that could be
+accessed in the memory reclaim paths.
+To minimize contention on the CPU hotplug lock, care should be taken not to
+enable or disable static keys unnecessarily.
+
+Because static keys are intended to minimize hook overhead for regular
+filesystem operations when xfs_scrub is not running, the intended usage
+patterns are as follows:
+
+- The hooked part of XFS should declare a static-scoped static key that
+  defaults to false.
+  The ``DEFINE_STATIC_KEY_FALSE`` macro takes care of this.
+  The static key itself should be declared as a ``static`` variable.
+
+- When deciding to invoke code that's only used by scrub, the regular
+  filesystem should call the ``static_branch_unlikely`` predicate to avoid the
+  scrub-only hook code if the static key is not enabled.
+
+- The regular filesystem should export helper functions that call
+  ``static_branch_inc`` to enable and ``static_branch_dec`` to disable the
+  static key.
+  Wrapper functions make it easy to compile out the relevant code if the kernel
+  distributor turns off online fsck at build time.
+
+- Scrub functions wanting to turn on scrub-only XFS functionality should call
+  the ``xchk_fshooks_enable`` from the setup function to enable a specific
+  hook.
+  This must be done before obtaining any resources that are used by memory
+  reclaim.
+  Callers had better be sure they really need the functionality gated by the
+  static key; the ``TRY_HARDER`` flag is useful here.
+
+Online scrub has resource acquisition helpers (e.g. ``xchk_perag_lock``) to
+handle locking AGI and AGF buffers for all scrubber functions.
+If it detects a conflict between scrub and the running transactions, it will
+try to wait for intents to complete.
+If the caller of the helper has not enabled the static key, the helper will
+return -EDEADLOCK, which should result in the scrub being restarted with the
+``TRY_HARDER`` flag set.
+The scrub setup function should detect that flag, enable the static key, and
+try the scrub again.
+Scrub teardown disables all static keys obtained by ``xchk_fshooks_enable``.
+
+For more information, please see the kernel documentation of
+Documentation/staging/static-keys.rst.

