Return-Path: <linux-fsdevel+bounces-38975-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99134A0A79B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Jan 2025 09:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6C65188685E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Jan 2025 08:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768BD183CBB;
	Sun, 12 Jan 2025 08:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="SmOQN784"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF98E1741D2
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 Jan 2025 08:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736669231; cv=none; b=VFZljHjQ9wQUQuD6kRq353A5lpl+qoMw8/t5NbbbsHz+EY+ZSXv7ajSSmZW6bhNc/2VcmBtASVqG2/BkyYzqfIpJBdfDgivOG65OvVBD4od2f3OBnbF5JBszycaS4wAzCx3JYkbGWYVcxj61ntKxBQSb+p8vv0+xjAXTzqx+IqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736669231; c=relaxed/simple;
	bh=kL1cGxATTaZAA4F1+TRJSYTKVewjCNP/vvNl0vbnrbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gNZqIRAkJ8hhCmUYLCoiUVwOBuOS5S9rrmZL+yV8kGVDcRvXD8f8dCSaLVn39JrkVty/6HmyhhniJPuBDaoYigdsqlGJoEh0CduJvNJvuQOvOw1EuU9euX++dR1rJqtSBvl2ZsicJ6SJ2TVqcFEdXb8VGoD4ieezRQYNi3sH77Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=SmOQN784; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=mRHQjBeY/zKYYqwggOyph1zW3dYy9X28LJVBScBtM2M=; b=SmOQN784QK9rD3WK+SEHtXb5ag
	uxj5iYwZiRD2N8x6Hmn67XvE5WReHLflU+tI9WcrnpOq0KUPvSN2U6bdun1+GX5WwDS/pIv4H5ijG
	RCtgV6kA+YMGPNXtR7g7wWj43vRomYWkQtRhA3vIQ4UQovBepPqXdfBPtO5oUoPGZ/SxtnXAVoQE/
	MEcCQT+e/HK+EQdiUVpagqg57ToLLvXWyGrIa8NKmGkKvSUN1YDI1oaAwGbQ8wFqZ/xKdPK1vA0t3
	QAZwH4CyHYs4/pZ8QOnKs694HPYvTfkrInY/7SLRQsYAa6QRNZ7J8IjBTgp5LZ3hy6cdSqcRGRpuH
	lLmfOHrw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tWszz-00000000ak9-11i9;
	Sun, 12 Jan 2025 08:07:07 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: gregkh@linuxfoundation.org
Subject: [PATCH v2 16/21] sof-client-ipc-flood-test: don't mess with ->d_name
Date: Sun, 12 Jan 2025 08:07:00 +0000
Message-ID: <20250112080705.141166-16-viro@zeniv.linux.org.uk>
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


