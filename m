Return-Path: <linux-fsdevel+bounces-61746-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 448C2B598AC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 16:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CCCD462DE4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 14:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B4935083E;
	Tue, 16 Sep 2025 13:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GWGzCbAD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32FC32F764
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 13:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758031193; cv=none; b=qMkBhHi2NQ5UMQdCIVxkBSK5Eetd5rVoRE3RwnBrVgq2ZdQd2PyOPDBT9f/nyb35kRBv1H//fO/L5rmjFEHAJlkO1ZqCLD4f4G3V3BRU+GjxYqoB9EZ8ofBeYQ10m+gwVzvIx3UeU55OaGDr7tfLrj1ulHZPtv/h8MdePtaT+40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758031193; c=relaxed/simple;
	bh=67CCxoskkGrnlUlHhCX2YKbkGpmxVzicQpN51RR/ZoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mv2y40YWC2ooUVqYkyUidiBI8ofQYSUwEFt48WVQpO3HmIElMEcHbnkfiUIVcVpo4phCmh8x2kgON08Y5nUGSrEAT/n0TWQz5YIg82U1lcnvH2NRjMOchGlwWEfj/kRM0bg/P/ANFAac8H8IbNHMRYiLicFqYkZuj6aYD9TIg6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GWGzCbAD; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45f2fa8a1adso15710175e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 06:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758031189; x=1758635989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=29JSURtnbb1RZIccpZPbCOQkUUAEjI4J83C/88taCJc=;
        b=GWGzCbADEW3VzjUgNqLj4SAOxmXYChxKAq25VCNCe2AJuoXDONt8UqftEbl9+WmgPd
         y3MPTYzAH1TNoPNuK5R5+sWMewJwRpxU+Rq6V2rwY+AQINbE1dgMVkdS/rNi8GEZl/i3
         EnQoWClY1USpxmh+7xKrheqXmx/LI5sgh4FECMhQcXt201ANOGKBdeZUr+MjBFnziHd6
         V8hZ3q0rm4zkX4fnNDSkn07jVElHgfFRz0O9zhNZqtzYnpioDsnI+FHOILrUZUAxRjOJ
         hy4OT14lx+bu7nGGW8Y5uibHiAaAbHUhvW6WKVzORQkflkY/wWI4IC96w/pyXUSAEDy9
         cQUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758031189; x=1758635989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=29JSURtnbb1RZIccpZPbCOQkUUAEjI4J83C/88taCJc=;
        b=ol3m8LE8QzJkoTwWKO/xSYAhMgxLjTPk19OZqELxBq35fXx9YdLxbxCqwC5C/JMlYB
         2qtrj5iIVE9akFHUuN4ByWuoQaecHxAx7iTPoEoPjyw2Yhsw9/SdBck0bQDU4UhFR1BN
         hso20akep75lH3ZwtGdNFGFVUPS37nickIRY//WDQJ/wnNecHTxlmUhVFbSbRRD0pv5X
         kWhOMV/nIIsu8dWajI07WReecyc6OlXWVuM0OklOwZvnPdkPgiv30LLRHaqvZm7sOHd5
         /BMJKLWvZ5McKxyDZ565Ih1TrxcaKxQo/Zs8+plvf9xDL/doWirY07FP8J+1jQDn+OVO
         Yqwg==
X-Forwarded-Encrypted: i=1; AJvYcCWrg117x8dsSDNFfrTn2kS7o3h1tne3J/dcPDtklu6XczxD1bHA5NSPrIx4/PsRN4wBtMMrsBJB4OQklV8l@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2a6yXAIX27pb6CU4QHN5Ipz1EbbFyJMrAc1PYT8EJcBLUWsIP
	cfDiry4zHw40/9yo6DTs3rZgvhFmhA/X8XTam6qTWuGuHehD9rNw3y1j
X-Gm-Gg: ASbGncvZtX3fuwEJuOnd8Sm5MP5jHvSRFXkIGkY3yikdZiGOACmebuoeXCqVvHSD8an
	5OuYIWDjVIzsyZWvdwGjVM4blB65hnsuBPd6aIYe3EAA66Wr87SOmMgxcvuG0/Jvaesblbtzjfu
	2NvEJTmXYh4LU+0jyoSsgaTdeBW1soxgSdCpK0B5zqcn8siVgpfHYYjn7lI3twrmMg9gX13uy36
	2IvbEXNlv91m/cC3IHG0C20Tf5RpqjeCdu/kJKtRh7TepH1d0kp0Jh5UYPU9I0g5v4Cuv0HPzWf
	Zry3gSwzjrWmSCzs4MezdLhpXMEPj42fCfingnhf7uf25l+WIXZ36sLOufGwC5+67VqykXXZHxU
	8ifvY2ZQFpA67yUr3mpwWJ9yfGAmLLDLF22aIsEI7l7TT2O6Dq6//FJwI8kzEZtPN4Zet8pMMNj
	qpJQT6jr4=
X-Google-Smtp-Source: AGHT+IHcXAIc1sXbMc5v7hDSGRfrit2oYOb7A0GAgCY3ykOcZbinoBfJfezyLCAk8DhCdfrCgCQQPw==
X-Received: by 2002:a05:6000:2510:b0:3ec:db87:ff53 with SMTP id ffacd0b85a97d-3ecdb8813b6mr1168621f8f.12.1758031188900;
        Tue, 16 Sep 2025 06:59:48 -0700 (PDT)
