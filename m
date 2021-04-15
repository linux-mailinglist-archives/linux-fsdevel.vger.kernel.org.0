Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 026D5360610
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Apr 2021 11:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbhDOJoW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Apr 2021 05:44:22 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:17340 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232204AbhDOJoR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Apr 2021 05:44:17 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FLZ9V26V1zB1Gr;
        Thu, 15 Apr 2021 17:41:34 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Thu, 15 Apr 2021 17:43:42 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <viro@zeniv.linux.org.uk>, <jack@suse.com>,
        <linux-fsdevel@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] direct-io: use read lock for DIO_LOCKING flag
Date:   Thu, 15 Apr 2021 17:43:32 +0800
Message-ID: <20210415094332.37231-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

9902af79c01a ("parallel lookups: actual switch to rwsem") changes inode
lock from mutex to rwsem, however, we forgot to adjust lock for
DIO_LOCKING flag in do_blockdev_direct_IO(), so let's change to hold read
lock to mitigate performance regression in the case of read DIO vs read DIO,
meanwhile it still keeps original functionality of avoiding buffered access
vs direct access.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/direct-io.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/direct-io.c b/fs/direct-io.c
index b2e86e739d7a..93ff912f2749 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -1166,7 +1166,7 @@ do_blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 	dio->flags = flags;
 	if (dio->flags & DIO_LOCKING && iov_iter_rw(iter) == READ) {
 		/* will be released by direct_io_worker */
-		inode_lock(inode);
+		inode_lock_shared(inode);
 	}
 
 	/* Once we sampled i_size check for reads beyond EOF */
@@ -1316,7 +1316,7 @@ do_blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 	 * of protecting us from looking up uninitialized blocks.
 	 */
 	if (iov_iter_rw(iter) == READ && (dio->flags & DIO_LOCKING))
-		inode_unlock(dio->inode);
+		inode_unlock_shared(dio->inode);
 
 	/*
 	 * The only time we want to leave bios in flight is when a successful
@@ -1341,7 +1341,7 @@ do_blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 
 fail_dio:
 	if (dio->flags & DIO_LOCKING && iov_iter_rw(iter) == READ)
-		inode_unlock(inode);
+		inode_unlock_shared(inode);
 
 	kmem_cache_free(dio_cache, dio);
 	return retval;
-- 
2.29.2

