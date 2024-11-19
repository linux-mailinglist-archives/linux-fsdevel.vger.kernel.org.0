Return-Path: <linux-fsdevel+bounces-35240-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA959D2E66
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 19:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EE41284694
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 18:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E771D0DE6;
	Tue, 19 Nov 2024 18:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iBEMmx5G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB66815443F;
	Tue, 19 Nov 2024 18:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732042513; cv=none; b=arGa+XlDv/WLEnqMJfl2RkqS5jnnqJrlrjLhWKqTJlXbfkt3WPReyrBWT4sKGz9yvOkEWslrahnViKxZDzwrQfHDhknjA+R16ITX8t7kL27XRn8FwaNofHdTBL4aBGAtCKrMiTj/Bl9rOBRRb71xlWlh/HuyEygr4FyzMkNvtmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732042513; c=relaxed/simple;
	bh=C0TI5qIwPPZ3r0n9JcSi4WhcKabDZiTlFOuRDQFeCus=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zq7w2y6TCNljn6J64vk3G1uNPiukxG/TIL1d4Jmtq63gpwiADkAfiGB57+jk3u9BSTMdgmGjpGsgvLC2oKzfL72U/vmaObFTTAu9v0v6L3fKcLS4Neph1kbVpy0IHRAGNITB0cmZUHUnAHrFd1hA6vq+f5DL99qSKjWJdiWFVf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iBEMmx5G; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=GUp7C3parh6nolGIWaYmyQs9aj9pP/Kt+abY468TUtk=; b=iBEMmx5G/ZrEurEj8fypJ5k9x3
	KrAqiYYmYHY5O8M4DrcilxoyX4FrawVJdsz0lO0KzoIK9xfoUKiQP67C+o8p5f3LwLBDyxm2yFMCD
	wEZc9DhZECNDAHzT8N6WjgKNzqTJGmHdHgdASF37VKxxboFNYfjDOjK/2RZ3oeKc9A6Z5HrT8SiZY
	dt4YkF2SPfBzCNQZwYUlgJ71VguD8qUCwYQ3uYtBIwjBswmh9cjnB5/y0lc5cyDbpoeswMuAjdqru
	EyqrFZrWZdI4CEnx5KGK6bOqbaobAz2Yuq/J3ytUnUg/mWqyZAhAWDP6KBvWMp4YqsiT115n9R/C9
	hPC5jl2w==;
Received: from [50.53.2.24] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tDTNV-0000000DS9C-3THK;
	Tue, 19 Nov 2024 18:55:09 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: patches@lists.linux.dev,
	Randy Dunlap <rdunlap@infradead.org>,
	Christoph Hellwig <hch@lst.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Subject: [PATCH] fiemap: use kernel-doc includes in fiemap docbook
Date: Tue, 19 Nov 2024 10:55:07 -0800
Message-ID: <20241119185507.102454-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add some kernel-doc notation to structs in fiemap header files
then pull that into Documentation/filesystems/fiemap.rst
instead of duplicating the header file structs in fiemap.rst.
This helps to future-proof fiemap.rst against struct changes.

Add missing flags documentation from header files into fiemap.rst
for FIEMAP_FLAG_CACHE and FIEMAP_EXTENT_SHARED.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
Cc: linux-fsdevel@vger.kernel.org

 Documentation/filesystems/fiemap.rst |   45 ++++++----------------
 include/linux/fiemap.h               |   16 +++++--
 include/uapi/linux/fiemap.h          |   51 ++++++++++++++++++-------
 3 files changed, 61 insertions(+), 51 deletions(-)

--- linux-next-20241118.orig/include/uapi/linux/fiemap.h
+++ linux-next-20241118/include/uapi/linux/fiemap.h
@@ -14,37 +14,60 @@
 
 #include <linux/types.h>
 
