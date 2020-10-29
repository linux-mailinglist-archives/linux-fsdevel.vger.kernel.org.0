Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8623C29DE07
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 01:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388916AbgJ2Aoh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Oct 2020 20:44:37 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60803 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731945AbgJ2Afn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Oct 2020 20:35:43 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kXvuj-0008Ep-Ic; Thu, 29 Oct 2020 00:35:37 +0000
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
Subject: [PATCH 15/34] stat: add mapped_generic_fillattr()
Date:   Thu, 29 Oct 2020 01:32:33 +0100
Message-Id: <20201029003252.2128653-16-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201029003252.2128653-1-christian.brauner@ubuntu.com>
References: <20201029003252.2128653-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The generic_fillattr() helper fills in the basic attributes associated with an
inode. Add a mapped_generic_fillattr() helper to handle idmapped mounts. If the
inode is accessed through an idmapped mount we need to map it according to the
mount's user namespace. If the initial user namespace is passed all operations
are a nop so non-idmapped mounts will not see a change in behavior and will
also not see any performance impact. This also means that the
non-idmapped-mount aware generic_fillattr() helper can be implemented on top of
the idmapped-mount aware mapped_generic_fillattr() helper.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/stat.c          | 18 +++++++++++++-----
 include/linux/fs.h |  1 +
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/fs/stat.c b/fs/stat.c
index dacecdda2e79..ee6d92aec7ac 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -25,7 +25,8 @@
 #include "mount.h"
 
 /**
- * generic_fillattr - Fill in the basic attributes from the inode struct
+ * mapped_generic_fillattr - Fill in the basic attributes from the inode struct on idmapped mounts
+ * @user_ns: the user namespace from which we access this inode
  * @inode: Inode to use as the source
  * @stat: Where to fill in the attributes
  *
@@ -33,14 +34,15 @@
  * found on the VFS inode structure.  This is the default if no getattr inode
  * operation is supplied.
  */
-void generic_fillattr(struct inode *inode, struct kstat *stat)
+void mapped_generic_fillattr(struct user_namespace *mnt_user_ns,
+			 struct inode *inode, struct kstat *stat)
 {
 	stat->dev = inode->i_sb->s_dev;
 	stat->ino = inode->i_ino;
 	stat->mode = inode->i_mode;
 	stat->nlink = inode->i_nlink;
-	stat->uid = inode->i_uid;
-	stat->gid = inode->i_gid;
+	stat->uid = i_uid_into_mnt(mnt_user_ns, inode);
+	stat->gid = i_gid_into_mnt(mnt_user_ns, inode);
 	stat->rdev = inode->i_rdev;
 	stat->size = i_size_read(inode);
 	stat->atime = inode->i_atime;
@@ -49,6 +51,12 @@ void generic_fillattr(struct inode *inode, struct kstat *stat)
 	stat->blksize = i_blocksize(inode);
 	stat->blocks = inode->i_blocks;
 }
+EXPORT_SYMBOL(mapped_generic_fillattr);
+
+void generic_fillattr(struct inode *inode, struct kstat *stat)
+{
+	mapped_generic_fillattr(&init_user_ns, inode, stat);
+}
 EXPORT_SYMBOL(generic_fillattr);
 
 /**
@@ -87,7 +95,7 @@ int vfs_getattr_nosec(const struct path *path, struct kstat *stat,
 		return inode->i_op->getattr(path, stat, request_mask,
 					    query_flags);
 
-	generic_fillattr(inode, stat);
+	mapped_generic_fillattr(mnt_user_ns(path->mnt), inode, stat);
 	return 0;
 }
 EXPORT_SYMBOL(vfs_getattr_nosec);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index f41d93b0e6d7..e66852dee65d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3162,6 +3162,7 @@ extern int page_symlink(struct inode *inode, const char *symname, int len);
 extern const struct inode_operations page_symlink_inode_operations;
 extern void kfree_link(void *);
 extern void generic_fillattr(struct inode *, struct kstat *);
+extern void mapped_generic_fillattr(struct user_namespace *, struct inode *, struct kstat *);
 extern int vfs_getattr_nosec(const struct path *, struct kstat *, u32, unsigned int);
 extern int vfs_getattr(const struct path *, struct kstat *, u32, unsigned int);
 void __inode_add_bytes(struct inode *inode, loff_t bytes);
-- 
2.29.0

