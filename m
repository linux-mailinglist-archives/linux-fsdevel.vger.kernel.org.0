Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BEA441B13F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Sep 2021 15:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241058AbhI1Nze (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Sep 2021 09:55:34 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:23178 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241073AbhI1Nze (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Sep 2021 09:55:34 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4HJgtW2zprz1DHNh;
        Tue, 28 Sep 2021 21:52:35 +0800 (CST)
Received: from dggpeml500025.china.huawei.com (7.185.36.35) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 28 Sep 2021 21:53:53 +0800
Received: from huawei.com (10.175.124.27) by dggpeml500025.china.huawei.com
 (7.185.36.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 28 Sep
 2021 21:53:52 +0800
From:   Hou Tao <houtao1@huawei.com>
To:     Tejun Heo <tj@kernel.org>, Ian Kent <raven@themaw.net>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        <linux-fsdevel@vger.kernel.org>, <glider@google.com>,
        <houtao1@huawei.com>
Subject: [PATCH] kernfs: also call kernfs_set_rev() for positive dentry
Date:   Tue, 28 Sep 2021 22:07:50 +0800
Message-ID: <20210928140750.1274441-1-houtao1@huawei.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A KMSAN warning is reported by Alexander Potapenko:

BUG: KMSAN: uninit-value in kernfs_dop_revalidate+0x61f/0x840
fs/kernfs/dir.c:1053
 kernfs_dop_revalidate+0x61f/0x840 fs/kernfs/dir.c:1053
 d_revalidate fs/namei.c:854
 lookup_dcache fs/namei.c:1522
 __lookup_hash+0x3a6/0x590 fs/namei.c:1543
 filename_create+0x312/0x7c0 fs/namei.c:3657
 do_mkdirat+0x103/0x930 fs/namei.c:3900
 __do_sys_mkdir fs/namei.c:3931
 __se_sys_mkdir fs/namei.c:3929
 __x64_sys_mkdir+0xda/0x120 fs/namei.c:3929
 do_syscall_x64 arch/x86/entry/common.c:51

It seems a positive dentry in kernfs becomes a negative dentry directly
through d_delete() in vfs_rmdir(). dentry->d_time is uninitialized
when accessing it in kernfs_dop_revalidate(), because it is only
initialized when created as negative dentry in kernfs_iop_lookup().

The problem can be reproduced by the following command:

  cd /sys/fs/cgroup/pids && mkdir hi && stat hi && rmdir hi && stat hi

A simple fixes seems to be initializing d->d_time for positive dentry
in kernfs_iop_lookup() as well. The downside is the negative dentry
will be revalidated again after it becomes negative in d_delete(),
because the revison of its parent must have been increased due to
its removal.

Alternative solution is implement .d_iput for kernfs, and assign d_time
for the newly-generated negative dentry in it. But we may need to
take kernfs_rwsem to protect again the concurrent kernfs_link_sibling()
on the parent directory, it is a little over-killing. Now the simple
fix is chosen.

Link: https://marc.info/?l=linux-fsdevel&m=163249838610499
Fixes: c7e7c04274b1 ("kernfs: use VFS negative dentry caching")
Reported-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 fs/kernfs/dir.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 0c7f1558f489..f7618ba5b3b2 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -1140,8 +1140,13 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
 		if (!inode)
 			inode = ERR_PTR(-ENOMEM);
 	}
-	/* Needed only for negative dentry validation */
-	if (!inode)
+	/*
+	 * Needed for negative dentry validation.
+	 * The negative dentry can be created in kernfs_iop_lookup()
+	 * or transforms from positive dentry in dentry_unlink_inode()
+	 * called from vfs_rmdir().
+	 */
+	if (!IS_ERR(inode))
 		kernfs_set_rev(parent, dentry);
 	up_read(&kernfs_rwsem);
 
-- 
2.29.2

