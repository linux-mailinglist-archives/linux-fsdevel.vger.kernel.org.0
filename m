Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6CC17DFC5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2020 13:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbgCIMR6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Mar 2020 08:17:58 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34436 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726620AbgCIMR5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Mar 2020 08:17:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583756276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e/8oKaNwBTjhOkAOmc6Y3YdVNmuI5yN2hQOJFhQz4lM=;
        b=Po5Vb6eyH5tFphGfDeeIoY9LJlDLjQLn3OXaoW5jSM3JPisG68xvAgg8QRQz0nopEQmPOo
        KSLTRS9X+D00BBQbKCtJHfk1Z/ggU7DKRIwkDeSpnN6SEiOYhDmyD8NycrZwEJNFzuyM92
        R2hjYlxRC9EPkrAS00XUbIiH0h89HNs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-s4zxH0fUMA-47Vr9jx16yA-1; Mon, 09 Mar 2020 08:17:55 -0400
X-MC-Unique: s4zxH0fUMA-47Vr9jx16yA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 328A6800D48;
        Mon,  9 Mar 2020 12:17:53 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-182.rdu2.redhat.com [10.10.120.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 610B973893;
        Mon,  9 Mar 2020 12:17:50 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 04/17] pipe: Add O_NOTIFICATION_PIPE [ver #4]
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, dhowells@redhat.com, casey@schaufler-ca.com,
        sds@tycho.nsa.gov, nicolas.dichtel@6wind.com, raven@themaw.net,
        christian@brauner.io, andres@anarazel.de, jlayton@redhat.com,
        dray@redhat.com, kzak@redhat.com, keyrings@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 09 Mar 2020 12:17:49 +0000
Message-ID: <158375626967.334846.484230574013552912.stgit@warthog.procyon.org.uk>
In-Reply-To: <158375623086.334846.16121725232323108842.stgit@warthog.procyon.org.uk>
References: <158375623086.334846.16121725232323108842.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add an O_NOTIFICATION_PIPE flag that can be passed to pipe2() to indicate
that the pipe being created is going to be used for notifications.  This
suppresses the use of splice(), vmsplice(), tee() and sendfile() on the
pipe as calling iov_iter_revert() on a pipe when a kernel notification
message has been inserted into the middle of a multi-buffer splice will be
messy.

The flag is given the same value as O_EXCL as it seems unlikely that
this flag will ever be applicable to pipes and I don't want to use up
another O_* bit unnecessarily.  An alternative could be to add a pipe3()
system call.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/uapi/linux/watch_queue.h |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/uapi/linux/watch_queue.h b/include/uapi/linux/watch_queue.h
index 5f3d21e8a34b..9df72227f515 100644
--- a/include/uapi/linux/watch_queue.h
+++ b/include/uapi/linux/watch_queue.h
@@ -3,6 +3,9 @@
 #define _UAPI_LINUX_WATCH_QUEUE_H
 
 #include <linux/types.h>
+#include <linux/fcntl.h>
+
+#define O_NOTIFICATION_PIPE	O_EXCL	/* Parameter to pipe2() selecting notification pipe */
 
 enum watch_notification_type {
 	WATCH_TYPE_META		= 0,	/* Special record */


