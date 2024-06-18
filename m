Return-Path: <linux-fsdevel+bounces-21906-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E95590DF53
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2024 00:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94166280D7D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2024 22:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32614190693;
	Tue, 18 Jun 2024 22:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+7m1+Mf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5A81849F6;
	Tue, 18 Jun 2024 22:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718750748; cv=none; b=I2jwT4ZDcvQYW9yLP+xXDH8weQ2eTYW3Q/6g969szvOj1SujjD+wl2YKCxHHwjcji/HqJlJ6GC5hKLql4/1Fh13J3z/0654MLZ4/QE1k4MsV6jHTlDY73IoH9WLpeTcovriXlbToBuSMSQYlYmDVVIyFWH1RFEduDOWiQBRzp+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718750748; c=relaxed/simple;
	bh=BRYHJjN55WzCmrelJcd8JVcPZniK31ZSH/3ppJflWBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OFPoV6dVrMFPOFNPgswV/H8/RgaX6WBgiam/KlIGC2b+WtCqES7aqkBHMjVFvr9cYDG3lJG2bg370d0pTtpDWyNzU4jTQXLW0XCPEuxoVTFPiW55SqGAlbYPcTnDdX6WMu/2w7JMtG2HSTx7oo28ZeL+2SEI0vxp87O9N/ods8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h+7m1+Mf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0592AC32786;
	Tue, 18 Jun 2024 22:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718750748;
	bh=BRYHJjN55WzCmrelJcd8JVcPZniK31ZSH/3ppJflWBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h+7m1+MftxjtctKSgK+ErwiEiUuKyGqmCNL+qDMH6l5ecOdq7PogE8ZeY9/wQDkWz
	 yaB4VZX+sao0OsXy2X3rmy+7mqsMauaYi9vEVXYvwzl1lOeK631bUfPUV5yIpH4dv+
	 Pg1sTWe842h1BzI3FOevUeMSseDIShK6pHN7HYXZenyQIJhcb+9jy67xmMOq81DPRH
	 ElfNqsmCu/VRajWHgAkegR7UbM2In+9u6yIFvHXyO/ptL+oBlvujZbqJimkz6L2QLd
	 JMaW5qvY4WeDV3opbnev60+toF+pj5/fzA13ywqOkNHJxp0yh7UnpYoEtJ3Bo2s9kr
	 r4EdVfrIUNf/A==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	gregkh@linuxfoundation.org,
	linux-mm@kvack.org,
	liam.howlett@oracle.com,
	surenb@google.com,
	rppt@kernel.org,
	adobriyan@gmail.com,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v5 5/6] tools: sync uapi/linux/fs.h header into tools subdir
Date: Tue, 18 Jun 2024 15:45:24 -0700
Message-ID: <20240618224527.3685213-6-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618224527.3685213-1-andrii@kernel.org>
References: <20240618224527.3685213-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We need this UAPI header in tools/include subdirectory for using it from
BPF selftests.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/include/uapi/linux/fs.h | 184 +++++++++++++++++++++++++++++++---
 1 file changed, 172 insertions(+), 12 deletions(-)

diff --git a/tools/include/uapi/linux/fs.h b/tools/include/uapi/linux/fs.h
index cc3fea99fd43..cad6375044bc 100644
--- a/tools/include/uapi/linux/fs.h
+++ b/tools/include/uapi/linux/fs.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _LINUX_FS_H
-#define _LINUX_FS_H
+#ifndef _UAPI_LINUX_FS_H
+#define _UAPI_LINUX_FS_H
 
 /*
  * This file has definitions for some important file table structures
@@ -13,10 +13,14 @@
 #include <linux/limits.h>
 #include <linux/ioctl.h>
 #include <linux/types.h>
+#ifndef __KERNEL__
 #include <linux/fscrypt.h>
+#endif
 
 /* Use of MS_* flags within the kernel is restricted to core mount(2) code. */
+#if !defined(__KERNEL__)
 #include <linux/mount.h>
+#endif
 
 /*
  * It's silly to have NR_OPEN bigger than NR_FILE, but you can change
@@ -24,8 +28,8 @@
  * nr_file rlimit, so it's safe to set up a ridiculously high absolute
  * upper limit on files-per-process.
  *
- * Some programs (notably those using select()) may have to be
- * recompiled to take full advantage of the new limits..
+ * Some programs (notably those using select()) may have to be 
+ * recompiled to take full advantage of the new limits..  
  */
 
 /* Fixed constants first: */
@@ -308,29 +312,31 @@ struct fsxattr {
 typedef int __bitwise __kernel_rwf_t;
 
 /* high priority request, poll if possible */
-#define RWF_HIPRI	((__kernel_rwf_t)0x00000001)
+#define RWF_HIPRI	((__force __kernel_rwf_t)0x00000001)
 
 /* per-IO O_DSYNC */
-#define RWF_DSYNC	((__kernel_rwf_t)0x00000002)
+#define RWF_DSYNC	((__force __kernel_rwf_t)0x00000002)
 
 /* per-IO O_SYNC */
-#define RWF_SYNC	((__kernel_rwf_t)0x00000004)
+#define RWF_SYNC	((__force __kernel_rwf_t)0x00000004)
 
 /* per-IO, return -EAGAIN if operation would block */
-#define RWF_NOWAIT	((__kernel_rwf_t)0x00000008)
+#define RWF_NOWAIT	((__force __kernel_rwf_t)0x00000008)
 
 /* per-IO O_APPEND */
-#define RWF_APPEND	((__kernel_rwf_t)0x00000010)
+#define RWF_APPEND	((__force __kernel_rwf_t)0x00000010)
 
 /* per-IO negation of O_APPEND */
-#define RWF_NOAPPEND	((__kernel_rwf_t)0x00000020)
+#define RWF_NOAPPEND	((__force __kernel_rwf_t)0x00000020)
 
 /* mask of flags supported by the kernel */
 #define RWF_SUPPORTED	(RWF_HIPRI | RWF_DSYNC | RWF_SYNC | RWF_NOWAIT |\
 			 RWF_APPEND | RWF_NOAPPEND)
 
+#define PROCFS_IOCTL_MAGIC 'f'
+
 /* Pagemap ioctl */
-#define PAGEMAP_SCAN	_IOWR('f', 16, struct pm_scan_arg)
+#define PAGEMAP_SCAN	_IOWR(PROCFS_IOCTL_MAGIC, 16, struct pm_scan_arg)
 
 /* Bitmasks provided in pm_scan_args masks and reported in page_region.categories. */
 #define PAGE_IS_WPALLOWED	(1 << 0)
@@ -389,4 +395,158 @@ struct pm_scan_arg {
 	__u64 return_mask;
 };
 
-#endif /* _LINUX_FS_H */
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
+	__u32 vma_page_size;		/* out */
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
+#endif /* _UAPI_LINUX_FS_H */
-- 
2.43.0


