Return-Path: <linux-fsdevel+bounces-61528-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4621B5899A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CFB01760D6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1608B83CC7;
	Tue, 16 Sep 2025 00:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQ/tvZtU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7376E7483;
	Tue, 16 Sep 2025 00:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757982807; cv=none; b=q+PfA8aj8+SxKjxH2lb2FyVOQHCzRnh+xbwgPD2ueNAkR6KSI7qF5iFLfYOsz7OJdpovFVX7i1o4i5p47kxjgoXcIv/xXwim9dDl8eFUBdFMaELxBA2X4tSCuIQ8xAS9bC8YK60p8FYOFDyT3AKCbWNzu/Jlh9I3gUplJ5yAqxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757982807; c=relaxed/simple;
	bh=rk+vR/G+zN7TRlq4MQ3kSk44DwESEODiHCCSttKu+oE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kuqi4TTJhf33GzaYDSB15Oio4Dgj6SHX/971kTJnTanTuU1cbJWYm001KK9SrhjhHXSgrw/XGYg97N8dNwqWzkmlV5kA5d1f5+pcuVfa5c97EpASoecPUHG7Ic7wA2XYEgpiR9ZrM1P73X6ov7wURw0Blv2xYG6Hrl0kDJGJ1a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQ/tvZtU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45EACC4CEF1;
	Tue, 16 Sep 2025 00:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757982807;
	bh=rk+vR/G+zN7TRlq4MQ3kSk44DwESEODiHCCSttKu+oE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=TQ/tvZtUO9Vhz3q5GhH+opznQd4a4YXiz5jD5E1vqzXnjF/DtMwXlD6HQUyLnEjQh
	 TyrT6XC1DzPFgBOUk9TRcEBUDMv20OBeEXWiYtjarVfTy5OZWvQ3l8E0yol1swmBzN
	 sTkttNAYdDlPpiXVfsZOPrfxMB53CdL/ytTG3eVILHAQS46rY73O/ri6+P9ZWXTL1x
	 mloHxe+kT0GhmotFyABTEc1Pm4X+ggpu+IwfpDY9S9osIR/SRDfnKgiJPJonSgEsMT
	 ucpBLJSFDcORLgD4GH7B1bhNe7GCT3L76iV4wJBGKTMlx53oaDDgccvDFS2/J4Xsqd
	 zv8uQogrI29uQ==
Date: Mon, 15 Sep 2025 17:33:26 -0700
Subject: [PATCH 21/28] fuse: implement fadvise for iomap files
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, linux-xfs@vger.kernel.org, John@groves.net,
 linux-fsdevel@vger.kernel.org, neal@gompa.dev, joannelkoong@gmail.com
Message-ID: <175798151716.382724.506132159399951337.stgit@frogsfrogsfrogs>
In-Reply-To: <175798151087.382724.2707973706304359333.stgit@frogsfrogsfrogs>
References: <175798151087.382724.2707973706304359333.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

If userspace asks us to perform readahead on a file, take i_rwsem so
that it can't race with hole punching or writes.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_i.h     |    3 +++
 fs/fuse/file.c       |    1 +
 fs/fuse/file_iomap.c |   20 ++++++++++++++++++++
 3 files changed, 24 insertions(+)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index e45780f6fe9e39..d59c19f61d5337 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1789,6 +1789,8 @@ int fuse_iomap_flush_unmap_range(struct inode *inode, loff_t pos,
 
 int fuse_dev_ioctl_iomap_support(struct file *file,
 				 struct fuse_iomap_support __user *argp);
+
+int fuse_iomap_fadvise(struct file *file, loff_t start, loff_t end, int advice);
 #else
 # define fuse_iomap_enabled(...)		(false)
 # define fuse_has_iomap(...)			(false)
@@ -1813,6 +1815,7 @@ int fuse_dev_ioctl_iomap_support(struct file *file,
 # define fuse_iomap_fallocate(...)		(-ENOSYS)
 # define fuse_iomap_flush_unmap_range(...)	(-ENOSYS)
 # define fuse_dev_ioctl_iomap_support(...)	(-EOPNOTSUPP)
+# define fuse_iomap_fadvise			NULL
 #endif
 
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index dd65485c9743bf..9476f14035bb7f 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3189,6 +3189,7 @@ static const struct file_operations fuse_file_operations = {
 	.poll		= fuse_file_poll,
 	.fallocate	= fuse_file_fallocate,
 	.copy_file_range = fuse_copy_file_range,
+	.fadvise	= fuse_iomap_fadvise,
 };
 
 static const struct address_space_operations fuse_file_aops  = {
diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
index 2d01828fc532b0..a484cd235d9da2 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -7,6 +7,7 @@
 #include <linux/fiemap.h>
 #include <linux/pagemap.h>
 #include <linux/falloc.h>
+#include <linux/fadvise.h>
 #include "fuse_i.h"
 #include "fuse_trace.h"
 #include "iomap_priv.h"
@@ -1856,3 +1857,22 @@ int fuse_dev_ioctl_iomap_support(struct file *file,
 		return -EFAULT;
 	return 0;
 }
+
+int fuse_iomap_fadvise(struct file *file, loff_t start, loff_t end, int advice)
+{
+	struct inode *inode = file_inode(file);
+	bool needlock = advice == POSIX_FADV_WILLNEED &&
+			fuse_inode_has_iomap(inode);
+	int ret;
+
+	/*
+	 * Operations creating pages in page cache need protection from hole
+	 * punching and similar ops
+	 */
+	if (needlock)
+		inode_lock_shared(inode);
+	ret = generic_fadvise(file, start, end, advice);
+	if (needlock)
+		inode_unlock_shared(inode);
+	return ret;
+}


