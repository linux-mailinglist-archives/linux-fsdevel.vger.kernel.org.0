Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4F0AAF00E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2019 18:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436983AbfIJQ7E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Sep 2019 12:59:04 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2261 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2436951AbfIJQ7D (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Sep 2019 12:59:03 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id EFECA36A1693ACCB51C4;
        Wed, 11 Sep 2019 00:58:58 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Wed, 11 Sep 2019
 00:58:52 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <viro@zeniv.linux.org.uk>, <jack@suse.cz>,
        <akpm@linux-foundation.org>, <linux-fsdevel@vger.kernel.org>
CC:     <yi.zhang@huawei.com>, <houtao1@huawei.com>,
        <renxudong1@huawei.com>
Subject: [PATCH] fs: need to ensure that dentry is initialized before it is added to parent dentry
Date:   Wed, 11 Sep 2019 01:05:37 +0800
Message-ID: <1568135137-106264-1-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

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

Let's look about __d_alloc:
INIT_LIST_HEAD(&dentry->d_child) have 2 steps:
1. dentry->d_child.next = &dentry->d_child
2. dentry->d_child.prev = &dentry->d_child

list_add have 4 steps:
3. parent->d_subdirs.next->prev = &dentry->d_child
4. dentry->d_child.next = parent->d_subdirs.next
5. dentry->d_child.prev = &parent->d_subdirs
6. parent->d_subdirs.next = &dentry->d_child

In arm64, CPU may run out of order. It only guarantees 4 is after 1,
5 is after 2. Maybe set parent->d_subdirs->next first, while
dentry->d_child.next is still uninitialized.

dentryA->next is still fileA1, So ls dirB will goto fileA1 which
belongs to dirA, thus oops happens.

Need to ensure that dentry is initialized before it is added to
parent dentry.
PS: After add smp_wmb, we test it in 10 hours, the oops does not happen.

Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 fs/dcache.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/dcache.c b/fs/dcache.c
index e88cf05..0a07671 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1767,6 +1767,16 @@ struct dentry *d_alloc(struct dentry * parent, const struct qstr *name)
 	struct dentry *dentry = __d_alloc(parent->d_sb, name);
 	if (!dentry)
 		return NULL;
+
+	/*
+	 * need to ensure that dentry->d_child.next is initialized
+	 * (__d_alloc->INIT_LIST_HEAD) before dentry is added to
+	 * parent->d_subdirs, Otherwise in next_positive(do not have
+	 * spin_lock), we may visit uninitialized value because of cpu
+	 * run optimization(first add dentry to parent->d_subdirs).
+	 */
+	smp_wmb();
+
 	spin_lock(&parent->d_lock);
 	/*
 	 * don't need child lock because it is not subject
--
2.7.4

