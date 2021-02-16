Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B55031D2B8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Feb 2021 23:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbhBPWe2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Feb 2021 17:34:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbhBPWeM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Feb 2021 17:34:12 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDCDC061786;
        Tue, 16 Feb 2021 14:33:31 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id t2so267262pjq.2;
        Tue, 16 Feb 2021 14:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TJysXv8APtrCULxq5p/h5QAaLxz99yamVkXsF+GpYMY=;
        b=uNTFmRKMa9MrvKzfPVIKnZlz6gYnyyL9LjJmJjqHbgXysj/XXj/imjCMwD7es0FLWU
         VI3l0TpOkWJ8prFhqBgCO0UJaSz95ubuDwWNex7ofTRoDkk0dUPpCDlCH8AMEYqx5+sX
         o6pm2wJZUfcKe55FhuHB0Jadcr+mHog6G7ghflm06dB7iKtc7naYJiay5+2vIYOkT36e
         NkSBrEW1nMK/nlLO8uOBD22NUBTRy3Al2AMoHmETzjT+g/k9cRN4IDhNA9q83Bw55viW
         0plE/pe5UKw+GCj/E1bDNyNlrPLD+bWxbq4y1r6f98EW5xnIXvvFfMApive3dM6aPu3R
         SnPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TJysXv8APtrCULxq5p/h5QAaLxz99yamVkXsF+GpYMY=;
        b=l9bcvZ0WFsVbr36PGQI8es8pgxeeHqbrBPlOG0BjPk10uZbxzDNSxvOejxuaIBoIJ8
         oubfa3UQDjXEp9RXq6jqutQ938UMykKswKMkBZwBF8ByEfFPmynIFSOYvPfzY2bzYBKv
         i3+6WqCYj8WTcFkOPq8wTXEQ8y/pjx6TXHQ/KKGw7kKNGI9WnGuLq2TlrlRQlh8Z2pkW
         gq/g0eRKsagLc/3rFXt2KlHHkZV6yBmrv1aMfapgdPX3Vk9O/c27y6nPeKOD+sibMPj9
         4Cws1RpclP+p2BFKOoE3lzepq+UUdvK6g+d6XpTVx3+lvYalorcKgL8gigSu5kCrQ3jy
         P5ZQ==
X-Gm-Message-State: AOAM532PMqgsgiMGibwEEY57PIlwYXBLJwa9JXqaQoCHd1I+pxbSDEuo
        fkH1xFA6Hl2P5tzrDK6z8oQ=
X-Google-Smtp-Source: ABdhPJwprwHP/Cs2LSPRlIUzMr2mbIllLDYLfCAcwubDtdrsxSZJv4nVsP9M9FG2fQDQbb/tIuHVeQ==
X-Received: by 2002:a17:90a:fb87:: with SMTP id cp7mr6202873pjb.121.1613514811348;
        Tue, 16 Feb 2021 14:33:31 -0800 (PST)
Received: from localhost.localdomain ([27.122.242.75])
        by smtp.gmail.com with ESMTPSA id w5sm579pfb.11.2021.02.16.14.33.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Feb 2021 14:33:31 -0800 (PST)
From:   Hyeongseok Kim <hyeongseok@gmail.com>
To:     namjae.jeon@samsung.com, sj1557.seo@samsung.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hyeongseok Kim <hyeongseok@gmail.com>
Subject: [PATCH v2 2/2] exfat: add support FITRIM ioctl
Date:   Wed, 17 Feb 2021 07:33:06 +0900
Message-Id: <20210216223306.47693-3-hyeongseok@gmail.com>
X-Mailer: git-send-email 2.27.0.83.g0313f36
In-Reply-To: <20210216223306.47693-1-hyeongseok@gmail.com>
References: <20210216223306.47693-1-hyeongseok@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

add FITRIM ioctl to support trimming mounted filesystem

Signed-off-by: Hyeongseok Kim <hyeongseok@gmail.com>
---
 fs/exfat/balloc.c   | 81 +++++++++++++++++++++++++++++++++++++++++++++
 fs/exfat/exfat_fs.h |  1 +
 fs/exfat/file.c     | 33 ++++++++++++++++++
 3 files changed, 115 insertions(+)

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
index 679828e7be07..0cbad1577841 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -349,9 +349,42 @@ int exfat_setattr(struct dentry *dentry, struct iattr *attr)
 	return error;
 }
 
+static int exfat_ioctl_fitrim(struct inode *inode, unsigned long arg)
+{
+	struct super_block *sb = inode->i_sb;
+	struct request_queue *q = bdev_get_queue(sb->s_bdev);
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
 long exfat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
+	struct inode *inode = file_inode(filp);
+
 	switch (cmd) {
+	case FITRIM:
+		return exfat_ioctl_fitrim(inode, arg);
 	default:
 		return -ENOTTY;
 	}
-- 
2.27.0.83.g0313f36

