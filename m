Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 591344478A0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Nov 2021 03:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236906AbhKHClA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Nov 2021 21:41:00 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:27119 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbhKHClA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Nov 2021 21:41:00 -0500
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4HnZwz2VBwz1DJCl;
        Mon,  8 Nov 2021 10:36:03 +0800 (CST)
Received: from dggpeml500019.china.huawei.com (7.185.36.137) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Mon, 8 Nov 2021 10:38:12 +0800
Received: from huawei.com (10.175.124.27) by dggpeml500019.china.huawei.com
 (7.185.36.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Mon, 8 Nov
 2021 10:38:11 +0800
From:   Wu Bo <wubo40@huawei.com>
To:     <viro@zeniv.linux.org.uk>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linfeilong@huawei.com>, <wubo40@huawei.com>
Subject: [PATCH] fs: direct-io: use DIV_ROUND_UP helper macro for calculations
Date:   Mon, 8 Nov 2021 11:10:11 +0800
Message-ID: <1636341011-6494-1-git-send-email-wubo40@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500019.china.huawei.com (7.185.36.137)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Replace open coded divisor calculations with the DIV_ROUND_UP kernel
macro for better readability.

Signed-off-by: Wu Bo <wubo40@huawei.com>
---
 fs/direct-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/direct-io.c b/fs/direct-io.c
index 6544435..e5869c2 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -194,7 +194,7 @@ static inline int dio_refill_pages(struct dio *dio, struct dio_submit *sdio)
 		iov_iter_advance(sdio->iter, ret);
 		ret += sdio->from;
 		sdio->head = 0;
-		sdio->tail = (ret + PAGE_SIZE - 1) / PAGE_SIZE;
+		sdio->tail = DIV_ROUND_UP(ret, PAGE_SIZE);
 		sdio->to = ((ret - 1) & (PAGE_SIZE - 1)) + 1;
 		return 0;
 	}
-- 
2.29.2

