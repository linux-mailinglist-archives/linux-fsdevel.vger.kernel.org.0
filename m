Return-Path: <linux-fsdevel+bounces-55370-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04789B0984A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 472A9566857
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FE2244690;
	Thu, 17 Jul 2025 23:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWdSk+Rr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A333235072;
	Thu, 17 Jul 2025 23:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752795656; cv=none; b=rA+Du8cHwF3CP6oTh+B7XqI6nldqW7pBRfHzTHXVEqIKZd+CVDkVCnFD3PLuxshCy2J7W0RXk9Do6/k3v9AdZRUSMtVbaeWdxSJikwcY9+9E8pY1O4p9H/846/3EwwjwhMEQuHjSc/WijqA5gw/rtwStIn8DabC0+JMRyEEgo94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752795656; c=relaxed/simple;
	bh=j85FB9m2aRVIX2Y800k8rVHD2cH09P7Idx3M1VuMENI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HUKR4DI0jnY2g2u1BKzWdUmQCvFUuJjxobrJLIFjIe13XwD37KUXlsxbkbVUW1UzMFrnZwQWqB/6vjphsKfEQUlOlkv7Yt+s0uGsHWouETOd5uvuU4e4dDOSuw8Dt8PZ7fiDY+df2ygj47nAZBEm10TlK/g7tCI9MAk0oXoXDXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KWdSk+Rr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32198C4CEE3;
	Thu, 17 Jul 2025 23:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752795656;
	bh=j85FB9m2aRVIX2Y800k8rVHD2cH09P7Idx3M1VuMENI=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=KWdSk+Rru+Y/S05Ojqr/9JS+eeG0uLFCrtAjZ8oPOiYL7v3CGNLW0WQG9uGpU7Itz
	 9ALKtdOTjSUntw74rl7KeHThSjEaQ3KNAXgYPcQ1nVBXOsVQXE9UcouvtxTm830Npt
	 D97zcJwe6ZV8FEgltyDtzoNV7UVM6w8mH47JRqp/qM6gBltWv01pDjxSUJ475EpkzF
	 1wajs912vQlv83jBJYrcKFeJUpcmSkBDUKks85oLKB8DYOwln2fsKsRI2qAyiB9nma
	 f6tpe0PKuTsHP5kKv/rSCen+gAahRpjiEvYhcg8CkE84Q9qUFYnynBIGHyMFy++omV
	 JNXePGDOuyAFw==
Date: Thu, 17 Jul 2025 16:40:55 -0700
Subject: [PATCH 06/22] fuse2fs: implement directio file reads
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: joannelkoong@gmail.com, miklos@szeredi.hu, John@groves.net,
 linux-fsdevel@vger.kernel.org, bernd@bsbernd.com, linux-ext4@vger.kernel.org,
 neal@gompa.dev
Message-ID: <175279461142.715479.13903075510416571519.stgit@frogsfrogsfrogs>
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

Implement file reads via iomap.  Currently only directio is supported.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 72b9ec837209ca..209858aeb9307c 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -1274,6 +1274,10 @@ static void *op_init(struct fuse_conn_info *conn
 		goto mount_fail;
 	}
 #endif
+#if defined(HAVE_FUSE_IOMAP) && defined(FUSE_CAP_IOMAP_DIRECTIO)
+	if (fuse2fs_iomap_enabled(ff))
+		fuse_set_feature_flag(conn, FUSE_CAP_IOMAP_DIRECTIO);
+#endif
 
 	/*
 	 * If we're mounting in iomap mode, we need to unmount in op_destroy
@@ -5165,7 +5169,26 @@ static int fuse2fs_iomap_begin_read(struct fuse2fs *ff, ext2_ino_t ino,
 				    uint64_t count, uint32_t opflags,
 				    struct fuse_iomap *read_iomap)
 {
-	return -ENOSYS;
+	errcode_t err;
+
+	if (!(opflags & FUSE_IOMAP_OP_DIRECT))
+		return -ENOSYS;
+
+	/* fall back to slow path for inline data reads */
+	if (inode->i_flags & EXT4_INLINE_DATA_FL)
+		return -ENOSYS;
+
+	/* flush dirty io_channel buffers to disk before iomap reads them */
+	err = io_channel_flush(ff->fs->io);
+	if (err)
+		return translate_error(ff->fs, ino, err);
+
+	if (inode->i_flags & EXT4_EXTENTS_FL)
+		return fuse2fs_iomap_begin_extent(ff, ino, inode, pos, count,
+						  opflags, read_iomap);
+
+	return fuse2fs_iomap_begin_indirect(ff, ino, inode, pos, count,
+					    opflags, read_iomap);
 }
 
 static int fuse2fs_iomap_begin_write(struct fuse2fs *ff, ext2_ino_t ino,


