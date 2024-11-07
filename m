Return-Path: <linux-fsdevel+bounces-33890-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B8A9C0386
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 12:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69F90286021
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 11:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D31C1F669C;
	Thu,  7 Nov 2024 11:10:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D654B1F6687;
	Thu,  7 Nov 2024 11:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730977834; cv=none; b=h8p6AavuLE1mv0IHfGcoiBm4RXJ4h3vA+fq7vKA3t8oSUJc8k3Tv8fYKMGRm+OJkApv0Qiv5uscSan0JSgxAY5NawC2MBBZL+c+KqqFfKQ8Sw4IMm62tQ3datvGHqvuutAu0AQDV0m7veznC3gUo732zB4HZeU7i5ozTTPF+2tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730977834; c=relaxed/simple;
	bh=1WexRfGfAjCbZ7vpocIPygEkhF0DS+Vxup3A6fLnrzg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bDoAtJq9QjMGrUl+ySn85vlaIkAfIPuR0IuXaCZUrZ7KspesvRX8D21C+e0guXef5nlhmpRJ7KMfRiHiGrBRv/GrjaSlTMl7/V4n86a6L4BKOy/CL4BGrHOvqZ7WZY5pCXU/BFotgKgS08YqsJtVZAWZWiUNCgzEOi+s76+fcWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4XkfTm39pBzQsf2;
	Thu,  7 Nov 2024 19:09:16 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id AA6D9180105;
	Thu,  7 Nov 2024 19:10:24 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemf100017.china.huawei.com
 (7.202.181.16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 7 Nov
 2024 19:10:23 +0800
From: Zizhi Wo <wozizhi@huawei.com>
To: <netfs@lists.linux.dev>, <dhowells@redhat.com>, <jlayton@kernel.org>,
	<brauner@kernel.org>
CC: <hsiangkao@linux.alibaba.com>, <jefflexu@linux.alibaba.com>,
	<zhujia.zj@bytedance.com>, <linux-erofs@lists.ozlabs.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<wozizhi@huawei.com>, <libaokun1@huawei.com>, <yangerkun@huawei.com>,
	<houtao1@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH v2 3/5] cachefiles: Clean up in cachefiles_commit_tmpfile()
Date: Thu, 7 Nov 2024 19:06:47 +0800
Message-ID: <20241107110649.3980193-4-wozizhi@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241107110649.3980193-1-wozizhi@huawei.com>
References: <20241107110649.3980193-1-wozizhi@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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
Acked-by: David Howells <dhowells@redhat.com>
---
 fs/cachefiles/namei.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index 2b3f9935dbb4..7cf59713f0f7 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -691,11 +691,6 @@ bool cachefiles_commit_tmpfile(struct cachefiles_cache *cache,
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


