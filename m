Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B13F3F2F9B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2019 14:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388700AbfKGNgB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Nov 2019 08:36:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43809 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389009AbfKGNf6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Nov 2019 08:35:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573133756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n4R1Fzd+pGG5bQkqBl+oCaWkFZmZQWCk8wvdGedtUFc=;
        b=MfXq3GgG+369eHmfHR0DgxoaHmm20hwM4IY/my75ecmehqtoqfRxJZAeIg5kOpjQO1OU+y
        jLxXFjeRSCqEcEnLvzyCtAdC8UXrHraI+P6u+Z0fYRAIilNB08hoMLU7n+2VIEDGJSvmq9
        lgtpHoWFHOiE0jXhojhqLGQ4Bfd++yY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-cqWgQ4OrMpmP2rEkq2S4Pw-1; Thu, 07 Nov 2019 08:35:53 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 89136107ACC4;
        Thu,  7 Nov 2019 13:35:51 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-254.rdu2.redhat.com [10.10.120.254])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5330D5D6A0;
        Thu,  7 Nov 2019 13:35:48 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 03/14] security: Add a hook for the point of
 notification insertion [ver #2]
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
Date:   Thu, 07 Nov 2019 13:35:47 +0000
Message-ID: <157313374753.29677.10499095666351592097.stgit@warthog.procyon.org.uk>
In-Reply-To: <157313371694.29677.15388731274912671071.stgit@warthog.procyon.org.uk>
References: <157313371694.29677.15388731274912671071.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: cqWgQ4OrMpmP2rEkq2S4Pw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a security hook that allows an LSM to rule on whether a notification
message is allowed to be inserted into a particular watch queue.

The hook is given the following information:

 (1) The credentials of the triggerer (which may be init_cred for a system
     notification, eg. a hardware error).

 (2) The credentials of the whoever set the watch.

 (3) The notification message.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Casey Schaufler <casey@schaufler-ca.com>
cc: Stephen Smalley <sds@tycho.nsa.gov>
cc: linux-security-module@vger.kernel.org
---

 include/linux/lsm_hooks.h |   14 ++++++++++++++
 include/linux/security.h  |   15 ++++++++++++++-
 security/security.c       |    9 +++++++++
 3 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index d62e92b768c4..8e1cbc27fc62 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1427,6 +1427,12 @@
  *=09Check to see if a process is allowed to watch for event notifications
  *=09from devices (as a global set).
  *
+ * @post_notification:
+ *=09Check to see if a watch notification can be posted to a particular
+ *=09queue.
+ *=09@w_cred: The credentials of the whoever set the watch.
+ *=09@cred: The event-triggerer's credentials
+ *=09@n: The notification being posted
  *
  * Security hooks for using the eBPF maps and programs functionalities thr=
ough
  * eBPF syscalls.
@@ -1716,6 +1722,11 @@ union security_list_options {
 #ifdef CONFIG_DEVICE_NOTIFICATIONS
 =09int (*watch_devices)(void);
 #endif
+#ifdef CONFIG_WATCH_QUEUE
+=09int (*post_notification)(const struct cred *w_cred,
+=09=09=09=09 const struct cred *cred,
+=09=09=09=09 struct watch_notification *n);
+#endif
=20
 #ifdef CONFIG_SECURITY_NETWORK
 =09int (*unix_stream_connect)(struct sock *sock, struct sock *other,
@@ -2001,6 +2012,9 @@ struct security_hook_heads {
 #ifdef CONFIG_DEVICE_NOTIFICATIONS
 =09struct hlist_head watch_devices;
 #endif
+#ifdef CONFIG_WATCH_QUEUE
+=09struct hlist_head post_notification;
+#endif /* CONFIG_WATCH_QUEUE */
 #ifdef CONFIG_SECURITY_NETWORK
 =09struct hlist_head unix_stream_connect;
 =09struct hlist_head unix_may_send;
diff --git a/include/linux/security.h b/include/linux/security.h
index 5d1867772022..ee98e020c749 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -57,6 +57,8 @@ struct mm_struct;
 struct fs_context;
 struct fs_parameter;
 enum fs_value_type;
+struct watch;
+struct watch_notification;
=20
 /* Default (no) options for the capable function */
 #define CAP_OPT_NONE 0x0
@@ -1287,6 +1289,18 @@ static inline int security_watch_devices(void)
 =09return 0;
 }
 #endif
+#if defined(CONFIG_SECURITY) && defined(CONFIG_WATCH_QUEUE)
+int security_post_notification(const struct cred *w_cred,
+=09=09=09       const struct cred *cred,
+=09=09=09       struct watch_notification *n);
+#else
+static inline int security_post_notification(const struct cred *w_cred,
+=09=09=09=09=09     const struct cred *cred,
+=09=09=09=09=09     struct watch_notification *n)
+{
+=09return 0;
+}
+#endif
=20
 #ifdef CONFIG_SECURITY_NETWORK
=20
@@ -1912,4 +1926,3 @@ static inline void security_bpf_prog_free(struct bpf_=
prog_aux *aux)
 #endif /* CONFIG_BPF_SYSCALL */
=20
 #endif /* ! __LINUX_SECURITY_H */
-
diff --git a/security/security.c b/security/security.c
index 4f970716fa6c..c9d5c3d5472a 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1956,6 +1956,15 @@ int security_inode_getsecctx(struct inode *inode, vo=
id **ctx, u32 *ctxlen)
 }
 EXPORT_SYMBOL(security_inode_getsecctx);
=20
+#ifdef CONFIG_WATCH_QUEUE
+int security_post_notification(const struct cred *w_cred,
+=09=09=09       const struct cred *cred,
+=09=09=09       struct watch_notification *n)
+{
+=09return call_int_hook(post_notification, 0, w_cred, cred, n);
+}
+#endif /* CONFIG_WATCH_QUEUE */
+
 #ifdef CONFIG_KEY_NOTIFICATIONS
 int security_watch_key(struct key *key)
 {

