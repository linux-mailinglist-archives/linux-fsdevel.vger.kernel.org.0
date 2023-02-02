Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A4A6887DA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Feb 2023 20:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbjBBT4T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Feb 2023 14:56:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjBBT4J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Feb 2023 14:56:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA05A72645;
        Thu,  2 Feb 2023 11:56:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3F5E6B82809;
        Thu,  2 Feb 2023 19:56:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5E7CC433EF;
        Thu,  2 Feb 2023 19:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675367759;
        bh=r3V37YBbx7Dr6tFGtJRA4/NGEkzhKVUYEr3Bb3orMz4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I29BLEqwV8fmRQN9xBUHiS5C0+I+160UDvHGHbWO3gh/Ncrk9jSMkEyZz4gY05xxL
         1ln0BkExwLUtVZUMQuIltGeqJkUO0qbb4yemGF9yjttQshkvNS+hTNmTJCWM0UUgL/
         wFRW1wfybTbInA6PWD48tLmDLHCo1Y3tUeDRp2nylU1b1SGMS2wU4pTKJgCj5Lr42H
         PfhuFWrW4vfqfr5vRAyrnUWtBf9NilH96ppeqluHZKIRaOWSudecLgzqkY8JaHl7TW
         EkHrIasKc9J3if0HKM0MwQMUd0iFsrehKQRg3jKuIjKpImGmQ8c9y5XLkac2EJZB4Q
         jF987pJNsKtag==
Date:   Thu, 2 Feb 2023 11:55:58 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Allison Henderson <allison.henderson@oracle.com>
Cc:     Catherine Hoang <catherine.hoang@oracle.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        Chandan Babu <chandan.babu@oracle.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>
Subject: Re: [PATCH 06/14] xfs: document how online fsck deals with eventual
 consistency
Message-ID: <Y9wVTqgEQXBmY5BH@magnolia>
References: <167243825144.682859.12802259329489258661.stgit@magnolia>
 <167243825245.682859.4827095718073568782.stgit@magnolia>
 <fa10340d87b71049de04df358abdc2305c3f39f4.camel@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fa10340d87b71049de04df358abdc2305c3f39f4.camel@oracle.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 31, 2023 at 06:11:30AM +0000, Allison Henderson wrote:
> On Fri, 2022-12-30 at 14:10 -0800, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > Writes to an XFS filesystem employ an eventual consistency update
> > model
> > to break up complex multistep metadata updates into small chained
> > transactions.  This is generally good for performance and scalability
> > because XFS doesn't need to prepare for enormous transactions, but it
> > also means that online fsck must be careful not to attempt a fsck
> > action
> > unless it can be shown that there are no other threads processing a
> > transaction chain.  This part of the design documentation covers the
> > thinking behind the consistency model and how scrub deals with it.
> > 
> > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > ---
> >  .../filesystems/xfs-online-fsck-design.rst         |  303
> > ++++++++++++++++++++
> >  1 file changed, 303 insertions(+)
> > 
> > 
> > diff --git a/Documentation/filesystems/xfs-online-fsck-design.rst
> > b/Documentation/filesystems/xfs-online-fsck-design.rst
> > index f45bf97fa9c4..419eb54ee200 100644
> > --- a/Documentation/filesystems/xfs-online-fsck-design.rst
> > +++ b/Documentation/filesystems/xfs-online-fsck-design.rst
> > @@ -1443,3 +1443,306 @@ This step is critical for enabling system
> > administrator to monitor the status
> >  of the filesystem and the progress of any repairs.
> >  For developers, it is a useful means to judge the efficacy of error
> > detection
> >  and correction in the online and offline checking tools.
> > +
> > +Eventual Consistency vs. Online Fsck
> > +------------------------------------
> > +
> > +Midway through the development of online scrubbing, the fsstress
> > tests
> > +uncovered a misinteraction between online fsck and compound
> > transaction chains
> > +created by other writer threads that resulted in false reports of
> > metadata
> > +inconsistency.
> > +The root cause of these reports is the eventual consistency model
> > introduced by
> > +the expansion of deferred work items and compound transaction chains
> > when
> > +reverse mapping and reflink were introduced.
> 
> 
> 

