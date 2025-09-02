Return-Path: <linux-fsdevel+bounces-59996-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4BBB4083B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 16:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B78E3B0E84
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 14:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79DAA320A34;
	Tue,  2 Sep 2025 14:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TzgLrrZm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511F431DDBF;
	Tue,  2 Sep 2025 14:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756824882; cv=none; b=P16JXVd3liWKNOstYLFDHmtzCtfvTxeMjVG1MQf1R7eD4AUgzVMPhS900ApUH8qyu+vFoqDfra+Qj/wqaBqGDnciYZYWSe/cycPfw63+3YC+X33F7ywlk1XfFimrL7qf6jjbhgnjXNHOiYzg4Yhs1yrwBkUqsN0mkatHSw9QFRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756824882; c=relaxed/simple;
	bh=87s2y9MbR6vkGnJsIzaZPbo6IK/VlQxAr6Brw+tVE5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j8h1yKT5/SDv2FM/dtISNxfjDSggDBmn/QQuyRKyP7sFrAk4PtGMVohxPDzfKz+RgU+5rdaa0IovP+hlszBpeEwU0tT3QQa0hcSc6w7SUNv7e99G0aUKsb2HSr+f+QDOohY0o81dj32knPaoBlRlVXFO9AW9ZueEAEFktcifDic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TzgLrrZm; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b042cc3954fso338977166b.0;
        Tue, 02 Sep 2025 07:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756824879; x=1757429679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xdmxW6S2htIgGYvZak+e/bKLuU7dc03qzfViFoZp6Xg=;
        b=TzgLrrZmUJ1KavbGFYuSxCGmPh93HNZKV8AKvLzIudZDSe+fzyZnz6q942UlqDuYVV
         jVaAwQLAkkluI7SI34YiaXNaJ5kbkaeu5pTyGKSlGMt7CW+2CsKaKRMCygdQs/ZEwTxt
         qVIosfCu+T2DLn0W6FrUjpEKXatd2IB9J/xnTLxxZGH/qtprZjFSmbE1CnM2evFPO0SE
         Ihlw3OLL2ss0VpLnsge3wUCvWbEp9CLvEYHRj1XxIwaS4rclSV3TlDAZRRR17jTypWs/
         6cH5w14iS6WU4xrSrWZOZ66ScgKTRhON0F3ze7Xx/1L8otD8om9zE9oXngueonUCGYMp
         7y2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756824879; x=1757429679;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xdmxW6S2htIgGYvZak+e/bKLuU7dc03qzfViFoZp6Xg=;
        b=bwOWgylo8RnDR16A+1T1iasb/PK9gfTeI6F/dbdEoQbBVsgUaL75tp/XZJ/UAKf+Ot
         Kopo+1mQwB9aMX4mcJtlTVkINrq7qyNaaifc9H7EIXxd3tKhuAqpjMLH/kvkuaPwM7FA
         rjumufw6QmeLG3WC3SHUhrUO5VxAcJgVkLrA2eSjCyO68C88NAUZAyBOptqHdCRly6X2
         WMwisZ0jcritfG5hNRfilPqaQkCEWhg8UqZ9trIvJzao1ZIwjQT4bp6d2EIdsbUUjcy8
         Y5nOp3rnWBpyA76kX+VOB1lvoazp95B6JGG+joFfroc6pD/3dKilzFuD4l0EccM/RkD9
         WgMg==
X-Forwarded-Encrypted: i=1; AJvYcCUG8gche/Osdy22zlD1LGTLdTgyi1nBV0RKkU1kwSCD9zXCEgGXLy1qBf/LYXObzGjwgsX6iXMg+QUbwVPx@vger.kernel.org, AJvYcCUPuQGQbzyATFWdsoooW/UMHlICc5hj+prznAk9R1UfjJ4VrQSPG2xYSgoXiMCDwhC0RuFKFKvcTJbe@vger.kernel.org, AJvYcCUX4p+uBVLP5LW9+fUD6JNKNBSi7m9eC+wyM5o9wjpq/F9XaezZKRcdHRiGnUCQtO80yWeSXtIBNpotLg==@vger.kernel.org, AJvYcCV7IxfP8mCGcGUas+JVDzyLf8FmmlqgKzqMUlpnhkWYYRbLJbOhqW7tOUwFvyBbTIjbhhi80lZEe17OWdPOmA==@vger.kernel.org, AJvYcCWvvawVXhXHGn6kPeS1e3Y38kTGzTWQnzqTL2OVDchyi+RKGPO7UsR9lRBkr6eTEobHSAaxF3WsUv2Umg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwW4/qS0We4O0kmJkMKG0dK4mj67GVBXU0qdNV6Vlk/+M0hVDpz
	pxWkGYwZGFXzAn89Xati8B9Q5v+Q9noOn1eTMYFR/3Iux45OK5QhuUEO
