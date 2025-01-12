Return-Path: <linux-fsdevel+bounces-38976-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6AAA0A79C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Jan 2025 09:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1900164D33
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Jan 2025 08:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F2E17335C;
	Sun, 12 Jan 2025 08:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="JrHXz/nh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750ED1714A1
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 Jan 2025 08:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736669232; cv=none; b=KCq1EKscEV6QRCsdqj5EcfSUluZO6PyX1kGe5FVTwvsMaG/HSWpPhCe0GDoWkfrKqt5D2Xi87D8k7hrhaglmeQR2SDEf/05MbZBYLS4Lvos+V+xH9BBdZePt/+MVYGHj3N/d5pBQxpM8yIMOmjFtlZ+KePqMWsAsinkcb76M60s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736669232; c=relaxed/simple;
	bh=6XsNsTnZAZUO1qs9XomY6qjRZLJ8wvbLGA8kGX+Yy/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JpK17CHhrBUgnwvGFdnDQcqgw7xau1h/fE3XLxC/PYE2ZtcFERB/4sJWKEbumqt0Q90ofbcIEj7u9ZLlo/OkTIUz/l0f3nhgeoBtXFyYdR0lCAy5i1F1MM1EiDLN/NiMj+qsEnmY8C+W750VHxhx5Oc+/Xyr/K5VuvFicuB+CW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=JrHXz/nh; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=M7FLqGDbjN4vMNrJ5LlcXHAwEz7+9PRw9Uk0Oh7Yg9k=; b=JrHXz/nho9w2WAaqlJHWWNiRlj
	oVq4FutMRRlznVX5DENWcTRD9dUi+4P/tgzr9q1GPMWSny8TJCTN4j1OJae4d6ccOFtDId7/gkSma
	5t+iMjV3VLsiv8VGwlNjB/Y8xYOk+84ZxL9bLYIMOm/b9ERTvxvfkB+ZmcQuitUrDRFkK6FMo0OhI
	+SHCDZNn7dVdLmKkPzIYA4v2Iw2XD8knoGnCSjrTPBVnyuVy3m3sZDIdHZp7TwP+hqZADVJk1MBPk
	LJYHfG7bZq88JxG6MKKzU6x0GCi68ZqzYLooOL+TVlaE5OG4zXLvlsEAMCbnf/giQz+c8N5fQ3eBt
	NeGLI7sA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tWszy-00000000ajt-3yTw;
	Sun, 12 Jan 2025 08:07:06 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: gregkh@linuxfoundation.org
Subject: [PATCH v2 13/21] mtu3: don't mess wiht ->d_iname
Date: Sun, 12 Jan 2025 08:06:57 +0000
Message-ID: <20250112080705.141166-13-viro@zeniv.linux.org.uk>
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

use debugfs_{create_file,get}_aux() instead.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/usb/mtu3/mtu3_debugfs.c | 40 ++++++---------------------------
 1 file changed, 7 insertions(+), 33 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3_debugfs.c b/drivers/usb/mtu3/mtu3_debugfs.c
index f0de99858353..deeac2c8f589 100644
--- a/drivers/usb/mtu3/mtu3_debugfs.c
+++ b/drivers/usb/mtu3/mtu3_debugfs.c
@@ -256,16 +256,7 @@ static const struct mtu3_file_map mtu3_ep_files[] = {
 
 static int mtu3_ep_open(struct inode *inode, struct file *file)
 {
-	const char *file_name = file_dentry(file)->d_iname;
-	const struct mtu3_file_map *f_map;
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(mtu3_ep_files); i++) {
-		f_map = &mtu3_ep_files[i];
-
-		if (strcmp(f_map->name, file_name) == 0)
-			break;
-	}
+	const struct mtu3_file_map *f_map = debugfs_get_aux(file);
 
 	return single_open(file, f_map->show, inode->i_private);
 }
@@ -288,17 +279,8 @@ static const struct debugfs_reg32 mtu3_prb_regs[] = {
 
 static int mtu3_probe_show(struct seq_file *sf, void *unused)
 {
-	const char *file_name = file_dentry(sf->file)->d_iname;
 	struct mtu3 *mtu = sf->private;
-	const struct debugfs_reg32 *regs;
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(mtu3_prb_regs); i++) {
-		regs = &mtu3_prb_regs[i];
-
-		if (strcmp(regs->name, file_name) == 0)
-			break;
-	}
+	const struct debugfs_reg32 *regs = debugfs_get_aux(sf->file);
 
 	seq_printf(sf, "0x%04x - 0x%08x\n", (u32)regs->offset,
 		   mtu3_readl(mtu->ippc_base, (u32)regs->offset));
@@ -314,13 +296,11 @@ static int mtu3_probe_open(struct inode *inode, struct file *file)
 static ssize_t mtu3_probe_write(struct file *file, const char __user *ubuf,
 				size_t count, loff_t *ppos)
 {
-	const char *file_name = file_dentry(file)->d_iname;
 	struct seq_file *sf = file->private_data;
 	struct mtu3 *mtu = sf->private;
-	const struct debugfs_reg32 *regs;
+	const struct debugfs_reg32 *regs = debugfs_get_aux(file);
 	char buf[32];
 	u32 val;
-	int i;
 
 	if (copy_from_user(&buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
 		return -EFAULT;
@@ -328,12 +308,6 @@ static ssize_t mtu3_probe_write(struct file *file, const char __user *ubuf,
 	if (kstrtou32(buf, 0, &val))
 		return -EINVAL;
 
-	for (i = 0; i < ARRAY_SIZE(mtu3_prb_regs); i++) {
-		regs = &mtu3_prb_regs[i];
-
-		if (strcmp(regs->name, file_name) == 0)
-			break;
-	}
 	mtu3_writel(mtu->ippc_base, (u32)regs->offset, val);
 
 	return count;
@@ -358,8 +332,8 @@ static void mtu3_debugfs_create_prb_files(struct mtu3 *mtu)
 
 	for (i = 0; i < ARRAY_SIZE(mtu3_prb_regs); i++) {
 		regs = &mtu3_prb_regs[i];
-		debugfs_create_file(regs->name, 0644, dir_prb,
-				    mtu, &mtu3_probe_fops);
+		debugfs_create_file_aux(regs->name, 0644, dir_prb,
+				    mtu, regs, &mtu3_probe_fops);
 	}
 
 	mtu3_debugfs_regset(mtu, mtu->ippc_base, mtu3_prb_regs,
@@ -379,8 +353,8 @@ static void mtu3_debugfs_create_ep_dir(struct mtu3_ep *mep,
 	for (i = 0; i < ARRAY_SIZE(mtu3_ep_files); i++) {
 		files = &mtu3_ep_files[i];
 
-		debugfs_create_file(files->name, 0444, dir_ep,
-				    mep, &mtu3_ep_fops);
+		debugfs_create_file_aux(files->name, 0444, dir_ep,
+				    mep, files, &mtu3_ep_fops);
 	}
 }
 
-- 
2.39.5


