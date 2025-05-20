Return-Path: <linux-fsdevel+bounces-49476-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3E5ABCE7E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 07:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBC0D3A4AE7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 05:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C45A25B69C;
	Tue, 20 May 2025 05:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Rsh9v91e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AA4257455
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 May 2025 05:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747718175; cv=none; b=g01yJ3kUWMgCOvZLZ7Q0G+l5Slw0ExCAgR665dAzob4HmaTlvrkBq1Qd+Rv5qSg3Gav6mykIyk/3J6f5YhGCPL2zi15EChYUzo8iDH4HW0RTHrDrgKfuWYCiwuaaxzuOzHoKYa0j1bE4fMSJHywNfH6oeRm5YzpiII6Eq/tZAkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747718175; c=relaxed/simple;
	bh=qIfS6eL6bKdqoJe9XzZ2X0UHibtGO3qcUrzIKnRpzy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sv730nlOFUuqYqTFj30njdCgolZT0aD3fZxDitlDfKWeageyo9w3S+lFwu7BaTHS+g+bWLvHUR+GxMA0EhH35WfpynxYpe4ck2QEWtSMMdly3EPaDuyzbNLML8vIcC2BYhS5qv2E+CvWCr3ApmvOlZPWK2WP7BPwt894zCQNyY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Rsh9v91e; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747718170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yp+gMyCCEhWIJhMBAJi3K0ln1Cu3dcNJVw79Mw0koIs=;
	b=Rsh9v91eFzHL862uZejGA1jLKTDEiiuRw0LH7No5kzbp//5KU9n0WSa1w+wSJIrUJhsEUC
	3auSG6nPoNZM0hIyreBSXRNPLCSV3BJQgV/Rz810y4NxOeXQhctdDZWdfPVSSvxY+pi2MI
	AvPlIjNIjmB3eLmjxiaxn6Q8PuHf3cc=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-fsdevel@vger.kernel.org,
	linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 2/6] darray: lift from bcachefs
Date: Tue, 20 May 2025 01:15:54 -0400
Message-ID: <20250520051600.1903319-3-kent.overstreet@linux.dev>
In-Reply-To: <20250520051600.1903319-1-kent.overstreet@linux.dev>
References: <20250520051600.1903319-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

dynamic arrays - inspired from CCAN darrays, basically c++ stl vectors.

