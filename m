Return-Path: <linux-fsdevel+bounces-49621-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FA9AC00FF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 02:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AC1E16CE92
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 00:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA2233F7;
	Thu, 22 May 2025 00:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KGlni+AK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FFA2F32
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 May 2025 00:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747872383; cv=none; b=IM4bZ+cWR/FBoLhRWnY2GCVvYo8HTWmzw5q70EyMV8Z0RMvo7G1j0WdsmxBR1c6uF18hg7VbGGs2yr4YBKAaJE54Z3P7SwgaW8X0tRDgytFjuWKgaiqqFL06txhHI6vCXP+Mv+GbDdlrZGxoYtzOndSIqh6b2vIUCkEOw3JsA5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747872383; c=relaxed/simple;
	bh=ncXtSkFQYmNQSXhgqNnfZ8xOV8OGJ5BtaeN26cFw4vY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cvgTn83EmoEsvgvvRAJz6HAY69bdYSF6TqE67KHw0AJ86q2gvZb+t3RGEgbzZS072JeTYL9Sa3vylhWQ45dpQU0GeYMJ1QVyo73YM7HuLcmYDZquBbvJ1UPuXJsdIctkX2BPgpfathoJQyd70GJs/gcawY0frPePS76ZrzgLscc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KGlni+AK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D6FFC4CEE4;
	Thu, 22 May 2025 00:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747872382;
	bh=ncXtSkFQYmNQSXhgqNnfZ8xOV8OGJ5BtaeN26cFw4vY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=KGlni+AKdzfrEzPSLtR6xbBYz9rZGo970nCbjI3coiSpKFy0PFQhQoAApyjuPOS9R
	 FM0KgqNZ+dKzkiCWYw1UehI/a5Smx9qMvcw+NEE94mFWU+W14a4qlH2LP+WSu7MdtU
	 A563iO1n8SQECZv1T8xFYrJLYsFBiVItK9IdbStk3Awh1ym6gJzVVEJVpDEEGsRUgg
	 MSBSrEoLQMphRsOgMoSyxSBysBpFfwxe4015bFNAaE66RWWssGPKsbmt4tAZ2AgdzO
	 VtO5FbPB5zFJeDg2JlCWCJgtbXPbxdMAGO6stiG1FWaTbHgEgYF7KdmgwvbSCDSVWF
	 tOMiD3S8qYTLQ==
Date: Wed, 21 May 2025 17:06:22 -0700
Subject: [PATCH 4/8] libfuse: add a notification to add a new device to iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: bschubert@ddn.com, djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, bernd@bsbernd.com, John@groves.net,
 joannelkoong@gmail.com, miklos@szeredi.hu
Message-ID: <174787196430.1483718.10459156173280037489.stgit@frogsfrogsfrogs>
In-Reply-To: <174787196326.1483718.13513023339006584229.stgit@frogsfrogsfrogs>
References: <174787196326.1483718.13513023339006584229.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Plumb in the pieces needed to attach block devices to a fuse+iomap mount
for use with iomap operations.  This enables us to have filesystems
where the metadata could live somewhere else, but the actual file IO
goes to locally attached storage.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse_kernel.h   |    8 ++++++++
 include/fuse_lowlevel.h |   16 ++++++++++++++++
 lib/fuse_lowlevel.c     |   21 +++++++++++++++++++++
 lib/fuse_versionscript  |    1 +
 4 files changed, 46 insertions(+)


diff --git a/include/fuse_kernel.h b/include/fuse_kernel.h
index 1b3f6046128bde..94efb90279579c 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -233,6 +233,7 @@
  *  7.44
  *  - add FUSE_IOMAP and iomap_{begin,end,ioend} handlers for FIEMAP and
  *    SEEK_{DATA,HOLE} support
+ *  - add FUSE_NOTIFY_ADD_IOMAP_DEVICE for multi-device filesystems
  */
 
 #ifndef _LINUX_FUSE_H
@@ -676,6 +677,7 @@ enum fuse_notify_code {
 	FUSE_NOTIFY_RETRIEVE = 5,
 	FUSE_NOTIFY_DELETE = 6,
 	FUSE_NOTIFY_RESEND = 7,
+	FUSE_NOTIFY_ADD_IOMAP_DEVICE = 8,
 	FUSE_NOTIFY_CODE_MAX,
 };
 
@@ -1328,4 +1330,10 @@ struct fuse_iomap_end_in {
 	uint32_t map_dev;	/* device cookie */
 };
 
+struct fuse_iomap_add_device_out {
+	int32_t fd;		/* fd of the open device to add */
+	uint32_t reserved;	/* must be zero */
+	uint32_t *map_dev;	/* location to receive device cookie */
+};
+
 #endif /* _LINUX_FUSE_H */
diff --git a/include/fuse_lowlevel.h b/include/fuse_lowlevel.h
index 4950aae4f82e0d..c9975f1862a074 100644
--- a/include/fuse_lowlevel.h
+++ b/include/fuse_lowlevel.h
@@ -1948,6 +1948,22 @@ int fuse_lowlevel_notify_store(struct fuse_session *se, fuse_ino_t ino,
 int fuse_lowlevel_notify_retrieve(struct fuse_session *se, fuse_ino_t ino,
 				  size_t size, off_t offset, void *cookie);
 
+/**
+ * Attach an open file descriptor to a fuse+iomap mount.  Currently must be
+ * a block device.
+ *
+ * Added in FUSE protocol version 7.44. If the kernel does not support
+ * this (or a newer) version, the function will return -ENOSYS and do
+ * nothing.
+ *
+ * @param se the session object
+ * @param fd file descriptor of an open block device
+ * @param map_dev pointer to iomap device number
+ * @return zero for success, -errno for failure
+ */
+int fuse_lowlevel_notify_iomap_add_device(struct fuse_session *se, int fd,
+					  uint32_t *map_dev);
+
 
 /* ----------------------------------------------------------- *
  * Utility functions					       *
diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index 56f4789ddb2d0a..ef92ab8c062cbf 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -3110,6 +3110,27 @@ int fuse_lowlevel_notify_store(struct fuse_session *se, fuse_ino_t ino,
 	return res;
 }
 
+int fuse_lowlevel_notify_iomap_add_device(struct fuse_session *se, int fd,
+					  uint32_t *map_dev)
+{
+	struct fuse_iomap_add_device_out outarg = {
+		.fd = fd,
+		.map_dev = map_dev,
+	};
+	struct iovec iov[2];
+
+	if (!se)
+		return -EINVAL;
+
+	if (se->conn.proto_minor < 44)
+		return -ENOSYS;
+
+	iov[1].iov_base = &outarg;
+	iov[1].iov_len = sizeof(outarg);
+
+	return send_notify_iov(se, FUSE_NOTIFY_ADD_IOMAP_DEVICE, iov, 2);
+}
+
 struct fuse_retrieve_req {
 	struct fuse_notify_req nreq;
 	void *cookie;
diff --git a/lib/fuse_versionscript b/lib/fuse_versionscript
index 22c59e1af66c95..5c04e204adba33 100644
--- a/lib/fuse_versionscript
+++ b/lib/fuse_versionscript
@@ -205,6 +205,7 @@ FUSE_3.17 {
 FUSE_3.18 {
 	global:
 		fuse_req_is_uring;
+		fuse_lowlevel_notify_iomap_add_device;
 } FUSE_3.17;
 
 # Local Variables:


