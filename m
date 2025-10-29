Return-Path: <linux-fsdevel+bounces-66061-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E94EC17B63
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A9D218965AB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4252C13AA2F;
	Wed, 29 Oct 2025 01:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="udkfaTHF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFDE1FAC42;
	Wed, 29 Oct 2025 01:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761699621; cv=none; b=lAikVixMpFlm1eXGoNEiI4D1cQ5NG5EFgP9k2syJbtZTzeZ3rkAtlQ1+96GdsdCSUDv3RY5mtmjKz/I8ImP1cLmZuXHkLQYDy9KN+9C6vQk4myKuYqK6WtwVkBvAweFATj0qOBQFxOlRieirkWrElmIKsbx+DuDnmg6hhmM5ZG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761699621; c=relaxed/simple;
	bh=LTl5boR0ractJjfOD7Uh0wIg2GcG1ZqwW/MbLKm3rI0=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XgC/v3VcU9YwGATVpgm4ISEBvjdY+EA/Da+g3JlAKdbq5iIcO+w/4K8h+zuMSmsLoc63sjoZxj1C3Slbb+bHIGRNoiY58wRM3rTKtwZZYK839n3ms4QvuMlxDRBgLVQVxkf2VrMKknA2KczrTI4Y+XBfgclidYwhbg1RNCUTkAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=udkfaTHF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7697DC4CEE7;
	Wed, 29 Oct 2025 01:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761699621;
	bh=LTl5boR0ractJjfOD7Uh0wIg2GcG1ZqwW/MbLKm3rI0=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=udkfaTHFVUcPQ4A02Rx2wVqoIeqBEmJKv9n4k2egntHsiAYfJbSIDonmAwPCD/UAC
	 Jx1iN6TiVgoAhcZCN/vOKdnHjIQh51AJpFj+1/vILJOA67WdvhAOU1TRtZJj+S5ao5
	 wkC6onyKCwLY6GZmoHltHQBcbLFS8I4shqhlTJr5Ru/8rwncWL+NjJXkJXb2V+FWpc
	 nQKhnyFZ3GfaT8AvncqVVUZNoxNN8OvJ9YQdUoSn45WfDDICrmV2W+LJu2Wer7NQoJ
	 oZ6tcqaS2UpT93L+ne/0Z4PyWhpHnavLN1F8qcfZ3eygL7baHtxeIGv2xug7TMYBJj
	 a4BNEln5KQMVg==
Date: Tue, 28 Oct 2025 18:00:21 -0700
Subject: [PATCH 04/22] libfuse: add upper level iomap commands
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, miklos@szeredi.hu, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <176169813605.1427432.7363271334520067796.stgit@frogsfrogsfrogs>
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

Teach the upper level fuse library about the iomap begin and end
operations, and connect it to the lower level.  This is needed for
fuse2fs to start using iomap.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse.h |   17 +++++++++
 lib/fuse.c     |  102 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 119 insertions(+)


