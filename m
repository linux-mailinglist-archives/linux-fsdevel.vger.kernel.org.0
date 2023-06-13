Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3606E72D9D8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jun 2023 08:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239835AbjFMGYf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jun 2023 02:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239483AbjFMGYd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jun 2023 02:24:33 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392F6E6B;
        Mon, 12 Jun 2023 23:24:29 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4QgJPn4N0ZzLmpq;
        Tue, 13 Jun 2023 14:22:37 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.175) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 14:24:26 +0800
From:   Lu Jialin <lujialin4@huawei.com>
To:     Lu Jialin <lujialin4@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Subject: [PATCH] sched/psi: Fix use-after-free in poll_freewait()
Date:   Tue, 13 Jun 2023 14:23:06 +0800
Message-ID: <20230613062306.101831-1-lujialin4@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.175]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We found a UAF bug in remove_wait_queue as follows:

==================================================================
BUG: KASAN: use-after-free in _raw_spin_lock_irqsave+0x71/0xe0
Write of size 4 at addr ffff8881150d7b28 by task psi_trigger/15306
Call Trace:
 dump_stack+0x9c/0xd3
 print_address_description.constprop.0+0x19/0x170
 __kasan_report.cold+0x6c/0x84
 kasan_report+0x3a/0x50
 check_memory_region+0xfd/0x1f0
 _raw_spin_lock_irqsave+0x71/0xe0
 remove_wait_queue+0x26/0xc0
 poll_freewait+0x6b/0x120
 do_sys_poll+0x305/0x400
 do_syscall_64+0x33/0x40
 entry_SYSCALL_64_after_hwframe+0x61/0xc6

Allocated by task 15306:
 kasan_save_stack+0x1b/0x40
 __kasan_kmalloc.constprop.0+0xb5/0xe0
 psi_trigger_create.part.0+0xfc/0x450
 cgroup_pressure_write+0xfc/0x3b0
 cgroup_file_write+0x1b3/0x390
 kernfs_fop_write_iter+0x224/0x2e0
 new_sync_write+0x2ac/0x3a0
 vfs_write+0x365/0x430
 ksys_write+0xd5/0x1b0
 do_syscall_64+0x33/0x40
 entry_SYSCALL_64_after_hwframe+0x61/0xc6

Freed by task 15850:
 kasan_save_stack+0x1b/0x40
 kasan_set_track+0x1c/0x30
 kasan_set_free_info+0x20/0x40
 __kasan_slab_free+0x151/0x180
 kfree+0xba/0x680
 cgroup_file_release+0x5c/0xe0
 kernfs_drain_open_files+0x122/0x1e0
 kernfs_drain+0xff/0x1e0
 __kernfs_remove.part.0+0x1d1/0x3b0
 kernfs_remove_by_name_ns+0x89/0xf0
 cgroup_addrm_files+0x393/0x3d0
 css_clear_dir+0x8f/0x120
 kill_css+0x41/0xd0
 cgroup_destroy_locked+0x166/0x300
 cgroup_rmdir+0x37/0x140
 kernfs_iop_rmdir+0xbb/0xf0
 vfs_rmdir.part.0+0xa5/0x230
 do_rmdir+0x2e0/0x320
 __x64_sys_unlinkat+0x99/0xc0
 do_syscall_64+0x33/0x40
 entry_SYSCALL_64_after_hwframe+0x61/0xc6
==================================================================

If using epoll(), wake_up_pollfree will empty waitqueue and set
wait_queue_head is NULL before free waitqueue of psi trigger. But is
doesn't work when using poll(), which will lead a UAF problem in
poll_freewait coms as following:

(cgroup_rmdir)                      |
psi_trigger_destroy                 |
  wake_up_pollfree(&t->event_wait)  |
    kfree(t)                        |
				    |	(poll_freewait)
				    |     free_poll_entry(pwq->inline_entries + i)
				    |	    remove_wait_queue(entry->wait_address)
				    |	      spin_lock_irqsave(&wq_head->lock)

entry->wait_address in poll_freewait() is t->event_wait in cgroup_rmdir().
t->event_wait is free in psi_trigger_destroy before call poll_freewait(),
therefore wq_head in poll_freewait() has been already freed, which would
lead to a UAF.

similar problem for epoll() has been fixed commit c2dbe32d5db5
("sched/psi: Fix use-after-free in ep_remove_wait_queue()").
epoll wakeup function ep_poll_callback() will empty waitqueue and set
wait_queue_head is NULL when pollflags is POLLFREE and judge pwq->whead
is NULL or not before remove_wait_queue in ep_remove_wait_queue(),
which will fix the UAF bug in ep_remove_wait_queue.

But poll wakeup function pollwake() doesn't do that. To fix the
problem, we empty waitqueue and set wait_address is NULL in pollwake() when
key is POLLFREE. otherwise in remove_wait_queue, which is similar to
epoll().

Fixes: 0e94682b73bf ("psi: introduce psi monitor")
Signed-off-by: Lu Jialin <lujialin4@huawei.com>
---
 fs/select.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/fs/select.c b/fs/select.c
index 0ee55af1a55c..e64c7b4e9959 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -132,7 +132,17 @@ EXPORT_SYMBOL(poll_initwait);
 
 static void free_poll_entry(struct poll_table_entry *entry)
 {
-	remove_wait_queue(entry->wait_address, &entry->wait);
+	wait_queue_head_t *whead;
+
+	rcu_read_lock();
+	/* If it is cleared by POLLFREE, it should be rcu-safe.
+	 * If we read NULL we need a barrier paired with smp_store_release()
+	 * in pollwake().
+	 */
+	whead = smp_load_acquire(&entry->wait_address);
+	if (whead)
+		remove_wait_queue(whead, &entry->wait);
+	rcu_read_unlock();
 	fput(entry->filp);
 }
 
@@ -215,6 +225,14 @@ static int pollwake(wait_queue_entry_t *wait, unsigned mode, int sync, void *key
 	entry = container_of(wait, struct poll_table_entry, wait);
 	if (key && !(key_to_poll(key) & entry->key))
 		return 0;
+	if (key_to_poll(key) & POLLFREE) {
+		list_del_init(&wait->entry);
+		/* wait_address !=NULL protects us from the race with
+		 * poll_freewait().
+		 */
+		smp_store_release(&entry->wait_address, NULL);
+		return 0;
+	}
 	return __pollwake(wait, mode, sync, key);
 }
 
-- 
2.17.1

