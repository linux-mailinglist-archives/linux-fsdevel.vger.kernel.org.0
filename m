Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C21CE16286E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 15:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgBROgX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 09:36:23 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:53030 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbgBROfj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 09:35:39 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j43xs-0000fF-2l; Tue, 18 Feb 2020 14:35:08 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Aleksa Sarai <cyphar@cyphar.com>, Jann Horn <jannh@google.com>
Cc:     smbarber@chromium.org, Seth Forshee <seth.forshee@canonical.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Serge Hallyn <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Phil Estes <estesp@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v3 04/25] fsuidgid: add fsid mapping helpers
Date:   Tue, 18 Feb 2020 15:33:50 +0100
Message-Id: <20200218143411.2389182-5-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200218143411.2389182-1-christian.brauner@ubuntu.com>
References: <20200218143411.2389182-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds a set of helpers to translate between kfsuid/kfsgid and their
userspace fsuid/fsgid counter parts relative to a given user namespace.

- kuid_t make_kfsuid(struct user_namespace *from, uid_t fsuid)
  Maps a user-namespace fsuid pair into a kfsuid.
  If no fsuid mappings have been written it behaves identical to calling
  make_kuid(). This ensures backwards compatibility for workloads unaware
  or not in need of fsid mappings.

- kgid_t make_kfsgid(struct user_namespace *from, gid_t fsgid)
  Maps a user-namespace fsgid pair into a kfsgid.
  If no fsgid mappings have been written it behaves identical to calling
  make_kgid(). This ensures backwards compatibility for workloads unaware
  or not in need of fsid mappings.

- uid_t from_kfsuid(struct user_namespace *to, kuid_t fsuid)
  Creates a fsuid from a kfsuid user-namespace pair if possible.
  If no fsuid mappings have been written it behaves identical to calling
  from_kuid(). This ensures backwards compatibility for workloads unaware
  or not in need of fsid mappings.

- gid_t from_kfsgid(struct user_namespace *to, kgid_t fsgid)
  Creates a fsgid from a kfsgid user-namespace pair if possible.
  If no fsgid mappings have been written it behaves identical to calling
  make_kgid(). This ensures backwards compatibility for workloads unaware
  or not in need of fsid mappings.

- uid_t from_kfsuid_munged(struct user_namespace *to, kuid_t fsuid)
  Always creates a fsuid from a kfsuid user-namespace pair.
  If no fsuid mappings have been written it behaves identical to calling
  from_kuid(). This ensures backwards compatibility for workloads unaware
  or not in need of fsid mappings.

- gid_t from_kfsgid_munged(struct user_namespace *to, kgid_t fsgid)
  Always creates a fsgid from a kfsgid user-namespace pair if possible.
  If no fsgid mappings have been written it behaves identical to calling
  make_kgid(). This ensures backwards compatibility for workloads unaware
  or not in need of fsid mappings.

- bool kfsuid_has_mapping(struct user_namespace *ns, kuid_t uid)
  Check whether this kfsuid has a mapping in the provided user namespace.
  If no fsuid mappings have been written it behaves identical to calling
  from_kuid(). This ensures backwards compatibility for workloads unaware
  or not in need of fsid mappings.

- bool kfsgid_has_mapping(struct user_namespace *ns, kgid_t gid)
  Check whether this kfsgid has a mapping in the provided user namespace.
  If no fsgid mappings have been written it behaves identical to calling
  make_kgid(). This ensures backwards compatibility for workloads unaware
  or not in need of fsid mappings.

- kuid_t kfsuid_to_kuid(struct user_namespace *to, kuid_t kfsuid)
  Translate from a kfsuid into a kuid.

- kgid_t kfsgid_to_kgid(struct user_namespace *to, kgid_t kfsgid)
  Translate from a kfsgid into a kgid.

- kuid_t kuid_to_kfsuid(struct user_namespace *to, kuid_t kuid)
  Translate from a kuid into a kfsuid.

- kgid_t kgid_to_kfsuid(struct user_namespace *to, kgid_t kgid)
  Translate from a kgid into a kfsgid.

Cc: Jann Horn <jannh@google.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
unchanged

