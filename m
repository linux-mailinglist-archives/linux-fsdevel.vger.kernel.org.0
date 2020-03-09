Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF9317DFBE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2020 13:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgCIMRu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Mar 2020 08:17:50 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:30309 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726622AbgCIMRt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Mar 2020 08:17:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583756268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yz4hc0/XOFV20u36GthyXDkgpvfQTUeH550vAHUvCEw=;
        b=cdzFMF3JFyT5dkcDDNJXiLmVRJjpdZ6QDiT06HmNTBe03PcRD7cXvqhn5RRkMX4uFxA59X
        q54PWY5h99JhmmrxSnbGbjqCKxEV2QEDp7k0s/7PRKcMmBj7hEBVGSNX93DXV2zdxiVILX
        8Pv9mK3c33u7nNfG/9nOv2P20/n2OuM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-IayPkVwbN6ikGY7tWJwcLA-1; Mon, 09 Mar 2020 08:17:46 -0400
X-MC-Unique: IayPkVwbN6ikGY7tWJwcLA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 748991005513;
        Mon,  9 Mar 2020 12:17:44 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-182.rdu2.redhat.com [10.10.120.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A9ABE7389F;
        Mon,  9 Mar 2020 12:17:41 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 03/17] security: Add a hook for the point of notification
 insertion [ver #4]
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-security-module@vger.kernel.org, dhowells@redhat.com,
        dhowells@redhat.com, casey@schaufler-ca.com, sds@tycho.nsa.gov,
        nicolas.dichtel@6wind.com, raven@themaw.net, christian@brauner.io,
        andres@anarazel.de, jlayton@redhat.com, dray@redhat.com,
        kzak@redhat.com, keyrings@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 09 Mar 2020 12:17:41 +0000
Message-ID: <158375626100.334846.3654197678658672620.stgit@warthog.procyon.org.uk>
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
 include/linux/security.h  |   14 ++++++++++++++
 security/security.c       |    9 +++++++++
 3 files changed, 37 insertions(+)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 79d7c73676d7..16530255dc11 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1427,6 +1427,12 @@
  *	Check to see if a process is allowed to watch for event notifications
  *	from devices (as a global set).
  *
+ * @post_notification:
+ *	Check to see if a watch notification can be posted to a particular
+ *	queue.
+ *	@w_cred: The credentials of the whoever set the watch.
+ *	@cred: The event-triggerer's credentials
+ *	@n: The notification being posted
  *
  * Security hooks for using the eBPF maps and programs functionalities through
  * eBPF syscalls.
@@ -1716,6 +1722,11 @@ union security_list_options {
 #ifdef CONFIG_DEVICE_NOTIFICATIONS
 	int (*watch_devices)(void);
 #endif
+#ifdef CONFIG_WATCH_QUEUE
+	int (*post_notification)(const struct cred *w_cred,
+				 const struct cred *cred,
+				 struct watch_notification *n);
+#endif
 
 #ifdef CONFIG_SECURITY_NETWORK
 	int (*unix_stream_connect)(struct sock *sock, struct sock *other,
@@ -2009,6 +2020,9 @@ struct security_hook_heads {
 #ifdef CONFIG_DEVICE_NOTIFICATIONS
 	struct hlist_head watch_devices;
 #endif
+#ifdef CONFIG_WATCH_QUEUE
+	struct hlist_head post_notification;
+#endif /* CONFIG_WATCH_QUEUE */
 #ifdef CONFIG_SECURITY_NETWORK
 	struct hlist_head unix_stream_connect;
 	struct hlist_head unix_may_send;
diff --git a/include/linux/security.h b/include/linux/security.h
index 7a36064a64ea..910a1efa9a79 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -57,6 +57,8 @@ struct mm_struct;
 struct fs_context;
 struct fs_parameter;
 enum fs_value_type;
+struct watch;
+struct watch_notification;
 
 /* Default (no) options for the capable function */
 #define CAP_OPT_NONE 0x0
@@ -1292,6 +1294,18 @@ static inline int security_watch_devices(void)
 	return 0;
 }
 #endif
+#if defined(CONFIG_SECURITY) && defined(CONFIG_WATCH_QUEUE)
+int security_post_notification(const struct cred *w_cred,
+			       const struct cred *cred,
+			       struct watch_notification *n);
+#else
+static inline int security_post_notification(const struct cred *w_cred,
+					     const struct cred *cred,
+					     struct watch_notification *n)
+{
+	return 0;
+}
+#endif
 
 #ifdef CONFIG_SECURITY_NETWORK
 
diff --git a/security/security.c b/security/security.c
index 22877f47cf62..db7b574c9c70 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1988,6 +1988,15 @@ int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
 }
 EXPORT_SYMBOL(security_inode_getsecctx);
 
+#ifdef CONFIG_WATCH_QUEUE
+int security_post_notification(const struct cred *w_cred,
+			       const struct cred *cred,
+			       struct watch_notification *n)
+{
+	return call_int_hook(post_notification, 0, w_cred, cred, n);
+}
+#endif /* CONFIG_WATCH_QUEUE */
+
 #ifdef CONFIG_KEY_NOTIFICATIONS
 int security_watch_key(struct key *key)
 {


