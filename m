Return-Path: <linux-fsdevel+bounces-38230-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE809FDDFB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Dec 2024 09:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B2293A16AB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Dec 2024 08:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384AA148855;
	Sun, 29 Dec 2024 08:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Cet97t0r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E06255887
	for <linux-fsdevel@vger.kernel.org>; Sun, 29 Dec 2024 08:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735459949; cv=none; b=p77VfsaNF9YVeevmltDE2hDB8I1xR6lNYXO8J+EiWFW+I4IYnaPHItmxBkEPo5JcaCSzbc8dYenin9wWdi5LbpPVCQXw+40zeYxdLT8IwKH0xmCESMrzTg35jzy5/yZW3vt6F85kG6LVlBx3E092QhcV/nLHB4nLa/fbcBW6XQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735459949; c=relaxed/simple;
	bh=kL1cGxATTaZAA4F1+TRJSYTKVewjCNP/vvNl0vbnrbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eg53jvyj0wIh6Ug+qoD2GsViqFY6R8BJFgWzjMScTGodMf+lkx6WSGmt5ixn9HFo+O0A/Zw/QCvA1/wImhlvC9/7n+MUyZyXedSFiSLhWCAv5259u5nl02qtz92Rls1ODZaze63JkhkvKIw6Dic7Q5hFN5ZPEB2LzefmQf2Kff0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Cet97t0r; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=mRHQjBeY/zKYYqwggOyph1zW3dYy9X28LJVBScBtM2M=; b=Cet97t0r8AlACHf+8cV7OtjBGc
	6LMZ9EgdTy0k1RyNFEjwhSH2hP35pSEMT4ozqQZ3bGnBjDHt3YTfb9U3jYGecEPdVQsCWurtFNX5y
	y4438Z2+d4fgD2p39GorKzZFAXSqr5fOU5ZQsa6FMZ0CoRlYrGMEhkoRjuW95xKft8h+idNYNCyyM
	iF+LeZ4uBAIXbcO2QzXhefKcATuDT7jDE7/YcycQPrNWBNyKhFrOWBB/D+ZNgK3hlCd2hjLow38NX
	Wozlj8UWB4WASDWMF4531scTn7Nq4aRTAQT710fK5ZeqEJ+fsghPD2SAhSPjihwUUs+UmKuMHdX5X
	ky78G5Ag==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tRoPR-0000000DOj4-1aMT;
	Sun, 29 Dec 2024 08:12:25 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: gregkh@linuxfoundation.org
Subject: [PATCH 16/20] sof-client-ipc-flood-test: don't mess with ->d_name
Date: Sun, 29 Dec 2024 08:12:19 +0000
Message-ID: <20241229081223.3193228-16-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241229081223.3193228-1-viro@zeniv.linux.org.uk>
References: <20241229080948.GY1977892@ZenIV>
 <20241229081223.3193228-1-viro@zeniv.linux.org.uk>
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
 sound/soc/sof/sof-client-ipc-flood-test.c | 39 +++++++----------------
 1 file changed, 12 insertions(+), 27 deletions(-)

diff --git a/sound/soc/sof/sof-client-ipc-flood-test.c b/sound/soc/sof/sof-client-ipc-flood-test.c
index b35c98896968..11b6f7da2882 100644
--- a/sound/soc/sof/sof-client-ipc-flood-test.c
+++ b/sound/soc/sof/sof-client-ipc-flood-test.c
@@ -158,7 +158,6 @@ static ssize_t sof_ipc_flood_dfs_write(struct file *file, const char __user *buf
 	unsigned long ipc_duration_ms = 0;
 	bool flood_duration_test = false;
 	unsigned long ipc_count = 0;
-	struct dentry *dentry;
 	int err;
 	char *string;
 	int ret;
@@ -182,14 +181,7 @@ static ssize_t sof_ipc_flood_dfs_write(struct file *file, const char __user *buf
 	 * ipc_duration_ms test floods the DSP for the time specified
 	 * in the debugfs entry.
 	 */
-	dentry = file->f_path.dentry;
-	if (strcmp(dentry->d_name.name, DEBUGFS_IPC_FLOOD_COUNT) &&
-	    strcmp(dentry->d_name.name, DEBUGFS_IPC_FLOOD_DURATION)) {
-		ret = -EINVAL;
-		goto out;
-	}
-
-	if (!strcmp(dentry->d_name.name, DEBUGFS_IPC_FLOOD_DURATION))
+	if (debugfs_get_aux_num(file))
 		flood_duration_test = true;
 
 	/* test completion criterion */
@@ -252,22 +244,15 @@ static ssize_t sof_ipc_flood_dfs_read(struct file *file, char __user *buffer,
 	struct sof_ipc_flood_priv *priv = cdev->data;
 	size_t size_ret;
 
-	struct dentry *dentry;
+	if (*ppos)
+		return 0;
 
-	dentry = file->f_path.dentry;
-	if (!strcmp(dentry->d_name.name, DEBUGFS_IPC_FLOOD_COUNT) ||
-	    !strcmp(dentry->d_name.name, DEBUGFS_IPC_FLOOD_DURATION)) {
-		if (*ppos)
-			return 0;
+	count = min_t(size_t, count, strlen(priv->buf));
+	size_ret = copy_to_user(buffer, priv->buf, count);
+	if (size_ret)
+		return -EFAULT;
 
-		count = min_t(size_t, count, strlen(priv->buf));
-		size_ret = copy_to_user(buffer, priv->buf, count);
-		if (size_ret)
-			return -EFAULT;
-
-		*ppos += count;
-		return count;
-	}
+	*ppos += count;
 	return count;
 }
 
@@ -320,12 +305,12 @@ static int sof_ipc_flood_probe(struct auxiliary_device *auxdev,
 	priv->dfs_root = debugfs_create_dir(dev_name(dev), debugfs_root);
 	if (!IS_ERR_OR_NULL(priv->dfs_root)) {
 		/* create read-write ipc_flood_count debugfs entry */
-		debugfs_create_file(DEBUGFS_IPC_FLOOD_COUNT, 0644, priv->dfs_root,
-				    cdev, &sof_ipc_flood_fops);
+		debugfs_create_file_aux_num(DEBUGFS_IPC_FLOOD_COUNT, 0644,
+				    priv->dfs_root, cdev, 0, &sof_ipc_flood_fops);
 
 		/* create read-write ipc_flood_duration_ms debugfs entry */
-		debugfs_create_file(DEBUGFS_IPC_FLOOD_DURATION, 0644,
-				    priv->dfs_root, cdev, &sof_ipc_flood_fops);
+		debugfs_create_file_aux_num(DEBUGFS_IPC_FLOOD_DURATION, 0644,
+				    priv->dfs_root, cdev, 1, &sof_ipc_flood_fops);
 
 		if (auxdev->id == 0) {
 			/*
-- 
2.39.5


