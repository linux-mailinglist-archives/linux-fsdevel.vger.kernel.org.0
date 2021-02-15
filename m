Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8C7331B483
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Feb 2021 05:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbhBOEZR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 Feb 2021 23:25:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbhBOEZO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 Feb 2021 23:25:14 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7E8C061756;
        Sun, 14 Feb 2021 20:24:34 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id t11so3508100pgu.8;
        Sun, 14 Feb 2021 20:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HX3Y6/bZJNI/LCL5M4XjVMDlW67dC1nmK86mUGOjbP8=;
        b=O7m6Lok/luQkrvdgV/DHDliKanSrmh1+FR+yr5kA7HnRET/Khgt14AoGtmzxiLW7Nv
         5p1RBtgewgCGV8b2UvYR+DFClHjKnDNIPCOQqZ5vDcUUC5iOJv88HJLTXTP17+Nw1ceJ
         K14I0IN3K1qcTyioiJZd2R5+TaJfJOPboXHvks6PlsWfdGIo+yy0eEhqpVdXbDCKZsbe
         VjDmDM/qFQq4K69D+fwX4bgycvDSkLCXppIIPhx+akXoOhrxe68O0sqIA3S8CzJ9iV0+
         BFZ/mt+cO56WGLje8j6HBzjC9I4Ozz8NXDhw/ptuW5qCbtly22RmV0OAlvgeFHx1CbBt
         VwUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HX3Y6/bZJNI/LCL5M4XjVMDlW67dC1nmK86mUGOjbP8=;
        b=MJlbNsGJFVz83ojOELIL1liGUYg+8R0lqw+QKD+UaOgvMznAMpeW3wzKiLavC7r+Th
         6dXmNKEnfD445GLfGdUyU/kRhlDzIxq9jw+xhNJ4GTz5EpSQUm/WOwWtsnJSML1KCFiG
         zXzK1bVpTWFHOCWbZHEWbn9TLoFQcBHDpC/OupZHG4+Q/UQzDkhiXQ9XF3ljUoULufpY
         8LjvhNFkkDKwCVmdqdaKL2GrHqXlWBmZ9VcTRM2aka1yJc8aZimQ8eTNVQP4iuWDEPbO
         kVNYKLyTVC5nx7Nj+9dB+PpghEFkuratL7pLEEAs8uH3LAgLrV9jrCE7TRVfR4X/khio
         BpAQ==
X-Gm-Message-State: AOAM530NAMq3EaHXiRwIcLwuynqR3EqtCN2kc0qqoQ+IByQln/Ly8PgO
        blKZ477ddN6jVY0mVnEuGQO/E/DOfy8bAqxT
X-Google-Smtp-Source: ABdhPJxlJmZ50rgX1hMcG/z4GukLG7/oyUYPseNH08LytOgXbc7LTT5Qy6pXPW6R+2CDCVcY/1TQiw==
X-Received: by 2002:aa7:930f:0:b029:1e3:9a82:39e5 with SMTP id 15-20020aa7930f0000b02901e39a8239e5mr13831900pfj.33.1613363073661;
        Sun, 14 Feb 2021 20:24:33 -0800 (PST)
Received: from localhost.localdomain ([27.122.242.75])
        by smtp.gmail.com with ESMTPSA id o135sm15768241pfg.21.2021.02.14.20.24.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Feb 2021 20:24:33 -0800 (PST)
From:   Hyeongseok Kim <hyeongseok@gmail.com>
To:     namjae.jeon@samsung.com, sj1557.seo@samsung.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hyeongseok Kim <hyeongseok@gmail.com>
Subject: [PATCH 2/2] exfat: add support FITRIM ioctl
Date:   Mon, 15 Feb 2021 13:24:11 +0900
Message-Id: <20210215042411.119392-2-hyeongseok@gmail.com>
X-Mailer: git-send-email 2.27.0.83.g0313f36
In-Reply-To: <20210215042411.119392-1-hyeongseok@gmail.com>
References: <20210215042411.119392-1-hyeongseok@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

