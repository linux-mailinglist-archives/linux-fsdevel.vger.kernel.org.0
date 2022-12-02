Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0869C640BEF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Dec 2022 18:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234089AbiLBRSb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Dec 2022 12:18:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234214AbiLBRSM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Dec 2022 12:18:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4F9E51FD
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Dec 2022 09:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670001382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E+1/kxt1BcrGWlRNRbifBPUUK2viMqVoDBsQbTYSfG4=;
        b=huYppDrAY2Nnrl2dZ9Ljh9XmQclpez7XkNcvIuX0z4vxeEcAf62AiuV17WCKj58JiRsByy
        kx4GRs75S7AosG9kiX0n77z9uVtYL0TlAljFGLgYiPtBtYDCMI2LVq+K5uVvKF/X8P7d6e
        IFgA80Cb5F+j2+icie4eBk5T/tUDqqU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-210-p9TcCX5SMzOk8TRsi3DIrA-1; Fri, 02 Dec 2022 12:16:19 -0500
X-MC-Unique: p9TcCX5SMzOk8TRsi3DIrA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9DCE23C0F7F6;
        Fri,  2 Dec 2022 17:16:15 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.8.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5B0DD40C947B;
        Fri,  2 Dec 2022 17:16:15 +0000 (UTC)
From:   Brian Foster <bfoster@redhat.com>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ikent@redhat.com, onestero@redhat.com, willy@infradead.org,
        ebiederm@redhat.com
Subject: [PATCH v3 2/5] pid: split cyclic id allocation cursor from idr
Date:   Fri,  2 Dec 2022 12:16:17 -0500
Message-Id: <20221202171620.509140-3-bfoster@redhat.com>
In-Reply-To: <20221202171620.509140-1-bfoster@redhat.com>
References: <20221202171620.509140-1-bfoster@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As a next step in separating pid allocation from the idr, split off
the cyclic pid allocation cursor from the idr. Lift the cursor value
into the struct pid_namespace. Note that this involves temporarily
open-coding the cursor increment on allocation, but this is cleaned
up in the subsequent patch.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Brian Foster <bfoster@redhat.com>
---
 arch/powerpc/platforms/cell/spufs/sched.c | 2 +-
 fs/proc/loadavg.c                         | 2 +-
 include/linux/pid_namespace.h             | 1 +
 kernel/pid.c                              | 6 ++++--
 kernel/pid_namespace.c                    | 4 ++--
 5 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/sched.c b/arch/powerpc/platforms/cell/spufs/sched.c
index 99bd027a7f7c..a2ed928d7658 100644
--- a/arch/powerpc/platforms/cell/spufs/sched.c
+++ b/arch/powerpc/platforms/cell/spufs/sched.c
@@ -1072,7 +1072,7 @@ static int show_spu_loadavg(struct seq_file *s, void *private)
 		LOAD_INT(c), LOAD_FRAC(c),
 		count_active_contexts(),
 		atomic_read(&nr_spu_contexts),
-		idr_get_cursor(&task_active_pid_ns(current)->idr) - 1);
+		READ_ONCE(task_active_pid_ns(current)->pid_next) - 1);
 	return 0;
 }
 #endif
diff --git a/fs/proc/loadavg.c b/fs/proc/loadavg.c
index 817981e57223..2740b31b6461 100644
--- a/fs/proc/loadavg.c
+++ b/fs/proc/loadavg.c
@@ -22,7 +22,7 @@ static int loadavg_proc_show(struct seq_file *m, void *v)
 		LOAD_INT(avnrun[1]), LOAD_FRAC(avnrun[1]),
 		LOAD_INT(avnrun[2]), LOAD_FRAC(avnrun[2]),
 		nr_running(), nr_threads,
-		idr_get_cursor(&task_active_pid_ns(current)->idr) - 1);
+		READ_ONCE(task_active_pid_ns(current)->pid_next) - 1);
 	return 0;
 }
 
diff --git a/include/linux/pid_namespace.h b/include/linux/pid_namespace.h
index 07481bb87d4e..82c72482019d 100644
--- a/include/linux/pid_namespace.h
+++ b/include/linux/pid_namespace.h
@@ -18,6 +18,7 @@ struct fs_pin;
 
 struct pid_namespace {
 	struct idr idr;
+	unsigned int pid_next;
 	struct rcu_head rcu;
 	unsigned int pid_allocated;
 	struct task_struct *child_reaper;
diff --git a/kernel/pid.c b/kernel/pid.c
index 3622f8b13143..2e2d33273c8e 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -75,6 +75,7 @@ int pid_max_max = PID_MAX_LIMIT;
 struct pid_namespace init_pid_ns = {
 	.ns.count = REFCOUNT_INIT(2),
 	.idr = IDR_INIT(init_pid_ns.idr),
+	.pid_next = 0,
 	.pid_allocated = PIDNS_ADDING,
 	.level = 0,
 	.child_reaper = &init_task,
@@ -208,7 +209,7 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
 			 * init really needs pid 1, but after reaching the
 			 * maximum wrap back to RESERVED_PIDS
 			 */
-			if (idr_get_cursor(&tmp->idr) > RESERVED_PIDS)
+			if (tmp->pid_next > RESERVED_PIDS)
 				pid_min = RESERVED_PIDS;
 
 			/*
@@ -217,6 +218,7 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
 			 */
 			nr = idr_alloc_cyclic(&tmp->idr, NULL, pid_min,
 					      pid_max, GFP_ATOMIC);
+			tmp->pid_next = nr + 1;
 		}
 		xa_unlock_irq(&tmp->idr.idr_rt);
 		idr_preload_end();
@@ -278,7 +280,7 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
 
 		/* On failure to allocate the first pid, reset the state */
 		if (tmp == ns && tmp->pid_allocated == PIDNS_ADDING)
-			idr_set_cursor(&ns->idr, 0);
+			ns->pid_next = 0;
 
 		idr_remove(&tmp->idr, upid->nr);
 		xa_unlock_irq(&tmp->idr.idr_rt);
diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index f4f8cb0435b4..a53d20c5c85e 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -272,12 +272,12 @@ static int pid_ns_ctl_handler(struct ctl_table *table, int write,
 	 * it should synchronize its usage with external means.
 	 */
 
-	next = idr_get_cursor(&pid_ns->idr) - 1;
+	next = READ_ONCE(pid_ns->pid_next) - 1;
 
 	tmp.data = &next;
 	ret = proc_dointvec_minmax(&tmp, write, buffer, lenp, ppos);
 	if (!ret && write)
-		idr_set_cursor(&pid_ns->idr, next + 1);
+		WRITE_ONCE(pid_ns->pid_next, next + 1);
 
 	return ret;
 }
-- 
2.37.3

