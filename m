Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECB65F24BF
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Oct 2022 20:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbiJBS07 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 Oct 2022 14:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbiJBS06 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 Oct 2022 14:26:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8008A34986;
        Sun,  2 Oct 2022 11:26:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C10D60EDE;
        Sun,  2 Oct 2022 18:26:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BDF4C433D6;
        Sun,  2 Oct 2022 18:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664735214;
        bh=rRn5K+/UJ6ffAqDD3gjRRgtvFRlIESAh/dZVJ21oOv4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=FAy0mZ2FiNb5AYNmMhGjCHs9vl3sH+e+hmSDvdNyHsyDLHy6g4AaTBZzDBap1ZPgk
         3Zgv15k0R6Z/75O/isjQ7iFdstJ2DnLtC71a8lIWsx7BguEwBzgvko1nlk3qSxS3Sj
         JMLW2GtHOewLd4b6fz87lLLStCFSXU5FGS7puONWq6MrxtNqXeL8F6u5q4g6VqJvup
         rX4iy1G6bGegtY+snSTmRd4NGtDWKug5x0pucfK+3eXqdQFv2Pnxc8VvL2KnFGNWOs
         tqj+g7UBKu0c0DNPacUaJaI/B+dbsSrDEciBCVrXIkoVOBD1DpeZqoaFiR2dMjVzDM
         rlrUfEO9kzc8Q==
Subject: [PATCH 11/14] xfs: document metadata file repair
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, willy@infradead.org,
        chandan.babu@oracle.com, allison.henderson@oracle.com,
        linux-fsdevel@vger.kernel.org, hch@infradead.org,
        catherine.hoang@oracle.com, david@fromorbit.com
Date:   Sun, 02 Oct 2022 11:19:45 -0700
Message-ID: <166473478514.1082796.4894881059241519911.stgit@magnolia>
In-Reply-To: <166473478338.1082796.8807888906305023929.stgit@magnolia>
References: <166473478338.1082796.8807888906305023929.stgit@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

File-based metadata (such as xattrs and directories) can be extremely
large.  To reduce the memory requirements and maximize code reuse, it is
very convenient to create a temporary file, use the regular dir/attr
code to store salvaged information, and then atomically swap the extents
between the file being repaired and the temporary file.  Record the high
level concepts behind how temporary files and atomic content swapping
should work, and then present some case studies of what the actual
repair functions do.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 .../filesystems/xfs-online-fsck-design.rst         |  574 ++++++++++++++++++++
 1 file changed, 574 insertions(+)


diff --git a/Documentation/filesystems/xfs-online-fsck-design.rst b/Documentation/filesystems/xfs-online-fsck-design.rst
index 5ab2d76ad694..d7fecc0c49cf 100644
--- a/Documentation/filesystems/xfs-online-fsck-design.rst
+++ b/Documentation/filesystems/xfs-online-fsck-design.rst
@@ -3256,6 +3256,8 @@ Proposed patchsets include fixing
 `dir iget usage
 <https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=scrub-dir-iget-fixes>`_.
 
+.. _ilocking:
+
 Locking Inodes
 ^^^^^^^^^^^^^^
 
@@ -3699,3 +3701,575 @@ The proposed patchset is the
 `rmap repair
 <https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=repair-rmap-btree>`_
 series.
