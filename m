Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27F492FED97
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 15:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730871AbhAUNas (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 08:30:48 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:54822 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731366AbhAUN2r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 08:28:47 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1l2Zux-0005g7-UT; Thu, 21 Jan 2021 13:22:32 +0000
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
Subject: [PATCH v6 31/40] namespace: only take read lock in do_reconfigure_mnt()
Date:   Thu, 21 Jan 2021 14:19:50 +0100
Message-Id: <20210121131959.646623-32-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210121131959.646623-1-christian.brauner@ubuntu.com>
References: <20210121131959.646623-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=I7aJzwt0DpkJRJifO843fvdrR3C7hhJVdcz6GAHs5To=; m=kYGZs6uxDqNnDWq6amn5PljPB3N7RA7sHRkNgwMp1lA=; p=O0TWEIwrbg8QrF14GljNCoXe8MA31Ulu2rf6pUWyHAo=; g=f6e4b4a5508c730a9bc5fc9fed06d285573d486d
X-Patch-Sig: m=pgp; i=christian.brauner@ubuntu.com; s=0x0x91C61BC06578DCA2; b=iHUEABYKAB0WIQRAhzRXHqcMeLMyaSiRxhvAZXjcogUCYAl9pgAKCRCRxhvAZXjcoheiAQCNq6g R7W31jEDQ1qTDxON63E9c5BpR/hnvmNsehDL4bgEA04lytDQ5sUwwJM8ZlP0XfLmigSZ09W7wckQz f0PzmgI=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

do_reconfigure_mnt() used to take the down_write(&sb->s_umount) lock
which seems unnecessary since we're not changing the superblock. We're
only checking whether it is already read-only. Setting other mount
attributes is protected by lock_mount_hash() afaict and not by s_umount.

The history of down_write(&sb->s_umount) lock being taken when setting
mount attributes dates back to the introduction of MNT_READONLY in [2].
This introduced the concept of having read-only mounts in contrast to
just having a read-only superblock. When it got introduced it was simply
plumbed into do_remount() which already took down_write(&sb->s_umount)
because it was only used to actually change the superblock before [2].
Afaict, it would've already been possible back then to only use
down_read(&sb->s_umount) for MS_BIND | MS_REMOUNT since actual mount
options were protected by the vfsmount lock already. But that would've
meant special casing the locking for MS_BIND | MS_REMOUNT in
do_remount() which people might not have considered worth it.
Then in [1] MS_BIND | MS_REMOUNT mount option changes were split out of
do_remount() into do_reconfigure_mnt() but the down_write(&sb->s_umount)
lock was simply copied over.
Now that we have this be a separate helper only take the
down_read(&sb->s_umount) lock since we're only interested in checking
whether the super block is currently read-only and blocking any writers
from changing it. Essentially, checking that the super block is
read-only has the advantage that we can avoid having to go into the
slowpath and through MNT_WRITE_HOLD and can simply set the read-only
flag on the mount in set_mount_attributes().

[1]: commit 43f5e655eff7 ("vfs: Separate changing mount flags full remount")
[2]: commit 2e4b7fcd9260 ("[PATCH] r/o bind mounts: honor mount writer counts at remount")

Link: https://lore.kernel.org/r/20210112220124.837960-4-christian.brauner@ubuntu.com
Cc: David Howells <dhowells@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
unchanged

/* v3 */
unchanged

/* v4 */
unchanged

/* v5 */
unchanged
base-commit: 7c53f6b671f4aba70ff15e1b05148b10d58c2837

/* v6 */
unchanged
base-commit: 19c329f6808995b142b3966301f217c831e7cf31
---
 fs/namespace.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 5fceb2854395..367f1c7cb6db 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2527,10 +2527,6 @@ static int change_mount_ro_state(struct mount *mnt, unsigned int mnt_flags)
 	return 0;
 }
 
-/*
- * Update the user-settable attributes on a mount.  The caller must hold
- * sb->s_umount for writing.
- */
 static void set_mount_attributes(struct mount *mnt, unsigned int mnt_flags)
 {
 	mnt_flags |= mnt->mnt.mnt_flags & ~MNT_USER_SETTABLE_MASK;
@@ -2580,13 +2576,17 @@ static int do_reconfigure_mnt(struct path *path, unsigned int mnt_flags)
 	if (!can_change_locked_flags(mnt, mnt_flags))
 		return -EPERM;
 
-	down_write(&sb->s_umount);
+	/*
+	 * We're only checking whether the superblock is read-only not
+	 * changing it, so only take down_read(&sb->s_umount).
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
2.30.0

