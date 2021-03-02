Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9244932A510
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Mar 2021 16:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442738AbhCBLqw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Mar 2021 06:46:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381335AbhCBFVD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Mar 2021 00:21:03 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F83C06178B;
        Mon,  1 Mar 2021 21:05:49 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id q20so13057493pfu.8;
        Mon, 01 Mar 2021 21:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Iqp5bpy3tZBqdtRjNj/u1VvRMlRbGWzDgAp5ZHqpvhs=;
        b=bxc9ZVXO+pJvIJo+e9qN3qi3uF9DGgelFeL2kXAR46UJpHLV56FLoYjpbdtRU0HUWZ
         h6pR/WcboBMSWlps5ZOpKhG8itI/i89p611L4834VKFC+n3hdKvoh8yGi+HZxKN8ds+O
         MLbToSFPKEmtXmaKQDgeUj+b2QG07BRO34obl5H3UBGnOs7rQQ7QTdu2pRc6CWzR1TXl
         7I0stBQoDtD0UTb4mXfGLtaVeMgMoI2TQUkxBkulYr1ynpuC8g+OiXLEQS9bWvN1gAdO
         bx6xGgO7+NM+hmympASiqnUjCMH2lWnPSAyDOoBPzzAB41zUzROJ3KVpDEz6Of1gd4O5
         OViw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Iqp5bpy3tZBqdtRjNj/u1VvRMlRbGWzDgAp5ZHqpvhs=;
        b=akX+ohi6dIMnhvhxRk7sXZloh/1ZY9yMFXJQEMb8ND0IAU3DekEfVG90FtuH8Z6PMM
         tJhtQYblmAj5116EgsyOsXc5nCYFql1mtcK7el/pex5/EredSS5quLzcGSiaTVI+XSeg
         LkX7Mt4KAeosMDs4ld40irF9PLBH8jtjOO6BPSxPJeg9VhZCi85RAal+O6fsxoaT+3fw
         QFFqRAIcU+bgA1Znp5zxJotGTYvRB7I7Qf7Nq1dDG6tM1PpvW8Sq4Ax4buKfCYt6mHyp
         1Vj4co6YTz4KBy2hW7VrIKEhKIj499nGisEXPTtV93XB6ElFNM/3z6WYN3tj5xe6TnGn
         mT2w==
X-Gm-Message-State: AOAM532Mo1W/rr2PYOjNrI4Euz4+cHl0T9Tskn9lQCfEz05e/+zcatez
        kcPCj9PTpST6ElzsME9YtbI=
X-Google-Smtp-Source: ABdhPJxxQjWqo1f1yNleYzB15q+uce+ZkH5ufVCny0uk3/GiSi1URTO1/6kaQwYHEd51XFrGTlQh9A==
X-Received: by 2002:a62:dd01:0:b029:1ed:6b67:1377 with SMTP id w1-20020a62dd010000b02901ed6b671377mr1768587pff.48.1614661549532;
        Mon, 01 Mar 2021 21:05:49 -0800 (PST)
Received: from localhost.localdomain ([27.122.242.75])
        by smtp.gmail.com with ESMTPSA id s16sm19759143pfs.39.2021.03.01.21.05.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Mar 2021 21:05:49 -0800 (PST)
From:   Hyeongseok Kim <hyeongseok@gmail.com>
To:     namjae.jeon@samsung.com, sj1557.seo@samsung.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Hyeongseok Kim <hyeongseok@gmail.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH v4 2/2] exfat: add support ioctl and FITRIM function
Date:   Tue,  2 Mar 2021 14:05:21 +0900
Message-Id: <20210302050521.6059-3-hyeongseok@gmail.com>
X-Mailer: git-send-email 2.27.0.83.g0313f36
In-Reply-To: <20210302050521.6059-1-hyeongseok@gmail.com>
References: <20210302050521.6059-1-hyeongseok@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add FITRIM ioctl to enable discarding unused blocks while mounted.
As current exFAT doesn't have generic ioctl handler, add empty ioctl
function first, and add FITRIM handler.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Signed-off-by: Hyeongseok Kim <hyeongseok@gmail.com>
---
 fs/exfat/balloc.c   | 80 +++++++++++++++++++++++++++++++++++++++++++++
 fs/exfat/dir.c      |  5 +++
 fs/exfat/exfat_fs.h |  4 +++
 fs/exfat/file.c     | 53 ++++++++++++++++++++++++++++++
 4 files changed, 142 insertions(+)

