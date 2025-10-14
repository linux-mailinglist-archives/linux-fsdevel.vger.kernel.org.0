Return-Path: <linux-fsdevel+bounces-64124-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D275ABD9496
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 14:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 916984E51A2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 12:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28AE7313264;
	Tue, 14 Oct 2025 12:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="J74RUQm/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82B43126C4
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 12:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760443899; cv=none; b=WcjQ2XN085gIDEdPbPVWUXP6xLgEoZv/GNidoL43MBaVsau/EFyGcIbxMxsOpKjbZDQ62EY1L8uAzsAQBbMIuze97lO1XngXseVEJdZY5ImtCv2GlggXxLqzFZNmv8EEpuWnbmxg0i8i+cFdCxwVyvWOMupEBbieZWv1JriFr1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760443899; c=relaxed/simple;
	bh=+vt+P1gKs7IA4qnalldJC+/KOdDH9y73KStqBM9tDjE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=a2XvGik7JO9rVXPZGHI9kEG4KE24rynAO+xNTlzqGVez5JdJkZ8us/yfAtmknZRSHu45OZ4BZMoapv++JHifCVJyVN7zBJa74FIhJLCBYb0wEZy/DUepSigL7r8xlZAB9++fzaVpXVW6aqCQKoYzBN55T8IIRzXq8NLQv4ChkDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=J74RUQm/; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20251014121133epoutp032155c9404b5779200ea90b5e893a2393~uWmS-fGhC0652206522epoutp039
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 12:11:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20251014121133epoutp032155c9404b5779200ea90b5e893a2393~uWmS-fGhC0652206522epoutp039
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1760443893;
	bh=0UgwlhGGtcRLvWvYU6JEi+YKutAgTxvOhKedb6kBv8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J74RUQm/+0gajJpvT9wdHpjxTNea007wFXgioeHyvKcAzalI8477xRXdhy9DrQp3N
	 KVmGwJM89Z6Y1lew8LW1B/ffXGlo05cKSLIVjO4UL48tklXtYCQUMEolfUF0T8rp/F
	 tWMlKsun1y/gV6dImsbWcHRczI09A4Ouu8mVEpqY=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20251014121132epcas5p3ea7317af9d533ca5d1036dabc2db7b84~uWmSZouOO1223112231epcas5p37;
	Tue, 14 Oct 2025 12:11:32 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.91]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4cmCkC3dbxz3hhT4; Tue, 14 Oct
	2025 12:11:31 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20251014121130epcas5p3b76f1a7ab53a57403275e9ba5d3549a3~uWmRAVzc30753207532epcas5p3U;
	Tue, 14 Oct 2025 12:11:30 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20251014121126epsmtip16a3d513bf9db4889a24bd46fa8cec6f3~uWmNIg9Sd1309013090epsmtip1j;
	Tue, 14 Oct 2025 12:11:26 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: jaegeuk@kernel.org, chao@kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, miklos@szeredi.hu, agruenba@redhat.com,
	trondmy@kernel.org, anna@kernel.org, akpm@linux-foundation.org,
	willy@infradead.org, mcgrof@kernel.org, clm@meta.com, david@fromorbit.com,
	amir73il@gmail.com, axboe@kernel.dk, hch@lst.de, ritesh.list@gmail.com,
	djwong@kernel.org, dave@stgolabs.net, wangyufei@vivo.com
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
	gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, linux-mm@kvack.org,
	gost.dev@samsung.com, kundan.kumar@samsung.com, anuj20.g@samsung.com,
	vishak.g@samsung.com, joshi.k@samsung.com
Subject: [PATCH v2 15/16] writeback: added support to change the number of
 writebacks using a sysfs attribute
Date: Tue, 14 Oct 2025 17:38:44 +0530
Message-Id: <20251014120845.2361-16-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251014120845.2361-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251014121130epcas5p3b76f1a7ab53a57403275e9ba5d3549a3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251014121130epcas5p3b76f1a7ab53a57403275e9ba5d3549a3
References: <20251014120845.2361-1-kundan.kumar@samsung.com>
	<CGME20251014121130epcas5p3b76f1a7ab53a57403275e9ba5d3549a3@epcas5p3.samsung.com>

