Return-Path: <linux-fsdevel+bounces-61581-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 054ABB589FD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B136A3AD71B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87AD3D561;
	Tue, 16 Sep 2025 00:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EvldTYMP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5357A4400
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 00:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757983637; cv=none; b=m1UvvE4rGgfBt+deKGZOXrRgoCMxvDN1CsaPRIfYQ+hCt46Fy81zRracTa4tNrO8yyxX6WbivCKeUntKVa1boU8zqERRM1wMJWZMTLF3yc8SRu5UGPewSv6Ph1Bkj6h9aNB48C2eM/mPH5WLw5fxnHsZ6rRmsGPLeyyf3bNAArc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757983637; c=relaxed/simple;
	bh=iQZ2HVcbzkTETf81ZHgMaicVlUr+KJZMLkXVflneqiY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A4pAnvljSz9HhVHdQL6DVNj8tPrF0LsX45yVNY/UE7AFqXQL12KkUx5OOjrzgW4R3yIO4CVo2JjrXQfYJ6L5+kfLvS28XPjzEqBNKf1pseXy+QEMQqISvSehPgFDRQyy9gDmZxawdfCA4G9bJ8gCjXZvp7V/0R5cyo08/LzLabk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EvldTYMP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7B4FC4CEF1;
	Tue, 16 Sep 2025 00:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757983635;
	bh=iQZ2HVcbzkTETf81ZHgMaicVlUr+KJZMLkXVflneqiY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=EvldTYMPOUXO6pNmIPXeBXvLgBGxwb4a52I7637KThno2AjHLbu7dtdrCL/+eZe2G
	 GJeL6wcLeEOjFQkz6u08Zumo8gC5pFfh1uK/gRavNNk7mMEpxGGhBmLcJBkr57CGY0
	 +BdNEP0JQOino655J6tHlc6jXCPatOx0PVcHQT5PiQRF70PFidQWrIXFwNnv2wAUUe
	 LWOWeVVuSLwoWTaxZDJH4+Vv17LXA+O+31xD9JxLUDriP3hsLJkhhWPLhIuUstvZqR
	 0zzKWmbLqOBmxPseewRyOSQARMm9OdkpQZVJn4zLyR5TP7vdgt16U2XZiPJuLWTwIW
	 m0OwGaQYzpQlg==
Date: Mon, 15 Sep 2025 17:47:15 -0700
Subject: [PATCH 2/4] libfuse: set sync, immutable,
 and append when loading files
From: "Darrick J. Wong" <djwong@kernel.org>
To: bschubert@ddn.com, djwong@kernel.org
Cc: John@groves.net, neal@gompa.dev, bernd@bsbernd.com,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com
Message-ID: <175798155278.387738.2496408963127208492.stgit@frogsfrogsfrogs>
In-Reply-To: <175798155228.387738.1956568770138953630.stgit@frogsfrogsfrogs>
References: <175798155228.387738.1956568770138953630.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Add these three fuse_attr::flags bits so that servers can mark a file as
immutable or append-only and have the kernel advertise and enforce that.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse_common.h |    6 ++++++
 include/fuse_kernel.h |    8 ++++++++
 lib/fuse_lowlevel.c   |    6 ++++++
 3 files changed, 20 insertions(+)


diff --git a/include/fuse_common.h b/include/fuse_common.h
index eb08320bc8863f..9016721320eb5a 100644
--- a/include/fuse_common.h
+++ b/include/fuse_common.h
@@ -1236,6 +1236,12 @@ static inline bool fuse_iomap_need_write_allocate(unsigned int opflags,
 #define FUSE_IFLAG_IOMAP		(1U << 1)
 /* enable untorn writes */
 #define FUSE_IFLAG_ATOMIC		(1U << 2)
+/* file writes are synchronous */
+#define FUSE_IFLAG_SYNC			(1U << 3)
+/* file is immutable */
+#define FUSE_IFLAG_IMMUTABLE		(1U << 4)
+/* file is append only */
+#define FUSE_IFLAG_APPEND		(1U << 5)
 
 /* Which fields are set in fuse_iomap_config_out? */
 #define FUSE_IOMAP_CONFIG_SID		(1 << 0ULL)
diff --git a/include/fuse_kernel.h b/include/fuse_kernel.h
index ed41792f94cf4f..4721c4e36159e1 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -242,6 +242,8 @@
  *  - add FUSE_IOMAP_CONFIG so the fuse server can configure more fs geometry
  *  - add FUSE_NOTIFY_IOMAP_DEV_INVAL to invalidate iomap bdev ranges
  *  - add FUSE_ATTR_ATOMIC for single-fsblock atomic write support
+ *  - add FUSE_ATTR_{SYNC,IMMUTABLE,APPEND} for VFS enforcement of file
+ *    attributes
  */
 
 #ifndef _LINUX_FUSE_H
@@ -584,11 +586,17 @@ struct fuse_file_lock {
  * FUSE_ATTR_DAX: Enable DAX for this file in per inode DAX mode
  * FUSE_ATTR_IOMAP: Use iomap for this inode
  * FUSE_ATTR_ATOMIC: Enable untorn writes
+ * FUSE_ATTR_SYNC: File writes are always synchronous
+ * FUSE_ATTR_IMMUTABLE: File is immutable
+ * FUSE_ATTR_APPEND: File is append-only
  */
 #define FUSE_ATTR_SUBMOUNT      (1 << 0)
 #define FUSE_ATTR_DAX		(1 << 1)
 #define FUSE_ATTR_IOMAP		(1 << 2)
 #define FUSE_ATTR_ATOMIC	(1 << 3)
+#define FUSE_ATTR_SYNC		(1 << 4)
+#define FUSE_ATTR_IMMUTABLE	(1 << 5)
+#define FUSE_ATTR_APPEND	(1 << 6)
 
 /**
  * Open flags
diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index 6108b1862a7eb8..a6294c5c065cd2 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -128,6 +128,12 @@ static void convert_stat(const struct stat *stbuf, struct fuse_attr *attr,
 		attr->flags |= FUSE_ATTR_IOMAP;
 	if (iflags & FUSE_IFLAG_ATOMIC)
 		attr->flags |= FUSE_ATTR_ATOMIC;
+	if (iflags & FUSE_IFLAG_SYNC)
+		attr->flags |= FUSE_ATTR_SYNC;
+	if (iflags & FUSE_IFLAG_IMMUTABLE)
+		attr->flags |= FUSE_ATTR_IMMUTABLE;
+	if (iflags & FUSE_IFLAG_APPEND)
+		attr->flags |= FUSE_ATTR_APPEND;
 }
 
 static void convert_attr(const struct fuse_setattr_in *attr, struct stat *stbuf)


