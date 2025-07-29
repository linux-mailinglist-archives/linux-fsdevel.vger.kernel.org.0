Return-Path: <linux-fsdevel+bounces-56251-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B10EB14F96
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 16:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14BF94E5BAE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 14:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8485920B7FA;
	Tue, 29 Jul 2025 14:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Ztw3XNMa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F15F26AAA3
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Jul 2025 14:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753800826; cv=none; b=ISB5LwpcsR7wh7FGa6gkyfe566BXTlJectdRBCyIJpr9J9n1fXp6EgvqT7J6SQQ1IZHaG3nOpnpchWXcfK5M7UrmzXP4V82e+bGA1l2mtW50Zku7lRzcSZ6rZJ2Ni8fj0JS3XN2WP2XCnat/4omSdpUlWlb1j53EJtrV7czy8+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753800826; c=relaxed/simple;
	bh=KwRowNpSO6yjOuVBF/z2ZfDv8QX69ZTfnl9fE+obzac=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=YkisQu/EJLRUS0QWNolLKTY1rXkIzOo3HB7aOE1owUIG+qc127snHLmB213z9gi8M8QjTTv8xXb5PuFBGpyaGIcn2Re1w+sFvHkYjS6GkkJIiDmZ93xw6/mqCfIU0WkBqYs2+ncHZkemw9hSVGiL1DrylbJ47S+EJqQdaR2FVqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Ztw3XNMa; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250729145337epoutp03f94caa143852cbae600781a7d6522bf9~WwI0fivzq0527005270epoutp039
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Jul 2025 14:53:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250729145337epoutp03f94caa143852cbae600781a7d6522bf9~WwI0fivzq0527005270epoutp039
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1753800817;
	bh=jhItjDu9xvQkkDeErOWAlu/915D9e9WOaYs2jLChWtM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ztw3XNMaFx+hdOFKWXicXb9ByjalhDE2bGXVfVaTbxMi3RiXHmtqhyoREnOzoGPmi
	 +FFv9b597mOL3PFTlq3Yok5JV23WAGIY6IO74vgV8T2WyfH3rwpy+hcpMbRODJUyD8
	 vxz98A4Ss+aZs5S/b4V/TRe/5fZJKQeGP4s8RnJE=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20250729145336epcas5p249122aeb208d49161fed05bea24ee302~WwI0FtPTc0554805548epcas5p2G;
	Tue, 29 Jul 2025 14:53:36 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.86]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4bryym18Tgz3hhT3; Tue, 29 Jul
	2025 14:53:36 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250729145335epcas5p462315e4dae631a1d940b6c3b2b611659~WwIylDKwi0961609616epcas5p40;
	Tue, 29 Jul 2025 14:53:35 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250729145333epsmtip23891c1a16a3474adc13b8ab7a69cdb24~WwIxLG00l0477304773epsmtip2D;
	Tue, 29 Jul 2025 14:53:33 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: kbusch@kernel.org, hch@lst.de, axboe@kernel.dk, brauner@kernel.org,
	josef@toxicpanda.com, jack@suse.cz, jlayton@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, Kanchan Joshi <joshi.k@samsung.com>
Subject: [RFC PATCH 2/5] fs: add the interface to query user write streams
Date: Tue, 29 Jul 2025 20:21:32 +0530
Message-Id: <20250729145135.12463-3-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250729145135.12463-1-joshi.k@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250729145335epcas5p462315e4dae631a1d940b6c3b2b611659
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250729145335epcas5p462315e4dae631a1d940b6c3b2b611659
References: <20250729145135.12463-1-joshi.k@samsung.com>
	<CGME20250729145335epcas5p462315e4dae631a1d940b6c3b2b611659@epcas5p4.samsung.com>

Add new fcntl F_GET_MAX_WRITE_STREAMS.
This returns the numbers of streams that are available for userspace.

And for that, use ->user_write_streams() callback when the involved
filesystem provides it.
In absence of such callback, use 'max_write_streams' queue limit of the
underlying block device.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 fs/fcntl.c                 | 31 +++++++++++++++++++++++++++++++
 include/uapi/linux/fcntl.h |  5 +++++
 2 files changed, 36 insertions(+)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 5598e4d57422..36ca833e9a0b 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -27,6 +27,7 @@
 #include <linux/compat.h>
 #include <linux/mount.h>
 #include <linux/rw_hint.h>
+#include <linux/blkdev.h>
 
 #include <linux/poll.h>
 #include <asm/siginfo.h>
@@ -394,6 +395,33 @@ static long fcntl_set_rw_hint(struct file *file, unsigned int cmd,
 	return 0;
 }
 
+static u8 vfs_user_write_streams(struct inode *inode)
+{
+	struct super_block *sb;
+
+	if (S_ISBLK(inode->i_mode))
+		return bdev_max_write_streams(I_BDEV(inode));
+
+	sb = inode->i_sb;
+	/* If available, use per-mount/fs policy */
+	if (sb->s_op && sb->s_op->user_write_streams)
+		return sb->s_op->user_write_streams(sb);
+	/* otherwise, fallback to queue limit */
+	if (sb->s_bdev)
+		return bdev_max_write_streams(sb->s_bdev);
+	return 0;
+}
+
+static long fcntl_get_max_write_streams(struct file *file)
+{
+	struct inode *inode = file_inode(file);
+
+	if (S_ISBLK(inode->i_mode))
+		inode = file->f_mapping->host;
+
+	return vfs_user_write_streams(inode);
+}
+
 /* Is the file descriptor a dup of the file? */
 static long f_dupfd_query(int fd, struct file *filp)
 {
@@ -552,6 +580,9 @@ static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
 	case F_SET_RW_HINT:
 		err = fcntl_set_rw_hint(filp, cmd, arg);
 		break;
+	case F_GET_MAX_WRITE_STREAMS:
+		err = fcntl_get_max_write_streams(filp);
+		break;
 	default:
 		break;
 	}
diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index f291ab4f94eb..87ec808d0f03 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -61,6 +61,11 @@
 #define F_GET_FILE_RW_HINT	(F_LINUX_SPECIFIC_BASE + 13)
 #define F_SET_FILE_RW_HINT	(F_LINUX_SPECIFIC_BASE + 14)
 
+/*
+ *  Query available write streams
+ */
+#define F_GET_MAX_WRITE_STREAMS (F_LINUX_SPECIFIC_BASE + 15)
+
 /*
  * Valid hint values for F_{GET,SET}_RW_HINT. 0 is "not set", or can be
  * used to clear any hints previously set.
-- 
2.25.1


