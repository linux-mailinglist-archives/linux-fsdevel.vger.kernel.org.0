Return-Path: <linux-fsdevel+bounces-15490-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D99588F493
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 02:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8113F1C2C35C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 01:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F422263A;
	Thu, 28 Mar 2024 01:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b="TUJmaZj3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A071317C8B;
	Thu, 28 Mar 2024 01:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.19.144.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711589406; cv=none; b=msMHTU3E6FdFmq7o2ipK/jjfqqvvqFyih9ZtpxWLbIewBKTDF3uocLa5Bb58tCMImLTOtD53D8Qcr4R/IcxBYN0UpkbPNK5fbYQPzx4FFHW3XmKsYZusYVpZafFWJWqYTr2XAI/RGstfY6F433zusDrB8dz0EtU6ja2jMvaErW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711589406; c=relaxed/simple;
	bh=vj5UV26cPJ/Oq+xEzrXuvmzcSKdklz00ocQzvpFP7/8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hjiMeFnDJgKY6pUXjEmLn7W+oofKH4XRlLnA/FDhPfT5ZDTuiiZpyzBxP/Iex/xwhbYE1EEiV0ztSIMa2GpgB101wtgczx/wF8S7VlhsecLlM5F6VLPckw0xcg3FvBq1X2DHnTho8Lm4wrn9KIzVfJD6kKXEA8SglXk1z0eZAhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me; spf=pass smtp.mailfrom=dorminy.me; dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b=TUJmaZj3; arc=none smtp.client-ip=71.19.144.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dorminy.me
Received: from authenticated-user (box.fidei.email [71.19.144.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by box.fidei.email (Postfix) with ESMTPSA id DE358827B2;
	Wed, 27 Mar 2024 21:29:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
	t=1711589397; bh=vj5UV26cPJ/Oq+xEzrXuvmzcSKdklz00ocQzvpFP7/8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=TUJmaZj3ghwnDCt1CrSMWUHYE6REK0JdLDo4KeMw+3/LPabSHQKrHzJLnqdVMJtDg
	 0dhmooN0j8CI/M1HMDJwsFKpR0FwUOAhsPvsSvEYB8LvJXrmT+MNC5Pq3NcZiA3Oew
	 CQsW1rt5DaZDjp24UXGIf8g1yXQkNpL5YfPlQEHYK9K6BW1t8nsmbbQCCdjFd2gbG5
	 dLKATDFF8cD1V2eFHPM1H4msI1r4M2ghasYJKIL00j+IYeRd+zzhPiwgaPO/aQDwnc
	 kD8w7KiJyCNIbX6wbRrj0KkRmpiBciZk9dokInAKzK3X3ZPjsi+aZK9qoE5iqsU2sa
	 4l8GY2yUGkg9g==
From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To: Jonathan Corbet <corbet@lwn.net>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
	linux-doc@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 1/5] fs: fiemap: add physical_length field to extents
Date: Wed, 27 Mar 2024 21:22:19 -0400
Message-ID: <947581e8b4d196651a8cadfcbf55b48d6734d633.1711588701.git.sweettea-kernel@dorminy.me>
In-Reply-To: <cover.1711588701.git.sweettea-kernel@dorminy.me>
References: <cover.1711588701.git.sweettea-kernel@dorminy.me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some filesystems support compressed extents which have a larger logical
size than physical, and for those filesystems, it can be useful for
userspace to know how much space those extents actually use. For
instance, the compsize [1] tool for btrfs currently uses btrfs-internal,
root-only ioctl to find the actual disk space used by a file; it would
be better and more useful for this information to require fewer
privileges and to be usable on more filesystems. Therefore, use one of
the padding u64s in the fiemap extent structure to return the actual
physical length; and, for now, return this as equal to the logical
length.

[1] https://github.com/kilobyte/compsize

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 Documentation/filesystems/fiemap.rst | 28 +++++++++++++++++-------
 fs/ioctl.c                           |  3 ++-
 include/uapi/linux/fiemap.h          | 32 ++++++++++++++++++++++------
 3 files changed, 47 insertions(+), 16 deletions(-)

diff --git a/Documentation/filesystems/fiemap.rst b/Documentation/filesystems/fiemap.rst
index 93fc96f760aa..c2bfa107c8d7 100644
--- a/Documentation/filesystems/fiemap.rst
+++ b/Documentation/filesystems/fiemap.rst
@@ -80,14 +80,24 @@ Each extent is described by a single fiemap_extent structure as
 returned in fm_extents::
 
     struct fiemap_extent {
-	    __u64	fe_logical;  /* logical offset in bytes for the start of
-				* the extent */
-	    __u64	fe_physical; /* physical offset in bytes for the start
-				* of the extent */
-	    __u64	fe_length;   /* length in bytes for the extent */
-	    __u64	fe_reserved64[2];
-	    __u32	fe_flags;    /* FIEMAP_EXTENT_* flags for this extent */
-	    __u32	fe_reserved[3];
+            /*
+             * logical offset in bytes for the start of
+             * the extent from the beginning of the file
+             */
+            __u64 fe_logical;
+            /*
+             * physical offset in bytes for the start
+             * of the extent from the beginning of the disk
+             */
+            __u64 fe_physical;
+            /* logical length in bytes for this extent */
+            __u64 fe_logical_length;
+            /* physical length in bytes for this extent */
+            __u64 fe_physical_length;
+            __u64 fe_reserved64[1];
+            /* FIEMAP_EXTENT_* flags for this extent */
+            __u32 fe_flags;
+            __u32 fe_reserved[3];
     };
 
 All offsets and lengths are in bytes and mirror those on disk.  It is valid
@@ -175,6 +185,8 @@ FIEMAP_EXTENT_MERGED
   userspace would be highly inefficient, the kernel will try to merge most
   adjacent blocks into 'extents'.
 
+FIEMAP_EXTENT_HAS_PHYS_LEN
+  This will be set if the file system populated the physical length field.
 
 VFS -> File System Implementation
 ---------------------------------
diff --git a/fs/ioctl.c b/fs/ioctl.c
index 1d5abfdf0f22..850ad46fd923 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -138,7 +138,8 @@ int fiemap_fill_next_extent(struct fiemap_extent_info *fieinfo, u64 logical,
 	memset(&extent, 0, sizeof(extent));
 	extent.fe_logical = logical;
 	extent.fe_physical = phys;
-	extent.fe_length = len;
+	extent.fe_logical_length = len;
+	extent.fe_physical_length = len;
 	extent.fe_flags = flags;
 
 	dest += fieinfo->fi_extents_mapped;
diff --git a/include/uapi/linux/fiemap.h b/include/uapi/linux/fiemap.h
index 24ca0c00cae3..3079159b8e94 100644
--- a/include/uapi/linux/fiemap.h
+++ b/include/uapi/linux/fiemap.h
@@ -14,14 +14,30 @@
 
 #include <linux/types.h>
 
+/*
+ * For backward compatibility, where the member of the struct was called
+ * fe_length instead of fe_logical_length.
+ */
+#define fe_length fe_logical_length
+
 struct fiemap_extent {
-	__u64 fe_logical;  /* logical offset in bytes for the start of
-			    * the extent from the beginning of the file */
-	__u64 fe_physical; /* physical offset in bytes for the start
-			    * of the extent from the beginning of the disk */
-	__u64 fe_length;   /* length in bytes for this extent */
-	__u64 fe_reserved64[2];
-	__u32 fe_flags;    /* FIEMAP_EXTENT_* flags for this extent */
+	/*
+	 * logical offset in bytes for the start of
+	 * the extent from the beginning of the file
+	 */
+	__u64 fe_logical;
+	/*
+	 * physical offset in bytes for the start
+	 * of the extent from the beginning of the disk
+	 */
+	__u64 fe_physical;
+	/* logical length in bytes for this extent */
+	__u64 fe_logical_length;
+	/* physical length in bytes for this extent */
+	__u64 fe_physical_length;
+	__u64 fe_reserved64[1];
+	/* FIEMAP_EXTENT_* flags for this extent */
+	__u32 fe_flags;
 	__u32 fe_reserved[3];
 };
 
@@ -66,5 +82,7 @@ struct fiemap {
 						    * merged for efficiency. */
 #define FIEMAP_EXTENT_SHARED		0x00002000 /* Space shared with other
 						    * files. */
+#define FIEMAP_EXTENT_HAS_PHYS_LEN	0x00004000 /* Physical length is valid
+						    * and set by FS. */
 
 #endif /* _UAPI_LINUX_FIEMAP_H */
-- 
2.43.0


