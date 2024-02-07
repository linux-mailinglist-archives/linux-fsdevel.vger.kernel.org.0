Return-Path: <linux-fsdevel+bounces-10551-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F2984C2CC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 03:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 350241C21712
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 02:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFD8134AC;
	Wed,  7 Feb 2024 02:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ye+QLjw/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01E4FC15
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Feb 2024 02:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707274601; cv=none; b=GUxRYdgecsV6upiuOekOE3nJS7CgGLVEGuuVM5Q7/MWfbAjIO2Z9pUm2TIYQl5um01PqxgF8DtNG9gfWV0OpzeKe4AIbhBE898kZsvPwUllyuFA8taXsY+2RBsh34tMewv58HvvYjmS0BLSgP4Xp1cOgd4IMrQaM1b9Egtw9xlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707274601; c=relaxed/simple;
	bh=MS0WbqtVgIe8M1NZp32269Ki857UQEJAVjcpeaNthFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hG5NGCQu4cYRHgfgAWCbU8BkSTzA3FZPoqC9PVgCpt1dYvxyqzFxC3njQocw7asK/NKgpkKZS+KQzAohjUPuNkJ3w8XLbuBuckgtNic+aeLIF+Sh/AP5LKnJZDDWZQMq8vLIW3yOHz9t/YThFcbQtOWA5H11lI1Im7mHbhGLFVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ye+QLjw/; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707274598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p6CyvyH0tYATCrucslrTDjNjg0PrSUtOo7EHe4oQc5I=;
	b=Ye+QLjw/NWQqtmBsgOqlE1WDn0+jPGYYi/5PfOEo6x68cSdmQR3gcWWVVXAolYXm69/sfi
	/3V67CihVSAGRpPnRt5vurk6dxswUQQaYS3YMBEIv4TX1IczIUWkf2xtQ5/rfNVz24r4+F
	nd/mMoWB2rggmsdvd4Z5u/zuqpsOg+Q=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	linux-btrfs@vger.kernel.org,
	Jan Kara <jack@suse.cz>,
	Dave Chinner <dchinner@redhat.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>,
	linux-fsdevel@vger.kernel.or
Subject: [PATCH v3 3/7] fs: FS_IOC_GETUUID
Date: Tue,  6 Feb 2024 21:56:17 -0500
Message-ID: <20240207025624.1019754-4-kent.overstreet@linux.dev>
In-Reply-To: <20240207025624.1019754-1-kent.overstreet@linux.dev>
References: <20240207025624.1019754-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add a new generic ioctls for querying the filesystem UUID.

These are lifted versions of the ext4 ioctls, with one change: we're not
using a flexible array member, because UUIDs will never be more than 16
bytes.

This patch adds a generic implementation of FS_IOC_GETFSUUID, which
reads from super_block->s_uuid. We're not lifting SETFSUUID from ext4 -
that can be done on offline filesystems by the people who need it,
trying to do it online is just asking for too much trouble.

Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Dave Chinner <dchinner@redhat.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>
Cc: Theodore Ts'o <tytso@mit.edu>
Cc: linux-fsdevel@vger.kernel.or
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 .../userspace-api/ioctl/ioctl-number.rst         |  3 ++-
 fs/ioctl.c                                       | 16 ++++++++++++++++
 include/uapi/linux/fs.h                          | 16 ++++++++++++++++
 3 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index 457e16f06e04..3731ecf1e437 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -82,8 +82,9 @@ Code  Seq#    Include File                                           Comments
 0x10  00-0F  drivers/char/s390/vmcp.h
 0x10  10-1F  arch/s390/include/uapi/sclp_ctl.h
 0x10  20-2F  arch/s390/include/uapi/asm/hypfs.h
-0x12  all    linux/fs.h
+0x12  all    linux/fs.h                                              BLK* ioctls
              linux/blkpg.h
+0x15  all    linux/fs.h                                              FS_IOC_* ioctls
 0x1b  all                                                            InfiniBand Subsystem
                                                                      <http://infiniband.sourceforge.net/>
 0x20  all    drivers/cdrom/cm206.h
diff --git a/fs/ioctl.c b/fs/ioctl.c
index 76cf22ac97d7..74eab9549383 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -763,6 +763,19 @@ static int ioctl_fssetxattr(struct file *file, void __user *argp)
 	return err;
 }
 
+static int ioctl_getfsuuid(struct file *file, void __user *argp)
+{
+	struct super_block *sb = file_inode(file)->i_sb;
+	struct fsuuid2 u = { .len = sb->s_uuid_len, };
+
+	if (!sb->s_uuid_len)
+		return -ENOIOCTLCMD;
+
+	memcpy(&u.uuid[0], &sb->s_uuid, sb->s_uuid_len);
+
+	return copy_to_user(argp, &u, sizeof(u)) ? -EFAULT : 0;
+}
+
 /*
  * do_vfs_ioctl() is not for drivers and not intended to be EXPORT_SYMBOL()'d.
  * It's just a simple helper for sys_ioctl and compat_sys_ioctl.
@@ -845,6 +858,9 @@ static int do_vfs_ioctl(struct file *filp, unsigned int fd,
 	case FS_IOC_FSSETXATTR:
 		return ioctl_fssetxattr(filp, argp);
 
+	case FS_IOC_GETFSUUID:
+		return ioctl_getfsuuid(filp, argp);
+
 	default:
 		if (S_ISREG(inode->i_mode))
 			return file_ioctl(filp, cmd, argp);
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 48ad69f7722e..d459f816cd50 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -64,6 +64,19 @@ struct fstrim_range {
 	__u64 minlen;
 };
 
+/*
+ * We include a length field because some filesystems (vfat) have an identifier
+ * that we do want to expose as a UUID, but doesn't have the standard length.
+ *
+ * We use a fixed size buffer beacuse this interface will, by fiat, never
+ * support "UUIDs" longer than 16 bytes; we don't want to force all downstream
+ * users to have to deal with that.
+ */
+struct fsuuid2 {
+	__u8	len;
+	__u8	uuid[16];
+};
+
 /* extent-same (dedupe) ioctls; these MUST match the btrfs ioctl definitions */
 #define FILE_DEDUPE_RANGE_SAME		0
 #define FILE_DEDUPE_RANGE_DIFFERS	1
@@ -190,6 +203,9 @@ struct fsxattr {
  * (see uapi/linux/blkzoned.h)
  */
 
+/* Returns the external filesystem UUID, the same one blkid returns */
+#define FS_IOC_GETFSUUID		_IOR(0x15, 0, struct fsuuid2)
+
 #define BMAP_IOCTL 1		/* obsolete - kept for compatibility */
 #define FIBMAP	   _IO(0x00,1)	/* bmap access */
 #define FIGETBSZ   _IO(0x00,2)	/* get the block size used for bmap */
-- 
2.43.0


