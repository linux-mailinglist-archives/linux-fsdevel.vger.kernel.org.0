Return-Path: <linux-fsdevel+bounces-19299-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3539C8C2F75
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2024 06:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C25C5B21F7D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2024 04:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138313BB21;
	Sat, 11 May 2024 04:03:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096AEC8F3
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 May 2024 04:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715400201; cv=none; b=Rnsi8FkbL7vH+krurTwiHx90JyJXSsZKGFcyI8SJGhnlTu5p0r5yzkxvz7Aj/C0iaek5h0nSIX4QeC/CppCHd55utk6aVjvCqWNmrI2RuEy5yYfdxmCRwY5wyhquHIsjJyAicZciRrsfi5Wxs8MRsH/XFx1GwncLpobQ6JlV7JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715400201; c=relaxed/simple;
	bh=JtHC26HkSHE5cX2S6q5iKRXQ9klbcMw02lQhUQtzHoQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ekiCdPQX8Yd8B0awmgKGfr2i8IsDbiNqbEcSQRCU3NT8ICilgigGn7Eh6/5Rte/cECYAqjasEcKt9EMPVOhjQJXOM4TVGny2kkHutgs9pAldOUGjO8zjJLVKKhUt072hoVOJHFdwIeR88+PX048c45Y22ykSU9d6GK7Qae/nh/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VbsTH176jzvXkx;
	Sat, 11 May 2024 11:59:47 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id A938E1400CF;
	Sat, 11 May 2024 12:03:10 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sat, 11 May
 2024 12:03:10 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <jack@suse.cz>
CC: <lihongbo22@huawei.com>, <linux-fsdevel@vger.kernel.org>
Subject: [PATCH -next] fsconfig: intercept for non-new mount API in advance for FSCONFIG_CMD_CREATE_EXCL
Date: Sat, 11 May 2024 12:02:49 +0800
Message-ID: <20240511040249.2141380-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500022.china.huawei.com (7.185.36.66)

fsconfig with FSCONFIG_CMD_CREATE_EXCL command requires the new mount api,
here we should return -EOPNOTSUPP in advance to avoid extra procedure.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 fs/fsopen.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/fsopen.c b/fs/fsopen.c
index 6593ae518115..880eea7a30fd 100644
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
+		case FSCONFIG_CMD_CREATE_EXEC:
 			ret = -EOPNOTSUPP;
 			goto out_f;
 		}
-- 
2.34.1


