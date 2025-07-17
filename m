Return-Path: <linux-fsdevel+bounces-55389-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6466B0987F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A3773AF2BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8D7241CAF;
	Thu, 17 Jul 2025 23:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kNkOY370"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281B9219313;
	Thu, 17 Jul 2025 23:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752795955; cv=none; b=rmyG3iQIIMPq4jsdBk+ngYoo/9ahgkXbVI4vLFmvc42wQYdlXhBA0NF9ff+2MlncnBvWZbDq+1dMoo4Ie7j+3Yk5b8HWnHFiu+HgblTK0rRWX/taU1u5BVsgMdQjwhp+DBcE6bNL5NT5R39VinxE6eHyAydMim9bDtgCnn3IabE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752795955; c=relaxed/simple;
	bh=FHLINl1DZS36+/aS7+Y+rW9XOVpqobZcCBImVb5SBi4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZRkobRirNvn7tp9olGtBs0xp+bXxCx66Gp+yzOU4SkkHUfspC1h1ShX9iAuWPZBN26M/sW0xai97OnAO7uET6Qnn9HR7Ts4pWMaewlOoxhyUBeVsXwx2xwjmAMe/O7iNAHB0JC2CBNi6GgRCIRxde05Hj/cB1rJMKvApKfZtJlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kNkOY370; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3C4BC4CEE3;
	Thu, 17 Jul 2025 23:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752795955;
	bh=FHLINl1DZS36+/aS7+Y+rW9XOVpqobZcCBImVb5SBi4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=kNkOY3701SWVc02oLrXeETa2ehQk+tD4Z+9r3Y1qyPn43NB9OmXr6jPPEJOkPImhx
	 X1ZzE4LLaD/NcFfIdLUPekK0Jsz7io3wgKpoaLy0eX7UQtnhm5r2F8qxsZ6XVlvuPG
	 wv5c4WplFGcnlH6smfej7sETPYexJ7u9qApjg8XlfA09RRZH/CVZsgta4B67koQx2T
	 nFBcH14p/c7jMfbUgHYUvESyXnnCbyaOQloAN1GDCMUe5gozx3Jgwawg2JxR8Kfd3X
	 M56lq+qjoJFgCFarN3Yjbt+DSs7OA4fvEgyo8zzIl/6b2yFbzczyPrH19pdum298x/
	 kUxb/FdirgMrQ==
Date: Thu, 17 Jul 2025 16:45:54 -0700
Subject: [PATCH 02/10] fuse2fs: skip permission checking on utimens when iomap
 is enabled
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: joannelkoong@gmail.com, miklos@szeredi.hu, John@groves.net,
 linux-fsdevel@vger.kernel.org, bernd@bsbernd.com, linux-ext4@vger.kernel.org,
 neal@gompa.dev
Message-ID: <175279461755.716436.17233234796060756869.stgit@frogsfrogsfrogs>
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

When iomap is enabled, the kernel is in charge of enforcing permissions
checks on timestamp updates for files.  We needn't do that in userspace
anymore.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index f9151ae6acb4e5..5d75cffa8f6bca 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -4334,11 +4334,12 @@ static int op_utimens(const char *path, const struct timespec ctv[2]
 
 	/*
 	 * ext4 allows timestamp updates of append-only files but only if we're
-	 * setting to current time
+	 * setting to current time.  If iomap is enabled, the kernel does the
+	 * permission checking for timestamp updates and we can skip the check.
 	 */
 	if (ctv[0].tv_nsec == UTIME_NOW && ctv[1].tv_nsec == UTIME_NOW)
 		access |= A_OK;
-	ret = check_inum_access(ff, ino, access);
+	ret = fuse2fs_iomap_enabled(ff) ? 0 : check_inum_access(ff, ino, access);
 	if (ret)
 		goto out;
 


