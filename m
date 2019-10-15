Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6919AD830A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2019 23:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389046AbfJOVvC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Oct 2019 17:51:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53500 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732397AbfJOVvC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Oct 2019 17:51:02 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7BF3F2A09B7;
        Tue, 15 Oct 2019 21:51:01 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-84.rdu2.redhat.com [10.10.121.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E04EA60A97;
        Tue, 15 Oct 2019 21:50:58 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 21/21] smack: Implement the watch_key and
 post_notification hooks
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
Date:   Tue, 15 Oct 2019 22:50:58 +0100
Message-ID: <157117625816.15019.16199730634258730255.stgit@warthog.procyon.org.uk>
In-Reply-To: <157117606853.15019.15459271147790470307.stgit@warthog.procyon.org.uk>
References: <157117606853.15019.15459271147790470307.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Tue, 15 Oct 2019 21:51:01 +0000 (UTC)
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
 security/smack/smack_lsm.c |   82 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 82 insertions(+), 1 deletion(-)

diff --git a/include/linux/lsm_audit.h b/include/linux/lsm_audit.h
index 915330abf6e5..734d67889826 100644
--- a/include/linux/lsm_audit.h
+++ b/include/linux/lsm_audit.h
@@ -74,6 +74,7 @@ struct common_audit_data {
 #define LSM_AUDIT_DATA_FILE	12
 #define LSM_AUDIT_DATA_IBPKEY	13
 #define LSM_AUDIT_DATA_IBENDPORT 14
+#define LSM_AUDIT_DATA_NOTIFICATION 15
 	union 	{
 		struct path path;
 		struct dentry *dentry;
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index ecea41ce919b..71b6f37d49c1 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4273,7 +4273,7 @@ static int smack_key_permission(key_ref_t key_ref,
 	if (tkp == NULL)
 		return -EACCES;
 
-	if (smack_privileged_cred(CAP_MAC_OVERRIDE, cred))
+	if (smack_privileged(CAP_MAC_OVERRIDE))
 		return 0;
 
 #ifdef CONFIG_AUDIT
@@ -4319,8 +4319,81 @@ static int smack_key_getsecurity(struct key *key, char **_buffer)
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
@@ -4709,8 +4782,15 @@ static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
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

