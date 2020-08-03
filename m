Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB94123A736
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Aug 2020 15:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgHCNGh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Aug 2020 09:06:37 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58136 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727064AbgHCNGh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Aug 2020 09:06:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596459995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j/v002Gxe6nBxuXIo8xXJ4Ruh4kteZD7I/mhEJxj0MM=;
        b=MuV+mJpI9HWCI/yVeXv5uoperMrxw6iZZ4yWmzf5HEbQNIcRduKyBVHx9oLMp5iXSa2mRS
        N33KJ0NOWR9FTtGihXkFeZNNV4JsW2WGmxHzJS3OAfJ9Bc6GQ+uM2A7baewtmmVBc3T00m
        tBmNEsONIIbvXco6u/tjOCRJDziQYWc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-NWK5erupNA6dLy11xyeTNg-1; Mon, 03 Aug 2020 09:06:34 -0400
X-MC-Unique: NWK5erupNA6dLy11xyeTNg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 29543106B20A;
        Mon,  3 Aug 2020 13:06:32 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-32.rdu2.redhat.com [10.10.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 214D78A19E;
        Mon,  3 Aug 2020 13:06:27 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 1/5] watch_queue: Limit the number of watches a user can hold
 [ver #2]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        dhowells@redhat.com, torvalds@linux-foundation.org,
        casey@schaufler-ca.com, sds@tycho.nsa.gov,
        nicolas.dichtel@6wind.com, raven@themaw.net, christian@brauner.io,
        jlayton@redhat.com, kzak@redhat.com, mszeredi@redhat.com,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 03 Aug 2020 14:06:27 +0100
Message-ID: <159645998732.1779777.6694081988484186124.stgit@warthog.procyon.org.uk>
In-Reply-To: <159645997768.1779777.8286723139418624756.stgit@warthog.procyon.org.uk>
References: <159645997768.1779777.8286723139418624756.stgit@warthog.procyon.org.uk>
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
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
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


