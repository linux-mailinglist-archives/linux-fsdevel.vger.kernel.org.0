Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D64D6695BD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jan 2023 12:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241123AbjAMLhP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Jan 2023 06:37:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241261AbjAMLgs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Jan 2023 06:36:48 -0500
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FBE4F13B;
        Fri, 13 Jan 2023 03:23:53 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4NtfDq1kmQz4f3v6x;
        Fri, 13 Jan 2023 19:23:39 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgBXwLM6P8Fj7hGXBg--.28092S5;
        Fri, 13 Jan 2023 19:23:41 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
To:     linux-cachefs@redhat.com
Cc:     David Howells <dhowells@redhat.com>,
        Jeff Layton <jlayton@kernel.org>, linux-erofs@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jingbo Xu <jefflexu@linux.alibaba.com>, houtao1@huawei.com
Subject: [PATCH v3 1/2] fscache: Use wait_on_bit() to wait for the freeing of relinquished volume
Date:   Fri, 13 Jan 2023 19:52:10 +0800
Message-Id: <20230113115211.2895845-2-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20230113115211.2895845-1-houtao@huaweicloud.com>
References: <20230113115211.2895845-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBXwLM6P8Fj7hGXBg--.28092S5
X-Coremail-Antispam: 1UD129KBjvJXoWxCF45KrWftrWxXrWxury7trb_yoWrJFyfp3
        9I9343trW8X3srAw4kJw4UZrySgFykJan7CrWvkry7Aw4ftF1UtF10k34ruFW7A3yDJrWI
        va1jqw13Ww1UAFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvlb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
        A2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
        0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
        JVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
        W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
        1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
        IIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
        x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
        DU0xZFpf9x07UiAwxUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Hou Tao <houtao1@huawei.com>

The freeing of relinquished volume will wake up the pending volume
acquisition by using wake_up_bit(), however it is mismatched with
wait_var_event() used in fscache_wait_on_volume_collision() and it will
never wake up the waiter in the wait-queue because these two functions
operate on different wait-queues.

According to the implementation in fscache_wait_on_volume_collision(),
if the wake-up of pending acquisition is delayed longer than 20 seconds
(e.g., due to the delay of on-demand fd closing), the first
wait_var_event_timeout() will timeout and the following wait_var_event()
will hang forever as shown below:

 FS-Cache: Potential volume collision new=00000024 old=00000022
 ......
 INFO: task mount:1148 blocked for more than 122 seconds.
       Not tainted 6.1.0-rc6+ #1
 task:mount           state:D stack:0     pid:1148  ppid:1
 Call Trace:
  <TASK>
  __schedule+0x2f6/0xb80
  schedule+0x67/0xe0
  fscache_wait_on_volume_collision.cold+0x80/0x82
  __fscache_acquire_volume+0x40d/0x4e0
  erofs_fscache_register_volume+0x51/0xe0 [erofs]
  erofs_fscache_register_fs+0x19c/0x240 [erofs]
  erofs_fc_fill_super+0x746/0xaf0 [erofs]
  vfs_get_super+0x7d/0x100
  get_tree_nodev+0x16/0x20
  erofs_fc_get_tree+0x20/0x30 [erofs]
  vfs_get_tree+0x24/0xb0
  path_mount+0x2fa/0xa90
  do_mount+0x7c/0xa0
  __x64_sys_mount+0x8b/0xe0
  do_syscall_64+0x30/0x60
  entry_SYSCALL_64_after_hwframe+0x46/0xb0

Considering that wake_up_bit() is more selective, so fix it by using
wait_on_bit() instead of wait_var_event() to wait for the freeing of
relinquished volume. In addition because waitqueue_active() is used in
wake_up_bit() and clear_bit() doesn't imply any memory barrier, use
clear_and_wake_up_bit() to add the missing memory barrier between
cursor->flags and waitqueue_active().

Fixes: 62ab63352350 ("fscache: Implement volume registration")
Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 fs/fscache/volume.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/fscache/volume.c b/fs/fscache/volume.c
index ab8ceddf9efa..903af9d85f8b 100644
--- a/fs/fscache/volume.c
+++ b/fs/fscache/volume.c
@@ -141,13 +141,14 @@ static bool fscache_is_acquire_pending(struct fscache_volume *volume)
 static void fscache_wait_on_volume_collision(struct fscache_volume *candidate,
 					     unsigned int collidee_debug_id)
 {
-	wait_var_event_timeout(&candidate->flags,
-			       !fscache_is_acquire_pending(candidate), 20 * HZ);
+	wait_on_bit_timeout(&candidate->flags, FSCACHE_VOLUME_ACQUIRE_PENDING,
+			    TASK_UNINTERRUPTIBLE, 20 * HZ);
 	if (fscache_is_acquire_pending(candidate)) {
 		pr_notice("Potential volume collision new=%08x old=%08x",
 			  candidate->debug_id, collidee_debug_id);
 		fscache_stat(&fscache_n_volumes_collision);
-		wait_var_event(&candidate->flags, !fscache_is_acquire_pending(candidate));
+		wait_on_bit(&candidate->flags, FSCACHE_VOLUME_ACQUIRE_PENDING,
+			    TASK_UNINTERRUPTIBLE);
 	}
 }
 
@@ -347,8 +348,8 @@ static void fscache_wake_pending_volume(struct fscache_volume *volume,
 	hlist_bl_for_each_entry(cursor, p, h, hash_link) {
 		if (fscache_volume_same(cursor, volume)) {
 			fscache_see_volume(cursor, fscache_volume_see_hash_wake);
-			clear_bit(FSCACHE_VOLUME_ACQUIRE_PENDING, &cursor->flags);
-			wake_up_bit(&cursor->flags, FSCACHE_VOLUME_ACQUIRE_PENDING);
+			clear_and_wake_up_bit(FSCACHE_VOLUME_ACQUIRE_PENDING,
+					      &cursor->flags);
 			return;
 		}
 	}
-- 
2.29.2

