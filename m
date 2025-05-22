Return-Path: <linux-fsdevel+bounces-49649-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4650AC013A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 02:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E3C71BC462D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 00:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454F020EB;
	Thu, 22 May 2025 00:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uMTuNC2C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B6F195;
	Thu, 22 May 2025 00:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747872870; cv=none; b=JGnHJiLLvWXeLdam+mDAA4RqDolQR3J1CiD+dgQshNCWdNfQcxbdOnMNkAfveQuzVAwD4Dbk+g6vBzgGKwfM8XzoYWZMze18KSy2ddvjgXlUDfsuODvWhFDRh55zT488iOlI9VJy9dk7jalqzGprWSTdYgGjAteGK815iIyzFi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747872870; c=relaxed/simple;
	bh=a532W/rNQCX7Cfu+ss6qDWhXjYevMqZji2QXzrq2+54=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hmE/ORQAPqiCN9R99YHNkL7vA8adZiKzCtfidp6vh+qGL2kshpIVcY3IqAQWEG8VLlALS7p3EflgBow34BS2XDE5PkRE23ftQLz67QuGg4JZLuFR+DNqwaoyEDid9ylDTNpYhIsM8eAUikJPNanbYObf7dpbdSh83GGB1K1mFGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uMTuNC2C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75D99C4CEE4;
	Thu, 22 May 2025 00:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747872870;
	bh=a532W/rNQCX7Cfu+ss6qDWhXjYevMqZji2QXzrq2+54=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=uMTuNC2CzGUwwWdn4c6x7WGPYDzYJu4UHHBrSYMorqcSiXhRBS0QbUTlKjr1KjmfV
	 yhRPzu+cpAGeqfkk0SbewBJXRvjAsFulKp8goTCtKmVl5MaMJxW64+zSdVl0J5LHs7
	 kMbEtQ6tC2OJtQ5PZb/jGuJ7EmMmLlx3MEUld/QfJyjl7jKP7sBre7txxyf9rOGKbz
	 yXDbJILA65DI2G5HfJgMP+JuuCd5vmQ5isL3To8G7Ti/MHnL8uyCI06lxeRANc3sOC
	 4JG+k0hCmGCnpZsGx+UwWHtqnNlN7Rahy67POBNEIQQgtC1pEintfeCfjcW1kJwIBp
	 yUIIsB0FSylFw==
Date: Wed, 21 May 2025 17:14:30 -0700
Subject: [PATCH 14/16] fuse2fs: disable most io channel flush/invalidate in
 iomap pagecache mode
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, linux-ext4@vger.kernel.org, miklos@szeredi.hu,
 joannelkoong@gmail.com, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org
Message-ID: <174787198686.1484996.7993409438926165203.stgit@frogsfrogsfrogs>
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

Now that fuse2fs uses iomap for pagecache IO, all regular file IO goes
directly to the disk.  There is no need to flush the unix IO manager's
disk cache (or invalidate it) because it does not contain file data.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 842ea3a191fa44..ba8c5f301625c6 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -5091,9 +5091,11 @@ static int fuse_iomap_begin_read(struct fuse2fs *ff, ext2_ino_t ino,
 		return -ENOSYS;
 
 	/* flush dirty io_channel buffers to disk before iomap reads them */
-	err = io_channel_flush_tag(ff->fs->io, ino);
-	if (err)
-		return translate_error(ff->fs, ino, err);
+	if (!iomap_does_fileio(ff)) {
+		err = io_channel_flush_tag(ff->fs->io, ino);
+		if (err)
+			return translate_error(ff->fs, ino, err);
+	}
 
 	if (inode->i_flags & EXT4_EXTENTS_FL)
 		return extent_iomap_begin(ff, ino, inode, pos, count, opflags,
@@ -5188,9 +5190,11 @@ static int fuse_iomap_begin_write(struct fuse2fs *ff, ext2_ino_t ino,
 	 * flush and invalidate the file's io_channel buffers before iomap
 	 * writes them
 	 */
-	err = io_channel_invalidate_tag(ff->fs->io, ino);
-	if (err)
-		return translate_error(ff->fs, ino, err);
+	if (!iomap_does_fileio(ff)) {
+		err = io_channel_invalidate_tag(ff->fs->io, ino);
+		if (err)
+			return translate_error(ff->fs, ino, err);
+	}
 
 	return 0;
 }
@@ -5685,7 +5689,7 @@ static int op_iomap_ioend(const char *path, uint64_t nodeid, uint64_t attr_ino,
 	 * flush and invalidate the file's io_channel buffers again now that
 	 * iomap wrote them
 	 */
-	if (written > 0) {
+	if (written > 0 && !iomap_does_fileio(ff)) {
 		err = io_channel_invalidate_tag(ff->fs->io, attr_ino);
 		if (err) {
 			ret = translate_error(ff->fs, attr_ino, err);


