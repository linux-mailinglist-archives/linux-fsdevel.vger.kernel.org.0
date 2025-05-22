Return-Path: <linux-fsdevel+bounces-49645-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBECAC0131
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 02:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 895769E57C1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 00:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1546A1FC3;
	Thu, 22 May 2025 00:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F5gv5yWB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723B2645;
	Thu, 22 May 2025 00:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747872808; cv=none; b=UXIWQ/gGDwNxzZPG0uVR2fRuHyho6QhD3sy1YRrnMMQlgeOuam8LAoxRjzzB0atFLRpXJHjlCaIMrUqXlklpcK2CuzjlJz8p9/bqSbUZ5S2FOBz+qn7mqDfrlUV2LQBlWfuzt4Jh39DiJieV1ajJL2IlEIVtITSE/bKs9BVsiy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747872808; c=relaxed/simple;
	bh=56uq7N9VFKakuRkuIPK+TagxykRRN5cxybVhPd3GLbA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mw6ZmFiNmZXT4RZNvtfdlfCtKBpPtXGrJ4tbowfEh+lQ09bPIkKSD+Ci90RH3CGFQsl/t0v6OpShAqDup+TsGRf/9BchODXciAtGpQDZwIqrm+KK4qDzSqT7u0Rh/7ePyAh3MTapG8SciFJIQVPfg22Vw9AxcCAP5YiJ6xHxHgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F5gv5yWB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6E43C4CEE4;
	Thu, 22 May 2025 00:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747872807;
	bh=56uq7N9VFKakuRkuIPK+TagxykRRN5cxybVhPd3GLbA=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=F5gv5yWBw0HtVnv4fiARl3W547QkFP+Zf7ukbR0SOutJKwB/pqz9zpQzVYg+PTbSg
	 hKGOtyTXmTWxVVcMDbbufI9kcEH24TcQ5Ip0ETBCL8ccH+gZrsTN19+pFbSq8kKuSJ
	 hZEdox3hXBxpZzmSpsRrB7LeFcWoWwjnB1bw5eZdtVtFWsMDwQ6GztnNNwy+UogXzt
	 HtQN7uU9ns8DPWJW4AADaMcRmdR5e8aNShm/wmqaIBcGf24kHlCSbnA7e39S7lm8bJ
	 3N3UUkSnNedOxn6G4ookTXi7kjyRdZ1s++M1rbx0CK7oAJrhJhyYcDuYbPvBf5Rgyp
	 vPlWVQxC7un0w==
Date: Wed, 21 May 2025 17:13:27 -0700
Subject: [PATCH 10/16] fuse2fs: flush and invalidate the buffer cache on trim
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, linux-ext4@vger.kernel.org, miklos@szeredi.hu,
 joannelkoong@gmail.com, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org
Message-ID: <174787198613.1484996.8155825438670079197.stgit@frogsfrogsfrogs>
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

Discard operates directly on the storage device, which means that we
need to flush and invalidate the buffer cache because it could be
caching freed blocks whose contents are about to change.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 7152979ed6694e..219d4bf698d628 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -4365,6 +4365,11 @@ static int ioctl_fitrim(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 	cleared = 0;
 	max_blocks = FUSE2FS_B_TO_FSBT(ff, 2048ULL * 1024 * 1024);
 
+	/* flush any dirty data out of the disk cache before trimming */
+	err = io_channel_flush_tag(ff->fs->io, IO_CHANNEL_TAG_NULL);
+	if (err)
+		return translate_error(fs, fh->ino, err);
+
 	fr->len = 0;
 	while (start <= end) {
 		err = ext2fs_find_first_zero_block_bitmap2(fs->block_map,
@@ -4394,6 +4399,16 @@ static int ioctl_fitrim(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 		}
 		start = b + 1;
 	}
+	if (err)
+		goto out;
+
+	/*
+	 * Invalidate the entire disk cache now that we've written zeroes so
+	 * that EXT2_ALLOCRANGE_ZERO_BLOCKS works correctly.
+	 */
+	err = io_channel_invalidate_tag(ff->fs->io, IO_CHANNEL_TAG_NULL);
+	if (err)
+		return translate_error(fs, fh->ino, err);
 
 out:
 	fr->len = cleared;


