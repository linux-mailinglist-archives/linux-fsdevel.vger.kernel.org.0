Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D750C18F823
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Mar 2020 16:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbgCWPFM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Mar 2020 11:05:12 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:48822 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726955AbgCWPFM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Mar 2020 11:05:12 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id AD78B2E0AF3;
        Mon, 23 Mar 2020 18:05:09 +0300 (MSK)
Received: from myt4-18a966dbd9be.qloud-c.yandex.net (myt4-18a966dbd9be.qloud-c.yandex.net [2a02:6b8:c00:12ad:0:640:18a9:66db])
        by mxbackcorp1j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id s3ED7ZnPtH-59NOwMP0;
        Mon, 23 Mar 2020 18:05:09 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1584975909; bh=kmq7mjIkuy0JgwDaEhLMvbyTFfm1yg70KiCTf+qdFP8=;
        h=Message-ID:Date:To:From:Subject:Cc;
        b=oTCO06RSPtRgx7ylET1DtUPO1RAEf4fh4WjjM5oWDcxf0DC+jZZ6kALONI8nunTap
         HkJoqCSEnuaPLiDV9KGm+kgr7XZzDTE3Y8ZjpuMl2KSdmnQRfzrnJFKIpGAS5WezsM
         Po2t9yH0VUlDlgMJciTkXSIazNQ2jFv5/opU1V+I=
Authentication-Results: mxbackcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from unknown (unknown [2a02:6b8:b080:6803::1:2])
        by myt4-18a966dbd9be.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id FQS5zzaSBX-58aO1vlM;
        Mon, 23 Mar 2020 18:05:08 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH v2] fs/namespace: handle mount(MS_BIND|MS_REMOUNT) without
 locking sb->s_umount
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     David Howells <dhowells@redhat.com>,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>,
        Matthew Wilcox <willy@infradead.org>
Date:   Mon, 23 Mar 2020 18:05:08 +0300
Message-ID: <158497590858.7371.9311902565121473436.stgit@buzz>
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

v2:
- inline helpers into change_mount_ro_state
- verify lock with lockdep_assert_held_write

Link: https://lore.kernel.org/lkml/158454107541.4470.14819321770893756073.stgit@buzz/ (v1)
Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 fs/namespace.c |   58 +++++++++++++++++++++++++-------------------------------
 1 file changed, 26 insertions(+), 32 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 85b5f7bea82e..d394a4c414a2 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -459,11 +459,22 @@ void mnt_drop_write_file(struct file *file)
 }
 EXPORT_SYMBOL(mnt_drop_write_file);
 
-static int mnt_make_readonly(struct mount *mnt)
+/* mount_lock must be held */
+static int change_mount_ro_state(struct mount *mnt, unsigned int mnt_flags)
 {
+	bool readonly_request = (mnt_flags & MNT_READONLY);
 	int ret = 0;
 
-	lock_mount_hash();
+	lockdep_assert_held_write(&mount_lock.seqcount);
+
+	if (readonly_request == __mnt_is_readonly(&mnt->mnt))
+		goto out;
+
+	if (!readonly_request) {
+		mnt->mnt.mnt_flags &= ~MNT_READONLY;
+		goto out;
+	}
+
 	mnt->mnt.mnt_flags |= MNT_WRITE_HOLD;
 	/*
 	 * After storing MNT_WRITE_HOLD, we'll read the counters. This store
@@ -497,16 +508,9 @@ static int mnt_make_readonly(struct mount *mnt)
 	 */
 	smp_wmb();
 	mnt->mnt.mnt_flags &= ~MNT_WRITE_HOLD;
-	unlock_mount_hash();
-	return ret;
-}
 
-static int __mnt_unmake_readonly(struct mount *mnt)
-{
-	lock_mount_hash();
-	mnt->mnt.mnt_flags &= ~MNT_READONLY;
-	unlock_mount_hash();
-	return 0;
+out:
+	return ret;
 }
 
 int sb_prepare_remount_readonly(struct super_block *sb)
@@ -2440,30 +2444,16 @@ static bool can_change_locked_flags(struct mount *mnt, unsigned int mnt_flags)
 	return true;
 }
 
-static int change_mount_ro_state(struct mount *mnt, unsigned int mnt_flags)
-{
-	bool readonly_request = (mnt_flags & MNT_READONLY);
-
-	if (readonly_request == __mnt_is_readonly(&mnt->mnt))
-		return 0;
-
-	if (readonly_request)
-		return mnt_make_readonly(mnt);
-
-	return __mnt_unmake_readonly(mnt);
-}
-
 /*
- * Update the user-settable attributes on a mount.  The caller must hold
- * sb->s_umount for writing.
+ * Update the user-settable attributes on a mount.
+ * mount_lock must be held.
  */
 static void set_mount_attributes(struct mount *mnt, unsigned int mnt_flags)
 {
-	lock_mount_hash();
+	lockdep_assert_held_write(&mount_lock.seqcount);
 	mnt_flags |= mnt->mnt.mnt_flags & ~MNT_USER_SETTABLE_MASK;
 	mnt->mnt.mnt_flags = mnt_flags;
 	touch_mnt_namespace(mnt->mnt_ns);
-	unlock_mount_hash();
 }
 
 static void mnt_warn_timestamp_expiry(struct path *mountpoint, struct vfsmount *mnt)
@@ -2495,7 +2485,6 @@ static void mnt_warn_timestamp_expiry(struct path *mountpoint, struct vfsmount *
  */
 static int do_reconfigure_mnt(struct path *path, unsigned int mnt_flags)
 {
-	struct super_block *sb = path->mnt->mnt_sb;
 	struct mount *mnt = real_mount(path->mnt);
 	int ret;
 
@@ -2508,11 +2497,13 @@ static int do_reconfigure_mnt(struct path *path, unsigned int mnt_flags)
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
 
@@ -2551,8 +2542,11 @@ static int do_remount(struct path *path, int ms_flags, int sb_flags,
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

