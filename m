Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 585F9162B74
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 18:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbgBRRGl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 12:06:41 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40334 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726742AbgBRRGi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 12:06:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582045596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yfA5n8Z+aIk+kyYGrURBEqzc1iGCmKy1Em7iNUliKXo=;
        b=BgIXjbCLHBUJKAUm74I5cZL7ZdvZvhRVbB+iZNaA1wlkIeGlOCyhhk5B5N1VXRR7+F4jZM
        YAZfYDJBefrzt8VuRo1IQMtRZk+8wmxb2e47AIPK47npMJoh4S+KcLVy+ct0UndHqlyLLg
        YWUdkfX9yBNis81k0qjePRAbtpQ53a0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-m6fPwh4wM82T2JjhXtBb3Q-1; Tue, 18 Feb 2020 12:06:32 -0500
X-MC-Unique: m6fPwh4wM82T2JjhXtBb3Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2097C108442A;
        Tue, 18 Feb 2020 17:06:31 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-122-163.rdu2.redhat.com [10.10.122.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9AF2E90F65;
        Tue, 18 Feb 2020 17:06:29 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 12/19] security: Add hooks to rule on setting a superblock or
 mount watch [ver #16]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net, mszeredi@redhat.com,
        christian@brauner.io, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 18 Feb 2020 17:06:28 +0000
Message-ID: <158204558892.3299825.4526893589062757993.stgit@warthog.procyon.org.uk>
In-Reply-To: <158204549488.3299825.3783690177353088425.stgit@warthog.procyon.org.uk>
References: <158204549488.3299825.3783690177353088425.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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

 include/linux/lsm_hooks.h |   24 ++++++++++++++++++++++++
 include/linux/security.h  |   16 ++++++++++++++++
 security/security.c       |   14 ++++++++++++++
 3 files changed, 54 insertions(+)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 16530255dc11..c4451ac197ae 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1427,6 +1427,18 @@
  *	Check to see if a process is allowed to watch for event notifications
  *	from devices (as a global set).
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
@@ -1722,6 +1734,12 @@ union security_list_options {
 #ifdef CONFIG_DEVICE_NOTIFICATIONS
 	int (*watch_devices)(void);
 #endif
+#ifdef CONFIG_MOUNT_NOTIFICATIONS
+	int (*watch_mount)(struct watch *watch, struct path *path);
+#endif
+#ifdef CONFIG_SB_NOTIFICATIONS
+	int (*watch_sb)(struct watch *watch, struct super_block *sb);
+#endif
 #ifdef CONFIG_WATCH_QUEUE
 	int (*post_notification)(const struct cred *w_cred,
 				 const struct cred *cred,
@@ -2020,6 +2038,12 @@ struct security_hook_heads {
 #ifdef CONFIG_DEVICE_NOTIFICATIONS
 	struct hlist_head watch_devices;
 #endif
+#ifdef CONFIG_MOUNT_NOTIFICATIONS
+	struct hlist_head watch_mount;
+#endif
+#ifdef CONFIG_SB_NOTIFICATIONS
+	struct hlist_head watch_sb;
+#endif
 #ifdef CONFIG_WATCH_QUEUE
 	struct hlist_head post_notification;
 #endif /* CONFIG_WATCH_QUEUE */
diff --git a/include/linux/security.h b/include/linux/security.h
index 910a1efa9a79..2ca2569bc12c 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1306,6 +1306,22 @@ static inline int security_post_notification(const struct cred *w_cred,
 	return 0;
 }
 #endif
+#if defined(CONFIG_SECURITY) && defined(CONFIG_MOUNT_NOTIFICATIONS)
+int security_watch_mount(struct watch *watch, struct path *path);
+#else
+static inline int security_watch_mount(struct watch *watch, struct path *path)
+{
+	return 0;
+}
+#endif
+#if defined(CONFIG_SECURITY) && defined(CONFIG_SB_NOTIFICATIONS)
+int security_watch_sb(struct watch *watch, struct super_block *sb);
+#else
+static inline int security_watch_sb(struct watch *watch, struct super_block *sb)
+{
+	return 0;
+}
+#endif
 
 #ifdef CONFIG_SECURITY_NETWORK
 
diff --git a/security/security.c b/security/security.c
index db7b574c9c70..5c0463444a90 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2004,6 +2004,20 @@ int security_watch_key(struct key *key)
 }
 #endif
 
+#ifdef CONFIG_MOUNT_NOTIFICATIONS
+int security_watch_mount(struct watch *watch, struct path *path)
+{
+	return call_int_hook(watch_mount, 0, watch, path);
+}
+#endif
+
+#ifdef CONFIG_SB_NOTIFICATIONS
+int security_watch_sb(struct watch *watch, struct super_block *sb)
+{
+	return call_int_hook(watch_sb, 0, watch, sb);
+}
+#endif
+
 #ifdef CONFIG_DEVICE_NOTIFICATIONS
 int security_watch_devices(void)
 {


