Return-Path: <linux-fsdevel+bounces-20763-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B168D7959
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 02:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93BB7B2124E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 00:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E5E3FC7;
	Mon,  3 Jun 2024 00:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AifI8db+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F1D15D1
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Jun 2024 00:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717374801; cv=none; b=GyqOu2+rW1CkMFvBe7lmjsp9pBDbcBMlIS7JjN1L8d2yP4cxEMiMNbuXZZuRhAZ8zFuU9pxdWjdIn1qhr8TMY80tdAI6UH0BZDa3mJbou1W+6ddTNRLS1MwAUnU2QOUrLA0ImiBoyNIJ1w/hwr75t9kBL3P5jqpX82ReopvFL2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717374801; c=relaxed/simple;
	bh=XDpvuG4s3ovgN0s3Tvb37TDg+pwRbYPgpqNn8zbOavI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PdS14vc+SgoqZ6/MvlZIM6G6LYFvw1NDJaY5y0l3WLSTBKNKiQRw6WwTr4ACiJI3fJk6HrZi6BVUAsbqL3JgB0XJ5Jk8ieIRQXF2jW26PnwlVjmtCygU4WqM2a4dIIqnXtaTFIFpzDaZe82A01bDo/LxDb02YAf2dHSgAPLPrwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AifI8db+; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717374796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1NPXN7ErKBoGZ+ge1x2t3+lzs1N7VfbV+EIVGe5PtUM=;
	b=AifI8db+I7uHKCB29BPZNaLufmloWnxnT1nOjRs9v31loznRfI7U6+4DFcp/KG1N1MzEF2
	t7UD55hvAVKjfAIbMGqavhRpyXFtCdHVIOQWBUNfk2EKE5Xh9KYJMPRatIMtf5Mmz44/2p
	+1MipJ9nXpsgFUNf0V8uyVx47aM/bMU=
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: axboe@kernel.dk
X-Envelope-To: kent.overstreet@linux.dev
X-Envelope-To: brauner@kernel.org
X-Envelope-To: viro@zeniv.linux.org.uk
X-Envelope-To: bernd.schubert@fastmail.fm
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: josef@toxicpanda.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	Bernd Schubert <bernd.schubert@fastmail.fm>,
	linux-mm@kvack.org,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 1/5] darray: lift from bcachefs
Date: Sun,  2 Jun 2024 20:32:58 -0400
Message-ID: <20240603003306.2030491-2-kent.overstreet@linux.dev>
In-Reply-To: <20240603003306.2030491-1-kent.overstreet@linux.dev>
References: <20240603003306.2030491-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

dynamic arrays - inspired from CCAN darrays, basically c++ stl vectors.

Used by thread_with_stdio, which is also being lifted from bcachefs for
xfs.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 MAINTAINERS                             |  7 +++
 fs/bcachefs/Makefile                    |  1 -
 fs/bcachefs/btree_types.h               |  2 +-
 fs/bcachefs/btree_update.c              |  2 +
 fs/bcachefs/btree_write_buffer_types.h  |  2 +-
 fs/bcachefs/fsck.c                      |  2 +-
 fs/bcachefs/journal_io.h                |  2 +-
 fs/bcachefs/journal_sb.c                |  2 +-
 fs/bcachefs/sb-downgrade.c              |  3 +-
 fs/bcachefs/sb-errors_types.h           |  2 +-
 fs/bcachefs/sb-members.h                |  3 +-
 fs/bcachefs/subvolume.h                 |  1 -
 fs/bcachefs/subvolume_types.h           |  2 +-
 fs/bcachefs/thread_with_file_types.h    |  2 +-
 fs/bcachefs/util.h                      | 28 +-----------
 {fs/bcachefs => include/linux}/darray.h | 59 ++++++++++++++++---------
 include/linux/darray_types.h            | 22 +++++++++
 lib/Makefile                            |  2 +-
 {fs/bcachefs => lib}/darray.c           | 12 ++++-
 19 files changed, 95 insertions(+), 61 deletions(-)
 rename {fs/bcachefs => include/linux}/darray.h (66%)
 create mode 100644 include/linux/darray_types.h
 rename {fs/bcachefs => lib}/darray.c (56%)

diff --git a/MAINTAINERS b/MAINTAINERS
index d6c90161c7bf..fafa30715f66 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6010,6 +6010,13 @@ F:	net/ax25/ax25_out.c
 F:	net/ax25/ax25_timer.c
 F:	net/ax25/sysctl_net_ax25.c
 