Was there supposed to be a comment here?

> > +
> > +Originally, transaction chains were added to XFS to avoid deadlocks
> > when
> > +unmapping space from files.
> > +Deadlock avoidance rules require that AGs only be locked in
> > increasing order,
> > +which makes it impossible (say) to use a single transaction to free
> > a space
> > +extent in AG 7 and then try to free a now superfluous block mapping
> > btree block
> > +in AG 3.
> > +To avoid these kinds of deadlocks, XFS creates Extent Freeing Intent
> > (EFI) log
> > +items to commit to freeing some space in one transaction while
> > deferring the
> > +actual metadata updates to a fresh transaction.
> > +The transaction sequence looks like this:
> > +
> > +1. The first transaction contains a physical update to the file's
> > block mapping
> > +   structures to remove the mapping from the btree blocks.
> > +   It then attaches to the in-memory transaction an action item to
> > schedule
> > +   deferred freeing of space.
> > +   Concretely, each transaction maintains a list of ``struct
> > +   xfs_defer_pending`` objects, each of which maintains a list of
> > ``struct
> > +   xfs_extent_free_item`` objects.
> > +   Returning to the example above, the action item tracks the
> > freeing of both
> > +   the unmapped space from AG 7 and the block mapping btree (BMBT)
> > block from
> > +   AG 3.
> > +   Deferred frees recorded in this manner are committed in the log
> > by creating
> > +   an EFI log item from the ``struct xfs_extent_free_item`` object
> > and
> > +   attaching the log item to the transaction.
> > +   When the log is persisted to disk, the EFI item is written into
> > the ondisk
> > +   transaction record.
> > +   EFIs can list up to 16 extents to free, all sorted in AG order.
> > +
> > +2. The second transaction contains a physical update to the free
> > space btrees
> > +   of AG 3 to release the former BMBT block and a second physical
> > update to the
> > +   free space btrees of AG 7 to release the unmapped file space.
> > +   Observe that the the physical updates are resequenced in the
> > correct order
> > +   when possible.
> > +   Attached to the transaction is a an extent free done (EFD) log
> > item.
> > +   The EFD contains a pointer to the EFI logged in transaction #1 so
> > that log
> > +   recovery can tell if the EFI needs to be replayed.
> > +
> > +If the system goes down after transaction #1 is written back to the
> > filesystem
> > +but before #2 is committed, a scan of the filesystem metadata would
> > show
> > +inconsistent filesystem metadata because there would not appear to
> > be any owner
> > +of the unmapped space.
> > +Happily, log recovery corrects this inconsistency for us -- when
> > recovery finds
> > +an intent log item but does not find a corresponding intent done
> > item, it will
> > +reconstruct the incore state of the intent item and finish it.
> > +In the example above, the log must replay both frees described in
> > the recovered
> > +EFI to complete the recovery phase.
> > +
> > +There are two subtleties to XFS' transaction chaining strategy to
> > consider.
> > +The first is that log items must be added to a transaction in the
> > correct order
> > +to prevent conflicts with principal objects that are not held by the
> > +transaction.
> > +In other words, all per-AG metadata updates for an unmapped block
> > must be
> > +completed before the last update to free the extent, and extents
> > should not
> > +be reallocated until that last update commits to the log.
> > +The second subtlety comes from the fact that AG header buffers are
> > (usually)
> > +released between each transaction in a chain.
> > +This means that other threads can observe an AG in an intermediate
> > state,
> > +but as long as the first subtlety is handled, this should not affect
> > the
> > +correctness of filesystem operations.
> > +Unmounting the filesystem flushes all pending work to disk, which
> > means that
> > +offline fsck never sees the temporary inconsistencies caused by
> > deferred work
> > +item processing.
> > +In this manner, XFS employs a form of eventual consistency to avoid
> > deadlocks
> > +and increase parallelism.
> > +
> > +During the design phase of the reverse mapping and reflink features,
> > it was
> > +decided that it was impractical to cram all the reverse mapping
> > updates for a
> > +single filesystem change into a single transaction because a single
> > file
> > +mapping operation can explode into many small updates:
> > +
> > +* The block mapping update itself
> > +* A reverse mapping update for the block mapping update
> > +* Fixing the freelist
> > +* A reverse mapping update for the freelist fix
> > +
> > +* A shape change to the block mapping btree
> > +* A reverse mapping update for the btree update
> > +* Fixing the freelist (again)
> > +* A reverse mapping update for the freelist fix
> > +
> > +* An update to the reference counting information
> > +* A reverse mapping update for the refcount update
> > +* Fixing the freelist (a third time)
> > +* A reverse mapping update for the freelist fix
> > +
> > +* Freeing any space that was unmapped and not owned by any other
> > file
> > +* Fixing the freelist (a fourth time)
> > +* A reverse mapping update for the freelist fix
> > +
> > +* Freeing the space used by the block mapping btree
> > +* Fixing the freelist (a fifth time)
> > +* A reverse mapping update for the freelist fix
> > +
> > +Free list fixups are not usually needed more than once per AG per
> > transaction
> > +chain, but it is theoretically possible if space is very tight.
> > +For copy-on-write updates this is even worse, because this must be
> > done once to
> > +remove the space from a staging area and again to map it into the
> > file!
> > +
> > +To deal with this explosion in a calm manner, XFS expands its use of
> > deferred
> > +work items to cover most reverse mapping updates and all refcount
> > updates.
> > +This reduces the worst case size of transaction reservations by
> > breaking the
> > +work into a long chain of small updates, which increases the degree
> > of eventual
> > +consistency in the system.
> > +Again, this generally isn't a problem because XFS orders its
> > deferred work
> > +items carefully to avoid resource reuse conflicts between
> > unsuspecting threads.
> > +
> > +However, online fsck changes the rules -- remember that although
> > physical
> > +updates to per-AG structures are coordinated by locking the buffers
> > for AG
> > +headers, buffer locks are dropped between transactions.
> > +Once scrub acquires resources and takes locks for a data structure,
> > it must do
> > +all the validation work without releasing the lock.
> > +If the main lock for a space btree is an AG header buffer lock,
> > scrub may have
> > +interrupted another thread that is midway through finishing a chain.
> > +For example, if a thread performing a copy-on-write has completed a
> > reverse
> > +mapping update but not the corresponding refcount update, the two AG
> > btrees
> > +will appear inconsistent to scrub and an observation of corruption
> > will be
> > +recorded.  This observation will not be correct.
> > +If a repair is attempted in this state, the results will be
> > catastrophic!
> > +
> > +Several solutions to this problem were evaluated upon discovery of
> > this flaw:
> 
> 
> Hmm, so while having a really in depth efi example is insightful, I
> wonder if it would be more oranized to put it in a separate document
> somewhere and just reference it.  As far as ofsck is concerned, I think
> a lighter sumary would do:
> 
> 
> "Complex operations that modify multiple AGs are performed through a
> series of transactions which are logged to a journal that an offline
> fsck can either replay or discard.  Online fsck however, must be able
> to deal with these operations while they are still in progress.  This
> presents a unique challenge for ofsck since a partially completed
> transaction chain may present the appearance of inconsistencies, even
> though the operations are functioning as intended. (For a more detailed
> example, see <cite document here...>)  
> 
> The challenge then becomes how to avoid incorrectly repairing these
> non-issues as doing so would cause more harm than help."

