Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 470D1D8288
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2019 23:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731404AbfJOVsa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Oct 2019 17:48:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55734 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729725AbfJOVsa (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Oct 2019 17:48:30 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9874118C427E;
        Tue, 15 Oct 2019 21:48:29 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-84.rdu2.redhat.com [10.10.121.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 056AF5D9E2;
        Tue, 15 Oct 2019 21:48:26 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 04/21] pipe: Advance tail pointer inside of wait
 spinlock in pipe_read()
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
Date:   Tue, 15 Oct 2019 22:48:26 +0100
Message-ID: <157117610623.15019.10121494102947608380.stgit@warthog.procyon.org.uk>
In-Reply-To: <157117606853.15019.15459271147790470307.stgit@warthog.procyon.org.uk>
References: <157117606853.15019.15459271147790470307.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.62]); Tue, 15 Oct 2019 21:48:29 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Advance the pipe ring tail pointer inside of wait spinlock in pipe_read()
so that the pipe can be written into with kernel notifications from
contexts where pipe->mutex cannot be taken.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/pipe.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 0574277bad18..08af7e7bbea2 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -324,9 +324,14 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 
 			if (!buf->len) {
 				pipe_buf_release(pipe, buf);
+				spin_lock_irq(&pipe->wait.lock);
 				tail++;
 				pipe_commit_read(pipe, tail);
-				do_wakeup = 1;
+				do_wakeup = 0;
+				prelocked_wake_up_interruptible_sync_poll(
+					&pipe->wait, EPOLLOUT | EPOLLWRNORM);
+				spin_unlock_irq(&pipe->wait.lock);
+				kill_fasync(&pipe->fasync_writers, SIGIO, POLL_OUT);
 			}
 			total_len -= chars;
 			if (!total_len)
@@ -358,6 +363,7 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 		if (do_wakeup) {
 			wake_up_interruptible_sync_poll(&pipe->wait, EPOLLOUT | EPOLLWRNORM);
  			kill_fasync(&pipe->fasync_writers, SIGIO, POLL_OUT);
+			do_wakeup = 0;
 		}
 		pipe_wait(pipe);
 	}

