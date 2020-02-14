Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13DDA15F583
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2020 19:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730552AbgBNSh7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Feb 2020 13:37:59 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:33603 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730317AbgBNSh5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Feb 2020 13:37:57 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j2fqH-0000uO-WA; Fri, 14 Feb 2020 18:37:34 +0000
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
Subject: [PATCH v2 01/28] user_namespace: introduce fsid mappings infrastructure
Date:   Fri, 14 Feb 2020 19:35:27 +0100
Message-Id: <20200214183554.1133805-2-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200214183554.1133805-1-christian.brauner@ubuntu.com>
References: <20200214183554.1133805-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This introduces the infrastructure to setup fsid mappings which will be used in
later patches.
All new code depends on CONFIG_USER_NS_FSID=y. It currently defaults to "N".
If CONFIG_USER_NS_FSID is not set, no new code is added.

In this patch fsuid_m_show() and fsgid_m_show() are introduced. They are
identical to uid_m_show() and gid_m_show() until we introduce from_kfsuid() and
from_kfsgid() in a follow-up patch.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
- Randy Dunlap <rdunlap@infradead.org>:
  - Fix typo in USER_NS_FSID kconfig documentation.
---
 include/linux/user_namespace.h |  10 +++
 init/Kconfig                   |  11 +++
 kernel/user.c                  |  22 ++++++
 kernel/user_namespace.c        | 122 +++++++++++++++++++++++++++++++++
 4 files changed, 165 insertions(+)

diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
index 6ef1c7109fc4..e44742b0cf8a 100644
--- a/include/linux/user_namespace.h
+++ b/include/linux/user_namespace.h
@@ -56,6 +56,10 @@ enum ucount_type {
 struct user_namespace {
 	struct uid_gid_map	uid_map;
 	struct uid_gid_map	gid_map;
+#ifdef CONFIG_USER_NS_FSID
+	struct uid_gid_map	fsuid_map;
+	struct uid_gid_map	fsgid_map;
+#endif
 	struct uid_gid_map	projid_map;
 	atomic_t		count;
 	struct user_namespace	*parent;
@@ -127,6 +131,12 @@ struct seq_operations;
 extern const struct seq_operations proc_uid_seq_operations;
 extern const struct seq_operations proc_gid_seq_operations;
 extern const struct seq_operations proc_projid_seq_operations;
+#ifdef CONFIG_USER_NS_FSID
+extern const struct seq_operations proc_fsuid_seq_operations;
+extern const struct seq_operations proc_fsgid_seq_operations;
+extern ssize_t proc_fsuid_map_write(struct file *, const char __user *, size_t, loff_t *);
+extern ssize_t proc_fsgid_map_write(struct file *, const char __user *, size_t, loff_t *);
+#endif
 extern ssize_t proc_uid_map_write(struct file *, const char __user *, size_t, loff_t *);
 extern ssize_t proc_gid_map_write(struct file *, const char __user *, size_t, loff_t *);
 extern ssize_t proc_projid_map_write(struct file *, const char __user *, size_t, loff_t *);
diff --git a/init/Kconfig b/init/Kconfig
index cfee56c151f1..d4d0beeba48f 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1111,6 +1111,17 @@ config USER_NS
 
 	  If unsure, say N.
 
+config USER_NS_FSID
+	bool "User namespace fsid mappings"
+	depends on USER_NS
+	default n
+	help
+	  This allows containers to alter their filesystem id mappings.
+	  With this containers with different id mappings can still share
+	  the same filesystem.
+
+	  If unsure, say N.
+
 config PID_NS
 	bool "PID Namespaces"
 	default y
diff --git a/kernel/user.c b/kernel/user.c
index 5235d7f49982..2ccaea9b810b 100644
--- a/kernel/user.c
+++ b/kernel/user.c
@@ -55,6 +55,28 @@ struct user_namespace init_user_ns = {
 			},
 		},
 	},
+#ifdef CONFIG_USER_NS_FSID
+	.fsuid_map = {
+		.nr_extents = 1,
+		{
+			.extent[0] = {
+				.first = 0,
+				.lower_first = 0,
+				.count = 4294967295U,
+			},
+		},
+	},
+	.fsgid_map = {
+		.nr_extents = 1,
+		{
+			.extent[0] = {
+				.first = 0,
+				.lower_first = 0,
+				.count = 4294967295U,
+			},
+		},
+	},
+#endif
 	.count = ATOMIC_INIT(3),
 	.owner = GLOBAL_ROOT_UID,
 	.group = GLOBAL_ROOT_GID,
diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index 8eadadc478f9..cbdf456f95f0 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -191,6 +191,16 @@ static void free_user_ns(struct work_struct *work)
 			kfree(ns->projid_map.forward);
 			kfree(ns->projid_map.reverse);
 		}
+#ifdef CONFIG_USER_NS_FSID
+		if (ns->fsgid_map.nr_extents > UID_GID_MAP_MAX_BASE_EXTENTS) {
+			kfree(ns->fsgid_map.forward);
+			kfree(ns->fsgid_map.reverse);
+		}
+		if (ns->fsuid_map.nr_extents > UID_GID_MAP_MAX_BASE_EXTENTS) {
+			kfree(ns->fsuid_map.forward);
+			kfree(ns->fsuid_map.reverse);
+		}
+#endif
 		retire_userns_sysctls(ns);
 		key_free_user_ns(ns);
 		ns_free_inum(&ns->ns);
