Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C24EB3B03E4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 14:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbhFVMOB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 08:14:01 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:54659 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbhFVMOB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 08:14:01 -0400
Received: from orion.localdomain ([95.117.21.172]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MEF87-1m5KHq1khB-00AJEx; Tue, 22 Jun 2021 14:11:43 +0200
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Subject: [RFC PATCH 2/6] fs: ext4: move fstrim to file_operation
Date:   Tue, 22 Jun 2021 14:11:32 +0200
Message-Id: <20210622121136.4394-3-info@metux.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210622121136.4394-1-info@metux.net>
References: <20210622121136.4394-1-info@metux.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:SEAYXtm7GbVRHzQweFmUed37iHQEuQsNHzL6JPFjCdIFUsZ8DpE
 rNLUkzG5KwoOTSZVn0a/RVqtklPMLEzq7kGBneS4k2VwL6tuAHe0SEIpgnZRWd8qPm/SbLE
 2hzj53B1leIY98qMip64KB9xofwe0kFCHi/z9qLxEVPB5SSVl0GQeE1cwrJb41sHPzjW16L
 DikV2XD8AqzDX2ATXXiMA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:xkiEMdkzDJ4=:Jj1tfXek19BWroOSl2xRNe
 SZ7Wc3Rd1StVPROiNKuJRpyqLWB4PRDHrkUUT3zZCOyuVA9KQDt4SLaDdeY9tuaWIcNNLko4B
 GY0thnYypJJnKuimn5Gv/5AHpHdQ5L5+b72KhJb2X4/g/qpxjiCeyVeYHCwd3ZlIqmD46Pt6f
 Z9kQ04y2CKyiZPqgKmNGx/UTZIqHLXvP66RdrEutDfMWxkpzpKRwIlCMLJ1dS+87klN0fMPZb
 kQM5vtuSExf2i5iSg+Y7+DOiWGG6v4MiyiTGzncg3ofnIC0edbYRPZH/XBtzRmq850HWGuM6d
 UcGmwHce7Y7cMug9m5s/xHMM2lRW5F2eg91PmsTfSsuDtsSftQX8wWpJFbBnzuix2DfKref+D
 ilyIhgeqXQiUfAz68u0JzY54R3jioUix6F7pR3WpJWwQ9u6NHzqWw9qH3TXO37vLgsEQD3KtE
 aT25px0yUd+OHZLhO873Yvo76b5LcBvrSad8EzNUojhANtbGBCrxMeW7P0C2yIS5oA/gH5HB6
 FgcDvqMjBEnt+9S5ZPJMEg=
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

---
 fs/ext4/ext4.h  |  1 +
 fs/ext4/file.c  |  1 +
 fs/ext4/ioctl.c | 60 ++++++++++++++++++++-----------------------------
 3 files changed, 26 insertions(+), 36 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 37002663d521..2770f8f5da95 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1272,6 +1272,7 @@ struct ext4_inode_info {
 #define ext4_find_next_bit		find_next_bit_le
 
 extern void ext4_set_bits(void *bm, int cur, int len);
+extern long ext4_fitrim(struct file *filp, struct fstrim_range *range);
 
 /*
  * Maximal mount counts between two filesystem checks
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 816dedcbd541..07bf5a0d10f2 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -927,6 +927,7 @@ const struct file_operations ext4_file_operations = {
 	.splice_read	= generic_file_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.fallocate	= ext4_fallocate,
+	.fitrim		= ext4_fitrim,
 };
 
 const struct inode_operations ext4_file_inode_operations = {
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 31627f7dc5cd..138e6128cb0c 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -800,6 +800,30 @@ static int ext4_ioctl_get_es_cache(struct file *filp, unsigned long arg)
 	return error;
 }
 
+long ext4_fitrim(struct file *filp, struct fstrim_range *range)
+{
+	struct request_queue *q = bdev_get_queue(sb->s_bdev);
+	int ret = 0;
+
+	if (!blk_queue_discard(q))
+		return -EOPNOTSUPP;
+
+	/*
+	 * We haven't replayed the journal, so we cannot use our
+	 * block-bitmap-guided storage zapping commands.
+	 */
+	if (test_opt(sb, NOLOAD) && ext4_has_feature_journal(sb))
+		return -EROFS;
+
+	range->minlen = max((unsigned int)range->minlen,
+			   q->limits.discard_granularity);
+	ret = ext4_trim_fs(sb, range);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
 static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
@@ -1044,41 +1068,6 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return err;
 	}
 
-	case FITRIM:
-	{
-		struct request_queue *q = bdev_get_queue(sb->s_bdev);
-		struct fstrim_range range;
-		int ret = 0;
-
-		if (!capable(CAP_SYS_ADMIN))
-			return -EPERM;
-
-		if (!blk_queue_discard(q))
-			return -EOPNOTSUPP;
-
-		/*
-		 * We haven't replayed the journal, so we cannot use our
-		 * block-bitmap-guided storage zapping commands.
-		 */
-		if (test_opt(sb, NOLOAD) && ext4_has_feature_journal(sb))
-			return -EROFS;
-
-		if (copy_from_user(&range, (struct fstrim_range __user *)arg,
-		    sizeof(range)))
-			return -EFAULT;
-
-		range.minlen = max((unsigned int)range.minlen,
-				   q->limits.discard_granularity);
-		ret = ext4_trim_fs(sb, &range);
-		if (ret < 0)
-			return ret;
-
-		if (copy_to_user((struct fstrim_range __user *)arg, &range,
-		    sizeof(range)))
-			return -EFAULT;
-
-		return 0;
-	}
 	case EXT4_IOC_PRECACHE_EXTENTS:
 		return ext4_ext_precache(inode);
 
@@ -1272,7 +1261,6 @@ long ext4_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	}
 	case EXT4_IOC_MOVE_EXT:
 	case EXT4_IOC_RESIZE_FS:
-	case FITRIM:
 	case EXT4_IOC_PRECACHE_EXTENTS:
 	case FS_IOC_SET_ENCRYPTION_POLICY:
 	case FS_IOC_GET_ENCRYPTION_PWSALT:
-- 
2.20.1

