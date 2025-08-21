Return-Path: <linux-fsdevel+bounces-58493-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D9CB2E9FF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 03:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FB053B8A45
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8EDB1DF97D;
	Thu, 21 Aug 2025 01:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QOT4lAPo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151511A9F9F
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 01:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755738364; cv=none; b=jOd0DYjuc3HwMtBVeJB7+Pk3Lq/gC+InuNBO9msJXflODZRkEgL16fX2nKCpaIx+H88vK0oqX3vIyYRaKzwYYIlUAyIqkiQ/MZravhqRrwBnQfDBivOR820djzznyzb6DLriRQVeBr4IC4fSVwil9v+gJiNkTp1eUpSeeMXgRuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755738364; c=relaxed/simple;
	bh=XnnBOf4AfhjVY+505UBDnC33OJ/8CxGItsnspttK/0M=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L1yI/GFfo82OABb8kLwpBIdeG8x2eidBxCBiJCo1asoHrw+O3LzDTHjTlfoIrJJvnhyDfCS5X0Y8vKrMo3vB8JJGvBoYA1s6BSfWQ9s/uvKoVFw/en0luK3vxRydcjeN6sgoLIiEF2H+BD8DjN5aqBmOEIdIOWjQLgd7O/ysmRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QOT4lAPo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C4AFC4CEE7;
	Thu, 21 Aug 2025 01:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755738363;
	bh=XnnBOf4AfhjVY+505UBDnC33OJ/8CxGItsnspttK/0M=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=QOT4lAPobD1nJh1tg6Yxv2sHlx61dNZT/bJs/Oj56I3QkQ6BCFXqmWqSU2MfqfKhS
	 aPjkaZUZeqMvaZKEMDMMpj0hfVYJQOuwsLkIjxKMc9Ah/MMpTDynEnwjsK9YImbc6Z
	 fRPVlz6vArYHkstsu4UfKFQnC6JQeNe06rKj0BMEVHT20GVIFF6gXvOhNtATlG7Jxl
	 AErGfk7YY5tGXZ6PwGslS0nqy+xZCOCPkpkSs1Gya+eZy1gVzDxCRroOf1tPJkN4cV
	 kBUdsJGbVsKCVrXa8j6HwhNbsXccnDfe9ffQ+TCy+q5I99GgsOC4MJDoTEcpCajT6E
	 hZ1ViD38fvE8A==
Date: Wed, 20 Aug 2025 18:06:03 -0700
Subject: [PATCH 18/21] libfuse: add low level code to invalidate iomap block
 device ranges
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: John@groves.net, joannelkoong@gmail.com, bernd@bsbernd.com,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, neal@gompa.dev
Message-ID: <175573711622.19163.14817301594564446642.stgit@frogsfrogsfrogs>
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
index 46960711691d99..1470b59d742165 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -241,6 +241,7 @@
  *    SEEK_{DATA,HOLE}, buffered I/O, and direct I/O
  *  - add FUSE_ATTR_IOMAP to enable iomap for specific inodes
  *  - add FUSE_IOMAP_CONFIG so the fuse server can configure more fs geometry
+ *  - add FUSE_NOTIFY_IOMAP_DEV_INVAL to invalidate iomap bdev ranges
  */
 
 #ifndef _LINUX_FUSE_H
@@ -691,6 +692,7 @@ enum fuse_notify_code {
 	FUSE_NOTIFY_DELETE = 6,
 	FUSE_NOTIFY_RESEND = 7,
 	FUSE_NOTIFY_INC_EPOCH = 8,
+	FUSE_NOTIFY_IOMAP_DEV_INVAL = 9,
 	FUSE_NOTIFY_CODE_MAX,
 };
 
@@ -1389,4 +1391,11 @@ struct fuse_iomap_config_out {
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
index 1b2a6c00d0f9dc..b7a099bea6921e 100644
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
index 60627ec35cd367..f730a7fd4ead09 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -3480,6 +3480,28 @@ int fuse_lowlevel_notify_store(struct fuse_session *se, fuse_ino_t ino,
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
index f886d268c8a99f..65ce70649b031c 100644
--- a/lib/fuse_versionscript
+++ b/lib/fuse_versionscript
@@ -233,6 +233,7 @@ FUSE_3.99 {
 		fuse_fs_can_enable_iomapx;
 		fuse_lowlevel_discover_iomap;
 		fuse_reply_iomap_config;
+		fuse_lowlevel_iomap_device_invalidate;
 } FUSE_3.18;
 
 # Local Variables:


