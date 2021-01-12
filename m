Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2B22F3E9D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jan 2021 01:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393786AbhALWEX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jan 2021 17:04:23 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:42988 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392274AbhALWDq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jan 2021 17:03:46 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kzRkk-0003bd-Vx; Tue, 12 Jan 2021 22:03:03 +0000
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
        Theodore Tso <tytso@mit.edu>, Alban Crequy <alban@kinvolk.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Howells <dhowells@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@ubuntu.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Lennart Poettering <lennart@poettering.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>, smbarber@chromium.org,
        Phil Estes <estesp@gmail.com>, Serge Hallyn <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Todd Kjos <tkjos@google.com>, Paul Moore <paul@paul-moore.com>,
        Jonathan Corbet <corbet@lwn.net>,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v5 08/42] fs: add id translation helpers
Date:   Tue, 12 Jan 2021 23:00:50 +0100
Message-Id: <20210112220124.837960-9-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210112220124.837960-1-christian.brauner@ubuntu.com>
References: <20210112220124.837960-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=DPHLY9J1WgTtTJIZfW+M0ys29DrUndhBq8NbMQ4LhTc=; m=f8Rp5sG3By3IoZf9oxFawhK5ciuhIUWlpZXQnI5KhyM=; p=FdjzGfRkpgFbW6faYox4tn7jKSccYWBah7wp94uJi2M=; g=d24687f3801a2d5b9a8c966b0220bebc4a38950b
X-Patch-Sig: m=pgp; i=christian.brauner@ubuntu.com; s=0x0x91C61BC06578DCA2; b=iHUEABYKAB0WIQRAhzRXHqcMeLMyaSiRxhvAZXjcogUCX/4YtQAKCRCRxhvAZXjcoms5AP9UD8K jKRQgl1LwNzDLENvBEn2KJkcp0Z2leCRTfRmUMgD/ZWnrxZqJq8G8S8UIcj5YGta0jcX3KaWk4MJ4 XSta0wo=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add simple helpers to make it easy to map kuids into and from idmapped
mounts. We provide simple wrappers that filesystems can use to e.g.
initialize inodes similar to i_{uid,gid}_read() and i_{uid,gid}_write().
Accessing an inode through an idmapped mount will require the inode to
be mapped according to the mount's user namespace. If the fsids are used
to compare against inodes or to initialize inodes they are required to
be shifted from the mount's user namespace. Passing the initial user
namespace to these helpers makes them a nop and so any non-idmapped
paths will not be impacted.

Cc: David Howells <dhowells@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
- Christoph Hellwig <hch@lst.de>:
  - Get rid of the ifdefs and the config option that hid idmapped mounts.

/* v3 */
unchanged

/* v4 */
- Serge Hallyn <serge@hallyn.com>:
  - Use "mnt_userns" to refer to a vfsmount's userns everywhere to make
    terminology consistent.

/* v5 */
base-commit: 7c53f6b671f4aba70ff15e1b05148b10d58c2837
---
 include/linux/fs.h | 47 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index fd47deea7c17..1da4c21fb588 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -39,6 +39,7 @@
 #include <linux/fs_types.h>
 #include <linux/build_bug.h>
 #include <linux/stddef.h>
+#include <linux/cred.h>
 
 #include <asm/byteorder.h>
 #include <uapi/linux/fs.h>
@@ -1572,6 +1573,52 @@ static inline void i_gid_write(struct inode *inode, gid_t gid)
 	inode->i_gid = make_kgid(inode->i_sb->s_user_ns, gid);
 }
 
+static inline kuid_t kuid_into_mnt(struct user_namespace *mnt_userns,
+				   kuid_t kuid)
+{
+	return make_kuid(mnt_userns, __kuid_val(kuid));
+}
+
+static inline kgid_t kgid_into_mnt(struct user_namespace *mnt_userns,
+				   kgid_t kgid)
+{
+	return make_kgid(mnt_userns, __kgid_val(kgid));
+}
+
+static inline kuid_t i_uid_into_mnt(struct user_namespace *mnt_userns,
+				    const struct inode *inode)
+{
+	return kuid_into_mnt(mnt_userns, inode->i_uid);
+}
+
+static inline kgid_t i_gid_into_mnt(struct user_namespace *mnt_userns,
+				    const struct inode *inode)
+{
+	return kgid_into_mnt(mnt_userns, inode->i_gid);
+}
+
+static inline kuid_t kuid_from_mnt(struct user_namespace *mnt_userns,
+				   kuid_t kuid)
+{
+	return KUIDT_INIT(from_kuid(mnt_userns, kuid));
+}
+
+static inline kgid_t kgid_from_mnt(struct user_namespace *mnt_userns,
+				   kgid_t kgid)
+{
+	return KGIDT_INIT(from_kgid(mnt_userns, kgid));
+}
+
+static inline kuid_t fsuid_into_mnt(struct user_namespace *mnt_userns)
+{
+	return kuid_from_mnt(mnt_userns, current_fsuid());
+}
+
+static inline kgid_t fsgid_into_mnt(struct user_namespace *mnt_userns)
+{
+	return kgid_from_mnt(mnt_userns, current_fsgid());
+}
+
 extern struct timespec64 current_time(struct inode *inode);
 
 /*
-- 
2.30.0

