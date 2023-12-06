Return-Path: <linux-fsdevel+bounces-4918-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AF680637D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 01:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29E222819ED
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 00:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E91804
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 00:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XYWclCyE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F9019E;
	Wed,  6 Dec 2023 00:13:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A79EEC433C7;
	Wed,  6 Dec 2023 00:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701821630;
	bh=XeFO6Xmo3W9XjUw2LX22986LAJlmhOkFPd3kf2ndubU=;
	h=From:To:Cc:Subject:Date:From;
	b=XYWclCyEOM4kNmKVXoWbaPTNHj2To0jnMPsCEk2o4nj1un+/Yk9ebjTrOzI3T2N7A
	 DzPKlaWACNxFP+BKvlhIC5ZsiH2yHHZS+YnRlfgC7TMQ0KklwoDNyItmRo2NbK6d3F
	 c4F2GkLtg/5Hlz0zNSqp0lAxEiguLEHEWUJrXrseO9t4f4q8D+bc00SPzdv+BJBymY
	 ISbO7WfBhSqdJPZeMjWh8o8UJE40eleNAhLwkLdzaBF9axm0SZz8llC2ko6jGmVGWF
	 /sEPZxZZbuJn929qQFr2hmmnJZUxAljcjrfpk0LzYabdTRMkJ0PtHR9SS2Qx1IdG5d
	 HRBEMaXwyfkdg==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-fscrypt@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH] fscrypt: move the call to fscrypt_destroy_keyring() into ->put_super()
Date: Tue,  5 Dec 2023 16:13:24 -0800
Message-ID: <20231206001325.13676-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

btrfs, which is planning to add support for fscrypt, has a variety of
asynchronous things it does with inodes that can potentially last until
->put_super, when it shuts everything down and cleans up all async work.
Consequently, btrfs needs the call to fscrypt_destroy_keyring() to
happen either after or within ->put_super.

Meanwhile, f2fs needs the call to fscrypt_destroy_keyring() to happen
either *before* or within ->put_super, due to the dependency of
f2fs_get_devices() on ->s_fs_info still existing.

To meet both of these constraints, this patch moves the keyring
destruction into ->put_super.  This gives filesystems some flexibility
into when it is done.  This does mean that the VFS no longer handles it
automatically for filesystems, which is unfortunate, though this is in
line with most of the other fscrypt functions.

(The fscrypt keyring destruction has now been changed an embarrassingly
large number of times.  Hopefully this will be The Last Change That
Finally Gets It Right!)

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/ceph/super.c     |  1 +
 fs/crypto/keyring.c | 13 +++++++------
 fs/ext4/super.c     |  2 ++
 fs/f2fs/super.c     |  2 ++
 fs/super.c          |  7 -------
 fs/ubifs/super.c    |  2 ++
 6 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 5ec102f6b1ac5..48155aa2c5fd0 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -40,20 +40,21 @@ static LIST_HEAD(ceph_fsc_list);
  */
 
 /*
  * super ops
  */
 static void ceph_put_super(struct super_block *s)
 {
 	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(s);
 
 	doutc(fsc->client, "begin\n");
+	fscrypt_destroy_keyring(s);
 	ceph_fscrypt_free_dummy_policy(fsc);
 	ceph_mdsc_close_sessions(fsc->mdsc);
 	doutc(fsc->client, "done\n");
 }
 
 static int ceph_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
 	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(d_inode(dentry));
 	struct ceph_mon_client *monc = &fsc->client->monc;
 	struct ceph_statfs st;
diff --git a/fs/crypto/keyring.c b/fs/crypto/keyring.c
index f34a9b0b9e922..49d130368b802 100644
--- a/fs/crypto/keyring.c
+++ b/fs/crypto/keyring.c
@@ -212,27 +212,27 @@ static int allocate_filesystem_keyring(struct super_block *sb)
 	 * Pairs with the smp_load_acquire() in fscrypt_find_master_key().
 	 * I.e., here we publish ->s_master_keys with a RELEASE barrier so that
 	 * concurrent tasks can ACQUIRE it.
 	 */
 	smp_store_release(&sb->s_master_keys, keyring);
 	return 0;
 }
 
 /*
  * Release all encryption keys that have been added to the filesystem, along
- * with the keyring that contains them.
+ * with the keyring that contains them.  This is called at unmount time.
  *
- * This is called at unmount time, after all potentially-encrypted inodes have
- * been evicted.  The filesystem's underlying block device(s) are still
- * available at this time; this is important because after user file accesses
- * have been allowed, this function may need to evict keys from the keyslots of
- * an inline crypto engine, which requires the block device(s).
+ * Filesystems must call this from their ->put_super() method, after all
+ * potentially-encrypted inodes have been evicted but before the data structures
+ * needed for fscrypt_operations::get_devices() to work have been freed.  For
+ * block device based filesystems, the filesystem's block device(s) must still
+ * be available so that inline encryption keys can be evicted if necessary.
  */
 void fscrypt_destroy_keyring(struct super_block *sb)
 {
 	struct fscrypt_keyring *keyring = sb->s_master_keys;
 	size_t i;
 
 	if (!keyring)
 		return;
 
 	for (i = 0; i < ARRAY_SIZE(keyring->key_hashtable); i++) {
@@ -251,20 +251,21 @@ void fscrypt_destroy_keyring(struct super_block *sb)
 			 */
 			WARN_ON_ONCE(refcount_read(&mk->mk_active_refs) != 1);
 			WARN_ON_ONCE(refcount_read(&mk->mk_struct_refs) != 1);
 			WARN_ON_ONCE(!mk->mk_present);
 			fscrypt_initiate_key_removal(sb, mk);
 		}
 	}
 	kfree_sensitive(keyring);
 	sb->s_master_keys = NULL;
 }
