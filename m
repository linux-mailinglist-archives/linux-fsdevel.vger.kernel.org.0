Return-Path: <linux-fsdevel+bounces-49647-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 073D3AC0135
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 02:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B754D1754A6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 00:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5066220EB;
	Thu, 22 May 2025 00:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AAo8fr1M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD994645;
	Thu, 22 May 2025 00:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747872839; cv=none; b=jlUwziuYhCEUktdbgWJkEEcRbi6w0093fzbNYuUSBOVWP+y1FifxNYUpqWe5JfUpSOwC1oOFEz62RuwFKVFO/Agedw7Qtqqe0KPsBXoqsuskzU3K3JnBsOly/G/O+ZAhAbOdeoPJLZFmOMztyFb4VnGB+RRHZ6gVFpabswQvqYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747872839; c=relaxed/simple;
	bh=4rTBwj2G+OOxK0L03pdQyhHCJqYHyigQifWTR/ttz8U=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rpoZifl+hdyNoCYTuLdR7epIXlAJ8Wf3Tlc8EEriEe7V+6TVklirgWwTodz0Rb+RFm0eJSRFOfJfhk1c+lh1MtIsQ84tBVXAhx8J+VuZbeUx3o03HfdqDo2kVmVTrFZh6F90oMARhb7BI1K6WAgGAJIs4mLDNYYphRhfMFHdLJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AAo8fr1M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E80DC4CEE4;
	Thu, 22 May 2025 00:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747872839;
	bh=4rTBwj2G+OOxK0L03pdQyhHCJqYHyigQifWTR/ttz8U=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=AAo8fr1MyIzk/jd2/2eHn5IyiJBwD9w3ccXIfuOQM7L1TuWNKVj9aipBl4O0Q7S3s
	 M/5W4Nz6u2Gw0xOg8CyFPdVz7TYFo2R3DSCup6UVv8+FHheE40VDFzC+ZNkjQMmb3t
	 T5c3A+WebtADw41uYLR6Eff4HiIp3lnu5iBBhWQY07AsbtYC2rmiqDzgn9MFZQpIIc
	 2YsnQpHLhID8//7+rGqo3x7r4E1/GqKVf4nHSy35xs2FwUprb3+m+taV1jVs7YCIig
	 7GJsMqOE65NWqJvuF59kjLrM1pGiFT3zy1U9YDqQGtdHNSTfMBtHvdoJxLjuU27Cj/
	 qLVNEJAK/VbNg==
Date: Wed, 21 May 2025 17:13:58 -0700
Subject: [PATCH 12/16] fuse2fs: don't zero bytes in punch hole
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, linux-ext4@vger.kernel.org, miklos@szeredi.hu,
 joannelkoong@gmail.com, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org
Message-ID: <174787198650.1484996.5639277239335638587.stgit@frogsfrogsfrogs>
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

When iomap is in use for the pagecache, it will take care of zeroing the
unaligned parts of punched out regions so we don't have to do it
ourselves.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index fe6d97324c1f57..aeb2b6fbc28401 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -152,6 +152,7 @@ enum fuse2fs_iomap_state {
 	IOMAP_DISABLED,
 	IOMAP_UNKNOWN,
 	IOMAP_ENABLED,
+	IOMAP_FILEIO,	/* enabled and does all file data block IO */
 };
 #endif
 
@@ -1040,6 +1041,7 @@ static errcode_t confirm_iomap(struct fuse_conn_info *conn, struct fuse2fs *ff)
 		/* fallthrough */;
 	case IOMAP_DISABLED:
 		return 0;
+	case IOMAP_FILEIO:
 	case IOMAP_ENABLED:
 		break;
 	}
@@ -1059,11 +1061,17 @@ static errcode_t confirm_iomap(struct fuse_conn_info *conn, struct fuse2fs *ff)
 
 static int iomap_enabled(const struct fuse2fs *ff)
 {
-	return ff->iomap_state == IOMAP_ENABLED;
+	return ff->iomap_state >= IOMAP_ENABLED;
+}
+
+static int iomap_does_fileio(const struct fuse2fs *ff)
+{
+	return ff->iomap_state == IOMAP_FILEIO;
 }
 #else
 # define confirm_iomap(...)	(0)
 # define iomap_enabled(...)	(0)
+# define iomap_does_fileio(...)	(0)
 #endif
 
 static void *op_init(struct fuse_conn_info *conn
@@ -1100,6 +1108,20 @@ static void *op_init(struct fuse_conn_info *conn
 	if (ff->iomap_state != IOMAP_DISABLED &&
 	    fuse_set_feature_flag(conn, FUSE_CAP_IOMAP))
 		ff->iomap_state = IOMAP_ENABLED;
+
+	/*
+	 * If iomap is turned on and the kernel advertises support for both
+	 * direct and pagecache IO, then that means the kernel handles all
+	 * regular file data block IO for us.  That means we can turn off all
+	 * of libext2fs' file data block handling except for inline data.
+	 *
+	 * XXX: kernel doesn't support inline data iomap
+	 */
+	if (iomap_enabled(ff) &&
+	    fuse_get_feature_flag(conn, FUSE_CAP_IOMAP_DIRECTIO) &&
+	    fuse_get_feature_flag(conn, FUSE_CAP_IOMAP_PAGECACHE))
+		ff->iomap_state = IOMAP_FILEIO;
+
 	/*
 	 * In iomap mode, the kernel writes file data directly to the block
 	 * device and does not flush the bdev page cache.  We must open the
@@ -4580,6 +4602,10 @@ static errcode_t clean_block_middle(struct fuse2fs *ff, ext2_ino_t ino,
 	int retflags;
 	errcode_t err;
 
+	/* the kernel does this for us in iomap mode */
+	if (iomap_does_fileio(ff))
+		return 0;
+
 	residue = FUSE2FS_OFF_IN_FSB(ff, offset);
 	if (residue == 0)
 		return 0;
@@ -4617,6 +4643,10 @@ static errcode_t clean_block_edge(struct fuse2fs *ff, ext2_ino_t ino,
 	off_t residue;
 	errcode_t err;
 
+	/* the kernel does this for us in iomap mode */
+	if (iomap_does_fileio(ff))
+		return 0;
+
 	residue = FUSE2FS_OFF_IN_FSB(ff, offset);
 	if (residue == 0)
 		return 0;


