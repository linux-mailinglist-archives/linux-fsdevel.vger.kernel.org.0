Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0A3D189EDD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Mar 2020 16:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbgCRPFK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Mar 2020 11:05:10 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:54065 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726866AbgCRPFK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Mar 2020 11:05:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584543908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0/CnksCBsQwZug6TofMO/DlPDAR/X0sM7NiA63phxVA=;
        b=M9mAI3LMMeGttjbbciDefg08YYZAGyd8tAlqSyq1XkyH6s6DZ7Iz9n5kB9a16bHlfYBsk8
        It2OLh3kPpv5axYv3N2TQ38JQNz41zh9wZd6gjsB8OLtzY2kA0Qd348qyCG0QmPOTxSN3F
        f2aWV9egWHhounuiBiDQjTGuoJ/Y7ZA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-Fr6f5LQLNMen6nFAOfePkw-1; Wed, 18 Mar 2020 11:05:00 -0400
X-MC-Unique: Fr6f5LQLNMen6nFAOfePkw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AAA7C801E6C;
        Wed, 18 Mar 2020 15:04:58 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-113-126.rdu2.redhat.com [10.10.113.126])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AE0F719C58;
        Wed, 18 Mar 2020 15:04:55 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 11/17] smack: Implement the watch_key and post_notification
 hooks [ver #5]
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk
Cc:     Casey Schaufler <casey@schaufler-ca.com>, dhowells@redhat.com,
        casey@schaufler-ca.com, sds@tycho.nsa.gov,
        nicolas.dichtel@6wind.com, raven@themaw.net, christian@brauner.io,
        andres@anarazel.de, jlayton@redhat.com, dray@redhat.com,
        kzak@redhat.com, keyrings@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 18 Mar 2020 15:04:55 +0000
Message-ID: <158454389492.2863966.1081946626597156477.stgit@warthog.procyon.org.uk>
In-Reply-To: <158454378820.2863966.10496767254293183123.stgit@warthog.procyon.org.uk>
References: <158454378820.2863966.10496767254293183123.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Implement the watch_key security hook in Smack to make sure that a key
grants the caller Read permission in order to set a watch on a key.

Also implement the post_notification security hook to make sure that the
notification source is granted Write permission by the watch queue.

For the moment, the watch_devices security hook is left unimplemented as
it's not obvious what the object should be since the queue is global and
didn't previously exist.

Signed-off-by: David Howells <dhowells@redhat.com>
Acked-by: Casey Schaufler <casey@schaufler-ca.com>
---

 include/linux/lsm_audit.h  |    1 +
 security/smack/smack_lsm.c |   83 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 83 insertions(+), 1 deletion(-)

diff --git a/include/linux/lsm_audit.h b/include/linux/lsm_audit.h
index 99d629fd9944..28f23b341c1c 100644
--- a/include/linux/lsm_audit.h
+++ b/include/linux/lsm_audit.h
@@ -75,6 +75,7 @@ struct common_audit_data {
 #define LSM_AUDIT_DATA_IBPKEY	13
 #define LSM_AUDIT_DATA_IBENDPORT 14
 #define LSM_AUDIT_DATA_LOCKDOWN 15
+#define LSM_AUDIT_DATA_NOTIFICATION 16
 	union 	{
 		struct path path;
 		struct dentry *dentry;
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 8c61d175e195..2862fc383473 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -41,6 +41,7 @@
 #include <linux/parser.h>
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
+#include <linux/watch_queue.h>
 #include "smack.h"
 
 #define TRANS_TRUE	"TRUE"
@@ -4265,7 +4266,7 @@ static int smack_key_permission(key_ref_t key_ref,
 	if (tkp == NULL)
 		return -EACCES;
 
-	if (smack_privileged_cred(CAP_MAC_OVERRIDE, cred))
+	if (smack_privileged(CAP_MAC_OVERRIDE))
 		return 0;
 
 #ifdef CONFIG_AUDIT
@@ -4311,8 +4312,81 @@ static int smack_key_getsecurity(struct key *key, char **_buffer)
 	return length;
 }
 
+
+#ifdef CONFIG_KEY_NOTIFICATIONS
+/**
+ * smack_watch_key - Smack access to watch a key for notifications.
+ * @key: The key to be watched
+ *
+ * Return 0 if the @watch->cred has permission to read from the key object and
+ * an error otherwise.
+ */
+static int smack_watch_key(struct key *key)
+{
+	struct smk_audit_info ad;
+	struct smack_known *tkp = smk_of_current();
+	int rc;
+
+	if (key == NULL)
+		return -EINVAL;
+	/*
+	 * If the key hasn't been initialized give it access so that
+	 * it may do so.
+	 */
+	if (key->security == NULL)
+		return 0;
+	/*
+	 * This should not occur
+	 */
+	if (tkp == NULL)
+		return -EACCES;
+
+	if (smack_privileged_cred(CAP_MAC_OVERRIDE, current_cred()))
+		return 0;
+
+#ifdef CONFIG_AUDIT
+	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_KEY);
+	ad.a.u.key_struct.key = key->serial;
+	ad.a.u.key_struct.key_desc = key->description;
+#endif
+	rc = smk_access(tkp, key->security, MAY_READ, &ad);
+	rc = smk_bu_note("key watch", tkp, key->security, MAY_READ, rc);
+	return rc;
+}
+#endif /* CONFIG_KEY_NOTIFICATIONS */
 #endif /* CONFIG_KEYS */
 
+#ifdef CONFIG_WATCH_QUEUE
+/**
+ * smack_post_notification - Smack access to post a notification to a queue
+ * @w_cred: The credentials of the watcher.
+ * @cred: The credentials of the event source (may be NULL).
+ * @n: The notification message to be posted.
+ */
+static int smack_post_notification(const struct cred *w_cred,
+				   const struct cred *cred,
+				   struct watch_notification *n)
+{
+	struct smk_audit_info ad;
+	struct smack_known *subj, *obj;
+	int rc;
+
+	/* Always let maintenance notifications through. */
+	if (n->type == WATCH_TYPE_META)
+		return 0;
+
+	if (!cred)
+		return 0;
+	subj = smk_of_task(smack_cred(cred));
+	obj = smk_of_task(smack_cred(w_cred));
+
+	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_NOTIFICATION);
+	rc = smk_access(subj, obj, MAY_WRITE, &ad);
+	rc = smk_bu_note("notification", subj, obj, MAY_WRITE, rc);
+	return rc;
+}
+#endif /* CONFIG_WATCH_QUEUE */
+
 /*
  * Smack Audit hooks
  *
@@ -4701,8 +4775,15 @@ static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(key_free, smack_key_free),
 	LSM_HOOK_INIT(key_permission, smack_key_permission),
 	LSM_HOOK_INIT(key_getsecurity, smack_key_getsecurity),
+#ifdef CONFIG_KEY_NOTIFICATIONS
+	LSM_HOOK_INIT(watch_key, smack_watch_key),
+#endif
 #endif /* CONFIG_KEYS */
 
+#ifdef CONFIG_WATCH_QUEUE
+	LSM_HOOK_INIT(post_notification, smack_post_notification),
+#endif
+
  /* Audit hooks */
 #ifdef CONFIG_AUDIT
 	LSM_HOOK_INIT(audit_rule_init, smack_audit_rule_init),


