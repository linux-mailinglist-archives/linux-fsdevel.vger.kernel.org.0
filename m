Return-Path: <linux-fsdevel+bounces-62242-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F43B8A6BC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 17:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82D3E4E09C9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 15:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71015321459;
	Fri, 19 Sep 2025 15:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lATqr6bV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4695331D75B
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Sep 2025 15:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758296969; cv=none; b=pUwOLBL5g/Y2Zi7ow84SDB6xUMcono1uZbBF3NYaqDEztVIs2gmuXqAOB1F7mLjF2sTsZpuM1hgSFfPy4119WbNCKFT4nDA2FPuAplVpv3v2hDQcq1UuZtozg2QymSnGz0JPX/9daKcRTXab+1KW8RUgBfyr2gffKf4i3FJKqH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758296969; c=relaxed/simple;
	bh=LSFV/NfZEwqnDjp+iV1IY39dyxzDe8/ADZxl955aT+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=juNEYfY+yfJevT9SceMurJ/WPWDSV94PLe1+wJGpj+z2glBM6RLCaz4kmauGE3QPmfcdcsJl1/Dc2m4gU55GqdOSW8Pe+8sbmXSvAsCbO7ySK7lnv+nFfgpapjSMF7x6jZh7afrCeXV15qBPBSErW3xrJjw1ExfPkNIDMXfTDZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lATqr6bV; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3ee130237a8so1141051f8f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Sep 2025 08:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758296963; x=1758901763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t0iRz1PTYzANkmkgJ7TTHV0DY262htgB5WIYkJCCYak=;
        b=lATqr6bVfHvogP0qwV3Z468cDnUXWap0BxD1QrQm+juuH3wNHxPFNfFmmKPa8cRSVo
         yKwxsIDKdA1BQ4cFHnhdT6gB0C0wn/toN+rfuL+8BeKMFdny6pFwRexCfkjeGigIp6pK
         cJM1qqn9RCzf1PSUlLMZRmWjqEVcN6V0pINxRt8cBD7CTnurjjer6QDTUeJBkClb/Wm/
         ayn0nWgQuTL5+bi7ExbPg8eF4q2dRleumzRSbz0d7/QvigmJenXJozSozd4lNAF3hipv
         3yZmUWUsran7gHjTbGV3l60yvg2KF8yILxw4w1K7gGDtHc9SgJo6vGaMAQ8vWFaMRbv+
         9+Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758296963; x=1758901763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t0iRz1PTYzANkmkgJ7TTHV0DY262htgB5WIYkJCCYak=;
        b=vidBkAqFnMEnxJKe3kT7tTlgV3cFHD+vmKtCpRGaVlFEPyWU5i5dEabG5qtq8EmGVL
         ewyuMYp+wQ8VQABTkDUWf0DeIYRDcbo+1RoOfT+ruMjBLZafhKwuBuAmDf+mkOs65Oet
         tY8iIlis7SCdUsIbBVDSj6zSJVhpSGmQcjcPPgbZ1VFW3vCAgI947UWH2io9OCW5Jicw
         1iSX3KZXiBOs0aoI0zwAGCZNXCr7imujwLqzUbYLWNKJMYmrQx7Gzo9g6rJ6TKCfrXJW
         Qs1JD1mo/cF0qCNiiivMqq5i35CJg2iwv5TtoKdd6+tZEhX299UZsIhOgSAFcELKU+om
         xvsw==
X-Forwarded-Encrypted: i=1; AJvYcCUdxZ7eoFHWmZlxVvlntmgVN+BsCjydFStKTlWOMERR1PV3o9vDkWjEaibZ1fX9h98YXPr4qrysPo0K3BF3@vger.kernel.org
X-Gm-Message-State: AOJu0YzWuOd1bxfb+yIlLm1XHPONPm6Kuiocx5p4C+urpluUd4rXp4PT
	c6vY1pmJEuU26iFLqputb8Fgq4a7ZvFcDz519PfKOIFz6Jy6W6twmFy3
