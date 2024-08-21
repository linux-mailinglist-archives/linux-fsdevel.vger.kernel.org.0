Return-Path: <linux-fsdevel+bounces-26426-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF1595930A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 04:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A0731C2239D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 02:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363D8166F28;
	Wed, 21 Aug 2024 02:47:51 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A41E16B390;
	Wed, 21 Aug 2024 02:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724208470; cv=none; b=uFnDTEFyvK3/+C9v8Lj0btYvyIYWUVyWJrr4B5qR95K28Jz0W0JUCxO7HD0AT6ihddqRJ5ODmvwKKJVQwsc7ZxOMtf9x6h6cjL5l2o6xtxlfepWn0VikuFP/NdHhE4+9EvKsFQIB3aUG75l8ph7epXDML+20H+Yubg/zlQVLh0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724208470; c=relaxed/simple;
	bh=fNpQdqiYafe+uT164m+atZ9+6PBDTWdvrJXj+Ayo99o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JXjqUHLScxEytSMQOjeTJx27bQntHRjRnU9/+TneUlAqQg7DlYph2ghzdg3OuIKNXMAhio7ict4UpBmMDHyFSW2TadWty7iuXKj/BioW/ZfcuHe6JSV9rYnEjlot9YPgkp6bnQctSJdEotcfWMGnQvNRNzLrd4mxmFwTlpWW1A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WpW2K4xBHz13cQg;
	Wed, 21 Aug 2024 10:47:05 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id 3370D1800D4;
	Wed, 21 Aug 2024 10:47:44 +0800 (CST)
Received: from localhost.localdomain (10.175.104.67) by
 kwepemf100017.china.huawei.com (7.202.181.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 21 Aug 2024 10:47:43 +0800
From: Zizhi Wo <wozizhi@huawei.com>
To: <netfs@lists.linux.dev>, <dhowells@redhat.com>, <jlayton@kernel.org>
CC: <hsiangkao@linux.alibaba.com>, <jefflexu@linux.alibaba.com>,
	<zhujia.zj@bytedance.com>, <linux-erofs@lists.ozlabs.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<wozizhi@huawei.com>, <libaokun1@huawei.com>, <yangerkun@huawei.com>,
	<houtao1@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH 5/8] cachefiles: Clean up in cachefiles_commit_tmpfile()
Date: Wed, 21 Aug 2024 10:42:58 +0800
Message-ID: <20240821024301.1058918-6-wozizhi@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240821024301.1058918-1-wozizhi@huawei.com>
References: <20240821024301.1058918-1-wozizhi@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemf100017.china.huawei.com (7.202.181.16)

Currently, cachefiles_commit_tmpfile() will only be called if object->flags
is set to CACHEFILES_OBJECT_USING_TMPFILE. Only cachefiles_create_file()
and cachefiles_invalidate_cookie() set this flag. Both of these functions
replace object->file with the new tmpfile, and both are called by
fscache_cookie_state_machine(), so there are no concurrency issues.

So the equation "d_backing_inode(dentry) == file_inode(object->file)" in
cachefiles_commit_tmpfile() will never hold true according to the above
conditions. This patch removes this part of the redundant code and does not
involve any other logical changes.

Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
---
 fs/cachefiles/namei.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index 70b0b3477085..ce9d558ae4fa 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -700,11 +700,6 @@ bool cachefiles_commit_tmpfile(struct cachefiles_cache *cache,
 	}
 
 	if (!d_is_negative(dentry)) {
-		if (d_backing_inode(dentry) == file_inode(object->file)) {
-			success = true;
-			goto out_dput;
-		}
-
 		ret = cachefiles_unlink(volume->cache, object, fan, dentry,
 					FSCACHE_OBJECT_IS_STALE);
 		if (ret < 0)
-- 
2.39.2


