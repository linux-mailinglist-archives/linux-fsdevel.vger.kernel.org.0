Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9644078A6CA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Aug 2023 09:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjH1Hvp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Aug 2023 03:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjH1HvP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Aug 2023 03:51:15 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1216114;
        Mon, 28 Aug 2023 00:51:12 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RZ2mp2VZcz4f4XWm;
        Mon, 28 Aug 2023 15:51:06 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgC3RqntUexkiIAVBw--.11528S2;
        Mon, 28 Aug 2023 15:51:09 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] vfs: use helpers for calling f_op->{read,write}_iter() in read_write.c
Date:   Mon, 28 Aug 2023 23:50:56 +0800
Message-Id: <20230828155056.4100924-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgC3RqntUexkiIAVBw--.11528S2
X-Coremail-Antispam: 1UD129KBjvdXoWruF1fXw4kGrW7XrWxWw47CFg_yoWDZrc_CF
        nFyr1xJFWqkrs7J348C3ZIvFy0gw4Y9Fn5Wr4vyrWDKa1xWFykZrZ5Zr1DAF1YqanFgFsx
        Cws2v345JryUCjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb7AYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l87I20VAvwVAaII0Ic2I_JFv_Gryl8c
        AvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq
        3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gc
        CE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxI
        r21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87
        Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IY
        c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
        026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF
        0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0x
        vE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
        jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU0sqXJUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        MAY_BE_FORGED,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

use helpers for calling f_op->{read,write}_iter() in read_write.c

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/read_write.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index a21ba3be7dbe..2f816f1212f4 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -425,7 +425,7 @@ ssize_t __kernel_read(struct file *file, void *buf, size_t count, loff_t *pos)
 	init_sync_kiocb(&kiocb, file);
 	kiocb.ki_pos = pos ? *pos : 0;
 	iov_iter_kvec(&iter, ITER_DEST, &iov, 1, iov.iov_len);
-	ret = file->f_op->read_iter(&kiocb, &iter);
+	ret = call_read_iter(file, &kiocb, &iter);
 	if (ret > 0) {
 		if (pos)
 			*pos = kiocb.ki_pos;
@@ -514,7 +514,7 @@ ssize_t __kernel_write_iter(struct file *file, struct iov_iter *from, loff_t *po
 
 	init_sync_kiocb(&kiocb, file);
 	kiocb.ki_pos = pos ? *pos : 0;
-	ret = file->f_op->write_iter(&kiocb, from);
+	ret = call_write_iter(file, &kiocb, from);
 	if (ret > 0) {
 		if (pos)
 			*pos = kiocb.ki_pos;
-- 
2.30.0

