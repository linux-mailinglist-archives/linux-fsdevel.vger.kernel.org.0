Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9444FAF8EE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2019 11:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbfIKJbU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Sep 2019 05:31:20 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:44902 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727459AbfIKJbU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Sep 2019 05:31:20 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D33D74B9B6EAD744FAE6;
        Wed, 11 Sep 2019 17:31:18 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Wed, 11 Sep 2019
 17:31:12 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <viro@zeniv.linux.org.uk>, <jack@suse.cz>,
        <akpm@linux-foundation.org>, <linux-fsdevel@vger.kernel.org>
CC:     <yi.zhang@huawei.com>, <houtao1@huawei.com>,
        <renxudong1@huawei.com>
Subject: [PATCH] Revert "lockless next_positive()"
Date:   Wed, 11 Sep 2019 17:37:57 +0800
Message-ID: <1568194677-127378-1-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[ This reverts commit ebaaa80e8f20 ("lockless next_positive()"),
To avoid the following oops. Of course, we can still find a
better way, I suggest revert this first. ]

Use a script to test kernel(arm64) in the following steps:
(filesystem is tmpfs, dirA already have 10 files, dirB
have 12 files)
1. keep open filenotexist(O_RDWR) in dirA
2. keep open filenotexist(O_RDWR) in dirB
3. keep ls dirB

After 10 minutes, there will be an oops:
Unable to handle kernel paging request at virtual address 00000000003564ad
Process ls (pid: 142652, stack limit = 0x0000000055c452f6)
Call trace:
 dcache_readdir+0xf8/0x1b0
 iterate_dir+0x8c/0x1a8
 ksys_getdents64+0xa4/0x190
 __arm64_sys_getdents64+0x28/0x38
 el0_svc_common+0x78/0x130
 el0_svc_handler+0x38/0x78
 el0_svc+0x8/0xc

The reason is as follows:
1. dirA create new dentryA(dentryA->next = fileA1), and will delete it
lookup_open
  d_alloc_parallel
    d_alloc
    dput -->prev allocated dentry has been added to dentry_hashtable

dput remove dentryA from dirA, dentryA->next is still fileA1.

2. dirB create new dentry(use dentryA), and add it to dirB
d_alloc -->This will need dirB shared lock
   __d_alloc
     INIT_LIST_HEAD(&dentry->d_child)
   spin_lock(&parent->d_lock)
   list_add(&dentry->d_child, &parent->d_subdirs)

3. At the same time, ls dirB -->This will need dirB shared lock
dcache_readdir
  p = &dentry->d_subdirs
  next_positive
    p = from->next

Although d_alloc has spin_lock, next_positive does not have it since
commit ebaaa80e8f20 ("lockless next_positive()").

In arm64, CPU may run out of order. Maybe set parent->d_subdirs->next
first, while dentry->d_child.next is still uninitialized.

dentryA->next is still fileA1, So ls dirB will goto fileA1 which
belongs to dirA, thus oops happens.

Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 fs/libfs.c | 32 +++++---------------------------
 1 file changed, 5 insertions(+), 27 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index c9b2850..3287996 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -93,53 +93,31 @@ static struct dentry *next_positive(struct dentry *parent,
 				    struct list_head *from,
 				    int count)
 {
-	unsigned *seq = &parent->d_inode->i_dir_seq, n;
-	struct dentry *res;
+	struct dentry *res = NULL;
 	struct list_head *p;
-	bool skipped;
-	int i;

-retry:
-	i = count;
-	skipped = false;
-	n = smp_load_acquire(seq) & ~1;
-	res = NULL;
-	rcu_read_lock();
+	spin_lock(&parent->d_lock);
 	for (p = from->next; p != &parent->d_subdirs; p = p->next) {
 		struct dentry *d = list_entry(p, struct dentry, d_child);
-		if (!simple_positive(d)) {
-			skipped = true;
-		} else if (!--i) {
+		if (simple_positive(d) && !--count) {
 			res = d;
 			break;
 		}
 	}
-	rcu_read_unlock();
-	if (skipped) {
-		smp_rmb();
-		if (unlikely(*seq != n))
-			goto retry;
-	}
+	spin_unlock(&parent->d_lock);
 	return res;
 }

 static void move_cursor(struct dentry *cursor, struct list_head *after)
 {
 	struct dentry *parent = cursor->d_parent;
-	unsigned n, *seq = &parent->d_inode->i_dir_seq;
+
 	spin_lock(&parent->d_lock);
-	for (;;) {
-		n = *seq;
-		if (!(n & 1) && cmpxchg(seq, n, n + 1) == n)
-			break;
-		cpu_relax();
-	}
 	__list_del(cursor->d_child.prev, cursor->d_child.next);
 	if (after)
 		list_add(&cursor->d_child, after);
 	else
 		list_add_tail(&cursor->d_child, &parent->d_subdirs);
-	smp_store_release(seq, n + 2);
 	spin_unlock(&parent->d_lock);
 }

--
2.7.4

