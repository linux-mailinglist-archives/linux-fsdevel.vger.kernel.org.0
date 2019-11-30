Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 438BD10DC10
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Nov 2019 02:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfK3BlR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Nov 2019 20:41:17 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:39660 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727231AbfK3BlR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Nov 2019 20:41:17 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 658C6E2D7CCA17DD39D2;
        Sat, 30 Nov 2019 09:41:15 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Sat, 30 Nov 2019
 09:41:09 +0800
From:   yu kuai <yukuai3@huawei.com>
To:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <viro@zeniv.linux.org.uk>, <rostedt@goodmis.org>,
        <oleg@redhat.com>, <mchehab+samsung@kernel.org>, <corbet@lwn.net>,
        <tytso@mit.edu>, <jmorris@namei.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <yukuai3@huawei.com>, <zhengbin13@huawei.com>,
        <yi.zhang@huawei.com>, <chenxiang66@hisilicon.com>,
        <xiexiuqi@huawei.com>
Subject: [PATCH 3/3] debugfs: fix potential infinite loop in debugfs_remove_recursive
Date:   Sat, 30 Nov 2019 10:02:25 +0800
Message-ID: <20191130020225.20239-4-yukuai3@huawei.com>
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

debugfs_remove_recursive uses list_empty to judge weather a dentry has
any subdentry or not. This can lead to infinite loop when any subdir is
in use.

The problem was discoverd by the following steps in the console.
1. use debugfs_create_dir to create a dir and multiple subdirs(insmod);
2. cd to the subdir with depth not less than 2;
3. call debugfs_remove_recursive(rmmod).

After removing the subdir, the infinite loop is triggered because
debugfs_remove_recursive uses list_empty to judge if the current dir
doesn't have any subdentry. However list_empty can't skip the subdentry
that is not simple_positive(simple_positive() will return false).

Fix the problem by using simple_empty instead of list_empty.

Fixes: 776164c1faac ('debugfs: debugfs_remove_recursive() must not rely
on list_empty(d_subdirs)')
Reported-by: chenxiang66@hisilicon.com

Signed-off-by: yu kuai <yukuai3@huawei.com>
---
 fs/debugfs/inode.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 7b975dbb2bb4..d5ef7a0a4410 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -773,8 +773,11 @@ void debugfs_remove_recursive(struct dentry *dentry)
 		if (!simple_positive(child))
 			continue;
 
-		/* perhaps simple_empty(child) makes more sense */
-		if (!list_empty(&child->d_subdirs)) {
+		/*
+		 * use simple_empty to prevent infinite loop when any
+		 * subdentry of child is in use
+		 */
+		if (!simple_empty(child)) {
 			spin_unlock(&parent->d_lock);
 			inode_unlock(d_inode(parent));
 			parent = child;
-- 
2.17.2

