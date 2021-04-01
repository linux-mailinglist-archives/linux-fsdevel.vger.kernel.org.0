Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B386D350F9A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 08:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233302AbhDAG5E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Apr 2021 02:57:04 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15062 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbhDAG4t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Apr 2021 02:56:49 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F9v6m2flYzPnNb;
        Thu,  1 Apr 2021 14:54:08 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Thu, 1 Apr 2021 14:56:38 +0800
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
To:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Yang Guo <guoyang2@huawei.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>
Subject: [PATCH] fs/buffer.c: Delete redundant uptodate check for buffer
Date:   Thu, 1 Apr 2021 14:57:02 +0800
Message-ID: <1617260222-13797-1-git-send-email-zhangshaokun@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Yang Guo <guoyang2@huawei.com>

The buffer uptodate state has been checked in function set_buffer_uptodate,
there is no need use buffer_uptodate before calling set_buffer_uptodate and
delete it.

Cc: Alexander Viro <viro@zeniv.linux.org.uk> 
Signed-off-by: Yang Guo <guoyang2@huawei.com>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 fs/buffer.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 673cfbef9eec..2c0d0b3f3203 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2055,8 +2055,7 @@ int __block_write_begin_int(struct page *page, loff_t pos, unsigned len,
 		block_end = block_start + blocksize;
 		if (block_end <= from || block_start >= to) {
 			if (PageUptodate(page)) {
-				if (!buffer_uptodate(bh))
-					set_buffer_uptodate(bh);
+				set_buffer_uptodate(bh);
 			}
 			continue;
 		}
@@ -2088,8 +2087,7 @@ int __block_write_begin_int(struct page *page, loff_t pos, unsigned len,
 			}
 		}
 		if (PageUptodate(page)) {
-			if (!buffer_uptodate(bh))
-				set_buffer_uptodate(bh);
+			set_buffer_uptodate(bh);
 			continue; 
 		}
 		if (!buffer_uptodate(bh) && !buffer_delay(bh) &&
-- 
2.7.4

