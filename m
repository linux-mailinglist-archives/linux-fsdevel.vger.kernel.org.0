Return-Path: <linux-fsdevel+bounces-66079-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D46C17BDE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F02343A2A5E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23272D839F;
	Wed, 29 Oct 2025 01:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bbTa2/p5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383E623E35B;
	Wed, 29 Oct 2025 01:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761699903; cv=none; b=EZujeLqpOgkokrF6DAidiG4PVe4fEI9iuuwdjvTqsnfiBfI2WCr+1JKgcvYiYII+hOlFaPwmVcQH5l0UwTxd+l2IESt/PwoPrS6V3RuEuEkeOL+q3Vy/KmWrLEqQFIvDJJa85bi0v+O3h/1NaSr2cb4WhM5Ll0E/QwdcAQSuzKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761699903; c=relaxed/simple;
	bh=jURVI79vx5Z2E0H+Qq9XTpqwrS7+pzPFTT4nFXk6F2Y=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n5Bois8tF2KUSbwnaDp9JvjOGwwoN55qw3xCL0JOMBuPtVUWrskc61N7rcuewh4RfyJwRhR2h1sTzdl+Rox89uLdIkGeLx1QTRTOfM9IMy0i0dCMWb3koN0/4FaVE9d33kaeliCJySLMNp5zFrcb4SGdQ4wDsdHFaNzGouGlq+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bbTa2/p5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10964C4CEE7;
	Wed, 29 Oct 2025 01:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761699903;
	bh=jURVI79vx5Z2E0H+Qq9XTpqwrS7+pzPFTT4nFXk6F2Y=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=bbTa2/p51MRimVdEfSCn3scLR7V+AwiIhjTgCF/m+c5Yf72zI9TpQe7ovhOjD9o0h
	 AYsm1ZxjulIAjGByJ0sg2TwysYUU7EQvCV+YXoGWrzsaua8I6QP9V3KXPYgRWAHX5w
	 Id9fpQE6M4Lft9LFWM0IhgG+dgKz/G0msewzA13HnI6WO0D6Z3pOyx0KWxHBEGJ2gP
	 Jg5wnSoFejmDm/+ZI9B7U7NAL8BeFt8K1/eDDfAfFu7l2KITioOy4takuIngdxhvzd
	 1SjeQhSZldRIyFTsERVKBVwxY27HTYh/4L0TXqjCfkOyups6l+FmeuNyoKx0GcyxUb
	 7C4xtjDj9Cf5A==
Date: Tue, 28 Oct 2025 18:05:02 -0700
Subject: [PATCH 22/22] libfuse: add upper-level filesystem freeze, thaw,
 and shutdown events
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, miklos@szeredi.hu, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <176169813930.1427432.10103793123149377393.stgit@frogsfrogsfrogs>
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

Pass filesystem freeze, thaw, and shutdown requests from the low level
library to the upper level library so that those fuse servers can handle
the events.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse.h |   15 +++++++++
 lib/fuse.c     |   95 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 110 insertions(+)


