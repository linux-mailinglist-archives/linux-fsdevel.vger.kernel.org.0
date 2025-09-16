Return-Path: <linux-fsdevel+bounces-61576-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD314B589F8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 863D417649D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7731E3DCD;
	Tue, 16 Sep 2025 00:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OHBBKXBl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB33A1CD2C
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 00:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757983557; cv=none; b=uFZSORc5bP0Uir3TAbnfulsRbEvw3MDPpPomLJ/rF/lmSRlYl3pj37JVdyvViU0Bcn7VAlmyOF3E4V0FTFKFlZQSg7aVuPCzI8rCjqw7KhuNEPB0nXWhY/x3BPc51v3Uryq3HKMXv5YXdjEGkbadtOJtumIIusEB7BznburybBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757983557; c=relaxed/simple;
	bh=4NKZiIKuGA46bx4hrR5rW2ZMpxCvw5bfitcEyhEyoCE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eRWfvss6kBm/DUcIRxKWftLVC5ZHpadtcHIyBbIed/zHkWo+AbPXFHnDBuDf0d+65Kkk5rFRZrTz5T1SjGe0mvZoNYSWoGVcGKFnOljMtpu5phb7+/+j7aSEYzJvdu/N/Zw8ah9w6SJtGK/SBAce57cq/pnyesJTOmQnlnvY8Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OHBBKXBl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DF35C4CEF1;
	Tue, 16 Sep 2025 00:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757983557;
	bh=4NKZiIKuGA46bx4hrR5rW2ZMpxCvw5bfitcEyhEyoCE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=OHBBKXBloGCspKw+RVbwVcRGtN/FfecV2/Gw4KvC94lXDbKUjZBXvy6sBCELWOxPr
	 933WDQl5fpiyko/kWLNIvYr0ca/FNlPi56ER8FJNDE0yhR42egZuQ760VdhNO1UNLf
	 59MfQrNMq0KRxKG2fy+q07UVfzyLcC3PsnoOi+KQ59gf3dKk3KTD9WVTjfTI6aasd0
	 Vbwwu9eoT2iAO1/qfPsMLzOQjhOZxIiwfBoWr+56sLA2OTGIC9dYwPcoHomI5FvQUx
	 p2USyTnWaWIYagZsLVi5TaJq/qjAgEjuhPBq05wTpYJvnE9YTwYxK0u/524F2ikAks
	 Zb9EiL500L4/A==
Date: Mon, 15 Sep 2025 17:45:57 -0700
Subject: [PATCH 16/18] libfuse: add low level code to invalidate iomap block
 device ranges
From: "Darrick J. Wong" <djwong@kernel.org>
To: bschubert@ddn.com, djwong@kernel.org
Cc: John@groves.net, neal@gompa.dev, bernd@bsbernd.com,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com
Message-ID: <175798154797.386924.14334721167031207021.stgit@frogsfrogsfrogs>
In-Reply-To: <175798154438.386924.8786074960979860206.stgit@frogsfrogsfrogs>
References: <175798154438.386924.8786074960979860206.stgit@frogsfrogsfrogs>
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
index 4009d0109711d9..861c3d449db788 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -240,6 +240,7 @@
  *  - add FUSE_IOMAP and iomap_{begin,end,ioend} for regular file operations
  *  - add FUSE_ATTR_IOMAP to enable iomap for specific inodes
  *  - add FUSE_IOMAP_CONFIG so the fuse server can configure more fs geometry
+ *  - add FUSE_NOTIFY_IOMAP_DEV_INVAL to invalidate iomap bdev ranges
  */
 
 #ifndef _LINUX_FUSE_H
@@ -689,6 +690,7 @@ enum fuse_notify_code {
 	FUSE_NOTIFY_DELETE = 6,
 	FUSE_NOTIFY_RESEND = 7,
 	FUSE_NOTIFY_INC_EPOCH = 8,
+	FUSE_NOTIFY_IOMAP_DEV_INVAL = 9,
 	FUSE_NOTIFY_CODE_MAX,
 };
 
@@ -1394,4 +1396,11 @@ struct fuse_iomap_config_out {
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
index b79c73d1573c40..687e14b8fea64f 100644
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
index 26c23527439feb..166bd82eca463b 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -3483,6 +3483,28 @@ int fuse_lowlevel_notify_store(struct fuse_session *se, fuse_ino_t ino,
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


