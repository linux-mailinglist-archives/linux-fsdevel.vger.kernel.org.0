Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5308222CFD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 22:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgGPUfh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 16:35:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51425 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726167AbgGPUf1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 16:35:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594931725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MA2zTmLbYOvlJ63Y/TrUWnikoLb+7ScXgVhmHlwKe8M=;
        b=Vvll/QjolsyGzBgie2WFdmYFPstEhB9hilz0GuQLd0AIUDJ+ewT/odNvOd9HyDKE6Bc1Ta
        glTBwPitPZpJ9SOfAwK0QpA0flqecGBTiig5C9MsbY7StQgbw5INzQzXbdoTzkAHbKBXTo
        mdJUU8ppSNRjZ3XTIAnJG3GBhZ2u8MY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-NGli0yJJN46cvpRhHGDfRA-1; Thu, 16 Jul 2020 16:35:21 -0400
X-MC-Unique: NGli0yJJN46cvpRhHGDfRA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A95F7100526A;
        Thu, 16 Jul 2020 20:35:19 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-113.rdu2.redhat.com [10.10.112.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 74B7E5C1C3;
        Thu, 16 Jul 2020 20:35:15 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 3/5] keys: Provide KEYCTL_GRANT_PERMISSION
From:   David Howells <dhowells@redhat.com>
To:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Cc:     dhowells@redhat.com,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Eric Biederman <ebiederm@xmission.com>, jlayton@redhat.com,
        christian@brauner.io, selinux@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, containers@lists.linux-foundation.org
Date:   Thu, 16 Jul 2020 21:35:14 +0100
Message-ID: <159493171464.3249370.14298001109518163029.stgit@warthog.procyon.org.uk>
In-Reply-To: <159493167778.3249370.8145886688150701997.stgit@warthog.procyon.org.uk>
References: <159493167778.3249370.8145886688150701997.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.22
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Provide a keyctl() operation to grant/remove permissions.  The grant
operation, wrapped by libkeyutils, looks like:

	int ret = keyctl_grant_permission(key_serial_t key,
					  enum key_ace_subject_type type,
					  unsigned int subject,
					  unsigned int perm);

Where key is the key to be modified, type and subject represent the subject
to which permission is to be granted (or removed) and perm is the set of
permissions to be granted.  0 is returned on success.  SETSEC permission is
required for this.

The subject type currently must be KEY_ACE_SUBJ_STANDARD for the moment
(other subject types will come along later).

For subject type KEY_ACE_SUBJ_STANDARD, the following subject values are
available:

	KEY_ACE_POSSESSOR	The possessor of the key
	KEY_ACE_OWNER		The owner of the key
	KEY_ACE_GROUP		The key's group
	KEY_ACE_EVERYONE	Everyone

perm lists the permissions to be granted:

	KEY_ACE_VIEW		Can view the key metadata
	KEY_ACE_READ		Can read the key content
	KEY_ACE_WRITE		Can update/modify the key content
	KEY_ACE_SEARCH		Can find the key by searching/requesting
	KEY_ACE_LINK		Can make a link to the key
	KEY_ACE_SETSEC		Can set security
	KEY_ACE_INVAL		Can invalidate
	KEY_ACE_REVOKE		Can revoke
	KEY_ACE_JOIN		Can join this keyring
	KEY_ACE_CLEAR		Can clear this keyring

If an ACE already exists for the subject, then the permissions mask will be
overwritten; if perm is 0, it will be deleted.

Currently, the internal ACL is limited to a maximum of 16 entries.

For example:

	int ret = keyctl_grant_permission(key,
					  KEY_ACE_SUBJ_STANDARD,
					  KEY_ACE_OWNER,
					  KEY_ACE_VIEW | KEY_ACE_READ);

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/uapi/linux/keyctl.h |    2 +
 security/keys/compat.c      |    2 +
 security/keys/internal.h    |    5 ++
 security/keys/keyctl.c      |    8 +++
 security/keys/permission.c  |  120 +++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 136 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/keyctl.h b/include/uapi/linux/keyctl.h
