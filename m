Return-Path: <linux-fsdevel+bounces-15979-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9455896673
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 09:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCEFB1C23036
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 07:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466775EE80;
	Wed,  3 Apr 2024 07:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b="duAbvHkd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304405B68F;
	Wed,  3 Apr 2024 07:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.19.144.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712129587; cv=none; b=BnMd9NpwMx4sJWpOw5C9UHodNEKFKX3SK7cwmim+E8hcVYRlBv/IS9ItN33oDgfbGvuLKk79az1O3Gw+hQj7VXnOJIcRclfx3TREaAB4WoxMcjO0deoXYiDa/jz+ZL7Ls9TiN723SeuMcWwrvPp1D+Lzc+9b8Wmj+KUdCgaWRwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712129587; c=relaxed/simple;
	bh=8hdRucriYr7TDeIc1Z7lCtD9oMQ64x6lsX9+VmwRajs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hu4amzfH5J4b6+u0f00WKMpQlapFy+DDAvg4mCqnEdIahv3gxb3P83wZV8+XLFHVXgnupNulMynR2MTNKiVAITjz6X0AmgkB57TCf4hIOmXy3UARmhdZV2OWqRNiU7X0sL5Oz5hc80csBdAIsBpAS+2l4Hta4gLrdB5Iobpydb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me; spf=pass smtp.mailfrom=dorminy.me; dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b=duAbvHkd; arc=none smtp.client-ip=71.19.144.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dorminy.me
Received: from authenticated-user (box.fidei.email [71.19.144.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by box.fidei.email (Postfix) with ESMTPSA id 47146807A5;
	Wed,  3 Apr 2024 03:33:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
	t=1712129585; bh=8hdRucriYr7TDeIc1Z7lCtD9oMQ64x6lsX9+VmwRajs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=duAbvHkdgGafhhkA8hd0r625830aALZZQ8oxeANR/Kl8V2xZug5kmcP4vI1YapxFN
	 A9LIDRTvjeSQOhcIpRDoLRTbG3NMyvM/72K1ifkS/Z9WVfqJVjWSBQ7y9OWOKItEFi
	 P+IExaIGlJDtZ5Rx/+twB5qnULd5b1xw9JJmHoTUZK1CNmor9ry/3WJ5MlliuOXzge
	 eoaW6DepcInBi/zwZ/15PRH144T5KOWel/2PH8M2LXhMM/YZG6q5hG/wxWX1eFQHXr
	 y0rEkGXPrjhNC8NJHfsw4ypdhHDVDROcDUUlNXmuBJ6WY9PkwLnPjt68hBA1lQ7Eyb
	 PKcWh0anOhPtA==
From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To: Jonathan Corbet <corbet@lwn.net>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Brian Foster <bfoster@redhat.com>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-bcachefs@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v3 01/13] fs: fiemap: add physical_length field to extents
Date: Wed,  3 Apr 2024 03:22:42 -0400
Message-ID: <1ba5bfccccbf4ff792f178268badde056797d0c4.1712126039.git.sweettea-kernel@dorminy.me>
In-Reply-To: <cover.1712126039.git.sweettea-kernel@dorminy.me>
References: <cover.1712126039.git.sweettea-kernel@dorminy.me>
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
index 661b46125669..8afd32e1a27a 100644
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


