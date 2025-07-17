Return-Path: <linux-fsdevel+bounces-55384-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F1FB09872
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 126EB5A2E8B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0C72550BB;
	Thu, 17 Jul 2025 23:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bPUqf5eY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDED024110F;
	Thu, 17 Jul 2025 23:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752795878; cv=none; b=pTFWIv/C5+I2AzZGWuN88fZemjfsE7tqhcyblq2evfJX3DC/HPmEXNV+iEMInXnwYNCBFSDGkUi1a5r35UYE8IqMJaYMk8xumE/92zNLjjIqx4pNnsh/s4H8D07cnNY2D/YVXbwO+sZ5dCKtG5QWL4s5LYii/LSB+rrbbHYA1sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752795878; c=relaxed/simple;
	bh=5HH6C4oGmSAngwcvLYb/8zzSyUOg2dHgYRJc0QdHtck=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fQWT6v1sV5jNPM+80iqEIZROwEB5rVe9kbuD358hPsebycaEvuMLmsTtJq4He9C8uNV2dJ7bhBi9Zvy98Ce30Xvd5RZb0wLVjuLc0MVlb3RHUczCcxmIkianZjl2LbVyaZQlhAS4naMYQqpntePpP521MB8mEBW9+14i7FElz04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bPUqf5eY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65070C4CEF0;
	Thu, 17 Jul 2025 23:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752795876;
	bh=5HH6C4oGmSAngwcvLYb/8zzSyUOg2dHgYRJc0QdHtck=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=bPUqf5eYtM4xBLUkSqetoiwngng9OZtyEhZ9rxhjL9tHwb/3Bcni3clLk/63Wjufo
	 6N1my5InqC+Ku5bjWLMCoONfu+41p8Co/oy3Kjcs68Hn/ZUiQQW8wrtkJz5ewEsmfJ
	 Zz/z/3mpOFyVOGcDIU1oZicbcwf26ThYSa4+RLAf9QepGD8JAREmxxVR7+eE/SoE+K
	 QqnSSKOu3GR2AhvYWNR7pPlifXgUkVjHwT9qhm/cvmTKkaEOFUtkpG9p/tjW6MBs/e
	 +Kb5Wj54UbpNSRaUG+QSEDMtNtEHvGpaeyryHZOPFJB6VuSe28hcbgf0TDuQ9pmL/P
	 WC6yqr+E2sIEg==
Date: Thu, 17 Jul 2025 16:44:35 -0700
Subject: [PATCH 20/22] fuse2fs: set iomap-related inode flags
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: joannelkoong@gmail.com, miklos@szeredi.hu, John@groves.net,
 linux-fsdevel@vger.kernel.org, bernd@bsbernd.com, linux-ext4@vger.kernel.org,
 neal@gompa.dev
Message-ID: <175279461395.715479.7477289872117738395.stgit@frogsfrogsfrogs>
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

Set FUSE_IFLAG_* when we do a getattr, so that all files will have iomap
enabled.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index c21a95b6920d5c..e71fcbaeeaf0c6 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -1571,6 +1571,25 @@ static int op_getattr(const char *path, struct stat *statbuf
 	return ret;
 }
 
+#ifdef HAVE_FUSE_IOMAP
+static int op_getattr_iflags(const char *path, struct stat *statbuf,
+			     unsigned int *iflags, struct fuse_file_info *fi)
+{
+	struct fuse_context *ctxt = fuse_get_context();
+	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
+	int ret = op_getattr(path, statbuf, fi);
+
+	if (ret)
+		return ret;
+
+	if (fuse2fs_iomap_does_fileio(ff))
+		*iflags |= FUSE_IFLAG_IOMAP_DIRECTIO | FUSE_IFLAG_IOMAP_FILEIO;
+
+	return 0;
+}
+#endif
+
+
 static int op_readlink(const char *path, char *buf, size_t len)
 {
 	struct fuse_context *ctxt = fuse_get_context();
@@ -6178,6 +6197,7 @@ static struct fuse_operations fs_ops = {
 	.iomap_end = op_iomap_end,
 	.iomap_config = op_iomap_config,
 	.iomap_ioend = op_iomap_ioend,
+	.getattr_iflags = op_getattr_iflags,
 #endif /* HAVE_FUSE_IOMAP */
 };
 


