Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3C759F90
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2019 17:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbfF1Ps6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jun 2019 11:48:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48032 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726905AbfF1Ps5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jun 2019 11:48:57 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AA298308FBB4;
        Fri, 28 Jun 2019 15:48:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-219.rdu2.redhat.com [10.10.120.219])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 379BF26DF3;
        Fri, 28 Jun 2019 15:48:48 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 2/9] security: Add hooks to rule on setting a watch [ver #5]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        nicolas.dichtel@6wind.com, raven@themaw.net,
        Christian Brauner <christian@brauner.io>, dhowells@redhat.com,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-block@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 28 Jun 2019 16:48:47 +0100
Message-ID: <156173692760.15137.9636883182556029747.stgit@warthog.procyon.org.uk>
In-Reply-To: <156173690158.15137.3985163001079120218.stgit@warthog.procyon.org.uk>
References: <156173690158.15137.3985163001079120218.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Fri, 28 Jun 2019 15:48:56 +0000 (UTC)
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

 include/linux/lsm_hooks.h |   22 ++++++++++++++++++++++
 include/linux/security.h  |   15 +++++++++++++++
 security/security.c       |   13 +++++++++++++
 3 files changed, 50 insertions(+)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 47f58cfb6a19..f9d31f6445e4 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1413,6 +1413,20 @@
  *	@ctx is a pointer in which to place the allocated security context.
  *	@ctxlen points to the place to put the length of @ctx.
  *
+ * Security hooks for the general notification queue:
+ *
+ * @watch_key:
+ *	Check to see if a process is allowed to watch for event notifications
+ *	from a key or keyring.
+ *	@watch: The watch object
+ *	@key: The key to watch.
+ *
+ * @watch_devices:
+ *	Check to see if a process is allowed to watch for event notifications
+ *	from devices (as a global set).
+ *	@watch: The watch object
+ *
+ *
  * Security hooks for using the eBPF maps and programs functionalities through
  * eBPF syscalls.
  *
@@ -1688,6 +1702,10 @@ union security_list_options {
 	int (*inode_notifysecctx)(struct inode *inode, void *ctx, u32 ctxlen);
 	int (*inode_setsecctx)(struct dentry *dentry, void *ctx, u32 ctxlen);
 	int (*inode_getsecctx)(struct inode *inode, void **ctx, u32 *ctxlen);
+#ifdef CONFIG_WATCH_QUEUE
+	int (*watch_key)(struct watch *watch, struct key *key);
+	int (*watch_devices)(struct watch *watch);
+#endif /* CONFIG_WATCH_QUEUE */
 
 #ifdef CONFIG_SECURITY_NETWORK
 	int (*unix_stream_connect)(struct sock *sock, struct sock *other,
@@ -1964,6 +1982,10 @@ struct security_hook_heads {
 	struct hlist_head inode_notifysecctx;
 	struct hlist_head inode_setsecctx;
 	struct hlist_head inode_getsecctx;
+#ifdef CONFIG_WATCH_QUEUE
+	struct hlist_head watch_key;
+	struct hlist_head watch_devices;
+#endif /* CONFIG_WATCH_QUEUE */
 #ifdef CONFIG_SECURITY_NETWORK
 	struct hlist_head unix_stream_connect;
 	struct hlist_head unix_may_send;
diff --git a/include/linux/security.h b/include/linux/security.h
index 659071c2e57c..540863678355 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -57,6 +57,7 @@ struct mm_struct;
 struct fs_context;
 struct fs_parameter;
 enum fs_value_type;
+struct watch;
 
 /* Default (no) options for the capable function */
 #define CAP_OPT_NONE 0x0
@@ -392,6 +393,10 @@ void security_inode_invalidate_secctx(struct inode *inode);
 int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
 int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
+#ifdef CONFIG_WATCH_QUEUE
+int security_watch_key(struct watch *watch, struct key *key);
+int security_watch_devices(struct watch *watch);
+#endif /* CONFIG_WATCH_QUEUE */
 #else /* CONFIG_SECURITY */
 
 static inline int call_lsm_notifier(enum lsm_event event, void *data)
@@ -1204,6 +1209,16 @@ static inline int security_inode_getsecctx(struct inode *inode, void **ctx, u32
 {
 	return -EOPNOTSUPP;
 }
+#ifdef CONFIG_WATCH_QUEUE
+static inline int security_watch_key(struct watch *watch, struct key *key)
+{
+	return 0;
+}
+static inline int security_watch_devices(struct watch *watch)
+{
+	return 0;
+}
+#endif /* CONFIG_WATCH_QUEUE */
 #endif	/* CONFIG_SECURITY */
 
 #ifdef CONFIG_SECURITY_NETWORK
diff --git a/security/security.c b/security/security.c
index 613a5c00e602..2c9919226ad1 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1917,6 +1917,19 @@ int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
 }
 EXPORT_SYMBOL(security_inode_getsecctx);
 
+#ifdef CONFIG_WATCH_QUEUE
+int security_watch_key(struct watch *watch, struct key *key)
+{
+	return call_int_hook(watch_key, 0, watch, key);
+}
+
+int security_watch_devices(struct watch *watch)
+{
+	return call_int_hook(watch_devices, 0, watch);
+}
+
+#endif /* CONFIG_WATCH_QUEUE */
+
 #ifdef CONFIG_SECURITY_NETWORK
 
 int security_unix_stream_connect(struct sock *sock, struct sock *other, struct sock *newsk)

