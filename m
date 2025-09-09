Return-Path: <linux-fsdevel+bounces-60639-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4090B4A761
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 11:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95D08543C5B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 09:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39ECD2C21EC;
	Tue,  9 Sep 2025 09:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AOtnCJCS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8EE2C15A0;
	Tue,  9 Sep 2025 09:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757409275; cv=none; b=Zb+AdB74jntDqvcMm33D/rZ+J5P4UbHMg105pdnVP/dQ+0okIqB9dW9eh6mtfYX62JjqNYZqcyuOUS9US8aK7l7r0J1WhPdvqkCxorS+BJkFpdJz8lN5ztq3I6A4iwz6kxP7PphfLh5tuKQsVk1mhRlrw264cby6QqGaICvd/vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757409275; c=relaxed/simple;
	bh=IMseACTiSvlyfiyb+LeynI6JiS3FUZBsMYDVNhYzMhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TUa2W4f2gSHe4RgY56/U1qqTUcq/GpkBD6AzaZMH296PfWm1ZYC6uiGKIz8rQIdxYfyeD9ThYjR6JPx8xz0gVpfn0yZYxO7l3VbTS/s6beg+riW4QieO+qxpkNS4ec5kWXu/Onr3n0pZ66vdMRs0r3FiJ3n8r5fYszitujM8DIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AOtnCJCS; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45de6490e74so17974425e9.2;
        Tue, 09 Sep 2025 02:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757409271; x=1758014071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QxYF3RT5zHEtZoH+0QZfPrO40F2dnCdJJPKEE+ejIoU=;
        b=AOtnCJCSUOfr1HYjFg3Fp3oIFyHF8c+owZVYjf6QLEC4URTHPkTLufjBaUZ2oyBAMO
         XgOoOjW8/WrDbRmUTL3a2y3E/6mW9ubLoQevsCnFuNMZSKCwCgVZ6f6GH1j9+XwvE9SI
         nlSrvw+V6NytW2o2WuLlWR5KDbBVjOCPeKbUgGIADZLbWDq69RO3Fdg+rYdwXoFEWdGg
         +uS9vcT+4IL/Z1zxWj9kuFQGjkjj40ytVQJSMl5T3MyD0KCtsZeLJaBoxKpv25VGjWzC
         S3v+cEDtINNvOXCF53Nt7d8RU4q0yCOYs8QIRP9LgSzduJJAbTfy3mxjx3mD7gTM5FXP
         IKCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757409271; x=1758014071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QxYF3RT5zHEtZoH+0QZfPrO40F2dnCdJJPKEE+ejIoU=;
        b=Zx+KXJduIswF399QnB5mq+namOnljXQS54bVL3OdQmJ/fp022swn5VeQWF7EP7oEig
         e7utuCuX4Hwf94jCi/ep74/jBE59X36aUBQyuGr34W63OFmrcspmuimyN41rYXEUjExt
         MlPiWwhvsn3snlzdmv+qLb31lxUWtm8UD7bLamHAYC2taX7jIzOO8HU3HPyQzZxxeTLW
         55eBeLNHInTWuhxx4krjA/WItSIzsQ5YVX38JgC+ShKoRXJTnhREezsL91TR/dlaVYV0
         Ruk1ZXaoGuh1qFixeqEurFHoXOQuXt8TX4ZIZHvO1L6kZFl1bsuwmzZl3A4WlK2UbJ/W
         RthQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3gGuFcUxQhzlj+hMYETu8x+fZKNw0FxfNwaTAa64QtZZyy0+bryJbgTddOAmyCJ7ATD3TxyPlnGki@vger.kernel.org, AJvYcCVVaaJbNm7AcFlNcpVl2MPOcLN50TrNMNHGhiKc0NJ6Byw7ycRxQbBPQ6O/q0VgwJeM/6gB2SoLm9jC2Q==@vger.kernel.org, AJvYcCVfrNAjMbGBmGq+XTuFOqOVAa/4mB7+IlzkyImDVj18EKwPl2xy71I9SIDGohMh61+BBw0pHxzqs74roGkb@vger.kernel.org, AJvYcCVqqyxDR0KkS/yc2/78Ju350DLUsXFBAIul+bJmpN1KrSdjBrrJMP/mpeziVsvlBNXVb/V8oblMA0q9og==@vger.kernel.org, AJvYcCWgdwJ76cNx9x1B/U/rc7JxXj2jFamEVuYefWILNan6/2Ml8bj/f9+2vibItur+F7hRBXMtzF30jVvq/zy5Ew==@vger.kernel.org