+DARRAY
+M:	Kent Overstreet <kent.overstreet@linux.dev>
+L:	linux-bcachefs@vger.kernel.org
+S:	Maintained
+F:	include/linux/darray.h
+F:	include/linux/darray_types.h
+
 DATA ACCESS MONITOR
 M:	SeongJae Park <sj@kernel.org>
 L:	damon@lists.linux.dev
diff --git a/fs/bcachefs/Makefile b/fs/bcachefs/Makefile
index 66ca0bbee639..281e4a7c1f31 100644
--- a/fs/bcachefs/Makefile
+++ b/fs/bcachefs/Makefile
@@ -28,7 +28,6 @@ bcachefs-y		:=	\
 	checksum.o		\
 	clock.o			\
 	compress.o		\
-	darray.o		\
 	debug.o			\
 	dirent.o		\
 	disk_groups.o		\
diff --git a/fs/bcachefs/btree_types.h b/fs/bcachefs/btree_types.h
index d63db4fefe73..7dcd015619af 100644
--- a/fs/bcachefs/btree_types.h
+++ b/fs/bcachefs/btree_types.h
@@ -2,13 +2,13 @@
 #ifndef _BCACHEFS_BTREE_TYPES_H
 #define _BCACHEFS_BTREE_TYPES_H
 
+#include <linux/darray_types.h>
 #include <linux/list.h>
 #include <linux/rhashtable.h>
 
 #include "bbpos_types.h"
 #include "btree_key_cache_types.h"
 #include "buckets_types.h"
-#include "darray.h"
 #include "errcode.h"
 #include "journal_types.h"
 #include "replicas_types.h"
diff --git a/fs/bcachefs/btree_update.c b/fs/bcachefs/btree_update.c
index f3c645a43dcb..23d52129db40 100644
--- a/fs/bcachefs/btree_update.c
+++ b/fs/bcachefs/btree_update.c
@@ -14,6 +14,8 @@
 #include "snapshot.h"
 #include "trace.h"
 
