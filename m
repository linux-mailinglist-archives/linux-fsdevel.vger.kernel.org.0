Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD81E711B96
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 02:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233496AbjEZArO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 20:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjEZArN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 20:47:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6953512E;
        Thu, 25 May 2023 17:47:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DCE9064BE9;
        Fri, 26 May 2023 00:47:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45997C433D2;
        Fri, 26 May 2023 00:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685062029;
        bh=QLn9NfTKHeefj+AkkGETIom+dGEK+7VlU8J/xTBLRf4=;
        h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
        b=h+GhOWVHAqxhl+YxRW3KK+GgQE42fUwH9Ei+k7SqpLuYvMT+MmCZ9Ki971EAg0DyE
         Krl3V1WM1fxWTIWkgmoEzLbE69P6KlD/mKBDkz2L69piSBLJP2VSu38eRdnoX+Cpk/
         4UF9+AHa9DmC2EPPHnjF3+nIwxlykrM7vOuTWV1Jjs9prJXTI4bhMANeeLQOyGJoJo
         MoFcsnCs1R2mEnv2UrOgRJjdGfGznZHMswqFyVVaQ8pF38bmNywSNzuasXamkJ1DE1
         eWvrm+ZdUWZBX647tYWSt/z9dk6mVHrm39paUMeesJYySSo4VBkzxeTWfHdZZrHxlQ
         /lWqgBMoPaGVA==
Date:   Thu, 25 May 2023 17:47:08 -0700
Subject: [PATCH 1/7] xfs: create a big array data structure
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        linux-xfs@vger.kernel.org, willy@infradead.org,
        linux-fsdevel@vger.kernel.org
Message-ID: <168506056469.3729324.10116553858401440150.stgit@frogsfrogsfrogs>
In-Reply-To: <168506056447.3729324.13624212283929857624.stgit@frogsfrogsfrogs>
References: <168506056447.3729324.13624212283929857624.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

Create a simple 'big array' data structure for storage of fixed-size
metadata records that will be used to reconstruct a btree index.  For
repair operations, the most important operations are append, iterate,
and sort.

Earlier implementations of the big array used linked lists and suffered
from severe problems -- pinning all records in kernel memory was not a
good idea and frequently lead to OOM situations; random access was very
inefficient; and record overhead for the lists was unacceptably high at
40-60%.

Therefore, the big memory array relies on the 'xfile' abstraction, which
creates a memfd file and stores the records in page cache pages.  Since
the memfd is created in tmpfs, the memory pages can be pushed out to
disk if necessary and we have a built-in usage limit of 50% of physical
memory.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/xfs/Kconfig         |    1 
 fs/xfs/Makefile        |    2 
 fs/xfs/scrub/trace.c   |    4 -
 fs/xfs/scrub/trace.h   |  123 ++++++++++++++++
 fs/xfs/scrub/xfarray.c |  370 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/xfs/scrub/xfarray.h |   58 ++++++++
 fs/xfs/scrub/xfile.c   |  325 ++++++++++++++++++++++++++++++++++++++++++
 fs/xfs/scrub/xfile.h   |   58 ++++++++
 8 files changed, 940 insertions(+), 1 deletion(-)
 create mode 100644 fs/xfs/scrub/xfarray.c
 create mode 100644 fs/xfs/scrub/xfarray.h
 create mode 100644 fs/xfs/scrub/xfile.c
 create mode 100644 fs/xfs/scrub/xfile.h


diff --git a/fs/xfs/Kconfig b/fs/xfs/Kconfig
index 52e1823241fb..152348b4dece 100644
--- a/fs/xfs/Kconfig
+++ b/fs/xfs/Kconfig
@@ -128,6 +128,7 @@ config XFS_ONLINE_SCRUB
 	bool "XFS online metadata check support"
 	default n
 	depends on XFS_FS
+	depends on TMPFS && SHMEM
 	select XFS_DRAIN_INTENTS
 	help
 	  If you say Y here you will be able to check metadata on a
diff --git a/fs/xfs/Makefile b/fs/xfs/Makefile
index d562d128af8e..7a5fa47a3093 100644
--- a/fs/xfs/Makefile
+++ b/fs/xfs/Makefile
@@ -164,6 +164,8 @@ xfs-y				+= $(addprefix scrub/, \
 				   rmap.o \
 				   scrub.o \
 				   symlink.o \
+				   xfarray.o \
+				   xfile.o \
 				   )
 
 xfs-$(CONFIG_XFS_RT)		+= scrub/rtbitmap.o
diff --git a/fs/xfs/scrub/trace.c b/fs/xfs/scrub/trace.c
index 0a975439d2b6..46249e7b17e0 100644
--- a/fs/xfs/scrub/trace.c
+++ b/fs/xfs/scrub/trace.c
@@ -12,8 +12,10 @@
 #include "xfs_mount.h"
 #include "xfs_inode.h"
 #include "xfs_btree.h"
