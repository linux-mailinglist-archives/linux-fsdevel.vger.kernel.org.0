Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2632C75C1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Nov 2020 23:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387895AbgK1VtN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 Nov 2020 16:49:13 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:40180 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733149AbgK1R7z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 Nov 2020 12:59:55 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=wenyang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UGoMy0t_1606586341;
Received: from localhost(mailfrom:wenyang@linux.alibaba.com fp:SMTPD_---0UGoMy0t_1606586341)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 29 Nov 2020 01:59:12 +0800
From:   Wen Yang <wenyang@linux.alibaba.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>,
        Christian Brauner <christian@brauner.io>, ebiederm@xmission.com
Cc:     Wen Yang <wenyang@linux.alibaba.com>,
        Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] proc: add locking checks in proc_inode_is_dead
Date:   Sun, 29 Nov 2020 01:58:50 +0800
Message-Id: <20201128175850.19484-1-wenyang@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The proc_inode_is_dead function might race with __unhash_process.
This will result in a whole bunch of stale proc entries being cached.
To prevent that, add the required locking.

Signed-off-by: Wen Yang <wenyang@linux.alibaba.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Christian Brauner <christian@brauner.io>
Cc: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
---
 fs/proc/base.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 1bc9bcd..59720bc 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1994,7 +1994,13 @@ static int pid_revalidate(struct dentry *dentry, unsigned int flags)
 
 static inline bool proc_inode_is_dead(struct inode *inode)
 {
-	return !proc_pid(inode)->tasks[PIDTYPE_PID].first;
+	bool has_task;
+
+	read_lock(&tasklist_lock);
+	has_task = pid_has_task(proc_pid(inode), PIDTYPE_PID);
+	read_unlock(&tasklist_lock);
+
+	return !has_task;
 }
 
 int pid_delete_dentry(const struct dentry *dentry)
-- 
1.8.3.1

