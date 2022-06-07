Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5262853F37D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jun 2022 03:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235269AbiFGBtF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jun 2022 21:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235192AbiFGBs5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jun 2022 21:48:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75B4666AC;
        Mon,  6 Jun 2022 18:48:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33F07611E8;
        Tue,  7 Jun 2022 01:48:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E0C6C385A9;
        Tue,  7 Jun 2022 01:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654566534;
        bh=ek6+AUavn8Rbvehvbad715ISAIo7IwxWWuj79LM0DdM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=MePeml4Cq+EsKGO9bFJ83E6nMp7anBOCMJeTmPYeoEcpqYy994f/qcXtPPL70Rcia
         Slj1fbf5HCC9EBv/ZB2vZkn3oPic8LqMmzmGUUB3Ua7Bm/9rZGb6r3MTrDlRxvs/2G
         0OzP19KHNL7/4g5ITcfObeyEW8NwXUAXYRuDr0t/QnAKuTouXhlHq/2QHhSasbjgHs
         ec1ylpDk8A2OV/qiptZ4snTyKXqQXyZbHnqQGmPlX3fec2/qhQICizzmFoxePIjKSc
         k+YL8/QAODoi9h1xjGGu3Kbc20qaf0jOf7n8G2vIi66EkV1GLZFckj39CiqO+bmCcb
         b/SmCcFQ4wZ7Q==
Subject: [PATCH 2/8] xfs: document the general theory underlying online fsck
 design
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, willy@infradead.org,
        chandan.babu@oracle.com, allison.henderson@oracle.com,
        linux-fsdevel@vger.kernel.org, hch@infradead.org,
        catherine.hoang@oracle.com
Date:   Mon, 06 Jun 2022 18:48:54 -0700
Message-ID: <165456653402.167418.12013933026741916677.stgit@magnolia>
In-Reply-To: <165456652256.167418.912764930038710353.stgit@magnolia>
References: <165456652256.167418.912764930038710353.stgit@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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

Start the second chapter of the online fsck design documentation.
This covers the general theory underlying how online fsck works.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 .../filesystems/xfs-online-fsck-design.rst         |  357 ++++++++++++++++++++
 1 file changed, 357 insertions(+)


diff --git a/Documentation/filesystems/xfs-online-fsck-design.rst b/Documentation/filesystems/xfs-online-fsck-design.rst
index 8768cbf7ab47..1ad7cd81b9fd 100644
--- a/Documentation/filesystems/xfs-online-fsck-design.rst
+++ b/Documentation/filesystems/xfs-online-fsck-design.rst
@@ -170,3 +170,360 @@ metadata to enable targeted checking and repair operations while the system
 is running.
 This capability will be coupled to automatic system management so that
 autonomous self-healing of XFS maximizes service availability.
