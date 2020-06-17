Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA4BC1FCCEA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jun 2020 13:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgFQL6t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jun 2020 07:58:49 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:35150 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726816AbgFQL6s (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jun 2020 07:58:48 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8E58374B058FB3BC4BEA;
        Wed, 17 Jun 2020 19:58:46 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Wed, 17 Jun 2020
 19:58:35 +0800
From:   "zhangyi (F)" <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>, <tytso@mit.edu>, <jack@suse.cz>
CC:     <adilger.kernel@dilger.ca>, <zhangxiaoxu5@huawei.com>,
        <yi.zhang@huawei.com>, <linux-fsdevel@vger.kernel.org>
Subject: [PATCH v2 5/5] ext4: remove write io error check before read inode block
Date:   Wed, 17 Jun 2020 19:59:47 +0800
Message-ID: <20200617115947.836221-6-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200617115947.836221-1-yi.zhang@huawei.com>
References: <20200617115947.836221-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

After we add ext4_end_buffer_async_write() callback into block layer to
detect metadata buffer's async write error in the background, we can
remove the partial fix for filesystem inconsistency problem caused by
reading old data from disk in commit <9c83a923c67d> "ext4: don't read
inode block if the buffer has a write error".

Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
---
 fs/ext4/inode.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 8ccb6996c384..b2fc1aef3886 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4281,15 +4281,6 @@ static int __ext4_get_inode_loc(struct inode *inode,
 	if (!buffer_uptodate(bh)) {
 		lock_buffer(bh);
 
-		/*
-		 * If the buffer has the write error flag, we have failed
-		 * to write out another inode in the same block.  In this
-		 * case, we don't have to read the block because we may
-		 * read the old inode data successfully.
-		 */
-		if (buffer_write_io_error(bh) && !buffer_uptodate(bh))
-			set_buffer_uptodate(bh);
-
 		if (buffer_uptodate(bh)) {
 			/* someone brought it uptodate while we waited */
 			unlock_buffer(bh);
-- 
2.25.4

