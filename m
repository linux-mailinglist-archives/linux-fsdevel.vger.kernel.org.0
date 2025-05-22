Return-Path: <linux-fsdevel+bounces-49638-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B97FAC0124
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 02:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B75349E5F56
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 00:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623E81FC3;
	Thu, 22 May 2025 00:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4TUVJuv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF764195;
	Thu, 22 May 2025 00:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747872698; cv=none; b=c3OSXXVuFVkI8zSnt+GL3eT0nv7M8vQ/DIIOkh4v+ejecoEYgxMYpLUxrLBmtEuq9ZgEL/PGReUENvqd5dc8I9ZbfV+JKuFU1YtDeFvUm102A2NBQ0fItGwwX+XRuzHeoQMuwG/yyrqGamTLFWbDEq+4JIg4iGKvRoqRz3JcAwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747872698; c=relaxed/simple;
	bh=+X64KxwxqyK1KxIOxSIfevNUyJhYmX2zelSnJ3GwwgI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dMVITQpYM2jAkAiABu6nK1yD/pksz6SKEal1E4051n0jyHrdNealo+H5ANXLohETRaKW1EOuy3xlPxHpfc4u/QUN2zMG3PAmARwxyziTJjNwcMSHOMslWPoRFIpFPJ3mlvN5hcRfB1umpEszH7o7EFmAnOaa70aBXOD9sVm2vbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q4TUVJuv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 387A0C4CEE4;
	Thu, 22 May 2025 00:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747872698;
	bh=+X64KxwxqyK1KxIOxSIfevNUyJhYmX2zelSnJ3GwwgI=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Q4TUVJuvDpaWVGOG0SYQLYxAUuSWDoT5JABfiBYWBKx/kPDRx7kBa1n4r9cuNPd0U
	 sUmVQEbTB7tChbt1fb9MrPP+SUgzBAzzlenMUxAt3auYI4liHJhgA3bbTQM+mxM6+D
	 zP4oun8ETfZg0GpPNQqvKqwLgwIHhEB8Kp67SFYtZSmsapmOrJcXrzCtql0nmVDicE
	 xFm8RpzAmkfNUVUvV5CoyZ9zqi51vF6tw26uDjNFi2aJAUNeol54VtyQTeeG8ze8nX
	 X1U9d7VGU3eL6W6NXyn+lPcypT2wu5YB9mnSDh7nuLtyrV//p6X1RYulZpWJTPFTNl
	 AL5EssyLucQBA==
Date: Wed, 21 May 2025 17:11:37 -0700
Subject: [PATCH 03/16] fuse2fs: always use directio disk reads with fuse2fs
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, linux-ext4@vger.kernel.org, miklos@szeredi.hu,
 joannelkoong@gmail.com, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org
Message-ID: <174787198487.1484996.12546102480862938973.stgit@frogsfrogsfrogs>
In-Reply-To: <174787198370.1484996.3340565971108603226.stgit@frogsfrogsfrogs>
References: <174787198370.1484996.3340565971108603226.stgit@frogsfrogsfrogs>
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
 misc/fuse2fs.c |   26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 92a80753f4f1e8..91c0da096bef9c 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -988,8 +988,14 @@ static errcode_t confirm_iomap(struct fuse_conn_info *conn, struct fuse2fs *ff)
 
 	return 0;
 }
+
+static int iomap_enabled(const struct fuse2fs *ff)
+{
+	return ff->iomap_state == IOMAP_ENABLED;
+}
 #else
 # define confirm_iomap(...)	(0)
+# define iomap_enabled(...)	(0)
 #endif
 
 static void *op_init(struct fuse_conn_info *conn
@@ -1001,6 +1007,9 @@ static void *op_init(struct fuse_conn_info *conn
 	struct fuse_context *ctxt = fuse_get_context();
 	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
 	ext2_filsys fs = ff->fs;
+#ifdef HAVE_FUSE_IOMAP
+	int was_directio = ff->directio;
+#endif
 	errcode_t err;
 	int ret;
 
@@ -1023,6 +1032,15 @@ static void *op_init(struct fuse_conn_info *conn
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
+	if (iomap_enabled(ff))
+		ff->directio = 1;
 #endif
 
 #if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
@@ -1038,6 +1056,14 @@ static void *op_init(struct fuse_conn_info *conn
 	 */
 	if (!fs) {
 		err = open_fs(ff, 0);
+#ifdef HAVE_FUSE_IOMAP
+		if (err && iomap_enabled(ff) && !was_directio) {
+			fuse_unset_feature_flag(conn, FUSE_CAP_IOMAP);
+			ff->iomap_state = IOMAP_DISABLED;
+			ff->directio = 0;
+			err = open_fs(ff, 0);
+		}
+#endif
 		if (err)
 			goto mount_fail;
 		fs = ff->fs;


