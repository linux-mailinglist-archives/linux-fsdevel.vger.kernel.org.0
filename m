Return-Path: <linux-fsdevel+bounces-25194-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74143949B8D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 00:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A22C6B222FD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 22:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6258017994C;
	Tue,  6 Aug 2024 22:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fd4B0sF7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AA217839C;
	Tue,  6 Aug 2024 22:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722984620; cv=none; b=HLlTaYV1UtB08e03/27jnAhl7f+QtqrlUj4IP3Ts3hUqS3H1wSDodG6Xpf5x9Fs+Lop6No0OAKQim9SCnwTVKxyC435sAtaVc8VrWTAHpOLxTT3V5t9nlnVFBRN7xNSR7w/OOGYbYFpAJBFz4a6z2fj4auvE9aLzLxtzoFAYOyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722984620; c=relaxed/simple;
	bh=wuVJ3fMMB+jQUed5PX/IDLjnX8+4xb4uf3BgKIplZPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F4lVAyZrYJsLivrwyoHw3qulsEoGauyjWNjps3qR65572BcmVM4Jy3MufPewKj4kxlMUj5jufQ1Ng3NzEdbUJZYY6prOVOzBxopTqJ9mx9bMcq10Oju4+DGnW7Bi2tSQCwfsFoWK+VZ1JyxAoCwMJKpgiulYdpKNbzOxIsgA/Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fd4B0sF7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FABAC4AF0C;
	Tue,  6 Aug 2024 22:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722984620;
	bh=wuVJ3fMMB+jQUed5PX/IDLjnX8+4xb4uf3BgKIplZPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fd4B0sF7CHeqWbjxs0EHqLAY8+4pbJsZ5KgedAy0lZnZxwP3xxkVPW9SCUPx25FGC
	 vJMekXuDMWzjMkKp4P153nAuFVzpTcZO7SHbpg0AyHnYxTrqaNVJIbcVYxREnR5HI0
	 8MuHUTk8lq5OznzZyW4+FNVS1XSD9/RoqXNqyYnPLtjjUxc0qL9K+hh56MR+/HgJNv
	 rrz2dtOUivCZtc/VSAIXVt6sbAYf+arM8Htu8W7J3U8b/zuA1IyvpT6qiClOZTcSdG
	 4sjAPyBkA0nCkb/kjs7wgGGnrlg54EW/96KVev0lNPCw4git9LiAGiIN2HxvsMOZah
	 3LFFBuZf4bEfA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 08/10] tools/include: Sync filesystem headers with the kernel sources
Date: Tue,  6 Aug 2024 15:50:11 -0700
Message-ID: <20240806225013.126130-9-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
In-Reply-To: <20240806225013.126130-1-namhyung@kernel.org>
References: <20240806225013.126130-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To pick up changes from:

  0f9ca80fa4f9 fs: Add initial atomic write support info to statx
  f9af549d1fd3 fs: export mount options via statmount()
  0a3deb11858a fs: Allow listmount() in foreign mount namespace
  09b31295f833 fs: export the mount ns id via statmount
  d04bccd8c19d listmount: allow listing in reverse order
  bfc69fd05ef9 fs/procfs: add build ID fetching to PROCMAP_QUERY API
  ed5d583a88a9 fs/procfs: implement efficient VMA querying API for /proc/<pid>/maps

This should be used to beautify FS syscall arguments and it addresses
these tools/perf build warnings:

  Warning: Kernel ABI header differences:
  diff -u tools/include/uapi/linux/stat.h include/uapi/linux/stat.h
  diff -u tools/perf/trace/beauty/include/uapi/linux/fs.h include/uapi/linux/fs.h
  diff -u tools/perf/trace/beauty/include/uapi/linux/mount.h include/uapi/linux/mount.h
  diff -u tools/perf/trace/beauty/include/uapi/linux/stat.h include/uapi/linux/stat.h

Please see tools/include/uapi/README for details (it's in the first patch
of this series).

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/include/uapi/linux/stat.h               |  12 +-
 .../perf/trace/beauty/include/uapi/linux/fs.h | 163 +++++++++++++++++-
 .../trace/beauty/include/uapi/linux/mount.h   |  10 +-
 .../trace/beauty/include/uapi/linux/stat.h    |  12 +-
 4 files changed, 189 insertions(+), 8 deletions(-)

