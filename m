Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 110D2D8292
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2019 23:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730775AbfJOVsi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Oct 2019 17:48:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44678 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726802AbfJOVsi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Oct 2019 17:48:38 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 39DA473A69;
        Tue, 15 Oct 2019 21:48:38 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-84.rdu2.redhat.com [10.10.121.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9DAB66012E;
        Tue, 15 Oct 2019 21:48:35 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 05/21] pipe: Conditionalise wakeup in pipe_read()
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
Date:   Tue, 15 Oct 2019 22:48:34 +0100
Message-ID: <157117611484.15019.2438330064445318267.stgit@warthog.procyon.org.uk>
In-Reply-To: <157117606853.15019.15459271147790470307.stgit@warthog.procyon.org.uk>
References: <157117606853.15019.15459271147790470307.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 15 Oct 2019 21:48:38 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Only do a wakeup in pipe_read() if we made space in a completely full
buffer.  The producer shouldn't be waiting on pipe->wait otherwise.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/pipe.c |   15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 08af7e7bbea2..0d25cb090a03 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -327,11 +327,13 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 				spin_lock_irq(&pipe->wait.lock);
 				tail++;
 				pipe_commit_read(pipe, tail);
-				do_wakeup = 0;
-				prelocked_wake_up_interruptible_sync_poll(
-					&pipe->wait, EPOLLOUT | EPOLLWRNORM);
+				do_wakeup = 1;
+				if (head - (tail - 1) == pipe->max_usage)
+					prelocked_wake_up_interruptible_sync_poll(
+						&pipe->wait, EPOLLOUT | EPOLLWRNORM);
 				spin_unlock_irq(&pipe->wait.lock);
-				kill_fasync(&pipe->fasync_writers, SIGIO, POLL_OUT);
+				if (head - (tail - 1) == pipe->max_usage)
+					kill_fasync(&pipe->fasync_writers, SIGIO, POLL_OUT);
 			}
 			total_len -= chars;
 			if (!total_len)
@@ -360,11 +362,6 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 				ret = -ERESTARTSYS;
 			break;
 		}
-		if (do_wakeup) {
-			wake_up_interruptible_sync_poll(&pipe->wait, EPOLLOUT | EPOLLWRNORM);
- 			kill_fasync(&pipe->fasync_writers, SIGIO, POLL_OUT);
-			do_wakeup = 0;
-		}
 		pipe_wait(pipe);
 	}
 	__pipe_unlock(pipe);

