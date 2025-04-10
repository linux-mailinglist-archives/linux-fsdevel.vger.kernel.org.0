Return-Path: <linux-fsdevel+bounces-46144-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D5FA834F8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 02:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B65C8467828
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 00:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2494A6A33B;
	Thu, 10 Apr 2025 00:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KF3nTh2P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F8D2EAF7;
	Thu, 10 Apr 2025 00:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744243889; cv=none; b=tLWmEX94rmxeUxsNx+17USq/4s37SkpLdPffF1tvaQ+JvCoCsMWCvolVXzX70c9fGd8i2wvnwpbkb6/CSnQtA4m1peKX2qax457k5iK8RIJEslZEZbbgBwQeSBkNxTTWWz5vQFZdRmNj2EYkVmuuo2t1CracibgKfLijn0kDlvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744243889; c=relaxed/simple;
	bh=Rgg5bpdxIO+BYS9u82ebgAKUejZ/QWm2LeNMH8pvgmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OuOhUIISwkD9U1JWJfdTTxyH6dVPmnTip7X6n9NMUjqJ5ueknbD3eyMuNGVyyUZ46X0/ijctZBTNneVniTenTVCDvLmZ3r1s3LU0QzB5/U7A+Fi8aAmD3GhBb+IuT9mGu4s/xGBKiVQIoiqgo4E7HQB5lL7YwWRoVHqdvi4+WDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KF3nTh2P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6DBEC4CEEE;
	Thu, 10 Apr 2025 00:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744243889;
	bh=Rgg5bpdxIO+BYS9u82ebgAKUejZ/QWm2LeNMH8pvgmE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KF3nTh2PA78ZBLpHtjfW6V0CTvbETieFKZ0eJPn1+c5hc7ruw4koekY6t9TdQBBHg
	 4+8H/unmzf65vkEENSiX87ikBxhPN5dbOz/Bt2pa91uVRwAEkVoEZPAd8R8tFTRm6o
	 YsanVfempdYNVpyaylX13GyMiBbPMbd8prmKz8HF2MasGULKU1yZpG/NN3o0FhKbLW
	 PwgTNxCwQDVpD82sB9JMf8EvLgbUH5boW8t1DQj9I6+K8dNunSiWWOp6gnFFaCmD9I
	 Qss3snrLTmC0/bdSDoLGgr0iF10sZB2xGQVaGU0CFo07LfsPPWzFlZGf+UG32fsO5o
	 nCKO85kOgDdbA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 04/10] tools headers: Update the VFS headers with the kernel sources
Date: Wed,  9 Apr 2025 17:11:19 -0700
Message-ID: <20250410001125.391820-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
In-Reply-To: <20250410001125.391820-1-namhyung@kernel.org>
References: <20250410001125.391820-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To pick up the changes in:

  7ed6cbe0f8caa6ee fs: add STATX_DIO_READ_ALIGN
  8fc7e23a9bd851e6 fs: reformat the statx definition
  a5874fde3c0884a3 exec: Add a new AT_EXECVE_CHECK flag to execveat(2)
  1ebd4a3c095cd538 blk-crypto: add ioctls to create and prepare hardware-wrapped keys
  af6505e5745b9f3a fs: add RWF_DONTCACHE iocb and FOP_DONTCACHE file_operations flag
  10783d0ba0d7731e fs, iov_iter: define meta io descriptor
  8f6116b5b77b0536 statmount: add a new supported_mask field
  37c4a9590e1efcae statmount: allow to retrieve idmappings

Addressing this perf tools build warning:

  Warning: Kernel ABI header differences:
    diff -u tools/include/uapi/linux/stat.h include/uapi/linux/stat.h
    diff -u tools/perf/trace/beauty/include/uapi/linux/stat.h include/uapi/linux/stat.h
    diff -u tools/perf/trace/beauty/include/uapi/linux/fcntl.h include/uapi/linux/fcntl.h
    diff -u tools/perf/trace/beauty/include/uapi/linux/fs.h include/uapi/linux/fs.h
    diff -u tools/perf/trace/beauty/include/uapi/linux/mount.h include/uapi/linux/mount.h

