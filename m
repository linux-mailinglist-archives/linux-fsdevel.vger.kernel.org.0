Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 474A321F6F7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 18:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbgGNQPw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 12:15:52 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40914 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgGNQPt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 12:15:49 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jvNar-0005y1-4Q; Tue, 14 Jul 2020 16:15:45 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 1/4] namespace: take lock_mount_hash() directly when changing flags
Date:   Tue, 14 Jul 2020 18:14:13 +0200
Message-Id: <20200714161415.3886463-3-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714161415.3886463-1-christian.brauner@ubuntu.com>
References: <20200714161415.3886463-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
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
index f30ed401cc6d..395b9c912edf 100644
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
@@ -2609,8 +2605,11 @@ static int do_remount(struct path *path, int ms_flags, int sb_flags,
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
2.27.0

