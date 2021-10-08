Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 725634266BB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Oct 2021 11:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbhJHJ1p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Oct 2021 05:27:45 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:23356 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237470AbhJHJ1j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Oct 2021 05:27:39 -0400
Received: from dggeme752-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HQjNt5gt7zbd3B
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Oct 2021 17:21:18 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggeme752-chm.china.huawei.com
 (10.3.19.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Fri, 8 Oct
 2021 17:25:42 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <linux-fsdevel@vger.kernel.org>
CC:     <jack@suse.cz>, <yi.zhang@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH 2/2] qupta: correct error number in free_dqentry()
Date:   Fri, 8 Oct 2021 17:38:21 +0800
Message-ID: <20211008093821.1001186-3-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211008093821.1001186-1-yi.zhang@huawei.com>
References: <20211008093821.1001186-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggeme752-chm.china.huawei.com (10.3.19.98)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix the error path in free_dqentry(), pass out the error number if the
freeing block is not correct.

Fixes: 1ccd14b9c271c ("quota: Split off quota tree handling into a separate file")
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Cc: stable@kernel.org
---
 fs/quota/quota_tree.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/quota/quota_tree.c b/fs/quota/quota_tree.c
index 583b7f7715f9..5f2405994280 100644
--- a/fs/quota/quota_tree.c
+++ b/fs/quota/quota_tree.c
@@ -414,6 +414,7 @@ static int free_dqentry(struct qtree_mem_dqinfo *info, struct dquot *dquot,
 		quota_error(dquot->dq_sb, "Quota structure has offset to "
 			"other block (%u) than it should (%u)", blk,
 			(uint)(dquot->dq_off >> info->dqi_blocksize_bits));
+		ret = -EIO;
 		goto out_buf;
 	}
 	ret = read_blk(info, blk, buf);
-- 
2.31.1