-#include "scrub/scrub.h"
 #include "xfs_ag.h"
+#include "scrub/scrub.h"
+#include "scrub/xfile.h"
+#include "scrub/xfarray.h"
 
 /* Figure out which block the btree cursor was pointing to. */
 static inline xfs_fsblock_t
diff --git a/fs/xfs/scrub/trace.h b/fs/xfs/scrub/trace.h
index 7418d6c60056..c5fa000c668b 100644
--- a/fs/xfs/scrub/trace.h
+++ b/fs/xfs/scrub/trace.h
@@ -16,6 +16,9 @@
 #include <linux/tracepoint.h>
 #include "xfs_bit.h"
 
+struct xfile;
+struct xfarray;
+
 /*
  * ftrace's __print_symbolic requires that all enum values be wrapped in the
  * TRACE_DEFINE_ENUM macro so that the enum value can be encoded in the ftrace
@@ -725,6 +728,126 @@ TRACE_EVENT(xchk_refcount_incorrect,
 		  __entry->seen)
 )
 
+TRACE_EVENT(xfile_create,
+	TP_PROTO(struct xfs_mount *mp, struct xfile *xf),
+	TP_ARGS(mp, xf),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(unsigned long, ino)
+		__array(char, pathname, 256)
+	),
+	TP_fast_assign(
+		char		pathname[257];
+		char		*path;
+
+		__entry->dev = mp->m_super->s_dev;
+		__entry->ino = file_inode(xf->file)->i_ino;
+		memset(pathname, 0, sizeof(pathname));
+		path = file_path(xf->file, pathname, sizeof(pathname) - 1);
+		if (IS_ERR(path))
+			path = "(unknown)";
+		strncpy(__entry->pathname, path, sizeof(__entry->pathname));
+	),
+	TP_printk("dev %d:%d xfino 0x%lx path '%s'",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->ino,
+		  __entry->pathname)
+);
+
+TRACE_EVENT(xfile_destroy,
+	TP_PROTO(struct xfile *xf),
+	TP_ARGS(xf),
+	TP_STRUCT__entry(
+		__field(unsigned long, ino)
+		__field(unsigned long long, bytes)
+		__field(loff_t, size)
+	),
+	TP_fast_assign(
+		struct xfile_stat	statbuf;
+		int			ret;
+
+		ret = xfile_stat(xf, &statbuf);
+		if (!ret) {
+			__entry->bytes = statbuf.bytes;
+			__entry->size = statbuf.size;
+		} else {
+			__entry->bytes = -1;
+			__entry->size = -1;
+		}
+		__entry->ino = file_inode(xf->file)->i_ino;
+	),
+	TP_printk("xfino 0x%lx mem_bytes 0x%llx isize 0x%llx",
+		  __entry->ino,
+		  __entry->bytes,
+		  __entry->size)
+);
+
+DECLARE_EVENT_CLASS(xfile_class,
+	TP_PROTO(struct xfile *xf, loff_t pos, unsigned long long bytecount),
+	TP_ARGS(xf, pos, bytecount),
+	TP_STRUCT__entry(
+		__field(unsigned long, ino)
+		__field(unsigned long long, bytes_used)
+		__field(loff_t, pos)
+		__field(loff_t, size)
+		__field(unsigned long long, bytecount)
+	),
+	TP_fast_assign(
+		struct xfile_stat	statbuf;
+		int			ret;
+
+		ret = xfile_stat(xf, &statbuf);
+		if (!ret) {
+			__entry->bytes_used = statbuf.bytes;
+			__entry->size = statbuf.size;
+		} else {
+			__entry->bytes_used = -1;
+			__entry->size = -1;
+		}
+		__entry->ino = file_inode(xf->file)->i_ino;
+		__entry->pos = pos;
+		__entry->bytecount = bytecount;
+	),
+	TP_printk("xfino 0x%lx mem_bytes 0x%llx pos 0x%llx bytecount 0x%llx isize 0x%llx",
+		  __entry->ino,
+		  __entry->bytes_used,
+		  __entry->pos,
+		  __entry->bytecount,
+		  __entry->size)
+);
+#define DEFINE_XFILE_EVENT(name) \
+DEFINE_EVENT(xfile_class, name, \
+	TP_PROTO(struct xfile *xf, loff_t pos, unsigned long long bytecount), \
+	TP_ARGS(xf, pos, bytecount))
+DEFINE_XFILE_EVENT(xfile_pread);
+DEFINE_XFILE_EVENT(xfile_pwrite);
+DEFINE_XFILE_EVENT(xfile_seek_data);
+
+TRACE_EVENT(xfarray_create,
+	TP_PROTO(struct xfarray *xfa, unsigned long long required_capacity),
+	TP_ARGS(xfa, required_capacity),
+	TP_STRUCT__entry(
+		__field(unsigned long, ino)
+		__field(uint64_t, max_nr)
+		__field(size_t, obj_size)
+		__field(int, obj_size_log)
+		__field(unsigned long long, required_capacity)
+	),
+	TP_fast_assign(
+		__entry->max_nr = xfa->max_nr;
+		__entry->obj_size = xfa->obj_size;
+		__entry->obj_size_log = xfa->obj_size_log;
+		__entry->ino = file_inode(xfa->xfile->file)->i_ino;
+		__entry->required_capacity = required_capacity;
+	),
+	TP_printk("xfino 0x%lx max_nr %llu reqd_nr %llu objsz %zu objszlog %d",
+		  __entry->ino,
+		  __entry->max_nr,
+		  __entry->required_capacity,
+		  __entry->obj_size,
+		  __entry->obj_size_log)
+);
+
 /* repair tracepoints */
 #if IS_ENABLED(CONFIG_XFS_ONLINE_REPAIR)
 
