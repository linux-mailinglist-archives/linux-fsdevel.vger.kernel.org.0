Return-Path: <linux-fsdevel+bounces-58481-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A53C3B2E9F9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 03:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1367917C49F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8C41DF97D;
	Thu, 21 Aug 2025 01:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JEYjW0U3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56830192B66
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 01:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755738176; cv=none; b=RxxqXVAffsVjhLiVbnFZdy/EXipJ3eIlphGrXZverV3BManYLod4VKpm7g18bkt9cGiYjiV0gr3QYVKKwzY0foHTcJFA+vM8VEfYUuwgvx+4cKPTRuTdxrIArxPFx7kBQA8rz1p/dp5+18O0Xy800VGrzs0DF14d0VDdr64Et5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755738176; c=relaxed/simple;
	bh=Dnsj+qmJzbnjuixnZiPnNvHtU/f8YaEdBBuBAvYeixY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rAgIF1+CQegxi3gv0t80JeWbpWP+KX+ECxn33ALX3EKWamNtgTQcR6v04ssRnDeP2aX0lk18kj3UgHiOEWIogAMNBc1PLQX+nGaX9m/DSu/59DaBUGWWEK22iFfz4dxOCVJ3v3HnyIgW8oZXfiL989VFacygvoQ5mspvkMzkNYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JEYjW0U3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31D26C4CEE7;
	Thu, 21 Aug 2025 01:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755738176;
	bh=Dnsj+qmJzbnjuixnZiPnNvHtU/f8YaEdBBuBAvYeixY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=JEYjW0U31CIy52DgwgzSiMU7FN9Qe2m+Hu7PT63Gbwjo7kNn2HdFrkpttwNY765Rb
	 IRCHIkqkEteLdD/xKnVT+BuX75nnBQvXx8EPXE2vJU9FBsSAvuG9PVrgcMoL225N8w
	 5Ew6XpBbWuzZOG8tsc2FCBtxWrmXt8YKTlSJXFioUMaQx5uv1lwYEYKKgYsTcf8H23
	 eDDkqX/Xeim17XnSoo9/8Dys0srFjZFkI7H95QgevhwP+9hHgsSOAa6bCZ28gTlV3a
	 cZqs8L2M+i4xf5wc3uvp6OotRpI10iCpLNYdI1bMJbnRzYnuXTTRy5Nbu96fJKZ6CU
	 UWrtPFVjHQf4Q==
Date: Wed, 20 Aug 2025 18:02:55 -0700
Subject: [PATCH 06/21] libfuse: add upper-level iomap add device function
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: John@groves.net, joannelkoong@gmail.com, bernd@bsbernd.com,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, neal@gompa.dev
Message-ID: <175573711395.19163.4636093031457989871.stgit@frogsfrogsfrogs>
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
index d785303bab99ea..03cce1f0f184c3 100644
--- a/lib/fuse_versionscript
+++ b/lib/fuse_versionscript
@@ -223,6 +223,8 @@ FUSE_3.99 {
 		fuse_reply_iomap_begin;
 		fuse_lowlevel_iomap_device_add;
 		fuse_lowlevel_iomap_device_remove;
+		fuse_fs_iomap_device_add;
+		fuse_fs_iomap_device_remove;
 } FUSE_3.18;
 
 # Local Variables:


