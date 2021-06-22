Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D29013B03EC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 14:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbhFVMOF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 08:14:05 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:58875 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbhFVMOC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 08:14:02 -0400
Received: from orion.localdomain ([95.117.21.172]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N1gac-1lFhgu1jwm-011zHy; Tue, 22 Jun 2021 14:11:44 +0200
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Subject: [RFC PATCH 6/6] fs: f2fs: move fstrim to file_operation
Date:   Tue, 22 Jun 2021 14:11:36 +0200
Message-Id: <20210622121136.4394-7-info@metux.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210622121136.4394-1-info@metux.net>
References: <20210622121136.4394-1-info@metux.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:KbVZgb+ncrb5PGXtUdzRU4R7/1hoNcz0HKyGrGMscLo4DO2Bs+8
 f+WDGUvYtR7RfZVPOczhz+Pj8NPqgK68MD7iFrZMIJgE43vG1G1aPcyo/w4TyeqJNr1YmO+
 y2upeMAXAQwAjAL5xq48eDoBdsjQPRpLv0v1w11tXyrqn3ElOeV/qwokWtE4Of94mCeGIOn
 RiYumH0F6uZEDOBsP4loA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:lWKsG7Xj5rQ=:eU73c2EZQ0fXEjV9nnVANq
 K7A3YrleS4vvDCqcvk3u0nkHKJvKzibi0IQq4vk2Qs0pT92XuY+QH+x3gJA20b1PLZKPvy6O0
 61EA3c9F1fy1sivfYIbeXL3uTnP93p0PHAzI2OjLWTRHYyFxWE1F/+k3e/nedlkEFNK39qk5j
 QT3Pk+gadLLUjpQpqN7+9O7Cqj+1HsM+RHOzkqqWbgdnBA6JcNCz3AGrkfAS17FUV3o4w9ces
 u6tKliro1BxUhaJV06fUrVR+8umvvHnQwQ3MfhHMdTyE86N0oRrpQcQFdeRGj4z3ZWnlbktCF
 WVf2UzHFKIQT57WWBi+1WsRaJVnhq96sMKBOgpS63SPYYfy8B6s4sM7aalJj7304iIWX7Vqa+
 Vixv4GIJcf03OtU09b+G8dWnqUFKoDqAQiTWjfqMkQ8GmJFnC0dw0yrwZCXU0+EXRFLr5/bhf
 OrmHttCc/HFWRYWQFsYAhykcIy45Ygha+HiPFx5BEQtqLHcIPiEWSkBxCBvkINEgoZWHOsBaL
 CSsf8iRGPX4v4xWdO4pwCE=
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use the newly introduced file_operation callback for FITRIM ioctl.
This removes some common code, eg. permission check, buffer copying,
which is now done by generic vfs code.
---
 fs/f2fs/file.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index ceb575f99048..4c3f5eab22aa 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2252,38 +2252,27 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
 	return ret;
 }
 
-static int f2fs_ioc_fitrim(struct file *filp, unsigned long arg)
+static long f2fs_ioc_fitrim(struct file *file, struct fstrim_range *range)
 {
 	struct inode *inode = file_inode(filp);
 	struct super_block *sb = inode->i_sb;
 	struct request_queue *q = bdev_get_queue(sb->s_bdev);
-	struct fstrim_range range;
 	int ret;
 
-	if (!capable(CAP_SYS_ADMIN))
-		return -EPERM;
-
 	if (!f2fs_hw_support_discard(F2FS_SB(sb)))
 		return -EOPNOTSUPP;
 
-	if (copy_from_user(&range, (struct fstrim_range __user *)arg,
-				sizeof(range)))
-		return -EFAULT;
-
 	ret = mnt_want_write_file(filp);
 	if (ret)
 		return ret;
 
-	range.minlen = max((unsigned int)range.minlen,
+	range->minlen = max((unsigned int)range->minlen,
 				q->limits.discard_granularity);
-	ret = f2fs_trim_fs(F2FS_SB(sb), &range);
+	ret = f2fs_trim_fs(F2FS_SB(sb), range);
 	mnt_drop_write_file(filp);
 	if (ret < 0)
 		return ret;
 
-	if (copy_to_user((struct fstrim_range __user *)arg, &range,
-				sizeof(range)))
-		return -EFAULT;
 	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
 	return 0;
 }
@@ -4124,8 +4113,6 @@ static long __f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return f2fs_ioc_abort_volatile_write(filp);
 	case F2FS_IOC_SHUTDOWN:
 		return f2fs_ioc_shutdown(filp, arg);
-	case FITRIM:
-		return f2fs_ioc_fitrim(filp, arg);
 	case FS_IOC_SET_ENCRYPTION_POLICY:
 		return f2fs_ioc_set_encryption_policy(filp, arg);
 	case FS_IOC_GET_ENCRYPTION_POLICY:
@@ -4405,7 +4392,6 @@ long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case F2FS_IOC_RELEASE_VOLATILE_WRITE:
 	case F2FS_IOC_ABORT_VOLATILE_WRITE:
 	case F2FS_IOC_SHUTDOWN:
-	case FITRIM:
 	case FS_IOC_SET_ENCRYPTION_POLICY:
 	case FS_IOC_GET_ENCRYPTION_PWSALT:
 	case FS_IOC_GET_ENCRYPTION_POLICY:
@@ -4461,4 +4447,5 @@ const struct file_operations f2fs_file_operations = {
 #endif
 	.splice_read	= generic_file_splice_read,
 	.splice_write	= iter_file_splice_write,
+	.fitrim		= f2fs_ioc_fitrim,
 };
-- 
2.20.1