diff --git a/tools/include/uapi/linux/stat.h b/tools/include/uapi/linux/stat.h
index 67626d535316..887a25286441 100644
--- a/tools/include/uapi/linux/stat.h
+++ b/tools/include/uapi/linux/stat.h
@@ -126,9 +126,15 @@ struct statx {
 	__u64	stx_mnt_id;
 	__u32	stx_dio_mem_align;	/* Memory buffer alignment for direct I/O */
 	__u32	stx_dio_offset_align;	/* File offset alignment for direct I/O */
-	__u64	stx_subvol;	/* Subvolume identifier */
 	/* 0xa0 */
-	__u64	__spare3[11];	/* Spare space for future expansion */
+	__u64	stx_subvol;	/* Subvolume identifier */
+	__u32	stx_atomic_write_unit_min;	/* Min atomic write unit in bytes */
+	__u32	stx_atomic_write_unit_max;	/* Max atomic write unit in bytes */
+	/* 0xb0 */
+	__u32   stx_atomic_write_segments_max;	/* Max atomic write segment count */
+	__u32   __spare1[1];
+	/* 0xb8 */
+	__u64	__spare3[9];	/* Spare space for future expansion */
 	/* 0x100 */
 };
 
@@ -157,6 +163,7 @@ struct statx {
 #define STATX_DIOALIGN		0x00002000U	/* Want/got direct I/O alignment info */
 #define STATX_MNT_ID_UNIQUE	0x00004000U	/* Want/got extended stx_mount_id */
 #define STATX_SUBVOL		0x00008000U	/* Want/got stx_subvol */
+#define STATX_WRITE_ATOMIC	0x00010000U	/* Want/got atomic_write_* fields */
 
 #define STATX__RESERVED		0x80000000U	/* Reserved for future struct statx expansion */
 
@@ -192,6 +199,7 @@ struct statx {
 #define STATX_ATTR_MOUNT_ROOT		0x00002000 /* Root of a mount */
 #define STATX_ATTR_VERITY		0x00100000 /* [I] Verity protected file */
 #define STATX_ATTR_DAX			0x00200000 /* File is currently in DAX state */
+#define STATX_ATTR_WRITE_ATOMIC		0x00400000 /* File supports atomic write operations */
 
 
 #endif /* _UAPI_LINUX_STAT_H */
diff --git a/tools/perf/trace/beauty/include/uapi/linux/fs.h b/tools/perf/trace/beauty/include/uapi/linux/fs.h
index 45e4e64fd664..753971770733 100644
--- a/tools/perf/trace/beauty/include/uapi/linux/fs.h
+++ b/tools/perf/trace/beauty/include/uapi/linux/fs.h
@@ -329,12 +329,17 @@ typedef int __bitwise __kernel_rwf_t;
 /* per-IO negation of O_APPEND */
 #define RWF_NOAPPEND	((__force __kernel_rwf_t)0x00000020)
 
+/* Atomic Write */
+#define RWF_ATOMIC	((__force __kernel_rwf_t)0x00000040)
+
 /* mask of flags supported by the kernel */
 #define RWF_SUPPORTED	(RWF_HIPRI | RWF_DSYNC | RWF_SYNC | RWF_NOWAIT |\
-			 RWF_APPEND | RWF_NOAPPEND)
+			 RWF_APPEND | RWF_NOAPPEND | RWF_ATOMIC)
+
+#define PROCFS_IOCTL_MAGIC 'f'
 
 /* Pagemap ioctl */
-#define PAGEMAP_SCAN	_IOWR('f', 16, struct pm_scan_arg)
+#define PAGEMAP_SCAN	_IOWR(PROCFS_IOCTL_MAGIC, 16, struct pm_scan_arg)
 
 /* Bitmasks provided in pm_scan_args masks and reported in page_region.categories. */
 #define PAGE_IS_WPALLOWED	(1 << 0)
@@ -393,4 +398,158 @@ struct pm_scan_arg {
 	__u64 return_mask;
 };
 
