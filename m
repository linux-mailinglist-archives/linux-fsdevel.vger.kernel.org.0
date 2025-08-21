Return-Path: <linux-fsdevel+bounces-58541-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C6CB2EA67
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 03:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D3C6C4E33B9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1DE1F463B;
	Thu, 21 Aug 2025 01:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XzCLbDlJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CF71A9FAD;
	Thu, 21 Aug 2025 01:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755739115; cv=none; b=XixgnT4hG52beEJ1AB4N8MNbmwvdqGAddYOiDVaOwv2y18JkeW7B5HhGq84xyevro1EMinlF/S8p4/kyGtQN+N8jn8Qauu4VOqZQ6pvCOcfk4K46iChwr3E3qDCL6jnWJXrvLouDuhMouLqBgx5HhpDCiBTfqYs/vsUdft5vjOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755739115; c=relaxed/simple;
	bh=9DNZXmNbUyDbPmYGp4pYp3Si6l1xdCOZ4HtYatPOvGA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FiQ1gxqEvfY05F8vdtEnsZDLRu218z+BPPHWJLAqrPl7s0mQG0CywDzaiv/vM47VLQ0mlEIjcpD9jYhp6fSb7qK0bymBTjP2jrsMzQQ/0DvPXv9Ffwd3JazDxpqw7mXLxSOMWUjm5LR19Nze0+jo1kNoMsdDLQ+XMI+NZ1t/0dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XzCLbDlJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE28FC4CEEB;
	Thu, 21 Aug 2025 01:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755739115;
	bh=9DNZXmNbUyDbPmYGp4pYp3Si6l1xdCOZ4HtYatPOvGA=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=XzCLbDlJ+776aMrCk9307dhMwEqVsXZnnEVcl6XHG03JosCxrMll+IfiU50PornfG
	 b7Z9Qobk7wUEuLRdb0deWMZ7zCOF2pJ/ZM8EMgf+pgZ2Y52Ht+XphS35hNBUGniIcj
	 kQQt6wxd0oHEtcT5sjEj2od8N1WvsUj9G7hcDt9LS0NREcCji4J8IL33hfSJGFusQG
	 vRluF/8r7uZ7VzHU/GUkwM/hF9/nGnuJzWdB8sxYwD1WWVcNCtMqhMPhetVQe6MwVi
	 Oj1M3wZixCNj+90NpyVPrV/kz0WUozIMGfSw7+c3PYZWP8DnPorGai2/1tlffXHYgM
	 LY+kk3hXbfA+A==
Date: Wed, 20 Aug 2025 18:18:34 -0700
Subject: [PATCH 11/19] fuse2fs: avoid fuseblk mode if fuse-iomap support is
 likely
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com,
 neal@gompa.dev