I agree that this topic needs a much shorter introduction before moving
on to the gory details.  How does this strike you?

"Complex operations can make modifications to multiple per-AG data
structures with a chain of transactions.  These chains, once committed
to the log, are restarted during log recovery if the system crashes
while processing the chain.  Because the AG header buffers are unlocked
between transactions within a chain, online checking must coordinate
with chained operations that are in progress to avoid incorrectly
detecting inconsistencies due to pending chains.  Furthermore, online
repair must not run when operations are pending because the metadata are
temporarily inconsistent with each other, and rebuilding is not
possible."

"Only online fsck has this requirement of total consistency of AG
metadata, and should be relatively rare as compared to filesystem change
operations.  Online fsck coordinates with transaction chains as follows:

* "For each AG, maintain a count of intent items targetting that AG.
  The count should be bumped whenever a new item is added to the chain.
  The count should be dropped when the filesystem has locked the AG
  header buffers and finished the work.

* "When online fsck wants to examine an AG, it should lock the AG header
  buffers to quiesce all transaction chains that want to modify that AG.
  If the count is zero, proceed with the checking operation.  If it is
  nonzero, cycle the buffer locks to allow the chain to make forward
  progress.

"This may lead to online fsck taking a long time to complete, but
regular filesystem updates take precedence over background checking
activity.  Details about the discovery of this situation are presented
in the <next section>, and details about the solution are presented
<after that>."

