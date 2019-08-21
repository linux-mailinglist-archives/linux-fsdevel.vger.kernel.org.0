Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7D997006
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2019 05:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfHUDJ6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Aug 2019 23:09:58 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5167 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726329AbfHUDJ6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Aug 2019 23:09:58 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B3456DC69904F5E4D189;
        Wed, 21 Aug 2019 11:09:55 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 21 Aug
 2019 11:09:48 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Chao Yu <chao@kernel.org>, <devel@driverdev.osuosl.org>,
        Miao Xie <miaoxie@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, <weidu.du@huawei.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH v2 4/6] staging: erofs: avoid loop in submit chains
Date:   Wed, 21 Aug 2019 11:09:08 +0800
Message-ID: <20190821030908.40282-1-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As reported by erofs-utils fuzzer, 2 conditions
can happen in corrupted images, which can cause
unexpected behaviors.
 - access the same pcluster one more time;
 - access the tail end pcluster again, e.g.
            _ access again (will trigger tail merging)
           |
     1 2 3 1 2             ->   1 2 3 1
     |_ tail end of the chain    \___/ (unexpected behavior)
Let's detect and avoid them now.

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
Hi Greg,

 It seems that you picked up [PATCH 4/6], could you replace it
 with this v2? It seems that I missed a condition here, which
 can be observed after a much longer fuzzing on corrupted
 compressed images. Or you could just drop this [PATCH 4/6]
 patch when you apply to staging-next since those patches are
 independent.

Thanks you very much,
Gao Xiang

 drivers/staging/erofs/zdata.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/erofs/zdata.c b/drivers/staging/erofs/zdata.c
index 2d7aaf98f7de..5f8d3ac0e813 100644
--- a/drivers/staging/erofs/zdata.c
+++ b/drivers/staging/erofs/zdata.c
@@ -132,7 +132,7 @@ enum z_erofs_collectmode {
 struct z_erofs_collector {
 	struct z_erofs_pagevec_ctor vector;
 
-	struct z_erofs_pcluster *pcl;
+	struct z_erofs_pcluster *pcl, *tailpcl;
 	struct z_erofs_collection *cl;
 	struct page **compressedpages;
 	z_erofs_next_pcluster_t owned_head;
@@ -353,6 +353,11 @@ static struct z_erofs_collection *cllookup(struct z_erofs_collector *clt,
 		return NULL;
 
 	pcl = container_of(grp, struct z_erofs_pcluster, obj);
+	if (clt->owned_head == &pcl->next || pcl == clt->tailpcl) {
+		DBG_BUGON(1);
+		erofs_workgroup_put(grp);
+		return ERR_PTR(-EFSCORRUPTED);
+	}
 
 	cl = z_erofs_primarycollection(pcl);
 	if (unlikely(cl->pageofs != (map->m_la & ~PAGE_MASK))) {
@@ -379,7 +384,13 @@ static struct z_erofs_collection *cllookup(struct z_erofs_collector *clt,
 		}
 	}
 	mutex_lock(&cl->lock);
+	/* used to check tail merging loop due to corrupted images */
+	if (clt->owned_head == Z_EROFS_PCLUSTER_TAIL)
+		clt->tailpcl = pcl;
 	clt->mode = try_to_claim_pcluster(pcl, &clt->owned_head);
+	/* clean tailpcl if the current owned_head is Z_EROFS_PCLUSTER_TAIL */
+	if (clt->owned_head == Z_EROFS_PCLUSTER_TAIL)
+		clt->tailpcl = NULL;
 	clt->pcl = pcl;
 	clt->cl = cl;
 	return cl;
@@ -432,6 +443,9 @@ static struct z_erofs_collection *clregister(struct z_erofs_collector *clt,
 		kmem_cache_free(pcluster_cachep, pcl);
 		return ERR_PTR(-EAGAIN);
 	}
+	/* used to check tail merging loop due to corrupted images */
+	if (clt->owned_head == Z_EROFS_PCLUSTER_TAIL)
+		clt->tailpcl = pcl;
 	clt->owned_head = &pcl->next;
 	clt->pcl = pcl;
 	clt->cl = cl;
-- 
2.17.1

