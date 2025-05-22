Return-Path: <linux-fsdevel+bounces-49623-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BD9AC0101
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 02:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B3C116E58E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 00:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36F380B;
	Thu, 22 May 2025 00:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZEZK3iu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E17E36B
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 May 2025 00:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747872414; cv=none; b=u2TSLYgqrBZzR6aPyDdERU1nvFBW0GtKNtmny2dOd4H7uB1NeUrmYAqNkvDCPmiGUSDmiTMTKSOlnWIP/GgD7w0k64nBdnTkzoIjUdav3gU7u8sY4Mg3P/jqXJUBuC2aFb0PEf5j2zqSa6SUCgZrj4h7QwFus56bNAxQ64vT2nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747872414; c=relaxed/simple;
	bh=pS+3OxbcNNct28bcrIOdxPUctas2Ii068jvOQOZcdzk=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rip9I0utv+3BUv8WVvImxHvzyHsj1fjG09648mw22gmEGVrAEelW4iwQkJX0to7f75IeIFVVdBtWgWxzVrA43uGLBYGvbl5v9mAfdBMyuna3ZIS184kgPAY64fmn7oWNoWKjjTiA/Ne29LiW2G3bboca2s4/qbk26syNWDXNta4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZEZK3iu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4541C4CEE4;
	Thu, 22 May 2025 00:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747872414;
	bh=pS+3OxbcNNct28bcrIOdxPUctas2Ii068jvOQOZcdzk=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=mZEZK3iu+NDCEKSdaifu+QZ9o6jFdoaVX87U9F+dvGHDwi2I5HuhWZfQXX2HSTJXJ
	 bIIDX2DJ4jAwvXCe4mRyYCbTqcKBPT8hpi5DClR9eyEgUSTmQ09PpYOBal+JvgOeq0
	 moB9GX4o0Je7fEn4RqIpHlefLVPhYdSZPVJAyD/wzoTS02Qu2g8ZDROGeRQoslgMoI
	 ZUbwC9vCiUBDJRzQzTiyL9ajp2/5AtxKFdmhtXylRk49WR2Is1OckknqBu/SAoCtzw
	 SNay+bAoAYXl3RbrHhvgalfc7aaN8YZ8VWom8c8BLk1RhxkIByJh2/wwa6aEwEdC27
	 bbQcYQXa0vKfg==
Date: Wed, 21 May 2025 17:06:53 -0700
Subject: [PATCH 6/8] libfuse: add upper level iomap ioend commands
From: "Darrick J. Wong" <djwong@kernel.org>
To: bschubert@ddn.com, djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, bernd@bsbernd.com, John@groves.net,
 joannelkoong@gmail.com, miklos@szeredi.hu
Message-ID: <174787196466.1483718.4949810896113006588.stgit@frogsfrogsfrogs>
In-Reply-To: <174787196326.1483718.13513023339006584229.stgit@frogsfrogsfrogs>
References: <174787196326.1483718.13513023339006584229.stgit@frogsfrogsfrogs>
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
 include/fuse.h |    6 ++++++
 lib/fuse.c     |   45 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)


diff --git a/include/fuse.h b/include/fuse.h
index fa5543bdf59deb..5b0e8fb370c27c 100644
--- a/include/fuse.h
+++ b/include/fuse.h
@@ -863,6 +863,12 @@ struct fuse_operations {
 			  off_t pos_in, uint64_t length_in,
 			  uint32_t opflags_in, ssize_t written_in,
 			  const struct fuse_iomap *iomap_in);
+
+	/* Complete an iomap file IO operation */
+	int (*iomap_ioend) (const char *path, uint64_t nodeid,
+			    uint64_t attr_ino, off_t pos_in, size_t written_in,
+			    uint32_t ioendflags_in, int error_in,
+			    uint64_t new_addr_in);
 #endif /* FUSE_USE_VERSION >= 318 */
 };
 
diff --git a/lib/fuse.c b/lib/fuse.c
index efec49d35043e0..b1404cda0abc74 100644
--- a/lib/fuse.c
+++ b/lib/fuse.c
@@ -4528,6 +4528,50 @@ static void fuse_lib_iomap_end(fuse_req_t req, fuse_ino_t nodeid,
 	reply_err(req, err);
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
@@ -4628,6 +4672,7 @@ static struct fuse_lowlevel_ops fuse_path_ops = {
 	.lseek = fuse_lib_lseek,
 	.iomap_begin = fuse_lib_iomap_begin,
 	.iomap_end = fuse_lib_iomap_end,
+	.iomap_ioend = fuse_lib_iomap_ioend,
 };
 
 int fuse_notify_poll(struct fuse_pollhandle *ph)


