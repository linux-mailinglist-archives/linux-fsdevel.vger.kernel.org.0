Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27D0A38C9C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2019 16:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729416AbfFGOSZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jun 2019 10:18:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45512 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728442AbfFGOSZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jun 2019 10:18:25 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AA4EC30C31AB;
        Fri,  7 Jun 2019 14:18:23 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-173.rdu2.redhat.com [10.10.120.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A096C5C634;
        Fri,  7 Jun 2019 14:18:21 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 06/13] keys: Add a notification facility [ver #4]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 07 Jun 2019 15:18:19 +0100
Message-ID: <155991709983.15579.13232123365803197237.stgit@warthog.procyon.org.uk>
In-Reply-To: <155991702981.15579.6007568669839441045.stgit@warthog.procyon.org.uk>
References: <155991702981.15579.6007568669839441045.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Fri, 07 Jun 2019 14:18:24 +0000 (UTC)
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

 Documentation/security/keys/core.rst |   58 +++++++++++++++++++++
 include/linux/key.h                  |    4 +
 include/uapi/linux/keyctl.h          |    1 
 include/uapi/linux/watch_queue.h     |   25 +++++++++
 security/keys/Kconfig                |   10 ++++
 security/keys/compat.c               |    2 +
 security/keys/gc.c                   |    5 ++
 security/keys/internal.h             |   30 ++++++++++-
 security/keys/key.c                  |   37 ++++++++-----
 security/keys/keyctl.c               |   95 +++++++++++++++++++++++++++++++++-
 security/keys/keyring.c              |   17 ++++--
 security/keys/request_key.c          |    4 +
 12 files changed, 264 insertions(+), 24 deletions(-)

diff --git a/Documentation/security/keys/core.rst b/Documentation/security/keys/core.rst
index 9521c4207f01..05ef58c753f3 100644
--- a/Documentation/security/keys/core.rst
+++ b/Documentation/security/keys/core.rst
@@ -808,6 +808,7 @@ The keyctl syscall functions are:
      A process must have search permission on the key for this function to be
      successful.
 
+
   *  Compute a Diffie-Hellman shared secret or public key::
 
 	long keyctl(KEYCTL_DH_COMPUTE, struct keyctl_dh_params *params,
@@ -1001,6 +1002,63 @@ The keyctl syscall functions are:
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
index 7099985e35a9..f1c43852c0c6 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -159,6 +159,9 @@ struct key {
 		struct list_head graveyard_link;
 		struct rb_node	serial_node;
 	};
+#ifdef CONFIG_KEY_NOTIFICATIONS
+	struct watch_list	*watchers;	/* Entities watching this key for changes */
+#endif
 	struct rw_semaphore	sem;		/* change vs change sem */
 	struct key_user		*user;		/* owner of this key */
 	void			*security;	/* security data for this key */
@@ -193,6 +196,7 @@ struct key {
 #define KEY_FLAG_ROOT_CAN_INVAL	7	/* set if key can be invalidated by root without permission */
 #define KEY_FLAG_KEEP		8	/* set if key should not be removed */
 #define KEY_FLAG_UID_KEYRING	9	/* set if key is a user or user session keyring */
+#define KEY_FLAG_SET_WATCH_PROXY 10	/* Set if watch_proxy should be set on added keys */
 
 	/* the key type and key description string
 	 * - the desc is used to match a key against search criteria
diff --git a/include/uapi/linux/keyctl.h b/include/uapi/linux/keyctl.h
index f45ee0f69c0c..e9e7da849619 100644
--- a/include/uapi/linux/keyctl.h
+++ b/include/uapi/linux/keyctl.h
@@ -67,6 +67,7 @@
 #define KEYCTL_PKEY_SIGN		27	/* Create a public key signature */
 #define KEYCTL_PKEY_VERIFY		28	/* Verify a public key signature */
 #define KEYCTL_RESTRICT_KEYRING		29	/* Restrict keys allowed to link to a keyring */
+#define KEYCTL_WATCH_KEY		30	/* Watch a key or ring of keys for changes */
 
 /* keyctl structures */
 struct keyctl_dh_params {
diff --git a/include/uapi/linux/watch_queue.h b/include/uapi/linux/watch_queue.h
index 0e3e5672aa09..32177bcf85f1 100644
--- a/include/uapi/linux/watch_queue.h
+++ b/include/uapi/linux/watch_queue.h
@@ -80,4 +80,29 @@ struct watch_notification_filter {
 	struct watch_notification_type_filter filters[];
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
index 6462e6654ccf..fbe064fa0a17 100644
--- a/security/keys/Kconfig
+++ b/security/keys/Kconfig
@@ -101,3 +101,13 @@ config KEY_DH_OPERATIONS
 	 in the kernel.
 
 	 If you are unsure as to whether this is required, answer N.
+
+config KEY_NOTIFICATIONS
+	bool "Provide key/keyring change notifications"
+	depends on KEYS
+	select WATCH_QUEUE
+	help
+	  This option provides support for getting change notifications on keys
+	  and keyrings on which the caller has View permission.  This makes use
+	  of the /dev/watch_queue misc device to handle the notification
+	  buffer and provides KEYCTL_WATCH_KEY to enable/disable watches.
diff --git a/security/keys/compat.c b/security/keys/compat.c
index 9482df601dc3..021d8e1c9233 100644
--- a/security/keys/compat.c
+++ b/security/keys/compat.c
@@ -158,6 +158,8 @@ COMPAT_SYSCALL_DEFINE5(keyctl, u32, option,
 	case KEYCTL_PKEY_VERIFY:
 		return keyctl_pkey_verify(compat_ptr(arg2), compat_ptr(arg3),
 					  compat_ptr(arg4), compat_ptr(arg5));
+	case KEYCTL_WATCH_KEY:
+		return keyctl_watch_key(arg2, arg3, arg4);
 
 	default:
 		return -EOPNOTSUPP;
diff --git a/security/keys/gc.c b/security/keys/gc.c
index 634e96b380e8..b685b9a85a9e 100644
--- a/security/keys/gc.c
+++ b/security/keys/gc.c
@@ -135,6 +135,11 @@ static noinline void key_gc_unused_keys(struct list_head *keys)
 		kdebug("- %u", key->serial);
 		key_check(key);
 
+#ifdef CONFIG_KEY_NOTIFICATIONS
+		remove_watch_list(key->watchers);
+		key->watchers = NULL;
+#endif
+
 		/* Throw away the key data if the key is instantiated */
 		if (state == KEY_IS_POSITIVE && key->type->destroy)
 			key->type->destroy(key);
diff --git a/security/keys/internal.h b/security/keys/internal.h
index 8f533c81aa8d..a7ac0f823ade 100644
--- a/security/keys/internal.h
+++ b/security/keys/internal.h
@@ -19,6 +19,7 @@
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
@@ -178,6 +180,23 @@ extern int key_task_permission(const key_ref_t key_ref,
 			       const struct cred *cred,
 			       key_perm_t perm);
 
+static inline void notify_key(struct key *key,
+			      enum key_notification_subtype subtype, u32 aux)
+{
+#ifdef CONFIG_KEY_NOTIFICATIONS
+	struct key_notification n = {
+		.watch.type	= WATCH_TYPE_KEY_NOTIFY,
+		.watch.subtype	= subtype,
+		.watch.info	= sizeof(n),
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
@@ -324,6 +343,15 @@ static inline long keyctl_pkey_e_d_s(int op,
 }
 #endif
 
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
index 696f1c092c50..9d9f94992470 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -412,6 +412,7 @@ static void mark_key_instantiated(struct key *key, int reject_error)
 	 */
 	smp_store_release(&key->state,
 			  (reject_error < 0) ? reject_error : KEY_IS_POSITIVE);
+	notify_key(key, NOTIFY_KEY_INSTANTIATED, reject_error);
 }
 
 /*
@@ -454,7 +455,7 @@ static int __key_instantiate_and_link(struct key *key,
 				if (test_bit(KEY_FLAG_KEEP, &keyring->flags))
 					set_bit(KEY_FLAG_KEEP, &key->flags);
 
-				__key_link(key, _edit);
+				__key_link(keyring, key, _edit);
 			}
 
 			/* disable the authorisation key */
@@ -603,7 +604,7 @@ int key_reject_and_link(struct key *key,
 
 		/* and link it into the destination keyring */
 		if (keyring && link_ret == 0)
-			__key_link(key, &edit);
+			__key_link(keyring, key, &edit);
 
 		/* disable the authorisation key */
 		if (authkey)
@@ -756,9 +757,11 @@ static inline key_ref_t __key_update(key_ref_t key_ref,
 	down_write(&key->sem);
 
 	ret = key->type->update(key, prep);
-	if (ret == 0)
+	if (ret == 0) {
 		/* Updating a negative key positively instantiates it */
 		mark_key_instantiated(key, 0);
+		notify_key(key, NOTIFY_KEY_UPDATED, 0);
+	}
 
 	up_write(&key->sem);
 
@@ -999,9 +1002,11 @@ int key_update(key_ref_t key_ref, const void *payload, size_t plen)
 	down_write(&key->sem);
 
 	ret = key->type->update(key, &prep);
-	if (ret == 0)
+	if (ret == 0) {
 		/* Updating a negative key positively instantiates it */
 		mark_key_instantiated(key, 0);
+		notify_key(key, NOTIFY_KEY_UPDATED, 0);
+	}
 
 	up_write(&key->sem);
 
@@ -1033,15 +1038,17 @@ void key_revoke(struct key *key)
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
@@ -1063,8 +1070,10 @@ void key_invalidate(struct key *key)
 
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
index 3e4053a217c3..f3b71efd76c5 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -914,6 +914,7 @@ long keyctl_chown_key(key_serial_t id, uid_t user, gid_t group)
 	if (group != (gid_t) -1)
 		key->gid = gid;
 
+	notify_key(key, NOTIFY_KEY_SETATTR, 0);
 	ret = 0;
 
 error_put:
@@ -964,6 +965,7 @@ long keyctl_setperm_key(key_serial_t id, key_perm_t perm)
 	/* if we're not the sysadmin, we can only change a key that we own */
 	if (capable(CAP_SYS_ADMIN) || uid_eq(key->uid, current_fsuid())) {
 		key->perm = perm;
+		notify_key(key, NOTIFY_KEY_SETATTR, 0);
 		ret = 0;
 	}
 
@@ -1355,10 +1357,12 @@ long keyctl_set_timeout(key_serial_t id, unsigned timeout)
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
@@ -1631,6 +1635,90 @@ long keyctl_restrict_keyring(key_serial_t id, const char __user *_type,
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
+	struct watch *watch;
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
+		watch->info_id	= (u32)watch_id << 24;
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
+	kfree(watch);
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
  * The key control system call
  */
@@ -1771,6 +1859,9 @@ SYSCALL_DEFINE5(keyctl, int, option, unsigned long, arg2, unsigned long, arg3,
 			(const void __user *)arg4,
 			(const void __user *)arg5);
 
+	case KEYCTL_WATCH_KEY:
+		return keyctl_watch_key((key_serial_t)arg2, (int)arg3, (int)arg4);
+
 	default:
 		return -EOPNOTSUPP;
 	}
diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index e14f09e3a4b0..f0f9ab3c5587 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -1018,12 +1018,14 @@ int keyring_restrict(key_ref_t keyring_ref, const char *type,
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
@@ -1286,12 +1288,14 @@ int __key_link_check_live_key(struct key *keyring, struct key *key)
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
@@ -1369,7 +1373,7 @@ int key_link(struct key *keyring, struct key *key)
 		if (ret == 0)
 			ret = __key_link_check_live_key(keyring, key);
 		if (ret == 0)
-			__key_link(key, &edit);
+			__key_link(keyring, key, &edit);
 		__key_link_end(keyring, &key->index_key, edit);
 	}
 
@@ -1398,6 +1402,7 @@ EXPORT_SYMBOL(key_link);
 int key_unlink(struct key *keyring, struct key *key)
 {
 	struct assoc_array_edit *edit;
+	key_serial_t target = key_serial(key);
 	int ret;
 
 	key_check(keyring);
@@ -1419,6 +1424,7 @@ int key_unlink(struct key *keyring, struct key *key)
 		goto error;
 
 	assoc_array_apply_edit(edit);
+	notify_key(keyring, NOTIFY_KEY_UNLINKED, target);
 	key_payload_reserve(keyring, keyring->datalen - KEYQUOTA_LINK_BYTES);
 	ret = 0;
 
@@ -1452,6 +1458,7 @@ int keyring_clear(struct key *keyring)
 	} else {
 		if (edit)
 			assoc_array_apply_edit(edit);
+		notify_key(keyring, NOTIFY_KEY_CLEARED, 0);
 		key_payload_reserve(keyring, 0);
 		ret = 0;
 	}
diff --git a/security/keys/request_key.c b/security/keys/request_key.c
index 75d87f9e0f49..5f474d0e8620 100644
--- a/security/keys/request_key.c
+++ b/security/keys/request_key.c
@@ -387,7 +387,7 @@ static int construct_alloc_key(struct keyring_search_context *ctx,
 		goto key_already_present;
 
 	if (dest_keyring)
-		__key_link(key, &edit);
+		__key_link(dest_keyring, key, &edit);
 
 	mutex_unlock(&key_construction_mutex);
 	if (dest_keyring)
@@ -406,7 +406,7 @@ static int construct_alloc_key(struct keyring_search_context *ctx,
 	if (dest_keyring) {
 		ret = __key_link_check_live_key(dest_keyring, key);
 		if (ret == 0)
-			__key_link(key, &edit);
+			__key_link(dest_keyring, key, &edit);
 		__key_link_end(dest_keyring, &ctx->index_key, edit);
 		if (ret < 0)
 			goto link_check_failed;

