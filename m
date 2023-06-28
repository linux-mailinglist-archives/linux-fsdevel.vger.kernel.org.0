Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C20CF741242
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 15:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbjF1NYd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 09:24:33 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:21999 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbjF1NYW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 09:24:22 -0400
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Qrj0H48qjzlWNs;
        Wed, 28 Jun 2023 21:21:35 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 28 Jun
 2023 21:24:19 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <jack@suse.cz>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
        <yangerkun@huawei.com>, <chengzhihao1@huawei.com>,
        <yukuai3@huawei.com>, <libaokun1@huawei.com>
Subject: [PATCH v2 7/7] quota: remove unused function put_dquot_list()
Date:   Wed, 28 Jun 2023 21:21:55 +0800
Message-ID: <20230628132155.1560425-8-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230628132155.1560425-1-libaokun1@huawei.com>
References: <20230628132155.1560425-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that no one is calling put_dquot_list(), remove it.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/quota/dquot.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index df028fb2ce72..ba0125473be3 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -1102,26 +1102,6 @@ static void remove_inode_dquot_ref(struct inode *inode, int type)
 	dqput(dquot);
 }
 
-/*
- * Free list of dquots
- * Dquots are removed from inodes and no new references can be got so we are
- * the only ones holding reference
- */
-static void put_dquot_list(struct list_head *tofree_head)
-{
-	struct list_head *act_head;
-	struct dquot *dquot;
-
-	act_head = tofree_head->next;
-	while (act_head != tofree_head) {
-		dquot = list_entry(act_head, struct dquot, dq_free);
-		act_head = act_head->next;
-		/* Remove dquot from the list so we won't have problems... */
-		list_del_init(&dquot->dq_free);
-		dqput(dquot);
-	}
-}
-
 static void remove_dquot_ref(struct super_block *sb, int type)
 {
 	struct inode *inode;
-- 
2.31.1

