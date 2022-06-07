Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4DB53F383
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jun 2022 03:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235330AbiFGBtX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jun 2022 21:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235380AbiFGBtV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jun 2022 21:49:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF9467D2E;
        Mon,  6 Jun 2022 18:49:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BA495B81B32;
        Tue,  7 Jun 2022 01:49:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63316C385A9;
        Tue,  7 Jun 2022 01:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654566552;
        bh=bt6WMmxovT13rcshbpFfkhSJ8NQFAEXAiWTxaDgfkbQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=oYwqNYeDa/L3ll1B59p577psE85g9jXnlHbInv3UstOdLouk2jhfxc6Bf4LQDuf4Z
         8GwYMg0udILBVLooUdncWRJHlhalwx0VUb5140NaH6tFikROFB1nK+g+K/N7bq6qAC
         AQauAl/DmlTnPtrRs9YCylGLYrt7YvdT2yjpHgkv5U12zkKVvAL7M4zdtrtUJdS9mD
         ELY+B4ZhAc1eF16g+aS3HrySI1CVelpz2icxoDEhkop4JK1VA0bX+tJg+dzGDcThvF
         nhOtW9bEluoysPeudeRn0ocY0y4+0teLBuHx0elduuO3i3ABZlpDanRG5TFfzJkJ/T
         6BVLqFQ/zA8Rg==
Subject: [PATCH 5/8] xfs: document technical aspects of kernel space metadata
 repair code
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, willy@infradead.org,
        chandan.babu@oracle.com, allison.henderson@oracle.com,
        linux-fsdevel@vger.kernel.org, hch@infradead.org,
        catherine.hoang@oracle.com
Date:   Mon, 06 Jun 2022 18:49:11 -0700
Message-ID: <165456655194.167418.18231964741132704054.stgit@magnolia>
In-Reply-To: <165456652256.167418.912764930038710353.stgit@magnolia>
References: <165456652256.167418.912764930038710353.stgit@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URI_DOTEDU autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

Add the fifth chapter of the online fsck design documentation, where we
discuss the details of the data structures and algorithms used by the
kernel to repair filesystem space metadata.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 .../filesystems/xfs-online-fsck-design.rst         | 1299 ++++++++++++++++++++
 .../filesystems/xfs-self-describing-metadata.rst   |    1 
 2 files changed, 1294 insertions(+), 6 deletions(-)


diff --git a/Documentation/filesystems/xfs-online-fsck-design.rst b/Documentation/filesystems/xfs-online-fsck-design.rst
index bdb4bdda3180..18d63aa089cd 100644
--- a/Documentation/filesystems/xfs-online-fsck-design.rst
+++ b/Documentation/filesystems/xfs-online-fsck-design.rst
@@ -368,20 +368,20 @@ long time to complete.
 For both of these reasons, we cannot lock resources for the entire duration of
 the repair.
 
-Instead, repair functions set up an in-memory sidecar index to stage
+Instead, repair functions set up an in-memory staging structure to store
 observations.
-Depending on the requirements of the specific repair function, the sidecar
+Depending on the requirements of the specific repair function, the staging
 index can have the same format as the ondisk structure, or it can have a design
 specific to that repair function.
 The second step is to release all locks and start the filesystem scan.
-When the repair scanner needs to record an observation, the sidecar data are
+When the repair scanner needs to record an observation, the staging data are
 locked long enough to apply the update.
 Simultaneously, the repair function hooks relevant parts of the filesystem to
-apply updates to the sidecar data if the the update pertains to an object that
+apply updates to the staging data if the the update pertains to an object that
 has already been scanned by the index builder.
 Once the scan is done, the owning object is re-locked, the live data is used to
 write a new ondisk structure, and the repairs are committed atomically.
-The hooks are disabled and the sidecar staging area is freed.
+The hooks are disabled and the staging staging area is freed.
 Finally, the storage from the old data structure are carefully reaped.
 
 Introducing concurrency helps us to avoid various locking problems, but at a
@@ -392,7 +392,7 @@ The staging area has to become a fully functional parallel structure so that
 updates can be merged from the hooks.
 Finally, the hook, the filesystem scan, and the inode locking model must be
 sufficiently well integrated that a hook event can decide if a given update
-should be applied to the sidecar structure.
+should be applied to the staging structure.
 
 In theory, the scrub implementation could apply these same techniques for
 primary metadata, but doing so would make it massively more complex and less
@@ -817,3 +817,1290 @@ Proposed patchsets include
 and
 `preservation of sickness info during memory reclaim
 <https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=indirect-health-reporting>`_.