X-Gm-Gg: ASbGncsWiuJ3XQiZMvuXsI1VcowSKusnrpoJ4wtGHZN1z8fIFl/roEJssWhq34ZRMN9
	HSBFr47Ypa6tG6aJS8FlOWWM57XB4ywNkEKICxVB/raDgm5HHJWOXPC+PZiDLW4q+Au+7lJl79h
	400R7r/Ee/e7V/r7QYJCi8JqcMweWORRO1Ml1Q43aXn6x1k0sF6N7IOOAyYkJmiq4m68SUn3zBA
	A8MVklpEpdO593ardy2yyHn4Aco7fRe0DtwxjeIpyCGM+grXWsVIvgFLqwaw79XeHKY1iC5YYLP
	zbOI0PwoIX79/JoE7KzhUaYR0HpXT4I9vywk2+leKmER1awRCENsa7skVe0uzMvcQVjcz4opfcT
	EU5H6zTfBMFc1kXCp4XbiGSNf1p+3CN55NDv2S9hjAcifXNW43mdBQ1wkW0kNbqjsm3w7mFTa
X-Google-Smtp-Source: AGHT+IHW5sdwJXlZ5JxxzgBeMh33tvLHuD9JfkmxHNnMPV/ivsut2CiOZ6uDz8v2nXkjAn9n8Tw5Eg==
X-Received: by 2002:a05:6000:4024:b0:3e5:47a9:1c7f with SMTP id ffacd0b85a97d-3ee85b4a162mr2977438f8f.47.1758296962581;
        Fri, 19 Sep 2025 08:49:22 -0700 (PDT)
Received: from f.. (cst-prg-88-146.cust.vodafone.cz. [46.135.88.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee073f53c4sm8446746f8f.3.2025.09.19.08.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 08:49:21 -0700 (PDT)
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
	ceph-devel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v5 3/4] Manual conversion of ->i_state uses
Date: Fri, 19 Sep 2025 17:49:03 +0200
Message-ID: <20250919154905.2592318-4-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250919154905.2592318-1-mjguzik@gmail.com>
References: <20250919154905.2592318-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Takes care of spots not converted by coccinelle.

Nothing to look at with one exception: smp_store_release and
smp_load_acquire pair replaced with a manual store/load +
smb_wmb()/smp_rmb(), see I_WB_SWITCH.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 Documentation/filesystems/porting.rst | 2 +-
 fs/bcachefs/fs.c                      | 8 ++++----
 fs/btrfs/inode.c                      | 8 ++++----
 fs/dcache.c                           | 2 +-
 fs/fs-writeback.c                     | 4 ++--
 fs/inode.c                            | 8 ++++----
 fs/ocfs2/inode.c                      | 2 +-
 fs/xfs/xfs_reflink.h                  | 2 +-
 include/linux/backing-dev.h           | 3 ++-
 include/linux/fs.h                    | 2 +-
 include/linux/writeback.h             | 4 ++--
 include/trace/events/writeback.h      | 8 ++++----
 12 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index 85f590254f07..0629611600f1 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -211,7 +211,7 @@ test and set for you.
 e.g.::
 
 	inode = iget_locked(sb, ino);
-	if (inode->i_state & I_NEW) {
+	if (inode_state_read(inode) & I_NEW) {
 		err = read_inode_from_disk(inode);
 		if (err < 0) {
 			iget_failed(inode);
diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
index 687af0eea0c2..f4a13678057b 100644
--- a/fs/bcachefs/fs.c
+++ b/fs/bcachefs/fs.c
@@ -347,7 +347,7 @@ static struct bch_inode_info *bch2_inode_hash_find(struct bch_fs *c, struct btre
 			spin_unlock(&inode->v.i_lock);
 			return NULL;
 		}
-		if ((inode->v.i_state & (I_FREEING|I_WILL_FREE))) {
+		if ((inode_state_read(&inode->v) & (I_FREEING|I_WILL_FREE))) {
 			if (!trans) {
 				__wait_on_freeing_inode(c, inode, inum);
 			} else {
@@ -411,7 +411,7 @@ static struct bch_inode_info *bch2_inode_hash_insert(struct bch_fs *c,
 		 * only insert fully created inodes in the inode hash table. But
 		 * discard_new_inode() expects it to be set...
 		 */
-		inode->v.i_state |= I_NEW;
+		inode_state_add(&inode->v, I_NEW);
 		/*
 		 * We don't want bch2_evict_inode() to delete the inode on disk,
 		 * we just raced and had another inode in cache. Normally new
@@ -2224,8 +2224,8 @@ void bch2_evict_subvolume_inodes(struct bch_fs *c, snapshot_id_list *s)
 		if (!snapshot_list_has_id(s, inode->ei_inum.subvol))
 			continue;
 
-		if (!(inode->v.i_state & I_DONTCACHE) &&
-		    !(inode->v.i_state & I_FREEING) &&
+		if (!(inode_state_read(&inode->v) & I_DONTCACHE) &&
+		    !(inode_state_read(&inode->v) & I_FREEING) &&
 		    igrab(&inode->v)) {
 			this_pass_clean = false;
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 8e2ab3fb9070..d2f7e7c57a36 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3856,7 +3856,7 @@ static int btrfs_add_inode_to_root(struct btrfs_inode *inode, bool prealloc)
 		ASSERT(ret != -ENOMEM);
 		return ret;
 	} else if (existing) {
-		WARN_ON(!(existing->vfs_inode.i_state & (I_WILL_FREE | I_FREEING)));
+		WARN_ON(!(inode_state_read(&existing->vfs_inode) & (I_WILL_FREE | I_FREEING)));
 	}
 
 	return 0;
@@ -5745,7 +5745,7 @@ struct btrfs_inode *btrfs_iget_path(u64 ino, struct btrfs_root *root,
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 
-	if (!(inode->vfs_inode.i_state & I_NEW))
+	if (!(inode_state_read(&inode->vfs_inode) & I_NEW))
 		return inode;
 
 	ret = btrfs_read_locked_inode(inode, path);
@@ -5769,7 +5769,7 @@ struct btrfs_inode *btrfs_iget(u64 ino, struct btrfs_root *root)
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 
-	if (!(inode->vfs_inode.i_state & I_NEW))
+	if (!(inode_state_read(&inode->vfs_inode) & I_NEW))
 		return inode;
 
 	path = btrfs_alloc_path();
@@ -7435,7 +7435,7 @@ static void btrfs_invalidate_folio(struct folio *folio, size_t offset,
 	u64 page_start = folio_pos(folio);
 	u64 page_end = page_start + folio_size(folio) - 1;
 	u64 cur;
-	int inode_evicting = inode->vfs_inode.i_state & I_FREEING;
+	int inode_evicting = inode_state_read(&inode->vfs_inode) & I_FREEING;
 
 	/*
 	 * We have folio locked so no new ordered extent can be created on this
diff --git a/fs/dcache.c b/fs/dcache.c
index 0dd2ee8a3b47..e01c8b678a6f 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1981,7 +1981,7 @@ void d_instantiate_new(struct dentry *entry, struct inode *inode)
 	spin_lock(&inode->i_lock);
 	__d_instantiate(entry, inode);
 	WARN_ON(!(inode_state_read(inode) & I_NEW));
-	inode->i_state &= ~I_NEW & ~I_CREATING;
+	inode_state_del(inode, I_NEW | I_CREATING);
 	/*
 	 * Pairs with the barrier in prepare_to_wait_event() to make sure
 	 * ___wait_var_event() either sees the bit cleared or
diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 0e9e96f10dd4..745df148baaa 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -478,8 +478,8 @@ static bool inode_do_switch_wbs(struct inode *inode,
 	 * Paired with load_acquire in unlocked_inode_to_wb_begin() and
 	 * ensures that the new wb is visible if they see !I_WB_SWITCH.
 	 */
-	smp_store_release(&inode->i_state,
-			  inode_state_read(inode) & ~I_WB_SWITCH);
+	smp_wmb();
+	inode_state_del(inode, I_WB_SWITCH);
 
 	xa_unlock_irq(&mapping->i_pages);
 	spin_unlock(&inode->i_lock);
diff --git a/fs/inode.c b/fs/inode.c
index 2ed2367ecbae..e5b7cc3cddaf 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -829,7 +829,7 @@ static void evict(struct inode *inode)
 	 * This also means we don't need any fences for the call below.
 	 */
 	inode_wake_up_bit(inode, __I_NEW);
-	BUG_ON(inode->i_state != (I_FREEING | I_CLEAR));
+	BUG_ON(inode_state_read(inode) != (I_FREEING | I_CLEAR));
 
 	destroy_inode(inode);
 }
@@ -1878,7 +1878,7 @@ static void iput_final(struct inode *inode)
 
 	state = inode_state_read(inode);
 	if (!drop) {
-		WRITE_ONCE(inode->i_state, state | I_WILL_FREE);
+		inode_state_add(inode, I_WILL_FREE);
 		spin_unlock(&inode->i_lock);
 
 		write_inode_now(inode, 1);
@@ -1889,7 +1889,7 @@ static void iput_final(struct inode *inode)
 		state &= ~I_WILL_FREE;
 	}
 
-	WRITE_ONCE(inode->i_state, state | I_FREEING);
+	inode_state_set(inode, state | I_FREEING);
 	if (!list_empty(&inode->i_lru))
 		inode_lru_list_del(inode);
 	spin_unlock(&inode->i_lock);
@@ -2946,7 +2946,7 @@ void dump_inode(struct inode *inode, const char *reason)
 	pr_warn("%s encountered for inode %px\n"
 		"fs %s mode %ho opflags 0x%hx flags 0x%x state 0x%x count %d\n",
 		reason, inode, sb->s_type->name, inode->i_mode, inode->i_opflags,
-		inode->i_flags, inode->i_state, atomic_read(&inode->i_count));
+		inode->i_flags, inode_state_read(inode), atomic_read(&inode->i_count));
 }
 
 EXPORT_SYMBOL(dump_inode);
diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
index 7810c43392b0..21e5cde1cd1c 100644
--- a/fs/ocfs2/inode.c
+++ b/fs/ocfs2/inode.c
@@ -152,7 +152,7 @@ struct inode *ocfs2_iget(struct ocfs2_super *osb, u64 blkno, unsigned flags,
 		mlog_errno(PTR_ERR(inode));
 		goto bail;
 	}
-	trace_ocfs2_iget5_locked(inode->i_state);
+	trace_ocfs2_iget5_locked(inode_state_read(inode));
 	if (inode_state_read(inode) & I_NEW) {
 		rc = ocfs2_read_locked_inode(inode, &args);
 		unlock_new_inode(inode);
diff --git a/fs/xfs/xfs_reflink.h b/fs/xfs/xfs_reflink.h
index 36cda724da89..86e87e5936b5 100644
--- a/fs/xfs/xfs_reflink.h
+++ b/fs/xfs/xfs_reflink.h
@@ -17,7 +17,7 @@ xfs_can_free_cowblocks(struct xfs_inode *ip)
 {
 	struct inode *inode = VFS_I(ip);
 
-	if ((inode->i_state & I_DIRTY_PAGES) ||
+	if ((inode_state_read(inode) & I_DIRTY_PAGES) ||
 	    mapping_tagged(inode->i_mapping, PAGECACHE_TAG_DIRTY) ||
 	    mapping_tagged(inode->i_mapping, PAGECACHE_TAG_WRITEBACK) ||
 	    atomic_read(&inode->i_dio_count))
diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index e721148c95d0..720e5f8ad782 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -292,7 +292,8 @@ unlocked_inode_to_wb_begin(struct inode *inode, struct wb_lock_cookie *cookie)
 	 * Paired with store_release in inode_switch_wbs_work_fn() and
 	 * ensures that we see the new wb if we see cleared I_WB_SWITCH.
 	 */
-	cookie->locked = smp_load_acquire(&inode->i_state) & I_WB_SWITCH;
+	cookie->locked = inode_state_read(inode) & I_WB_SWITCH;
+	smp_rmb();
 
 	if (unlikely(cookie->locked))
 		xa_lock_irqsave(&inode->i_mapping->i_pages, cookie->flags);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index a4e93fcd4b44..4ba2b274588a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2656,7 +2656,7 @@ static inline int icount_read(const struct inode *inode)
  */
 static inline bool inode_is_dirtytime_only(struct inode *inode)
 {
-	return (inode->i_state & (I_DIRTY_TIME | I_NEW |
+	return (inode_state_read(inode) & (I_DIRTY_TIME | I_NEW |
 				  I_FREEING | I_WILL_FREE)) == I_DIRTY_TIME;
 }
 
diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index a2848d731a46..5fcb5ab4fa47 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -193,7 +193,7 @@ void inode_io_list_del(struct inode *inode);
 static inline void wait_on_inode(struct inode *inode)
 {
 	wait_var_event(inode_state_wait_address(inode, __I_NEW),
-		       !(READ_ONCE(inode->i_state) & I_NEW));
+		       !(inode_state_read(inode) & I_NEW));
 }
 
 #ifdef CONFIG_CGROUP_WRITEBACK
@@ -234,7 +234,7 @@ static inline void inode_attach_wb(struct inode *inode, struct folio *folio)
 static inline void inode_detach_wb(struct inode *inode)
 {
 	if (inode->i_wb) {
-		WARN_ON_ONCE(!(inode->i_state & I_CLEAR));
+		WARN_ON_ONCE(!(inode_state_read(inode) & I_CLEAR));
 		wb_put(inode->i_wb);
 		inode->i_wb = NULL;
 	}
diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
index 1e23919c0da9..70c496954473 100644
--- a/include/trace/events/writeback.h
+++ b/include/trace/events/writeback.h
@@ -120,7 +120,7 @@ DECLARE_EVENT_CLASS(writeback_dirty_inode_template,
 		/* may be called for files on pseudo FSes w/ unregistered bdi */
 		strscpy_pad(__entry->name, bdi_dev_name(bdi), 32);
 		__entry->ino		= inode->i_ino;
-		__entry->state		= inode->i_state;
+		__entry->state		= inode_state_read(inode);
 		__entry->flags		= flags;
 	),
 
@@ -719,7 +719,7 @@ TRACE_EVENT(writeback_sb_inodes_requeue,
 		strscpy_pad(__entry->name,
 			    bdi_dev_name(inode_to_bdi(inode)), 32);
 		__entry->ino		= inode->i_ino;
-		__entry->state		= inode->i_state;
+		__entry->state		= inode_state_read(inode);
 		__entry->dirtied_when	= inode->dirtied_when;
 		__entry->cgroup_ino	= __trace_wb_assign_cgroup(inode_to_wb(inode));
 	),
@@ -758,7 +758,7 @@ DECLARE_EVENT_CLASS(writeback_single_inode_template,
 		strscpy_pad(__entry->name,
 			    bdi_dev_name(inode_to_bdi(inode)), 32);
 		__entry->ino		= inode->i_ino;
-		__entry->state		= inode->i_state;
+		__entry->state		= inode_state_read(inode);
 		__entry->dirtied_when	= inode->dirtied_when;
 		__entry->writeback_index = inode->i_mapping->writeback_index;
 		__entry->nr_to_write	= nr_to_write;
@@ -810,7 +810,7 @@ DECLARE_EVENT_CLASS(writeback_inode_template,
 	TP_fast_assign(
 		__entry->dev	= inode->i_sb->s_dev;
 		__entry->ino	= inode->i_ino;
-		__entry->state	= inode->i_state;
+		__entry->state	= inode_state_read(inode);
 		__entry->mode	= inode->i_mode;
 		__entry->dirtied_when = inode->dirtied_when;
 	),
-- 
2.43.0


