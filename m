Return-Path: <linux-fsdevel+bounces-61508-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 809E5B58956
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C144521F43
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FB51AF0B6;
	Tue, 16 Sep 2025 00:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="avAfkFHi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3768C1A9F82;
	Tue, 16 Sep 2025 00:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757982496; cv=none; b=Vyl2YjuhmoQq2oo9SZUd8boQC99iNh/GMQ55y/VpEBJZhmfBLmo7P1to3UqRSZCywt7sL/zVy/kN5kCeIK2S9OhkRRZs0XRJFicG/h5zp1NvF2VjhKNHTZAYkD2LNx/Tv9bQufRuQkTduUSTBX2qGzb0dQcs7DbADQEchjguZE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757982496; c=relaxed/simple;
	bh=An+rAhXIpmBgocNvmNmL+ufAbURpWq1EagwX3UFplCY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kWd3ToAQ8LbzcETgmm1v3ufEXq6nRiH2RDQa+oHL8S87biepEB+wwgZYcxJiWAQCmkykozVIzzWaVa3fce+8oC8IgySxwZbzhnLiZ2o1IVSNM5ehLdnzIIelF73pZiMGdqESPCZta06pvPRNxwroNQgvdchayXGoCCZirW9M5jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=avAfkFHi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8C4BC4CEF1;
	Tue, 16 Sep 2025 00:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757982494;
	bh=An+rAhXIpmBgocNvmNmL+ufAbURpWq1EagwX3UFplCY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=avAfkFHi0EdiZ8kx3Sj2Dg5NyvrEVuIPNLOaqw5+F4eSsnQ6LP5sSaSkJ0Pgft6Ro
	 404PyzpaH/9twzq1qq6EfcwUV8t4cSo2xah4/Z1n6eMIWNrE/IrnDIRktQBZGgc9E5
	 p59N4G4A0IcBQLlafCqWBckXY9+5isev0op/MoQWFkm4hlNF24hLUEZcdiEZNa9zDb
	 Be8aKK6cycBU/7+6tJaIJveblEulRm4buStBVP0wj5C4ExmGlgn/eigio5uEbr2zaL
	 ZYS4pRdPmLLMZpFaczmN+cYyK3OzyeVhbWlPI3BdOh0kAokZBXMU3xwxYsf3rs1AHw
	 zp3Jhpt+6hl+g==
Date: Mon, 15 Sep 2025 17:28:14 -0700
Subject: [PATCH 01/28] fuse: implement the basic iomap mechanisms
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, linux-xfs@vger.kernel.org, John@groves.net,
 linux-fsdevel@vger.kernel.org, neal@gompa.dev, joannelkoong@gmail.com
Message-ID: <175798151288.382724.14189484118371001092.stgit@frogsfrogsfrogs>
In-Reply-To: <175798151087.382724.2707973706304359333.stgit@frogsfrogsfrogs>
References: <175798151087.382724.2707973706304359333.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Implement functions to enable upcalling of iomap_begin and iomap_end to
userspace fuse servers.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_i.h          |   35 ++++
 fs/fuse/iomap_priv.h      |   36 ++++
 include/uapi/linux/fuse.h |   90 +++++++++
 fs/fuse/Kconfig           |   32 +++
 fs/fuse/Makefile          |    1 
 fs/fuse/file_iomap.c      |  434 +++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/inode.c           |    9 +
 7 files changed, 636 insertions(+), 1 deletion(-)
 create mode 100644 fs/fuse/iomap_priv.h
 create mode 100644 fs/fuse/file_iomap.c


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 4560687d619d76..f0d408a6e12c32 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -923,6 +923,9 @@ struct fuse_conn {
 	/* Is synchronous FUSE_INIT allowed? */
 	unsigned int sync_init:1;
 
+	/* Enable fs/iomap for file operations */
+	unsigned int iomap:1;
+
 	/* Use io_uring for communication */
 	unsigned int io_uring;
 
@@ -1047,6 +1050,11 @@ static inline struct fuse_mount *get_fuse_mount_super(struct super_block *sb)
 	return sb->s_fs_info;
 }
 