add FITRIM ioctl to support trimming mounted filesystem

Signed-off-by: Hyeongseok Kim <hyeongseok@gmail.com>
---
 fs/exfat/balloc.c   | 89 +++++++++++++++++++++++++++++++++++++++++++++
 fs/exfat/exfat_fs.h |  1 +
 fs/exfat/file.c     | 33 +++++++++++++++++
 3 files changed, 123 insertions(+)

diff --git a/fs/exfat/balloc.c b/fs/exfat/balloc.c
index 761c79c3a4ba..edd0f6912e8e 100644
--- a/fs/exfat/balloc.c
+++ b/fs/exfat/balloc.c
@@ -273,3 +273,92 @@ int exfat_count_used_clusters(struct super_block *sb, unsigned int *ret_count)
 	*ret_count = count;
 	return 0;
 }
+
+int exfat_trim_fs(struct inode *inode, struct fstrim_range *range)
+{
+	struct super_block *sb = inode->i_sb;
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	u64 clu_start, clu_end, trim_minlen, trimmed_total = 0;
+	unsigned int trim_begin, trim_end, count;
+	unsigned int next_free_clu;
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
+				if (err && err != -EOPNOTSUPP)
+					goto unlock;
+				if (!err)
+					trimmed_total += count;
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
+		if (need_resched()) {
+			mutex_unlock(&EXFAT_SB(inode->i_sb)->s_lock);
+			cond_resched();
+			mutex_lock(&EXFAT_SB(inode->i_sb)->s_lock);
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
+		if (err && err != -EOPNOTSUPP)
+			goto unlock;
+
+		if (!err)
+			trimmed_total += count;
+	}
+
+unlock:
+	mutex_unlock(&EXFAT_SB(inode->i_sb)->s_lock);
+	range->len = trimmed_total << sbi->cluster_size_bits;
+
+	return err;
+}
diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index a183021ae31d..e050aea0b639 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -411,6 +411,7 @@ int exfat_set_bitmap(struct inode *inode, unsigned int clu);
 void exfat_clear_bitmap(struct inode *inode, unsigned int clu, bool sync);
 unsigned int exfat_find_free_bitmap(struct super_block *sb, unsigned int clu);
 int exfat_count_used_clusters(struct super_block *sb, unsigned int *ret_count);
+int exfat_trim_fs(struct inode *inode, struct fstrim_range *range);
 
 /* file.c */
 extern const struct file_operations exfat_file_operations;
diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index 679828e7be07..61a64a4d4e6a 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -351,7 +351,40 @@ int exfat_setattr(struct dentry *dentry, struct iattr *attr)
 
 long exfat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
+	struct inode *inode = file_inode(filp);
+	struct super_block *sb = inode->i_sb;
+
 	switch (cmd) {
+	case FITRIM:
+	{
+		struct request_queue *q = bdev_get_queue(sb->s_bdev);
+		struct fstrim_range range;
+		int ret = 0;
+
+		if (!capable(CAP_SYS_ADMIN))
+			return -EPERM;
+
+		if (!blk_queue_discard(q))
+			return -EOPNOTSUPP;
+
+		if (copy_from_user(&range, (struct fstrim_range __user *)arg,
+			sizeof(range)))
+			return -EFAULT;
+
+		range.minlen = max_t(unsigned int, range.minlen,
+					q->limits.discard_granularity);
+
+		ret = exfat_trim_fs(inode, &range);
+		if (ret < 0)
+			return ret;
+
+		if (copy_to_user((struct fstrim_range __user *)arg, &range,
+			sizeof(range)))
+			return -EFAULT;
+
+		return 0;
+	}
+
 	default:
 		return -ENOTTY;
 	}
-- 
2.27.0.83.g0313f36