diff --git a/fs/exfat/balloc.c b/fs/exfat/balloc.c
index 761c79c3a4ba..8e5e9f037574 100644
--- a/fs/exfat/balloc.c
+++ b/fs/exfat/balloc.c
@@ -273,3 +273,83 @@ int exfat_count_used_clusters(struct super_block *sb, unsigned int *ret_count)
 	*ret_count = count;
 	return 0;
 }
+
+int exfat_trim_fs(struct inode *inode, struct fstrim_range *range)
+{
+	unsigned int trim_begin, trim_end, count, next_free_clu;
+	u64 clu_start, clu_end, trim_minlen, trimmed_total = 0;
+	struct super_block *sb = inode->i_sb;
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	int err = 0;
+
+	clu_start = max_t(u64, range->start >> sbi->cluster_size_bits,
+				EXFAT_FIRST_CLUSTER);
+	clu_end = clu_start + (range->len >> sbi->cluster_size_bits) - 1;
+	trim_minlen = range->minlen >> sbi->cluster_size_bits;
+
+	if (clu_start >= sbi->num_clusters || range->len < sbi->cluster_size)
+		return -EINVAL;
+
+	if (clu_end >= sbi->num_clusters)
+		clu_end = sbi->num_clusters - 1;
+
+	mutex_lock(&sbi->bitmap_lock);
+
+	trim_begin = trim_end = exfat_find_free_bitmap(sb, clu_start);
+	if (trim_begin == EXFAT_EOF_CLUSTER)
+		goto unlock;
+
+	next_free_clu = exfat_find_free_bitmap(sb, trim_end + 1);
+	if (next_free_clu == EXFAT_EOF_CLUSTER)
+		goto unlock;
+
+	do {
+		if (next_free_clu == trim_end + 1) {
+			/* extend trim range for continuous free cluster */
+			trim_end++;
+		} else {
+			/* trim current range if it's larger than trim_minlen */
+			count = trim_end - trim_begin + 1;
+			if (count >= trim_minlen) {
+				err = sb_issue_discard(sb,
+					exfat_cluster_to_sector(sbi, trim_begin),
+					count * sbi->sect_per_clus, GFP_NOFS, 0);
+				if (err)
+					goto unlock;
+
+				trimmed_total += count;
+			}
+
+			/* set next start point of the free hole */
+			trim_begin = trim_end = next_free_clu;
+		}
+
+		if (next_free_clu >= clu_end)
+			break;
+
+		if (fatal_signal_pending(current)) {
+			err = -ERESTARTSYS;
+			goto unlock;
+		}
+
+		next_free_clu = exfat_find_free_bitmap(sb, next_free_clu + 1);
+	} while (next_free_clu != EXFAT_EOF_CLUSTER &&
+			next_free_clu > trim_end);
+
+	/* try to trim remainder */
+	count = trim_end - trim_begin + 1;
+	if (count >= trim_minlen) {
+		err = sb_issue_discard(sb, exfat_cluster_to_sector(sbi, trim_begin),
+			count * sbi->sect_per_clus, GFP_NOFS, 0);
+		if (err)
+			goto unlock;
+
+		trimmed_total += count;
+	}
+
+unlock:
+	mutex_unlock(&sbi->bitmap_lock);
+	range->len = trimmed_total << sbi->cluster_size_bits;
+
+	return err;
+}
diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index 916797077aad..e1d5536de948 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/slab.h>
+#include <linux/compat.h>
 #include <linux/bio.h>
 #include <linux/buffer_head.h>
 
