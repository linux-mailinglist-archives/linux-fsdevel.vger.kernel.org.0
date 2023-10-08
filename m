Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C815B7BCB9F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Oct 2023 03:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344303AbjJHBsQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 Oct 2023 21:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344267AbjJHBsP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 Oct 2023 21:48:15 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AEF3B6;
        Sat,  7 Oct 2023 18:48:14 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4S34n20knsz4f3khf;
        Sun,  8 Oct 2023 09:48:06 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP1 (Coremail) with SMTP id cCh0CgBH0bFZCiJl7zQbCQ--.22902S3;
        Sun, 08 Oct 2023 09:48:11 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org, dhowells@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] pipe: remove pipe_full check with wrong head in pipe_write
Date:   Sun,  8 Oct 2023 17:48:00 +0800
Message-Id: <20231008094801.354312-2-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20231008094801.354312-1-shikemeng@huaweicloud.com>
References: <20231008094801.354312-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgBH0bFZCiJl7zQbCQ--.22902S3
X-Coremail-Antispam: 1UD129KBjvdXoWruF13Cw1xAr45GF1xurWDXFb_yoWkKFgEka
        97CFn3ur43Jr48Jw17CFnakryxW34Uur1UZrW5Ar9xJF1kWr98u3s5W34DC34UZ3Z8tF9x
        C392van2vr1fWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbf8YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l87I20VAvwVAaII0Ic2I_JFv_Gryl82
        xGYIkIc2x26280x7IE14v26r18M28IrcIa0xkI8VCY1x0267AKxVWUXVWUCwA2ocxC64kI
        II0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7
        xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
        z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4
        xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v2
        6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwI
        xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
        Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7
        IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k2
        6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
        AFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU0a0PDUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=1.8 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        KHOP_HELO_FCRDNS,MAY_BE_FORGED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In pipe_write we have:
	head = pipe->head;
	if (!pipe_full(head, pipe->tail, pipe->max_usage))
		pipe->head = head + 1;
		/* write data to buffer at head */

	/* supposed to check if pipe is full after write */
	if (!pipe_full(head, pipe->tail, pipe->max_usage))
		continue

The second pipe_full expects head after write but head before write is
used. Luckily, we will call pipe_full with correct reloaded pipe->head
in new loop cycle and stop writing correctly. Remove wrong pipe_full
check and simply continue to first pipe_full check after write done to
avoid unnecessary check.

Fixes: a194dfe6e6f6 ("pipe: Rearrange sequence in pipe_write() to preallocate slot")
Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/pipe.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 2d88f73f585a..b19875720ff1 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -542,10 +542,9 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 
 			if (!iov_iter_count(from))
 				break;
-		}
 
-		if (!pipe_full(head, pipe->tail, pipe->max_usage))
 			continue;
+		}
 
 		/* Wait for buffer space to become available. */
 		if ((filp->f_flags & O_NONBLOCK) ||
-- 
2.30.0

