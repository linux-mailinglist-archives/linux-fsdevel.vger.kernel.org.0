Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAC617B15DE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 10:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjI1ISi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 04:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjI1ISh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 04:18:37 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90B8B3;
        Thu, 28 Sep 2023 01:18:35 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Rx5w71sVyz4f3mHZ;
        Thu, 28 Sep 2023 16:18:31 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP3 (Coremail) with SMTP id _Ch0CgAngVDXNhVlhwUABg--.50964S4;
        Thu, 28 Sep 2023 16:18:33 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org, dhowells@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] pipe: avoid repeat check of pipe->readers with pipe lock held
Date:   Fri, 29 Sep 2023 00:17:52 +0800
Message-Id: <20230928161752.142268-3-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230928161752.142268-1-shikemeng@huaweicloud.com>
References: <20230928161752.142268-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgAngVDXNhVlhwUABg--.50964S4
X-Coremail-Antispam: 1UD129KBjvdXoW7GFyDJF1xZrWxCw18WFyxuFg_yoWDtwbEk3
        92yF1rWr1fJrWxXa17CF1ayr4UuryDAr17Zr1Yyr9rGF18WryDu3Z5ZFy8AryUXan8GF9x
        Ca9Fyr9rJr1xCjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbfAYFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l87I20VAvwVAaII0Ic2I_JFv_Gryl82
        xGYIkIc2x26280x7IE14v26r15M28IrcIa0xkI8VCY1x0267AKxVWUCVW8JwA2ocxC64kI
        II0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7
        xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
        z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4
        xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v2
        6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwI
        xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
        Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7
        IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK
        8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I
        0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU0TrW7UUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Change to pipe->readers is protected by pipe_lock. Only recheck
pipe->reader after relock to avoid repeat check of pipe->readers with
pipe lock held.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/pipe.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index b19875720ff1..e9c63f66d1c7 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -479,13 +479,6 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 	}
 
 	for (;;) {
-		if (!pipe->readers) {
-			send_sig(SIGPIPE, current, 0);
-			if (!ret)
-				ret = -EPIPE;
-			break;
-		}
-
 		head = pipe->head;
 		if (!pipe_full(head, pipe->tail, pipe->max_usage)) {
 			unsigned int mask = pipe->ring_size - 1;
@@ -573,6 +566,12 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 		__pipe_lock(pipe);
 		was_empty = pipe_empty(pipe->head, pipe->tail);
 		wake_next_writer = true;
+		if (!pipe->readers) {
+			send_sig(SIGPIPE, current, 0);
+			if (!ret)
+				ret = -EPIPE;
+			break;
+		}
 	}
 out:
 	if (pipe_full(pipe->head, pipe->tail, pipe->max_usage))
-- 
2.30.0

