Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02EA55A98CB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Sep 2022 15:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234461AbiIANYp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Sep 2022 09:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234022AbiIANYO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Sep 2022 09:24:14 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D713C2BB12;
        Thu,  1 Sep 2022 06:24:10 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MJMBr1WRNznTwj;
        Thu,  1 Sep 2022 21:21:40 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500005.china.huawei.com
 (7.192.104.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 1 Sep
 2022 21:24:07 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <cluster-devel@redhat.com>,
        <ntfs3@lists.linux.dev>, <ocfs2-devel@oss.oracle.com>,
        <reiserfs-devel@vger.kernel.org>, <jack@suse.cz>
CC:     <tytso@mit.edu>, <akpm@linux-foundation.org>, <axboe@kernel.dk>,
        <viro@zeniv.linux.org.uk>, <rpeterso@redhat.com>,
        <agruenba@redhat.com>, <almaz.alexandrovich@paragon-software.com>,
        <mark@fasheh.com>, <dushistov@mail.ru>, <hch@infradead.org>,
        <yi.zhang@huawei.com>, <chengzhihao1@huawei.com>,
        <yukuai3@huawei.com>
Subject: [PATCH v2 11/14] ufs: replace ll_rw_block()
Date:   Thu, 1 Sep 2022 21:35:02 +0800
Message-ID: <20220901133505.2510834-12-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220901133505.2510834-1-yi.zhang@huawei.com>
References: <20220901133505.2510834-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ll_rw_block() is not safe for the sync read path because it cannot
guarantee that submitting read IO if the buffer has been locked. We
could get false positive EIO after wait_on_buffer() if the buffer has
been locked by others. So stop using ll_rw_block() in ufs.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ufs/balloc.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/ufs/balloc.c b/fs/ufs/balloc.c
index bd810d8239f2..2436e3f82147 100644
--- a/fs/ufs/balloc.c
+++ b/fs/ufs/balloc.c
@@ -295,14 +295,10 @@ static void ufs_change_blocknr(struct inode *inode, sector_t beg,
 
 			if (!buffer_mapped(bh))
 					map_bh(bh, inode->i_sb, oldb + pos);
-			if (!buffer_uptodate(bh)) {
-				ll_rw_block(REQ_OP_READ, 1, &bh);
-				wait_on_buffer(bh);
-				if (!buffer_uptodate(bh)) {
-					ufs_error(inode->i_sb, __func__,
-						  "read of block failed\n");
-					break;
-				}
+			if (bh_read(bh, 0) < 0) {
+				ufs_error(inode->i_sb, __func__,
+					  "read of block failed\n");
+				break;
 			}
 
 			UFSD(" change from %llu to %llu, pos %u\n",
-- 
2.31.1

