Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4761F2F3E4C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jan 2021 01:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394268AbhALWGI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jan 2021 17:06:08 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:42904 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389648AbhALWDf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jan 2021 17:03:35 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kzRkS-0003bd-67; Tue, 12 Jan 2021 22:02:44 +0000
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
Subject: [PATCH v5 01/42] namespace: take lock_mount_hash() directly when changing flags
Date:   Tue, 12 Jan 2021 23:00:43 +0100
Message-Id: <20210112220124.837960-2-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210112220124.837960-1-christian.brauner@ubuntu.com>
References: <20210112220124.837960-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=+EOqvkSOxu9JCGW0Rc3vZBIUJjJSA6JSNVX4DwVrmRY=; m=1ldsXyQsqFzxZT47hY5iS9n+gKweLAHoZ2/lfZPgpJA=; p=Gmp8PEq1ocGHlzNKtKR+I8ZfJbh6G/h1rPDV3ZFUV6Y=; g=8e89644d361e75b82524365516392cf4a074a9c9
X-Patch-Sig: m=pgp; i=christian.brauner@ubuntu.com; s=0x0x91C61BC06578DCA2; b=iHUEABYKAB0WIQRAhzRXHqcMeLMyaSiRxhvAZXjcogUCX/4YtAAKCRCRxhvAZXjcohiHAQDbiHx Wr7Ip4En4GOzkOlVR6L5UXpUzmB1DY7b+sZLgzQD/bVGUnIwFA2RGO53R7V/Sm3SASWjlW/E2LXED UJ6d2A0=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Changing mount options always ends up taking lock_mount_hash() but when
MNT_READONLY is requested and neither the mount nor the superblock are
MNT_READONLY we end up taking the lock, dropping it, and retaking it to
change the other mount attributes. Instead, let's acquire the lock once
when changing the mount attributes. This simplifies the locking in these
codepath, makes them easier to reason about and avoids having to
reacquire the lock right after dropping it.

Cc: David Howells <dhowells@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
- Christoph Hellwig <hch@lst.de>:
  - Remove pointless __mnt_unmake_readonly() helper.
  - Even though Christoph suggested to lockdep_assert_held() into places that
    require {lock,unlock}_mount_hash() it seems that seqlock's don't support
    it.

/* v3 */
unchanged

/* v4 */
unchanged

/* v5 */
base-commit: 7c53f6b671f4aba70ff15e1b05148b10d58c2837
---
 fs/namespace.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index d2db7dfe232b..dc782ddf603e 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -463,7 +463,6 @@ static int mnt_make_readonly(struct mount *mnt)
 {
 	int ret = 0;
 
-	lock_mount_hash();
 	mnt->mnt.mnt_flags |= MNT_WRITE_HOLD;
 	/*
 	 * After storing MNT_WRITE_HOLD, we'll read the counters. This store
@@ -497,18 +496,9 @@ static int mnt_make_readonly(struct mount *mnt)
 	 */
 	smp_wmb();
 	mnt->mnt.mnt_flags &= ~MNT_WRITE_HOLD;
-	unlock_mount_hash();
 	return ret;
 }
 
-static int __mnt_unmake_readonly(struct mount *mnt)
-{
-	lock_mount_hash();
-	mnt->mnt.mnt_flags &= ~MNT_READONLY;
-	unlock_mount_hash();
-	return 0;
-}
-
 int sb_prepare_remount_readonly(struct super_block *sb)
 {
 	struct mount *mnt;
@@ -2511,7 +2501,8 @@ static int change_mount_ro_state(struct mount *mnt, unsigned int mnt_flags)
 	if (readonly_request)
 		return mnt_make_readonly(mnt);
 
-	return __mnt_unmake_readonly(mnt);
+	mnt->mnt.mnt_flags &= ~MNT_READONLY;
+	return 0;
 }
 
 /*
@@ -2520,11 +2511,9 @@ static int change_mount_ro_state(struct mount *mnt, unsigned int mnt_flags)
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
@@ -2570,9 +2559,11 @@ static int do_reconfigure_mnt(struct path *path, unsigned int mnt_flags)
 		return -EPERM;
 
 	down_write(&sb->s_umount);
+	lock_mount_hash();
 	ret = change_mount_ro_state(mnt, mnt_flags);
 	if (ret == 0)
 		set_mount_attributes(mnt, mnt_flags);
+	unlock_mount_hash();
 	up_write(&sb->s_umount);
 
 	mnt_warn_timestamp_expiry(path, &mnt->mnt);
@@ -2613,8 +2604,11 @@ static int do_remount(struct path *path, int ms_flags, int sb_flags,
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
2.30.0

