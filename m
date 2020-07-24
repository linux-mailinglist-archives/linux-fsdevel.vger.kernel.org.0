Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F19622C5E4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jul 2020 15:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbgGXNLv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jul 2020 09:11:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36571 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726953AbgGXNLv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jul 2020 09:11:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595596309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rnmF7PFcUQLOvfsrRmGZL1mkv1G/Vz60+pFjt89D08Q=;
        b=KRyeGw1Dzmw9udGupSCXZwPxU5XBdXYmjkD94fCnLgouEGw+hL4gdOzy7K0UEZr15ISWEY
        RwpExwnmw4Ex2kjZO7s2ka8ERXyXEUfh+WSKXvZRWOmEtvcEnXM4sAZIcvU7LQGTahxpdE
        Xt7+MKc0bTQJ+0tmj/8uS/JhocK0MuI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-x6wJTfzIPnaOwAa8-oZBnQ-1; Fri, 24 Jul 2020 09:11:45 -0400
X-MC-Unique: x6wJTfzIPnaOwAa8-oZBnQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1350800460;
        Fri, 24 Jul 2020 13:11:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-32.rdu2.redhat.com [10.10.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 22D4987B05;
        Fri, 24 Jul 2020 13:11:40 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 2/4] watch_queue: Add security hooks to rule on setting mount
 watches
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     James Morris <jamorris@linux.microsoft.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-security-module@vger.kernel.org, dhowells@redhat.com,
        torvalds@linux-foundation.org, casey@schaufler-ca.com,
        sds@tycho.nsa.gov, nicolas.dichtel@6wind.com, raven@themaw.net,
        christian@brauner.io, jlayton@redhat.com, kzak@redhat.com,
        mszeredi@redhat.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 24 Jul 2020 14:11:40 +0100
Message-ID: <159559630034.2141315.7836099179446814699.stgit@warthog.procyon.org.uk>
In-Reply-To: <159559628247.2141315.2107013106060144287.stgit@warthog.procyon.org.uk>
References: <159559628247.2141315.2107013106060144287.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a security hook that will allow an LSM to rule on whether or not a
watch may be set on a mount.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: James Morris <jamorris@linux.microsoft.com>
cc: Casey Schaufler <casey@schaufler-ca.com>
cc: Stephen Smalley <sds@tycho.nsa.gov>
cc: linux-security-module@vger.kernel.org
---

 include/linux/lsm_hook_defs.h |    3 +++
 include/linux/lsm_hooks.h     |    6 ++++++
 include/linux/security.h      |    8 ++++++++
 security/security.c           |    7 +++++++
 4 files changed, 24 insertions(+)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index af998f93d256..f6eaf8bd617b 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -264,6 +264,9 @@ LSM_HOOK(int, 0, post_notification, const struct cred *w_cred,
 #if defined(CONFIG_SECURITY) && defined(CONFIG_KEY_NOTIFICATIONS)
 LSM_HOOK(int, 0, watch_key, struct key *key)
 #endif /* CONFIG_SECURITY && CONFIG_KEY_NOTIFICATIONS */
+#ifdef CONFIG_MOUNT_NOTIFICATIONS
+LSM_HOOK(int, 0, watch_mount, struct watch *watch, struct path *path)
+#endif
 
 #ifdef CONFIG_SECURITY_NETWORK
 LSM_HOOK(int, 0, unix_stream_connect, struct sock *sock, struct sock *other,
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 95b7c1d32062..56275145b91d 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1468,6 +1468,12 @@
  *	from a key or keyring.
  *	@key: The key to watch.
  *
+ * @watch_mount:
+ *	Check to see if a process is allowed to watch for mount topology change
+ *	notifications on a mount subtree.
+ *	@watch: The watch object
+ *	@path: The root of the subtree to watch.
+ *
  * Security hooks for using the eBPF maps and programs functionalities through
  * eBPF syscalls.
  *
diff --git a/include/linux/security.h b/include/linux/security.h
index 0a0a03b36a3b..318fdfe7f4d6 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1314,6 +1314,14 @@ static inline int security_watch_key(struct key *key)
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
 
 #ifdef CONFIG_SECURITY_NETWORK
 
diff --git a/security/security.c b/security/security.c
index 70a7ad357bc6..3cdf5039f727 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2067,6 +2067,13 @@ int security_watch_key(struct key *key)
 }
 #endif
 
+#ifdef CONFIG_MOUNT_NOTIFICATIONS
+int security_watch_mount(struct watch *watch, struct path *path)
+{
+	return call_int_hook(watch_mount, 0, watch, path);
+}
+#endif
+
 #ifdef CONFIG_SECURITY_NETWORK
 
 int security_unix_stream_connect(struct sock *sock, struct sock *other, struct sock *newsk)


