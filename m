Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 357AE29DE42
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 01:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731033AbgJ2Af2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Oct 2020 20:35:28 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60620 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730340AbgJ2Af0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Oct 2020 20:35:26 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kXvuL-0008Ep-Mt; Thu, 29 Oct 2020 00:35:13 +0000
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
Subject: [PATCH 01/34] namespace: take lock_mount_hash() directly when changing flags
Date:   Thu, 29 Oct 2020 01:32:19 +0100
Message-Id: <20201029003252.2128653-2-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201029003252.2128653-1-christian.brauner@ubuntu.com>
References: <20201029003252.2128653-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Changing mount options always ends up taking lock_mount_hash() but when
MNT_READONLY is requested and neither the mount nor the superblock are
not already MNT_READONLY we end up taking the lock, dropping it, and
retaking it to change the other mount attributes. Instead of this,
acquire the lock once when changing mount properties. This simplifies
the locking in these codepath, makes them easier to reason about and
avoids having to reacquire the lock right after dropping it.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: David Howells <dhowells@redhat.com>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/namespace.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index cebaa3e81794..20ee291a7af4 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -463,7 +463,6 @@ static int mnt_make_readonly(struct mount *mnt)
 {
 	int ret = 0;
 
-	lock_mount_hash();
 	mnt->mnt.mnt_flags |= MNT_WRITE_HOLD;
 	/*
 	 * After storing MNT_WRITE_HOLD, we'll read the counters. This store
@@ -497,15 +496,12 @@ static int mnt_make_readonly(struct mount *mnt)
 	 */
 	smp_wmb();
 	mnt->mnt.mnt_flags &= ~MNT_WRITE_HOLD;
-	unlock_mount_hash();
 	return ret;
 }
 
 static int __mnt_unmake_readonly(struct mount *mnt)
 {
-	lock_mount_hash();
 	mnt->mnt.mnt_flags &= ~MNT_READONLY;
-	unlock_mount_hash();
 	return 0;
 }
 
@@ -2517,11 +2513,9 @@ static int change_mount_ro_state(struct mount *mnt, unsigned int mnt_flags)
  */
 static void set_mount_attributes(struct mount *mnt, unsigned int mnt_flags)
 {
-	lock_mount_hash();
 	mnt_flags |= mnt->mnt.mnt_flags & ~MNT_USER_SETTABLE_MASK;
 	mnt->mnt.mnt_flags = mnt_flags;
 	touch_mnt_namespace(mnt->mnt_ns);
-	unlock_mount_hash();
 }
 
 static void mnt_warn_timestamp_expiry(struct path *mountpoint, struct vfsmount *mnt)
@@ -2567,9 +2561,11 @@ static int do_reconfigure_mnt(struct path *path, unsigned int mnt_flags)
 		return -EPERM;
 
 	down_write(&sb->s_umount);
+	lock_mount_hash();
 	ret = change_mount_ro_state(mnt, mnt_flags);
 	if (ret == 0)
 		set_mount_attributes(mnt, mnt_flags);
+	unlock_mount_hash();
 	up_write(&sb->s_umount);
 
 	mnt_warn_timestamp_expiry(path, &mnt->mnt);
@@ -2610,8 +2606,11 @@ static int do_remount(struct path *path, int ms_flags, int sb_flags,
 		err = -EPERM;
 		if (ns_capable(sb->s_user_ns, CAP_SYS_ADMIN)) {
 			err = reconfigure_super(fc);
-			if (!err)
+			if (!err) {
+				lock_mount_hash();
 				set_mount_attributes(mnt, mnt_flags);
+				unlock_mount_hash();
+			}
 		}
 		up_write(&sb->s_umount);
 	}
-- 
2.29.0

