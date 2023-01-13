Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4536695B8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jan 2023 12:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbjAMLhM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Jan 2023 06:37:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240584AbjAMLgr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Jan 2023 06:36:47 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7BBF65B4;
        Fri, 13 Jan 2023 03:23:46 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NtfDq53jDz4f4bKJ;
        Fri, 13 Jan 2023 19:23:39 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgBXwLM6P8Fj7hGXBg--.28092S6;
        Fri, 13 Jan 2023 19:23:42 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
To:     linux-cachefs@redhat.com
Cc:     David Howells <dhowells@redhat.com>,
        Jeff Layton <jlayton@kernel.org>, linux-erofs@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jingbo Xu <jefflexu@linux.alibaba.com>, houtao1@huawei.com
Subject: [PATCH v3 2/2] fscache: Use clear_and_wake_up_bit() in fscache_create_volume_work()
Date:   Fri, 13 Jan 2023 19:52:11 +0800
Message-Id: <20230113115211.2895845-3-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20230113115211.2895845-1-houtao@huaweicloud.com>
References: <20230113115211.2895845-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBXwLM6P8Fj7hGXBg--.28092S6
X-Coremail-Antispam: 1UD129KBjvJXoW7tryxXF18tr4DCF45JFy3CFg_yoW8Jw1Upr
        Z3GF1Sgay8X39rJr4DX3y7Z34fWryUGan7Cr10y3W7Zr4rAryFv3Z0kas8uF17C3yDJrWf
        ZF15Kw43Wr1UAr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvlb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
        A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
        0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
        JVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
        W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
        1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
        IIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
        x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
        DU0xZFpf9x07je89NUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Hou Tao <houtao1@huawei.com>

fscache_create_volume_work() uses wake_up_bit() to wake up the processes
which are waiting for the completion of volume creation. According to
comments in wake_up_bit() and waitqueue_active(), an extra smp_mb() is
needed to guarantee the memory order between FSCACHE_VOLUME_CREATING
flag and waitqueue_active() before invoking wake_up_bit().

Fixing it by using clear_and_wake_up_bit() to add the missing memory
barrier.

Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 fs/fscache/volume.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/fscache/volume.c b/fs/fscache/volume.c
index 903af9d85f8b..cdf991bdd9de 100644
--- a/fs/fscache/volume.c
+++ b/fs/fscache/volume.c
@@ -280,8 +280,7 @@ static void fscache_create_volume_work(struct work_struct *work)
 	fscache_end_cache_access(volume->cache,
 				 fscache_access_acquire_volume_end);
 
-	clear_bit_unlock(FSCACHE_VOLUME_CREATING, &volume->flags);
-	wake_up_bit(&volume->flags, FSCACHE_VOLUME_CREATING);
+	clear_and_wake_up_bit(FSCACHE_VOLUME_CREATING, &volume->flags);
 	fscache_put_volume(volume, fscache_volume_put_create_work);
 }
 
-- 
2.29.2

