Return-Path: <linux-fsdevel+bounces-55377-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC61B09859
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4440D7AAD45
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EFF241CAF;
	Thu, 17 Jul 2025 23:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8DeV+Zj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C8D1F0E32;
	Thu, 17 Jul 2025 23:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752795767; cv=none; b=pJb4iu6/aSwp6LnS7DCSINX5bhJ/LeqdfVdJtb1qh3kHPeooVqQuqgFiois69bMBeerxh+mdU4t7C9NBeSKcOg7JPCllLaOEgNS95WxOBH5nm258XeGCqDawUjQtn0s1SszsdcQcLuZGMsg2HYGhcR46uLp1gM94mzC/BUlWcdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752795767; c=relaxed/simple;
	bh=25eO5Fa4oYw7KHAjc1MqVH7oCSvZNOIRy6HJRUp/fBI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a0T7pc1ANQvg3q15Xpv1T1bHIbDGpGDxPrvlrQmaunDzsoScx7KEjkHxee3AX9joEYfHxE9dLJzFfkM9QZClRhLzgmITrpJb6AAxUR8VHxVLD10E9zJrqtcvb+2RqgTDyNF38EfOVDTR783XeOMONgzjmJbDCrsu415SoqhnONo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O8DeV+Zj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3500C4CEE3;
	Thu, 17 Jul 2025 23:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752795766;
	bh=25eO5Fa4oYw7KHAjc1MqVH7oCSvZNOIRy6HJRUp/fBI=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=O8DeV+Zj9zOnvK6sBzVnehBv+jP4wjdzi8J6tNYh9iTK/t+CjK4VaGEh4GSkyJZMi
	 iKfRXZM1jWFvCpBvjGduyW3tTPrkgeARHLlM20iy1h/dvWzE2L0K+zJ0CWVJ6x3WUr
	 RRr/bEDJ4/Sv2SuzPYrfN6aCvf8hSQFOe/OEZZIZw8rfNXKuetzdegNYHLkZEZHs13
	 tyLLsHYCjToNopDiXCBAmBL7t4jsvqvC28qzTm0qw8kmG0s9FX149OE7AUIm70a1zV
	 UtlRrfad5TxMny1OW4kORf5+73fSy4d3Wvhg20PnliFmSFZ2R4KybGCaBIo7I00WMb
	 09wbJIYILQLKg==
Date: Thu, 17 Jul 2025 16:42:45 -0700
Subject: [PATCH 13/22] fuse2fs: don't zero bytes in punch hole
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: joannelkoong@gmail.com, miklos@szeredi.hu, John@groves.net,
 linux-fsdevel@vger.kernel.org, bernd@bsbernd.com, linux-ext4@vger.kernel.org,
 neal@gompa.dev
Message-ID: <175279461268.715479.919606166251317155.stgit@frogsfrogsfrogs>
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

When iomap is in use for the pagecache, it will take care of zeroing the
unaligned parts of punched out regions so we don't have to do it
ourselves.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index f7d17737459c11..45eec59d85faf4 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -235,6 +235,7 @@ enum fuse2fs_iomap_state {
 	IOMAP_DISABLED,
 	IOMAP_UNKNOWN,
 	IOMAP_ENABLED,
+	IOMAP_FILEIO,	/* enabled and does all file data block IO */
 };
 #endif
 
@@ -494,8 +495,14 @@ static int fuse2fs_iomap_enabled(const struct fuse2fs *ff)
 {
 	return ff->iomap_state >= IOMAP_ENABLED;
 }
+
+static int fuse2fs_iomap_does_fileio(const struct fuse2fs *ff)
+{
+	return ff->iomap_state == IOMAP_FILEIO;
+}
 #else
 # define fuse2fs_iomap_enabled(...)	(0)
+# define fuse2fs_iomap_does_fileio(...)	(0)
 #endif
 
 static inline void fuse2fs_dump_extents(struct fuse2fs *ff, ext2_ino_t ino,
@@ -1219,6 +1226,7 @@ static void fuse2fs_iomap_confirm(struct fuse_conn_info *conn,
 		return;
 	case IOMAP_DISABLED:
 		return;
+	case IOMAP_FILEIO:
 	case IOMAP_ENABLED:
 		break;
 	}
@@ -1267,6 +1275,20 @@ static void *op_init(struct fuse_conn_info *conn
 	if (ff->iomap_state != IOMAP_DISABLED &&
 	    fuse_set_feature_flag(conn, FUSE_CAP_IOMAP))
 		ff->iomap_state = IOMAP_ENABLED;
+
+	/*
+	 * If iomap is turned on and the kernel advertises support for both
+	 * direct and buffered IO, then that means the kernel handles all
+	 * regular file data block IO for us.  That means we can turn off all
+	 * of libext2fs' file data block handling except for inline data.
+	 *
+	 * XXX: kernel doesn't support inline data iomap
+	 */
+	if (fuse2fs_iomap_enabled(ff) &&
+	    fuse_get_feature_flag(conn, FUSE_CAP_IOMAP_DIRECTIO) &&
+	    fuse_get_feature_flag(conn, FUSE_CAP_IOMAP_FILEIO))
+		ff->iomap_state = IOMAP_FILEIO;
+
 	/*
 	 * In iomap mode, the kernel writes file data directly to the block
 	 * device and does not flush the bdev page cache.  We must open the
@@ -4734,6 +4756,10 @@ static errcode_t clean_block_middle(struct fuse2fs *ff, ext2_ino_t ino,
 	int retflags;
 	errcode_t err;
 
+	/* the kernel does this for us in iomap mode */
+	if (fuse2fs_iomap_does_fileio(ff))
+		return 0;
+
 	if (!*buf) {
 		err = ext2fs_get_mem(fs->blocksize, buf);
 		if (err)
@@ -4767,6 +4793,10 @@ static errcode_t clean_block_edge(struct fuse2fs *ff, ext2_ino_t ino,
 	off_t residue;
 	errcode_t err;
 
+	/* the kernel does this for us in iomap mode */
+	if (fuse2fs_iomap_does_fileio(ff))
+		return 0;
+
 	residue = FUSE2FS_OFF_IN_FSB(ff, offset);
 	if (residue == 0)
 		return 0;


