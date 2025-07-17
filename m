Return-Path: <linux-fsdevel+bounces-55369-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B338B09844
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E7AD3A7D54
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5B22417E0;
	Thu, 17 Jul 2025 23:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+ewvXCq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC231FCFF8;
	Thu, 17 Jul 2025 23:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752795640; cv=none; b=jKhOiwR1f/X9su0zjFBfE+jWWg4x5QfLRBg/4HTbypD53O01gtDvGTANu5CAIxjzm48k9m9tHx4MiUYfrXlxssTcXyCDQVw2F+MHb96rch+g6nePyFpPHX0NdMi9fXXt1/iT6hE/kvEHBx0N5KvvavleQmaHj3yy/rhBecDzyQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752795640; c=relaxed/simple;
	bh=Ncbilzg8lpP20soMIovmeD7FbkhnRyhxPU5jHcUjNQE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wcxo+n44E3LGJ6x34Uvl+qswsQ/2ylE1Lg/5x7O0LZXd2+/fECI8Xae/U1t/Miwyq5k7ONlS4Jao6+pl7Sa1hZYEOS/O9A3k4wbIVwoFjwWsUcCMyIl4fEynZk3H3TSbA+gDlJTwbR3GMTKfKH1qK+u8gLiRYcMpieRWsuOn8vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+ewvXCq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CE26C4CEE3;
	Thu, 17 Jul 2025 23:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752795640;
	bh=Ncbilzg8lpP20soMIovmeD7FbkhnRyhxPU5jHcUjNQE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=V+ewvXCq+r9T7aOvsn8JcZaqJiqv170PIVwfXc0wLcfuSYax9IeHQPNG3cX48Lo12
	 dFrpQvm131PheYesDXq2Vz4gJhXMk87Ps7M0MTTlF7Kl6NUszWhtHkY/XzwF9rAtJq
	 4zdOpO1UdsfK03+tFr/FFof362hPQraOqjUXbzDvFSSHcb4fo2Pk5s6DX/2W49X0Q7
	 mpIS97sYeRuW1WkcK2cQodpPABqbqVHgfOSPnCrGq3knXW50NiMuUjtwyZxi11Oh0Q
	 ZeBXs90SwTWGQJ57uCwxOtAnapEiaCLb6wLkfYqD64Xy+UIcy6mXsdLEeUroUqkKFO
	 zY7YPLzzXsyXw==
Date: Thu, 17 Jul 2025 16:40:40 -0700
Subject: [PATCH 05/22] fuse2fs: always use directio disk reads with fuse2fs
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: joannelkoong@gmail.com, miklos@szeredi.hu, John@groves.net,
 linux-fsdevel@vger.kernel.org, bernd@bsbernd.com, linux-ext4@vger.kernel.org,
 neal@gompa.dev
Message-ID: <175279461123.715479.8914961804310412947.stgit@frogsfrogsfrogs>
In-Reply-To: <175279460935.715479.15460687085573767955.stgit@frogsfrogsfrogs>
References: <175279460935.715479.15460687085573767955.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

In iomap mode, the kernel writes file data directly to the block device
and does not flush the bdev page cache.  We must open the filesystem in
directio mode to avoid cache coherency issues when reading file data
blocks.  If we can't open the bdev in directio mode, we must not use
iomap.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 9eb067e1737054..72b9ec837209ca 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -1174,6 +1174,9 @@ static void *op_init(struct fuse_conn_info *conn
 	struct fuse_context *ctxt = fuse_get_context();
 	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
 	ext2_filsys fs = ff->fs;
+#ifdef HAVE_FUSE_IOMAP
+	int was_directio = ff->directio;
+#endif
 	errcode_t err;
 	int ret;
 
@@ -1196,6 +1199,15 @@ static void *op_init(struct fuse_conn_info *conn
 	if (ff->iomap_state != IOMAP_DISABLED &&
 	    fuse_set_feature_flag(conn, FUSE_CAP_IOMAP))
 		ff->iomap_state = IOMAP_ENABLED;
+	/*
+	 * In iomap mode, the kernel writes file data directly to the block
+	 * device and does not flush the bdev page cache.  We must open the
+	 * filesystem in directio mode to avoid cache coherency issues when
+	 * reading file data.  If we can't open the bdev in directio mode, we
+	 * must not use iomap.
+	 */
+	if (fuse2fs_iomap_enabled(ff))
+		ff->directio = 1;
 #endif
 
 #if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
@@ -1213,6 +1225,14 @@ static void *op_init(struct fuse_conn_info *conn
 	 */
 	if (!fs) {
 		err = fuse2fs_open(ff, 0);
+#ifdef HAVE_FUSE_IOMAP
+		if (err && fuse2fs_iomap_enabled(ff) && !was_directio) {
+			fuse_unset_feature_flag(conn, FUSE_CAP_IOMAP);
+			ff->iomap_state = IOMAP_DISABLED;
+			ff->directio = 0;
+			err = fuse2fs_open(ff, 0);
+		}
+#endif
 		if (err)
 			goto mount_fail;
 		fs = ff->fs;


