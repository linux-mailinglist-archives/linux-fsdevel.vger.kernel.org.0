Return-Path: <linux-fsdevel+bounces-49617-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D381AC00FB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 02:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C54A59E49E8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 00:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2B51E51D;
	Thu, 22 May 2025 00:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e38+j712"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184EE1BC41;
	Thu, 22 May 2025 00:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747872319; cv=none; b=NylpRvWvOgBn7Qgq/dbxgmKgi3md+x7cXtiLo+ZhmLoMA+3CwMvQh11y4pN5H4S7YvqyyK3V63OUSsgHS0a8k4rg9XNnjX764L58KpEEM6FaI3fBpnjzU4FCfqSQXV2LH0atDf0EpEafJgjO8a0wRNq0PU/N6Tb69vktQe3+tsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747872319; c=relaxed/simple;
	bh=RIfS4x6M2c9LZeI5udPVj9EhoMW5G/Z4nHTmVUvMuaY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CQFVvKwlF8h/ClJB+/okLgh4imjiY5PiL5SnNM6pdBxFj1XMFEYMRdDnaje3kYFGO+yhPgisVHHNI/b0oa1AgNN6+hnnaDsO/iazaXEoxB3Mwfb1CrbjWVsqdVxl7oYv3uWgXIyv56QoUNwEat4ICP7NpSTacRN4Yoe+z3hLl88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e38+j712; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E30BDC4CEE4;
	Thu, 22 May 2025 00:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747872318;
	bh=RIfS4x6M2c9LZeI5udPVj9EhoMW5G/Z4nHTmVUvMuaY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=e38+j712QhiQZVFvFC1HZmMijegGYhVvETYGthA7C9e4z4CwmsUndxEXH0iZfuRdA
	 Lnpd8YDy0bTeWSV01O6EASXq2jI6cE1FcCCxaIZCu2buyZrnK3ic0Za5N2qqTz170h
	 ES6Wx384X7qaTWyTC8ZFxaHDScHrUtGPtWFQm8TR7tltoPRPdkYHT4V9HQgdp1dTDX
	 aA5X3EjeMU1w08usbxVZ/PGyXMsVwjUKIsytSNO0ofKct9HGkzBwWonApMfeKw3oz4
	 I5bKiG9yfqCEY9/USQTkCp5hXbObpMWdzD88BA+G9gmElvwlQPjCvz3iZi3+2ctiff
	 YQ7jE47xIcqYA==
Date: Wed, 21 May 2025 17:05:18 -0700
Subject: [PATCH 11/11] fuse: advertise support for iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com,
 linux-xfs@vger.kernel.org, bernd@bsbernd.com, John@groves.net
Message-ID: <174787195800.1483178.5830088582040507337.stgit@frogsfrogsfrogs>
In-Reply-To: <174787195502.1483178.17485675069927796174.stgit@frogsfrogsfrogs>
References: <174787195502.1483178.17485675069927796174.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Advertise our new IO paths programmatically by creating an ioctl that
can return the capabilities of the kernel.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_i.h          |    4 ++++
 include/uapi/linux/fuse.h |   13 +++++++++++++
 fs/fuse/dev.c             |    3 +++
 fs/fuse/file_iomap.c      |   18 ++++++++++++++++++
 4 files changed, 38 insertions(+)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 8481b1d0299df0..5b14e8b23f305f 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1683,6 +1683,9 @@ int fuse_iomap_setsize(struct mnt_idmap *idmap, struct dentry *dentry,
 		       struct iattr *iattr);
 int fuse_iomap_fallocate(struct file *file, int mode, loff_t offset,
 			 loff_t length, loff_t new_size);
+
+int fuse_iomap_ioc_support(struct file *file,
+			   struct fuse_iomap_support __user *argp);
 #else
 # define fuse_iomap_enabled(...)		(false)
 # define fuse_has_iomap(...)			(false)
@@ -1706,6 +1709,7 @@ int fuse_iomap_fallocate(struct file *file, int mode, loff_t offset,
 # define fuse_iomap_buffered_write(...)		(-ENOSYS)
 # define fuse_iomap_setsize(...)		(-ENOSYS)
 # define fuse_iomap_fallocate(...)		(-ENOSYS)
+# define fuse_iomap_ioc_support(...)		(-ENOTTY)
 #endif
 
 #endif /* _FS_FUSE_I_H */
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index c9402f2b2a335c..cbef70ae05c73b 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -1135,12 +1135,25 @@ struct fuse_backing_map {
 	uint64_t	padding;
 };
 
+/* basic reporting functionality */
+#define FUSE_IOMAP_SUPPORT_BASICS	(1ULL << 0)
+/* fuse driver can do direct io */
+#define FUSE_IOMAP_SUPPORT_DIRECTIO	(1ULL << 1)
+/* fuse driver can do buffered io */
+#define FUSE_IOMAP_SUPPORT_PAGECACHE	(1ULL << 2)
+struct fuse_iomap_support {
+	uint64_t	flags;
+	uint64_t	padding;
+};
+
 /* Device ioctls: */
 #define FUSE_DEV_IOC_MAGIC		229
 #define FUSE_DEV_IOC_CLONE		_IOR(FUSE_DEV_IOC_MAGIC, 0, uint32_t)
 #define FUSE_DEV_IOC_BACKING_OPEN	_IOW(FUSE_DEV_IOC_MAGIC, 1, \
 					     struct fuse_backing_map)
 #define FUSE_DEV_IOC_BACKING_CLOSE	_IOW(FUSE_DEV_IOC_MAGIC, 2, uint32_t)
+#define FUSE_DEV_IOC_IOMAP_SUPPORT	_IOR(FUSE_DEV_IOC_MAGIC, 3, \
+					     struct fuse_iomap_support)
 
 struct fuse_lseek_in {
 	uint64_t	fh;
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 9d7064ec170cf6..91beafbbcf7c02 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2620,6 +2620,9 @@ static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
 	case FUSE_DEV_IOC_BACKING_CLOSE:
 		return fuse_dev_ioctl_backing_close(file, argp);
 
+	case FUSE_DEV_IOC_IOMAP_SUPPORT:
+		return fuse_iomap_ioc_support(file, argp);
+
 	default:
 		return -ENOTTY;
 	}
diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
index 746d9ae192dc55..60e1242b32fd7c 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -1425,3 +1425,21 @@ fuse_iomap_fallocate(
 
 	return 0;
 }
+
+int fuse_iomap_ioc_support(struct file *file,
+			   struct fuse_iomap_support __user *argp)
+{
+	struct fuse_iomap_support ios = { };
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (fuse_iomap_enabled())
+		ios.flags = FUSE_IOMAP_SUPPORT_BASICS |
+			    FUSE_IOMAP_SUPPORT_DIRECTIO |
+			    FUSE_IOMAP_SUPPORT_PAGECACHE;
+
+	if (copy_to_user(argp, &ios, sizeof(ios)))
+		return -EFAULT;
+	return 0;
+}


