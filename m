Return-Path: <linux-fsdevel+bounces-63643-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4C4BC7EDA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 09 Oct 2025 10:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 25ED24FC8ED
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Oct 2025 08:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F77F272E56;
	Thu,  9 Oct 2025 08:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnp/ZE+S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2A62E6CB3
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Oct 2025 08:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759996808; cv=none; b=dSRkF2rTHwG/e+HgP8BbWQGnn24y770x5J7HoW2x9TZoo9KgaZSFCMECwAvWqhPQ3DiuLO5VnI7PchE9amLfsu9l+3XiNPxUYvHd39ckkptbeQfQKuJ4G28QR9tyYc8q+QT8IAxlDS9I3wNXrwivHuvzo2/22pNxs1JVjFPLT/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759996808; c=relaxed/simple;
	bh=+RBRF6meQwn3q9nzPryP2p+8250ep4XlqqidEyLjj2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zw9YpNmvzVqb8wdIU5z6L2yBr/Qb4htupS5HUSAbnH31w+t5kIinj3X42st1OMa6//FzvPPClA+ehmihb0a8WMLKGXWbjq6I75xnBOE70c4y/6d2hRoJhsekhwLgEd2TBRJYHj9ShvDrvTHJuy9Hj7lz4xJNp0yqdHnhpROoBeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fnp/ZE+S; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-61cc281171cso1271462a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Oct 2025 01:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759996804; x=1760601604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XtNZzXzCxxpF7eJNzzGGCepg+EzDGtZJGp4a5sIIOtw=;
        b=fnp/ZE+SnFGGqdYjPEXfYpM67VICjbU02VFp7wjSOOatBehRt/dBhsNMOHO/6nwVB3
         jnkwlcziHlgHkK+PG9v4A7K6/v71B1HLzZsRdjyCgik+sJjW2Z4oXjgZnzu2mSWH649Z
         ok9IUTJdev1mL0m0ApggQrjrtN9Q+Ovi1n6hlLE6mzYX6MbK+6jmx84UkuJKT/vIT7iv
         nRVPcGAX2ADZuFB3rYRyQwdEw+ZkvvPLvd3/n7bH/wM6y39oc7ln4cYHS3Tx1kaSYZbS
         cO2kIpTowdX+8+e5lqNGIu/Y75FfzPi8hqZ/Wj+ImxxFdrf/Vg9xCWOEs2BjNuvIHvp/
         wh6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759996804; x=1760601604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XtNZzXzCxxpF7eJNzzGGCepg+EzDGtZJGp4a5sIIOtw=;
        b=mqj7TOo25OD2KC9KjBnV9DCA17cPMMb7e9yZ3Yw1rKSBJu/ddySDSqFB+opmYumOu2
         /prhHhA1QWsAbBEuPKME0HXS7J1GYx+SHEt5k3Oc/6xXevbVpiOm5toRXXGO3JSKiZ8B
         6Eg69Fsg1OWOPPAN/rDSMkA0b3cB/C2AIEyGAozznLUczVQBEdfM77Cd0hFpahA8hpIy
         vSY9Pc/RtuHmFK/yj3RtmFJ0mQVMqv6TtPWxDlB2/fEF63DG9s6pa2uOAsj6kSJl4lII
         9bac5ZEw7KQlRDBJdzw3nLSS1Sgtm7Fjz50hIPBDafow/1c395W5UOJfQHElKjdA3oFO
         IVfg==
X-Forwarded-Encrypted: i=1; AJvYcCUmc09wysJD/lLrceKetAZC9DgaxrMKb7x5junTkAdkj/UN0RUlifAkBpsa7HQc+GFIXgOr4EULZkotuiAt@vger.kernel.org
X-Gm-Message-State: AOJu0YzzvcSgnY+ebbDp7ILiNd1Fj9JG/5vjm6OYma1+w5TwhFnDesh6
	tvGAY5DYvZ0yTXKEpgAg0a0FgFSaMKw4iytU7NZEuRAWPSGfhSLU9Q+d
