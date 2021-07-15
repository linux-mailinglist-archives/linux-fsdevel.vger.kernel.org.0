Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9FD63C9652
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 05:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233439AbhGODTA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jul 2021 23:19:00 -0400
Received: from foss.arm.com ([217.140.110.172]:45970 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233066AbhGODS7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jul 2021 23:18:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 48A8C11D4;
        Wed, 14 Jul 2021 20:16:07 -0700 (PDT)
Received: from entos-ampere-02.shanghai.arm.com (entos-ampere-02.shanghai.arm.com [10.169.214.103])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EB2143F7D8;
        Wed, 14 Jul 2021 20:16:04 -0700 (PDT)
From:   Jia He <justin.he@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>, nd@arm.com,
        Jia He <justin.he@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC 03/13] fs: Remove the number postfix of '%pD' in format string
Date:   Thu, 15 Jul 2021 11:15:23 +0800
Message-Id: <20210715031533.9553-4-justin.he@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210715031533.9553-1-justin.he@arm.com>
References: <20210715031533.9553-1-justin.he@arm.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

After the behavior of '%pD' is changed to print the full path of file,
the previous number postfix of '%pD' is pointless.

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Jia He <justin.he@arm.com>
---
 fs/exec.c       | 2 +-
 fs/ioctl.c      | 2 +-
 fs/read_write.c | 2 +-
 fs/splice.c     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 38f63451b928..a9f9de7da8ff 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -811,7 +811,7 @@ int setup_arg_pages(struct linux_binprm *bprm,
 	BUG_ON(prev != vma);
 
 	if (unlikely(vm_flags & VM_EXEC)) {
-		pr_warn_once("process '%pD4' started with executable stack\n",
+		pr_warn_once("process '%pD' started with executable stack\n",
 			     bprm->file);
 	}
 
diff --git a/fs/ioctl.c b/fs/ioctl.c
index 1e2204fa9963..80c9d3d00c8f 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -78,7 +78,7 @@ static int ioctl_fibmap(struct file *filp, int __user *p)
 
 	if (block > INT_MAX) {
 		error = -ERANGE;
-		pr_warn_ratelimited("[%s/%d] FS: %s File: %pD4 would truncate fibmap result\n",
+		pr_warn_ratelimited("[%s/%d] FS: %s File: %pD would truncate fibmap result\n",
 				    current->comm, task_pid_nr(current),
 				    sb->s_id, filp);
 	}
diff --git a/fs/read_write.c b/fs/read_write.c
index 9db7adf160d2..3fdb17e4b712 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -422,7 +422,7 @@ static ssize_t new_sync_read(struct file *filp, char __user *buf, size_t len, lo
 static int warn_unsupported(struct file *file, const char *op)
 {
 	pr_warn_ratelimited(
-		"kernel %s not supported for file %pD4 (pid: %d comm: %.20s)\n",
+		"kernel %s not supported for file %pD (pid: %d comm: %.20s)\n",
 		op, file, current->pid, current->comm);
 	return -EINVAL;
 }
diff --git a/fs/splice.c b/fs/splice.c
index 5dbce4dcc1a7..4b0b9029b5ca 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -751,7 +751,7 @@ EXPORT_SYMBOL(generic_splice_sendpage);
 static int warn_unsupported(struct file *file, const char *op)
 {
 	pr_debug_ratelimited(
-		"splice %s not supported for file %pD4 (pid: %d comm: %.20s)\n",
+		"splice %s not supported for file %pD (pid: %d comm: %.20s)\n",
 		op, file, current->pid, current->comm);
 	return -EINVAL;
 }
-- 
2.17.1

