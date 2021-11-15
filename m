Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C75644FDC5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Nov 2021 04:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237254AbhKOEBm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 Nov 2021 23:01:42 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:15823 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237235AbhKOEB1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 Nov 2021 23:01:27 -0500
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HswQQ6GVHz5pVP;
        Mon, 15 Nov 2021 11:58:06 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
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
Subject: [PATCH 2/2] pipe: delete a duplicate line of code in pipe_write()
Date:   Mon, 15 Nov 2021 11:57:21 +0800
Message-ID: <20211115035721.1909-3-thunder.leizhen@huawei.com>
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

The buf->offset has been assigned to 0 before the copy operation, and it
seems odd to readjust its value after the copy is complete. Delete the
second 'buf->offset = 0'.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 fs/pipe.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 302f1e50ce3be1d..7ba11a633c0eeb9 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -536,7 +536,6 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 				break;
 			}
 			ret += copied;
-			buf->offset = 0;
 			buf->len = copied;
 
 			if (!iov_iter_count(from))
-- 
2.26.0.106.g9fadedd