+/**
+ * struct fiemap_extent - description of one fiemap extent
+ * @fe_logical: logical offset in bytes for the start of the extent
+ *	from the beginning of the file
+ * @fe_physical: physical offset in bytes for the start of the extent
+ *	from the beginning of the disk
+ * @fe_length: length in bytes for this extent
+ * @fe_flags: FIEMAP_EXTENT_* flags for this extent
+ */
 struct fiemap_extent {
-	__u64 fe_logical;  /* logical offset in bytes for the start of
-			    * the extent from the beginning of the file */
-	__u64 fe_physical; /* physical offset in bytes for the start
-			    * of the extent from the beginning of the disk */
-	__u64 fe_length;   /* length in bytes for this extent */
+	__u64 fe_logical;
+	__u64 fe_physical;
+	__u64 fe_length;
+	/* private: */
 	__u64 fe_reserved64[2];
-	__u32 fe_flags;    /* FIEMAP_EXTENT_* flags for this extent */
+	/* public: */
+	__u32 fe_flags;
+	/* private: */
 	__u32 fe_reserved[3];
 };
 
+/**
+ * struct fiemap - file extent mappings
+ * @fm_start: logical offset (inclusive) at
+ *	which to start mapping (in)
+ * @fm_length: logical length of mapping which
+ *	userspace wants (in)
+ * @fm_flags: FIEMAP_FLAG_* flags for request (in/out)
+ * @fm_mapped_extents: number of extents that were mapped (out)
+ * @fm_extent_count: size of fm_extents array (in)
+ * @fm_extents: array of mapped extents (out)
+ */
 struct fiemap {
-	__u64 fm_start;		/* logical offset (inclusive) at
-				 * which to start mapping (in) */
-	__u64 fm_length;	/* logical length of mapping which
-				 * userspace wants (in) */
-	__u32 fm_flags;		/* FIEMAP_FLAG_* flags for request (in/out) */
-	__u32 fm_mapped_extents;/* number of extents that were mapped (out) */
-	__u32 fm_extent_count;  /* size of fm_extents array (in) */
+	__u64 fm_start;
+	__u64 fm_length;
+	__u32 fm_flags;
+	__u32 fm_mapped_extents;
+	__u32 fm_extent_count;
+	/* private: */
 	__u32 fm_reserved;
-	struct fiemap_extent fm_extents[]; /* array of mapped extents (out) */
+	/* public: */
+	struct fiemap_extent fm_extents[];
 };
 
 #define FIEMAP_MAX_OFFSET	(~0ULL)
 
+/* flags used in fm_flags: */
 #define FIEMAP_FLAG_SYNC	0x00000001 /* sync file data before map */
 #define FIEMAP_FLAG_XATTR	0x00000002 /* map extended attribute tree */
 #define FIEMAP_FLAG_CACHE	0x00000004 /* request caching of the extents */
 
 #define FIEMAP_FLAGS_COMPAT	(FIEMAP_FLAG_SYNC | FIEMAP_FLAG_XATTR)
 
+/* flags used in fe_flags: */
 #define FIEMAP_EXTENT_LAST		0x00000001 /* Last extent in file. */
 #define FIEMAP_EXTENT_UNKNOWN		0x00000002 /* Data location unknown. */
 #define FIEMAP_EXTENT_DELALLOC		0x00000004 /* Location still pending.
--- linux-next-20241118.orig/Documentation/filesystems/fiemap.rst
+++ linux-next-20241118/Documentation/filesystems/fiemap.rst
@@ -12,21 +12,10 @@ returns a list of extents.
 Request Basics
 --------------
 
-A fiemap request is encoded within struct fiemap::
-
-  struct fiemap {
-	__u64	fm_start;	 /* logical offset (inclusive) at
-				  * which to start mapping (in) */
-	__u64	fm_length;	 /* logical length of mapping which
-				  * userspace cares about (in) */
-	__u32	fm_flags;	 /* FIEMAP_FLAG_* flags for request (in/out) */
-	__u32	fm_mapped_extents; /* number of extents that were
-				    * mapped (out) */
-	__u32	fm_extent_count; /* size of fm_extents array (in) */
-	__u32	fm_reserved;
-	struct fiemap_extent fm_extents[0]; /* array of mapped extents (out) */
-  };
+A fiemap request is encoded within struct fiemap:
 
+.. kernel-doc:: include/uapi/linux/fiemap.h
+   :identifiers: fiemap
 
 fm_start, and fm_length specify the logical range within the file
 which the process would like mappings for. Extents returned mirror
@@ -60,6 +49,8 @@ FIEMAP_FLAG_XATTR
   If this flag is set, the extents returned will describe the inodes
   extended attribute lookup tree, instead of its data tree.
 
+FIEMAP_FLAG_CACHE
+  This flag requests caching of the extents.
 
 Extent Mapping
 --------------
@@ -77,18 +68,10 @@ complete the requested range and will no
 flag set (see the next section on extent flags).
 
 Each extent is described by a single fiemap_extent structure as
-returned in fm_extents::
+returned in fm_extents:
 
-    struct fiemap_extent {
-	    __u64	fe_logical;  /* logical offset in bytes for the start of
-				* the extent */
-	    __u64	fe_physical; /* physical offset in bytes for the start
-				* of the extent */
-	    __u64	fe_length;   /* length in bytes for the extent */
-	    __u64	fe_reserved64[2];
-	    __u32	fe_flags;    /* FIEMAP_EXTENT_* flags for this extent */
-	    __u32	fe_reserved[3];
-    };
+.. kernel-doc:: include/uapi/linux/fiemap.h
+    :identifiers: fiemap_extent
 
 All offsets and lengths are in bytes and mirror those on disk.  It is valid
 for an extents logical offset to start before the request or its logical
@@ -175,6 +158,8 @@ FIEMAP_EXTENT_MERGED
   userspace would be highly inefficient, the kernel will try to merge most
   adjacent blocks into 'extents'.
 
+FIEMAP_EXTENT_SHARED
+  This flag is set to request that space be shared with other files.
 
 VFS -> File System Implementation
 ---------------------------------
@@ -191,14 +176,10 @@ each discovered extent::
                      u64 len);
 
 ->fiemap is passed struct fiemap_extent_info which describes the
-fiemap request::
+fiemap request:
 
-  struct fiemap_extent_info {
-	unsigned int fi_flags;		/* Flags as passed from user */
-	unsigned int fi_extents_mapped;	/* Number of mapped extents */
-	unsigned int fi_extents_max;	/* Size of fiemap_extent array */
-	struct fiemap_extent *fi_extents_start;	/* Start of fiemap_extent array */
-  };
+.. kernel-doc:: include/linux/fiemap.h
+    :identifiers: fiemap_extent_info
 
 It is intended that the file system should not need to access any of this
 structure directly. Filesystem handlers should be tolerant to signals and return
--- linux-next-20241118.orig/include/linux/fiemap.h
+++ linux-next-20241118/include/linux/fiemap.h
@@ -5,12 +5,18 @@
 #include <uapi/linux/fiemap.h>
 #include <linux/fs.h>
 
+/**
+ * struct fiemap_extent_info - fiemap request to a filesystem
+ * @fi_flags:		Flags as passed from user
+ * @fi_extents_mapped:	Number of mapped extents
+ * @fi_extents_max:	Size of fiemap_extent array
+ * @fi_extents_start:	Start of fiemap_extent array
+ */
 struct fiemap_extent_info {
-	unsigned int fi_flags;		/* Flags as passed from user */
-	unsigned int fi_extents_mapped;	/* Number of mapped extents */
-	unsigned int fi_extents_max;	/* Size of fiemap_extent array */
-	struct fiemap_extent __user *fi_extents_start; /* Start of
-							fiemap_extent array */
+	unsigned int fi_flags;
+	unsigned int fi_extents_mapped;
+	unsigned int fi_extents_max;
+	struct fiemap_extent __user *fi_extents_start;
 };
 
 int fiemap_prep(struct inode *inode, struct fiemap_extent_info *fieinfo,

