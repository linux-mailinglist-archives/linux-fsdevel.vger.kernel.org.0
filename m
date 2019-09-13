Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07D23B232D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2019 17:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391355AbfIMPRY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Sep 2019 11:17:24 -0400
Received: from relay.sw.ru ([185.231.240.75]:60990 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388354AbfIMPRY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Sep 2019 11:17:24 -0400
Received: from [172.16.24.21]
        by relay.sw.ru with esmtp (Exim 4.92)
        (envelope-from <vvs@virtuozzo.com>)
        id 1i8nK5-0006fH-Mk; Fri, 13 Sep 2019 18:17:21 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH] fuse: lost unlock_page in fuse_writepage()
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <d1d73587-2fdd-c09e-589b-dd7bd039e08d@virtuozzo.com>
Date:   Fri, 13 Sep 2019 18:17:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

unlock_page() was lost in fuse_writepage()

Fixes commit ff17be086477 ("fuse: writepage: skip already in flight") # 3.13+

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 fs/fuse/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 5ae2828beb00..91c99724dee0 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1767,6 +1767,7 @@ static int fuse_writepage(struct page *page, struct writeback_control *wbc)
 		WARN_ON(wbc->sync_mode == WB_SYNC_ALL);
 
 		redirty_page_for_writepage(wbc, page);
+		unlock_page(page);
 		return 0;
 	}
 
-- 
2.17.1

