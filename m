Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 282B513C2E2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 14:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729057AbgAONbQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 08:31:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41974 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729122AbgAONbP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 08:31:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579095073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sdalmPdPxMEBu8xBz15QUCyI0CxOdrt6XvQLFxdky0s=;
        b=h2zYrCicPjBAhAi7LQP9ry9JcghB9qFs1DmAzuuk5XFeK088mj0TlCR8AIieaLRKY6Tloa
        bGFEPZ86dDPkJagOiyXV/653IBe6/F5lqoBSsRk1lxGsjKBzXTvRYobd+oDqvJNx7YDGUt
        aCPFRXGJ1D/8KOxhXWuhlUF68X/kpkM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-u2-HHscHNP6QHwUvOgoOFg-1; Wed, 15 Jan 2020 08:31:10 -0500
X-MC-Unique: u2-HHscHNP6QHwUvOgoOFg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B15D71005516;
        Wed, 15 Jan 2020 13:31:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-52.rdu2.redhat.com [10.10.120.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 66C0910372F3;
        Wed, 15 Jan 2020 13:31:03 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 03/14] security: Add a hook for the point of
 notification insertion [ver #3]
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
Date:   Wed, 15 Jan 2020 13:31:02 +0000
Message-ID: <157909506262.20155.1543413154684187380.stgit@warthog.procyon.org.uk>
In-Reply-To: <157909503552.20155.3030058841911628518.stgit@warthog.procyon.org.uk>
References: <157909503552.20155.3030058841911628518.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
index 8f2fa100d128..e03ee1164268 100644
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
@@ -1290,6 +1292,18 @@ static inline int security_watch_devices(void)
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
index 578863f230a6..9c1878a7fadf 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1956,6 +1956,15 @@ int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
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