/* v3 */
- Jann Horn <jannh@google.com>:
  - Split changes to map_write() to implement fsid mappings into three separate
    patches: basic fsid helpers, preparatory changes to map_write(), actual
    fsid mapping support in map_write().
---
 include/linux/fsuidgid.h | 122 +++++++++++++++++++++++++++++++++
 kernel/user_namespace.c  | 141 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 261 insertions(+), 2 deletions(-)
 create mode 100644 include/linux/fsuidgid.h

diff --git a/include/linux/fsuidgid.h b/include/linux/fsuidgid.h
new file mode 100644
index 000000000000..46763591f4e6
--- /dev/null
+++ b/include/linux/fsuidgid.h
@@ -0,0 +1,122 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_FSUIDGID_H
+#define _LINUX_FSUIDGID_H
+
+#include <linux/uidgid.h>
+
+#ifdef CONFIG_USER_NS_FSID
+
+extern kuid_t make_kfsuid(struct user_namespace *from, uid_t fsuid);
+extern kgid_t make_kfsgid(struct user_namespace *from, gid_t fsgid);
+extern uid_t from_kfsuid(struct user_namespace *to, kuid_t kfsuid);
+extern gid_t from_kfsgid(struct user_namespace *to, kgid_t kfsgid);
+extern uid_t from_kfsuid_munged(struct user_namespace *to, kuid_t kfsuid);
+extern gid_t from_kfsgid_munged(struct user_namespace *to, kgid_t kfsgid);
+
+static inline bool kfsuid_has_mapping(struct user_namespace *ns, kuid_t kfsuid)
+{
+	return from_kfsuid(ns, kfsuid) != (uid_t) -1;
+}
+
+static inline bool kfsgid_has_mapping(struct user_namespace *ns, kgid_t kfsgid)
+{
+	return from_kfsgid(ns, kfsgid) != (gid_t) -1;
+}
+
+static inline kuid_t kfsuid_to_kuid(struct user_namespace *to, kuid_t kfsuid)
+{
+	uid_t fsuid = from_kfsuid(to, kfsuid);
+	if (fsuid == (uid_t) -1)
+		return INVALID_UID;
+	return make_kuid(to, fsuid);
+}
+
+static inline kgid_t kfsgid_to_kgid(struct user_namespace *to, kgid_t kfsgid)
+{
+	gid_t fsgid = from_kfsgid(to, kfsgid);
+	if (fsgid == (gid_t) -1)
+		return INVALID_GID;
+	return make_kgid(to, fsgid);
+}
+
+static inline kuid_t kuid_to_kfsuid(struct user_namespace *to, kuid_t kuid)
+{
+	uid_t uid = from_kuid(to, kuid);
+	if (uid == (uid_t) -1)
+		return INVALID_UID;
+	return make_kfsuid(to, uid);
+}
+
+static inline kgid_t kgid_to_kfsgid(struct user_namespace *to, kgid_t kgid)
+{
+	gid_t gid = from_kgid(to, kgid);
+	if (gid == (gid_t) -1)
+		return INVALID_GID;
+	return make_kfsgid(to, gid);
+}
+
+#else
+
+static inline kuid_t make_kfsuid(struct user_namespace *from, uid_t fsuid)
+{
+	return make_kuid(from, fsuid);
+}
+
+static inline kgid_t make_kfsgid(struct user_namespace *from, gid_t fsgid)
+{
+	return make_kgid(from, fsgid);
+}
+
+static inline uid_t from_kfsuid(struct user_namespace *to, kuid_t kfsuid)
+{
+	return from_kuid(to, kfsuid);
+}
+
+static inline gid_t from_kfsgid(struct user_namespace *to, kgid_t kfsgid)
+{
+	return from_kgid(to, kfsgid);
+}
+
+static inline uid_t from_kfsuid_munged(struct user_namespace *to, kuid_t kfsuid)
+{
+	return from_kuid_munged(to, kfsuid);
+}
+
+static inline gid_t from_kfsgid_munged(struct user_namespace *to, kgid_t kfsgid)
+{
+	return from_kgid_munged(to, kfsgid);
+}
+
+static inline bool kfsuid_has_mapping(struct user_namespace *ns, kuid_t kfsuid)
+{
+	return kuid_has_mapping(ns, kfsuid);
+}
+
+static inline bool kfsgid_has_mapping(struct user_namespace *ns, kgid_t kfsgid)
+{
+	return kgid_has_mapping(ns, kfsgid);
+}
+
+static inline kuid_t kfsuid_to_kuid(struct user_namespace *to, kuid_t kfsuid)
+{
+	return kfsuid;
+}
+
+static inline kgid_t kfsgid_to_kgid(struct user_namespace *to, kgid_t kfsgid)
+{
+	return kfsgid;
+}
+
+static inline kuid_t kuid_to_kfsuid(struct user_namespace *to, kuid_t kuid)
+{
+	return kuid;
+}
+
+static inline kgid_t kgid_to_kfsgid(struct user_namespace *to, kgid_t kgid)
+{
+	return kgid;
+}
+
+#endif /* CONFIG_USER_NS_FSID */
+
+#endif /* _LINUX_FSUIDGID_H */
diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index cbdf456f95f0..2cfd1e519cc4 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -20,6 +20,7 @@
 #include <linux/fs_struct.h>
 #include <linux/bsearch.h>
 #include <linux/sort.h>
