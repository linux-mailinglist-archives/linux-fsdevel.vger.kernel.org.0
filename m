Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9624F59FD5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2019 17:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfF1Pub (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jun 2019 11:50:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54507 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726750AbfF1Pua (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jun 2019 11:50:30 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3CA4981DEB;
        Fri, 28 Jun 2019 15:50:30 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-219.rdu2.redhat.com [10.10.120.219])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 595C85C22C;
        Fri, 28 Jun 2019 15:50:24 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 1/6] security: Add hooks to rule on setting a superblock or
 mount watch [ver #5]
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
Date:   Fri, 28 Jun 2019 16:50:23 +0100
Message-ID: <156173702349.15650.1484210092464492434.stgit@warthog.procyon.org.uk>
In-Reply-To: <156173701358.15650.8735203424342507015.stgit@warthog.procyon.org.uk>
References: <156173701358.15650.8735203424342507015.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Fri, 28 Jun 2019 15:50:30 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add security hooks that will allow an LSM to rule on whether or not a watch
may be set on a mount or on a superblock.  More than one hook is required
as the watches watch different types of object.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Casey Schaufler <casey@schaufler-ca.com>
cc: Stephen Smalley <sds@tycho.nsa.gov>
cc: linux-security-module@vger.kernel.org
---

 include/linux/lsm_hooks.h |   16 ++++++++++++++++
 include/linux/security.h  |   10 ++++++++++
 security/security.c       |   10 ++++++++++
 3 files changed, 36 insertions(+)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 5fe387d35990..3a4d7a260572 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1433,6 +1433,18 @@
  *	from devices (as a global set).
  *	@watch: The watch object
  *
+ * @watch_mount:
+ *	Check to see if a process is allowed to watch for mount topology change
+ *	notifications on a mount subtree.
+ *	@watch: The watch object
+ *	@path: The root of the subtree to watch.
+ *
+ * @watch_sb:
+ *	Check to see if a process is allowed to watch for event notifications
+ *	from a superblock.
+ *	@watch: The watch object
+ *	@sb: The superblock to watch.
+ *
  * @post_notification:
  *	Check to see if a watch notification can be posted to a particular
  *	queue.
@@ -1721,6 +1733,8 @@ union security_list_options {
 #ifdef CONFIG_WATCH_QUEUE
 	int (*watch_key)(struct watch *watch, struct key *key);
 	int (*watch_devices)(struct watch *watch);
+	int (*watch_mount)(struct watch *watch, struct path *path);
+	int (*watch_sb)(struct watch *watch, struct super_block *sb);
 	int (*post_notification)(const struct cred *w_cred,
 				 const struct cred *cred,
 				 struct watch_notification *n);
@@ -2007,6 +2021,8 @@ struct security_hook_heads {
 #ifdef CONFIG_WATCH_QUEUE
 	struct hlist_head watch_key;
 	struct hlist_head watch_devices;
+	struct hlist_head watch_mount;
+	struct hlist_head watch_sb;
 	struct hlist_head post_notification;
 #endif /* CONFIG_WATCH_QUEUE */
 #ifdef CONFIG_SECURITY_NETWORK
diff --git a/include/linux/security.h b/include/linux/security.h
index 8a9645472232..74ec6d41eca5 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -401,6 +401,8 @@ int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
 #ifdef CONFIG_WATCH_QUEUE
 int security_watch_key(struct watch *watch, struct key *key);
 int security_watch_devices(struct watch *watch);
+int security_watch_mount(struct watch *watch, struct path *path);
+int security_watch_sb(struct watch *watch, struct super_block *sb);
 int security_post_notification(const struct cred *w_cred,
 			       const struct cred *cred,
 			       struct watch_notification *n);
@@ -1233,6 +1235,14 @@ static inline int security_watch_devices(struct watch *watch)
 {
 	return 0;
 }
+static inline int security_watch_mount(struct watch *watch, struct path *path)
+{
+	return 0;
+}
+static inline int security_watch_sb(struct watch *watch, struct super_block *sb)
+{
+	return 0;
+}
 static inline int security_post_notification(const struct cred *w_cred,
 					     const struct cred *cred,
 					     struct watch_notification *n)
diff --git a/security/security.c b/security/security.c
index 1390fb1203e4..37fec6cec905 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1940,6 +1940,16 @@ int security_watch_devices(struct watch *watch)
 	return call_int_hook(watch_devices, 0, watch);
 }
 
+int security_watch_mount(struct watch *watch, struct path *path)
+{
+	return call_int_hook(watch_mount, 0, watch, path);
+}
+
+int security_watch_sb(struct watch *watch, struct super_block *sb)
+{
+	return call_int_hook(watch_sb, 0, watch, sb);
+}
+
 int security_post_notification(const struct cred *w_cred,
 			       const struct cred *cred,
 			       struct watch_notification *n)

