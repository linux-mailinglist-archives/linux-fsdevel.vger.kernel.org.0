Return-Path: <linux-fsdevel+bounces-22338-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 043D8916762
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 14:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36A531C24F96
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 12:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F6E14A4C1;
	Tue, 25 Jun 2024 12:15:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B159F14A087
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jun 2024 12:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719317732; cv=none; b=H9GBD2nRBtOiuu0/02uL/Zd9c3ujUNq4EbLoKOmcQcTLBB31X87CmzKyhqv9y5pxBnODcEXlCehTFsGi6S6qCiqKuC6CicYrpQzk1/fVg/HAUcKvT9zsqd89gPW37+d5E7F+v420mKeQdX3beXJN1ciGgPJiAa6GDZBNePQcAhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719317732; c=relaxed/simple;
	bh=QWV/jNTyVFmZ8Qo22Mo4dRxVnJVfifSmQrkdlhaD09Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=C63MQ6RXxumG8B43kHLV7kiMejCCgdaQjZSFqLAR+lZu0T9HnY78QBOwvvmOfbLFvEWq2bUVTXchFAsCj6SizN0Ni/JiGuMpfhIoiuUzya0D8peAjDFxV95+svJIER4OeWcLU4Z0IfLnu1/4UZqVKZLJHovHSQZTmeRcFeNocFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4W7kJd507PzddVN;
	Tue, 25 Jun 2024 20:13:53 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 2E1EA180085;
	Tue, 25 Jun 2024 20:15:27 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 25 Jun
 2024 20:15:26 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <jack@suse.cz>
CC: <lihongbo22@huawei.com>, <linux-fsdevel@vger.kernel.org>
Subject: [PATCH v3] fs: fsconfig: intercept non-new mount API in advance for FSCONFIG_CMD_CREATE_EXCL command
Date: Tue, 25 Jun 2024 20:18:31 +0800
Message-ID: <20240625121831.1833081-1-lihongbo22@huawei.com>
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

fsconfig with FSCONFIG_CMD_CREATE_EXCL command requires the new mount api,
here we should return -EOPNOTSUPP in advance to avoid extra procedure.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
v3:
  - Add reviewed-by.

v2: https://lore.kernel.org/all/20240522030422.315892-1-lihongbo22@huawei.com/
  - Fix misspelling and change the target branch.

v1: https://lore.kernel.org/all/20240511062147.3312801-1-lihongbo22@huawei.com/T/
---
 fs/fsopen.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/fsopen.c b/fs/fsopen.c
index 6593ae518115..18fe979da7e2 100644
--- a/fs/fsopen.c
+++ b/fs/fsopen.c
@@ -220,10 +220,6 @@ static int vfs_cmd_create(struct fs_context *fc, bool exclusive)
 	if (!mount_capable(fc))
 		return -EPERM;
 
-	/* require the new mount api */
-	if (exclusive && fc->ops == &legacy_fs_context_ops)
-		return -EOPNOTSUPP;
-
 	fc->phase = FS_CONTEXT_CREATING;
 	fc->exclusive = exclusive;
 
@@ -411,6 +407,7 @@ SYSCALL_DEFINE5(fsconfig,
 		case FSCONFIG_SET_PATH:
 		case FSCONFIG_SET_PATH_EMPTY:
 		case FSCONFIG_SET_FD:
+		case FSCONFIG_CMD_CREATE_EXCL:
 			ret = -EOPNOTSUPP;
 			goto out_f;
 		}
-- 
2.34.1