User can change the number of writeback contexts with values 1 to num
cpus using the new sysfs attribute

echo <num_writbacks> > /sys/class/bdi/<maj>:<min>/nwritebacks

The sequence of operations when number of writebacks is changed :
  - fetch the superblock for a bdi
  - freezes the filesystem
  - iterate through inodes of the superblock and flush the pages
  - shutdown and free the writeback threads
  - allocate and register the wb threads
  - thaw the filesystem

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 fs/super.c                  | 23 +++++++++
 include/linux/backing-dev.h |  1 +
 include/linux/fs.h          |  1 +
 mm/backing-dev.c            | 93 +++++++++++++++++++++++++++++++++++++
 mm/page-writeback.c         |  8 ++++
 5 files changed, 126 insertions(+)

diff --git a/fs/super.c b/fs/super.c
index 7f876f32343a..19ae05880888 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -2072,6 +2072,29 @@ static inline bool may_unfreeze(struct super_block *sb, enum freeze_holder who,
 	return false;
 }
 
+struct super_block *freeze_bdi_super(struct backing_dev_info *bdi)
+{
+	struct super_block *sb_iter;
+	struct super_block *sb = NULL;
+
+	spin_lock(&sb_lock);
+	list_for_each_entry(sb_iter, &super_blocks, s_list) {
+		if (sb_iter->s_bdi == bdi) {
+			sb = sb_iter;
+			break;
+		}
+	}
+	spin_unlock(&sb_lock);
+
+	if (sb) {
+		atomic_inc(&sb->s_active);
+		freeze_super(sb, FREEZE_HOLDER_KERNEL, NULL);
+	}
+
+	return sb;
+}
+EXPORT_SYMBOL(freeze_bdi_super);
+
 /**
  * freeze_super - lock the filesystem and force it into a consistent state
  * @sb: the super to lock
diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index fb042e593c16..14f53183b8d1 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -144,6 +144,7 @@ int bdi_set_max_ratio_no_scale(struct backing_dev_info *bdi, unsigned int max_ra
 int bdi_set_min_bytes(struct backing_dev_info *bdi, u64 min_bytes);
 int bdi_set_max_bytes(struct backing_dev_info *bdi, u64 max_bytes);
 int bdi_set_strict_limit(struct backing_dev_info *bdi, unsigned int strict_limit);
+int bdi_set_nwritebacks(struct backing_dev_info *bdi, unsigned int nwritebacks);
 
 /*
  * Flags in backing_dev_info::capability
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 5199b0d49fa5..c7ed1c0b79f9 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2770,6 +2770,7 @@ extern int unregister_filesystem(struct file_system_type *);
 extern int vfs_statfs(const struct path *, struct kstatfs *);
 extern int user_statfs(const char __user *, struct kstatfs *);
 extern int fd_statfs(int, struct kstatfs *);
+struct super_block *freeze_bdi_super(struct backing_dev_info *bdi);
 int freeze_super(struct super_block *super, enum freeze_holder who,
 		 const void *freeze_owner);
 int thaw_super(struct super_block *super, enum freeze_holder who,
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 2a8f3b683b2d..5bfb9bf3ce52 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -35,6 +35,17 @@ LIST_HEAD(bdi_list);
 /* bdi_wq serves all asynchronous writeback tasks */
 struct workqueue_struct *bdi_wq;
 
+static int cgwb_bdi_init(struct backing_dev_info *bdi);
+static void cgwb_bdi_register(struct backing_dev_info *bdi,
+			      struct bdi_writeback_ctx *bdi_wb_ctx);
+static void cgwb_bdi_unregister(struct backing_dev_info *bdi,
+				struct bdi_writeback_ctx *bdi_wb_ctx);
+static void wb_shutdown(struct bdi_writeback *wb);
+static void wb_exit(struct bdi_writeback *wb);
+static struct bdi_writeback_ctx **wb_ctx_alloc(struct backing_dev_info *bdi,
+					       int num_ctxs);
+static void wb_ctx_free(struct backing_dev_info *bdi);
+
 #ifdef CONFIG_DEBUG_FS
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
@@ -469,6 +480,87 @@ static ssize_t strict_limit_show(struct device *dev,
 }
 static DEVICE_ATTR_RW(strict_limit);
 
