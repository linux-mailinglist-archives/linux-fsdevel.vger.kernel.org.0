Return-Path: <linux-fsdevel+bounces-59144-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F78BB34EB5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 00:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 520E11B26979
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 22:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334193093D2;
	Mon, 25 Aug 2025 21:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BMauL+LF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A19F304BC8;
	Mon, 25 Aug 2025 21:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756159152; cv=none; b=Nw29d4JYH4KqLYlFJHTwkwcDtvYFXGk834O4pAHrdOHeQJ20PG8ObiuJu/QiEm4S6eluMECw/ou7cvXePphXYgwSMKt4l0jrFspU342yXnH910pAeunq7pAQ5Flyj/2SfrKIj4ydi7Z21pGLD7kZNP/3tdXl2gHj5bL4yYFoYP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756159152; c=relaxed/simple;
	bh=debu6CtOANeU5OraTdRp6pJY5LK8ZGe07EFkxOyDAvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D9JzhREMUMPSbNM0dkDTKVodAHwxE+xDoJLgJ2bbEHvOZB0zMcE0bqrZpxmAxQbO2jUqD2R0x43lPaGY34tduRgZg0sQ5k48cfJDShnZWhSgTuSr5O6N+ARG9D64PeJLPR9pz/GSGlHuB3/P1HvXZ90mrTX+iZCwZi/dcXTbW8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BMauL+LF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A595CC116C6;
	Mon, 25 Aug 2025 21:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756159152;
	bh=debu6CtOANeU5OraTdRp6pJY5LK8ZGe07EFkxOyDAvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BMauL+LFZZ6fkePoixzfpnIFLW98SKv+iWCsDxGDbIOCr7sw4LzYBvBGlKLWfeet8
	 j90NCJY2jB4lozIwFm9/b3rp/Wn0z3ESo7DA/VeaoMCRDV/TDgypNvkxY7IVjEM+CX
	 16mZTYyrsgEy8VhL1lnta8hCXZYX3+cwChiydeMquPVvJpj6CWKv5FLGZTWLQcwP/a
	 McemCiXjRSKjZqlhKdaG1MEqR38lG4Z2rVtSTeXkRlE+qSATRXqMUy95PbQpa6eDlf
	 vb94PEy0Wt/ABtW2XF15V72FS9J7D7jcVylIJc10ON4gi0Uyq/asFgrRWZTPQrO6AS
	 oC+nxL6Q0VOeg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 09/11] tools headers: Sync uapi/linux/fs.h with the kernel source
Date: Mon, 25 Aug 2025 14:59:01 -0700
Message-ID: <20250825215904.2594216-10-namhyung@kernel.org>
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
In-Reply-To: <20250825215904.2594216-1-namhyung@kernel.org>
References: <20250825215904.2594216-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To pick up the changes in this cset:

  76fdb7eb4e1c9108 uapi: export PROCFS_ROOT_INO
  ca115d7e754691c0 tree-wide: s/struct fileattr/struct file_kattr/g
  be7efb2d20d67f33 fs: introduce file_getattr and file_setattr syscalls
  9eb22f7fedfc9eb1 fs: add ioctl to query metadata and protection info capabilities

This addresses these perf build warnings:

  Warning: Kernel ABI header differences:
    diff -u tools/perf/trace/beauty/include/uapi/linux/fs.h include/uapi/linux/fs.h

Please see tools/include/uapi/README for further details.

Cc: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 .../perf/trace/beauty/include/uapi/linux/fs.h | 88 +++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/tools/perf/trace/beauty/include/uapi/linux/fs.h b/tools/perf/trace/beauty/include/uapi/linux/fs.h
index 0098b0ce8ccb1f19..0bd678a4a10ef854 100644
--- a/tools/perf/trace/beauty/include/uapi/linux/fs.h
+++ b/tools/perf/trace/beauty/include/uapi/linux/fs.h
@@ -60,6 +60,17 @@
 #define RENAME_EXCHANGE		(1 << 1)	/* Exchange source and dest */
 #define RENAME_WHITEOUT		(1 << 2)	/* Whiteout source */
 
