Return-Path: <linux-fsdevel+bounces-61583-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6035B589FF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8012C1667B7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137014207F;
	Tue, 16 Sep 2025 00:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u7ay+ZUJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748874400
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 00:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757983668; cv=none; b=qX+bSfGP2H7j8wl0PpTSbNKg0TIsVeGtKP+0JYeYhz7q1tOWrloLa99Aw7vMquLFdZegIUQxF0mExqVSPaBXle1bY5QF2u438Je3AAf0YQX4q7/cCfLPRH1Iw4qCdSzlBs2K0GJgrVxPsj54dOeOzRSxweqkfBFcT2e69766fZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757983668; c=relaxed/simple;
	bh=Isdjl+DEnSjlaLiqqfEy/dKmUltBJ009k5O0ezWApGI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bkJ7JeshanoL6hduJa/nYzDKpmA5kIGgMkP5bic2Tg2DD/BNN3FBaoDyIXRfIXiz9RNlsNp6TVCc1SWr2Df+ym+2BchZTvOQjMyUxGWyhmki+Yc+YxDD/uTGf7hN5cz5bVs4ltFrZVgFioS/PI/U6gJnw/X5C3Dl2yE4ThrfzC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u7ay+ZUJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC0C5C4CEF1;
	Tue, 16 Sep 2025 00:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757983667;
	bh=Isdjl+DEnSjlaLiqqfEy/dKmUltBJ009k5O0ezWApGI=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=u7ay+ZUJBXihLVibHsMLm7eC/o0NLpu/AeazbL3k9FuW0UN47UMcz8GPTY494GYyG
	 EjhdLo3kIvRA9ynHQQlbpuEsTDFYEjahQQhITJtZv8GOQUkf6eFZNzDSGmxLNazSYC
	 q0b/uWnsJH2ekoAdVOuL2boWnyllCz5CtcVf6ervxNTgNy+kdp5vi8HTKR03IeBU4p
	 lYb/S4YUk3CBTrQ9hQoQKBGD2+UIkGCX/RVseOTIdlX/QQqsG/RTrCH+k6c6y2WgNi
	 U5BFwVtGZY7ZzkILJP1rt7tI0WVxSf/9tHeHAoYx70lVnGB7CtqxNLZz0i3q5TETC4
	 fQjWHnNXzDK5w==
Date: Mon, 15 Sep 2025 17:47:46 -0700
Subject: [PATCH 4/4] libfuse: add syncfs support to the upper library
From: "Darrick J. Wong" <djwong@kernel.org>
To: bschubert@ddn.com, djwong@kernel.org
Cc: John@groves.net, neal@gompa.dev, bernd@bsbernd.com,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com
Message-ID: <175798155313.387738.13241606425447998633.stgit@frogsfrogsfrogs>
In-Reply-To: <175798155228.387738.1956568770138953630.stgit@frogsfrogsfrogs>
References: <175798155228.387738.1956568770138953630.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Support syncfs in the upper level library.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse.h |    5 +++++
 lib/fuse.c     |   31 +++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)


diff --git a/include/fuse.h b/include/fuse.h
index e53e92786cea08..0b81a1259c4f09 100644
--- a/include/fuse.h
+++ b/include/fuse.h
@@ -903,6 +903,11 @@ struct fuse_operations {
 	 */
 	int (*iomap_config) (uint64_t supported_flags, off_t maxbytes,
 			     struct fuse_iomap_config *cfg);
+
+	/**
+	 * Flush the entire filesystem to disk.
+	 */
+	int (*syncfs) (const char *path);
 };
 
 /** Extra context that may be needed by some filesystems
diff --git a/lib/fuse.c b/lib/fuse.c
index 1c813ec5a697a0..ac0206f6ed4544 100644
--- a/lib/fuse.c
+++ b/lib/fuse.c
@@ -2963,6 +2963,16 @@ static int fuse_fs_iomap_config(struct fuse_fs *fs, uint64_t flags,
 	return fs->op.iomap_config(flags, maxbytes, cfg);
 }
 
+static int fuse_fs_syncfs(struct fuse_fs *fs, const char *path)
+{
+	fuse_get_context()->private_data = fs->user_data;
+	if (!fs->op.syncfs)
+		return -ENOSYS;
+	if (fs->debug)
+		fuse_log(FUSE_LOG_DEBUG, "syncfs[%s]\n", path);
+	return fs->op.syncfs(path);
+}
+
 static void fuse_lib_setattr(fuse_req_t req, fuse_ino_t ino, struct stat *attr,
 			     int valid, struct fuse_file_info *fi)
 {
@@ -4836,6 +4846,26 @@ static void fuse_lib_iomap_config(fuse_req_t req, uint64_t flags,
 	fuse_reply_iomap_config(req, &cfg);
 }
 
+static void fuse_lib_syncfs(fuse_req_t req, fuse_ino_t ino)
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
+	err = fuse_fs_syncfs(f->fs, path);
+	fuse_finish_interrupt(f, req, &d);
+	free_path(f, ino, path);
+	reply_err(req, err);
+}
+
 static int clean_delay(struct fuse *f)
 {
 	/*
@@ -4937,6 +4967,7 @@ static struct fuse_lowlevel_ops fuse_path_ops = {
 #ifdef HAVE_STATX
 	.statx = fuse_lib_statx,
 #endif
+	.syncfs = fuse_lib_syncfs,
 	.iomap_begin = fuse_lib_iomap_begin,
 	.iomap_end = fuse_lib_iomap_end,
 	.iomap_ioend = fuse_lib_iomap_ioend,


