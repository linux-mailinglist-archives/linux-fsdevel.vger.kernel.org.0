Return-Path: <linux-fsdevel+bounces-55362-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F24BDB09832
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D5CB1C262F4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660C523ABB7;
	Thu, 17 Jul 2025 23:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fIl4mT6I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A6B1FCFF8
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 23:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752795531; cv=none; b=GayW8e3T1xrYlOxT+MB+la7pATkcPL+JZEx3jiT5hJhAq9fprD3/y2AE3FhzGtBR2gV5m0ND9lW3SpVbX4Buleint6WiSV5rbX+ijZLToHxPerQeNmgtuGZCSFPkpI4HtYRky/zlVwj3o3QadrxgpL64MNOKfMMm2w7WeseWmns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752795531; c=relaxed/simple;
	bh=IPNuJAFZ5b2mWf028/PxVeA2RNq9js8Oy7BRE284i3o=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uzrjRaOcLygCRVvikcSSG+3Hbb/fUpNT7Saz1wfYf4mWbUTOLWIYc+xlr8kvpcd4x/YIorBfMVjICT5PrJBfScSqZB9XFL6PteNMWGIlalgeBnSXKuWIBXuoy7OpXa8VhKvqMKlPQnGw5IQmOhMRvh3jYK7LzS9GEHANgaymN48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fIl4mT6I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41A30C4CEE3;
	Thu, 17 Jul 2025 23:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752795531;
	bh=IPNuJAFZ5b2mWf028/PxVeA2RNq9js8Oy7BRE284i3o=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=fIl4mT6Ipnouo2O/VdqcWVGrW0O/Hp8J0nfOH0eJyn5LfKejFtdxg/KIlgTOK9qyS
	 iUjdRQjocf/MDBmAoQ5sy5+p9M7xsIJEphOInHCkpCWYbGpIqwUg7Mj6NmxIN1Tx7m
	 m0yfmE7mk0+VaMNdt6C6YyhypENcZJFFel1taX8ZgibQo47BN3h0YzDmEm45B9xR0h
	 3Vjvyksbe0ah87a+QirffWEszjr9QXsRNZGwt/vjo9dTzJsOMYvXssrqMVswJie2JZ
	 xIUA7bTtlhGzby2vKWOyweyif4Uxa7IOS7RbT4Dy5mwki2upvchw0ox2UYejf49nth
	 7wQz34a1d+o/Q==
Date: Thu, 17 Jul 2025 16:38:50 -0700
Subject: [PATCH 2/4] libfuse: add syncfs support to the upper library
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: John@groves.net, joannelkoong@gmail.com, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, neal@gompa.dev, miklos@szeredi.hu
Message-ID: <175279460412.714831.14947365915190175591.stgit@frogsfrogsfrogs>
In-Reply-To: <175279460363.714831.9608375779453686904.stgit@frogsfrogsfrogs>
References: <175279460363.714831.9608375779453686904.stgit@frogsfrogsfrogs>
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
index 6ce6ccfd102386..a59f43e0701e1a 100644
--- a/include/fuse.h
+++ b/include/fuse.h
@@ -890,6 +890,11 @@ struct fuse_operations {
 	 */
 	int (*iomap_config) (uint32_t flags, off_t maxbytes,
 			     struct fuse_iomap_config *cfg);
+
+	/**
+	 * Flush the entire filesystem to disk.
+	 */
+	int (*syncfs) (const char *path);
 #endif /* FUSE_USE_VERSION >= 318 */
 };
 
diff --git a/lib/fuse.c b/lib/fuse.c
index b722a1b526e3de..c3fa6dad589cb0 100644
--- a/lib/fuse.c
+++ b/lib/fuse.c
@@ -2887,6 +2887,16 @@ static int fuse_fs_iomap_config(struct fuse_fs *fs, uint32_t flags,
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
@@ -4673,6 +4683,26 @@ static void fuse_lib_iomap_config(fuse_req_t req, uint32_t flags,
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
@@ -4771,6 +4801,7 @@ static struct fuse_lowlevel_ops fuse_path_ops = {
 	.fallocate = fuse_lib_fallocate,
 	.copy_file_range = fuse_lib_copy_file_range,
 	.lseek = fuse_lib_lseek,
+	.syncfs = fuse_lib_syncfs,
 	.iomap_begin = fuse_lib_iomap_begin,
 	.iomap_end = fuse_lib_iomap_end,
 	.iomap_ioend = fuse_lib_iomap_ioend,


