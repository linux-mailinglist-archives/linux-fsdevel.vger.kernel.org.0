Return-Path: <linux-fsdevel+bounces-55388-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F19B09881
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1843A1C4402B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C96A242935;
	Thu, 17 Jul 2025 23:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j2X843Lq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C22219313;
	Thu, 17 Jul 2025 23:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752795939; cv=none; b=p7S2IMFFk4uzRY36FWt64CRtSY4YpYvxTX0g4R3ED2uIBw1iSAZfEAnsvZZb33FHunIBaaBCtriprOL8WK404QEywOCaeeT+fpr9aXqw3zz+LMMBxtAzKIRQnJOTX4AXIrjzZitfdz76GC2Mvirz8y4aMmWzk8pcqf+5oWmTbp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752795939; c=relaxed/simple;
	bh=R6/DhdmRqAtqQai50PYCPNbHhmmpjeuTVZqWGl41m/M=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xeuk7nuGZOBx8eViW0rravhqyoaHC9cIImSt2fEKorkL5bcHCX4RgFwjgUVgFwFhRNmNfHGFu9YbXOejNbOZB3ei6HTuIBynkY5/ISGaoaQPJsVt4/baZO8QQrDxLyCXpp6dNgeQzd3sJbdHF6zg65ZbO8VYA13agUpLUNDWrW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j2X843Lq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B2BFC4CEE3;
	Thu, 17 Jul 2025 23:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752795939;
	bh=R6/DhdmRqAtqQai50PYCPNbHhmmpjeuTVZqWGl41m/M=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=j2X843LqPCU14cYTvjvCVZqEM2CcnnxOeGJRHJt90gsPuTq0KBRqZDEd+IDhr0fqx
	 BjcwD5DCTCZudlJDUv7R8i2itYcOegdKiLjVkxWKCM408pp/VvYM+O6HmjvjAc4ww1
	 OkY+Hm/kl/Cw1EUx2WGikq1e35qALwpdb8rh4XQAZItwuySfdjGCTHrMz+xa0cjeQW
	 D6KoLDypHNLU1FPQ94wwFxLtaL/iS2AJ4GAetvewRVz89Vxr0zTCGHXRTFn2fXqqZe
	 SiDRkC8pnfO4LLjcL1nLYCmbRbvQmsmrDuiPy1Nv29NHJf/TET8Gg+OaOroNGzMvNj
	 RjxnblAqyaXBg==
Date: Thu, 17 Jul 2025 16:45:38 -0700
Subject: [PATCH 01/10] fuse2fs: allow O_APPEND and O_TRUNC opens
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: joannelkoong@gmail.com, miklos@szeredi.hu, John@groves.net,
 linux-fsdevel@vger.kernel.org, bernd@bsbernd.com, linux-ext4@vger.kernel.org,
 neal@gompa.dev
Message-ID: <175279461737.716436.10797569088655850505.stgit@frogsfrogsfrogs>
In-Reply-To: <175279461680.716436.11923939115339176158.stgit@frogsfrogsfrogs>
References: <175279461680.716436.11923939115339176158.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Commit 9f69dfc4e275cc didn't quite get the permissions checking correct:

generic/362       - output mismatch (see /var/tmp/fstests/generic/362.out.bad)
    --- tests/generic/362.out   2025-04-30 16:20:44.563833050 -0700
    +++ /var/tmp/fstests/generic/362.out.bad    2025-06-11 17:04:24.061193618 -0700
    @@ -1,2 +1,3 @@
     QA output created by 362
    +Failed to open/create file: Operation not permitted
     Silence is golden
    ...
    (Run 'diff -u /run/fstests/bin/tests/generic/362.out /var/tmp/fstests/generic/362.out.bad'  to see the entire diff)

The kernel allows opening a file for append and truncation.  What it
doesn't allow is opening an append-only file for truncation.  Note that
this causes generic/079 to regress, but the root cause of that problem
is actually that fuse oddly supports FS_IOC_[GS]ETFLAGS but doesn't
actually set the VFS inode flags.

Fixes: 9f69dfc4e275cc ("fuse2fs: implement O_APPEND correctly")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index f863042a4db074..f9151ae6acb4e5 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -3254,15 +3254,8 @@ static int __op_open(struct fuse2fs *ff, const char *path,
 	/* the kernel handles all block IO for us in iomap mode */
 	if (fuse2fs_iomap_does_fileio(ff))
 		file->open_flags |= EXT2_FILE_NOBLOCKIO;
-	if (fp->flags & O_APPEND) {
-		/* the kernel doesn't allow truncation of an append-only file */
-		if (fp->flags & O_TRUNC) {
-			ret = -EPERM;
-			goto out;
-		}
-
+	if (fp->flags & O_APPEND)
 		check |= A_OK;
-	}
 
 	detect_linux_executable_open(fp->flags, &check, &file->open_flags);
 


