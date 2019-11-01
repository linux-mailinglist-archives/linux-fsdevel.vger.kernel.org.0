Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DAEDEC7AD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2019 18:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729516AbfKARea (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Nov 2019 13:34:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60685 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726979AbfKARea (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Nov 2019 13:34:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572629669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OLwH1xhZtcs6oehBhP4aFawQY9wwncddHsWF2TUeyN4=;
        b=c89MDXXKh53Cn7lTIiazHqeRFtLjbTInA9JvG/EZERpswsN6mUmw+rv9PVOJtvimrz/mpD
        8cjS2KQnyIE1k2pczdz2JmMTq/ap3fQTs4L/fBhKM6cBwC+Sf0Y0uxgpo2UOc4NLUaGZmj
        KD0IyGFmp4D7MKm5u9C5AdFhQmZ7+ps=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-bpXnJyK9PXO9uxLy8SjMgQ-1; Fri, 01 Nov 2019 13:34:23 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 512BB1800D7D;
        Fri,  1 Nov 2019 17:34:21 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-40.rdu2.redhat.com [10.10.121.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AA7C360BEC;
        Fri,  1 Nov 2019 17:34:18 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 02/11] Remove the nr_exclusive argument from
 __wake_up_sync_key() [ver #3]
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
Date:   Fri, 01 Nov 2019 17:34:18 +0000
Message-ID: <157262965796.13142.7304635748939123321.stgit@warthog.procyon.org.uk>
In-Reply-To: <157262963995.13142.5568934007158044624.stgit@warthog.procyon.org.uk>
References: <157262963995.13142.5568934007158044624.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: bpXnJyK9PXO9uxLy8SjMgQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove the nr_exclusive argument from __wake_up_sync_key() and derived
functions as everything seems to set it to 1.  Note also that if it wasn't
set to 1, it would clear WF_SYNC anyway.

Signed-off-by: David Howells <dhowells@redhat.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---

 include/linux/wait.h |    8 ++++----
 kernel/exit.c        |    2 +-
 kernel/sched/wait.c  |   14 ++++----------
 3 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/include/linux/wait.h b/include/linux/wait.h
index 3eb7cae8206c..bb7676d396cd 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -201,9 +201,9 @@ void __wake_up(struct wait_queue_head *wq_head, unsigne=
d int mode, int nr, void
 void __wake_up_locked_key(struct wait_queue_head *wq_head, unsigned int mo=
de, void *key);
 void __wake_up_locked_key_bookmark(struct wait_queue_head *wq_head,
 =09=09unsigned int mode, void *key, wait_queue_entry_t *bookmark);
-void __wake_up_sync_key(struct wait_queue_head *wq_head, unsigned int mode=
, int nr, void *key);
+void __wake_up_sync_key(struct wait_queue_head *wq_head, unsigned int mode=
, void *key);
 void __wake_up_locked(struct wait_queue_head *wq_head, unsigned int mode, =
int nr);
-void __wake_up_sync(struct wait_queue_head *wq_head, unsigned int mode, in=
t nr);
+void __wake_up_sync(struct wait_queue_head *wq_head, unsigned int mode);
=20
 #define wake_up(x)=09=09=09__wake_up(x, TASK_NORMAL, 1, NULL)
 #define wake_up_nr(x, nr)=09=09__wake_up(x, TASK_NORMAL, nr, NULL)
@@ -214,7 +214,7 @@ void __wake_up_sync(struct wait_queue_head *wq_head, un=
signed int mode, int nr);
 #define wake_up_interruptible(x)=09__wake_up(x, TASK_INTERRUPTIBLE, 1, NUL=
L)
 #define wake_up_interruptible_nr(x, nr)=09__wake_up(x, TASK_INTERRUPTIBLE,=
 nr, NULL)
 #define wake_up_interruptible_all(x)=09__wake_up(x, TASK_INTERRUPTIBLE, 0,=
 NULL)
-#define wake_up_interruptible_sync(x)=09__wake_up_sync((x), TASK_INTERRUPT=
IBLE, 1)
+#define wake_up_interruptible_sync(x)=09__wake_up_sync((x), TASK_INTERRUPT=
IBLE)
=20
 /*
  * Wakeup macros to be used to report events to the targets.
@@ -228,7 +228,7 @@ void __wake_up_sync(struct wait_queue_head *wq_head, un=
signed int mode, int nr);
 #define wake_up_interruptible_poll(x, m)=09=09=09=09=09\
 =09__wake_up(x, TASK_INTERRUPTIBLE, 1, poll_to_key(m))
 #define wake_up_interruptible_sync_poll(x, m)=09=09=09=09=09\
-=09__wake_up_sync_key((x), TASK_INTERRUPTIBLE, 1, poll_to_key(m))
+=09__wake_up_sync_key((x), TASK_INTERRUPTIBLE, poll_to_key(m))
=20
 #define ___wait_cond_timeout(condition)=09=09=09=09=09=09\
 ({=09=09=09=09=09=09=09=09=09=09\
diff --git a/kernel/exit.c b/kernel/exit.c
index a46a50d67002..a1ff25ef050e 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -1435,7 +1435,7 @@ static int child_wait_callback(wait_queue_entry_t *wa=
it, unsigned mode,
 void __wake_up_parent(struct task_struct *p, struct task_struct *parent)
 {
 =09__wake_up_sync_key(&parent->signal->wait_chldexit,
-=09=09=09=09TASK_INTERRUPTIBLE, 1, p);
+=09=09=09   TASK_INTERRUPTIBLE, p);
 }
=20
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
 void __wake_up_sync_key(struct wait_queue_head *wq_head, unsigned int mode=
,
-=09=09=09int nr_exclusive, void *key)
+=09=09=09void *key)
 {
-=09int wake_flags =3D 1; /* XXX WF_SYNC */
-
 =09if (unlikely(!wq_head))
 =09=09return;
=20
-=09if (unlikely(nr_exclusive !=3D 1))
-=09=09wake_flags =3D 0;
-
-=09__wake_up_common_lock(wq_head, mode, nr_exclusive, wake_flags, key);
+=09__wake_up_common_lock(wq_head, mode, 1, WF_SYNC, key);
 }
 EXPORT_SYMBOL_GPL(__wake_up_sync_key);
=20
 /*
  * __wake_up_sync - see __wake_up_sync_key()
  */
-void __wake_up_sync(struct wait_queue_head *wq_head, unsigned int mode, in=
t nr_exclusive)
+void __wake_up_sync(struct wait_queue_head *wq_head, unsigned int mode)
 {
-=09__wake_up_sync_key(wq_head, mode, nr_exclusive, NULL);
+=09__wake_up_sync_key(wq_head, mode, NULL);
 }
 EXPORT_SYMBOL_GPL(__wake_up_sync);=09/* For internal use only */
=20

