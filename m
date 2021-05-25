Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E900F38FC39
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 May 2021 10:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbhEYIJ7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 May 2021 04:09:59 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:3999 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbhEYIJP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 May 2021 04:09:15 -0400
Received: from dggems702-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Fq5lF5NPpzmbSD;
        Tue, 25 May 2021 15:47:21 +0800 (CST)
Received: from dggpeml500019.china.huawei.com (7.185.36.137) by
 dggems702-chm.china.huawei.com (10.3.19.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 25 May 2021 15:49:41 +0800
Received: from huawei.com (10.175.124.27) by dggpeml500019.china.huawei.com
 (7.185.36.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 25 May
 2021 15:49:41 +0800
From:   Wu Bo <wubo40@huawei.com>
To:     <viro@zeniv.linux.org.uk>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>, <linux-fsdevel@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <linfeilong@huawei.com>, <wubo40@huawei.com>
Subject: [PATCH 2/2] fs: direct-io: use DIV_ROUND_UP helper macro for calculations
Date:   Tue, 25 May 2021 16:15:20 +0800
Message-ID: <1621930520-515336-3-git-send-email-wubo40@huawei.com>
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
 fs/direct-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/direct-io.c b/fs/direct-io.c
index b2e86e7..6e7d402 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -195,7 +195,7 @@ static inline int dio_refill_pages(struct dio *dio, struct dio_submit *sdio)
 		iov_iter_advance(sdio->iter, ret);
 		ret += sdio->from;
 		sdio->head = 0;
-		sdio->tail = (ret + PAGE_SIZE - 1) / PAGE_SIZE;
+		sdio->tail = DIV_ROUND_UP(ret, PAGE_SIZE);
 		sdio->to = ((ret - 1) & (PAGE_SIZE - 1)) + 1;
 		return 0;
 	}
-- 
1.8.3.1

