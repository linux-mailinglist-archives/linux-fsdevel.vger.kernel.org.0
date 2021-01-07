Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 536F42ECD06
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Jan 2021 10:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbhAGJmZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Jan 2021 04:42:25 -0500
Received: from mail.windriver.com ([147.11.1.11]:65405 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbhAGJmY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Jan 2021 04:42:24 -0500
X-Greylist: delayed 2348 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Jan 2021 04:42:19 EST
Received: from pek-ygao-d1.windriver.com (pek-ygao-d1.corp.ad.wrs.com [128.224.155.99])
        by mail.windriver.com (8.15.2/8.15.2) with ESMTPS id 1079f0OD012649
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 7 Jan 2021 01:41:01 -0800 (PST)
References: <20201209112100.47653-1-yahu.gao@windriver.com> <20201209112100.47653-2-yahu.gao@windriver.com> <20201209131652.GM3579531@ZenIV.linux.org.uk>
User-agent: mu4e 1.2.0; emacs 26.3
From:   Gao Yahu <yahu.gao@windriver.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Yahu Gao <yahu.gao@windriver.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2] fs/proc: Fix NULL pointer dereference in pid_delete_dentry
In-reply-to: <20201209131652.GM3579531@ZenIV.linux.org.uk>
Date:   Thu, 07 Jan 2021 17:41:00 +0800
Message-ID: <87lfd59j9v.fsf@pek-ygao-d1>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Get the staus of task from the pointer of proc inode directly is not
safe. Make it happen in RCU protection.

Signed-off-by: Yahu Gao <yahu.gao@windriver.com>
---
v2 changes:
  - Use RCU lock to avoid NULL dereference of pid.
---
 fs/proc/base.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index b3422cda2a91..d44b5f2414a6 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1,3 +1,4 @@
+
 // SPDX-License-Identifier: GPL-2.0
 /*
  *  linux/fs/proc/base.c
@@ -1994,7 +1995,16 @@ static int pid_revalidate(struct dentry *dentry, unsigned int flags)
 
 static inline bool proc_inode_is_dead(struct inode *inode)
 {
-	return !proc_pid(inode)->tasks[PIDTYPE_PID].first;
+	struct pid *pid = NULL;
+	struct hlist_node *first = NULL;
+
+	rcu_read_lock();
+	pid = proc_pid(inode);
+	if (likely(pid))
+		first = rcu_dereference_check(hlist_first_rcu(&pid->tasks[PIDTYPE_PID]),
+					      lockdep_tasklist_lock_is_held());
+	rcu_read_unlock();
+	return !first;
 }
 
 int pid_delete_dentry(const struct dentry *dentry)
-- 
2.25.1
