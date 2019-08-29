Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8827A2570
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2019 20:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729824AbfH2Sal (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Aug 2019 14:30:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41870 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727929AbfH2Saj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Aug 2019 14:30:39 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 57938307D8E3;
        Thu, 29 Aug 2019 18:30:38 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-255.rdu2.redhat.com [10.10.120.255])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 89C0419D7A;
        Thu, 29 Aug 2019 18:30:35 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 05/11] keys: Add a notification facility [ver #6]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        nicolas.dichtel@6wind.com, raven@themaw.net,
        Christian Brauner <christian@brauner.io>, dhowells@redhat.com,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-block@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 29 Aug 2019 19:30:34 +0100
Message-ID: <156710343480.10009.5063333889020557796.stgit@warthog.procyon.org.uk>
In-Reply-To: <156710338860.10009.12524626894838499011.stgit@warthog.procyon.org.uk>
References: <156710338860.10009.12524626894838499011.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Thu, 29 Aug 2019 18:30:38 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a key/keyring change notification facility whereby notifications about
changes in key and keyring content and attributes can be received.

Firstly, an event queue needs to be created:

	fd = open("/dev/event_queue", O_RDWR);
	ioctl(fd, IOC_WATCH_QUEUE_SET_SIZE, page_size << n);

then a notification can be set up to report notifications via that queue:

	struct watch_notification_filter filter = {
		.nr_filters = 1,
		.filters = {
			[0] = {
				.type = WATCH_TYPE_KEY_NOTIFY,
				.subtype_filter[0] = UINT_MAX,
			},
		},
	};
	ioctl(fd, IOC_WATCH_QUEUE_SET_FILTER, &filter);
	keyctl_watch_key(KEY_SPEC_SESSION_KEYRING, fd, 0x01);

After that, records will be placed into the queue when events occur in
which keys are changed in some way.  Records are of the following format:

	struct key_notification {
		struct watch_notification watch;
		__u32	key_id;
		__u32	aux;
	} *n;

Where:

	n->watch.type will be WATCH_TYPE_KEY_NOTIFY.

	n->watch.subtype will indicate the type of event, such as
	NOTIFY_KEY_REVOKED.

	n->watch.info & WATCH_INFO_LENGTH will indicate the length of the
	record.

	n->watch.info & WATCH_INFO_ID will be the second argument to
	keyctl_watch_key(), shifted.

	n->key will be the ID of the affected key.

	n->aux will hold subtype-dependent information, such as the key
	being linked into the keyring specified by n->key in the case of
	NOTIFY_KEY_LINKED.

Note that it is permissible for event records to be of variable length -
or, at least, the length may be dependent on the subtype.  Note also that
the queue can be shared between multiple notifications of various types.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 Documentation/security/keys/core.rst |   58 +++++++++++++++++++
 include/linux/key.h                  |    3 +
 include/uapi/linux/keyctl.h          |    2 +
 include/uapi/linux/watch_queue.h     |   28 +++++++++
 security/keys/Kconfig                |    9 +++
 security/keys/compat.c               |    3 +
 security/keys/gc.c                   |    5 ++
 security/keys/internal.h             |   30 ++++++++++
 security/keys/key.c                  |   38 ++++++++-----
 security/keys/keyctl.c               |  103 +++++++++++++++++++++++++++++++++-
 security/keys/keyring.c              |   20 ++++---
 security/keys/request_key.c          |    4 +
 12 files changed, 275 insertions(+), 28 deletions(-)

diff --git a/Documentation/security/keys/core.rst b/Documentation/security/keys/core.rst
index d6d8b0b756b6..957179f8cea9 100644
--- a/Documentation/security/keys/core.rst
+++ b/Documentation/security/keys/core.rst
@@ -833,6 +833,7 @@ The keyctl syscall functions are:
      A process must have search permission on the key for this function to be
      successful.
 
+
   *  Compute a Diffie-Hellman shared secret or public key::
 
 	long keyctl(KEYCTL_DH_COMPUTE, struct keyctl_dh_params *params,
@@ -1026,6 +1027,63 @@ The keyctl syscall functions are:
      written into the output buffer.  Verification returns 0 on success.
 
 
+  *  Watch a key or keyring for changes::
+
+	long keyctl(KEYCTL_WATCH_KEY, key_serial_t key, int queue_fd,
+		    const struct watch_notification_filter *filter);
+
+     This will set or remove a watch for changes on the specified key or
+     keyring.
+
+     "key" is the ID of the key to be watched.
+
+     "queue_fd" is a file descriptor referring to an open "/dev/watch_queue"
+     which manages the buffer into which notifications will be delivered.
+
+     "filter" is either NULL to remove a watch or a filter specification to
+     indicate what events are required from the key.
+
+     See Documentation/watch_queue.rst for more information.
+
+     Note that only one watch may be emplaced for any particular { key,
+     queue_fd } combination.
+
+     Notification records look like::
+
+	struct key_notification {
+		struct watch_notification watch;
+		__u32	key_id;
+		__u32	aux;
+	};
+
+     In this, watch::type will be "WATCH_TYPE_KEY_NOTIFY" and subtype will be
+     one of::
+
+	NOTIFY_KEY_INSTANTIATED
+	NOTIFY_KEY_UPDATED
+	NOTIFY_KEY_LINKED
+	NOTIFY_KEY_UNLINKED
+	NOTIFY_KEY_CLEARED
+	NOTIFY_KEY_REVOKED
+	NOTIFY_KEY_INVALIDATED
+	NOTIFY_KEY_SETATTR
+
+     Where these indicate a key being instantiated/rejected, updated, a link
+     being made in a keyring, a link being removed from a keyring, a keyring
+     being cleared, a key being revoked, a key being invalidated or a key
+     having one of its attributes changed (user, group, perm, timeout,
+     restriction).
+
+     If a watched key is deleted, a basic watch_notification will be issued
+     with "type" set to WATCH_TYPE_META and "subtype" set to
+     watch_meta_removal_notification.  The watchpoint ID will be set in the
+     "info" field.
+
+     This needs to be configured by enabling:
+
+	"Provide key/keyring change notifications" (KEY_NOTIFICATIONS)
+
+
 Kernel Services
 ===============
 
diff --git a/include/linux/key.h b/include/linux/key.h
index 50028338a4cc..b897ef4f7030 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -176,6 +176,9 @@ struct key {
 		struct list_head graveyard_link;
 		struct rb_node	serial_node;
 	};
+#ifdef CONFIG_KEY_NOTIFICATIONS
+	struct watch_list	*watchers;	/* Entities watching this key for changes */
+#endif
 	struct rw_semaphore	sem;		/* change vs change sem */
 	struct key_user		*user;		/* owner of this key */
 	void			*security;	/* security data for this key */
diff --git a/include/uapi/linux/keyctl.h b/include/uapi/linux/keyctl.h
index ed3d5893830d..4c8884eea808 100644
--- a/include/uapi/linux/keyctl.h
+++ b/include/uapi/linux/keyctl.h
@@ -69,6 +69,7 @@
 #define KEYCTL_RESTRICT_KEYRING		29	/* Restrict keys allowed to link to a keyring */
 #define KEYCTL_MOVE			30	/* Move keys between keyrings */
 #define KEYCTL_CAPABILITIES		31	/* Find capabilities of keyrings subsystem */
+#define KEYCTL_WATCH_KEY		32	/* Watch a key or ring of keys for changes */
 
 /* keyctl structures */
 struct keyctl_dh_params {
@@ -130,5 +131,6 @@ struct keyctl_pkey_params {
 #define KEYCTL_CAPS0_MOVE		0x80 /* KEYCTL_MOVE supported */
 #define KEYCTL_CAPS1_NS_KEYRING_NAME	0x01 /* Keyring names are per-user_namespace */
 #define KEYCTL_CAPS1_NS_KEY_TAG		0x02 /* Key indexing can include a namespace tag */
+#define KEYCTL_CAPS1_NOTIFICATIONS	0x04 /* Keys generate watchable notifications */
 
 #endif /*  _LINUX_KEYCTL_H */
diff --git a/include/uapi/linux/watch_queue.h b/include/uapi/linux/watch_queue.h
index 3f0e09ed6963..654d4ba8b909 100644
--- a/include/uapi/linux/watch_queue.h
+++ b/include/uapi/linux/watch_queue.h
@@ -10,7 +10,8 @@
 
 enum watch_notification_type {
 	WATCH_TYPE_META		= 0,	/* Special record */
-	WATCH_TYPE___NR		= 1
+	WATCH_TYPE_KEY_NOTIFY	= 1,	/* Key change event notification */
+	WATCH_TYPE___NR		= 2
 };
 
 enum watch_meta_notification_subtype {
@@ -98,4 +99,29 @@ struct watch_notification_removal {
 	__u64	id;		/* Type-dependent identifier */
 };
 
+/*
+ * Type of key/keyring change notification.
+ */
+enum key_notification_subtype {
+	NOTIFY_KEY_INSTANTIATED	= 0, /* Key was instantiated (aux is error code) */
+	NOTIFY_KEY_UPDATED	= 1, /* Key was updated */
+	NOTIFY_KEY_LINKED	= 2, /* Key (aux) was added to watched keyring */
+	NOTIFY_KEY_UNLINKED	= 3, /* Key (aux) was removed from watched keyring */
+	NOTIFY_KEY_CLEARED	= 4, /* Keyring was cleared */
+	NOTIFY_KEY_REVOKED	= 5, /* Key was revoked */
+	NOTIFY_KEY_INVALIDATED	= 6, /* Key was invalidated */
+	NOTIFY_KEY_SETATTR	= 7, /* Key's attributes got changed */
+};
+
+/*
+ * Key/keyring notification record.
+ * - watch.type = WATCH_TYPE_KEY_NOTIFY
+ * - watch.subtype = enum key_notification_type
+ */
+struct key_notification {
+	struct watch_notification watch;
+	__u32	key_id;		/* The key/keyring affected */
+	__u32	aux;		/* Per-type auxiliary data */
+};
+
 #endif /* _UAPI_LINUX_WATCH_QUEUE_H */
diff --git a/security/keys/Kconfig b/security/keys/Kconfig
index dd313438fecf..20791a556b58 100644
--- a/security/keys/Kconfig
+++ b/security/keys/Kconfig
@@ -120,3 +120,12 @@ config KEY_DH_OPERATIONS
 	 in the kernel.
 
 	 If you are unsure as to whether this is required, answer N.
+
+config KEY_NOTIFICATIONS
+	bool "Provide key/keyring change notifications"
+	depends on KEYS && WATCH_QUEUE
+	help
+	  This option provides support for getting change notifications on keys
+	  and keyrings on which the caller has View permission.  This makes use
+	  of the /dev/watch_queue misc device to handle the notification
+	  buffer and provides KEYCTL_WATCH_KEY to enable/disable watches.
diff --git a/security/keys/compat.c b/security/keys/compat.c
index 9bcc404131aa..ac5a4fd0d7ea 100644
--- a/security/keys/compat.c
+++ b/security/keys/compat.c
@@ -161,6 +161,9 @@ COMPAT_SYSCALL_DEFINE5(keyctl, u32, option,
 	case KEYCTL_CAPABILITIES:
 		return keyctl_capabilities(compat_ptr(arg2), arg3);
 
+	case KEYCTL_WATCH_KEY:
+		return keyctl_watch_key(arg2, arg3, arg4);
+
 	default:
 		return -EOPNOTSUPP;
 	}
diff --git a/security/keys/gc.c b/security/keys/gc.c
index 671dd730ecfc..3c90807476eb 100644
--- a/security/keys/gc.c
+++ b/security/keys/gc.c
@@ -131,6 +131,11 @@ static noinline void key_gc_unused_keys(struct list_head *keys)
 		kdebug("- %u", key->serial);
 		key_check(key);
 
+#ifdef CONFIG_KEY_NOTIFICATIONS
+		remove_watch_list(key->watchers, key->serial);
+		key->watchers = NULL;
+#endif
+
 		/* Throw away the key data if the key is instantiated */
 		if (state == KEY_IS_POSITIVE && key->type->destroy)
 			key->type->destroy(key);
diff --git a/security/keys/internal.h b/security/keys/internal.h
index c039373488bd..240f55c7b4a2 100644
--- a/security/keys/internal.h
+++ b/security/keys/internal.h
@@ -15,6 +15,7 @@
 #include <linux/task_work.h>
 #include <linux/keyctl.h>
 #include <linux/refcount.h>
+#include <linux/watch_queue.h>
 #include <linux/compat.h>
 
 struct iovec;
@@ -97,7 +98,8 @@ extern int __key_link_begin(struct key *keyring,
 			    const struct keyring_index_key *index_key,
 			    struct assoc_array_edit **_edit);
 extern int __key_link_check_live_key(struct key *keyring, struct key *key);
-extern void __key_link(struct key *key, struct assoc_array_edit **_edit);
+extern void __key_link(struct key *keyring, struct key *key,
+		       struct assoc_array_edit **_edit);
 extern void __key_link_end(struct key *keyring,
 			   const struct keyring_index_key *index_key,
 			   struct assoc_array_edit *edit);
@@ -181,6 +183,23 @@ extern int key_task_permission(const key_ref_t key_ref,
 			       const struct cred *cred,
 			       key_perm_t perm);
 
+static inline void notify_key(struct key *key,
+			      enum key_notification_subtype subtype, u32 aux)
+{
+#ifdef CONFIG_KEY_NOTIFICATIONS
+	struct key_notification n = {
+		.watch.type	= WATCH_TYPE_KEY_NOTIFY,
+		.watch.subtype	= subtype,
+		.watch.info	= watch_sizeof(n),
+		.key_id		= key_serial(key),
+		.aux		= aux,
+	};
+
+	post_watch_notification(key->watchers, &n.watch, current_cred(),
+				n.key_id);
+#endif
+}
+
 /*
  * Check to see whether permission is granted to use a key in the desired way.
  */
@@ -331,6 +350,15 @@ static inline long keyctl_pkey_e_d_s(int op,
 
 extern long keyctl_capabilities(unsigned char __user *_buffer, size_t buflen);
 
+#ifdef CONFIG_KEY_NOTIFICATIONS
+extern long keyctl_watch_key(key_serial_t, int, int);
+#else
+static inline long keyctl_watch_key(key_serial_t key_id, int watch_fd, int watch_id)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
 /*
  * Debugging key validation
  */
diff --git a/security/keys/key.c b/security/keys/key.c
index 764f4c57913e..83e8d7c4bb6f 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -443,6 +443,7 @@ static int __key_instantiate_and_link(struct key *key,
 			/* mark the key as being instantiated */
 			atomic_inc(&key->user->nikeys);
 			mark_key_instantiated(key, 0);
+			notify_key(key, NOTIFY_KEY_INSTANTIATED, 0);
 
 			if (test_and_clear_bit(KEY_FLAG_USER_CONSTRUCT, &key->flags))
 				awaken = 1;
@@ -452,7 +453,7 @@ static int __key_instantiate_and_link(struct key *key,
 				if (test_bit(KEY_FLAG_KEEP, &keyring->flags))
 					set_bit(KEY_FLAG_KEEP, &key->flags);
 
-				__key_link(key, _edit);
+				__key_link(keyring, key, _edit);
 			}
 
 			/* disable the authorisation key */
@@ -600,6 +601,7 @@ int key_reject_and_link(struct key *key,
 		/* mark the key as being negatively instantiated */
 		atomic_inc(&key->user->nikeys);
 		mark_key_instantiated(key, -error);
+		notify_key(key, NOTIFY_KEY_INSTANTIATED, -error);
 		key->expiry = ktime_get_real_seconds() + timeout;
 		key_schedule_gc(key->expiry + key_gc_delay);
 
@@ -610,7 +612,7 @@ int key_reject_and_link(struct key *key,
 
 		/* and link it into the destination keyring */
 		if (keyring && link_ret == 0)
-			__key_link(key, &edit);
+			__key_link(keyring, key, &edit);
 
 		/* disable the authorisation key */
 		if (authkey)
@@ -763,9 +765,11 @@ static inline key_ref_t __key_update(key_ref_t key_ref,
 	down_write(&key->sem);
 
 	ret = key->type->update(key, prep);
-	if (ret == 0)
+	if (ret == 0) {
 		/* Updating a negative key positively instantiates it */
 		mark_key_instantiated(key, 0);
+		notify_key(key, NOTIFY_KEY_UPDATED, 0);
+	}
 
 	up_write(&key->sem);
 
@@ -1013,9 +1017,11 @@ int key_update(key_ref_t key_ref, const void *payload, size_t plen)
 	down_write(&key->sem);
 
 	ret = key->type->update(key, &prep);
-	if (ret == 0)
+	if (ret == 0) {
 		/* Updating a negative key positively instantiates it */
 		mark_key_instantiated(key, 0);
+		notify_key(key, NOTIFY_KEY_UPDATED, 0);
+	}
 
 	up_write(&key->sem);
 
@@ -1047,15 +1053,17 @@ void key_revoke(struct key *key)
 	 *   instantiated
 	 */
 	down_write_nested(&key->sem, 1);
-	if (!test_and_set_bit(KEY_FLAG_REVOKED, &key->flags) &&
-	    key->type->revoke)
-		key->type->revoke(key);
-
-	/* set the death time to no more than the expiry time */
-	time = ktime_get_real_seconds();
-	if (key->revoked_at == 0 || key->revoked_at > time) {
-		key->revoked_at = time;
-		key_schedule_gc(key->revoked_at + key_gc_delay);
+	if (!test_and_set_bit(KEY_FLAG_REVOKED, &key->flags)) {
+		notify_key(key, NOTIFY_KEY_REVOKED, 0);
+		if (key->type->revoke)
+			key->type->revoke(key);
+
+		/* set the death time to no more than the expiry time */
+		time = ktime_get_real_seconds();
+		if (key->revoked_at == 0 || key->revoked_at > time) {
+			key->revoked_at = time;
+			key_schedule_gc(key->revoked_at + key_gc_delay);
+		}
 	}
 
 	up_write(&key->sem);
@@ -1077,8 +1085,10 @@ void key_invalidate(struct key *key)
 
 	if (!test_bit(KEY_FLAG_INVALIDATED, &key->flags)) {
 		down_write_nested(&key->sem, 1);
-		if (!test_and_set_bit(KEY_FLAG_INVALIDATED, &key->flags))
+		if (!test_and_set_bit(KEY_FLAG_INVALIDATED, &key->flags)) {
+			notify_key(key, NOTIFY_KEY_INVALIDATED, 0);
 			key_schedule_gc_links();
+		}
 		up_write(&key->sem);
 	}
 }
diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index 9b898c969558..684d60228ac0 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -37,7 +37,9 @@ static const unsigned char keyrings_capabilities[2] = {
 	       KEYCTL_CAPS0_MOVE
 	       ),
 	[1] = (KEYCTL_CAPS1_NS_KEYRING_NAME |
-	       KEYCTL_CAPS1_NS_KEY_TAG),
+	       KEYCTL_CAPS1_NS_KEY_TAG |
+	       (IS_ENABLED(CONFIG_KEY_NOTIFICATIONS)	? KEYCTL_CAPS1_NOTIFICATIONS : 0)
+	       ),
 };
 
 static int key_get_type_from_user(char *type,
@@ -970,6 +972,7 @@ long keyctl_chown_key(key_serial_t id, uid_t user, gid_t group)
 	if (group != (gid_t) -1)
 		key->gid = gid;
 
+	notify_key(key, NOTIFY_KEY_SETATTR, 0);
 	ret = 0;
 
 error_put:
@@ -1020,6 +1023,7 @@ long keyctl_setperm_key(key_serial_t id, key_perm_t perm)
 	/* if we're not the sysadmin, we can only change a key that we own */
 	if (capable(CAP_SYS_ADMIN) || uid_eq(key->uid, current_fsuid())) {
 		key->perm = perm;
+		notify_key(key, NOTIFY_KEY_SETATTR, 0);
 		ret = 0;
 	}
 
@@ -1411,10 +1415,12 @@ long keyctl_set_timeout(key_serial_t id, unsigned timeout)
 okay:
 	key = key_ref_to_ptr(key_ref);
 	ret = 0;
-	if (test_bit(KEY_FLAG_KEEP, &key->flags))
+	if (test_bit(KEY_FLAG_KEEP, &key->flags)) {
 		ret = -EPERM;
-	else
+	} else {
 		key_set_timeout(key, timeout);
+		notify_key(key, NOTIFY_KEY_SETATTR, 0);
+	}
 	key_put(key);
 
 error:
@@ -1688,6 +1694,94 @@ long keyctl_restrict_keyring(key_serial_t id, const char __user *_type,
 	return ret;
 }
 
+#ifdef CONFIG_KEY_NOTIFICATIONS
+/*
+ * Watch for changes to a key.
+ *
+ * The caller must have View permission to watch a key or keyring.
+ */
+long keyctl_watch_key(key_serial_t id, int watch_queue_fd, int watch_id)
+{
+	struct watch_queue *wqueue;
+	struct watch_list *wlist = NULL;
+	struct watch *watch = NULL;
+	struct key *key;
+	key_ref_t key_ref;
+	long ret;
+
+	if (watch_id < -1 || watch_id > 0xff)
+		return -EINVAL;
+
+	key_ref = lookup_user_key(id, KEY_LOOKUP_CREATE, KEY_NEED_VIEW);
+	if (IS_ERR(key_ref))
+		return PTR_ERR(key_ref);
+	key = key_ref_to_ptr(key_ref);
+
+	wqueue = get_watch_queue(watch_queue_fd);
+	if (IS_ERR(wqueue)) {
+		ret = PTR_ERR(wqueue);
+		goto err_key;
+	}
+
+	if (watch_id >= 0) {
+		ret = -ENOMEM;
+		if (!key->watchers) {
+			wlist = kzalloc(sizeof(*wlist), GFP_KERNEL);
+			if (!wlist)
+				goto err_wqueue;
+			init_watch_list(wlist, NULL);
+		}
+
+		watch = kzalloc(sizeof(*watch), GFP_KERNEL);
+		if (!watch)
+			goto err_wlist;
+
+		init_watch(watch, wqueue);
+		watch->id	= key->serial;
+		watch->info_id	= (u32)watch_id << WATCH_INFO_ID__SHIFT;
+		watch->cred = get_current_cred();
+
+		ret = security_watch_key(watch, key);
+		if (ret < 0)
+			goto err_watch;
+
+		down_write(&key->sem);
+		if (!key->watchers) {
+			key->watchers = wlist;
+			wlist = NULL;
+		}
+
+		ret = add_watch_to_object(watch, key->watchers);
+		up_write(&key->sem);
+
+		if (ret == 0)
+			watch = NULL;
+	} else {
+		ret = -EBADSLT;
+		if (key->watchers) {
+			down_write(&key->sem);
+			ret = remove_watch_from_object(key->watchers,
+						       wqueue, key_serial(key),
+						       false);
+			up_write(&key->sem);
+		}
+	}
+
+err_watch:
+	if (watch) {
+		put_cred(watch->cred);
+		kfree(watch);
+	}
+err_wlist:
+	kfree(wlist);
+err_wqueue:
+	put_watch_queue(wqueue);
+err_key:
+	key_put(key);
+	return ret;
+}
+#endif /* CONFIG_KEY_NOTIFICATIONS */
+
 /*
  * Get keyrings subsystem capabilities.
  */
@@ -1857,6 +1951,9 @@ SYSCALL_DEFINE5(keyctl, int, option, unsigned long, arg2, unsigned long, arg3,
 	case KEYCTL_CAPABILITIES:
 		return keyctl_capabilities((unsigned char __user *)arg2, (size_t)arg3);
 
+	case KEYCTL_WATCH_KEY:
+		return keyctl_watch_key((key_serial_t)arg2, (int)arg3, (int)arg4);
+
 	default:
 		return -EOPNOTSUPP;
 	}
diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index febf36c6ddc5..40a0dcdfda44 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -1060,12 +1060,14 @@ int keyring_restrict(key_ref_t keyring_ref, const char *type,
 	down_write(&keyring->sem);
 	down_write(&keyring_serialise_restrict_sem);
 
-	if (keyring->restrict_link)
+	if (keyring->restrict_link) {
 		ret = -EEXIST;
-	else if (keyring_detect_restriction_cycle(keyring, restrict_link))
+	} else if (keyring_detect_restriction_cycle(keyring, restrict_link)) {
 		ret = -EDEADLK;
-	else
+	} else {
 		keyring->restrict_link = restrict_link;
+		notify_key(keyring, NOTIFY_KEY_SETATTR, 0);
+	}
 
 	up_write(&keyring_serialise_restrict_sem);
 	up_write(&keyring->sem);
@@ -1366,12 +1368,14 @@ int __key_link_check_live_key(struct key *keyring, struct key *key)
  * holds at most one link to any given key of a particular type+description
  * combination.
  */
-void __key_link(struct key *key, struct assoc_array_edit **_edit)
+void __key_link(struct key *keyring, struct key *key,
+		struct assoc_array_edit **_edit)
 {
 	__key_get(key);
 	assoc_array_insert_set_object(*_edit, keyring_key_to_ptr(key));
 	assoc_array_apply_edit(*_edit);
 	*_edit = NULL;
+	notify_key(keyring, NOTIFY_KEY_LINKED, key_serial(key));
 }
 
 /*
@@ -1455,7 +1459,7 @@ int key_link(struct key *keyring, struct key *key)
 	if (ret == 0)
 		ret = __key_link_check_live_key(keyring, key);
 	if (ret == 0)
-		__key_link(key, &edit);
+		__key_link(keyring, key, &edit);
 
 error_end:
 	__key_link_end(keyring, &key->index_key, edit);
@@ -1487,7 +1491,7 @@ static int __key_unlink_begin(struct key *keyring, struct key *key,
 	struct assoc_array_edit *edit;
 
 	BUG_ON(*_edit != NULL);
-	
+
 	edit = assoc_array_delete(&keyring->keys, &keyring_assoc_array_ops,
 				  &key->index_key);
 	if (IS_ERR(edit))
@@ -1507,6 +1511,7 @@ static void __key_unlink(struct key *keyring, struct key *key,
 			 struct assoc_array_edit **_edit)
 {
 	assoc_array_apply_edit(*_edit);
+	notify_key(keyring, NOTIFY_KEY_UNLINKED, key_serial(key));
 	*_edit = NULL;
 	key_payload_reserve(keyring, keyring->datalen - KEYQUOTA_LINK_BYTES);
 }
@@ -1625,7 +1630,7 @@ int key_move(struct key *key,
 		goto error;
 
 	__key_unlink(from_keyring, key, &from_edit);
-	__key_link(key, &to_edit);
+	__key_link(to_keyring, key, &to_edit);
 error:
 	__key_link_end(to_keyring, &key->index_key, to_edit);
 	__key_unlink_end(from_keyring, key, from_edit);
@@ -1659,6 +1664,7 @@ int keyring_clear(struct key *keyring)
 	} else {
 		if (edit)
 			assoc_array_apply_edit(edit);
+		notify_key(keyring, NOTIFY_KEY_CLEARED, 0);
 		key_payload_reserve(keyring, 0);
 		ret = 0;
 	}
diff --git a/security/keys/request_key.c b/security/keys/request_key.c
index 7325f382dbf4..430f24a461f5 100644
--- a/security/keys/request_key.c
+++ b/security/keys/request_key.c
@@ -418,7 +418,7 @@ static int construct_alloc_key(struct keyring_search_context *ctx,
 		goto key_already_present;
 
 	if (dest_keyring)
-		__key_link(key, &edit);
+		__key_link(dest_keyring, key, &edit);
 
 	mutex_unlock(&key_construction_mutex);
 	if (dest_keyring)
@@ -437,7 +437,7 @@ static int construct_alloc_key(struct keyring_search_context *ctx,
 	if (dest_keyring) {
 		ret = __key_link_check_live_key(dest_keyring, key);
 		if (ret == 0)
-			__key_link(key, &edit);
+			__key_link(dest_keyring, key, &edit);
 		__key_link_end(dest_keyring, &ctx->index_key, edit);
 		if (ret < 0)
 			goto link_check_failed;