+static inline const struct fuse_mount *get_fuse_mount_super_c(const struct super_block *sb)
+{
+	return sb->s_fs_info;
+}
+
 static inline struct fuse_conn *get_fuse_conn_super(struct super_block *sb)
 {
 	return get_fuse_mount_super(sb)->fc;
@@ -1057,16 +1065,31 @@ static inline struct fuse_mount *get_fuse_mount(struct inode *inode)
 	return get_fuse_mount_super(inode->i_sb);
 }
 
+static inline const struct fuse_mount *get_fuse_mount_c(const struct inode *inode)
+{
+	return get_fuse_mount_super_c(inode->i_sb);
+}
+
 static inline struct fuse_conn *get_fuse_conn(struct inode *inode)
 {
 	return get_fuse_mount_super(inode->i_sb)->fc;
 }
 
+static inline const struct fuse_conn *get_fuse_conn_c(const struct inode *inode)
+{
+	return get_fuse_mount_super_c(inode->i_sb)->fc;
+}
+
 static inline struct fuse_inode *get_fuse_inode(struct inode *inode)
 {
 	return container_of(inode, struct fuse_inode, inode);
 }
 
+static inline const struct fuse_inode *get_fuse_inode_c(const struct inode *inode)
+{
+	return container_of(inode, struct fuse_inode, inode);
+}
+
 static inline u64 get_node_id(struct inode *inode)
 {
 	return get_fuse_inode(inode)->nodeid;
@@ -1666,4 +1689,16 @@ extern void fuse_sysctl_unregister(void);
 #define fuse_sysctl_unregister()	do { } while (0)
 #endif /* CONFIG_SYSCTL */
 
+#if IS_ENABLED(CONFIG_FUSE_IOMAP)
+bool fuse_iomap_enabled(void);
+
+static inline bool fuse_has_iomap(const struct inode *inode)
+{
+	return get_fuse_conn_c(inode)->iomap;
+}
+#else
+# define fuse_iomap_enabled(...)		(false)
+# define fuse_has_iomap(...)			(false)
+#endif
+
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/iomap_priv.h b/fs/fuse/iomap_priv.h
new file mode 100644
index 00000000000000..243d92cb625095
--- /dev/null
+++ b/fs/fuse/iomap_priv.h
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 Oracle.  All Rights Reserved.
+ * Author: Darrick J. Wong <djwong@kernel.org>
+ */
+#ifndef _FS_FUSE_IOMAP_PRIV_H
+#define _FS_FUSE_IOMAP_PRIV_H
+
+#if IS_ENABLED(CONFIG_FUSE_IOMAP)
+#if IS_ENABLED(CONFIG_FUSE_IOMAP_DEBUG)
+# define ASSERT(condition) do {						\
+	int __cond = !!(condition);					\
+	WARN(!__cond, "Assertion failed: %s, func: %s, line: %d", #condition, __func__, __LINE__); \
+} while (0)
+# define BAD_DATA(condition) ({						\
+	int __cond = !!(condition);					\
+	WARN(__cond, "Bad mapping: %s, func: %s, line: %d", #condition, __func__, __LINE__); \
+})
+#else
+# define ASSERT(condition)
+# define BAD_DATA(condition) ({						\
+	int __cond = !!(condition);					\
+	unlikely(__cond);						\
+})
+#endif /* CONFIG_FUSE_IOMAP_DEBUG */
+
+enum fuse_iomap_iodir {
+	READ_MAPPING,
+	WRITE_MAPPING,
+};
+
+#define EFSCORRUPTED	EUCLEAN
+
+#endif /* CONFIG_FUSE_IOMAP */
+
+#endif /* _FS_FUSE_IOMAP_PRIV_H */
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 31b80f93211b81..3634cbe602cd9c 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -235,6 +235,9 @@
  *
  *  7.44
  *  - add FUSE_NOTIFY_INC_EPOCH
+ *
+ *  7.99
+ *  - add FUSE_IOMAP and iomap_{begin,end,ioend} for regular file operations
  */
 
 #ifndef _LINUX_FUSE_H
@@ -270,7 +273,7 @@
 #define FUSE_KERNEL_VERSION 7
 
 /** Minor version number of this interface */
-#define FUSE_KERNEL_MINOR_VERSION 44
+#define FUSE_KERNEL_MINOR_VERSION 99
 
 /** The node ID of the root inode */
 #define FUSE_ROOT_ID 1
