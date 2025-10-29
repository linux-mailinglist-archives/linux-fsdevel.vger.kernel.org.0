Return-Path: <linux-fsdevel+bounces-66065-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB36C17B87
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 61BED4FE000
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011672D7DC8;
	Wed, 29 Oct 2025 01:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBoD/usR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501D526529B;
	Wed, 29 Oct 2025 01:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761699684; cv=none; b=HzxusxzLWo+MGV0WG4AsswZcdxjxRrznyFzkA53oEWFQNypXKdbk4B1HxdEmlIerKaBM6q/2gJytuYwK8LwEZM8xzHIPzrQah+goV9rXps0Ef99NUevhnfrIzjvtthxlk8qRUD+KnVm9C+tSbEk7VTwrd9XKJ/L1abibPcfyhyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761699684; c=relaxed/simple;
	bh=Dpj2RMqBrC/jUGijZJDnD41kh2g/xLksavnFREPJyLY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KF768UQ/zzxz67IhdSM92KGnz0aRzOre0JEda8clIHR0x8WRpRNNsrO8PIeyvrE0oRAoFDsq/scvRVSZ2XrENibs1V5ZcAa47SEv584yO72eNbNkxgrk3Rf7un7lKqv5tu2741Wt0Z27+WKzgCYtPtzb+tF0Eh1pALt5kQX6S0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBoD/usR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21CE7C4CEE7;
	Wed, 29 Oct 2025 01:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761699684;
	bh=Dpj2RMqBrC/jUGijZJDnD41kh2g/xLksavnFREPJyLY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=MBoD/usRh+ep6QW9/Nt+MlK/+JSvkhtPR1pFYUW44qoQ7xkBMwKYafUGKg8zXsFAv
	 07+9y1r+nW6r6blKTjPcngfw87Fdq6surcoIblCMkW8dI9proq09g/dZ1xCmkUQ2c0
	 vd9chkq0U8fRQ35GbvKeI5hdgPB77mR3QGcGL4HqhzS/KfGKWu0LEfLtuqRledjLwf
	 Sa+qOlwobpz6iFSRv7Ln0fB483XaVoMPgE9cbP+WjtPNvV0vyRc0zZuoZo+V/tWF5g
	 VKqkXjT5/uq2YOj7Cj2NoFuksc6SGBLLKKmScQGj4CKPvL5GVoV0qiLJrcBxeW9haQ
	 Xzae12FzQcX+Q==
Date: Tue, 28 Oct 2025 18:01:23 -0700
Subject: [PATCH 08/22] libfuse: add upper level iomap ioend commands
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, miklos@szeredi.hu, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <176169813677.1427432.12873630859017935068.stgit@frogsfrogsfrogs>
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

Teach the upper level fuse library about iomap ioend events, which
happen when a write that isn't a pure overwrite completes.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse.h |    8 ++++++++
 lib/fuse.c     |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)


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
index 0d9dfe83608e1e..1d2f99074911c3 100644
--- a/lib/fuse.c
+++ b/lib/fuse.c
@@ -2852,6 +2852,27 @@ int fuse_fs_iomap_device_remove(int device_id)
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
+			 path, (unsigned long long)nodeid,
+			 (unsigned long long)attr_ino, (unsigned long long)pos,
+			 written, ioendflags, error);
+	}
+
+	return fs->op.iomap_ioend(path, nodeid, attr_ino, pos, written,
+				  ioendflags, error, new_addr);
+}
+
 static void fuse_lib_setattr(fuse_req_t req, fuse_ino_t ino, struct stat *attr,
 			     int valid, struct fuse_file_info *fi)
 {
@@ -4582,6 +4603,30 @@ static void fuse_lib_iomap_end(fuse_req_t req, fuse_ino_t nodeid,
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
@@ -4685,6 +4730,7 @@ static struct fuse_lowlevel_ops fuse_path_ops = {
 #endif
 	.iomap_begin = fuse_lib_iomap_begin,
 	.iomap_end = fuse_lib_iomap_end,
+	.iomap_ioend = fuse_lib_iomap_ioend,
 };
 
 int fuse_notify_poll(struct fuse_pollhandle *ph)


