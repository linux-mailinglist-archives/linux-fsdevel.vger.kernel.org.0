Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D530C2B345F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Nov 2020 11:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbgKOKtP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Nov 2020 05:49:15 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:59962 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727139AbgKOKtO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Nov 2020 05:49:14 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1keFRW-0000Kt-5S; Sun, 15 Nov 2020 10:39:34 +0000
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
        linux-ext4@vger.kernel.org, linux-audit@redhat.com,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 26/39] ioctl: handle idmapped mounts
Date:   Sun, 15 Nov 2020 11:37:05 +0100
Message-Id: <20201115103718.298186-27-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201115103718.298186-1-christian.brauner@ubuntu.com>
References: <20201115103718.298186-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Enable generic ioctls to handle idmapped mounts by passing down the mount's
user namespace.

Cc: Christoph Hellwig <hch@lst.de>
Cc: David Howells <dhowells@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
patch introduced
---
 fs/remap_range.c   | 7 +++++--
 fs/verity/enable.c | 2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/remap_range.c b/fs/remap_range.c
index 9e5b27641756..fe7f07228462 100644
--- a/fs/remap_range.c
+++ b/fs/remap_range.c
@@ -432,13 +432,16 @@ EXPORT_SYMBOL(vfs_clone_file_range);
 /* Check whether we are allowed to dedupe the destination file */
 static bool allow_file_dedupe(struct file *file)
 {
+	struct user_namespace *user_ns = mnt_user_ns(file->f_path.mnt);
+	struct inode *inode = file_inode(file);
+
 	if (capable(CAP_SYS_ADMIN))
 		return true;
 	if (file->f_mode & FMODE_WRITE)
 		return true;
-	if (uid_eq(current_fsuid(), file_inode(file)->i_uid))
+	if (uid_eq(current_fsuid(), i_uid_into_mnt(user_ns, inode)))
 		return true;
-	if (!inode_permission(&init_user_ns, file_inode(file), MAY_WRITE))
+	if (!inode_permission(user_ns, inode, MAY_WRITE))
 		return true;
 	return false;
 }
diff --git a/fs/verity/enable.c b/fs/verity/enable.c
index 7449ef0050f4..8b9ea0f0850f 100644
--- a/fs/verity/enable.c
+++ b/fs/verity/enable.c
@@ -369,7 +369,7 @@ int fsverity_ioctl_enable(struct file *filp, const void __user *uarg)
 	 * has verity enabled, and to stabilize the data being hashed.
 	 */
 
-	err = inode_permission(&init_user_ns, inode, MAY_WRITE);
+	err = inode_permission(mnt_user_ns(filp->f_path.mnt), inode, MAY_WRITE);
 	if (err)
 		return err;
 
-- 
2.29.2