X-Gm-Gg: ASbGncvo7RBvpCXYTMErJvUag3KuDSXCL8Brd5vSl3JMXuRG+nHvp+4A9i3R9IUapIU
	k9CXbyqJ0r9iSiewOuEx/eg86lXUi1XeJA2Lls4Me6FMYBh5LshCOXYSpghtl/ATJ/NIvJt1N9O
	jGWzRiQx2g8MZm/zScYQgZa5mUBtvq7vwp3p0GPvNY+/hQ2nsG+7b+2DJj9sT3jSXlQtybi54cd
	ZSUhYi5aaFX/KsSVTZeBywIzcPOxIe/oXd3myvMOoaUbm2qEBuqkTiisIQNbKm+D565yfVkrqST
	3qWTN3cSsQXPr2mFpoMIYZo7S2y+si9Ynz1mazsedSe60Ev8GVBRyGT5RBP5kf+wPLDqawIDcQT
	hdb834grGfv6z3VeaVm9Dm6Y6qyxucA97Bz0Z+NIHmZ2jjjSFF+Br1d3Ba54MfMNp1O50UY25xi
	GRZJc6y+VOB2FVAb0IBnjVOLXyJa5sIRDZEjJHyHDSnVc=
X-Google-Smtp-Source: AGHT+IEouxbTI3/2qFJGFL8V5mVY3HAotK98uqu1QC3hyrh6oGwfceS36G8V1F2YUkpXySTgyqtUfg==
X-Received: by 2002:a17:907:2d8a:b0:b3e:e16a:8cf2 with SMTP id a640c23a62f3a-b50aca0b087mr678905866b.56.1759996803728;
        Thu, 09 Oct 2025 01:00:03 -0700 (PDT)
