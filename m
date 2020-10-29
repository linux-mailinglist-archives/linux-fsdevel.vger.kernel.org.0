Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33C6329DD31
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 01:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731947AbgJ2Afc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Oct 2020 20:35:32 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60632 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730399AbgJ2Afa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Oct 2020 20:35:30 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kXvuV-0008Ep-OY; Thu, 29 Oct 2020 00:35:23 +0000
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
Subject: [PATCH 07/34] capability: handle idmapped mounts
Date:   Thu, 29 Oct 2020 01:32:25 +0100
Message-Id: <20201029003252.2128653-8-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201029003252.2128653-1-christian.brauner@ubuntu.com>
References: <20201029003252.2128653-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In order to determine whether a caller holds privilege over a given
inode the capability framework exposes the two helpers
privileged_wrt_inode_uidgid() and capable_wrt_inode_uidgid(). The former
verifies that the inode has a mapping in the caller's user namespace and
the latter additionally verifies that the caller has the requested
capability in their current user namespace. If the inode is accessed
through an idmapped mount we first need to map it according to the
mount's user namespace. Afterwards the checks are identical to
non-idmapped inodes. If the initial user namespace is passed all
operations are a nop so non-idmapped mounts will not see a change in
behavior and will also not see any performance impact.
Since the privileged_wrt_inode_uidgid() helper only has one caller it
makes more sense to simply add an additional user namespace argument and
adapt the single callsite it is used in. The capable_wrt_inode_uidgid()
helper is used in more places so we introduce a new
capable_wrt_mapped_inode_uidgid() helper which can be used by the vfs.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/exec.c                  |  2 +-
 include/linux/capability.h |  6 +++++-
 kernel/capability.c        | 22 ++++++++++++++++------
 3 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 547a2390baf5..8e75d7a33514 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1398,7 +1398,7 @@ void would_dump(struct linux_binprm *bprm, struct file *file)
 		/* Ensure mm->user_ns contains the executable */
 		user_ns = old = bprm->mm->user_ns;
 		while ((user_ns != &init_user_ns) &&
-		       !privileged_wrt_inode_uidgid(user_ns, inode))
+		       !privileged_wrt_inode_uidgid(user_ns, &init_user_ns, inode))
 			user_ns = user_ns->parent;
 
 		if (old != user_ns) {
diff --git a/include/linux/capability.h b/include/linux/capability.h
index 1e7fe311cabe..308d88096745 100644
--- a/include/linux/capability.h
+++ b/include/linux/capability.h
@@ -247,8 +247,12 @@ static inline bool ns_capable_setid(struct user_namespace *ns, int cap)
 	return true;
 }
 #endif /* CONFIG_MULTIUSER */
-extern bool privileged_wrt_inode_uidgid(struct user_namespace *ns, const struct inode *inode);
+extern bool privileged_wrt_inode_uidgid(struct user_namespace *ns,
+					struct user_namespace *mnt_user_ns,
+					const struct inode *inode);
 extern bool capable_wrt_inode_uidgid(const struct inode *inode, int cap);
+extern bool capable_wrt_mapped_inode_uidgid(struct user_namespace *mnt_user_ns,
+					const struct inode *inode, int cap);
 extern bool file_ns_capable(const struct file *file, struct user_namespace *ns, int cap);
 extern bool ptracer_capable(struct task_struct *tsk, struct user_namespace *ns);
 static inline bool perfmon_capable(void)
diff --git a/kernel/capability.c b/kernel/capability.c
index de7eac903a2a..427776414487 100644
--- a/kernel/capability.c
+++ b/kernel/capability.c
@@ -484,12 +484,24 @@ EXPORT_SYMBOL(file_ns_capable);
  *
  * Return true if the inode uid and gid are within the namespace.
  */
-bool privileged_wrt_inode_uidgid(struct user_namespace *ns, const struct inode *inode)
+bool privileged_wrt_inode_uidgid(struct user_namespace *ns,
+				 struct user_namespace *mnt_user_ns,
+				 const struct inode *inode)
 {
-	return kuid_has_mapping(ns, inode->i_uid) &&
-		kgid_has_mapping(ns, inode->i_gid);
+	return kuid_has_mapping(ns, i_uid_into_mnt(mnt_user_ns, inode)) &&
+	       kgid_has_mapping(ns, i_gid_into_mnt(mnt_user_ns, inode));
 }
 
+bool capable_wrt_mapped_inode_uidgid(struct user_namespace *mnt_user_ns,
+				 const struct inode *inode, int cap)
+{
+	struct user_namespace *ns = current_user_ns();
+
+	return ns_capable(ns, cap) &&
+	       privileged_wrt_inode_uidgid(ns, mnt_user_ns, inode);
+}
+EXPORT_SYMBOL(capable_wrt_mapped_inode_uidgid);
+
 /**
  * capable_wrt_inode_uidgid - Check nsown_capable and uid and gid mapped
  * @inode: The inode in question
@@ -501,9 +513,7 @@ bool privileged_wrt_inode_uidgid(struct user_namespace *ns, const struct inode *
  */
 bool capable_wrt_inode_uidgid(const struct inode *inode, int cap)
 {
-	struct user_namespace *ns = current_user_ns();
-
-	return ns_capable(ns, cap) && privileged_wrt_inode_uidgid(ns, inode);
+	return capable_wrt_mapped_inode_uidgid(&init_user_ns, inode, cap);
 }
 EXPORT_SYMBOL(capable_wrt_inode_uidgid);
 
-- 
2.29.0

