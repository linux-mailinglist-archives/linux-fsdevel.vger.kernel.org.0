Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37CE131D539
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Feb 2021 07:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbhBQGEw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Feb 2021 01:04:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbhBQGEC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Feb 2021 01:04:02 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1074C06174A;
        Tue, 16 Feb 2021 22:03:21 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id r2so6849621plr.10;
        Tue, 16 Feb 2021 22:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nYrAywWUkaQZ1Q6iXgClPZZIlqgleNWAK6tqZf411sA=;
        b=XpQfW46QlmX4junRi90CJcWolZbQ3JJFDTqGdP/blg4vgR/P+EtNCIHTWI2J9G2EAM
         Sno0swN9HSW1GFgyvzviWYAchiWT39q8oYI6/4ql677pjjad4WdAFtLB4oJof/kHVqbx
         mkhIkC8b2tt00njhvCVcp0wGw5r6Bj3J4kIs6Dqo8WcbvyQAvoZWrKHASmmm7C1KZJvX
         Gkif2FpPF+L3waPZxTU5p4MR1hWnVKGb6iuoal0s5du/Gvghq0/rfkY2TEu7t7SCM5cj
         +5m9zZKIPEEE5TaLIcgErmaD/K3zCmQ+lwBolPCRjpbf7QMRPQTe7BYjox4nl8eOMEIs
         NCTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nYrAywWUkaQZ1Q6iXgClPZZIlqgleNWAK6tqZf411sA=;
        b=fgFiWqq0LlP7YFuNjcBJIjJVeIg5egXgbHl9OJWqUjqxwKPCbPL85HToCTUoZETIOw
         X2uHtnv/L/ryKpuXjqnzYZrGbzKx1TPJjxNvh+0NQdDDcxNUPFz/RvKckJDUadEyN7Ty
         EjqaSLmticDVHEKZU6uW1jHMr6tUWEbz0fux7sutD8NIyRG/C1Iso9otLxTlH8SybGMG
         5bzFDbR55kKWbMJIRspsUJ3fP1JuF1bJZNzKV9qA5mnF3fAUkekD3aMr/rCBp8ZvoA5m
         vTiGFvqCfRhUXmQTcHfzs9pjWW09qDQedQ8m25022vs4m9P30tj2B+OUeT5bRi8nH/hw
         AMPA==
X-Gm-Message-State: AOAM531OS1tWLbHpHLj5Rd5J5x5CQXU4zWmDOPmzRqTlu6n5CEMFCxzm
        hec0I/a3lz8buYQE7meRJYo=
X-Google-Smtp-Source: ABdhPJxeofGuohAyG76/t+OB9fuvwsxFs9kiwDpq5Uc6rlarRrLHGdIKfhhVRqLiOzMPw8ntXPbk6A==
X-Received: by 2002:a17:902:b009:b029:e3:6915:5475 with SMTP id o9-20020a170902b009b02900e369155475mr7904409plr.34.1613541801521;
        Tue, 16 Feb 2021 22:03:21 -0800 (PST)
Received: from localhost.localdomain ([27.122.242.75])
        by smtp.gmail.com with ESMTPSA id x73sm861769pfd.185.2021.02.16.22.03.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Feb 2021 22:03:21 -0800 (PST)
From:   Hyeongseok Kim <hyeongseok@gmail.com>
To:     namjae.jeon@samsung.com, sj1557.seo@samsung.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hyeongseok Kim <hyeongseok@gmail.com>
Subject: [PATCH v3 1/1] exfat: add support ioctl and FITRIM function
Date:   Wed, 17 Feb 2021 15:03:05 +0900
Message-Id: <20210217060305.190898-2-hyeongseok@gmail.com>
X-Mailer: git-send-email 2.27.0.83.g0313f36
In-Reply-To: <20210217060305.190898-1-hyeongseok@gmail.com>
References: <20210217060305.190898-1-hyeongseok@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add FITRIM ioctl to enable discarding unused blocks while mounted.
As current exFAT doesn't have generic ioctl handler, add empty ioctl
function first, and add FITRIM handler.

Signed-off-by: Hyeongseok Kim <hyeongseok@gmail.com>
---
 fs/exfat/balloc.c   | 81 +++++++++++++++++++++++++++++++++++++++++++++
 fs/exfat/dir.c      |  5 +++
 fs/exfat/exfat_fs.h |  4 +++
 fs/exfat/file.c     | 53 +++++++++++++++++++++++++++++
 4 files changed, 143 insertions(+)

diff --git a/fs/exfat/balloc.c b/fs/exfat/balloc.c
index 761c79c3a4ba..d47beef66892 100644
--- a/fs/exfat/balloc.c
+++ b/fs/exfat/balloc.c
@@ -273,3 +273,84 @@ int exfat_count_used_clusters(struct super_block *sb, unsigned int *ret_count)
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
+	mutex_lock(&EXFAT_SB(inode->i_sb)->s_lock);
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
+		if (next_free_clu == trim_end + 1)
+			/* extend trim range for continuous free cluster */
+			trim_end++;
+		else {
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
+
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
+	mutex_unlock(&EXFAT_SB(inode->i_sb)->s_lock);
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
index 764bc645241e..e050aea0b639 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -411,6 +411,7 @@ int exfat_set_bitmap(struct inode *inode, unsigned int clu);
 void exfat_clear_bitmap(struct inode *inode, unsigned int clu, bool sync);
 unsigned int exfat_find_free_bitmap(struct super_block *sb, unsigned int clu);
 int exfat_count_used_clusters(struct super_block *sb, unsigned int *ret_count);
+int exfat_trim_fs(struct inode *inode, struct fstrim_range *range);
 
 /* file.c */
 extern const struct file_operations exfat_file_operations;
@@ -420,6 +421,9 @@ int exfat_setattr(struct dentry *dentry, struct iattr *attr);
 int exfat_getattr(const struct path *path, struct kstat *stat,
 		unsigned int request_mask, unsigned int query_flags);
 int exfat_file_fsync(struct file *file, loff_t start, loff_t end, int datasync);
+long exfat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
+long exfat_compat_ioctl(struct file *filp, unsigned int cmd,
+				unsigned long arg);
 
 /* namei.c */
 extern const struct dentry_operations exfat_dentry_ops;
diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index a92478eabfa4..3f88fccabe46 100644
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

