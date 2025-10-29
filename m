Return-Path: <linux-fsdevel+bounces-66072-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7F9C17B9F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 022C44FD839
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853412D7DC2;
	Wed, 29 Oct 2025 01:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aj03/NTV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE9821A449;
	Wed, 29 Oct 2025 01:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761699794; cv=none; b=jt0Ohs9rqik0NQrqKgEBQKXVx3+RkH/LY908UPaPOuqerN0+mIavt6PF3ck7qc8RG/hYOjWFQFz1PKmdixwVo/MhQMi5yariD1733b5SUKDfI6cdQKC/ZJJ2myemie37MoCyz66BPKJ73cAonzdo7tMXguaONVDrLPhOfS0FIoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761699794; c=relaxed/simple;
	bh=NV0W82ZhW5ITVLgoZkzM6axV/TdMmrfFCJ/ITmJG8Co=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mtKh1fxrpfdhVMC3NOBAEkFAjY03bqbaqrs4jtSgPpv/q3atJqqroNIxVgU1xvwvntWPJkrNIlFGlZE0hhVzaC2zBarIrNOecICPpJVvJG08En+GN8jU57H6Emavk/UDDGEvL7u6NwLGXGj/Vt+eGKye7wrwQUUsQk4IsyTz+1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aj03/NTV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74E90C4CEE7;
	Wed, 29 Oct 2025 01:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761699793;
	bh=NV0W82ZhW5ITVLgoZkzM6axV/TdMmrfFCJ/ITmJG8Co=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=aj03/NTVshcMicPpb3HwtwYJzS7UwFhR209Lhk8rU8UGj62ycNxhj7StwiBCEDDLI
	 el96jIxxlnfY0FA4FcqmQ0ugR8P3oDEcW5+beYleboI47ZCfpiHvyn+/3dcFuTBm9n
	 Cde7X4nesR2APbkQq9dwei8nOuw6y1nK+IborFXkafnNw4mr+NOIqV34F38QpJj680
	 8Y7PZjED8S32ntJoiaaQCg7CFSCKOlOjnZW48Yas0rXBaB617pTkqXZWMGi9zkOCGV
	 s7tF2qZ3hEDOlPQw5iZcZDCpCovB07//8mwFvh/LS17qApVwJHV66X4j3GERODGT5t
	 64IwkWCBKYjnA==
Date: Tue, 28 Oct 2025 18:03:13 -0700
Subject: [PATCH 15/22] libfuse: add upper level iomap_config implementation
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, miklos@szeredi.hu, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <176169813804.1427432.2905769026619791379.stgit@frogsfrogsfrogs>
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

Add FUSE_IOMAP_CONFIG helpers to the upper level fuse library.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse.h |    7 +++++++
 lib/fuse.c     |   37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)


diff --git a/include/fuse.h b/include/fuse.h
index 4c4fff837437c8..74b86e8d27fb35 100644
--- a/include/fuse.h
+++ b/include/fuse.h
@@ -896,6 +896,13 @@ struct fuse_operations {
 	 */
 	int (*getattr_iflags) (const char *path, struct stat *buf,
 			       unsigned int *iflags, struct fuse_file_info *fi);
+
+	/**
+	 * Configure the filesystem geometry that will be used by iomap
+	 * files.
+	 */
+	int (*iomap_config) (uint64_t supported_flags, off_t maxbytes,
+			     struct fuse_iomap_config *cfg);
 };
 
 /** Extra context that may be needed by some filesystems
diff --git a/lib/fuse.c b/lib/fuse.c
index 9337b1b66e2c49..1fec6371b7bc81 100644
--- a/lib/fuse.c
+++ b/lib/fuse.c
@@ -2942,6 +2942,23 @@ static int fuse_fs_iomap_ioend(struct fuse_fs *fs, const char *path,
 				  ioendflags, error, new_addr);
 }
 
+static int fuse_fs_iomap_config(struct fuse_fs *fs, uint64_t flags,
+				uint64_t maxbytes,
+				struct fuse_iomap_config *cfg)
+{
+	fuse_get_context()->private_data = fs->user_data;
+	if (!fs->op.iomap_config)
+		return -ENOSYS;
+
+	if (fs->debug) {
+		fuse_log(FUSE_LOG_DEBUG,
+			 "iomap_config flags 0x%llx maxbytes %lld\n",
+			 (unsigned long long)flags, (long long)maxbytes);
+	}
+
+	return fs->op.iomap_config(flags, maxbytes, cfg);
+}
+
 static void fuse_lib_setattr(fuse_req_t req, fuse_ino_t ino, struct stat *attr,
 			     int valid, struct fuse_file_info *fi)
 {
@@ -4796,6 +4813,25 @@ static void fuse_lib_iomap_ioend(fuse_req_t req, fuse_ino_t nodeid,
 	reply_err(req, err);
 }
 
+static void fuse_lib_iomap_config(fuse_req_t req, uint64_t flags,
+				  uint64_t maxbytes)
+{
+	struct fuse_iomap_config cfg = { };
+	struct fuse *f = req_fuse_prepare(req);
+	struct fuse_intr_data d;
+	int err;
+
+	fuse_prepare_interrupt(f, req, &d);
+	err = fuse_fs_iomap_config(f->fs, flags, maxbytes, &cfg);
+	fuse_finish_interrupt(f, req, &d);
+	if (err) {
+		reply_err(req, err);
+		return;
+	}
+
+	fuse_reply_iomap_config(req, &cfg);
+}
+
 static int clean_delay(struct fuse *f)
 {
 	/*
@@ -4900,6 +4936,7 @@ static struct fuse_lowlevel_ops fuse_path_ops = {
 	.iomap_begin = fuse_lib_iomap_begin,
 	.iomap_end = fuse_lib_iomap_end,
 	.iomap_ioend = fuse_lib_iomap_ioend,
+	.iomap_config = fuse_lib_iomap_config,
 };
 
 int fuse_notify_poll(struct fuse_pollhandle *ph)