+
+Staging Repairs with Temporary Files on Disk
+--------------------------------------------
+
+XFS stores a substantial amount of metadata in file forks: directories,
+extended attributes, symbolic link targets, free space bitmaps and summary
+information for the realtime volume, and quota records.
+File forks map 64-bit logical file fork space extents to physical storage space
+extents, similar to how a memory management unit maps 64-bit virtual addresses
+to physical memory addresses.
+Therefore, file-based tree structures (such as directories and extended
+attributes) use blocks mapped in the file fork offset address space that point
+to other blocks mapped within that same address space, and file-based linear
+structures (such as bitmaps and quota records) compute array element offsets in
+the file fork offset address space.
+
+In the initial iteration of file metadata repair, the damaged metadata blocks
+would be scanned for salvageable data; the extents in the file fork would be
+reaped; and then a new structure would be built in its place.
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
+- Extended attributes are allowed to use the entire attr fork offset address
+  space.
+
+- Even if repair could build an alternate copy of a data structure in a
+  different part of the fork address space, the atomic repair commit
+  requirement means that online repair would have to be able to perform a log
+  assisted ``COLLAPSE_RANGE`` operation to ensure that the old structure was
+  completely replaced.
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
+  Doing this as part of a range collapse means rewriting a large number of
+  blocks repeatedly, which is not conducive to quick repairs.
+
+The third iteration of the design for file metadata repair went for a totally
+new strategy -- create a temporary file in the XFS filesystem, write a new
+structure at the correct offsets into the temporary file, and atomically swap
+the fork mappings (and hence the fork contents) to commit the repair.
+Once the repair is complete, the old fork can be reaped as necessary; if the
+system goes down during the reap, the iunlink code will delete the blocks
+during log recovery.
+
+**Note**: All space usage and inode indices in the filesystem *must* be
+consistent to use a temporary file safely!
+This dependency is the reason why online repair can only use pageable kernel
+memory to stage ondisk space usage information.
+
+Swapping extents with a temporary file still requires a rewrite of the owner
+field of the block headers, but this is *much* simpler than moving tree blocks
+individually.
+Furthermore, the buffer verifiers do not verify owner fields (since they are
+not aware of the inode that owns the block), which makes reaping of old file
+blocks much simpler.
+Extent swapping requires that AG space metadata and the file fork metadata of
+the file being repaired are all consistent with respect to each other, but
+that's already a requirement for correct operation of files in general.
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
+Using a Temporary File
+``````````````````````
+
+Online repair code should use the ``xrep_tempfile_create`` function to create a
+temporary file inside the filesystem.
+This allocates an inode, marks the in-core inode private, and attaches it to
+the scrub context.
+These files are hidden from userspace, may not be added to the directory tree,
+and must be kept private.
+
+Temporary files only use two inode locks: the IOLOCK and the ILOCK.
+The MMAPLOCK is not needed here, because there must not be page faults from
+userspace for data fork blocks.
+The usage patterns of these two locks are the same as for any other XFS file --
+access to file data are controlled via the IOLOCK, and access to file metadata
+are controlled via the ILOCK.
+Locking helpers are provided so that the temporary file and its lock state can
+be cleaned up by the scrub context.
+To comply with the nested locking strategy laid out in the :ref:`inode
+locking<ilocking>` section, it is recommended that scrub functions use the
+xrep_tempfile_ilock*_nowait lock helpers.
+
+Data can be written to a temporary file by two means:
+
+1. ``xrep_tempfile_copyin`` can be used to set the contents of a regular
+   temporary file from an xfile.
+
+2. The regular directory, symbolic link, and extended attribute functions can
+   be used to write to the temporary file.
+
+Once a good copy of a data file has been constructed in a temporary file, it
+must be conveyed to the file being repaired, which is the topic of the next
+section.
+
+The proposed patches are in the
+`realtime summary repair
+<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=repair-rtsummary>`_
+series.
+
+Atomic Extent Swapping
+----------------------
+
+Once repair builds a temporary file with a new data structure written into
+it, it must commit the new changes into the existing file.
+It is not possible to swap the inumbers of two files, so instead the new
+metadata must replace the old.
+This suggests the need for the ability to swap extents, but the existing extent
+swapping code used by the file defragmenting tool ``xfs_fsr`` is not sufficient
+for online repair because:
+
+a. When the reverse-mapping btree is enabled, the swap code must keep the
+   reverse mapping information up to date with every exchange of mappings.
+   Therefore, it can only exchange one mapping per transaction, and each
+   transaction is independent.
+
+b. Reverse-mapping is critical for the operation of online fsck, so the old
+   defragmentation code (which swapped entire extent forks in a single
+   operation) is not useful here.
+
+c. Defragmentation is assumed to occur between two files with identical
+   contents.
+   For this use case, an incomplete exchange will not result in a user-visible
+   change in file contents, even if the operation is interrupted.
+
+d. Online repair needs to swap the contents of two files that are by definition
+   *not* identical.
+   For directory and xattr repairs, the user-visible contents might be the
+   same, but the contents of individual blocks may be very different.
+
+e. Old blocks in the file may be cross-linked with another structure and must
+   not reappear if the system goes down mid-repair.
+
+These problems are overcome by creating a new deferred operation and a new type
+of log intent item to track the progress of an operation to exchange two file
+ranges.
+The new deferred operation type chains together the same transactions used by
+the reverse-mapping extent swap code.
+The new log item records the progress of the exchange to ensure that once an
+exchange begins, it will always run to completion, even there are
+interruptions.
+
+The proposed patchset is the
+`atomic extent swap
+<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=atomic-file-updates>`_
+series.
+
+Using Log-Incompatible Feature Flags
+````````````````````````````````````
+
+Starting with XFS v5, the superblock contains a ``sb_features_log_incompat``
+field to indicate that the log contains records that might not readable by all
+kernels that could mount this filesystem.
+In short, log incompat features protect the log contents against kernels that
+will not understand the contents.
+Unlike the other superblock feature bits, log incompat bits are ephemeral
+because an empty (clean) log does not need protection.
+The log cleans itself after its contents have been committed into the
+filesystem, either as part of an unmount or because the system is otherwise
+idle.
+Because upper level code can be working on a transaction at the same time that
+the log cleans itself, it is necessary for upper level code to communicate to
+the log when it is going to use a log incompatible feature.
+
+The log coordinates access to incompatible features through the use of one
+``struct rw_semaphore`` for each feature.
+The log cleaning code tries to take this rwsem in exclusive mode to clear the
+bit; if the lock attempt fails, the feature bit remains set.
+Filesystem code signals its intention to use a log incompat feature in a
+transaction by calling ``xlog_use_incompat_feat``, which takes the rwsem in
+shared mode.
+The code supporting a log incompat feature should create wrapper functions to
+obtain the log feature and call ``xfs_add_incompat_log_feature`` to set the
+feature bits in the primary superblock.
+The superblock update is performed transactionally, so the wrapper to obtain
+log assistance must be called just prior to the creation of the transaction
+that uses the functionality.
+For a file operation, this step must happen after taking the IOLOCK and the
+MMAPLOCK, but before allocating the transaction.
+When the transaction is complete, the ``xlog_drop_incompat_feat`` function
+is called to release the feature.
+The feature bit will not be cleared from the superblock until the log becomes
+clean.
+
+Log-assisted extended attribute updates and atomic extent swaps both use log
+incompat features and provide convenience wrappers around the functionality.
+
+Mechanics of an Atomic Extent Swap
+``````````````````````````````````
+
+Swapping entire file forks is a complex task.
+The goal is to exchange all file fork mappings between two file fork offset
+ranges.
+There are likely to be many extent mappings in each fork, and the edges of
+the mappings aren't necessarily aligned.
+Furthermore, there may be other updates that need to happen after the swap,
+such as exchanging file sizes, inode flags, or conversion of fork data to local
+format.
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
+The new log intent item contains enough information to track two logical fork
+offset ranges: ``(inode1, startoff1, blockcount)`` and ``(inode2, startoff2,
+blockcount)``.
+Each step of a swap operation exchanges the largest file range mapping possible
+from one file to the other.
+After each step in the swap operation, the two startoff fields are incremented
+and the blockcount field is decremented to reflect the progress made.
+The flags field captures behavioral parameters such as swapping the attr fork
+instead of the data fork and other work to be done after the extent swap.
+The two isize fields are used to swap the file size at the end of the operation
+if the file data fork is the target of the swap operation.
+
+When the extent swap is initiated, the sequence of operations is as follows:
+
+1. Create a deferred work item for the extent swap.
+   At the start, it should contain the entirety of the file ranges to be
+   swapped.
+
+2. Call ``xfs_defer_finish`` to start processing of the exchange.
+   This will log an extent swap intent item to the transaction for the deferred
+   extent swap work item.
+
+3. Until ``sxi_blockcount`` of the deferred extent swap work item is zero,
+
+   a. Read the block maps of both file ranges starting at ``sxi_startoff1`` and
+      ``sxi_startoff2``, respectively, and compute the longest extent that can
+      be swapped in a single step.
+      This is the minimum of the two ``br_blockcount`` s in the mappings.
+      Keep advancing through the file forks until at least one of the mappings
+      contains written blocks.
+      Mutual holes, unwritten extents, and extent mappings to the same physical
+      space are not exchanged.
+
+      For the next few steps, this document will refer to the mapping that came
+      from file 1 as "map1", and the mapping that came from file 2 as "map2".
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
+      that was read at the start of step 3.
+
+   i. Compute the amount of file range that has just been covered.
+      This quantity is ``(map1.br_startoff + map1.br_blockcount -
+      sxi_startoff1)``, because step 3a could have skipped holes.
+
+   j. Increase the starting offsets of ``sxi_startoff1`` and ``sxi_startoff2``
+      by the number of blocks computed in the previous step, and decrease
+      ``sxi_blockcount`` by the same quantity.
+      This advances the cursor.
+
+   k. Log a new extent swap intent log item reflecting the advanced state of
+      the work item.
+
+   l. Return the proper error code (EAGAIN) to the deferred operation manager
+      to inform it that there is more work to be done.
+      The operation manager completes the deferred work in steps 3b-3e before
+      moving back to the start of step 3.
+
+4. Perform any post-processing.
+   This will be discussed in more detail in subsequent sections.
+
+If the filesystem goes down in the middle of an operation, log recovery will
+find the most recent unfinished extent swap log intent item and restart from
+there.
+This is how extent swapping guarantees that an outside observer will either see
+the old broken structure or the new one, and never a mismash of both.
+
+Extent Swapping with Regular User Files
+```````````````````````````````````````
+
+As mentioned earlier, XFS has long had the ability to swap extents between
+files, which is used almost exclusively by ``xfs_fsr`` to defragment files.
+The earliest form of this was the fork swap mechanism, where the entire
+contents of data forks could be exchanged between two files by exchanging the
+raw bytes in each inode fork's immediate area.
+When XFS v5 came along with self-describing metadata, this old mechanism grew
+some log support to continue rewriting the owner fields of BMBT blocks during
+log recovery.
+When the reverse mapping btree was later added to XFS, the only way to maintain
+the consistency of the fork mappings with the reverse mapping index was to
+develop an iterative mechanism that used deferred bmap and rmap operations to
+swap mappings one at a time.
+This mechanism is identical to steps 2-3 from the procedure above except for
+the new tracking items, because the atomic extent swap mechanism is an
+iteration of an existing mechanism and not something totally novel.
+For the narrow case of file defragmentation, the file contents must be
+identical, so the recovery guarantees are not much of a gain.
+
+Atomic extent swapping is much more flexible than the existing swapext
+implementations because it can guarantee that the caller never sees a mix of
+old and new contents even after a crash, and it can operate on two arbitrary
+file fork ranges.
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
+  Stage all writes to a temporary file, and when that is complete, call the
+  atomic extent swap system call with a flag to indicate that holes in the
+  temporary file should be ignored.
+  This emulates an atomic device write in software, and can support arbitrary
+  scattered writes.
+
+Preparation for Extent Swapping
+```````````````````````````````
+
+There are a few things that need to be taken care of before initiating an
+atomic extent swap operation.
+First, regular files require the page cache to be flushed to disk before the
+operation begins, and directio writes to be quiesced.
+Like any filesystem operation, extent swapping must determine the maximum
+amount of disk space and quota that can be consumed on behalf of both files in
+the operation, and reserve that quantity of resources to avoid an unrecoverable
+out of space failure once it starts dirtying metadata.
+The preparation step scans the ranges of both files to estimate:
+
+- Data device blocks needed to handle the repeated updates to the fork
+  mappings.
+- Change in data and realtime block counts for both files.
+- Increase in quota usage for both files, if the two files do not share the
+  same set of quota ids.
+- The number of extent mappings that will be added to each file.
+- Whether or not there are partially written realtime extents.
+  User programs must never be able to access a realtime file extent that maps
+  to different extents on the realtime volume, which could happen if the
+  operation fails to run to completion.
+
+The need for precise estimation increases the run time of the swap operation,
+but it is very important to maintain correct accounting.
+The filesystem must not run completely out of free space, nor can the extent
+swap ever add more extent mappings to a fork than it can support.
+Regular users are required to abide the quota limits, though metadata repairs
+may exceed quota to resolve inconsistent metadata elsewhere.
+
+Special Features for Swapping Metadata File Extents
+```````````````````````````````````````````````````
+
+Extended attributes, symbolic links, and directories can set the fork format to
+"local" and treat the fork as a literal area for data storage.
+Metadata repairs must take extra steps to support these cases:
+
+- If both forks are in local format and the fork areas are large enough, the
+  swap is performed by copying the incore fork contents, logging both forks,
+  and committing.
+  The atomic extent swap mechanism is not necessary, since this can be done
+  with a single transaction.
+
+- If both forks map blocks, then the regular atomic extent swap is used.
+
+- Otherwise, only one fork is in local format.
+  The contents of the local format fork are converted to a block to perform the
+  swap.
+  The conversion to block format must be done in the same transaction that
+  logs the initial extent swap intent log item.
+  The regular atomic extent swap is used to exchange the mappings.
+  Special flags are set on the swap operation so that the transaction can be
+  rolled one more time to convert the second file's fork back to local format
+  if possible.
+
+Extended attributes and directories stamp the owning inode into every block,
+but the buffer verifiers do not actually check the inode number!
+Although there is no verification, it is still important to maintain
+referential integrity, so prior to performing the extent swap, online repair
+walks every block in the new data structure to update the owner field and flush
+the buffer to disk.
+
+After a successful swap operation, the repair operation must reap the old fork
+blocks by processing each fork mapping through the standard :ref:`file extent
+reaping <reaping>` mechanism that is done post-repair.
+If the filesystem should go down during the reap part of the repair, the
+iunlink processing at the end of recovery will free both the temporary file and
+whatever blocks were not reaped.
+However, this iunlink processing omits the cross-link detection of online
+repair, and is not completely foolproof.
+
+Swapping Temporary File Extents
+```````````````````````````````
+
+To repair a metadata file, online repair proceeds as follows:
+
+1. Create a temporary repair file.
+
+2. Use the staging data to write out new contents into the temporary repair
+   file.
+   The same fork must be written to as is being repaired.
+
+3. Commit the scrub transaction, since the swap estimation step must be
+   completed before transaction reservations are made.
+
+4. Call ``xrep_tempswap_trans_alloc`` to allocate a new scrub transaction with
+   the appropriate resource reservations, locks, and fill out a ``struct
+   xfs_swapext_req`` with the details of the swap operation.
+
+5. Call ``xrep_tempswap_contents`` to swap the contents.
+
+6. Commit the transaction to complete the repair.
+
+.. _rtsummary:
+
+Case Study: Repairing the Realtime Summary File
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+In the "realtime" section of an XFS filesystem, free space is tracked via a
+bitmap, similar to Unix FFS.
+Each bit in the bitmap represents one realtime extent, which is a multiple of
+the filesystem block size between 4KiB and 1GiB in size.
+The realtime summary file indexes the number of free extents of a given size to
+the offset of the block within the realtime free space bitmap where those free
+extents begin.
+In other words, the summary file helps the allocator find free extents by
+length, similar to what the free space by count (cntbt) btree does for the data
+section.
+
+The summary file itself is a flat file (with no block headers or checksums!)
+partitioned into ``log2(total rt extents)`` sections containing enough 32-bit
+counters to match the number of blocks in the rt bitmap.
+Each counter records the number of free extents that start in that bitmap block
+and can satisfy a power-of-two allocation request.
+
+To check the summary file against the bitmap:
+
+1. Take the ILOCK of both the realtime bitmap and summary files.
+
+2. For each free space extent recorded in the bitmap:
+
+   a. Compute the position in the summary file that contains a counter that
+      represents this free extent.
+
+   b. Read the counter from the xfile.
+
+   c. Increment it, and write it back to the xfile.
+
+3. Compare the contents of the xfile against the ondisk file.
+
+To repair the summary file, write the xfile contents into the temporary file
+and use atomic extent swap to commit the new contents.
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
+1. Walk the attr fork mappings of the file being repaired to find the attribute
+   leaf blocks.
+   When one is found,
+
+   a. Walk the attr leaf block to find candidate keys.
+      When one is found,
+
+      1. Check the name for problems, and ignore the name if there are.
+
+      2. Retrieve the value.
+         If that succeeds, add the name and value to the staging xfarray and
+         xfblob.
+
+2. If the memory usage of the xfarray and xfblob exceed a certain amount of
+   memory or there are no more attr fork blocks to examine, unlock the file and
+   add the staged extended attributes to the temporary file.
+
+3. Use atomic extent swapping to exchange the new and old extended attribute
+   structures.
+   The old attribute blocks are now attached to the temporary file.
+
+4. Reap the temporary file.
+
+The proposed patchset is the
+`extended attribute repair
+<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=repair-xattrs>`_
+series.