@@ -306,6 +307,10 @@ const struct file_operations exfat_dir_operations = {
 	.llseek		= generic_file_llseek,
 	.read		= generic_read_dir,
 	.iterate	= exfat_iterate,
+	.unlocked_ioctl = exfat_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl = exfat_compat_ioctl,
+#endif
 	.fsync		= exfat_file_fsync,
 };
 
diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 1ce422d7e9ae..80ffca67cfdc 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -412,6 +412,7 @@ int exfat_set_bitmap(struct inode *inode, unsigned int clu);
 void exfat_clear_bitmap(struct inode *inode, unsigned int clu, bool sync);
 unsigned int exfat_find_free_bitmap(struct super_block *sb, unsigned int clu);
 int exfat_count_used_clusters(struct super_block *sb, unsigned int *ret_count);
+int exfat_trim_fs(struct inode *inode, struct fstrim_range *range);
 
 /* file.c */
 extern const struct file_operations exfat_file_operations;
@@ -421,6 +422,9 @@ int exfat_setattr(struct dentry *dentry, struct iattr *attr);
 int exfat_getattr(const struct path *path, struct kstat *stat,
 		unsigned int request_mask, unsigned int query_flags);
 int exfat_file_fsync(struct file *file, loff_t start, loff_t end, int datasync);
+long exfat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
+long exfat_compat_ioctl(struct file *filp, unsigned int cmd,
+				unsigned long arg);
 
 /* namei.c */
 extern const struct dentry_operations exfat_dentry_ops;
diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index 183ffdf4d43c..56542f3f7c5a 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/slab.h>
+#include <linux/compat.h>
 #include <linux/cred.h>
 #include <linux/buffer_head.h>
 #include <linux/blkdev.h>
@@ -348,6 +349,54 @@ int exfat_setattr(struct dentry *dentry, struct iattr *attr)
 	return error;
 }
 
+static int exfat_ioctl_fitrim(struct inode *inode, unsigned long arg)
+{
+	struct request_queue *q = bdev_get_queue(inode->i_sb->s_bdev);
+	struct fstrim_range range;
+	int ret = 0;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (!blk_queue_discard(q))
+		return -EOPNOTSUPP;
+
+	if (copy_from_user(&range, (struct fstrim_range __user *)arg, sizeof(range)))
+		return -EFAULT;
+
+	range.minlen = max_t(unsigned int, range.minlen,
+				q->limits.discard_granularity);
+
+	ret = exfat_trim_fs(inode, &range);
+	if (ret < 0)
+		return ret;
+
+	if (copy_to_user((struct fstrim_range __user *)arg, &range, sizeof(range)))
+		return -EFAULT;
+
+	return 0;
+}
+
+long exfat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
+{
+	struct inode *inode = file_inode(filp);
+
+	switch (cmd) {
+	case FITRIM:
+		return exfat_ioctl_fitrim(inode, arg);
+	default:
+		return -ENOTTY;
+	}
+}
+
+#ifdef CONFIG_COMPAT
+long exfat_compat_ioctl(struct file *filp, unsigned int cmd,
+				unsigned long arg)
+{
+	return exfat_ioctl(filp, cmd, (unsigned long)compat_ptr(arg));
+}
+#endif
+
 int exfat_file_fsync(struct file *filp, loff_t start, loff_t end, int datasync)
 {
 	struct inode *inode = filp->f_mapping->host;
@@ -368,6 +417,10 @@ const struct file_operations exfat_file_operations = {
 	.llseek		= generic_file_llseek,
 	.read_iter	= generic_file_read_iter,
 	.write_iter	= generic_file_write_iter,
+	.unlocked_ioctl = exfat_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl = exfat_compat_ioctl,
+#endif
 	.mmap		= generic_file_mmap,
 	.fsync		= exfat_file_fsync,
 	.splice_read	= generic_file_splice_read,
-- 
2.27.0.83.g0313f36

