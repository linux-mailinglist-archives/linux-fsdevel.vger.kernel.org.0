Return-Path: <linux-fsdevel+bounces-49650-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E73AC014B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 02:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67CBF4A5380
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 00:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C419F9DA;
	Thu, 22 May 2025 00:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6KIUUMq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84D633F7;
	Thu, 22 May 2025 00:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747872886; cv=none; b=TARD/I8EQKTve4SMy6v+RoKARii8DjKBpChBDhJ40SuLfp4DFQqCqstv5T8tFOpkSYxL7/YAMciOt82/CKjnqEH0EQFx5xgab4+Bum/5JC0Fkel+H+3Dc64lNDhXMiZcWOwp9TQgPAIXouxwHwZJV2BilXy6p58dbjiIiTCDp/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747872886; c=relaxed/simple;
	bh=NCYx/eHU+pX2727lJvSlEJC0Nsbwl/yRs7wLiYZUYnk=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P/UMxiWbK32ZnKw4PGS/662Hyu01owkz6Iwy8OrsUF4OIfuhGOHDzN09rPm6XTnYV2tL6KZl0cH15ofhhhJ+QRrZt9eZjw6pumcdm/c5FW1XM8ZbRv7bb1EQl2m3rL/jjPc151qiCSGgmebmfgsFijS0vUYneRIEaxz5uKdCl1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b6KIUUMq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 191E0C4CEE4;
	Thu, 22 May 2025 00:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747872886;
	bh=NCYx/eHU+pX2727lJvSlEJC0Nsbwl/yRs7wLiYZUYnk=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=b6KIUUMq1DQdq6exAzn20x4okdjj5cqz0JppVRj6O+L0nF8jwCZCPEkVVWd0DaP4F
	 pLkTPEbnddWqGTlhIlM8WFaQT1CYPA7sCL9nUUtNBpEuwEzrRadZiuABtQ9S648RMZ
	 H8e7z9AMVErE+QLpxgTFfhgTfUK9uhVijLurNZyyHqlVZ9a6igtTPn6ylB9rm6dJOT
	 X+ttzERxz6qjc11kLo+pfwU5z+ydShZM94FM8tzIapySnSxBgc2Hs3yJDvWhXakXaK
	 Pu4iuSR+EIT5vuxeX99demmVTAkQz9HoIJ1+6nfugJYxXPZBApxc6vcB7S8R7rFHif
	 U8aPyWSBSzOsg==
Date: Wed, 21 May 2025 17:14:45 -0700
Subject: [PATCH 15/16] fuse2fs: re-enable the block device pagecache for
 metadata IO
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, linux-ext4@vger.kernel.org, miklos@szeredi.hu,
 joannelkoong@gmail.com, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org
Message-ID: <174787198704.1484996.5526860565441150226.stgit@frogsfrogsfrogs>
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

Back in "fuse2fs: always use directio disk reads with fuse2fs", we
started using directio for all libext2fs disk IO to deal with cache
coherency issues between the unix io manager's disk cache, the block
device page cache, and the file data blocks being read and written to
disk by the kernel itself.

Now that we've turned off all regular file data block IO in libext2fs,
we don't need that and can go back to the old way, which is a lot
faster for metadata operations.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index ba8c5f301625c6..f31aee5af5aad9 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -1128,8 +1128,12 @@ static void *op_init(struct fuse_conn_info *conn
 	 * filesystem in directio mode to avoid cache coherency issues when
 	 * reading file data.  If we can't open the bdev in directio mode, we
 	 * must not use iomap.
+	 *
+	 * If we know that the kernel can handle all regular file IO for us,
+	 * then there is no cache coherency issue and we can use buffered reads
+	 * for all IO, which will all be filesystem metadata.
 	 */
-	if (iomap_enabled(ff))
+	if (iomap_enabled(ff) && !iomap_does_fileio(ff))
 		ff->directio = 1;
 #endif
 


