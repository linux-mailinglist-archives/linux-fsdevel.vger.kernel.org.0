Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEA36222D02
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 22:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgGPUfq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 16:35:46 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39192 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726784AbgGPUfp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 16:35:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594931741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CM9kHczG1mejpXizrOwMr6oWo17vjufOqFWL/O/dWtM=;
        b=EpojZllzLUu6XnG/MSPtjebGim3JiWZBOX5GZzo87HNKvghKtkK/Psfeo3DgndurR9ousw
        PmCKgXLMvTkfgLWQeAbCv/ct67rfq8zhCGQ3AJ5xVrdxh8oeZBDQRknCAxNducgie2ufTI
        wcUmFnZUTLpa4E8wZo3HDScAqzj5QOg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-KSUnhjn5M26KUAQU12vR8Q-1; Thu, 16 Jul 2020 16:35:40 -0400
X-MC-Unique: KSUnhjn5M26KUAQU12vR8Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 301BD18A1DE8;
        Thu, 16 Jul 2020 20:35:38 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-113.rdu2.redhat.com [10.10.112.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E4D3B19D7B;
        Thu, 16 Jul 2020 20:35:34 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 5/5] keys: Implement a 'container' keyring
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
Date:   Thu, 16 Jul 2020 21:35:34 +0100
Message-ID: <159493173410.3249370.17990149429251969645.stgit@warthog.procyon.org.uk>
In-Reply-To: <159493167778.3249370.8145886688150701997.stgit@warthog.procyon.org.uk>
References: <159493167778.3249370.8145886688150701997.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.22
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Implement a per-container keyring, dangling it off of a user_namespace.
The properties of this keyring are such that it's searched by request_key()
selectively before or after the other keyrings have been searched, but the
keys in it don't grant possession to the denizens of the container, and so
the denizens can't see such keys unless those keys grant direct access
through the ACL.  The kernel recurses up the user_namespace stack looking
for keyrings.

The container manager, however, can access the keyring, and can add, update
and remove keys therein.

This allows the container manager to push filesystem authentication keys,
for example, into the container and to keep them refreshed without the
denizens of the container needing to know anything about it.

To this end, the following pieces are also added:

 (1) A new keyctl function, KEYCTL_GET_CONTAINER_KEYRING, to get the
     container keyring from a user namespace:

	keyring = keyctl_get_userns_keyring(int userns_fd,
					    key_serial_t dest_keyring);

     Get the container keyring attached to a user namespace, creating it if
     it doesn't exist.  A file descriptor pointing to the user namespace
     must be supplied.  The keyring will be linked into the destination
     keyring if one is supplied (ie. not 0).  The keyring will be owned by
     the user_namespace's owner and will grant various permissions to the
     possessor.

 (2) An ACL ACE type that allows access to a key by a container:

	keyctl_grant_acl(key_serial_t key,
			 KEY_ACE_SUBJ_CONTAINER,
			 int userns_fd,
			 KEY_ACE_SEARCH);

     This grants the kernel the ability to use a key on behalf of the
     denizens of a container, but doesn't grant any other rights, including
     the ability of the denizens see the key even exists.

This can then be tested with something like the following from the command
line:

 (1) Get the container keyring for a user namespace and link it to the
     session keyring.  The container is referenced as file descriptor 5.

	# keyctl get_container 5 @s 5</proc/self/ns/user
	197321290

 (2) Get a key that should be placed into the container, e.g.:

	# kinit foo@EXAMPLE.COM
	# aklog-kafs example.com

     This, say, adds key 748104263 to the session keyring.

 (3) Grant permission to the container to use the key:

	# keyctl grant 748104263 cont:5 s 5</proc/self/ns/user

 (4) Move (or link) the key into the container keyring:

	# keyctl move 748104263 @s 197321290

 (5) View the resultant keyrings:

	# keyctl show
	Session Keyring
	 711486290 --alswrv      0     0  keyring: _ses
	 468790230 ---lswrv      0 65534   \_ keyring: _uid.0
	 197321290 ----swrv      0 65534   \_ keyring: .container
	 748104263 --alswrv      0     0       \_ rxrpc: afs@example.com

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/key.h            |   13 +++-
 include/linux/user_namespace.h |    7 ++
 include/uapi/linux/keyctl.h    |    3 +
 security/keys/Kconfig          |   11 +++
 security/keys/compat.c         |    3 +
 security/keys/internal.h       |   10 +++
 security/keys/key.c            |    2 -
 security/keys/keyctl.c         |  128 ++++++++++++++++++++++++++++++++++++++++
 security/keys/keyring.c        |    7 ++
 security/keys/permission.c     |   94 +++++++++++++++++++++++++++--
 security/keys/proc.c           |    2 -
 security/keys/process_keys.c   |   36 +++++++++++
 12 files changed, 302 insertions(+), 14 deletions(-)

