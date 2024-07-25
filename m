Return-Path: <linux-fsdevel+bounces-24224-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE8193BCB7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 08:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C211E1F22B3A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 06:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C4F4206B;
	Thu, 25 Jul 2024 06:46:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7691C6BE
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jul 2024 06:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721889980; cv=none; b=ootE2ZHZUAzFk0RlHzGDpm6B0KZWY+qFV3jmNXUG3Zs1E+wFSG+rlP2Clhtf5zzAPxpapvodiVp7nHO+9u075NT2Wj1N9mtcBs0ZNPo7Sx1ma+Gz/xAbqvHVZafQT6QDGnDe49vP15EmF88LN5VPkYJ3YKf05/vNDPAROf14kUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721889980; c=relaxed/simple;
	bh=2Rc5/VJ8Iym8vkuB9T5Yor9hF8Qc+zAg9WvEj76YILw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Bs61GmZFBu20kf2UPbZ8maxoZ20GTZdjpVvZxbYDMhc+ihaza4BScgoNpUJ+ekaWWiNWkgOxOUytA4g1ePrI60LVtMSxVdHppinZxA7Fbq0WjCw16yctuUEWRA76QKDJ5OD/wmYAhDGT2pDsulMbA96EwRYy8MUJDWcBw7tInQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WV1Wc1ML9z2ClPV;
	Thu, 25 Jul 2024 14:41:48 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id CE06E14044F;
	Thu, 25 Jul 2024 14:46:13 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 25 Jul
 2024 14:46:13 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <richard@nod.at>, <anton.ivanov@cambridgegreys.com>,
	<johannes@sipsolutions.net>, <brauner@kernel.org>
CC: <viro@zeniv.linux.org.uk>, <maze@google.com>,
	<linux-um@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
	<lihongbo22@huawei.com>
Subject: [PATCH] hostfs: fix the host directory parse when mounting.
Date: Thu, 25 Jul 2024 14:51:30 +0800
Message-ID: <20240725065130.1821964-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500022.china.huawei.com (7.185.36.66)

hostfs not keep the host directory when mounting. When the host
directory is none (default), fc->source is used as the host root
directory, and this is wrong. Here we use `parse_monolithic` to
handle the old mount path for parsing the root directory. For new
mount path, The `parse_param` is used for the host directory parse.

Reported-and-tested-by: Maciej Żenczykowski <maze@google.com>
Fixes: cd140ce9f611 ("hostfs: convert hostfs to use the new mount API")
Link: https://lore.kernel.org/all/CANP3RGceNzwdb7w=vPf5=7BCid5HVQDmz1K5kC9JG42+HVAh_g@mail.gmail.com/
Cc: Christian Brauner <brauner@kernel.org>
Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 fs/hostfs/hostfs_kern.c | 65 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 55 insertions(+), 10 deletions(-)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index 2b532670a561..48d2a21c3380 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -17,6 +17,7 @@
 #include <linux/writeback.h>
 #include <linux/mount.h>
 #include <linux/fs_context.h>
+#include <linux/fs_parser.h>
 #include <linux/namei.h>
 #include "hostfs.h"
 #include <init.h>
@@ -927,7 +928,6 @@ static const struct inode_operations hostfs_link_iops = {
 static int hostfs_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	struct hostfs_fs_info *fsi = sb->s_fs_info;
-	const char *host_root = fc->source;
 	struct inode *root_inode;
 	int err;
 
@@ -941,15 +941,6 @@ static int hostfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (err)
 		return err;
 
-	/* NULL is printed as '(null)' by printf(): avoid that. */
-	if (fc->source == NULL)
-		host_root = "";
-
-	fsi->host_root_path =
-		kasprintf(GFP_KERNEL, "%s/%s", root_ino, host_root);
-	if (fsi->host_root_path == NULL)
-		return -ENOMEM;
-
 	root_inode = hostfs_iget(sb, fsi->host_root_path);
 	if (IS_ERR(root_inode))
 		return PTR_ERR(root_inode);
@@ -975,6 +966,58 @@ static int hostfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	return 0;
 }
 
+enum hostfs_parma {
+	Opt_hostfs,
+};
+
+static const struct fs_parameter_spec hostfs_param_specs[] = {
+	fsparam_string_empty("hostfs",		Opt_hostfs),
+	{}
+};
+
+static int hostfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
+{
+	struct hostfs_fs_info *fsi = fc->s_fs_info;
+	struct fs_parse_result result;
+	char *host_root;
+	int opt;
+
+	opt = fs_parse(fc, hostfs_param_specs, param, &result);
+	if (opt < 0)
+		return opt;
+
+	switch (opt) {
+	case Opt_hostfs:
+		host_root = param->string;
+		if (!host_root)
+			host_root = "";
+		fsi->host_root_path =
+			kasprintf(GFP_KERNEL, "%s/%s", root_ino, host_root);
+		if (fsi->host_root_path == NULL)
+			return -ENOMEM;
+		break;
+	}
+
+	return 0;
+}
+
+static int hostfs_parse_monolithic(struct fs_context *fc, void *data)
+{
+	struct hostfs_fs_info *fsi = fc->s_fs_info;
+	char *host_root = (char *)data;
+
+	/* NULL is printed as '(null)' by printf(): avoid that. */
+	if (host_root == NULL)
+		host_root = "";
+
+	fsi->host_root_path =
+		kasprintf(GFP_KERNEL, "%s/%s", root_ino, host_root);
+	if (fsi->host_root_path == NULL)
+		return -ENOMEM;
+
+	return 0;
+}
+
 static int hostfs_fc_get_tree(struct fs_context *fc)
 {
 	return get_tree_nodev(fc, hostfs_fill_super);
@@ -992,6 +1035,8 @@ static void hostfs_fc_free(struct fs_context *fc)
 }
 
 static const struct fs_context_operations hostfs_context_ops = {
+	.parse_monolithic = hostfs_parse_monolithic,
+	.parse_param	= hostfs_parse_param,
 	.get_tree	= hostfs_fc_get_tree,
 	.free		= hostfs_fc_free,
 };
-- 
2.34.1


