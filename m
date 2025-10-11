Return-Path: <linux-fsdevel+bounces-63840-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3140DBCF304
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Oct 2025 11:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE780420AB3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Oct 2025 09:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91DFF22422E;
	Sat, 11 Oct 2025 09:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="s/FXj8qa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987FA33D8
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 Oct 2025 09:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760175215; cv=none; b=Yq+AU19bElsumq6dS+66+E1sdOFCoVkdvAGjCKoD0h154q6UO/BgKryrxegQdKl7BEs1VXzKzh7ZFRU7uy4GXd4LzfecFzOPetHgO5OJDUJ2ei6eb082HarAIDcvmv9OoRoEjVfFLDNpp0WVpUY1OfqGEYK5cX/up8K6OO6IibQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760175215; c=relaxed/simple;
	bh=G4zs8KEfGccYngAhH3LNcbxr54FoSijCs9C5XPzbOuE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gNyx0kIGYzX4qhF1wHaYnLOBRtTc/UkIM+tkhz44hmNrNytiq5xbEdPI+VGNtNqPCOttTFNG6XbozRhkJHH5/HOhBkOYDh6bVMdHQLv6nwDw8YAS6TnQvg6nQJfFinuGljNPXbi7/EApCCNDvglan2TydR9mSWJX/HaNaQe5hiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=s/FXj8qa; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ggOs2eAUyo4VXT1Pr+8pBElLmd5laphuk6GJ+x94CPU=;
	b=s/FXj8qapy0aucC0yRdED0WqNkV/UN3jfUkKNvl0TPiLMj0ukdb4x6JBR7WCjVkbzn42YlJ3q
	rR/t/viNbnsmLxMScKfrptU8kbmtJ3lSNhVJq0B9Yl376ILQQGf78WkdzuNlPOpDGMEGKIoM8GK
	lX/f9e3QOBj51OJpfB9loRQ=
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4ckJLr0ZXFzmV6w;
	Sat, 11 Oct 2025 17:33:08 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id D8772140123;
	Sat, 11 Oct 2025 17:33:25 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemr500015.china.huawei.com
 (7.202.195.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 11 Oct
 2025 17:33:25 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <richard@nod.at>, <anton.ivanov@cambridgegreys.com>,
	<johannes@sipsolutions.net>, <geoff@geoffthorpe.net>
CC: <linux-um@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
	<brauner@kernel.org>, <lihongbo22@huawei.com>
Subject: [PATCH] hostfs: Fix only passing host root in boot stage with new mount
Date: Sat, 11 Oct 2025 09:22:35 +0000
Message-ID: <20251011092235.29880-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemr500015.china.huawei.com (7.202.195.162)

In the old mount proceedure, hostfs could only pass root directory during
boot. This is because it constructed the root directory using the @root_ino
event without any mount options. However, when using it with the new mount
API, this step is no longer triggered. As a result, if users mounts without
specifying any mount options, the @host_root_path remains uninitialized. To
prevent this issue, the @host_root_path should be initialized at the time
of allocation.

Reported-by: Geoffrey Thorpe <geoff@geoffthorpe.net>
Closes: https://lore.kernel.org/all/643333a0-f434-42fb-82ac-d25a0b56f3b7@geoffthorpe.net/
Fixes: cd140ce9f611 ("hostfs: convert hostfs to use the new mount API")
Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 fs/hostfs/hostfs_kern.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index 1e1acf5775ab..86455eebbf6c 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -979,7 +979,7 @@ static int hostfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 {
 	struct hostfs_fs_info *fsi = fc->s_fs_info;
 	struct fs_parse_result result;
-	char *host_root;
+	char *host_root, *tmp_root;
 	int opt;
 
 	opt = fs_parse(fc, hostfs_param_specs, param, &result);
@@ -990,11 +990,13 @@ static int hostfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	case Opt_hostfs:
 		host_root = param->string;
 		if (!*host_root)
-			host_root = "";
-		fsi->host_root_path =
-			kasprintf(GFP_KERNEL, "%s/%s", root_ino, host_root);
-		if (fsi->host_root_path == NULL)
+			break;
+		tmp_root = kasprintf(GFP_KERNEL, "%s%s",
+				     fsi->host_root_path, host_root);
+		if (!tmp_root)
 			return -ENOMEM;
+		kfree(fsi->host_root_path);
+		fsi->host_root_path = tmp_root;
 		break;
 	}
 
@@ -1004,17 +1006,17 @@ static int hostfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 static int hostfs_parse_monolithic(struct fs_context *fc, void *data)
 {
 	struct hostfs_fs_info *fsi = fc->s_fs_info;
-	char *host_root = (char *)data;
+	char *tmp_root, *host_root = (char *)data;
 
 	/* NULL is printed as '(null)' by printf(): avoid that. */
 	if (host_root == NULL)
-		host_root = "";
+		return 0;
 
-	fsi->host_root_path =
-		kasprintf(GFP_KERNEL, "%s/%s", root_ino, host_root);
-	if (fsi->host_root_path == NULL)
+	tmp_root = kasprintf(GFP_KERNEL, "%s%s", fsi->host_root_path, host_root);
+	if (!tmp_root)
 		return -ENOMEM;
-
+	kfree(fsi->host_root_path);
+	fsi->host_root_path = tmp_root;
 	return 0;
 }
 
@@ -1049,6 +1051,11 @@ static int hostfs_init_fs_context(struct fs_context *fc)
 	if (!fsi)
 		return -ENOMEM;
 
+	fsi->host_root_path = kasprintf(GFP_KERNEL, "%s/", root_ino);
+	if (!fsi->host_root_path) {
+		kfree(fsi);
+		return -ENOMEM;
+	}
 	fc->s_fs_info = fsi;
 	fc->ops = &hostfs_context_ops;
 	return 0;
-- 
2.22.0


