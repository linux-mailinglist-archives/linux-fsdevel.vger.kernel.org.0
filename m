Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E75C10DC0D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Nov 2019 02:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbfK3BlS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Nov 2019 20:41:18 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:39606 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727227AbfK3BlR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Nov 2019 20:41:17 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5E6CC6908ADF057AE9F2;
        Sat, 30 Nov 2019 09:41:15 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Sat, 30 Nov 2019
 09:41:08 +0800
From:   yu kuai <yukuai3@huawei.com>
To:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <viro@zeniv.linux.org.uk>, <rostedt@goodmis.org>,
        <oleg@redhat.com>, <mchehab+samsung@kernel.org>, <corbet@lwn.net>,
        <tytso@mit.edu>, <jmorris@namei.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <yukuai3@huawei.com>, <zhengbin13@huawei.com>,
        <yi.zhang@huawei.com>, <chenxiang66@hisilicon.com>,
        <xiexiuqi@huawei.com>
Subject: [PATCH 2/3] fs/libfs.c: use 'spin_lock_nested' when taking 'd_lock' for dentry in simple_empty
Date:   Sat, 30 Nov 2019 10:02:24 +0800
Message-ID: <20191130020225.20239-3-yukuai3@huawei.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20191130020225.20239-1-yukuai3@huawei.com>
References: <20191130020225.20239-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

simple_emtpty currently use 'spin_lock_nested' for 'child' to avoid
confusion for lockdep. However, it's not used for 'dentry'.

In that case, there will be a problem if the caller called 'simple_empty'
with a parent's 'd_lock' held:

spin_lock(&dentry->d_parent->d_lock)
    call simple_empty(dentry)
        spin_lock(&dentry->d_lock) --> lockdep will report this
            spin_lock_nested(child->d_lock, spin_lock_nested)
            spin_unlock(child_lock)
        spin_unlock($dentry->d_lock)
    return from simple_empty
spin_unlock(&dentry->d_patrent->d_lock)

So, use 'DENTRY_D_LOCK_NESTED' for 'dentry' and 'DENTRY_D_LOCK_NESTED_TWICE'
for child.

Signed-off-by: yu kuai <yukuai3@huawei.com>
---
 fs/libfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index 1463b038ffc4..54a37444f7f9 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -336,9 +336,9 @@ int simple_empty(struct dentry *dentry)
 	struct dentry *child;
 	int ret = 0;
 
-	spin_lock(&dentry->d_lock);
+	spin_lock_nested(&dentry->d_lock, DENTRY_D_LOCK_NESTED);
 	list_for_each_entry(child, &dentry->d_subdirs, d_child) {
-		spin_lock_nested(&child->d_lock, DENTRY_D_LOCK_NESTED);
+		spin_lock_nested(&child->d_lock, DENTRY_D_LOCK_NESTED_TWICE);
 		if (simple_positive(child)) {
 			spin_unlock(&child->d_lock);
 			goto out;
-- 
2.17.2

