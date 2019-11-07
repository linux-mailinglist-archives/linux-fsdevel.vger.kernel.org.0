Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48C97F2FE6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2019 14:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388783AbfKGNhk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Nov 2019 08:37:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41270 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731056AbfKGNhk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Nov 2019 08:37:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573133859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vModMaExKzPyatIlo+9SWLkezhO2DwCfI4t3f2wYBPY=;
        b=SVQVZ3S5zplDonhGHexKvkHD5FIhPr6RB8dZeIYQp66I/UJ2XuQkpirNQwA7A/ncFA9ZWO
        hXBMamjk+vw1HDNAPI/fzY3o1f9dr5TM1nvumykxftK3l3n3nFjZWybWBZ2F/SGCpwTqep
        8LE5CaUTnttS5l8vmhvv18sRXdbuhcI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-_HSEua-AM3KNXwOf-qBRAA-1; Thu, 07 Nov 2019 08:37:36 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 28349107ACC3;
        Thu,  7 Nov 2019 13:37:34 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-254.rdu2.redhat.com [10.10.120.254])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3746A194B2;
        Thu,  7 Nov 2019 13:37:31 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 14/14] smack: Implement the watch_key and
 post_notification hooks [ver #2]
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
Date:   Thu, 07 Nov 2019 13:37:30 +0000
Message-ID: <157313385046.29677.1508444632181965475.stgit@warthog.procyon.org.uk>
In-Reply-To: <157313371694.29677.15388731274912671071.stgit@warthog.procyon.org.uk>
References: <157313371694.29677.15388731274912671071.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: _HSEua-AM3KNXwOf-qBRAA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
 security/smack/smack_lsm.c |   82 ++++++++++++++++++++++++++++++++++++++++=
+++-
 2 files changed, 82 insertions(+), 1 deletion(-)

diff --git a/include/linux/lsm_audit.h b/include/linux/lsm_audit.h
index 915330abf6e5..734d67889826 100644
--- a/include/linux/lsm_audit.h
+++ b/include/linux/lsm_audit.h
@@ -74,6 +74,7 @@ struct common_audit_data {
 #define LSM_AUDIT_DATA_FILE=0912
 #define LSM_AUDIT_DATA_IBPKEY=0913
 #define LSM_AUDIT_DATA_IBENDPORT 14
+#define LSM_AUDIT_DATA_NOTIFICATION 15
 =09union =09{
 =09=09struct path path;
 =09=09struct dentry *dentry;
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index ecea41ce919b..71b6f37d49c1 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4273,7 +4273,7 @@ static int smack_key_permission(key_ref_t key_ref,
 =09if (tkp =3D=3D NULL)
 =09=09return -EACCES;
=20
-=09if (smack_privileged_cred(CAP_MAC_OVERRIDE, cred))
+=09if (smack_privileged(CAP_MAC_OVERRIDE))
 =09=09return 0;
=20
 #ifdef CONFIG_AUDIT
@@ -4319,8 +4319,81 @@ static int smack_key_getsecurity(struct key *key, ch=
ar **_buffer)
 =09return length;
 }
=20
+
+#ifdef CONFIG_KEY_NOTIFICATIONS
+/**
+ * smack_watch_key - Smack access to watch a key for notifications.
+ * @key: The key to be watched
+ *
+ * Return 0 if the @watch->cred has permission to read from the key object=
 and
+ * an error otherwise.
+ */
+static int smack_watch_key(struct key *key)
+{
+=09struct smk_audit_info ad;
+=09struct smack_known *tkp =3D smk_of_current();
+=09int rc;
+
+=09if (key =3D=3D NULL)
+=09=09return -EINVAL;
+=09/*
+=09 * If the key hasn't been initialized give it access so that
+=09 * it may do so.
+=09 */
+=09if (key->security =3D=3D NULL)
+=09=09return 0;
+=09/*
+=09 * This should not occur
+=09 */
+=09if (tkp =3D=3D NULL)
+=09=09return -EACCES;
+
+=09if (smack_privileged_cred(CAP_MAC_OVERRIDE, current_cred()))
+=09=09return 0;
+
+#ifdef CONFIG_AUDIT
+=09smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_KEY);
+=09ad.a.u.key_struct.key =3D key->serial;
+=09ad.a.u.key_struct.key_desc =3D key->description;
+#endif
+=09rc =3D smk_access(tkp, key->security, MAY_READ, &ad);
+=09rc =3D smk_bu_note("key watch", tkp, key->security, MAY_READ, rc);
+=09return rc;
+}
+#endif /* CONFIG_KEY_NOTIFICATIONS */
 #endif /* CONFIG_KEYS */
=20
+#ifdef CONFIG_WATCH_QUEUE
+/**
+ * smack_post_notification - Smack access to post a notification to a queu=
e
+ * @w_cred: The credentials of the watcher.
+ * @cred: The credentials of the event source (may be NULL).
+ * @n: The notification message to be posted.
+ */
+static int smack_post_notification(const struct cred *w_cred,
+=09=09=09=09   const struct cred *cred,
+=09=09=09=09   struct watch_notification *n)
+{
+=09struct smk_audit_info ad;
+=09struct smack_known *subj, *obj;
+=09int rc;
+
+=09/* Always let maintenance notifications through. */
+=09if (n->type =3D=3D WATCH_TYPE_META)
+=09=09return 0;
+
+=09if (!cred)
+=09=09return 0;
+=09subj =3D smk_of_task(smack_cred(cred));
+=09obj =3D smk_of_task(smack_cred(w_cred));
+
+=09smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_NOTIFICATION);
+=09rc =3D smk_access(subj, obj, MAY_WRITE, &ad);
+=09rc =3D smk_bu_note("notification", subj, obj, MAY_WRITE, rc);
+=09return rc;
+}
+#endif /* CONFIG_WATCH_QUEUE */
+
 /*
  * Smack Audit hooks
  *
@@ -4709,8 +4782,15 @@ static struct security_hook_list smack_hooks[] __lsm=
_ro_after_init =3D {
 =09LSM_HOOK_INIT(key_free, smack_key_free),
 =09LSM_HOOK_INIT(key_permission, smack_key_permission),
 =09LSM_HOOK_INIT(key_getsecurity, smack_key_getsecurity),
+#ifdef CONFIG_KEY_NOTIFICATIONS
+=09LSM_HOOK_INIT(watch_key, smack_watch_key),
+#endif
 #endif /* CONFIG_KEYS */
=20
+#ifdef CONFIG_WATCH_QUEUE
+=09LSM_HOOK_INIT(post_notification, smack_post_notification),
+#endif
+
  /* Audit hooks */
 #ifdef CONFIG_AUDIT
 =09LSM_HOOK_INIT(audit_rule_init, smack_audit_rule_init),