Received: from f.. (cst-prg-66-155.cust.vodafone.cz. [46.135.66.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5007639379sm553509366b.48.2025.10.09.01.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 01:00:03 -0700 (PDT)
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
Subject: [PATCH v7 13/14] xfs: use the new ->i_state accessors
Date: Thu,  9 Oct 2025 09:59:27 +0200
Message-ID: <20251009075929.1203950-14-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251009075929.1203950-1-mjguzik@gmail.com>
References: <20251009075929.1203950-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change generated with coccinelle and fixed up by hand as appropriate.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

cheat sheet:

If ->i_lock is held, then:

state = inode->i_state          => state = inode_state_read(inode)
inode->i_state |= (I_A | I_B)   => inode_state_set(inode, I_A | I_B)
inode->i_state &= ~(I_A | I_B)  => inode_state_clear(inode, I_A | I_B)
inode->i_state = I_A | I_B      => inode_state_assign(inode, I_A | I_B)

If ->i_lock is not held or only held conditionally:

state = inode->i_state          => state = inode_state_read_once(inode)
inode->i_state |= (I_A | I_B)   => inode_state_set_raw(inode, I_A | I_B)
inode->i_state &= ~(I_A | I_B)  => inode_state_clear_raw(inode, I_A | I_B)
inode->i_state = I_A | I_B      => inode_state_assign_raw(inode, I_A | I_B)

 fs/xfs/scrub/common.c       | 2 +-
 fs/xfs/scrub/inode_repair.c | 2 +-
 fs/xfs/scrub/parent.c       | 2 +-
 fs/xfs/xfs_bmap_util.c      | 2 +-
 fs/xfs/xfs_health.c         | 4 ++--
 fs/xfs/xfs_icache.c         | 6 +++---
 fs/xfs/xfs_inode.c          | 6 +++---
 fs/xfs/xfs_inode_item.c     | 4 ++--
 fs/xfs/xfs_iops.c           | 2 +-
 fs/xfs/xfs_reflink.h        | 2 +-
 10 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/fs/xfs/scrub/common.c b/fs/xfs/scrub/common.c
index 2ef7742be7d3..7bfa37c99480 100644
--- a/fs/xfs/scrub/common.c
+++ b/fs/xfs/scrub/common.c
@@ -1249,7 +1249,7 @@ xchk_irele(
 		 * hits do not clear DONTCACHE, so we must do it here.
 		 */
 		spin_lock(&VFS_I(ip)->i_lock);
-		VFS_I(ip)->i_state &= ~I_DONTCACHE;
+		inode_state_clear(VFS_I(ip), I_DONTCACHE);
 		spin_unlock(&VFS_I(ip)->i_lock);
 	}
 
diff --git a/fs/xfs/scrub/inode_repair.c b/fs/xfs/scrub/inode_repair.c
index a90a011c7e5f..4f7040c9ddf0 100644
--- a/fs/xfs/scrub/inode_repair.c
+++ b/fs/xfs/scrub/inode_repair.c
@@ -1933,7 +1933,7 @@ xrep_inode_pptr(
 	 * Unlinked inodes that cannot be added to the directory tree will not
 	 * have a parent pointer.
 	 */
-	if (inode->i_nlink == 0 && !(inode->i_state & I_LINKABLE))
+	if (inode->i_nlink == 0 && !(inode_state_read_once(inode) & I_LINKABLE))
 		return 0;
 
 	/* Children of the superblock do not have parent pointers. */
diff --git a/fs/xfs/scrub/parent.c b/fs/xfs/scrub/parent.c
index 3b692c4acc1e..11d5de10fd56 100644
--- a/fs/xfs/scrub/parent.c
+++ b/fs/xfs/scrub/parent.c
@@ -915,7 +915,7 @@ xchk_pptr_looks_zapped(
 	 * Temporary files that cannot be linked into the directory tree do not
 	 * have attr forks because they cannot ever have parents.
 	 */
-	if (inode->i_nlink == 0 && !(inode->i_state & I_LINKABLE))
+	if (inode->i_nlink == 0 && !(inode_state_read_once(inode) & I_LINKABLE))
 		return false;
 
 	/*
diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index 06ca11731e43..2208a720ec3f 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -514,7 +514,7 @@ xfs_can_free_eofblocks(
 	 * Caller must either hold the exclusive io lock; or be inactivating
 	 * the inode, which guarantees there are no other users of the inode.
 	 */
-	if (!(VFS_I(ip)->i_state & I_FREEING))
+	if (!(inode_state_read_once(VFS_I(ip)) & I_FREEING))
 		xfs_assert_ilocked(ip, XFS_IOLOCK_EXCL);
 
 	/* prealloc/delalloc exists only on regular files */
diff --git a/fs/xfs/xfs_health.c b/fs/xfs/xfs_health.c
index 7c541fb373d5..3c1557fb1cf0 100644
--- a/fs/xfs/xfs_health.c
+++ b/fs/xfs/xfs_health.c
@@ -285,7 +285,7 @@ xfs_inode_mark_sick(
 	 * is not the case here.
 	 */
 	spin_lock(&VFS_I(ip)->i_lock);
-	VFS_I(ip)->i_state &= ~I_DONTCACHE;
+	inode_state_clear(VFS_I(ip), I_DONTCACHE);
 	spin_unlock(&VFS_I(ip)->i_lock);
 }
 
@@ -309,7 +309,7 @@ xfs_inode_mark_corrupt(
 	 * is not the case here.
 	 */
 	spin_lock(&VFS_I(ip)->i_lock);
-	VFS_I(ip)->i_state &= ~I_DONTCACHE;
+	inode_state_clear(VFS_I(ip), I_DONTCACHE);
 	spin_unlock(&VFS_I(ip)->i_lock);
 }
 
diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index e44040206851..f3fc4d21bfe1 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -334,7 +334,7 @@ xfs_reinit_inode(
 	dev_t			dev = inode->i_rdev;
 	kuid_t			uid = inode->i_uid;
 	kgid_t			gid = inode->i_gid;
-	unsigned long		state = inode->i_state;
+	unsigned long		state = inode_state_read_once(inode);
 
 	error = inode_init_always(mp->m_super, inode);
 
@@ -345,7 +345,7 @@ xfs_reinit_inode(
 	inode->i_rdev = dev;
 	inode->i_uid = uid;
 	inode->i_gid = gid;
-	inode->i_state = state;
+	inode_state_assign_raw(inode, state);
 	mapping_set_folio_min_order(inode->i_mapping,
 				    M_IGEO(mp)->min_folio_order);
 	return error;
@@ -411,7 +411,7 @@ xfs_iget_recycle(
 	ip->i_flags |= XFS_INEW;
 	xfs_perag_clear_inode_tag(pag, XFS_INO_TO_AGINO(mp, ip->i_ino),
 			XFS_ICI_RECLAIM_TAG);
-	inode->i_state = I_NEW;
+	inode_state_assign_raw(inode, I_NEW);
 	spin_unlock(&ip->i_flags_lock);
 	spin_unlock(&pag->pag_ici_lock);
 
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 36b39539e561..f1f88e48fe22 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -1580,7 +1580,7 @@ xfs_iunlink_reload_next(
 	next_ip->i_prev_unlinked = prev_agino;
 	trace_xfs_iunlink_reload_next(next_ip);
 rele:
-	ASSERT(!(VFS_I(next_ip)->i_state & I_DONTCACHE));
+	ASSERT(!(inode_state_read_once(VFS_I(next_ip)) & I_DONTCACHE));
 	if (xfs_is_quotacheck_running(mp) && next_ip)
 		xfs_iflags_set(next_ip, XFS_IQUOTAUNCHECKED);
 	xfs_irele(next_ip);
@@ -2111,7 +2111,7 @@ xfs_rename_alloc_whiteout(
 	 */
 	xfs_setup_iops(tmpfile);
 	xfs_finish_inode_setup(tmpfile);
-	VFS_I(tmpfile)->i_state |= I_LINKABLE;
+	inode_state_set_raw(VFS_I(tmpfile), I_LINKABLE);
 
 	*wip = tmpfile;
 	return 0;
@@ -2330,7 +2330,7 @@ xfs_rename(
 		 * flag from the inode so it doesn't accidentally get misused in
 		 * future.
 		 */
-		VFS_I(du_wip.ip)->i_state &= ~I_LINKABLE;
+		inode_state_clear_raw(VFS_I(du_wip.ip), I_LINKABLE);
 	}
 
 out_commit:
diff --git a/fs/xfs/xfs_inode_item.c b/fs/xfs/xfs_inode_item.c
index 1bd411a1114c..2eb0c6011a2e 100644
--- a/fs/xfs/xfs_inode_item.c
+++ b/fs/xfs/xfs_inode_item.c
@@ -113,9 +113,9 @@ xfs_inode_item_precommit(
 	 * to log the timestamps, or will clear already cleared fields in the
 	 * worst case.
 	 */
-	if (inode->i_state & I_DIRTY_TIME) {
+	if (inode_state_read_once(inode) & I_DIRTY_TIME) {
 		spin_lock(&inode->i_lock);
-		inode->i_state &= ~I_DIRTY_TIME;
+		inode_state_clear(inode, I_DIRTY_TIME);
 		spin_unlock(&inode->i_lock);
 	}
 
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index caff0125faea..ad94fbf55014 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -1420,7 +1420,7 @@ xfs_setup_inode(
 	bool			is_meta = xfs_is_internal_inode(ip);
 
 	inode->i_ino = ip->i_ino;
-	inode->i_state |= I_NEW;
+	inode_state_set_raw(inode, I_NEW);
 
 	inode_sb_list_add(inode);
 	/* make the inode look hashed for the writeback code */
diff --git a/fs/xfs/xfs_reflink.h b/fs/xfs/xfs_reflink.h
index 36cda724da89..9d1ed9bb0bee 100644
--- a/fs/xfs/xfs_reflink.h
+++ b/fs/xfs/xfs_reflink.h
@@ -17,7 +17,7 @@ xfs_can_free_cowblocks(struct xfs_inode *ip)
 {
 	struct inode *inode = VFS_I(ip);
 
-	if ((inode->i_state & I_DIRTY_PAGES) ||
+	if ((inode_state_read_once(inode) & I_DIRTY_PAGES) ||
 	    mapping_tagged(inode->i_mapping, PAGECACHE_TAG_DIRTY) ||
 	    mapping_tagged(inode->i_mapping, PAGECACHE_TAG_WRITEBACK) ||
 	    atomic_read(&inode->i_dio_count))
-- 
2.34.1


