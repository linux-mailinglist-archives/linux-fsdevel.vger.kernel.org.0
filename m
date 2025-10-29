Return-Path: <linux-fsdevel+bounces-66070-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4E4C17BAE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A16CA1C62E5C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6060972634;
	Wed, 29 Oct 2025 01:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AUqJbxsK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF3E1FAC42;
	Wed, 29 Oct 2025 01:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761699762; cv=none; b=ZQWZCjKAuOVGj5h0JdeYgTL4UnvdzuSxoHU3bLFn4M09a0E/RJH2kErbLrekf+7wEQoN7Vd/CU96CbdYoCsi77fMTXCb1nO5bg8PUyG/sxtmcmm3NUkuRYb5DqNIIIlnpnH/7M9/dqt3Czy8JaDCijVivV0/m6XzJ4J/4zaISt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761699762; c=relaxed/simple;
	bh=zs9Rjpd+W12v8TJs511W2utCTGqctTNpDbDHIWzwobo=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GgsWjWA+l3Nz8jKpZdlAiqUqYszuvk4GstDKnHJ8GXCWyESXenddFsn6QgN4HEhdeAb6lexVze4YDu2nB/TVNXwvDuEONjc2sarbjuF09NQG2ella6nRPJq+IFbxMF6VFq1yh9A+I9nPM+oP0O2uRdetacof77T5DjVZ+cBcUUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AUqJbxsK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36135C4CEE7;
	Wed, 29 Oct 2025 01:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761699762;
	bh=zs9Rjpd+W12v8TJs511W2utCTGqctTNpDbDHIWzwobo=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=AUqJbxsK2EOU/1P/c9tfqeNpuqGS0O0YsGo7LhQseqJxhULPY6dtZOpJKzBL1U+QS
	 n0CpzMXe9uLNSKzz7Ox0Wku7Wrd5ud7ORifOy2bDafjfuxT5CypweSeS5zKe8NbDE6
	 iQV4IhYOBGcMIBCZ3PWqSbkChqDUK0pPKSUzFitd9itsXYAujzqDxNREvgoELgZgI1
	 AcsecQfzhBGGNcE0+X8sAZxoo7IjKDU/2UTcsVI1AEPLiybEIEV2AVboQn6xjp0Q8C
	 8TwGij0sdk+DCeUNzfiSt4qXTQQyjM+A6kRmbJWMP851R3I7ApK7V3qGQAd75Yr72i
	 YAPjoDsQieA5A==
Date: Tue, 28 Oct 2025 18:02:41 -0700
Subject: [PATCH 13/22] libfuse: allow discovery of the kernel's iomap
 capabilities
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, miklos@szeredi.hu, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <176169813768.1427432.13427682700847139457.stgit@frogsfrogsfrogs>
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

Create a library function so that we can discover the kernel's iomap
capabilities ahead of time.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse_common.h   |    7 +++++++
 include/fuse_kernel.h   |    7 +++++++
 include/fuse_lowlevel.h |   10 ++++++++++
 lib/fuse_lowlevel.c     |   19 +++++++++++++++++++
 lib/fuse_versionscript  |    1 +
 5 files changed, 44 insertions(+)


diff --git a/include/fuse_common.h b/include/fuse_common.h
index 191d9749960992..86ae8894d81dbb 100644
--- a/include/fuse_common.h
+++ b/include/fuse_common.h
@@ -534,6 +534,13 @@ struct fuse_loop_config_v1 {
 
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
index 38aa03dce17e53..3dc00cd4cb113f 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -1144,12 +1144,19 @@ struct fuse_backing_map {
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
+#define FUSE_DEV_IOC_IOMAP_SUPPORT	_IOR(FUSE_DEV_IOC_MAGIC, 99, \
+					     struct fuse_iomap_support)
 
 struct fuse_lseek_in {
 	uint64_t	fh;
diff --git a/include/fuse_lowlevel.h b/include/fuse_lowlevel.h
index e2d14f2e2bd911..5ce7b4aaa2ae94 100644
--- a/include/fuse_lowlevel.h
+++ b/include/fuse_lowlevel.h
@@ -2576,6 +2576,16 @@ bool fuse_req_is_uring(fuse_req_t req);
 int fuse_req_get_payload(fuse_req_t req, char **payload, size_t *payload_sz,
 			 void **mr);
 
+
+/**
+ * Discover the kernel's iomap capabilities.  Returns FUSE_CAP_IOMAP_* flags.
+ *
+ * @param fd open file descriptor to a fuse device, or -1 if you're running
+ *           in the same process that will call mount().
+ * @return FUSE_IOMAP_SUPPORT_* flags
+ */
+uint64_t fuse_lowlevel_discover_iomap(int fd);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index e0d18844098971..4e7bf40833b578 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -4709,3 +4709,22 @@ int fuse_session_exited(struct fuse_session *se)
 
 	return exited ? 1 : 0;
 }
+
+uint64_t fuse_lowlevel_discover_iomap(int fd)
+{
+	struct fuse_iomap_support ios = { };
+
+	if (fd >= 0) {
+		ioctl(fd, FUSE_DEV_IOC_IOMAP_SUPPORT, &ios);
+		return ios.flags;
+	}
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
index 25a3e04c6c5ec7..704e8c2908ec4b 100644
--- a/lib/fuse_versionscript
+++ b/lib/fuse_versionscript
@@ -232,6 +232,7 @@ FUSE_3.99 {
 		fuse_add_direntry_plus_iflags;
 		fuse_fs_can_enable_iomap;
 		fuse_fs_can_enable_iomapx;
+		fuse_lowlevel_discover_iomap;
 } FUSE_3.18;
 
 # Local Variables:


