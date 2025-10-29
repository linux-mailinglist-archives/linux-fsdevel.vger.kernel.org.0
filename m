Return-Path: <linux-fsdevel+bounces-66091-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F51C17C33
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22CEB400F3E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21A52D8365;
	Wed, 29 Oct 2025 01:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y6otWS8D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087C716EB42;
	Wed, 29 Oct 2025 01:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761700091; cv=none; b=Vx6GwfKVBwzafBqFKlpubhbkLfTVevguR8NTFefn2Q3Y/UNxa+HdPyvhnB/JHHk6Z1GwEpUlzDxDRPKR7VzliMvZYBU5GWhjXNYs+9vIHKkasedSxItxudOlX5gwWCoZssJL44crRFCfJEYNIZwUByDtkw6IGAU9fa1TkL4X2Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761700091; c=relaxed/simple;
	bh=XjoMnYHkqQ36akbHFVIn5GZa32QxWvBvYWNqq/aPB14=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rTyHtta6OAbCWzlGd69mKU/4H9LX/jMX2P9/VucfwPe7T7MTWleCy1s2qcIbKUw2d9/aYX9jGAmWqFk2DCuXZW4RS2R9zsxBgEQA9Jb7qOyiDjfkbmVtNDoxPu7hMzVaFIBZ7YULxX7PXYn6rW2IVz3HxC54YdxsePgKyslYqNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y6otWS8D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 769C1C4CEE7;
	Wed, 29 Oct 2025 01:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761700090;
	bh=XjoMnYHkqQ36akbHFVIn5GZa32QxWvBvYWNqq/aPB14=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Y6otWS8Dr2/7bgohTUIvMCi+qJvLlf+GIQVFSlDDeMnUXa7COn4OE//PtQZ44IgV8
	 XEs6o/3thFquHZwB1mgLt8s3kXSM8DHBy6K+snEzPOD0iYavm9q8ZSoH7QzH/FvdiZ
	 ad+7qLCTgHqHaIklo8hC519rJk8wMKwdCJYm9Mcz4Q9GUR49Zw431Uq0+r51ve6/kq
	 EuJWeh4pb+6u78MuhjNOHfb25bhE8WUPvB038R/LJzw51WRPQwuJqMZ3EdntxKT34c
	 euQrRZT6RsBSET5VtFLwME3j9AAWKS5ZabnMH/amHkbcseDb6Qi5B3gZznq8k0ReGv
	 He03zrqZVBxmA==
Date: Tue, 28 Oct 2025 18:08:10 -0700
Subject: [PATCH 4/5] libfuse: enable setting iomap block device block size
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, miklos@szeredi.hu, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <176169814922.1428772.8400025430143585718.stgit@frogsfrogsfrogs>
In-Reply-To: <176169814833.1428772.4461258885999504499.stgit@frogsfrogsfrogs>
References: <176169814833.1428772.4461258885999504499.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Create a means for an unprivileged fuse server to set the block size of
a block device that it previously opened and associated with the fuse
connection.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse_kernel.h   |    7 +++++++
 include/fuse_lowlevel.h |   12 ++++++++++++
 lib/fuse_lowlevel.c     |   11 +++++++++++
 lib/fuse_versionscript  |    1 +
 4 files changed, 31 insertions(+)


diff --git a/include/fuse_kernel.h b/include/fuse_kernel.h
index 0638d774d36cbc..adf23f4214223b 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -1172,6 +1172,11 @@ struct fuse_iomap_support {
 	uint64_t	padding;
 };
 
+struct fuse_iomap_backing_info {
+	uint32_t	backing_id;
+	uint32_t	blocksize;
+};
+
 /* Device ioctls: */
 #define FUSE_DEV_IOC_MAGIC		229
 #define FUSE_DEV_IOC_CLONE		_IOR(FUSE_DEV_IOC_MAGIC, 0, uint32_t)
@@ -1181,6 +1186,8 @@ struct fuse_iomap_support {
 #define FUSE_DEV_IOC_ADD_IOMAP		_IO(FUSE_DEV_IOC_MAGIC, 99)
 #define FUSE_DEV_IOC_IOMAP_SUPPORT	_IOR(FUSE_DEV_IOC_MAGIC, 99, \
 					     struct fuse_iomap_support)
+#define FUSE_DEV_IOC_IOMAP_SET_BLOCKSIZE _IOW(FUSE_DEV_IOC_MAGIC, 99, \
+					      struct fuse_iomap_backing_info)
 
 struct fuse_lseek_in {
 	uint64_t	fh;
diff --git a/include/fuse_lowlevel.h b/include/fuse_lowlevel.h
index a93f3e27f6ef6d..63477ec4eeff33 100644
--- a/include/fuse_lowlevel.h
+++ b/include/fuse_lowlevel.h
@@ -2729,6 +2729,18 @@ uint64_t fuse_lowlevel_discover_iomap(int fd);
  */
 int fuse_lowlevel_add_iomap(int fd);
 
+/**
+ * Set the block size of an open block device that has been opened for use with
+ * iomap.
+ *
+ * @param fd open file descriptor to a fuse device
+ * @param dev_index device index returned by fuse_lowlevel_iomap_device_add
+ * @param blocksize block size in bytes
+ * @return 0 on success, -1 on failure with errno set
+ */
+int fuse_lowlevel_iomap_set_blocksize(int fd, int dev_index,
+				      unsigned int blocksize);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index 51c609761494af..60d2b28bbef683 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -4995,3 +4995,14 @@ int fuse_lowlevel_add_iomap(int fd)
 {
 	return ioctl(fd, FUSE_DEV_IOC_ADD_IOMAP);
 }
+
+int fuse_lowlevel_iomap_set_blocksize(int fd, int dev_index,
+				      unsigned int blocksize)
+{
+	struct fuse_iomap_backing_info fbi = {
+		.backing_id = dev_index,
+		.blocksize = blocksize,
+	};
+
+	return ioctl(fd, FUSE_DEV_IOC_IOMAP_SET_BLOCKSIZE, &fbi);
+}
diff --git a/lib/fuse_versionscript b/lib/fuse_versionscript
index 2adab40e0eab1f..d34b68903faa33 100644
--- a/lib/fuse_versionscript
+++ b/lib/fuse_versionscript
@@ -256,6 +256,7 @@ FUSE_3.99 {
 		fuse_service_request_file;
 		fuse_service_send_goodbye;
 		fuse_service_take_fusedev;
+		fuse_lowlevel_iomap_set_blocksize;
 } FUSE_3.18;
 
 # Local Variables:


