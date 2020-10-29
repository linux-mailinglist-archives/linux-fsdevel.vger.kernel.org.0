Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB0929DD6D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 01:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388740AbgJ2Ahm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Oct 2020 20:37:42 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60973 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387535AbgJ2Afu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Oct 2020 20:35:50 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kXvur-0008Ep-3m; Thu, 29 Oct 2020 00:35:45 +0000
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
Subject: [PATCH 19/34] namei: add lookup helpers with idmapped mounts aware permission checking
Date:   Thu, 29 Oct 2020 01:32:37 +0100
Message-Id: <20201029003252.2128653-20-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201029003252.2128653-1-christian.brauner@ubuntu.com>
References: <20201029003252.2128653-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The lookup_one_len(), lookup_one_len_unlocked(), and lookup_positive_unlocked()
helpers are used by filesystems targeted in this first iteration to lookup
dentries if the caller is privileged over the inode of the base dentry. Add
three new helpers lookup_one_len_mapped(), lookup_one_len_mapped_unlocked(),
and lookup_one_len_mapped_unlocked() to handle idmapped mounts. If the inode is
accessed through an idmapped mount it is mapped according to the mount's user
namespace. Afterwards the permissions checks are identical to non-idmapped
mounts. If the initial user namespace is passed all mapping operations are a
nop so non-idmapped mounts will not see a change in behavior and will also not
see any performance impact. It also means that the non-idmapped-mount aware
helpers can be implemented on top of their idmapped-mount aware counterparts by
passing the initial user namespace.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/namei.c            | 47 ++++++++++++++++++++++++++++++++-----------
 include/linux/namei.h |  6 ++++++
 2 files changed, 41 insertions(+), 12 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index a8a3de936cfc..7901ea09e80e 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2517,8 +2517,9 @@ int vfs_path_lookup(struct dentry *dentry, struct vfsmount *mnt,
 }
 EXPORT_SYMBOL(vfs_path_lookup);
 
-static int lookup_one_len_common(const char *name, struct dentry *base,
-				 int len, struct qstr *this)
+static int lookup_one_len_common(const char *name, struct dentry *base, int len,
+				 struct qstr *this,
+				 struct user_namespace *mnt_user_ns)
 {
 	this->name = name;
 	this->len = len;
@@ -2546,7 +2547,7 @@ static int lookup_one_len_common(const char *name, struct dentry *base,
 			return err;
 	}
 
-	return inode_permission(base->d_inode, MAY_EXEC);
+	return mapped_inode_permission(mnt_user_ns, base->d_inode, MAY_EXEC);
 }
 
 /**
@@ -2570,7 +2571,7 @@ struct dentry *try_lookup_one_len(const char *name, struct dentry *base, int len
 
 	WARN_ON_ONCE(!inode_is_locked(base->d_inode));
 
-	err = lookup_one_len_common(name, base, len, &this);
+	err = lookup_one_len_common(name, base, len, &this, &init_user_ns);
 	if (err)
 		return ERR_PTR(err);
 
@@ -2589,7 +2590,8 @@ EXPORT_SYMBOL(try_lookup_one_len);
  *
  * The caller must hold base->i_mutex.
  */
-struct dentry *lookup_one_len(const char *name, struct dentry *base, int len)
+struct dentry *lookup_one_len_mapped(const char *name, struct dentry *base, int len,
+				 struct user_namespace *mnt_user_ns)
 {
 	struct dentry *dentry;
 	struct qstr this;
@@ -2597,13 +2599,19 @@ struct dentry *lookup_one_len(const char *name, struct dentry *base, int len)
 
 	WARN_ON_ONCE(!inode_is_locked(base->d_inode));
 
-	err = lookup_one_len_common(name, base, len, &this);
+	err = lookup_one_len_common(name, base, len, &this, mnt_user_ns);
 	if (err)
 		return ERR_PTR(err);
 
 	dentry = lookup_dcache(&this, base, 0);
 	return dentry ? dentry : __lookup_slow(&this, base, 0);
 }
