Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD85D17DFDA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2020 13:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgCIMSh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Mar 2020 08:18:37 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25776 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726446AbgCIMSg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Mar 2020 08:18:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583756315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GR3gUWdq4byWgss8AntXB96XbBOJMDZx310zWsdihuU=;
        b=WHkZHfZkKVhMpEE8utOAqTVROONil16QyKH97oxXhtiOIrgTYLMrtYWIaVk7UJCaHbIsFZ
        IVuraSodnY99/+de7gs3QdBbGnNrZWYQp9ZQihyezXrBT2jSk3VxrBPJs8CzAFW8vb82dE
        3OhYtABV4JcxxcnoUnR0R6bAGLq5wf0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-dw7_wgJROhCZEiyBvG-QIw-1; Mon, 09 Mar 2020 08:18:31 -0400
X-MC-Unique: dw7_wgJROhCZEiyBvG-QIw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E48EC800D50;
        Mon,  9 Mar 2020 12:18:29 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-182.rdu2.redhat.com [10.10.120.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1DF125C1C3;
        Mon,  9 Mar 2020 12:18:26 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 08/17] pipe: Allow buffers to be marked
 read-whole-or-error for notifications [ver #4]
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, dhowells@redhat.com, casey@schaufler-ca.com,
        sds@tycho.nsa.gov, nicolas.dichtel@6wind.com, raven@themaw.net,
        christian@brauner.io, andres@anarazel.de, jlayton@redhat.com,
        dray@redhat.com, kzak@redhat.com, keyrings@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 09 Mar 2020 12:18:26 +0000
Message-ID: <158375630635.334846.14056952096999691585.stgit@warthog.procyon.org.uk>
In-Reply-To: <158375623086.334846.16121725232323108842.stgit@warthog.procyon.org.uk>
References: <158375623086.334846.16121725232323108842.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Allow a buffer to be marked such that read() must return the entire buffer
in one go or return ENOBUFS.  Multiple buffers can be amalgamated into a
single read, but a short read will occur if the next "whole" buffer won't
fit.

This is useful for watch queue notifications to make sure we don't split a
notification across multiple reads, especially given that we need to
fabricate an overrun record under some circumstances - and that isn't in
the buffers.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/pipe.c                        |    8 +++++++-
 include/linux/pipe_fs_i.h        |    1 +
 kernel/watch_queue.c             |    2 +-
 samples/watch_queue/watch_test.c |    2 +-
 4 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 36eedf8cb143..c98452868dde 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -320,8 +320,14 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 			size_t written;
 			int error;
 
-			if (chars > total_len)
+			if (chars > total_len) {
+				if (buf->flags & PIPE_BUF_FLAG_WHOLE) {
+					if (ret == 0)
+						ret = -ENOBUFS;
+					break;
+				}
 				chars = total_len;
+			}
 
 			error = pipe_buf_confirm(pipe, buf);
 			if (error) {
diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
index 8cd14d72dfd1..fee90981ba40 100644
--- a/include/linux/pipe_fs_i.h
+++ b/include/linux/pipe_fs_i.h
@@ -8,6 +8,7 @@
 #define PIPE_BUF_FLAG_ATOMIC	0x02	/* was atomically mapped */
 #define PIPE_BUF_FLAG_GIFT	0x04	/* page is a gift */
 #define PIPE_BUF_FLAG_PACKET	0x08	/* read() as a packet */
+#define PIPE_BUF_FLAG_WHOLE	0x10	/* read() must return entire buffer or error */
 
 /**
  *	struct pipe_buffer - a linux kernel pipe buffer
diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
index c103e34f8705..ad64ea300f6d 100644
--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -115,7 +115,7 @@ static bool post_one_notification(struct watch_queue *wqueue,
 	buf->ops = &watch_queue_pipe_buf_ops;
 	buf->offset = offset;
 	buf->len = len;
-	buf->flags = 0;
+	buf->flags = PIPE_BUF_FLAG_WHOLE;
 	pipe->head = head + 1;
 
 	if (!test_and_clear_bit(note, wqueue->notes_bitmap)) {
diff --git a/samples/watch_queue/watch_test.c b/samples/watch_queue/watch_test.c
index 9bf60abf5c7e..924e13a49c37 100644
--- a/samples/watch_queue/watch_test.c
+++ b/samples/watch_queue/watch_test.c
@@ -63,7 +63,7 @@ static void saw_key_change(struct watch_notification *n, size_t len)
  */
 static void consumer(int fd)
 {
-	unsigned char buffer[4096], *p, *end;
+	unsigned char buffer[433], *p, *end;
 	union {
 		struct watch_notification n;
 		unsigned char buf1[128];


