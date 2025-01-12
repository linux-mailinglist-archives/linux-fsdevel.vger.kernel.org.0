Return-Path: <linux-fsdevel+bounces-38962-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F3FA0A78D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Jan 2025 09:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC8321886962
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Jan 2025 08:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461E3185955;
	Sun, 12 Jan 2025 08:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="VbjPs4H5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C2A1632DF
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 Jan 2025 08:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736669229; cv=none; b=etAZDBzTi0UewqvH+p3RhHkokLaFNeLpaVlPdDxNnBEokyipHApDv04OaSXuK8NLhPwI74+7JwJy2vU6Vqo+Req/4/vQCazp+dmZ48mTBqxz87qaLb5eaQqRkPSO03XQK80aZs1Hc9/aLsHLrlLupGZdG1uDdajxRNvmkeLDcFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736669229; c=relaxed/simple;
	bh=JmsdoPD/bMeM7aHLi9HnuwqPvP1LegNfxDqAR2y1otw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J2pugT89cK97xuWaea/3P4InkX0ccwwSGmNwFxa0VTJEQWmVy4a1JEDMzlFu7YiANCXTsVWZQl0+m+kZe2Ay8WOd8tnyaLnzSNWvDVWWjy5GCZa92iOF+i6X2aAoP4wfjaL8YJNTFpilNFL75i2T5UpcCBWXREdYcjK4Hqw3AJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=VbjPs4H5; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=7lqeus4QTeCN/hjlDsViFag5rEIdwqFfljAzIRQIogY=; b=VbjPs4H5b53dZijChVHOH+3xDg
	2CNjzHlNNVkhuOYf4wA5KZRoQNsMZaNfjy4a4z+0V3ekcUoqPh6Fr3gOoJvaG0lsvZ4PPNjiEs3KN
	Mybxrg86GQsAf6Hm8jVpSgso9lpcOOzhQkcjIKlE+1lGeD4vgQ6+vIBVoCX5/BfM3/WBcLauRuPrD
	/8Yqpj7JpM9lqOwnGKaMB+2ZiIAFAjb4l5Mrmg7GlxPvYoYCGQnRVZFpIKnFdBK0ztJwSPOigleKC
	AXwHGF0I5sPgeqHDX/bIEmfSfDGBg3Q+8SFUla7SavBLVZLY7qelMxN73nNq/B/zP/HBJT8+YUGB0
	py7nhTqg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tWszy-00000000ajY-24xw;
	Sun, 12 Jan 2025 08:07:06 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: gregkh@linuxfoundation.org
Subject: [PATCH v2 09/21] b43legacy: make use of debugfs_get_aux()
Date: Sun, 12 Jan 2025 08:06:53 +0000
Message-ID: <20250112080705.141166-9-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250112080705.141166-1-viro@zeniv.linux.org.uk>
References: <20250112080545.GX1977892@ZenIV>
 <20250112080705.141166-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 .../net/wireless/broadcom/b43legacy/debugfs.c | 26 ++++++++-----------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/broadcom/b43legacy/debugfs.c b/drivers/net/wireless/broadcom/b43legacy/debugfs.c
index 6b0e8d117061..5d04bcc216e5 100644
--- a/drivers/net/wireless/broadcom/b43legacy/debugfs.c
+++ b/drivers/net/wireless/broadcom/b43legacy/debugfs.c
@@ -31,7 +31,6 @@ static struct dentry *rootdir;
 struct b43legacy_debugfs_fops {
 	ssize_t (*read)(struct b43legacy_wldev *dev, char *buf, size_t bufsize);
 	int (*write)(struct b43legacy_wldev *dev, const char *buf, size_t count);
-	struct file_operations fops;
 	/* Offset of struct b43legacy_dfs_file in struct b43legacy_dfsentry */
 	size_t file_struct_offset;
 	/* Take wl->irq_lock before calling read/write? */
@@ -188,7 +187,7 @@ static ssize_t b43legacy_debugfs_read(struct file *file, char __user *userbuf,
 				size_t count, loff_t *ppos)
 {
 	struct b43legacy_wldev *dev;
-	struct b43legacy_debugfs_fops *dfops;
+	const struct b43legacy_debugfs_fops *dfops;
 	struct b43legacy_dfs_file *dfile;
 	ssize_t ret;
 	char *buf;
@@ -208,8 +207,7 @@ static ssize_t b43legacy_debugfs_read(struct file *file, char __user *userbuf,
 		goto out_unlock;
 	}
 
-	dfops = container_of(debugfs_real_fops(file),
-			     struct b43legacy_debugfs_fops, fops);
+	dfops = debugfs_get_aux(file);
 	if (!dfops->read) {
 		err = -ENOSYS;
 		goto out_unlock;
@@ -257,7 +255,7 @@ static ssize_t b43legacy_debugfs_write(struct file *file,
 				 size_t count, loff_t *ppos)
 {
 	struct b43legacy_wldev *dev;
-	struct b43legacy_debugfs_fops *dfops;
+	const struct b43legacy_debugfs_fops *dfops;
 	char *buf;
 	int err = 0;
 
@@ -275,8 +273,7 @@ static ssize_t b43legacy_debugfs_write(struct file *file,
 		goto out_unlock;
 	}
 
-	dfops = container_of(debugfs_real_fops(file),
-			     struct b43legacy_debugfs_fops, fops);
+	dfops = debugfs_get_aux(file);
 	if (!dfops->write) {
 		err = -ENOSYS;
 		goto out_unlock;
@@ -308,17 +305,16 @@ static ssize_t b43legacy_debugfs_write(struct file *file,
 	return err ? err : count;
 }
 
+static struct debugfs_short_fops debugfs_ops = {
+	.read	= b43legacy_debugfs_read,
+	.write	= b43legacy_debugfs_write,
+	.llseek = generic_file_llseek
+};
 
 #define B43legacy_DEBUGFS_FOPS(name, _read, _write, _take_irqlock)	\
 	static struct b43legacy_debugfs_fops fops_##name = {		\
 		.read	= _read,				\
 		.write	= _write,				\
-		.fops	= {					\
-			.open	= simple_open,				\
-			.read	= b43legacy_debugfs_read,		\
-			.write	= b43legacy_debugfs_write,		\
-			.llseek = generic_file_llseek,			\
-		},						\
 		.file_struct_offset = offsetof(struct b43legacy_dfsentry, \
 					       file_##name),	\
 		.take_irqlock	= _take_irqlock,		\
@@ -386,9 +382,9 @@ void b43legacy_debugfs_add_device(struct b43legacy_wldev *dev)
 
 #define ADD_FILE(name, mode)	\
 	do {							\
-		debugfs_create_file(__stringify(name), mode,	\
+		debugfs_create_file_aux(__stringify(name), mode,	\
 				    e->subdir, dev,		\
-				    &fops_##name.fops);		\
+				    &fops_##name, &debugfs_ops);	\
 	} while (0)
 
 
-- 
2.39.5


