Return-Path: <linux-fsdevel+bounces-10516-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 238BB84BE86
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 21:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6E7B1F26D69
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 20:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5394C1B960;
	Tue,  6 Feb 2024 20:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pD1lnZx2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA7218AF8
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Feb 2024 20:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707250754; cv=none; b=O2FSbU3BnbvahNTYc7Du0ExO9vuK0g+l35cZ9MkRzlLP/afOSPaAEcPSCFZBaJMLD521+MoQyPik/o/97EFe2F3GwMgFhk38xCrDevdXgNN4fgha7CiRR1h93gpVtNKe7KiIuTdK6p9qG6ocamgTWGR8m6XWByR4llNvMmF/jxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707250754; c=relaxed/simple;
	bh=Nl2uD7WLGO6LwYrdmtsTqVkhwhbUvhZiQtCqAfnLPOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PrseR3PLVsn3s9zsQsIMGJDcUiDsd5OAwcx9VdBXh7nFB24HnorJXn8J3XUvE4r+4LQA0+YflTGUin5Z//8WmFHr/15E75xuJUodMflMF2lBjTiFWZf8fRv4RnbgSFOJ6rT0NGWYd8AhL+PutmyIkWg3GC6U30fM4uCPzkNn3xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pD1lnZx2; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707250750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cUWUWQYx2apHh584Rw7/E+yXOteLWIl9kYmQ30+LMmM=;
	b=pD1lnZx25k66T6d8cUseYkNdiKRM6rwnY7db3KlIqpszfG+WRNa4M1ZLVrYl1A5UUzrmlA
	8rmQRWHdrv4nbzS32Te2wHIF16jdGH71+IzPLqbBBg6SSCH1L8qPJgUkC7bCt2ZnLaKxJB
	wp1uqbhAlwB5wC7OhMFhbRH6xiWI87c=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: brauner@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Jan Kara <jack@suse.cz>,
	Dave Chinner <dchinner@redhat.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>,
	linux-fsdevel@vger.kernel.or
Subject: [PATCH v2 3/7] fs: FS_IOC_GETUUID
Date: Tue,  6 Feb 2024 15:18:51 -0500
Message-ID: <20240206201858.952303-4-kent.overstreet@linux.dev>
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
 fs/ioctl.c              | 16 ++++++++++++++++
 include/uapi/linux/fs.h | 17 +++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/fs/ioctl.c b/fs/ioctl.c
index 76cf22ac97d7..046c30294a82 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -763,6 +763,19 @@ static int ioctl_fssetxattr(struct file *file, void __user *argp)
 	return err;
 }
 
+static int ioctl_getfsuuid(struct file *file, void __user *argp)
+{
+	struct super_block *sb = file_inode(file)->i_sb;
+
+	if (!sb->s_uuid_len)
+		return -ENOIOCTLCMD;
+
+	struct fsuuid2 u = { .len = sb->s_uuid_len, };
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
index 48ad69f7722e..16a6ecadfd8d 100644
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
+#define FS_IOC_GETFSUUID		_IOR(0x12, 142, struct fsuuid2)
+
 #define BMAP_IOCTL 1		/* obsolete - kept for compatibility */
 #define FIBMAP	   _IO(0x00,1)	/* bmap access */
 #define FIGETBSZ   _IO(0x00,2)	/* get the block size used for bmap */
@@ -198,6 +214,7 @@ struct fsxattr {
 #define FITRIM		_IOWR('X', 121, struct fstrim_range)	/* Trim */
 #define FICLONE		_IOW(0x94, 9, int)
 #define FICLONERANGE	_IOW(0x94, 13, struct file_clone_range)
+
 #define FIDEDUPERANGE	_IOWR(0x94, 54, struct file_dedupe_range)
 
 #define FSLABEL_MAX 256	/* Max chars for the interface; each fs may differ */
-- 
2.43.0


