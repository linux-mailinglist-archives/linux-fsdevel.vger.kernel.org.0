Return-Path: <linux-fsdevel+bounces-58483-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AADF5B2E9EC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 03:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 444BAA22700
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFD31E102D;
	Thu, 21 Aug 2025 01:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pDtkV39m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3851E5B70
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 01:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755738207; cv=none; b=B7tXQNp+NSXoKbsA3yP538QiaiDlivxZo+HDDhGJmCs5vMeBL4RqhPC+MbDj3Ry4PCAPGNINnJUSCdDhqFin9GNN0DLDwiL8PeQ/1bAIO6j4A9sjdv1+dJ7dZ3lAqVcs8JDTR//4dQxhRJdoK7F6ZwcFOMvrn4ph0MMn911Infk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755738207; c=relaxed/simple;
	bh=m3eb097lgXn+Ka4h0VT8IwiCqGMaqcso6zYxCqFzTcw=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I1JLeFV9Z+b7bD3SUMt3sM2O0yk1B2uPzzLOQosaanYvXazGj+5hyHGXj3o/yymD5K2hGqY2Z3OBCgDfH1YY5bV+sZWS7+b/bE3bdHkvF/tUO8fGaT9ucD1UYYGlpxVarQRBOhUD2XxRQCc3+QNbtkmDDnNYIo4+JSqz4xSdRdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pDtkV39m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B70BC4CEE7;
	Thu, 21 Aug 2025 01:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755738207;
	bh=m3eb097lgXn+Ka4h0VT8IwiCqGMaqcso6zYxCqFzTcw=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=pDtkV39moJ6Lc5agojo0msq3JgWwcftw7/BbFguzSCFocCdi/L73O67y1y6JBsvg2
	 Z/ycbJykoS4P2hj5qjymTxqLKrlg/TTRx6xYEosxKiSlPocvxdz46Xg/qYrjUaSuCb
	 bqCgmQhAmrn4e3hqtcMzDtpGdgY+2Qls8fDk4gvFSv/9EURXt/xzdE2qaHoO+pFxwB
	 rZzQboZvtQaLW95woL9i3E4L9CmbXW9z2kAXRMbzuYlq5WkDm4tGWgMcdzT7CUOVT0
	 Ck9bsnkyAR699dveif56Fl1Xc2ya4Z0aCQrDhtLIaBquAX6+6S1h7UgSNjw3Xtxn2k
	 gc3b1xx4/VYWA==
Date: Wed, 20 Aug 2025 18:03:26 -0700
Subject: [PATCH 08/21] libfuse: add upper level iomap ioend commands
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: John@groves.net, joannelkoong@gmail.com, bernd@bsbernd.com,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, neal@gompa.dev
Message-ID: <175573711433.19163.13457508870895963188.stgit@frogsfrogsfrogs>
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

Teach the upper level fuse library about iomap ioend events, which
happen when a write that isn't a pure overwrite completes.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse.h |    8 ++++++++
 lib/fuse.c     |   45 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)


diff --git a/include/fuse.h b/include/fuse.h
index 524b77b5d7bbd0..1357f4319bcc21 100644
--- a/include/fuse.h
+++ b/include/fuse.h
@@ -881,6 +881,14 @@ struct fuse_operations {
 			  off_t pos_in, uint64_t length_in,
 			  uint32_t opflags_in, ssize_t written_in,
 			  const struct fuse_file_iomap *iomap);
+
+	/**
+	 * Respond to the outcome of a file IO operation.
+	 */
+	int (*iomap_ioend) (const char *path, uint64_t nodeid,
+			    uint64_t attr_ino, off_t pos_in, size_t written_in,
+			    uint32_t ioendflags_in, int error_in,
+			    uint64_t new_addr_in);
 };
 
 /** Extra context that may be needed by some filesystems
diff --git a/lib/fuse.c b/lib/fuse.c
index 632e935b8dff3e..725ab615d456e3 100644
--- a/lib/fuse.c
+++ b/lib/fuse.c
@@ -2848,6 +2848,26 @@ int fuse_fs_iomap_device_remove(int device_id)
 	return fuse_lowlevel_iomap_device_remove(se, device_id);
 }
 
+static int fuse_fs_iomap_ioend(struct fuse_fs *fs, const char *path,
+			       uint64_t nodeid, uint64_t attr_ino, off_t pos,
+			       size_t written, uint32_t ioendflags, int error,
+			       uint64_t new_addr)
+{
+	fuse_get_context()->private_data = fs->user_data;
+	if (!fs->op.iomap_ioend)
+		return -ENOSYS;
+
+	if (fs->debug) {
+		fuse_log(FUSE_LOG_DEBUG,
+			 "iomap_ioend[%s] nodeid %llu attr_ino %llu pos %llu written %zu ioendflags 0x%x error %d\n",
+			 path, nodeid, attr_ino, pos, written, ioendflags,
+			 error);
+	}
+
+	return fs->op.iomap_ioend(path, nodeid, attr_ino, pos, written,
+				  ioendflags, error, new_addr);
+}
+
 static void fuse_lib_setattr(fuse_req_t req, fuse_ino_t ino, struct stat *attr,
 			     int valid, struct fuse_file_info *fi)
 {
@@ -4578,6 +4598,30 @@ static void fuse_lib_iomap_end(fuse_req_t req, fuse_ino_t nodeid,
 	reply_err(req, err);
 }
 
+static void fuse_lib_iomap_ioend(fuse_req_t req, fuse_ino_t nodeid,
+				 uint64_t attr_ino, off_t pos, size_t written,
+				 uint32_t ioendflags, int error,
+				 uint64_t new_addr)
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
+	err = fuse_fs_iomap_ioend(f->fs, path, nodeid, attr_ino, pos, written,
+				  ioendflags, error, new_addr);
+	fuse_finish_interrupt(f, req, &d);
+	free_path(f, nodeid, path);
+	reply_err(req, err);
+}
+
 static int clean_delay(struct fuse *f)
 {
 	/*
@@ -4681,6 +4725,7 @@ static struct fuse_lowlevel_ops fuse_path_ops = {
 #endif
 	.iomap_begin = fuse_lib_iomap_begin,
 	.iomap_end = fuse_lib_iomap_end,
+	.iomap_ioend = fuse_lib_iomap_ioend,
 };
 
 int fuse_notify_poll(struct fuse_pollhandle *ph)


