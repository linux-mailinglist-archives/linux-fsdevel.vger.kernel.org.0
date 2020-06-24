Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8657206A66
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 05:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388454AbgFXDHM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Jun 2020 23:07:12 -0400
Received: from mail.loongson.cn ([114.242.206.163]:37844 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387985AbgFXDHL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Jun 2020 23:07:11 -0400
Received: from ticat.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxT2hYw_Je_A1JAA--.474S2;
        Wed, 24 Jun 2020 11:07:04 +0800 (CST)
From:   Peng Fan <fanpeng@loongson.cn>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: [PATCH] fs/read_write.c: Fix memory leak in read_write.c
Date:   Wed, 24 Jun 2020 11:07:03 +0800
Message-Id: <1592968023-20383-1-git-send-email-fanpeng@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9DxT2hYw_Je_A1JAA--.474S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw4UXry5XFy7urWkAryxXwb_yoW8GF1fpr
        47Ca1UKF48tr18AFs8KFn8WFyDAw4DCFZrGr43tw10vws7uF4vy3WUKry2gr4UAFZ7ArWU
        ZF1Iy3sIyFy5AaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F
        4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_
        Gr4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
        WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI
        7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
        1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4U
        MIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUUVHq5UUUU
        U==
X-CM-SenderInfo: xidq1vtqj6z05rqj20fqof0/
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

kmemleak report:
unreferenced object 0x98000002bb591d00 (size 256):
  comm "ftest03", pid 24778, jiffies 4301603810 (age 490.665s)
  hex dump (first 32 bytes):
    00 01 04 20 01 00 00 00 80 00 00 00 00 00 00 00  ... ............
    f0 02 04 20 01 00 00 00 80 00 00 00 00 00 00 00  ... ............
  backtrace:
    [<0000000050b162cb>] __kmalloc+0x234/0x438
    [<00000000491da9c7>] rw_copy_check_uvector+0x1ac/0x1f0
    [<00000000b0dddb43>] import_iovec+0x50/0xe8
    [<00000000ae843d73>] vfs_readv+0x50/0xb0
    [<00000000c7216b06>] do_readv+0x80/0x160
    [<00000000cad79c3f>] syscall_common+0x34/0x58

This is because "iov" allocated by kmalloc() is not destroyed. Under normal
circumstances, "ret_pointer" should be equal to "iov". But if the previous 
statements fails to execute, and the allocation is successful, then the
block of memory will not be released, because it is necessary to 
determine whether they are equal. So we need to change the order.

Signed-off-by: Peng Fan <fanpeng@loongson.cn>
---
 fs/read_write.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index bbfa9b1..aa4f7c5 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -832,8 +832,8 @@ ssize_t rw_copy_check_uvector(int type, const struct iovec __user * uvector,
 		}
 		ret += len;
 	}
-out:
 	*ret_pointer = iov;
+out:
 	return ret;
 }
 
-- 
2.1.0

