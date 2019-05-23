Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0555B28200
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2019 17:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731145AbfEWP6r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 May 2019 11:58:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35226 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730752AbfEWP6r (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 May 2019 11:58:47 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8124889C37;
        Thu, 23 May 2019 15:58:46 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-142.rdu2.redhat.com [10.10.121.142])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 582485D707;
        Thu, 23 May 2019 15:58:43 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 2/2] KEYS: Provide KEYCTL_GRANT_PERMISSION
From:   David Howells <dhowells@redhat.com>
To:     keyrings@vger.kernel.org
Cc:     dhowells@redhat.com, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 23 May 2019 16:58:43 +0100
Message-ID: <155862712317.24863.13455329541359881229.stgit@warthog.procyon.org.uk>
In-Reply-To: <155862710003.24863.11807972177275927370.stgit@warthog.procyon.org.uk>
References: <155862710003.24863.11807972177275927370.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 23 May 2019 15:58:46 +0000 (UTC)
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
permissions to be granted.  0 is returned on success.  SET_SECURITY
permission is required for this.

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
	KEY_ACE_SET_SECURITY	Can set security
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

 include/uapi/linux/keyctl.h |    1 
 security/keys/compat.c      |    2 +
 security/keys/internal.h    |    5 ++
 security/keys/keyctl.c      |    5 ++
 security/keys/permission.c  |  119 +++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 132 insertions(+)

diff --git a/include/uapi/linux/keyctl.h b/include/uapi/linux/keyctl.h
index eb0bfd491374..00b476fa6945 100644
--- a/include/uapi/linux/keyctl.h
+++ b/include/uapi/linux/keyctl.h
@@ -131,6 +131,7 @@ enum key_ace_standard_subject {
 #define KEYCTL_PKEY_VERIFY		28	/* Verify a public key signature */
 #define KEYCTL_RESTRICT_KEYRING		29	/* Restrict keys allowed to link to a keyring */
 #define KEYCTL_MOVE			30	/* Move keys between keyrings */
+#define KEYCTL_GRANT_PERMISSION		31	/* Grant a permit to a key */
 
 /* keyctl structures */
 struct keyctl_dh_params {
diff --git a/security/keys/compat.c b/security/keys/compat.c
index b326bc4f84d7..30c23a3cadb8 100644
--- a/security/keys/compat.c
+++ b/security/keys/compat.c
@@ -161,6 +161,8 @@ COMPAT_SYSCALL_DEFINE5(keyctl, u32, option,
 
 	case KEYCTL_MOVE:
 		return keyctl_keyring_move(arg2, arg3, arg4, arg5);
+	case KEYCTL_GRANT_PERMISSION:
+		return keyctl_grant_permission(arg2, arg3, arg4, arg5);
 
 	default:
 		return -EOPNOTSUPP;
diff --git a/security/keys/internal.h b/security/keys/internal.h
index 36cac9f7dbc1..99eccbd2ee7b 100644
--- a/security/keys/internal.h
+++ b/security/keys/internal.h
@@ -336,6 +336,11 @@ static inline long keyctl_pkey_e_d_s(int op,
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
index 51fae94ae2e0..d503758f9deb 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -1860,6 +1860,11 @@ SYSCALL_DEFINE5(keyctl, int, option, unsigned long, arg2, unsigned long, arg3,
 					   (key_serial_t)arg3,
 					   (key_serial_t)arg4,
 					   (unsigned int)arg5);
+	case KEYCTL_GRANT_PERMISSION:
+		return keyctl_grant_permission((key_serial_t)arg2,
+					       (enum key_ace_subject_type)arg3,
+					       (unsigned int)arg4,
+					       (unsigned int)arg5);
 
 	default:
 		return -EOPNOTSUPP;
diff --git a/security/keys/permission.c b/security/keys/permission.c
index 1f6a736d5acd..354ac539402c 100644
--- a/security/keys/permission.c
+++ b/security/keys/permission.c
@@ -273,3 +273,122 @@ long key_set_acl(struct key *key, struct key_acl *acl)
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
+	key_ref = lookup_user_key(keyid, KEY_LOOKUP_PARTIAL, KEY_NEED_SETSEC);
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
+	up_write(&key->sem);
+	key_put(key);
+error:
+	return ret;
+}