+/* /proc/<pid>/maps ioctl */
+#define PROCMAP_QUERY	_IOWR(PROCFS_IOCTL_MAGIC, 17, struct procmap_query)
+
+enum procmap_query_flags {
+	/*
+	 * VMA permission flags.
+	 *
+	 * Can be used as part of procmap_query.query_flags field to look up
+	 * only VMAs satisfying specified subset of permissions. E.g., specifying
+	 * PROCMAP_QUERY_VMA_READABLE only will return both readable and read/write VMAs,
+	 * while having PROCMAP_QUERY_VMA_READABLE | PROCMAP_QUERY_VMA_WRITABLE will only
+	 * return read/write VMAs, though both executable/non-executable and
+	 * private/shared will be ignored.
+	 *
+	 * PROCMAP_QUERY_VMA_* flags are also returned in procmap_query.vma_flags
+	 * field to specify actual VMA permissions.
+	 */
+	PROCMAP_QUERY_VMA_READABLE		= 0x01,
+	PROCMAP_QUERY_VMA_WRITABLE		= 0x02,
+	PROCMAP_QUERY_VMA_EXECUTABLE		= 0x04,
+	PROCMAP_QUERY_VMA_SHARED		= 0x08,
+	/*
+	 * Query modifier flags.
+	 *
+	 * By default VMA that covers provided address is returned, or -ENOENT
+	 * is returned. With PROCMAP_QUERY_COVERING_OR_NEXT_VMA flag set, closest
+	 * VMA with vma_start > addr will be returned if no covering VMA is
+	 * found.
+	 *
+	 * PROCMAP_QUERY_FILE_BACKED_VMA instructs query to consider only VMAs that
+	 * have file backing. Can be combined with PROCMAP_QUERY_COVERING_OR_NEXT_VMA
+	 * to iterate all VMAs with file backing.
+	 */
+	PROCMAP_QUERY_COVERING_OR_NEXT_VMA	= 0x10,
+	PROCMAP_QUERY_FILE_BACKED_VMA		= 0x20,
+};
+
+/*
+ * Input/output argument structured passed into ioctl() call. It can be used
+ * to query a set of VMAs (Virtual Memory Areas) of a process.
+ *
+ * Each field can be one of three kinds, marked in a short comment to the
+ * right of the field:
+ *   - "in", input argument, user has to provide this value, kernel doesn't modify it;
+ *   - "out", output argument, kernel sets this field with VMA data;
+ *   - "in/out", input and output argument; user provides initial value (used
+ *     to specify maximum allowable buffer size), and kernel sets it to actual
+ *     amount of data written (or zero, if there is no data).
+ *
+ * If matching VMA is found (according to criterias specified by
+ * query_addr/query_flags, all the out fields are filled out, and ioctl()
+ * returns 0. If there is no matching VMA, -ENOENT will be returned.
+ * In case of any other error, negative error code other than -ENOENT is
+ * returned.
+ *
+ * Most of the data is similar to the one returned as text in /proc/<pid>/maps
+ * file, but procmap_query provides more querying flexibility. There are no
+ * consistency guarantees between subsequent ioctl() calls, but data returned
+ * for matched VMA is self-consistent.
+ */
+struct procmap_query {
+	/* Query struct size, for backwards/forward compatibility */
+	__u64 size;
+	/*
+	 * Query flags, a combination of enum procmap_query_flags values.
+	 * Defines query filtering and behavior, see enum procmap_query_flags.
+	 *
+	 * Input argument, provided by user. Kernel doesn't modify it.
+	 */
+	__u64 query_flags;		/* in */
+	/*
+	 * Query address. By default, VMA that covers this address will
+	 * be looked up. PROCMAP_QUERY_* flags above modify this default
+	 * behavior further.
+	 *
+	 * Input argument, provided by user. Kernel doesn't modify it.
+	 */
+	__u64 query_addr;		/* in */
+	/* VMA starting (inclusive) and ending (exclusive) address, if VMA is found. */
+	__u64 vma_start;		/* out */
+	__u64 vma_end;			/* out */
+	/* VMA permissions flags. A combination of PROCMAP_QUERY_VMA_* flags. */
+	__u64 vma_flags;		/* out */
+	/* VMA backing page size granularity. */
+	__u64 vma_page_size;		/* out */
+	/*
+	 * VMA file offset. If VMA has file backing, this specifies offset
+	 * within the file that VMA's start address corresponds to.
+	 * Is set to zero if VMA has no backing file.
+	 */
+	__u64 vma_offset;		/* out */
+	/* Backing file's inode number, or zero, if VMA has no backing file. */
+	__u64 inode;			/* out */
+	/* Backing file's device major/minor number, or zero, if VMA has no backing file. */
+	__u32 dev_major;		/* out */
+	__u32 dev_minor;		/* out */
+	/*
+	 * If set to non-zero value, signals the request to return VMA name
+	 * (i.e., VMA's backing file's absolute path, with " (deleted)" suffix
+	 * appended, if file was unlinked from FS) for matched VMA. VMA name
+	 * can also be some special name (e.g., "[heap]", "[stack]") or could
+	 * be even user-supplied with prctl(PR_SET_VMA, PR_SET_VMA_ANON_NAME).
+	 *
+	 * Kernel will set this field to zero, if VMA has no associated name.
+	 * Otherwise kernel will return actual amount of bytes filled in
+	 * user-supplied buffer (see vma_name_addr field below), including the
+	 * terminating zero.
+	 *
+	 * If VMA name is longer that user-supplied maximum buffer size,
+	 * -E2BIG error is returned.
+	 *
+	 * If this field is set to non-zero value, vma_name_addr should point
+	 * to valid user space memory buffer of at least vma_name_size bytes.
+	 * If set to zero, vma_name_addr should be set to zero as well
+	 */
+	__u32 vma_name_size;		/* in/out */
+	/*
+	 * If set to non-zero value, signals the request to extract and return
+	 * VMA's backing file's build ID, if the backing file is an ELF file
+	 * and it contains embedded build ID.
+	 *
+	 * Kernel will set this field to zero, if VMA has no backing file,
+	 * backing file is not an ELF file, or ELF file has no build ID
+	 * embedded.
+	 *
+	 * Build ID is a binary value (not a string). Kernel will set
+	 * build_id_size field to exact number of bytes used for build ID.
+	 * If build ID is requested and present, but needs more bytes than
+	 * user-supplied maximum buffer size (see build_id_addr field below),
+	 * -E2BIG error will be returned.
+	 *
+	 * If this field is set to non-zero value, build_id_addr should point
+	 * to valid user space memory buffer of at least build_id_size bytes.
+	 * If set to zero, build_id_addr should be set to zero as well
+	 */
+	__u32 build_id_size;		/* in/out */
+	/*
+	 * User-supplied address of a buffer of at least vma_name_size bytes
+	 * for kernel to fill with matched VMA's name (see vma_name_size field
+	 * description above for details).
+	 *
+	 * Should be set to zero if VMA name should not be returned.
+	 */
+	__u64 vma_name_addr;		/* in */
+	/*
+	 * User-supplied address of a buffer of at least build_id_size bytes
+	 * for kernel to fill with matched VMA's ELF build ID, if available
+	 * (see build_id_size field description above for details).
+	 *
+	 * Should be set to zero if build ID should not be returned.
+	 */
+	__u64 build_id_addr;		/* in */
+};
+
 #endif /* _UAPI_LINUX_FS_H */
