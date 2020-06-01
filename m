Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D60E51EA03B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jun 2020 10:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbgFAIoB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jun 2020 04:44:01 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:42654 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726142AbgFAIoB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jun 2020 04:44:01 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 532D824308EB72B14281;
        Mon,  1 Jun 2020 16:43:56 +0800 (CST)
Received: from fedora-aep.huawei.cmm (10.175.113.49) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Mon, 1 Jun 2020 16:43:51 +0800
From:   yangerkun <yangerkun@huawei.com>
To:     <viro@zeniv.linux.org.uk>, <jlayton@kernel.org>, <neilb@suse.com>
CC:     <linux-fsdevel@vger.kernel.org>
Subject: [PATCH] locks: add locks_move_blocks in posix_lock_inode
Date:   Mon, 1 Jun 2020 17:16:16 +0800
Message-ID: <20200601091616.34137-1-yangerkun@huawei.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.49]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We forget to call locks_move_blocks in posix_lock_inode when try to
process same owner and different types.

Signed-off-by: yangerkun <yangerkun@huawei.com>
---
 fs/locks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/locks.c b/fs/locks.c
index b8a31c1c4fff..36bd2c221786 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1282,6 +1282,7 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 				if (!new_fl)
 					goto out;
 				locks_copy_lock(new_fl, request);
+				locks_move_blocks(new_fl, request);
 				request = new_fl;
 				new_fl = NULL;
 				locks_insert_lock_ctx(request, &fl->fl_list);
-- 
2.21.3

