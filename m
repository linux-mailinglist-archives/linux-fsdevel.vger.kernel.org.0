Return-Path: <linux-fsdevel+bounces-19953-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2028CB961
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 05:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDE501F222C7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 03:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFAD928371;
	Wed, 22 May 2024 03:04:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F09D28EA
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 May 2024 03:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716347044; cv=none; b=SkPIth1iiU5HhtFfq3CBUue8m2UvfIx4Zg1eRVAOvpB5jQ8CP+PkQ+qQoxMlTo/j+mL7wBIXaUNHKrXY0K1NlEtM7Y2OW4ns9EHvwqIdTI+tUrWEswXsYYHahjZIp6CYUi757qNkapwZOTu/5F4asW7kvPGbPuDzr5vScprI9Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716347044; c=relaxed/simple;
	bh=2nGX9UWIOlyN+m0pZgWlwp9Haxbw8Aslpnhg6J8c3GE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e41cfpCHffJq0JWU24iavoHln576nhmARzWIr7fSfqH+mtFmIV/MWZteIJEMa5rdZpmzXF6cZRD/VR82gB+EosrKcnY0Dk0/cbiPlDqmKFPM8zNjjNSTD2lXbXoa6n6PuH0lIuWIZUMpalypKkx88/MgPBrbru4mGupRrC8T+W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4VkbfC62GVz1ypDc;
	Wed, 22 May 2024 11:00:51 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 24B801A0188;
	Wed, 22 May 2024 11:03:53 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 22 May
 2024 11:03:52 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <jack@suse.cz>
CC: <lihongbo22@huawei.com>, <linux-fsdevel@vger.kernel.org>
Subject: [PATCH v2] fs: fsconfig: intercept non-new mount API in advance for FSCONFIG_CMD_CREATE_EXCL command
Date: Wed, 22 May 2024 11:04:22 +0800
Message-ID: <20240522030422.315892-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500022.china.huawei.com (7.185.36.66)

fsconfig with FSCONFIG_CMD_CREATE_EXCL command requires the new mount api,
here we should return -EOPNOTSUPP in advance to avoid extra procedure.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
v2:
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