diff --git a/include/linux/key.h b/include/linux/key.h
index 0db5539366e7..810ea1ce01f4 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -112,7 +112,8 @@ struct key_ace {
 	union {
 		kuid_t		uid;
 		kgid_t		gid;
-		unsigned int	subject_id;
+		unsigned long	subject_id;
+		struct key_tag	*subject_tag;
 	};
 };
 
@@ -124,13 +125,13 @@ struct key_acl {
 	struct key_ace		aces[];
 };
 
-#define KEY_POSSESSOR_ACE(perms) {			\
+#define KEY_POSSESSOR_ACE(perms) (struct key_ace){	\
 		.type = KEY_ACE_SUBJ_STANDARD,		\
 		.perm = perms,				\
 		.subject_id = KEY_ACE_POSSESSOR		\
 	}
 
-#define KEY_OWNER_ACE(perms) {				\
+#define KEY_OWNER_ACE(perms) (struct key_ace){		\
 		.type = KEY_ACE_SUBJ_STANDARD,		\
 		.perm = perms,				\
 		.subject_id = KEY_ACE_OWNER		\
@@ -320,6 +321,12 @@ static inline void key_ref_put(key_ref_t key_ref)
 	key_put(key_ref_to_ptr(key_ref));
 }
 
+static inline struct key_tag *key_get_tag(struct key_tag *tag)
+{
+	refcount_inc(&tag->usage);
+	return tag;
+}
+
 extern struct key *request_key_tag(struct key_type *type,
 				   const char *description,
 				   struct key_tag *domain_tag,
diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
index 6ef1c7109fc4..f007258bd3d9 100644
--- a/include/linux/user_namespace.h
+++ b/include/linux/user_namespace.h
@@ -79,6 +79,13 @@ struct user_namespace {
 	/* Register of per-UID persistent keyrings for this namespace */
 #ifdef CONFIG_PERSISTENT_KEYRINGS
 	struct key		*persistent_keyring_register;
+#endif
+	/* Ring of keys that the namespace owner can insert into the
+	 * namespace for transparent access by the denizens.
+	 */
+#ifdef CONFIG_CONTAINER_KEYRINGS
+	struct key		*container_keyring;
+	struct key_tag		*container_subj;	/* The ACE subject to match */
 #endif
 	struct work_struct	work;
 #ifdef CONFIG_SYSCTL
diff --git a/include/uapi/linux/keyctl.h b/include/uapi/linux/keyctl.h
index a5938f2c3e66..2579fe75b93f 100644
--- a/include/uapi/linux/keyctl.h
+++ b/include/uapi/linux/keyctl.h
@@ -20,6 +20,7 @@
  */
 enum key_ace_subject_type {
 	KEY_ACE_SUBJ_STANDARD	= 0,	/* subject is one of key_ace_standard_subject */
+	KEY_ACE_SUBJ_CONTAINER	= 1,	/* Subject is an fd referring to a container (eg. userns) */
 	nr__key_ace_subject_type
 };
 
@@ -134,6 +135,7 @@ enum key_ace_standard_subject {
 #define KEYCTL_CAPABILITIES		31	/* Find capabilities of keyrings subsystem */
 #define KEYCTL_WATCH_KEY		32	/* Watch a key or ring of keys for changes */
 #define KEYCTL_GRANT_PERMISSION		33	/* Grant a permit to a key */
+#define KEYCTL_GET_CONTAINER_KEYRING	34	/* Get a container keyring */
 
 /* keyctl structures */
 struct keyctl_dh_params {
@@ -198,5 +200,6 @@ struct keyctl_pkey_params {
 #define KEYCTL_CAPS1_NOTIFICATIONS	0x04 /* Keys generate watchable notifications */
 #define KEYCTL_CAPS1_ACL		0x08 /* Keys have ACLs rather than a p-u-g-o bitmask */
 #define KEYCTL_CAPS1_GRANT_PERMISSION	0x10 /* KEYCTL_GRANT_PERMISSION is supported */
+#define KEYCTL_CAPS1_CONTAINER_KEYRINGS	0x20 /* Container keyrings are supported */
 
 #endif /*  _LINUX_KEYCTL_H */
diff --git a/security/keys/Kconfig b/security/keys/Kconfig
index 83bc23409164..df138027942e 100644
--- a/security/keys/Kconfig
+++ b/security/keys/Kconfig
@@ -123,3 +123,14 @@ config KEY_NOTIFICATIONS
 	  and keyrings on which the caller has View permission.  This makes use
 	  of the /dev/watch_queue misc device to handle the notification
 	  buffer and provides KEYCTL_WATCH_KEY to enable/disable watches.
+
+config CONTAINER_KEYRINGS
+	bool "Provide per-container keyrings"
+	depends on KEYS && USER_NS
+	help
+	  This option provides a keyring on each user_namespace that is
+	  searched by request_key() after it has searched the normal process
+	  keyrings.  This is a place that the container manager can insert
+	  filesystem authentication keys into a container so that the denizens
+	  can use authenticated storage without having to do anything for
+	  themselves - the manager can take care of that.
diff --git a/security/keys/compat.c b/security/keys/compat.c
index 2b675f9a6162..3c9eecb43bba 100644
--- a/security/keys/compat.c
+++ b/security/keys/compat.c
@@ -161,6 +161,9 @@ COMPAT_SYSCALL_DEFINE5(keyctl, u32, option,
 	case KEYCTL_WATCH_KEY:
 		return keyctl_watch_key(arg2, arg3, arg4);
 
+	case KEYCTL_GET_CONTAINER_KEYRING:
+		return keyctl_get_container_keyring(arg2, arg3);
+
 	default:
 		return -EOPNOTSUPP;
 	}
diff --git a/security/keys/internal.h b/security/keys/internal.h
index d0d1bce95674..e3218aa72d4c 100644
--- a/security/keys/internal.h
+++ b/security/keys/internal.h
@@ -144,6 +144,7 @@ struct keyring_search_context {
 	int (*iterator)(const void *object, void *iterator_data);
 
 	/* Internal stuff */
+	const struct key_tag	*container_subj; /* The ACE container subject or NULL */
 	int			skipped_ret;
 	bool			possessed;
 	key_ref_t		result;
@@ -386,6 +387,15 @@ extern long keyctl_grant_permission(key_serial_t keyid,
 				    unsigned int subject,
 				    unsigned int perm);
 
+#ifdef CONFIG_KEY_NOTIFICATIONS
+extern long keyctl_get_container_keyring(int container_fd, key_serial_t destringid);
+#else
+static inline long keyctl_get_container_keyring(int container_fd, key_serial_t destringid)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
 /*
  * Debugging key validation
  */
diff --git a/security/keys/key.c b/security/keys/key.c
index 51491c07d7b9..17da784de9e8 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -318,7 +318,7 @@ struct key *key_alloc(struct key_type *type, const char *desc,
 		goto security_error;
 
 	/* publish the key by giving it a serial number */
-	refcount_inc(&key->domain_tag->usage);
+	key_get_tag(key->domain_tag);
 	atomic_inc(&user->nkeys);
 	key_alloc_serial(key);
 
diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index 54a2bfff9af2..786da7382b7a 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -21,6 +21,10 @@
 #include <linux/security.h>
 #include <linux/uio.h>
 #include <linux/uaccess.h>
+#include <linux/file.h>
+#include <linux/proc_fs.h>
+#include <linux/proc_ns.h>
+#include <linux/user_namespace.h>
 #include <keys/request_key_auth-type.h>
 #include "internal.h"
 
@@ -40,7 +44,8 @@ static const unsigned char keyrings_capabilities[2] = {
 	       KEYCTL_CAPS1_NS_KEY_TAG |
 	       (IS_ENABLED(CONFIG_KEY_NOTIFICATIONS)	? KEYCTL_CAPS1_NOTIFICATIONS : 0) |
 	       KEYCTL_CAPS1_ACL |
-	       KEYCTL_CAPS1_GRANT_PERMISSION
+	       KEYCTL_CAPS1_GRANT_PERMISSION |
+	       (IS_ENABLED(CONFIG_CONTAINER_KEYRINGS)	? KEYCTL_CAPS1_CONTAINER_KEYRINGS : 0)
 	       ),
 };
 
@@ -1758,6 +1763,124 @@ long keyctl_watch_key(key_serial_t id, int watch_queue_fd, int watch_id)
 }
 #endif /* CONFIG_KEY_NOTIFICATIONS */
 
+#ifdef CONFIG_CONTAINER_KEYRINGS
+/*
+ * Create a container keyring for a user namespace and add it.
+ */
+static struct key *key_create_container_keyring(struct user_namespace *user_ns)
+{
+	struct key_tag *tag;
+	struct key_acl *acl;
+	struct key *keyring;
+
+	keyring = key_get(user_ns->container_keyring);
+	if (keyring)
+		return keyring;
+
+	/* We're going to need a subject tag... */
+	tag = user_ns->container_subj;
+	if (!tag) {
+		tag = kzalloc(sizeof(struct key_tag), GFP_KERNEL);
+		if (!tag)
+			return ERR_PTR(-ENOMEM);
+		refcount_set(&tag->usage, 1);
+		user_ns->container_subj = tag;
+	}
+
+	/* ...  so that we can grant the container denizens search permission
+	 * on the keyring.
+	 */
+	acl = kzalloc(struct_size(acl, aces, 3), GFP_KERNEL);
+	if (!acl)
+		return ERR_PTR(-ENOMEM);
+
+	refcount_set(&acl->usage, 1);
+	acl->possessor_viewable = true;
+	acl->nr_ace		= 3;
+
+	acl->aces[0] = KEY_POSSESSOR_ACE(KEY_ACE_VIEW | KEY_ACE_READ | KEY_ACE_WRITE |
+					 KEY_ACE_CLEAR | KEY_ACE_SEARCH);
+	acl->aces[1] = KEY_OWNER_ACE(KEY_ACE_VIEW | KEY_ACE_READ);
+
+	acl->aces[2].type = KEY_ACE_SUBJ_CONTAINER;
+	acl->aces[2].subject_tag = key_get_tag(tag);
+	acl->aces[2].perm = KEY_ACE_SEARCH;
+
+	keyring = keyring_alloc(".container", user_ns->owner, INVALID_GID,
+				current_cred(), acl, 0, NULL, NULL);
+	key_put_acl(acl);
+	if (IS_ERR(keyring))
+		return keyring;
+
+	smp_store_release(&user_ns->container_keyring, key_get(keyring));
+	return keyring;
+}
+
+/*
+ * Get the container keyring attached to a container.  The container is
+ * referenced by a file descriptor referring to, say, a user_namespace.
+ */
+long keyctl_get_container_keyring(int container_fd, key_serial_t destringid)
+{
+	struct user_namespace *user_ns;
+	struct ns_common *ns;
+	struct file *f;
+	struct key *keyring;
+	key_ref_t dest_ref;
+	int ret = -EINVAL;
+
+	f = fget(container_fd);
+	if (!f)
+		return -EBADF;
+
+	if (!proc_ns_file(f))
+		goto error_file;
+	ns = get_proc_ns(file_inode(f));
+	if (ns->ops->type != CLONE_NEWUSER)
+		goto error_file;
+	user_ns = container_of(ns, struct user_namespace, ns);
+
+	keyring = key_get(READ_ONCE(user_ns->container_keyring));
+	if (!keyring) {
+		down_write(&user_ns->keyring_sem);
+		keyring = key_create_container_keyring(user_ns);
+		up_write(&user_ns->keyring_sem);
+		if (IS_ERR(keyring)) {
+			ret = PTR_ERR(keyring);
+			goto error_file;
+		}
+	}
+
+	/* Get the destination keyring if specified.  We don't need LINK
+	 * permission on the container keyring as having the container fd is
+	 * sufficient to grant us that.
+	 */
+	dest_ref = NULL;
+	if (destringid) {
+		dest_ref = lookup_user_key(destringid, KEY_LOOKUP_CREATE,
+					   KEY_NEED_KEYRING_ADD);
+		if (IS_ERR(dest_ref)) {
+			ret = PTR_ERR(dest_ref);
+			goto error_keyring;
+		}
+
+		ret = key_link(key_ref_to_ptr(dest_ref), keyring);
+		if (ret < 0)
+			goto error_dest;
+	}
+
+	ret = key_serial(keyring);
+
+error_dest:
+	key_ref_put(dest_ref);
+error_keyring:
+	key_put(keyring);
+error_file:
+	fput(f);
+	return ret;
+}
+#endif
+
 /*
  * Get keyrings subsystem capabilities.
  */
@@ -1935,6 +2058,9 @@ SYSCALL_DEFINE5(keyctl, int, option, unsigned long, arg2, unsigned long, arg3,
 	case KEYCTL_WATCH_KEY:
 		return keyctl_watch_key((key_serial_t)arg2, (int)arg3, (int)arg4);
 
+	case KEYCTL_GET_CONTAINER_KEYRING:
+		return keyctl_get_container_keyring((int)arg2, (key_serial_t)arg3);
+
 	default:
 		return -EOPNOTSUPP;
 	}
diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index 1779c95b428c..eb311987bb9b 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -64,6 +64,13 @@ void key_free_user_ns(struct user_namespace *ns)
 #ifdef CONFIG_PERSISTENT_KEYRINGS
 	key_put(ns->persistent_keyring_register);
 #endif
+#ifdef CONFIG_CONTAINER_KEYRINGS
+	if (ns->container_subj) {
+		ns->container_subj->removed = true;
+		key_put_tag(ns->container_subj);
+	}
+	key_put(ns->container_keyring);
+#endif
 }
 
 /*
diff --git a/security/keys/permission.c b/security/keys/permission.c
index 3ae4d9aedc3a..b984e1ce7e5d 100644
--- a/security/keys/permission.c
+++ b/security/keys/permission.c
@@ -7,6 +7,10 @@
 
 #include <linux/export.h>
 #include <linux/security.h>
+#include <linux/file.h>
+#include <linux/proc_fs.h>
+#include <linux/proc_ns.h>
+#include <linux/user_namespace.h>
 #include <keys/request_key_auth-type.h>
 #include "internal.h"
 
@@ -177,7 +181,9 @@ static int check_key_permission(const key_ref_t key_ref, const struct cred *cred
 /*
  * Resolve an ACL to a mask.
  */
-static unsigned int key_resolve_acl(const key_ref_t key_ref, const struct cred *cred)
+static unsigned int key_resolve_acl(const key_ref_t key_ref,
+				    const struct cred *cred,
+				    const struct key_tag *tag)
 {
 	const struct key *key = key_ref_to_ptr(key_ref);
 	const struct key_acl *acl;
@@ -215,6 +221,11 @@ static unsigned int key_resolve_acl(const key_ref_t key_ref, const struct cred *
 				break;
 			}
 			break;
+
+		case KEY_ACE_SUBJ_CONTAINER:
+			if (ace->subject_tag == tag)
+				allow |= ace->perm;
+			break;
 		}
 	}
 
@@ -242,7 +253,7 @@ int key_task_permission(const key_ref_t key_ref, const struct cred *cred,
 	int ret;
 
 	rcu_read_lock();
-	allow = key_resolve_acl(key_ref, cred);
+	allow = key_resolve_acl(key_ref, cred, NULL);
 	rcu_read_unlock();
 
 	ret = check_key_permission(key_ref, cred, allow, need_perm, &notes);
@@ -274,7 +285,7 @@ int key_search_permission(const key_ref_t key_ref,
 	unsigned int allow, notes = 0;
 	int ret;
 
-	allow = key_resolve_acl(key_ref, ctx->cred);
+	allow = key_resolve_acl(key_ref, ctx->cred, ctx->container_subj);
 
 	ret = check_key_permission(key_ref, ctx->cred, allow, need_perm, &notes);
 	if (ret < 0)
@@ -374,13 +385,24 @@ unsigned int key_acl_to_perm(const struct key_acl *acl)
 	return perm;
 }
 
+static void key_free_acl(struct rcu_head *rcu)
+{
+	struct key_acl *acl = container_of(rcu, struct key_acl, rcu);
+	unsigned int i;
+
+	for (i = 0; i < acl->nr_ace; i++)
+		if (acl->aces[i].type == KEY_ACE_SUBJ_CONTAINER)
+			key_put_tag(acl->aces[i].subject_tag);
+	kfree(acl);
+}
+
 /*
  * Destroy a key's ACL.
  */
 void key_put_acl(struct key_acl *acl)
 {
 	if (acl && refcount_dec_and_test(&acl->usage))
-		kfree_rcu(acl, rcu);
+		call_rcu(&acl->rcu, key_free_acl);
 }
 
 /*
@@ -440,7 +462,8 @@ static struct key_acl *key_alloc_acl(const struct key_acl *old_acl, int nr, int
 }
 
 /*
- * Generate the revised ACL.
+ * Generate the revised ACL.  If the new ACE contains a key_tag and we don't
+ * have the tag in ACL yet, we steal the tag and clear the caller's pointer.
  */
 static long key_change_acl(struct key *key, struct key_ace *new_ace)
 {
@@ -461,6 +484,7 @@ static long key_change_acl(struct key *key, struct key_ace *new_ace)
 	if (IS_ERR(acl))
 		return PTR_ERR(acl);
 	acl->aces[i] = *new_ace;
+	new_ace->subject_tag = NULL; /* Stole the tag */
 	goto change;
 
 found_match:
@@ -484,6 +508,49 @@ static long key_change_acl(struct key *key, struct key_ace *new_ace)
 	return key_set_acl(key, acl);
 }
 
+/*
+ * Look up the user namespace tag associated with a fd.
+ */
+static struct key_tag *key_get_ns_tag(int fd)
+{
+#ifdef CONFIG_CONTAINER_KEYRINGS
+	struct user_namespace *userns;
+	struct ns_common *ns;
+	struct key_tag *tag = ERR_PTR(-EINVAL), *candidate;
+	struct file *f;
+
+	f = fget(fd);
+	if (!f)
+		return ERR_PTR(-EBADF);
+
+	if (!proc_ns_file(f))
+		goto error;
+	ns = get_proc_ns(file_inode(f));
+	if (ns->ops->type != CLONE_NEWUSER)
+		goto error;
+
+	userns = container_of(ns, struct user_namespace, ns);
+	if (!userns->container_subj) {
+		candidate = kzalloc(sizeof(struct key_tag), GFP_KERNEL);
+		refcount_set(&candidate->usage, 1);
+		down_write(&userns->keyring_sem);
+		if (!userns->container_subj) {
+			userns->container_subj = candidate;
+			candidate = NULL;
+		}
+		up_write(&userns->keyring_sem);
+		kfree(candidate);
+	}
+
+	tag = key_get_tag(userns->container_subj);
+error:
+	fput(f);
+	return tag;
+#else
+	return ERR_PTR(-EOPNOTSUPP);
+#endif
+}
+
 /*
  * Add, alter or remove (if perm == 0) an ACE in a key's ACL.
  */
@@ -492,13 +559,15 @@ long keyctl_grant_permission(key_serial_t keyid,
 			     unsigned int subject,
 			     unsigned int perm)
 {
-	struct key_ace new_ace;
+	struct key_tag *tag;
 	struct key *key;
 	key_ref_t key_ref;
 	long ret;
 
-	new_ace.type = type;
-	new_ace.perm = perm;
+	struct key_ace new_ace = {
+		.type = type,
+		.perm = perm,
+	};
 
 	switch (type) {
 	case KEY_ACE_SUBJ_STANDARD:
@@ -507,6 +576,13 @@ long keyctl_grant_permission(key_serial_t keyid,
 		new_ace.subject_id = subject;
 		break;
 
+	case KEY_ACE_SUBJ_CONTAINER:
+		tag = key_get_ns_tag(subject);
+		if (IS_ERR(tag))
+			return PTR_ERR(tag);
+		new_ace.subject_tag = tag;
+		break;
+
 	default:
 		return -ENOENT;
 	}
@@ -529,5 +605,7 @@ long keyctl_grant_permission(key_serial_t keyid,
 	up_write(&key->sem);
 	key_put(key);
 error:
+	if (new_ace.type == KEY_ACE_SUBJ_CONTAINER && new_ace.subject_tag)
+		key_put_tag(new_ace.subject_tag);
 	return ret;
 }
diff --git a/security/keys/proc.c b/security/keys/proc.c
index a6b349ee1759..ba3be0e9c97d 100644
--- a/security/keys/proc.c
+++ b/security/keys/proc.c
@@ -183,7 +183,7 @@ static int proc_keys_show(struct seq_file *m, void *v)
 	check_pos = acl->possessor_viewable;
 
 	/* determine if the key is possessed by this process (a test we can
-	 * skip if the key does not indicate the possessor can view it
+	 * skip if the key does not indicate the possessor can view it)
 	 */
 	key_ref = make_key_ref(key, 0);
 	if (check_pos) {
diff --git a/security/keys/process_keys.c b/security/keys/process_keys.c
index 3721f96dd6fb..af09db1e5984 100644
--- a/security/keys/process_keys.c
+++ b/security/keys/process_keys.c
@@ -458,6 +458,7 @@ void key_fsgid_changed(struct cred *new_cred)
  */
 key_ref_t search_cred_keyrings_rcu(struct keyring_search_context *ctx)
 {
+	struct user_namespace *userns;
 	struct key *user_session;
 	key_ref_t key_ref, ret, err;
 	const struct cred *cred = ctx->cred;
@@ -556,6 +557,41 @@ key_ref_t search_cred_keyrings_rcu(struct keyring_search_context *ctx)
 		}
 	}
 
+#ifdef CONFIG_CONTAINER_KEYRINGS
+	for (userns = cred->user_ns; userns; userns = userns->parent) {
+		if (!userns->container_keyring || !userns->container_subj)
+			continue;
+
+		/* The denizens of the container don't possess the key
+		 * and have a special subject to match.
+		 */
+		ctx->container_subj = userns->container_subj;
+		key_ref = keyring_search_rcu(make_key_ref(userns->container_keyring,
+							  false), ctx);
+		ctx->container_subj = NULL;
+
+		if (!IS_ERR(key_ref))
+			goto found;
+
+		switch (PTR_ERR(key_ref)) {
+		case -EAGAIN: /* no key */
+			if (ret)
+				break;
+			/* fall through */
+		case -ENOKEY: /* negative key */
+			ret = key_ref;
+			break;
+		default:
+			/* Hmmm...  should we admit to the denizens of
+			 * the container that a key exists?
+			 */
+			err = key_ref;
+			break;
+		}
+	}
+
+#endif
+
 	/* no key - decide on the error we're going to go for */
 	key_ref = ret ? ret : err;
 


