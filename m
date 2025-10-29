Return-Path: <linux-fsdevel+bounces-66075-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8ABC17BB7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93AF53AFDFA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15372D780C;
	Wed, 29 Oct 2025 01:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pow96vJp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0971421A449;
	Wed, 29 Oct 2025 01:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761699841; cv=none; b=XtvBM/hkMS7jr0Mdky6whIvIaGKvJOf74vZMAiv3ZPV3CAXw9TxjTZpwfodeJ6LvqcOXF0Hj+p0lZ/p0+kgAfVgfshQ94xJ4mK5Zp0MvmHLHPHkvBlBD+p//DrJI6P7w0LY+jZWvMHcz5TvPzHnhH/okVLkNus4nt9d4NXS6i4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761699841; c=relaxed/simple;
	bh=yYNO2U77mgEHt6evTRuBoTYo+iD5r6zKJmsafIWfjzg=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lmPZ5U6z70DeJTSGGq5mbS2MlBWgCjF77BjdAhBwDyLfltRjnaR5t5VAQXDO7IMn61RthK0CIfoicMwsabalGwejlafz+OoFZwKP8Ylvk5mRTXO7ZYf+XXqQHs2l/DBq8Z//+DyiWG6uzEof5+gFMOh4bcxS1q0iX8WlyNDLakw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pow96vJp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74AD9C4CEE7;
	Wed, 29 Oct 2025 01:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761699840;
	bh=yYNO2U77mgEHt6evTRuBoTYo+iD5r6zKJmsafIWfjzg=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=pow96vJpPShTAn6r4aFEFhn8Sf+vyQwf9mFmQt6VOOH/zQI+tm5seeU93QVYPdoGP
	 pIQjiTk1aJTnJCXMpQrFT0M2+hk6ymsUZPOoF3jgcOreeIba5SsYM8Q8kSF+ohDdj6
	 wDgzDtWyzrmTai1K2tW0w3NJwKcpPBEF7/yMjAcEy8eGxG2ntZrsC6r3tPZGffNBZI
	 0jjrB9rptdOT8EemvRbe5jXvYL/ntoL23m2+GS/c25egzmgQee4/FDpTW0L2ghCiPC
	 Q9AvoAHnosH1Sz3X0ZikE9Z/ljqVlcEc8WHWd0GiC+v9rKNGUxQMIa0KneRUFJOuWV
	 cNJLb4mGmmAIA==
Date: Tue, 28 Oct 2025 18:03:59 -0700
Subject: [PATCH 18/22] libfuse: add atomic write support
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, miklos@szeredi.hu, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <176169813858.1427432.2448355121308876367.stgit@frogsfrogsfrogs>
In-Reply-To: <176169813437.1427432.15345189583850708968.stgit@frogsfrogsfrogs>
References: <176169813437.1427432.15345189583850708968.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Add the single flag that we need to turn on atomic write support in
fuse.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse_common.h |    4 ++++
 include/fuse_kernel.h |    3 +++
 lib/fuse_lowlevel.c   |    2 ++
 3 files changed, 9 insertions(+)


diff --git a/include/fuse_common.h b/include/fuse_common.h
index 59b79b44a36e8d..eb08320bc8863f 100644
--- a/include/fuse_common.h
+++ b/include/fuse_common.h
@@ -540,6 +540,8 @@ struct fuse_loop_config_v1 {
  * FUSE_IOMAP_SUPPORT_FILEIO: basic file I/O functionality through iomap
  */
 #define FUSE_IOMAP_SUPPORT_FILEIO	(1ULL << 0)
+/* untorn writes through iomap */
+#define FUSE_IOMAP_SUPPORT_ATOMIC	(1ULL << 1)
 
 /**
  * Connection information, passed to the ->init() method
@@ -1232,6 +1234,8 @@ static inline bool fuse_iomap_need_write_allocate(unsigned int opflags,
 #define FUSE_IFLAG_DAX			(1U << 0)
 /* use iomap for this inode */
 #define FUSE_IFLAG_IOMAP		(1U << 1)
+/* enable untorn writes */
+#define FUSE_IFLAG_ATOMIC		(1U << 2)
 
 /* Which fields are set in fuse_iomap_config_out? */
 #define FUSE_IOMAP_CONFIG_SID		(1 << 0ULL)
diff --git a/include/fuse_kernel.h b/include/fuse_kernel.h
index d1143e0c122b9c..5b9259714a628d 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -245,6 +245,7 @@
  *  - add FUSE_ATTR_IOMAP to enable iomap for specific inodes
  *  - add FUSE_IOMAP_CONFIG so the fuse server can configure more fs geometry
  *  - add FUSE_NOTIFY_IOMAP_DEV_INVAL to invalidate iomap bdev ranges
+ *  - add FUSE_ATTR_ATOMIC for single-fsblock atomic write support
  */
 
 #ifndef _LINUX_FUSE_H
@@ -586,10 +587,12 @@ struct fuse_file_lock {
  * FUSE_ATTR_SUBMOUNT: Object is a submount root
  * FUSE_ATTR_DAX: Enable DAX for this file in per inode DAX mode
  * FUSE_ATTR_IOMAP: Use iomap for this inode
+ * FUSE_ATTR_ATOMIC: Enable untorn writes
  */
 #define FUSE_ATTR_SUBMOUNT      (1 << 0)
 #define FUSE_ATTR_DAX		(1 << 1)
 #define FUSE_ATTR_IOMAP		(1 << 2)
+#define FUSE_ATTR_ATOMIC	(1 << 3)
 
 /**
  * Open flags
diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index db202b59a2f0e6..605848bb4cd55b 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -127,6 +127,8 @@ static void convert_stat(const struct stat *stbuf, struct fuse_attr *attr,
 		attr->flags |= FUSE_ATTR_DAX;
 	if (iflags & FUSE_IFLAG_IOMAP)
 		attr->flags |= FUSE_ATTR_IOMAP;
+	if (iflags & FUSE_IFLAG_ATOMIC)
+		attr->flags |= FUSE_ATTR_ATOMIC;
 }
 
 static void convert_attr(const struct fuse_setattr_in *attr, struct stat *stbuf)


