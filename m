Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA2738C90
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2019 16:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729345AbfFGOSM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jun 2019 10:18:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50614 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728684AbfFGOSM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jun 2019 10:18:12 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5C611308339B;
        Fri,  7 Jun 2019 14:18:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-173.rdu2.redhat.com [10.10.120.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DE39F842A8;
        Fri,  7 Jun 2019 14:17:59 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 04/13] security: Add a hook for the point of notification
 insertion [ver #4]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-security-module@vger.kernel.org, dhowells@redhat.com,
        raven@themaw.net, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-block@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 07 Jun 2019 15:17:59 +0100
Message-ID: <155991707918.15579.12255928917117357405.stgit@warthog.procyon.org.uk>
In-Reply-To: <155991702981.15579.6007568669839441045.stgit@warthog.procyon.org.uk>
References: <155991702981.15579.6007568669839441045.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Fri, 07 Jun 2019 14:18:11 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a security hook that allows an LSM to rule on whether a notification
message is allowed to be inserted into a particular watch queue.

The hook is given the following information:

 (1) The credentials of the triggerer (which may be init_cred for a system
     notification, eg. a hardware error).

 (2) The credentials of the creator of the watch buffer.

 (3) The notification message.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Casey Schaufler <casey@schaufler-ca.com>
cc: Stephen Smalley <sds@tycho.nsa.gov>
cc: linux-security-module@vger.kernel.org
---

 include/linux/lsm_hooks.h |   10 ++++++++++
 include/linux/security.h  |   10 ++++++++++
 security/security.c       |    6 ++++++
 3 files changed, 26 insertions(+)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 0543449c0f6e..94fb6067fed5 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1445,6 +1445,12 @@
  *	from devices (as a global set).
  *	@watch: The watch object
  *
+ * @post_notification:
+ *	Check to see if a watch notification can be posted to a particular
+ *	queue.
+ *	@q_cred: The credentials of the target watch queue.
+ *	@cred: The event-triggerer's credentials
+ *	@n: The notification being posted
  *
  * Security hooks for using the eBPF maps and programs functionalities through
  * eBPF syscalls.
@@ -1729,6 +1735,9 @@ union security_list_options {
 	int (*watch_sb)(struct watch *watch, struct super_block *sb);
 	int (*watch_key)(struct watch *watch, struct key *key);
 	int (*watch_devices)(struct watch *watch);
+	int (*post_notification)(const struct cred *q_cred,
+				 const struct cred *cred,
+				 struct watch_notification *n);
 #endif /* CONFIG_WATCH_QUEUE */
 
 #ifdef CONFIG_SECURITY_NETWORK
@@ -2014,6 +2023,7 @@ struct security_hook_heads {
 	struct hlist_head watch_sb;
 	struct hlist_head watch_key;
 	struct hlist_head watch_devices;
+	struct hlist_head post_notification;
 #endif /* CONFIG_WATCH_QUEUE */
 #ifdef CONFIG_SECURITY_NETWORK
 	struct hlist_head unix_stream_connect;
diff --git a/include/linux/security.h b/include/linux/security.h
index ac3bf6b5f87b..ed301edeaa19 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -59,6 +59,7 @@ struct fs_parameter;
 enum fs_value_type;
 struct fsinfo_kparams;
 struct watch;
+struct watch_notification;
 
 /* Default (no) options for the capable function */
 #define CAP_OPT_NONE 0x0
@@ -402,6 +403,9 @@ int security_watch_mount(struct watch *watch, struct path *path);
 int security_watch_sb(struct watch *watch, struct super_block *sb);
 int security_watch_key(struct watch *watch, struct key *key);
 int security_watch_devices(struct watch *watch);
+int security_post_notification(const struct cred *q_cred,
+			       const struct cred *cred,
+			       struct watch_notification *n);
 #endif /* CONFIG_WATCH_QUEUE */
 #else /* CONFIG_SECURITY */
 
@@ -1239,6 +1243,12 @@ static inline int security_watch_devices(struct watch *watch)
 {
 	return 0;
 }
+static inline int security_post_notification(const struct cred *q_cred,
+					     const struct cred *cred,
+					     struct watch_notification *n)
+{
+	return 0;
+}
 #endif /* CONFIG_WATCH_QUEUE */
 #endif	/* CONFIG_SECURITY */
 
diff --git a/security/security.c b/security/security.c
index ee2f8539a0d5..8a04ac74b4fe 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1950,6 +1950,12 @@ int security_watch_devices(struct watch *watch)
 	return call_int_hook(watch_devices, 0, watch);
 }
 
+int security_post_notification(const struct cred *q_cred,
+			       const struct cred *cred,
+			       struct watch_notification *n)
+{
+	return call_int_hook(post_notification, 0, q_cred, cred, n);
+}
 #endif /* CONFIG_WATCH_QUEUE */
 
 #ifdef CONFIG_SECURITY_NETWORK

