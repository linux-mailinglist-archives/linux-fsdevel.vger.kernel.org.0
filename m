Return-Path: <linux-fsdevel+bounces-10518-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D79A584BE8A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 21:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15CD31C217E5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 20:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B94A1C29F;
	Tue,  6 Feb 2024 20:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DKSKc9Qu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6851B81C
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Feb 2024 20:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707250756; cv=none; b=TBRsJZmE9vqt2nxctNCWi/DZfum0QxCidhERX3dyCuxgBiRyPs3kIc6UihswIfYvAD6bDOHOjoFZ+1dILpgXd4GFtenfdJGVMAlTsQ9QnQUrmBjPPZT8mG0cDoORSzaNNSglgnPc/Te1CHhBhyuZKpIWLEo+m4SIp8SsEg/eD04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707250756; c=relaxed/simple;
	bh=ihVywjsRPaRNHRnt5rdgpKCQd+dwFydgn6siSAIZffg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GjPyJkwwFjrook2OzIpZ0x/s7EbXSoFRPx1egOjkPK+q9jMjzE9MpcMmU6h1sFqqd2UhExOC68TN9Ycdo4dLAFkcOuh/WJibztcF9RyFVwR7d23txI0NYcjXdc1l6eI4HK/fW8cGP10wmgSUbStC4L8em5Yr+QZTEwearHe9D0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DKSKc9Qu; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707250753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ItugtweJECqHs1CmLKyw1iHGhu+1pYozy9UbRerZ1b8=;
	b=DKSKc9QueSrA93ArB5oPwxfyFK2m+WBscYd1Ghb0bw+a38mdK+rp6SEpyQ5H5sEyXc47tJ
	1lSieGlvpOwAuUV5wMDjp1IUIIENjvGsMXu08c/BO/IUoy1qzVPM+rLzftUJ5sKLRcmN+p
	WxIEql9iBhVS8q97qUtyqkAtYTn5QkY=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: brauner@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Jan Kara <jack@suse.cz>,
	Dave Chinner <dchinner@redhat.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v2 5/7] fs: FS_IOC_GETSYSFSNAME
Date: Tue,  6 Feb 2024 15:18:53 -0500
Message-ID: <20240206201858.952303-6-kent.overstreet@linux.dev>
In-Reply-To: <20240206201858.952303-1-kent.overstreet@linux.dev>
References: <20240206201858.952303-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add a new ioctl for getting the sysfs name of a filesystem - the path
under /sys/fs.

This is going to let us standardize exporting data from sysfs across
filesystems, e.g. time stats.

The returned path will always be of the form "$FSTYP/$SYSFS_IDENTIFIER",
where the sysfs identifier may be a UUID (for bcachefs) or a device name
(xfs).

Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Dave Chinner <dchinner@redhat.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>
Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/ioctl.c              | 17 +++++++++++++++++
 include/linux/fs.h      |  1 +
 include/uapi/linux/fs.h | 10 ++++++++++
 3 files changed, 28 insertions(+)

diff --git a/fs/ioctl.c b/fs/ioctl.c
index 046c30294a82..7c37765bd04e 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -776,6 +776,20 @@ static int ioctl_getfsuuid(struct file *file, void __user *argp)
 	return copy_to_user(argp, &u, sizeof(u)) ? -EFAULT : 0;
 }
 
+static int ioctl_get_fs_sysfs_path(struct file *file, void __user *argp)
+{
+	struct super_block *sb = file_inode(file)->i_sb;
+
+	if (!strlen(sb->s_sysfs_name))
+		return -ENOIOCTLCMD;
+
+	struct fssysfspath u = {};
+
+	snprintf(u.name, sizeof(u.name), "%s/%s", sb->s_type->name, sb->s_sysfs_name);
+
+	return copy_to_user(argp, &u, sizeof(u)) ? -EFAULT : 0;
+}
+
 /*
  * do_vfs_ioctl() is not for drivers and not intended to be EXPORT_SYMBOL()'d.
  * It's just a simple helper for sys_ioctl and compat_sys_ioctl.
@@ -861,6 +875,9 @@ static int do_vfs_ioctl(struct file *filp, unsigned int fd,
 	case FS_IOC_GETFSUUID:
 		return ioctl_getfsuuid(filp, argp);
 
+	case FS_IOC_GETFSSYSFSPATH:
+		return ioctl_get_fs_sysfs_path(filp, argp);
+
 	default:
 		if (S_ISREG(inode->i_mode))
 			return file_ioctl(filp, cmd, argp);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index acdc56987cb1..b96c1d009718 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1258,6 +1258,7 @@ struct super_block {
 	char			s_id[32];	/* Informational name */
 	uuid_t			s_uuid;		/* UUID */
 	u8			s_uuid_len;	/* Default 16, possibly smaller for weird filesystems */
+	char			s_sysfs_name[UUID_STRING_LEN + 1];
 
 	unsigned int		s_max_links;
 
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 16a6ecadfd8d..c0f7bd4b6350 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -77,6 +77,10 @@ struct fsuuid2 {
 	__u8	uuid[16];
 };
 
+struct fssysfspath {
+	__u8			name[128];
+};
+
 /* extent-same (dedupe) ioctls; these MUST match the btrfs ioctl definitions */
 #define FILE_DEDUPE_RANGE_SAME		0
 #define FILE_DEDUPE_RANGE_DIFFERS	1
@@ -206,6 +210,12 @@ struct fsxattr {
 /* Returns the external filesystem UUID, the same one blkid returns */
 #define FS_IOC_GETFSUUID		_IOR(0x12, 142, struct fsuuid2)
 
+/*
+ * Returns the path component under /sys/fs/ that refers to this filesystem;
+ * also /sys/kernel/debug/ for filesystems with debugfs exports
+ */
+#define FS_IOC_GETFSSYSFSPATH		_IOR(0x12, 143, struct fssysfspath)
+
 #define BMAP_IOCTL 1		/* obsolete - kept for compatibility */
 #define FIBMAP	   _IO(0x00,1)	/* bmap access */
 #define FIGETBSZ   _IO(0x00,2)	/* get the block size used for bmap */
-- 
2.43.0


