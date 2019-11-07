Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B96FBF2FA0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2019 14:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389058AbfKGNgH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Nov 2019 08:36:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21286 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389044AbfKGNgG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Nov 2019 08:36:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573133765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1iJ9SFloRQNuyS/D5+Qa3Tkj5Bge5r/4dODrhTtMrE4=;
        b=Pk10vjQOXA7DG+4dzJY+MqaCfpLY/fQoHBtQxzF4EUfAiQYKfQgeBebSUUKG3/oMqOrz//
        YGgBfodqQoCgKCrRyMBpoZsmDyX92W/9+oo2rSeKawPF3mVq4e5oSJGjstuLjy7DIYsxR0
        t+tbJU/lMLMsVJCgIrM2S9Rb8y78Eyc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-fcnjLTtBM8KugIWCHW5cqg-1; Thu, 07 Nov 2019 08:36:02 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 55841800C61;
        Thu,  7 Nov 2019 13:36:00 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-254.rdu2.redhat.com [10.10.120.254])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8FE2D600D1;
        Thu,  7 Nov 2019 13:35:57 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 04/14] pipe: Add O_NOTIFICATION_PIPE [ver #2]
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     dhowells@redhat.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, nicolas.dichtel@6wind.com,
        raven@themaw.net, Christian Brauner <christian@brauner.io>,
        dhowells@redhat.com, keyrings@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-block@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 07 Nov 2019 13:35:56 +0000
Message-ID: <157313375678.29677.15875689548927466028.stgit@warthog.procyon.org.uk>
In-Reply-To: <157313371694.29677.15388731274912671071.stgit@warthog.procyon.org.uk>
References: <157313371694.29677.15388731274912671071.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: fcnjLTtBM8KugIWCHW5cqg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

diff --git a/include/uapi/linux/watch_queue.h b/include/uapi/linux/watch_qu=
eue.h
index 5f3d21e8a34b..9df72227f515 100644
--- a/include/uapi/linux/watch_queue.h
+++ b/include/uapi/linux/watch_queue.h
@@ -3,6 +3,9 @@
 #define _UAPI_LINUX_WATCH_QUEUE_H
=20
 #include <linux/types.h>
+#include <linux/fcntl.h>
+
+#define O_NOTIFICATION_PIPE=09O_EXCL=09/* Parameter to pipe2() selecting n=
otification pipe */
=20
 enum watch_notification_type {
 =09WATCH_TYPE_META=09=09=3D 0,=09/* Special record */

