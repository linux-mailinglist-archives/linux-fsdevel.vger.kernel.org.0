Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E46BE6AD3FA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Mar 2023 02:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjCGBcT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Mar 2023 20:32:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjCGBcP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Mar 2023 20:32:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583E353292;
        Mon,  6 Mar 2023 17:31:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D677AB8126A;
        Tue,  7 Mar 2023 01:31:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EA3DC433D2;
        Tue,  7 Mar 2023 01:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678152694;
        bh=6802hAB636FjTNNBftg8d5gR9AIiuBDv0EZGrDUmjHg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=e45I1zk7s9/qk2a6zc9tQZejFwL3OsUaMC4Cq1l6Hli1N4KsddWs4sSHYwjN0z2r/
         i3DO8mxkfUxK2L3KV0jO6dCTWz3PhPqqxV0O/n6cLCSy6nJ9uA7RD5RWsgO7mdDotl
         HTPLELQnDsGUrLmE8O1UTAGf0gIoFcFFJ5Ih5yAuzBZY5NKEJgIcGQtCXFPnOuCOnE
         mYMv+M6xopyWzURimKO3DqKQd7ECycsONKDahRR6hLc/AfYpLqmZi/bI3K3Kce2Ozo
         BMbY3iM1J+2DNQRZL+3bRyoWgWy6qDEClx+0tmvKAAtqlR7MXXA1NhSXnCw/LT9cGn
         2gNOE30Nozygg==
Subject: [PATCH 08/14] xfs: document btree bulk loading
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, willy@infradead.org,
        chandan.babu@oracle.com, allison.henderson@oracle.com,
        linux-fsdevel@vger.kernel.org, hch@infradead.org,
        catherine.hoang@oracle.com, david@fromorbit.com
Date:   Mon, 06 Mar 2023 17:31:34 -0800
Message-ID: <167815269412.3750278.16082662517962448050.stgit@magnolia>
In-Reply-To: <167815264897.3750278.15092544376893521026.stgit@magnolia>
References: <167815264897.3750278.15092544376893521026.stgit@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

Add a discussion of the btree bulk loading code, which makes it easy to
take an in-memory recordset and write it out to disk in an efficient
manner.  This also enables atomic switchover from the old to the new
structure with minimal potential for leaking the old blocks.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 .../filesystems/xfs-online-fsck-design.rst         |  665 ++++++++++++++++++++
 1 file changed, 665 insertions(+)


diff --git a/Documentation/filesystems/xfs-online-fsck-design.rst b/Documentation/filesystems/xfs-online-fsck-design.rst
index 21f0638ab69d..2baea7673498 100644
--- a/Documentation/filesystems/xfs-online-fsck-design.rst
+++ b/Documentation/filesystems/xfs-online-fsck-design.rst
@@ -2332,3 +2332,668 @@ this functionality as follows:
 
 After removing xfile logged buffers from the transaction in this manner, the
 transaction can be committed or cancelled.
