Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9EA3189DB1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Mar 2020 15:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgCROSC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Mar 2020 10:18:02 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:40296 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726832AbgCROSC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Mar 2020 10:18:02 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 7C5D72E160B;
        Wed, 18 Mar 2020 17:17:58 +0300 (MSK)
Received: from myt5-70c90f7d6d7d.qloud-c.yandex.net (myt5-70c90f7d6d7d.qloud-c.yandex.net [2a02:6b8:c12:3e2c:0:640:70c9:f7d])
        by mxbackcorp1j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id CaVSFTWyfA-HtYCaN8Y;
        Wed, 18 Mar 2020 17:17:58 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1584541078; bh=fdQkn6uxD4cq3OcGYQ5wY/u9bHIKTLesrnrE/I7Gvn4=;
        h=Message-ID:Date:To:From:Subject:Cc;
        b=wwAIv/a29T8GFEPCSwPd6bQ8FPsD0RBSNSxihbdfon1FjMF8s9nNbdupafjpoTf0r
         5rwWkTYtx0xTWV007HsCtgBzV59L153LooMNE820yJhoRPtNNTTm5lsxyHEXGeoAwz
         uuIaPih24MSPAnTqSkoeN7uJ/4YKg8r8lUF0Ft8E=
Authentication-Results: mxbackcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from unknown (unknown [2a02:6b8:b080:6709::1:1])
        by myt5-70c90f7d6d7d.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id zgfxdoFQrA-Htb8H5Yb;
        Wed, 18 Mar 2020 17:17:55 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH] fs/namespace: handle mount(MS_BIND|MS_REMOUNT) without
 locking sb->s_umount
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Date:   Wed, 18 Mar 2020 17:17:55 +0300
Message-ID: <158454107541.4470.14819321770893756073.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Writeback grabs sb->s_umount for read during I/O. This blocks bind-remount
for a long time. Bind-remount actually does not need sb->s_umount locked
for read or write because it does not alter superblock, only mnt_flags.
All mnt_flags are serialized by global mount_lock.

This patch moves locking into callers to handle remount atomically.
Also grab namespace_sem to synchronize with /proc/mounts and mountinfo.
Function do_change_type() uses the same locking combination.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 fs/namespace.c |   26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 85b5f7bea82e..c6c03be5cc4e 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -459,11 +459,11 @@ void mnt_drop_write_file(struct file *file)
 }
 EXPORT_SYMBOL(mnt_drop_write_file);
 
+/* mount_lock must be held */
 static int mnt_make_readonly(struct mount *mnt)
 {
 	int ret = 0;
 
-	lock_mount_hash();
 	mnt->mnt.mnt_flags |= MNT_WRITE_HOLD;
 	/*
 	 * After storing MNT_WRITE_HOLD, we'll read the counters. This store
@@ -497,15 +497,14 @@ static int mnt_make_readonly(struct mount *mnt)
 	 */
 	smp_wmb();
 	mnt->mnt.mnt_flags &= ~MNT_WRITE_HOLD;
-	unlock_mount_hash();
+
 	return ret;
 }
 
+/* mount_lock must be held */
 static int __mnt_unmake_readonly(struct mount *mnt)
 {
-	lock_mount_hash();
 	mnt->mnt.mnt_flags &= ~MNT_READONLY;
-	unlock_mount_hash();
 	return 0;
 }
 
@@ -2440,6 +2439,7 @@ static bool can_change_locked_flags(struct mount *mnt, unsigned int mnt_flags)
 	return true;
 }
 
+/* mount_lock must be held */
 static int change_mount_ro_state(struct mount *mnt, unsigned int mnt_flags)
 {
 	bool readonly_request = (mnt_flags & MNT_READONLY);
@@ -2454,16 +2454,14 @@ static int change_mount_ro_state(struct mount *mnt, unsigned int mnt_flags)
 }
 
 /*
- * Update the user-settable attributes on a mount.  The caller must hold
- * sb->s_umount for writing.
+ * Update the user-settable attributes on a mount.
+ * mount_lock must be held.
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
@@ -2495,7 +2493,6 @@ static void mnt_warn_timestamp_expiry(struct path *mountpoint, struct vfsmount *
  */
 static int do_reconfigure_mnt(struct path *path, unsigned int mnt_flags)
 {
-	struct super_block *sb = path->mnt->mnt_sb;
 	struct mount *mnt = real_mount(path->mnt);
 	int ret;
 
@@ -2508,11 +2505,13 @@ static int do_reconfigure_mnt(struct path *path, unsigned int mnt_flags)
 	if (!can_change_locked_flags(mnt, mnt_flags))
 		return -EPERM;
 
-	down_write(&sb->s_umount);
+	namespace_lock();
+	lock_mount_hash();
 	ret = change_mount_ro_state(mnt, mnt_flags);
 	if (ret == 0)
 		set_mount_attributes(mnt, mnt_flags);
-	up_write(&sb->s_umount);
+	unlock_mount_hash();
+	namespace_unlock();
 
 	mnt_warn_timestamp_expiry(path, &mnt->mnt);
 
@@ -2551,8 +2550,11 @@ static int do_remount(struct path *path, int ms_flags, int sb_flags,
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