Open coding these is unwieldy. In this series they're used by the new
dcache code for exclusion between case insensitive directories and
overlayfs, and we've got a lot of open coded dynamic arrays that could
be cleaned up with this.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 MAINTAINERS                             |  7 +++
 fs/bcachefs/Makefile                    |  1 -
 fs/bcachefs/btree_node_scan_types.h     |  2 +-
 fs/bcachefs/btree_types.h               |  2 +-
 fs/bcachefs/btree_update.c              |  1 +
 fs/bcachefs/btree_write_buffer_types.h  |  2 +-
 fs/bcachefs/disk_accounting_types.h     |  2 +-
 fs/bcachefs/fsck.c                      |  2 +-
 fs/bcachefs/journal_io.h                |  2 +-
 fs/bcachefs/journal_sb.c                |  2 +-
 fs/bcachefs/rcu_pending.c               |  3 +-
 fs/bcachefs/sb-downgrade.c              |  3 +-
 fs/bcachefs/sb-errors_types.h           |  2 +-
 fs/bcachefs/sb-members.h                |  3 +-
 fs/bcachefs/snapshot_types.h            |  3 +-
 fs/bcachefs/subvolume.h                 |  1 -
 fs/bcachefs/thread_with_file_types.h    |  2 +-
 fs/bcachefs/util.h                      | 28 +---------
 {fs/bcachefs => include/linux}/darray.h | 70 ++++++++++++++-----------
 include/linux/darray_types.h            | 33 ++++++++++++
 lib/Makefile                            |  2 +-
 {fs/bcachefs => lib}/darray.c           |  9 +++-
 22 files changed, 106 insertions(+), 76 deletions(-)
 rename {fs/bcachefs => include/linux}/darray.h (64%)
 create mode 100644 include/linux/darray_types.h
 rename {fs/bcachefs => lib}/darray.c (75%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3cbf9ac0d83f..ae460234af14 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6515,6 +6515,13 @@ F:	net/ax25/ax25_out.c
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
index 93c8ee5425c8..d71621711cfa 100644
--- a/fs/bcachefs/Makefile
+++ b/fs/bcachefs/Makefile
@@ -28,7 +28,6 @@ bcachefs-y		:=	\
 	checksum.o		\
 	clock.o			\
 	compress.o		\
-	darray.o		\
 	data_update.o		\
 	debug.o			\
 	dirent.o		\
diff --git a/fs/bcachefs/btree_node_scan_types.h b/fs/bcachefs/btree_node_scan_types.h
index 2811b6857c97..422d49a5c57c 100644
--- a/fs/bcachefs/btree_node_scan_types.h
+++ b/fs/bcachefs/btree_node_scan_types.h
@@ -2,7 +2,7 @@
 #ifndef _BCACHEFS_BTREE_NODE_SCAN_TYPES_H
 #define _BCACHEFS_BTREE_NODE_SCAN_TYPES_H
 
-#include "darray.h"
+#include <linux/darray.h>
 
 struct found_btree_node {
 	bool			range_updated:1;
diff --git a/fs/bcachefs/btree_types.h b/fs/bcachefs/btree_types.h
index 6a0b82886581..7020ceef50e7 100644
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
index 20fba8d17431..afd05c3dfd03 100644
--- a/fs/bcachefs/btree_update.c
+++ b/fs/bcachefs/btree_update.c
@@ -14,6 +14,7 @@
 #include "snapshot.h"
 #include "trace.h"
 
+#include <linux/darray.h>
 #include <linux/string_helpers.h>
 
 static inline int btree_insert_entry_cmp(const struct btree_insert_entry *l,
diff --git a/fs/bcachefs/btree_write_buffer_types.h b/fs/bcachefs/btree_write_buffer_types.h
index e9e76e20f43b..d39d163c6ea9 100644
--- a/fs/bcachefs/btree_write_buffer_types.h
+++ b/fs/bcachefs/btree_write_buffer_types.h
@@ -2,7 +2,7 @@
 #ifndef _BCACHEFS_BTREE_WRITE_BUFFER_TYPES_H
 #define _BCACHEFS_BTREE_WRITE_BUFFER_TYPES_H
 
-#include "darray.h"
+#include <linux/darray_types.h>
 #include "journal_types.h"
 
 #define BTREE_WRITE_BUFERED_VAL_U64s_MAX	4
diff --git a/fs/bcachefs/disk_accounting_types.h b/fs/bcachefs/disk_accounting_types.h
index b1982131b206..242b3270cd5c 100644
--- a/fs/bcachefs/disk_accounting_types.h
+++ b/fs/bcachefs/disk_accounting_types.h
@@ -2,7 +2,7 @@
 #ifndef _BCACHEFS_DISK_ACCOUNTING_TYPES_H
 #define _BCACHEFS_DISK_ACCOUNTING_TYPES_H
 
-#include "darray.h"
+#include <linux/darray.h>
 
 struct accounting_mem_entry {
 	struct bpos				pos;
diff --git a/fs/bcachefs/fsck.c b/fs/bcachefs/fsck.c
index 338309d0a570..cc56c706d2b0 100644
--- a/fs/bcachefs/fsck.c
+++ b/fs/bcachefs/fsck.c
@@ -6,7 +6,6 @@
 #include "btree_cache.h"
 #include "btree_update.h"
 #include "buckets.h"
-#include "darray.h"
 #include "dirent.h"
 #include "error.h"
 #include "fs.h"
@@ -21,6 +20,7 @@
 #include "xattr.h"
 
 #include <linux/bsearch.h>
+#include <linux/darray.h>
 #include <linux/dcache.h> /* struct qstr */
 
 static int dirent_points_to_inode_nowarn(struct bkey_s_c_dirent d,
diff --git a/fs/bcachefs/journal_io.h b/fs/bcachefs/journal_io.h
index 12b39fcb4424..ffa543424e9e 100644
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
index 62b910f2fb27..68b960e08f12 100644
--- a/fs/bcachefs/journal_sb.c
+++ b/fs/bcachefs/journal_sb.c
@@ -2,8 +2,8 @@
 
 #include "bcachefs.h"
 #include "journal_sb.h"
-#include "darray.h"
 
+#include <linux/darray.h>
 #include <linux/sort.h>
 
 /* BCH_SB_FIELD_journal: */
diff --git a/fs/bcachefs/rcu_pending.c b/fs/bcachefs/rcu_pending.c
index bef2aa1b8bcd..2cf3d55d0bbc 100644
--- a/fs/bcachefs/rcu_pending.c
+++ b/fs/bcachefs/rcu_pending.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #define pr_fmt(fmt) "%s() " fmt "\n", __func__
 
+#include <linux/darray.h>
 #include <linux/generic-radix-tree.h>
 #include <linux/mm.h>
 #include <linux/percpu.h>
@@ -9,8 +10,6 @@
 #include <linux/vmalloc.h>
 
 #include "rcu_pending.h"
-#include "darray.h"
-#include "util.h"
 
 #define static_array_for_each(_a, _i)			\
 	for (typeof(&(_a)[0]) _i = _a;			\
diff --git a/fs/bcachefs/sb-downgrade.c b/fs/bcachefs/sb-downgrade.c
index 861fce1630f0..d4e22c43eeb2 100644
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
index 40325239c3b0..3b28871d23ed 100644
--- a/fs/bcachefs/sb-errors_types.h
+++ b/fs/bcachefs/sb-errors_types.h
@@ -2,7 +2,7 @@
 #ifndef _BCACHEFS_SB_ERRORS_TYPES_H
 #define _BCACHEFS_SB_ERRORS_TYPES_H
 
-#include "darray.h"
+#include <linux/darray_types.h>
 
 struct bch_sb_error_entry_cpu {
 	u64			id:16,
diff --git a/fs/bcachefs/sb-members.h b/fs/bcachefs/sb-members.h
index 6bd9b86aee5b..09b751a75020 100644
--- a/fs/bcachefs/sb-members.h
+++ b/fs/bcachefs/sb-members.h
@@ -2,10 +2,11 @@
 #ifndef _BCACHEFS_SB_MEMBERS_H
 #define _BCACHEFS_SB_MEMBERS_H
 
-#include "darray.h"
 #include "bkey_types.h"
 #include "enumerated_ref.h"
 
+#include <linux/darray.h>
+
 extern char * const bch2_member_error_strs[];
 
 static inline struct bch_member *
diff --git a/fs/bcachefs/snapshot_types.h b/fs/bcachefs/snapshot_types.h
index 0ab698f13e5c..31f96d1cf5f4 100644
--- a/fs/bcachefs/snapshot_types.h
+++ b/fs/bcachefs/snapshot_types.h
@@ -3,9 +3,10 @@
 #define _BCACHEFS_SNAPSHOT_TYPES_H
 
 #include "bbpos_types.h"
-#include "darray.h"
 #include "subvolume_types.h"
 
+#include <linux/darray_types.h>
+
 typedef DARRAY(u32) snapshot_id_list;
 
 #define IS_ANCESTOR_BITMAP	128
diff --git a/fs/bcachefs/subvolume.h b/fs/bcachefs/subvolume.h
index 075f55e25c70..771ade03a348 100644
--- a/fs/bcachefs/subvolume.h
+++ b/fs/bcachefs/subvolume.h
@@ -2,7 +2,6 @@
 #ifndef _BCACHEFS_SUBVOLUME_H
 #define _BCACHEFS_SUBVOLUME_H
 
-#include "darray.h"
 #include "subvolume_types.h"
 
 int bch2_check_subvols(struct bch_fs *);
diff --git a/fs/bcachefs/thread_with_file_types.h b/fs/bcachefs/thread_with_file_types.h
index f4d484d44f63..254b8493ec4b 100644
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
index 25cf61ebd40c..3985636cbc24 100644
--- a/fs/bcachefs/util.h
+++ b/fs/bcachefs/util.h
@@ -5,24 +5,24 @@
 #include <linux/bio.h>
 #include <linux/blkdev.h>
 #include <linux/closure.h>
+#include <linux/darray.h>
 #include <linux/errno.h>
 #include <linux/freezer.h>
 #include <linux/kernel.h>
 #include <linux/min_heap.h>
-#include <linux/sched/clock.h>
 #include <linux/llist.h>
 #include <linux/log2.h>
 #include <linux/percpu.h>
 #include <linux/preempt.h>
 #include <linux/random.h>
 #include <linux/ratelimit.h>
+#include <linux/sched/clock.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/workqueue.h>
 
 #include "mean_and_variance.h"
 
-#include "darray.h"
 #include "time_stats.h"
 
 struct closure;
@@ -552,30 +552,6 @@ static inline void memset_u64s_tail(void *s, int c, unsigned bytes)
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
similarity index 64%
rename from fs/bcachefs/darray.h
rename to include/linux/darray.h
index 50ec3decfe8c..7a0c0159b319 100644
--- a/fs/bcachefs/darray.h
+++ b/include/linux/darray.h
@@ -1,45 +1,26 @@
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
-typedef DARRAY(char *)	darray_str;
-typedef DARRAY(const char *) darray_const_str;
-
-typedef DARRAY(u8)	darray_u8;
-typedef DARRAY(u16)	darray_u16;
-typedef DARRAY(u32)	darray_u32;
-typedef DARRAY(u64)	darray_u64;
-
-typedef DARRAY(s8)	darray_s8;
-typedef DARRAY(s16)	darray_s16;
-typedef DARRAY(s32)	darray_s32;
-typedef DARRAY(s64)	darray_s64;
-
-int __bch2_darray_resize_noprof(darray_char *, size_t, size_t, gfp_t);
+int __darray_resize_slowpath(darray_char *, size_t, size_t, gfp_t);
 
 #define __bch2_darray_resize(...)	alloc_hooks(__bch2_darray_resize_noprof(__VA_ARGS__))
 
 #define __darray_resize(_d, _element_size, _new_size, _gfp)		\
 	(unlikely((_new_size) > (_d)->size)				\
-	 ? __bch2_darray_resize((_d), (_element_size), (_new_size), (_gfp))\
+	 ? __darray_resize_slowpath((_d), (_element_size), (_new_size), (_gfp))\
 	 : 0)
 
 #define darray_resize_gfp(_d, _new_size, _gfp)				\
@@ -74,6 +55,28 @@ int __bch2_darray_resize_noprof(darray_char *, size_t, size_t, gfp_t);
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
@@ -84,10 +87,15 @@ int __bch2_darray_resize_noprof(darray_char *, size_t, size_t, gfp_t);
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
@@ -111,4 +119,4 @@ do {									\
 	darray_init(_d);						\
 } while (0)
 
-#endif /* _BCACHEFS_DARRAY_H */
+#endif /* _LINUX_DARRAY_H */
diff --git a/include/linux/darray_types.h b/include/linux/darray_types.h
new file mode 100644
index 000000000000..c55484487905
--- /dev/null
+++ b/include/linux/darray_types.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * (C) 2022-2024 Kent Overstreet <kent.overstreet@linux.dev>
+ */
+#ifndef _LINUX_DARRAY_TYPES_H
+#define _LINUX_DARRAY_TYPES_H
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
+typedef DARRAY(const char *) darray_const_str;
+
+typedef DARRAY(u8)	darray_u8;
+typedef DARRAY(u16)	darray_u16;
+typedef DARRAY(u32)	darray_u32;
+typedef DARRAY(u64)	darray_u64;
+
+typedef DARRAY(s8)	darray_s8;
+typedef DARRAY(s16)	darray_s16;
+typedef DARRAY(s32)	darray_s32;
+typedef DARRAY(s64)	darray_s64;
+
+#endif /* _LINUX_DARRAY_TYPES_H */
diff --git a/lib/Makefile b/lib/Makefile
index f07b24ce1b3f..4f053d577bf3 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -56,7 +56,7 @@ obj-y += bcd.o sort.o parser.o debug_locks.o random32.o \
 	 bsearch.o find_bit.o llist.o lwq.o memweight.o kfifo.o \
 	 percpu-refcount.o rhashtable.o base64.o \
 	 once.o refcount.o rcuref.o usercopy.o errseq.o bucket_locks.o \
-	 generic-radix-tree.o bitmap-str.o
+	 generic-radix-tree.o bitmap-str.o darray.o
 obj-y += string_helpers.o
 obj-y += hexdump.o
 obj-$(CONFIG_TEST_HEXDUMP) += test_hexdump.o
diff --git a/fs/bcachefs/darray.c b/lib/darray.c
similarity index 75%
rename from fs/bcachefs/darray.c
rename to lib/darray.c
index e86d36d23e9e..1d3820a43e14 100644
--- a/fs/bcachefs/darray.c
+++ b/lib/darray.c
@@ -1,11 +1,15 @@
 // SPDX-License-Identifier: GPL-2.0
+/*
+ * (C) 2022-2024 Kent Overstreet <kent.overstreet@linux.dev>
+ */
 
+#include <linux/darray.h>
+#include <linux/export.h>
 #include <linux/log2.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
-#include "darray.h"
 
-int __bch2_darray_resize_noprof(darray_char *d, size_t element_size, size_t new_size, gfp_t gfp)
+int __darray_resize_slowpath(darray_char *d, size_t element_size, size_t new_size, gfp_t gfp)
 {
 	if (new_size > d->size) {
 		new_size = roundup_pow_of_two(new_size);
@@ -36,3 +40,4 @@ int __bch2_darray_resize_noprof(darray_char *d, size_t element_size, size_t new_
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(__darray_resize_slowpath);
-- 
2.49.0


