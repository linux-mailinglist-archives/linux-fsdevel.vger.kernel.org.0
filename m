Return-Path: <linux-fsdevel+bounces-72279-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A678ECEBA82
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Dec 2025 10:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F30F30380EB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Dec 2025 09:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3813164B0;
	Wed, 31 Dec 2025 09:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="6vbCpnyS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6850C3168E3;
	Wed, 31 Dec 2025 09:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767172447; cv=none; b=UqpVZidreu/EzFuhSvet5DB9Af7UgWtyTpKhJHMqDN2mzNlZAcGk/45xWTU18Napkd8aXIjscow84CzfXgE6zO2CT5MP8VRUHeCXeZiT6pBf5nMgorRK3ikGmXGsvfjDQbG2vo1Ak2ZOd97cKulWGz5yi1zyuvMapU9+Ha4KgEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767172447; c=relaxed/simple;
	bh=S7RjyECHRDHNXIL1Al8k3RPWxT6vjUtdtCg4YK41Swo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NuOnnkz7/Exv0yTzV3tBGzp9aW41AfQQLuR77irbWPTpQ5hdb2f8T4OGL+cfzWsWJsK+Q51AjUaCqa0UbIQaSNXpEgy6W3iFZFAAj1hMIgtU9rF2RLm01RRkFBPwL6eVCIAT/NWtylef7vGySS9OMx+SlE/FHktmJMbJrs51L5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=6vbCpnyS; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Ii4OAViqYCm/sgHCVWzYCGvcDaSOgZiGOYibBrZpOYU=;
	b=6vbCpnySXkmEqQBj+K55ndCgfd4lrG6flgNfy05ERumm6g/PuPxdBMSEG46fc1SwIvzqG7gg+
	1+WQ3JCBdt0XUhX2EChxqn0BVx0dlMHswwEPUz0SaTu0tPTlwDgXoNAw249+FBw+UlUxb7wWNZW
	cBSMB8miZLhswOMENMspOgk=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4dh41k2Vbsz1cyP2;
	Wed, 31 Dec 2025 17:10:50 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 04FFD4069C;
	Wed, 31 Dec 2025 17:14:01 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemr500015.china.huawei.com
 (7.202.195.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 31 Dec
 2025 17:14:00 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <hsiangkao@linux.alibaba.com>, <chao@kernel.org>, <brauner@kernel.org>
CC: <djwong@kernel.org>, <amir73il@gmail.com>, <hch@lst.de>,
	<lihongbo22@huawei.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v12 06/10] erofs: support domain-specific page cache share
Date: Wed, 31 Dec 2025 09:01:14 +0000
Message-ID: <20251231090118.541061-7-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20251231090118.541061-1-lihongbo22@huawei.com>
References: <20251231090118.541061-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemr500015.china.huawei.com (7.202.195.162)

From: Hongzhen Luo <hongzhen@linux.alibaba.com>

Only files in the same domain will share the page cache. Also modify
the sysfs related content in preparation for the upcoming page cache
share feature.

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/super.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index dca1445f6c92..960da62636ad 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -524,6 +524,8 @@ static int erofs_fc_parse_param(struct fs_context *fc,
 		if (!sbi->fsid)
 			return -ENOMEM;
 		break;
+#endif
+#if defined(CONFIG_EROFS_FS_ONDEMAND) || defined(CONFIG_EROFS_FS_PAGE_CACHE_SHARE)
 	case Opt_domain_id:
 		kfree(sbi->domain_id);
 		sbi->domain_id = kstrdup(param->string, GFP_KERNEL);
@@ -624,7 +626,7 @@ static void erofs_set_sysfs_name(struct super_block *sb)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 
-	if (sbi->domain_id)
+	if (sbi->domain_id && !erofs_sb_has_ishare_xattrs(sbi))
 		super_set_sysfs_name_generic(sb, "%s,%s", sbi->domain_id,
 					     sbi->fsid);
 	else if (sbi->fsid)
@@ -1054,12 +1056,10 @@ static int erofs_show_options(struct seq_file *seq, struct dentry *root)
 		seq_puts(seq, ",dax=never");
 	if (erofs_is_fileio_mode(sbi) && test_opt(opt, DIRECT_IO))
 		seq_puts(seq, ",directio");
-#ifdef CONFIG_EROFS_FS_ONDEMAND
 	if (sbi->fsid)
 		seq_printf(seq, ",fsid=%s", sbi->fsid);
 	if (sbi->domain_id)
 		seq_printf(seq, ",domain_id=%s", sbi->domain_id);
-#endif
 	if (sbi->dif0.fsoff)
 		seq_printf(seq, ",fsoffset=%llu", sbi->dif0.fsoff);
 	return 0;
-- 
2.22.0


