Return-Path: <linux-fsdevel+bounces-62467-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1FAB93DF9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 03:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DED15482104
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 01:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10E02D0619;
	Tue, 23 Sep 2025 01:29:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C2C2701B4;
	Tue, 23 Sep 2025 01:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758590978; cv=none; b=jirTgIbVshynbOfgqg1ZmH/zLUWeYuE+92xPcguzwJnaEHMvNCQa6/bhHTxumWexqNDTLPd10UL4CdsyHI6Xm+VfylZrrNvmkHHjhr/9tv8FGZ3Zj4+1n6LZuu/6mR+qJ1vZWSWzKy08D90qvdUTU6HTeJSUuMMSkn/4QK//jKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758590978; c=relaxed/simple;
	bh=C2oiyfr9F2erbOeu81kYs9iQQq2Amb2HQt4fHUjbKMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fy/nygvSmRsAGFx27KICcf+GAPm2DwdfaXLdn1kC0Twvs19PEjVQ5+XmZ669+kOsXfIoSK94AWc9oI9LfSipCjBQgXCTYojSbtUlfupxwpqKrKQMNfRw/keOEnrtP/4njKyvFu9teOnY4D9DC1pIZqc5iwfVZmi7u/nQ3dc9UGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cW2Sv2txyzYQv3W;
	Tue, 23 Sep 2025 09:29:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 8DAE01A103D;
	Tue, 23 Sep 2025 09:29:24 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP4 (Coremail) with SMTP id gCh0CgAXKWHq99FoGYYGAg--.10941S11;
	Tue, 23 Sep 2025 09:29:24 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	libaokun1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH 07/13] ext4: add mext_check_validity() to do basic check
Date: Tue, 23 Sep 2025 09:27:17 +0800
Message-ID: <20250923012724.2378858-8-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250923012724.2378858-1-yi.zhang@huaweicloud.com>
References: <20250923012724.2378858-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXKWHq99FoGYYGAg--.10941S11
X-Coremail-Antispam: 1UD129KBjvJXoW3Xr43Ar4xGFyfJFWxKrWktFb_yoW7Xr15pF
	yxCr13X34jqas0k3yrtFsxXr1Y93WxKr42grZ3Xw48XFWDCF9Igw1DJa1vv3WUtrWDJ3y0
	qF42kry7ua17JaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
	WIevJa73UjIFyTuYvjfUriihUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Currently, the basic validation checks during the move extent operation
are scattered across __ext4_ioctl() and ext4_move_extents(), which makes
the code somewhat disorganized. Introduce a new helper,
mext_check_validity(), to handle these checks. This change involves only
code relocation without any logical modifications.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/ioctl.c       |  10 -----
 fs/ext4/move_extent.c | 102 +++++++++++++++++++++++++++---------------
 2 files changed, 65 insertions(+), 47 deletions(-)

diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 84e3c73952d7..a0d3a951ae85 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -1349,16 +1349,6 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		if (!(fd_file(donor)->f_mode & FMODE_WRITE))
 			return -EBADF;
 
-		if (ext4_has_feature_bigalloc(sb)) {
-			ext4_msg(sb, KERN_ERR,
-				 "Online defrag not supported with bigalloc");
-			return -EOPNOTSUPP;
-		} else if (IS_DAX(inode)) {
-			ext4_msg(sb, KERN_ERR,
-				 "Online defrag not supported with DAX");
-			return -EOPNOTSUPP;
-		}
-
 		err = mnt_want_write_file(filp);
 		if (err)
 			return err;
diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index 6175906c7119..92f4cba3516d 100644
--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -442,6 +442,68 @@ move_extent_per_page(struct file *o_filp, struct inode *donor_inode,
 	goto unlock_folios;
 }
 
