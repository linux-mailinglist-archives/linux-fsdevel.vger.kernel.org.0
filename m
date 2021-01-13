Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 925CA2F5147
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jan 2021 18:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbhAMRmw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jan 2021 12:42:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727962AbhAMRmw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jan 2021 12:42:52 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CECC061575
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Jan 2021 09:42:11 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id h1so2057744qvr.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Jan 2021 09:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=HzF3MXTeCTbRlxf3/1M1iugn5XEMK7QFQKjoigiYDkw=;
        b=vOf1EwIqh/xzs3yDIbdGzIP9xv58y63igsPzrCIYRFDU5u1DbrYovhxLFnx/lx3rsi
         8dEfz3ptVFQZO7IxTOvw7tXFTHNm0k16Nsiy+QpnbDi4m8M3arl4UmMoGqWWqV1/hwMd
         lVgc5YdCdmwCASAPCeqGyqOOVpurRNnfQZN8FU14pNj5xVkCcNinQJkz6zNalyDQeh8j
         XLL8T9R8CxL1ZDQTSQfw4oW9z9ZYWKLfafANE1046olShYDsppf5ZQExmHLxhIHnidAy
         cZQqtDuvl2AUVKe+5gtZGSK2G82Ma9yREVLVPNGN48nuU2bFltI/gjaf4eU3dhIoNOIY
         EqjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=HzF3MXTeCTbRlxf3/1M1iugn5XEMK7QFQKjoigiYDkw=;
        b=mi1Pd8PFRL1IvGmX789UTt3bMBZdaFDhxatW+8Dbr/Elw/+C8kKIAHfyOWbRpeHLB7
         iOMhaOXKc6+icm7/cUd1x99FcxukNijCmUgf7wl6RSR7CC5lPgHCFsee2oD8XA/S8/P1
         y1E+Mgm5JLTeW48p5pxxSyoGIPPjS4GL+zCHR24j1HlkZGm72IwYF/bKVgoH4smaAEYW
         ThE8v/4yGviIqft+vVmVfhsYlai95jqO7496dg1j3AfYaMnIniaDQcLKOBFYvNrcwJr8
         FoiZeP6bod18Qf4wZ+Ow5T/f7ZBWA+e3dmNBEt9R5/D0ysNqZjPnhA+/sjkmDjWuVYrn
         VQ3w==
X-Gm-Message-State: AOAM533hlRkewfezBrM5HbQ/9K26ntNvnH/rMI78APnk1jVB7iauW0jw
        Jalyn2KSXATCbi61fl1xqY4v+3bnpj4=
X-Google-Smtp-Source: ABdhPJzju57ZTb0aPBWIY91s0bPW4mHdG7ZlTu77EVKBJtuUg523fV38D6+xcSZwxfb/9AaMWh+yBMM91ok=
Sender: "figiel via sendgmr" <figiel@odra.waw.corp.google.com>
X-Received: from odra.waw.corp.google.com ([2a00:79e0:2:11:1ea0:b8ff:fe79:fe73])
 (user=figiel job=sendgmr) by 2002:a0c:b59a:: with SMTP id g26mr3204411qve.26.1610559731077;
 Wed, 13 Jan 2021 09:42:11 -0800 (PST)
Date:   Wed, 13 Jan 2021 18:41:27 +0100
Message-Id: <20210113174127.2500051-1-figiel@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH] fs/proc: Expose RSEQ configuration
From:   Piotr Figiel <figiel@google.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Michel Lespinasse <walken@google.com>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Andrei Vagin <avagin@gmail.com>, mathieu.desnoyers@efficios.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        posk@google.com, kyurtsever@google.com, ckennelly@google.com,
        pjt@google.com, Piotr Figiel <figiel@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For userspace checkpoint and restore (C/R) some way of getting process
state containing RSEQ configuration is needed.

There are two ways this information is going to be used:
 - to re-enable RSEQ for threads which had it enabled before C/R
 - to detect if a thread was in a critical section during C/R

Since C/R preserves TLS memory and addresses RSEQ ABI will be restored
using the address registered before C/R.

Detection whether the thread is in a critical section during C/R is
needed to enforce behavior of RSEQ abort during C/R. Attaching with
ptrace() before registers are dumped itself doesn't cause RSEQ abort.
Restoring the instruction pointer within the critical section is
problematic because rseq_cs may get cleared before the control is
passed to the migrated application code leading to RSEQ invariants not
being preserved.

Signed-off-by: Piotr Figiel <figiel@google.com>
---
 fs/proc/base.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index b3422cda2a91..3d4712ac4370 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -662,6 +662,20 @@ static int proc_pid_syscall(struct seq_file *m, struct pid_namespace *ns,
 
 	return 0;
 }
+
+#ifdef CONFIG_RSEQ
+static int proc_pid_rseq(struct seq_file *m, struct pid_namespace *ns,
+				struct pid *pid, struct task_struct *task)
+{
+	int res = lock_trace(task);
+
+	if (res)
+		return res;
+	seq_printf(m, "0x%llx 0x%x\n", (uint64_t)task->rseq, task->rseq_sig);
+	unlock_trace(task);
+	return 0;
+}
+#endif /* CONFIG_RSEQ */
 #endif /* CONFIG_HAVE_ARCH_TRACEHOOK */
 
 /************************************************************************/
@@ -3182,6 +3196,9 @@ static const struct pid_entry tgid_base_stuff[] = {
 	REG("comm",      S_IRUGO|S_IWUSR, proc_pid_set_comm_operations),
 #ifdef CONFIG_HAVE_ARCH_TRACEHOOK
 	ONE("syscall",    S_IRUSR, proc_pid_syscall),
+#ifdef CONFIG_RSEQ
+	ONE("rseq",       S_IRUSR, proc_pid_rseq),
+#endif
 #endif
 	REG("cmdline",    S_IRUGO, proc_pid_cmdline_ops),
 	ONE("stat",       S_IRUGO, proc_tgid_stat),
@@ -3522,6 +3539,9 @@ static const struct pid_entry tid_base_stuff[] = {
 			 &proc_pid_set_comm_operations, {}),
 #ifdef CONFIG_HAVE_ARCH_TRACEHOOK
 	ONE("syscall",   S_IRUSR, proc_pid_syscall),
+#ifdef CONFIG_RSEQ
+	ONE("rseq",      S_IRUSR, proc_pid_rseq),
+#endif
 #endif
 	REG("cmdline",   S_IRUGO, proc_pid_cmdline_ops),
 	ONE("stat",      S_IRUGO, proc_tid_stat),
-- 
2.30.0.284.gd98b1dd5eaa7-goog

