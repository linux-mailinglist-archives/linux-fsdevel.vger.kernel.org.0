Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7ECD93C6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2019 16:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394026AbfJPO0a convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Oct 2019 10:26:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40738 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387995AbfJPO0a (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Oct 2019 10:26:30 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 830493086E27;
        Wed, 16 Oct 2019 14:26:29 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-84.rdu2.redhat.com [10.10.121.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 35D195D9DC;
        Wed, 16 Oct 2019 14:26:26 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=whiz1sHXu8SVZKEC2dup=r5JMrftPtEt6ff9Ea8dyH8yQ@mail.gmail.com>
References: <CAHk-=whiz1sHXu8SVZKEC2dup=r5JMrftPtEt6ff9Ea8dyH8yQ@mail.gmail.com> <157117606853.15019.15459271147790470307.stgit@warthog.procyon.org.uk> <157117608708.15019.1998141309054662114.stgit@warthog.procyon.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dhowells@redhat.com, Tim Chen <tim.c.chen@linux.intel.com>,
        Kan Liang <kan.liang@intel.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 02/21] Add a prelocked wake-up
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6899.1571235985.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Wed, 16 Oct 2019 15:26:25 +0100
Message-ID: <6900.1571235985@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Wed, 16 Oct 2019 14:26:30 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Btw, is there any point in __wake_up_sync_key() taking a nr_exclusive
argument since it clears WF_SYNC if nr_exclusive != 1 and doesn't make sense
to be >1 anyway.

David
---
diff --git a/include/linux/wait.h b/include/linux/wait.h
index 3eb7cae8206c..bb7676d396cd 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -201,9 +201,9 @@ void __wake_up(struct wait_queue_head *wq_head, unsigned int mode, int nr, void
 void __wake_up_locked_key(struct wait_queue_head *wq_head, unsigned int mode, void *key);
 void __wake_up_locked_key_bookmark(struct wait_queue_head *wq_head,
 		unsigned int mode, void *key, wait_queue_entry_t *bookmark);
-void __wake_up_sync_key(struct wait_queue_head *wq_head, unsigned int mode, int nr, void *key);
+void __wake_up_sync_key(struct wait_queue_head *wq_head, unsigned int mode, void *key);
 void __wake_up_locked(struct wait_queue_head *wq_head, unsigned int mode, int nr);
-void __wake_up_sync(struct wait_queue_head *wq_head, unsigned int mode, int nr);
+void __wake_up_sync(struct wait_queue_head *wq_head, unsigned int mode);
 
 #define wake_up(x)			__wake_up(x, TASK_NORMAL, 1, NULL)
 #define wake_up_nr(x, nr)		__wake_up(x, TASK_NORMAL, nr, NULL)
@@ -214,7 +214,7 @@ void __wake_up_sync(struct wait_queue_head *wq_head, unsigned int mode, int nr);
 #define wake_up_interruptible(x)	__wake_up(x, TASK_INTERRUPTIBLE, 1, NULL)
 #define wake_up_interruptible_nr(x, nr)	__wake_up(x, TASK_INTERRUPTIBLE, nr, NULL)
 #define wake_up_interruptible_all(x)	__wake_up(x, TASK_INTERRUPTIBLE, 0, NULL)
-#define wake_up_interruptible_sync(x)	__wake_up_sync((x), TASK_INTERRUPTIBLE, 1)
+#define wake_up_interruptible_sync(x)	__wake_up_sync((x), TASK_INTERRUPTIBLE)
 
 /*
  * Wakeup macros to be used to report events to the targets.
@@ -228,7 +228,7 @@ void __wake_up_sync(struct wait_queue_head *wq_head, unsigned int mode, int nr);
 #define wake_up_interruptible_poll(x, m)					\
 	__wake_up(x, TASK_INTERRUPTIBLE, 1, poll_to_key(m))
 #define wake_up_interruptible_sync_poll(x, m)					\
-	__wake_up_sync_key((x), TASK_INTERRUPTIBLE, 1, poll_to_key(m))
+	__wake_up_sync_key((x), TASK_INTERRUPTIBLE, poll_to_key(m))
 
 #define ___wait_cond_timeout(condition)						\
 ({										\
diff --git a/kernel/exit.c b/kernel/exit.c
index a46a50d67002..a1ff25ef050e 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -1435,7 +1435,7 @@ static int child_wait_callback(wait_queue_entry_t *wait, unsigned mode,
 void __wake_up_parent(struct task_struct *p, struct task_struct *parent)
 {
 	__wake_up_sync_key(&parent->signal->wait_chldexit,
-				TASK_INTERRUPTIBLE, 1, p);
+			   TASK_INTERRUPTIBLE, p);
 }
 
 static long do_wait(struct wait_opts *wo)
diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
index c1e566a114ca..b4b52361dab7 100644
--- a/kernel/sched/wait.c
+++ b/kernel/sched/wait.c
@@ -169,7 +169,6 @@ EXPORT_SYMBOL_GPL(__wake_up_locked_key_bookmark);
  * __wake_up_sync_key - wake up threads blocked on a waitqueue.
  * @wq_head: the waitqueue
  * @mode: which threads
- * @nr_exclusive: how many wake-one or wake-many threads to wake up
  * @key: opaque value to be passed to wakeup targets
  *
  * The sync wakeup differs that the waker knows that it will schedule
@@ -183,26 +182,21 @@ EXPORT_SYMBOL_GPL(__wake_up_locked_key_bookmark);
  * accessing the task state.
  */
 void __wake_up_sync_key(struct wait_queue_head *wq_head, unsigned int mode,
-			int nr_exclusive, void *key)
+			void *key)
 {
-	int wake_flags = 1; /* XXX WF_SYNC */
-
 	if (unlikely(!wq_head))
 		return;
 
-	if (unlikely(nr_exclusive != 1))
-		wake_flags = 0;
-
-	__wake_up_common_lock(wq_head, mode, nr_exclusive, wake_flags, key);
+	__wake_up_common_lock(wq_head, mode, 1, WF_SYNC, key);
 }
 EXPORT_SYMBOL_GPL(__wake_up_sync_key);
 
 /*
  * __wake_up_sync - see __wake_up_sync_key()
  */
-void __wake_up_sync(struct wait_queue_head *wq_head, unsigned int mode, int nr_exclusive)
+void __wake_up_sync(struct wait_queue_head *wq_head, unsigned int mode)
 {
-	__wake_up_sync_key(wq_head, mode, nr_exclusive, NULL);
+	__wake_up_sync_key(wq_head, mode, NULL);
 }
 EXPORT_SYMBOL_GPL(__wake_up_sync);	/* For internal use only */
 
