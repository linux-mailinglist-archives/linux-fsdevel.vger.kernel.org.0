Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5A22CE3C8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Dec 2020 01:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389462AbgLDADu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Dec 2020 19:03:50 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:42387 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387545AbgLDADu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Dec 2020 19:03:50 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kkyXu-0007ka-J6; Fri, 04 Dec 2020 00:01:58 +0000
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
        Aleksa Sarai <cyphar@cyphar.com>,
        Lennart Poettering <lennart@poettering.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>, smbarber@chromium.org,
        Phil Estes <estesp@gmail.com>, Serge Hallyn <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Todd Kjos <tkjos@google.com>, Paul Moore <paul@paul-moore.com>,
        Jonathan Corbet <corbet@lwn.net>,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v4 24/40] utimes: handle idmapped mounts
Date:   Fri,  4 Dec 2020 00:57:20 +0100
Message-Id: <20201203235736.3528991-25-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201203235736.3528991-1-christian.brauner@ubuntu.com>
References: <20201203235736.3528991-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Enable the vfs_utimes() helper to handle idmapped mounts by passing down
the mount's user namespace. If the initial user namespace is passed
nothing changes so non-idmapped mounts will see identical behavior as
before.

Cc: Christoph Hellwig <hch@lst.de>
Cc: David Howells <dhowells@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
unchanged

/* v3 */
unchanged

/* v4 */
- Serge Hallyn <serge@hallyn.com>:
  - Use "mnt_userns" to refer to a vfsmount's userns everywhere to make
    terminology consistent.
---
 fs/utimes.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/utimes.c b/fs/utimes.c
index 1a4130bee157..33fa753bab3a 100644
--- a/fs/utimes.c
+++ b/fs/utimes.c
@@ -22,6 +22,7 @@ int vfs_utimes(const struct path *path, struct timespec64 *times)
 	struct iattr newattrs;
 	struct inode *inode = path->dentry->d_inode;
 	struct inode *delegated_inode = NULL;
+	struct user_namespace *mnt_userns;
 
 	if (times) {
 		if (!nsec_valid(times[0].tv_nsec) ||
@@ -61,8 +62,9 @@ int vfs_utimes(const struct path *path, struct timespec64 *times)
 		newattrs.ia_valid |= ATTR_TOUCH;
 	}
 retry_deleg:
+	mnt_userns = mnt_user_ns(path->mnt);
 	inode_lock(inode);
-	error = notify_change(&init_user_ns, path->dentry, &newattrs, &delegated_inode);
+	error = notify_change(mnt_userns, path->dentry, &newattrs, &delegated_inode);
 	inode_unlock(inode);
 	if (delegated_inode) {
 		error = break_deleg_wait(&delegated_inode);
-- 
2.29.2