Please see tools/include/uapi/README for further details.

Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/include/uapi/linux/stat.h               | 99 ++++++++++++++-----
 .../trace/beauty/include/uapi/linux/fcntl.h   |  4 +
 .../perf/trace/beauty/include/uapi/linux/fs.h | 21 +++-
 .../trace/beauty/include/uapi/linux/mount.h   | 10 +-
 .../trace/beauty/include/uapi/linux/stat.h    | 99 ++++++++++++++-----
 5 files changed, 179 insertions(+), 54 deletions(-)

diff --git a/tools/include/uapi/linux/stat.h b/tools/include/uapi/linux/stat.h
index 887a2528644168a3..f78ee3670dd5d7c8 100644
--- a/tools/include/uapi/linux/stat.h
+++ b/tools/include/uapi/linux/stat.h
@@ -98,43 +98,93 @@ struct statx_timestamp {
  */
 struct statx {
 	/* 0x00 */
-	__u32	stx_mask;	/* What results were written [uncond] */
-	__u32	stx_blksize;	/* Preferred general I/O size [uncond] */
-	__u64	stx_attributes;	/* Flags conveying information about the file [uncond] */
+	/* What results were written [uncond] */
+	__u32	stx_mask;
+
+	/* Preferred general I/O size [uncond] */
+	__u32	stx_blksize;
+
+	/* Flags conveying information about the file [uncond] */
+	__u64	stx_attributes;
+
 	/* 0x10 */
-	__u32	stx_nlink;	/* Number of hard links */
-	__u32	stx_uid;	/* User ID of owner */
-	__u32	stx_gid;	/* Group ID of owner */
-	__u16	stx_mode;	/* File mode */
+	/* Number of hard links */
+	__u32	stx_nlink;
+
+	/* User ID of owner */
+	__u32	stx_uid;
+
+	/* Group ID of owner */
+	__u32	stx_gid;
+
+	/* File mode */
+	__u16	stx_mode;
 	__u16	__spare0[1];
+
 	/* 0x20 */
-	__u64	stx_ino;	/* Inode number */
-	__u64	stx_size;	/* File size */
-	__u64	stx_blocks;	/* Number of 512-byte blocks allocated */
-	__u64	stx_attributes_mask; /* Mask to show what's supported in stx_attributes */
+	/* Inode number */
+	__u64	stx_ino;
+
+	/* File size */
+	__u64	stx_size;
+
+	/* Number of 512-byte blocks allocated */
+	__u64	stx_blocks;
+
+	/* Mask to show what's supported in stx_attributes */
+	__u64	stx_attributes_mask;
+
 	/* 0x40 */
-	struct statx_timestamp	stx_atime;	/* Last access time */
-	struct statx_timestamp	stx_btime;	/* File creation time */
-	struct statx_timestamp	stx_ctime;	/* Last attribute change time */
-	struct statx_timestamp	stx_mtime;	/* Last data modification time */
+	/* Last access time */
+	struct statx_timestamp	stx_atime;
+
+	/* File creation time */
+	struct statx_timestamp	stx_btime;
+
+	/* Last attribute change time */
+	struct statx_timestamp	stx_ctime;
+
+	/* Last data modification time */
+	struct statx_timestamp	stx_mtime;
+
 	/* 0x80 */
-	__u32	stx_rdev_major;	/* Device ID of special file [if bdev/cdev] */
+	/* Device ID of special file [if bdev/cdev] */
+	__u32	stx_rdev_major;
 	__u32	stx_rdev_minor;
-	__u32	stx_dev_major;	/* ID of device containing file [uncond] */
+
+	/* ID of device containing file [uncond] */
+	__u32	stx_dev_major;
 	__u32	stx_dev_minor;
+
 	/* 0x90 */
 	__u64	stx_mnt_id;
-	__u32	stx_dio_mem_align;	/* Memory buffer alignment for direct I/O */
-	__u32	stx_dio_offset_align;	/* File offset alignment for direct I/O */
+
+	/* Memory buffer alignment for direct I/O */
+	__u32	stx_dio_mem_align;
+
+	/* File offset alignment for direct I/O */
+	__u32	stx_dio_offset_align;
+
 	/* 0xa0 */
-	__u64	stx_subvol;	/* Subvolume identifier */
-	__u32	stx_atomic_write_unit_min;	/* Min atomic write unit in bytes */
-	__u32	stx_atomic_write_unit_max;	/* Max atomic write unit in bytes */
+	/* Subvolume identifier */
+	__u64	stx_subvol;
+
+	/* Min atomic write unit in bytes */
+	__u32	stx_atomic_write_unit_min;
+
+	/* Max atomic write unit in bytes */
+	__u32	stx_atomic_write_unit_max;
+
 	/* 0xb0 */
-	__u32   stx_atomic_write_segments_max;	/* Max atomic write segment count */
-	__u32   __spare1[1];
+	/* Max atomic write segment count */
+	__u32   stx_atomic_write_segments_max;
+
+	/* File offset alignment for direct I/O reads */
+	__u32	stx_dio_read_offset_align;
+
 	/* 0xb8 */
 	__u64	__spare3[9];	/* Spare space for future expansion */
+
 	/* 0x100 */
 };
 
@@ -164,6 +214,7 @@ struct statx {
 #define STATX_MNT_ID_UNIQUE	0x00004000U	/* Want/got extended stx_mount_id */
 #define STATX_SUBVOL		0x00008000U	/* Want/got stx_subvol */
 #define STATX_WRITE_ATOMIC	0x00010000U	/* Want/got atomic_write_* fields */
+#define STATX_DIO_READ_ALIGN	0x00020000U	/* Want/got dio read alignment info */
 
 #define STATX__RESERVED		0x80000000U	/* Reserved for future struct statx expansion */
 
diff --git a/tools/perf/trace/beauty/include/uapi/linux/fcntl.h b/tools/perf/trace/beauty/include/uapi/linux/fcntl.h
index 6e6907e63bfc2b4d..a15ac2fa4b202fa0 100644
--- a/tools/perf/trace/beauty/include/uapi/linux/fcntl.h
+++ b/tools/perf/trace/beauty/include/uapi/linux/fcntl.h
@@ -155,4 +155,8 @@
 #define AT_HANDLE_MNT_ID_UNIQUE	0x001	/* Return the u64 unique mount ID. */
 #define AT_HANDLE_CONNECTABLE	0x002	/* Request a connectable file handle */
 
+/* Flags for execveat2(2). */
+#define AT_EXECVE_CHECK		0x10000	/* Only perform a check if execution
+					   would be allowed. */
+
 #endif /* _UAPI_LINUX_FCNTL_H */
diff --git a/tools/perf/trace/beauty/include/uapi/linux/fs.h b/tools/perf/trace/beauty/include/uapi/linux/fs.h
index 7539717707337a8c..e762e1af650c4bf0 100644
--- a/tools/perf/trace/beauty/include/uapi/linux/fs.h
+++ b/tools/perf/trace/beauty/include/uapi/linux/fs.h
@@ -40,6 +40,15 @@
 #define BLOCK_SIZE_BITS 10
 #define BLOCK_SIZE (1<<BLOCK_SIZE_BITS)
 
+/* flags for integrity meta */
+#define IO_INTEGRITY_CHK_GUARD		(1U << 0) /* enforce guard check */
+#define IO_INTEGRITY_CHK_REFTAG		(1U << 1) /* enforce ref check */
+#define IO_INTEGRITY_CHK_APPTAG		(1U << 2) /* enforce app check */
+
+#define IO_INTEGRITY_VALID_FLAGS (IO_INTEGRITY_CHK_GUARD | \
+				  IO_INTEGRITY_CHK_REFTAG | \
+				  IO_INTEGRITY_CHK_APPTAG)
+
 #define SEEK_SET	0	/* seek relative to beginning of file */
 #define SEEK_CUR	1	/* seek relative to current file position */
 #define SEEK_END	2	/* seek relative to end of file */
@@ -203,10 +212,8 @@ struct fsxattr {
 #define BLKROTATIONAL _IO(0x12,126)
 #define BLKZEROOUT _IO(0x12,127)
 #define BLKGETDISKSEQ _IOR(0x12,128,__u64)
-/*
- * A jump here: 130-136 are reserved for zoned block devices
- * (see uapi/linux/blkzoned.h)
- */
+/* 130-136 are used by zoned block device ioctls (uapi/linux/blkzoned.h) */
+/* 137-141 are used by blk-crypto ioctls (uapi/linux/blk-crypto.h) */
 
 #define BMAP_IOCTL 1		/* obsolete - kept for compatibility */
 #define FIBMAP	   _IO(0x00,1)	/* bmap access */
@@ -332,9 +339,13 @@ typedef int __bitwise __kernel_rwf_t;
 /* Atomic Write */
 #define RWF_ATOMIC	((__force __kernel_rwf_t)0x00000040)
 
+/* buffered IO that drops the cache after reading or writing data */
+#define RWF_DONTCACHE	((__force __kernel_rwf_t)0x00000080)
+
 /* mask of flags supported by the kernel */
 #define RWF_SUPPORTED	(RWF_HIPRI | RWF_DSYNC | RWF_SYNC | RWF_NOWAIT |\
-			 RWF_APPEND | RWF_NOAPPEND | RWF_ATOMIC)
+			 RWF_APPEND | RWF_NOAPPEND | RWF_ATOMIC |\
+			 RWF_DONTCACHE)
 
 #define PROCFS_IOCTL_MAGIC 'f'
 
