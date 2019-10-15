Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22B96D82B7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2019 23:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731942AbfJOVtX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Oct 2019 17:49:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56012 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727845AbfJOVtX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Oct 2019 17:49:23 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5D91718C427F;
        Tue, 15 Oct 2019 21:49:22 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-84.rdu2.redhat.com [10.10.121.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 71D316012E;
        Tue, 15 Oct 2019 21:49:19 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 10/21] security: Add hooks to rule on setting a watch
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
Date:   Tue, 15 Oct 2019 22:49:18 +0100
Message-ID: <157117615866.15019.12994037836113060379.stgit@warthog.procyon.org.uk>
In-Reply-To: <157117606853.15019.15459271147790470307.stgit@warthog.procyon.org.uk>
References: <157117606853.15019.15459271147790470307.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.62]); Tue, 15 Oct 2019 21:49:22 +0000 (UTC)
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
  *	@ctx is a pointer in which to place the allocated security context.
  *	@ctxlen points to the place to put the length of @ctx.
  *
+ * Security hooks for the general notification queue:
+ *
+ * @watch_key:
+ *	Check to see if a process is allowed to watch for event notifications
+ *	from a key or keyring.
+ *	@key: The key to watch.
+ *
+ * @watch_devices:
+ *	Check to see if a process is allowed to watch for event notifications
+ *	from devices (as a global set).
+ *
+ *
  * Security hooks for using the eBPF maps and programs functionalities through
  * eBPF syscalls.
  *
@@ -1698,6 +1710,12 @@ union security_list_options {
 	int (*inode_notifysecctx)(struct inode *inode, void *ctx, u32 ctxlen);
 	int (*inode_setsecctx)(struct dentry *dentry, void *ctx, u32 ctxlen);
 	int (*inode_getsecctx)(struct inode *inode, void **ctx, u32 *ctxlen);
+#ifdef CONFIG_KEY_NOTIFICATIONS
+	int (*watch_key)(struct key *key);
+#endif
+#ifdef CONFIG_DEVICE_NOTIFICATIONS
+	int (*watch_devices)(void);
+#endif
 
 #ifdef CONFIG_SECURITY_NETWORK
 	int (*unix_stream_connect)(struct sock *sock, struct sock *other,
@@ -1977,6 +1995,12 @@ struct security_hook_heads {
 	struct hlist_head inode_notifysecctx;
 	struct hlist_head inode_setsecctx;
 	struct hlist_head inode_getsecctx;
+#ifdef CONFIG_KEY_NOTIFICATIONS
+	struct hlist_head watch_key;
+#endif
+#ifdef CONFIG_DEVICE_NOTIFICATIONS
+	struct hlist_head watch_devices;
+#endif
 #ifdef CONFIG_SECURITY_NETWORK
 	struct hlist_head unix_stream_connect;
 	struct hlist_head unix_may_send;
diff --git a/include/linux/security.h b/include/linux/security.h
index a8d59d612d27..5d1867772022 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1271,6 +1271,23 @@ static inline int security_locked_down(enum lockdown_reason what)
 }
 #endif	/* CONFIG_SECURITY */
 
+#if defined(CONFIG_SECURITY) && defined(CONFIG_KEY_NOTIFICATIONS)
+int security_watch_key(struct key *key);
+#else
+static inline int security_watch_key(struct key *key)
+{
+	return 0;
+}
+#endif
+#if defined(CONFIG_SECURITY) && defined(CONFIG_DEVICE_NOTIFICATIONS)
+int security_watch_devices(void);
+#else
+static inline int security_watch_devices(void)
+{
+	return 0;
+}
+#endif
+
 #ifdef CONFIG_SECURITY_NETWORK
 
 int security_unix_stream_connect(struct sock *sock, struct sock *other, struct sock *newsk);
diff --git a/security/security.c b/security/security.c
index 1bc000f834e2..4f970716fa6c 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1956,6 +1956,20 @@ int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
 }
 EXPORT_SYMBOL(security_inode_getsecctx);
 
+#ifdef CONFIG_KEY_NOTIFICATIONS
+int security_watch_key(struct key *key)
+{
+	return call_int_hook(watch_key, 0, key);
+}
+#endif
+
+#ifdef CONFIG_DEVICE_NOTIFICATIONS
+int security_watch_devices(void)
+{
+	return call_int_hook(watch_devices, 0);
+}
+#endif
+
 #ifdef CONFIG_SECURITY_NETWORK
 
 int security_unix_stream_connect(struct sock *sock, struct sock *other, struct sock *newsk)

