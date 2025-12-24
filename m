Return-Path: <linux-fsdevel+bounces-72020-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 064E8CDB52F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 05:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E38030285D2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 04:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FCB32B9BA;
	Wed, 24 Dec 2025 04:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="PON2s7TU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F5D329E44;
	Wed, 24 Dec 2025 04:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766550152; cv=none; b=LaqRig372zkv2fSFG20kwn+fIlPX8JtREpb9zStxBsK2Ih2+ICfXFm0OnlerZbgSMpeK5sSt/poR7AQueAU8WvQpaVbosYwNTfeNEX8eEgmMh0rQ91Pbvb3rbWYUHzRGqa4jAOTsEBFKhYPL7b7shEUd7qtufoOX83sW8zPB/1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766550152; c=relaxed/simple;
	bh=veVUQ2o+POAKg964/YB7KUtw4Ydl1Cf3kXnaw1S5fZ0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BJ0IxoS33bjIO9qoDEYM3s+6Zn5OxEtKUTTbMilHxbvQrS1ySIOf29ISbIldpZJ4LNCVQVG2FgWWGKN/aFb7pkdY6IMREibY/mH9Mh5oTs2PPTj7+qfll3wQiPiPah0lf1lDWyf1LySqx5DDM7ovBA2UpfQhbTRIAs9996ZIkpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=PON2s7TU; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=wn4ap7JN/CCke+bhEnRF6p4H5kDv3OOsswGx7q8mscg=;
	b=PON2s7TUEQotSA2137gzqOJyBAEO2JEi7jpCgCGCSdGLfbcF0M5oqL6LW7wrMiao/CD9MIGGm
	6JMjYKwHHCVxSQcj7HtpAUU/GdV+R9YSEC3T/DnBWgGbAZv4iPPfU5iRYTlaV+GD1vlJM/PcS9S
	3t8uT4Pkdwf9hoQNiMMhqcE=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4dbdtV5gFyz12LF3;
	Wed, 24 Dec 2025 12:19:14 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 4C76E40363;
	Wed, 24 Dec 2025 12:22:27 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemr500015.china.huawei.com
 (7.202.195.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 24 Dec
 2025 12:22:26 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <hsiangkao@linux.alibaba.com>, <chao@kernel.org>, <brauner@kernel.org>,
	<djwong@kernel.org>, <amir73il@gmail.com>, <hch@lst.de>
CC: <linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <lihongbo22@huawei.com>
Subject: [PATCH v11 06/10] erofs: support domain-specific page cache share
Date: Wed, 24 Dec 2025 04:09:28 +0000
Message-ID: <20251224040932.496478-7-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20251224040932.496478-1-lihongbo22@huawei.com>
References: <20251224040932.496478-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemr500015.china.huawei.com (7.202.195.162)

From: Hongzhen Luo <hongzhen@linux.alibaba.com>

Only files in the same domain will share the page cache. Also modify
the sysfs related content in preparation for the upcoming page cache
share feature.

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 fs/erofs/super.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 68480f10e69d..819ab0ae9950 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -518,6 +518,8 @@ static int erofs_fc_parse_param(struct fs_context *fc,
 		if (!sbi->fsid)
 			return -ENOMEM;
 		break;
+#endif
+#if defined(CONFIG_EROFS_FS_ONDEMAND) || defined(CONFIG_EROFS_FS_PAGE_CACHE_SHARE)
 	case Opt_domain_id:
 		kfree(sbi->domain_id);
 		sbi->domain_id = kstrdup(param->string, GFP_KERNEL);
@@ -618,7 +620,7 @@ static void erofs_set_sysfs_name(struct super_block *sb)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 
-	if (sbi->domain_id)
+	if (sbi->domain_id && !erofs_sb_has_ishare_xattrs(sbi))
 		super_set_sysfs_name_generic(sb, "%s,%s", sbi->domain_id,
 					     sbi->fsid);
 	else if (sbi->fsid)
@@ -1049,12 +1051,10 @@ static int erofs_show_options(struct seq_file *seq, struct dentry *root)
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