+
+Kernel Algorithms and Data Structures
+=====================================
+
+In this section, we discuss the key algorithms and data structures of the
+kernel code that facilitate the ability to check and repair metadata while the
+system is running.
+We start with the pieces that provide the foundation for checking metadata and
+then move on to how XFS actually regenerates itself.
+
+Self Describing Metadata
+------------------------
+
+Starting with XFS version 5 in 2012, XFS updated the format of nearly every
+ondisk block header to record a magic number, a checksum, a universally
+"unique" identifier (UUID), an owner code, the ondisk address of the block,
+and a log sequence number.
+When loading a block buffer from disk, the magic number, UUID, owner, and
+ondisk address confirm that the retrieved block matches the specific owner of
+the current filesystem, and that the information contained in the block is
+supposed to be found at the ondisk address.
+The first three components enable checking tools to disregard alleged metadata
+that doesn't belong to the filesystem, and the fourth component enables the
+filesystem to detect lost writes.
+
+The logging code maintains the checksum and the log sequence number of the last
+transactional update.
+Checksums are useful for detecting torn writes and other mischief between the
+computer and its storage devices.
+Sequence number tracking enables log recovery to avoid applying out of date
+log updates to the filesystem.
+
+These two features improve overall runtime resiliency by providing a means for
+the filesystem to detect obvious corruption when reading metadata blocks from
+disk, but these buffer verifiers cannot provide any consistency checking
+between metadata structures.
+
+For more details, see
+:ref:`Documentation/filesystems/xfs-self-describing-metadata.rst <xfs_self_describing_metadata>`.
+
+Reverse Mapping
+---------------
+
+The original design of XFS (circa 1993) is an improvement upon 1980s Unix
+filesystem design.
+In those days, storage density was expensive, CPU time was scarce, and
+excessive seek time could kill performance.
+For performance reasons, filesystem authors were reluctant to add redundancy to
+the filesystem, even at the cost of data integrity.
+Filesystems designers in the early 21st century chose different strategies to
+increase internal redundancy -- either by storing nearly identical copies of
+metadata, or through more space-efficient techniques such as erasure coding.
+Obvious corruptions are typically repaired by copying replicas or
+reconstructing from codes.
+
+For XFS, a different redundancy strategy was chosen: the addition of a
+secondary space usage index that maps allocated disk extents back to their
+owners.
+By adding a new index, the filesystem retains most of its ability to scale
+well to heavily threaded workloads involving large datasets, since the primary
+file metadata (the directory tree, the file block map, and the allocation
+groups) remain unchanged.
+Although the reverse-mapping feature increases overhead costs for space
+mapping activities just like any other system that improves redundancy, it
+has one key advantage: the reverse index is key to enabling online fsck and
+other requested functionality such as filesystem reorganization, better media
+failure reporting, and shrinking.
+
+A criticism of adding the secondary index is that it does nothing to improve
+the robustness of user data storage itself.
+This is valid, but it is a tradeoff -- the complexity of the new index is far
+less than adding volume management and storage device mirroring to XFS.
+Perfection of RAID 1 and device remapping are best left to existing layers in
+the kernel.
+
+The information captured in a reverse space mapping record is as follows:
+
+.. code-block:: c
+
+	struct xfs_rmap_irec {
+	    xfs_agblock_t    rm_startblock;   /* extent start block */
+	    xfs_extlen_t     rm_blockcount;   /* extent length */
+	    uint64_t         rm_owner;        /* extent owner */
+	    uint64_t         rm_offset;       /* offset within the owner */
+	    unsigned int     rm_flags;        /* state flags */
+	};
+
+The first two fields capture the location and size of the physical space,
+in units of filesystem blocks.
+The owner field tells us which metadata structure or file inode have been
+assigned this space.
+For space allocated to files, the offset field tells us where the space was
+mapped within the file fork.
+Finally, the flags field provides extra information about the space usage --
+is this an attribute fork extent?  A file mapping btree extent?  Or an
+unwritten data extent?
+
+Online filesystem checking judges the consistency of each primary metadata
+record by comparing its space allocation information against all other space
+indices.
+The reverse mapping index plays a key role in the consistency checking process
+because it contains a second copy of all space allocation information.
+However, program runtime and ease of resource acquisition are the only real
+limits to what online checking can consult.
+For example, a file data extent mapping can be checked against:
+
+* The absence of an entry in the free space information.
+* The absence of an entry in the inode index.
+* The absence of an entry in the reference count data if the file is not
+  marked as having shared extents.
+* The correspondence of an entry in the reverse mapping information.
+
+A key observation here is that only the reverse mapping can provide a positive
+affirmation of correctness if the primary metadata is in doubt.
+The checking code for most primary metadata follows a path similar to the
+one outlined above.
+
+A second observation to make about this secondary index is that proving its
+consistency with the primary metadata is difficult.
+Demonstrating that a given reverse mapping record exactly corresponds to the
+primary space metadata involves a full scan of all primary space metadata,
+which is very time intensive.
+Furthermore, scanning activity for online fsck can only use non-blocking lock
+acquisition primitives if the locking order is not the regular order as used
+by the rest of the filesystem.
+Technically speaking, this means that forward progress during this part of a
+scan of the reverse mapping data cannot be guaranteed if system load is
+especially heavy.
+For this reason, it is not practical for online check to detect reverse
+mapping records that lack a counterpart in the primary metadata.
+Instead, we rely on rigorous cross-referencing during the primary space mapping
+structure checks.
+
+Reverse mappings play a key role in reconstruction of primary metadata.
+The secondary information is general enough for online repair to synthesize a
+complete copy of any primary space management metadata by locking that
+resource, querying all reverse mapping indices looking for records matching
+the relevant resource, and transforming the mapping into an appropriate format.
+The details of how these records are staged, written to disk, and committed
+into the filesystem will be covered in subsequent sections.
+
+Checking and Cross-Referencing
+------------------------------
+
+The first step of checking a metadata structure is to examine every record
+contained within the structure and its relationship with the rest of the
+system.
+XFS contains multiple layers of checking to try to prevent inconsistent
+metadata from wreaking havoc on the system.
+Each of these layers contributes information that helps the kernel to make
+three decisions about the health of a metadata structure:
+
+- Is a part of this structure obviously corrupt (``XFS_SCRUB_OFLAG_CORRUPT``) ?
+- Is this structure inconsistent with the rest of the system
+  (``XFS_SCRUB_OFLAG_XCORRUPT``) ?
+- Is there so much damage around the filesystem that cross-referencing is not
+  possible (``XFS_SCRUB_OFLAG_XFAIL``) ?
+- Can the structure be optimized to improve performance or reduce the size of
+  metadata (``XFS_SCRUB_OFLAG_PREEN``) ?
+- Does the structure contain data that is not inconsistent but deserves review
+  by the system administrator (``XFS_SCRUB_OFLAG_WARNING``) ?
+
+The following sections describe how the metadata scrubbing process works.
+
+Metadata Buffer Verification
+````````````````````````````
+
+The lowest layer of metadata protection in XFS are the metadata verifiers built
+into the buffer cache.
+These functions perform inexpensive internal consistency checking of the block
+itself, and answer these questions:
+
+- Does the block belong to this filesystem?
+
+- Does the block belong to the structure that asked for the read?
+  This assumes that metadata blocks only have one owner, which is always true
+  in XFS.
+
+- Is the type of data stored in the block within a reasonable range of what we
+  were expecting?
+
+- Does the physical location of the block match the location we read from?
+
+- Does the block checksum match the data?
+
+The scope of the protections here are very limited -- they can only establish
+that the filesystem code is reasonably free of gross corruption bugs and that
+the storage system is reasonably competent at retrieval.
+Corruption problems observed at runtime cause the generation of health reports,
+failed system calls, and in the extreme case, filesystem shutdowns if the
+corrupt metadata force the cancellation of a dirty transaction.
+
+Every online fsck scrubbing function is expected to read every ondisk metadata
+block of a structure in the course of checking the structure.
+Corruption problems observed during a check are immediately reported to
+userspace as corruption; during a cross-reference, they are reported as a
+failure to cross-reference once the full examination is complete.
+Reads satisfied by a buffer already in cache (and hence already verified)
+bypass these checks.
+
+Internal Consistency Checks
+```````````````````````````
+
+The next higher level of metadata protection are the internal record
+verification code built into the filesystem.
+These checks are split between the buffer verifiers, the in-filesystem users of
+the buffer cache, and the scrub code itself, depending on the amount of higher
+level context required.
+The scope of checking is still internal to the block.
+For performance reasons, regular runtime code may skip some of these checks
+unless debugging is enabled or a write is about to occur.
+Scrub functions, of course, must check all possible problems.
+These higher level checking functions answer these questions:
+
+- Does the type of data stored in the block match what we were expecting?
+
+- Does the block belong to the owning structure that asked for the read?
+
+- If the block contains records, do the records fit within the block?
+
+- If the block tracks internal free space information, is it consistent with
+  the record areas?
+
+- Are the records contained inside the block free of obvious corruptions?
+
+Record checks in this category are more rigorous and more time-intensive.
+For example, block and inode pointers are checked to ensure that they point
+within the dynamically allocated parts of an allocation group and within
+the filesystem.
+Names are checked for invalid characters, and flags are checked for invalid
+combinations.
+Other record attributes are checked for sensible values.
+Btree records spanning an interval of the btree keyspace are checked for
+correct order and lack of mergeability (except for file fork mappings).
+
+Validation of Userspace-Controlled Record Attributes
+````````````````````````````````````````````````````
+
+Various pieces of filesystem metadata are directly controlled by userspace.
+Because of this nature, validation work cannot be more precise than checking
+that a value is within the possible range.
+These fields include:
+
+- Superblock fields controlled by mount options
+- Filesystem labels
+- File timestamps
+- File permissions
+- File size
+- File flags
+- Names present in directory entries, extended attribute keys, and filesystem
+  labels
+- Extended attribute key namespaces
+- Extended attribute values
+- File data block contents
+- Quota limits
+- Quota timer expiration (if resource usage exceeds the soft limit)
+
+Cross-Referencing Space Metadata
+````````````````````````````````
+
+The next higher level of checking is cross-referencing records between metadata
+structures.
+For regular runtime code, the cost of these checks is considered prohibitively
+expensive, but as scrub is dedicated to rooting out inconsistencies, it pursues
+all avenues of inquiry.
+The exact set of cross-referencing is highly dependent on the context of the
+data structure being checked.
+
+The XFS btree code has keyspace scanning functions that online fsck uses to
+cross reference one structure with another.
+Specifically, they can scan the key space of an index to determine if that
+keyspace is fully, sparsely, or not at all mapped to records.
+For the reverse mapping btree, it is possible to mask parts of the key for the
+purposes of performing a keyspace scan.
+This enables us to decide if the rmap btree contains records mapping a certain
+amount of physical space regardless of the actual owners.
+
+Space allocation records are cross-referenced as follows:
+
+1. Any space mentioned by any metadata structure are cross-referenced as
+   follows:
+
+   - Does the reverse mapping index list only the appropriate owner as the
+     owner of each block?
+   - Are none of the blocks claimed as free space?
+   - If these aren't file data blocks, are none of the blocks claimed as space
+     shared by different owners?
+
+2. Btree blocks are cross-referenced as follows:
+
+   - Everything in class 1 above.
+   - If there's a parent node block, do the keys listed for this block match the
+     keyspace of this block?
+   - Do the sibling pointers point to valid blocks?  Of the same level?
+   - Do the child pointers point to valid blocks?  Of the next level down?
+
+3. Free space btree records are cross-referenced as follows:
+
+   - Everything in class 1 and 2 above.
+   - Does the reverse mapping index list no owners of this space?
+   - Is this space not claimed by the inode index for inodes?
+   - Is it not mentioned by the reference count index?
+   - Is there a matching record in the other free space btree?
+
+4. Inode btree records are cross-referenced as follows:
+
+   - Everything in class 1 and 2 above.
+   - Is there a matching record in free inode btree?
+   - Do inodes outside of the holemask correspond with inode clusters?
+   - Do inodes in the freemask correspond with inode records with zero link
+     count?
+
+5. Inode records are cross-referenced as follows:
+
+   - Everything in class 1.
+   - Do all the fields that summarize information about the file forks actually
+     match those forks?
+   - Does each inode with zero link count correspond to a record in the free
+     inode btree?
+
+6. File fork space mapping records are cross-referenced as follows:
+
+   - Everything in class 1 and 2 above.
+   - Is this space not mentioned by the inode btrees?
+   - If this is a CoW fork mapping, does it correspond to a CoW entry in the
+     reference count btree?
+
+7. Reference count records are cross-referenced as follows:
+
+   - Everything in class 1 and 2 above.
+   - Within the space subkeyspace of the rmap btree (that is to say, all
+     records mapped to a particular space extent and ignoring the owner info),
+     can we find the same number of records for each block as the listed
+     reference count?
+
+Proposed patchsets are the series to find gaps in
+`refcount
+<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=scrub-detect-refcount-gaps>`_,
+`inode
+<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=scrub-detect-inobt-gaps>`_, and
+`rmap
+<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=scrub-detect-rmapbt-gaps>`_ records;
+to find
+`mergeable records
+<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=scrub-detect-mergeable-records>`_;
+and to
+`improve cross referencing with rmap
+<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=scrub-strengthen-rmap-checking>`_
+before starting a repair.
+
+Cross-Referencing Directory Entries
+```````````````````````````````````
+
+The filesystem directory tree is, like any tree, a directed acylic graph
+structure.
+Each directory contains a number of directory entries which associate a name
+with an inode number.
+Directory entries can be cross-referenced as follows:
+
+- Is the inode number valid?
+- Does it point to an inode with nonzero link count?
+- Does the entry's file type match the file mode?
+- If the child is a subdirectory, does its dotdot pointer point back to the
+  parent?
+
+Checking operations involving :ref:`parents <dirparent>` and
+:ref:`file link counts <nlinks>` are discussed in more detail in later
+sections.
+
+Cross-Referencing Summary Counters
+``````````````````````````````````
+
+XFS maintains three classes of summary counters: available resources, quota
+resource usage, and file link counts.
+
+In theory, the amount of available resources (data blocks, inodes, realtime
+extents) can be found by walking the entire filesystem.
+This would make for very slow reporting, so a transactional filesystem can
+maintain summaries of this information in the superblock.
+Cross-referencing these values against the filesystem metadata should be a
+simple matter of walking the free space and inode metadata in each AG and the
+realtime bitmap, but there are complications that will be discussed in
+:ref:`more detail <fscounters>` later.
+
+:ref:`Quota usage <quotacheck>` and :ref:`file link count <nlinks>`
+checking are sufficiently complicated that they get their own sections.
+
+Post-Repair Reverification
+``````````````````````````
+
+After performing a repair, the checking code is run a second time to validate
+the new structure, and the results of the health assessment are recorded
+internally and returned to the calling process.
+This step is critical for enabling system administrator to monitor the status
+of the filesystem and the progress of any repairs.
+For developers, it is a useful means to judge the efficacy of error detection
+and correction in the online and offline checking tools.
+
+Eventual Consistency vs. Online Fsck
+------------------------------------
+
+Midway through the development of online scrubbing, misinteractions were
+observed between online fsck and compound transaction chains created by other
+writer threads that resulted in false reports of metadata inconsistency.
+The root cause of these reports is the eventual consistency model introduced by
+the expansion of deferred work items and compound transaction chains when
+reverse mapping and reflink were introduced.
+
+Originally, transaction chains were added to XFS to avoid deadlocks when
+unmapping space from files.
+Deadlock avoidance rules require that AGs only be locked in increasing order,
+which makes it impossible (say) to free a space extent in AG 7 and then try to
+free a now superfluous block mapping btree block in AG 3.
+To avoid these kinds of deadlocks, XFS creates Extent Freeing Intent (EFI) log
+items so that we can commit to freeing some space in one transaction and put
+off making the actual metadata updates to a fresh transaction.
+The transaction sequence looks like this:
+
+1. The first transaction contains a physical update to the file's block mapping
+   structures to remove the mapping from the btree blocks.
+   It then attaches to the in-memory transaction an action item (``struct
+   xfs_defer_pending``) to schedule deferred freeing of space.
+   Returning to the example above, the action item tracks the freeing of both
+   the unmapped space from AG 7 and the block mapping btree (BMBT) block from
+   AG 3.
+   Deferred frees recorded in this manner are committed in the log by creating
+   an EFI log item from the action item, and attaching the log item to the
+   transaction.
+   When the log is persisted to disk, the EFI item is written into the ondisk
+   transaction record.
+   EFIs can list up to 16 extents to free, all sorted in AG order.
+
+2. The second transaction contains a physical update to the free space btrees
+   of AG 7 to release the unmapped file space and a second physical update to
+   the free space btrees of AG 3 to release the former BMBT block.
+   Attached to the transaction is a an extent free done (EFD) log item.
+   The EFD contains a pointer to the EFI logged in transaction #1 so that log
+   recovery can tell if the EFI needs to be replayed.
+
+If the system goes down after transaction #1 is written back to the filesystem
+but before #2 is committed, a scan of the filesystem metadata would show
+inconsistent filesystem metadata because there would not appear to be any owner
+of the unmapped space.
+Happily, this inconsistency is also resolved by log recovery -- if it recovers
+an intent log item but does not recover a corresponding intent done log item,
+it will replay the unfinished intent item.
+In the example above, the log must replay both frees described in the recovered
+EFI to complete the recovery phase.
+
+There are two subtleties to XFS' transaction chaining strategy to consider.
+The first is that log items must be added to a transaction in the correct order
+to prevent conflicts with principal objects that are not held by the
+transaction.
+In other words, all per-AG metadata updates for an unmapped block must be
+completed before the last update to free the extent.
+The second subtlety to consider is the fact that AG header buffers are
+(usually) released between each transaction in a chain.
+This means that other threads can observe an AG in an intermediate state,
+but as long as the first subtlety is handled, this should not affect the
+correctness of filesystem operations.
+Unmounting the filesystem flushes all pending work to disk, which means that
+offline fsck never sees the temporary inconsistencies caused by deferred work
+item processing.
+In this manner, XFS employs a form of eventual consistency to avoid deadlocks
+and increase parallelism.
+
+When the reverse mapping and reflink features were under development, it was
+deemed impractical to try to cram all the reverse mapping updates into a single
+transaction because a single file mapping operation can explode into many
+small updates:
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
+For copy-on-write updates this is even worse, because we have to do this once
+to remove the space from the staging area, and again to map it into the file!
+
+To deal with this explosion in a calm manner, XFS expanded its use of deferred
+work items to most reverse mapping updates and all refcount updates.
+This reduces the worst case size of transaction reservations by breaking the
+work into a long chain of small updates, which increases the degree of eventual
+consistency in the system.
+Again, this generally isn't a problem because we order the deferred work items
+carefully to avoid conflicts between owners.
+
+However, online fsck changes the rules -- remember that although physical
+updates to per-AG structures are coordinated by locking the buffers for AG
+headers, buffer locks are dropped between transactions.
+Once scrub acquires resources and takes locks for a data structure, it must do
+all the validation work without releasing the lock.
+If the lock for a structure is an AG header buffer lock, scrub may have
+interrupted another thread that is midway through finishing a chain.
+For example, if the writer thread has completed a reverse mapping update but
+not the corresponding refcount update, the two AG btrees will appear
+inconsistent to scrub and an observation of corruption will be recorded.
+This observation will not be correct.
+If a repair is attempted in this state, the results will be catastrophic!
+
+Three solutions to this problem were evaluated upon discovery of this flaw:
+
+1. Add a higher level lock to allocation groups and require writer threads to
+   acquire the higher level lock in AG order.
+   This would be very difficult to implement in practice because we don't
+   always know ahead of time which locks we need to grab.
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
+3. Recognize that only online fsck has this requirement of total consistency
+   of AG metadata, and that online fsck should be relatively rare as compared
+   to file operations.
+   For each AG, maintain a sloppy count of intent items targetting that AG.
+   When online fsck wants to examine an AG, it should lock the AG header
+   buffers to quiesce all transaction chains that want to modify that AG, and
+   only proceed with the scrub if the count is zero.
+   In other words, scrub only proceeds if it can lock the AG header buffers and
+   there can't possibly be any intents in progress.
+
+The third solution has been implemented in the current iteration of online
+fsck, with percpu counters implementing the "sloppy" counter.
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
+The second property of the drain is key to the correct coordination of scrub.
+
+The scrub drain works as follows:
+
+1. Grab the per-AG structure for the AG.
+2. Lock the AGI and AGF header buffers.
+3. If the per-AG intent counter to zero, we know there are no chains in
+   progress and we are good to go.
+4. Otherwise, release the AGI and AGF header buffers.
+5. Wait for the intent counter to reach zero, then go to step 2.
+
+To avoid polling in step 5, the drain provides a waitqueue for scrub threads to
+be woken up whenever the intent count drops.
+On architectures that support it, jump labels (aka dynamic code patching)
+reduces the overhead of the drain waitqueue to nearly zero when scrub is not in
+use.
+
+The proposed patchset is the
+`scrub intent drain series
+<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=scrub-drain-intents>`_.
+
+.. _xfile:
+
+Pageable Kernel Memory
+----------------------
+
+Demonstrations of early prototypes of online repair awoke the XFS community to
+two new technical requirements that were not originally identified.
+In the first iteration of online repair, the code walked whatever filesystem
+metadata it needed to synthesize new records, and inserted records into a new
+btree as it found them.
+This was obviously subpar since any additional corruption or runtime errors
+encountered during the walk would shut down the filesystem.
+After remount, the blocks containing the half-rebuilt data structure would not
+be accessible until another repair was attempted.
+Solving the problem of half-rebuilt data structures will be discussed in the
+next section.
+
+For the second iteration, the synthesized records were instead stored in kernel
+slab memory.
+Doing so enabled online repair to abort without writing to the filesystem if
+the metadata walk failed, which prevented online fsck from making things worse.
+
+Three unfortunate qualities of kernel memory management make it unsuitable for
+this purpose.
+First, although it is tempting to allocate a contiguous block of memory to
+create a C array, this cannot easily be done in the kernel because it cannot be
+relied upon to allocate multiple contiguous memory pages.
+Second, although disparate physical pages can be virtually mapped together,
+installed memory might still not be large enough to stage the entire record set
+in memory while constructing a new btree.
+In response to these two considerations, the implementation was adjusted to use
+doubly linked lists, which means every record requires two 64-bit list head
+pointers, which is a lot of overhead.
+Even this was subpar because of the third unfortunate quality -- kernel memory
+is pinned, which can drive the system out of memory, leading to OOM kills of
+unrelated processes.
+
+For the third iteration, attention swung back to the possibility of using
+byte-indexed array-like storage to reduce the overhead of in-memory records.
+At any given time, online repair does not need to keep the entire record set in
+memory, which means that individual records can be paged out.
+Creating new temporary files in the XFS filesystem to store intermediate data
+was explored and partially rejected because a filesystem with compromised space
+and inode metadata should never be used to fix compromised space or inode
+metadata.
+However, the kernel already has a facility for byte-addressable and pageable
+storage: shmemfs.
+In-kernel graphics drivers (most notably i915) take advantage of shmemfs files
+to store intermediate data that doesn't need to be completely in memory, so
+that usage precedent is already established.
+Hence, the ``xfile`` was born!
+
+A survey of the intended uses of xfiles suggested these use cases:
+
+1. Storing arrays of fixed-sized records (space management btrees)
+2. Storing large binary objects (blobs) of variable sizes (directory and
+   extended attribute repairs)
+3. Storing sparse arrays of fixed-sized records (quotas, realtime metadata, and
+   link counts)
+4. Staging btrees in memory (reverse mapping btrees)
+
+For security and performance reasons, the shmem files created by XFS must be
+owned privately by the repair code.
+This means that they are never installed in the file descriptor table, nor can
+the xfile's memory pages be mapped into userspace processes.
+If the shmem file is shared between threads to stage repairs, the online fsck
+code must provide its own locks to coordinate access.
+shmem file pages can only be mapped into the kernel for brief periods of time
+because the kernel address space is limited and pinned backing pages cannot be
+written to swap.
+
+.. _xfarray:
+
+Arrays of Fixed-Sized Records
+`````````````````````````````
+
+In XFS, each type of indexed space metadata (free space, inodes, reference
+counts, file fork space, and reverse mappings) consists of a set of fixed-size
+records indexed with a classic B+ tree.
+During a repair, scrub needs to stage new records during the gathering step and
+retrieve them during the btree building step.
+A simple load/store interface satisfies this requirement.
+Ultimately, records must be stored in sorted order in btree leaf blocks.
+Hence it is necessary to sort the staged records before bulk writing them into
+a new ondisk btree.
+To stage these records, the ``xfarray`` abstraction was born; it is created
+as a linear byte array atop an xfile.
+
+The proposed patchset is the
+`big in-memory array
+<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=big-array>`_.
+
+Pagecache and Inode Locking
+^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Loads and stores of array elements are conceptually similar to what
+``pread(2)`` and ``pwrite(2)`` can do in userspace.
+However, this is not quite how xfile accesses actually work.
+Recall the statement that every file is privately owned by the online repair
+worker that created it, and online fsck is expected to coordinate access
+explicitly.
+The xfile code directly calls ``pagecache_write_{begin,end}`` when storing
+records, to ensure that the pagecache state is maintained properly.
+It directly calls ``shmem_read_mapping_page_gfp`` when reading records to avoid
+dealing with the internal structure of shmemfs.
+In other words, xfiles ignore the VFS read and write code paths to avoid
+having to create a dummy ``struct kiocb`` and to avoid taking inode locks.
+
+Sorting
+^^^^^^^
+
+During the next iteration after the creation of the xfarray, a community
+reviewer remarked that for performance reasons, online repair ought to load
+batches of records into btree record blocks instead of inserting records into a
+new btree one at a time.
+The btree insertion code in XFS is responsible for maintaining correct ordering
+of the records, so naturally the xfarray must also support sorting the record
+set prior to bulk loading.
+
+The sorting algorithm used in the xfarray is actually a combination of adaptive
+quicksort and heapsort subalgorithms in spirit of
+`Sedgewick <https://algs4.cs.princeton.edu/23quicksort/>`_ and
+`pdqsort <https://github.com/orlp/pdqsort>`_, with refinements for the Linux
+kernel.
+To sort records in a reasonably short amount of time, we want to take advantage
+of the binary subpartitioning offered by quicksort, but we also use heapsort
+to hedge aginst performance collapse if the chosen quicksort pivots are poor.
+Both algorithms are (in theory) O(n * lg(n)).
+
+The kernel already contains a reasonably performant implementation of heapsort.
+It only operates on regular C arrays, which limits the scope of its usefulness.
+There are two key places where the xfarray uses it:
+
+* Sorting any record subset backed by a single xfile page.
+* Loading a small number of xfarray records from potentially disparate parts
+  of the xfarray into a memory buffer, and sorting the buffer.
+
+In other words, heapsort is used to constrain the nested recursion of
+quicksort, which is how we mitigate quicksort's worst runtime behavior.
+
+Choosing a quicksort pivot is known to be tricky business.
+A good pivot would split the set to sort in half, leading to the O(n * lg(n))
+divide and conquer behavior that is crucial to performance.
+A poor pivot barely splits the subset at all, leading to O(n ^ 2) performance.
+The xfarray sort routine tries to avoid picking a bad pivot by sampling nine
+records into a memory buffer and using the kernel heapsort to identify the
+median of the nine.
+
+Most modern quicksort implementations employ Tukey's "ninther" to select a
+pivot from a memory-backed array.
+Typical ninther implementations pick three unique triads of records, sort each
+of the triads, and then sort the middle value of each triad to determine the
+ninther value.
+As stated previously, however, xfile accesses are not entirely cheap.
+It turned out to be much more performant to read the nine elements into a
+memory buffer, run the kernel's in-memory heapsort on the buffer, and choose
+the 4th element of that buffer as the pivot.
+Tukey's ninthers are described in J. W. Tukey, `The ninther, a technique for
+low-effort robust (resistant) location in large samples`, in *Contributions to
+Survey Sampling and Applied Statistics*, edited by H. David, (Academic Press,
+1978), pp. 251 –257.
+
+The partitioning of quicksort is fairly textbook -- rearrange the record
+subset around the pivot, then set up the current and next stack frames to
+sort with the larger and the smaller halves of the pivot, respectively.
+This keeps the stack space requirements to log2(record count).
+
+As a final performance optimization, the hi and lo scanning phase of quicksort
+keeps examined xfile pages mapped in the kernel for as long as possible to
+reduce map/unmap cycles.
+Surprisingly, this reduces overall sort runtime by nearly half again after
+accounting for the application of heapsort directly onto xfile pages.
+
+Blob Storage
+````````````
+
+Extended attributes and directories add an additional requirement for staging
+records: arbitrary byte sequences of finite length.
+Directory entries associate a name with a file, and extended attributes
+implement a key-value store.
+The names, keys, and values can also be staged in an xfile with the same loads
+and store technique as the xfarray, so the ``xfblob`` abstraction was created
+to simplify things.
+
+The details of repairing directories and extended attributes will be discussed
+in a subsequent section about atomic extent swapping.
+Sorting is not supported for blobs, since the store interface takes the input
+blob and returns a cookie that can be used to retrieve the blob.
+No deduplication is performed, but callers can discard all blobs.
+
+The proposed patchset is at the start of the
+`extended attribute repair
+<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=repair-xattrs>`_
+series.
+
+Sparse Arrays of Fixed-Size Records
+```````````````````````````````````
+
+Sparse arrays are nearly the same as regular arrays, except for the expectation
+that there may be long sequences of zeroed areas between written records.
+The zeroed areas can be written that way explicitly, or they can be unpopulated
+areas of the xfile mapping.
+To iterate the non-null records of a sparse xfarray, a special load function
+uses ``SEEK_DATA`` to skip areas of the array that are not populated with
+memory pages.
+
+Bulk Loading of B+Trees
+-----------------------
+
+As mentioned previously, early iterations of online repair built new btree
+structures by creating a new btree and adding staged records individually.
+Loading a btree one record at a time had a slight advantage of not requiring
+the incore records to be sorted prior to commit.
+Unfortunately, adding records with a separate transaction chain for each
+record is very slow.
+Moreover, the lack of log support meant that the old btree blocks would leak if
+the repair succeeded but the system went down afterwards.
+Furthermore, the new btree blocks would leak if the system went down before
+committing the repair.
+Loading records one at a time also meant that we cannot control the loading
+factor of the blocks in the new btree.
+
+Fortunately, the venerable ``xfs_repair`` tool had a more efficient means for
+rebuilding a btree index from a collection of records -- bulk btree loading.
+Darrick studied the existing code, took notes on how it worked, built a new
+generic implementation, and ported offline repair to use it.
+Those notes in turn have been refreshed and are presented here.
+
+Geometry Computation
+````````````````````
+
+The first step of bulk loading is to compute the shape of the btree from the
+record set, the type of btree, and any load factor preferences.
+First and foremost, we must establish the minimum and maximum records that will
+fit in a leaf block from the size of each btree block and the block header.
+Roughly speaking, the maximum number of records is::
+
+        maxrecs = (block_size - header_size) / record_size
+
+The XFS design specifies that btree blocks should be merged when possible,
+which means the minimum number of records is half of maxrecs::
+
+        minrecs = maxrecs / 2
+
+The next variable to determine is the desired loading factor.
+This must be at least minrecs and no more than maxrecs.
+Choosing minrecs is undesirable because it wastes half the block.
+Choosing maxrecs is also undesirable because adding a single record to each
+newly rebuilt leaf block will cause a tree split, which causes a noticeable
+drop in performance immediately afterwards.
+The default loading factor was chosen to be 75% of maxrecs, which provides a
+reasonably compact structure without any immediate split penalties.
+If space is tight, the loading factor will be set to maxrecs to try to avoid
+running out of space::
+
+        leaf_load_factor = enough space ? (maxrecs + minrecs) / 2 : maxrecs
+
+Load factor is computed for btree node blocks using the combined size of the
+btree key and pointer as the record size::
+
+        maxrecs = (block_size - header_size) / (key_size + ptr_size)
+        minrecs = maxrecs / 2
+        node_load_factor = enough space ? (maxrecs + minrecs) / 2 : maxrecs
+
+Once that's done, the number of leaf blocks required to store the record set
+can be computed as::
+
+        leaf_blocks = ceil(record_count / leaf_load_factor)
+
+The number of node blocks needed to point to the next level down in the tree
+is computed as::
+
+        n_blocks = (n == 0 ? leaf_blocks : node_blocks[n])
+        node_blocks[n + 1] = ceil(n_blocks / node_load_factor)
+
+This computation is performed recursively until the current level only needs
+one block.
+At that point we've reached the tree root, and we know the height of the new
+tree.
+The number of blocks needed for the new tree is the summation of the number of
+blocks per level.
+
+.. _newbt:
+
+Reserving New B+Tree Blocks
+```````````````````````````
+
+Once we know the number of blocks that we need for the new btree, we need to
+allocate those blocks from the free space extents.
+Each reserved extent is tracked separately by the btree builder state data.
+To improve crash resilience, we also log an Extent Freeing Intent (EFI) item in
+the same transaction as the space allocation and attach it to reservation.
+If the system goes down, log recovery will find the EFIs and put them back in
+the free space, effectively leaving the filesystem untouched.
+
+Each time we claim a block for the btree from a reserved extent, we update the
+reservation to reflect the claimed space.
+When we've written the new data structure to disk and are ready to commit to
+the new structure, we walk the reservation list and log Extent Freeing Done
+(EFD) items to mark the end of the construction phase.
+Unclaimed reservations are converted to regular deferred extent free work
+to be freed after the new structure is committed.
+The EFDs logged to the committing transaction must not overrun it.
+For that reason, it is assumed that the buffer update committing the new
+data structure will be small and the only non-intent item attached to the
+transaction.
+Block reservation tries to allocate as much contiguous space as possible to
+reduce the number of EFIs in play.
+
+While repair is writing these new btree blocks, the EFIs created for the space
+reservations pin the tail of the log.
+It's possible that other parts of the system will remain busy and push the head
+of the log towards the pinned tail.
+To avoid livelocking the filesystem, the EFIs cannot pin the tail of the log
+for too long.
+To alleviate this problem, the dynamic relogging capability of the deferred ops
+mechanism is reused here to commit a transaction at the log head containing an
+EFD for the old EFI and new EFI at the head.
+This enables the log to release the old EFI to keep the log moving forwards.
+
+EFIs have a role to play during the commit phase; please see the section about
+:ref:`Reaping Old Metadata Blocks <reaping>` for more details.
+
+Proposed patchsets are the
+`bitmap rework
+<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=repair-bitmap-rework>`_
+and the
+`preparation for bulk loading btrees
+<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=repair-prep-for-bulk-loading>`_.
+
+
+Writing the New Tree
+````````````````````
+
+This part is pretty simple -- the btree builder claims a block from the
+reserved list, writes the new btree block header, fills the rest of the block
+with records, and add the block to a list of written blocks.
+Sibling pointers are set every time a new block is added to the level.
+When we've finished writing the record blocks, we move on to the nodes.
+To fill a node block, we walk each block in the next level down in the tree
+computing the relevant keys and writing them into the node.
+When we've reached the root level, we're ready to commit the new btree!
+
+To commit the new btree, we write the btree blocks to disk synchronously.
+This is a little complicated because a new btree block could have been freed
+recently, so we must be careful to remove the (stale) buffer from the AIL list
+before we can write the new blocks to disk.
+Once the new blocks have been persisted, we log the location of the new root to
+a transaction, and commit the transaction to cement the new btree into the
+filesystem.
+Repair them moves on to reaping the old blocks, which will be discussed after
+a few case studies.
+
+Case Study: Rebuilding the Inode Index
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+The inode btree maps inode numbers to the ondisk location of the associated
+inode records.
+This is space usage information, which means that we can rebuild the inode
+btrees from the reverse mapping information.
+Each reverse mapping record with an owner of ``XFS_RMAP_OWN_INODES`` should
+tell us the location of at least one inode cluster buffer.
+A cluster is the smallest number of ondisk inodes that can be allocated or
+freed in a single transaction; it is never smaller than 1 fs block or 4 inodes.
+
+For each inode space allocation, first ensure that there are no records in the
+free space btrees nor any records in the reference count btree.
+If there are, the space metadata inconsistencies are reason enough to abort the
+operation.
+Otherwise, read each cluster buffer to check that its contents appear to be
+ondisk inodes and to decide if the file is allocated (``i_mode != 0``) or free
+(``i_mode == 0``).
+Accumulate the results of successive inode cluster buffer reads until we have
+enough to fill a single inode chunk, which is 64 consecutive numbers in the
+inode number keyspace.
+If the chunk is sparse, the chunk record may include holes.
+Once we have accumulated one chunk's worth of data, we store the inode btree
+record in the xfarray for the inode btree.
+The free inode btree is only populated with records for chunks that have free
+non-sparse inodes.
+The number of records for the inode btree is the number of xfarray records,
+but the record count for the free inode btree has to be computed as we add
+xfarray entries.
+
+Now that we know the number of records to store in each inode btree, compute
+the geometry of the new btrees, allocate blocks to store the btree, and flush
+them to disk.
+When the new btrees have been persisted, commit the new btree root locations to
+the AGI buffer and move on to reaping the old btree blocks.
+The old btree blocks occupy the space the reverse mapping index describes as
+being owned by ``XFS_RMAP_OWN_INOBT`` but cannot be found by visiting each
+block in the new inode btrees.
+
+The proposed patchset is the
+`AG btree repair
+<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=repair-ag-btrees>`_
+series.
+
+Case Study: Rebuilding the Space Reference Counts
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+This algorithm is also described in the code for ``xfs_repair``, since the
+implementations are similar.
+
+Reverse mapping records are used to rebuild the reference count information.
+Reference counts are required for correct operation of copy on write for shared
+file data.
+Imagine the reverse mapping entries as rectangles representing extents of
+physical blocks, and that the rectangles can be laid down to allow them to
+overlap each other.
+Then we know that we must have a reference count record starting and ending
+wherever the height of the stack changes.
+In other words, the record emission stimulus is level-triggered::
+
+                        -    ---
+              --      ----- ----   ---        ------
+        --   ----     ----------- ----     ---------
+        -------------------------------- -----------
+        ^ ^  ^^ ^^    ^ ^^ ^^^  ^^^^  ^ ^^ ^  ^     ^
+        2 1  23 21    3 43 234  2123  1 01 2  3     0
+
+Note that in the actual reference count btree we don't store the refcount == 0
+cases because the free space btree tells us which blocks are free.
+Extents being used to stage copy-on-write operations should be the only records
+with refcount == 1.
+Single-owner file blocks aren't recorded in either the free space or the
+reference count btrees.
+
+Given the reverse mapping btree, which orders records by physical block number,
+a starting physical block (``sp``), a bag-like data structure to hold mappings
+that cover ``sp``, and the next physical block where the level changes
+(``np``), we can reconstruct the reference count information as follows:
+
+While there are still unprocessed mappings in the reverse mapping btree:
+
+1. Set ``sp`` to the physical block of the next unprocessed reverse mapping
+   record.
+
+2. Add to the bag all the reverse mappings where ``rm_startblock`` == ``sp``.
+
+3. Set ``np`` to the physical block where the bag size will change.
+   This is the minimum of (``rm_startblock`` of the next unprocessed mapping)
+   and (``rm_startblock`` + ``rm_blockcount`` of each mapping in the bag).
+
+4. Record the bag size as ``old_bag_size``.
+
+5. While the bag isn't empty,
+
+   a. Remove from the bag all mappings where ``rm_startblock`` +
+      ``rm_blockcount`` == ``np``.
+
+   b. Add to the bag all reverse mappings where ``rm_startblock`` == ``np``.
+
+   c. If the bag size isn't ``old_bag_size``, store the refcount record
+      ``(sp, np - sp, bag_size)`` in the refcount xfarray.
+
+   d. If the bag is empty, break out of this inner loop.
+
+   e. Set ``old_bag_size`` to ``bag_size``.
+
+   f. Set ``sp`` = ``np``.
+
+   g. Set ``np`` to the physical block where the bag size will change.
+      Go to step 3 above.
+
+6. Reference count records should be added for all reverse mappings with an
+   owner of ``XFS_RMAP_OWN_COW`` because they represent space extents that are
+   in use to stage copy on write operations.
+
+Like the other btree repair functions, we store the new refcount records in an
+xfarray and use the btree bulk loading code to persist and commit a new tree.
+The old btree blocks occupy the space the the reverse mapping index describes
+as being owned by ``XFS_RMAP_OWN_REFC`` but cannot be found by visiting each
+block in the new refcount btree.
+
+The proposed patchset is the
+`AG btree repair
+<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=repair-ag-btrees>`_
+series.
+
+Case Study: Rebuilding File Fork Mapping Indices
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Rebuilding the data or attribute forks of a file is straightforward if the
+fork is in extents or block mapping btree (BMBT) format.
+The reverse mapping records of each AG are traversed to find all the space
+mapped to that file fork.
+Once the collected records are sorted in file offset order, the btree bulk
+loading code is used to reserve blocks for the new btree, write them to disk,
+and atomically commit the new structure into the inode.
+
+There are two minor complications here:
+First, it's possible to move the fork offset to adjust the sizes of the
+immediate areas if the data and attr forks are not both in BMBT format.
+Second, if there are sufficiently few fork mappings, it may be possible to use
+EXTENTS format instead of BMBT.
+
+The old btree blocks are found by computing the bitmap of all records for that
+file fork that also have the ``XFS_RMAP_BMBT_BLOCK`` flag set, and subtracting
+the blocks in the new bmap btree.
+The resulting blocks are passed to the reaping mechanism for disposal.
+
+The proposed patchset is the
+`inode repair
+<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=repair-inodes>`_
+series.
+
+.. _reaping:
+
+Reaping Old Metadata Blocks
+---------------------------
+
+Whenever we build a new data structure to replace one that is suspect, the
+question arises of how to dispose of the blocks that allegedly belonged to the
+old structure.
+The laziest method of course is not to deal with them at all, but this slowly
+leads to service degradations as space leaks out of the filesystem.
+If we're fortunate, someone will schedule a rebuild of the free space
+information, which will plug all those leaks.
+Freeing all of the blocks that we *think* composed an old data structure is
+naïve, because there may be other data structures that also think they own some
+of those blocks (e.g. crosslinked trees).
+Permitting the block allocator to hand them out again will not push the system
+towards consistency.
+
+Instead, online repair uses the reverse mapping index to discover which subset
+of the reap candidate extents are not claimed by anything else in the
+filesystem and frees only those that have no other owners.
+
+For space metadata, the process of finding extents to dispose of generally
+follows this format:
+
+1. Create a bitmap of space used by data structures that we want to preserve.
+   Generally, this is the new structure that is being built, and we can reuse
+   the space reservation data from when we wrote the new object.
+
+2. Survey the reverse mapping data to create a bitmap of space owned by the
+   same ``XFS_RMAP_OWN_*`` number for the metadata that is being preserved.
+
+3. Use the bitmap disunion operator to subtract (1) from (2).
+   The remaining set bits represent extents that could be freed.
+   The process moves on to step 4 below.
+
+Repairs for file-based metadata such as extended attributes, directories,
+symbolic links, quota files and realtime bitmaps are performed by building a
+new structure attached to a temporary file and swapping the forks.
+Afterward, the mappings in the old file fork are the candidate blocks for
+disposal.
+
+The process for disposing of old extents is as follows:
+
+4. For each extent in the candidate list, count the number of reverse mapping
+   records for the first block in that extent that do not have the same rmap
+   owner for the data structure being repaired.
+
+   - If zero, the block has a single owner and can be freed.
+   - If not, the block is part of a crosslinked structure and must not be
+     freed.
+
+5. Starting with the next block in the extent, figure out how many more blocks
+   have the same zero/nonzero other owner status as that first block.
+
+6. If the region is crosslinked, delete the reverse mapping entry for the
+   structure being repaired and move on to the next region.
+
+7. If the region is to be freed, mark any corresponding buffers in the buffer
+   cache as stale to prevent log writeback.
+
+8. Free the region and move on.
+
+There are two complications to this procedure.
+Transactions are of finite size, so we must be careful to roll the transactions
+used during the reaping process to avoid overruns.
+Overruns come from two sources:
+
+a. EFIs logged on behalf of space that we're freeing,
+b. Log items for buffer invalidations.
+
+To avoid overruns, repair rolls the transaction when it perceives that the
+transaction reservation is nearly exhausted, and resumes logging updates with
+the new transaction.
+This introduces a window in which a crash during the reaping process can leak
+blocks.
+
+The proposed patchset is the
+`preparation for bulk loading btrees
+<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=repair-prep-for-bulk-loading>`_
+series.
+
+Case Study: Reaping After a Regular Btree Repair
+````````````````````````````````````````````````
+
+Old reference count and inode btrees are the easiest to reap because they have
+rmap records with special owner codes: ``XFS_RMAP_OWN_REFC`` for the refcount
+btree, and ``XFS_RMAP_OWN_INOBT`` for the inode and free inode btrees.
+Creating a list of extents to reap that we think are the old btree blocks is
+quite simple, conceptually:
+
+1. Lock the relevant AGI/AGF header buffers to prevent allocation and frees.
+2. For each reverse mapping record with an rmap owner that interests us, set
+   the corresponding range in a bitmap.
+3. Walk the current data structures that have the same rmap owner.
+   For each block visited, clear that range in the above bitmap.
+4. Each set bit in the bitmap represents a block that could be a block from the
+   old data structures and hence is a candidate for reaping.
+   In other words, ``(rmap_records_owned_by & ~blocks_reachable_by_walk)``.
+   The disunion operation will appear throughout these case studies.
+
+If it is possible to maintain the AGF lock throughout the repair (which is the
+common case), then step 2 can be performed at the same time as the reverse
+mapping record walk that creates the records for the new btree.
+
+Case Study: Rebuilding the Free Space Indices
+`````````````````````````````````````````````
+
+Repairing the free space btrees has three key complications over a regular
+btree repair.
+The first complication is that free space is not explicitly tracked in the
+reverse mapping records.
+Hence, the new free space records must be inferred from gaps in the physical
+space component of the keyspace of the reverse mapping btree.
+
+The second complication is much more serious: we can't use the common btree
+reservation code.
+Most btree repair functions assume the free space btrees are consistent, so
+they share the common code described in the section about
+:ref:`reserving new btree blocks <newbt>` to allocate new blocks and use
+bespoke EFIs to ensure that log recovery will free the blocks if the repair
+fails to commit the new btree root.
+This is obviously impossible when repairing the free space btrees themselves.
+However, repair holds the AGF buffer lock for the duration of the free space
+index reconstruction, so it can use the collected free space information to
+supply the blocks for the new free space btrees.
+It is not necessary to back each reserved extent with an EFI because we're
+building the new btrees in what the ondisk filesystem thinks is free space.
+However, if reserving blocks for the new btrees from the collected free space
+information changes the number of free space records, repair must re-estimate
+the new free space btree geometry with the new record count until the
+reservation is sufficient.
+As part of committing the new btrees, we must ensure that reverse mappings
+are created for the reserved blocks that we used and that unused reserved
+blocks are inserted into the free space btrees.
+Deferrred rmap and freeing operations are used to ensure that this transition
+is atomic.
+
+Finding the blocks to reap after the repair is the third complication.
+Blocks for the free space btrees and the reverse mapping btrees are supplied by
+the AGFL.
+Blocks put onto the AGFL have reverse mapping records with the owner
+``XFS_RMAP_OWN_AG``.
+This ownership is retained when blocks move from the AGFL into the free space
+btrees or the reverse mapping btrees.
+When we are walking reverse mapping records to synthesize free space records,
+we also take notice of the ``XFS_RMAP_OWN_AG`` records and set the
+corresponding bits in a bitmap (``ag_owner_bitmap``).
+We also maintain a second bitmap in which we set the bits corresponding to the
+rmap btree blocks and the AGFL blocks (``rmap_agfl_bitmap``).
+When the walk is complete, the bitmap disunion operation ``(ag_owner_bitmap &
+~rmap_agfl_bitmap)`` is used to identify the extents that we think are used by
+the old free space btrees.
+These blocks can then be reaped using the methods outlined above.
+
+The proposed patchset is the
+`AG btree repair
+<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=repair-ag-btrees>`_
+series.
+
+.. _rmap_reap:
+
+Case Study: Reaping After Repairing Reverse Mapping Btrees
+``````````````````````````````````````````````````````````
+
+Old reverse mapping btrees are less difficult to reap after a repair.
+As mentioned in the previous section, blocks on the AGFL, the two free space
+btree blocks, and the reverse mapping btree blocks all have reverse mapping
+records with ``XFS_RMAP_OWN_AG`` as the owner.
+The full process of gathering reverse mapping records and building a new btree
+are described in the case study of
+:ref:`live rebuilds of rmap data <rmap_repair>`, but a crucial point from that
+discussion is that the new rmap btree will not contain any records for the old
+rmap btree, nor should the old btree blocks be tracked in the free space
+btrees.
+The list of candidate reaping blocks is computed by setting the bits
+corresponding to the gaps in the new rmap btree records, and then clearing the
+bits corresponding to extents in the free space btrees.
+The result ``(new_rmapbt_gaps & ~bnobt_records)`` are reaped using the methods
+outlined above.
+
+The proposed patchset is the
+`AG btree repair
+<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=repair-ag-btrees>`_
+series.
+
+Case Study: Rebuilding the AGFL
+```````````````````````````````
+
+The allocation group free block list (AGFL) is repaired as follows:
+
+1. Create a bitmap for all the space that the reverse mapping data claims is
+   owned by ``XFS_RMAP_OWN_AG``.
+2. Subtract the space used by the two free space btrees and the rmap btree.
+3. Subtract any space that the reverse mapping data claims is owned by any
+   other owner, to avoid re-adding crosslinked blocks to the AGFL.
+4. Once the AGFL is full, reap any blocks leftover.
+5. The next operation to fix the freelist will right-size the list.
diff --git a/Documentation/filesystems/xfs-self-describing-metadata.rst b/Documentation/filesystems/xfs-self-describing-metadata.rst
index b79dbf36dc94..a10c4ae6955e 100644
--- a/Documentation/filesystems/xfs-self-describing-metadata.rst
+++ b/Documentation/filesystems/xfs-self-describing-metadata.rst
@@ -1,4 +1,5 @@
 .. SPDX-License-Identifier: GPL-2.0
+.. _xfs_self_describing_metadata:
 
 ============================
 XFS Self Describing Metadata