X-Gm-Gg: ASbGnctJEQZd4vaX//CHzlY0EBhgnRT+dIv50wX208jpreF26zYVvsw1PRCItcL3TbW
	bk8/WPdcbFnkU5D2zDWVuySaDAWVpBLVi4id0f/IBw/kZFKfP3VVs4XsEG7UY+qHYx6PHsHAvPq
	WrozwPRmkcgL1zlyhsS1WkfbqwkHr8Syv4aN3Z828o+f8p+AJ9E7Vv+Tds7t7S8gbICmUeO1+Bh
	LbGpPAhLKb4UO093g0Y1cQnmdLxW7URqtCv1jbOYyZR0eWDtkkBkfkFOxWUjPGDBXeAG/nDKYeP
	e8OktiphgsIiwZUJpPPluxd+hPTWVkkrpeSilrTRcTl0ls3if8r98hWSnFxqqqlEPTT6ynsgvxM
	OpP6giKeVdnJbLFaMp1pusGUvOGmQBhkVGgWWqfdqeUjcBMP0yvxl0ijvc8675Q==
X-Google-Smtp-Source: AGHT+IFICR6xl8TzNorjPESEpiLkZomS3bG4DEW4D8celE7+0sM/x5pfIPNlfMspn6fBsUxfvLiSeQ==
X-Received: by 2002:a17:907:6090:b0:b04:2cc2:e495 with SMTP id a640c23a62f3a-b042cc31af3mr754574066b.14.1756824878158;
        Tue, 02 Sep 2025 07:54:38 -0700 (PDT)
Received: from f.. (cst-prg-84-152.cust.vodafone.cz. [46.135.84.152])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b040e6845f8sm739247566b.51.2025.09.02.07.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 07:54:37 -0700 (PDT)
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
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [WIP RFC PATCH] fs: retire I_WILL_FREE
Date: Tue,  2 Sep 2025 16:54:28 +0200
Message-ID: <20250902145428.456510-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Following up on my response to the refcount patchset, here is a churn
patch to retire I_WILL_FREE.

The only consumer is the drop inode routine in ocfs2.

For the life of me I could not figure out if write_inode_now() is legal
to call in ->evict_inode later and have no means to test, so I devised a
hack: let the fs set I_FREEING ahead of time. Also note iput_final()
issues write_inode_now() anyway but only for the !drop case, which is the
opposite of what is being returned.

One could further hack around it by having ocfs2 return *DON'T* drop but
also set I_DONTCACHE, which would result in both issuing the write in
iput_final() and dropping. I think the hack I did implement is cleaner.
Preferred option is ->evict_inode from ocfs handling the i/o, but per
the above I don't know how to do it.

So.. the following is my proposed first step towards sanitisation of
i_state and the lifecycle flags.

I verified fs/inode.c and fs/fs-writeback.c compile, otherwise untested.

Generated against vfs-6.18.inode.refcount.preliminaries

Comments?

---
 block/bdev.c                     |  2 +-
 fs/bcachefs/fs.c                 |  2 +-
 fs/btrfs/inode.c                 |  2 +-
 fs/crypto/keyring.c              |  2 +-
 fs/drop_caches.c                 |  2 +-
 fs/ext4/inode.c                  |  2 +-
 fs/fs-writeback.c                | 18 +++++++----------
 fs/gfs2/ops_fstype.c             |  2 +-
 fs/inode.c                       | 34 +++++++++++++++++---------------
 fs/notify/fsnotify.c             |  6 +++---
 fs/ocfs2/inode.c                 |  3 +--
 fs/quota/dquot.c                 |  2 +-
 fs/xfs/scrub/common.c            |  3 +--
 include/linux/fs.h               | 32 ++++++++++++------------------
 include/trace/events/writeback.h |  3 +--
 security/landlock/fs.c           | 12 +++++------
 16 files changed, 58 insertions(+), 69 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index b77ddd12dc06..1801d89e448b 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -1265,7 +1265,7 @@ void sync_bdevs(bool wait)
 		struct block_device *bdev;
 
 		spin_lock(&inode->i_lock);