+
+Bulk Loading of Ondisk B+Trees
+------------------------------
+
+As mentioned previously, early iterations of online repair built new btree
+structures by creating a new btree and adding observations individually.
+Loading a btree one record at a time had a slight advantage of not requiring
+the incore records to be sorted prior to commit, but was very slow and leaked
+blocks if the system went down during a repair.
+Loading records one at a time also meant that repair could not control the
+loading factor of the blocks in the new btree.
+
+Fortunately, the venerable ``xfs_repair`` tool had a more efficient means for
+rebuilding a btree index from a collection of records -- bulk btree loading.
+This was implemented rather inefficiently code-wise, since ``xfs_repair``
+had separate copy-pasted implementations for each btree type.
+
+To prepare for online fsck, each of the four bulk loaders were studied, notes
+were taken, and the four were refactored into a single generic btree bulk
+loading mechanism.
+Those notes in turn have been refreshed and are presented below.
+
+Geometry Computation
+````````````````````
+
+The zeroth step of bulk loading is to assemble the entire record set that will
+be stored in the new btree, and sort the records.
+Next, call ``xfs_btree_bload_compute_geometry`` to compute the shape of the
+btree from the record set, the type of btree, and any load factor preferences.
+This information is required for resource reservation.
+
+First, the geometry computation computes the minimum and maximum records that
+will fit in a leaf block from the size of a btree block and the size of the
+block header.
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
+reasonably compact structure without any immediate split penalties::
+
+        default_load_factor = (maxrecs + minrecs) / 2
+
+If space is tight, the loading factor will be set to maxrecs to try to avoid
+running out of space::
+
+        leaf_load_factor = enough space ? default_load_factor : maxrecs
+
+Load factor is computed for btree node blocks using the combined size of the
+btree key and pointer as the record size::
+
+        maxrecs = (block_size - header_size) / (key_size + ptr_size)
+        minrecs = maxrecs / 2
+        node_load_factor = enough space ? default_load_factor : maxrecs
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
+The entire computation is performed recursively until the current level only
+needs one block.
+The resulting geometry is as follows:
+
+- For AG-rooted btrees, this level is the root level, so the height of the new
+  tree is ``level + 1`` and the space needed is the summation of the number of
+  blocks on each level.
+
+- For inode-rooted btrees where the records in the top level do not fit in the
+  inode fork area, the height is ``level + 2``, the space needed is the
+  summation of the number of blocks on each level, and the inode fork points to
+  the root block.
+
+- For inode-rooted btrees where the records in the top level can be stored in
+  the inode fork area, then the root block can be stored in the inode, the
+  height is ``level + 1``, and the space needed is one less than the summation
+  of the number of blocks on each level.
+  This only becomes relevant when non-bmap btrees gain the ability to root in
+  an inode, which is a future patchset and only included here for completeness.
+
+.. _newbt:
+
+Reserving New B+Tree Blocks
+```````````````````````````
+
+Once repair knows the number of blocks needed for the new btree, it allocates
+those blocks using the free space information.
+Each reserved extent is tracked separately by the btree builder state data.
+To improve crash resilience, the reservation code also logs an Extent Freeing
+Intent (EFI) item in the same transaction as each space allocation and attaches
+its in-memory ``struct xfs_extent_free_item`` object to the space reservation.
+If the system goes down, log recovery will use the unfinished EFIs to free the
+unused space, the free space, leaving the filesystem unchanged.
+
+Each time the btree builder claims a block for the btree from a reserved
+extent, it updates the in-memory reservation to reflect the claimed space.
+Block reservation tries to allocate as much contiguous space as possible to
+reduce the number of EFIs in play.
+
+While repair is writing these new btree blocks, the EFIs created for the space
+reservations pin the tail of the ondisk log.
+It's possible that other parts of the system will remain busy and push the head
+of the log towards the pinned tail.
+To avoid livelocking the filesystem, the EFIs must not pin the tail of the log
+for too long.
+To alleviate this problem, the dynamic relogging capability of the deferred ops
+mechanism is reused here to commit a transaction at the log head containing an
+EFD for the old EFI and new EFI at the head.
+This enables the log to release the old EFI to keep the log moving forwards.
+
+EFIs have a role to play during the commit and reaping phases; please see the
+next section and the section about :ref:`reaping<reaping>` for more details.
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
+This part is pretty simple -- the btree builder (``xfs_btree_bulkload``) claims
+a block from the reserved list, writes the new btree block header, fills the
+rest of the block with records, and adds the new leaf block to a list of
+written blocks::
+
+  ┌────┐
+  │leaf│
+  │RRR │
+  └────┘
+
+Sibling pointers are set every time a new block is added to the level::
+
+  ┌────┐ ┌────┐ ┌────┐ ┌────┐
+  │leaf│→│leaf│→│leaf│→│leaf│
+  │RRR │←│RRR │←│RRR │←│RRR │
+  └────┘ └────┘ └────┘ └────┘
+
+When it finishes writing the record leaf blocks, it moves on to the node
+blocks
+To fill a node block, it walks each block in the next level down in the tree
+to compute the relevant keys and write them into the parent node::
+
+      ┌────┐       ┌────┐
+      │node│──────→│node│
+      │PP  │←──────│PP  │
+      └────┘       └────┘
+      ↙   ↘         ↙   ↘
+  ┌────┐ ┌────┐ ┌────┐ ┌────┐
+  │leaf│→│leaf│→│leaf│→│leaf│
+  │RRR │←│RRR │←│RRR │←│RRR │
+  └────┘ └────┘ └────┘ └────┘
+
+When it reaches the root level, it is ready to commit the new btree!::
+
+          ┌─────────┐
+          │  root   │
+          │   PP    │
+          └─────────┘
+          ↙         ↘
+      ┌────┐       ┌────┐
+      │node│──────→│node│
+      │PP  │←──────│PP  │
+      └────┘       └────┘
+      ↙   ↘         ↙   ↘
+  ┌────┐ ┌────┐ ┌────┐ ┌────┐
+  │leaf│→│leaf│→│leaf│→│leaf│
+  │RRR │←│RRR │←│RRR │←│RRR │
+  └────┘ └────┘ └────┘ └────┘
+
+The first step to commit the new btree is to persist the btree blocks to disk
+synchronously.
+This is a little complicated because a new btree block could have been freed
+in the recent past, so the builder must use ``xfs_buf_delwri_queue_here`` to
+remove the (stale) buffer from the AIL list before it can write the new blocks
+to disk.
+Blocks are queued for IO using a delwri list and written in one large batch
+with ``xfs_buf_delwri_submit``.
+
+Once the new blocks have been persisted to disk, control returns to the
+individual repair function that called the bulk loader.
+The repair function must log the location of the new root in a transaction,
+clean up the space reservations that were made for the new btree, and reap the
+old metadata blocks:
+
+1. Commit the location of the new btree root.
+
+2. For each incore reservation:
+
+   a. Log Extent Freeing Done (EFD) items for all the space that was consumed
+      by the btree builder.  The new EFDs must point to the EFIs attached to
+      the reservation to prevent log recovery from freeing the new blocks.
+
+   b. For unclaimed portions of incore reservations, create a regular deferred
+      extent free work item to be free the unused space later in the
+      transaction chain.
+
+   c. The EFDs and EFIs logged in steps 2a and 2b must not overrun the
+      reservation of the committing transaction.
+      If the btree loading code suspects this might be about to happen, it must
+      call ``xrep_defer_finish`` to clear out the deferred work and obtain a
+      fresh transaction.
+
+3. Clear out the deferred work a second time to finish the commit and clean
+   the repair transaction.
+
+The transaction rolling in steps 2c and 3 represent a weakness in the repair
+algorithm, because a log flush and a crash before the end of the reap step can
+result in space leaking.
+Online repair functions minimize the chances of this occuring by using very
+large transactions, which each can accomodate many thousands of block freeing
+instructions.
+Repair moves on to reaping the old blocks, which will be presented in a
+subsequent :ref:`section<reaping>` after a few case studies of bulk loading.
+
+Case Study: Rebuilding the Inode Index
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+The high level process to rebuild the inode index btree is:
+
+1. Walk the reverse mapping records to generate ``struct xfs_inobt_rec``
+   records from the inode chunk information and a bitmap of the old inode btree
+   blocks.
+
+2. Append the records to an xfarray in inode order.
+
+3. Use the ``xfs_btree_bload_compute_geometry`` function to compute the number
+   of blocks needed for the inode btree.
+   If the free space inode btree is enabled, call it again to estimate the
+   geometry of the finobt.
+
+4. Allocate the number of blocks computed in the previous step.
+
+5. Use ``xfs_btree_bload`` to write the xfarray records to btree blocks and
+   generate the internal node blocks.
+   If the free space inode btree is enabled, call it again to load the finobt.
+
+6. Commit the location of the new btree root block(s) to the AGI.
+
+7. Reap the old btree blocks using the bitmap created in step 1.
+
+Details are as follows.
+
+The inode btree maps inumbers to the ondisk location of the associated
+inode records, which means that the inode btrees can be rebuilt from the
+reverse mapping information.
+Reverse mapping records with an owner of ``XFS_RMAP_OWN_INOBT`` marks the
+location of the old inode btree blocks.
+Each reverse mapping record with an owner of ``XFS_RMAP_OWN_INODES`` marks the
+location of at least one inode cluster buffer.
+A cluster is the smallest number of ondisk inodes that can be allocated or
+freed in a single transaction; it is never smaller than 1 fs block or 4 inodes.
+
+For the space represented by each inode cluster, ensure that there are no
+records in the free space btrees nor any records in the reference count btree.
+If there are, the space metadata inconsistencies are reason enough to abort the
+operation.
+Otherwise, read each cluster buffer to check that its contents appear to be
+ondisk inodes and to decide if the file is allocated
+(``xfs_dinode.i_mode != 0``) or free (``xfs_dinode.i_mode == 0``).
+Accumulate the results of successive inode cluster buffer reads until there is
+enough information to fill a single inode chunk record, which is 64 consecutive
+numbers in the inumber keyspace.
+If the chunk is sparse, the chunk record may include holes.
+
+Once the repair function accumulates one chunk's worth of data, it calls
+``xfarray_append`` to add the inode btree record to the xfarray.
+This xfarray is walked twice during the btree creation step -- once to populate
+the inode btree with all inode chunk records, and a second time to populate the
+free inode btree with records for chunks that have free non-sparse inodes.
+The number of records for the inode btree is the number of xfarray records,
+but the record count for the free inode btree has to be computed as inode chunk
+records are stored in the xfarray.
+
+The proposed patchset is the
+`AG btree repair
+<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=repair-ag-btrees>`_
+series.
+
+Case Study: Rebuilding the Space Reference Counts
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Reverse mapping records are used to rebuild the reference count information.
+Reference counts are required for correct operation of copy on write for shared
+file data.
+Imagine the reverse mapping entries as rectangles representing extents of
+physical blocks, and that the rectangles can be laid down to allow them to
+overlap each other.
+From the diagram below, it is apparent that a reference count record must start
+or end wherever the height of the stack changes.
+In other words, the record emission stimulus is level-triggered::
+
+                        █    ███
+              ██      █████ ████   ███        ██████
+        ██   ████     ███████████ ████     █████████
+        ████████████████████████████████ ███████████
+        ^ ^  ^^ ^^    ^ ^^ ^^^  ^^^^  ^ ^^ ^  ^     ^
+        2 1  23 21    3 43 234  2123  1 01 2  3     0
+
+The ondisk reference count btree does not store the refcount == 0 cases because
+the free space btree already records which blocks are free.
+Extents being used to stage copy-on-write operations should be the only records
+with refcount == 1.
+Single-owner file blocks aren't recorded in either the free space or the
+reference count btrees.
+
+The high level process to rebuild the reference count btree is:
+
+1. Walk the reverse mapping records to generate ``struct xfs_refcount_irec``
+   records for any space having more than one reverse mapping and add them to
+   the xfarray.
+   Any records owned by ``XFS_RMAP_OWN_COW`` are also added to the xfarray
+   because these are extents allocated to stage a copy on write operation and
+   are tracked in the refcount btree.
+
+   Use any records owned by ``XFS_RMAP_OWN_REFC`` to create a bitmap of old
+   refcount btree blocks.
+
+2. Sort the records in physical extent order, putting the CoW staging extents
+   at the end of the xfarray.
+   This matches the sorting order of records in the refcount btree.
+
+3. Use the ``xfs_btree_bload_compute_geometry`` function to compute the number
+   of blocks needed for the new tree.
+
+4. Allocate the number of blocks computed in the previous step.
+
+5. Use ``xfs_btree_bload`` to write the xfarray records to btree blocks and
+   generate the internal node blocks.
+
+6. Commit the location of new btree root block to the AGF.
+
+7. Reap the old btree blocks using the bitmap created in step 1.
+
+Details are as follows; the same algorithm is used by ``xfs_repair`` to
+generate refcount information from reverse mapping records.
+
+- Until the reverse mapping btree runs out of records:
+
+  - Retrieve the next record from the btree and put it in a bag.
+
+  - Collect all records with the same starting block from the btree and put
+    them in the bag.
+
+  - While the bag isn't empty:
+
+    - Among the mappings in the bag, compute the lowest block number where the
+      reference count changes.
+      This position will be either the starting block number of the next
+      unprocessed reverse mapping or the next block after the shortest mapping
+      in the bag.
+
+    - Remove all mappings from the bag that end at this position.
+
+    - Collect all reverse mappings that start at this position from the btree
+      and put them in the bag.
+
+    - If the size of the bag changed and is greater than one, create a new
+      refcount record associating the block number range that we just walked to
+      the size of the bag.
+
+The bag-like structure in this case is a type 2 xfarray as discussed in the
+:ref:`xfarray access patterns<xfarray_access_patterns>` section.
+Reverse mappings are added to the bag using ``xfarray_store_anywhere`` and
+removed via ``xfarray_unset``.
+Bag members are examined through ``xfarray_iter`` loops.
+
+The proposed patchset is the
+`AG btree repair
+<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=repair-ag-btrees>`_
+series.
+
+Case Study: Rebuilding File Fork Mapping Indices
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+The high level process to rebuild a data/attr fork mapping btree is:
+
+1. Walk the reverse mapping records to generate ``struct xfs_bmbt_rec``
+   records from the reverse mapping records for that inode and fork.
+   Append these records to an xfarray.
+   Compute the bitmap of the old bmap btree blocks from the ``BMBT_BLOCK``
+   records.
+
+2. Use the ``xfs_btree_bload_compute_geometry`` function to compute the number
+   of blocks needed for the new tree.
+
+3. Sort the records in file offset order.
+
+4. If the extent records would fit in the inode fork immediate area, commit the
+   records to that immediate area and skip to step 8.
+
+5. Allocate the number of blocks computed in the previous step.
+
+6. Use ``xfs_btree_bload`` to write the xfarray records to btree blocks and
+   generate the internal node blocks.
+
+7. Commit the new btree root block to the inode fork immediate area.
+
+8. Reap the old btree blocks using the bitmap created in step 1.
+
+There are some complications here:
+First, it's possible to move the fork offset to adjust the sizes of the
+immediate areas if the data and attr forks are not both in BMBT format.
+Second, if there are sufficiently few fork mappings, it may be possible to use
+EXTENTS format instead of BMBT, which may require a conversion.
+Third, the incore extent map must be reloaded carefully to avoid disturbing
+any delayed allocation extents.
+
+The proposed patchset is the
+`file mapping repair
+<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=repair-file-mappings>`_
+series.
+
+.. _reaping:
+
+Reaping Old Metadata Blocks
+---------------------------
+
+Whenever online fsck builds a new data structure to replace one that is
+suspect, there is a question of how to find and dispose of the blocks that
+belonged to the old structure.
+The laziest method of course is not to deal with them at all, but this slowly
+leads to service degradations as space leaks out of the filesystem.
+Hopefully, someone will schedule a rebuild of the free space information to
+plug all those leaks.
+Offline repair rebuilds all space metadata after recording the usage of
+the files and directories that it decides not to clear, hence it can build new
+structures in the discovered free space and avoid the question of reaping.
+
+As part of a repair, online fsck relies heavily on the reverse mapping records
+to find space that is owned by the corresponding rmap owner yet truly free.
+Cross referencing rmap records with other rmap records is necessary because
+there may be other data structures that also think they own some of those
+blocks (e.g. crosslinked trees).
+Permitting the block allocator to hand them out again will not push the system
+towards consistency.
+
+For space metadata, the process of finding extents to dispose of generally
+follows this format:
+
+1. Create a bitmap of space used by data structures that must be preserved.
+   The space reservations used to create the new metadata can be used here if
+   the same rmap owner code is used to denote all of the objects being rebuilt.
+
+2. Survey the reverse mapping data to create a bitmap of space owned by the
+   same ``XFS_RMAP_OWN_*`` number for the metadata that is being preserved.
+
+3. Use the bitmap disunion operator to subtract (1) from (2).
+   The remaining set bits represent candidate extents that could be freed.
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
+4. For each candidate extent, count the number of reverse mapping records for
+   the first block in that extent that do not have the same rmap owner for the
+   data structure being repaired.
+
+   - If zero, the block has a single owner and can be freed.
+
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
+However, there is one complication to this procedure.
+Transactions are of finite size, so the reaping process must be careful to roll
+the transactions to avoid overruns.
+Overruns come from two sources:
+
+a. EFIs logged on behalf of space that is no longer occupied
+
+b. Log items for buffer invalidations
+
+This is also a window in which a crash during the reaping process can leak
+blocks.
+As stated earlier, online repair functions use very large transactions to
+minimize the chances of this occurring.
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
+Creating a list of extents to reap the old btree blocks is quite simple,
+conceptually:
+
+1. Lock the relevant AGI/AGF header buffers to prevent allocation and frees.
+
+2. For each reverse mapping record with an rmap owner corresponding to the
+   metadata structure being rebuilt, set the corresponding range in a bitmap.
+
+3. Walk the current data structures that have the same rmap owner.
+   For each block visited, clear that range in the above bitmap.
+
+4. Each set bit in the bitmap represents a block that could be a block from the
+   old data structures and hence is a candidate for reaping.
+   In other words, ``(rmap_records_owned_by & ~blocks_reachable_by_walk)``
+   are the blocks that might be freeable.
+
+If it is possible to maintain the AGF lock throughout the repair (which is the
+common case), then step 2 can be performed at the same time as the reverse
+mapping record walk that creates the records for the new btree.
+
+Case Study: Rebuilding the Free Space Indices
+`````````````````````````````````````````````
+
+The high level process to rebuild the free space indices is:
+
+1. Walk the reverse mapping records to generate ``struct xfs_alloc_rec_incore``
+   records from the gaps in the reverse mapping btree.
+
+2. Append the records to an xfarray.
+
+3. Use the ``xfs_btree_bload_compute_geometry`` function to compute the number
+   of blocks needed for each new tree.
+
+4. Allocate the number of blocks computed in the previous step from the free
+   space information collected.
+
+5. Use ``xfs_btree_bload`` to write the xfarray records to btree blocks and
+   generate the internal node blocks for the free space by length index.
+   Call it again for the free space by block number index.
+
+6. Commit the locations of the new btree root blocks to the AGF.
+
+7. Reap the old btree blocks by looking for space that is not recorded by the
+   reverse mapping btree, the new free space btrees, or the AGFL.
+
+Repairing the free space btrees has three key complications over a regular
+btree repair:
+
+First, free space is not explicitly tracked in the reverse mapping records.
+Hence, the new free space records must be inferred from gaps in the physical
+space component of the keyspace of the reverse mapping btree.
+
+Second, free space repairs cannot use the common btree reservation code because
+new blocks are reserved out of the free space btrees.
+This is impossible when repairing the free space btrees themselves.
+However, repair holds the AGF buffer lock for the duration of the free space
+index reconstruction, so it can use the collected free space information to
+supply the blocks for the new free space btrees.
+It is not necessary to back each reserved extent with an EFI because the new
+free space btrees are constructed in what the ondisk filesystem thinks is
+unowned space.
+However, if reserving blocks for the new btrees from the collected free space
+information changes the number of free space records, repair must re-estimate
+the new free space btree geometry with the new record count until the
+reservation is sufficient.
+As part of committing the new btrees, repair must ensure that reverse mappings
+are created for the reserved blocks and that unused reserved blocks are
+inserted into the free space btrees.
+Deferrred rmap and freeing operations are used to ensure that this transition
+is atomic, similar to the other btree repair functions.
+
+Third, finding the blocks to reap after the repair is not overly
+straightforward.
+Blocks for the free space btrees and the reverse mapping btrees are supplied by
+the AGFL.
+Blocks put onto the AGFL have reverse mapping records with the owner
+``XFS_RMAP_OWN_AG``.
+This ownership is retained when blocks move from the AGFL into the free space
+btrees or the reverse mapping btrees.
+When repair walks reverse mapping records to synthesize free space records, it
+creates a bitmap (``ag_owner_bitmap``) of all the space claimed by
+``XFS_RMAP_OWN_AG`` records.
+The repair context maintains a second bitmap corresponding to the rmap btree
+blocks and the AGFL blocks (``rmap_agfl_bitmap``).
+When the walk is complete, the bitmap disunion operation ``(ag_owner_bitmap &
+~rmap_agfl_bitmap)`` computes the extents that are used by the old free space
+btrees.
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
+rmap btree, nor will the old btree blocks be tracked in the free space btrees.
+The list of candidate reaping blocks is computed by setting the bits
+corresponding to the gaps in the new rmap btree records, and then clearing the
+bits corresponding to extents in the free space btrees and the current AGFL
+blocks.
+The result ``(new_rmapbt_gaps & ~(agfl | bnobt_records))`` are reaped using the
+methods outlined above.
+
+The rest of the process of rebuildng the reverse mapping btree is discussed
+in a separate :ref:`case study<rmap_repair>`.
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
+
+2. Subtract the space used by the two free space btrees and the rmap btree.
+
+3. Subtract any space that the reverse mapping data claims is owned by any
+   other owner, to avoid re-adding crosslinked blocks to the AGFL.
+
+4. Once the AGFL is full, reap any blocks leftover.
+
+5. The next operation to fix the freelist will right-size the list.
+
+See `fs/xfs/scrub/agheader_repair.c <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/xfs/scrub/agheader_repair.c>`_ for more details.

