Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C071D6AD3F0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Mar 2023 02:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjCGBcN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Mar 2023 20:32:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjCGBcE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Mar 2023 20:32:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF145CC0C;
        Mon,  6 Mar 2023 17:31:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 34020B81289;
        Tue,  7 Mar 2023 01:31:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E594CC433EF;
        Tue,  7 Mar 2023 01:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678152661;
        bh=i7M3mYClZB9SrIPldQ4nuyh8gBoy5peseZE0jhdxJHw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=uuDqdqxOHbfra+e6VbwbdUrQq7iXDIWirFtvAPgC5ruHmzrxcO03NRjU8R8fymxRv
         T88QxsgEahx46UBHh11PRS0E+B+12dLtRHjJDM8OzBXz1l949/SOAumiKSMzs3SzPc
         h4UmQt9SSG/AYME8Yr7Vl5bp8L6yFzO29vrBfcwxNp7oD5nuEFW4Gux2OVeJEUYmMT
         NeoP78F7kj970wulydbMdlGuvNexDXzKzbxvDqwg2iyWlzyKPXXfY7VnSsAsznsWv6
         uli724cjg+NSnw7lJ9js73zSc6wXGIySghh0CnX6957lwY+9oh2f4tUpO/3lnagfZR
         2UFdsOhxqRO5w==
Subject: [PATCH 02/14] xfs: document the general theory underlying online fsck
 design
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, willy@infradead.org,
        chandan.babu@oracle.com, allison.henderson@oracle.com,
        linux-fsdevel@vger.kernel.org, hch@infradead.org,
        catherine.hoang@oracle.com, david@fromorbit.com
Date:   Mon, 06 Mar 2023 17:31:00 -0800
Message-ID: <167815266047.3750278.16330727239901024398.stgit@magnolia>
In-Reply-To: <167815264897.3750278.15092544376893521026.stgit@magnolia>
References: <167815264897.3750278.15092544376893521026.stgit@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URI_DOTEDU autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

Start the second chapter of the online fsck design documentation.
This covers the general theory underlying how online fsck works.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 .../filesystems/xfs-online-fsck-design.rst         |  404 ++++++++++++++++++++
 1 file changed, 404 insertions(+)


diff --git a/Documentation/filesystems/xfs-online-fsck-design.rst b/Documentation/filesystems/xfs-online-fsck-design.rst
index 07c7b4cde18f..0846935325b2 100644
--- a/Documentation/filesystems/xfs-online-fsck-design.rst
+++ b/Documentation/filesystems/xfs-online-fsck-design.rst
@@ -210,3 +210,407 @@ metadata to enable targeted checking and repair operations while the system
 is running.
 This capability will be coupled to automatic system management so that
 autonomous self-healing of XFS maximizes service availability.
