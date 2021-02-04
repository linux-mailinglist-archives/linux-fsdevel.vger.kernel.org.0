Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 614FB30FA31
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 18:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238704AbhBDRt5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 12:49:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33598 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238761AbhBDRtY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 12:49:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612460874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EPfAuG0oBJE4PXJsBlf2tB98jHVDv6oHlGeWmlrAOzc=;
        b=OupA2uKNCcJY7crSaafB6v46EvK1iC8YcC/6B3xh24qJZ2zrb7h+6ak9txZwQxOrNmo1EW
        hDjgulzMlW5+5OSkIPkj3m3Lx6AQIS/5vM37TjIZPsgsE6Eq2S4Q8DYOLXktnjwetqhmVM
        7TZ95r9f/D5OxVip701Kt3QiYUCXDXU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-KG3bQBilOTydoNN-krak0w-1; Thu, 04 Feb 2021 12:47:52 -0500
X-MC-Unique: KG3bQBilOTydoNN-krak0w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 095B4195D562;
        Thu,  4 Feb 2021 17:47:51 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-115-23.rdu2.redhat.com [10.10.115.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8AD7F6CDD5;
        Thu,  4 Feb 2021 17:47:48 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 2/2] keys: Allow request_key upcalls from a container to be
 intercepted
From:   David Howells <dhowells@redhat.com>
To:     sprabhu@redhat.com
Cc:     dhowells@redhat.com, Jarkko Sakkinen <jarkko@kernel.org>,
        christian@brauner.io, selinux@vger.kernel.org,
        keyrings@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, containers@lists.linux-foundation.org
Date:   Thu, 04 Feb 2021 17:47:47 +0000
Message-ID: <161246086770.1990927.4967525549888707001.stgit@warthog.procyon.org.uk>
In-Reply-To: <161246085160.1990927.13137391845549674518.stgit@warthog.procyon.org.uk>
References: <161246085160.1990927.13137391845549674518.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Provide a mechanism by which daemons can intercept request_key upcalls,
filtered by namespace and key type, and service them.  The list of active
services is per-user_namespace.


====
WHY?
====

Requests to upcall and instantiate a key are directed to /sbin/request_key
run in the init namespaces.  This is the wrong thing to do for
request_key() called inside a container.  Rather, the container manager
should be able to intercept a request and deal with it itself, applying the
appropriate namespaces.

For example, a container with a different network namespace that routes
packets out of a different NIC should probably not use the main system DNS
settings.


==================
SETTING INTERCEPTS
==================

An intercept is set by calling:

	keyctl(KEYCTL_SERVICE_INTERCEPT,
	       int queue_keyring, int userns_fd,
	       const char *type_name, unsigned int ns_mask);

