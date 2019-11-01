Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02710EC7B7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2019 18:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729635AbfKARej (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Nov 2019 13:34:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26594 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729615AbfKARej (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Nov 2019 13:34:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572629678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jLpXdslDrrhp+REdHr3l91hluU6shWm/KAlmhAfJqp8=;
        b=J73b8rWV2gk10JFe0x/QyokYOgxlB+NdAiMS3AvE1HRllTJAzUus8tr06vVKRMOY5LXdhQ
        Q/xTt7t4HZksbFnzBjFd4peMExCC69QUP/J0c7pSniPAMHYMRvyS2HfV4pFBDQuUVaPSxo
        ayR1dTmuVJQNznxLIKhAvPt9n2F5ujM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-GwIvBTtLNaqHYo-nxOu7PA-1; Fri, 01 Nov 2019 13:34:34 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 499B6107ACC0;
        Fri,  1 Nov 2019 17:34:32 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-40.rdu2.redhat.com [10.10.121.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 690DB600D1;
        Fri,  1 Nov 2019 17:34:27 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 03/11] Add wake_up_interruptible_sync_poll_locked() [ver
 #3]
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     dhowells@redhat.com, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        nicolas.dichtel@6wind.com, raven@themaw.net,
        Christian Brauner <christian@brauner.io>, dhowells@redhat.com,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 01 Nov 2019 17:34:26 +0000
Message-ID: <157262966653.13142.15080563290216609050.stgit@warthog.procyon.org.uk>
In-Reply-To: <157262963995.13142.5568934007158044624.stgit@warthog.procyon.org.uk>
References: <157262963995.13142.5568934007158044624.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: GwIvBTtLNaqHYo-nxOu7PA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a wakeup call for a case whereby the caller already has the waitqueue
spinlock held.  This can be used by pipes to alter the ring buffer indices
and issue a wakeup under the same spinlock.

Signed-off-by: David Howells <dhowells@redhat.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---

 include/linux/wait.h |    3 +++
 kernel/sched/wait.c  |   23 +++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/linux/wait.h b/include/linux/wait.h
index bb7676d396cd..3283c8d02137 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -202,6 +202,7 @@ void __wake_up_locked_key(struct wait_queue_head *wq_he=
ad, unsigned int mode, vo
 void __wake_up_locked_key_bookmark(struct wait_queue_head *wq_head,
 =09=09unsigned int mode, void *key, wait_queue_entry_t *bookmark);
 void __wake_up_sync_key(struct wait_queue_head *wq_head, unsigned int mode=
, void *key);
+void __wake_up_locked_sync_key(struct wait_queue_head *wq_head, unsigned i=
nt mode, void *key);
 void __wake_up_locked(struct wait_queue_head *wq_head, unsigned int mode, =
int nr);
 void __wake_up_sync(struct wait_queue_head *wq_head, unsigned int mode);
=20
@@ -229,6 +230,8 @@ void __wake_up_sync(struct wait_queue_head *wq_head, un=
signed int mode);
 =09__wake_up(x, TASK_INTERRUPTIBLE, 1, poll_to_key(m))
 #define wake_up_interruptible_sync_poll(x, m)=09=09=09=09=09\
 =09__wake_up_sync_key((x), TASK_INTERRUPTIBLE, poll_to_key(m))
+#define wake_up_interruptible_sync_poll_locked(x, m)=09=09=09=09\
+=09__wake_up_locked_sync_key((x), TASK_INTERRUPTIBLE, poll_to_key(m))
=20
 #define ___wait_cond_timeout(condition)=09=09=09=09=09=09\
 ({=09=09=09=09=09=09=09=09=09=09\
diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
index b4b52361dab7..ba059fbfc53a 100644
--- a/kernel/sched/wait.c
+++ b/kernel/sched/wait.c
@@ -191,6 +191,29 @@ void __wake_up_sync_key(struct wait_queue_head *wq_hea=
d, unsigned int mode,
 }
 EXPORT_SYMBOL_GPL(__wake_up_sync_key);
=20
+/**
+ * __wake_up_locked_sync_key - wake up a thread blocked on a locked waitqu=
eue.
+ * @wq_head: the waitqueue
+ * @mode: which threads
+ * @key: opaque value to be passed to wakeup targets
+ *
+ * The sync wakeup differs in that the waker knows that it will schedule
+ * away soon, so while the target thread will be woken up, it will not
+ * be migrated to another CPU - ie. the two threads are 'synchronized'
+ * with each other. This can prevent needless bouncing between CPUs.
+ *
+ * On UP it can prevent extra preemption.
+ *
+ * If this function wakes up a task, it executes a full memory barrier bef=
ore
+ * accessing the task state.
+ */
+void __wake_up_locked_sync_key(struct wait_queue_head *wq_head,
+=09=09=09       unsigned int mode, void *key)
+{
+        __wake_up_common(wq_head, mode, 1, WF_SYNC, key, NULL);
+}
+EXPORT_SYMBOL_GPL(__wake_up_locked_sync_key);
+
 /*
  * __wake_up_sync - see __wake_up_sync_key()
  */