+/*
+ * Check the validity of the basic filesystem environment and the
+ * inodes' support status.
+ */
+static int mext_check_validity(struct inode *orig_inode,
+			       struct inode *donor_inode)
+{
+	struct super_block *sb = orig_inode->i_sb;
+
+	if (ext4_has_feature_bigalloc(sb)) {
+		ext4_msg(sb, KERN_ERR,
+			 "Online defrag not supported with bigalloc");
+		return -EOPNOTSUPP;
+	}
+
+	if (IS_DAX(orig_inode)) {
+		ext4_msg(sb, KERN_ERR,
+			 "Online defrag not supported with DAX");
+		return -EOPNOTSUPP;
+	}
+
+	/*
+	 * TODO: it's not obvious how to swap blocks for inodes with full
+	 * journaling enabled.
+	 */
+	if (ext4_should_journal_data(orig_inode) ||
+	    ext4_should_journal_data(donor_inode)) {
+		ext4_msg(sb, KERN_ERR,
+			 "Online defrag not supported with data journaling");
+		return -EOPNOTSUPP;
+	}
+
+	if (IS_ENCRYPTED(orig_inode) || IS_ENCRYPTED(donor_inode)) {
+		ext4_msg(sb, KERN_ERR,
+			 "Online defrag not supported for encrypted files");
+		return -EOPNOTSUPP;
+	}
+
+	/* origin and donor should be different inodes */
+	if (orig_inode == donor_inode) {
+		ext4_debug("ext4 move extent: The argument files should not be same inode [ino:orig %lu, donor %lu]\n",
+			   orig_inode->i_ino, donor_inode->i_ino);
+		return -EINVAL;
+	}
+
+	/* origin and donor should belone to the same filesystem */
+	if (orig_inode->i_sb != donor_inode->i_sb) {
+		ext4_debug("ext4 move extent: The argument files should be in same FS [ino:orig %lu, donor %lu]\n",
+			   orig_inode->i_ino, donor_inode->i_ino);
+		return -EINVAL;
+	}
+
+	/* Regular file check */
+	if (!S_ISREG(orig_inode->i_mode) || !S_ISREG(donor_inode->i_mode)) {
+		ext4_debug("ext4 move extent: The argument files should be regular file [ino:orig %lu, donor %lu]\n",
+			   orig_inode->i_ino, donor_inode->i_ino);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 /**
  * mext_check_arguments - Check whether move extent can be done
  *
@@ -567,43 +629,9 @@ ext4_move_extents(struct file *o_filp, struct file *d_filp, __u64 orig_blk,
 	ext4_lblk_t d_start = donor_blk;
 	int ret;
 
-	if (orig_inode->i_sb != donor_inode->i_sb) {
-		ext4_debug("ext4 move extent: The argument files "
-			"should be in same FS [ino:orig %lu, donor %lu]\n",
-			orig_inode->i_ino, donor_inode->i_ino);
-		return -EINVAL;
-	}
-
-	/* orig and donor should be different inodes */
-	if (orig_inode == donor_inode) {
-		ext4_debug("ext4 move extent: The argument files should not "
-			"be same inode [ino:orig %lu, donor %lu]\n",
-			orig_inode->i_ino, donor_inode->i_ino);
-		return -EINVAL;
-	}
-
-	/* Regular file check */
-	if (!S_ISREG(orig_inode->i_mode) || !S_ISREG(donor_inode->i_mode)) {
-		ext4_debug("ext4 move extent: The argument files should be "
-			"regular file [ino:orig %lu, donor %lu]\n",
-			orig_inode->i_ino, donor_inode->i_ino);
-		return -EINVAL;
-	}
-
-	/* TODO: it's not obvious how to swap blocks for inodes with full
-	   journaling enabled */
-	if (ext4_should_journal_data(orig_inode) ||
-	    ext4_should_journal_data(donor_inode)) {
-		ext4_msg(orig_inode->i_sb, KERN_ERR,
-			 "Online defrag not supported with data journaling");
-		return -EOPNOTSUPP;
-	}
-
-	if (IS_ENCRYPTED(orig_inode) || IS_ENCRYPTED(donor_inode)) {
-		ext4_msg(orig_inode->i_sb, KERN_ERR,
-			 "Online defrag not supported for encrypted files");
-		return -EOPNOTSUPP;
-	}
+	ret = mext_check_validity(orig_inode, donor_inode);
+	if (ret)
+		return ret;
 
 	/* Protect orig and donor inodes against a truncate */
 	lock_two_nondirectories(orig_inode, donor_inode);
-- 
2.46.1


