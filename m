Return-Path: <linux-fsdevel+bounces-1028-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F717D50EE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 15:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8181CB20FB0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 13:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5C729406;
	Tue, 24 Oct 2023 13:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="djcYZ/B9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D33314A84
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 13:06:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C351C433C8;
	Tue, 24 Oct 2023 13:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698152772;
	bh=V47he2npVP8GSLfUCdp40Hooxnm7f2iCuON82HbGixg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=djcYZ/B9tG5aP2HrQ9TxPeD98nS9EIu9x6HAJDn6EijTyHVeZ0ulpR+czsJtZrQQE
	 djbSHAsMGEX30+Rkt6viWaFMg5sI0N8y6RrrALXinZS8Nq/fj+4vaMCiNm/6PlCP8j
	 gCJme+um+M840a5NJIOpLIWIVjJ1OUJHYmS/fzYqUlP4F7Z5aONUWX5B81SOUk6Rfg
	 HEQ2Pw1/Id49JU/6AZWlWTBTHFtzpGksDWbEN3AAzmc4R9cRIFJ6FFWuTgIVEsif/5
	 CQ33QcqQMv6cr4dEDCiLnhXD731U9HBUrMPqKVQ0hZ37QcGLGz5UQsC/0lmhjxeis1
	 y+hVXGIZMpB7w==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 24 Oct 2023 15:01:07 +0200
Subject: [PATCH v2 01/10] fs: massage locking helpers
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231024-vfs-super-freeze-v2-1-599c19f4faac@kernel.org>
References: <20231024-vfs-super-freeze-v2-0-599c19f4faac@kernel.org>
In-Reply-To: <20231024-vfs-super-freeze-v2-0-599c19f4faac@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
 "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=7882; i=brauner@kernel.org;
 h=from:subject:message-id; bh=V47he2npVP8GSLfUCdp40Hooxnm7f2iCuON82HbGixg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSaH3RgOSA741jgZiY2wQMWGnqLGSJMrvU8T3s7L+npfdH0
 lDeOHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABM5fYbhf9jLCSv9BWvnZjvO/vzjsa
 j4t6mLWl/sq+5ZpvkvrfsVzzdGhtVS64uWh0ZrOazhXHVqf9Hi919XGGtrurnlXfp2y0XsKBMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Multiple people have balked at the the fact that
super_lock{_shared,_excluse}() return booleans and even if they return
false hold s_umount. So let's change them to only hold s_umount when
true is returned and change the code accordingly.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/super.c | 105 +++++++++++++++++++++++++++++++++++--------------------------
 1 file changed, 61 insertions(+), 44 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index c7b452e12e4c..9cf3ee50cecd 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -105,8 +105,9 @@ static inline bool wait_born(struct super_block *sb)
  *
  * The caller must have acquired a temporary reference on @sb->s_count.
  *
- * Return: This returns true if SB_BORN was set, false if SB_DYING was
- *         set. The function acquires s_umount and returns with it held.
+ * Return: The function returns true if SB_BORN was set and with
+ *         s_umount held. The function returns false if SB_DYING was
+ *         set and without s_umount held.
  */
 static __must_check bool super_lock(struct super_block *sb, bool excl)
 {
@@ -121,8 +122,10 @@ static __must_check bool super_lock(struct super_block *sb, bool excl)
 	 * @sb->s_root is NULL and @sb->s_active is 0. No one needs to
 	 * grab a reference to this. Tell them so.
 	 */
-	if (sb->s_flags & SB_DYING)
+	if (sb->s_flags & SB_DYING) {
+		super_unlock(sb, excl);
 		return false;
+	}
 
 	/* Has called ->get_tree() successfully. */
 	if (sb->s_flags & SB_BORN)
@@ -140,13 +143,13 @@ static __must_check bool super_lock(struct super_block *sb, bool excl)
 	goto relock;
 }
 
-/* wait and acquire read-side of @sb->s_umount */
+/* wait and try to acquire read-side of @sb->s_umount */
 static inline bool super_lock_shared(struct super_block *sb)
 {
 	return super_lock(sb, false);
 }
 