where "queue_keyring" indicates a keyring into which authorisation keys
will be placed as request_key() calls happen; "userns_fd" indicates the
user namespace on which to place the interception (or -1 for the caller's);
"type_name" indicates the type of key to filter for (or NULL); and
"ns_mask" is a bitwise-OR of:

	KEY_SERVICE_NS_UTS
	KEY_SERVICE_NS_IPC
	KEY_SERVICE_NS_MNT
	KEY_SERVICE_NS_PID
	KEY_SERVICE_NS_NET
	KEY_SERVICE_NS_CGROUP

which select those namespaces of the caller that must match for the
interceptionto occur..  So, for example, a daemon that wanted to service
DNS requests from the kernel would do something like:

	queue = add_key("keyring", "queue", NULL, 0,
			KEY_SPEC_THREAD_KEYRING);
	keyctl(KEYCTL_SERVICE_INTERCEPT, queue, -1, "dns_resolver",
	       KEY_SERVICE_NS_NET);

so that it gets all the DNS records issued by processes in the current
network namespace, no matter what other namespaces are in force at the
time.  On the other hand, the following call:

	keyctl(KEYCTL_SERVICE_INTERCEPT, queue, -1, NULL, 0);

will match everything.

If conflicts arise between two filter records (and different daemons can
have filter records in the same list), the most specific record is matched
by preference, otherwise the first added gets the work.  So, in the example
above, the dns_resolver-specific record would match in preference to the
match-everything record as the former in more specific (it specifies a type
and a particular namespace).  EEXIST is given if an intercept exactly
matches one already in place.

An intercept can be removed by setting queue_keyring to 0, e.g.:

	keyctl(KEYCTL_SERVICE_INTERCEPT, 0, -1, "dns_resolver",
	       KEY_SERVICE_NS_NET);

All the other parameters must be given as when the intercept was set.

Notes:

 (1) Note that anyone can create a channel, but only a sysadmin or the root
     user of the current user_namespace may add filters.

     [!] NOTE: I'm really not sure how to get the security right here.  Who
	 is allowed to intercept requests?  Getting it wrong opens a
	 definite security hole.

 (2) It doesn't really handle multiple service threads watching the same
     keyring.

 (3) The intercepts are not tied to the lifetime of the queue keyring,
     though they can be removed later.  This is probably wrong, but it's
     more tricky since they currently pin the queue keyring.  They are,
     however, cleaned up when the user namespace that owns then is
     destroyed.

 (4) I'm not sure it really handles cases where some of the caller's
     namespaces aren't owned by the caller's user_namespace.


==================
SERVICING REQUESTS
==================

The daemon servicing requests should place a watch on the queue keyring.
This will inform it of when an authorisation key is placed in there.

An authorisation key's description indicates the target key and the callout
data can be read from the authorisation key.

The daemon can then gain permission to instantiate the associated key.

	keyctl_assume_authority(key_id);

After which it can do one of:

	keyctl_instantiate(key_id, "foo_bar", 7, 0);
	keyctl_negate(key_id, 0, 0);
	keyctl_reject(key_id, 0, ENOANO, 0);

and the authorisation key will be automatically revoked and unlinked.

If the authorisation key is unlinked from all keyrings, the target key will
be rejected if it hasn't been instantiated yet.


[!] NOTE: Need to provide some way to find out the operation type and other
    parameters from the auth key.  /sbin/request_key supplies this on the
    command line, but I can't do that here.  It's probably something that
    needs storing into the request_key_auth-type key and an additional
    keyctl providing to retrieve it.


===========
SAMPLE CODE
===========

A sample program is provided.  This can be run as:

	./samples/watch_queue/key_req_intercept

it will then watch for requests to be made for user keyrings in the user
namespace in which it resides.  Such requests can be made by:

	keyctl request2 user a @s

This key will be rejected and the command will fail with ENOANO.
Subsequent accesses to the key will also fail with ENOANO.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/key-type.h                |    4 
 include/linux/user_namespace.h          |    2 
 include/uapi/linux/keyctl.h             |   13 +
 kernel/user.c                           |    3 
 kernel/user_namespace.c                 |    2 
 samples/watch_queue/Makefile            |    2 
 samples/watch_queue/key_req_intercept.c |  271 +++++++++++++++++++++++++
 security/keys/Makefile                  |    2 
 security/keys/compat.c                  |    3 
 security/keys/internal.h                |    5 
 security/keys/keyctl.c                  |    6 +
 security/keys/keyring.c                 |    1 
 security/keys/process_keys.c            |    2 
 security/keys/request_key.c             |   16 +
 security/keys/request_key_auth.c        |    3 
 security/keys/service.c                 |  337 +++++++++++++++++++++++++++++++
 16 files changed, 663 insertions(+), 9 deletions(-)
 create mode 100644 samples/watch_queue/key_req_intercept.c
 create mode 100644 security/keys/service.c

diff --git a/include/linux/key-type.h b/include/linux/key-type.h
index 7d985a1dfe4a..6218688eb254 100644
--- a/include/linux/key-type.h
+++ b/include/linux/key-type.h
@@ -62,8 +62,10 @@ struct key_match_data {
  * kernel managed key type definition
  */
 struct key_type {
+	struct module *owner;
+
 	/* name of the type */
-	const char *name;
+	const char name[24];
 
 	/* default payload length for quota precalculation (optional)
 	 * - this can be used instead of calling key_payload_reserve(), that
diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
index 64cf8ebdc4ec..7691778aff3a 100644
--- a/include/linux/user_namespace.h
+++ b/include/linux/user_namespace.h
@@ -73,6 +73,8 @@ struct user_namespace {
 	struct list_head	keyring_name_list;
 	struct key		*user_keyring_register;
 	struct rw_semaphore	keyring_sem;
+	struct hlist_head	request_key_services;
+	spinlock_t		request_key_services_lock;
 #endif
 
 	/* Register of per-UID persistent keyrings for this namespace */
diff --git a/include/uapi/linux/keyctl.h b/include/uapi/linux/keyctl.h
index 4c8884eea808..a2e553df139b 100644
--- a/include/uapi/linux/keyctl.h
+++ b/include/uapi/linux/keyctl.h
@@ -36,6 +36,18 @@
 #define KEY_REQKEY_DEFL_GROUP_KEYRING		6
 #define KEY_REQKEY_DEFL_REQUESTOR_KEYRING	7
 
+/* Request_key service daemon namespace selection specifiers. */
+#define KEY_SERVICE_NS_UTS		0x0001
+#define KEY_SERVICE_NS_IPC		0x0002
+#define KEY_SERVICE_NS_MNT		0x0004
+#define KEY_SERVICE_NS_PID		0x0008
+#define KEY_SERVICE_NS_NET		0x0010
+#define KEY_SERVICE_NS_CGROUP		0x0020
+#define KEY_SERVICE___ALL_NS		0x003f
+
+#define KEY_SERVICE_FD_CLOEXEC		0x0001
+#define KEY_SERVICE_FD_NONBLOCK		0x0002
+
 /* keyctl commands */
 #define KEYCTL_GET_KEYRING_ID		0	/* ask for a keyring's ID */
 #define KEYCTL_JOIN_SESSION_KEYRING	1	/* join or start named session keyring */
@@ -70,6 +82,7 @@
 #define KEYCTL_MOVE			30	/* Move keys between keyrings */
 #define KEYCTL_CAPABILITIES		31	/* Find capabilities of keyrings subsystem */
 #define KEYCTL_WATCH_KEY		32	/* Watch a key or ring of keys for changes */
+#define KEYCTL_SERVICE_INTERCEPT	33	/* Intercept request_key services on a user_ns */
 
 /* keyctl structures */
 struct keyctl_dh_params {
diff --git a/kernel/user.c b/kernel/user.c
index 78ee75f4cd21..0362d738286a 100644
--- a/kernel/user.c
+++ b/kernel/user.c
@@ -71,6 +71,9 @@ struct user_namespace init_user_ns = {
 #ifdef CONFIG_KEYS
 	.keyring_name_list = LIST_HEAD_INIT(init_user_ns.keyring_name_list),
 	.keyring_sem = __RWSEM_INITIALIZER(init_user_ns.keyring_sem),
+	.request_key_services = HLIST_HEAD_INIT,
+	.request_key_services_lock =
+	__SPIN_LOCK_UNLOCKED(init_user_ns.request_key_services_lock),
 #endif
 };
 EXPORT_SYMBOL_GPL(init_user_ns);
diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index f60cf7b5973c..9aebb4be4c00 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -130,6 +130,8 @@ int create_user_ns(struct cred *new)
 #ifdef CONFIG_KEYS
 	INIT_LIST_HEAD(&ns->keyring_name_list);
 	init_rwsem(&ns->keyring_sem);
+	INIT_HLIST_HEAD(&ns->request_key_services);
+	spin_lock_init(&ns->request_key_services_lock);
 #endif
 	ret = -ENOMEM;
 	if (!setup_userns_sysctls(ns))
diff --git a/samples/watch_queue/Makefile b/samples/watch_queue/Makefile
index c0db3a6bc524..4aaa2e2f67a0 100644
--- a/samples/watch_queue/Makefile
+++ b/samples/watch_queue/Makefile
@@ -1,4 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 userprogs-always-y += watch_test
+userprogs-always-y += key_req_intercept
 
 userccflags += -I usr/include
+userldflags += -lkeyutils
diff --git a/samples/watch_queue/key_req_intercept.c b/samples/watch_queue/key_req_intercept.c
new file mode 100644
index 000000000000..c187024a0ce0
--- /dev/null
+++ b/samples/watch_queue/key_req_intercept.c
@@ -0,0 +1,271 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Intercept request_key upcalls
+ *
+ * Copyright (C) 2021 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#define _GNU_SOURCE
+#include <stdbool.h>
+#include <stdarg.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <signal.h>
+#include <unistd.h>
+#include <errno.h>
+#include <sys/ioctl.h>
+#include <limits.h>
+#include <keyutils.h>
+#include <linux/watch_queue.h>
+#include <linux/unistd.h>
+
+#ifndef KEYCTL_WATCH_KEY
+#define KEYCTL_WATCH_KEY 32
+#endif
+#ifndef KEYCTL_SERVICE_INTERCEPT
+#define KEYCTL_SERVICE_INTERCEPT 33
+#endif
+#ifndef __NR_keyctl
+#define __NR_keyctl -1
+#endif
+
+#define BUF_SIZE 256
+
+typedef int key_serial_t;
+key_serial_t queue_keyring;
+
+static long keyctl_watch_key(int key, int watch_fd, int watch_id)
+{
+	return syscall(__NR_keyctl, KEYCTL_WATCH_KEY, key, watch_fd, watch_id);
+}
+
+static long keyctl_service_intercept(int queue_keyring, int userns_fd,
+				     const char *type_name, unsigned int ns_mask)
+{
+	return syscall(__NR_keyctl, KEYCTL_SERVICE_INTERCEPT,
+		       queue_keyring, userns_fd, type_name, ns_mask);
+}
+
+static const char auth_key_type[] = ".request_key_auth;";
+
+/*
+ * Instantiate a key.
+ */
+static void do_instantiation(key_serial_t key, char *desc)
+{
+	printf("INSTANTIATE %u '%s'\n", key, desc);
+
+	if (keyctl_assume_authority(key) == -1) {
+		perror("keyctl_assume_authority");
+		exit(1);
+	}
+
+	if (keyctl_reject(key, 20, ENOANO, 0) == -1) {
+		perror("keyctl_reject");
+		exit(1);
+	}
+}
+
+/*
+ * Process a notification.
+ */
+static void process_request(struct watch_notification *n, size_t len)
+{
+	struct key_notification *k = (struct key_notification *)n;
+	key_serial_t auth_key, key;
+	char desc[1024], *p;
+
+	if (len != sizeof(struct key_notification)) {
+		fprintf(stderr, "Incorrect key message length\n");
+		return;
+	}
+
+	auth_key = k->aux;
+	printf("REQUEST %d aux=%d\n", k->key_id, k->aux);
+
+	if (keyctl_describe(auth_key, desc, sizeof(desc)) == -1) {
+		perror("keyctl_describe(auth_key)");
+		exit(1);
+	}
+
+	printf("AUTH_KEY '%s'\n", desc);
+	if (memcmp(desc, auth_key_type, sizeof(auth_key_type) - 1) != 0) {
+		printf("NOT AUTH_KEY TYPE\n");
+	} else {
+		p = strrchr(desc, ';');
+		if (p) {
+			key = strtoul(p + 1, NULL, 16);
+			printf("KEY '%d'\n", key);
+
+			if (keyctl_describe(key, desc, sizeof(desc)) == -1) {
+				perror("keyctl_describe(key)");
+				exit(1);
+			}
+
+			do_instantiation(key, desc);
+			return;
+		}
+	}
+
+	/* Shouldn't need to do this if we successfully instantiated/rejected
+	 * the target key.
+	 */
+	if (keyctl_unlink(auth_key, queue_keyring) == -1)
+		perror("keyctl_unlink");
+}
+
+/*
+ * Consume and display events.
+ */
+static void consumer(int fd)
+{
+	unsigned char buffer[433], *p, *end;
+	union {
+		struct watch_notification n;
+		unsigned char buf1[128];
+	} n;
+	ssize_t buf_len;
+
+	for (;;) {
+		buf_len = read(fd, buffer, sizeof(buffer));
+		if (buf_len == -1) {
+			perror("read");
+			exit(1);
+		}
+
+		if (buf_len == 0) {
+			printf("-- END --\n");
+			return;
+		}
+
+		if (buf_len > sizeof(buffer)) {
+			fprintf(stderr, "Read buffer overrun: %zd\n", buf_len);
+			return;
+		}
+
+		printf("read() = %zd\n", buf_len);
+
+		p = buffer;
+		end = buffer + buf_len;
+		while (p < end) {
+			size_t largest, len;
+
+			largest = end - p;
+			if (largest > 128)
+				largest = 128;
+			if (largest < sizeof(struct watch_notification)) {
+				fprintf(stderr, "Short message header: %zu\n", largest);
+				return;
+			}
+			memcpy(&n, p, largest);
+
+			printf("NOTIFY[%03zx]: ty=%06x sy=%02x i=%08x\n",
+			       p - buffer, n.n.type, n.n.subtype, n.n.info);
+
+			len = n.n.info & WATCH_INFO_LENGTH;
+			if (len < sizeof(n.n) || len > largest) {
+				fprintf(stderr, "Bad message length: %zu/%zu\n", len, largest);
+				exit(1);
+			}
+
+			switch (n.n.type) {
+			case WATCH_TYPE_META:
+				switch (n.n.subtype) {
+				case WATCH_META_REMOVAL_NOTIFICATION:
+					printf("REMOVAL of watchpoint %08x\n",
+					       (n.n.info & WATCH_INFO_ID) >>
+					       WATCH_INFO_ID__SHIFT);
+					break;
+				case WATCH_META_LOSS_NOTIFICATION:
+					printf("-- LOSS --\n");
+					break;
+				default:
+					printf("other meta record\n");
+					break;
+				}
+				break;
+			case WATCH_TYPE_KEY_NOTIFY:
+				switch (n.n.subtype) {
+				case NOTIFY_KEY_LINKED:
+					process_request(&n.n, len);
+					break;
+				default:
+					printf("other key subtype\n");
+					break;
+				}
+				break;
+			default:
+				printf("other type\n");
+				break;
+			}
+
+			p += len;
+		}
+	}
+}
+
+static struct watch_notification_filter filter = {
+	.nr_filters	= 1,
+	.filters = {
+		[0]	= {
+			.type			= WATCH_TYPE_KEY_NOTIFY,
+			.subtype_filter[0]	= (1 << NOTIFY_KEY_LINKED),
+		},
+	},
+};
+
+static void cleanup(void)
+{
+	printf("--- clean up ---\n");
+	if (keyctl_service_intercept(0, -1, "user", 0) == -1)
+		perror("unintercept");
+	if (keyctl_clear(queue_keyring) == -1)
+		perror("clear");
+	if (keyctl_unlink(queue_keyring, KEY_SPEC_SESSION_KEYRING) == -1)
+		perror("unlink/q");
+}
+
+int main(int argc, char **argv)
+{
+	int pipefd[2], fd;
+
+	queue_keyring = add_key("keyring", "intercept", NULL, 0, KEY_SPEC_SESSION_KEYRING);
+	if (queue_keyring == -1) {
+		perror("add_key");
+		exit(1);
+	}
+
+	printf("QUEUE KEYRING %d\n", queue_keyring);
+
+	if (pipe2(pipefd, O_NOTIFICATION_PIPE) == -1) {
+		perror("pipe2");
+		exit(1);
+	}
+	fd = pipefd[0];
+
+	if (ioctl(fd, IOC_WATCH_QUEUE_SET_SIZE, BUF_SIZE) == -1) {
+		perror("watch_queue(size)");
+		exit(1);
+	}
+
+	if (ioctl(fd, IOC_WATCH_QUEUE_SET_FILTER, &filter) == -1) {
+		perror("watch_queue(filter)");
+		exit(1);
+	}
+
+	if (keyctl_watch_key(queue_keyring, fd, 0x01) == -1) {
+		perror("keyctl_watch_key");
+		exit(1);
+	}
+
+	if (keyctl_service_intercept(queue_keyring, -1, "user", 0) == -1) {
+		perror("keyctl_service_intercept");
+		exit(1);
+	}
+
+	atexit(cleanup);
+
+	consumer(fd);
+	exit(0);
+}
diff --git a/security/keys/Makefile b/security/keys/Makefile
index 5f40807f05b3..3626340df84b 100644
--- a/security/keys/Makefile
+++ b/security/keys/Makefile
@@ -15,7 +15,9 @@ obj-y := \
 	process_keys.o \
 	request_key.o \
 	request_key_auth.o \
+	service.o \
 	user_defined.o
+
 compat-obj-$(CONFIG_KEY_DH_OPERATIONS) += compat_dh.o
 obj-$(CONFIG_COMPAT) += compat.o $(compat-obj-y)
 obj-$(CONFIG_PROC_FS) += proc.o
diff --git a/security/keys/compat.c b/security/keys/compat.c
index 1545efdca562..39c7b1b2a7c7 100644
--- a/security/keys/compat.c
+++ b/security/keys/compat.c
@@ -126,6 +126,9 @@ COMPAT_SYSCALL_DEFINE5(keyctl, u32, option,
 	case KEYCTL_WATCH_KEY:
 		return keyctl_watch_key(arg2, arg3, arg4);
 
+	case KEYCTL_SERVICE_INTERCEPT:
+		return keyctl_service_intercept(arg2, arg3, compat_ptr(arg4), arg5);
+
 	default:
 		return -EOPNOTSUPP;
 	}
diff --git a/security/keys/internal.h b/security/keys/internal.h
index 9b9cf3b6fcbb..b777ef755626 100644
--- a/security/keys/internal.h
+++ b/security/keys/internal.h
@@ -150,6 +150,7 @@ extern struct key *find_keyring_by_name(const char *name, bool uid_keyring);
 
 extern int look_up_user_keyrings(struct key **, struct key **);
 extern struct key *get_user_session_keyring_rcu(const struct cred *);
+extern int install_thread_keyring(void);
 extern int install_thread_keyring_to_cred(struct cred *);
 extern int install_process_keyring_to_cred(struct cred *);
 extern int install_session_keyring_to_cred(struct cred *, struct key *);
@@ -183,6 +184,8 @@ extern void key_gc_keytype(struct key_type *ktype);
 extern int key_task_permission(const key_ref_t key_ref,
 			       const struct cred *cred,
 			       enum key_need_perm need_perm);
+extern int queue_request_key(struct key *key, struct key *auth_key);
+extern void clear_request_key_services(struct user_namespace *ns);
 
 static inline void notify_key(struct key *key,
 			      enum key_notification_subtype subtype, u32 aux)
@@ -265,6 +268,8 @@ extern long keyctl_invalidate_key(key_serial_t);
 extern long keyctl_restrict_keyring(key_serial_t id,
 				    const char __user *_type,
 				    const char __user *_restriction);
+extern long keyctl_service_intercept(int, int, const char __user *, unsigned int);
+
 #ifdef CONFIG_PERSISTENT_KEYRINGS
 extern long keyctl_get_persistent(uid_t, key_serial_t);
 extern unsigned persistent_keyring_expiry;
diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index 96a92a645216..5cac7979c5c0 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -2015,6 +2015,12 @@ SYSCALL_DEFINE5(keyctl, int, option, unsigned long, arg2, unsigned long, arg3,
 	case KEYCTL_WATCH_KEY:
 		return keyctl_watch_key((key_serial_t)arg2, (int)arg3, (int)arg4);
 
+	case KEYCTL_SERVICE_INTERCEPT:
+		return keyctl_service_intercept((key_serial_t)arg2,
+						(int)arg3,
+						(const char __user *)arg4,
+						(unsigned int)arg5);
+
 	default:
 		return -EOPNOTSUPP;
 	}
diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index 5e6a90760753..7ab9e5130f18 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -60,6 +60,7 @@ void key_free_user_ns(struct user_namespace *ns)
 	list_del_init(&ns->keyring_name_list);
 	write_unlock(&keyring_name_lock);
 
+	clear_request_key_services(ns);
 	key_put(ns->user_keyring_register);
 #ifdef CONFIG_PERSISTENT_KEYRINGS
 	key_put(ns->persistent_keyring_register);
diff --git a/security/keys/process_keys.c b/security/keys/process_keys.c
index e3d79a7b6db6..3b515781bc8b 100644
--- a/security/keys/process_keys.c
+++ b/security/keys/process_keys.c
@@ -241,7 +241,7 @@ int install_thread_keyring_to_cred(struct cred *new)
  *
  * Return: 0 if a thread keyring is now present; -errno on failure.
  */
-static int install_thread_keyring(void)
+int install_thread_keyring(void)
 {
 	struct cred *new;
 	int ret;
diff --git a/security/keys/request_key.c b/security/keys/request_key.c
index 2da4404276f0..81fe5aa02dee 100644
--- a/security/keys/request_key.c
+++ b/security/keys/request_key.c
@@ -14,6 +14,7 @@
 #include <linux/keyctl.h>
 #include <linux/slab.h>
 #include <net/net_namespace.h>
+#include <linux/init_task.h>
 #include "internal.h"
 #include <keys/request_key_auth-type.h>
 
@@ -112,7 +113,7 @@ static int call_usermodehelper_keys(const char *path, char **argv, char **envp,
  * Request userspace finish the construction of a key
  * - execute "/sbin/request-key <op> <key> <uid> <gid> <keyring> <keyring> <keyring>"
  */
-static int call_sbin_request_key(struct key *authkey, void *aux)
+static int call_sbin_request_key(struct key *authkey)
 {
 	static char const request_key[] = "/sbin/request-key";
 	struct request_key_auth *rka = get_request_key_auth(authkey);
@@ -224,7 +225,6 @@ static int construct_key(struct key *key, const void *callout_info,
 			 size_t callout_len, void *aux,
 			 struct key *dest_keyring)
 {
-	request_key_actor_t actor;
 	struct key *authkey;
 	int ret;
 
@@ -237,11 +237,13 @@ static int construct_key(struct key *key, const void *callout_info,
 		return PTR_ERR(authkey);
 
 	/* Make the call */
-	actor = call_sbin_request_key;
-	if (key->type->request_key)
-		actor = key->type->request_key;
-
-	ret = actor(authkey, aux);
+	if (key->type->request_key) {
+		ret = key->type->request_key(authkey, aux);
+	} else {
+		ret = queue_request_key(key, authkey);
+		if (ret == -ENOPARAM)
+			ret = call_sbin_request_key(authkey);
+	}
 
 	/* check that the actor called complete_request_key() prior to
 	 * returning an error */
diff --git a/security/keys/request_key_auth.c b/security/keys/request_key_auth.c
index 41e9735006d0..8379dfd15395 100644
--- a/security/keys/request_key_auth.c
+++ b/security/keys/request_key_auth.c
@@ -152,6 +152,9 @@ static void request_key_auth_destroy(struct key *key)
 		rcu_assign_keypointer(key, NULL);
 		call_rcu(&rka->rcu, request_key_auth_rcu_disposal);
 	}
+
+	if (key_read_state(rka->target_key) == KEY_IS_UNINSTANTIATED)
+		key_reject_and_link(rka->target_key, 0, -ENOKEY, NULL, NULL);
 }
 
 /*
diff --git a/security/keys/service.c b/security/keys/service.c
new file mode 100644
index 000000000000..cea8ae993bea
--- /dev/null
+++ b/security/keys/service.c
@@ -0,0 +1,337 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Service daemon interface
+ *
+ * Copyright (C) 2021 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#include <linux/key.h>
+#include <linux/key-type.h>
+#include <linux/utsname.h>
+#include <linux/ipc_namespace.h>
+#include <linux/mnt_namespace.h>
+#include <linux/pid_namespace.h>
+#include <linux/cgroup.h>
+#include <net/net_namespace.h>
+#include "internal.h"
+#include "../fs/mount.h"
+
+/*
+ * Request service filter record.
+ */
+struct request_key_service {
+	struct hlist_node	user_ns_link;	/* Link in the user_ns service list */
+	struct key		*queue_keyring;	/* Keyring into which requests are placed */
+
+	/* The following fields define the selection criteria that we select
+	 * this record on.  All these references must be pinned just in case
+	 * the fd gets passed to another process or the owning process changes
+	 * its own namespaces.
+	 *
+	 * Most of the criteria can be NULL if that criterion is irrelevant to
+	 * the filter.
+	 */
+	char			type[24];	/* Key type of interest (or "") */
+	struct ns_tag		*uts_ns;	/* Matching UTS namespace (or NULL) */
+	struct ns_tag		*ipc_ns;	/* Matching IPC namespace (or NULL) */
+	struct ns_tag		*mnt_ns;	/* Matching mount namespace (or NULL) */
+	struct ns_tag		*pid_ns;	/* Matching process namespace (or NULL) */
+	struct ns_tag		*net_ns;	/* Matching network namespace (or NULL) */
+	struct ns_tag		*cgroup_ns;	/* Matching cgroup namespace (or NULL) */
+	u8			selectivity;	/* Number of exact-match fields */
+	bool			dead;
+};
+
+/*
+ * Free a request_key service record
+ */
+static void free_key_service(struct request_key_service *svc)
+{
+	if (svc) {
+		put_ns_tag(svc->uts_ns);
+		put_ns_tag(svc->ipc_ns);
+		put_ns_tag(svc->mnt_ns);
+		put_ns_tag(svc->pid_ns);
+		put_ns_tag(svc->net_ns);
+		put_ns_tag(svc->cgroup_ns);
+		key_put(svc->queue_keyring);
+		kfree(svc);
+	}
+}
+
+/*
+ * Allocate a service record.
+ */
+static struct request_key_service *alloc_key_service(key_serial_t queue_keyring,
+						     const char __user *type_name,
+						     unsigned int ns_mask)
+{
+	struct request_key_service *svc;
+	struct key_type *type;
+	key_ref_t key_ref;
+	int ret;
+	u8 selectivity = 0;
+
+	svc = kzalloc(sizeof(struct request_key_service), GFP_KERNEL);
+	if (!svc)
+		return ERR_PTR(-ENOMEM);
+
+	if (queue_keyring != 0) {
+		key_ref = lookup_user_key(queue_keyring, 0, KEY_NEED_SEARCH);
+		if (IS_ERR(key_ref)) {
+			ret = PTR_ERR(key_ref);
+			goto err_svc;
+		}
+
+		svc->queue_keyring = key_ref_to_ptr(key_ref);
+	}
+
+	/* Save the matching criteria.  Anything the caller doesn't care about
+	 * we leave as NULL.
+	 */
+	if (type_name) {
+		ret = strncpy_from_user(svc->type, type_name, sizeof(svc->type));
+		if (ret < 0)
+			goto err_keyring;
+		if (ret >= sizeof(svc->type)) {
+			ret = -EINVAL;
+			goto err_keyring;
+		}
+
+		type = key_type_lookup(type_name);
+		if (IS_ERR(type)) {
+			ret = -EINVAL;
+			goto err_keyring;
+		}
+		memcpy(svc->type, type->name, sizeof(svc->type));
+		key_type_put(type);
+	}
+
+	if (ns_mask & KEY_SERVICE_NS_UTS) {
+		svc->uts_ns = get_ns_tag(current->nsproxy->uts_ns->ns.tag);
+		selectivity++;
+	}
+	if (ns_mask & KEY_SERVICE_NS_IPC) {
+		svc->ipc_ns = get_ns_tag(current->nsproxy->ipc_ns->ns.tag);
+		selectivity++;
+	}
+	if (ns_mask & KEY_SERVICE_NS_MNT) {
+		svc->mnt_ns = get_ns_tag(current->nsproxy->mnt_ns->ns.tag);
+		selectivity++;
+	}
+	if (ns_mask & KEY_SERVICE_NS_PID) {
+		svc->pid_ns = get_ns_tag(task_active_pid_ns(current)->ns.tag);
+		selectivity++;
+	}
+	if (ns_mask & KEY_SERVICE_NS_NET) {
+		svc->net_ns = get_ns_tag(current->nsproxy->net_ns->ns.tag);
+		selectivity++;
+	}
+	if (ns_mask & KEY_SERVICE_NS_CGROUP) {
+		svc->cgroup_ns = get_ns_tag(current->nsproxy->cgroup_ns->ns.tag);
+		selectivity++;
+	}
+
+	svc->selectivity = selectivity;
+	return svc;
+
+err_keyring:
+	key_put(svc->queue_keyring);
+err_svc:
+	kfree(svc);
+	return ERR_PTR(ret);
+}
+
+/*
+ * Install a request_key service into the user namespace's list
+ */
+static int install_key_service(struct user_namespace *user_ns,
+			       struct request_key_service *svc)
+{
+	struct request_key_service *p;
+	struct hlist_node **pp;
+	int ret = 0;
+
+	spin_lock(&user_ns->request_key_services_lock);
+
+	/* The services list is kept in order of selectivity.  The more exact
+	 * matches a service requires, the earlier it is in the list.
+	 */
+	for (pp = &user_ns->request_key_services.first; *pp; pp = &(*pp)->next) {
+		p = hlist_entry(*pp, struct request_key_service, user_ns_link);
+		if (p->selectivity < svc->selectivity)
+			goto insert_before;
+		if (p->selectivity > svc->selectivity)
+			continue;
+		if (memcmp(p->type, svc->type, sizeof(p->type)) == 0 &&
+		    p->uts_ns == svc->uts_ns &&
+		    p->ipc_ns == svc->ipc_ns &&
+		    p->mnt_ns == svc->mnt_ns &&
+		    p->pid_ns == svc->pid_ns &&
+		    p->net_ns == svc->net_ns &&
+		    p->cgroup_ns == svc->cgroup_ns)
+			goto duplicate;
+	}
+
+	svc->user_ns_link.pprev = pp;
+	rcu_assign_pointer(*pp, &svc->user_ns_link);
+	goto out;
+
+insert_before:
+	hlist_add_before_rcu(&svc->user_ns_link, &p->user_ns_link);
+	goto out;
+
+duplicate:
+	free_key_service(svc);
+	ret = -EEXIST;
+out:
+	spin_unlock(&user_ns->request_key_services_lock);
+	return ret;
+}
+
+/*
+ * Remove a request_key service interception from the user namespace's list
+ */
+static int remove_key_service(struct user_namespace *user_ns,
+			      struct request_key_service *svc)
+{
+	struct request_key_service *p;
+	struct hlist_node **pp;
+	int ret = 0;
+
+	spin_lock(&user_ns->request_key_services_lock);
+
+	/* The services list is kept in order of selectivity.  The more exact
+	 * matches a service requires, the earlier it is in the list.
+	 */
+	for (pp = &user_ns->request_key_services.first; *pp; pp = &(*pp)->next) {
+		p = hlist_entry(*pp, struct request_key_service, user_ns_link);
+		if (p->selectivity < svc->selectivity)
+			break;
+		if (p->selectivity > svc->selectivity)
+			continue;
+		if (memcmp(p->type, svc->type, sizeof(p->type)) == 0 &&
+		    p->uts_ns == svc->uts_ns &&
+		    p->ipc_ns == svc->ipc_ns &&
+		    p->mnt_ns == svc->mnt_ns &&
+		    p->pid_ns == svc->pid_ns &&
+		    p->net_ns == svc->net_ns &&
+		    p->cgroup_ns == svc->cgroup_ns)
+			goto found;
+	}
+
+	p = NULL;
+	ret = -ENOENT;
+	goto out;
+
+found:
+	hlist_del_rcu(&p->user_ns_link);
+out:
+	spin_unlock(&user_ns->request_key_services_lock);
+	free_key_service(p);
+	free_key_service(svc);
+	return ret;
+}
+
+/*
+ * Add a request_key service handler for a subset of the calling process's
+ * particular set of namespaces.
+ */
+long keyctl_service_intercept(key_serial_t queue_keyring,
+			      int userns_fd,
+			      const char __user *type_name,
+			      unsigned int ns_mask)
+{
+	struct request_key_service *svc;
+	struct user_namespace *user_ns = current_user_ns();
+
+	if (ns_mask & ~KEY_SERVICE___ALL_NS)
+		return -EINVAL;
+	if (userns_fd != -1)
+		return -EINVAL; /* Not supported yet */
+
+	/* Require the caller to be the owner of the user namespace in which
+	 * the fd was created if they're not the sysadmin.  Possibly we should
+	 * be more strict about what namespaces one can select, but it's not
+	 * clear how best to do that.
+	 */
+	if (!capable(CAP_SYS_ADMIN) &&
+	    !uid_eq(user_ns->owner, current_cred()->euid))
+		return -EPERM;
+
+	svc = alloc_key_service(queue_keyring, type_name, ns_mask);
+	if (IS_ERR(svc))
+		return PTR_ERR(svc);
+
+	if (queue_keyring == 0)
+		return remove_key_service(user_ns, svc);
+
+	return install_key_service(user_ns, svc);
+}
+
+/*
+ * Queue a construction record if we can find a queue to punt it off to.
+ */
+int queue_request_key(struct key *key, struct key *auth_key)
+{
+	struct request_key_service *svc;
+	struct user_namespace *user_ns = current_user_ns();
+	struct pid_namespace *pid_ns = task_active_pid_ns(current);
+	struct nsproxy *nsproxy = current->nsproxy;
+	struct key *queue_keyring = NULL;
+	int ret;
+
+	if (hlist_empty(&user_ns->request_key_services))
+		return false;
+
+	rcu_read_lock();
+
+	hlist_for_each_entry_rcu(svc, &user_ns->request_key_services, user_ns_link) {
+		if (svc->type[0] &&
+		    memcmp(svc->type, key->type->name, sizeof(svc->type)) != 0)
+			continue;
+		if ((svc->uts_ns && svc->uts_ns != nsproxy->uts_ns->ns.tag) ||
+		    (svc->ipc_ns && svc->ipc_ns != nsproxy->ipc_ns->ns.tag) ||
+		    (svc->mnt_ns && svc->mnt_ns != nsproxy->mnt_ns->ns.tag) ||
+		    (svc->pid_ns && svc->pid_ns != pid_ns->ns.tag) ||
+		    (svc->net_ns && svc->net_ns != nsproxy->net_ns->ns.tag) ||
+		    (svc->cgroup_ns && svc->cgroup_ns != nsproxy->cgroup_ns->ns.tag))
+			continue;
+		goto found_match;
+	}
+
+	rcu_read_unlock();
+	return -ENOPARAM;
+
+found_match:
+	spin_lock(&user_ns->request_key_services_lock);
+	if (!svc->dead)
+		queue_keyring = key_get(svc->queue_keyring);
+	spin_unlock(&user_ns->request_key_services_lock);
+	rcu_read_unlock();
+
+	ret = -ENOPARAM;
+	if (queue_keyring) {
+		ret = key_link(queue_keyring, auth_key);
+		if (ret < 0)
+			key_reject_and_link(key, 0, ret, NULL, auth_key);
+		key_put(queue_keyring);
+	}
+
+	return ret;
+}
+
+/*
+ * Clear all the service intercept records on a user namespace.
+ */
+void clear_request_key_services(struct user_namespace *user_ns)
+{
+	struct request_key_service *svc;
+
+	while (!hlist_empty(&user_ns->request_key_services)) {
+		svc = hlist_entry(user_ns->request_key_services.first,
+				  struct request_key_service, user_ns_link);
+		hlist_del(&svc->user_ns_link);
+		free_key_service(svc);
+	}
+}


