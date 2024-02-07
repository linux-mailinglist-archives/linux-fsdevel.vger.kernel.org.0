Return-Path: <linux-fsdevel+bounces-10553-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 939D784C2D0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 03:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A834B2BCA2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 02:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F7317BAF;
	Wed,  7 Feb 2024 02:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Xkskbv1B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B209F125C7
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Feb 2024 02:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707274603; cv=none; b=E8B15BmG5WsbuxARTqxecXRTxMHoi4GOTPXi9H/rExzMBZOjtuft0+sO6REkG5fK/ioiF4d2KSisPkJrVkfJdCMqYGNalJ558bv8aQ8ya/JpZ4zIVFP5/VZSu3e24Pv2O4HynUcmrOB6OVvmLHJpK9z6BoQFrV/G0UWazYEfPAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707274603; c=relaxed/simple;
	bh=vbqvSHdZJsrGtl4Lju6wfFZUHt9ZsvthSKcxz6ZWeOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tGjQvrvjbtE3HY+ZEvK+vMCKjwE+fXUu2R3poBTQVAbhJGetINLlFfFGKanhkStvEmfYo/RFufnjGStHlXglVsR+QBy56t0wxbNPIlj+o7Pk4tspbfdjSilqtvXDB3jGzDXPBmi7TawkAu5KnO5Pe5nWJBuePHMKF/WtVYOiLzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Xkskbv1B; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707274600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5nefsnteNMIXQ0vBHat1NyVxbt5y5vhYA9vOpXDrhng=;
	b=Xkskbv1B7ziP255fE+nGs14FO490cUFqHFByCu/9XD2m2NIRUhtER2eNqeOWq1ZXxoTA9q
	OPkR1ydTdA+JSLkiurUHaYHt5TaItDRuG8UjVuo0H6+AuBVlCe2it1KmJlVsDOvlV3M/fp
	G7lMWH9FDMaDVWC67oDOTutjfZvU/dY=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	linux-btrfs@vger.kernel.org,
	Jan Kara <jack@suse.cz>,
	Dave Chinner <dchinner@redhat.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v3 5/7] fs: FS_IOC_GETSYSFSNAME
Date: Tue,  6 Feb 2024 21:56:19 -0500
Message-ID: <20240207025624.1019754-6-kent.overstreet@linux.dev>
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
 include/linux/fs.h      | 42 +++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/fs.h | 11 +++++++++++
 3 files changed, 70 insertions(+)

diff --git a/fs/ioctl.c b/fs/ioctl.c
index 74eab9549383..1d5abfdf0f22 100644
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
+	struct fs_sysfs_path u = {};
+
+	u.len = scnprintf(u.name, sizeof(u.name), "%s/%s", sb->s_type->name, sb->s_sysfs_name);
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
index acdc56987cb1..fb003d9d05af 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1255,10 +1255,23 @@ struct super_block {
 	struct fsnotify_mark_connector __rcu	*s_fsnotify_marks;
 #endif
 
+	/*
+	 * q: why are s_id and s_sysfs_name not the same? both are human
+	 * readable strings that identify the filesystem
+	 * a: s_id is allowed to change at runtime; it's used in log messages,
+	 * and we want to when a device starts out as single device (s_id is dev
+	 * name) but then a device is hot added and we have to switch to
+	 * identifying it by UUID
+	 * but s_sysfs_name is a handle for programmatic access, and can't
+	 * change at runtime
+	 */
 	char			s_id[32];	/* Informational name */
 	uuid_t			s_uuid;		/* UUID */
 	u8			s_uuid_len;	/* Default 16, possibly smaller for weird filesystems */
 
+	/* if set, fs shows up under sysfs at /sys/fs/$FSTYP/s_sysfs_name */
+	char			s_sysfs_name[UUID_STRING_LEN + 1];
+
 	unsigned int		s_max_links;
 
 	/*
@@ -2541,6 +2554,35 @@ static inline void super_set_uuid(struct super_block *sb, const u8 *uuid, unsign
 	memcpy(&sb->s_uuid, uuid, len);
 }
 
+/* set sb sysfs name based on sb->s_bdev */
+static inline void super_set_sysfs_name_bdev(struct super_block *sb)
+{
+	snprintf(sb->s_sysfs_name, sizeof(sb->s_sysfs_name), "%pg", sb->s_bdev);
+}
+
+/* set sb sysfs name based on sb->s_uuid */
+static inline void super_set_sysfs_name_uuid(struct super_block *sb)
+{
+	WARN_ON(sb->s_uuid_len != sizeof(sb->s_uuid));
+	snprintf(sb->s_sysfs_name, sizeof(sb->s_sysfs_name), "%pU", sb->s_uuid.b);
+}
+
+/* set sb sysfs name based on sb->s_id */
+static inline void super_set_sysfs_name_id(struct super_block *sb)
+{
+	strscpy(sb->s_sysfs_name, sb->s_id, sizeof(sb->s_sysfs_name));
+}
+
+/* try to use something standard before you use this */
+static inline void super_set_sysfs_name_generic(struct super_block *sb, const char *fmt, ...)
+{
+	va_list args;
+
+	va_start(args, fmt);
+	vsnprintf(sb->s_sysfs_name, sizeof(sb->s_sysfs_name), fmt, args);
+	va_end(args);
+}
+
 extern int current_umask(void);
 
 extern void ihold(struct inode * inode);
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index d459f816cd50..db5f9decd6f1 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -77,6 +77,11 @@ struct fsuuid2 {
 	__u8	uuid[16];
 };
 
+struct fs_sysfs_path {
+	__u8			len;
+	__u8			name[128];
+};
+
 /* extent-same (dedupe) ioctls; these MUST match the btrfs ioctl definitions */
 #define FILE_DEDUPE_RANGE_SAME		0
 #define FILE_DEDUPE_RANGE_DIFFERS	1
@@ -206,6 +211,12 @@ struct fsxattr {
 /* Returns the external filesystem UUID, the same one blkid returns */
 #define FS_IOC_GETFSUUID		_IOR(0x15, 0, struct fsuuid2)
 
+/*
+ * Returns the path component under /sys/fs/ that refers to this filesystem;
+ * also /sys/kernel/debug/ for filesystems with debugfs exports
+ */
+#define FS_IOC_GETFSSYSFSPATH		_IOR(0x15, 1, struct fs_sysfs_path)
+
 #define BMAP_IOCTL 1		/* obsolete - kept for compatibility */
 #define FIBMAP	   _IO(0x00,1)	/* bmap access */
 #define FIGETBSZ   _IO(0x00,2)	/* get the block size used for bmap */
-- 
2.43.0


