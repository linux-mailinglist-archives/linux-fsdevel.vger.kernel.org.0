Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64982480520
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Dec 2021 23:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233846AbhL0WhC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Dec 2021 17:37:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:29572 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233844AbhL0WhB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Dec 2021 17:37:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640644621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k4U1IPyVy0EekGo2lRPabdEHbBtnmJjEveSqzKeRMmQ=;
        b=S6/+UOwMeHYBujb1wLT/28yVt+PrN9kasRYfgGAq/w/FTwZCU9TE476cPNmZPi4Z5Zu5ER
        qf9t22sTc0vdSzu+vLP1CbMz06fJflUcAgjDSclwa4r+78vBloMe1eA7dO9C4iSvpWr4bz
        k8Y7Ll+w3teJYJcLkBf69BYzdxY2234=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-613-HygyfgOWM6-B9MfclocP6w-1; Mon, 27 Dec 2021 17:36:57 -0500
X-MC-Unique: HygyfgOWM6-B9MfclocP6w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8BD4A14756;
        Mon, 27 Dec 2021 22:36:54 +0000 (UTC)
Received: from wcosta.com (ovpn-116-95.gru2.redhat.com [10.97.116.95])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D125F78DD7;
        Mon, 27 Dec 2021 22:36:24 +0000 (UTC)
From:   Wander Lairson Costa <wander@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Laurent Vivier <laurent@vivier.eu>,
        YunQiang Su <ysu@wavecomp.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Helge Deller <deller@gmx.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Rafael Aquini <aquini@redhat.com>,
        Phil Auld <pauld@redhat.com>, Rolf Eike Beer <eb@emlix.com>,
        Muchun Song <songmuchun@bytedance.com>,
        linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and
        infrastructure)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH RFC 2/4] process: add the PF_SUID flag
Date:   Mon, 27 Dec 2021 19:34:33 -0300
Message-Id: <20211227223436.317091-3-wander@redhat.com>
In-Reply-To: <20211227223436.317091-1-wander@redhat.com>
References: <20211227223436.317091-1-wander@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
index 3913b335b95f..b4bd157a5282 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1311,6 +1311,10 @@ int begin_new_exec(struct linux_binprm * bprm)
 
 	me->flags &= ~(PF_RANDOMIZE | PF_FORKNOEXEC | PF_KTHREAD |
 					PF_NOFREEZE | PF_NO_SETAFFINITY);
+
+	if (bprm->suid_bin)
+		me->flags |= PF_SUID;
+
 	flush_thread();
 	me->personality &= ~bprm->per_clear;
 
diff --git a/include/linux/sched.h b/include/linux/sched.h
index e3b328b81ac0..f7811c42b004 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1651,6 +1651,7 @@ extern struct pid *cad_pid;
 #define PF_VCPU			0x00000001	/* I'm a virtual CPU */
 #define PF_IDLE			0x00000002	/* I am an IDLE thread */
 #define PF_EXITING		0x00000004	/* Getting shut down */
+#define PF_SUID			0x00000008	/* The process comes from a suid/sgid binary */
 #define PF_IO_WORKER		0x00000010	/* Task is an IO worker */
 #define PF_WQ_WORKER		0x00000020	/* I'm a workqueue worker */
 #define PF_FORKNOEXEC		0x00000040	/* Forked but didn't exec */
diff --git a/kernel/fork.c b/kernel/fork.c
index 231b1ba3ca9f..1e1ffff70d14 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2080,6 +2080,8 @@ static __latent_entropy struct task_struct *copy_process(
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

