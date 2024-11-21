Return-Path: <linux-fsdevel+bounces-35373-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1AF99D4535
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 02:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 468EDB22330
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 01:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21ED21EF01;
	Thu, 21 Nov 2024 01:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YnCnmsQr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168414C66;
	Thu, 21 Nov 2024 01:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732151641; cv=none; b=lJqEwZSSwRPUpfYjHRXb6GjuLE0X/QpKz20fJ2isOEzMjpOQs/OyU8hpuQjLszdHRTDuLJ8qLEEQBV0WqyRWxXCxS+aQb5WTjQwSJW1YGsRLBwggo/t5W54EzdRH9/M3XF2dGTy5Jekl8RKBV/5tiQtoKbNOi/34OHtpg9gfvbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732151641; c=relaxed/simple;
	bh=l4FDzqr+e6/1dGF1MfQAFNMR+lWKMS7bW/hnMtn1YZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lfi5/3XbDru2bfN1QIZt/LZrDyB7Ub6OXqjDokkCNDFKosUZ5Ah+YSfC3NcNQhVpMSI6ciO3p/i1uUrzEiE7AefaA2G/69ijQErIYciy1rTHgZCNI3+NomKjENbbNLdXN+FBOucjJL2MVgDuQA1pYpplxqg56+3YwC41kZidHMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YnCnmsQr; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=2Fl5ltEnbJlMG+sVSMC7bWYoVQrbhsNI48omXw8gVVA=; b=YnCnmsQrlp2TLhDkLcuOJoQLPZ
	x8+6Ugg+jb53HWy34bttBIiAbGDFY+goQ4d37uk5W5mSWNM3nkJuyKj1W0shpzQdvsWzBCQBusn+c
	ItQaCGS4NF5dRC8xky8XI5jkF3I6+cUuCNLEJD6QQTN93UoOEmMRwuS5jx2uQ9yBR6vh+tR30Jurd
	8wrpooC6HJAqhlUPxguybmKZwDwOJr/jhprjayNd8Ou//je0BHx+9WI0CpYQqjHnQ3z98vUJo1azg
	PdJgY7Uv6GdLNXVDdEnzgOzF8pfIQfUiI5930XIqVVhM9iZ4HlC+oDRRUZg+pxGlIODVQ8C9P3i8g
	D9Tp9dLw==;
Received: from [50.53.2.24] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tDvlb-0000000GWPT-1Zye;
	Thu, 21 Nov 2024 01:13:55 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Christoph Hellwig <hch@lst.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2] fiemap: use kernel-doc includes in fiemap docbook
Date: Wed, 20 Nov 2024 17:13:52 -0800
Message-ID: <20241121011352.201907-1-rdunlap@infradead.org>
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
Cc: Matthew Wilcox <willy@infradead.org>
---
v2: Use Willy's parameter description changes.
    Change some 2-line parameter comments to one line.

    I have not converted the flag constants from macros to enums
    even though that would help with future-proofing the documentation.
    If Christoph says that he would like to see that, I can work on it.

Cc: linux-fsdevel@vger.kernel.org

 Documentation/filesystems/fiemap.rst |   45 ++++++-----------------
 include/linux/fiemap.h               |   16 +++++---
 include/uapi/linux/fiemap.h          |   47 +++++++++++++++++--------
 3 files changed, 57 insertions(+), 51 deletions(-)

--- linux-next-20241120.orig/include/uapi/linux/fiemap.h
+++ linux-next-20241120/include/uapi/linux/fiemap.h
@@ -14,37 +14,56 @@
 
 #include <linux/types.h>
 
+/**
+ * struct fiemap_extent - description of one fiemap extent
+ * @fe_logical: byte offset of the extent in the file
+ * @fe_physical: byte offset of extent on disk
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
+ * @fm_start: byte offset (inclusive) at which to start mapping (in)
+ * @fm_length: logical length of mapping which userspace wants (in)
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
--- linux-next-20241120.orig/Documentation/filesystems/fiemap.rst
+++ linux-next-20241120/Documentation/filesystems/fiemap.rst
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
--- linux-next-20241120.orig/include/linux/fiemap.h
+++ linux-next-20241120/include/linux/fiemap.h
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