+EXPORT_SYMBOL_GPL(fscrypt_destroy_keyring);
 
 static struct hlist_head *
 fscrypt_mk_hash_bucket(struct fscrypt_keyring *keyring,
 		       const struct fscrypt_key_specifier *mk_spec)
 {
 	/*
 	 * Since key specifiers should be "random" values, it is sufficient to
 	 * use a trivial hash function that just takes the first several bits of
 	 * the key specifier.
 	 */
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index c5fcf377ab1fa..86aa642a866c5 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1288,20 +1288,22 @@ static void ext4_flex_groups_free(struct ext4_sb_info *sbi)
 	rcu_read_unlock();
 }
 
 static void ext4_put_super(struct super_block *sb)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct ext4_super_block *es = sbi->s_es;
 	int aborted = 0;
 	int err;
 
+	fscrypt_destroy_keyring(sb);
+
 	/*
 	 * Unregister sysfs before destroying jbd2 journal.
 	 * Since we could still access attr_journal_task attribute via sysfs
 	 * path which could have sbi->s_journal->j_task as NULL
 	 * Unregister sysfs before flush sbi->s_sb_upd_work.
 	 * Since user may read /proc/fs/ext4/xx/mb_groups during umount, If
 	 * read metadata verify failed then will queue error work.
 	 * update_super_work will call start_this_handle may trigger
 	 * BUG_ON.
 	 */
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 033af907c3b1d..5cfd0a53a10d6 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1618,20 +1618,22 @@ static void destroy_device_list(struct f2fs_sb_info *sbi)
 	kvfree(sbi->devs);
 }
 
 static void f2fs_put_super(struct super_block *sb)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
 	int i;
 	int err = 0;
 	bool done;
 
+	fscrypt_destroy_keyring(sb);
+
 	/* unregister procfs/sysfs entries in advance to avoid race case */
 	f2fs_unregister_sysfs(sbi);
 
 	f2fs_quota_off_umount(sb);
 
 	/* prevent remaining shrinker jobs */
 	mutex_lock(&sbi->umount_mutex);
 
 	/*
 	 * flush all issued checkpoints and stop checkpoint issue thread.
diff --git a/fs/super.c b/fs/super.c
index 076392396e724..b697f2064a905 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -24,21 +24,20 @@
 #include <linux/export.h>
 #include <linux/slab.h>
 #include <linux/blkdev.h>
 #include <linux/mount.h>
 #include <linux/security.h>
 #include <linux/writeback.h>		/* for the emergency remount stuff */
 #include <linux/idr.h>
 #include <linux/mutex.h>
 #include <linux/backing-dev.h>
 #include <linux/rculist_bl.h>
-#include <linux/fscrypt.h>
 #include <linux/fsnotify.h>
 #include <linux/lockdep.h>
 #include <linux/user_namespace.h>
 #include <linux/fs_context.h>
 #include <uapi/linux/mount.h>
 #include "internal.h"
 
 static int thaw_super_locked(struct super_block *sb, enum freeze_holder who);
 
 static LIST_HEAD(super_blocks);
@@ -674,26 +673,20 @@ void generic_shutdown_super(struct super_block *sb)
 		/* Evict all inodes with zero refcount. */
 		evict_inodes(sb);
 
 		/*
 		 * Clean up and evict any inodes that still have references due
 		 * to fsnotify or the security policy.
 		 */
 		fsnotify_sb_delete(sb);
 		security_sb_delete(sb);
 
-		/*
-		 * Now that all potentially-encrypted inodes have been evicted,
-		 * the fscrypt keyring can be destroyed.
-		 */
-		fscrypt_destroy_keyring(sb);
-
 		if (sb->s_dio_done_wq) {
 			destroy_workqueue(sb->s_dio_done_wq);
 			sb->s_dio_done_wq = NULL;
 		}
 
 		if (sop->put_super)
 			sop->put_super(sb);
 
 		if (CHECK_DATA_CORRUPTION(!list_empty(&sb->s_inodes),
 				"VFS: Busy inodes after unmount of %s (%s)",
diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index 09e270d6ed025..b6fa27412c43e 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -1925,20 +1925,22 @@ static void ubifs_remount_ro(struct ubifs_info *c)
 	mutex_unlock(&c->umount_mutex);
 }
 
 static void ubifs_put_super(struct super_block *sb)
 {
 	int i;
 	struct ubifs_info *c = sb->s_fs_info;
 
 	ubifs_msg(c, "un-mount UBI device %d", c->vi.ubi_num);
 
+	fscrypt_destroy_keyring(sb);
+
 	/*
 	 * The following asserts are only valid if there has not been a failure
 	 * of the media. For example, there will be dirty inodes if we failed
 	 * to write them back because of I/O errors.
 	 */
 	if (!c->ro_error) {
 		ubifs_assert(c, c->bi.idx_growth == 0);
 		ubifs_assert(c, c->bi.dd_growth == 0);
 		ubifs_assert(c, c->bi.data_growth == 0);
 	}

base-commit: 33cc938e65a98f1d29d0a18403dbbee050dcad9a
-- 
2.43.0