index 998d4e50bd41..a5938f2c3e66 100644
--- a/include/uapi/linux/keyctl.h
+++ b/include/uapi/linux/keyctl.h
@@ -133,6 +133,7 @@ enum key_ace_standard_subject {
 #define KEYCTL_MOVE			30	/* Move keys between keyrings */
 #define KEYCTL_CAPABILITIES		31	/* Find capabilities of keyrings subsystem */
 #define KEYCTL_WATCH_KEY		32	/* Watch a key or ring of keys for changes */
+#define KEYCTL_GRANT_PERMISSION		33	/* Grant a permit to a key */
 
 /* keyctl structures */
 struct keyctl_dh_params {
@@ -196,5 +197,6 @@ struct keyctl_pkey_params {
 #define KEYCTL_CAPS1_NS_KEY_TAG		0x02 /* Key indexing can include a namespace tag */
 #define KEYCTL_CAPS1_NOTIFICATIONS	0x04 /* Keys generate watchable notifications */
 #define KEYCTL_CAPS1_ACL		0x08 /* Keys have ACLs rather than a p-u-g-o bitmask */
+#define KEYCTL_CAPS1_GRANT_PERMISSION	0x10 /* KEYCTL_GRANT_PERMISSION is supported */
 
 #endif /*  _LINUX_KEYCTL_H */
diff --git a/security/keys/compat.c b/security/keys/compat.c
index 6ee9d8f6a4a5..2b675f9a6162 100644
--- a/security/keys/compat.c
+++ b/security/keys/compat.c
@@ -152,6 +152,8 @@ COMPAT_SYSCALL_DEFINE5(keyctl, u32, option,
 
 	case KEYCTL_MOVE:
 		return keyctl_keyring_move(arg2, arg3, arg4, arg5);
+	case KEYCTL_GRANT_PERMISSION:
+		return keyctl_grant_permission(arg2, arg3, arg4, arg5);
 
 	case KEYCTL_CAPABILITIES:
 		return keyctl_capabilities(compat_ptr(arg2), arg3);
diff --git a/security/keys/internal.h b/security/keys/internal.h
index 3b2114d00d5c..af2c9531c435 100644
--- a/security/keys/internal.h
+++ b/security/keys/internal.h
@@ -377,6 +377,11 @@ static inline long keyctl_watch_key(key_serial_t key_id, int watch_fd, int watch
 }
 #endif
 
+extern long keyctl_grant_permission(key_serial_t keyid,
+				    enum key_ace_subject_type type,
+				    unsigned int subject,
+				    unsigned int perm);
+
 /*
  * Debugging key validation
  */
diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index 8689d4331285..fae2df676e30 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -39,7 +39,8 @@ static const unsigned char keyrings_capabilities[2] = {
 	[1] = (KEYCTL_CAPS1_NS_KEYRING_NAME |
 	       KEYCTL_CAPS1_NS_KEY_TAG |
 	       (IS_ENABLED(CONFIG_KEY_NOTIFICATIONS)	? KEYCTL_CAPS1_NOTIFICATIONS : 0) |
-	       KEYCTL_CAPS1_ACL
+	       KEYCTL_CAPS1_ACL |
+	       KEYCTL_CAPS1_GRANT_PERMISSION
 	       ),
 };
 
@@ -1920,6 +1921,11 @@ SYSCALL_DEFINE5(keyctl, int, option, unsigned long, arg2, unsigned long, arg3,
 					   (key_serial_t)arg3,
 					   (key_serial_t)arg4,
 					   (unsigned int)arg5);
+	case KEYCTL_GRANT_PERMISSION:
+		return keyctl_grant_permission((key_serial_t)arg2,
+					       (enum key_ace_subject_type)arg3,
+					       (unsigned int)arg4,
+					       (unsigned int)arg5);
 
 	case KEYCTL_CAPABILITIES:
 		return keyctl_capabilities((unsigned char __user *)arg2, (size_t)arg3);
diff --git a/security/keys/permission.c b/security/keys/permission.c
index 37bad810bc16..0bb7f6b695f4 100644
--- a/security/keys/permission.c
+++ b/security/keys/permission.c
@@ -380,3 +380,123 @@ long key_set_acl(struct key *key, struct key_acl *acl)
 	key_put_acl(acl);
 	return 0;
 }
+
+/*
+ * Allocate a new ACL with an extra ACE slot.
+ */
+static struct key_acl *key_alloc_acl(const struct key_acl *old_acl, int nr, int skip)
+{
+	struct key_acl *acl;
+	int nr_ace, i, j = 0;
+
+	nr_ace = old_acl->nr_ace + nr;
+	if (nr_ace > 16)
+		return ERR_PTR(-EINVAL);
+
+	acl = kzalloc(struct_size(acl, aces, nr_ace), GFP_KERNEL);
+	if (!acl)
+		return ERR_PTR(-ENOMEM);
+
+	refcount_set(&acl->usage, 1);
+	acl->nr_ace = nr_ace;
+	for (i = 0; i < old_acl->nr_ace; i++) {
+		if (i == skip)
+			continue;
+		acl->aces[j] = old_acl->aces[i];
+		j++;
+	}
+	return acl;
+}
+
+/*
+ * Generate the revised ACL.
+ */
+static long key_change_acl(struct key *key, struct key_ace *new_ace)
+{
+	struct key_acl *acl, *old;
+	int i;
+
+	old = rcu_dereference_protected(key->acl, lockdep_is_held(&key->sem));
+
+	for (i = 0; i < old->nr_ace; i++)
+		if (old->aces[i].type == new_ace->type &&
+		    old->aces[i].subject_id == new_ace->subject_id)
+			goto found_match;
+
+	if (new_ace->perm == 0)
+		return 0; /* No permissions to remove.  Add deny record? */
+
+	acl = key_alloc_acl(old, 1, -1);
+	if (IS_ERR(acl))
+		return PTR_ERR(acl);
+	acl->aces[i] = *new_ace;
+	goto change;
+
+found_match:
+	if (new_ace->perm == 0)
+		goto delete_ace;
+	if (new_ace->perm == old->aces[i].perm)
+		return 0;
+	acl = key_alloc_acl(old, 0, -1);
+	if (IS_ERR(acl))
+		return PTR_ERR(acl);
+	acl->aces[i].perm = new_ace->perm;
+	goto change;
+
+delete_ace:
+	acl = key_alloc_acl(old, -1, i);
+	if (IS_ERR(acl))
+		return PTR_ERR(acl);
+	goto change;
+
+change:
+	return key_set_acl(key, acl);
+}
+
+/*
+ * Add, alter or remove (if perm == 0) an ACE in a key's ACL.
+ */
+long keyctl_grant_permission(key_serial_t keyid,
+			     enum key_ace_subject_type type,
+			     unsigned int subject,
+			     unsigned int perm)
+{
+	struct key_ace new_ace;
+	struct key *key;
+	key_ref_t key_ref;
+	long ret;
+
+	new_ace.type = type;
+	new_ace.perm = perm;
+
+	switch (type) {
+	case KEY_ACE_SUBJ_STANDARD:
+		if (subject >= nr__key_ace_standard_subject)
+			return -ENOENT;
+		new_ace.subject_id = subject;
+		break;
+
+	default:
+		return -ENOENT;
+	}
+
+	key_ref = lookup_user_key(keyid, KEY_LOOKUP_PARTIAL, KEY_NEED_CHANGE_ACL);
+	if (IS_ERR(key_ref)) {
+		ret = PTR_ERR(key_ref);
+		goto error;
+	}
+
+	key = key_ref_to_ptr(key_ref);
+
+	down_write(&key->sem);
+
+	/* If we're not the sysadmin, we can only change a key that we own */
+	ret = -EACCES;
+	if (capable(CAP_SYS_ADMIN) || uid_eq(key->uid, current_fsuid()))
+		ret = key_change_acl(key, &new_ace);
+
+	up_write(&key->sem);
+	key_put(key);
+error:
+	return ret;
+}