+
+Theory of Operation
+===================
+
+Because it is necessary for online fsck to lock and scan live metadata objects,
+online fsck consists of two separate code components.
+The first is the userspace driver program ``xfs_scrub``, which is responsible
+for identifying individual metadata items, scheduling work items for them,
+reacting to the outcomes appropriately, and reporting results to the system
+administrator.
+The second is the kernel, which must implement functions to check and repair
+each type of online fsck work item.
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
+Broadly speaking, online fsck should be able to check and to repair nearly
+everything that the offline fsck program can handle.
+However, implicit in the adjective *online* is the limitation that online fsck
+cannot deal with anything that prevents the filesystem from mounting.
+Because of this, maintenance of the offline fsck tool will continue.
+A second limitation of online fsck is that it must follow the same resource
+sharing and lock acquisition rules as the regular filesystem.
+This means that scrub cannot take *any* shortcuts to save time, because doing
+so could lead to concurrency problems.
+In other words, online fsck will never be able to fix 100% of the
+inconsistencies that offline fsck can repair, and a complete run of online fsck
+may take longer.
+However, both of these limitations are acceptable tradeoffs to satisfy the
+different motivation of online fsck, which is to **minimize system downtime**
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
+   If corruption is found in the inode header or btree and repairs are
+   permitted, the repairs are performed early to prepare for phase 3.
+   Optimizations and all other repairs are deferred to phase 4.
+
+3. Check all metadata of every file in the filesystem.
+   Each metadata structure is also scheduled as a separate scrub item.
+   Repairs, if permitted, are attempted as soon as they are found.
+   If any problems were found during phase 2, all repairs are deferred to phase
+   4.
+   Optimizations and unsuccessful repairs are deferred to phase 4.
+
+4. All remaining repairs and scheduled optimizations are performed during this
+   phase, if the caller permitted this; if there is no work to be done, this
+   phase is skipped.
+   Before starting repairs, the summary counters are checked and any necessary
+   repairs are performed so that subsequent repairs proceed with accurate
+   resource reservations.
+   Unsuccesful repair attempts will be requeued as long as forward progress
+   on repairs is made anywhere in the filesystem.
+   Free space in the filesystem is trimmed at the end of phase 4 if the
+   filesystem is clean.
+
+5. By the start of this phase, all filesystem metadata (with the possible
+   exception of summary information) should be correct.
+   Any summary information that has not previously been checked is checked now.
+   Next, directory entry names and extended attribute names are checked for
+   suspicious entries such as control characters or confusing Unicode sequences
+   appearing in names.
+
+6. Read all allocated and written data file extents in the filesystem, if the
+   caller asked for a media scan.
+   The ability to use hardware-assisted data file integrity checking is new
+   to online fsck; neither of the previous tools have this capability.
+
+7. The final phase re-checks the summary counters and presents the caller with
+   a summary of space usage and file counts.
+
+Steps for Each Scrub Item
+-------------------------
+
+The kernel scrub code uses a three-step strategy for checking and repairing
+the aspect of a metadata object represented by a scrub item:
+
+1. The scrub item of interest is checked for corruptions; opportunities for
+   optimization; and for values that are directly controlled by the system
+   administrator but look suspicious.
+   If the item is not corrupt or does not need optimization, the positive scan
+   results are returned to userspace and no further action is necessary.
+   If the item is corrupt or could be optimized but the caller did not permit
+   this, the negative scan results are returned to userspace.
+   Otherwise, the kernel moves on to the second step.
+
+2. For the second step, resources and locks obtained in the first step are
+   retained, and the repair function is called.
+   Repair functions will generally choose rebuild a structure from other
+   metadata rather than try to salvage the existing structure.
+   If the repair fails, the scan results from the first step are returned to
+   userspace.
+   Otherwise, the kernel moves on to the third step.
+
+3. In the third step, the kernel runs the same checks over the new metadata
+   item to assess the efficacy of the repairs.
+   The results of the third step are returned to userspace.
+
+Classification of Metadata
+--------------------------
+
+Each type of metadata object (and therefore each type of scrub item) can be
+classified as follows:
+
+Primary Metadata
+````````````````
+
+Metadata structures in this category should be most familiar to filesystem
+users either because they are directly created by the user or they index
+objects created by the user
+Most filesystem objects fall into this class.
+Resource and lock acquisition for scrub code follows the same order as regular
+filesystem accesses.
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
+Because we lock a primary object for the duration of the repair, this is
+effectively an offline repair operation performed on a subset of the
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
+Algorithms" <https://dl.acm.org/doi/10.5555/645336.649870>`_,
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
+Resource and lock acquisition for scrub code do not follow the same order as
+regular filesystem accesses, and may involve full filesystem scans.
+
+Secondary metadata objects are difficult for scrub to process, because scrub
+attaches to the secondary object but needs to check primary metadata, which
+runs counter to the usual acquisition order.
+Check functions can be limited in scope to reduce runtime.
+Repairs, however, require a full scan of primary metadata, which can take a
+long time to complete.
+For both of these reasons, we cannot lock resources for the entire duration of
+the repair.
+
+Instead, repair functions set up an in-memory sidecar index to stage
+observations.
+Depending on the requirements of the specific repair function, the sidecar
+index can have the same format as the ondisk structure, or it can have a design
+specific to that repair function.
+The second step is to release all locks and start the filesystem scan.
+When the repair scanner needs to record an observation, the sidecar data are
+locked long enough to apply the update.
+Simultaneously, the repair function hooks relevant parts of the filesystem to
+apply updates to the sidecar data if the the update pertains to an object that
+has already been scanned by the index builder.
+Once the scan is done, the owning object is re-locked, the live data is used to
+write a new ondisk structure, and the repairs are committed atomically.
+The hooks are disabled and the sidecar staging area is freed.
+Finally, the storage from the old data structure are carefully reaped.
+
+Introducing concurrency helps us to avoid various locking problems, but at a
+high cost to code complexity.
+Live filesystem code has to be hooked so that the repair function can observe
+updates in progress.
+The staging area has to become a fully functional parallel structure so that
+updates can be merged from the hooks.
+Finally, the hook, the filesystem scan, and the inode locking model must be
+sufficiently well integrated that a hook event can decide if a given update
+should be applied to the sidecar structure.
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
+As a result, online repair uses an indexed side file (the in-memory btree) to
+determine what goes in the new ondisk structure and a scan cursor to control
+what goes into the side file.
+
+Summary Information
+```````````````````
+
+Metadata structures in this last category summarize the contents of primary
+metadata records.
+These are often used to speed up resource usage queries, and are many times
+smaller than the primary metadata which they represent.
+Check and repair both require full filesystem scans, but resource and lock
+acquisition follow the same paths as regular filesystem accesses.
+
+The superblock summary counters have special requirements due to the underlying
+implementation of the incore counters, and will be treated separately.
+Check and repair of the other types of summary counters (quotas and file link
+counts) employ the same filesystem scanning and hooking techniques as outlined
+above, but because the underlying data are arrays of integer counters, the
+staging data need not be a fully functional mirror of the ondisk structure.
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
+we're setting attributes of the objects being scanned, and not building a
+separate data structure.
+Each online fsck function will be discussed as case studies later in this
+document.
+
+Risk Management
+---------------
+
+During the development of online fsck, several risk factors were identified
+that may make the feature unsuitable to certain distributors and users.
+These steps can be taken to reduce or eliminate those risks, though at a cost
+to functionality.
+
+- **Decreased performance**: Adding metadata indices to the filesystem
+  increases the performance cost of persisting changes to disk, and the reverse
+  space mapping and directory parent pointers are no exception.
+  System administrators who require the maximum performance can disable the
+  reverse mapping features at format time, though this choice dramatically
+  reduces the ability of online metadata checking to find inconsistencies
+  and repair them.
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
+  mitigation.
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
+  operators help to fix the flaws, but this opinion apparently is not widely
+  shared among security "researchers".
+  The XFS maintainers' continuing ability to manage these events presents an
+  ongoing risk to the stability of the development process.
+  Automated testing should front-load some of the risk while the feature is
+  considered EXPERIMENTAL.
+
+Many of these risks are inherent to software programming.
+Despite them, it is hoped that this new functionality will prove useful in
+reducing unexpected downtime.

