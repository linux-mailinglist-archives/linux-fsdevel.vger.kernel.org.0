Return-Path: <linux-fsdevel+bounces-61568-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD137B589EF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 683813AC443
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91721A3172;
	Tue, 16 Sep 2025 00:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="blAcZIOB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440C514F112
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 00:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757983433; cv=none; b=TvDRzU1n04T7YtdBochX0PHuxC3u5lUlHpykyi/jICI5/L5fxxoeMKkQiJBN+eQVkC00/R+WZUcLojqG19dv2sZVWplnv8cqEUTYKaIKrxPufsos3ivmyhwZCfl3TU2+Km0Gcg8tkvew0ZtjuXGbiCSBD1r5Cvm62XDIyMHENOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757983433; c=relaxed/simple;
	bh=m3eb097lgXn+Ka4h0VT8IwiCqGMaqcso6zYxCqFzTcw=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lXwTstm0mGIuHjGFIXxfENqjYgvu3NmqkD076FDurA/mBwssWqO3tfJMbe9spaSEyRe9PV6nosI0gX17RSWirWJDWItmQ18syMgRNQyz9bcQrzsSImSiJuJQGTG8ALLfL7JFIPqhDElTqpJoWc/3rXwB0nR/mC/Tn2J5dz/Xuhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=blAcZIOB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9003C4CEF1;
	Tue, 16 Sep 2025 00:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757983432;
	bh=m3eb097lgXn+Ka4h0VT8IwiCqGMaqcso6zYxCqFzTcw=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=blAcZIOBBrjeNGnymyXgek5FKTMyHrB7YMU77McacT184yRiEmBe5nzWZd08CHIEB
	 qyxg91nDWGZxK6nTSj+iLv9Q4/3rwOjRtoOQ/l7UQoKWJ/1zPKqM3isnJ4MlNFJuOY
	 xP02pOWG2Wgeb4S/b13Oi7u7jEeZe+1XBOw8JjP9Yg/1uptmrF0z3UJWKRxACmcKTE
	 1GIXMKs9peyGnRG8pMuKlqvr42kMP9kk3ybsjNDTpAnxFsGlroQEd+a+OwCdKthlRK
	 zApk4D8Gvl8ZHfg9KHoyCKUi7DormjN+OCEDpYNG4MV/BQmK4/siAR5EiRZWPlE5+u
	 iNNsMo7p+46Hg==
Date: Mon, 15 Sep 2025 17:43:52 -0700
Subject: [PATCH 08/18] libfuse: add upper level iomap ioend commands
From: "Darrick J. Wong" <djwong@kernel.org>
To: bschubert@ddn.com, djwong@kernel.org
Cc: John@groves.net, neal@gompa.dev, bernd@bsbernd.com,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com
Message-ID: <175798154654.386924.3267797045320691888.stgit@frogsfrogsfrogs>
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


