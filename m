Return-Path: <linux-fsdevel+bounces-66082-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF2DC17BFF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F02DA1C833CE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4A12D8DDD;
	Wed, 29 Oct 2025 01:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EHe22hmH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6602D7D2F;
	Wed, 29 Oct 2025 01:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761699950; cv=none; b=Mk1wIdnP8bpZeG+8JRn496hV1DEcAQDFhj3bdqWmoLs5j9PLm/5rz0xqUubPx2PqOgEsUWYEacwRbTVwAnEkJhr67mZAYzQ0U49YV5Hjk+zC48zRaEukbXQLa6JOkHlGn/Y5D6oNBullzTZH/fadkzUgju9v1jRD48tWNMoeQII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761699950; c=relaxed/simple;
	bh=KnPW33uEVVBJJatHIwC617mAd1OFFENhGGqQbFR/YF4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aPjpeHg4obn6RucXWFUR59IWgy3i7Hothh1jVNYFGhES5S6wjwweQFUgmDS/4fD9esVjxlnMdmAtvwuhgA5vE3K6xDK9aRCEbFaW4TkyRQwzJ9QIRzMil7DMDv9Z7XSb+JD4J+UcmonVGJiXHgkqSBcZ2VbdzyVSLt1TAHeKPrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EHe22hmH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9C08C4CEE7;
	Wed, 29 Oct 2025 01:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761699950;
	bh=KnPW33uEVVBJJatHIwC617mAd1OFFENhGGqQbFR/YF4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=EHe22hmHJjvuESbAGFy4CEffAloh/h/z2QUOdRyGq5XHzStSa34NuuphU/JSr1s5H
	 w5Fetv2/bOgcDParTKj7xiH2JebzGbe56kmiaNsdfoqb8OXzKFudJ5TXPXpIzRNPYl
	 jMRSm74T6AhBsSR2ZOz9G1WD7tissBSS+zo9FTcVrDx/Rh1aEAeMN1dQc9sW1klhdu
	 8kkZIIPWcJBiKshlRQ7stBryJCLxun2vunONbydZJLKV23w7a7RXj+Z0nUYcci/RaP
	 ooIQXi9WXsFq9iCkxPcSOylvK+O0M/xG2VBzG7zV9aS5vPD/2cpkgbrTm9Jb7t/AJj
	 u7S9HZy6RDKYQ==
Date: Tue, 28 Oct 2025 18:05:49 -0700
Subject: [PATCH 2/4] libfuse: set sync, immutable,
 and append when loading files
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, miklos@szeredi.hu, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <176169814355.1428390.16043068248654100347.stgit@frogsfrogsfrogs>
In-Reply-To: <176169814307.1428390.11550104537543281678.stgit@frogsfrogsfrogs>
References: <176169814307.1428390.11550104537543281678.stgit@frogsfrogsfrogs>
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
index 83ab3f54f54a2e..5df95ba35ce341 100644
--- a/include/fuse_common.h
+++ b/include/fuse_common.h
@@ -1241,6 +1241,12 @@ static inline bool fuse_iomap_need_write_allocate(unsigned int opflags,
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
index 37e5eb8c65f206..6fd0397b758eae 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -246,6 +246,8 @@
  *  - add FUSE_IOMAP_CONFIG so the fuse server can configure more fs geometry
  *  - add FUSE_NOTIFY_IOMAP_DEV_INVAL to invalidate iomap bdev ranges
  *  - add FUSE_ATTR_ATOMIC for single-fsblock atomic write support
+ *  - add FUSE_ATTR_{SYNC,IMMUTABLE,APPEND} for VFS enforcement of file
+ *    attributes
  */
 
 #ifndef _LINUX_FUSE_H
@@ -588,11 +590,17 @@ struct fuse_file_lock {
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
index 728a6b635471c7..3ab4a532b4edbb 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -129,6 +129,12 @@ static void convert_stat(const struct stat *stbuf, struct fuse_attr *attr,
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


