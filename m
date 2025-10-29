Return-Path: <linux-fsdevel+bounces-66086-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA14AC17C24
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F20D11A23E1A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F2C2D8779;
	Wed, 29 Oct 2025 01:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T/qlEiwp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8922820DB;
	Wed, 29 Oct 2025 01:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761700012; cv=none; b=GIddJv9XJJOtOH2ct2SU+GsCytiRC//honoVR7Ukw3zsGstH3hPHnmqdGvNxM2yvoFdqIyHpJ5oyeGA4n5UR24oE4up1ZiCjIP1zURWCpG+OxMQSUMndvltDslx5kwk/7dYR5z2+Xpg4sgsFrLYFuMIyLocv7bOgOyhucXR77qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761700012; c=relaxed/simple;
	bh=2RBmReo8qBb6mrOcYGsISlegbY62v8zqg/QBTaYoC0c=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h8Z3eYavyk/IThC/G11+ZG1B8fuKZMB2lcpAdStBD8qEZXTPgRY77i9ZJb4b9wUk4do5fX4js3Ql5BLMcILOK73e3X1aM4D+UBGtRLBxvlVaWun7gyLH82/ygFOEhbo9nrIN50CaNghdJbeyq84xyIKzCvyEYuHtijk+HQb+VQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T/qlEiwp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A141C4CEE7;
	Wed, 29 Oct 2025 01:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761700012;
	bh=2RBmReo8qBb6mrOcYGsISlegbY62v8zqg/QBTaYoC0c=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=T/qlEiwpz8H0dHeMP0axgiORjb86fCwsdXrk2oGPkUKsOsdf/zCnH9p5fuKZ7nMiK
	 HUCYUaQ0pY+NGWaM/+owvRJpMEwerqARNI1VsMihO5+NJZuxrKlDhtatAnM4YnMZKd
	 TquoCI8tna9pXZ26O477nGw75hU3bILZrwbKbenxIb7w8qIk2ATI7mU4wlDHRWT1d+
	 WfOaqhwHCD3Qu3ckNzu67ZNNM+1ZBfTsUBxKRtXSDUJ7fPO6tlH6x3Zek0tUh15jhM
	 kay+twc5yN+kDHiJ3D4hVX5gKwVlVr1PpfcnSh80/57/H7u3qQwf4bwZ7U53KnQoGm
	 +CqgqJ9gmZbLA==
Date: Tue, 28 Oct 2025 18:06:52 -0700
Subject: [PATCH 2/3] libfuse: add upper-level iomap cache management
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, miklos@szeredi.hu, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <176169814616.1428599.2864088786806186737.stgit@frogsfrogsfrogs>
In-Reply-To: <176169814570.1428599.1070273812934230095.stgit@frogsfrogsfrogs>
References: <176169814570.1428599.1070273812934230095.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Make it so that upper-level fuse servers can use the iomap cache too.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse.h         |   31 +++++++++++++++++++++++++++++++
 lib/fuse.c             |   30 ++++++++++++++++++++++++++++++
 lib/fuse_versionscript |    2 ++
 3 files changed, 63 insertions(+)


diff --git a/include/fuse.h b/include/fuse.h
index 3d36b49e1b3f67..1f03f3c3115cc1 100644
--- a/include/fuse.h
+++ b/include/fuse.h
@@ -1470,6 +1470,37 @@ bool fuse_fs_can_enable_iomap(const struct stat *statbuf);
  */
 bool fuse_fs_can_enable_iomapx(const struct statx *statxbuf);
 
+/*
+ * Upsert some file mapping information into the kernel.  This is necessary
+ * for filesystems that require coordination of mapping state changes between
+ * buffered writes and writeback, and desirable for better performance
+ * elsewhere.
+ *
+ * @param nodeid the inode number
+ * @param attr_ino inode number as told by fuse_attr::ino
+ * @param read mapping information for file reads
+ * @param write mapping information for file writes
+ * @return zero for success, -errno for failure
+ */
+int fuse_fs_iomap_upsert(uint64_t nodeid, uint64_t attr_ino,
+			 const struct fuse_file_iomap *read,
+			 const struct fuse_file_iomap *write);
+
+/**
+ * Invalidate some file mapping information in the kernel.
+ *
+ * @param nodeid the inode number
+ * @param attr_ino inode number as told by fuse_attr::ino
+ * @param read_off start of the range of read mappings to invalidate
+ * @param read_len length of the range of read mappings to invalidate
+ * @param write_off start of the range of write mappings to invalidate
+ * @param write_len length of the range of write mappings to invalidate
+ * @return zero for success, -errno for failure
+ */
+int fuse_fs_iomap_inval(uint64_t nodeid, uint64_t attr_ino, loff_t read_off,
+			uint64_t read_len, loff_t write_off,
+			uint64_t write_len);
+
 int fuse_notify_poll(struct fuse_pollhandle *ph);
 
 /**
diff --git a/lib/fuse.c b/lib/fuse.c
index d54fc9ea2004bd..553bc0cb5bc818 100644
--- a/lib/fuse.c
+++ b/lib/fuse.c
@@ -3010,6 +3010,36 @@ static int fuse_fs_syncfs(struct fuse_fs *fs, const char *path)
 	return fs->op.syncfs(path);
 }
 
+int fuse_fs_iomap_upsert(uint64_t nodeid, uint64_t attr_ino,
+			 const struct fuse_file_iomap *read,
+			 const struct fuse_file_iomap *write)
+{
+	struct fuse_context *ctxt = fuse_get_context();
+	struct fuse_session *se = fuse_get_session(ctxt->fuse);
+
+	return fuse_lowlevel_notify_iomap_upsert(se, nodeid, attr_ino,
+						 read, write);
+}
+
+int fuse_fs_iomap_inval(uint64_t nodeid, uint64_t attr_ino, loff_t read_off,
+			uint64_t read_len, loff_t write_off,
+			uint64_t write_len)
+{
+	struct fuse_context *ctxt = fuse_get_context();
+	struct fuse_session *se = fuse_get_session(ctxt->fuse);
+	struct fuse_iomap_inval read = {
+		.offset = read_off,
+		.length = read_len,
+	};
+	struct fuse_iomap_inval write = {
+		.offset = write_off,
+		.length = write_len,
+	};
+
+	return fuse_lowlevel_notify_iomap_inval(se, nodeid, attr_ino, &read,
+						&write);
+}
+
 static void fuse_lib_setattr(fuse_req_t req, fuse_ino_t ino, struct stat *attr,
 			     int valid, struct fuse_file_info *fi)
 {
diff --git a/lib/fuse_versionscript b/lib/fuse_versionscript
index 696cb77a254ccb..3bf7c0aca8f657 100644
--- a/lib/fuse_versionscript
+++ b/lib/fuse_versionscript
@@ -239,6 +239,8 @@ FUSE_3.99 {
 		fuse_loopdev_setup;
 		fuse_lowlevel_notify_iomap_upsert;
 		fuse_lowlevel_notify_iomap_inval;
+		fuse_fs_iomap_upsert;
+		fuse_fs_iomap_inval;
 } FUSE_3.18;
 
 # Local Variables:


