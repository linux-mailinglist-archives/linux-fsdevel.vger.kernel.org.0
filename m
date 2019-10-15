Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE0B9D7684
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2019 14:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729366AbfJOM21 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Oct 2019 08:28:27 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:34280 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726441AbfJOM21 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Oct 2019 08:28:27 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8CE1BBC063981FFFAF3F;
        Tue, 15 Oct 2019 20:28:25 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.439.0; Tue, 15 Oct 2019 20:28:15 +0800
From:   chenxiang <chenxiang66@hisilicon.com>
To:     <trond.myklebust@hammerspace.com>, <anna.schumaker@netapp.com>
CC:     <linux-nfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linuxarm@huawei.com>, Xiang Chen <chenxiang66@hisilicon.com>
Subject: [PATCH] nfs: No need to add NULL check before function kfree()
Date:   Tue, 15 Oct 2019 20:25:16 +0800
Message-ID: <1571142316-173812-1-git-send-email-chenxiang66@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Xiang Chen <chenxiang66@hisilicon.com>

It fixes the warning as follows reported by coccicheck:
fs/nfs/sysfs.c:125:2-7: WARNING: NULL check before some freeing functions is not
needed.

Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
---
 fs/nfs/sysfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
index 4f3390b..c489496 100644
--- a/fs/nfs/sysfs.c
+++ b/fs/nfs/sysfs.c
@@ -121,8 +121,7 @@ static void nfs_netns_client_release(struct kobject *kobj)
 			struct nfs_netns_client,
 			kobject);
 
-	if (c->identifier)
-		kfree(c->identifier);
+	kfree(c->identifier);
 	kfree(c);
 }
 
-- 
2.8.1