@@ -443,6 +446,7 @@ struct fuse_file_lock {
  * FUSE_OVER_IO_URING: Indicate that client supports io-uring
  * FUSE_REQUEST_TIMEOUT: kernel supports timing out requests.
  *			 init_out.request_timeout contains the timeout (in secs)
+ * FUSE_IOMAP: Client supports iomap for regular file operations.
  */
 #define FUSE_ASYNC_READ		(1 << 0)
 #define FUSE_POSIX_LOCKS	(1 << 1)
@@ -490,6 +494,7 @@ struct fuse_file_lock {
 #define FUSE_ALLOW_IDMAP	(1ULL << 40)
 #define FUSE_OVER_IO_URING	(1ULL << 41)
 #define FUSE_REQUEST_TIMEOUT	(1ULL << 42)
+#define FUSE_IOMAP		(1ULL << 43)
 
 /**
  * CUSE INIT request/reply flags
@@ -658,6 +663,9 @@ enum fuse_opcode {
 	FUSE_TMPFILE		= 51,
 	FUSE_STATX		= 52,
 
+	FUSE_IOMAP_BEGIN	= 4094,
+	FUSE_IOMAP_END		= 4095,
+
 	/* CUSE specific operations */
 	CUSE_INIT		= 4096,
 
@@ -1297,4 +1305,84 @@ struct fuse_uring_cmd_req {
 	uint8_t padding[6];
 };
 
+/* mapping types; see corresponding IOMAP_TYPE_ */
+#define FUSE_IOMAP_TYPE_HOLE		(0)
+#define FUSE_IOMAP_TYPE_DELALLOC	(1)
+#define FUSE_IOMAP_TYPE_MAPPED		(2)
+#define FUSE_IOMAP_TYPE_UNWRITTEN	(3)
+#define FUSE_IOMAP_TYPE_INLINE		(4)
+
+/* fuse-specific mapping type indicating that writes use the read mapping */
+#define FUSE_IOMAP_TYPE_PURE_OVERWRITE	(255)
+
+#define FUSE_IOMAP_DEV_NULL		(0U)	/* null device cookie */
+
+/* mapping flags passed back from iomap_begin; see corresponding IOMAP_F_ */
+#define FUSE_IOMAP_F_NEW		(1U << 0)
+#define FUSE_IOMAP_F_DIRTY		(1U << 1)
+#define FUSE_IOMAP_F_SHARED		(1U << 2)
+#define FUSE_IOMAP_F_MERGED		(1U << 3)
+#define FUSE_IOMAP_F_BOUNDARY		(1U << 4)
+#define FUSE_IOMAP_F_ANON_WRITE		(1U << 5)
+#define FUSE_IOMAP_F_ATOMIC_BIO		(1U << 6)
+
+/* fuse-specific mapping flag asking for ->iomap_end call */
+#define FUSE_IOMAP_F_WANT_IOMAP_END	(1U << 7)
+
+/* mapping flags passed to iomap_end */
+#define FUSE_IOMAP_F_SIZE_CHANGED	(1U << 8)
+#define FUSE_IOMAP_F_STALE		(1U << 9)
+
+/* operation flags from iomap; see corresponding IOMAP_* */
+#define FUSE_IOMAP_OP_WRITE		(1U << 0)
+#define FUSE_IOMAP_OP_ZERO		(1U << 1)
+#define FUSE_IOMAP_OP_REPORT		(1U << 2)
+#define FUSE_IOMAP_OP_FAULT		(1U << 3)
+#define FUSE_IOMAP_OP_DIRECT		(1U << 4)
+#define FUSE_IOMAP_OP_NOWAIT		(1U << 5)
+#define FUSE_IOMAP_OP_OVERWRITE_ONLY	(1U << 6)
+#define FUSE_IOMAP_OP_UNSHARE		(1U << 7)
+#define FUSE_IOMAP_OP_DAX		(1U << 8)
+#define FUSE_IOMAP_OP_ATOMIC		(1U << 9)
+#define FUSE_IOMAP_OP_DONTCACHE		(1U << 10)
+
+#define FUSE_IOMAP_NULL_ADDR		(-1ULL)	/* addr is not valid */
+
+struct fuse_iomap_io {
+	uint64_t offset;	/* file offset of mapping, bytes */
+	uint64_t length;	/* length of mapping, bytes */
+	uint64_t addr;		/* disk offset of mapping, bytes */
+	uint16_t type;		/* FUSE_IOMAP_TYPE_* */
+	uint16_t flags;		/* FUSE_IOMAP_F_* */
+	uint32_t dev;		/* device cookie */
+};
+
+struct fuse_iomap_begin_in {
+	uint32_t opflags;	/* FUSE_IOMAP_OP_* */
+	uint32_t reserved;	/* zero */
+	uint64_t attr_ino;	/* matches fuse_attr:ino */
+	uint64_t pos;		/* file position, in bytes */
+	uint64_t count;		/* operation length, in bytes */
+};
+
+struct fuse_iomap_begin_out {
+	/* read file data from here */
+	struct fuse_iomap_io	read;
+
+	/* write file data to here, if applicable */
+	struct fuse_iomap_io	write;
+};
+
+struct fuse_iomap_end_in {
+	uint32_t opflags;	/* FUSE_IOMAP_OP_* */
+	uint32_t reserved;	/* zero */
+	uint64_t attr_ino;	/* matches fuse_attr:ino */
+	uint64_t pos;		/* file position, in bytes */
+	uint64_t count;		/* operation length, in bytes */
+	int64_t written;	/* bytes processed */
+
+	/* mapping that the kernel acted upon */
+	struct fuse_iomap_io	map;
+};
+
 #endif /* _LINUX_FUSE_H */
diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
index 9563fa5387a241..67dfe300bf2e07 100644
--- a/fs/fuse/Kconfig
+++ b/fs/fuse/Kconfig
@@ -69,6 +69,38 @@ config FUSE_PASSTHROUGH
 config FUSE_BACKING
 	bool
 
+config FUSE_IOMAP
+	bool "FUSE file IO over iomap"
+	default n
+	depends on FUSE_FS
+	depends on BLOCK
+	select FS_IOMAP
+	help
+	  Enable fuse servers to operate the regular file I/O path through
+	  the fs-iomap library in the kernel.  This enables higher performance
+	  userspace filesystems by keeping the performance critical parts in
+	  the kernel while delegating the difficult metadata parsing parts to
+	  an easily-contained userspace program.
+
+	  This feature is considered EXPERIMENTAL.  Use with caution!
+
+	  If unsure, say N.
+
+config FUSE_IOMAP_BY_DEFAULT
+	bool "FUSE file I/O over iomap by default"
+	default n
+	depends on FUSE_IOMAP
+	help
+	  Enable sending FUSE file I/O over iomap by default.
+
+config FUSE_IOMAP_DEBUG
+	bool "Debug FUSE file IO over iomap"
+	default n
+	depends on FUSE_IOMAP
+	help
+	  Enable debugging assertions for the fuse iomap code paths and logging
+	  of bad iomap file mapping data being sent to the kernel.
+
 config FUSE_IO_URING
 	bool "FUSE communication over io-uring"
 	default y
diff --git a/fs/fuse/Makefile b/fs/fuse/Makefile
index 46041228e5be2c..27be39317701d6 100644
--- a/fs/fuse/Makefile
+++ b/fs/fuse/Makefile
@@ -18,5 +18,6 @@ fuse-$(CONFIG_FUSE_PASSTHROUGH) += passthrough.o
 fuse-$(CONFIG_FUSE_BACKING) += backing.o
 fuse-$(CONFIG_SYSCTL) += sysctl.o
 fuse-$(CONFIG_FUSE_IO_URING) += dev_uring.o
+fuse-$(CONFIG_FUSE_IOMAP) += file_iomap.o
 
 virtiofs-y := virtio_fs.o
diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
new file mode 100644
index 00000000000000..dda757768d3ea6
--- /dev/null
+++ b/fs/fuse/file_iomap.c
@@ -0,0 +1,434 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 Oracle.  All Rights Reserved.
+ * Author: Darrick J. Wong <djwong@kernel.org>
+ */
+#include <linux/iomap.h>
+#include "fuse_i.h"
+#include "fuse_trace.h"
+#include "iomap_priv.h"
+
+static bool __read_mostly enable_iomap =
+#if IS_ENABLED(CONFIG_FUSE_IOMAP_BY_DEFAULT)
+	true;
+#else
+	false;
+#endif
+module_param(enable_iomap, bool, 0644);
+MODULE_PARM_DESC(enable_iomap, "Enable file I/O through iomap");
+
+bool fuse_iomap_enabled(void)
+{
+	/* Don't let anyone touch iomap until the end of the patchset. */
+	return false;
+
+	/*
+	 * There are fears that a fuse+iomap server could somehow DoS the
+	 * system by doing things like going out to lunch during a writeback
+	 * related iomap request.  Only allow iomap access if the fuse server
+	 * has rawio capabilities since those processes can mess things up
+	 * quite well even without our help.
+	 */
+	return enable_iomap && has_capability_noaudit(current, CAP_SYS_RAWIO);
+}
+
+/* Convert IOMAP_* mapping types to FUSE_IOMAP_TYPE_* */
+#define XMAP(word) \
+	case IOMAP_##word: \
+		return FUSE_IOMAP_TYPE_##word
+static inline uint16_t fuse_iomap_type_to_server(uint16_t iomap_type)
+{
+	switch (iomap_type) {
+	XMAP(HOLE);
+	XMAP(DELALLOC);
+	XMAP(MAPPED);
+	XMAP(UNWRITTEN);
+	XMAP(INLINE);
+	default:
+		ASSERT(0);
+	}
+	return 0;
+}
+#undef XMAP
+
+/* Convert FUSE_IOMAP_TYPE_* to IOMAP_* mapping types */
+#define XMAP(word) \
+	case FUSE_IOMAP_TYPE_##word: \
+		return IOMAP_##word
+static inline uint16_t fuse_iomap_type_from_server(uint16_t fuse_type)
+{
+	switch (fuse_type) {
+	XMAP(HOLE);
+	XMAP(DELALLOC);
+	XMAP(MAPPED);
+	XMAP(UNWRITTEN);
+	XMAP(INLINE);
+	default:
+		ASSERT(0);
+	}
+	return 0;
+}
+#undef XMAP
+
+/* Validate FUSE_IOMAP_TYPE_* */
+static inline bool fuse_iomap_check_type(uint16_t fuse_type)
+{
+	switch (fuse_type) {
+	case FUSE_IOMAP_TYPE_HOLE:
+	case FUSE_IOMAP_TYPE_DELALLOC:
+	case FUSE_IOMAP_TYPE_MAPPED:
+	case FUSE_IOMAP_TYPE_UNWRITTEN:
+	case FUSE_IOMAP_TYPE_INLINE:
+	case FUSE_IOMAP_TYPE_PURE_OVERWRITE:
+		return true;
+	}
+
+	return false;
+}
+
+#define FUSE_IOMAP_F_ALL (FUSE_IOMAP_F_NEW | \
+			  FUSE_IOMAP_F_DIRTY | \
+			  FUSE_IOMAP_F_SHARED | \
+			  FUSE_IOMAP_F_MERGED | \
+			  FUSE_IOMAP_F_BOUNDARY | \
+			  FUSE_IOMAP_F_ANON_WRITE | \
+			  FUSE_IOMAP_F_ATOMIC_BIO | \
+			  FUSE_IOMAP_F_WANT_IOMAP_END)
+
+static inline bool fuse_iomap_check_flags(uint16_t flags)
+{
+	return (flags & ~FUSE_IOMAP_F_ALL) == 0;
+}
+
+/* Convert IOMAP_F_* mapping state flags to FUSE_IOMAP_F_* */
+#define XMAP(word) \
+	if (iomap_f_flags & IOMAP_F_##word) \
+		ret |= FUSE_IOMAP_F_##word
+#define YMAP(iword, oword) \
+	if (iomap_f_flags & IOMAP_F_##iword) \
+		ret |= FUSE_IOMAP_F_##oword
+static inline uint16_t fuse_iomap_flags_to_server(uint16_t iomap_f_flags)
+{
+	uint16_t ret = 0;
+
+	XMAP(NEW);
+	XMAP(DIRTY);
+	XMAP(SHARED);
+	XMAP(MERGED);
+	XMAP(BOUNDARY);
+	XMAP(ANON_WRITE);
+	XMAP(ATOMIC_BIO);
+	YMAP(PRIVATE, WANT_IOMAP_END);
+
+	XMAP(SIZE_CHANGED);
+	XMAP(STALE);
+
+	return ret;
+}
+#undef YMAP
+#undef XMAP
+
+/* Convert FUSE_IOMAP_F_* to IOMAP_F_* mapping state flags */
+#define XMAP(word) \
+	if (fuse_f_flags & FUSE_IOMAP_F_##word) \
+		ret |= IOMAP_F_##word
+#define YMAP(iword, oword) \
+	if (fuse_f_flags & FUSE_IOMAP_F_##iword) \
+		ret |= IOMAP_F_##oword
+static inline uint16_t fuse_iomap_flags_from_server(uint16_t fuse_f_flags)
+{
+	uint16_t ret = 0;
+
+	XMAP(NEW);
+	XMAP(DIRTY);
+	XMAP(SHARED);
+	XMAP(MERGED);
+	XMAP(BOUNDARY);
+	XMAP(ANON_WRITE);
+	XMAP(ATOMIC_BIO);
+	YMAP(WANT_IOMAP_END, PRIVATE);
+
+	return ret;
+}
+#undef YMAP
+#undef XMAP
+
+/* Convert IOMAP_* operation flags to FUSE_IOMAP_OP_* */
+#define XMAP(word) \
+	if (iomap_op_flags & IOMAP_##word) \
+		ret |= FUSE_IOMAP_OP_##word
+static inline uint32_t fuse_iomap_op_to_server(unsigned iomap_op_flags)
+{
+	uint32_t ret = 0;
+
+	XMAP(WRITE);
+	XMAP(ZERO);
+	XMAP(REPORT);
+	XMAP(FAULT);
+	XMAP(DIRECT);
+	XMAP(NOWAIT);
+	XMAP(OVERWRITE_ONLY);
+	XMAP(UNSHARE);
+	XMAP(DAX);
+	XMAP(ATOMIC);
+	XMAP(DONTCACHE);
+
+	return ret;
+}
+#undef XMAP
+
+/* Validate an iomap mapping. */
+static inline bool fuse_iomap_check_mapping(const struct inode *inode,
+					    const struct fuse_iomap_io *map,
+					    enum fuse_iomap_iodir iodir)
+{
+	const unsigned int blocksize = i_blocksize(inode);
+	uint64_t end;
+
+	/* Type and flags must be known */
+	if (BAD_DATA(!fuse_iomap_check_type(map->type)))
+		return false;
+	if (BAD_DATA(!fuse_iomap_check_flags(map->flags)))
+		return false;
+
+	/* No zero-length mappings */
+	if (BAD_DATA(map->length == 0))
+		return false;
+
+	/* File range must be aligned to blocksize */
+	if (BAD_DATA(!IS_ALIGNED(map->offset, blocksize)))
+		return false;
+	if (BAD_DATA(!IS_ALIGNED(map->length, blocksize)))
+		return false;
+
+	/* No overflows in the file range */
+	if (BAD_DATA(check_add_overflow(map->offset, map->length, &end)))
+		return false;
+
+	/* File range cannot start past maxbytes */
+	if (BAD_DATA(map->offset >= inode->i_sb->s_maxbytes))
+		return false;
+
+	switch (map->type) {
+	case FUSE_IOMAP_TYPE_MAPPED:
+	case FUSE_IOMAP_TYPE_UNWRITTEN:
+		/* Mappings backed by space must have a device/addr */
+		if (BAD_DATA(map->dev == FUSE_IOMAP_DEV_NULL))
+			return false;
+		if (BAD_DATA(map->addr == FUSE_IOMAP_NULL_ADDR))
+			return false;
+		break;
+	case FUSE_IOMAP_TYPE_DELALLOC:
+	case FUSE_IOMAP_TYPE_HOLE:
+	case FUSE_IOMAP_TYPE_INLINE:
+		/* Mappings not backed by space cannot have a device addr. */
+		if (BAD_DATA(map->dev != FUSE_IOMAP_DEV_NULL))
+			return false;
+		if (BAD_DATA(map->addr != FUSE_IOMAP_NULL_ADDR))
+			return false;
+		break;
+	case FUSE_IOMAP_TYPE_PURE_OVERWRITE:
+		/* "Pure overwrite" only allowed for write mapping */
+		if (BAD_DATA(iodir != WRITE_MAPPING))
+			return false;
+		break;
+	default:
+		/* should have been caught already */
+		ASSERT(0);
+		return false;
+	}
+
+	/* XXX: we don't support devices yet */
+	if (BAD_DATA(map->dev != FUSE_IOMAP_DEV_NULL))
+		return false;
+
+	/* No overflows in the device range, if supplied */
+	if (map->addr != FUSE_IOMAP_NULL_ADDR &&
+	    BAD_DATA(check_add_overflow(map->addr, map->length, &end)))
+		return false;
+
+	return true;
+}
+
+/* Convert a mapping from the server into something the kernel can use */
+static inline void fuse_iomap_from_server(struct inode *inode,
+					  struct iomap *iomap,
+					  const struct fuse_iomap_io *fmap)
+{
+	iomap->addr = fmap->addr;
+	iomap->offset = fmap->offset;
+	iomap->length = fmap->length;
+	iomap->type = fuse_iomap_type_from_server(fmap->type);
+	iomap->flags = fuse_iomap_flags_from_server(fmap->flags);
+	iomap->bdev = inode->i_sb->s_bdev; /* XXX */
+}
+
+/* Convert a mapping from the kernel into something the server can use */
+static inline void fuse_iomap_to_server(struct fuse_iomap_io *fmap,
+					const struct iomap *iomap)
+{
+	fmap->addr = FUSE_IOMAP_NULL_ADDR; /* XXX */
+	fmap->offset = iomap->offset;
+	fmap->length = iomap->length;
+	fmap->type = fuse_iomap_type_to_server(iomap->type);
+	fmap->flags = fuse_iomap_flags_to_server(iomap->flags);
+	fmap->dev = FUSE_IOMAP_DEV_NULL; /* XXX */
+}
+
+/* Check the incoming _begin mappings to make sure they're not nonsense. */
+static inline int
+fuse_iomap_begin_validate(const struct inode *inode,
+			  unsigned opflags, loff_t pos,
+			  const struct fuse_iomap_begin_out *outarg)
+{
+	/* Make sure the mappings aren't garbage */
+	if (!fuse_iomap_check_mapping(inode, &outarg->read, READ_MAPPING))
+		return -EFSCORRUPTED;
+
+	if (!fuse_iomap_check_mapping(inode, &outarg->write, WRITE_MAPPING))
+		return -EFSCORRUPTED;
+
+	/*
+	 * Must have returned a mapping for at least the first byte in the
+	 * range.  The main mapping check already validated that the length
+	 * is nonzero and there is no overflow in computing end.
+	 */
+	if (BAD_DATA(outarg->read.offset > pos))
+		return -EFSCORRUPTED;
+	if (BAD_DATA(outarg->write.offset > pos))
+		return -EFSCORRUPTED;
+
+	if (BAD_DATA(outarg->read.offset + outarg->read.length <= pos))
+		return -EFSCORRUPTED;
+	if (BAD_DATA(outarg->write.offset + outarg->write.length <= pos))
+		return -EFSCORRUPTED;
+
+	return 0;
+}
+
+static inline bool fuse_is_iomap_file_write(unsigned int opflags)
+{
+	return opflags & (IOMAP_WRITE | IOMAP_ZERO | IOMAP_UNSHARE);
+}
+
+static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t count,
+			    unsigned opflags, struct iomap *iomap,
+			    struct iomap *srcmap)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct fuse_iomap_begin_in inarg = {
+		.attr_ino = fi->orig_ino,
+		.opflags = fuse_iomap_op_to_server(opflags),
+		.pos = pos,
+		.count = count,
+	};
+	struct fuse_iomap_begin_out outarg = { };
+	struct fuse_mount *fm = get_fuse_mount(inode);
+	FUSE_ARGS(args);
+	int err;
+
+	args.opcode = FUSE_IOMAP_BEGIN;
+	args.nodeid = get_node_id(inode);
+	args.in_numargs = 1;
+	args.in_args[0].size = sizeof(inarg);
+	args.in_args[0].value = &inarg;
+	args.out_numargs = 1;
+	args.out_args[0].size = sizeof(outarg);
+	args.out_args[0].value = &outarg;
+	err = fuse_simple_request(fm, &args);
+	if (err)
+		return err;
+
+	err = fuse_iomap_begin_validate(inode, opflags, pos, &outarg);
+	if (err)
+		return err;
+
+	if (fuse_is_iomap_file_write(opflags) &&
+	    outarg.write.type != FUSE_IOMAP_TYPE_PURE_OVERWRITE) {
+		/*
+		 * For an out of place write, we must supply the write mapping
+		 * via @iomap, and the read mapping via @srcmap.
+		 */
+		fuse_iomap_from_server(inode, iomap, &outarg.write);
+		fuse_iomap_from_server(inode, srcmap, &outarg.read);
+	} else {
+		/*
+		 * For everything else (reads, reporting, and pure overwrites),
+		 * we can return the sole mapping through @iomap and leave
+		 * @srcmap unchanged from its default (HOLE).
+		 */
+		fuse_iomap_from_server(inode, iomap, &outarg.read);
+	}
+
+	return 0;
+}
+
+/* Decide if we send FUSE_IOMAP_END to the fuse server */
+static bool fuse_should_send_iomap_end(const struct iomap *iomap,
+				       unsigned int opflags, loff_t count,
+				       ssize_t written)
+{
+	/* fuse server demanded an iomap_end call. */
+	if (iomap->flags & FUSE_IOMAP_F_WANT_IOMAP_END)
+		return true;
+
+	/* Reads and reporting should never affect the filesystem metadata */
+	if (!fuse_is_iomap_file_write(opflags))
+		return false;
+
+	/* Appending writes get an iomap_end call */
+	if (iomap->flags & IOMAP_F_SIZE_CHANGED)
+		return true;
+
+	/* Short writes get an iomap_end call to clean up delalloc */
+	return written < count;
+}
+
+static int fuse_iomap_end(struct inode *inode, loff_t pos, loff_t count,
+			  ssize_t written, unsigned opflags,
+			  struct iomap *iomap)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct fuse_mount *fm = get_fuse_mount(inode);
+	int err = 0;
+
+	if (fuse_should_send_iomap_end(iomap, opflags, count, written)) {
+		struct fuse_iomap_end_in inarg = {
+			.opflags = fuse_iomap_op_to_server(opflags),
+			.attr_ino = fi->orig_ino,
+			.pos = pos,
+			.count = count,
+			.written = written,
+		};
+		FUSE_ARGS(args);
+
+		fuse_iomap_to_server(&inarg.map, iomap);
+
+		args.opcode = FUSE_IOMAP_END;
+		args.nodeid = get_node_id(inode);
+		args.in_numargs = 1;
+		args.in_args[0].size = sizeof(inarg);
+		args.in_args[0].value = &inarg;
+		err = fuse_simple_request(fm, &args);
+		switch (err) {
+		case -ENOSYS:
+			/*
+			 * libfuse returns ENOSYS for servers that don't
+			 * implement iomap_end
+			 */
+			err = 0;
+			break;
+		case 0:
+			break;
+		default:
+			break;
+		}
+	}
+
+	return err;
+}
+
+const struct iomap_ops fuse_iomap_ops = {
+	.iomap_begin		= fuse_iomap_begin,
+	.iomap_end		= fuse_iomap_end,
+};
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 1e7298b2b89b58..32f4b7c9a20a8a 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1448,6 +1448,13 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 
 			if (flags & FUSE_REQUEST_TIMEOUT)
 				timeout = arg->request_timeout;
+
+			if ((flags & FUSE_IOMAP) && fuse_iomap_enabled()) {
+				fc->local_fs = 1;
+				fc->iomap = 1;
+				printk(KERN_WARNING
+ "fuse: EXPERIMENTAL iomap feature enabled.  Use at your own risk!");
+			}
 		} else {
 			ra_pages = fc->max_read / PAGE_SIZE;
 			fc->no_lock = 1;
@@ -1516,6 +1523,8 @@ static struct fuse_init_args *fuse_new_init(struct fuse_mount *fm)
 	 */
 	if (fuse_uring_enabled())
 		flags |= FUSE_OVER_IO_URING;
+	if (fuse_iomap_enabled())
+		flags |= FUSE_IOMAP;
 
 	ia->in.flags = flags;
 	ia->in.flags2 = flags >> 32;