diff --git a/include/fuse.h b/include/fuse.h
index e53e92786cea08..a10666b78eb1eb 100644
--- a/include/fuse.h
+++ b/include/fuse.h
@@ -903,6 +903,21 @@ struct fuse_operations {
 	 */
 	int (*iomap_config) (uint64_t supported_flags, off_t maxbytes,
 			     struct fuse_iomap_config *cfg);
+
+	/**
+	 * Freeze the filesystem
+	 */
+	int (*freezefs) (const char *path, uint64_t unlinked_files);
+
+	/**
+	 * Thaw the filesystem
+	 */
+	int (*unfreezefs) (const char *path);
+
+	/**
+	 * Shut down the filesystem
+	 */
+	int (*shutdownfs) (const char *path, uint64_t flags);
 };
 
 /** Extra context that may be needed by some filesystems
diff --git a/lib/fuse.c b/lib/fuse.c
index ed2bd3da212743..b8d4b4600077d7 100644
--- a/lib/fuse.c
+++ b/lib/fuse.c
@@ -2968,6 +2968,38 @@ static int fuse_fs_iomap_config(struct fuse_fs *fs, uint64_t flags,
 	return fs->op.iomap_config(flags, maxbytes, cfg);
 }
 
+static int fuse_fs_freezefs(struct fuse_fs *fs, const char *path,
+			    uint64_t unlinked)
+{
+	fuse_get_context()->private_data = fs->user_data;
+	if (!fs->op.freezefs)
+		return -ENOSYS;
+	if (fs->debug)
+		fuse_log(FUSE_LOG_DEBUG, "freezefs[%s]\n", path);
+	return fs->op.freezefs(path, unlinked);
+}
+
+static int fuse_fs_unfreezefs(struct fuse_fs *fs, const char *path)
+{
+	fuse_get_context()->private_data = fs->user_data;
+	if (!fs->op.unfreezefs)
+		return -ENOSYS;
+	if (fs->debug)
+		fuse_log(FUSE_LOG_DEBUG, "unfreezefs[%s]\n", path);
+	return fs->op.unfreezefs(path);
+}
+
+static int fuse_fs_shutdownfs(struct fuse_fs *fs, const char *path,
+			      uint64_t flags)
+{
+	fuse_get_context()->private_data = fs->user_data;
+	if (!fs->op.shutdownfs)
+		return -ENOSYS;
+	if (fs->debug)
+		fuse_log(FUSE_LOG_DEBUG, "shutdownfs[%s]\n", path);
+	return fs->op.shutdownfs(path, flags);
+}
+
 static void fuse_lib_setattr(fuse_req_t req, fuse_ino_t ino, struct stat *attr,
 			     int valid, struct fuse_file_info *fi)
 {
@@ -4841,6 +4873,66 @@ static void fuse_lib_iomap_config(fuse_req_t req, uint64_t flags,
 	fuse_reply_iomap_config(req, &cfg);
 }
 
+static void fuse_lib_freezefs(fuse_req_t req, fuse_ino_t ino, uint64_t unlinked)
+{
+	struct fuse *f = req_fuse_prepare(req);
+	struct fuse_intr_data d;
+	char *path;
+	int err;
+
+	err = get_path(f, ino, &path);
+	if (err) {
+		reply_err(req, err);
+		return;
+	}
+
+	fuse_prepare_interrupt(f, req, &d);
+	err = fuse_fs_freezefs(f->fs, path, unlinked);
+	fuse_finish_interrupt(f, req, &d);
+	free_path(f, ino, path);
+	reply_err(req, err);
+}
+
+static void fuse_lib_unfreezefs(fuse_req_t req, fuse_ino_t ino)
+{
+	struct fuse *f = req_fuse_prepare(req);
+	struct fuse_intr_data d;
+	char *path;
+	int err;
+
+	err = get_path(f, ino, &path);
+	if (err) {
+		reply_err(req, err);
+		return;
+	}
+
+	fuse_prepare_interrupt(f, req, &d);
+	err = fuse_fs_unfreezefs(f->fs, path);
+	fuse_finish_interrupt(f, req, &d);
+	free_path(f, ino, path);
+	reply_err(req, err);
+}
+
+static void fuse_lib_shutdownfs(fuse_req_t req, fuse_ino_t ino, uint64_t flags)
+{
+	struct fuse *f = req_fuse_prepare(req);
+	struct fuse_intr_data d;
+	char *path;
+	int err;
+
+	err = get_path(f, ino, &path);
+	if (err) {
+		reply_err(req, err);
+		return;
+	}
+
+	fuse_prepare_interrupt(f, req, &d);
+	err = fuse_fs_shutdownfs(f->fs, path, flags);
+	fuse_finish_interrupt(f, req, &d);
+	free_path(f, ino, path);
+	reply_err(req, err);
+}
+
 static int clean_delay(struct fuse *f)
 {
 	/*
@@ -4942,6 +5034,9 @@ static struct fuse_lowlevel_ops fuse_path_ops = {
 #ifdef HAVE_STATX
 	.statx = fuse_lib_statx,
 #endif
+	.freezefs = fuse_lib_freezefs,
+	.unfreezefs = fuse_lib_unfreezefs,
+	.shutdownfs = fuse_lib_shutdownfs,
 	.iomap_begin = fuse_lib_iomap_begin,
 	.iomap_end = fuse_lib_iomap_end,
 	.iomap_ioend = fuse_lib_iomap_ioend,