-		if (inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW) ||
+		if (inode->i_state & (I_FREEING | I_NEW) ||
 		    mapping->nrpages == 0) {
 			spin_unlock(&inode->i_lock);
 			continue;
diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
index 687af0eea0c2..a62d597630d1 100644
--- a/fs/bcachefs/fs.c
+++ b/fs/bcachefs/fs.c
@@ -347,7 +347,7 @@ static struct bch_inode_info *bch2_inode_hash_find(struct bch_fs *c, struct btre
 			spin_unlock(&inode->v.i_lock);
 			return NULL;
 		}
-		if ((inode->v.i_state & (I_FREEING|I_WILL_FREE))) {
+		if ((inode->v.i_state & I_FREEING)) {
 			if (!trans) {
 				__wait_on_freeing_inode(c, inode, inum);
 			} else {
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 5bcd8e25fa78..f1d9336b903f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3856,7 +3856,7 @@ static int btrfs_add_inode_to_root(struct btrfs_inode *inode, bool prealloc)
 		ASSERT(ret != -ENOMEM);
 		return ret;
 	} else if (existing) {
-		WARN_ON(!(existing->vfs_inode.i_state & (I_WILL_FREE | I_FREEING)));
+		WARN_ON(!(existing->vfs_inode.i_state & I_FREEING));
 	}
 
 	return 0;
diff --git a/fs/crypto/keyring.c b/fs/crypto/keyring.c
index 7557f6a88b8f..97f4c7049222 100644
--- a/fs/crypto/keyring.c
+++ b/fs/crypto/keyring.c
@@ -957,7 +957,7 @@ static void evict_dentries_for_decrypted_inodes(struct fscrypt_master_key *mk)
 	list_for_each_entry(ci, &mk->mk_decrypted_inodes, ci_master_key_link) {
 		inode = ci->ci_inode;
 		spin_lock(&inode->i_lock);
-		if (inode->i_state & (I_FREEING | I_WILL_FREE | I_NEW)) {
+		if (inode->i_state & (I_FREEING | I_NEW)) {
 			spin_unlock(&inode->i_lock);
 			continue;
 		}
diff --git a/fs/drop_caches.c b/fs/drop_caches.c
index 019a8b4eaaf9..40fa9b17375b 100644
--- a/fs/drop_caches.c
+++ b/fs/drop_caches.c
@@ -28,7 +28,7 @@ static void drop_pagecache_sb(struct super_block *sb, void *unused)
 		 * inodes without pages but we deliberately won't in case
 		 * we need to reschedule to avoid softlockups.
 		 */
-		if ((inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW)) ||
+		if ((inode->i_state & (I_FREEING|I_NEW)) ||
 		    (mapping_empty(inode->i_mapping) && !need_resched())) {
 			spin_unlock(&inode->i_lock);
 			continue;
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index ed54c4d0f2f9..14209758e5be 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -425,7 +425,7 @@ void ext4_check_map_extents_env(struct inode *inode)
 	if (!S_ISREG(inode->i_mode) ||
 	    IS_NOQUOTA(inode) || IS_VERITY(inode) ||
 	    is_special_ino(inode->i_sb, inode->i_ino) ||
-	    (inode->i_state & (I_FREEING | I_WILL_FREE | I_NEW)) ||
+	    (inode->i_state & (I_FREEING | I_NEW)) ||
 	    ext4_test_inode_flag(inode, EXT4_INODE_EA_INODE) ||
 	    ext4_verity_in_progress(inode))
 		return;
diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 6088a67b2aae..5fa388820daf 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -405,10 +405,10 @@ static bool inode_do_switch_wbs(struct inode *inode,
 	xa_lock_irq(&mapping->i_pages);
 
 	/*
-	 * Once I_FREEING or I_WILL_FREE are visible under i_lock, the eviction
+	 * Once I_FREEING is visible under i_lock, the eviction
 	 * path owns the inode and we shouldn't modify ->i_io_list.
 	 */
-	if (unlikely(inode->i_state & (I_FREEING | I_WILL_FREE)))
+	if (unlikely(inode->i_state & I_FREEING))
 		goto skip_switch;
 
 	trace_inode_switch_wbs(inode, old_wb, new_wb);
@@ -560,7 +560,7 @@ static bool inode_prepare_wbs_switch(struct inode *inode,
 	/* while holding I_WB_SWITCH, no one else can update the association */
 	spin_lock(&inode->i_lock);
 	if (!(inode->i_sb->s_flags & SB_ACTIVE) ||
-	    inode->i_state & (I_WB_SWITCH | I_FREEING | I_WILL_FREE) ||
+	    inode->i_state & (I_WB_SWITCH | I_FREEING) ||
 	    inode_to_wb(inode) == new_wb) {
 		spin_unlock(&inode->i_lock);
 		return false;
@@ -1758,7 +1758,7 @@ __writeback_single_inode(struct inode *inode, struct writeback_control *wbc)
  * whether it is a data-integrity sync (%WB_SYNC_ALL) or not (%WB_SYNC_NONE).
  *
  * To prevent the inode from going away, either the caller must have a reference
- * to the inode, or the inode must have I_WILL_FREE or I_FREEING set.
+ * to the inode, or the inode must have I_FREEING set.
  */
 static int writeback_single_inode(struct inode *inode,
 				  struct writeback_control *wbc)
@@ -1768,9 +1768,7 @@ static int writeback_single_inode(struct inode *inode,
 
 	spin_lock(&inode->i_lock);
 	if (!icount_read(inode))
-		WARN_ON(!(inode->i_state & (I_WILL_FREE|I_FREEING)));
-	else
-		WARN_ON(inode->i_state & I_WILL_FREE);
+		WARN_ON(!(inode->i_state & I_FREEING));
 
 	if (inode->i_state & I_SYNC) {
 		/*
@@ -1928,7 +1926,7 @@ static long writeback_sb_inodes(struct super_block *sb,
 		 * kind writeout is handled by the freer.
 		 */
 		spin_lock(&inode->i_lock);
-		if (inode->i_state & (I_NEW | I_FREEING | I_WILL_FREE)) {
+		if (inode->i_state & (I_NEW | I_FREEING)) {
 			redirty_tail_locked(inode, wb);
 			spin_unlock(&inode->i_lock);
 			continue;
@@ -2696,7 +2694,7 @@ static void wait_sb_inodes(struct super_block *sb)
 		spin_unlock_irq(&sb->s_inode_wblist_lock);
 
 		spin_lock(&inode->i_lock);
-		if (inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW)) {
+		if (inode->i_state & (I_FREEING | I_NEW)) {
 			spin_unlock(&inode->i_lock);
 
 			spin_lock_irq(&sb->s_inode_wblist_lock);
@@ -2844,8 +2842,6 @@ EXPORT_SYMBOL(sync_inodes_sb);
  *
  * This function commits an inode to disk immediately if it is dirty. This is
  * primarily needed by knfsd.
- *
- * The caller must either have a ref on the inode or must have set I_WILL_FREE.
  */
 int write_inode_now(struct inode *inode, int sync)
 {
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index c770006f8889..1393181a64dc 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -1749,7 +1749,7 @@ static void gfs2_evict_inodes(struct super_block *sb)
 	spin_lock(&sb->s_inode_list_lock);
 	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
 		spin_lock(&inode->i_lock);
-		if ((inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW)) &&
+		if ((inode->i_state & (I_FREEING | I_NEW)) &&
 		    !need_resched()) {
 			spin_unlock(&inode->i_lock);
 			continue;
diff --git a/fs/inode.c b/fs/inode.c
index 2db680a37235..8188b0b5dfa1 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -532,7 +532,7 @@ EXPORT_SYMBOL(ihold);
 
 static void __inode_add_lru(struct inode *inode, bool rotate)
 {
-	if (inode->i_state & (I_DIRTY_ALL | I_SYNC | I_FREEING | I_WILL_FREE))
+	if (inode->i_state & (I_DIRTY_ALL | I_SYNC | I_FREEING))
 		return;
 	if (icount_read(inode))
 		return;
@@ -577,7 +577,7 @@ static void inode_lru_list_del(struct inode *inode)
 static void inode_pin_lru_isolating(struct inode *inode)
 {
 	lockdep_assert_held(&inode->i_lock);
-	WARN_ON(inode->i_state & (I_LRU_ISOLATING | I_FREEING | I_WILL_FREE));
+	WARN_ON(inode->i_state & (I_LRU_ISOLATING | I_FREEING));
 	inode->i_state |= I_LRU_ISOLATING;
 }
 
@@ -879,7 +879,7 @@ void evict_inodes(struct super_block *sb)
 			spin_unlock(&inode->i_lock);
 			continue;
 		}
-		if (inode->i_state & (I_NEW | I_FREEING | I_WILL_FREE)) {
+		if (inode->i_state & (I_NEW | I_FREEING)) {
 			spin_unlock(&inode->i_lock);
 			continue;
 		}
@@ -1025,7 +1025,7 @@ static struct inode *find_inode(struct super_block *sb,
 		if (!test(inode, data))
 			continue;
 		spin_lock(&inode->i_lock);
-		if (inode->i_state & (I_FREEING|I_WILL_FREE)) {
+		if (inode->i_state & I_FREEING) {
 			__wait_on_freeing_inode(inode, is_inode_hash_locked);
 			goto repeat;
 		}
@@ -1066,7 +1066,7 @@ static struct inode *find_inode_fast(struct super_block *sb,
 		if (inode->i_sb != sb)
 			continue;
 		spin_lock(&inode->i_lock);
-		if (inode->i_state & (I_FREEING|I_WILL_FREE)) {
+		if (inode->i_state & I_FREEING) {
 			__wait_on_freeing_inode(inode, is_inode_hash_locked);
 			goto repeat;
 		}
@@ -1538,7 +1538,7 @@ EXPORT_SYMBOL(iunique);
 struct inode *igrab(struct inode *inode)
 {
 	spin_lock(&inode->i_lock);
-	if (!(inode->i_state & (I_FREEING|I_WILL_FREE))) {
+	if (!(inode->i_state & I_FREEING)) {
 		__iget(inode);
 		spin_unlock(&inode->i_lock);
 	} else {
@@ -1728,7 +1728,7 @@ struct inode *find_inode_rcu(struct super_block *sb, unsigned long hashval,
 
 	hlist_for_each_entry_rcu(inode, head, i_hash) {
 		if (inode->i_sb == sb &&
-		    !(READ_ONCE(inode->i_state) & (I_FREEING | I_WILL_FREE)) &&
+		    !(READ_ONCE(inode->i_state) & I_FREEING) &&
 		    test(inode, data))
 			return inode;
 	}
@@ -1767,7 +1767,7 @@ struct inode *find_inode_by_ino_rcu(struct super_block *sb,
 	hlist_for_each_entry_rcu(inode, head, i_hash) {
 		if (inode->i_ino == ino &&
 		    inode->i_sb == sb &&
-		    !(READ_ONCE(inode->i_state) & (I_FREEING | I_WILL_FREE)))
+		    !(READ_ONCE(inode->i_state) & I_FREEING))
 		    return inode;
 	}
 	return NULL;
@@ -1789,7 +1789,7 @@ int insert_inode_locked(struct inode *inode)
 			if (old->i_sb != sb)
 				continue;
 			spin_lock(&old->i_lock);
-			if (old->i_state & (I_FREEING|I_WILL_FREE)) {
+			if (old->i_state & I_FREEING) {
 				spin_unlock(&old->i_lock);
 				continue;
 			}
@@ -1862,12 +1862,19 @@ static void iput_final(struct inode *inode)
 	int drop;
 
 	WARN_ON(inode->i_state & I_NEW);
+	VFS_BUG_ON_INODE(inode->i_state & I_FREEING, inode);
 
 	if (op->drop_inode)
 		drop = op->drop_inode(inode);
 	else
 		drop = generic_drop_inode(inode);
 
+	/*
+	 * Note: the ->drop_inode routine is allowed to set I_FREEING for us,
+	 * but this is only legal if they want to drop.
+	 */
+	VFS_BUG_ON_INODE(!drop && (inode->i_state & I_FREEING), inode);
+
 	if (!drop &&
 	    !(inode->i_state & I_DONTCACHE) &&
 	    (sb->s_flags & SB_ACTIVE)) {
@@ -1877,19 +1884,14 @@ static void iput_final(struct inode *inode)
 	}
 
 	state = inode->i_state;
+	WRITE_ONCE(inode->i_state, state | I_FREEING);
 	if (!drop) {
-		WRITE_ONCE(inode->i_state, state | I_WILL_FREE);
 		spin_unlock(&inode->i_lock);
-
 		write_inode_now(inode, 1);
-
 		spin_lock(&inode->i_lock);
-		state = inode->i_state;
-		WARN_ON(state & I_NEW);
-		state &= ~I_WILL_FREE;
 	}
+	WARN_ON(inode->i_state & I_NEW);
 
-	WRITE_ONCE(inode->i_state, state | I_FREEING);
 	if (!list_empty(&inode->i_lru))
 		inode_lru_list_del(inode);
 	spin_unlock(&inode->i_lock);
diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 46bfc543f946..cff8417fa6db 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -47,12 +47,12 @@ static void fsnotify_unmount_inodes(struct super_block *sb)
 	spin_lock(&sb->s_inode_list_lock);
 	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
 		/*
-		 * We cannot __iget() an inode in state I_FREEING,
-		 * I_WILL_FREE, or I_NEW which is fine because by that point
+		 * We cannot __iget() an inode in state I_FREEING
+		 * or I_NEW which is fine because by that point
 		 * the inode cannot have any associated watches.
 		 */
 		spin_lock(&inode->i_lock);
-		if (inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW)) {
+		if (inode->i_state & (I_FREEING | I_NEW)) {
 			spin_unlock(&inode->i_lock);
 			continue;
 		}
diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
index 14bf440ea4df..29549fc899e9 100644
--- a/fs/ocfs2/inode.c
+++ b/fs/ocfs2/inode.c
@@ -1307,12 +1307,11 @@ int ocfs2_drop_inode(struct inode *inode)
 				inode->i_nlink, oi->ip_flags);
 
 	assert_spin_locked(&inode->i_lock);
-	inode->i_state |= I_WILL_FREE;
+	inode->i_state |= I_FREEING;
 	spin_unlock(&inode->i_lock);
 	write_inode_now(inode, 1);
 	spin_lock(&inode->i_lock);
 	WARN_ON(inode->i_state & I_NEW);
-	inode->i_state &= ~I_WILL_FREE;
 
 	return 1;
 }
diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index df4a9b348769..3aa916040602 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -1030,7 +1030,7 @@ static int add_dquot_ref(struct super_block *sb, int type)
 	spin_lock(&sb->s_inode_list_lock);
 	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
 		spin_lock(&inode->i_lock);
-		if ((inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW)) ||
+		if ((inode->i_state & (I_FREEING | I_NEW)) ||
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
index c4fd010cf5bf..e8ad8f0a03c7 100644
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
@@ -764,7 +759,7 @@ enum inode_state_flags_t {
 	I_DIRTY_SYNC		= (1U << 4),
 	I_DIRTY_DATASYNC	= (1U << 5),
 	I_DIRTY_PAGES		= (1U << 6),
-	I_WILL_FREE		= (1U << 7),
+	I_PINNING_NETFS_WB	= (1U << 7),
 	I_FREEING		= (1U << 8),
 	I_CLEAR			= (1U << 9),
 	I_REFERENCED		= (1U << 10),
@@ -775,7 +770,6 @@ enum inode_state_flags_t {
 	I_CREATING		= (1U << 15),
 	I_DONTCACHE		= (1U << 16),
 	I_SYNC_QUEUED		= (1U << 17),
-	I_PINNING_NETFS_WB	= (1U << 18)
 };
 
 #define I_DIRTY_INODE (I_DIRTY_SYNC | I_DIRTY_DATASYNC)
@@ -2628,7 +2622,7 @@ static inline int icount_read(const struct inode *inode)
 static inline bool inode_is_dirtytime_only(struct inode *inode)
 {
 	return (inode->i_state & (I_DIRTY_TIME | I_NEW |
-				  I_FREEING | I_WILL_FREE)) == I_DIRTY_TIME;
+				  I_FREEING)) == I_DIRTY_TIME;
 }
 
 extern void inc_nlink(struct inode *inode);
diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
index 1e23919c0da9..6e3ebecc95e9 100644
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
index 0bade2c5aa1d..7ffcd62324fa 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1290,13 +1290,13 @@ static void hook_sb_delete(struct super_block *const sb)
 		 */
 		spin_lock(&inode->i_lock);
 		/*
-		 * Checks I_FREEING and I_WILL_FREE  to protect against a race
-		 * condition when release_inode() just called iput(), which
-		 * could lead to a NULL dereference of inode->security or a
-		 * second call to iput() for the same Landlock object.  Also
-		 * checks I_NEW because such inode cannot be tied to an object.
+		 * Checks I_FREEING to protect against a race condition when
+		 * release_inode() just called iput(), which could lead to a
+		 * NULL dereference of inode->security or a second call to
+		 * iput() for the same Landlock object.  Also checks I_NEW
+		 * because such inode cannot be tied to an object.
 		 */
-		if (inode->i_state & (I_FREEING | I_WILL_FREE | I_NEW)) {
+		if (inode->i_state & (I_FREEING | I_NEW)) {
 			spin_unlock(&inode->i_lock);
 			continue;
 		}
-- 
2.43.0


