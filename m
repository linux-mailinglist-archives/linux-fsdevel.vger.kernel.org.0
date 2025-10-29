Return-Path: <linux-fsdevel+bounces-66123-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFF7C17D5C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 67CAC4FE126
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77E72D2381;
	Wed, 29 Oct 2025 01:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iqRcccf0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEDD264617;
	Wed, 29 Oct 2025 01:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761700592; cv=none; b=jI6cATmRPGAAP2Fh1Wu9SGsUnaqjYNeW5Uu91O4MkMcUVb8Hu1ypKTGU2q7LlZU9UvoXIwA4GjrRaYbnmkwOkwz8Mmm6YFFe1lfnaB2V7RyuJG6Y/47HOgQjAAok87SZAf9QFdEfltzGF9yTL4Q3jV7hp9FVxRIUeH0Xozmpze0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761700592; c=relaxed/simple;
	bh=Fs93egrnwQSgC77Qw3BsPiF3hlCrnQQrXnUlPFJ5POU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LB55UEM6RoXv/Zh6jDqgMn1rNyCFkcCQRXvYD7jG1BIE7PKH/kZa2kx6KEF2gidVFggSeiBnnV/9HhlPGb5oWBJMb9wPv6g4LEkYkBDYDtIboqNla6BGxwSS0G9YtuD/pX/Z1VYN6Qj6LOR7dy6TBXbUiiJ4yo1IS0wDGYsRA8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iqRcccf0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88826C4CEE7;
	Wed, 29 Oct 2025 01:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761700591;
	bh=Fs93egrnwQSgC77Qw3BsPiF3hlCrnQQrXnUlPFJ5POU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=iqRcccf0DV63iHxAebafcfOkLJn7mXeSGT7AgGlLQcNVuD1QXCovMUSHp5JCMNpF9
	 wWZw2sNoSt2su0rgN9W2sDUVKonP8RJgkMte0uGUH0CEsYybsFA8Q3Wi2Goi+00chl
	 lo/O5z2FXyQzdbPyXt+yjRE86935MK7ODKXUjH48xVRZ7btKwSFfGOUTTJEbL9pwF3
	 oRk5wGmSEw52niz2ML7QcVe59rahrVrtmUmw/JeWxscfA8ad7ijm9W2Fbxjb/BfNHA
	 5tdyGBHQTvhp20xXZz9HcVieVsMfbmEHibMJCz1965i7E0esgvLh+ETgjUv4d5u5qR
	 MCVBk7r73r43g==
Date: Tue, 28 Oct 2025 18:16:31 -0700
Subject: [PATCH 1/3] fuse2fs: enable caching of iomaps
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com, bernd@bsbernd.com,
 neal@gompa.dev, miklos@szeredi.hu, linux-ext4@vger.kernel.org
Message-ID: <176169818574.1430840.331637712484434762.stgit@frogsfrogsfrogs>
In-Reply-To: <176169818545.1430840.7420840378591574460.stgit@frogsfrogsfrogs>
References: <176169818545.1430840.7420840378591574460.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Cache the iomaps we generate in the kernel for better performance.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fuse4fs/fuse4fs.c |   25 +++++++++++++++++++++++++
 misc/fuse2fs.c    |   24 ++++++++++++++++++++++++
 2 files changed, 49 insertions(+)


diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index 958b3cab83a68d..438a9030e3da27 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -293,6 +293,8 @@ struct fuse4fs {
 #ifdef STATX_WRITE_ATOMIC
 	unsigned int awu_min, awu_max;
 #endif
+	/* options set by fuse_opt_parse must be of type int */
+	int iomap_cache;
 #endif
 	unsigned int blockmask;
 	unsigned long offset;
@@ -6886,6 +6888,24 @@ static void op_iomap_begin(fuse_req_t req, fuse_ino_t fino, uint64_t dontcare,
 	if (opflags & FUSE_IOMAP_OP_ATOMIC)
 		read.flags |= FUSE_IOMAP_F_ATOMIC_BIO;
 
+	/*
+	 * Cache the mapping in the kernel so that we can reuse them for
+	 * subsequent IO.
+	 */
+	if (ff->iomap_cache) {
+		ret = fuse_lowlevel_notify_iomap_upsert(ff->fuse, fino, ino,
+							&read, NULL);
+		if (ret) {
+			ret = translate_error(fs, ino, -ret);
+			goto out_unlock;
+		} else {
+			/* Tell the kernel to retry from cache */
+			read.type = FUSE_IOMAP_TYPE_RETRY_CACHE;
+			read.dev = FUSE_IOMAP_DEV_NULL;
+			read.addr = FUSE_IOMAP_NULL_ADDR;
+		}
+	}
+
 out_unlock:
 	fuse4fs_finish(ff, ret);
 	if (ret)
@@ -7699,6 +7719,10 @@ static struct fuse_opt fuse4fs_opts[] = {
 #ifdef HAVE_CLOCK_MONOTONIC
 	FUSE4FS_OPT("timing",		timing,			1),
 #endif
+#ifdef HAVE_FUSE_IOMAP
+	FUSE4FS_OPT("iomap_cache",	iomap_cache,		1),
+	FUSE4FS_OPT("noiomap_cache",	iomap_cache,		0),
+#endif
 
 #ifdef HAVE_FUSE_IOMAP
 #ifdef MS_LAZYTIME
@@ -8083,6 +8107,7 @@ int main(int argc, char *argv[])
 		.iomap_want = FT_DEFAULT,
 		.iomap_state = IOMAP_UNKNOWN,
 		.iomap_dev = FUSE_IOMAP_DEV_NULL,
+		.iomap_cache = 1,
 #endif
 #ifdef HAVE_FUSE_LOOPDEV
 		.loop_fd = -1,
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index c0e8fa35dcf8ed..ff32a429179915 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -285,6 +285,8 @@ struct fuse2fs {
 #ifdef STATX_WRITE_ATOMIC
 	unsigned int awu_min, awu_max;
 #endif
+	/* options set by fuse_opt_parse must be of type int */
+	int iomap_cache;
 #endif
 	unsigned int blockmask;
 	unsigned long offset;
@@ -6440,6 +6442,23 @@ static int op_iomap_begin(const char *path, uint64_t nodeid, uint64_t attr_ino,
 	if (opflags & FUSE_IOMAP_OP_ATOMIC)
 		read->flags |= FUSE_IOMAP_F_ATOMIC_BIO;
 
+	/*
+	 * Cache the mapping in the kernel so that we can reuse them for
+	 * subsequent IO.
+	 */
+	if (ff->iomap_cache) {
+		ret = fuse_fs_iomap_upsert(nodeid, attr_ino, read, NULL);
+		if (ret) {
+			ret = translate_error(fs, attr_ino, -ret);
+			goto out_unlock;
+		} else {
+			/* Tell the kernel to retry from cache */
+			read->type = FUSE_IOMAP_TYPE_RETRY_CACHE;
+			read->dev = FUSE_IOMAP_DEV_NULL;
+			read->addr = FUSE_IOMAP_NULL_ADDR;
+		}
+	}
+
 out_unlock:
 	fuse2fs_finish(ff, ret);
 	return ret;
@@ -7245,6 +7264,10 @@ static struct fuse_opt fuse2fs_opts[] = {
 #ifdef HAVE_CLOCK_MONOTONIC
 	FUSE2FS_OPT("timing",		timing,			1),
 #endif
+#ifdef HAVE_FUSE_IOMAP
+	FUSE2FS_OPT("iomap_cache",	iomap_cache,		1),
+	FUSE2FS_OPT("noiomap_cache",	iomap_cache,		0),
+#endif
 
 #ifdef HAVE_FUSE_IOMAP
 #ifdef MS_LAZYTIME
@@ -7525,6 +7548,7 @@ int main(int argc, char *argv[])
 		.iomap_want = FT_DEFAULT,
 		.iomap_state = IOMAP_UNKNOWN,
 		.iomap_dev = FUSE_IOMAP_DEV_NULL,
+		.iomap_cache = 1,
 #endif
 #ifdef HAVE_FUSE_LOOPDEV
 		.loop_fd = -1,