diff --git a/tools/perf/trace/beauty/include/uapi/linux/mount.h b/tools/perf/trace/beauty/include/uapi/linux/mount.h
index c07008816acae89c..7fa67c2031a5db52 100644
--- a/tools/perf/trace/beauty/include/uapi/linux/mount.h
+++ b/tools/perf/trace/beauty/include/uapi/linux/mount.h
@@ -179,7 +179,12 @@ struct statmount {
 	__u32 opt_array;	/* [str] Array of nul terminated fs options */
 	__u32 opt_sec_num;	/* Number of security options */
 	__u32 opt_sec_array;	/* [str] Array of nul terminated security options */
-	__u64 __spare2[46];
+	__u64 supported_mask;	/* Mask flags that this kernel supports */
+	__u32 mnt_uidmap_num;	/* Number of uid mappings */
+	__u32 mnt_uidmap;	/* [str] Array of uid mappings (as seen from callers namespace) */
+	__u32 mnt_gidmap_num;	/* Number of gid mappings */
+	__u32 mnt_gidmap;	/* [str] Array of gid mappings (as seen from callers namespace) */
+	__u64 __spare2[43];
 	char str[];		/* Variable size part containing strings */
 };
 
@@ -217,6 +222,9 @@ struct mnt_id_req {
 #define STATMOUNT_SB_SOURCE		0x00000200U	/* Want/got sb_source */
 #define STATMOUNT_OPT_ARRAY		0x00000400U	/* Want/got opt_... */
 #define STATMOUNT_OPT_SEC_ARRAY		0x00000800U	/* Want/got opt_sec... */
+#define STATMOUNT_SUPPORTED_MASK	0x00001000U	/* Want/got supported mask flags */
+#define STATMOUNT_MNT_UIDMAP		0x00002000U	/* Want/got uidmap... */
+#define STATMOUNT_MNT_GIDMAP		0x00004000U	/* Want/got gidmap... */
 
 /*
  * Special @mnt_id values that can be passed to listmount
diff --git a/tools/perf/trace/beauty/include/uapi/linux/stat.h b/tools/perf/trace/beauty/include/uapi/linux/stat.h
index 887a2528644168a3..f78ee3670dd5d7c8 100644
--- a/tools/perf/trace/beauty/include/uapi/linux/stat.h
+++ b/tools/perf/trace/beauty/include/uapi/linux/stat.h
@@ -98,43 +98,93 @@ struct statx_timestamp {
  */
 struct statx {
 	/* 0x00 */
-	__u32	stx_mask;	/* What results were written [uncond] */
-	__u32	stx_blksize;	/* Preferred general I/O size [uncond] */
-	__u64	stx_attributes;	/* Flags conveying information about the file [uncond] */
+	/* What results were written [uncond] */
+	__u32	stx_mask;
+
+	/* Preferred general I/O size [uncond] */
+	__u32	stx_blksize;
+
+	/* Flags conveying information about the file [uncond] */
+	__u64	stx_attributes;
+
 	/* 0x10 */
-	__u32	stx_nlink;	/* Number of hard links */
-	__u32	stx_uid;	/* User ID of owner */
-	__u32	stx_gid;	/* Group ID of owner */
-	__u16	stx_mode;	/* File mode */
+	/* Number of hard links */
+	__u32	stx_nlink;
+
+	/* User ID of owner */
+	__u32	stx_uid;
+
+	/* Group ID of owner */
+	__u32	stx_gid;
+
+	/* File mode */
+	__u16	stx_mode;
 	__u16	__spare0[1];
+
 	/* 0x20 */
-	__u64	stx_ino;	/* Inode number */
-	__u64	stx_size;	/* File size */
-	__u64	stx_blocks;	/* Number of 512-byte blocks allocated */
-	__u64	stx_attributes_mask; /* Mask to show what's supported in stx_attributes */
+	/* Inode number */
+	__u64	stx_ino;
+
+	/* File size */
+	__u64	stx_size;
+
+	/* Number of 512-byte blocks allocated */
+	__u64	stx_blocks;
+
+	/* Mask to show what's supported in stx_attributes */
+	__u64	stx_attributes_mask;
+
 	/* 0x40 */
-	struct statx_timestamp	stx_atime;	/* Last access time */
-	struct statx_timestamp	stx_btime;	/* File creation time */
-	struct statx_timestamp	stx_ctime;	/* Last attribute change time */
-	struct statx_timestamp	stx_mtime;	/* Last data modification time */
+	/* Last access time */
+	struct statx_timestamp	stx_atime;
+
+	/* File creation time */
+	struct statx_timestamp	stx_btime;
+
+	/* Last attribute change time */
+	struct statx_timestamp	stx_ctime;
+
+	/* Last data modification time */
+	struct statx_timestamp	stx_mtime;
+
 	/* 0x80 */
-	__u32	stx_rdev_major;	/* Device ID of special file [if bdev/cdev] */
+	/* Device ID of special file [if bdev/cdev] */
+	__u32	stx_rdev_major;
 	__u32	stx_rdev_minor;
-	__u32	stx_dev_major;	/* ID of device containing file [uncond] */
+
+	/* ID of device containing file [uncond] */
+	__u32	stx_dev_major;
 	__u32	stx_dev_minor;
+
 	/* 0x90 */
 	__u64	stx_mnt_id;
-	__u32	stx_dio_mem_align;	/* Memory buffer alignment for direct I/O */
-	__u32	stx_dio_offset_align;	/* File offset alignment for direct I/O */
+
+	/* Memory buffer alignment for direct I/O */
+	__u32	stx_dio_mem_align;
+
+	/* File offset alignment for direct I/O */
+	__u32	stx_dio_offset_align;
+
 	/* 0xa0 */
-	__u64	stx_subvol;	/* Subvolume identifier */
-	__u32	stx_atomic_write_unit_min;	/* Min atomic write unit in bytes */
-	__u32	stx_atomic_write_unit_max;	/* Max atomic write unit in bytes */
+	/* Subvolume identifier */
+	__u64	stx_subvol;
+
+	/* Min atomic write unit in bytes */
+	__u32	stx_atomic_write_unit_min;
+
+	/* Max atomic write unit in bytes */
+	__u32	stx_atomic_write_unit_max;
+
 	/* 0xb0 */
-	__u32   stx_atomic_write_segments_max;	/* Max atomic write segment count */
-	__u32   __spare1[1];
+	/* Max atomic write segment count */
+	__u32   stx_atomic_write_segments_max;
+
+	/* File offset alignment for direct I/O reads */
+	__u32	stx_dio_read_offset_align;
+
 	/* 0xb8 */
 	__u64	__spare3[9];	/* Spare space for future expansion */
+
 	/* 0x100 */
 };
 
@@ -164,6 +214,7 @@ struct statx {
 #define STATX_MNT_ID_UNIQUE	0x00004000U	/* Want/got extended stx_mount_id */
 #define STATX_SUBVOL		0x00008000U	/* Want/got stx_subvol */
 #define STATX_WRITE_ATOMIC	0x00010000U	/* Want/got atomic_write_* fields */
+#define STATX_DIO_READ_ALIGN	0x00020000U	/* Want/got dio read alignment info */
 
 #define STATX__RESERVED		0x80000000U	/* Reserved for future struct statx expansion */
 
-- 
2.49.0.504.g3bcea36a83-goog


