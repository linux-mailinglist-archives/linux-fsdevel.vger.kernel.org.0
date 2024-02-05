Return-Path: <linux-fsdevel+bounces-10352-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A6384A7B1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 22:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31AB61C278DE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 21:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2914112BF12;
	Mon,  5 Feb 2024 20:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Wcr8U8fQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7934812A17F
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Feb 2024 20:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707163571; cv=none; b=pGuCiL94swyx0kIpBWvqqdXNay0WObATj/49FT50pXzY0S2GueOpB8Q0wGSP6wvvCrFw0CslOnw5vFjD3hHIirwd0Lmt8tq7jRzKukLycyFr8tT2gPMeOLIDsfkWbNipjyK1snFLuE8ZUhufBiF3skWwPvGdwoiBzdxERWIY6wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707163571; c=relaxed/simple;
	bh=hPLAUyLLwUKEPrP5CZCmbgyMU8k8zrKbJNl29jrSSdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PT6oC69slWXpfsa8pVevZ7SX6EPOvMkk/dE9v3Zi0aK8vi5milYzaHVSVGF/92iI3zhZcYbkrtFaRrgSW1W6fRRKlxEu7m6D08kweCped0P1gOh3Y5+JQfC7bcwuZ4vmJZKWPtUuzOYu9ukWK+Gu0q1lNq09+xQMuGfRy8JmxxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Wcr8U8fQ; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707163566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MqXRwSUVpxeinEtP3l48LwjODcmqmNTThZB6l3iXHHM=;
	b=Wcr8U8fQCqYiiXre7rQymRda8iHSMIpNPM3+OFYG4WDeLA1Xpd1jwEnMK723HJDBKRO5l0
	g0554M9yp0a1oAe+iJ5UMU98kzaBHHllX6DgrX82A0VDgaLHrEBCg1qxgYvy629vbxAx40
	HOhKsQ9HMoJfioY7Yt4DCYRG9xNNBNs=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Dave Chinner <dchinner@redhat.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>,
	linux-fsdevel@vger.kernel.or
Subject: [PATCH 2/6] fs: FS_IOC_GETUUID
Date: Mon,  5 Feb 2024 15:05:13 -0500
Message-ID: <20240205200529.546646-3-kent.overstreet@linux.dev>
In-Reply-To: <20240205200529.546646-1-kent.overstreet@linux.dev>
References: <20240205200529.546646-1-kent.overstreet@linux.dev>
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
reads from super_block->s_uuid; FS_IOC_SETFSUUID is left for individual
filesystems to implement.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Dave Chinner <dchinner@redhat.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>
Cc: Theodore Ts'o <tytso@mit.edu>
Cc: linux-fsdevel@vger.kernel.or
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/ioctl.c              | 16 ++++++++++++++++
 include/uapi/linux/fs.h | 16 ++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/fs/ioctl.c b/fs/ioctl.c
index 76cf22ac97d7..858801060408 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -763,6 +763,19 @@ static int ioctl_fssetxattr(struct file *file, void __user *argp)
 	return err;
 }
 
+static int ioctl_getfsuuid(struct file *file, void __user *argp)
+{
+	struct super_block *sb = file_inode(file)->i_sb;
+
+	if (WARN_ON(sb->s_uuid_len > sizeof(sb->s_uuid)))
+		sb->s_uuid_len = sizeof(sb->s_uuid);
+
+	struct fsuuid2 u = { .fsu_len = sb->s_uuid_len, };
+	memcpy(&u.fsu_uuid[0], &sb->s_uuid, sb->s_uuid_len);
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
index 48ad69f7722e..0389fea87db5 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -64,6 +64,20 @@ struct fstrim_range {
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
+	__u32       fsu_len;
+	__u32       fsu_flags;
+	__u8        fsu_uuid[16];
+};
+
 /* extent-same (dedupe) ioctls; these MUST match the btrfs ioctl definitions */
 #define FILE_DEDUPE_RANGE_SAME		0
 #define FILE_DEDUPE_RANGE_DIFFERS	1
@@ -215,6 +229,8 @@ struct fsxattr {
 #define FS_IOC_FSSETXATTR		_IOW('X', 32, struct fsxattr)
 #define FS_IOC_GETFSLABEL		_IOR(0x94, 49, char[FSLABEL_MAX])
 #define FS_IOC_SETFSLABEL		_IOW(0x94, 50, char[FSLABEL_MAX])
+#define FS_IOC_GETFSUUID		_IOR(0x94, 51, struct fsuuid2)
+#define FS_IOC_SETFSUUID		_IOW(0x94, 52, struct fsuuid2)
 
 /*
  * Inode flags (FS_IOC_GETFLAGS / FS_IOC_SETFLAGS)
-- 
2.43.0


