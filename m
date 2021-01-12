Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A68FE2F3F60
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jan 2021 01:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438181AbhALWP7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jan 2021 17:15:59 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:44793 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438174AbhALWP5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jan 2021 17:15:57 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kzRli-0003bd-Qe; Tue, 12 Jan 2021 22:04:02 +0000
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
Subject: [PATCH v5 29/42] ioctl: handle idmapped mounts
Date:   Tue, 12 Jan 2021 23:01:11 +0100
Message-Id: <20210112220124.837960-30-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210112220124.837960-1-christian.brauner@ubuntu.com>
References: <20210112220124.837960-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=kAwitCaU5Zsp+82CuxVVPm6U8xXlPPtQ0Z0Dh6WXu44=; m=VC5Xd0Zl8AGaO0BlP8YtVNixey9scChiBadwiGTSB5k=; p=oTgP29ybjPTdbnArRS0UjBd62m6f1UrtDPAozi+SHu8=; g=c32d9c1a69a581553f7de28602c01b53e63879e6
X-Patch-Sig: m=pgp; i=christian.brauner@ubuntu.com; s=0x0x91C61BC06578DCA2; b=iHUEABYKAB0WIQRAhzRXHqcMeLMyaSiRxhvAZXjcogUCX/4YuAAKCRCRxhvAZXjcolFtAP9Jyut NCwljnX8YPYbEbH0TGh2ZGqdwFl7dwrXEioMjsgEAxXesyAYTyhhGHAHOKEZri1frriOo39vmk6H9 U/Lv1wg=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Enable generic ioctls to handle idmapped mounts by passing down the
mount's user namespace. If the initial user namespace is passed nothing
changes so non-idmapped mounts will see identical behavior as before.

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
- Serge Hallyn <serge@hallyn.com>:
  - Use "mnt_userns" to refer to a vfsmount's userns everywhere to make
    terminology consistent.

/* v5 */
base-commit: 7c53f6b671f4aba70ff15e1b05148b10d58c2837

- Christoph Hellwig <hch@lst.de>:
  - Use new file_userns_helper().
---
 fs/remap_range.c   | 7 +++++--
 fs/verity/enable.c | 2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/remap_range.c b/fs/remap_range.c
index 29a4a4dbfe12..dc68394ec9a1 100644
--- a/fs/remap_range.c
+++ b/fs/remap_range.c
@@ -432,13 +432,16 @@ EXPORT_SYMBOL(vfs_clone_file_range);
 /* Check whether we are allowed to dedupe the destination file */
 static bool allow_file_dedupe(struct file *file)
 {
+	struct user_namespace *mnt_userns = file_user_ns(file);
+	struct inode *inode = file_inode(file);
+
 	if (capable(CAP_SYS_ADMIN))
 		return true;
 	if (file->f_mode & FMODE_WRITE)
 		return true;
-	if (uid_eq(current_fsuid(), file_inode(file)->i_uid))
+	if (uid_eq(current_fsuid(), i_uid_into_mnt(mnt_userns, inode)))
 		return true;
-	if (!inode_permission(&init_user_ns, file_inode(file), MAY_WRITE))
+	if (!inode_permission(mnt_userns, inode, MAY_WRITE))
 		return true;
 	return false;
 }
diff --git a/fs/verity/enable.c b/fs/verity/enable.c
index 6809cf8a99b7..9a221e368fa6 100644
--- a/fs/verity/enable.c
+++ b/fs/verity/enable.c
@@ -369,7 +369,7 @@ int fsverity_ioctl_enable(struct file *filp, const void __user *uarg)
 	 * has verity enabled, and to stabilize the data being hashed.
 	 */
 
-	err = inode_permission(&init_user_ns, inode, MAY_WRITE);
+	err = inode_permission(file_user_ns(filp), inode, MAY_WRITE);
 	if (err)
 		return err;
 
-- 
2.30.0