+#include <linux/fsuidgid.h>
 
 static struct kmem_cache *user_ns_cachep __read_mostly;
 static DEFINE_MUTEX(userns_state_mutex);
@@ -583,6 +584,142 @@ projid_t from_kprojid_munged(struct user_namespace *targ, kprojid_t kprojid)
 }
 EXPORT_SYMBOL(from_kprojid_munged);
 
+#ifdef CONFIG_USER_NS_FSID
+/**
+ *	make_kfsuid - Map a user-namespace fsuid pair into a kuid.
+ *	@ns:  User namespace that the fsuid is in
+ *	@fsuid: User identifier
+ *
+ *	Maps a user-namespace fsuid pair into a kernel internal kfsuid,
+ *	and returns that kfsuid.
+ *
+ *	When there is no mapping defined for the user-namespace kfsuid
+ *	pair INVALID_UID is returned.  Callers are expected to test
+ *	for and handle INVALID_UID being returned.  INVALID_UID
+ *	may be tested for using uid_valid().
+ */
+kuid_t make_kfsuid(struct user_namespace *ns, uid_t fsuid)
+{
+	/* Map the fsuid to a global kernel fsuid */
+	return KUIDT_INIT(map_id_down(&ns->fsuid_map, fsuid));
+}
+EXPORT_SYMBOL(make_kfsuid);
+
+/**
+ *	from_kfsuid - Create a fsuid from a kfsuid user-namespace pair.
+ *	@targ: The user namespace we want a fsuid in.
+ *	@kfsuid: The kernel internal fsuid to start with.
+ *
+ *	Map @kfsuid into the user-namespace specified by @targ and
+ *	return the resulting fsuid.
+ *
+ *	There is always a mapping into the initial user_namespace.
+ *
+ *	If @kfsuid has no mapping in @targ (uid_t)-1 is returned.
+ */
+uid_t from_kfsuid(struct user_namespace *targ, kuid_t kfsuid)
+{
+	/* Map the fsuid from a global kernel fsuid */
+	return map_id_up(&targ->fsuid_map, __kuid_val(kfsuid));
+}
+EXPORT_SYMBOL(from_kfsuid);
+
+/**
+ *	from_kfsuid_munged - Create a fsuid from a kfsuid user-namespace pair.
+ *	@targ: The user namespace we want a fsuid in.
+ *	@kfsuid: The kernel internal fsuid to start with.
+ *
+ *	Map @kfsuid into the user-namespace specified by @targ and
+ *	return the resulting fsuid.
+ *
+ *	There is always a mapping into the initial user_namespace.
+ *
+ *	Unlike from_kfsuid from_kfsuid_munged never fails and always
+ *	returns a valid fsuid.  This makes from_kfsuid_munged appropriate
+ *	for use in syscalls like stat and getuid where failing the
+ *	system call and failing to provide a valid fsuid are not an
+ *	options.
+ *
+ *	If @kfsuid has no mapping in @targ overflowuid is returned.
+ */
+uid_t from_kfsuid_munged(struct user_namespace *targ, kuid_t kfsuid)
+{
+	uid_t fsuid;
+	fsuid = from_kfsuid(targ, kfsuid);
+
+	if (fsuid == (uid_t) -1)
+		fsuid = overflowuid;
+	return fsuid;
+}
+EXPORT_SYMBOL(from_kfsuid_munged);
+
+/**
+ *	make_kfsgid - Map a user-namespace fsgid pair into a kfsgid.
+ *	@ns:  User namespace that the fsgid is in
+ *	@fsgid: User identifier
+ *
+ *	Maps a user-namespace fsgid pair into a kernel internal kfsgid,
+ *	and returns that kfsgid.
+ *
+ *	When there is no mapping defined for the user-namespace fsgid
+ *	pair INVALID_GID is returned.  Callers are expected to test
+ *	for and handle INVALID_GID being returned.  INVALID_GID
+ *	may be tested for using gid_valid().
+ */
+kgid_t make_kfsgid(struct user_namespace *ns, gid_t fsgid)
+{
+	/* Map the fsgid to a global kernel fsgid */
+	return KGIDT_INIT(map_id_down(&ns->fsgid_map, fsgid));
+}
+EXPORT_SYMBOL(make_kfsgid);
+
+/**
+ *	from_kfsgid - Create a fsgid from a kfsgid user-namespace pair.
+ *	@targ: The user namespace we want a fsgid in.
+ *	@kfsgid: The kernel internal fsgid to start with.
+ *
+ *	Map @kfsgid into the user-namespace specified by @targ and
+ *	return the resulting fsgid.
+ *
+ *	There is always a mapping into the initial user_namespace.
+ *
+ *	If @kfsgid has no mapping in @targ (gid_t)-1 is returned.
+ */
+gid_t from_kfsgid(struct user_namespace *targ, kgid_t kfsgid)
+{
+	/* Map the fsgid from a global kernel fsgid */
+	return map_id_up(&targ->fsgid_map, __kgid_val(kfsgid));
+}
+EXPORT_SYMBOL(from_kfsgid);
+
+/**
+ *	from_kfsgid_munged - Create a fsgid from a kfsgid user-namespace pair.
+ *	@targ: The user namespace we want a fsgid in.
+ *	@kfsgid: The kernel internal fsgid to start with.
+ *
+ *	Map @kfsgid into the user-namespace specified by @targ and
+ *	return the resulting fsgid.
+ *
+ *	There is always a mapping into the initial user_namespace.
+ *
+ *	Unlike from_kfsgid from_kfsgid_munged never fails and always
+ *	returns a valid fsgid.  This makes from_kfsgid_munged appropriate
+ *	for use in syscalls like stat and getgid where failing the
+ *	system call and failing to provide a valid fsgid are not options.
+ *
+ *	If @kfsgid has no mapping in @targ overflowgid is returned.
+ */
+gid_t from_kfsgid_munged(struct user_namespace *targ, kgid_t kfsgid)
+{
+	gid_t fsgid;
+	fsgid = from_kfsgid(targ, kfsgid);
+
+	if (fsgid == (gid_t) -1)
+		fsgid = overflowgid;
+	return fsgid;
+}
+EXPORT_SYMBOL(from_kfsgid_munged);
+#endif /* CONFIG_USER_NS_FSID */
 
 static int uid_m_show(struct seq_file *seq, void *v)
 {
@@ -659,7 +796,7 @@ static int fsuid_m_show(struct seq_file *seq, void *v)
 	if ((lower_ns == ns) && lower_ns->parent)
 		lower_ns = lower_ns->parent;
 
-	lower = from_kuid(lower_ns, KUIDT_INIT(extent->lower_first));
+	lower = from_kfsuid(lower_ns, KUIDT_INIT(extent->lower_first));
 
 	seq_printf(seq, "%10u %10u %10u\n",
 		extent->first,
@@ -680,7 +817,7 @@ static int fsgid_m_show(struct seq_file *seq, void *v)
 	if ((lower_ns == ns) && lower_ns->parent)
 		lower_ns = lower_ns->parent;
 
-	lower = from_kgid(lower_ns, KGIDT_INIT(extent->lower_first));
+	lower = from_kfsgid(lower_ns, KGIDT_INIT(extent->lower_first));
 
 	seq_printf(seq, "%10u %10u %10u\n",
 		extent->first,
-- 
2.25.0

