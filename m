Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFA96AD3FB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Mar 2023 02:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjCGBcV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Mar 2023 20:32:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjCGBcM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Mar 2023 20:32:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09031637CB;
        Mon,  6 Mar 2023 17:31:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89630611B3;
        Tue,  7 Mar 2023 01:31:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2BE7C433EF;
        Tue,  7 Mar 2023 01:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678152689;
        bh=+DJ2l186OwWVqyaoqJJDL4Cqj5GAmOsrAt20qhbHXUs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=El6xT5EYYxz3rkvIJA8n3I5gIkKVTTzYcExqZFRiXvMmE/7+XBgGuVy+5AUIvbEhr
         W5PChz2VnomHdYOYfvSVG8QiHal9Hd/3b2J28Z60W3uhfvUd3aeQwDdQL8E7E7aSPe
         ORzdZAm8472hf0VdHSzyeh0hAOZGW8Ad2d2HrioRaw37LcmlpyDERdcATuyaXEk1JU
         RkrqSJt9dDIlvwfbQzxcg8zzZlWQ9Li49amr6tsppbNwY9a4uoQOh58rW/RhlKQRPP
         IzCHCeAM/XVHun4OIPO1pWJLwF2OQUu01F+cLW+0pVxeqPQqCB0H+FSFhQLUEvpXRb
         xp2tN+wXju0KQ==
Subject: [PATCH 07/14] xfs: document pageable kernel memory
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, willy@infradead.org,
        chandan.babu@oracle.com, allison.henderson@oracle.com,
        linux-fsdevel@vger.kernel.org, hch@infradead.org,
        catherine.hoang@oracle.com, david@fromorbit.com
Date:   Mon, 06 Mar 2023 17:31:28 -0800
Message-ID: <167815268848.3750278.17454613426313755372.stgit@magnolia>
In-Reply-To: <167815264897.3750278.15092544376893521026.stgit@magnolia>
References: <167815264897.3750278.15092544376893521026.stgit@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URI_DOTEDU autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

Add a discussion of pageable kernel memory, since online fsck needs
quite a bit more memory than most other parts of the filesystem to stage
records and other information.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 .../filesystems/xfs-online-fsck-design.rst         |  500 ++++++++++++++++++++
 1 file changed, 500 insertions(+)


diff --git a/Documentation/filesystems/xfs-online-fsck-design.rst b/Documentation/filesystems/xfs-online-fsck-design.rst
index e095264b591e..21f0638ab69d 100644
--- a/Documentation/filesystems/xfs-online-fsck-design.rst
+++ b/Documentation/filesystems/xfs-online-fsck-design.rst
@@ -413,6 +413,8 @@ Algorithms") of Srinivasan.
 However, any data structure builder that maintains a resource lock for the
 duration of the repair is *always* an offline algorithm.
 
+.. _secondary_metadata:
+
 Secondary Metadata
 ``````````````````
 
@@ -1832,3 +1834,501 @@ Scrub teardown disables all static keys obtained by ``xchk_fsgates_enable``.
 
 For more information, please see the kernel documentation of
 Documentation/staging/static-keys.rst.
+
+.. _xfile:
+
+Pageable Kernel Memory
+----------------------
+
+Some online checking functions work by scanning the filesystem to build a
+shadow copy of an ondisk metadata structure in memory and comparing the two
+copies.
+For online repair to rebuild a metadata structure, it must compute the record
+set that will be stored in the new structure before it can persist that new
+structure to disk.
+Ideally, repairs complete with a single atomic commit that introduces
+a new data structure.
+To meet these goals, the kernel needs to collect a large amount of information
+in a place that doesn't require the correct operation of the filesystem.
+
+Kernel memory isn't suitable because:
+
+* Allocating a contiguous region of memory to create a C array is very
+  difficult, especially on 32-bit systems.
+
+* Linked lists of records introduce double pointer overhead which is very high
+  and eliminate the possibility of indexed lookups.
+
+* Kernel memory is pinned, which can drive the system into OOM conditions.
+
+* The system might not have sufficient memory to stage all the information.
+
+At any given time, online fsck does not need to keep the entire record set in
+memory, which means that individual records can be paged out if necessary.
+Continued development of online fsck demonstrated that the ability to perform
+indexed data storage would also be very useful.
+Fortunately, the Linux kernel already has a facility for byte-addressable and
+pageable storage: tmpfs.
+In-kernel graphics drivers (most notably i915) take advantage of tmpfs files
+to store intermediate data that doesn't need to be in memory at all times, so
+that usage precedent is already established.
+Hence, the ``xfile`` was born!
+
++--------------------------------------------------------------------------+
+| **Historical Sidebar**:                                                  |
++--------------------------------------------------------------------------+
+| The first edition of online repair inserted records into a new btree as  |
+| it found them, which failed because filesystem could shut down with a    |
+| built data structure, which would be live after recovery finished.       |
+|                                                                          |
+| The second edition solved the half-rebuilt structure problem by storing  |
+| everything in memory, but frequently ran the system out of memory.       |
+|                                                                          |
+| The third edition solved the OOM problem by using linked lists, but the  |
+| memory overhead of the list pointers was extreme.                        |
++--------------------------------------------------------------------------+
+
+xfile Access Models
+```````````````````
+
+A survey of the intended uses of xfiles suggested these use cases:
+
+1. Arrays of fixed-sized records (space management btrees, directory and
+   extended attribute entries)
+
+2. Sparse arrays of fixed-sized records (quotas and link counts)
+
+3. Large binary objects (BLOBs) of variable sizes (directory and extended
+   attribute names and values)
+
+4. Staging btrees in memory (reverse mapping btrees)
+
+5. Arbitrary contents (realtime space management)
+
+To support the first four use cases, high level data structures wrap the xfile
+to share functionality between online fsck functions.
+The rest of this section discusses the interfaces that the xfile presents to
+four of those five higher level data structures.
+The fifth use case is discussed in the :ref:`realtime summary <rtsummary>` case
+study.
+
+The most general storage interface supported by the xfile enables the reading
+and writing of arbitrary quantities of data at arbitrary offsets in the xfile.
+This capability is provided by ``xfile_pread`` and ``xfile_pwrite`` functions,
+which behave similarly to their userspace counterparts.
+XFS is very record-based, which suggests that the ability to load and store
+complete records is important.
+To support these cases, a pair of ``xfile_obj_load`` and ``xfile_obj_store``
+functions are provided to read and persist objects into an xfile.
+They are internally the same as pread and pwrite, except that they treat any
+error as an out of memory error.
+For online repair, squashing error conditions in this manner is an acceptable
+behavior because the only reaction is to abort the operation back to userspace.
+All five xfile usecases can be serviced by these four functions.
+
+However, no discussion of file access idioms is complete without answering the
+question, "But what about mmap?"
+It is convenient to access storage directly with pointers, just like userspace
+code does with regular memory.
+Online fsck must not drive the system into OOM conditions, which means that
+xfiles must be responsive to memory reclamation.
+tmpfs can only push a pagecache folio to the swap cache if the folio is neither
+pinned nor locked, which means the xfile must not pin too many folios.
+
+Short term direct access to xfile contents is done by locking the pagecache
+folio and mapping it into kernel address space.
+Programmatic access (e.g. pread and pwrite) uses this mechanism.
+Folio locks are not supposed to be held for long periods of time, so long
+term direct access to xfile contents is done by bumping the folio refcount,
+mapping it into kernel address space, and dropping the folio lock.
+These long term users *must* be responsive to memory reclaim by hooking into
+the shrinker infrastructure to know when to release folios.
+
+The ``xfile_get_page`` and ``xfile_put_page`` functions are provided to
+retrieve the (locked) folio that backs part of an xfile and to release it.
+The only code to use these folio lease functions are the xfarray
+:ref:`sorting<xfarray_sort>` algorithms and the :ref:`in-memory
+btrees<xfbtree>`.
+
+xfile Access Coordination
+`````````````````````````
+
+For security reasons, xfiles must be owned privately by the kernel.
+They are marked ``S_PRIVATE`` to prevent interference from the security system,
+must never be mapped into process file descriptor tables, and their pages must
+never be mapped into userspace processes.
+
+To avoid locking recursion issues with the VFS, all accesses to the shmfs file
+are performed by manipulating the page cache directly.
+xfile writers call the ``->write_begin`` and ``->write_end`` functions of the
+xfile's address space to grab writable pages, copy the caller's buffer into the
+page, and release the pages.
+xfile readers call ``shmem_read_mapping_page_gfp`` to grab pages directly
+before copying the contents into the caller's buffer.
+In other words, xfiles ignore the VFS read and write code paths to avoid
+having to create a dummy ``struct kiocb`` and to avoid taking inode and
+freeze locks.
+tmpfs cannot be frozen, and xfiles must not be exposed to userspace.
+
+If an xfile is shared between threads to stage repairs, the caller must provide
+its own locks to coordinate access.
+For example, if a scrub function stores scan results in an xfile and needs
+other threads to provide updates to the scanned data, the scrub function must
+provide a lock for all threads to share.
+
+.. _xfarray:
+
+Arrays of Fixed-Sized Records
+`````````````````````````````
+
+In XFS, each type of indexed space metadata (free space, inodes, reference
+counts, file fork space, and reverse mappings) consists of a set of fixed-size
+records indexed with a classic B+ tree.
+Directories have a set of fixed-size dirent records that point to the names,
+and extended attributes have a set of fixed-size attribute keys that point to
+names and values.
+Quota counters and file link counters index records with numbers.
+During a repair, scrub needs to stage new records during the gathering step and
+retrieve them during the btree building step.
+
+Although this requirement can be satisfied by calling the read and write
+methods of the xfile directly, it is simpler for callers for there to be a
+higher level abstraction to take care of computing array offsets, to provide
+iterator functions, and to deal with sparse records and sorting.
+The ``xfarray`` abstraction presents a linear array for fixed-size records atop
+the byte-accessible xfile.
+
+.. _xfarray_access_patterns:
+
+Array Access Patterns
+^^^^^^^^^^^^^^^^^^^^^
+
+Array access patterns in online fsck tend to fall into three categories.
+Iteration of records is assumed to be necessary for all cases and will be
+covered in the next section.
+
+The first type of caller handles records that are indexed by position.
+Gaps may exist between records, and a record may be updated multiple times
+during the collection step.
+In other words, these callers want a sparse linearly addressed table file.
+The typical use case are quota records or file link count records.
+Access to array elements is performed programmatically via ``xfarray_load`` and
+``xfarray_store`` functions, which wrap the similarly-named xfile functions to
+provide loading and storing of array elements at arbitrary array indices.
+Gaps are defined to be null records, and null records are defined to be a
+sequence of all zero bytes.
+Null records are detected by calling ``xfarray_element_is_null``.
+They are created either by calling ``xfarray_unset`` to null out an existing
+record or by never storing anything to an array index.
+
+The second type of caller handles records that are not indexed by position
+and do not require multiple updates to a record.
+The typical use case here is rebuilding space btrees and key/value btrees.
+These callers can add records to the array without caring about array indices
+via the ``xfarray_append`` function, which stores a record at the end of the
+array.
+For callers that require records to be presentable in a specific order (e.g.
+rebuilding btree data), the ``xfarray_sort`` function can arrange the sorted
+records; this function will be covered later.
+
+The third type of caller is a bag, which is useful for counting records.
+The typical use case here is constructing space extent reference counts from
+reverse mapping information.
+Records can be put in the bag in any order, they can be removed from the bag
+at any time, and uniqueness of records is left to callers.
+The ``xfarray_store_anywhere`` function is used to insert a record in any
+null record slot in the bag; and the ``xfarray_unset`` function removes a
+record from the bag.
+
+The proposed patchset is the
+`big in-memory array
+<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=big-array>`_.
+
+Iterating Array Elements
+^^^^^^^^^^^^^^^^^^^^^^^^
+
+Most users of the xfarray require the ability to iterate the records stored in
+the array.
+Callers can probe every possible array index with the following:
+
+.. code-block:: c
+
+	xfarray_idx_t i;
+	foreach_xfarray_idx(array, i) {
+	    xfarray_load(array, i, &rec);
+
+	    /* do something with rec */
+	}
+
+All users of this idiom must be prepared to handle null records or must already
+know that there aren't any.
+
+For xfarray users that want to iterate a sparse array, the ``xfarray_iter``
+function ignores indices in the xfarray that have never been written to by
+calling ``xfile_seek_data`` (which internally uses ``SEEK_DATA``) to skip areas
+of the array that are not populated with memory pages.
+Once it finds a page, it will skip the zeroed areas of the page.
+
+.. code-block:: c
+
+	xfarray_idx_t i = XFARRAY_CURSOR_INIT;
+	while ((ret = xfarray_iter(array, &i, &rec)) == 1) {
+	    /* do something with rec */
+	}
+
+.. _xfarray_sort:
+
+Sorting Array Elements
+^^^^^^^^^^^^^^^^^^^^^^
+
+During the fourth demonstration of online repair, a community reviewer remarked
+that for performance reasons, online repair ought to load batches of records
+into btree record blocks instead of inserting records into a new btree one at a
+time.
+The btree insertion code in XFS is responsible for maintaining correct ordering
+of the records, so naturally the xfarray must also support sorting the record
+set prior to bulk loading.
+
+Case Study: Sorting xfarrays
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The sorting algorithm used in the xfarray is actually a combination of adaptive
+quicksort and a heapsort subalgorithm in the spirit of
+`Sedgewick <https://algs4.cs.princeton.edu/23quicksort/>`_ and
+`pdqsort <https://github.com/orlp/pdqsort>`_, with customizations for the Linux
+kernel.
+To sort records in a reasonably short amount of time, ``xfarray`` takes
+advantage of the binary subpartitioning offered by quicksort, but it also uses
+heapsort to hedge aginst performance collapse if the chosen quicksort pivots
+are poor.
+Both algorithms are (in general) O(n * lg(n)), but there is a wide performance
+gulf between the two implementations.
+
+The Linux kernel already contains a reasonably fast implementation of heapsort.
+It only operates on regular C arrays, which limits the scope of its usefulness.
+There are two key places where the xfarray uses it:
+
+* Sorting any record subset backed by a single xfile page.
+
+* Loading a small number of xfarray records from potentially disparate parts
+  of the xfarray into a memory buffer, and sorting the buffer.
+
+In other words, ``xfarray`` uses heapsort to constrain the nested recursion of
+quicksort, thereby mitigating quicksort's worst runtime behavior.
+
+Choosing a quicksort pivot is a tricky business.
+A good pivot splits the set to sort in half, leading to the divide and conquer
+behavior that is crucial to  O(n * lg(n)) performance.
+A poor pivot barely splits the subset at all, leading to O(n\ :sup:`2`)
+runtime.
+The xfarray sort routine tries to avoid picking a bad pivot by sampling nine
+records into a memory buffer and using the kernel heapsort to identify the
+median of the nine.
+
+Most modern quicksort implementations employ Tukey's "ninther" to select a
+pivot from a classic C array.
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
+1978), pp. 251–257.
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
+Each directory entry record needs to store entry name,
+and each extended attribute needs to store both the attribute name and value.
+The names, keys, and values can consume a large amount of memory, so the
+``xfblob`` abstraction was created to simplify management of these blobs
+atop an xfile.
+
+Blob arrays provide ``xfblob_load`` and ``xfblob_store`` functions to retrieve
+and persist objects.
+The store function returns a magic cookie for every object that it persists.
+Later, callers provide this cookie to the ``xblob_load`` to recall the object.
+The ``xfblob_free`` function frees a specific blob, and the ``xfblob_truncate``
+function frees them all because compaction is not needed.
+
+The details of repairing directories and extended attributes will be discussed
+in a subsequent section about atomic extent swapping.
+However, it should be noted that these repair functions only use blob storage
+to cache a small number of entries before adding them to a temporary ondisk
+file, which is why compaction is not required.
+
+The proposed patchset is at the start of the
+`extended attribute repair
+<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=repair-xattrs>`_ series.
+
+.. _xfbtree:
+
+In-Memory B+Trees
+`````````````````
+
+The chapter about :ref:`secondary metadata<secondary_metadata>` mentioned that
+checking and repairing of secondary metadata commonly requires coordination
+between a live metadata scan of the filesystem and writer threads that are
+updating that metadata.
+Keeping the scan data up to date requires requires the ability to propagate
+metadata updates from the filesystem into the data being collected by the scan.
+This *can* be done by appending concurrent updates into a separate log file and
+applying them before writing the new metadata to disk, but this leads to
+unbounded memory consumption if the rest of the system is very busy.
+Another option is to skip the side-log and commit live updates from the
+filesystem directly into the scan data, which trades more overhead for a lower
+maximum memory requirement.
+In both cases, the data structure holding the scan results must support indexed
+access to perform well.
+
+Given that indexed lookups of scan data is required for both strategies, online
+fsck employs the second strategy of committing live updates directly into
+scan data.
+Because xfarrays are not indexed and do not enforce record ordering, they
+are not suitable for this task.
+Conveniently, however, XFS has a library to create and maintain ordered reverse
+mapping records: the existing rmap btree code!
+If only there was a means to create one in memory.
+
+Recall that the :ref:`xfile <xfile>` abstraction represents memory pages as a
+regular file, which means that the kernel can create byte or block addressable
+virtual address spaces at will.
+The XFS buffer cache specializes in abstracting IO to block-oriented  address
+spaces, which means that adaptation of the buffer cache to interface with
+xfiles enables reuse of the entire btree library.
+Btrees built atop an xfile are collectively known as ``xfbtrees``.
+The next few sections describe how they actually work.
+
+The proposed patchset is the
+`in-memory btree
+<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=in-memory-btrees>`_
+series.
+
+Using xfiles as a Buffer Cache Target
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Two modifications are necessary to support xfiles as a buffer cache target.
+The first is to make it possible for the ``struct xfs_buftarg`` structure to
+host the ``struct xfs_buf`` rhashtable, because normally those are held by a
+per-AG structure.
+The second change is to modify the buffer ``ioapply`` function to "read" cached
+pages from the xfile and "write" cached pages back to the xfile.
+Multiple access to individual buffers is controlled by the ``xfs_buf`` lock,
+since the xfile does not provide any locking on its own.
+With this adaptation in place, users of the xfile-backed buffer cache use
+exactly the same APIs as users of the disk-backed buffer cache.
+The separation between xfile and buffer cache implies higher memory usage since
+they do not share pages, but this property could some day enable transactional
+updates to an in-memory btree.
+Today, however, it simply eliminates the need for new code.
+
+Space Management with an xfbtree
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Space management for an xfile is very simple -- each btree block is one memory
+page in size.
+These blocks use the same header format as an on-disk btree, but the in-memory
+block verifiers ignore the checksums, assuming that xfile memory is no more
+corruption-prone than regular DRAM.
+Reusing existing code here is more important than absolute memory efficiency.
+
+The very first block of an xfile backing an xfbtree contains a header block.
+The header describes the owner, height, and the block number of the root
+xfbtree block.
+
+To allocate a btree block, use ``xfile_seek_data`` to find a gap in the file.
+If there are no gaps, create one by extending the length of the xfile.
+Preallocate space for the block with ``xfile_prealloc``, and hand back the
+location.
+To free an xfbtree block, use ``xfile_discard`` (which internally uses
+``FALLOC_FL_PUNCH_HOLE``) to remove the memory page from the xfile.
+
+Populating an xfbtree
+^^^^^^^^^^^^^^^^^^^^^
+
+An online fsck function that wants to create an xfbtree should proceed as
+follows:
+
+1. Call ``xfile_create`` to create an xfile.
+
+2. Call ``xfs_alloc_memory_buftarg`` to create a buffer cache target structure
+   pointing to the xfile.
+
+3. Pass the buffer cache target, buffer ops, and other information to
+   ``xfbtree_create`` to write an initial tree header and root block to the
+   xfile.
+   Each btree type should define a wrapper that passes necessary arguments to
+   the creation function.
+   For example, rmap btrees define ``xfs_rmapbt_mem_create`` to take care of
+   all the necessary details for callers.
+   A ``struct xfbtree`` object will be returned.
+
+4. Pass the xfbtree object to the btree cursor creation function for the
+   btree type.
+   Following the example above, ``xfs_rmapbt_mem_cursor`` takes care of this
+   for callers.
+
+5. Pass the btree cursor to the regular btree functions to make queries against
+   and to update the in-memory btree.
+   For example, a btree cursor for an rmap xfbtree can be passed to the
+   ``xfs_rmap_*`` functions just like any other btree cursor.
+   See the :ref:`next section<xfbtree_commit>` for information on dealing with
+   xfbtree updates that are logged to a transaction.
+
+6. When finished, delete the btree cursor, destroy the xfbtree object, free the
+   buffer target, and the destroy the xfile to release all resources.
+
+.. _xfbtree_commit:
+
+Committing Logged xfbtree Buffers
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Although it is a clever hack to reuse the rmap btree code to handle the staging
+structure, the ephemeral nature of the in-memory btree block storage presents
+some challenges of its own.
+The XFS transaction manager must not commit buffer log items for buffers backed
+by an xfile because the log format does not understand updates for devices
+other than the data device.
+An ephemeral xfbtree probably will not exist by the time the AIL checkpoints
+log transactions back into the filesystem, and certainly won't exist during
+log recovery.
+For these reasons, any code updating an xfbtree in transaction context must
+remove the buffer log items from the transaction and write the updates into the
+backing xfile before committing or cancelling the transaction.
+
+The ``xfbtree_trans_commit`` and ``xfbtree_trans_cancel`` functions implement
+this functionality as follows:
+
+1. Find each buffer log item whose buffer targets the xfile.
+
+2. Record the dirty/ordered status of the log item.
+
+3. Detach the log item from the buffer.
+
+4. Queue the buffer to a special delwri list.
+
+5. Clear the transaction dirty flag if the only dirty log items were the ones
+   that were detached in step 3.
+
+6. Submit the delwri list to commit the changes to the xfile, if the updates
+   are being committed.
+
+After removing xfile logged buffers from the transaction in this manner, the
+transaction can be committed or cancelled.

