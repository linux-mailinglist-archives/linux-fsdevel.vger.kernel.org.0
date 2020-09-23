Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3378274ED9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Sep 2020 04:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgIWCH5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Sep 2020 22:07:57 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14262 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726743AbgIWCH5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Sep 2020 22:07:57 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id ED42D5D3707A01EE135B;
        Wed, 23 Sep 2020 10:07:54 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Wed, 23 Sep 2020 10:07:46 +0800
From:   Jing Xiangfeng <jingxiangfeng@huawei.com>
To:     <miklos@szeredi.hu>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jingxiangfeng@huawei.com>
Subject: [PATCH -next] virtiofs: Move the assignment to ret outside the loop
Date:   Wed, 23 Sep 2020 10:07:55 +0800
Message-ID: <20200923020755.187255-1-jingxiangfeng@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There is no need to do the assignment each time. So move the assignment
to ret outside the loop.

Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
---
 fs/fuse/dax.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index e394dba08cc4..f18cd7b53ec7 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -1259,9 +1259,9 @@ static int fuse_dax_mem_range_init(struct fuse_conn_dax *fcd)
 	pr_debug("%s: dax mapped %ld pages. nr_ranges=%ld\n",
 		__func__, nr_pages, nr_ranges);
 
+	ret = -ENOMEM;
 	for (i = 0; i < nr_ranges; i++) {
 		range = kzalloc(sizeof(struct fuse_dax_mapping), GFP_KERNEL);
-		ret = -ENOMEM;
 		if (!range)
 			goto out_err;
 
-- 
2.26.0.106.g9fadedd

