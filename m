Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66FFF29DE4B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 01:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390627AbgJ2Axg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Oct 2020 20:53:36 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60626 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727944AbgJ2Af2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Oct 2020 20:35:28 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kXvuU-0008Ep-1v; Thu, 29 Oct 2020 00:35:22 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org
Cc:     John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Mrunal Patel <mpatel@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Andy Lutomirski <luto@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Theodore Tso <tytso@mit.edu>, Alban Crequy <alban@kinvolk.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Howells <dhowells@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Jann Horn <jannh@google.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@ubuntu.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Lennart Poettering <lennart@poettering.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>, smbarber@chromium.org,
        Phil Estes <estesp@gmail.com>, Serge Hallyn <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Todd Kjos <tkjos@google.com>, Jonathan Corbet <corbet@lwn.net>,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-audit@redhat.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 06/34] fs: add id translation helpers
Date:   Thu, 29 Oct 2020 01:32:24 +0100
Message-Id: <20201029003252.2128653-7-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201029003252.2128653-1-christian.brauner@ubuntu.com>
References: <20201029003252.2128653-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add simple helpers to make it easy to map kuids into and from idmapped
mounts. We provide simple wrappers that filesystems can use to
e.g. initialize inodes similar to i_{uid,gid}_read() and
i_{uid,gid}_write(). Accessing an inode through an idmapped mount will
require the inode to be mapped according to the mount's user namespace.
If the fsids are used to compare against inodes or to initialize inodes
they are required to be shifted from the mount's user namespace. Passing
the initial user namespace to these helpers makes them a nop and so any
non-idmapped paths will not be impacted.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 include/linux/fs.h | 75 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 8314cd351673..8a891b80d0b4 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -39,6 +39,7 @@
 #include <linux/fs_types.h>
 #include <linux/build_bug.h>
 #include <linux/stddef.h>
+#include <linux/cred.h>
 
 #include <asm/byteorder.h>
 #include <uapi/linux/fs.h>
@@ -1574,6 +1575,80 @@ static inline void i_gid_write(struct inode *inode, gid_t gid)
 	inode->i_gid = make_kgid(inode->i_sb->s_user_ns, gid);
 }
 
+static inline kuid_t kuid_into_mnt(struct user_namespace *to, kuid_t kuid)
+{
+#ifdef CONFIG_IDMAP_MOUNTS
+	return make_kuid(to, __kuid_val(kuid));
+#else
+	return kuid;
+#endif
+}
+
+static inline kgid_t kgid_into_mnt(struct user_namespace *to, kgid_t kgid)
+{
+#ifdef CONFIG_IDMAP_MOUNTS
+	return make_kgid(to, __kgid_val(kgid));
+#else
+	return kgid;
+#endif
+}
+
+static inline kuid_t i_uid_into_mnt(struct user_namespace *to,
+				    const struct inode *inode)
+{
+#ifdef CONFIG_IDMAP_MOUNTS
+	return kuid_into_mnt(to, inode->i_uid);
+#else
+	return inode->i_uid;
+#endif
+}
+
+static inline kgid_t i_gid_into_mnt(struct user_namespace *to,
+				    const struct inode *inode)
+{
+#ifdef CONFIG_IDMAP_MOUNTS
+	return kgid_into_mnt(to, inode->i_gid);
+#else
+	return inode->i_gid;
+#endif
+}
+
+static inline kuid_t kuid_from_mnt(struct user_namespace *to, kuid_t kuid)
+{
+#ifdef CONFIG_IDMAP_MOUNTS
+	return KUIDT_INIT(from_kuid(to, kuid));
+#else
+	return kuid;
+#endif
+}
+
+static inline kgid_t kgid_from_mnt(struct user_namespace *to, kgid_t kgid)
+{
+#ifdef CONFIG_IDMAP_MOUNTS
+	return KGIDT_INIT(from_kgid(to, kgid));
+#else
+	return kgid;
+#endif
+}
+
+static inline kuid_t fsuid_into_mnt(struct user_namespace *to)
+{
+#ifdef CONFIG_IDMAP_MOUNTS
+	return kuid_from_mnt(to, current_fsuid());
+#else
+	return current_fsuid();
+#endif
+}
+
+static inline kgid_t fsgid_into_mnt(struct user_namespace *to)
+{
+#ifdef CONFIG_IDMAP_MOUNTS
+	return kgid_from_mnt(to, current_fsgid());
+#else
+	return current_fsgid();
+#endif
+}
+
 extern struct timespec64 current_time(struct inode *inode);
 
 /*
-- 
2.29.0