+static ssize_t nwritebacks_store(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf, size_t count)
+{
+	struct backing_dev_info *bdi = dev_get_drvdata(dev);
+	unsigned int nwritebacks;
+	ssize_t ret;
+	struct super_block *sb = NULL;
+	struct bdi_writeback_ctx **wb_ctx;
+	struct bdi_writeback_ctx *bdi_wb_ctx;
+	struct inode *inode;
+
+	ret = kstrtouint(buf, 10, &nwritebacks);
+	if (ret < 0)
+		return ret;
+
+	if (nwritebacks < 1 || nwritebacks > num_online_cpus())
+		return -EINVAL;
+
+	if (nwritebacks == bdi->nr_wb_ctx)
+		return count;
+
+	wb_ctx = wb_ctx_alloc(bdi, nwritebacks);
+	if (!wb_ctx)
+		return -ENOMEM;
+
+	sb = freeze_bdi_super(bdi);
+	if (!sb)
+		return -EBUSY;
+
+	spin_lock(&sb->s_inode_list_lock);
+	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
+		filemap_write_and_wait(inode->i_mapping);
+		truncate_inode_pages_final(inode->i_mapping);
+#ifdef CONFIG_CGROUP_WRITEBACK
+		if (inode->i_wb) {
+			WARN_ON_ONCE(!(inode->i_state & I_CLEAR));
+			wb_put(inode->i_wb);
+			inode->i_wb = NULL;
+		}
+#endif
+	}
+	spin_unlock(&sb->s_inode_list_lock);
+
+	for_each_bdi_wb_ctx(bdi, bdi_wb_ctx) {
+		wb_shutdown(&bdi_wb_ctx->wb);
+		cgwb_bdi_unregister(bdi, bdi_wb_ctx);
+	}
+
+	for_each_bdi_wb_ctx(bdi, bdi_wb_ctx) {
+		WARN_ON_ONCE(test_bit(WB_registered, &bdi_wb_ctx->wb.state));
+		wb_exit(&bdi_wb_ctx->wb);
+		kfree(bdi_wb_ctx);
+	}
+	kfree(bdi->wb_ctx);
+
+	ret = bdi_set_nwritebacks(bdi, nwritebacks);
+
+	bdi->wb_ctx = wb_ctx;
+
+	cgwb_bdi_init(bdi);
+	for_each_bdi_wb_ctx(bdi, bdi_wb_ctx) {
+		cgwb_bdi_register(bdi, bdi_wb_ctx);
+		set_bit(WB_registered, &bdi_wb_ctx->wb.state);
+	}
+
+	thaw_super(sb, FREEZE_HOLDER_KERNEL, NULL);
+	deactivate_super(sb);
+
+	return ret;
+}
+
+static ssize_t nwritebacks_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct backing_dev_info *bdi = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%d\n", bdi->nr_wb_ctx);
+}
+static DEVICE_ATTR_RW(nwritebacks);
+
 static struct attribute *bdi_dev_attrs[] = {
 	&dev_attr_read_ahead_kb.attr,
 	&dev_attr_min_ratio.attr,
@@ -479,6 +571,7 @@ static struct attribute *bdi_dev_attrs[] = {
 	&dev_attr_max_bytes.attr,
 	&dev_attr_stable_pages_required.attr,
 	&dev_attr_strict_limit.attr,
+	&dev_attr_nwritebacks.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(bdi_dev);
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 6f283a777da6..1a43022affdd 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -818,6 +818,14 @@ int bdi_set_strict_limit(struct backing_dev_info *bdi, unsigned int strict_limit
 	return 0;
 }
 
+int bdi_set_nwritebacks(struct backing_dev_info *bdi, unsigned int nwritebacks)
+{
+	spin_lock_bh(&bdi_lock);
+	bdi->nr_wb_ctx = nwritebacks;
+	spin_unlock_bh(&bdi_lock);
+	return 0;
+}
+
 static unsigned long dirty_freerun_ceiling(unsigned long thresh,
 					   unsigned long bg_thresh)
 {
-- 
2.25.1


