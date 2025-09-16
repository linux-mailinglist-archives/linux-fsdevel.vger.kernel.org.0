Return-Path: <linux-fsdevel+bounces-61633-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD53B58A7D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 03:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A20616F90E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 01:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F911D63CD;
	Tue, 16 Sep 2025 01:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u+uxUg3X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0880418DF8D;
	Tue, 16 Sep 2025 01:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757984498; cv=none; b=OLRWdCILG9RyymBONU2kFO/f1b+jR1j26ndaFh90eGBZbNW1joQIkXdNsY3VCcEyepWWwPa8/kwsLuUHSw3JRv962F8VYdrpTkZU8LrEUsOG3b9Lx/zAI8mrfXVOc+xlzwYMsrYZev22n6xfhqXnToNa/lzWNswKHtW+K1nFfRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757984498; c=relaxed/simple;
	bh=O8zBylSIqzb33mqOVpUW0BWfCY76Dh92gNo4EJd0TxI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B21Xaj8GuliRW3KO5i9KLO8OvhhGVRnzp3K+SDH2VC1sBIG2rM8soYw/bY1gkh+U2QI1WnxcvTTbz/x1LtiNEubJNVxEpk+LGwM9ItZNmocJHFNwcpuHvIuxpIHNAlH4WKBQtI50Y7WzSj/6CYCIoJOgH8wJ73Q1e2q4ROtuLuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u+uxUg3X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67552C4CEF1;
	Tue, 16 Sep 2025 01:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757984497;
	bh=O8zBylSIqzb33mqOVpUW0BWfCY76Dh92gNo4EJd0TxI=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=u+uxUg3XDq20G24nIEmUlOBrglnvrq6GuRJA9vbyQ4rRnk4NkiiCSNzWRed+NMrB4
	 ShFTtmj5Cjo8Leot8esQ8YFoKdR3cWcvjr0pbFQFeyzzGNK0XBLmJ/7szfHw6f1RQ+
	 GXblVZt383b2N42ybKRKlgNCeOAyWJPyvSGWw+xwtVH26PKbBtK6nPWlon5iYI1932
	 Wb+16XF3Bru08msbZaZGf5/lk2BZHytH0vMa39pcekFUCPRkczVqSYxbzamH0HqhKG
	 sPtcRY1cZUNeuxcsSy2mP3+do/xQTCXkzFYf0a/+a0qgJBzwAg68OpwPIyX+TjWwdd
	 Wp7FoRLiRlp2Q==
Date: Mon, 15 Sep 2025 18:01:36 -0700
Subject: [PATCH 11/17] fuse2fs: avoid fuseblk mode if fuse-iomap support is
 likely
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: miklos@szeredi.hu, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, John@groves.net, bernd@bsbernd.com,
 joannelkoong@gmail.com
Message-ID: <175798161918.390496.869367698720142079.stgit@frogsfrogsfrogs>
In-Reply-To: <175798161643.390496.10274066827486065265.stgit@frogsfrogsfrogs>
References: <175798161643.390496.10274066827486065265.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Since fuse in iomap mode guarantees that op_destroy will be called
before umount returns, we don't need to use fuseblk mode to get that
guarantee.  Disable fuseblk mode, which saves us the trouble of closing
and reopening the device.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fuse4fs/fuse4fs.c |   20 +++++++++++++++++++-
 misc/fuse2fs.c    |   20 +++++++++++++++++++-
 2 files changed, 38 insertions(+), 2 deletions(-)


diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index e482b00f14d572..8965edbaf9b834 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -273,6 +273,7 @@ struct fuse4fs {
 	enum fuse4fs_feature_toggle iomap_want;
 	enum fuse4fs_iomap_state iomap_state;
 	uint32_t iomap_dev;
+	uint64_t iomap_cap;
 #endif
 	unsigned int blockmask;
 	unsigned long offset;
@@ -1240,6 +1241,8 @@ static errcode_t fuse4fs_open(struct fuse4fs *ff, int libext2_flags)
 	if (ff->directio)
 		flags |= EXT2_FLAG_DIRECT_IO;
 
+	dbg_printf(ff, "opening with flags=0x%x\n", flags);
+
 	err = ext2fs_open2(ff->device, options, flags, 0, 0, unix_io_manager,
 			   &ff->fs);
 	if (err == EPERM) {
@@ -6930,6 +6933,19 @@ static unsigned long long default_cache_size(void)
 	return ret;
 }
 
+#ifdef HAVE_FUSE_IOMAP
+static inline bool fuse4fs_discover_iomap(struct fuse4fs *ff)
+{
+	if (ff->iomap_want == FT_DISABLE)
+		return false;
+
+	ff->iomap_cap = fuse_lowlevel_discover_iomap(-1);
+	return ff->iomap_cap & FUSE_IOMAP_SUPPORT_FILEIO;
+}
+#else
+# define fuse4fs_discover_iomap(...)	(false)
+#endif
+
 static inline bool fuse4fs_want_fuseblk(const struct fuse4fs *ff)
 {
 	if (ff->noblkdev)
@@ -7071,6 +7087,7 @@ int main(int argc, char *argv[])
 	errcode_t err;
 	FILE *orig_stderr = stderr;
 	char extra_args[BUFSIZ];
+	bool iomap_detected = false;
 	int ret;
 
 	ret = fuse_opt_parse(&args, &fctx, fuse4fs_opts, fuse4fs_opt_proc);
@@ -7144,7 +7161,8 @@ int main(int argc, char *argv[])
 		goto out;
 	}
 
-	if (fuse4fs_want_fuseblk(&fctx)) {
+	iomap_detected = fuse4fs_discover_iomap(&fctx);
+	if (!iomap_detected && fuse4fs_want_fuseblk(&fctx)) {
 		/*
 		 * If this is a block device, we want to close the fs, reopen
 		 * the block device in non-exclusive mode, and start the fuse
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index c13bd6c3baf9c9..7fa4070dee0367 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -267,6 +267,7 @@ struct fuse2fs {
 	enum fuse2fs_feature_toggle iomap_want;
 	enum fuse2fs_iomap_state iomap_state;
 	uint32_t iomap_dev;
+	uint64_t iomap_cap;
 #endif
 	unsigned int blockmask;
 	unsigned long offset;
@@ -1052,6 +1053,8 @@ static errcode_t fuse2fs_open(struct fuse2fs *ff, int libext2_flags)
 	if (ff->directio)
 		flags |= EXT2_FLAG_DIRECT_IO;
 
+	dbg_printf(ff, "opening with flags=0x%x\n", flags);
+
 	err = ext2fs_open2(ff->device, options, flags, 0, 0, unix_io_manager,
 			   &ff->fs);
 	if (err == EPERM) {
@@ -6426,6 +6429,19 @@ static unsigned long long default_cache_size(void)
 	return ret;
 }
 
+#ifdef HAVE_FUSE_IOMAP
+static inline bool fuse2fs_discover_iomap(struct fuse2fs *ff)
+{
+	if (ff->iomap_want == FT_DISABLE)
+		return false;
+
+	ff->iomap_cap = fuse_lowlevel_discover_iomap(-1);
+	return ff->iomap_cap & FUSE_IOMAP_SUPPORT_FILEIO;
+}
+#else
+# define fuse2fs_discover_iomap(...)	(false)
+#endif
+
 static inline bool fuse2fs_want_fuseblk(const struct fuse2fs *ff)
 {
 	if (ff->noblkdev)
@@ -6466,6 +6482,7 @@ int main(int argc, char *argv[])
 	errcode_t err;
 	FILE *orig_stderr = stderr;
 	char extra_args[BUFSIZ];
+	bool iomap_detected = false;
 	int ret;
 
 	ret = fuse_opt_parse(&args, &fctx, fuse2fs_opts, fuse2fs_opt_proc);
@@ -6539,7 +6556,8 @@ int main(int argc, char *argv[])
 		goto out;
 	}
 
-	if (fuse2fs_want_fuseblk(&fctx)) {
+	iomap_detected = fuse2fs_discover_iomap(&fctx);
+	if (!iomap_detected && fuse2fs_want_fuseblk(&fctx)) {
 		/*
 		 * If this is a block device, we want to close the fs, reopen
 		 * the block device in non-exclusive mode, and start the fuse