Message-ID: <175573713929.21970.16585818990916539197.stgit@frogsfrogsfrogs>
In-Reply-To: <175573713645.21970.9783397720493472605.stgit@frogsfrogsfrogs>
References: <175573713645.21970.9783397720493472605.stgit@frogsfrogsfrogs>
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
 misc/fuse2fs.c |   20 +++++++++++++++++++-
 misc/fuse4fs.c |   20 +++++++++++++++++++-
 2 files changed, 38 insertions(+), 2 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 588b0053f43c95..97b010b8dc1055 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -275,6 +275,7 @@ struct fuse2fs {
 	enum fuse2fs_feature_toggle iomap_want;
 	enum fuse2fs_iomap_state iomap_state;
 	uint32_t iomap_dev;
+	uint64_t iomap_cap;
 #endif
 	unsigned int blockmask;
 	unsigned long offset;
@@ -1056,6 +1057,8 @@ static errcode_t fuse2fs_open(struct fuse2fs *ff, int libext2_flags)
 	if (ff->directio)
 		flags |= EXT2_FLAG_DIRECT_IO;
 
+	dbg_printf(ff, "opening with flags=0x%x\n", flags);
+
 	err = ext2fs_open2(ff->device, options, flags, 0, 0, unix_io_manager,
 			   &ff->fs);
 	if (err == EPERM) {
@@ -6527,6 +6530,19 @@ static unsigned long long default_cache_size(void)
 	return ret;
 }
 
+#ifdef HAVE_FUSE_IOMAP
+static inline bool fuse2fs_discover_iomap(struct fuse2fs *ff)
+{
+	if (ff->iomap_want == FT_DISABLE)
+		return false;
+
+	ff->iomap_cap = fuse_lowlevel_discover_iomap();
+	return ff->iomap_cap & FUSE_IOMAP_SUPPORT_FILEIO;
+}
+#else
+# define fuse2fs_discover_iomap(...)	(false)
+#endif
+
 static inline bool fuse2fs_want_fuseblk(const struct fuse2fs *ff)
 {
 	if (ff->noblkdev)
@@ -6567,6 +6583,7 @@ int main(int argc, char *argv[])
 	errcode_t err;
 	FILE *orig_stderr = stderr;
 	char extra_args[BUFSIZ];
+	bool iomap_detected = false;
 	int ret;
 
 	ret = fuse_opt_parse(&args, &fctx, fuse2fs_opts, fuse2fs_opt_proc);
@@ -6637,7 +6654,8 @@ int main(int argc, char *argv[])
 		goto out;
 	}
 
-	if (fuse2fs_want_fuseblk(&fctx)) {
+	iomap_detected = fuse2fs_discover_iomap(&fctx);
+	if (!iomap_detected && fuse2fs_want_fuseblk(&fctx)) {
 		/*
 		 * If this is a block device, we want to close the fs, reopen
 		 * the block device in non-exclusive mode, and start the fuse
diff --git a/misc/fuse4fs.c b/misc/fuse4fs.c
index e08c5af5abfd27..3bb6140b35570e 100644
--- a/misc/fuse4fs.c
+++ b/misc/fuse4fs.c
@@ -270,6 +270,7 @@ struct fuse4fs {
 	enum fuse4fs_feature_toggle iomap_want;
 	enum fuse4fs_iomap_state iomap_state;
 	uint32_t iomap_dev;
+	uint64_t iomap_cap;
 #endif
 	unsigned int blockmask;
 	unsigned long offset;
@@ -1233,6 +1234,8 @@ static errcode_t fuse4fs_open(struct fuse4fs *ff, int libext2_flags)
 	if (ff->directio)
 		flags |= EXT2_FLAG_DIRECT_IO;
 
+	dbg_printf(ff, "opening with flags=0x%x\n", flags);
+
 	err = ext2fs_open2(ff->device, options, flags, 0, 0, unix_io_manager,
 			   &ff->fs);
 	if (err == EPERM) {
@@ -6862,6 +6865,19 @@ static unsigned long long default_cache_size(void)
 	return ret;
 }
 
+#ifdef HAVE_FUSE_IOMAP
+static inline bool fuse4fs_discover_iomap(struct fuse4fs *ff)
+{
+	if (ff->iomap_want == FT_DISABLE)
+		return false;
+
+	ff->iomap_cap = fuse_lowlevel_discover_iomap();
+	return ff->iomap_cap & FUSE_IOMAP_SUPPORT_FILEIO;
+}
+#else
+# define fuse4fs_discover_iomap(...)	(false)
+#endif
+
 static inline bool fuse4fs_want_fuseblk(const struct fuse4fs *ff)
 {
 	if (ff->noblkdev)
@@ -7002,6 +7018,7 @@ int main(int argc, char *argv[])
 	errcode_t err;
 	FILE *orig_stderr = stderr;
 	char extra_args[BUFSIZ];
+	bool iomap_detected = false;
 	int ret;
 
 	ret = fuse_opt_parse(&args, &fctx, fuse4fs_opts, fuse4fs_opt_proc);
@@ -7072,7 +7089,8 @@ int main(int argc, char *argv[])
 		goto out;
 	}
 
-	if (fuse4fs_want_fuseblk(&fctx)) {
+	iomap_detected = fuse4fs_discover_iomap(&fctx);
+	if (!iomap_detected && fuse4fs_want_fuseblk(&fctx)) {
 		/*
 		 * If this is a block device, we want to close the fs, reopen
 		 * the block device in non-exclusive mode, and start the fuse