-/* wait and acquire write-side of @sb->s_umount */
+/* wait and try to acquire write-side of @sb->s_umount */
 static inline bool super_lock_excl(struct super_block *sb)
 {
 	return super_lock(sb, true);
@@ -532,16 +535,18 @@ EXPORT_SYMBOL(deactivate_super);
  */
 static int grab_super(struct super_block *s) __releases(sb_lock)
 {
-	bool born;
+	bool locked;
 
 	s->s_count++;
 	spin_unlock(&sb_lock);
-	born = super_lock_excl(s);
-	if (born && atomic_inc_not_zero(&s->s_active)) {
-		put_super(s);
-		return 1;
+	locked = super_lock_excl(s);
+	if (locked) {
+		if (atomic_inc_not_zero(&s->s_active)) {
+			put_super(s);
+			return 1;
+		}
+		super_unlock_excl(s);
 	}
-	super_unlock_excl(s);
 	put_super(s);
 	return 0;
 }
@@ -572,7 +577,6 @@ static inline bool wait_dead(struct super_block *sb)
  */
 static bool grab_super_dead(struct super_block *sb)
 {
-
 	sb->s_count++;
 	if (grab_super(sb)) {
 		put_super(sb);
@@ -958,15 +962,17 @@ void iterate_supers(void (*f)(struct super_block *, void *), void *arg)
 
 	spin_lock(&sb_lock);
 	list_for_each_entry(sb, &super_blocks, s_list) {
-		bool born;
+		bool locked;
 
 		sb->s_count++;
 		spin_unlock(&sb_lock);
 
-		born = super_lock_shared(sb);
-		if (born && sb->s_root)
-			f(sb, arg);
-		super_unlock_shared(sb);
+		locked = super_lock_shared(sb);
+		if (locked) {
+			if (sb->s_root)
+				f(sb, arg);
+			super_unlock_shared(sb);
+		}
 
 		spin_lock(&sb_lock);
 		if (p)
@@ -994,15 +1000,17 @@ void iterate_supers_type(struct file_system_type *type,
 
 	spin_lock(&sb_lock);
 	hlist_for_each_entry(sb, &type->fs_supers, s_instances) {
-		bool born;
+		bool locked;
 
 		sb->s_count++;
 		spin_unlock(&sb_lock);
 
-		born = super_lock_shared(sb);
-		if (born && sb->s_root)
-			f(sb, arg);
-		super_unlock_shared(sb);
+		locked = super_lock_shared(sb);
+		if (locked) {
+			if (sb->s_root)
+				f(sb, arg);
+			super_unlock_shared(sb);
+		}
 
 		spin_lock(&sb_lock);
 		if (p)
@@ -1051,15 +1059,17 @@ struct super_block *user_get_super(dev_t dev, bool excl)
 	spin_lock(&sb_lock);
 	list_for_each_entry(sb, &super_blocks, s_list) {
 		if (sb->s_dev ==  dev) {
-			bool born;
+			bool locked;
 
 			sb->s_count++;
 			spin_unlock(&sb_lock);
 			/* still alive? */
-			born = super_lock(sb, excl);
-			if (born && sb->s_root)
-				return sb;
-			super_unlock(sb, excl);
+			locked = super_lock(sb, excl);
+			if (locked) {
+				if (sb->s_root)
+					return sb;
+				super_unlock(sb, excl);
+			}
 			/* nope, got unmounted */
 			spin_lock(&sb_lock);
 			__put_super(sb);
@@ -1170,9 +1180,9 @@ int reconfigure_super(struct fs_context *fc)
 
 static void do_emergency_remount_callback(struct super_block *sb)
 {
-	bool born = super_lock_excl(sb);
+	bool locked = super_lock_excl(sb);
 
-	if (born && sb->s_root && sb->s_bdev && !sb_rdonly(sb)) {
+	if (locked && sb->s_root && sb->s_bdev && !sb_rdonly(sb)) {
 		struct fs_context *fc;
 
 		fc = fs_context_for_reconfigure(sb->s_root,
@@ -1183,7 +1193,8 @@ static void do_emergency_remount_callback(struct super_block *sb)
 			put_fs_context(fc);
 		}
 	}
-	super_unlock_excl(sb);
+	if (locked)
+		super_unlock_excl(sb);
 }
 
 static void do_emergency_remount(struct work_struct *work)
@@ -1206,16 +1217,17 @@ void emergency_remount(void)
 
 static void do_thaw_all_callback(struct super_block *sb)
 {
-	bool born = super_lock_excl(sb);
+	bool locked = super_lock_excl(sb);
 
-	if (born && sb->s_root) {
+	if (locked && sb->s_root) {
 		if (IS_ENABLED(CONFIG_BLOCK))
 			while (sb->s_bdev && !thaw_bdev(sb->s_bdev))
 				pr_warn("Emergency Thaw on %pg\n", sb->s_bdev);
 		thaw_super_locked(sb, FREEZE_HOLDER_USERSPACE);
-	} else {
-		super_unlock_excl(sb);
+		return;
 	}
+	if (locked)
+		super_unlock_excl(sb);
 }
 
 static void do_thaw_all(struct work_struct *work)
@@ -1429,7 +1441,7 @@ static struct super_block *bdev_super_lock_shared(struct block_device *bdev)
 	__releases(&bdev->bd_holder_lock)
 {
 	struct super_block *sb = bdev->bd_holder;
-	bool born;
+	bool locked;
 
 	lockdep_assert_held(&bdev->bd_holder_lock);
 	lockdep_assert_not_held(&sb->s_umount);
@@ -1441,9 +1453,8 @@ static struct super_block *bdev_super_lock_shared(struct block_device *bdev)
 	spin_unlock(&sb_lock);
 	mutex_unlock(&bdev->bd_holder_lock);
 
-	born = super_lock_shared(sb);
-	if (!born || !sb->s_root || !(sb->s_flags & SB_ACTIVE)) {
-		super_unlock_shared(sb);
+	locked = super_lock_shared(sb);
+	if (!locked || !sb->s_root || !(sb->s_flags & SB_ACTIVE)) {
 		put_super(sb);
 		return NULL;
 	}
@@ -1959,9 +1970,11 @@ int freeze_super(struct super_block *sb, enum freeze_holder who)
 {
 	int ret;
 
+	if (!super_lock_excl(sb)) {
+		WARN_ON_ONCE("Dying superblock while freezing!");
+		return -EINVAL;
+	}
 	atomic_inc(&sb->s_active);
-	if (!super_lock_excl(sb))
-		WARN(1, "Dying superblock while freezing!");
 
 retry:
 	if (sb->s_writers.frozen == SB_FREEZE_COMPLETE) {
@@ -2009,8 +2022,10 @@ int freeze_super(struct super_block *sb, enum freeze_holder who)
 	/* Release s_umount to preserve sb_start_write -> s_umount ordering */
 	super_unlock_excl(sb);
 	sb_wait_write(sb, SB_FREEZE_WRITE);
-	if (!super_lock_excl(sb))
-		WARN(1, "Dying superblock while freezing!");
+	if (!super_lock_excl(sb)) {
+		WARN_ON_ONCE("Dying superblock while freezing!");
+		return -EINVAL;
+	}
 
 	/* Now we go and block page faults... */
 	sb->s_writers.frozen = SB_FREEZE_PAGEFAULT;
@@ -2128,8 +2143,10 @@ static int thaw_super_locked(struct super_block *sb, enum freeze_holder who)
  */
 int thaw_super(struct super_block *sb, enum freeze_holder who)
 {
-	if (!super_lock_excl(sb))
-		WARN(1, "Dying superblock while thawing!");
+	if (!super_lock_excl(sb)) {
+		WARN_ON_ONCE("Dying superblock while thawing!");
+		return -EINVAL;
+	}
 	return thaw_super_locked(sb, who);
 }
 EXPORT_SYMBOL(thaw_super);

-- 
2.34.1