+#include <linux/darray.h>
+
 static inline int btree_insert_entry_cmp(const struct btree_insert_entry *l,
 					 const struct btree_insert_entry *r)
 {
diff --git a/fs/bcachefs/btree_write_buffer_types.h b/fs/bcachefs/btree_write_buffer_types.h
index 9b9433de9c36..5f248873087c 100644
--- a/fs/bcachefs/btree_write_buffer_types.h
+++ b/fs/bcachefs/btree_write_buffer_types.h
@@ -2,7 +2,7 @@
 #ifndef _BCACHEFS_BTREE_WRITE_BUFFER_TYPES_H
 #define _BCACHEFS_BTREE_WRITE_BUFFER_TYPES_H
 
-#include "darray.h"
+#include <linux/darray_types.h>
 #include "journal_types.h"
 
 #define BTREE_WRITE_BUFERED_VAL_U64s_MAX	4
diff --git a/fs/bcachefs/fsck.c b/fs/bcachefs/fsck.c
index c8f57465131c..3ead927285b6 100644
--- a/fs/bcachefs/fsck.c
+++ b/fs/bcachefs/fsck.c
@@ -5,7 +5,6 @@
 #include "btree_cache.h"
 #include "btree_update.h"
 #include "buckets.h"
-#include "darray.h"
 #include "dirent.h"
 #include "error.h"
 #include "fs-common.h"
@@ -18,6 +17,7 @@
 #include "xattr.h"
 
 #include <linux/bsearch.h>
+#include <linux/darray.h>
 #include <linux/dcache.h> /* struct qstr */
 
 /*
diff --git a/fs/bcachefs/journal_io.h b/fs/bcachefs/journal_io.h
index 2ca9cde30ea8..2b8f458cf13c 100644
--- a/fs/bcachefs/journal_io.h
+++ b/fs/bcachefs/journal_io.h
@@ -2,7 +2,7 @@
 #ifndef _BCACHEFS_JOURNAL_IO_H
 #define _BCACHEFS_JOURNAL_IO_H
 
-#include "darray.h"
+#include <linux/darray_types.h>
 
 void bch2_journal_pos_from_member_info_set(struct bch_fs *);
 void bch2_journal_pos_from_member_info_resume(struct bch_fs *);
diff --git a/fs/bcachefs/journal_sb.c b/fs/bcachefs/journal_sb.c
index db80e506e3ab..9db57f6f1035 100644
--- a/fs/bcachefs/journal_sb.c
+++ b/fs/bcachefs/journal_sb.c
@@ -2,8 +2,8 @@
 
 #include "bcachefs.h"
 #include "journal_sb.h"
-#include "darray.h"
 
+#include <linux/darray.h>
 #include <linux/sort.h>
 
 /* BCH_SB_FIELD_journal: */
diff --git a/fs/bcachefs/sb-downgrade.c b/fs/bcachefs/sb-downgrade.c
index 390a1bbd2567..526e2c26d1b4 100644
--- a/fs/bcachefs/sb-downgrade.c
+++ b/fs/bcachefs/sb-downgrade.c
@@ -6,12 +6,13 @@
  */
 
 #include "bcachefs.h"
-#include "darray.h"
 #include "recovery_passes.h"
 #include "sb-downgrade.h"
 #include "sb-errors.h"
 #include "super-io.h"
 
+#include <linux/darray.h>
+
 #define RECOVERY_PASS_ALL_FSCK		BIT_ULL(63)
 
 /*
diff --git a/fs/bcachefs/sb-errors_types.h b/fs/bcachefs/sb-errors_types.h
index 666599d3fb9d..39cae3a6a024 100644
--- a/fs/bcachefs/sb-errors_types.h
+++ b/fs/bcachefs/sb-errors_types.h
@@ -2,7 +2,7 @@
 #ifndef _BCACHEFS_SB_ERRORS_TYPES_H
 #define _BCACHEFS_SB_ERRORS_TYPES_H
 
-#include "darray.h"
+#include <linux/darray_types.h>
 
 #define BCH_SB_ERRS()							\
 	x(clean_but_journal_not_empty,				0)	\
diff --git a/fs/bcachefs/sb-members.h b/fs/bcachefs/sb-members.h
index dd93192ec065..338275899b60 100644
--- a/fs/bcachefs/sb-members.h
+++ b/fs/bcachefs/sb-members.h
@@ -2,9 +2,10 @@
 #ifndef _BCACHEFS_SB_MEMBERS_H
 #define _BCACHEFS_SB_MEMBERS_H
 
-#include "darray.h"
 #include "bkey_types.h"
 
+#include <linux/darray.h>
+
 extern char * const bch2_member_error_strs[];
 
 static inline struct bch_member *
diff --git a/fs/bcachefs/subvolume.h b/fs/bcachefs/subvolume.h
index afa5e871efb2..0311b8669c76 100644
--- a/fs/bcachefs/subvolume.h
+++ b/fs/bcachefs/subvolume.h
@@ -2,7 +2,6 @@
 #ifndef _BCACHEFS_SUBVOLUME_H
 #define _BCACHEFS_SUBVOLUME_H
 
-#include "darray.h"
 #include "subvolume_types.h"
 
 enum bch_validate_flags;
diff --git a/fs/bcachefs/subvolume_types.h b/fs/bcachefs/subvolume_types.h
index 9b10c8947828..3a1ee762ad61 100644
--- a/fs/bcachefs/subvolume_types.h
+++ b/fs/bcachefs/subvolume_types.h
@@ -2,7 +2,7 @@
 #ifndef _BCACHEFS_SUBVOLUME_TYPES_H
 #define _BCACHEFS_SUBVOLUME_TYPES_H
 
-#include "darray.h"
+#include <linux/darray_types.h>
 
 typedef DARRAY(u32) snapshot_id_list;
 
diff --git a/fs/bcachefs/thread_with_file_types.h b/fs/bcachefs/thread_with_file_types.h
index e0daf4eec341..41990756aa26 100644
--- a/fs/bcachefs/thread_with_file_types.h
+++ b/fs/bcachefs/thread_with_file_types.h
@@ -2,7 +2,7 @@
 #ifndef _BCACHEFS_THREAD_WITH_FILE_TYPES_H
 #define _BCACHEFS_THREAD_WITH_FILE_TYPES_H
 
-#include "darray.h"
+#include <linux/darray_types.h>
 
 struct stdio_buf {
 	spinlock_t		lock;
diff --git a/fs/bcachefs/util.h b/fs/bcachefs/util.h
index 5d2c470a49ac..1da52a8b3914 100644
--- a/fs/bcachefs/util.h
+++ b/fs/bcachefs/util.h
@@ -5,22 +5,22 @@
 #include <linux/bio.h>
 #include <linux/blkdev.h>
 #include <linux/closure.h>
+#include <linux/darray.h>
 #include <linux/errno.h>
 #include <linux/freezer.h>
 #include <linux/kernel.h>
-#include <linux/sched/clock.h>
 #include <linux/llist.h>
 #include <linux/log2.h>
 #include <linux/percpu.h>
 #include <linux/preempt.h>
 #include <linux/ratelimit.h>
+#include <linux/sched/clock.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/workqueue.h>
 
 #include "mean_and_variance.h"
 
-#include "darray.h"
 #include "time_stats.h"
 
 struct closure;
@@ -626,30 +626,6 @@ static inline void memset_u64s_tail(void *s, int c, unsigned bytes)
 	memset(s + bytes, c, rem);
 }
 
-/* just the memmove, doesn't update @_nr */
-#define __array_insert_item(_array, _nr, _pos)				\
-	memmove(&(_array)[(_pos) + 1],					\
-		&(_array)[(_pos)],					\
-		sizeof((_array)[0]) * ((_nr) - (_pos)))
-
-#define array_insert_item(_array, _nr, _pos, _new_item)			\
-do {									\
-	__array_insert_item(_array, _nr, _pos);				\
-	(_nr)++;							\
-	(_array)[(_pos)] = (_new_item);					\
-} while (0)
-
-#define array_remove_items(_array, _nr, _pos, _nr_to_remove)		\
-do {									\
-	(_nr) -= (_nr_to_remove);					\
-	memmove(&(_array)[(_pos)],					\
-		&(_array)[(_pos) + (_nr_to_remove)],			\
-		sizeof((_array)[0]) * ((_nr) - (_pos)));		\
-} while (0)
-
-#define array_remove_item(_array, _nr, _pos)				\
-	array_remove_items(_array, _nr, _pos, 1)
-
 static inline void __move_gap(void *array, size_t element_size,
 			      size_t nr, size_t size,
 			      size_t old_gap, size_t new_gap)
diff --git a/fs/bcachefs/darray.h b/include/linux/darray.h
similarity index 66%
rename from fs/bcachefs/darray.h
rename to include/linux/darray.h
index 4b340d13caac..ff167eb795f2 100644
--- a/fs/bcachefs/darray.h
+++ b/include/linux/darray.h
@@ -1,34 +1,26 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _BCACHEFS_DARRAY_H
-#define _BCACHEFS_DARRAY_H
+/*
+ * (C) 2022-2024 Kent Overstreet <kent.overstreet@linux.dev>
+ */
+#ifndef _LINUX_DARRAY_H
+#define _LINUX_DARRAY_H
 
 /*
- * Dynamic arrays:
+ * Dynamic arrays
  *
  * Inspired by CCAN's darray
  */
 
+#include <linux/darray_types.h>
 #include <linux/slab.h>
 
-#define DARRAY_PREALLOCATED(_type, _nr)					\
-struct {								\
-	size_t nr, size;						\
-	_type *data;							\
-	_type preallocated[_nr];					\
-}
-
-#define DARRAY(_type) DARRAY_PREALLOCATED(_type, 0)
-
-typedef DARRAY(char)	darray_char;
-typedef DARRAY(char *) darray_str;
-
-int __bch2_darray_resize(darray_char *, size_t, size_t, gfp_t);
+int __darray_resize_slowpath(darray_char *, size_t, size_t, gfp_t);
 
 static inline int __darray_resize(darray_char *d, size_t element_size,
 				  size_t new_size, gfp_t gfp)
 {
 	return unlikely(new_size > d->size)
-		? __bch2_darray_resize(d, element_size, new_size, gfp)
+		? __darray_resize_slowpath(d, element_size, new_size, gfp)
 		: 0;
 }
 
@@ -69,6 +61,28 @@ static inline int __darray_make_room(darray_char *d, size_t t_size, size_t more,
 #define darray_first(_d)	((_d).data[0])
 #define darray_last(_d)		((_d).data[(_d).nr - 1])
 
+/* Insert/remove items into the middle of a darray: */
+
+#define array_insert_item(_array, _nr, _pos, _new_item)			\
+do {									\
+	memmove(&(_array)[(_pos) + 1],					\
+		&(_array)[(_pos)],					\
+		sizeof((_array)[0]) * ((_nr) - (_pos)));		\
+	(_nr)++;							\
+	(_array)[(_pos)] = (_new_item);					\
+} while (0)
+
+#define array_remove_items(_array, _nr, _pos, _nr_to_remove)		\
+do {									\
+	(_nr) -= (_nr_to_remove);					\
+	memmove(&(_array)[(_pos)],					\
+		&(_array)[(_pos) + (_nr_to_remove)],			\
+		sizeof((_array)[0]) * ((_nr) - (_pos)));		\
+} while (0)
+
+#define array_remove_item(_array, _nr, _pos)				\
+	array_remove_items(_array, _nr, _pos, 1)
+
 #define darray_insert_item(_d, pos, _item)				\
 ({									\
 	size_t _pos = (pos);						\
@@ -79,10 +93,15 @@ static inline int __darray_make_room(darray_char *d, size_t t_size, size_t more,
 	_ret;								\
 })
 
+#define darray_remove_items(_d, _pos, _nr_to_remove)			\
+	array_remove_items((_d)->data, (_d)->nr, (_pos) - (_d)->data, _nr_to_remove)
+
 #define darray_remove_item(_d, _pos)					\
-	array_remove_item((_d)->data, (_d)->nr, (_pos) - (_d)->data)
+	darray_remove_items(_d, _pos, 1)
+
+/* Iteration: */
 
-#define __darray_for_each(_d, _i)						\
+#define __darray_for_each(_d, _i)					\
 	for ((_i) = (_d).data; _i < (_d).data + (_d).nr; _i++)
 
 #define darray_for_each(_d, _i)						\
@@ -106,4 +125,4 @@ do {									\
 	darray_init(_d);						\
 } while (0)
 
-#endif /* _BCACHEFS_DARRAY_H */
+#endif /* _LINUX_DARRAY_H */
diff --git a/include/linux/darray_types.h b/include/linux/darray_types.h
new file mode 100644
index 000000000000..a400a0c3600d
--- /dev/null
+++ b/include/linux/darray_types.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * (C) 2022-2024 Kent Overstreet <kent.overstreet@linux.dev>
+ */
+#ifndef _LINUX_DARRAY_TYpES_H
+#define _LINUX_DARRAY_TYpES_H
+
+#include <linux/types.h>
+
+#define DARRAY_PREALLOCATED(_type, _nr)					\
+struct {								\
+	size_t nr, size;						\
+	_type *data;							\
+	_type preallocated[_nr];					\
+}
+
+#define DARRAY(_type) DARRAY_PREALLOCATED(_type, 0)
+
+typedef DARRAY(char)	darray_char;
+typedef DARRAY(char *)	darray_str;
+
+#endif /* _LINUX_DARRAY_TYpES_H */
diff --git a/lib/Makefile b/lib/Makefile
index 3b1769045651..f540c84e8c08 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -48,7 +48,7 @@ obj-y += bcd.o sort.o parser.o debug_locks.o random32.o \
 	 bsearch.o find_bit.o llist.o lwq.o memweight.o kfifo.o \
 	 percpu-refcount.o rhashtable.o base64.o \
 	 once.o refcount.o rcuref.o usercopy.o errseq.o bucket_locks.o \
-	 generic-radix-tree.o bitmap-str.o
+	 generic-radix-tree.o bitmap-str.o darray.o
 obj-$(CONFIG_STRING_KUNIT_TEST) += string_kunit.o
 obj-y += string_helpers.o
 obj-$(CONFIG_STRING_HELPERS_KUNIT_TEST) += string_helpers_kunit.o
diff --git a/fs/bcachefs/darray.c b/lib/darray.c
similarity index 56%
rename from fs/bcachefs/darray.c
rename to lib/darray.c
index ac35b8b705ae..7cb064f14b39 100644
--- a/fs/bcachefs/darray.c
+++ b/lib/darray.c
@@ -1,10 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0
+/*
+ * (C) 2022-2024 Kent Overstreet <kent.overstreet@linux.dev>
+ */
 
+#include <linux/darray.h>
 #include <linux/log2.h>
+#include <linux/module.h>
 #include <linux/slab.h>
-#include "darray.h"
 
-int __bch2_darray_resize(darray_char *d, size_t element_size, size_t new_size, gfp_t gfp)
+int __darray_resize_slowpath(darray_char *d, size_t element_size, size_t new_size, gfp_t gfp)
 {
 	if (new_size > d->size) {
 		new_size = roundup_pow_of_two(new_size);
@@ -22,3 +26,7 @@ int __bch2_darray_resize(darray_char *d, size_t element_size, size_t new_size, g
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(__darray_resize_slowpath);
+
+MODULE_AUTHOR("Kent Overstreet");
+MODULE_LICENSE("GPL");
-- 
2.45.1