+EXPORT_SYMBOL(lookup_one_len_mapped);
+
+struct dentry *lookup_one_len(const char *name, struct dentry *base, int len)
+{
+	return lookup_one_len_mapped(name, base, len, &init_user_ns);
+}
 EXPORT_SYMBOL(lookup_one_len);
 
 /**
@@ -2618,14 +2626,14 @@ EXPORT_SYMBOL(lookup_one_len);
  * Unlike lookup_one_len, it should be called without the parent
  * i_mutex held, and will take the i_mutex itself if necessary.
  */
-struct dentry *lookup_one_len_unlocked(const char *name,
-				       struct dentry *base, int len)
+struct dentry *lookup_one_len_mapped_unlocked(const char *name, struct dentry *base,
+					  int len, struct user_namespace *mnt_user_ns)
 {
 	struct qstr this;
 	int err;
 	struct dentry *ret;
 
-	err = lookup_one_len_common(name, base, len, &this);
+	err = lookup_one_len_common(name, base, len, &this, mnt_user_ns);
 	if (err)
 		return ERR_PTR(err);
 
@@ -2634,6 +2642,13 @@ struct dentry *lookup_one_len_unlocked(const char *name,
 		ret = lookup_slow(&this, base, 0);
 	return ret;
 }
+EXPORT_SYMBOL(lookup_one_len_mapped_unlocked);
+
+struct dentry *lookup_one_len_unlocked(const char *name,
+				       struct dentry *base, int len)
+{
+	return lookup_one_len_mapped_unlocked(name, base, len, &init_user_ns);
+}
 EXPORT_SYMBOL(lookup_one_len_unlocked);
 
 /*
@@ -2644,16 +2659,24 @@ EXPORT_SYMBOL(lookup_one_len_unlocked);
  * need to be very careful; pinned positives have ->d_inode stable, so
  * this one avoids such problems.
  */
-struct dentry *lookup_positive_unlocked(const char *name,
-				       struct dentry *base, int len)
+struct dentry *lookup_positive_mapped_unlocked(const char *name,
+					   struct dentry *base, int len,
+					   struct user_namespace *mnt_user_ns)
 {
-	struct dentry *ret = lookup_one_len_unlocked(name, base, len);
+	struct dentry *ret = lookup_one_len_mapped_unlocked(name, base, len, mnt_user_ns);
 	if (!IS_ERR(ret) && d_flags_negative(smp_load_acquire(&ret->d_flags))) {
 		dput(ret);
 		ret = ERR_PTR(-ENOENT);
 	}
 	return ret;
 }
+EXPORT_SYMBOL(lookup_positive_mapped_unlocked);
+
+struct dentry *lookup_positive_unlocked(const char *name,
+				       struct dentry *base, int len)
+{
+	return lookup_positive_mapped_unlocked(name, base, len, &init_user_ns);
+}
 EXPORT_SYMBOL(lookup_positive_unlocked);
 
 #ifdef CONFIG_UNIX98_PTYS
diff --git a/include/linux/namei.h b/include/linux/namei.h
index a4bb992623c4..42dbe4c2653a 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -68,8 +68,14 @@ extern struct dentry *kern_path_locked(const char *, struct path *);
 
 extern struct dentry *try_lookup_one_len(const char *, struct dentry *, int);
 extern struct dentry *lookup_one_len(const char *, struct dentry *, int);
+extern struct dentry *lookup_one_len_mapped(const char *, struct dentry *, int,
+					struct user_namespace *);
 extern struct dentry *lookup_one_len_unlocked(const char *, struct dentry *, int);
+extern struct dentry *lookup_one_len_mapped_unlocked(const char *, struct dentry *,
+						 int, struct user_namespace *);
 extern struct dentry *lookup_positive_unlocked(const char *, struct dentry *, int);
+extern struct dentry *lookup_positive_mapped_unlocked(const char *, struct dentry *,
+						  int, struct user_namespace *);
 
 extern int follow_down_one(struct path *);
 extern int follow_down(struct path *);
-- 
2.29.0

