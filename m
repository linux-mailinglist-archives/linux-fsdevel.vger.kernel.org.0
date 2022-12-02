Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78111640BE2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Dec 2022 18:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233959AbiLBRRK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Dec 2022 12:17:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233643AbiLBRRJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Dec 2022 12:17:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5FC8D96B6
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Dec 2022 09:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670001379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fMasqR+dnAYUNzNvfPkl6FDxt06ngAqgCShDgQ/MNk4=;
        b=diZcmYWfPd1FSDiC+SfCPEg7hkRKIUrQVJiOQyL6d99RgjFPeoFFqNje+Q/xtiwllT8DyW
        0K1RPTEqDj8xSA3HyZ/e1WdFu0p4uDykXn6MHqM1ctXOCpYGKXUl5yj/PIeOgB7Jbsg9Uv
        YGD5727YqE26ZMVP6c3WqYAizVZiKm0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-558-rkrXDgJWMlaM3o3biIrs3g-1; Fri, 02 Dec 2022 12:16:15 -0500
X-MC-Unique: rkrXDgJWMlaM3o3biIrs3g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4BAD1882823;
        Fri,  2 Dec 2022 17:16:15 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.8.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0990E40C94AA;
        Fri,  2 Dec 2022 17:16:15 +0000 (UTC)
From:   Brian Foster <bfoster@redhat.com>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ikent@redhat.com, onestero@redhat.com, willy@infradead.org,
        ebiederm@redhat.com
Subject: [PATCH v3 1/5] pid: replace pidmap_lock with xarray lock
Date:   Fri,  2 Dec 2022 12:16:16 -0500
Message-Id: <20221202171620.509140-2-bfoster@redhat.com>
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

As a first step to changing the struct pid tracking code from the
idr over to the xarray, replace the custom pidmap_lock spinlock with
the internal lock associated with the underlying xarray. This is
effectively equivalent to using idr_lock() and friends, but since
the goal is to disentangle from the idr, move directly to the
underlying xarray api.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Brian Foster <bfoster@redhat.com>
---
 kernel/pid.c | 79 ++++++++++++++++++++++++++--------------------------
 1 file changed, 40 insertions(+), 39 deletions(-)

diff --git a/kernel/pid.c b/kernel/pid.c
index 3fbc5e46b721..3622f8b13143 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -86,22 +86,6 @@ struct pid_namespace init_pid_ns = {
 };
 EXPORT_SYMBOL_GPL(init_pid_ns);
 
-/*
- * Note: disable interrupts while the pidmap_lock is held as an
- * interrupt might come in and do read_lock(&tasklist_lock).
- *
- * If we don't disable interrupts there is a nasty deadlock between
- * detach_pid()->free_pid() and another cpu that does
- * spin_lock(&pidmap_lock) followed by an interrupt routine that does
- * read_lock(&tasklist_lock);
- *
- * After we clean up the tasklist_lock and know there are no
- * irq handlers that take it we can leave the interrupts enabled.
- * For now it is easier to be safe than to prove it can't happen.
- */
-
-static  __cacheline_aligned_in_smp DEFINE_SPINLOCK(pidmap_lock);
-
 void put_pid(struct pid *pid)
 {
 	struct pid_namespace *ns;
@@ -129,10 +113,11 @@ void free_pid(struct pid *pid)
 	int i;
 	unsigned long flags;
 
-	spin_lock_irqsave(&pidmap_lock, flags);
 	for (i = 0; i <= pid->level; i++) {
 		struct upid *upid = pid->numbers + i;
 		struct pid_namespace *ns = upid->ns;
+
+		xa_lock_irqsave(&ns->idr.idr_rt, flags);
 		switch (--ns->pid_allocated) {
 		case 2:
 		case 1:
@@ -150,8 +135,8 @@ void free_pid(struct pid *pid)
 		}
 
 		idr_remove(&ns->idr, upid->nr);
+		xa_unlock_irqrestore(&ns->idr.idr_rt, flags);
 	}
-	spin_unlock_irqrestore(&pidmap_lock, flags);
 
 	call_rcu(&pid->rcu, delayed_put_pid);
 }
@@ -206,7 +191,7 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
 		}
 
 		idr_preload(GFP_KERNEL);
