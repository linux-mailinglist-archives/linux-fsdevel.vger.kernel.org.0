Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF47A95EF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2019 00:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730547AbfIDWQR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Sep 2019 18:16:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49982 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727722AbfIDWQR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Sep 2019 18:16:17 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2140718C4284;
        Wed,  4 Sep 2019 22:16:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-255.rdu2.redhat.com [10.10.120.255])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2F1E15C207;
        Wed,  4 Sep 2019 22:16:13 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 03/11] security: Add a hook for the point of notification
 insertion [ver #8]
From:   David Howells <dhowells@redhat.com>
To:     keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     dhowells@redhat.com, torvalds@linux-foundation.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        nicolas.dichtel@6wind.com, raven@themaw.net,
        Christian Brauner <christian@brauner.io>, dhowells@redhat.com,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 04 Sep 2019 23:16:12 +0100
Message-ID: <156763537237.18676.12991040129330701275.stgit@warthog.procyon.org.uk>
In-Reply-To: <156763534546.18676.3530557439501101639.stgit@warthog.procyon.org.uk>
References: <156763534546.18676.3530557439501101639.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.62]); Wed, 04 Sep 2019 22:16:16 +0000 (UTC)
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
index b0cdefcda4e6..257d803dcf6f 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1424,6 +1424,12 @@
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
@@ -1706,6 +1712,11 @@ union security_list_options {
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
@@ -1988,6 +1999,9 @@ struct security_hook_heads {
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
index 3be44354d308..24c54b9ff0a1 100644
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
@@ -1222,6 +1224,18 @@ static inline int security_watch_devices(void)
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
 
@@ -1847,4 +1861,3 @@ static inline void security_bpf_prog_free(struct bpf_prog_aux *aux)
 #endif /* CONFIG_BPF_SYSCALL */
 
 #endif /* ! __LINUX_SECURITY_H */
-
diff --git a/security/security.c b/security/security.c
index 007eb48bc848..b719c5a5b2ba 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1916,6 +1916,15 @@ int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
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

