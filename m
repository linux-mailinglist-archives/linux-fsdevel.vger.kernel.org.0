Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56F8038FC34
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 May 2021 10:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbhEYIJ4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 May 2021 04:09:56 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5548 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbhEYIJP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 May 2021 04:09:15 -0400
Received: from dggems701-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Fq5kl32NqzwTPD;
        Tue, 25 May 2021 15:46:55 +0800 (CST)
Received: from dggpeml500019.china.huawei.com (7.185.36.137) by
 dggems701-chm.china.huawei.com (10.3.19.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 25 May 2021 15:49:41 +0800
Received: from huawei.com (10.175.124.27) by dggpeml500019.china.huawei.com
 (7.185.36.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 25 May
 2021 15:49:40 +0800
From:   Wu Bo <wubo40@huawei.com>
To:     <viro@zeniv.linux.org.uk>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>, <linux-fsdevel@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <linfeilong@huawei.com>, <wubo40@huawei.com>
Subject: [PATCH 1/2] crypto: af_alg - use DIV_ROUND_UP helper macro for calculations
Date:   Tue, 25 May 2021 16:15:19 +0800
Message-ID: <1621930520-515336-2-git-send-email-wubo40@huawei.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1621930520-515336-1-git-send-email-wubo40@huawei.com>
References: <1621930520-515336-1-git-send-email-wubo40@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500019.china.huawei.com (7.185.36.137)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Wu Bo <wubo40@huawei.com>

Replace open coded divisor calculations with the DIV_ROUND_UP kernel
macro for better readability.

Signed-off-by: Wu Bo <wubo40@huawei.com>
---
 crypto/af_alg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/af_alg.c b/crypto/af_alg.c
index 18cc82d..8bd288d 100644
--- a/crypto/af_alg.c
+++ b/crypto/af_alg.c
@@ -411,7 +411,7 @@ int af_alg_make_sg(struct af_alg_sgl *sgl, struct iov_iter *iter, int len)
 	if (n < 0)
 		return n;
 
-	npages = (off + n + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	npages = DIV_ROUND_UP(off + n, PAGE_SIZE);
 	if (WARN_ON(npages == 0))
 		return -EINVAL;
 	/* Add one extra for linking */
-- 
1.8.3.1

