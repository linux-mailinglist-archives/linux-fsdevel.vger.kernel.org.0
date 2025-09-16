Return-Path: <linux-fsdevel+bounces-61591-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1236B58A0E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8035B3A4047
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936D519E7F9;
	Tue, 16 Sep 2025 00:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gurAmQ7v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BF6482EB
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 00:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757983777; cv=none; b=gRdltnCYW3/92LH3OvUM/Ts/QFL5tke8BrK8cJHQWls3PPD29HMfRBYxildxTxd523wgfrF4mycj18y8YpXY9pwEFFRh2ujBz/Grd8ZDRtsyDXjqFe2SiHKdtxIPdtyP9P3uzwNtPuzYPCWvKl/OJ0kM/EognlhS4Wfp9aPn6F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757983777; c=relaxed/simple;
	bh=rrOGfFr3C/nABw0/gXdv/50EyNBt717dhHqqgS9Iygw=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WZPBHoOk+gkDxf0E96yiFM0ZCkdZyQdYurmSj6kHQIE0wq41clYSnMtev7UT3/8g1i9m+ybb45elEYR5bUfNxfVTQmZlKFYgjkC3bNll2n8+GDIrjt/wC87QRJBzubke8OM4DvBYdXJHILQzkl3HOxLa+rJ9BndCWXLVcjQkSiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gurAmQ7v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 781F2C4CEF1;
	Tue, 16 Sep 2025 00:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757983776;
	bh=rrOGfFr3C/nABw0/gXdv/50EyNBt717dhHqqgS9Iygw=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=gurAmQ7v5Kt6aI8103kqNdxM5OkVVNH75OVioTiv+MzojlG5SVNR3w9fTEM0yUcAo
	 6wRveHnYAKOn6N7hxdzWiqIr3ba3x9s7kSARg0t0XJTPaJ4BdW5Q/rMNIjlvkpnT2s
	 4Rqo0kGRfSKCQWYVLdpvZPXfeB5QeGA7cqrAQ5loJa0LIQRvW3+4tJTLeVq8Ku41tf
	 2ryt1Lm8PE3WR/DEkUzd6bwxsYaApffYB3AZKxYOnayBmg1mWh6fE/b/npe6885XRH
	 i+Sq+lkczn2SoD556Eac4K90CmfCATjELZbprQyC1JXDFKSMVIZv8jBE2w49LJWeq6
	 c7cIhQA6i9HwQ==
Date: Mon, 15 Sep 2025 17:49:36 -0700
Subject: [PATCH 4/4] libfuse: enable setting iomap block device block size
From: "Darrick J. Wong" <djwong@kernel.org>
To: bschubert@ddn.com, djwong@kernel.org
Cc: John@groves.net, neal@gompa.dev, bernd@bsbernd.com,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com
Message-ID: <175798155841.388120.11176490794113987015.stgit@frogsfrogsfrogs>
In-Reply-To: <175798155756.388120.4267843355083714610.stgit@frogsfrogsfrogs>
References: <175798155756.388120.4267843355083714610.stgit@frogsfrogsfrogs>
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
index 3b88b36c04ae02..01a1372afb40b3 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -1163,6 +1163,11 @@ struct fuse_iomap_support {
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
@@ -1172,6 +1177,8 @@ struct fuse_iomap_support {
 #define FUSE_DEV_IOC_ADD_IOMAP		_IO(FUSE_DEV_IOC_MAGIC, 99)
 #define FUSE_DEV_IOC_IOMAP_SUPPORT	_IOR(FUSE_DEV_IOC_MAGIC, 99, \
 					     struct fuse_iomap_support)
+#define FUSE_DEV_IOC_IOMAP_SET_BLOCKSIZE _IOW(FUSE_DEV_IOC_MAGIC, 99, \
+					      struct fuse_iomap_backing_info)
 
 struct fuse_lseek_in {
 	uint64_t	fh;
diff --git a/include/fuse_lowlevel.h b/include/fuse_lowlevel.h
index 7a99f05e2de841..43098cb655effa 100644
--- a/include/fuse_lowlevel.h
+++ b/include/fuse_lowlevel.h
@@ -2692,6 +2692,18 @@ uint64_t fuse_lowlevel_discover_iomap(int fd);
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
index 784c90d8cd1e3f..68e979e2ab334e 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -4844,3 +4844,14 @@ int fuse_lowlevel_add_iomap(int fd)
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
index 39bc1e1036007a..c45be2a92e59b9 100644
--- a/lib/fuse_versionscript
+++ b/lib/fuse_versionscript
@@ -255,6 +255,7 @@ FUSE_3.99 {
 		fuse_service_request_file;
 		fuse_service_send_goodbye;
 		fuse_service_take_fusedev;
+		fuse_lowlevel_iomap_set_blocksize;
 } FUSE_3.18;
 
 # Local Variables:


