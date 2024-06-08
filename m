Return-Path: <linux-fsdevel+bounces-21278-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7801C900ED2
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Jun 2024 02:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84EE61F23282
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Jun 2024 00:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2695B441F;
	Sat,  8 Jun 2024 00:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cvQYtdsS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7077F;
	Sat,  8 Jun 2024 00:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717805828; cv=none; b=hREmaCcQEUxs1zO6o5h7EBFIMLHr5MrSg9Eec1VJFBFu4SgD3q08q/vbBf10c/fPu7Pw9xNYjry9nlX61FQEP8oRUHgogo69blAxLgnNPVYeu6xyY/dMkl0h0Hkex54Oh4JB2lTJfe1pkemvEQB9hI/9TsbhSAeduL01ZQFGeao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717805828; c=relaxed/simple;
	bh=ISy9lXbPJVApjdhMZ9TNJATfLx2Xg8/tHe+5v0DfUBc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XKFOp4uyH6/lkwZSHDNQcE06wHB5iasXIf+mVILOnjE7JKHB/uFvKS22kpiTRhihJVyj9SnXIqCEq4F4UdCoLdQ9gDV2nSNpT17ID/NGJE2l7mEU89Hk3qH9F6gx8YcLkREHc/Ve3746x5ccOgWAhvc9Czp4VTsoYsVeGbEqlFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cvQYtdsS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5425C3277B;
	Sat,  8 Jun 2024 00:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717805828;
	bh=ISy9lXbPJVApjdhMZ9TNJATfLx2Xg8/tHe+5v0DfUBc=;
	h=Date:From:To:Cc:Subject:From;
	b=cvQYtdsSJ+PfZYqqS9MTZCKL0OF9vvGWDQF8Yf2F4NZpODt2LxEqqslYmaBUE6tEx
	 QdbYnojAWMqjLuKX3DRXfzmGI7T0tyKCMlgEKkajkWxvpdOcGfzAx13Gf622Zt5XCv
	 LaIOMbPh+wCU2xEuhukUZNBkbFH7o/D/eAGaKv3jDzCA4+/4zV1K4kn1d17TyxCwaM
	 qFV8ZZWLRCN2VRzUz2MAWeMKegi3QXM5LQIpIdWY4o05kOqMdly08dO9yvLZ2T6fWJ
	 o8kg5BxUQ70yj9zzo+Y9M5ICYQgRThn1mMtOTVh7eoDRZdxCxWfZ+r4H9v4VuJBVcE
	 8N6pWy8ie78XA==
Date: Fri, 7 Jun 2024 17:17:07 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
	Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>, Jan Kara <jack@suse.cz>,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH] Documentation: document the design of iomap and how to port
Message-ID: <20240608001707.GD52973@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

From: Darrick J. Wong <djwong@kernel.org>

This is the fourth attempt at documenting the design of iomap and how to
port filesystems to use it.  Apologies for all the rst formatting, but
it's necessary to distinguish code from regular text.

A lot of this has been collected from various email conversations, code
comments, commit messages, my own understanding of iomap, and
Ritesh/Luis' previous efforts to create a document.  Please note a large
part of this has been taken from Dave's reply to last iomap doc
patchset. Thanks to Ritesh, Luis, Dave, Darrick, Matthew, Christoph and
other iomap developers who have taken time to explain the iomap design
in various emails, commits, comments etc.

Cc: Dave Chinner <david@fromorbit.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Inspired-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 Documentation/filesystems/index.rst |    1 
 Documentation/filesystems/iomap.rst | 1060 +++++++++++++++++++++++++++++++++++
 MAINTAINERS                         |    1 
 3 files changed, 1062 insertions(+)
 create mode 100644 Documentation/filesystems/iomap.rst

diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index 8f5c1ee02e2f..b010cc8df32d 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -34,6 +34,7 @@ algorithms work.
    seq_file
    sharedsubtree
    idmappings
+   iomap
 
    automount-support
 
diff --git a/Documentation/filesystems/iomap.rst b/Documentation/filesystems/iomap.rst
new file mode 100644
index 000000000000..a478b55e4135
--- /dev/null
+++ b/Documentation/filesystems/iomap.rst
@@ -0,0 +1,1060 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. _iomap:
+
+..
+        Dumb style notes to maintain the author's sanity:
+        Please try to start sentences on separate lines so that
+        sentence changes don't bleed colors in diff.
+        Heading decorations are documented in sphinx.rst.
+
+============================
+VFS iomap Design and Porting
+============================
+
+.. toctree::
+
+Introduction
+============
+
+iomap is a filesystem library for handling various filesystem operations
+that involves mapping of file's logical offset ranges to physical
+extents.
+This origins of this library is the file I/O path that XFS once used; it
+has now been extended to cover several other operations.
+The library provides various APIs for implementing various file and
+pagecache operations, such as:
+
+ * Pagecache reads and writes
+ * Folio write faults to the pagecache
+ * Writeback of dirty folios
+ * Direct I/O reads and writes
+ * FIEMAP
+ * lseek ``SEEK_DATA`` and ``SEEK_HOLE``
+ * swapfile activation
+
+Who Should Read This?
+=====================
+
+The target audience for this document are filesystem, storage, and
+pagecache programmers and code reviewers.
+The goal of this document is to provide a brief discussion of the
+design and capabilities of iomap, followed by a more detailed catalog
+of the interfaces presented by iomap.
+If you change iomap, please update this design document.
+
+But Why?
+========
+
+Unlike the classic Linux I/O model which breaks file I/O into small
+units (generally memory pages or blocks) and looks up space mappings on
+the basis of that unit, the iomap model asks the filesystem for the
+largest space mappings that it can create for a given file operation and
+initiates operations on that basis.
+This strategy improves the filesystem's visibility into the size of the
+operation being performed, which enables it to combat fragmentation with
+larger space allocations when possible.
+Larger space mappings improve runtime performance by amortizing the cost
+of a mapping function call into the filesystem across a larger amount of
+data.
+
+At a high level, an iomap operation `looks like this
+<https://lore.kernel.org/all/ZGbVaewzcCysclPt@dread.disaster.area/>`_:
+
+1. For each byte in the operation range...
+
+   1. Obtain space mapping via ->iomap_begin
+   2. For each sub-unit of work...
+
+      1. Revalidate the mapping and go back to (1) above, if necessary
+      2. Do the work
+
+   3. Increment operation cursor
+   4. Release the mapping via ->iomap_end, if necessary
+
+Each iomap operation will be covered in more detail below.
+This library was covered previously by an `LWN article
+<https://lwn.net/Articles/935934/>`_ and a `KernelNewbies page
+<https://kernelnewbies.org/KernelProjects/iomap>`_.
+
+Data Structures and Algorithms
+==============================
+
+Definitions
+-----------
+
+ * ``bufferhead``: Shattered remnants of the old buffer cache.
+ * ``fsblock``: The block size of a file, also known as ``i_blocksize``.
+ * ``i_rwsem``: The VFS ``struct inode`` rwsemaphore.
+ * ``invalidate_lock``: The pagecache ``struct address_space``
+   rwsemaphore that protects against folio removal.
+
+struct iomap_ops
+----------------
+
+Every iomap function requires the filesystem to pass an operations
+structure to obtain a mapping and (optionally) to release the mapping.
+
+.. code-block:: c
+
+ struct iomap_ops {
+     int (*iomap_begin)(struct inode *inode, loff_t pos, loff_t length,
+                        unsigned flags, struct iomap *iomap,
+                        struct iomap *srcmap);
+
+     int (*iomap_end)(struct inode *inode, loff_t pos, loff_t length,
+                      ssize_t written, unsigned flags,
+                      struct iomap *iomap);
+ };
+
+The ``->iomap_begin`` function is called to obtain one mapping for the
+range of bytes specified by ``pos`` and ``length`` for the file
+``inode``.
+
+Each iomap operation describes the requested operation through the
+``flags`` argument.
+The exact value of ``flags`` will be documented in the
+operation-specific sections below, but these principles apply generally:
+
+ * For a write operation, ``IOMAP_WRITE`` will be set.
+   Filesystems must not return ``IOMAP_HOLE`` mappings.
+
+ * For any other operation, ``IOMAP_WRITE`` will not be set.
+
+ * For any operation targetting direct access to storage (fsdax),
+   ``IOMAP_DAX`` will be set.
+
+If it is necessary to read existing file contents from a `different
+<https://lore.kernel.org/all/20191008071527.29304-9-hch@lst.de/>`_ device or
+address range on a device, the filesystem should return that information via
+``srcmap``.
+Only pagecache and fsdax operations support reading from one mapping and
+writing to another.
+
+After the operation completes, the ``->iomap_end`` function, if present,
+is called to signal that iomap is finished with a mapping.
+Typically, implementations will use this function to tear down any
+context that were set up in ``->iomap_begin``.
+For example, a write might wish to commit the reservations for the bytes
+that were operated upon and unreserve any space that was not operated
+upon.
+``written`` might be zero if no bytes were touched.
+``flags`` will contain the same value passed to ``->iomap_begin``.
+iomap ops for reads are not likely to need to supply this function.
+
+Both functions should return a negative errno code on error, or zero.
+
+struct iomap
+------------
+
+The filesystem returns the mappings via the following structure.
+For documentation purposes, the structure has been reordered to group
+fields that go together logically.
+
+.. code-block:: c
+
+ struct iomap {
+     loff_t                       offset;
+     u64                          length;
+
+     u16                          type;
+     u16                          flags;
+
+     u64                          addr;
+     struct block_device          *bdev;
+     struct dax_device            *dax_dev;
+     void                         *inline_data;
+
+     void                         *private;
+
+     const struct iomap_folio_ops *folio_ops;
+
+     u64                          validity_cookie;
+ };
+
+The information is useful for translating file operations into action.
+The actions taken are specific to the target of the operation, such as
+disk cache, physical storage devices, or another part of the kernel.
+
+ * ``offset`` and ``length`` describe the range of file offsets, in
+   bytes, covered by this mapping.
+   These fields must always be set by the filesystem.
+
+ * ``type`` describes the type of the space mapping:
+
+   * **IOMAP_HOLE**: No storage has been allocated.
+     This type must never be returned in response to an IOMAP_WRITE
+     operation because writes must allocate and map space, and return
+     the mapping.
+     The ``addr`` field must be set to ``IOMAP_NULL_ADDR``.
+     iomap does not support writing (whether via pagecache or direct
+     I/O) to a hole.
+
+   * **IOMAP_DELALLOC**: A promise to allocate space at a later time
+     ("delayed allocation").
+     If the filesystem returns IOMAP_F_NEW here and the write fails, the
+     ``->iomap_end`` function must delete the reservation.
+     The ``addr`` field must be set to ``IOMAP_NULL_ADDR``.
+
+   * **IOMAP_MAPPED**: The file range maps to specific space on the
+     storage device.
+     The device is returned in ``bdev`` or ``dax_dev``.
+     The device address, in bytes, is returned via ``addr``.
+
+   * **IOMAP_UNWRITTEN**: The file range maps to specific space on the
+     storage device, but the space has not yet been initialized.
+     The device is returned in ``bdev`` or ``dax_dev``.
+     The device address, in bytes, is returned via ``addr``.
+     Reads will return zeroes to userspace.
+     For a write or writeback operation, the ioend should update the
+     mapping to MAPPED.
+
+   * **IOMAP_INLINE**: The file range maps to the memory buffer
+     specified by ``inline_data``.
+     For write operation, the ``->iomap_end`` function presumably
+     handles persisting the data.
+     The ``addr`` field must be set to ``IOMAP_NULL_ADDR``.
+
+ * ``flags`` describe the status of the space mapping.
+   These flags should be set by the filesystem in ``->iomap_begin``:
+
+   * **IOMAP_F_NEW**: The space under the mapping is newly allocated.
+     Areas that will not be written to must be zeroed.
+     If a write fails and the mapping is a space reservation, the
+     reservation must be deleted.
+
+   * **IOMAP_F_DIRTY**: The inode will have uncommitted metadata needed
+     to access any data written.
+     fdatasync is required to commit these changes to persistent
+     storage.
+     This needs to take into account metadata changes that *may* be made
+     at I/O completion, such as file size updates from direct I/O.
+
+   * **IOMAP_F_SHARED**: The space under the mapping is shared.
+     Copy on write is necessary to avoid corrupting other file data.
+
+   * **IOMAP_F_BUFFER_HEAD**: This mapping requires the use of buffer
+     heads for pagecache operations.
+     Do not add more uses of this.
+
+   * **IOMAP_F_MERGED**: Multiple contiguous block mappings were
+     coalesced into this single mapping.
+     This is only useful for FIEMAP.
+
+   * **IOMAP_F_XATTR**: The mapping is for extended attribute data, not
+     regular file data.
+     This is only useful for FIEMAP.
+
+   * **IOMAP_F_PRIVATE**: Starting with this value, the upper bits can
+     be set by the filesystem for its own purposes.
+
+   These flags can be set by iomap itself during file operations.
+   The filesystem should supply an ``->iomap_end`` function to observe
+   these flags:
+
+   * **IOMAP_F_SIZE_CHANGED**: The file size has changed as a result of
+     using this mapping.
+
+   * **IOMAP_F_STALE**: The mapping was found to be stale.
+     iomap will call ``->iomap_end`` on this mapping and then
+     ``->iomap_begin`` to obtain a new mapping.
+
+   Currently, these flags are only set by pagecache operations.
+
+ * ``addr`` describes the device address, in bytes.
+
+ * ``bdev`` describes the block device for this mapping.
+   This only needs to be set for mapped or unwritten operations.
+
+ * ``dax_dev`` describes the DAX device for this mapping.
+   This only needs to be set for mapped or unwritten operations, and
+   only for a fsdax operation.
+
+ * ``inline_data`` points to a memory buffer for I/O involving
+   ``IOMAP_INLINE`` mappings.
+   This value is ignored for all other mapping types.
+
+ * ``private`` is a pointer to `filesystem-private information
+   <https://lore.kernel.org/all/20180619164137.13720-7-hch@lst.de/>`_.
+   This value will be passed unchanged to ``->iomap_end``.
+
+ * ``folio_ops`` will be covered in the section on pagecache operations.
+
+ * ``validity_cookie`` is a magic freshness value set by the filesystem
+   that should be used to detect stale mappings.
+   For pagecache operations this is critical for correct operation
+   because page faults can occur, which implies that filesystem locks
+   should not be held between ``->iomap_begin`` and ``->iomap_end``.
+   Filesystems with completely static mappings need not set this value.
+   Only pagecache operations revalidate mappings.
+
+   XXX: Should fsdax revalidate as well?
+
+Validation
+==========
+
+**NOTE**: iomap only handles mapping and I/O.
+Filesystems must still call out to the VFS to check input parameters
+and file state before initiating an I/O operation.
+It does not handle updating of timestamps, stripping privileges, or
+access control.
+
+Locking Hierarchy
+=================
+
+iomap requires that filesystems provide their own locking.
+There are no locks within iomap itself, though in the course of an
+operation iomap may take other locks (e.g. folio/dax locks) as part of
+an I/O operation.
+Locking with iomap can be split into two categories: above and below
+iomap.
+
+The upper level of lock must coordinate the iomap operation with other
+iomap operations.
+Generally, the filesystem must take VFS/pagecache locks such as
+``i_rwsem`` or ``invalidate_lock`` before calling into iomap.
+The exact locking requirements are specific to the type of operation.
+
+The lower level of lock must coordinate access to the mapping
+information.
+This lock is filesystem specific and should be held during
+``->iomap_begin`` while sampling the mapping and validity cookie.
+
+The general locking hierarchy in iomap is:
+
+ * VFS or pagecache lock
+
+   * Internal filesystem specific mapping lock
+
+   * iomap operation-specific lock
+
+The exact locking requirements are specific to the filesystem; for
+certain operations, some of these locks can be elided.
+All further mention of locking are *recommendations*, not mandates.
+Each filesystem author must figure out the locking for themself.
+
+iomap Operations
+================
+
+Below are a discussion of the file operations that iomap implements.
+
+Buffered I/O
+------------
+
+Buffered I/O is the default file I/O path in Linux.
+File contents are cached in memory ("pagecache") to satisfy reads and
+writes.
+Dirty cache will be written back to disk at some point that can be
+forced via ``fsync`` and variants.
+
+iomap implements nearly all the folio and pagecache management that
+filesystems once had to implement themselves.
+This means that the filesystem need not know the details of allocating,
+mapping, managing uptodate and dirty state, or writeback of pagecache
+folios.
+Unless the filesystem explicitly opts in to buffer heads, they will not
+be used, which makes buffered I/O much more efficient, and ``willy``
+much happier.
+
+struct address_space_operations
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The following iomap functions can be referenced directly from the
+address space operations structure:
+
+ * ``iomap_dirty_folio``
+ * ``iomap_release_folio``
+ * ``iomap_invalidate_folio``
+ * ``iomap_is_partially_uptodate``
+
+The following address space operations can be wrapped easily:
+
+ * ``read_folio``
+ * ``readahead``
+ * ``writepages``
+ * ``bmap``
+ * ``swap_activate``
+
+struct iomap_folio_ops
+~~~~~~~~~~~~~~~~~~~~~~
+
+The ``->iomap_begin`` function for pagecache operations may set the
+``struct iomap::folio_ops`` field to an ops structure to override
+default behaviors of iomap:
+
+.. code-block:: c
+
+ struct iomap_folio_ops {
+     struct folio *(*get_folio)(struct iomap_iter *iter, loff_t pos,
+                                unsigned len);
+     void (*put_folio)(struct inode *inode, loff_t pos, unsigned copied,
+                       struct folio *folio);
+     bool (*iomap_valid)(struct inode *inode, const struct iomap *iomap);
+ };
+
+iomap calls these functions:
+
+  - ``get_folio``: Called to allocate and return an active reference to
+    a locked folio prior to starting a write.
+    If this function is not provided, iomap will call
+    ``iomap_get_folio``.
+    This could be used to `set up per-folio filesystem state
+    <https://lore.kernel.org/all/20190429220934.10415-5-agruenba@redhat.com/>`_
+    for a write.
+
+  - ``put_folio``: Called to unlock and put a folio after a pagecache
+    operation completes.
+    If this function is not provided, iomap will ``folio_unlock`` and
+    ``folio_put`` on its own.
+    This could be used to `commit per-folio filesystem state
+    <https://lore.kernel.org/all/20180619164137.13720-6-hch@lst.de/>`_
+    that was set up by ``->get_folio``.
+
+  - ``iomap_valid``: The filesystem may not hold locks between
+    ``->iomap_begin`` and ``->iomap_end`` because pagecache operations
+    can take folio locks, fault on userspace pages, initiate writeback
+    for memory reclamation, or engage in other time-consuming actions.
+    If a file's space mapping data are mutable, it is possible that the
+    mapping for a particular pagecache folio can `change in the time it
+    takes
+    <https://lore.kernel.org/all/20221123055812.747923-8-david@fromorbit.com/>`_
+    to allocate, install, and lock that folio.
+    For such files, the mapping *must* be revalidated after the folio
+    lock has been taken so that iomap can manage the folio correctly.
+    The filesystem's ``->iomap_begin`` function must sample a sequence
+    counter into ``struct iomap::validity_cookie`` at the same time that
+    it populates the mapping fields.
+    It must then provide a ``->iomap_valid`` function to compare the
+    validity cookie against the source counter and return whether or not
+    the mapping is still valid.
+    If the mapping is not valid, the mapping will be sampled again.
+
+These ``struct kiocb`` flags are significant for buffered I/O with
+iomap:
+
+ * ``IOCB_NOWAIT``: Only proceed with the I/O if mapping data are
+   already in memory, we do not have to initiate other I/O, and we
+   acquire all filesystem locks without blocking.
+   Neither this flag nor its definition ``RWF_NOWAIT`` actually define
+   what this flag means, so this is the best the author could come up
+   with.
+
+Internal per-Folio State
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+If the fsblock size matches the size of a pagecache folio, it is assumed
+that all disk I/O operations will operate on the entire folio.
+The uptodate (memory contents are at least as new as what's on disk) and
+dirty (memory contents are newer than what's on disk) status of the
+folio are all that's needed for this case.
+
+If the fsblock size is less than the size of a pagecache folio, iomap
+tracks the per-fsblock uptodate and dirty state itself.
+This enables iomap to handle both "bs < ps" `filesystems
+<https://lore.kernel.org/all/20230725122932.144426-1-ritesh.list@gmail.com/>`_
+and large folios in the pagecache.
+
+iomap internally tracks two state bits per fsblock:
+
+ * ``uptodate``: iomap will try to keep folios fully up to date.
+   If there are read(ahead) errors, those fsblocks will not be marked
+   uptodate.
+   The folio itself will be marked uptodate when all fsblocks within the
+   folio are uptodate.
+
+ * ``dirty``: iomap will set the per-block dirty state when programs
+   write to the file.
+   The folio itself will be marked dirty when any fsblock within the
+   folio is dirty.
+
+iomap also tracks the amount of read and write disk IOs that are in
+flight.
+This structure is much lighter weight than ``struct buffer_head``.
+
+Filesystems wishing to turn on large folios in the pagecache should call
+``mapping_set_large_folios`` when initializing the incore inode.
+
+Readahead and Reads
+~~~~~~~~~~~~~~~~~~~
+
+The ``iomap_readahead`` function initiates readahead to the pagecache.
+The ``iomap_read_folio`` function reads one folio's worth of data into
+the pagecache.
+The ``flags`` argument to ``->iomap_begin`` will be set to zero.
+The pagecache takes whatever locks it needs before calling the
+filesystem.
+
+Writes
+~~~~~~
+
+The ``iomap_file_buffered_write`` function writes an ``iocb`` to the
+pagecache.
+``IOMAP_WRITE`` or ``IOMAP_WRITE`` | ``IOMAP_NOWAIT`` will be passed as
+the ``flags`` argument to ``->iomap_begin``.
+Callers commonly take ``i_rwsem`` in either shared or exclusive mode.
+
+mmap Write Faults
+^^^^^^^^^^^^^^^^^
+
+The ``iomap_page_mkwrite`` function handles a write fault to a folio the
+pagecache.
+``IOMAP_WRITE | IOMAP_FAULT`` will be passed as the ``flags`` argument
+to ``->iomap_begin``.
+Callers commonly take the mmap ``invalidate_lock`` in shared or
+exclusive mode.
+
+Write Failures
+^^^^^^^^^^^^^^
+
+After a short write to the pagecache, the areas not written will not
+become marked dirty.
+The filesystem must arrange to `cancel
+<https://lore.kernel.org/all/20221123055812.747923-6-david@fromorbit.com/>`_
+such `reservations
+<https://lore.kernel.org/linux-xfs/20220817093627.GZ3600936@dread.disaster.area/>`_
+because writeback will not consume the reservation.
+The ``iomap_file_buffered_write_punch_delalloc`` can be called from a
+``->iomap_end`` function to find all the clean areas of the folios
+caching a fresh (``IOMAP_F_NEW``) delalloc mapping.
+It takes the ``invalidate_lock``.
+
+The filesystem should supply a callback ``punch`` will be called for
+each file range in this state.
+This function must *only* remove delayed allocation reservations, in
+case another thread racing with the current thread writes successfully
+to the same region and triggers writeback to flush the dirty data out to
+disk.
+
+Truncation
+^^^^^^^^^^
+
+Filesystems can call ``iomap_truncate_page`` to zero the bytes in the
+pagecache from EOF to the end of the fsblock during a file truncation
+operation.
+``truncate_setsize`` or ``truncate_pagecache`` will take care of
+everything after the EOF block.
+``IOMAP_ZERO`` will be passed as the ``flags`` argument to
+``->iomap_begin``.
+Callers typically take ``i_rwsem`` and ``invalidate_lock`` in exclusive
+mode.
+
+Zeroing for File Operations
+^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Filesystems can call ``iomap_zero_range`` to perform zeroing of the
+pagecache for non-truncation file operations that are not aligned to
+the fsblock size.
+``IOMAP_ZERO`` will be passed as the ``flags`` argument to
+``->iomap_begin``.
+Callers typically take ``i_rwsem`` and ``invalidate_lock`` in exclusive
+mode.
+
+Unsharing Reflinked File Data
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Filesystems can call ``iomap_file_unshare`` to force a file sharing
+storage with another file to preemptively copy the shared data to newly
+allocate storage.
+``IOMAP_WRITE | IOMAP_UNSHARE`` will be passed as the ``flags`` argument
+to ``->iomap_begin``.
+Callers typically take ``i_rwsem`` and ``invalidate_lock`` in exclusive
+mode.
+
+Writeback
+~~~~~~~~~
+
+Filesystems can call ``iomap_writepages`` to respond to a request to
+write dirty pagecache folios to disk.
+The ``mapping`` and ``wbc`` parameters should be passed unchanged.
+The ``wpc`` pointer should be allocated by the filesystem and must
+be initialized to zero.
+
+The pagecache will lock each folio before trying to schedule it for
+writeback.
+It does not lock ``i_rwsem`` or ``invalidate_lock``.
+
+The dirty bit will be cleared for all folios run through the
+``->map_blocks`` machinery described below even if the writeback fails.
+This is to prevent dirty folio clots when storage devices fail; an
+``-EIO`` is recorded for userspace to collect via ``fsync``.
+
+The ``ops`` structure must be specified and is as follows:
+
+struct iomap_writeback_ops
+^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+.. code-block:: c
+
+ struct iomap_writeback_ops {
+     int (*map_blocks)(struct iomap_writepage_ctx *wpc, struct inode *inode,
+                       loff_t offset, unsigned len);
+     int (*prepare_ioend)(struct iomap_ioend *ioend, int status);
+     void (*discard_folio)(struct folio *folio, loff_t pos);
+ };
+
+The fields are as follows:
+
+  - ``map_blocks``: Sets ``wpc->iomap`` to the space mapping of the file
+    range (in bytes) given by ``offset`` and ``len``.
+    iomap calls this function for each fs block in each dirty folio,
+    even if the mapping returned is longer than one fs block.
+    Do not return ``IOMAP_INLINE`` mappings here; the ``->iomap_end``
+    function must deal with persisting written data.
+    Filesystems can skip a potentially expensive mapping lookup if the
+    mappings have not changed.
+    This revalidation must be open-coded by the filesystem; it is
+    unclear if ``iomap::validity_cookie`` can be reused for this
+    purpose.
+    This function is required.
+
+  - ``prepare_ioend``: Enables filesystems to transform the writeback
+    ioend or perform any other prepatory work before the writeback I/O
+    is submitted.
+    A filesystem can override the ``->bi_end_io`` function for its own
+    purposes, such as kicking the ioend completion to a workqueue if the
+    bio is completed in interrupt context.
+    This function is optional.
+
+  - ``discard_folio``: iomap calls this function after ``->map_blocks``
+    fails schedule I/O for any part of a dirty folio.
+    The function should throw away any reservations that may have been
+    made for the write.
+    The folio will be marked clean and an ``-EIO`` recorded in the
+    pagecache.
+    Filesystems can use this callback to `remove
+    <https://lore.kernel.org/all/20201029163313.1766967-1-bfoster@redhat.com/>`_
+    delalloc reservations to avoid having delalloc reservations for
+    clean pagecache.
+    This function is optional.
+
+Writeback ioend Completion
+^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+iomap creates chains of ``struct iomap_ioend`` objects that wrap the
+``bio`` that is used to write pagecache data to disk.
+By default, iomap finishes writeback ioends by clearing the writeback
+bit on the folios attached to the ``ioend``.
+If the write failed, it will also set the error bits on the folios and
+the address space.
+This can happen in interrupt or process context, depending on the
+storage device.
+
+Filesystems that need to update internal bookkeeping (e.g. unwritten
+extent conversions) should provide a ``->prepare_ioend`` function to
+override the ``struct iomap_end::bio::bi_end_io`` with its own function.
+This function should call ``iomap_finish_ioends`` after finishing its
+own work.
+
+Some filesystems may wish to `amortize the cost of running metadata
+transactions
+<https://lore.kernel.org/all/20220120034733.221737-1-david@fromorbit.com/>`_
+for post-writeback updates by batching them.
+They may also require transactions to run from process context, which
+implies punting batches to a workqueue.
+iomap ioends contain a ``list_head`` to enable batching.
+
+Given a batch of ioends, iomap has a few helpers to assist with
+amortization:
+
+ * ``iomap_sort_ioends``: Sort all the ioends in the list by file
+   offset.
+
+ * ``iomap_ioend_try_merge``: Given an ioend that is not in any list and
+   a separate list of sorted ioends, merge as many of the ioends from
+   the head of the list into the given ioend.
+   ioends can only be merged if the file range and storage addresses are
+   contiguous; the unwritten and shared status are the same; and the
+   write I/O outcome is the same.
+   The merged ioends become their own list.
+
+ * ``iomap_finish_ioends``: Finish an ioend that possibly has other
+   ioends linked to it.
+
+Direct I/O
+----------
+
+In Linux, direct I/O is defined as file I/O that is issued directly to
+storage, bypassing the pagecache.
+
+The ``iomap_dio_rw`` function implements O_DIRECT (direct I/O) reads and
+writes for files.
+An optional ``ops`` parameter can be passed to change the behavior of
+direct I/O.
+The ``done_before`` parameter should be set if writes have been
+initiated prior to the call.
+The direction of the I/O is determined from the ``iocb`` passed in.
+
+The ``flags`` argument can be any of the following values:
+
+ * ``IOMAP_DIO_FORCE_WAIT``: Wait for the I/O to complete even if the
+   kiocb is not synchronous.
+
+ * ``IOMAP_DIO_OVERWRITE_ONLY``: Allocating blocks, zeroing partial
+   blocks, and extensions of the file size are not allowed.
+   The entire file range must to map to a single written or unwritten
+   extent.
+   This flag exists to enable issuing concurrent direct IOs with only
+   the shared ``i_rwsem`` held when the file I/O range is not aligned to
+   the filesystem block size.
+   ``-EAGAIN`` will be returned if the operation cannot proceed.
+
+ * ``IOMAP_DIO_PARTIAL``: If a page fault occurs, return whatever
+   progress has already been made.
+   The caller may deal with the page fault and retry the operation.
+
+These ``struct kiocb`` flags are significant for direct I/O with iomap:
+
+ * ``IOCB_NOWAIT``: Only proceed with the I/O if mapping data are
+   already in memory, we do not have to initiate other I/O, and we
+   acquire all filesystem locks without blocking.
+
+ * ``IOCB_SYNC``: Ensure that the device has persisted data to disk
+   before completing the call.
+   In the case of pure overwrites, the I/O may be issued with FUA
+   enabled.
+
+ * ``IOCB_HIPRI``: Poll for I/O completion instead of waiting for an
+   interrupt.
+   Only meaningful for asynchronous I/O, and only if the entire I/O can
+   be issued as a single ``struct bio``.
+
+ * ``IOCB_DIO_CALLER_COMP``: Try to run I/O completion from the caller's
+   process context.
+   See ``linux/fs.h`` for more details.
+
+Filesystems should call ``iomap_dio_rw`` from ``->read_iter`` and
+``->write_iter``, and set ``FMODE_CAN_ODIRECT`` in the ``->open``
+function for the file.
+They should not set ``->direct_IO``, which is deprecated.
+
+If a filesystem wishes to perform its own work before direct I/O
+completion, it should call ``__iomap_dio_rw``.
+If its return value is not an error pointer or a NULL pointer, the
+filesystem should pass the return value to ``iomap_dio_complete`` after
+finishing its internal work.
+
+Direct Reads
+~~~~~~~~~~~~
+
+A direct I/O read initiates a read I/O from the storage device to the
+caller's buffer.
+Dirty parts of the pagecache are flushed to storage before initiating
+the read io.
+The ``flags`` value for ``->iomap_begin`` will be ``IOMAP_DIRECT`` with
+any combination of the following enhancements:
+
+ * ``IOMAP_NOWAIT``: Read if mapping data are already in memory.
+   Does not initiate other I/O or block on filesystem locks.
+
+Callers commonly hold ``i_rwsem`` in shared mode.
+
+Direct Writes
+~~~~~~~~~~~~~
+
+A direct I/O write initiates a write I/O to the storage device to the
+caller's buffer.
+Dirty parts of the pagecache are flushed to storage before initiating
+the write io.
+The pagecache is invalidated both before and after the write io.
+The ``flags`` value for ``->iomap_begin`` will be ``IOMAP_DIRECT |
+IOMAP_WRITE`` with any combination of the following enhancements:
+
+ * ``IOMAP_NOWAIT``: Write if mapping data are already in memory.
+   Does not initiate other I/O or block on filesystem locks.
+ * ``IOMAP_OVERWRITE_ONLY``: Allocating blocks and zeroing partial
+   blocks is not allowed.
+   The entire file range must to map to a single written or unwritten
+   extent.
+   The file I/O range must be aligned to the filesystem block size.
+
+Callers commonly hold ``i_rwsem`` in shared or exclusive mode.
+
+struct iomap_dio_ops:
+~~~~~~~~~~~~~~~~~~~~~
+.. code-block:: c
+
+ struct iomap_dio_ops {
+     void (*submit_io)(const struct iomap_iter *iter, struct bio *bio,
+                       loff_t file_offset);
+     int (*end_io)(struct kiocb *iocb, ssize_t size, int error,
+                   unsigned flags);
+     struct bio_set *bio_set;
+ };
+
+The fields of this structure are as follows:
+
+  - ``submit_io``: iomap calls this function when it has constructed a
+    ``struct bio`` object for the I/O requested, and wishes to submit it
+    to the block device.
+    If no function is provided, ``submit_bio`` will be called directly.
+    Filesystems that would like to perform additional work before (e.g.
+    data replication for btrfs) should implement this function.
+
+  - ``end_io``: This is called after the ``struct bio`` completes.
+    This function should perform post-write conversions of unwritten
+    extent mappings, handle write failures, etc.
+    The ``flags`` argument may be set to a combination of the following:
+
+    * ``IOMAP_DIO_UNWRITTEN``: The mapping was unwritten, so the ioend
+      should mark the extent as written.
+
+    * ``IOMAP_DIO_COW``: Writing to the space in the mapping required a
+      copy on write operation, so the ioend should switch mappings.
+
+  - ``bio_set``: This allows the filesystem to provide a custom bio_set
+    for allocating direct I/O bios.
+    This enables filesystems to `stash additional per-bio information
+    <https://lore.kernel.org/all/20220505201115.937837-3-hch@lst.de/>`_
+    for private use.
+    If this field is NULL, generic ``struct bio`` objects will be used.
+
+Filesystems that want to perform extra work after an I/O completion
+should set a custom ``->bi_end_io`` function via ``->submit_io``.
+Afterwards, the custom endio function must call
+``iomap_dio_bio_end_io`` to finish the direct I/O.
+
+DAX I/O
+-------
+
+Storage devices that can be directly mapped as memory support a new
+access mode known as "fsdax".
+
+fsdax Reads
+~~~~~~~~~~~
+
+A fsdax read performs a memcpy from storage device to the caller's
+buffer.
+The ``flags`` value for ``->iomap_begin`` will be ``IOMAP_DAX`` with any
+combination of the following enhancements:
+
+ * ``IOMAP_NOWAIT``: Read if mapping data are already in memory.
+   Does not initiate other I/O or block on filesystem locks.
+
+Callers commonly hold ``i_rwsem`` in shared mode.
+
+fsdax Writes
+~~~~~~~~~~~~
+
+A fsdax write initiates a memcpy to the storage device to the caller's
+buffer.
+The ``flags`` value for ``->iomap_begin`` will be ``IOMAP_DAX |
+IOMAP_WRITE`` with any combination of the following enhancements:
+
+ * ``IOMAP_NOWAIT``: Write if mapping data are already in memory.
+   Does not initiate other I/O or block on filesystem locks.
+
+ * ``IOMAP_OVERWRITE_ONLY``: Allocating blocks and zeroing partial
+   blocks is not allowed.
+   The entire file range must to map to a single written or unwritten
+   extent.
+   The file I/O range must be aligned to the filesystem block size.
+
+Callers commonly hold ``i_rwsem`` in exclusive mode.
+
+mmap Faults
+~~~~~~~~~~~
+
+The ``dax_iomap_fault`` function handles read and write faults to fsdax
+storage.
+For a read fault, ``IOMAP_DAX | IOMAP_FAULT`` will be passed as the
+``flags`` argument to ``->iomap_begin``.
+For a write fault, ``IOMAP_DAX | IOMAP_FAULT | IOMAP_WRITE`` will be
+passed as the ``flags`` argument to ``->iomap_begin``.
+
+Callers commonly hold the same locks as they do to call their iomap
+pagecache counterparts.
+
+Truncation, fallocate, and Unsharing
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+For fsdax files, the following functions are provided to replace their
+iomap pagecache I/O counterparts.
+The ``flags`` argument to ``->iomap_begin`` are the same as the
+pagecache counterparts, with ``IOMAP_DIO`` added.
+
+ * ``dax_file_unshare``
+ * ``dax_zero_range``
+ * ``dax_truncate_page``
+
+Callers commonly hold the same locks as they do to call their iomap
+pagecache counterparts.
+
+SEEK_DATA
+---------
+
+The ``iomap_seek_data`` function implements the SEEK_DATA "whence" value
+for llseek.
+``IOMAP_REPORT`` will be passed as the ``flags`` argument to
+``->iomap_begin``.
+
+For unwritten mappings, the pagecache will be searched.
+Regions of the pagecache with a folio mapped and uptodate fsblocks
+within those folios will be reported as data areas.
+
+Callers commonly hold ``i_rwsem`` in shared mode.
+
+SEEK_HOLE
+---------
+
+The ``iomap_seek_hole`` function implements the SEEK_HOLE "whence" value
+for llseek.
+``IOMAP_REPORT`` will be passed as the ``flags`` argument to
+``->iomap_begin``.
+
+For unwritten mappings, the pagecache will be searched.
+Regions of the pagecache with no folio mapped, or a !uptodate fsblock
+within a folio will be reported as sparse hole areas.
+
+Callers commonly hold ``i_rwsem`` in shared mode.
+
+Swap File Activation
+--------------------
+
+The ``iomap_swapfile_activate`` function finds all the base-page aligned
+regions in a file and sets them up as swap space.
+The file will be ``fsync()``'d before activation.
+``IOMAP_REPORT`` will be passed as the ``flags`` argument to
+``->iomap_begin``.
+All mappings must be mapped or unwritten; cannot be dirty or shared, and
+cannot span multiple block devices.
+Callers must hold ``i_rwsem`` in exclusive mode; this is already
+provided by ``swapon``.
+
+Extent Map Reporting (FS_IOC_FIEMAP)
+------------------------------------
+
+The ``iomap_fiemap`` function exports file extent mappings to userspace
+in the format specified by the ``FS_IOC_FIEMAP`` ioctl.
+``IOMAP_REPORT`` will be passed as the ``flags`` argument to
+``->iomap_begin``.
+Callers commonly hold ``i_rwsem`` in shared mode.
+
+Block Map Reporting (FIBMAP)
+----------------------------
+
+``iomap_bmap`` implements FIBMAP.
+The calling conventions are the same as for FIEMAP.
+This function is only provided to maintain compatibility for filesystems
+that implemented FIBMAP prior to conversion.
+This ioctl is deprecated; do not add a FIBMAP implementation to
+filesystems that do not have it.
+Callers should probably hold ``i_rwsem`` in shared mode, but this is
+unclear.
+
+Porting Guide
+=============
+
+Why Convert to iomap?
+---------------------
+
+There are several reasons to convert a filesystem to iomap:
+
+ 1. The classic Linux I/O path is not terribly efficient.
+    Pagecache operations lock a single base page at a time and then call
+    into the filesystem to return a mapping for only that page.
+    Direct I/O operations build I/O requests a single file block at a
+    time.
+    This worked well enough for direct/indirect-mapped filesystems such
+    as ext2, but is very inefficient for extent-based filesystems such
+    as XFS.
+
+ 2. Large folios are only supported via iomap; there are no plans to
+    convert the old buffer_head path to use them.
+
+ 3. Direct access to storage on memory-like devices (fsdax) is only
+    supported via iomap.
+
+ 4. Lower maintenance overhead for individual filesystem maintainers.
+    iomap handles common pagecache related operations itself, such as
+    allocating, instantiating, locking, and unlocking of folios.
+    No ->write_begin(), ->write_end() or direct_IO
+    address_space_operations are required to be implemented by
+    filesystem using iomap.
+
+How to Convert to iomap?
+------------------------
+
+First, add ``#include <linux/iomap.h>`` from your source code and add
+``select FS_IOMAP`` to your filesystem's Kconfig option.
+Build the kernel, run fstests with the ``-g all`` option across a wide
+variety of your filesystem's supported configurations to build a
+baseline of which tests pass and which ones fail.
+
+The recommended approach is first to implement ``->iomap_begin`` (and
+``->iomap->end`` if necessary) to allow iomap to obtain a read-only
+mapping of a file range.
+In most cases, this is a relatively trivial conversion of the existing
+``get_block()`` function for read-only mappings.
+``FS_IOC_FIEMAP`` is a good first target because it is trivial to
+implement support for it and then to determine that the extent map
+iteration is correct from userspace.
+If FIEMAP is returning the correct information, it's a good sign that
+other read-only mapping operations will do the right thing.
+
+Next, modify the filesystem's ``get_block(create = false)``
+implementation to use the new ``->iomap_begin`` implementation to map
+file space for selected read operations.
+Hide behind a debugging knob the ability to switch on the iomap mapping
+functions for selected call paths.
+It is necessary to write some code to fill out the bufferhead-based
+mapping information from the ``iomap`` structure, but the new functions
+can be tested without needing to implement any iomap APIs.
+
+Once the read-only functions are working like this, convert each high
+level file operation one by one to use iomap native APIs instead of
+going through ``get_block()``.
+Done one at a time, regressions should be self evident.
+You *do* have a regression test baseline for fstests, right?
+It is suggested to convert swap file activation, ``SEEK_DATA``, and
+``SEEK_HOLE`` before tackling the I/O paths.
+A likely complexity at this point will be converting the buffered read
+I/O path because of bufferheads.
+The buffered read I/O paths doesn't need to be converted yet, though the
+direct I/O read path should be converted in this phase.
+
+At this point, you should look over your ``->iomap_begin`` function.
+If it switches between large blocks of code based on dispatching of the
+``flags`` argument, you should consider breaking it up into
+per-operation iomap ops with smaller, more cohesive functions.
+XFS is a good example of this.
+
+The next thing to do is implement ``get_blocks(create == true)``
+functionality in the ``->iomap_begin``/``->iomap_end`` methods.
+It is strongly recommended to create separate mapping functions and
+iomap ops for write operations.
+Then convert the direct I/O write path to iomap, and start running fsx
+w/ DIO enabled in earnest on filesystem.
+This will flush out lots of data integrity corner case bugs that the new
+write mapping implementation introduces.
+
+Now, convert any remaining file operations to call the iomap functions.
+This will get the entire filesystem using the new mapping functions, and
+they should largely be debugged and working correctly after this step.
+
+Most likely at this point, the buffered read and write paths will still
+to be converted.
+The mapping functions should all work correctly, so all that needs to be
+done is rewriting all the code that interfaces with bufferheads to
+interface with iomap and folios.
+It is much easier first to get regular file I/O (without any fancy
+features like fscrypt, fsverity, compression, or data=journaling)
+converted to use iomap.
+Some of those fancy features (fscrypt and compression) aren't
+implemented yet in iomap.
+For unjournalled filesystems that use the pagecache for symbolic links
+and directories, you might also try converting their handling to iomap.
+
+The rest is left as an exercise for the reader, as it will be different
+for every filesystem.
+If you encounter problems, email the people and lists in
+``get_maintainers.pl`` for help.
+
+Bugs and Limitations
+====================
+
+ * No support for fscrypt.
+ * No support for compression.
+ * No support for fsverity yet.
+ * Strong assumptions that IO should work the way it does on XFS.
+ * Does iomap *actually* work for non-regular file data?
+
+Patches welcome!
diff --git a/MAINTAINERS b/MAINTAINERS
index 8754ac2c259d..2ddd94d43ecf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8483,6 +8483,7 @@ R:	Darrick J. Wong <djwong@kernel.org>
 L:	linux-xfs@vger.kernel.org
 L:	linux-fsdevel@vger.kernel.org
 S:	Supported
+F:	Documentation/filesystems/iomap.txt
 F:	fs/iomap/
 F:	include/linux/iomap.h
 

