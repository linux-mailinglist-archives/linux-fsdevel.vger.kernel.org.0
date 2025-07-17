Return-Path: <linux-fsdevel+bounces-55351-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E10C8B09825
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F6ED16664B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5153B23FC4C;
	Thu, 17 Jul 2025 23:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZDu92RP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CA91FCFF8
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 23:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752795359; cv=none; b=loT3xZv0TS5k8qrjwikablkhjBnJmkqHG2BdgNoeMYpajLi+0NUiaaLXnkQpV7I4sXXCNVjOxjNdonERT5/vmK1IxeFyXuXUTIjfEv2LifJWihlz3HAuZb8NbkbnECJ6h+ZLCbhm4ABemQbb6nLOyWnll5BbpjcRPJ7y1whLbwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752795359; c=relaxed/simple;
	bh=fIMjHhvEAbdmw76WNBoQaqITvdRHxQEPtVRz3/ZaKO0=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JwP/Y44pIM3Reun2tTlme+rkmXNd09++aLgdUJ0B7giPuSRYtm2XIWMf42YH74o5M2pTwvCfL5s7Eb0QdzFyPnskUmFkclCtYFos0suNC2qlUoweuwT5O9L1F2IQor/T/embXmUE8m+CEfSX2pak88/ZMMhn5Hog8iGT5T60hmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZDu92RP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ED8FC4CEE3;
	Thu, 17 Jul 2025 23:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752795359;
	bh=fIMjHhvEAbdmw76WNBoQaqITvdRHxQEPtVRz3/ZaKO0=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=aZDu92RPJAmwxmNo+Hfs7coeRnVVN6KPIwx5JVfIhdzbFTU45P1kCJgfRerIAWMLL
	 BrHT3HiMYQZGHKcFF+BRN9KMrsifGqzBsJBaZuk0isYZO0tt7yvSEnAXbnDkiX/Lxo
	 CzbYhFhYg70Rq++8mVDHP0+SOwDEj3JLTrsYkSeT0E8oFZpssy4eX5IEvLHzWYdMix
	 U5x42b3SuNktDxRVKweCnP+ugvdgvlBwSZK4KI5gVbmMkGNccFMG7faqDhS3cbkdwz
	 6jl6b+1L5lmio7mjoHHbdDr4/s2zi3pn9AfU9MuITzo+ALQj8prYOBVDFEed7QvPbS
	 GXwj5VqDDuEPg==
Date: Thu, 17 Jul 2025 16:35:58 -0700
Subject: [PATCH 06/14] libfuse: add upper level iomap ioend commands
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: John@groves.net, joannelkoong@gmail.com, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, neal@gompa.dev, miklos@szeredi.hu
Message-ID: <175279459839.714161.1363778226655701909.stgit@frogsfrogsfrogs>
In-Reply-To: <175279459673.714161.10658209239262310420.stgit@frogsfrogsfrogs>
References: <175279459673.714161.10658209239262310420.stgit@frogsfrogsfrogs>
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
index 6b25586e768285..e2e7c950bf144d 100644
--- a/include/fuse.h
+++ b/include/fuse.h
@@ -868,6 +868,14 @@ struct fuse_operations {
 			  off_t pos_in, uint64_t length_in,
 			  uint32_t opflags_in, ssize_t written_in,
 			  const struct fuse_iomap *iomap_in);
+
+	/**
+	 * Respond to the outcome of a file IO operation.
+	 */
+	int (*iomap_ioend) (const char *path, uint64_t nodeid,
+			    uint64_t attr_ino, off_t pos_in, size_t written_in,
+			    uint32_t ioendflags_in, int error_in,
+			    uint64_t new_addr_in);
 #endif /* FUSE_USE_VERSION >= 318 */
 };
 
diff --git a/lib/fuse.c b/lib/fuse.c
index aa4287e0896761..8dbf88877dd37c 100644
--- a/lib/fuse.c
+++ b/lib/fuse.c
@@ -2776,6 +2776,26 @@ static int fuse_fs_iomap_end(struct fuse_fs *fs, const char *path,
 				written, iomap);
 }
 
+static int fuse_fs_iomap_ioend(struct fuse_fs *fs, const char *path,
+			       uint64_t nodeid, uint64_t attr_ino, off_t pos,
+			       size_t written, uint32_t ioendflags, int error,
+			       uint64_t new_addr)
+{
+	fuse_get_context()->private_data = fs->user_data;
+	if (!fs->op.iomap_ioend)
+		return 0;
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
@@ -4466,6 +4486,30 @@ static void fuse_lib_iomap_end(fuse_req_t req, fuse_ino_t nodeid,
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
@@ -4566,6 +4610,7 @@ static struct fuse_lowlevel_ops fuse_path_ops = {
 	.lseek = fuse_lib_lseek,
 	.iomap_begin = fuse_lib_iomap_begin,
 	.iomap_end = fuse_lib_iomap_end,
+	.iomap_ioend = fuse_lib_iomap_ioend,
 };
 
 int fuse_notify_poll(struct fuse_pollhandle *ph)


