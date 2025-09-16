Return-Path: <linux-fsdevel+bounces-61661-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37BA3B58AD1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 03:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDC4616A91B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 01:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C421CEAD6;
	Tue, 16 Sep 2025 01:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BIx2ganI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F252A1AA;
	Tue, 16 Sep 2025 01:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757984920; cv=none; b=GsbiW+dotVe5rT7UUxLj4V1t4Wnx3/oXcd2bX5h0aLAk4vlqNQguzn/Ut0elkrsm8TZPEZFu58um+SVP7DkOsKWW493w5NpVatbnFInos1R7oR5gfyVRxOsIUleE2dJJl/FqgyJey9WwnHE56yOndx8ZByWrqEaRPWv0R0jEJMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757984920; c=relaxed/simple;
	bh=aRR2GSBLFQab+VhN7yLaXSW8yKq2JFgymVoIpiVYCFU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c43Su3k1kRXnqRx3mpnKb2BITGZJzcWV8wdSp6ORaIWdRkHAh9QwKSxc66mMXZPhv1nZPF1jOcGzd5iJ1XRHAq9g8TGLpp991JtHWthIIyAq6TSFbW5hkm5cU3s/eWmXkvTPNQ6gpKTdtnlTdrbN34fuLoyGfGidYrW4BI7gDZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BIx2ganI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECEA5C4CEF1;
	Tue, 16 Sep 2025 01:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757984920;
	bh=aRR2GSBLFQab+VhN7yLaXSW8yKq2JFgymVoIpiVYCFU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=BIx2ganIjVDHxYixrZBM/R+vJFF6TzSJWItn0XLYOcs3EKBPRLlVF50EwIeJ6969O
	 HNJY7XTXjgUf34E4GaZMJPXM18aJaudoWSvIcB8doYWUtTfHkNCURde04YOORhZN/M
	 f8w9eRbPVKZemo9MN1o6L1CGJ3kHFSW0r/CTrj5FQ+pLKiI59KVhDQiTDXIzSUrXjq
	 j/TlythXKQBEEwgSHf+NJpXqKOMlTRPzL+nXtj97fOdehCWHZIks2aDckbJI3zJ7JT
	 HrLbn+Ozxs/xv8MsdNntRVsJ29nVyGVOaPht7u9hTuMyqQr87Nd9uJ0X0MnsxAaNAZ
	 pLW+5R6PxvzWg==
Date: Mon, 15 Sep 2025 18:08:39 -0700
Subject: [PATCH 1/4] libext2fs: fix MMP code to work with unixfd IO manager
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: miklos@szeredi.hu, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, John@groves.net, bernd@bsbernd.com,
 joannelkoong@gmail.com
Message-ID: <175798163116.392148.11424841429013808910.stgit@frogsfrogsfrogs>
In-Reply-To: <175798163083.392148.13563951490661745612.stgit@frogsfrogsfrogs>
References: <175798163083.392148.13563951490661745612.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

The MMP code assumes that it can (re)open() the filesystem via
fs->device_name.  However, if the Unix FD IO manager is in use the path
will be the string representation of the fd number.  This is a horrible
layering violation, but let's take the easy route and reroute the open()
call to dup() if desirable.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/ext2fs/mmp.c |   46 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)


diff --git a/lib/ext2fs/mmp.c b/lib/ext2fs/mmp.c
index eb9417020e6d3f..936ae920563fc5 100644
--- a/lib/ext2fs/mmp.c
+++ b/lib/ext2fs/mmp.c
@@ -26,6 +26,7 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
+#include <limits.h>
 
 #include "ext2fs/ext2_fs.h"
 #include "ext2fs/ext2fs.h"
@@ -41,6 +42,49 @@
 #endif
 #endif
 
+static int ext2fs_mmp_open_device(ext2_filsys fs, int flags)
+{
+	struct stat st;
+	char *endptr = NULL;
+	long maybe_fd;
+	int new_fd;
+	int want_directio = 1;
+	int ret;
+
+	/*
+	 * If the device name is only a number, then most likely the unixfd IO
+	 * manager is in use here.  Try to extract the fd number; if we can't,
+	 * then fall back to regular open.
+	 */
+	errno = 0;
+	maybe_fd = strtol(fs->device_name, &endptr, 10);
+	if (errno || endptr != fs->device_name + strlen(fs->device_name))
+		return open(fs->device_name, flags);
+
+	if (maybe_fd < 0 || maybe_fd > INT_MAX)
+		return -1;
+
+	/* Skip directio if this is a regular file, just like below */
+	ret = fstat(maybe_fd, &st);
+	if (ret == 0 && S_ISREG(st.st_mode))
+		want_directio = 0;
+
+	/* Duplicate the fd so that the MMP code can close it later */
+	new_fd = dup(maybe_fd);
+	if (new_fd < 0)
+		return -1;
+
+	if (want_directio) {
+		ret = fcntl(new_fd, F_SETFL, O_DIRECT);
+		if (ret) {
+			close(new_fd);
+			return -1;
+		}
+	}
+
+	return new_fd;
+}
+
 errcode_t ext2fs_mmp_read(ext2_filsys fs, blk64_t mmp_blk, void *buf)
 {
 #ifdef CONFIG_MMP
@@ -70,7 +114,7 @@ errcode_t ext2fs_mmp_read(ext2_filsys fs, blk64_t mmp_blk, void *buf)
 		    S_ISREG(st.st_mode))
 			flags &= ~O_DIRECT;
 
-		fs->mmp_fd = open(fs->device_name, flags);
+		fs->mmp_fd = ext2fs_mmp_open_device(fs, flags);
 		if (fs->mmp_fd < 0) {
 			retval = EXT2_ET_MMP_OPEN_DIRECT;
 			goto out;