-		spin_lock_irq(&pidmap_lock);
+		xa_lock_irq(&tmp->idr.idr_rt);
 
 		if (tid) {
 			nr = idr_alloc(&tmp->idr, NULL, tid,
@@ -233,7 +218,7 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
 			nr = idr_alloc_cyclic(&tmp->idr, NULL, pid_min,
 					      pid_max, GFP_ATOMIC);
 		}
-		spin_unlock_irq(&pidmap_lock);
+		xa_unlock_irq(&tmp->idr.idr_rt);
 		idr_preload_end();
 
 		if (nr < 0) {
@@ -266,34 +251,38 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
 	INIT_HLIST_HEAD(&pid->inodes);
 
 	upid = pid->numbers + ns->level;
-	spin_lock_irq(&pidmap_lock);
-	if (!(ns->pid_allocated & PIDNS_ADDING))
-		goto out_unlock;
 	for ( ; upid >= pid->numbers; --upid) {
+		tmp = upid->ns;
+
+		xa_lock_irq(&tmp->idr.idr_rt);
+		if (tmp == ns && !(tmp->pid_allocated & PIDNS_ADDING)) {
+			xa_unlock_irq(&tmp->idr.idr_rt);
+			put_pid_ns(ns);
+			goto out_free;
+		}
+
 		/* Make the PID visible to find_pid_ns. */
-		idr_replace(&upid->ns->idr, pid, upid->nr);
-		upid->ns->pid_allocated++;
+		idr_replace(&tmp->idr, pid, upid->nr);
+		tmp->pid_allocated++;
+		xa_unlock_irq(&tmp->idr.idr_rt);
 	}
-	spin_unlock_irq(&pidmap_lock);
 
 	return pid;
 
-out_unlock:
-	spin_unlock_irq(&pidmap_lock);
-	put_pid_ns(ns);
-
 out_free:
-	spin_lock_irq(&pidmap_lock);
 	while (++i <= ns->level) {
 		upid = pid->numbers + i;
-		idr_remove(&upid->ns->idr, upid->nr);
-	}
+		tmp = upid->ns;
 
-	/* On failure to allocate the first pid, reset the state */
-	if (ns->pid_allocated == PIDNS_ADDING)
-		idr_set_cursor(&ns->idr, 0);
+		xa_lock_irq(&tmp->idr.idr_rt);
 
-	spin_unlock_irq(&pidmap_lock);
+		/* On failure to allocate the first pid, reset the state */
+		if (tmp == ns && tmp->pid_allocated == PIDNS_ADDING)
+			idr_set_cursor(&ns->idr, 0);
+
+		idr_remove(&tmp->idr, upid->nr);
+		xa_unlock_irq(&tmp->idr.idr_rt);
+	}
 
 	kmem_cache_free(ns->pid_cachep, pid);
 	return ERR_PTR(retval);
@@ -301,9 +290,9 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
 
 void disable_pid_allocation(struct pid_namespace *ns)
 {
-	spin_lock_irq(&pidmap_lock);
+	xa_lock_irq(&ns->idr.idr_rt);
 	ns->pid_allocated &= ~PIDNS_ADDING;
-	spin_unlock_irq(&pidmap_lock);
+	xa_unlock_irq(&ns->idr.idr_rt);
 }
 
 struct pid *find_pid_ns(int nr, struct pid_namespace *ns)
@@ -647,6 +636,18 @@ SYSCALL_DEFINE2(pidfd_open, pid_t, pid, unsigned int, flags)
 	return fd;
 }
 
+/*
+ * Note: disable interrupts while the xarray lock is held as an interrupt might
+ * come in and do read_lock(&tasklist_lock).
+ *
+ * If we don't disable interrupts there is a nasty deadlock between
+ * detach_pid()->free_pid() and another cpu that does xa_lock() followed by an
+ * interrupt routine that does read_lock(&tasklist_lock);
+ *
+ * After we clean up the tasklist_lock and know there are no irq handlers that
+ * take it we can leave the interrupts enabled.  For now it is easier to be safe
+ * than to prove it can't happen.
+ */
 void __init pid_idr_init(void)
 {
 	/* Verify no one has done anything silly: */
-- 
2.37.3

