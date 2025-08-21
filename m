Return-Path: <linux-fsdevel+bounces-58491-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39633B2E9FC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 03:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E82643B7A64
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF011EDA26;
	Thu, 21 Aug 2025 01:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YXTrhc7J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAAC1A9F9F
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 01:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755738332; cv=none; b=OQahFPRgO/i7guUbz2BsCi3T/aMahFOEVeI8+0amwykkTogOxNK9ASouGaGJibzw9Mlu3T+DErTfRIcZcLBcoDBLRJOMGzFvXuhoQ9bQm6OZqKaEmnjEIq3ViIJvT/lvoo+LuMiJqBbb4VdM7RTiUaZ0l2jxCLxxFSu9isxSLCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755738332; c=relaxed/simple;
	bh=leONSAPhKZ3PJRJnryXfLRsVbrmIuhuMCeaQpvHNIBk=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UEaIHWEFWFRA2qyS0B+KNpVTq6rijrv5zR5ZikqKJKDBJ1VqqOhPJWd0v+pwJSaI9WZ7B7WHq7zYshtKVuWv5C250rFTWSn5znASyf8g7QA8aGm1Mq7uhXbt2q6zKTxkyFGwKMP5HIya1d+tMXOWUKCF+IbbQC7691nfbVPlTLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YXTrhc7J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 590F7C4CEE7;
	Thu, 21 Aug 2025 01:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755738332;
	bh=leONSAPhKZ3PJRJnryXfLRsVbrmIuhuMCeaQpvHNIBk=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=YXTrhc7J5ZD/32wBkMvZKUpY0FKIzQqk4DyP6KW5Xo6IzXaBVQZfHFAzDgdepZNDV
	 h4X7oZppALmtujdATTKn/Ufx5FS31n8YmZyw9C3JD3W+j31GvtHVVNsBrhkemNUIC6
	 o6l56gUhQ7A/jVqbWKaNYAQu8qHqf7v4IGnGqlhj2vkpQYAUqR/oisAKeoedFhmvad
	 en0yIJd/8z3r2ArtfUeCvOKTYmFLArDLxVQM/somVHY1/45L+WtTA65YMmvU4Kw0NH
	 Z01DS4KsAC/JP3hUy6hYUNfPULIoq67IKfFAbLEwvVgY/npWGVOTwXU2ySvjXu1sbe
	 AYrmKTRxBIF6g==
Date: Wed, 20 Aug 2025 18:05:31 -0700
Subject: [PATCH 16/21] libfuse: add upper level iomap_config implementation
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: John@groves.net, joannelkoong@gmail.com, bernd@bsbernd.com,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, neal@gompa.dev
Message-ID: <175573711584.19163.3151870041088987013.stgit@frogsfrogsfrogs>
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
index cbf2c5d3a67895..177c524eff736b 100644
--- a/lib/fuse.c
+++ b/lib/fuse.c
@@ -2937,6 +2937,23 @@ static int fuse_fs_iomap_ioend(struct fuse_fs *fs, const char *path,
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
+			 "iomap_config flags 0x%x maxbytes %lld\n",
+			 flags, (long long)maxbytes);
+	}
+
+	return fs->op.iomap_config(flags, maxbytes, cfg);
+}
+
 static void fuse_lib_setattr(fuse_req_t req, fuse_ino_t ino, struct stat *attr,
 			     int valid, struct fuse_file_info *fi)
 {
@@ -4791,6 +4808,25 @@ static void fuse_lib_iomap_ioend(fuse_req_t req, fuse_ino_t nodeid,
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
@@ -4895,6 +4931,7 @@ static struct fuse_lowlevel_ops fuse_path_ops = {
 	.iomap_begin = fuse_lib_iomap_begin,
 	.iomap_end = fuse_lib_iomap_end,
 	.iomap_ioend = fuse_lib_iomap_ioend,
+	.iomap_config = fuse_lib_iomap_config,
 };
 
 int fuse_notify_poll(struct fuse_pollhandle *ph)


