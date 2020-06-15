Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9691F8C05
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jun 2020 03:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgFOBO5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 Jun 2020 21:14:57 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5884 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727969AbgFOBO5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 Jun 2020 21:14:57 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id BCB86E364E1C73D4E395;
        Mon, 15 Jun 2020 09:14:54 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Mon, 15 Jun 2020
 09:14:48 +0800
From:   Zheng Bin <zhengbin13@huawei.com>
To:     <ericvh@gmail.com>, <lucho@ionkov.net>, <asmadeus@codewreck.org>,
        <v9fs-developer@lists.sourceforge.net>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <yi.zhang@huawei.com>, <zhengbin13@huawei.com>
Subject: [PATCH RESEND] 9p: Fix memory leak in v9fs_mount
Date:   Mon, 15 Jun 2020 09:21:53 +0800
Message-ID: <20200615012153.89538-1-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.26.0.106.g9fadedd
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

v9fs_mount
  v9fs_session_init
    v9fs_cache_session_get_cookie
      v9fs_random_cachetag                     -->alloc cachetag
      v9ses->fscache = fscache_acquire_cookie  -->maybe NULL
  sb = sget                                    -->fail, goto clunk
clunk_fid:
  v9fs_session_close
    if (v9ses->fscache)                        -->NULL
      kfree(v9ses->cachetag)

Thus memleak happens.

Signed-off-by: Zheng Bin <zhengbin13@huawei.com>
---
 fs/9p/v9fs.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index 15a99f9c7253..39def020a074 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -500,10 +500,9 @@ void v9fs_session_close(struct v9fs_session_info *v9ses)
 	}

 #ifdef CONFIG_9P_FSCACHE
-	if (v9ses->fscache) {
+	if (v9ses->fscache)
 		v9fs_cache_session_put_cookie(v9ses);
-		kfree(v9ses->cachetag);
-	}
+	kfree(v9ses->cachetag);
 #endif
 	kfree(v9ses->uname);
 	kfree(v9ses->aname);
--
2.26.0.106.g9fadedd

