Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 942BD22D1B1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jul 2020 00:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbgGXWRe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jul 2020 18:17:34 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58958 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726607AbgGXWRe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jul 2020 18:17:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595629052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ikn7XLZPTxeIVvUjg9wLFxM7BUnwsYUpP1vYegUNA+s=;
        b=F52nhKBrOz0C/WnJeqBz3mB0QTsedwc/h3aA0L0K3k86hR+meQdKuqbb1Abo7Nz8L2GlwE
        jLiz6dYwxGMWLET3EDIgOqJfVwcDgoNlXch14xq1cEc4jEfr9V9N7btZtDrNYivg35BvoC
        6gBLpmS3k6yOjmZVDjjkewzs+lErZOM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-503-0zdhgtEIODezm04tPgO93g-1; Fri, 24 Jul 2020 18:17:30 -0400
X-MC-Unique: 0zdhgtEIODezm04tPgO93g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 958461902EA0;
        Fri, 24 Jul 2020 22:17:28 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-32.rdu2.redhat.com [10.10.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 513E18BEF7;
        Fri, 24 Jul 2020 22:17:27 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] watch_queue: Limit the number of watches a user can hold
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     dhowells@redhat.com, jarkko.sakkinen@linux.intel.com,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 24 Jul 2020 23:17:26 +0100
Message-ID: <159562904644.2287160.13294507067766261970.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Impose a limit on the number of watches that a user can hold so that they
can't use this mechanism to fill up all the available memory.

This is done by putting a counter in user_struct that's incremented when a
watch is allocated and decreased when it is released.  If the number
exceeds the RLIMIT_NOFILE limit, the watch is rejected with EAGAIN.

This can be tested by the following means:

 (1) Create a watch queue and attach it to fd 5 in the program given - in
     this case, bash:

	keyctl watch_session /tmp/nlog /tmp/gclog 5 bash

 (2) In the shell, set the maximum number of files to, say, 99:

	ulimit -n 99

 (3) Add 200 keyrings:

	for ((i=0; i<200; i++)); do keyctl newring a$i @s || break; done

 (4) Try to watch all of the keyrings:

	for ((i=0; i<200; i++)); do echo $i; keyctl watch_add 5 %:a$i || break; done

     This should fail when the number of watches belonging to the user hits
     99.

 (5) Remove all the keyrings and all of those watches should go away:

	for ((i=0; i<200; i++)); do keyctl unlink %:a$i; done

 (6) Kill off the watch queue by exiting the shell spawned by
     watch_session.

Fixes: c73be61cede5 ("pipe: Add general notification queue support")
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/sched/user.h |    3 +++
 kernel/watch_queue.c       |    8 ++++++++
 2 files changed, 11 insertions(+)

diff --git a/include/linux/sched/user.h b/include/linux/sched/user.h
index 917d88edb7b9..a8ec3b6093fc 100644
--- a/include/linux/sched/user.h
+++ b/include/linux/sched/user.h
@@ -36,6 +36,9 @@ struct user_struct {
     defined(CONFIG_NET) || defined(CONFIG_IO_URING)
 	atomic_long_t locked_vm;
 #endif
+#ifdef CONFIG_WATCH_QUEUE
+	atomic_t nr_watches;	/* The number of watches this user currently has */
+#endif
 
 	/* Miscellaneous per-user rate limit */
 	struct ratelimit_state ratelimit;
diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
index f74020f6bd9d..0ef8f65bd2d7 100644
--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -393,6 +393,7 @@ static void free_watch(struct rcu_head *rcu)
 	struct watch *watch = container_of(rcu, struct watch, rcu);
 
 	put_watch_queue(rcu_access_pointer(watch->queue));
+	atomic_dec(&watch->cred->user->nr_watches);
 	put_cred(watch->cred);
 }
 
@@ -452,6 +453,13 @@ int add_watch_to_object(struct watch *watch, struct watch_list *wlist)
 	watch->cred = get_current_cred();
 	rcu_assign_pointer(watch->watch_list, wlist);
 
+	if (atomic_inc_return(&watch->cred->user->nr_watches) >
+	    task_rlimit(current, RLIMIT_NOFILE)) {
+		atomic_dec(&watch->cred->user->nr_watches);
+		put_cred(watch->cred);
+		return -EAGAIN;
+	}
+
 	spin_lock_bh(&wqueue->lock);
 	kref_get(&wqueue->usage);
 	kref_get(&watch->usage);


