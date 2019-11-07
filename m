Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3627F2F93
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2019 14:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388964AbfKGNft (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Nov 2019 08:35:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54692 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388949AbfKGNft (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Nov 2019 08:35:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573133747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MDeACoL83y1tsr0QHr/3YWjjkVF4ntD6L2sg20RsuZs=;
        b=hFZGAe0wHjFgLTKj+o/x3KyHJEWkiqS10Q27uLwXiSvkHT9QfsvA7rMhFnzWyLsGReQ1RV
        bnIreG3ubjyJVBrarF1uDROyEl697UKBDP79CBva6XY1PdQbdAaDk7C6CtR+IwhQfYvj4s
        fXv7fXfqb+k4iTMsBZ7LrciyGkzXaEU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-xsJGfgOsOrqquyb3cy4x5g-1; Thu, 07 Nov 2019 08:35:44 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4BD881005500;
        Thu,  7 Nov 2019 13:35:42 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-254.rdu2.redhat.com [10.10.120.254])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 570031001B09;
        Thu,  7 Nov 2019 13:35:39 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 02/14] security: Add hooks to rule on setting a watch
 [ver #2]
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
Date:   Thu, 07 Nov 2019 13:35:38 +0000
Message-ID: <157313373855.29677.3888607349866181437.stgit@warthog.procyon.org.uk>
In-Reply-To: <157313371694.29677.15388731274912671071.stgit@warthog.procyon.org.uk>
References: <157313371694.29677.15388731274912671071.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: xsJGfgOsOrqquyb3cy4x5g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add security hooks that will allow an LSM to rule on whether or not a watch
may be set.  More than one hook is required as the watches watch different
types of object.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Casey Schaufler <casey@schaufler-ca.com>
cc: Stephen Smalley <sds@tycho.nsa.gov>
cc: linux-security-module@vger.kernel.org
---

 include/linux/lsm_hooks.h |   24 ++++++++++++++++++++++++
 include/linux/security.h  |   17 +++++++++++++++++
 security/security.c       |   14 ++++++++++++++
 3 files changed, 55 insertions(+)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index a3763247547c..d62e92b768c4 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1416,6 +1416,18 @@
  *=09@ctx is a pointer in which to place the allocated security context.
  *=09@ctxlen points to the place to put the length of @ctx.
  *
+ * Security hooks for the general notification queue:
+ *
+ * @watch_key:
+ *=09Check to see if a process is allowed to watch for event notifications
+ *=09from a key or keyring.
+ *=09@key: The key to watch.
+ *
+ * @watch_devices:
+ *=09Check to see if a process is allowed to watch for event notifications
+ *=09from devices (as a global set).
+ *
+ *
  * Security hooks for using the eBPF maps and programs functionalities thr=
ough
  * eBPF syscalls.
  *
@@ -1698,6 +1710,12 @@ union security_list_options {
 =09int (*inode_notifysecctx)(struct inode *inode, void *ctx, u32 ctxlen);
 =09int (*inode_setsecctx)(struct dentry *dentry, void *ctx, u32 ctxlen);
 =09int (*inode_getsecctx)(struct inode *inode, void **ctx, u32 *ctxlen);
+#ifdef CONFIG_KEY_NOTIFICATIONS
+=09int (*watch_key)(struct key *key);
+#endif
+#ifdef CONFIG_DEVICE_NOTIFICATIONS
+=09int (*watch_devices)(void);
+#endif
=20
 #ifdef CONFIG_SECURITY_NETWORK
 =09int (*unix_stream_connect)(struct sock *sock, struct sock *other,
@@ -1977,6 +1995,12 @@ struct security_hook_heads {
 =09struct hlist_head inode_notifysecctx;
 =09struct hlist_head inode_setsecctx;
 =09struct hlist_head inode_getsecctx;
+#ifdef CONFIG_KEY_NOTIFICATIONS
+=09struct hlist_head watch_key;
+#endif
+#ifdef CONFIG_DEVICE_NOTIFICATIONS
+=09struct hlist_head watch_devices;
+#endif
 #ifdef CONFIG_SECURITY_NETWORK
 =09struct hlist_head unix_stream_connect;
 =09struct hlist_head unix_may_send;
diff --git a/include/linux/security.h b/include/linux/security.h
index a8d59d612d27..5d1867772022 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1271,6 +1271,23 @@ static inline int security_locked_down(enum lockdown=
_reason what)
 }
 #endif=09/* CONFIG_SECURITY */
=20
+#if defined(CONFIG_SECURITY) && defined(CONFIG_KEY_NOTIFICATIONS)
+int security_watch_key(struct key *key);
+#else
+static inline int security_watch_key(struct key *key)
+{
+=09return 0;
+}
+#endif
+#if defined(CONFIG_SECURITY) && defined(CONFIG_DEVICE_NOTIFICATIONS)
+int security_watch_devices(void);
+#else
+static inline int security_watch_devices(void)
+{
+=09return 0;
+}
+#endif
+
 #ifdef CONFIG_SECURITY_NETWORK
=20
 int security_unix_stream_connect(struct sock *sock, struct sock *other, st=
ruct sock *newsk);
diff --git a/security/security.c b/security/security.c
index 1bc000f834e2..4f970716fa6c 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1956,6 +1956,20 @@ int security_inode_getsecctx(struct inode *inode, vo=
id **ctx, u32 *ctxlen)
 }
 EXPORT_SYMBOL(security_inode_getsecctx);
=20
+#ifdef CONFIG_KEY_NOTIFICATIONS
+int security_watch_key(struct key *key)
+{
+=09return call_int_hook(watch_key, 0, key);
+}
+#endif
+
+#ifdef CONFIG_DEVICE_NOTIFICATIONS
+int security_watch_devices(void)
+{
+=09return call_int_hook(watch_devices, 0);
+}
+#endif
+
 #ifdef CONFIG_SECURITY_NETWORK
=20
 int security_unix_stream_connect(struct sock *sock, struct sock *other, st=
ruct sock *newsk)

