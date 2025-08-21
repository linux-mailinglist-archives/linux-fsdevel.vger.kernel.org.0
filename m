Return-Path: <linux-fsdevel+bounces-58489-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF63B2EA04
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 03:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB0E51BC00D3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443601F3B8A;
	Thu, 21 Aug 2025 01:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tjoaqvzp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A247B1C3C18
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 01:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755738301; cv=none; b=pw7CEuRBReCfYHLhuzgxVPnm+paYELKuelcDQxAGwrRAYePxVRHSIlUDv8FzvgwFc/vp2sgrDdYtiQcVChTunmzOljH1u+jKm/Zl9tCvaI6yUaKZYXiq1XKyjOfa4pnPEAxoaitXPWRnT/poOhcsj87QbT+w2LnAGtiOjgvWEYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755738301; c=relaxed/simple;
	bh=SIT8lI5+pV470nwrWHHwrR23+VT69o3+JERMmfd3ang=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H2X+6sfMpyBGLGl4dbLMDILREWwzO87wUpZyai0vB5T//QVXwCPlbSP5PFlkAgIPg4Cwahlc0JL1Zwe8g2BcOcEa3WadNR0HxjtrjR7N4lEmOM+McvMMSHNQabD4tr3+VsicYkl4x/I66M3Lubp1FrcWKEv+5ILOpF6ot/TNJ08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tjoaqvzp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E714C4CEE7;
	Thu, 21 Aug 2025 01:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755738301;
	bh=SIT8lI5+pV470nwrWHHwrR23+VT69o3+JERMmfd3ang=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=tjoaqvzpUqJZRM56NFhPXjKBiTgNouD+IWegPUrbf6uIKu5K6fWCoZomYcIZFniyz
	 2NnWMNXTiNCKgJhkoL8xugvU04kYO4jXa6UgvsBMnSZTn4FuTAItbHHE7TOdGm0zZT
	 KR7nuSwPG+wlkraG6g2mmx6zSw6rRp+2xlPUlsETBPtFcNyivcNzt26bBtx/03jYOK
	 pcM5FkHJELmC9bwJVA5ERklNIgUul9Zc/kPgA10OnTTn8P1z6yN+LKFbDQSW+YnHnD
	 +DCuu9GUoF4mK9EmUdPRHKHguy9dEYHIt4Ptljoni1CaXdKge2YKWSxnEsuq16WpNr
	 vAmLnY9HwsiGQ==
Date: Wed, 20 Aug 2025 18:05:00 -0700
Subject: [PATCH 14/21] libfuse: allow discovery of the kernel's iomap
 capabilities
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: John@groves.net, joannelkoong@gmail.com, bernd@bsbernd.com,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, neal@gompa.dev
Message-ID: <175573711546.19163.3246297741263919924.stgit@frogsfrogsfrogs>
In-Reply-To: <175573711192.19163.9486664721161324503.stgit@frogsfrogsfrogs>
References: <175573711192.19163.9486664721161324503.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Create a library function so that we can discover the kernel's iomap
capabilities ahead of time.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse_common.h   |    7 +++++++
 include/fuse_kernel.h   |    7 +++++++
 include/fuse_lowlevel.h |    5 +++++
 lib/fuse_lowlevel.c     |   15 +++++++++++++++
 lib/fuse_versionscript  |    1 +
 5 files changed, 35 insertions(+)


diff --git a/include/fuse_common.h b/include/fuse_common.h
index 6e8b2958373258..f9cc3702411680 100644
--- a/include/fuse_common.h
+++ b/include/fuse_common.h
@@ -542,6 +542,13 @@ struct fuse_loop_config_v1 {
 
 #define FUSE_IOCTL_MAX_IOV	256
 
+/**
+ * iomap discovery flags
+ *
+ * FUSE_IOMAP_SUPPORT_FILEIO: basic file I/O functionality through iomap
+ */
+#define FUSE_IOMAP_SUPPORT_FILEIO	(1ULL << 0)
+
 /**
  * Connection information, passed to the ->init() method
  *
diff --git a/include/fuse_kernel.h b/include/fuse_kernel.h
index eafad773a1fd5f..dbd2ce1fbbe6ed 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -1134,12 +1134,19 @@ struct fuse_backing_map {
 	uint64_t	padding;
 };
 
+struct fuse_iomap_support {
+	uint64_t	flags;
+	uint64_t	padding;
+};
+
 /* Device ioctls: */
 #define FUSE_DEV_IOC_MAGIC		229
 #define FUSE_DEV_IOC_CLONE		_IOR(FUSE_DEV_IOC_MAGIC, 0, uint32_t)
 #define FUSE_DEV_IOC_BACKING_OPEN	_IOW(FUSE_DEV_IOC_MAGIC, 1, \
 					     struct fuse_backing_map)
 #define FUSE_DEV_IOC_BACKING_CLOSE	_IOW(FUSE_DEV_IOC_MAGIC, 2, uint32_t)
+#define FUSE_DEV_IOC_IOMAP_SUPPORT	_IOR(FUSE_DEV_IOC_MAGIC, 3, \
+					     struct fuse_iomap_support)
 
 struct fuse_lseek_in {
 	uint64_t	fh;
diff --git a/include/fuse_lowlevel.h b/include/fuse_lowlevel.h
index e0642032127686..2931a57ec4079b 100644
--- a/include/fuse_lowlevel.h
+++ b/include/fuse_lowlevel.h
@@ -2556,6 +2556,11 @@ int fuse_session_receive_buf(struct fuse_session *se, struct fuse_buf *buf);
  */
 bool fuse_req_is_uring(fuse_req_t req);
 
+/**
+ * Discover the kernel's iomap capabilities.  Returns FUSE_CAP_IOMAP_* flags.
+ */
+uint64_t fuse_lowlevel_discover_iomap(void);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index 6a96c0f62d5884..ab10204c8042d9 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -4603,3 +4603,18 @@ int fuse_session_exited(struct fuse_session *se)
 
 	return exited ? 1 : 0;
 }
+
+uint64_t fuse_lowlevel_discover_iomap(void)
+{
+	struct fuse_iomap_support ios = { };
+	int fd;
+
+	fd = open("/dev/fuse", O_RDONLY | O_CLOEXEC);
+	if (fd < 0)
+		return 0;
+
+	ioctl(fd, FUSE_DEV_IOC_IOMAP_SUPPORT, &ios);
+	close(fd);
+
+	return ios.flags;
+}
diff --git a/lib/fuse_versionscript b/lib/fuse_versionscript
index aa16efdd8a9879..5275a17ba1ed51 100644
--- a/lib/fuse_versionscript
+++ b/lib/fuse_versionscript
@@ -231,6 +231,7 @@ FUSE_3.99 {
 		fuse_add_direntry_plus_iflags;
 		fuse_fs_can_enable_iomap;
 		fuse_fs_can_enable_iomapx;
+		fuse_lowlevel_discover_iomap;
 } FUSE_3.18;
 
 # Local Variables:


