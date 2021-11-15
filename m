Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E39C644FDC4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Nov 2021 04:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237245AbhKOEBj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 Nov 2021 23:01:39 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:27204 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237234AbhKOEB1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 Nov 2021 23:01:27 -0500
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4HswNr0g0zz8vNd;
        Mon, 15 Nov 2021 11:56:44 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 15 Nov 2021 11:58:25 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 15 Nov 2021 11:58:25 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/2] pipe: fix potential use-after-free in pipe_read()
Date:   Mon, 15 Nov 2021 11:57:20 +0800
Message-ID: <20211115035721.1909-2-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20211115035721.1909-1-thunder.leizhen@huawei.com>
References: <20211115035721.1909-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Accessing buf->flags after pipe_buf_release(pipe, buf) is unsafe, because
the 'buf' memory maybe freed.

Fixes: e7d553d69cf6 ("pipe: Add notification lossage handling")
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 fs/pipe.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 6d4342bad9f15b2..302f1e50ce3be1d 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -319,10 +319,12 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 			}
 
 			if (!buf->len) {
+				unsigned int __maybe_unused flags = buf->flags;
+
 				pipe_buf_release(pipe, buf);
 				spin_lock_irq(&pipe->rd_wait.lock);
 #ifdef CONFIG_WATCH_QUEUE
-				if (buf->flags & PIPE_BUF_FLAG_LOSS)
+				if (flags & PIPE_BUF_FLAG_LOSS)
 					pipe->note_loss = true;
 #endif
 				tail++;
-- 
2.26.0.106.g9fadedd

