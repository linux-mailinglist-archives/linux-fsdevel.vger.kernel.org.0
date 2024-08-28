Return-Path: <linux-fsdevel+bounces-27564-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 769F6962669
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 13:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32A5D281F9A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 11:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F3616D9BA;
	Wed, 28 Aug 2024 11:53:59 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43C114A4D6
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 11:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724846039; cv=none; b=eBe1OBHONLEZ5++8abFp5HF+7N0XaC/X7RYYYTovoBnSB9VVmu/DTzWp8WnW1Lo0EU3OtUknouEEB5ufJYhGeSDjYJwTxnePk1vNr8oqkMJIF7iO5n7o5Ii+xTLwiY1TTzmAKbWiY0fzYZdKTo2NFsNd+qDZKHQxmjVZd1ihf7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724846039; c=relaxed/simple;
	bh=Q93TqhxpDAenL7lwa/1VBxKIzkGe4weUVL8erqHBd+o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=StC+C5M+6DV9bL/X2gThlrzR9a2NOTu0Hg6pEUnzeN3uHaU4ck2HHN7TJVQ1wLVXwf6xAvlBIpoCc9Up409yLcNHIZOycjkGLP2lL5RWDFBJRCDJtWpy+OiTXQHsvNivp1iVL9mkU750AUgu0Iu8gWTEX/nXsGSPBEZ935vgQt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Wv2p36YpSzpTsR;
	Wed, 28 Aug 2024 19:52:11 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 0735D180AE6;
	Wed, 28 Aug 2024 19:53:54 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 28 Aug
 2024 19:53:53 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <dlemoal@kernel.org>, <naohiro.aota@wdc.com>, <jth@kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <lihongbo22@huawei.com>
Subject: [PATCH -next] zonefs: obtain fs magic from superblock
Date: Wed, 28 Aug 2024 20:01:52 +0800
Message-ID: <20240828120152.3695626-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500022.china.huawei.com (7.185.36.66)

The sb->s_magic holds the file system magic, we can use
this to avoid use file system magic macro directly.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 fs/zonefs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index faf1eb87895d..1ecbf19ccc58 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -444,7 +444,7 @@ static int zonefs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
 	enum zonefs_ztype t;
 
-	buf->f_type = ZONEFS_MAGIC;
+	buf->f_type = sb->s_magic;
 	buf->f_bsize = sb->s_blocksize;
 	buf->f_namelen = ZONEFS_NAME_MAX;
 
-- 
2.34.1


