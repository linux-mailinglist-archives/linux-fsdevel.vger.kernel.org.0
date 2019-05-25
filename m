Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEBB2A462
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 May 2019 14:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfEYM3o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 May 2019 08:29:44 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:54680 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726808AbfEYM3n (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 May 2019 08:29:43 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E5E25F651719228DE6B0;
        Sat, 25 May 2019 20:29:37 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Sat, 25 May 2019
 20:29:27 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <viro@zeniv.linux.org.uk>, <axboe@kernel.dk>
CC:     <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] io_uring: remove set but not used variable 'ret'
Date:   Sat, 25 May 2019 20:29:04 +0800
Message-ID: <20190525122904.12792-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

fs/io_uring.c: In function io_ring_submit:
fs/io_uring.c:2279:7: warning: variable ret set but not used [-Wunused-but-set-variable]

It's not used since commit f3fafe4103bd ("io_uring: add support for sqe links")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 fs/io_uring.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 8ef9d8d3c88b..e2bbd227ab2a 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2276,7 +2276,6 @@ static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit)
 
 	for (i = 0; i < to_submit; i++) {
 		struct sqe_submit s;
-		int ret;
 
 		if (!io_get_sqring(ctx, &s))
 			break;
@@ -2292,7 +2291,7 @@ static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit)
 		s.needs_fixed_file = false;
 		submit++;
 
-		ret = io_submit_sqe(ctx, &s, statep, &link);
+		io_submit_sqe(ctx, &s, statep, &link);
 	}
 	io_commit_sqring(ctx);
 
-- 
2.17.1