@@ -637,6 +647,50 @@ static int projid_m_show(struct seq_file *seq, void *v)
 	return 0;
 }
 
+#ifdef CONFIG_USER_NS_FSID
+static int fsuid_m_show(struct seq_file *seq, void *v)
+{
+	struct user_namespace *ns = seq->private;
+	struct uid_gid_extent *extent = v;
+	struct user_namespace *lower_ns;
+	uid_t lower;
+
+	lower_ns = seq_user_ns(seq);
+	if ((lower_ns == ns) && lower_ns->parent)
+		lower_ns = lower_ns->parent;
+
+	lower = from_kuid(lower_ns, KUIDT_INIT(extent->lower_first));
+
+	seq_printf(seq, "%10u %10u %10u\n",
+		extent->first,
+		lower,
+		extent->count);
+
+	return 0;
+}
+
+static int fsgid_m_show(struct seq_file *seq, void *v)
+{
+	struct user_namespace *ns = seq->private;
+	struct uid_gid_extent *extent = v;
+	struct user_namespace *lower_ns;
+	gid_t lower;
+
+	lower_ns = seq_user_ns(seq);
+	if ((lower_ns == ns) && lower_ns->parent)
+		lower_ns = lower_ns->parent;
+
+	lower = from_kgid(lower_ns, KGIDT_INIT(extent->lower_first));
+
+	seq_printf(seq, "%10u %10u %10u\n",
+		extent->first,
+		lower,
+		extent->count);
+
+	return 0;
+}
+#endif
+
 static void *m_start(struct seq_file *seq, loff_t *ppos,
 		     struct uid_gid_map *map)
 {
@@ -674,6 +728,22 @@ static void *projid_m_start(struct seq_file *seq, loff_t *ppos)
 	return m_start(seq, ppos, &ns->projid_map);
 }
 
+#ifdef CONFIG_USER_NS_FSID
+static void *fsuid_m_start(struct seq_file *seq, loff_t *ppos)
+{
+	struct user_namespace *ns = seq->private;
+
+	return m_start(seq, ppos, &ns->fsuid_map);
+}
+
+static void *fsgid_m_start(struct seq_file *seq, loff_t *ppos)
+{
+	struct user_namespace *ns = seq->private;
+
+	return m_start(seq, ppos, &ns->fsgid_map);
+}
+#endif
+
 static void *m_next(struct seq_file *seq, void *v, loff_t *pos)
 {
 	(*pos)++;
@@ -706,6 +776,22 @@ const struct seq_operations proc_projid_seq_operations = {
 	.show = projid_m_show,
 };
 
+#ifdef CONFIG_USER_NS_FSID
+const struct seq_operations proc_fsuid_seq_operations = {
+	.start = fsuid_m_start,
+	.stop = m_stop,
+	.next = m_next,
+	.show = fsuid_m_show,
+};
+
+const struct seq_operations proc_fsgid_seq_operations = {
+	.start = fsgid_m_start,
+	.stop = m_stop,
+	.next = m_next,
+	.show = fsgid_m_show,
+};
+#endif
+
 static bool mappings_overlap(struct uid_gid_map *new_map,
 			     struct uid_gid_extent *extent)
 {
@@ -1081,6 +1167,42 @@ ssize_t proc_projid_map_write(struct file *file, const char __user *buf,
 			 &ns->projid_map, &ns->parent->projid_map);
 }
 
+#ifdef CONFIG_USER_NS_FSID
+ssize_t proc_fsuid_map_write(struct file *file, const char __user *buf,
+			     size_t size, loff_t *ppos)
+{
+	struct seq_file *seq = file->private_data;
+	struct user_namespace *ns = seq->private;
+	struct user_namespace *seq_ns = seq_user_ns(seq);
+
+	if (!ns->parent)
+		return -EPERM;
+
+	if ((seq_ns != ns) && (seq_ns != ns->parent))
+		return -EPERM;
+
+	return map_write(file, buf, size, ppos, CAP_SETUID, &ns->fsuid_map,
+			 &ns->parent->fsuid_map);
+}
+
+ssize_t proc_fsgid_map_write(struct file *file, const char __user *buf,
+			     size_t size, loff_t *ppos)
+{
+	struct seq_file *seq = file->private_data;
+	struct user_namespace *ns = seq->private;
+	struct user_namespace *seq_ns = seq_user_ns(seq);
+
+	if (!ns->parent)
+		return -EPERM;
+
+	if ((seq_ns != ns) && (seq_ns != ns->parent))
+		return -EPERM;
+
+	return map_write(file, buf, size, ppos, CAP_SETGID, &ns->fsgid_map,
+			 &ns->parent->fsgid_map);
+}
+#endif
+
 static bool new_idmap_permitted(const struct file *file,
 				struct user_namespace *ns, int cap_setid,
 				struct uid_gid_map *new_map)
-- 
2.25.0