+
+2. Theory of Operation
+======================
+
+Because it is necessary for online fsck to lock and scan live metadata objects,
+online fsck consists of three separate code components.
+The first is the userspace driver program ``xfs_scrub``, which is responsible
+for identifying individual metadata items, scheduling work items for them,
+reacting to the outcomes appropriately, and reporting results to the system
+administrator.
+The second and third are in the kernel, which implements functions to check
+and repair each type of online fsck work item.
+
++------------------------------------------------------------------+
+| **Note**:                                                        |
++------------------------------------------------------------------+
+| For brevity, this document shortens the phrase "online fsck work |
+| item" to "scrub item".                                           |
++------------------------------------------------------------------+
+
+Scrub item types are delineated in a manner consistent with the Unix design
+philosophy, which is to say that each item should handle one aspect of a
+metadata structure, and handle it well.
+
+Scope
+-----
+
+In principle, online fsck should be able to check and to repair everything that
+the offline fsck program can handle.
+However, online fsck cannot be running 100% of the time, which means that
+latent errors may creep in after a scrub completes.
+If these errors cause the next mount to fail, offline fsck is the only
+solution.
+This limitation means that maintenance of the offline fsck tool will continue.
+A second limitation of online fsck is that it must follow the same resource
+sharing and lock acquisition rules as the regular filesystem.
+This means that scrub cannot take *any* shortcuts to save time, because doing
+so could lead to concurrency problems.
+In other words, online fsck is not a complete replacement for offline fsck, and
+a complete run of online fsck may take longer than online fsck.
+However, both of these limitations are acceptable tradeoffs to satisfy the
+different motivations of online fsck, which are to **minimize system downtime**
+and to **increase predictability of operation**.
+
+.. _scrubphases:
+
+Phases of Work
+--------------
+
+The userspace driver program ``xfs_scrub`` splits the work of checking and
+repairing an entire filesystem into seven phases.
+Each phase concentrates on checking specific types of scrub items and depends
+on the success of all previous phases.
+The seven phases are as follows:
+
+1. Collect geometry information about the mounted filesystem and computer,
+   discover the online fsck capabilities of the kernel, and open the
+   underlying storage devices.
+
+2. Check allocation group metadata, all realtime volume metadata, and all quota
+   files.
+   Each metadata structure is scheduled as a separate scrub item.
+   If corruption is found in the inode header or inode btree and ``xfs_scrub``
+   is permitted to perform repairs, then those scrub items are repaired to
+   prepare for phase 3.
+   Repairs are implemented by using the information in the scrub item to
+   resubmit the kernel scrub call with the repair flag enabled; this is
+   discussed in the next section.
+   Optimizations and all other repairs are deferred to phase 4.
+
+3. Check all metadata of every file in the filesystem.
+   Each metadata structure is also scheduled as a separate scrub item.
+   If repairs are needed and ``xfs_scrub`` is permitted to perform repairs,
+   and there were no problems detected during phase 2, then those scrub items
+   are repaired immediately.
+   Optimizations, deferred repairs, and unsuccessful repairs are deferred to
+   phase 4.
+
+4. All remaining repairs and scheduled optimizations are performed during this
+   phase, if the caller permits them.
+   Before starting repairs, the summary counters are checked and any necessary
+   repairs are performed so that subsequent repairs will not fail the resource
+   reservation step due to wildly incorrect summary counters.
+   Unsuccesful repairs are requeued as long as forward progress on repairs is
+   made somewhere in the filesystem.
+   Free space in the filesystem is trimmed at the end of phase 4 if the
+   filesystem is clean.
+
+5. By the start of this phase, all primary and secondary filesystem metadata
+   must be correct.
+   Summary counters such as the free space counts and quota resource counts
+   are checked and corrected.
+   Directory entry names and extended attribute names are checked for
+   suspicious entries such as control characters or confusing Unicode sequences
+   appearing in names.
+
+6. If the caller asks for a media scan, read all allocated and written data
+   file extents in the filesystem.
+   The ability to use hardware-assisted data file integrity checking is new
+   to online fsck; neither of the previous tools have this capability.
+   If media errors occur, they will be mapped to the owning files and reported.
+
+7. Re-check the summary counters and presents the caller with a summary of
+   space usage and file counts.
+
+Steps for Each Scrub Item
+-------------------------
+
+The kernel scrub code uses a three-step strategy for checking and repairing
+the one aspect of a metadata object represented by a scrub item:
+
+1. The scrub item of interest is checked for corruptions; opportunities for
+   optimization; and for values that are directly controlled by the system
+   administrator but look suspicious.
+   If the item is not corrupt or does not need optimization, resource are
+   released and the positive scan results are returned to userspace.
+   If the item is corrupt or could be optimized but the caller does not permit
+   this, resources are released and the negative scan results are returned to
+   userspace.
+   Otherwise, the kernel moves on to the second step.
+
+2. The repair function is called to rebuild the data structure.
+   Repair functions generally choose rebuild a structure from other metadata
+   rather than try to salvage the existing structure.
+   If the repair fails, the scan results from the first step are returned to
+   userspace.
+   Otherwise, the kernel moves on to the third step.
+
+3. In the third step, the kernel runs the same checks over the new metadata
+   item to assess the efficacy of the repairs.
+   The results of the reassessment are returned to userspace.
+
+Classification of Metadata
+--------------------------
+
+Each type of metadata object (and therefore each type of scrub item) is
+classified as follows:
+
+Primary Metadata
+````````````````
+
+Metadata structures in this category should be most familiar to filesystem
+users either because they are directly created by the user or they index
+objects created by the user
+Most filesystem objects fall into this class:
+
+- Free space and reference count information
+
+- Inode records and indexes
+
+- Storage mapping information for file data
+
+- Directories
+
+- Extended attributes
+
+- Symbolic links
+
+- Quota limits
+
+Scrub obeys the same rules as regular filesystem accesses for resource and lock
+acquisition.
+
+Primary metadata objects are the simplest for scrub to process.
+The principal filesystem object (either an allocation group or an inode) that
+owns the item being scrubbed is locked to guard against concurrent updates.
+The check function examines every record associated with the type for obvious
+errors and cross-references healthy records against other metadata to look for
+inconsistencies.
+Repairs for this class of scrub item are simple, since the repair function
+starts by holding all the resources acquired in the previous step.
+The repair function scans available metadata as needed to record all the
+observations needed to complete the structure.
+Next, it stages the observations in a new ondisk structure and commits it
+atomically to complete the repair.
+Finally, the storage from the old data structure are carefully reaped.
+
+Because ``xfs_scrub`` locks a primary object for the duration of the repair,
+this is effectively an offline repair operation performed on a subset of the
+filesystem.
+This minimizes the complexity of the repair code because it is not necessary to
+handle concurrent updates from other threads, nor is it necessary to access
+any other part of the filesystem.
+As a result, indexed structures can be rebuilt very quickly, and programs
+trying to access the damaged structure will be blocked until repairs complete.
+The only infrastructure needed by the repair code are the staging area for
+observations and a means to write new structures to disk.
+Despite these limitations, the advantage that online repair holds is clear:
+targeted work on individual shards of the filesystem avoids total loss of
+service.
+
+This mechanism is described in section 2.1 ("Off-Line Algorithm") of
+V. Srinivasan and M. J. Carey, `"Performance of On-Line Index Construction
+Algorithms" <https://minds.wisconsin.edu/bitstream/handle/1793/59524/TR1047.pdf>`_,
+*Extending Database Technology*, pp. 293-309, 1992.
+
+Most primary metadata repair functions stage their intermediate results in an
+in-memory array prior to formatting the new ondisk structure, which is very
+similar to the list-based algorithm discussed in section 2.3 ("List-Based
+Algorithms") of Srinivasan.
+However, any data structure builder that maintains a resource lock for the
+duration of the repair is *always* an offline algorithm.
+
+Secondary Metadata
+``````````````````
+
+Metadata structures in this category reflect records found in primary metadata,
+but are only needed for online fsck or for reorganization of the filesystem.
+
+Secondary metadata include:
+
+- Reverse mapping information
+
+- Directory parent pointers
+
+This class of metadata is difficult for scrub to process because scrub attaches
+to the secondary object but needs to check primary metadata, which runs counter
+to the usual order of resource acquisition.
+Frequently, this means that full filesystems scans are necessary to rebuild the
+metadata.
+Check functions can be limited in scope to reduce runtime.
+Repairs, however, require a full scan of primary metadata, which can take a
+long time to complete.
+Under these conditions, ``xfs_scrub`` cannot lock resources for the entire
+duration of the repair.
+
+Instead, repair functions set up an in-memory staging structure to store
+observations.
+Depending on the requirements of the specific repair function, the staging
+index will either have the same format as the ondisk structure or a design
+specific to that repair function.
+The next step is to release all locks and start the filesystem scan.
+When the repair scanner needs to record an observation, the staging data are
+locked long enough to apply the update.
+While the filesystem scan is in progress, the repair function hooks the
+filesystem so that it can apply pending filesystem updates to the staging
+information.
+Once the scan is done, the owning object is re-locked, the live data is used to
+write a new ondisk structure, and the repairs are committed atomically.
+The hooks are disabled and the staging staging area is freed.
+Finally, the storage from the old data structure are carefully reaped.
+
+Introducing concurrency helps online repair avoid various locking problems, but
+comes at a high cost to code complexity.
+Live filesystem code has to be hooked so that the repair function can observe
+updates in progress.
+The staging area has to become a fully functional parallel structure so that
+updates can be merged from the hooks.
+Finally, the hook, the filesystem scan, and the inode locking model must be
+sufficiently well integrated that a hook event can decide if a given update
+should be applied to the staging structure.
+
+In theory, the scrub implementation could apply these same techniques for
+primary metadata, but doing so would make it massively more complex and less
+performant.
+Programs attempting to access the damaged structures are not blocked from
+operation, which may cause application failure or an unplanned filesystem
+shutdown.
+
+Inspiration for the secondary metadata repair strategy was drawn from section
+2.4 of Srinivasan above, and sections 2 ("NSF: Inded Build Without Side-File")
+and 3.1.1 ("Duplicate Key Insert Problem") in C. Mohan, `"Algorithms for
+Creating Indexes for Very Large Tables Without Quiescing Updates"
+<https://dl.acm.org/doi/10.1145/130283.130337>`_, 1992.
+
+The sidecar index mentioned above bears some resemblance to the side file
+method mentioned in Srinivasan and Mohan.
+Their method consists of an index builder that extracts relevant record data to
+build the new structure as quickly as possible; and an auxiliary structure that
+captures all updates that would be committed to the index by other threads were
+the new index already online.
+After the index building scan finishes, the updates recorded in the side file
+are applied to the new index.
+To avoid conflicts between the index builder and other writer threads, the
+builder maintains a publicly visible cursor that tracks the progress of the
+scan through the record space.
+To avoid duplication of work between the side file and the index builder, side
+file updates are elided when the record ID for the update is greater than the
+cursor position within the record ID space.
+
+To minimize changes to the rest of the codebase, XFS online repair keeps the
+replacement index hidden until it's completely ready to go.
+In other words, there is no attempt to expose the keyspace of the new index
+while repair is running.
+The complexity of such an approach would be very high and perhaps more
+appropriate to building *new* indices.
+
+**Future Work Question**: Can the full scan and live update code used to
+facilitate a repair also be used to implement a comprehensive check?
+
+*Answer*: In theory, yes.  Check would be much stronger if each scrub function
+employed these live scans to build a shadow copy of the metadata and then
+compared the shadow records to the ondisk records.
+However, doing that is a fair amount more work than what the checking functions
+do now.
+The live scans and hooks were developed much later.
+That in turn increases the runtime of those scrub functions.
+
+Summary Information
+```````````````````
+
+Metadata structures in this last category summarize the contents of primary
+metadata records.
+These are often used to speed up resource usage queries, and are many times
+smaller than the primary metadata which they represent.
+
+Examples of summary information include:
+
+- Summary counts of free space and inodes
+
+- File link counts from directories
+
+- Quota resource usage counts
+
+Check and repair require full filesystem scans, but resource and lock
+acquisition follow the same paths as regular filesystem accesses.
+
+The superblock summary counters have special requirements due to the underlying
+implementation of the incore counters, and will be treated separately.
+Check and repair of the other types of summary counters (quota resource counts
+and file link counts) employ the same filesystem scanning and hooking
+techniques as outlined above, but because the underlying data are sets of
+integer counters, the staging data need not be a fully functional mirror of the
+ondisk structure.
+
+Inspiration for quota and file link count repair strategies were drawn from
+sections 2.12 ("Online Index Operations") through 2.14 ("Incremental View
+Maintenace") of G.  Graefe, `"Concurrent Queries and Updates in Summary Views
+and Their Indexes"
+<http://www.odbms.org/wp-content/uploads/2014/06/Increment-locks.pdf>`_, 2011.
+
+Since quotas are non-negative integer counts of resource usage, online
+quotacheck can use the incremental view deltas described in section 2.14 to
+track pending changes to the block and inode usage counts in each transaction,
+and commit those changes to a dquot side file when the transaction commits.
+Delta tracking is necessary for dquots because the index builder scans inodes,
+whereas the data structure being rebuilt is an index of dquots.
+Link count checking combines the view deltas and commit step into one because
+it sets attributes of the objects being scanned instead of writing them to a
+separate data structure.
+Each online fsck function will be discussed as case studies later in this
+document.
+
+Risk Management
+---------------
+
+During the development of online fsck, several risk factors were identified
+that may make the feature unsuitable for certain distributors and users.
+Steps can be taken to mitigate or eliminate those risks, though at a cost to
+functionality.
+
+- **Decreased performance**: Adding metadata indices to the filesystem
+  increases the time cost of persisting changes to disk, and the reverse space
+  mapping and directory parent pointers are no exception.
+  System administrators who require the maximum performance can disable the
+  reverse mapping features at format time, though this choice dramatically
+  reduces the ability of online fsck to find inconsistencies and repair them.
+
+- **Incorrect repairs**: As with all software, there might be defects in the
+  software that result in incorrect repairs being written to the filesystem.
+  Systematic fuzz testing (detailed in the next section) is employed by the
+  authors to find bugs early, but it might not catch everything.
+  The kernel build system provides Kconfig options (``CONFIG_XFS_ONLINE_SCRUB``
+  and ``CONFIG_XFS_ONLINE_REPAIR``) to enable distributors to choose not to
+  accept this risk.
+  The xfsprogs build system has a configure option (``--enable-scrub=no``) that
+  disables building of the ``xfs_scrub`` binary, though this is not a risk
+  mitigation if the kernel functionality remains enabled.
+
+- **Inability to repair**: Sometimes, a filesystem is too badly damaged to be
+  repairable.
+  If the keyspaces of several metadata indices overlap in some manner but a
+  coherent narrative cannot be formed from records collected, then the repair
+  fails.
+  To reduce the chance that a repair will fail with a dirty transaction and
+  render the filesystem unusable, the online repair functions have been
+  designed to stage and validate all new records before committing the new
+  structure.
+
+- **Misbehavior**: Online fsck requires many privileges -- raw IO to block
+  devices, opening files by handle, ignoring Unix discretionary access control,
+  and the ability to perform administrative changes.
+  Running this automatically in the background scares people, so the systemd
+  background service is configured to run with only the privileges required.
+  Obviously, this cannot address certain problems like the kernel crashing or
+  deadlocking, but it should be sufficient to prevent the scrub process from
+  escaping and reconfiguring the system.
+  The cron job does not have this protection.
+
+- **Fuzz Kiddiez**: There are many people now who seem to think that running
+  automated fuzz testing of ondisk artifacts to find mischevious behavior and
+  spraying exploit code onto the public mailing list for instant zero-day
+  disclosure is somehow of some social benefit.
+  In the view of this author, the benefit is realized only when the fuzz
+  operators help to **fix** the flaws, but this opinion apparently is not
+  widely shared among security "researchers".
+  The XFS maintainers' continuing ability to manage these events presents an
+  ongoing risk to the stability of the development process.
+  Automated testing should front-load some of the risk while the feature is
+  considered EXPERIMENTAL.
+
+Many of these risks are inherent to software programming.
+Despite this, it is hoped that this new functionality will prove useful in
+reducing unexpected downtime.