diff --git a/fs/xfs/scrub/xfarray.c b/fs/xfs/scrub/xfarray.c
new file mode 100644
index 000000000000..a2dce2c37a4f
--- /dev/null
+++ b/fs/xfs/scrub/xfarray.c
@@ -0,0 +1,370 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2021-2023 Oracle.  All Rights Reserved.
+ * Author: Darrick J. Wong <djwong@kernel.org>
+ */
+#include "xfs.h"
+#include "xfs_fs.h"
+#include "xfs_shared.h"
+#include "xfs_format.h"
+#include "scrub/xfile.h"
+#include "scrub/xfarray.h"
+#include "scrub/scrub.h"
+#include "scrub/trace.h"
+
+/*
+ * Large Arrays of Fixed-Size Records
+ * ==================================
+ *
+ * This memory array uses an xfile (which itself is a memfd "file") to store
+ * large numbers of fixed-size records in memory that can be paged out.  This
+ * puts less stress on the memory reclaim algorithms during an online repair
+ * because we don't have to pin so much memory.  However, array access is less
+ * direct than would be in a regular memory array.  Access to the array is
+ * performed via indexed load and store methods, and an append method is
+ * provided for convenience.  Array elements can be unset, which sets them to
+ * all zeroes.  Unset entries are skipped during iteration, though direct loads
+ * will return a zeroed buffer.  Callers are responsible for concurrency
+ * control.
+ */
+
+/*
+ * Pointer to scratch space.  Because we can't access the xfile data directly,
+ * we allocate a small amount of memory on the end of the xfarray structure to
+ * buffer array items when we need space to store values temporarily.
+ */
+static inline void *xfarray_scratch(struct xfarray *array)
+{
+	return (array + 1);
+}
+
+/* Compute array index given an xfile offset. */
+static xfarray_idx_t
+xfarray_idx(
+	struct xfarray	*array,
+	loff_t		pos)
+{
+	if (array->obj_size_log >= 0)
+		return (xfarray_idx_t)pos >> array->obj_size_log;
+
+	return div_u64((xfarray_idx_t)pos, array->obj_size);
+}
+
+/* Compute xfile offset of array element. */
+static inline loff_t xfarray_pos(struct xfarray *array, xfarray_idx_t idx)
+{
+	if (array->obj_size_log >= 0)
+		return idx << array->obj_size_log;
+
+	return idx * array->obj_size;
+}
+
+/*
+ * Initialize a big memory array.  Array records cannot be larger than a
+ * page, and the array cannot span more bytes than the page cache supports.
+ * If @required_capacity is nonzero, the maximum array size will be set to this
+ * quantity and the array creation will fail if the underlying storage cannot
+ * support that many records.
+ */
+int
+xfarray_create(
+	struct xfs_mount	*mp,
+	const char		*description,
+	unsigned long long	required_capacity,
+	size_t			obj_size,
+	struct xfarray		**arrayp)
+{
+	struct xfarray		*array;
+	struct xfile		*xfile;
+	int			error;
+
+	ASSERT(obj_size < PAGE_SIZE);
+
+	error = xfile_create(mp, description, 0, &xfile);
+	if (error)
+		return error;
+
+	error = -ENOMEM;
+	array = kzalloc(sizeof(struct xfarray) + obj_size, XCHK_GFP_FLAGS);
+	if (!array)
+		goto out_xfile;
+
+	array->xfile = xfile;
+	array->obj_size = obj_size;
+
+	if (is_power_of_2(obj_size))
+		array->obj_size_log = ilog2(obj_size);
+	else
+		array->obj_size_log = -1;
+
+	array->max_nr = xfarray_idx(array, MAX_LFS_FILESIZE);
+	trace_xfarray_create(array, required_capacity);
+
+	if (required_capacity > 0) {
+		if (array->max_nr < required_capacity) {
+			error = -ENOMEM;
+			goto out_xfarray;
+		}
+		array->max_nr = required_capacity;
+	}
+
+	*arrayp = array;
+	return 0;
+
+out_xfarray:
+	kfree(array);
+out_xfile:
+	xfile_destroy(xfile);
+	return error;
+}
+
+/* Destroy the array. */
+void
+xfarray_destroy(
+	struct xfarray	*array)
+{
+	xfile_destroy(array->xfile);
+	kfree(array);
+}
+
+/* Load an element from the array. */
+int
+xfarray_load(
+	struct xfarray	*array,
+	xfarray_idx_t	idx,
+	void		*ptr)
+{
+	if (idx >= array->nr)
+		return -ENODATA;
+
+	return xfile_obj_load(array->xfile, ptr, array->obj_size,
+			xfarray_pos(array, idx));
+}
+
+/* Is this array element potentially unset? */
+static inline bool
+xfarray_is_unset(
+	struct xfarray	*array,
+	loff_t		pos)
+{
+	void		*temp = xfarray_scratch(array);
+	int		error;
+
+	if (array->unset_slots == 0)
+		return false;
+
+	error = xfile_obj_load(array->xfile, temp, array->obj_size, pos);
+	if (!error && xfarray_element_is_null(array, temp))
+		return true;
+
+	return false;
+}
+
+/*
+ * Unset an array element.  If @idx is the last element in the array, the
+ * array will be truncated.  Otherwise, the entry will be zeroed.
+ */
+int
+xfarray_unset(
+	struct xfarray	*array,
+	xfarray_idx_t	idx)
+{
+	void		*temp = xfarray_scratch(array);
+	loff_t		pos = xfarray_pos(array, idx);
+	int		error;
+
+	if (idx >= array->nr)
+		return -ENODATA;
+
+	if (idx == array->nr - 1) {
+		array->nr--;
+		return 0;
+	}
+
+	if (xfarray_is_unset(array, pos))
+		return 0;
+
+	memset(temp, 0, array->obj_size);
+	error = xfile_obj_store(array->xfile, temp, array->obj_size, pos);
+	if (error)
+		return error;
+
+	array->unset_slots++;
+	return 0;
+}
+
+/*
+ * Store an element in the array.  The element must not be completely zeroed,
+ * because those are considered unset sparse elements.
+ */
+int
+xfarray_store(
+	struct xfarray	*array,
+	xfarray_idx_t	idx,
+	const void	*ptr)
+{
+	int		ret;
+
+	if (idx >= array->max_nr)
+		return -EFBIG;
+
+	ASSERT(!xfarray_element_is_null(array, ptr));
+
+	ret = xfile_obj_store(array->xfile, ptr, array->obj_size,
+			xfarray_pos(array, idx));
+	if (ret)
+		return ret;
+
+	array->nr = max(array->nr, idx + 1);
+	return 0;
+}
+
+/* Is this array element NULL? */
+bool
+xfarray_element_is_null(
+	struct xfarray	*array,
+	const void	*ptr)
+{
+	return !memchr_inv(ptr, 0, array->obj_size);
+}
+
+/*
+ * Store an element anywhere in the array that is unset.  If there are no
+ * unset slots, append the element to the array.
+ */
+int
+xfarray_store_anywhere(
+	struct xfarray	*array,
+	const void	*ptr)
+{
+	void		*temp = xfarray_scratch(array);
+	loff_t		endpos = xfarray_pos(array, array->nr);
+	loff_t		pos;
+	int		error;
+
+	/* Find an unset slot to put it in. */
+	for (pos = 0;
+	     pos < endpos && array->unset_slots > 0;
+	     pos += array->obj_size) {
+		error = xfile_obj_load(array->xfile, temp, array->obj_size,
+				pos);
+		if (error || !xfarray_element_is_null(array, temp))
+			continue;
+
+		error = xfile_obj_store(array->xfile, ptr, array->obj_size,
+				pos);
+		if (error)
+			return error;
+
+		array->unset_slots--;
+		return 0;
+	}
+
+	/* No unset slots found; attach it on the end. */
+	array->unset_slots = 0;
+	return xfarray_append(array, ptr);
+}
+
+/* Return length of array. */
+uint64_t
+xfarray_length(
+	struct xfarray	*array)
+{
+	return array->nr;
+}
+
+/*
+ * Decide which array item we're going to read as part of an _iter_get.
+ * @cur is the array index, and @pos is the file offset of that array index in
+ * the backing xfile.  Returns ENODATA if we reach the end of the records.
+ *
+ * Reading from a hole in a sparse xfile causes page instantiation, so for
+ * iterating a (possibly sparse) array we need to figure out if the cursor is
+ * pointing at a totally uninitialized hole and move the cursor up if
+ * necessary.
+ */
+static inline int
+xfarray_find_data(
+	struct xfarray	*array,
+	xfarray_idx_t	*cur,
+	loff_t		*pos)
+{
+	unsigned int	pgoff = offset_in_page(*pos);
+	loff_t		end_pos = *pos + array->obj_size - 1;
+	loff_t		new_pos;
+
+	/*
+	 * If the current array record is not adjacent to a page boundary, we
+	 * are in the middle of the page.  We do not need to move the cursor.
+	 */
+	if (pgoff != 0 && pgoff + array->obj_size - 1 < PAGE_SIZE)
+		return 0;
+
+	/*
+	 * Call SEEK_DATA on the last byte in the record we're about to read.
+	 * If the record ends at (or crosses) the end of a page then we know
+	 * that the first byte of the record is backed by pages and don't need
+	 * to query it.  If instead the record begins at the start of the page
+	 * then we know that querying the last byte is just as good as querying
+	 * the first byte, since records cannot be larger than a page.
+	 *
+	 * If the call returns the same file offset, we know this record is
+	 * backed by real pages.  We do not need to move the cursor.
+	 */
+	new_pos = xfile_seek_data(array->xfile, end_pos);
+	if (new_pos == -ENXIO)
+		return -ENODATA;
+	if (new_pos < 0)
+		return new_pos;
+	if (new_pos == end_pos)
+		return 0;
+
+	/*
+	 * Otherwise, SEEK_DATA told us how far up to move the file pointer to
+	 * find more data.  Move the array index to the first record past the
+	 * byte offset we were given.
+	 */
+	new_pos = roundup_64(new_pos, array->obj_size);
+	*cur = xfarray_idx(array, new_pos);
+	*pos = xfarray_pos(array, *cur);
+	return 0;
+}
+
+/*
+ * Starting at *idx, fetch the next non-null array entry and advance the index
+ * to set up the next _load_next call.  Returns ENODATA if we reach the end of
+ * the array.  Callers must set @*idx to XFARRAY_CURSOR_INIT before the first
+ * call to this function.
+ */
+int
+xfarray_load_next(
+	struct xfarray	*array,
+	xfarray_idx_t	*idx,
+	void		*rec)
+{
+	xfarray_idx_t	cur = *idx;
+	loff_t		pos = xfarray_pos(array, cur);
+	int		error;
+
+	do {
+		if (cur >= array->nr)
+			return -ENODATA;
+
+		/*
+		 * Ask the backing store for the location of next possible
+		 * written record, then retrieve that record.
+		 */
+		error = xfarray_find_data(array, &cur, &pos);
+		if (error)
+			return error;
+		error = xfarray_load(array, cur, rec);
+		if (error)
+			return error;
+
+		cur++;
+		pos += array->obj_size;
+	} while (xfarray_element_is_null(array, rec));
+
+	*idx = cur;
+	return 0;
+}
diff --git a/fs/xfs/scrub/xfarray.h b/fs/xfs/scrub/xfarray.h
new file mode 100644
index 000000000000..4f815f2c6d89
--- /dev/null
+++ b/fs/xfs/scrub/xfarray.h
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2021-2023 Oracle.  All Rights Reserved.
+ * Author: Darrick J. Wong <djwong@kernel.org>
+ */
+#ifndef __XFS_SCRUB_XFARRAY_H__
+#define __XFS_SCRUB_XFARRAY_H__
+
+/* xfile array index type, along with cursor initialization */
+typedef uint64_t		xfarray_idx_t;
+#define XFARRAY_CURSOR_INIT	((__force xfarray_idx_t)0)
+
+/* Iterate each index of an xfile array. */
+#define foreach_xfarray_idx(array, idx) \
+	for ((idx) = XFARRAY_CURSOR_INIT; \
+	     (idx) < xfarray_length(array); \
+	     (idx)++)
+
+struct xfarray {
+	/* Underlying file that backs the array. */
+	struct xfile	*xfile;
+
+	/* Number of array elements. */
+	xfarray_idx_t	nr;
+
+	/* Maximum possible array size. */
+	xfarray_idx_t	max_nr;
+
+	/* Number of unset slots in the array below @nr. */
+	uint64_t	unset_slots;
+
+	/* Size of an array element. */
+	size_t		obj_size;
+
+	/* log2 of array element size, if possible. */
+	int		obj_size_log;
+};
+
+int xfarray_create(struct xfs_mount *mp, const char *descr,
+		unsigned long long required_capacity, size_t obj_size,
+		struct xfarray **arrayp);
+void xfarray_destroy(struct xfarray *array);
+int xfarray_load(struct xfarray *array, xfarray_idx_t idx, void *ptr);
+int xfarray_unset(struct xfarray *array, xfarray_idx_t idx);
+int xfarray_store(struct xfarray *array, xfarray_idx_t idx, const void *ptr);
+int xfarray_store_anywhere(struct xfarray *array, const void *ptr);
+bool xfarray_element_is_null(struct xfarray *array, const void *ptr);
+
+/* Append an element to the array. */
+static inline int xfarray_append(struct xfarray *array, const void *ptr)
+{
+	return xfarray_store(array, array->nr, ptr);
+}
+
+uint64_t xfarray_length(struct xfarray *array);
+int xfarray_load_next(struct xfarray *array, xfarray_idx_t *idx, void *rec);
+
+#endif /* __XFS_SCRUB_XFARRAY_H__ */
diff --git a/fs/xfs/scrub/xfile.c b/fs/xfs/scrub/xfile.c
new file mode 100644
index 000000000000..e1125a3e39eb
--- /dev/null
+++ b/fs/xfs/scrub/xfile.c
@@ -0,0 +1,325 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2018-2023 Oracle.  All Rights Reserved.
+ * Author: Darrick J. Wong <djwong@kernel.org>
+ */
+#include "xfs.h"
+#include "xfs_fs.h"
+#include "xfs_shared.h"
+#include "xfs_format.h"
+#include "xfs_log_format.h"
+#include "xfs_trans_resv.h"
+#include "xfs_mount.h"
+#include "xfs_format.h"
+#include "scrub/xfile.h"
+#include "scrub/xfarray.h"
+#include "scrub/scrub.h"
+#include "scrub/trace.h"
+#include <linux/shmem_fs.h>
+
+/*
+ * Swappable Temporary Memory
+ * ==========================
+ *
+ * Online checking sometimes needs to be able to stage a large amount of data
+ * in memory.  This information might not fit in the available memory and it
+ * doesn't all need to be accessible at all times.  In other words, we want an
+ * indexed data buffer to store data that can be paged out.
+ *
+ * When CONFIG_TMPFS=y, shmemfs is enough of a filesystem to meet those
+ * requirements.  Therefore, the xfile mechanism uses an unlinked shmem file to
+ * store our staging data.  This file is not installed in the file descriptor
+ * table so that user programs cannot access the data, which means that the
+ * xfile must be freed with xfile_destroy.
+ *
+ * xfiles assume that the caller will handle all required concurrency
+ * management; standard vfs locks (freezer and inode) are not taken.  Reads
+ * and writes are satisfied directly from the page cache.
+ *
+ * NOTE: The current shmemfs implementation has a quirk that in-kernel reads
+ * of a hole cause a page to be mapped into the file.  If you are going to
+ * create a sparse xfile, please be careful about reading from uninitialized
+ * parts of the file.  These pages are !Uptodate and will eventually be
+ * reclaimed if not written, but in the short term this boosts memory
+ * consumption.
+ */
+
+/*
+ * xfiles must not be exposed to userspace and require upper layers to
+ * coordinate access to the one handle returned by the constructor, so
+ * establish a separate lock class for xfiles to avoid confusing lockdep.
+ */
+static struct lock_class_key xfile_i_mutex_key;
+
+/*
+ * Create an xfile of the given size.  The description will be used in the
+ * trace output.
+ */
+int
+xfile_create(
+	struct xfs_mount	*mp,
+	const char		*description,
+	loff_t			isize,
+	struct xfile		**xfilep)
+{
+	char			*fname;
+	struct inode		*inode;
+	struct xfile		*xf;
+	int			error = -ENOMEM;
+
+	xf = kmalloc(sizeof(struct xfile), XCHK_GFP_FLAGS);
+	if (!xf)
+		return -ENOMEM;
+
+	fname = kmalloc(MAXNAMELEN, XCHK_GFP_FLAGS);
+	if (!fname)
+		goto out_xfile;
+
+	snprintf(fname, MAXNAMELEN - 1, "XFS (%s): %s", mp->m_super->s_id,
+			description);
+	fname[MAXNAMELEN - 1] = 0;
+
+	xf->file = shmem_file_setup(fname, isize, 0);
+	if (!xf->file)
+		goto out_fname;
+	if (IS_ERR(xf->file)) {
+		error = PTR_ERR(xf->file);
+		goto out_fname;
+	}
+
+	/*
+	 * We want a large sparse file that we can pread, pwrite, and seek.
+	 * xfile users are responsible for keeping the xfile hidden away from
+	 * all other callers, so we skip timestamp updates and security checks.
+	 * Make the inode only accessible by root, just in case the xfile ever
+	 * escapes.
+	 */
+	xf->file->f_mode |= FMODE_PREAD | FMODE_PWRITE | FMODE_NOCMTIME |
+			    FMODE_LSEEK;
+	xf->file->f_flags |= O_RDWR | O_LARGEFILE | O_NOATIME;
+	inode = file_inode(xf->file);
+	inode->i_flags |= S_PRIVATE | S_NOCMTIME | S_NOATIME;
+	inode->i_mode &= ~0177;
+	inode->i_uid = GLOBAL_ROOT_UID;
+	inode->i_gid = GLOBAL_ROOT_GID;
+
+	lockdep_set_class(&inode->i_rwsem, &xfile_i_mutex_key);
+
+	trace_xfile_create(mp, xf);
+
+	kfree(fname);
+	*xfilep = xf;
+	return 0;
+out_fname:
+	kfree(fname);
+out_xfile:
+	kfree(xf);
+	return error;
+}
+
+/* Close the file and release all resources. */
+void
+xfile_destroy(
+	struct xfile		*xf)
+{
+	struct inode		*inode = file_inode(xf->file);
+
+	trace_xfile_destroy(xf);
+
+	lockdep_set_class(&inode->i_rwsem, &inode->i_sb->s_type->i_mutex_key);
+	fput(xf->file);
+	kfree(xf);
+}
+
+/*
+ * Read a memory object directly from the xfile's page cache.  Unlike regular
+ * pread, we return -E2BIG and -EFBIG for reads that are too large or at too
+ * high an offset, instead of truncating the read.  Otherwise, we return
+ * bytes read or an error code, like regular pread.
+ */
+ssize_t
+xfile_pread(
+	struct xfile		*xf,
+	void			*buf,
+	size_t			count,
+	loff_t			pos)
+{
+	struct inode		*inode = file_inode(xf->file);
+	struct address_space	*mapping = inode->i_mapping;
+	struct page		*page = NULL;
+	ssize_t			read = 0;
+	unsigned int		pflags;
+	int			error = 0;
+
+	if (count > MAX_RW_COUNT)
+		return -E2BIG;
+	if (inode->i_sb->s_maxbytes - pos < count)
+		return -EFBIG;
+
+	trace_xfile_pread(xf, pos, count);
+
+	pflags = memalloc_nofs_save();
+	while (count > 0) {
+		void		*p, *kaddr;
+		unsigned int	len;
+
+		len = min_t(ssize_t, count, PAGE_SIZE - offset_in_page(pos));
+
+		/*
+		 * In-kernel reads of a shmem file cause it to allocate a page
+		 * if the mapping shows a hole.  Therefore, if we hit ENOMEM
+		 * we can continue by zeroing the caller's buffer.
+		 */
+		page = shmem_read_mapping_page_gfp(mapping, pos >> PAGE_SHIFT,
+				__GFP_NOWARN);
+		if (IS_ERR(page)) {
+			error = PTR_ERR(page);
+			if (error != -ENOMEM)
+				break;
+
+			memset(buf, 0, len);
+			goto advance;
+		}
+
+		if (PageUptodate(page)) {
+			/*
+			 * xfile pages must never be mapped into userspace, so
+			 * we skip the dcache flush.
+			 */
+			kaddr = kmap_local_page(page);
+			p = kaddr + offset_in_page(pos);
+			memcpy(buf, p, len);
+			kunmap_local(kaddr);
+		} else {
+			memset(buf, 0, len);
+		}
+		put_page(page);
+
+advance:
+		count -= len;
+		pos += len;
+		buf += len;
+		read += len;
+	}
+	memalloc_nofs_restore(pflags);
+
+	if (read > 0)
+		return read;
+	return error;
+}
+
+/*
+ * Write a memory object directly to the xfile's page cache.  Unlike regular
+ * pwrite, we return -E2BIG and -EFBIG for writes that are too large or at too
+ * high an offset, instead of truncating the write.  Otherwise, we return
+ * bytes written or an error code, like regular pwrite.
+ */
+ssize_t
+xfile_pwrite(
+	struct xfile		*xf,
+	const void		*buf,
+	size_t			count,
+	loff_t			pos)
+{
+	struct inode		*inode = file_inode(xf->file);
+	struct address_space	*mapping = inode->i_mapping;
+	const struct address_space_operations *aops = mapping->a_ops;
+	struct page		*page = NULL;
+	ssize_t			written = 0;
+	unsigned int		pflags;
+	int			error = 0;
+
+	if (count > MAX_RW_COUNT)
+		return -E2BIG;
+	if (inode->i_sb->s_maxbytes - pos < count)
+		return -EFBIG;
+
+	trace_xfile_pwrite(xf, pos, count);
+
+	pflags = memalloc_nofs_save();
+	while (count > 0) {
+		void		*fsdata = NULL;
+		void		*p, *kaddr;
+		unsigned int	len;
+		int		ret;
+
+		len = min_t(ssize_t, count, PAGE_SIZE - offset_in_page(pos));
+
+		/*
+		 * We call write_begin directly here to avoid all the freezer
+		 * protection lock-taking that happens in the normal path.
+		 * shmem doesn't support fs freeze, but lockdep doesn't know
+		 * that and will trip over that.
+		 */
+		error = aops->write_begin(NULL, mapping, pos, len, &page,
+				&fsdata);
+		if (error)
+			break;
+
+		/*
+		 * xfile pages must never be mapped into userspace, so we skip
+		 * the dcache flush.  If the page is not uptodate, zero it
+		 * before writing data.
+		 */
+		kaddr = kmap_local_page(page);
+		if (!PageUptodate(page)) {
+			memset(kaddr, 0, PAGE_SIZE);
+			SetPageUptodate(page);
+		}
+		p = kaddr + offset_in_page(pos);
+		memcpy(p, buf, len);
+		kunmap_local(kaddr);
+
+		ret = aops->write_end(NULL, mapping, pos, len, len, page,
+				fsdata);
+		if (ret < 0) {
+			error = ret;
+			break;
+		}
+
+		written += ret;
+		if (ret != len)
+			break;
+
+		count -= ret;
+		pos += ret;
+		buf += ret;
+	}
+	memalloc_nofs_restore(pflags);
+
+	if (written > 0)
+		return written;
+	return error;
+}
+
+/* Find the next written area in the xfile data for a given offset. */
+loff_t
+xfile_seek_data(
+	struct xfile		*xf,
+	loff_t			pos)
+{
+	loff_t			ret;
+
+	ret = vfs_llseek(xf->file, pos, SEEK_DATA);
+	trace_xfile_seek_data(xf, pos, ret);
+	return ret;
+}
+
+/* Query stat information for an xfile. */
+int
+xfile_stat(
+	struct xfile		*xf,
+	struct xfile_stat	*statbuf)
+{
+	struct kstat		ks;
+	int			error;
+
+	error = vfs_getattr_nosec(&xf->file->f_path, &ks,
+			STATX_SIZE | STATX_BLOCKS, AT_STATX_DONT_SYNC);
+	if (error)
+		return error;
+
+	statbuf->size = ks.size;
+	statbuf->bytes = ks.blocks << SECTOR_SHIFT;
+	return 0;
+}
diff --git a/fs/xfs/scrub/xfile.h b/fs/xfs/scrub/xfile.h
new file mode 100644
index 000000000000..f91c90efd04a
--- /dev/null
+++ b/fs/xfs/scrub/xfile.h
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2018-2023 Oracle.  All Rights Reserved.
+ * Author: Darrick J. Wong <djwong@kernel.org>
+ */
+#ifndef __XFS_SCRUB_XFILE_H__
+#define __XFS_SCRUB_XFILE_H__
+
+struct xfile {
+	struct file		*file;
+};
+
+int xfile_create(struct xfs_mount *mp, const char *description, loff_t isize,
+		struct xfile **xfilep);
+void xfile_destroy(struct xfile *xf);
+
+ssize_t xfile_pread(struct xfile *xf, void *buf, size_t count, loff_t pos);
+ssize_t xfile_pwrite(struct xfile *xf, const void *buf, size_t count,
+		loff_t pos);
+
+/*
+ * Load an object.  Since we're treating this file as "memory", any error or
+ * short IO is treated as a failure to allocate memory.
+ */
+static inline int
+xfile_obj_load(struct xfile *xf, void *buf, size_t count, loff_t pos)
+{
+	ssize_t	ret = xfile_pread(xf, buf, count, pos);
+
+	if (ret < 0 || ret != count)
+		return -ENOMEM;
+	return 0;
+}
+
+/*
+ * Store an object.  Since we're treating this file as "memory", any error or
+ * short IO is treated as a failure to allocate memory.
+ */
+static inline int
+xfile_obj_store(struct xfile *xf, const void *buf, size_t count, loff_t pos)
+{
+	ssize_t	ret = xfile_pwrite(xf, buf, count, pos);
+
+	if (ret < 0 || ret != count)
+		return -ENOMEM;
+	return 0;
+}
+
+loff_t xfile_seek_data(struct xfile *xf, loff_t pos);
+
+struct xfile_stat {
+	loff_t			size;
+	unsigned long long	bytes;
+};
+
+int xfile_stat(struct xfile *xf, struct xfile_stat *statbuf);
+
+#endif /* __XFS_SCRUB_XFILE_H__ */

