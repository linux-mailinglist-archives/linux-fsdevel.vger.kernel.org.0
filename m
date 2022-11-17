Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F40D62D9ED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Nov 2022 12:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234870AbiKQLx6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Nov 2022 06:53:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239197AbiKQLxq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Nov 2022 06:53:46 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41011263D;
        Thu, 17 Nov 2022 03:53:44 -0800 (PST)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NCdWP15TzzqSTT;
        Thu, 17 Nov 2022 19:49:53 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 19:53:42 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 19:53:41 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        David Howells <dhowells@redhat.com>
Subject: [PATCH] pipe: fix potential use-after-free in pipe_read()
Date:   Thu, 17 Nov 2022 19:53:23 +0800
Message-ID: <20221117115323.1718-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.37.3.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Accessing buf->flags after pipe_buf_release(pipe, buf) is unsafe, because
the 'buf' memory maybe freed.

In fact, pipe->note_loss does not need the protection of spinlock
pipe->rd_wait.lock, it only needs the protection of __pipe_lock(pipe). So
make the assignment of pipe->note_loss complete before releasing 'buf' to
eliminate the risk.

Fixes: e7d553d69cf6 ("pipe: Add notification lossage handling")
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 fs/pipe.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 42c7ff41c2dba29..0f873949337ed28 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -321,12 +321,12 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 			}
 
 			if (!buf->len) {
-				pipe_buf_release(pipe, buf);
-				spin_lock_irq(&pipe->rd_wait.lock);
 #ifdef CONFIG_WATCH_QUEUE
 				if (buf->flags & PIPE_BUF_FLAG_LOSS)
 					pipe->note_loss = true;
 #endif
+				pipe_buf_release(pipe, buf);
+				spin_lock_irq(&pipe->rd_wait.lock);
 				tail++;
 				pipe->tail = tail;
 				spin_unlock_irq(&pipe->rd_wait.lock);
-- 
2.25.1

