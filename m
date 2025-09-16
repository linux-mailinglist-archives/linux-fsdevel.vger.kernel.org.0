Return-Path: <linux-fsdevel+bounces-61566-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1D9B589ED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 362B616A56D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F3E1A5B92;
	Tue, 16 Sep 2025 00:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BmDy4gs+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6D8179A3
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 00:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757983403; cv=none; b=avqczD4eeGpN3/b4ybvHHyXalu/5HuM1WRqmT2sSYqhyv8eN4HEVldwrEh4HwxMpekYneqJWsySICYetcZ+Z29E9TxlB4uO3I6uyBeCFNS0tPGIt+OhShj6xP6pMdRpVHRpBYBoqWMuXOWvo4vnMLXNHXKPn+xDpb4dVxQ3yNfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757983403; c=relaxed/simple;
	bh=RNYTN36ZF3UFBgBcfNA0ma/OhlZCFL6GdhxividtQWU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LpUPjhEW+gn1XfVkXDfc963Ff74kGZAnsywDMsGmaO8JPLUxMm5t4DiOjSq7suRIACWHGJgGG3SDL1lx2HhVUio1EZh/kqVDvIbeCMFNb8wHLgHnk6vwAO0Tg7Ke15seXAqjJ91UbuKz7zwRoYjTpCj82pcnJ+zo+X4T+gBV2fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BmDy4gs+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97EECC4CEF1;
	Tue, 16 Sep 2025 00:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757983401;
	bh=RNYTN36ZF3UFBgBcfNA0ma/OhlZCFL6GdhxividtQWU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=BmDy4gs+gEr3OkmSVf6LRX0RMtc449AufjH7ixeDSChM7l/0OGmq79fUFWNw56FtQ
	 c4tX8l8xadYMIgkWvKSDAfD9PxZg4ONGUn6nAtlCvHnJtC16fT4+bL52d+wrcIsHIy
	 AQvsDoiN6pPKDD1k+6s1XW7mrj0SMfLLwOAEax/sWCrjduhjBmmWsUE47MwQrsg3RA
	 aWEEtiAD4kQ4qWGDbAcdT4tq3tBA61OqPzYCtae4Co4PMzyV2kgH/k8gSWZ1T7yRx6
	 Dr9wkH0k31tfoACVhJiWM6wVDFgldjsPXsFdnxCL97gKOO6G+XzF5Ghl88bAkP/tRA
	 D+9B1TBsHZS/w==
Date: Mon, 15 Sep 2025 17:43:21 -0700
Subject: [PATCH 06/18] libfuse: add upper-level iomap add device function
From: "Darrick J. Wong" <djwong@kernel.org>
To: bschubert@ddn.com, djwong@kernel.org
Cc: John@groves.net, neal@gompa.dev, bernd@bsbernd.com,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com
Message-ID: <175798154618.386924.885643663488442261.stgit@frogsfrogsfrogs>
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

Make it so that the upper level fuse library can add iomap devices too.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse.h         |   19 +++++++++++++++++++
 lib/fuse.c             |   16 ++++++++++++++++
 lib/fuse_versionscript |    2 ++
 3 files changed, 37 insertions(+)


diff --git a/include/fuse.h b/include/fuse.h
index 958034a539abe6..524b77b5d7bbd0 100644
--- a/include/fuse.h
+++ b/include/fuse.h
@@ -1381,6 +1381,25 @@ void fuse_fs_init(struct fuse_fs *fs, struct fuse_conn_info *conn,
 		struct fuse_config *cfg);
 void fuse_fs_destroy(struct fuse_fs *fs);
 
+/**
+ * Attach an open file descriptor to a fuse+iomap mount.  Currently must be
+ * a block device.
+ *
+ * @param fd file descriptor of an open block device
+ * @param flags flags for the operation; none defined so far
+ * @return positive nonzero device id on success, or negative errno on failure
+ */
+int fuse_fs_iomap_device_add(int fd, unsigned int flags);
+
+/**
+ * Detach an open file from a fuse+iomap mount.  Must be a device id returned
+ * by fuse_lowlevel_iomap_device_add.
+ *
+ * @param device_id device index as returned by fuse_lowlevel_iomap_device_add
+ * @return 0 on success, or negative errno on failure
+ */
+int fuse_fs_iomap_device_remove(int device_id);
+
 int fuse_notify_poll(struct fuse_pollhandle *ph);
 
 /**
diff --git a/lib/fuse.c b/lib/fuse.c
index eef0967f796ed6..632e935b8dff3e 100644
--- a/lib/fuse.c
+++ b/lib/fuse.c
@@ -2832,6 +2832,22 @@ static int fuse_fs_iomap_end(struct fuse_fs *fs, const char *path,
 				written, iomap);
 }
 
+int fuse_fs_iomap_device_add(int fd, unsigned int flags)
+{
+	struct fuse_context *ctxt = fuse_get_context();
+	struct fuse_session *se = fuse_get_session(ctxt->fuse);
+
+	return fuse_lowlevel_iomap_device_add(se, fd, flags);
+}
+
+int fuse_fs_iomap_device_remove(int device_id)
+{
+	struct fuse_context *ctxt = fuse_get_context();
+	struct fuse_session *se = fuse_get_session(ctxt->fuse);
+
+	return fuse_lowlevel_iomap_device_remove(se, device_id);
+}
+
 static void fuse_lib_setattr(fuse_req_t req, fuse_ino_t ino, struct stat *attr,
 			     int valid, struct fuse_file_info *fi)
 {
diff --git a/lib/fuse_versionscript b/lib/fuse_versionscript
index e796100c5ee414..c42fae5d4a3c50 100644
--- a/lib/fuse_versionscript
+++ b/lib/fuse_versionscript
@@ -224,6 +224,8 @@ FUSE_3.99 {
 		fuse_reply_iomap_begin;
 		fuse_lowlevel_iomap_device_add;
 		fuse_lowlevel_iomap_device_remove;
+		fuse_fs_iomap_device_add;
+		fuse_fs_iomap_device_remove;
 } FUSE_3.18;
 
 # Local Variables:


