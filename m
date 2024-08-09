Return-Path: <linux-fsdevel+bounces-25497-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FCCC94C828
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 03:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BECA528807C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 01:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583DA12E4D;
	Fri,  9 Aug 2024 01:44:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CDB3234;
	Fri,  9 Aug 2024 01:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723167854; cv=none; b=FdA/7chv7wzwU4+xuMs8doc1P88f1t4oXerjjiVZso2+XdBUJa4KVMvtzCq9KHY5fxP+d2j1UO9WaUu+YNEjaz4bV3OXWvUvc3P7nfSdfBOFu7gz3HtR3NmB56aq+Gnzrq1PMzG6r52IxZtm3L11BGwxZcBUsJy9eKSVQ++KtjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723167854; c=relaxed/simple;
	bh=zjhg9zTvqXg9WUCET1dD1tSFmzlocx7JI25rFZnMsUc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RStkgzyk6KVCoXhKhgWHsek7UZOzMWsaxI9jHaWJouUKYBU9rARXZBu1YaJxjlYXJuT2yQQNtZF0NQYhAnsYSA/Dw6gdvLI8uQKrmGQ5UM4BZizDK0gSmcnvU48uFU7bbC+FIn7hhIl3Ec0EyRRL///FWu33NuPQuyx2p4/UORA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Wg6C24f8jzcd5c;
	Fri,  9 Aug 2024 09:43:58 +0800 (CST)
Received: from dggpemm500020.china.huawei.com (unknown [7.185.36.49])
	by mail.maildlp.com (Postfix) with ESMTPS id ACCAD18007C;
	Fri,  9 Aug 2024 09:44:07 +0800 (CST)
Received: from huawei.com (10.67.174.77) by dggpemm500020.china.huawei.com
 (7.185.36.49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 9 Aug
 2024 09:44:07 +0800
From: Liao Chen <liaochen4@huawei.com>
To: <linux-fsdevel@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <dlemoal@kernel.org>,
	<naohiro.aota@wdc.com>, <jth@kernel.org>, <liaochen4@huawei.com>
Subject: [PATCH -next] zonefs: add support for FS_IOC_GETFSSYSFSPATH
Date: Fri, 9 Aug 2024 01:36:27 +0000
Message-ID: <20240809013627.3546649-1-liaochen4@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500020.china.huawei.com (7.185.36.49)

FS_IOC_GETFSSYSFSPATH ioctl expects sysfs sub-path of a filesystem, the
format can be "$FSTYP/$SYSFS_IDENTIFIER" under /sys/fs, it can helps to
standardizes exporting sysfs datas across filesystems.

This patch wires up FS_IOC_GETFSSYSFSPATH for zonefs, it will output
"zonefs/<dev>".

Signed-off-by: Liao Chen <liaochen4@huawei.com>
---
 fs/zonefs/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index faf1eb87895d..e180daa39578 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -1262,6 +1262,7 @@ static int zonefs_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_maxbytes = 0;
 	sb->s_op = &zonefs_sops;
 	sb->s_time_gran	= 1;
+	super_set_sysfs_name_id(sb);
 
 	/*
 	 * The block size is set to the device zone write granularity to ensure
-- 
2.34.1