+/*
+ * The root inode of procfs is guaranteed to always have the same inode number.
+ * For programs that make heavy use of procfs, verifying that the root is a
+ * real procfs root and using openat2(RESOLVE_{NO_{XDEV,MAGICLINKS},BENEATH})
+ * will allow you to make sure you are never tricked into operating on the
+ * wrong procfs file.
+ */
+enum procfs_ino {
+	PROCFS_ROOT_INO = 1,
+};
+
 struct file_clone_range {
 	__s64 src_fd;
 	__u64 src_offset;
@@ -91,6 +102,63 @@ struct fs_sysfs_path {
 	__u8			name[128];
 };
 
+/* Protection info capability flags */
+#define	LBMD_PI_CAP_INTEGRITY		(1 << 0)
+#define	LBMD_PI_CAP_REFTAG		(1 << 1)
+
+/* Checksum types for Protection Information */
+#define LBMD_PI_CSUM_NONE		0
+#define LBMD_PI_CSUM_IP			1
+#define LBMD_PI_CSUM_CRC16_T10DIF	2
+#define LBMD_PI_CSUM_CRC64_NVME		4
+
+/* sizeof first published struct */
+#define LBMD_SIZE_VER0			16
+
+/*
+ * Logical block metadata capability descriptor
+ * If the device does not support metadata, all the fields will be zero.
+ * Applications must check lbmd_flags to determine whether metadata is
+ * supported or not.
+ */
+struct logical_block_metadata_cap {
+	/* Bitmask of logical block metadata capability flags */
+	__u32	lbmd_flags;
+	/*
+	 * The amount of data described by each unit of logical block
+	 * metadata
+	 */
+	__u16	lbmd_interval;
+	/*
+	 * Size in bytes of the logical block metadata associated with each
+	 * interval
+	 */
+	__u8	lbmd_size;
+	/*
+	 * Size in bytes of the opaque block tag associated with each
+	 * interval
+	 */
+	__u8	lbmd_opaque_size;
+	/*
+	 * Offset in bytes of the opaque block tag within the logical block
+	 * metadata
+	 */
+	__u8	lbmd_opaque_offset;
+	/* Size in bytes of the T10 PI tuple associated with each interval */
+	__u8	lbmd_pi_size;
+	/* Offset in bytes of T10 PI tuple within the logical block metadata */
+	__u8	lbmd_pi_offset;
+	/* T10 PI guard tag type */
+	__u8	lbmd_guard_tag_type;
+	/* Size in bytes of the T10 PI application tag */
+	__u8	lbmd_app_tag_size;
+	/* Size in bytes of the T10 PI reference tag */
+	__u8	lbmd_ref_tag_size;
+	/* Size in bytes of the T10 PI storage tag */
+	__u8	lbmd_storage_tag_size;
+	__u8	pad;
+};
+
 /* extent-same (dedupe) ioctls; these MUST match the btrfs ioctl definitions */
 #define FILE_DEDUPE_RANGE_SAME		0
 #define FILE_DEDUPE_RANGE_DIFFERS	1
@@ -148,6 +216,24 @@ struct fsxattr {
 	unsigned char	fsx_pad[8];
 };
 
+/*
+ * Variable size structure for file_[sg]et_attr().
+ *
+ * Note. This is alternative to the structure 'struct file_kattr'/'struct fsxattr'.
+ * As this structure is passed to/from userspace with its size, this can
+ * be versioned based on the size.
+ */
+struct file_attr {
+	__u64 fa_xflags;	/* xflags field value (get/set) */
+	__u32 fa_extsize;	/* extsize field value (get/set)*/
+	__u32 fa_nextents;	/* nextents field value (get)   */
+	__u32 fa_projid;	/* project identifier (get/set) */
+	__u32 fa_cowextsize;	/* CoW extsize field value (get/set) */
+};
+
+#define FILE_ATTR_SIZE_VER0 24
+#define FILE_ATTR_SIZE_LATEST FILE_ATTR_SIZE_VER0
+
 /*
  * Flags for the fsx_xflags field
  */
@@ -247,6 +333,8 @@ struct fsxattr {
  * also /sys/kernel/debug/ for filesystems with debugfs exports
  */
 #define FS_IOC_GETFSSYSFSPATH		_IOR(0x15, 1, struct fs_sysfs_path)
+/* Get logical block metadata capability details */
+#define FS_IOC_GETLBMD_CAP		_IOWR(0x15, 2, struct logical_block_metadata_cap)
 
 /*
  * Inode flags (FS_IOC_GETFLAGS / FS_IOC_SETFLAGS)
-- 
2.51.0.261.g7ce5a0a67e-goog