X-Gm-Message-State: AOJu0YzwnN6W4VlzZFNDo4XuWFXFSeLeQ7Zdl6SGcMHpuFT7QkbBFkZ9
	VbFFdcOuDEeuJXYqdVKFjQ4PJyIMCBPvxGDcYgVVC5gdsLsQd7hexWf7
X-Gm-Gg: ASbGncvm0XZbhebKSyCAeYEXSFCeyKAW99cawCk6afEtS++80FuDXuCUD15hpgZz9qE
	PoeMjpwRTDxxXm9QLr8HZ+GsOJjcsaQhvGfjIQEA9pIV2EvTCoW1xTgspgiGvQrqt6wk9YC+5Dy
	PYP4NMGHCtLjYX7PYsA4pRCUUGQNEbIhcjRc0S+gNU4vHVzyjuQ9N80Q27gUtLPC59NK1bjqlNz
	bG0FLqls6Pm/Jb8QEYG+ZquyQ/MnfTik+GECqJ1DJOoOF97MkxGCGDgqE/GPwc7Q3hb9W+J2vtQ
	Zis9M8ITpXCaeiGvxm6p6EJIQ+JcqicxftdeZci8oGyoaMcAu5yqF7K9Mq35uAm09NduE+EPyEA
	hRBK9qb7l05F42NWpTJcrSQHgB685IbiaudWciobARcsM4fT5crc=
X-Google-Smtp-Source: AGHT+IFi9+++EXFDxbZpee7QFWmtTnxdJJIkcvTcwNq69a2UHcOEtGo+RK/G6yNxl517a45cK9euag==
X-Received: by 2002:a05:600c:1c19:b0:45b:7d24:beac with SMTP id 5b1f17b1804b1-45df2e0495bmr6716185e9.10.1757409270816;
        Tue, 09 Sep 2025 02:14:30 -0700 (PDT)
Received: from f.. (cst-prg-84-152.cust.vodafone.cz. [46.135.84.152])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7521bff6esm1810784f8f.13.2025.09.09.02.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 02:14:30 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	josef@toxicpanda.com,
	kernel-team@fb.com,
	amir73il@gmail.com,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2 10/10] fs: retire the I_WILL_FREE flag
Date: Tue,  9 Sep 2025 11:13:44 +0200
Message-ID: <20250909091344.1299099-11-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250909091344.1299099-1-mjguzik@gmail.com>
References: <20250909091344.1299099-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 block/bdev.c                     |  2 +-
 fs/bcachefs/fs.c                 |  2 +-
 fs/btrfs/inode.c                 |  2 +-
 fs/crypto/keyring.c              |  2 +-
 fs/drop_caches.c                 |  2 +-
 fs/ext4/inode.c                  |  4 ++--
 fs/fs-writeback.c                | 20 +++++++++----------
 fs/gfs2/ops_fstype.c             |  2 +-
 fs/inode.c                       | 18 ++++++++---------
 fs/notify/fsnotify.c             |  8 ++++----
 fs/quota/dquot.c                 |  2 +-
 fs/xfs/scrub/common.c            |  3 +--
 include/linux/fs.h               | 34 +++++++++++++-------------------
 include/trace/events/writeback.h |  3 +--
 security/landlock/fs.c           |  2 +-
 15 files changed, 48 insertions(+), 58 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 77f04042ac67..fb280f7b04c0 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -1265,7 +1265,7 @@ void sync_bdevs(bool wait)
 		struct block_device *bdev;
 
 		spin_lock(&inode->i_lock);
