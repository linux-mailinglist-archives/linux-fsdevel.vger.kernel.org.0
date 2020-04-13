Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 123371A62BD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Apr 2020 07:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgDMFvg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Apr 2020 01:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:44456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbgDMFvg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Apr 2020 01:51:36 -0400
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13FF7C008654;
        Sun, 12 Apr 2020 22:12:27 -0700 (PDT)
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B717B5D6576156E76FA3;
        Mon, 13 Apr 2020 13:12:22 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.183) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Mon, 13 Apr 2020
 13:12:12 +0800
To:     <viro@zeniv.linux.org.uk>, <rostedt@goodmis.org>,
        <mingo@redhat.com>, "Jens Axboe" <axboe@kernel.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <jack@suse.cz>, <tj@kernel.org>, <bigeasy@linutronix.de>,
        linfeilong <linfeilong@huawei.com>,
        Yanxiaodan <yanxiaodan@huawei.com>,
        Mingfangsen <mingfangsen@huawei.com>,
        renxudong <renxudong1@huawei.com>
From:   Zhiqiang Liu <liuzhiqiang26@huawei.com>
Subject: [PATCH] buffer: remove useless comment and WB_REASON_FREE_MORE_MEM,
 reason.
Message-ID: <5844aa66-de1e-278b-5491-b7e6839640e9@huawei.com>
Date:   Mon, 13 Apr 2020 13:12:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.183]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Zhiqiang Liu <liuzhiqiang26@huawei.com>

free_more_memory func has been completely removed in commit bc48f001de12
("buffer: eliminate the need to call free_more_memory() in __getblk_slow()")

So comment and `WB_REASON_FREE_MORE_MEM` reason about free_more_memory
are no longer needed.

Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
---
 fs/buffer.c                      | 2 +-
 include/linux/backing-dev-defs.h | 1 -
 include/trace/events/writeback.h | 1 -
 3 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index b8d28370cfd7..07ab0405f3f5 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -973,7 +973,7 @@ grow_dev_page(struct block_device *bdev, sector_t block,
 	struct page *page;
 	struct buffer_head *bh;
 	sector_t end_block;
-	int ret = 0;		/* Will call free_more_memory() */
+	int ret = 0;
 	gfp_t gfp_mask;

 	gfp_mask = mapping_gfp_constraint(inode->i_mapping, ~__GFP_FS) | gfp;
diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
index 4fc87dee005a..ee577a83cfe6 100644
--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -54,7 +54,6 @@ enum wb_reason {
 	WB_REASON_SYNC,
 	WB_REASON_PERIODIC,
 	WB_REASON_LAPTOP_TIMER,
-	WB_REASON_FREE_MORE_MEM,
 	WB_REASON_FS_FREE_SPACE,
 	/*
 	 * There is no bdi forker thread any more and works are done
diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
index d94def25e4dc..85a33bea76f1 100644
--- a/include/trace/events/writeback.h
+++ b/include/trace/events/writeback.h
@@ -36,7 +36,6 @@
 	EM( WB_REASON_SYNC,			"sync")			\
 	EM( WB_REASON_PERIODIC,			"periodic")		\
 	EM( WB_REASON_LAPTOP_TIMER,		"laptop_timer")		\
-	EM( WB_REASON_FREE_MORE_MEM,		"free_more_memory")	\
 	EM( WB_REASON_FS_FREE_SPACE,		"fs_free_space")	\
 	EMe(WB_REASON_FORKER_THREAD,		"forker_thread")

-- 
2.19.1


