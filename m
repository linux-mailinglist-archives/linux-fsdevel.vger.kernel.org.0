Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD92C1FF568
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jun 2020 16:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731278AbgFROq6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jun 2020 10:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730924AbgFROq5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jun 2020 10:46:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0086C0613ED;
        Thu, 18 Jun 2020 07:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=T94kCvjMg3POOYY9QZ5B+bKnsinmf9rCUNlS0Naq4B0=; b=sZIUAkI2NjZ+MMiCdvtfYxmhhZ
        QSfUBaQNaFTFjYXrnoa0k4CfMSMBYgWQJcIeJT2KPiGTzastkugYaRi0P2OkdM+B9tZ1giWQFDEAu
        2xX9amWSGWOU8oF7zGU04ktP0FLYqU657CZfucoyNEhEny+VDLOxDC0qMFWvalfdkhsvTTYC8QmgH
        WrqZ4LAO5GNL64WUFddp82LA21mBJE9Kg0c2s2xM1T+A7AOKiD/B+MZISNiupYctsyLexsbpGTaYl
        RPdqczujbtE412KJXCBAeVRyHRT5BW4lEA9qrdRJUA3JtyyPAKSfu0XHEGWFrcTiq+7RnTdV7r0ks
        TF1gnuUg==;
Received: from 195-192-102-148.dyn.cablelink.at ([195.192.102.148] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jlvoX-0006W3-Dz; Thu, 18 Jun 2020 14:46:50 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>, Brian Gerst <brgerst@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] kernel: add a kernel_wait helper
Date:   Thu, 18 Jun 2020 16:46:27 +0200
Message-Id: <20200618144627.114057-7-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200618144627.114057-1-hch@lst.de>
References: <20200618144627.114057-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a helper that waits for a pid and stores the status in the passed
in kernel pointer.  Use it to fix the usage of kernel_wait4 in
call_usermodehelper_exec_sync that only happens to work due to the
implicit set_fs(KERNEL_DS) for kernel threads.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/sched/task.h |  1 +
 kernel/exit.c              | 16 ++++++++++++++++
 kernel/umh.c               | 29 ++++-------------------------
 3 files changed, 21 insertions(+), 25 deletions(-)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 38359071236ad7..a80007df396e95 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -102,6 +102,7 @@ struct task_struct *fork_idle(int);
 struct mm_struct *copy_init_mm(void);
 extern pid_t kernel_thread(int (*fn)(void *), void *arg, unsigned long flags);
 extern long kernel_wait4(pid_t, int __user *, int, struct rusage *);
+int kernel_wait(pid_t pid, int *stat);
 
 extern void free_task(struct task_struct *tsk);
 
diff --git a/kernel/exit.c b/kernel/exit.c
index 727150f2810338..fd598846df0b17 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -1626,6 +1626,22 @@ long kernel_wait4(pid_t upid, int __user *stat_addr, int options,
 	return ret;
 }
 
+int kernel_wait(pid_t pid, int *stat)
+{
+	struct wait_opts wo = {
+		.wo_type	= PIDTYPE_PID,
+		.wo_pid		= find_get_pid(pid),
+		.wo_flags	= WEXITED,
+	};
+	int ret;
+
+	ret = do_wait(&wo);
+	if (ret > 0 && wo.wo_stat)
+		*stat = wo.wo_stat;
+	put_pid(wo.wo_pid);
+	return ret;
+}
+
 SYSCALL_DEFINE4(wait4, pid_t, upid, int __user *, stat_addr,
 		int, options, struct rusage __user *, ru)
 {
diff --git a/kernel/umh.c b/kernel/umh.c
index 1284823dbad338..6fd948e478bec4 100644
--- a/kernel/umh.c
+++ b/kernel/umh.c
@@ -126,37 +126,16 @@ static void call_usermodehelper_exec_sync(struct subprocess_info *sub_info)
 {
 	pid_t pid;
 
-	/* If SIGCLD is ignored kernel_wait4 won't populate the status. */
+	/* If SIGCLD is ignored do_wait won't populate the status. */
 	kernel_sigaction(SIGCHLD, SIG_DFL);
 	pid = kernel_thread(call_usermodehelper_exec_async, sub_info, SIGCHLD);
-	if (pid < 0) {
+	if (pid < 0)
 		sub_info->retval = pid;
-	} else {
-		int ret = -ECHILD;
-		/*
-		 * Normally it is bogus to call wait4() from in-kernel because
-		 * wait4() wants to write the exit code to a userspace address.
-		 * But call_usermodehelper_exec_sync() always runs as kernel
-		 * thread (workqueue) and put_user() to a kernel address works
-		 * OK for kernel threads, due to their having an mm_segment_t
-		 * which spans the entire address space.
-		 *
-		 * Thus the __user pointer cast is valid here.
-		 */
-		kernel_wait4(pid, (int __user *)&ret, 0, NULL);
-
-		/*
-		 * If ret is 0, either call_usermodehelper_exec_async failed and
-		 * the real error code is already in sub_info->retval or
-		 * sub_info->retval is 0 anyway, so don't mess with it then.
-		 */
-		if (ret)
-			sub_info->retval = ret;
-	}
+	else
+		kernel_wait(pid, &sub_info->retval);
 
 	/* Restore default kernel sig handler */
 	kernel_sigaction(SIGCHLD, SIG_IGN);
-
 	umh_complete(sub_info);
 }
 
-- 
2.26.2

