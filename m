Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF7238FB82
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 May 2021 09:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbhEYHQl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 May 2021 03:16:41 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:3939 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhEYHQj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 May 2021 03:16:39 -0400
Received: from dggems704-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Fq4yn1GCTzBwM3;
        Tue, 25 May 2021 15:12:17 +0800 (CST)
Received: from dggpeml500019.china.huawei.com (7.185.36.137) by
 dggems704-chm.china.huawei.com (10.3.19.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 25 May 2021 15:15:08 +0800
Received: from huawei.com (10.175.124.27) by dggpeml500019.china.huawei.com
 (7.185.36.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 25 May
 2021 15:15:08 +0800
From:   Wu Bo <wubo40@huawei.com>
To:     <miklos@szeredi.hu>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linfeilong@huawei.com>, <wubo40@huawei.com>
Subject: [PATCH] fuse: use DIV_ROUND_UP helper macro for calculations
Date:   Tue, 25 May 2021 15:40:47 +0800
Message-ID: <1621928447-456653-1-git-send-email-wubo40@huawei.com>
X-Mailer: git-send-email 1.8.3.1
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
 fs/fuse/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 09ef2a4..62443eb 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1405,7 +1405,7 @@ static int fuse_get_user_pages(struct fuse_args_pages *ap, struct iov_iter *ii,
 		nbytes += ret;
 
 		ret += start;
-		npages = (ret + PAGE_SIZE - 1) / PAGE_SIZE;
+		npages = DIV_ROUND_UP(ret, PAGE_SIZE);
 
 		ap->descs[ap->num_pages].offset = start;
 		fuse_page_descs_length_init(ap->descs, ap->num_pages, npages);
-- 
1.8.3.1

