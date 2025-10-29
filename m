Return-Path: <linux-fsdevel+bounces-66073-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0921FC17BB1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CC0684E61AE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280862D9782;
	Wed, 29 Oct 2025 01:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SIToIUtS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81ECA21A449;
	Wed, 29 Oct 2025 01:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761699809; cv=none; b=Bvymhd+NtDPdB8MbbiqV40OyQ5ZT5Qwkt41Hyrzv5DnVWl0fXZTD12KsT8gRC1idFXh55pxMxt0ouZk4E+uMxPA1PFEqgc9hFvIO8wBP0nWxm4CKE+79bPYVBz+6fyytN5fC+BCntkpZivWOwWWzKKyZX0di9O3WAiqrgnc/6cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761699809; c=relaxed/simple;
	bh=dn6zBjK5Tjh/SI14L5uw7zGWHrcaU2K3+FgqqpTD8OU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EWZAvcgm3C9Yn1KNhVkJBDakxOX3eod4d0UA+W+zvERUIBqQz83k/gngLylK+fJPsQHIEe+WhIdpdF0Md5TVflnOVs+zH9/LllGpgidPCb4mrQ9FZnALdYFu4iL6DNWWEwmo2jAWOl+HsnRAg2ZmO2d2/vUQPNkuWVlhLo3kBFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SIToIUtS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13E5CC4CEE7;
	Wed, 29 Oct 2025 01:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761699809;
	bh=dn6zBjK5Tjh/SI14L5uw7zGWHrcaU2K3+FgqqpTD8OU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=SIToIUtS+cbCbjb93e9RYFNw/ANM7fCWQ9KBVSZE9cdJgrxys6EfDLkn1AGJEYU6w
	 47USUj2NW3SHysM8+fN6HHiFO6LLzy4qaKRp5HFpUlo4+H/dSjVp0kytiTLKamN3hK
	 Bl6QzJMok2+JEJgdZ8vsZphpyMWak8sD4u0aeIN7acrh2F0osaQdeg2k8ER4NoVZAQ
	 qS+hiv+V+FLAXhYkzokMZhADiYVhcIVuqTa1P6dKyPowEJqHe90Ldi90MgJiNFrLPA
	 F4qpD2Y7mM8lJSrdusw2aXCdFfexDqclaGrnWfBuh5V/+T7VJFLELDcpqHktm9j71v
	 CWE2hWZmYCWxw==
Date: Tue, 28 Oct 2025 18:03:28 -0700
Subject: [PATCH 16/22] libfuse: add low level code to invalidate iomap block
 device ranges
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, miklos@szeredi.hu, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <176169813822.1427432.5342542917237250086.stgit@frogsfrogsfrogs>
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

Make it easier to invalidate the page cache for a block device that is
being used in conjunction with iomap.  This allows a fuse server to kill
all cached data for a block that is being freed, so that block reuse
doesn't result in file corruption.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse_kernel.h   |    9 +++++++++
 include/fuse_lowlevel.h |   15 +++++++++++++++
 lib/fuse_lowlevel.c     |   22 ++++++++++++++++++++++
 lib/fuse_versionscript  |    1 +
 4 files changed, 47 insertions(+)


diff --git a/include/fuse_kernel.h b/include/fuse_kernel.h
index 77123c3d0323f7..d1143e0c122b9c 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -244,6 +244,7 @@
  *  - add FUSE_IOMAP and iomap_{begin,end,ioend} for regular file operations
  *  - add FUSE_ATTR_IOMAP to enable iomap for specific inodes
  *  - add FUSE_IOMAP_CONFIG so the fuse server can configure more fs geometry
+ *  - add FUSE_NOTIFY_IOMAP_DEV_INVAL to invalidate iomap bdev ranges
  */
 
 #ifndef _LINUX_FUSE_H
@@ -694,6 +695,7 @@ enum fuse_notify_code {
 	FUSE_NOTIFY_DELETE = 6,
 	FUSE_NOTIFY_RESEND = 7,
 	FUSE_NOTIFY_INC_EPOCH = 8,
+	FUSE_NOTIFY_IOMAP_DEV_INVAL = 99,
 	FUSE_NOTIFY_CODE_MAX,
 };
 
@@ -1404,4 +1406,11 @@ struct fuse_iomap_config_out {
 	int64_t s_maxbytes;	/* max file size */
 };
 
+struct fuse_iomap_dev_inval {
+	uint32_t dev;		/* device cookie */
+	uint32_t reserved;	/* zero */
+
+	uint64_t offset;	/* range to invalidate pagecache, bytes */
+	uint64_t length;
+};
 #endif /* _LINUX_FUSE_H */
diff --git a/include/fuse_lowlevel.h b/include/fuse_lowlevel.h
index 20c0a1e38595e1..110f7f73edbb2a 100644
--- a/include/fuse_lowlevel.h
+++ b/include/fuse_lowlevel.h
@@ -2158,6 +2158,21 @@ int fuse_lowlevel_iomap_device_add(struct fuse_session *se, int fd,
  */
 int fuse_lowlevel_iomap_device_remove(struct fuse_session *se, int device_id);
 
+/*
+ * Invalidate the page cache of a block device opened for use with iomap.
+ *
+ * Added in FUSE protocol version 7.99. If the kernel does not support
+ * this (or a newer) version, the function will return -ENOSYS and do
+ * nothing.
+ *
+ * @param se the session object
+ * @param dev device cookie returned by fuse_lowlevel_iomap_add_device
+ * @param offset start of the range to invalidate, in bytes
+ * @return length length of the range to invalidate, in bytes
+ */
+int fuse_lowlevel_iomap_device_invalidate(struct fuse_session *se, int dev,
+					  off_t offset, off_t length);
+
 /* ----------------------------------------------------------- *
  * Utility functions					       *
  * ----------------------------------------------------------- */
diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index 3c3aa7aec9f494..db202b59a2f0e6 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -3548,6 +3548,28 @@ int fuse_lowlevel_notify_store(struct fuse_session *se, fuse_ino_t ino,
 	return res;
 }
 
+int fuse_lowlevel_iomap_device_invalidate(struct fuse_session *se, int dev,
+					  off_t offset, off_t length)
+{
+	struct fuse_iomap_dev_inval arg = {
+		.dev = dev,
+		.offset = offset,
+		.length = length,
+	};
+	struct iovec iov[2];
+
+	if (!se)
+		return -EINVAL;
+
+	if (!(se->conn.want_ext & FUSE_CAP_IOMAP))
+		return -ENOSYS;
+
+	iov[1].iov_base = &arg;
+	iov[1].iov_len = sizeof(arg);
+
+	return send_notify_iov(se, FUSE_NOTIFY_IOMAP_DEV_INVAL, iov, 2);
+}
+
 struct fuse_retrieve_req {
 	struct fuse_notify_req nreq;
 	void *cookie;
diff --git a/lib/fuse_versionscript b/lib/fuse_versionscript
index 6e57e943a60e2d..d268471ae5bd38 100644
--- a/lib/fuse_versionscript
+++ b/lib/fuse_versionscript
@@ -234,6 +234,7 @@ FUSE_3.99 {
 		fuse_fs_can_enable_iomapx;
 		fuse_lowlevel_discover_iomap;
 		fuse_reply_iomap_config;
+		fuse_lowlevel_iomap_device_invalidate;
 } FUSE_3.18;
 
 # Local Variables:


