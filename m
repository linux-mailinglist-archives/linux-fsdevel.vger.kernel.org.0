Return-Path: <linux-fsdevel+bounces-26886-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 595F695C865
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 10:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C4581C21352
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 08:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69BFA149007;
	Fri, 23 Aug 2024 08:52:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDFD1448E1;
	Fri, 23 Aug 2024 08:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724403160; cv=none; b=KEVrEffXJdQu9zKlL3zfDMNf+Zp8GTk1uI6nl+iK9MHYrTf4J6/r8t1CddhUFMGLTjVnIe3Wh4/lTDC+JOx1cz9BItQKFz+ZmpZD0IyjY4+hawpAGc5hjT1ypBpDmItCNpNvV1eL4q6mR8i00TMaxfXoLX0oj7/6oJUk+3o5kAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724403160; c=relaxed/simple;
	bh=bn4Nn6SAWUd93cocRLtcz1T65V0A7e96a0EIfpt0HSU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=towQIimcxpWP9nD9ANjjPNwTN9bIfwrxc2NSgNWgeTSHkbcPTfxCRatXGCyjMKXaM6w96e4yJi1kJi+PR3So0Z0a+J09NHO7NpAWNHjqEfq+SlwPu2Bn2L9doO9t1JFu3jWHL4FzMMyl1RB5vx1/c0m5/gkR0tjgq2aMrITbpEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Wqv2z5gyRz1S8cY;
	Fri, 23 Aug 2024 16:52:27 +0800 (CST)
Received: from kwepemd100024.china.huawei.com (unknown [7.221.188.41])
	by mail.maildlp.com (Postfix) with ESMTPS id 274DE1402C7;
	Fri, 23 Aug 2024 16:52:33 +0800 (CST)
Received: from huawei.com (10.175.124.27) by kwepemd100024.china.huawei.com
 (7.221.188.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 23 Aug
 2024 16:52:32 +0800
From: yangyun <yangyun50@huawei.com>
To: Miklos Szeredi <miklos@szeredi.hu>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lixiaokeng@huawei.com>
Subject: [PATCH] fuse: fix memory leak in fuse_create_open
Date: Fri, 23 Aug 2024 16:51:46 +0800
Message-ID: <20240823085146.4017230-1-yangyun50@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd100024.china.huawei.com (7.221.188.41)

The memory of struct fuse_file is allocated but not freed
when get_create_ext return error.

Fixes: 3e2b6fdbdc9a ("fuse: send security context of inode on file")
Cc: stable@vger.kernel.org
Signed-off-by: yangyun <yangyun50@huawei.com>
---
 fs/fuse/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 2b0d4781f394..8e96df9fd76c 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -670,7 +670,7 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 
 	err = get_create_ext(&args, dir, entry, mode);
 	if (err)
-		goto out_put_forget_req;
+		goto out_free_ff;
 
 	err = fuse_simple_request(fm, &args);
 	free_ext_value(&args);
-- 
2.33.0


