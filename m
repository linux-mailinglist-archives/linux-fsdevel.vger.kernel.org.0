Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57BC7D827B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2019 23:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731082AbfJOVsM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Oct 2019 17:48:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49798 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730483AbfJOVsK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Oct 2019 17:48:10 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3C1A073A62;
        Tue, 15 Oct 2019 21:48:10 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-84.rdu2.redhat.com [10.10.121.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C1D6360852;
        Tue, 15 Oct 2019 21:48:07 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 02/21] Add a prelocked wake-up
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     dhowells@redhat.com, Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        nicolas.dichtel@6wind.com, raven@themaw.net,
        Christian Brauner <christian@brauner.io>, dhowells@redhat.com,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 15 Oct 2019 22:48:07 +0100
Message-ID: <157117608708.15019.1998141309054662114.stgit@warthog.procyon.org.uk>
In-Reply-To: <157117606853.15019.15459271147790470307.stgit@warthog.procyon.org.uk>
References: <157117606853.15019.15459271147790470307.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 15 Oct 2019 21:48:10 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a wakeup call for a case whereby the caller already has the waitqueue
spinlock held.  This can be used by pipes to alter the ring buffer indices
under the spinlock.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/wait.h |    2 ++
 kernel/sched/wait.c  |    7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/include/linux/wait.h b/include/linux/wait.h
index 3eb7cae8206c..d511b298a20c 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -229,6 +229,8 @@ void __wake_up_sync(struct wait_queue_head *wq_head, unsigned int mode, int nr);
 	__wake_up(x, TASK_INTERRUPTIBLE, 1, poll_to_key(m))
 #define wake_up_interruptible_sync_poll(x, m)					\
 	__wake_up_sync_key((x), TASK_INTERRUPTIBLE, 1, poll_to_key(m))
+void prelocked_wake_up_interruptible_sync_poll(struct wait_queue_head *wq_head,
+					       __poll_t mask);
 
 #define ___wait_cond_timeout(condition)						\
 ({										\
diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
index c1e566a114ca..43fbbbe9af27 100644
--- a/kernel/sched/wait.c
+++ b/kernel/sched/wait.c
@@ -126,6 +126,13 @@ static void __wake_up_common_lock(struct wait_queue_head *wq_head, unsigned int
 	} while (bookmark.flags & WQ_FLAG_BOOKMARK);
 }
 
+void prelocked_wake_up_interruptible_sync_poll(struct wait_queue_head *wq_head,
+					       __poll_t mask)
+{
+	__wake_up_common(wq_head, TASK_INTERRUPTIBLE, 1, WF_SYNC,
+			 poll_to_key(mask), NULL);
+}
+
 /**
  * __wake_up - wake up threads blocked on a waitqueue.
  * @wq_head: the waitqueue