Received: from f.. (cst-prg-88-146.cust.vodafone.cz. [46.135.88.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7cde81491sm16557991f8f.42.2025.09.16.06.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 06:59:48 -0700 (PDT)
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
Subject: [PATCH v4 07/12] xfs: use the new ->i_state accessors
Date: Tue, 16 Sep 2025 15:58:55 +0200
Message-ID: <20250916135900.2170346-8-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916135900.2170346-1-mjguzik@gmail.com>
References: <20250916135900.2170346-1-mjguzik@gmail.com>
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
Suppose flags I_A and I_B are to be handled, then if ->i_lock is held:

state = inode->i_state          => state = inode_state_read(inode)
inode->i_state |= (I_A | I_B)   => inode_state_add(inode, I_A | I_B)
inode->i_state &= ~(I_A | I_B)  => inode_state_del(inode, I_A | I_B)
inode->i_state = I_A | I_B      => inode_state_set(inode, I_A | I_B)

If ->i_lock is not held or only held conditionally, add "_once"
suffix for the read routine or "_raw" for the rest:

state = inode->i_state          => state = inode_state_read_once(inode)
inode->i_state |= (I_A | I_B)   => inode_state_add_raw(inode, I_A | I_B)
inode->i_state &= ~(I_A | I_B)  => inode_state_del_raw(inode, I_A | I_B)
inode->i_state = I_A | I_B      => inode_state_set_raw(inode, I_A | I_B)

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
index 2ef7742be7d3..e27cfbcfc5c9 100644
--- a/fs/xfs/scrub/common.c
+++ b/fs/xfs/scrub/common.c
@@ -1249,7 +1249,7 @@ xchk_irele(
 		 * hits do not clear DONTCACHE, so we must do it here.
 		 */
 		spin_lock(&VFS_I(ip)->i_lock);
-		VFS_I(ip)->i_state &= ~I_DONTCACHE;
+		inode_state_del(VFS_I(ip), I_DONTCACHE);
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
index 7c541fb373d5..c765a28b4556 100644
--- a/fs/xfs/xfs_health.c
+++ b/fs/xfs/xfs_health.c
@@ -285,7 +285,7 @@ xfs_inode_mark_sick(
 	 * is not the case here.
 	 */
 	spin_lock(&VFS_I(ip)->i_lock);
-	VFS_I(ip)->i_state &= ~I_DONTCACHE;
+	inode_state_del(VFS_I(ip), I_DONTCACHE);
 	spin_unlock(&VFS_I(ip)->i_lock);
 }
 
@@ -309,7 +309,7 @@ xfs_inode_mark_corrupt(
 	 * is not the case here.
 	 */
 	spin_lock(&VFS_I(ip)->i_lock);
-	VFS_I(ip)->i_state &= ~I_DONTCACHE;
+	inode_state_del(VFS_I(ip), I_DONTCACHE);
 	spin_unlock(&VFS_I(ip)->i_lock);
 }
 
diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index 4cf7abe50143..0023bd449573 100644
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
+	inode_state_set_raw(inode, state);
 	mapping_set_folio_min_order(inode->i_mapping,
 				    M_IGEO(mp)->min_folio_order);
 	return error;
@@ -411,7 +411,7 @@ xfs_iget_recycle(
 	ip->i_flags |= XFS_INEW;
 	xfs_perag_clear_inode_tag(pag, XFS_INO_TO_AGINO(mp, ip->i_ino),
 			XFS_ICI_RECLAIM_TAG);
-	inode->i_state = I_NEW;
+	inode_state_set_raw(inode, I_NEW);
 	spin_unlock(&ip->i_flags_lock);
 	spin_unlock(&pag->pag_ici_lock);
 
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index df8eab11dc48..ed141f818e8d 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -1569,7 +1569,7 @@ xfs_iunlink_reload_next(
 	next_ip->i_prev_unlinked = prev_agino;
 	trace_xfs_iunlink_reload_next(next_ip);
 rele:
-	ASSERT(!(VFS_I(next_ip)->i_state & I_DONTCACHE));
+	ASSERT(!(inode_state_read_once(VFS_I(next_ip)) & I_DONTCACHE));
 	if (xfs_is_quotacheck_running(mp) && next_ip)
 		xfs_iflags_set(next_ip, XFS_IQUOTAUNCHECKED);
 	xfs_irele(next_ip);
@@ -2093,7 +2093,7 @@ xfs_rename_alloc_whiteout(
 	 */
 	xfs_setup_iops(tmpfile);
 	xfs_finish_inode_setup(tmpfile);
-	VFS_I(tmpfile)->i_state |= I_LINKABLE;
+	inode_state_add_raw(VFS_I(tmpfile), I_LINKABLE);
 
 	*wip = tmpfile;
 	return 0;
@@ -2319,7 +2319,7 @@ xfs_rename(
 		 * flag from the inode so it doesn't accidentally get misused in
 		 * future.
 		 */
-		VFS_I(du_wip.ip)->i_state &= ~I_LINKABLE;
+		inode_state_del_raw(VFS_I(du_wip.ip), I_LINKABLE);
 	}
 
 out_commit:
diff --git a/fs/xfs/xfs_inode_item.c b/fs/xfs/xfs_inode_item.c
index 829675700fcd..a98fb2696d08 100644
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
+		inode_state_del(inode, I_DIRTY_TIME);
 		spin_unlock(&inode->i_lock);
 	}
 
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 149b5460fbfd..7a05d0ac7ed8 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -1419,7 +1419,7 @@ xfs_setup_inode(
 	bool			is_meta = xfs_is_internal_inode(ip);
 
 	inode->i_ino = ip->i_ino;
-	inode->i_state |= I_NEW;
+	inode_state_add_raw(inode, I_NEW);
 
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
2.43.0


