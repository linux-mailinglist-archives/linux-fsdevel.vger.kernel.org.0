Return-Path: <linux-fsdevel+bounces-19307-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 411918C2FCE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2024 08:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6028F1C216A0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2024 06:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573584F217;
	Sat, 11 May 2024 06:22:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F14B1E498
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 May 2024 06:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715408536; cv=none; b=tsToPEr/wQY1i5circCWwGghBwDdtVBMjLS4S4L8wYCDI4x/rRZs7XefnofUwF5BWUGZqtvE6fM2MXUBpPOjL4IqAoVvloFvBweBOf1CDmxGlj3A5vk4nxXbzxjdyTSpbtpNKDYuZMLofJvLkBI4xsY2cLkykUuIj9DcyIVvz9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715408536; c=relaxed/simple;
	bh=iIRMBheYKHzWAPkaWaWVe4+yH25N1oHWV8rwl1vUaRk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uMVPqOb3zP5oRnewK93YnfR9tWEJSMIr26O6qYuPQisQmt2dZZy5M5NZETzztbz/TGOoymtfX7J/ZjQFmZ0ADUHkZ4mNiS04lcBk4TPx6OhQn+TfRqeVmVDLZDsLxqF6fD84t5sOehKuEiU7SDC83kfpv/jHBKD77fXJN3wPxHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4VbwYc49xDz1S4vj;
	Sat, 11 May 2024 14:18:44 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 11C66140428;
	Sat, 11 May 2024 14:22:08 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sat, 11 May
 2024 14:22:07 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <viro@zeniv.linux.org.uk>, <brauner@kernel.org>
CC: <jack@suse.cz>, <lihongbo22@huawei.com>, <linux-fsdevel@vger.kernel.org>
Subject: [PATCH -next] fs: fsconfig: intercept for non-new mount API in advance for FSCONFIG_CMD_CREATE_EXCL
Date: Sat, 11 May 2024 14:21:47 +0800
Message-ID: <20240511062147.3312801-1-lihongbo22@huawei.com>
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
 dggpeml500022.china.huawei.com (7.185.36.66)

fsconfig with FSCONFIG_CMD_CREATE_EXCL command requires the new mount api,
here we should return -EOPNOTSUPP in advance to avoid extra procedure.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
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


