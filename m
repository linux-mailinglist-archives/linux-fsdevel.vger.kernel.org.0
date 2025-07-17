Return-Path: <linux-fsdevel+bounces-55333-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7885DB09819
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA9A94A37C1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A77E23FC4C;
	Thu, 17 Jul 2025 23:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gHFWyyhY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D756524169A
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 23:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752795077; cv=none; b=ClqD/bGfkAAJQszfkE0e1mdj2w/MbkU5Y+2XXAzm4c50MJ0C8kja8lnUS5nXQ5VrqcxN3HFHhfzupSv/pQIfddjkaasAGRTgzWDmyZSy+qLpBGaZ296DIFtMaa24LaPtm8TOAoQ0g284m0N4/q84sNjv6Fffc4oAJUOtRxau0Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752795077; c=relaxed/simple;
	bh=WIZtdjUL+al/tqXsu2ixGFzZU2wvi8OnN82UeMSCbkc=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bEvuYpVnLDRzpLAF81290OI/U9+L7LkAD1PemMS5+n2Qwj7x87WrvmeMuM9ES7GdQ7NNGy7VtladHIT/ke2xvtC4lsO6qYV4+sdokfQjBg6TYQUWwZNTkFTv4yEpyL6+5BskwtfIPVpDd4nBR+Fve1+5gXO93fylgs6CJ/6LB70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gHFWyyhY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B26A3C4CEE3;
	Thu, 17 Jul 2025 23:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752795077;
	bh=WIZtdjUL+al/tqXsu2ixGFzZU2wvi8OnN82UeMSCbkc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=gHFWyyhY7cpWz2A/qxyIXfCph2NJlds1k/rKiDOVN0aBijbHb+sNg9CIGP3Nf8U3u
	 FBA2TJcFljsHuHFu0Ve6GvTnwjLW5a+ex5NjZn0abe7+pmV5rEo30NXRcC1pv2C+/S
	 ewbwBrLrf6VtmqiicUQV16JEcF9GMryjnOjiHwB4DY8giicax2b9BSNAROlK9Zx0OC
	 Ly2yaM+d2kDQ4lHRi+niRD7fTJlunam+/Mwoejz2nFMfGQJHqbxVLfoZD9n4tjAZTO
	 dAZFe4Urfjb/4vlt755oWZGTHihS1be5LKM5eiPq3aJ2qmGDU+tDsA05A6nViyscgl
	 +dsFBW6EjpLzw==
Date: Thu, 17 Jul 2025 16:31:17 -0700
Subject: [PATCH 12/13] fuse: implement fadvise for iomap files
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, John@groves.net,
 miklos@szeredi.hu, bernd@bsbernd.com, joannelkoong@gmail.com
Message-ID: <175279450194.711291.2927492386627016697.stgit@frogsfrogsfrogs>
In-Reply-To: <175279449855.711291.17231562727952977187.stgit@frogsfrogsfrogs>
References: <175279449855.711291.17231562727952977187.stgit@frogsfrogsfrogs>
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
index 136b9e5aabaf51..5fba84c75f4a64 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1714,6 +1714,8 @@ int fuse_iomap_flush_unmap_range(struct inode *inode, loff_t pos,
 
 int fuse_dev_ioctl_iomap_support(struct file *file,
 				 struct fuse_iomap_support __user *argp);
+
+int fuse_iomap_fadvise(struct file *file, loff_t start, loff_t end, int advice);
 #else
 # define fuse_iomap_enabled(...)		(false)
 # define fuse_has_iomap(...)			(false)
@@ -1742,6 +1744,7 @@ int fuse_dev_ioctl_iomap_support(struct file *file,
 # define fuse_iomap_fallocate(...)		(-ENOSYS)
 # define fuse_iomap_flush_unmap_range(...)	(-ENOSYS)
 # define fuse_dev_ioctl_iomap_support(...)	(-EOPNOTSUPP)
+# define fuse_iomap_fadvise			NULL
 #endif
 
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 207836e2e09cc4..78e776878427e3 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3236,6 +3236,7 @@ static const struct file_operations fuse_file_operations = {
 	.poll		= fuse_file_poll,
 	.fallocate	= fuse_file_fallocate,
 	.copy_file_range = fuse_copy_file_range,
+	.fadvise	= fuse_iomap_fadvise,
 };
 
 static const struct address_space_operations fuse_file_aops  = {
diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
index 5253f7ef88c110..3f6e0496c4744b 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -8,6 +8,7 @@
 #include <linux/iomap.h>
 #include <linux/pagemap.h>
 #include <linux/falloc.h>
+#include <linux/fadvise.h>
 
 static bool __read_mostly enable_iomap =
 #if IS_ENABLED(CONFIG_FUSE_IOMAP_BY_DEFAULT)
@@ -1831,3 +1832,22 @@ int fuse_dev_ioctl_iomap_support(struct file *file,
 		return -EFAULT;
 	return 0;
 }
+
+int fuse_iomap_fadvise(struct file *file, loff_t start, loff_t end, int advice)
+{
+	struct inode *inode = file_inode(file);
+	bool needlock = advice == POSIX_FADV_WILLNEED &&
+			fuse_has_iomap_fileio(inode);
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


