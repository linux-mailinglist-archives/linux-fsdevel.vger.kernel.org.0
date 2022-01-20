Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA3E494797
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jan 2022 07:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237587AbiATGro (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jan 2022 01:47:44 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:31108 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233357AbiATGrn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jan 2022 01:47:43 -0500
Received: from dggeme756-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4JfXzH0gH3z1FCqG;
        Thu, 20 Jan 2022 14:43:55 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 dggeme756-chm.china.huawei.com (10.3.19.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Thu, 20 Jan 2022 14:47:41 +0800
From:   chenxiang <chenxiang66@hisilicon.com>
To:     <bcrl@kvack.org>, <viro@zeniv.linux.org.uk>
CC:     <linux-aio@kvack.org>, <linux-fsdevel@vger.kernel.org>,
        <linuxarm@huawei.com>, Xiang Chen <chenxiang66@hisilicon.com>
Subject: [PATCH] aio: Adjust the position of get_reqs_available() in aio_get_req()
Date:   Thu, 20 Jan 2022 14:42:26 +0800
Message-ID: <1642660946-60244-1-git-send-email-chenxiang66@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggeme756-chm.china.huawei.com (10.3.19.102)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Xiang Chen <chenxiang66@hisilicon.com>

Right now allocating aio_kiocb is in front of get_reqs_available(),
then need to free aio_kiocb if get_reqs_available() is failed.
Put get_reqs_availabe() in front of allocating aio_kiocb to avoid
freeing aio_kiocb if get_reqs_available() is failed.

Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
---
 fs/aio.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 9c81cf611d65..79f8ea31a696 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1025,14 +1025,12 @@ static inline struct aio_kiocb *aio_get_req(struct kioctx *ctx)
 {
 	struct aio_kiocb *req;
 
-	req = kmem_cache_alloc(kiocb_cachep, GFP_KERNEL);
-	if (unlikely(!req))
+	if (unlikely(!get_reqs_available(ctx)))
 		return NULL;
 
-	if (unlikely(!get_reqs_available(ctx))) {
-		kmem_cache_free(kiocb_cachep, req);
+	req = kmem_cache_alloc(kiocb_cachep, GFP_KERNEL);
+	if (unlikely(!req))
 		return NULL;
-	}
 
 	percpu_ref_get(&ctx->reqs);
 	req->ki_ctx = ctx;
-- 
2.33.0

