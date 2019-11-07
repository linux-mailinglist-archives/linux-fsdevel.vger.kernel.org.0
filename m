Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9E30F2FAD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2019 14:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389108AbfKGNg1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Nov 2019 08:36:27 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50444 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389106AbfKGNg0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Nov 2019 08:36:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573133784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2x89H88+vsUI4h/cKoykpGBr8HegQCKhplPqXdO3yrQ=;
        b=Em/IJnaqurH2s54dGqt1vIbSzUq6EFnVR/dK++eY9XJLgf7SjA2JOmPjTqnc4+Q4hvp8hS
        rYxtfpgT4URFzeVZ6CRlZprg5smglxEJNQWzt7g1EEIjA3FTeuFZBmYIrnPS9Q0/l/RZcY
        GnFGfIGr2KeKHwvi8FRsl2TudZHiU2Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-pb20McY9M_2OZEtZDWPt0w-1; Thu, 07 Nov 2019 08:36:21 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51683800C61;
        Thu,  7 Nov 2019 13:36:19 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-254.rdu2.redhat.com [10.10.120.254])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6E4685DA81;
        Thu,  7 Nov 2019 13:36:16 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 06/14] keys: Add a notification facility [ver #2]
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
Date:   Thu, 07 Nov 2019 13:36:15 +0000
Message-ID: <157313377569.29677.12622113665197554885.stgit@warthog.procyon.org.uk>
In-Reply-To: <157313371694.29677.15388731274912671071.stgit@warthog.procyon.org.uk>
References: <157313371694.29677.15388731274912671071.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: pb20McY9M_2OZEtZDWPt0w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a key/keyring change notification facility whereby notifications about
changes in key and keyring content and attributes can be received.

Firstly, an event queue needs to be created:

=09pipe2(fds, O_NOTIFICATION_PIPE);
=09ioctl(fds[1], IOC_WATCH_QUEUE_SET_SIZE, 256);

then a notification can be set up to report notifications via that queue:

=09struct watch_notification_filter filter =3D {
=09=09.nr_filters =3D 1,
=09=09.filters =3D {
=09=09=09[0] =3D {
=09=09=09=09.type =3D WATCH_TYPE_KEY_NOTIFY,
=09=09=09=09.subtype_filter[0] =3D UINT_MAX,
=09=09=09},
=09=09},
=09};
=09ioctl(fds[1], IOC_WATCH_QUEUE_SET_FILTER, &filter);
=09keyctl_watch_key(KEY_SPEC_SESSION_KEYRING, fds[1], 0x01);

After that, records will be placed into the queue when events occur in
which keys are changed in some way.  Records are of the following format:

=09struct key_notification {
=09=09struct watch_notification watch;
=09=09__u32=09key_id;
=09=09__u32=09aux;
=09} *n;

Where:

=09n->watch.type will be WATCH_TYPE_KEY_NOTIFY.

=09n->watch.subtype will indicate the type of event, such as
=09NOTIFY_KEY_REVOKED.

=09n->watch.info & WATCH_INFO_LENGTH will indicate the length of the
=09record.

=09n->watch.info & WATCH_INFO_ID will be the second argument to
=09keyctl_watch_key(), shifted.

=09n->key will be the ID of the affected key.

=09n->aux will hold subtype-dependent information, such as the key
=09being linked into the keyring specified by n->key in the case of
=09NOTIFY_KEY_LINKED.

Note that it is permissible for event records to be of variable length -
or, at least, the length may be dependent on the subtype.  Note also that
the queue can be shared between multiple notifications of various types.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 Documentation/security/keys/core.rst |   58 ++++++++++++++++++++
 include/linux/key.h                  |    3 +
 include/uapi/linux/keyctl.h          |    2 +
 include/uapi/linux/watch_queue.h     |   28 +++++++++-
 security/keys/Kconfig                |    9 +++
 security/keys/compat.c               |    3 +
 security/keys/gc.c                   |    5 ++
 security/keys/internal.h             |   30 ++++++++++
 security/keys/key.c                  |   38 ++++++++-----
 security/keys/keyctl.c               |   99 ++++++++++++++++++++++++++++++=
+++-
 security/keys/keyring.c              |   20 ++++---
 security/keys/request_key.c          |    4 +
 12 files changed, 271 insertions(+), 28 deletions(-)

diff --git a/Documentation/security/keys/core.rst b/Documentation/security/=
keys/core.rst
index d6d8b0b756b6..957179f8cea9 100644
--- a/Documentation/security/keys/core.rst
+++ b/Documentation/security/keys/core.rst
@@ -833,6 +833,7 @@ The keyctl syscall functions are:
      A process must have search permission on the key for this function to=
 be
      successful.
=20
+
   *  Compute a Diffie-Hellman shared secret or public key::
=20
 =09long keyctl(KEYCTL_DH_COMPUTE, struct keyctl_dh_params *params,
@@ -1026,6 +1027,63 @@ The keyctl syscall functions are:
      written into the output buffer.  Verification returns 0 on success.
=20
=20
+  *  Watch a key or keyring for changes::
+
+=09long keyctl(KEYCTL_WATCH_KEY, key_serial_t key, int queue_fd,
+=09=09    const struct watch_notification_filter *filter);
+
+     This will set or remove a watch for changes on the specified key or
+     keyring.
+
+     "key" is the ID of the key to be watched.
+
+     "queue_fd" is a file descriptor referring to an open "/dev/watch_queu=
e"
+     which manages the buffer into which notifications will be delivered.
+
+     "filter" is either NULL to remove a watch or a filter specification t=
o
+     indicate what events are required from the key.
+
+     See Documentation/watch_queue.rst for more information.
+
+     Note that only one watch may be emplaced for any particular { key,
+     queue_fd } combination.
+
+     Notification records look like::
+
+=09struct key_notification {
+=09=09struct watch_notification watch;
+=09=09__u32=09key_id;
+=09=09__u32=09aux;
+=09};
+
+     In this, watch::type will be "WATCH_TYPE_KEY_NOTIFY" and subtype will=
 be
+     one of::
+
+=09NOTIFY_KEY_INSTANTIATED
+=09NOTIFY_KEY_UPDATED
+=09NOTIFY_KEY_LINKED
+=09NOTIFY_KEY_UNLINKED
+=09NOTIFY_KEY_CLEARED
+=09NOTIFY_KEY_REVOKED
+=09NOTIFY_KEY_INVALIDATED
+=09NOTIFY_KEY_SETATTR
+
+     Where these indicate a key being instantiated/rejected, updated, a li=
nk
+     being made in a keyring, a link being removed from a keyring, a keyri=
ng
+     being cleared, a key being revoked, a key being invalidated or a key
+     having one of its attributes changed (user, group, perm, timeout,
+     restriction).
+
+     If a watched key is deleted, a basic watch_notification will be issue=
d
+     with "type" set to WATCH_TYPE_META and "subtype" set to
+     watch_meta_removal_notification.  The watchpoint ID will be set in th=
e
+     "info" field.
+
+     This needs to be configured by enabling:
+
+=09"Provide key/keyring change notifications" (KEY_NOTIFICATIONS)
+
+
 Kernel Services
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
diff --git a/include/linux/key.h b/include/linux/key.h
index 6cf8e71cf8b7..b99b40db08fc 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -176,6 +176,9 @@ struct key {
 =09=09struct list_head graveyard_link;
 =09=09struct rb_node=09serial_node;
 =09};
+#ifdef CONFIG_KEY_NOTIFICATIONS
+=09struct watch_list=09*watchers;=09/* Entities watching this key for chan=
ges */
+#endif
 =09struct rw_semaphore=09sem;=09=09/* change vs change sem */
 =09struct key_user=09=09*user;=09=09/* owner of this key */
 =09void=09=09=09*security;=09/* security data for this key */
diff --git a/include/uapi/linux/keyctl.h b/include/uapi/linux/keyctl.h
index ed3d5893830d..4c8884eea808 100644
--- a/include/uapi/linux/keyctl.h
+++ b/include/uapi/linux/keyctl.h
@@ -69,6 +69,7 @@
 #define KEYCTL_RESTRICT_KEYRING=09=0929=09/* Restrict keys allowed to link=
 to a keyring */
 #define KEYCTL_MOVE=09=09=0930=09/* Move keys between keyrings */
 #define KEYCTL_CAPABILITIES=09=0931=09/* Find capabilities of keyrings sub=
system */
+#define KEYCTL_WATCH_KEY=09=0932=09/* Watch a key or ring of keys for chan=
ges */
=20
 /* keyctl structures */
 struct keyctl_dh_params {
@@ -130,5 +131,6 @@ struct keyctl_pkey_params {
 #define KEYCTL_CAPS0_MOVE=09=090x80 /* KEYCTL_MOVE supported */
 #define KEYCTL_CAPS1_NS_KEYRING_NAME=090x01 /* Keyring names are per-user_=
namespace */
 #define KEYCTL_CAPS1_NS_KEY_TAG=09=090x02 /* Key indexing can include a na=
mespace tag */
+#define KEYCTL_CAPS1_NOTIFICATIONS=090x04 /* Keys generate watchable notif=
ications */
=20
 #endif /*  _LINUX_KEYCTL_H */
diff --git a/include/uapi/linux/watch_queue.h b/include/uapi/linux/watch_qu=
eue.h
index 3a5790f1f05d..c3d8320b5d3a 100644
--- a/include/uapi/linux/watch_queue.h
+++ b/include/uapi/linux/watch_queue.h
@@ -13,7 +13,8 @@
=20
 enum watch_notification_type {
 =09WATCH_TYPE_META=09=09=3D 0,=09/* Special record */
-=09WATCH_TYPE__NR=09=09=3D 1
+=09WATCH_TYPE_KEY_NOTIFY=09=3D 1,=09/* Key change event notification */
+=09WATCH_TYPE__NR=09=09=3D 2
 };
=20
 enum watch_meta_notification_subtype {
@@ -75,4 +76,29 @@ struct watch_notification_removal {
 =09__u64=09id;=09=09/* Type-dependent identifier */
 };
=20
+/*
+ * Type of key/keyring change notification.
+ */
+enum key_notification_subtype {
+=09NOTIFY_KEY_INSTANTIATED=09=3D 0, /* Key was instantiated (aux is error =
code) */
+=09NOTIFY_KEY_UPDATED=09=3D 1, /* Key was updated */
+=09NOTIFY_KEY_LINKED=09=3D 2, /* Key (aux) was added to watched keyring */
+=09NOTIFY_KEY_UNLINKED=09=3D 3, /* Key (aux) was removed from watched keyr=
ing */
+=09NOTIFY_KEY_CLEARED=09=3D 4, /* Keyring was cleared */
+=09NOTIFY_KEY_REVOKED=09=3D 5, /* Key was revoked */
+=09NOTIFY_KEY_INVALIDATED=09=3D 6, /* Key was invalidated */
+=09NOTIFY_KEY_SETATTR=09=3D 7, /* Key's attributes got changed */
+};
+
+/*
+ * Key/keyring notification record.
+ * - watch.type =3D WATCH_TYPE_KEY_NOTIFY
+ * - watch.subtype =3D enum key_notification_type
+ */
+struct key_notification {
+=09struct watch_notification watch;
+=09__u32=09key_id;=09=09/* The key/keyring affected */
+=09__u32=09aux;=09=09/* Per-type auxiliary data */
+};
+
 #endif /* _UAPI_LINUX_WATCH_QUEUE_H */
diff --git a/security/keys/Kconfig b/security/keys/Kconfig
index dd313438fecf..20791a556b58 100644
--- a/security/keys/Kconfig
+++ b/security/keys/Kconfig
@@ -120,3 +120,12 @@ config KEY_DH_OPERATIONS
 =09 in the kernel.
=20
 =09 If you are unsure as to whether this is required, answer N.
+
+config KEY_NOTIFICATIONS
+=09bool "Provide key/keyring change notifications"
+=09depends on KEYS && WATCH_QUEUE
+=09help
+=09  This option provides support for getting change notifications on keys
+=09  and keyrings on which the caller has View permission.  This makes use
+=09  of the /dev/watch_queue misc device to handle the notification
+=09  buffer and provides KEYCTL_WATCH_KEY to enable/disable watches.
diff --git a/security/keys/compat.c b/security/keys/compat.c
index 9bcc404131aa..ac5a4fd0d7ea 100644
--- a/security/keys/compat.c
+++ b/security/keys/compat.c
@@ -161,6 +161,9 @@ COMPAT_SYSCALL_DEFINE5(keyctl, u32, option,
 =09case KEYCTL_CAPABILITIES:
 =09=09return keyctl_capabilities(compat_ptr(arg2), arg3);
=20
+=09case KEYCTL_WATCH_KEY:
+=09=09return keyctl_watch_key(arg2, arg3, arg4);
+
 =09default:
 =09=09return -EOPNOTSUPP;
 =09}
diff --git a/security/keys/gc.c b/security/keys/gc.c
index 671dd730ecfc..3c90807476eb 100644
--- a/security/keys/gc.c
+++ b/security/keys/gc.c
@@ -131,6 +131,11 @@ static noinline void key_gc_unused_keys(struct list_he=
ad *keys)
 =09=09kdebug("- %u", key->serial);
 =09=09key_check(key);
=20
+#ifdef CONFIG_KEY_NOTIFICATIONS
+=09=09remove_watch_list(key->watchers, key->serial);
+=09=09key->watchers =3D NULL;
+#endif
+
 =09=09/* Throw away the key data if the key is instantiated */
 =09=09if (state =3D=3D KEY_IS_POSITIVE && key->type->destroy)
 =09=09=09key->type->destroy(key);
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
=20
 struct iovec;
@@ -97,7 +98,8 @@ extern int __key_link_begin(struct key *keyring,
 =09=09=09    const struct keyring_index_key *index_key,
 =09=09=09    struct assoc_array_edit **_edit);
 extern int __key_link_check_live_key(struct key *keyring, struct key *key)=
;
-extern void __key_link(struct key *key, struct assoc_array_edit **_edit);
+extern void __key_link(struct key *keyring, struct key *key,
+=09=09       struct assoc_array_edit **_edit);
 extern void __key_link_end(struct key *keyring,
 =09=09=09   const struct keyring_index_key *index_key,
 =09=09=09   struct assoc_array_edit *edit);
@@ -181,6 +183,23 @@ extern int key_task_permission(const key_ref_t key_ref=
,
 =09=09=09       const struct cred *cred,
 =09=09=09       key_perm_t perm);
=20
+static inline void notify_key(struct key *key,
+=09=09=09      enum key_notification_subtype subtype, u32 aux)
+{
+#ifdef CONFIG_KEY_NOTIFICATIONS
+=09struct key_notification n =3D {
+=09=09.watch.type=09=3D WATCH_TYPE_KEY_NOTIFY,
+=09=09.watch.subtype=09=3D subtype,
+=09=09.watch.info=09=3D watch_sizeof(n),
+=09=09.key_id=09=09=3D key_serial(key),
+=09=09.aux=09=09=3D aux,
+=09};
+
+=09post_watch_notification(key->watchers, &n.watch, current_cred(),
+=09=09=09=09n.key_id);
+#endif
+}
+
 /*
  * Check to see whether permission is granted to use a key in the desired =
way.
  */
@@ -331,6 +350,15 @@ static inline long keyctl_pkey_e_d_s(int op,
=20
 extern long keyctl_capabilities(unsigned char __user *_buffer, size_t bufl=
en);
=20
+#ifdef CONFIG_KEY_NOTIFICATIONS
+extern long keyctl_watch_key(key_serial_t, int, int);
+#else
+static inline long keyctl_watch_key(key_serial_t key_id, int watch_fd, int=
 watch_id)
+{
+=09return -EOPNOTSUPP;
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
 =09=09=09/* mark the key as being instantiated */
 =09=09=09atomic_inc(&key->user->nikeys);
 =09=09=09mark_key_instantiated(key, 0);
+=09=09=09notify_key(key, NOTIFY_KEY_INSTANTIATED, 0);
=20
 =09=09=09if (test_and_clear_bit(KEY_FLAG_USER_CONSTRUCT, &key->flags))
 =09=09=09=09awaken =3D 1;
@@ -452,7 +453,7 @@ static int __key_instantiate_and_link(struct key *key,
 =09=09=09=09if (test_bit(KEY_FLAG_KEEP, &keyring->flags))
 =09=09=09=09=09set_bit(KEY_FLAG_KEEP, &key->flags);
=20
-=09=09=09=09__key_link(key, _edit);
+=09=09=09=09__key_link(keyring, key, _edit);
 =09=09=09}
=20
 =09=09=09/* disable the authorisation key */
@@ -600,6 +601,7 @@ int key_reject_and_link(struct key *key,
 =09=09/* mark the key as being negatively instantiated */
 =09=09atomic_inc(&key->user->nikeys);
 =09=09mark_key_instantiated(key, -error);
+=09=09notify_key(key, NOTIFY_KEY_INSTANTIATED, -error);
 =09=09key->expiry =3D ktime_get_real_seconds() + timeout;
 =09=09key_schedule_gc(key->expiry + key_gc_delay);
=20
@@ -610,7 +612,7 @@ int key_reject_and_link(struct key *key,
=20
 =09=09/* and link it into the destination keyring */
 =09=09if (keyring && link_ret =3D=3D 0)
-=09=09=09__key_link(key, &edit);
+=09=09=09__key_link(keyring, key, &edit);
=20
 =09=09/* disable the authorisation key */
 =09=09if (authkey)
@@ -763,9 +765,11 @@ static inline key_ref_t __key_update(key_ref_t key_ref=
,
 =09down_write(&key->sem);
=20
 =09ret =3D key->type->update(key, prep);
-=09if (ret =3D=3D 0)
+=09if (ret =3D=3D 0) {
 =09=09/* Updating a negative key positively instantiates it */
 =09=09mark_key_instantiated(key, 0);
+=09=09notify_key(key, NOTIFY_KEY_UPDATED, 0);
+=09}
=20
 =09up_write(&key->sem);
=20
@@ -1013,9 +1017,11 @@ int key_update(key_ref_t key_ref, const void *payloa=
d, size_t plen)
 =09down_write(&key->sem);
=20
 =09ret =3D key->type->update(key, &prep);
-=09if (ret =3D=3D 0)
+=09if (ret =3D=3D 0) {
 =09=09/* Updating a negative key positively instantiates it */
 =09=09mark_key_instantiated(key, 0);
+=09=09notify_key(key, NOTIFY_KEY_UPDATED, 0);
+=09}
=20
 =09up_write(&key->sem);
=20
@@ -1047,15 +1053,17 @@ void key_revoke(struct key *key)
 =09 *   instantiated
 =09 */
 =09down_write_nested(&key->sem, 1);
-=09if (!test_and_set_bit(KEY_FLAG_REVOKED, &key->flags) &&
-=09    key->type->revoke)
-=09=09key->type->revoke(key);
-
-=09/* set the death time to no more than the expiry time */
-=09time =3D ktime_get_real_seconds();
-=09if (key->revoked_at =3D=3D 0 || key->revoked_at > time) {
-=09=09key->revoked_at =3D time;
-=09=09key_schedule_gc(key->revoked_at + key_gc_delay);
+=09if (!test_and_set_bit(KEY_FLAG_REVOKED, &key->flags)) {
+=09=09notify_key(key, NOTIFY_KEY_REVOKED, 0);
+=09=09if (key->type->revoke)
+=09=09=09key->type->revoke(key);
+
+=09=09/* set the death time to no more than the expiry time */
+=09=09time =3D ktime_get_real_seconds();
+=09=09if (key->revoked_at =3D=3D 0 || key->revoked_at > time) {
+=09=09=09key->revoked_at =3D time;
+=09=09=09key_schedule_gc(key->revoked_at + key_gc_delay);
+=09=09}
 =09}
=20
 =09up_write(&key->sem);
@@ -1077,8 +1085,10 @@ void key_invalidate(struct key *key)
=20
 =09if (!test_bit(KEY_FLAG_INVALIDATED, &key->flags)) {
 =09=09down_write_nested(&key->sem, 1);
-=09=09if (!test_and_set_bit(KEY_FLAG_INVALIDATED, &key->flags))
+=09=09if (!test_and_set_bit(KEY_FLAG_INVALIDATED, &key->flags)) {
+=09=09=09notify_key(key, NOTIFY_KEY_INVALIDATED, 0);
 =09=09=09key_schedule_gc_links();
+=09=09}
 =09=09up_write(&key->sem);
 =09}
 }
diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index 9b898c969558..6610649514fb 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -37,7 +37,9 @@ static const unsigned char keyrings_capabilities[2] =3D {
 =09       KEYCTL_CAPS0_MOVE
 =09       ),
 =09[1] =3D (KEYCTL_CAPS1_NS_KEYRING_NAME |
-=09       KEYCTL_CAPS1_NS_KEY_TAG),
+=09       KEYCTL_CAPS1_NS_KEY_TAG |
+=09       (IS_ENABLED(CONFIG_KEY_NOTIFICATIONS)=09? KEYCTL_CAPS1_NOTIFICAT=
IONS : 0)
+=09       ),
 };
=20
 static int key_get_type_from_user(char *type,
@@ -970,6 +972,7 @@ long keyctl_chown_key(key_serial_t id, uid_t user, gid_=
t group)
 =09if (group !=3D (gid_t) -1)
 =09=09key->gid =3D gid;
=20
+=09notify_key(key, NOTIFY_KEY_SETATTR, 0);
 =09ret =3D 0;
=20
 error_put:
@@ -1020,6 +1023,7 @@ long keyctl_setperm_key(key_serial_t id, key_perm_t p=
erm)
 =09/* if we're not the sysadmin, we can only change a key that we own */
 =09if (capable(CAP_SYS_ADMIN) || uid_eq(key->uid, current_fsuid())) {
 =09=09key->perm =3D perm;
+=09=09notify_key(key, NOTIFY_KEY_SETATTR, 0);
 =09=09ret =3D 0;
 =09}
=20
@@ -1411,10 +1415,12 @@ long keyctl_set_timeout(key_serial_t id, unsigned t=
imeout)
 okay:
 =09key =3D key_ref_to_ptr(key_ref);
 =09ret =3D 0;
-=09if (test_bit(KEY_FLAG_KEEP, &key->flags))
+=09if (test_bit(KEY_FLAG_KEEP, &key->flags)) {
 =09=09ret =3D -EPERM;
-=09else
+=09} else {
 =09=09key_set_timeout(key, timeout);
+=09=09notify_key(key, NOTIFY_KEY_SETATTR, 0);
+=09}
 =09key_put(key);
=20
 error:
@@ -1688,6 +1694,90 @@ long keyctl_restrict_keyring(key_serial_t id, const =
char __user *_type,
 =09return ret;
 }
=20
+#ifdef CONFIG_KEY_NOTIFICATIONS
+/*
+ * Watch for changes to a key.
+ *
+ * The caller must have View permission to watch a key or keyring.
+ */
+long keyctl_watch_key(key_serial_t id, int watch_queue_fd, int watch_id)
+{
+=09struct watch_queue *wqueue;
+=09struct watch_list *wlist =3D NULL;
+=09struct watch *watch =3D NULL;
+=09struct key *key;
+=09key_ref_t key_ref;
+=09long ret;
+
+=09if (watch_id < -1 || watch_id > 0xff)
+=09=09return -EINVAL;
+
+=09key_ref =3D lookup_user_key(id, KEY_LOOKUP_CREATE, KEY_NEED_VIEW);
+=09if (IS_ERR(key_ref))
+=09=09return PTR_ERR(key_ref);
+=09key =3D key_ref_to_ptr(key_ref);
+
+=09wqueue =3D get_watch_queue(watch_queue_fd);
+=09if (IS_ERR(wqueue)) {
+=09=09ret =3D PTR_ERR(wqueue);
+=09=09goto err_key;
+=09}
+
+=09if (watch_id >=3D 0) {
+=09=09ret =3D -ENOMEM;
+=09=09if (!key->watchers) {
+=09=09=09wlist =3D kzalloc(sizeof(*wlist), GFP_KERNEL);
+=09=09=09if (!wlist)
+=09=09=09=09goto err_wqueue;
+=09=09=09init_watch_list(wlist, NULL);
+=09=09}
+
+=09=09watch =3D kzalloc(sizeof(*watch), GFP_KERNEL);
+=09=09if (!watch)
+=09=09=09goto err_wlist;
+
+=09=09init_watch(watch, wqueue);
+=09=09watch->id=09=3D key->serial;
+=09=09watch->info_id=09=3D (u32)watch_id << WATCH_INFO_ID__SHIFT;
+
+=09=09ret =3D security_watch_key(key);
+=09=09if (ret < 0)
+=09=09=09goto err_watch;
+
+=09=09down_write(&key->sem);
+=09=09if (!key->watchers) {
+=09=09=09key->watchers =3D wlist;
+=09=09=09wlist =3D NULL;
+=09=09}
+
+=09=09ret =3D add_watch_to_object(watch, key->watchers);
+=09=09up_write(&key->sem);
+
+=09=09if (ret =3D=3D 0)
+=09=09=09watch =3D NULL;
+=09} else {
+=09=09ret =3D -EBADSLT;
+=09=09if (key->watchers) {
+=09=09=09down_write(&key->sem);
+=09=09=09ret =3D remove_watch_from_object(key->watchers,
+=09=09=09=09=09=09       wqueue, key_serial(key),
+=09=09=09=09=09=09       false);
+=09=09=09up_write(&key->sem);
+=09=09}
+=09}
+
+err_watch:
+=09kfree(watch);
+err_wlist:
+=09kfree(wlist);
+err_wqueue:
+=09put_watch_queue(wqueue);
+err_key:
+=09key_put(key);
+=09return ret;
+}
+#endif /* CONFIG_KEY_NOTIFICATIONS */
+
 /*
  * Get keyrings subsystem capabilities.
  */
@@ -1857,6 +1947,9 @@ SYSCALL_DEFINE5(keyctl, int, option, unsigned long, a=
rg2, unsigned long, arg3,
 =09case KEYCTL_CAPABILITIES:
 =09=09return keyctl_capabilities((unsigned char __user *)arg2, (size_t)arg=
3);
=20
+=09case KEYCTL_WATCH_KEY:
+=09=09return keyctl_watch_key((key_serial_t)arg2, (int)arg3, (int)arg4);
+
 =09default:
 =09=09return -EOPNOTSUPP;
 =09}
diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index febf36c6ddc5..40a0dcdfda44 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -1060,12 +1060,14 @@ int keyring_restrict(key_ref_t keyring_ref, const c=
har *type,
 =09down_write(&keyring->sem);
 =09down_write(&keyring_serialise_restrict_sem);
=20
-=09if (keyring->restrict_link)
+=09if (keyring->restrict_link) {
 =09=09ret =3D -EEXIST;
-=09else if (keyring_detect_restriction_cycle(keyring, restrict_link))
+=09} else if (keyring_detect_restriction_cycle(keyring, restrict_link)) {
 =09=09ret =3D -EDEADLK;
-=09else
+=09} else {
 =09=09keyring->restrict_link =3D restrict_link;
+=09=09notify_key(keyring, NOTIFY_KEY_SETATTR, 0);
+=09}
=20
 =09up_write(&keyring_serialise_restrict_sem);
 =09up_write(&keyring->sem);
@@ -1366,12 +1368,14 @@ int __key_link_check_live_key(struct key *keyring, =
struct key *key)
  * holds at most one link to any given key of a particular type+descriptio=
n
  * combination.
  */
-void __key_link(struct key *key, struct assoc_array_edit **_edit)
+void __key_link(struct key *keyring, struct key *key,
+=09=09struct assoc_array_edit **_edit)
 {
 =09__key_get(key);
 =09assoc_array_insert_set_object(*_edit, keyring_key_to_ptr(key));
 =09assoc_array_apply_edit(*_edit);
 =09*_edit =3D NULL;
+=09notify_key(keyring, NOTIFY_KEY_LINKED, key_serial(key));
 }
=20
 /*
@@ -1455,7 +1459,7 @@ int key_link(struct key *keyring, struct key *key)
 =09if (ret =3D=3D 0)
 =09=09ret =3D __key_link_check_live_key(keyring, key);
 =09if (ret =3D=3D 0)
-=09=09__key_link(key, &edit);
+=09=09__key_link(keyring, key, &edit);
=20
 error_end:
 =09__key_link_end(keyring, &key->index_key, edit);
@@ -1487,7 +1491,7 @@ static int __key_unlink_begin(struct key *keyring, st=
ruct key *key,
 =09struct assoc_array_edit *edit;
=20
 =09BUG_ON(*_edit !=3D NULL);
-=09
+
 =09edit =3D assoc_array_delete(&keyring->keys, &keyring_assoc_array_ops,
 =09=09=09=09  &key->index_key);
 =09if (IS_ERR(edit))
@@ -1507,6 +1511,7 @@ static void __key_unlink(struct key *keyring, struct =
key *key,
 =09=09=09 struct assoc_array_edit **_edit)
 {
 =09assoc_array_apply_edit(*_edit);
+=09notify_key(keyring, NOTIFY_KEY_UNLINKED, key_serial(key));
 =09*_edit =3D NULL;
 =09key_payload_reserve(keyring, keyring->datalen - KEYQUOTA_LINK_BYTES);
 }
@@ -1625,7 +1630,7 @@ int key_move(struct key *key,
 =09=09goto error;
=20
 =09__key_unlink(from_keyring, key, &from_edit);
-=09__key_link(key, &to_edit);
+=09__key_link(to_keyring, key, &to_edit);
 error:
 =09__key_link_end(to_keyring, &key->index_key, to_edit);
 =09__key_unlink_end(from_keyring, key, from_edit);
@@ -1659,6 +1664,7 @@ int keyring_clear(struct key *keyring)
 =09} else {
 =09=09if (edit)
 =09=09=09assoc_array_apply_edit(edit);
+=09=09notify_key(keyring, NOTIFY_KEY_CLEARED, 0);
 =09=09key_payload_reserve(keyring, 0);
 =09=09ret =3D 0;
 =09}
diff --git a/security/keys/request_key.c b/security/keys/request_key.c
index 957b9e3e1492..e1b9f1a80676 100644
--- a/security/keys/request_key.c
+++ b/security/keys/request_key.c
@@ -418,7 +418,7 @@ static int construct_alloc_key(struct keyring_search_co=
ntext *ctx,
 =09=09goto key_already_present;
=20
 =09if (dest_keyring)
-=09=09__key_link(key, &edit);
+=09=09__key_link(dest_keyring, key, &edit);
=20
 =09mutex_unlock(&key_construction_mutex);
 =09if (dest_keyring)
@@ -437,7 +437,7 @@ static int construct_alloc_key(struct keyring_search_co=
ntext *ctx,
 =09if (dest_keyring) {
 =09=09ret =3D __key_link_check_live_key(dest_keyring, key);
 =09=09if (ret =3D=3D 0)
-=09=09=09__key_link(key, &edit);
+=09=09=09__key_link(dest_keyring, key, &edit);
 =09=09__key_link_end(dest_keyring, &ctx->index_key, edit);
 =09=09if (ret < 0)
 =09=09=09goto link_check_failed;

