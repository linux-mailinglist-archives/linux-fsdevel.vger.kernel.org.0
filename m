Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC28729DD2C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 01:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731886AbgJ2Af3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Oct 2020 20:35:29 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60621 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730334AbgJ2Af0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Oct 2020 20:35:26 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kXvuN-0008Ep-Br; Thu, 29 Oct 2020 00:35:15 +0000
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
Subject: [PATCH 02/34] namespace: only take read lock in do_reconfigure_mnt()
Date:   Thu, 29 Oct 2020 01:32:20 +0100
Message-Id: <20201029003252.2128653-3-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201029003252.2128653-1-christian.brauner@ubuntu.com>
References: <20201029003252.2128653-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

do_reconfigure_mnt() used to take the down_write(&sb->s_umount) lock
which seems unnecessary since we're not changing the superblock. We're
only checking whether it is already read-only. Setting other mount
attributes is protected by lock_mount_hash() afaict and not by s_umount.

So I think the history of down_write(&sb->s_umount) lock being taken
when setting mount attributes dates back to the introduction of
MNT_READONLY in [2]. Afaict, this introduced the concept of having
read-only mounts in contrast to just having a read-only superblock. When
it got introduced it was simply plumbed into do_remount() which already
took down_write(&sb->s_umount) because it was only used to actually
change the superblock before [2]. Afaict, it would've already been
possible back then to only use down_read(&sb->s_umount) for
MS_BIND | MS_REMOUNT since actual mount options were protected by
the vfsmount lock already. But that would've meant special casing the
locking for MS_BIND | MS_REMOUNT in do_remount() which people might not
have considered worth it.
Then in [1] MS_BIND | MS_REMOUNT mount option changes were split out of
do_remount() into do_reconfigure_mnt() but the down_write(&sb->s_umount)
lock was simply copied over.
Now that we have this be a separate helper only take
the down_read(&sb->s_umount) lock since we're only interested in
checking whether the super block is currently read-only and blocking any
writers from changing it. Essentially, checking that the super block is
read-only has the advantage that we can avoid having to go into the
slowpath and through MNT_WRITE_HOLD and can simply set the read-only
flag on the mount in set_mount_attributes().

[1]: commit 43f5e655eff7 ("vfs: Separate changing mount flags full remount")
[2]: commit 2e4b7fcd9260 ("[PATCH] r/o bind mounts: honor mount writer counts at remount")
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: David Howells <dhowells@redhat.com>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/namespace.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 20ee291a7af4..6e0d5bb63197 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2507,10 +2507,6 @@ static int change_mount_ro_state(struct mount *mnt, unsigned int mnt_flags)
 	return __mnt_unmake_readonly(mnt);
 }
 
-/*
- * Update the user-settable attributes on a mount.  The caller must hold
- * sb->s_umount for writing.
- */
 static void set_mount_attributes(struct mount *mnt, unsigned int mnt_flags)
 {
 	mnt_flags |= mnt->mnt.mnt_flags & ~MNT_USER_SETTABLE_MASK;
@@ -2560,13 +2556,17 @@ static int do_reconfigure_mnt(struct path *path, unsigned int mnt_flags)
 	if (!can_change_locked_flags(mnt, mnt_flags))
 		return -EPERM;
 
-	down_write(&sb->s_umount);
+	/*
+	 * We're only checking whether the superblock is read-only not changing
+	 * it, so only take down_read(&sb->s_umount).
+	 */
+	down_read(&sb->s_umount);
 	lock_mount_hash();
 	ret = change_mount_ro_state(mnt, mnt_flags);
 	if (ret == 0)
 		set_mount_attributes(mnt, mnt_flags);
 	unlock_mount_hash();
-	up_write(&sb->s_umount);
+	up_read(&sb->s_umount);
 
 	mnt_warn_timestamp_expiry(path, &mnt->mnt);
 
-- 
2.29.0

