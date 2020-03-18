Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53352189EB4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Mar 2020 16:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbgCRPEB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Mar 2020 11:04:01 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:48187 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727194AbgCRPEA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Mar 2020 11:04:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584543839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e/8oKaNwBTjhOkAOmc6Y3YdVNmuI5yN2hQOJFhQz4lM=;
        b=GulVKCUNx2HFbvOZDKcqpFF4a43jZJ8sIEO2su8nqiw0somMmxsTEPX66a/lBSg/U/ojCD
        q7VqIwvMya60ZrYAiLctIl5cXRsNZtLYtnCM/QHaRmq9CaLWO+KnlYblIgr9xnGCbK1Exl
        hsUjQekAmEJpOxbDQo9v9MmwkQgewL0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-FfNo_gf4O0Wxy5Ttl7H2sQ-1; Wed, 18 Mar 2020 11:03:55 -0400
X-MC-Unique: FfNo_gf4O0Wxy5Ttl7H2sQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A0DEA1366;
        Wed, 18 Mar 2020 15:03:53 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-113-126.rdu2.redhat.com [10.10.113.126])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EF0415C241;
        Wed, 18 Mar 2020 15:03:50 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 04/17] pipe: Add O_NOTIFICATION_PIPE [ver #5]
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, casey@schaufler-ca.com, sds@tycho.nsa.gov,
        nicolas.dichtel@6wind.com, raven@themaw.net, christian@brauner.io,
        andres@anarazel.de, jlayton@redhat.com, dray@redhat.com,
        kzak@redhat.com, keyrings@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 18 Mar 2020 15:03:50 +0000
Message-ID: <158454383029.2863966.1921520389317717899.stgit@warthog.procyon.org.uk>
In-Reply-To: <158454378820.2863966.10496767254293183123.stgit@warthog.procyon.org.uk>
References: <158454378820.2863966.10496767254293183123.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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


