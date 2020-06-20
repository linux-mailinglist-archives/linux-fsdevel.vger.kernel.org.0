Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7324F201FE8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jun 2020 04:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732131AbgFTCxg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Jun 2020 22:53:36 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:54918 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732006AbgFTCxf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Jun 2020 22:53:35 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 866D37C39C1D07AFF78E;
        Sat, 20 Jun 2020 10:53:33 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Sat, 20 Jun 2020
 10:53:21 +0800
From:   "zhangyi (F)" <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>, <tytso@mit.edu>, <jack@suse.cz>
CC:     <adilger.kernel@dilger.ca>, <zhangxiaoxu5@huawei.com>,
        <yi.zhang@huawei.com>, <linux-fsdevel@vger.kernel.org>
Subject: [PATCH v3 3/5] ext4: remove write io error check before read inode block
Date:   Sat, 20 Jun 2020 10:54:25 +0800
Message-ID: <20200620025427.1756360-4-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200620025427.1756360-1-yi.zhang@huawei.com>
References: <20200620025427.1756360-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

After we add async write error check in ext4_journal_get_write_access(),
we can remove the partial fix for filesystem inconsistency problem
caused by reading old data from disk, which in commit <9c83a923c67d>
"ext4: don't read inode block if the buffer has a write error".

Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
---
 fs/ext4/inode.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index f68afc5c0b2d..79b73a86ef6c 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4289,15 +4289,6 @@ static int __ext4_get_inode_loc(struct inode *inode,
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

