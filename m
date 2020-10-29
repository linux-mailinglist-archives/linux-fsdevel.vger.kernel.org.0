Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 220CB29DD9B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 01:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388770AbgJ2Ais (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Oct 2020 20:38:48 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60886 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732668AbgJ2Afr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Oct 2020 20:35:47 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kXvun-0008Ep-LI; Thu, 29 Oct 2020 00:35:41 +0000
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
Subject: [PATCH 17/34] namei: introduce struct renamedata
Date:   Thu, 29 Oct 2020 01:32:35 +0100
Message-Id: <20201029003252.2128653-18-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201029003252.2128653-1-christian.brauner@ubuntu.com>
References: <20201029003252.2128653-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In order to handle idmapped mounts we will extend the vfs rename helper
to take two new arguments in follow up patches. Since this operations already
takes a bunch of arguments add a simple struct renamedata (based on struct
nameidata) and make the current helper to use it before we extend it.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/namei.c | 144 ++++++++++++++++++++++++++++++++---------------------
 1 file changed, 88 insertions(+), 56 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 76ee4d52bd5e..781f11795a22 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4221,62 +4221,24 @@ SYSCALL_DEFINE2(link, const char __user *, oldname, const char __user *, newname
 	return do_linkat(AT_FDCWD, oldname, AT_FDCWD, newname, 0);
 }
 
-/**
- * vfs_rename - rename a filesystem object
- * @old_dir:	parent of source
- * @old_dentry:	source
- * @new_dir:	parent of destination
- * @new_dentry:	destination
- * @delegated_inode: returns an inode needing a delegation break
- * @flags:	rename flags
- *
- * The caller must hold multiple mutexes--see lock_rename()).
- *
- * If vfs_rename discovers a delegation in need of breaking at either
- * the source or destination, it will return -EWOULDBLOCK and return a
- * reference to the inode in delegated_inode.  The caller should then
- * break the delegation and retry.  Because breaking a delegation may
- * take a long time, the caller should drop all locks before doing
- * so.
- *
- * Alternatively, a caller may pass NULL for delegated_inode.  This may
- * be appropriate for callers that expect the underlying filesystem not
- * to be NFS exported.
- *
- * The worst of all namespace operations - renaming directory. "Perverted"
- * doesn't even start to describe it. Somebody in UCB had a heck of a trip...
- * Problems:
- *
- *	a) we can get into loop creation.
- *	b) race potential - two innocent renames can create a loop together.
- *	   That's where 4.4 screws up. Current fix: serialization on
- *	   sb->s_vfs_rename_mutex. We might be more accurate, but that's another
- *	   story.
- *	c) we have to lock _four_ objects - parents and victim (if it exists),
- *	   and source (if it is not a directory).
- *	   And that - after we got ->i_mutex on parents (until then we don't know
- *	   whether the target exists).  Solution: try to be smart with locking
- *	   order for inodes.  We rely on the fact that tree topology may change
- *	   only under ->s_vfs_rename_mutex _and_ that parent of the object we
- *	   move will be locked.  Thus we can rank directories by the tree
- *	   (ancestors first) and rank all non-directories after them.
- *	   That works since everybody except rename does "lock parent, lookup,
- *	   lock child" and rename is under ->s_vfs_rename_mutex.
- *	   HOWEVER, it relies on the assumption that any object with ->lookup()
- *	   has no more than 1 dentry.  If "hybrid" objects will ever appear,
- *	   we'd better make sure that there's no link(2) for them.
- *	d) conversion from fhandle to dentry may come in the wrong moment - when
- *	   we are removing the target. Solution: we will have to grab ->i_mutex
- *	   in the fhandle_to_dentry code. [FIXME - current nfsfh.c relies on
- *	   ->i_mutex on parents, which works but leads to some truly excessive
- *	   locking].
- */
-int vfs_rename(struct inode *old_dir, struct dentry *old_dentry,
-	       struct inode *new_dir, struct dentry *new_dentry,
-	       struct inode **delegated_inode, unsigned int flags)
+struct renamedata {
+	struct inode *old_dir;
+	struct dentry *old_dentry;
+	struct inode *new_dir;
+	struct dentry *new_dentry;
+	struct inode **delegated_inode;
+	unsigned int flags;
+} __randomize_layout;
+
+static int __vfs_rename(struct renamedata *rd)
 {
 	int error;
 	struct user_namespace *user_ns = &init_user_ns;
+	struct inode *old_dir = rd->old_dir, *new_dir = rd->new_dir;
+	struct dentry *old_dentry = rd->old_dentry,
+		      *new_dentry = rd->new_dentry;
+	struct inode **delegated_inode = rd->delegated_inode;
+	unsigned int flags = rd->flags;
 	bool is_dir = d_is_dir(old_dentry);
 	struct inode *source = old_dentry->d_inode;
 	struct inode *target = new_dentry->d_inode;
@@ -4395,11 +4357,76 @@ int vfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 
 	return error;
 }
+
+/**
+ * vfs_rename - rename a filesystem object
+ * @old_dir:	parent of source
+ * @old_dentry:	source
+ * @new_dir:	parent of destination
+ * @new_dentry:	destination
+ * @delegated_inode: returns an inode needing a delegation break
+ * @flags:	rename flags
+ *
+ * The caller must hold multiple mutexes--see lock_rename()).
+ *
+ * If vfs_rename discovers a delegation in need of breaking at either
+ * the source or destination, it will return -EWOULDBLOCK and return a
+ * reference to the inode in delegated_inode.  The caller should then
+ * break the delegation and retry.  Because breaking a delegation may
+ * take a long time, the caller should drop all locks before doing
+ * so.
+ *
+ * Alternatively, a caller may pass NULL for delegated_inode.  This may
+ * be appropriate for callers that expect the underlying filesystem not
+ * to be NFS exported.
+ *
+ * The worst of all namespace operations - renaming directory. "Perverted"
+ * doesn't even start to describe it. Somebody in UCB had a heck of a trip...
+ * Problems:
+ *
+ *	a) we can get into loop creation.
+ *	b) race potential - two innocent renames can create a loop together.
+ *	   That's where 4.4 screws up. Current fix: serialization on
+ *	   sb->s_vfs_rename_mutex. We might be more accurate, but that's another
+ *	   story.
+ *	c) we have to lock _four_ objects - parents and victim (if it exists),
+ *	   and source (if it is not a directory).
+ *	   And that - after we got ->i_mutex on parents (until then we don't know
+ *	   whether the target exists).  Solution: try to be smart with locking
+ *	   order for inodes.  We rely on the fact that tree topology may change
+ *	   only under ->s_vfs_rename_mutex _and_ that parent of the object we
+ *	   move will be locked.  Thus we can rank directories by the tree
+ *	   (ancestors first) and rank all non-directories after them.
+ *	   That works since everybody except rename does "lock parent, lookup,
+ *	   lock child" and rename is under ->s_vfs_rename_mutex.
+ *	   HOWEVER, it relies on the assumption that any object with ->lookup()
+ *	   has no more than 1 dentry.  If "hybrid" objects will ever appear,
+ *	   we'd better make sure that there's no link(2) for them.
+ *	d) conversion from fhandle to dentry may come in the wrong moment - when
+ *	   we are removing the target. Solution: we will have to grab ->i_mutex
+ *	   in the fhandle_to_dentry code. [FIXME - current nfsfh.c relies on
+ *	   ->i_mutex on parents, which works but leads to some truly excessive
+ *	   locking].
+ */
+int vfs_rename(struct inode *old_dir, struct dentry *old_dentry,
+	       struct inode *new_dir, struct dentry *new_dentry,
+	       struct inode **delegated_inode, unsigned int flags)
+{
+	struct renamedata rd = {
+		.old_dir	 = old_dir,
+		.new_dir	 = new_dir,
+		.old_dentry	 = old_dentry,
+		.delegated_inode = delegated_inode,
+		.flags		 = flags,
+	};
+	return __vfs_rename(&rd);
+}
 EXPORT_SYMBOL(vfs_rename);
 
 static int do_renameat2(int olddfd, const char __user *oldname, int newdfd,
 			const char __user *newname, unsigned int flags)
 {
+	struct renamedata rd;
 	struct dentry *old_dentry, *new_dentry;
 	struct dentry *trap;
 	struct path old_path, new_path;
@@ -4505,9 +4532,14 @@ static int do_renameat2(int olddfd, const char __user *oldname, int newdfd,
 				     &new_path, new_dentry, flags);
 	if (error)
 		goto exit5;
-	error = vfs_rename(old_path.dentry->d_inode, old_dentry,
-			   new_path.dentry->d_inode, new_dentry,
-			   &delegated_inode, flags);
+
+	rd.old_dir	   = old_path.dentry->d_inode;
+	rd.old_dentry	   = old_dentry;
+	rd.new_dir	   = new_path.dentry->d_inode;
+	rd.new_dentry	   = new_dentry;
+	rd.delegated_inode = &delegated_inode;
+	rd.flags	   = flags;
+	error = __vfs_rename(&rd);
 exit5:
 	dput(new_dentry);
 exit4:
-- 
2.29.0

