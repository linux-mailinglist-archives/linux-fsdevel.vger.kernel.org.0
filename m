Return-Path: <linux-fsdevel+bounces-66113-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00975C17D07
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7BAB404683
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB842DC331;
	Wed, 29 Oct 2025 01:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b8g8T+Tz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527581BCA1C;
	Wed, 29 Oct 2025 01:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761700435; cv=none; b=IgEp71sQRWlaZJZcv4CiugqcLM6a9LQVDR8Kjpxf3g77ZpD12LsfcqzFKwKS/i4BQIfhrGUgsAQbgrZNm55xjCjfZ3VpnQBTHarwJJ6uiIiodW0N4qOtejUtOlKoOGFYGX03AgkYYHUheeIQ/K+JZqnCmF6gz2Nxt5tqWeF77Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761700435; c=relaxed/simple;
	bh=AXSX2yPIqCaRjoGLzOeqK3Rc58T1RoAHWxSALkMZB5E=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CgOCReu8S6TediFDPhDauII7+x5ymx4Rpe+DCWG3hTU+SY+jtHtphgAu+p4t9sVawnE7cUstXfIiQHa6QyK7p/9wDHalZ3opY2MW+WYugfQN8iGhB9mv9pY2yQo0aWYLQDnd4F0EHCeS/iEQy2EmGtZfrzboR7IaMuVY9rWLZLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b8g8T+Tz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2CF3C4CEE7;
	Wed, 29 Oct 2025 01:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761700434;
	bh=AXSX2yPIqCaRjoGLzOeqK3Rc58T1RoAHWxSALkMZB5E=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=b8g8T+TzNP78gJnnKbnZBZx4Sq7WnV/YxgLqv15Dgmt3YXvs+JOFxI8bqtTOdkVRk
	 QhnSaPSkNjupZEgpjbAkqF0kbRp+u+hnEI+lfxK5Gte/cEwuXfT9gjpaaKXRFT3nzq
	 rqAYBWZei0R1jCbb3A3/sfp+UeLpXwmfTfzt9v0Yoaay88YNqly0l9L2i5Xem00q3D
	 xD53wCtMR6d/smv/x0gglu1+IBGpWjG/jw2Ivgc2oT8m414uIYp2gPRzzpKA7LP0fU
	 QZSOz3gmYUpzdImlF9mvPSlfB528400sMkCVWAAs1qWNDWQ6cfYbl9+nJKdkaUjKPt
	 Gqj98hpDx/0BQ==
Date: Tue, 28 Oct 2025 18:13:54 -0700
Subject: [PATCH 02/11] fuse2fs: skip permission checking on utimens when iomap
 is enabled
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com, bernd@bsbernd.com,
 neal@gompa.dev, miklos@szeredi.hu, linux-ext4@vger.kernel.org
Message-ID: <176169818256.1430380.1484675885063509219.stgit@frogsfrogsfrogs>
In-Reply-To: <176169818170.1430380.13590456647130347042.stgit@frogsfrogsfrogs>
References: <176169818170.1430380.13590456647130347042.stgit@frogsfrogsfrogs>
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
 fuse4fs/fuse4fs.c |   11 +++++++----
 misc/fuse2fs.c    |   11 +++++++----
 2 files changed, 14 insertions(+), 8 deletions(-)


diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index 641fa0648b7a29..aeb3040c04b221 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -5263,13 +5263,16 @@ static int fuse4fs_utimens(struct fuse4fs *ff, const struct fuse_ctx *ctxt,
 
 	/*
 	 * ext4 allows timestamp updates of append-only files but only if we're
-	 * setting to current time
+	 * setting to current time.  If iomap is enabled, the kernel does the
+	 * permission checking for timestamp updates; skip the access check.
 	 */
 	if (aact == TA_NOW && mact == TA_NOW)
 		access |= A_OK;
-	ret = fuse4fs_inum_access(ff, ctxt, ino, access);
-	if (ret)
-		return ret;
+	if (!fuse4fs_iomap_enabled(ff)) {
+		ret = fuse4fs_inum_access(ff, ctxt, ino, access);
+		if (ret)
+			return ret;
+	}
 
 	if (aact != TA_OMIT)
 		EXT4_INODE_SET_XTIME(i_atime, &atime, inode);
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 9fda7663583f71..283a9abdc1963c 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -4917,13 +4917,16 @@ static int op_utimens(const char *path, const struct timespec ctv[2],
 
 	/*
 	 * ext4 allows timestamp updates of append-only files but only if we're
-	 * setting to current time
+	 * setting to current time.  If iomap is enabled, the kernel does the
+	 * permission checking for timestamp updates; skip the access check.
 	 */
 	if (ctv[0].tv_nsec == UTIME_NOW && ctv[1].tv_nsec == UTIME_NOW)
 		access |= A_OK;
-	ret = check_inum_access(ff, ino, access);
-	if (ret)
-		goto out;
+	if (!fuse2fs_iomap_enabled(ff)) {
+		ret = check_inum_access(ff, ino, access);
+		if (ret)
+			goto out;
+	}
 
 	err = fuse2fs_read_inode(fs, ino, &inode);
 	if (err) {


