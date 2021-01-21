Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C14F2FEE5E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 16:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732826AbhAUPUz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 10:20:55 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:54651 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732219AbhAUN0O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 08:26:14 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1l2Zu9-0005g7-Nn; Thu, 21 Jan 2021 13:21:41 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
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
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v6 20/40] init: handle idmapped mounts
Date:   Thu, 21 Jan 2021 14:19:39 +0100
Message-Id: <20210121131959.646623-21-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210121131959.646623-1-christian.brauner@ubuntu.com>
References: <20210121131959.646623-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=K1Mmb+2iBnpojBmIU4SJaafXPX8O2CFx1CDw+utpuOU=; m=S5fr/22/m+WbOwFrUpUHXheqOF01JiKNUA5zB/hY/Is=; p=MZSdRyOX771MwH+GLlcjB+0DrEr2A+58o5/RX/qOHFw=; g=45d6fad6f6d32f07d4014060b83492f4e5803561
X-Patch-Sig: m=pgp; i=christian.brauner@ubuntu.com; s=0x0x91C61BC06578DCA2; b=iHUEABYKAB0WIQRAhzRXHqcMeLMyaSiRxhvAZXjcogUCYAl9pQAKCRCRxhvAZXjcovuOAQD0vz6 qwrpIJ0cuKYpZaxNYnIKAkRlsiy3S2ImpIjxs5wEAx6MHynYZhSK9hn2FPNdNgboF6ArU1F+IBR0A AU0LGgo=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Enable the init helpers to handle idmapped mounts by passing down the
mount's user namespace. If the initial user namespace is passed nothing
changes so non-idmapped mounts will see identical behavior as before.

Link: https://lore.kernel.org/r/20210112220124.837960-29-christian.brauner@ubuntu.com
Cc: Christoph Hellwig <hch@lst.de>
Cc: David Howells <dhowells@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
patch introduced

/* v3 */
unchanged

/* v4 */
unchanged

/* v5 */
unchanged
base-commit: 7c53f6b671f4aba70ff15e1b05148b10d58c2837

/* v6 */
base-commit: 19c329f6808995b142b3966301f217c831e7cf31

- Christoph Hellwig <hch@lst.de>:
  - Use new path_permission() helper.
---
 fs/init.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/fs/init.c b/fs/init.c
index e65452750fa5..5c36adaa9b44 100644
--- a/fs/init.c
+++ b/fs/init.c
@@ -157,8 +157,8 @@ int __init init_mknod(const char *filename, umode_t mode, unsigned int dev)
 		mode &= ~current_umask();
 	error = security_path_mknod(&path, dentry, mode, dev);
 	if (!error)
-		error = vfs_mknod(&init_user_ns, path.dentry->d_inode, dentry,
-				  mode, new_decode_dev(dev));
+		error = vfs_mknod(mnt_user_ns(path.mnt), path.dentry->d_inode,
+				  dentry, mode, new_decode_dev(dev));
 	done_path_create(&path, dentry);
 	return error;
 }
@@ -167,6 +167,7 @@ int __init init_link(const char *oldname, const char *newname)
 {
 	struct dentry *new_dentry;
 	struct path old_path, new_path;
+	struct user_namespace *mnt_userns;
 	int error;
 
 	error = kern_path(oldname, 0, &old_path);
@@ -181,14 +182,15 @@ int __init init_link(const char *oldname, const char *newname)
 	error = -EXDEV;
 	if (old_path.mnt != new_path.mnt)
 		goto out_dput;
-	error = may_linkat(&init_user_ns, &old_path);
+	mnt_userns = mnt_user_ns(new_path.mnt);
+	error = may_linkat(mnt_userns, &old_path);
 	if (unlikely(error))
 		goto out_dput;
 	error = security_path_link(old_path.dentry, &new_path, new_dentry);
 	if (error)
 		goto out_dput;
-	error = vfs_link(old_path.dentry, &init_user_ns,
-			 new_path.dentry->d_inode, new_dentry, NULL);
+	error = vfs_link(old_path.dentry, mnt_userns, new_path.dentry->d_inode,
+			 new_dentry, NULL);
 out_dput:
 	done_path_create(&new_path, new_dentry);
 out:
@@ -207,8 +209,8 @@ int __init init_symlink(const char *oldname, const char *newname)
 		return PTR_ERR(dentry);
 	error = security_path_symlink(&path, dentry, oldname);
 	if (!error)
-		error = vfs_symlink(&init_user_ns, path.dentry->d_inode, dentry,
-				    oldname);
+		error = vfs_symlink(mnt_user_ns(path.mnt), path.dentry->d_inode,
+				    dentry, oldname);
 	done_path_create(&path, dentry);
 	return error;
 }
@@ -231,8 +233,8 @@ int __init init_mkdir(const char *pathname, umode_t mode)
 		mode &= ~current_umask();
 	error = security_path_mkdir(&path, dentry, mode);
 	if (!error)
-		error = vfs_mkdir(&init_user_ns, path.dentry->d_inode, dentry,
-				  mode);
+		error = vfs_mkdir(mnt_user_ns(path.mnt), path.dentry->d_inode,
+				  dentry, mode);
 	done_path_create(&path, dentry);
 	return error;
 }
-- 
2.30.0

