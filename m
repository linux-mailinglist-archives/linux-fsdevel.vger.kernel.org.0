Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 994572F6A25
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Jan 2021 19:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbhANSzd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Jan 2021 13:55:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728777AbhANSzd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Jan 2021 13:55:33 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFFEBC061757
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Jan 2021 10:54:52 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id p20so5254866qtq.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Jan 2021 10:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=AaPp1q1W8KDgYenpyt0snxhoTAxUV/jsi8fLsxYee9s=;
        b=AbFdoP4sUQzsnEf7uPBF6d1yyv7CEWy2hdehyosQPrfCEnUbp5VpMDvzXTovH7dvnY
         BUW7QoXa1ZS5R2g07mGCaB6/MPPcY3Zp6ngE7iLB9LYftWbbW8T6r5heYE4WGpLub/5E
         119UCT52twmefKyyAjVnpVpDA6PmdAZLdqCzVLm+TNFFfe7inQn5Pd4uaQHnKMJ6Xsf1
         GhgcRoFiyZyyu8mk20KPHxXF4HxfT0gITpKLYk0fzoNw3VjNZ67X06FS5QqPOH0Nyray
         X6Tl7++H0WaeBEzOpYY5T6o3n4t/ATRNnhlglQwgg22wG4cJicV1oEpr8LLpEDGritzO
         tdeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=AaPp1q1W8KDgYenpyt0snxhoTAxUV/jsi8fLsxYee9s=;
        b=C3aNXY+7ZjdJoPJcIBQv1UB0T5DpEVuQiQWe3S7QhkVMKYgSkJDo/yt/oOLdyTydc3
         RyTDWNMV8ZGi903B3YBvYaAGFDJTbg2SXc+m7ZB40PJb0R+fkaq/q+Aknf0tNkl8pS79
         w21Ouk07KzotritmY7ho0rlsDuwUyRIjS9gNHwi2y41yDCtfKmcP+1G8hCGLxq4KkK8C
         5kAZCL2FcosGtKEo3QcCkVnVF3fjaFjUMSqbExpkWLWoLkzCHcdURuorGfuHQX8LgaZ0
         4SGC4RUwfZSExhrt7vatcScEeqotTCJCz4Wr+4dVxxuQCEYruztBGXktnsJL0KrbyCOW
         AxIQ==
X-Gm-Message-State: AOAM530y7kUbI7s1Yc5kmDJ/y5plHsmRKxBmeRK7VZS3TDxIiE2+yA/u
        tv583UbAy9yYMl32g0lHZFbGrN6KRrk=
X-Google-Smtp-Source: ABdhPJyOjW3fImyvzubc9dkkNbV113IJEHcA3Y5QmRLgEwh56M49ioa1URPWggXJt8Ch2ptbRNX+UA4XhJI=
Sender: "figiel via sendgmr" <figiel@odra.waw.corp.google.com>
X-Received: from odra.waw.corp.google.com ([2a00:79e0:2:11:1ea0:b8ff:fe79:fe73])
 (user=figiel job=sendgmr) by 2002:a05:6214:b12:: with SMTP id
 u18mr2482010qvj.21.1610650491811; Thu, 14 Jan 2021 10:54:51 -0800 (PST)
Date:   Thu, 14 Jan 2021 19:54:45 +0100
Message-Id: <20210114185445.996-1-figiel@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v2] fs/proc: Expose RSEQ configuration
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

v2:
 - fixed string formatting for 32-bit architectures

v1:
 - https://lkml.kernel.org/r/20210113174127.2500051-1-figiel@google.com

---
 fs/proc/base.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index b3422cda2a91..7cc36a224b8b 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -662,6 +662,21 @@ static int proc_pid_syscall(struct seq_file *m, struct pid_namespace *ns,
 
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
+	seq_printf(m, "%tx %08x\n", (ptrdiff_t)((uintptr_t)task->rseq),
+		   task->rseq_sig);
+	unlock_trace(task);
+	return 0;
+}
+#endif /* CONFIG_RSEQ */
 #endif /* CONFIG_HAVE_ARCH_TRACEHOOK */
 
 /************************************************************************/
@@ -3182,6 +3197,9 @@ static const struct pid_entry tgid_base_stuff[] = {
 	REG("comm",      S_IRUGO|S_IWUSR, proc_pid_set_comm_operations),
 #ifdef CONFIG_HAVE_ARCH_TRACEHOOK
 	ONE("syscall",    S_IRUSR, proc_pid_syscall),
+#ifdef CONFIG_RSEQ
+	ONE("rseq",       S_IRUSR, proc_pid_rseq),
+#endif
 #endif
 	REG("cmdline",    S_IRUGO, proc_pid_cmdline_ops),
 	ONE("stat",       S_IRUGO, proc_tgid_stat),
@@ -3522,6 +3540,9 @@ static const struct pid_entry tid_base_stuff[] = {
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