diff --git a/tools/perf/trace/beauty/include/uapi/linux/mount.h b/tools/perf/trace/beauty/include/uapi/linux/mount.h
index ad5478dbad00..225bc366ffcb 100644
--- a/tools/perf/trace/beauty/include/uapi/linux/mount.h
+++ b/tools/perf/trace/beauty/include/uapi/linux/mount.h
@@ -154,7 +154,7 @@ struct mount_attr {
  */
 struct statmount {
 	__u32 size;		/* Total size, including strings */
-	__u32 __spare1;
+	__u32 mnt_opts;		/* [str] Mount options of the mount */
 	__u64 mask;		/* What results were written */
 	__u32 sb_dev_major;	/* Device ID */
 	__u32 sb_dev_minor;
@@ -172,7 +172,8 @@ struct statmount {
 	__u64 propagate_from;	/* Propagation from in current namespace */
 	__u32 mnt_root;		/* [str] Root of mount relative to root of fs */
 	__u32 mnt_point;	/* [str] Mountpoint relative to current root */
-	__u64 __spare2[50];
+	__u64 mnt_ns_id;	/* ID of the mount namespace */
+	__u64 __spare2[49];
 	char str[];		/* Variable size part containing strings */
 };
 
@@ -188,10 +189,12 @@ struct mnt_id_req {
 	__u32 spare;
 	__u64 mnt_id;
 	__u64 param;
+	__u64 mnt_ns_id;
 };
 
 /* List of all mnt_id_req versions. */
 #define MNT_ID_REQ_SIZE_VER0	24 /* sizeof first published struct */
+#define MNT_ID_REQ_SIZE_VER1	32 /* sizeof second published struct */
 
 /*
  * @mask bits for statmount(2)
@@ -202,10 +205,13 @@ struct mnt_id_req {
 #define STATMOUNT_MNT_ROOT		0x00000008U	/* Want/got mnt_root  */
 #define STATMOUNT_MNT_POINT		0x00000010U	/* Want/got mnt_point */
 #define STATMOUNT_FS_TYPE		0x00000020U	/* Want/got fs_type */
+#define STATMOUNT_MNT_NS_ID		0x00000040U	/* Want/got mnt_ns_id */
+#define STATMOUNT_MNT_OPTS		0x00000080U	/* Want/got mnt_opts */
 
 /*
  * Special @mnt_id values that can be passed to listmount
  */
 #define LSMT_ROOT		0xffffffffffffffff	/* root mount */
+#define LISTMOUNT_REVERSE	(1 << 0) /* List later mounts first */
 
 #endif /* _UAPI_LINUX_MOUNT_H */
diff --git a/tools/perf/trace/beauty/include/uapi/linux/stat.h b/tools/perf/trace/beauty/include/uapi/linux/stat.h
index 67626d535316..887a25286441 100644
--- a/tools/perf/trace/beauty/include/uapi/linux/stat.h
+++ b/tools/perf/trace/beauty/include/uapi/linux/stat.h
@@ -126,9 +126,15 @@ struct statx {
 	__u64	stx_mnt_id;
 	__u32	stx_dio_mem_align;	/* Memory buffer alignment for direct I/O */
 	__u32	stx_dio_offset_align;	/* File offset alignment for direct I/O */
-	__u64	stx_subvol;	/* Subvolume identifier */
 	/* 0xa0 */
-	__u64	__spare3[11];	/* Spare space for future expansion */
+	__u64	stx_subvol;	/* Subvolume identifier */
+	__u32	stx_atomic_write_unit_min;	/* Min atomic write unit in bytes */
+	__u32	stx_atomic_write_unit_max;	/* Max atomic write unit in bytes */
+	/* 0xb0 */
+	__u32   stx_atomic_write_segments_max;	/* Max atomic write segment count */
+	__u32   __spare1[1];
+	/* 0xb8 */
+	__u64	__spare3[9];	/* Spare space for future expansion */
 	/* 0x100 */
 };
 
@@ -157,6 +163,7 @@ struct statx {
 #define STATX_DIOALIGN		0x00002000U	/* Want/got direct I/O alignment info */
 #define STATX_MNT_ID_UNIQUE	0x00004000U	/* Want/got extended stx_mount_id */
 #define STATX_SUBVOL		0x00008000U	/* Want/got stx_subvol */
+#define STATX_WRITE_ATOMIC	0x00010000U	/* Want/got atomic_write_* fields */
 
 #define STATX__RESERVED		0x80000000U	/* Reserved for future struct statx expansion */
 
@@ -192,6 +199,7 @@ struct statx {
 #define STATX_ATTR_MOUNT_ROOT		0x00002000 /* Root of a mount */
 #define STATX_ATTR_VERITY		0x00100000 /* [I] Verity protected file */
 #define STATX_ATTR_DAX			0x00200000 /* File is currently in DAX state */
+#define STATX_ATTR_WRITE_ATOMIC		0x00400000 /* File supports atomic write operations */
 
 
 #endif /* _UAPI_LINUX_STAT_H */
-- 
2.46.0.rc2.264.g509ed76dc8-goog


