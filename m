Return-Path: <linux-fsdevel+bounces-68287-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CA3C587EE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 16:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37EFF4A63BC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 15:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2828B35A149;
	Thu, 13 Nov 2025 15:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="tkV+h/BL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF6B33BBA4;
	Thu, 13 Nov 2025 15:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763047145; cv=none; b=qWhKRqPbbZTqDEsYg7g2TYgHU7A0MTEWvbi9ln4lcLZSOPpq2A6WGr24XG94698bwJefJGlBwChhLE+ABUvAk/NPm6YVXArPtTAcrYoh+tIj2b4W/T+ax2Oa/oChuck5q910ixB/4ImF+/IH/RmlixBWhFCNgNx/DcNPQ9oa4vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763047145; c=relaxed/simple;
	bh=CR4Hgz/9myGG2v1YUbvHJLsx6eOdRj3lscoRryqb8m0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iyt2Xiq0S19+qq4I4BgMMjdEWC1BKh+b+olQWbqYhXghexJYFc1Mdf8hhgS3nZYvtDddrTPDOMNi8ZAConOumQP0slLdhzJk4zuWPahgFfJ0BHhRQyCiCPDzH4qFvRTdooAoFd1Knsg49YTWm1ESrOTA/lKJax8kgBzPNL7KX1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=tkV+h/BL; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 482CE1D47;
	Thu, 13 Nov 2025 15:15:39 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=tkV+h/BL;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id F0D202151;
	Thu, 13 Nov 2025 15:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1763047140;
	bh=9KyB2qFEVJ8OrxvroqmzHC505bmfmqJqaZ+1kd3f9PA=;
	h=From:To:CC:Subject:Date;
	b=tkV+h/BLISP0S5+hWllNAiaC3/uyUtTnxy2zRLQcXsBLq+F1zFJtJ26TiakgZ3Rux
	 0Xmbv6hSEvcmQdF7s7a4efzHhUULRsGTwZ/VLyp6kD5Hkm9s48hJ35lOku11nxcBei
	 rfu0aXks7OS8CjDOh0Wb19p4RqfmJgF9ti+nQBB4=
Received: from localhost.localdomain (172.30.20.182) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 13 Nov 2025 18:18:59 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH] fs/ntfs3: implement NTFS3_IOC_SHUTDOWN ioctl
Date: Thu, 13 Nov 2025 16:18:50 +0100
Message-ID: <20251113151851.7550-1-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

Add support for the NTFS3_IOC_SHUTDOWN ioctl, allowing userspace to
request a filesystem shutdown. The ioctl number is shared with other
filesystems such as ext4, exfat, and f2fs.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/file.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 60eb90bff955..b9484f48db34 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -19,6 +19,12 @@
 #include "ntfs.h"
 #include "ntfs_fs.h"
 
+/*
+ * cifx, btrfs, exfat, ext4, f2fs use this constant.
+ * Hope this value will become common to all fs.
+ */
+#define NTFS3_IOC_SHUTDOWN _IOR('X', 125, __u32)
+
 static int ntfs_ioctl_fitrim(struct ntfs_sb_info *sbi, unsigned long arg)
 {
 	struct fstrim_range __user *user_range;
@@ -73,13 +79,47 @@ static int ntfs_ioctl_set_volume_label(struct ntfs_sb_info *sbi, u8 __user *buf)
 	return ntfs_set_label(sbi, user, len);
 }
 
+/*
+ * ntfs_force_shutdown - helper function. Called from ioctl
+ */
+static int ntfs_force_shutdown(struct super_block *sb, u32 flags)
+{
+	int err;
+	struct ntfs_sb_info *sbi = sb->s_fs_info;
+
+	if (unlikely(ntfs3_forced_shutdown(sb)))
+		return 0;
+
+	/* No additional options yet (flags). */
+	err = bdev_freeze(sb->s_bdev);
+	if (err)
+		return err;
+	set_bit(NTFS_FLAGS_SHUTDOWN_BIT, &sbi->flags);
+	bdev_thaw(sb->s_bdev);
+	return 0;
+}
+
+static int ntfs_ioctl_shutdown(struct super_block *sb, unsigned long arg)
+{
+	u32 flags;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (get_user(flags, (__u32 __user *)arg))
+		return -EFAULT;
+
+	return ntfs_force_shutdown(sb, flags);
+}
+
 /*
  * ntfs_ioctl - file_operations::unlocked_ioctl
  */
 long ntfs_ioctl(struct file *filp, u32 cmd, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
-	struct ntfs_sb_info *sbi = inode->i_sb->s_fs_info;
+	struct super_block *sb = inode->i_sb;
+	struct ntfs_sb_info *sbi = sb->s_fs_info;
 
 	/* Avoid any operation if inode is bad. */
 	if (unlikely(is_bad_ni(ntfs_i(inode))))
@@ -92,6 +132,8 @@ long ntfs_ioctl(struct file *filp, u32 cmd, unsigned long arg)
 		return ntfs_ioctl_get_volume_label(sbi, (u8 __user *)arg);
 	case FS_IOC_SETFSLABEL:
 		return ntfs_ioctl_set_volume_label(sbi, (u8 __user *)arg);
+	case NTFS3_IOC_SHUTDOWN:
+		return ntfs_ioctl_shutdown(sb, arg);
 	}
 	return -ENOTTY; /* Inappropriate ioctl for device. */
 }
-- 
2.43.0