diff --git a/include/fuse.h b/include/fuse.h
index 209102651e9454..958034a539abe6 100644
--- a/include/fuse.h
+++ b/include/fuse.h
@@ -864,6 +864,23 @@ struct fuse_operations {
 	 */
 	int (*statx)(const char *path, int flags, int mask, struct statx *stxbuf,
 		     struct fuse_file_info *fi);
+
+	/**
+	 * Send a mapping to the kernel so that a file IO operation can run.
+	 */
+	int (*iomap_begin) (const char *path, uint64_t nodeid,
+			    uint64_t attr_ino, off_t pos_in,
+			    uint64_t length_in, uint32_t opflags_in,
+			    struct fuse_file_iomap *read_out,
+			    struct fuse_file_iomap *write_out);
+
+	/**
+	 * Respond to the outcome of a previous file mapping operation.
+	 */
+	int (*iomap_end) (const char *path, uint64_t nodeid, uint64_t attr_ino,
+			  off_t pos_in, uint64_t length_in,
+			  uint32_t opflags_in, ssize_t written_in,
+			  const struct fuse_file_iomap *iomap);
 };
 
 /** Extra context that may be needed by some filesystems
diff --git a/lib/fuse.c b/lib/fuse.c
index 4cc6f3b1c49cc5..6f86edb07ba5d2 100644
--- a/lib/fuse.c
+++ b/lib/fuse.c
@@ -2793,6 +2793,49 @@ int fuse_fs_chmod(struct fuse_fs *fs, const char *path, mode_t mode,
 	return fs->op.chmod(path, mode, fi);
 }
 
+static int fuse_fs_iomap_begin(struct fuse_fs *fs, const char *path,
+			       fuse_ino_t nodeid, uint64_t attr_ino, off_t pos,
+			       uint64_t count, uint32_t opflags,
+			       struct fuse_file_iomap *read,
+			       struct fuse_file_iomap *write)
+{
+	fuse_get_context()->private_data = fs->user_data;
+	if (!fs->op.iomap_begin)
+		return -ENOSYS;
+
+	if (fs->debug) {
+		fuse_log(FUSE_LOG_DEBUG,
+			 "iomap_begin[%s] nodeid %llu attr_ino %llu pos %llu count %llu opflags 0x%x\n",
+			 path, (unsigned long long)nodeid,
+			 (unsigned long long)attr_ino, (unsigned long long)pos,
+			 (unsigned long long)count, opflags);
+	}
+
+	return fs->op.iomap_begin(path, nodeid, attr_ino, pos, count, opflags,
+				  read, write);
+}
+
+static int fuse_fs_iomap_end(struct fuse_fs *fs, const char *path,
+			     fuse_ino_t nodeid, uint64_t attr_ino, off_t pos,
+			     uint64_t count, uint32_t opflags, ssize_t written,
+			     const struct fuse_file_iomap *iomap)
+{
+	fuse_get_context()->private_data = fs->user_data;
+	if (!fs->op.iomap_end)
+		return -ENOSYS;
+
+	if (fs->debug) {
+		fuse_log(FUSE_LOG_DEBUG,
+			 "iomap_end[%s] nodeid %llu attr_ino %llu pos %llu count %llu opflags 0x%x written %zd\n",
+			 path, (unsigned long long)nodeid,
+			 (unsigned long long)attr_ino, (unsigned long long)pos,
+			 (unsigned long long)count, opflags, written);
+	}
+
+	return fs->op.iomap_end(path, nodeid, attr_ino, pos, count, opflags,
+				written, iomap);
+}
+
 static void fuse_lib_setattr(fuse_req_t req, fuse_ino_t ino, struct stat *attr,
 			     int valid, struct fuse_file_info *fi)
 {
@@ -4466,6 +4509,63 @@ static void fuse_lib_statx(fuse_req_t req, fuse_ino_t ino, int flags, int mask,
 }
 #endif
 
+static void fuse_lib_iomap_begin(fuse_req_t req, fuse_ino_t nodeid,
+				 uint64_t attr_ino, off_t pos, uint64_t count,
+				 uint32_t opflags)
+{
+	struct fuse *f = req_fuse_prepare(req);
+	struct fuse_file_iomap read = { };
+	struct fuse_file_iomap write = { };
+	struct fuse_intr_data d;
+	char *path;
+	int err;
+
+	err = get_path_nullok(f, nodeid, &path);
+	if (err) {
+		reply_err(req, err);
+		return;
+	}
+
+	fuse_prepare_interrupt(f, req, &d);
+	err = fuse_fs_iomap_begin(f->fs, path, nodeid, attr_ino, pos, count,
+				  opflags, &read, &write);
+	fuse_finish_interrupt(f, req, &d);
+	free_path(f, nodeid, path);
+	if (err) {
+		reply_err(req, err);
+		return;
+	}
+
+	if (write.length == 0)
+		fuse_iomap_pure_overwrite(&write, &read);
+
+	fuse_reply_iomap_begin(req, &read, &write);
+}
+
+static void fuse_lib_iomap_end(fuse_req_t req, fuse_ino_t nodeid,
+			       uint64_t attr_ino, off_t pos, uint64_t count,
+			       uint32_t opflags, ssize_t written,
+			       const struct fuse_file_iomap *iomap)
+{
+	struct fuse *f = req_fuse_prepare(req);
+	struct fuse_intr_data d;
+	char *path;
+	int err;
+
+	err = get_path_nullok(f, nodeid, &path);
+	if (err) {
+		reply_err(req, err);
+		return;
+	}
+
+	fuse_prepare_interrupt(f, req, &d);
+	err = fuse_fs_iomap_end(f->fs, path, nodeid, attr_ino, pos, count,
+				opflags, written, iomap);
+	fuse_finish_interrupt(f, req, &d);
+	free_path(f, nodeid, path);
+	reply_err(req, err);
+}
+
 static int clean_delay(struct fuse *f)
 {
 	/*
@@ -4567,6 +4667,8 @@ static struct fuse_lowlevel_ops fuse_path_ops = {
 #ifdef HAVE_STATX
 	.statx = fuse_lib_statx,
 #endif
+	.iomap_begin = fuse_lib_iomap_begin,
+	.iomap_end = fuse_lib_iomap_end,
 };
 
 int fuse_notify_poll(struct fuse_pollhandle *ph)


