Return-Path: <linux-fsdevel+bounces-58500-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1899B2EA09
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 03:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B14707BCC84
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A611E32D3;
	Thu, 21 Aug 2025 01:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aWH/xBAk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C89E5FEE6
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 01:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755738473; cv=none; b=VE1y0bPvZIaoIXr5nZE7hytHbi2w08mkCsJRAcNr9aMbf4evL3DPzZ243BBe6fmEo2Gs1p2B22n0yL8GN5Q3e+xv19YKjNLbrzOsd8GgRQ7t3WOup9+T/d5BsqTzxzTHPmXU0xdmbhLfRD/8RMWtsVhuKtGKXroq+Xt1kfrlbB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755738473; c=relaxed/simple;
	bh=4S6+DJydNZZZ4tPz+Rp9nTzYehO0C+xlV3fCjRnQHQ8=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k+XjKFY09VAqDfvkmV74kHnEMNs9mavU3ltH9SwRnQtcl895e1v5uunlzgJnWLwoPgfw3qG5WdGf1f83CbRBw7iwyX90SFZ8uQK1SuU+Ig153CE67k3+wngQvZ7keNvGE8ODNjfI3QsbN4ZUOq4/zJImuzGx1yzJMQ2iFbLEdII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aWH/xBAk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E57CAC4CEE7;
	Thu, 21 Aug 2025 01:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755738473;
	bh=4S6+DJydNZZZ4tPz+Rp9nTzYehO0C+xlV3fCjRnQHQ8=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=aWH/xBAkHiaPevSfTM1ouTvrVhUS2qwDIrG9es8oucshtN8vt/0YIkjlUtQo2f+Sy
	 VuBrzp7U3LefuPEOqzXdaBru/rv/PcuDuEiuhHcgIPqPPhXTb7zHOMfwQ1qEO4q0JP
	 xUTREShZYfjn5QfqqLXCRSYzno4iLFbPmjvi3czrHlBo/1+17QBtfTSsQ8N8g3z04E
	 KDJprV4tkvUJzZDdVd8246GI04YoKbrYH16FyYcswmQdZDaCLx8kiRGlbK0WemvG4q
	 goeuhmw4UHZ4CHh8c7TceRuy/+TsTf1/d/O5TmIUYUzNFxJus95nOaGdOQHQWdrSxI
	 GFqCwQre+LF5Q==
Date: Wed, 20 Aug 2025 18:07:52 -0700
Subject: [PATCH 2/2] libfuse: add syncfs support to the upper library
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: John@groves.net, joannelkoong@gmail.com, bernd@bsbernd.com,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, neal@gompa.dev
Message-ID: <175573712231.20121.7895589272128230472.stgit@frogsfrogsfrogs>
In-Reply-To: <175573712188.20121.2758227627402346100.stgit@frogsfrogsfrogs>
References: <175573712188.20121.2758227627402346100.stgit@frogsfrogsfrogs>
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
index f8a57154017a2a..baf7a2e90af5e7 100644
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
index 7b28f848116abb..4e207491532e8b 100644
--- a/lib/fuse.c
+++ b/lib/fuse.c
@@ -2993,6 +2993,16 @@ int fuse_fs_iomap_inval(uint64_t nodeid, uint64_t attr_ino, loff_t read_off,
 						&write);
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
@@ -4866,6 +4876,26 @@ static void fuse_lib_iomap_config(fuse_req_t req, uint64_t flags,
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
@@ -4967,6 +4997,7 @@ static struct fuse_lowlevel_ops fuse_path_ops = {
 #ifdef HAVE_STATX
 	.statx = fuse_lib_statx,
 #endif
+	.syncfs = fuse_lib_syncfs,
 	.iomap_begin = fuse_lib_iomap_begin,
 	.iomap_end = fuse_lib_iomap_end,
 	.iomap_ioend = fuse_lib_iomap_ioend,