These gory details of how I recognized the problem are a subsection of
the main heading, and anyone who wants to know them can read it.
Readers who'd rather move on to the solution can jump directly to the
"Intent Drains" section.  The <bracketed> text are hyperlinks.

> > +
> > +1. Add a higher level lock to allocation groups and require writer
> > threads to
> > +   acquire the higher level lock in AG order before making any
> > changes.
> > +   This would be very difficult to implement in practice because it
> > is
> > +   difficult to determine which locks need to be obtained, and in
> > what order,
> > +   without simulating the entire operation.
> > +   Performing a dry run of a file operation to discover necessary
> > locks would
> > +   make the filesystem very slow.
> > +
> > +2. Make the deferred work coordinator code aware of consecutive
> > intent items
> > +   targeting the same AG and have it hold the AG header buffers
> > locked across
> > +   the transaction roll between updates.
> > +   This would introduce a lot of complexity into the coordinator
> > since it is
> > +   only loosely coupled with the actual deferred work items.
> > +   It would also fail to solve the problem because deferred work
> > items can
> > +   generate new deferred subtasks, but all subtasks must be complete
> > before
> > +   work can start on a new sibling task.
> Hmm, that one doesnt seem like it's really an option then :-(

Right.  Now that this section has become its own gory details
subsection, the sentence preceeding the numbered list becomes:

"Several other solutions to this problem were evaluated upon discovery
of this flaw and rejected:"

> > +
> > +3. Teach online fsck to walk all transactions waiting for whichever
> > lock(s)
> > +   protect the data structure being scrubbed to look for pending
> > operations.
> > +   The checking and repair operations must factor these pending
> > operations into
> > +   the evaluations being performed.
> > +   This solution is a nonstarter because it is *extremely* invasive
> > to the main
> > +   filesystem.
> > +
> > +4. Recognize that only online fsck has this requirement of total
> > consistency
> > +   of AG metadata, and that online fsck should be relatively rare as
> > compared
> > +   to filesystem change operations.
> > +   For each AG, maintain a count of intent items targetting that AG.
> > +   When online fsck wants to examine an AG, it should lock the AG
> > header
> > +   buffers to quiesce all transaction chains that want to modify
> > that AG, and
> > +   only proceed with the scrub if the count is zero.
> > +   In other words, scrub only proceeds if it can lock the AG header
> > buffers and
> > +   there can't possibly be any intents in progress.
> > +   This may lead to fairness and starvation issues, but regular
> > filesystem
> > +   updates take precedence over online fsck activity.
> So basically it sounds like 4 is the only reasonable option?

Yes.

> If the discussion concerning the other options have died down, I would
> clean them out.

That's just the problem -- I've sent this and the code patches to the
list several times now, and mostly haven't heard any solid replies.  So
it's a bit premature to take it out, and again it might be useful to
capture the roads not taken.

> They're great for brain storming and invitations for
> collaboration, but ideally the goal of any of that should be to narrow
> down an agreed upon plan of action.  And the goal of your document
> should make clear what that plan is.  So if no one has any objections
> by now, maybe just tie it right into the last line:
> 
> "The challenge then becomes how to avoid incorrectly repairing these
> non-issues as doing so would cause more harm than help. 
> Fortunately only online fsck has this requirement of total
> consistency..."

> > +
> > +Intent Drains
> > +`````````````
> > +
> > +The fourth solution is implemented in the current iteration of
> This solution is implemented...

"Online fsck uses an atomic intent item counter and lock cycling to
coordinate with transaction chains.  There are two key properties to the
drain mechanism..."

> > online fsck,
> > +with atomic_t providing the active intent counter.
> > +
> > +There are two key properties to the drain mechanism.
> > +First, the counter is incremented when a deferred work item is
> > *queued* to a
> > +transaction, and it is decremented after the associated intent done
> > log item is
> > +*committed* to another transaction.
> > +The second property is that deferred work can be added to a
> > transaction without
> > +holding an AG header lock, but per-AG work items cannot be marked
> > done without
> > +locking that AG header buffer to log the physical updates and the
> > intent done
> > +log item.
> > +The first property enables scrub to yield to running transaction
> > chains, which
> > +is an explicit deprioritization of online fsck to benefit file
> > operations.
> > +The second property of the drain is key to the correct coordination
> > of scrub,
> > +since scrub will always be able to decide if a conflict is possible.
> > +
> > +For regular filesystem code, the drain works as follows:
> > +
> > +1. Call the appropriate subsystem function to add a deferred work
> > item to a
> > +   transaction.
> > +
> > +2. The function calls ``xfs_drain_bump`` to increase the counter.
> > +
> > +3. When the deferred item manager wants to finish the deferred work
> > item, it
> > +   calls ``->finish_item`` to complete it.
> > +
> > +4. The ``->finish_item`` implementation logs some changes and calls
> > +   ``xfs_drain_drop`` to decrease the sloppy counter and wake up any
> > threads
> > +   waiting on the drain.
> > +
> > +5. The subtransaction commits, which unlocks the resource associated
> > with the
> > +   intent item.
> > +
> > +For scrub, the drain works as follows:
> > +
> > +1. Lock the resource(s) associated with the metadata being scrubbed.
> > +   For example, a scan of the refcount btree would lock the AGI and
> > AGF header
> > +   buffers.
> > +
> > +2. If the counter is zero (``xfs_drain_busy`` returns false), there
> > are no
> > +   chains in progress and the operation may proceed.
> > +
> > +3. Otherwise, release the resources grabbed in step 1.
> > +
> > +4. Wait for the intent counter to reach zero
> > (``xfs_drain_intents``), then go
> > +   back to step 1 unless a signal has been caught.
> > +
> > +To avoid polling in step 4, the drain provides a waitqueue for scrub
> > threads to
> > +be woken up whenever the intent count drops to zero.
> I think all that makes sense

Good! :)

> > +
> > +The proposed patchset is the
> > +`scrub intent drain series
> > +<
> > https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/
> > log/?h=scrub-drain-intents>`_.
> > +
> > +.. _jump_labels:
> > +
> > +Static Keys (aka Jump Label Patching)
> > +`````````````````````````````````````
> > +
> > +Online fsck for XFS separates the regular filesystem from the
> > checking and
> > +repair code as much as possible.
> > +However, there are a few parts of online fsck (such as the intent
> > drains, and
> > +later, live update hooks) where it is useful for the online fsck
> > code to know
> > +what's going on in the rest of the filesystem.
> > +Since it is not expected that online fsck will be constantly running
> > in the
> > +background, it is very important to minimize the runtime overhead
> > imposed by
> > +these hooks when online fsck is compiled into the kernel but not
> > actively
> > +running on behalf of userspace.
> > +Taking locks in the hot path of a writer thread to access a data
> > structure only
> > +to find that no further action is necessary is expensive -- on the
> > author's
> > +computer, this have an overhead of 40-50ns per access.
> > +Fortunately, the kernel supports dynamic code patching, which
> > enables XFS to
> > +replace a static branch to hook code with ``nop`` sleds when online
> > fsck isn't
> > +running.
> > +This sled has an overhead of however long it takes the instruction
> > decoder to
> > +skip past the sled, which seems to be on the order of less than 1ns
> > and
> > +does not access memory outside of instruction fetching.
> > +
> > +When online fsck enables the static key, the sled is replaced with
> > an
> > +unconditional branch to call the hook code.
> > +The switchover is quite expensive (~22000ns) but is paid entirely by
> > the
> > +program that invoked online fsck, and can be amortized if multiple
> > threads
> > +enter online fsck at the same time, or if multiple filesystems are
> > being
> > +checked at the same time.
> > +Changing the branch direction requires taking the CPU hotplug lock,
> > and since
> > +CPU initialization requires memory allocation, online fsck must be
> > careful not
> > +to change a static key while holding any locks or resources that
> > could be
> > +accessed in the memory reclaim paths.
> > +To minimize contention on the CPU hotplug lock, care should be taken
> > not to
> > +enable or disable static keys unnecessarily.
> > +
> > +Because static keys are intended to minimize hook overhead for
> > regular
> > +filesystem operations when xfs_scrub is not running, the intended
> > usage
> > +patterns are as follows:
> > +
> > +- The hooked part of XFS should declare a static-scoped static key
> > that
> > +  defaults to false.
> > +  The ``DEFINE_STATIC_KEY_FALSE`` macro takes care of this.
> > +  The static key itself should be declared as a ``static`` variable.
> > +
> > +- When deciding to invoke code that's only used by scrub, the
> > regular
> > +  filesystem should call the ``static_branch_unlikely`` predicate to
> > avoid the
> > +  scrub-only hook code if the static key is not enabled.
> > +
> > +- The regular filesystem should export helper functions that call
> > +  ``static_branch_inc`` to enable and ``static_branch_dec`` to
> > disable the
> > +  static key.
> > +  Wrapper functions make it easy to compile out the relevant code if
> > the kernel
> > +  distributor turns off online fsck at build time.
> > +
> > +- Scrub functions wanting to turn on scrub-only XFS functionality
> > should call
> > +  the ``xchk_fshooks_enable`` from the setup function to enable a
> > specific
> > +  hook.
> > +  This must be done before obtaining any resources that are used by
> > memory
> > +  reclaim.
> > +  Callers had better be sure they really need the functionality
> > gated by the
> > +  static key; the ``TRY_HARDER`` flag is useful here.
> > +
> > +Online scrub has resource acquisition helpers (e.g.
> > ``xchk_perag_lock``) to
> > +handle locking AGI and AGF buffers for all scrubber functions.
> > +If it detects a conflict between scrub and the running transactions,
> > it will
> > +try to wait for intents to complete.
> > +If the caller of the helper has not enabled the static key, the
> > helper will
> > +return -EDEADLOCK, which should result in the scrub being restarted
> > with the
> > +``TRY_HARDER`` flag set.
> > +The scrub setup function should detect that flag, enable the static
> > key, and
> > +try the scrub again.
> > +Scrub teardown disables all static keys obtained by
> > ``xchk_fshooks_enable``.
> 
> Ok, this part here seems pretty well documented.  Organizing nits aside
> I think it looks good.

Thanks for digging into all of this!

--D

> Allison
> 
> > +
> > +For more information, please see the kernel documentation of
> > +Documentation/staging/static-keys.rst.
> > 
> 
