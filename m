Return-Path: <linux-fsdevel+bounces-55380-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8CEB0985F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A58824A6F11
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879FD241667;
	Thu, 17 Jul 2025 23:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UF1k+gy4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F53BE46;
	Thu, 17 Jul 2025 23:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752795814; cv=none; b=Ri3VImbLn9a0diNvbTsmNf2L6yjmb2SLGA8DdUCeWKwwde7yQv4oCogWArAXspt/BDHxfLScRayLi2FPHMflaAccltRs+NWOePtr2jswb0xcOtVrFlBkyPg2kocySpGWO7nnH04NKLaWzA1kHBAYQdco00LIbF8iykTa56U48bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752795814; c=relaxed/simple;
	bh=BdUtnyzaf5PZ7TwbWK+wkNh0vXpBRjoT3bajKUes8dg=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QlxedqjNjLaPbGM1m1ho+PaqUFZIaVQvvUqLpvdkxhcq1I4PPEq9OTbQ+ZgPaLtj7/ABoEE3YkIlAo4Uj4Mo8OT9ia5CsC3K136viJQqIB+qSzrGfrog3h34ss396EnFxq9hYJyXh6l0l2lcR1mTYAdDITNlJfyupVdtFPUqOSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UF1k+gy4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C221CC4CEE3;
	Thu, 17 Jul 2025 23:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752795813;
	bh=BdUtnyzaf5PZ7TwbWK+wkNh0vXpBRjoT3bajKUes8dg=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=UF1k+gy4qLEMeqQXJBQ9luQFX2lQDPNB03/t1S3DOrhjJ6qHjBj5ogIMEysCViC7s
	 XSFlv8VkF38t8IPHS0IxQDy61eYBVgiFU9S//3SniFrEUJDsxzJwG8YxtcpmNZwKCK
	 uw5XUlHDzQLVxT6P7V+HIhukUhy+FOtl/FT72dX/25Xh54z73qAEYoRBiZL+BJssKs
	 vi6A93zQAsgsEBgy4R2BwyfyXkH+c2FkZ8YNzV/rAlsmj7tDzFMkvGRQlN56PdZJpi
	 O8afcigSguJAGwrg8cjIp9EZTLK67Ch8wv6Kh+fK2zwTpjUJm/xF/QpKjpoxrsYhF+
	 QSvO+jmPvUSGA==
Date: Thu, 17 Jul 2025 16:43:33 -0700
Subject: [PATCH 16/22] fuse2fs: re-enable the block device pagecache for
 metadata IO
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: joannelkoong@gmail.com, miklos@szeredi.hu, John@groves.net,
 linux-fsdevel@vger.kernel.org, bernd@bsbernd.com, linux-ext4@vger.kernel.org,
 neal@gompa.dev
Message-ID: <175279461322.715479.12194821289069351679.stgit@frogsfrogsfrogs>
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
index 9604f06e69bc90..9a62971f8dbba7 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -1295,8 +1295,12 @@ static void *op_init(struct fuse_conn_info *conn
 	 * filesystem in directio mode to avoid cache coherency issues when
 	 * reading file data.  If we can't open the bdev in directio mode, we
 	 * must not use iomap.
+	 *
+	 * If we know that the kernel can handle all regular file IO for us,
+	 * then there is no cache coherency issue and we can use buffered reads
+	 * for all IO, which will all be filesystem metadata.
 	 */
-	if (fuse2fs_iomap_enabled(ff))
+	if (fuse2fs_iomap_enabled(ff) && !fuse2fs_iomap_does_fileio(ff))
 		ff->directio = 1;
 #endif
 


