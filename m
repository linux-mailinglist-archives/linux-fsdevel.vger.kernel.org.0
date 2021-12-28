Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCDCA480BE4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Dec 2021 18:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236666AbhL1RLd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Dec 2021 12:11:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25343 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235980AbhL1RLd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Dec 2021 12:11:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640711492;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vnD9Ir6KafT49PHRnvs+2GzEgf09b29JgFdqlfV/kA0=;
        b=bSekmq1YJz6OYYkFduD8MiH4tQkC0tf7JX+Y+Y0xLffrTUtdboC5LVYsU78suUzOfKMqH5
        FPzYMV6dOUF+CkHrEtbM3vqPsvlKXobiOR1X9OV14PpofmgaNHXYfBldkq/9Coh5G3wG+i
        8KuUo/kyFGBpgMCgwmvRpK0tIoBgC1o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-16-ADxrujMmN8aDPXfYUMbGzw-1; Tue, 28 Dec 2021 12:11:29 -0500
X-MC-Unique: ADxrujMmN8aDPXfYUMbGzw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 293F8102C8D6;
        Tue, 28 Dec 2021 17:11:27 +0000 (UTC)
Received: from wcosta.com (ovpn-116-95.gru2.redhat.com [10.97.116.95])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EC18F77440;
        Tue, 28 Dec 2021 17:10:48 +0000 (UTC)
From:   Wander Lairson Costa <wander@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Laurent Vivier <laurent@vivier.eu>,
        YunQiang Su <ysu@wavecomp.com>, Helge Deller <deller@gmx.de>,
        Wander Lairson Costa <wander@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexey Gladkov <legion@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Rolf Eike Beer <eb@emlix.com>,
        linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and
        infrastructure)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH RFC v2 2/4] process: add the PF_SUID flag
Date:   Tue, 28 Dec 2021 14:09:06 -0300
Message-Id: <20211228170910.623156-3-wander@redhat.com>
In-Reply-To: <20211228170910.623156-1-wander@redhat.com>
References: <20211228170910.623156-1-wander@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If the binary file in an execve system call is a suid executable, we add
the PF_SUID flag to the process and all its future new children and
threads.

In a later commit, we will use this information to determine if it is
safe to core dump such a process.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 fs/exec.c             | 4 ++++
 include/linux/sched.h | 1 +
 kernel/fork.c         | 2 ++
 3 files changed, 7 insertions(+)

diff --git a/fs/exec.c b/fs/exec.c
index ec07b36fdbb4..81d6ab9a4f64 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1309,6 +1309,10 @@ int begin_new_exec(struct linux_binprm * bprm)
 
 	me->flags &= ~(PF_RANDOMIZE | PF_FORKNOEXEC | PF_KTHREAD |
 					PF_NOFREEZE | PF_NO_SETAFFINITY);
+
+	if (bprm->suid_bin)
+		me->flags |= PF_SUID;
+
 	flush_thread();
 	me->personality &= ~bprm->per_clear;
 
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 78c351e35fec..8ec2f907fb89 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1683,6 +1683,7 @@ extern struct pid *cad_pid;
 #define PF_KTHREAD		0x00200000	/* I am a kernel thread */
 #define PF_RANDOMIZE		0x00400000	/* Randomize virtual address space */
 #define PF_SWAPWRITE		0x00800000	/* Allowed to write to swap */
+#define PF_SUID			0x01000000	/* The process comes from a suid/sgid binary */
 #define PF_NO_SETAFFINITY	0x04000000	/* Userland is not allowed to meddle with cpus_mask */
 #define PF_MCE_EARLY		0x08000000      /* Early kill for mce process policy */
 #define PF_MEMALLOC_PIN		0x10000000	/* Allocation context constrained to zones which allow long term pinning. */
diff --git a/kernel/fork.c b/kernel/fork.c
index 3244cc56b697..f0375d102b57 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2076,6 +2076,8 @@ static __latent_entropy struct task_struct *copy_process(
 	delayacct_tsk_init(p);	/* Must remain after dup_task_struct() */
 	p->flags &= ~(PF_SUPERPRIV | PF_WQ_WORKER | PF_IDLE | PF_NO_SETAFFINITY);
 	p->flags |= PF_FORKNOEXEC;
+	if (current->flags & PF_SUID)
+		p->flags |= PF_SUID;
 	INIT_LIST_HEAD(&p->children);
 	INIT_LIST_HEAD(&p->sibling);
 	rcu_copy_process(p);
-- 
2.27.0