-		if (inode_state_read(inode) & (I_FREEING|I_WILL_FREE|I_NEW) ||
+		if (inode_state_read(inode) & (I_NEW | I_FREEING) ||
 		    mapping->nrpages == 0) {
 			spin_unlock(&inode->i_lock);
 			continue;
diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
index 172685ced878..1aeacc9a945e 100644
--- a/fs/bcachefs/fs.c
+++ b/fs/bcachefs/fs.c
@@ -347,7 +347,7 @@ static struct bch_inode_info *bch2_inode_hash_find(struct bch_fs *c, struct btre
 			spin_unlock(&inode->v.i_lock);
 			return NULL;
 		}
-		if ((inode_state_read(&inode->v) & (I_FREEING|I_WILL_FREE))) {
+		if (inode_state_read(&inode->v) & I_FREEING) {
 			if (!trans) {
 				__wait_on_freeing_inode(c, inode, inum);
 			} else {
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 1cfdba42f072..5a3cb16a9420 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3856,7 +3856,7 @@ static int btrfs_add_inode_to_root(struct btrfs_inode *inode, bool prealloc)
 		ASSERT(ret != -ENOMEM);
 		return ret;
 	} else if (existing) {
-		WARN_ON(!(inode_state_read_unlocked(&existing->vfs_inode) & (I_WILL_FREE | I_FREEING)));
+		WARN_ON(!(inode_state_read_unlocked(&existing->vfs_inode) & I_FREEING));
 	}
 
 	return 0;
diff --git a/fs/crypto/keyring.c b/fs/crypto/keyring.c
index 34beb60bc24e..b64726176218 100644
--- a/fs/crypto/keyring.c
+++ b/fs/crypto/keyring.c
@@ -957,7 +957,7 @@ static void evict_dentries_for_decrypted_inodes(struct fscrypt_master_key *mk)
 	list_for_each_entry(ci, &mk->mk_decrypted_inodes, ci_master_key_link) {
 		inode = ci->ci_inode;
 		spin_lock(&inode->i_lock);
-		if (inode_state_read(inode) & (I_FREEING | I_WILL_FREE | I_NEW)) {
+		if (inode_state_read(inode) & (I_NEW | I_FREEING)) {
 			spin_unlock(&inode->i_lock);
 			continue;
 		}
diff --git a/fs/drop_caches.c b/fs/drop_caches.c
index 73175ac2fe92..687795d7846b 100644
--- a/fs/drop_caches.c
+++ b/fs/drop_caches.c
@@ -28,7 +28,7 @@ static void drop_pagecache_sb(struct super_block *sb, void *unused)
 		 * inodes without pages but we deliberately won't in case
 		 * we need to reschedule to avoid softlockups.
 		 */
-		if ((inode_state_read(inode) & (I_FREEING|I_WILL_FREE|I_NEW)) ||
+		if ((inode_state_read(inode) & (I_NEW | I_FREEING)) ||
 		    (mapping_empty(inode->i_mapping) && !need_resched())) {
 			spin_unlock(&inode->i_lock);
 			continue;
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 55d87fa1c5af..db9a24ca7192 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -425,7 +425,7 @@ void ext4_check_map_extents_env(struct inode *inode)
 	if (!S_ISREG(inode->i_mode) ||
 	    IS_NOQUOTA(inode) || IS_VERITY(inode) ||
 	    is_special_ino(inode->i_sb, inode->i_ino) ||
-	    (inode_state_read_unlocked(inode) & (I_FREEING | I_WILL_FREE | I_NEW)) ||
+	    (inode_state_read_unlocked(inode) & (I_NEW | I_FREEING)) ||
 	    ext4_test_inode_flag(inode, EXT4_INODE_EA_INODE) ||
 	    ext4_verity_in_progress(inode))
 		return;
@@ -4581,7 +4581,7 @@ int ext4_truncate(struct inode *inode)
 	 * or it's a completely new inode. In those cases we might not
 	 * have i_rwsem locked because it's not necessary.
 	 */
-	if (!(inode_state_read_unlocked(inode) & (I_NEW|I_FREEING)))
+	if (!(inode_state_read_unlocked(inode) & (I_NEW | I_FREEING)))
 		WARN_ON(!inode_is_locked(inode));
 	trace_ext4_truncate_enter(inode);
 
diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 67c2157a7d21..a3fb9004b581 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -405,10 +405,10 @@ static bool inode_do_switch_wbs(struct inode *inode,
 	xa_lock_irq(&mapping->i_pages);
 
 	/*
-	 * Once I_FREEING or I_WILL_FREE are visible under i_lock, the eviction
-	 * path owns the inode and we shouldn't modify ->i_io_list.
+	 * Once I_FREEING is visible under i_lock, the eviction path owns the
+	 * inode and we shouldn't modify ->i_io_list.
 	 */
-	if (unlikely(inode_state_read(inode) & (I_FREEING | I_WILL_FREE)))
+	if (unlikely(inode_state_read(inode) & I_FREEING))
 		goto skip_switch;
 
 	trace_inode_switch_wbs(inode, old_wb, new_wb);
@@ -561,7 +561,7 @@ static bool inode_prepare_wbs_switch(struct inode *inode,
 	/* while holding I_WB_SWITCH, no one else can update the association */
 	spin_lock(&inode->i_lock);
 	if (!(inode->i_sb->s_flags & SB_ACTIVE) ||
-	    inode_state_read(inode) & (I_WB_SWITCH | I_FREEING | I_WILL_FREE) ||
+	    inode_state_read(inode) & (I_WB_SWITCH | I_FREEING) ||
 	    inode_to_wb(inode) == new_wb) {
 		spin_unlock(&inode->i_lock);
 		return false;
@@ -1759,7 +1759,7 @@ __writeback_single_inode(struct inode *inode, struct writeback_control *wbc)
  * whether it is a data-integrity sync (%WB_SYNC_ALL) or not (%WB_SYNC_NONE).
  *
  * To prevent the inode from going away, either the caller must have a reference
- * to the inode, or the inode must have I_WILL_FREE or I_FREEING set.
+ * to the inode, or the inode must have I_FREEING set.
  */
 static int writeback_single_inode(struct inode *inode,
 				  struct writeback_control *wbc)
@@ -1769,9 +1769,7 @@ static int writeback_single_inode(struct inode *inode,
 
 	spin_lock(&inode->i_lock);
 	if (!icount_read(inode))
-		WARN_ON(!(inode_state_read(inode) & (I_WILL_FREE|I_FREEING)));
-	else
-		WARN_ON(inode_state_read(inode) & I_WILL_FREE);
+		WARN_ON(!(inode_state_read(inode) & I_FREEING));
 
 	if (inode_state_read(inode) & I_SYNC) {
 		/*
@@ -1929,7 +1927,7 @@ static long writeback_sb_inodes(struct super_block *sb,
 		 * kind writeout is handled by the freer.
 		 */
 		spin_lock(&inode->i_lock);
-		if (inode_state_read(inode) & (I_NEW | I_FREEING | I_WILL_FREE)) {
+		if (inode_state_read(inode) & (I_NEW | I_FREEING)) {
 			redirty_tail_locked(inode, wb);
 			spin_unlock(&inode->i_lock);
 			continue;
@@ -2697,7 +2695,7 @@ static void wait_sb_inodes(struct super_block *sb)
 		spin_unlock_irq(&sb->s_inode_wblist_lock);
 
 		spin_lock(&inode->i_lock);
-		if (inode_state_read(inode) & (I_FREEING|I_WILL_FREE|I_NEW)) {
+		if (inode_state_read(inode) & (I_NEW | I_FREEING)) {
 			spin_unlock(&inode->i_lock);
 
 			spin_lock_irq(&sb->s_inode_wblist_lock);
@@ -2846,7 +2844,7 @@ EXPORT_SYMBOL(sync_inodes_sb);
  * This function commits an inode to disk immediately if it is dirty. This is
  * primarily needed by knfsd.
  *
- * The caller must either have a ref on the inode or must have set I_WILL_FREE.
+ * The caller must either have a ref on the inode or must have set I_FREEING.
  */
 int write_inode_now(struct inode *inode, int sync)
 {
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index 3ccd902ec5ba..240894adb34d 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -1749,7 +1749,7 @@ static void gfs2_evict_inodes(struct super_block *sb)
 	spin_lock(&sb->s_inode_list_lock);
 	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
 		spin_lock(&inode->i_lock);
-		if ((inode_state_read(inode) & (I_FREEING|I_WILL_FREE|I_NEW)) &&
+		if ((inode_state_read(inode) & (I_NEW | I_FREEING)) &&
 		    !need_resched()) {
 			spin_unlock(&inode->i_lock);
 			continue;
diff --git a/fs/inode.c b/fs/inode.c
index 9c695339ec3e..6a69de0bf7bd 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -532,7 +532,7 @@ EXPORT_SYMBOL(ihold);
 
 static void __inode_add_lru(struct inode *inode, bool rotate)
 {
-	if (inode_state_read(inode) & (I_DIRTY_ALL | I_SYNC | I_FREEING | I_WILL_FREE))
+	if (inode_state_read(inode) & (I_DIRTY_ALL | I_SYNC | I_FREEING))
 		return;
 	if (icount_read(inode))
 		return;
@@ -577,7 +577,7 @@ static void inode_lru_list_del(struct inode *inode)
 static void inode_pin_lru_isolating(struct inode *inode)
 {
 	lockdep_assert_held(&inode->i_lock);
-	WARN_ON(inode_state_read(inode) & (I_LRU_ISOLATING | I_FREEING | I_WILL_FREE));
+	WARN_ON(inode_state_read(inode) & (I_LRU_ISOLATING | I_FREEING));
 	inode_state_add(inode, I_LRU_ISOLATING);
 }
 
@@ -879,7 +879,7 @@ void evict_inodes(struct super_block *sb)
 			spin_unlock(&inode->i_lock);
 			continue;
 		}
-		if (inode_state_read(inode) & (I_NEW | I_FREEING | I_WILL_FREE)) {
+		if (inode_state_read(inode) & (I_NEW | I_FREEING)) {
 			spin_unlock(&inode->i_lock);
 			continue;
 		}
@@ -1025,7 +1025,7 @@ static struct inode *find_inode(struct super_block *sb,
 		if (!test(inode, data))
 			continue;
 		spin_lock(&inode->i_lock);
-		if (inode_state_read(inode) & (I_FREEING|I_WILL_FREE)) {
+		if (inode_state_read(inode) & I_FREEING) {
 			__wait_on_freeing_inode(inode, is_inode_hash_locked);
 			goto repeat;
 		}
@@ -1066,7 +1066,7 @@ static struct inode *find_inode_fast(struct super_block *sb,
 		if (inode->i_sb != sb)
 			continue;
 		spin_lock(&inode->i_lock);
-		if (inode_state_read(inode) & (I_FREEING|I_WILL_FREE)) {
+		if (inode_state_read(inode) & I_FREEING) {
 			__wait_on_freeing_inode(inode, is_inode_hash_locked);
 			goto repeat;
 		}
@@ -1538,7 +1538,7 @@ EXPORT_SYMBOL(iunique);
 struct inode *igrab(struct inode *inode)
 {
 	spin_lock(&inode->i_lock);
-	if (!(inode_state_read(inode) & (I_FREEING|I_WILL_FREE))) {
+	if (!(inode_state_read(inode) & I_FREEING)) {
 		__iget(inode);
 		spin_unlock(&inode->i_lock);
 	} else {
@@ -1728,7 +1728,7 @@ struct inode *find_inode_rcu(struct super_block *sb, unsigned long hashval,
 
 	hlist_for_each_entry_rcu(inode, head, i_hash) {
 		if (inode->i_sb == sb &&
-		    !(inode_state_read_unlocked(inode) & (I_FREEING | I_WILL_FREE)) &&
+		    !(inode_state_read_unlocked(inode) & I_FREEING) &&
 		    test(inode, data))
 			return inode;
 	}
@@ -1767,7 +1767,7 @@ struct inode *find_inode_by_ino_rcu(struct super_block *sb,
 	hlist_for_each_entry_rcu(inode, head, i_hash) {
 		if (inode->i_ino == ino &&
 		    inode->i_sb == sb &&
-		    !(inode_state_read_unlocked(inode) & (I_FREEING | I_WILL_FREE)))
+		    !(inode_state_read_unlocked(inode) & I_FREEING))
 		    return inode;
 	}
 	return NULL;
@@ -1789,7 +1789,7 @@ int insert_inode_locked(struct inode *inode)
 			if (old->i_sb != sb)
 				continue;
 			spin_lock(&old->i_lock);
-			if (inode_state_read(old) & (I_FREEING|I_WILL_FREE)) {
+			if (inode_state_read(old) & I_FREEING) {
 				spin_unlock(&old->i_lock);
 				continue;
 			}
diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 8e504b40fb39..82b0e97454db 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -47,12 +47,12 @@ static void fsnotify_unmount_inodes(struct super_block *sb)
 	spin_lock(&sb->s_inode_list_lock);
 	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
 		/*
-		 * We cannot __iget() an inode in state I_FREEING,
-		 * I_WILL_FREE, or I_NEW which is fine because by that point
-		 * the inode cannot have any associated watches.
+		 * We cannot __iget() an inode in state I_NEW or I_FREEING
+		 * which is fine because by that point the inode cannot have
+		 * any associated watches.
 		 */
 		spin_lock(&inode->i_lock);
-		if (inode_state_read(inode) & (I_FREEING|I_WILL_FREE|I_NEW)) {
+		if (inode_state_read(inode) & (I_NEW | I_FREEING)) {
 			spin_unlock(&inode->i_lock);
 			continue;
 		}
diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index beb3d82a2915..bd5b1d10a52a 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -1030,7 +1030,7 @@ static int add_dquot_ref(struct super_block *sb, int type)
 	spin_lock(&sb->s_inode_list_lock);
 	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
 		spin_lock(&inode->i_lock);
-		if ((inode_state_read(inode) & (I_FREEING|I_WILL_FREE|I_NEW)) ||
+		if ((inode_state_read(inode) & (I_NEW | I_FREEING)) ||
 		    !atomic_read(&inode->i_writecount) ||
 		    !dqinit_needed(inode, type)) {
 			spin_unlock(&inode->i_lock);
diff --git a/fs/xfs/scrub/common.c b/fs/xfs/scrub/common.c
index 2ef7742be7d3..e678f944206f 100644
--- a/fs/xfs/scrub/common.c
+++ b/fs/xfs/scrub/common.c
@@ -1086,8 +1086,7 @@ xchk_install_handle_inode(
 
 /*
  * Install an already-referenced inode for scrubbing.  Get our own reference to
- * the inode to make disposal simpler.  The inode must not be in I_FREEING or
- * I_WILL_FREE state!
+ * the inode to make disposal simpler.  The inode must not have I_FREEING set.
  */
 int
 xchk_install_live_inode(
diff --git a/include/linux/fs.h b/include/linux/fs.h
index f933d181a40e..40c4c0e8dd45 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -671,8 +671,8 @@ is_uncached_acl(struct posix_acl *acl)
  * I_DIRTY_DATASYNC, I_DIRTY_PAGES, and I_DIRTY_TIME.
  *
  * Four bits define the lifetime of an inode.  Initially, inodes are I_NEW,
- * until that flag is cleared.  I_WILL_FREE, I_FREEING and I_CLEAR are set at
- * various stages of removing an inode.
+ * until that flag is cleared.  I_FREEING and I_CLEAR are set at various stages
+ * of removing an inode.
  *
  * Two bits are used for locking and completion notification, I_NEW and I_SYNC.
  *
@@ -696,24 +696,21 @@ is_uncached_acl(struct posix_acl *acl)
  *			New inodes set I_NEW.  If two processes both create
  *			the same inode, one of them will release its inode and
  *			wait for I_NEW to be released before returning.
- *			Inodes in I_WILL_FREE, I_FREEING or I_CLEAR state can
- *			also cause waiting on I_NEW, without I_NEW actually
- *			being set.  find_inode() uses this to prevent returning
- *			nearly-dead inodes.
- * I_WILL_FREE		Must be set when calling write_inode_now() if i_count
- *			is zero.  I_FREEING must be set when I_WILL_FREE is
- *			cleared.
+ *			Inodes in I_FREEING or I_CLEAR state can also cause
+ *			waiting on I_NEW, without I_NEW actually being set.
+ *			find_inode() uses this to prevent returning nearly-dead
+ *			inodes.
  * I_FREEING		Set when inode is about to be freed but still has dirty
  *			pages or buffers attached or the inode itself is still
  *			dirty.
  * I_CLEAR		Added by clear_inode().  In this state the inode is
  *			clean and can be destroyed.  Inode keeps I_FREEING.
  *
- *			Inodes that are I_WILL_FREE, I_FREEING or I_CLEAR are
- *			prohibited for many purposes.  iget() must wait for
- *			the inode to be completely released, then create it
- *			anew.  Other functions will just ignore such inodes,
- *			if appropriate.  I_NEW is used for waiting.
+ *			Inodes that are I_FREEING or I_CLEAR are prohibited for
+ *			many purposes.  iget() must wait for the inode to be
+ *			completely released, then create it anew.  Other
+ *			functions will just ignore such inodes, if appropriate.
+ *			I_NEW is used for waiting.
  *
  * I_SYNC		Writeback of inode is running. The bit is set during
  *			data writeback, and cleared with a wakeup on the bit
@@ -743,8 +740,6 @@ is_uncached_acl(struct posix_acl *acl)
  * I_LRU_ISOLATING	Inode is pinned being isolated from LRU without holding
  *			i_count.
  *
- * Q: What is the difference between I_WILL_FREE and I_FREEING?
- *
  * __I_{SYNC,NEW,LRU_ISOLATING} are used to derive unique addresses to wait
  * upon. There's one free address left.
  */
@@ -764,7 +759,7 @@ enum inode_state_flags_enum {
 	I_DIRTY_SYNC		= (1U << 4),
 	I_DIRTY_DATASYNC	= (1U << 5),
 	I_DIRTY_PAGES		= (1U << 6),
-	I_WILL_FREE		= (1U << 7),
+	I_PINNING_NETFS_WB	= (1U << 7),
 	I_FREEING		= (1U << 8),
 	I_CLEAR			= (1U << 9),
 	I_REFERENCED		= (1U << 10),
@@ -775,7 +770,6 @@ enum inode_state_flags_enum {
 	I_CREATING		= (1U << 15),
 	I_DONTCACHE		= (1U << 16),
 	I_SYNC_QUEUED		= (1U << 17),
-	I_PINNING_NETFS_WB	= (1U << 18)
 };
 
 #define I_DIRTY_INODE (I_DIRTY_SYNC | I_DIRTY_DATASYNC)
@@ -2664,8 +2658,8 @@ static inline int icount_read(const struct inode *inode)
  */
 static inline bool inode_is_dirtytime_only(struct inode *inode)
 {
-	return (inode_state_read_unlocked(inode) & (I_DIRTY_TIME | I_NEW |
-				  I_FREEING | I_WILL_FREE)) == I_DIRTY_TIME;
+	return (inode_state_read_unlocked(inode) &
+		(I_DIRTY_TIME | I_NEW | I_FREEING)) == I_DIRTY_TIME;
 }
 
 extern void inc_nlink(struct inode *inode);
diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
index 82f6b7f26c29..1c6700011f08 100644
--- a/include/trace/events/writeback.h
+++ b/include/trace/events/writeback.h
@@ -15,7 +15,7 @@
 		{I_DIRTY_DATASYNC,	"I_DIRTY_DATASYNC"},	\
 		{I_DIRTY_PAGES,		"I_DIRTY_PAGES"},	\
 		{I_NEW,			"I_NEW"},		\
-		{I_WILL_FREE,		"I_WILL_FREE"},		\
+		{I_PINNING_NETFS_WB,	"I_PINNING_NETFS_WB"},	\
 		{I_FREEING,		"I_FREEING"},		\
 		{I_CLEAR,		"I_CLEAR"},		\
 		{I_SYNC,		"I_SYNC"},		\
@@ -27,7 +27,6 @@
 		{I_CREATING,		"I_CREATING"},		\
 		{I_DONTCACHE,		"I_DONTCACHE"},		\
 		{I_SYNC_QUEUED,		"I_SYNC_QUEUED"},	\
-		{I_PINNING_NETFS_WB,	"I_PINNING_NETFS_WB"},	\
 		{I_LRU_ISOLATING,	"I_LRU_ISOLATING"}	\
 	)
 
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 56c30d04971f..4135c11ac939 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1296,7 +1296,7 @@ static void hook_sb_delete(struct super_block *const sb)
 		 * iput() for the same Landlock object.  Also checks I_NEW
 		 * because such inode cannot be tied to an object.
 		 */
-		if (inode_state_read(inode) & (I_FREEING | I_WILL_FREE | I_NEW)) {
+		if (inode_state_read(inode) & (I_NEW | I_FREEING)) {
 			spin_unlock(&inode->i_lock);
 			continue;
 		}
-- 
2.43.0


