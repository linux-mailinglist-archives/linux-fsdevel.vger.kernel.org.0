Return-Path: <linux-fsdevel+bounces-17804-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 422488B2551
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 17:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EC20B22E19
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 15:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649E214B093;
	Thu, 25 Apr 2024 15:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8Jve8IU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D768374F5;
	Thu, 25 Apr 2024 15:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714059574; cv=none; b=f1i6x61cQxP0z2XNALEAKgfE7UtHOLpGhbz2rblMdc8CSFjg8qXl1vnodKuJW+BoH9+pPliLzRQTBF0vcOhYVNEoCHW6GiFppVY61xQKebmO/jPCMDOuBDbMEHmZfrC6WmujvIR/uJKcuAfSaZRqVRUrcURoEUafW6eXEsR5TG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714059574; c=relaxed/simple;
	bh=bSUclU2izGheTwXd8keft4MC8P1yEhM3Sj2Ld4U8jgs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IyhoxdNY/hSs/YJAUQeMUY2nTyq2EYSdDvdor341GTkHjuZLW9xQy/9mhdP6pvxrRWZPvEtstowiET3fmzrzuVi5JDianrunmmsU0yRb9RAShCjLztpnj3kxqspbvwAjLYD3agEkyAyJX1MsL0wLwcoAYNvlnFLvQtMFav9HjJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z8Jve8IU; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1eac92f7c74so5363915ad.3;
        Thu, 25 Apr 2024 08:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714059571; x=1714664371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A+WR63U8nKmZFg5g3cntUB4B81Edur+hAEfQ73A5aFQ=;
        b=Z8Jve8IUcGvV4EU+PDG/ZyD7cxIJBMR6MuFQbqPEDoDjuDM5VDsErX3ru0Of1d4gUR
         B2r++/CdJaj46G2x0ra4boPcEfoXskRs4Ot0X5NR2MX7xaLC3Fa9tvOTYWc07yOiJyFM
         uTZIqdJRkZ6oj9ENiIKcVcOnVP+gci6iL8YYoZh0KVbQC4rWYp8Z4DVIsz66N4DMQNDG
         HWIcofPPzAAfFzHYdpSGcjSxAAlyVy7qiACaNVBhVZmviDlVn0jcOw6153M2xasFNiZT
         w4AfZZJMPNCcwlwwJqq3JJ57+/050gJex7UDYNMY1a7DxCBdNX9G84Q4kVnf7KJVkdig
         zvGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714059571; x=1714664371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A+WR63U8nKmZFg5g3cntUB4B81Edur+hAEfQ73A5aFQ=;
        b=CzHzqbd4k5TnDjP9VDVWHTToMobEGwk7Ds2/qvzbx/llXpypT5MtgcoaWF8bBrAWkI
         Nc3XGyH9ru3fIhjpUPLXlpRrFwUSv87rx4IHLFi8G+U2bxOPeXMMpXV7bEnc2anhhUky
         ev6iVIeGmAIZg1owTksT9Rf99DT+QcsssOe/ijhumYQx0xjpfIjrfoLiaosm5a+AJYcs
         DKTaScKA/ovrFamO1yE8jXYt2m/pxhQsjwj/i/aVadStTWscYfELziGSNJ+h5ZUAfUCc
         dwt4cVWSLneKnAmOZolPaRevOA5JsT7DqtMJTegLpjcqxeimLREdgrXITguoaHWwO9zs
         VNzA==
X-Forwarded-Encrypted: i=1; AJvYcCWNuakBrCGteM5ZJ7FKE5xWh9V1Xu0iqj/Dt1wUS7Bo8liQxdIdRGmFapQqsHwxuQod30XVXMrnmwjHKKF/zMyhS73tz7qBVlrAuQCw
X-Gm-Message-State: AOJu0YwJ2ul+TNoX+GAK5f4/aGeqTgkywGb/0WbfqNdtER6qVdD2eTh7
	5hh4tZmvL+Y/JJB1+ma3xOMLPPNNEtOX3AJjdKNtir6ojJKeA0ZzoaWzz7/nz7M=
X-Google-Smtp-Source: AGHT+IEFO3xhTACsvdmGVlWDvmqEjDEnK2363p/Rd2lSHhywT8HZksTpJxIvxSeo/d+NqC6K4Jj1iQ==
X-Received: by 2002:a17:903:2451:b0:1ea:9585:a1d7 with SMTP id l17-20020a170903245100b001ea9585a1d7mr4790869pls.37.1714059571146;
        Thu, 25 Apr 2024 08:39:31 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id y14-20020a1709027c8e00b001e3e244e5c0sm13853843pll.78.2024.04.25.08.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 08:39:30 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+325b61d3c9a17729454b@syzkaller.appspotmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	willy@infradead.org,
	jlayton@kernel.org,
	brauner@kernel.org,
	jack@suse.cz,
	akpm@linux-foundation.org,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH] hfsplus: Fix deadlock in hfsplus filesystem
Date: Fri, 26 Apr 2024 00:39:24 +0900
Message-Id: <20240425153924.47962-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <00000000000044243d05eed3fc71@google.com>
References: <00000000000044243d05eed3fc71@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[syz report]
======================================================
WARNING: possible circular locking dependency detected
6.9.0-rc5-syzkaller-00036-g9d1ddab261f3 #0 Not tainted
------------------------------------------------------
syz-executor343/5074 is trying to acquire lock:
ffff8880482187c8 (&HFSPLUS_I(inode)->extents_lock){+.+.}-{3:3}, at: hfsplus_file_extend+0x21b/0x1b70 fs/hfsplus/extents.c:457

but task is already holding lock:
ffff88807dadc0b0 (&tree->tree_lock){+.+.}-{3:3}, at: hfsplus_find_init+0x14a/0x1c0

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&tree->tree_lock){+.+.}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       hfsplus_file_truncate+0x811/0xb50 fs/hfsplus/extents.c:595
       hfsplus_delete_inode+0x174/0x220
       hfsplus_unlink+0x512/0x790 fs/hfsplus/dir.c:405
       vfs_unlink+0x365/0x600 fs/namei.c:4335
       do_unlinkat+0x4ae/0x830 fs/namei.c:4399
       __do_sys_unlinkat fs/namei.c:4442 [inline]
       __se_sys_unlinkat fs/namei.c:4435 [inline]
       __x64_sys_unlinkat+0xce/0xf0 fs/namei.c:4435
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&HFSPLUS_I(inode)->extents_lock){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
       __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       hfsplus_file_extend+0x21b/0x1b70 fs/hfsplus/extents.c:457
       hfsplus_bmap_reserve+0x105/0x4e0 fs/hfsplus/btree.c:358
       hfsplus_rename_cat+0x1d0/0x1050 fs/hfsplus/catalog.c:456
       hfsplus_rename+0x12e/0x1c0 fs/hfsplus/dir.c:552
       vfs_rename+0xbdb/0xf00 fs/namei.c:4880
       do_renameat2+0xd94/0x13f0 fs/namei.c:5037
       __do_sys_rename fs/namei.c:5084 [inline]
       __se_sys_rename fs/namei.c:5082 [inline]
       __x64_sys_rename+0x86/0xa0 fs/namei.c:5082
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&tree->tree_lock);
                               lock(&HFSPLUS_I(inode)->extents_lock);
                               lock(&tree->tree_lock);
  lock(&HFSPLUS_I(inode)->extents_lock);

 *** DEADLOCK ***
 ==================================================

I wrote a patch to eliminate the deadlock that has been occurring 
continuously in hfsplus for a long time. This patch prevents deadlock 
caused by recursion and ABBA deadlock.

Reported-by: syzbot+325b61d3c9a17729454b@syzkaller.appspotmail.com
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 fs/hfsplus/attributes.c | 33 +++++++++++++++--
 fs/hfsplus/btree.c      | 14 ++++++-
 fs/hfsplus/catalog.c    | 45 ++++++++++++++++++++--
 fs/hfsplus/extents.c    | 82 ++++++++++++++++++++++++++++++-----------
 fs/hfsplus/xattr.c      | 17 +++++++--
 5 files changed, 159 insertions(+), 32 deletions(-)

diff --git a/fs/hfsplus/attributes.c b/fs/hfsplus/attributes.c
index eeebe80c6be4..af142e458ac2 100644
--- a/fs/hfsplus/attributes.c
+++ b/fs/hfsplus/attributes.c
@@ -198,8 +198,11 @@ int hfsplus_create_attr(struct inode *inode,
 	struct super_block *sb = inode->i_sb;
 	struct hfs_find_data fd;
 	hfsplus_attr_entry *entry_ptr;
+	atomic_long_t owner;
+	unsigned long curr = (unsigned long)current;
+	struct inode *fd_inode;
 	int entry_size;
-	int err;
+	int err, locked = 0;
 
 	hfs_dbg(ATTR_MOD, "create_attr: %s,%ld\n",
 		name ? name : NULL, inode->i_ino);
@@ -216,9 +219,19 @@ int hfsplus_create_attr(struct inode *inode,
 	err = hfs_find_init(HFSPLUS_SB(sb)->attr_tree, &fd);
 	if (err)
 		goto failed_init_create_attr;
-
+	
+	fd_inode = fd.tree->inode;
+	locked = mutex_trylock(&HFSPLUS_I(fd_inode)->extents_lock);
+
+	if(!locked){
+		owner = HFSPLUS_I(fd_inode)->extents_lock.owner;
+		if((unsigned long)atomic_long_cmpxchg(&owner, 0, 0) != curr)
+			return -EAGAIN;
+	}
 	/* Fail early and avoid ENOSPC during the btree operation */
 	err = hfs_bmap_reserve(fd.tree, fd.tree->depth + 1);
+	if(locked)
+		mutex_unlock(&HFSPLUS_I(fd_inode)->extents_lock);
 	if (err)
 		goto failed_create_attr;
 
@@ -306,7 +319,10 @@ static int __hfsplus_delete_attr(struct inode *inode, u32 cnid,
 
 int hfsplus_delete_attr(struct inode *inode, const char *name)
 {
-	int err = 0;
+	int err = 0, locked = 0;
+	atomic_long_t owner;
+	unsigned long curr = (unsigned long)current;
+	struct inode *fd_inode;
 	struct super_block *sb = inode->i_sb;
 	struct hfs_find_data fd;
 
@@ -321,9 +337,18 @@ int hfsplus_delete_attr(struct inode *inode, const char *name)
 	err = hfs_find_init(HFSPLUS_SB(sb)->attr_tree, &fd);
 	if (err)
 		return err;
-
+	
+	fd_inode = fd.tree->inode;
+	locked = mutex_trylock(&HFSPLUS_I(fd_inode)->extents_lock);
+	if(!locked){
+		owner = HFSPLUS_I(fd_inode)->extents_lock.owner;
+		if((unsigned long)atomic_long_cmpxchg(&owner, 0, 0) != curr)
+			return -EAGAIN;
+	}
 	/* Fail early and avoid ENOSPC during the btree operation */
 	err = hfs_bmap_reserve(fd.tree, fd.tree->depth);
+	if(locked)
+		mutex_unlock(&HFSPLUS_I(fd_inode)->extents_lock);
 	if (err)
 		goto out;
 
diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
index 9e1732a2b92a..aea695c4cfb8 100644
--- a/fs/hfsplus/btree.c
+++ b/fs/hfsplus/btree.c
@@ -380,9 +380,21 @@ struct hfs_bnode *hfs_bmap_alloc(struct hfs_btree *tree)
 	u16 off16;
 	u16 len;
 	u8 *data, byte, m;
-	int i, res;
+	int i, res, locked = 0;
+	struct inode *inode = tree->inode;
+	atomic_long_t owner;
+	unsigned long curr = (unsigned long)current;
+
+	locked = mutex_trylock(&HFSPLUS_I(inode)->extents_lock);
 
+	if(!locked){
+		owner = HFSPLUS_I(inode)->extents_lock.owner;
+		if((unsigned long)atomic_long_cmpxchg(&owner, 0, 0) != curr)
+			return ERR_PTR(-MAX_ERRNO);
+	}
 	res = hfs_bmap_reserve(tree, 1);
+	if (locked)
+		mutex_unlock(&HFSPLUS_I(inode)->extents_lock);
 	if (res)
 		return ERR_PTR(res);
 
diff --git a/fs/hfsplus/catalog.c b/fs/hfsplus/catalog.c
index 1995bafee839..b5cd01bce6ea 100644
--- a/fs/hfsplus/catalog.c
+++ b/fs/hfsplus/catalog.c
@@ -257,7 +257,10 @@ int hfsplus_create_cat(u32 cnid, struct inode *dir,
 	struct hfs_find_data fd;
 	hfsplus_cat_entry entry;
 	int entry_size;
-	int err;
+	int err, locked = 0;
+	atomic_long_t owner;
+	struct inode *fd_inode;
+	unsigned long curr = (unsigned long)current;
 
 	hfs_dbg(CAT_MOD, "create_cat: %s,%u(%d)\n",
 		str->name, cnid, inode->i_nlink);
@@ -269,7 +272,17 @@ int hfsplus_create_cat(u32 cnid, struct inode *dir,
 	 * Fail early and avoid ENOSPC during the btree operations. We may
 	 * have to split the root node at most once.
 	 */
+	fd_inode = fd.tree->inode;
+	locked = mutex_trylock(&HFSPLUS_I(fd_inode)->extents_lock);
+
+	if(!locked){
+		owner = HFSPLUS_I(fd_inode)->extents_lock.owner;
+		if((unsigned long)atomic_long_cmpxchg(&owner, 0, 0) != curr)
+			return -EAGAIN;
+	}
 	err = hfs_bmap_reserve(fd.tree, 2 * fd.tree->depth);
+	if (locked)
+		mutex_unlock(&HFSPLUS_I(fd_inode)->extents_lock);
 	if (err)
 		goto err2;
 
@@ -333,7 +346,10 @@ int hfsplus_delete_cat(u32 cnid, struct inode *dir, const struct qstr *str)
 	struct hfs_find_data fd;
 	struct hfsplus_fork_raw fork;
 	struct list_head *pos;
-	int err, off;
+	struct inode *fd_inode;
+	int err, off, locked = 0;
+	atomic_long_t owner;
+	unsigned long curr = (unsigned long)current;
 	u16 type;
 
 	hfs_dbg(CAT_MOD, "delete_cat: %s,%u\n", str ? str->name : NULL, cnid);
@@ -345,7 +361,17 @@ int hfsplus_delete_cat(u32 cnid, struct inode *dir, const struct qstr *str)
 	 * Fail early and avoid ENOSPC during the btree operations. We may
 	 * have to split the root node at most once.
 	 */
+	fd_inode = fd.tree->inode;
+	locked = mutex_trylock(&HFSPLUS_I(fd_inode)->extents_lock);
+
+	if(!locked){
+		owner = HFSPLUS_I(fd_inode)->extents_lock.owner;
+		if((unsigned long)atomic_long_cmpxchg(&owner, 0, 0) != curr)
+			return -EAGAIN;
+	}
 	err = hfs_bmap_reserve(fd.tree, 2 * (int)fd.tree->depth - 2);
+	if (locked)
+		mutex_unlock(&HFSPLUS_I(fd_inode)->extents_lock);
 	if (err)
 		goto out;
 
@@ -439,7 +465,10 @@ int hfsplus_rename_cat(u32 cnid,
 	struct hfs_find_data src_fd, dst_fd;
 	hfsplus_cat_entry entry;
 	int entry_size, type;
-	int err;
+	int err, locked = 0;
+	struct inode *fd_inode;
+	atomic_long_t owner;
+	unsigned long curr = (unsigned long)current;
 
 	hfs_dbg(CAT_MOD, "rename_cat: %u - %lu,%s - %lu,%s\n",
 		cnid, src_dir->i_ino, src_name->name,
@@ -453,7 +482,17 @@ int hfsplus_rename_cat(u32 cnid,
 	 * Fail early and avoid ENOSPC during the btree operations. We may
 	 * have to split the root node at most twice.
 	 */
+	fd_inode = src_fd.tree->inode;
+	locked = mutex_trylock(&HFSPLUS_I(fd_inode)->extents_lock);
+
+	if(!locked){
+		owner = HFSPLUS_I(fd_inode)->extents_lock.owner;
+		if((unsigned long)atomic_long_cmpxchg(&owner, 0, 0) != curr)
+			return -EAGAIN;
+	}
 	err = hfs_bmap_reserve(src_fd.tree, 4 * (int)src_fd.tree->depth - 1);
+	if (locked)
+		mutex_unlock(&HFSPLUS_I(fd_inode)->extents_lock);
 	if (err)
 		goto out;
 
diff --git a/fs/hfsplus/extents.c b/fs/hfsplus/extents.c
index 3c572e44f2ad..933c4409618a 100644
--- a/fs/hfsplus/extents.c
+++ b/fs/hfsplus/extents.c
@@ -88,7 +88,10 @@ static int __hfsplus_ext_write_extent(struct inode *inode,
 		struct hfs_find_data *fd)
 {
 	struct hfsplus_inode_info *hip = HFSPLUS_I(inode);
-	int res;
+	int res, locked = 0;
+	atomic_long_t owner;
+	unsigned long curr = (unsigned long)current;
+	struct inode *fd_inode;
 
 	WARN_ON(!mutex_is_locked(&hip->extents_lock));
 
@@ -97,6 +100,15 @@ static int __hfsplus_ext_write_extent(struct inode *inode,
 				HFSPLUS_TYPE_RSRC : HFSPLUS_TYPE_DATA);
 
 	res = hfs_brec_find(fd, hfs_find_rec_by_key);
+
+	fd_inode = fd->tree->inode;
+	locked = mutex_trylock(&HFSPLUS_I(fd_inode)->extents_lock);
+
+	if(!locked){
+		owner = HFSPLUS_I(fd_inode)->extents_lock.owner;
+		if((unsigned long)atomic_long_cmpxchg(&owner, 0, 0) != curr)
+			return -EAGAIN;
+	}
 	if (hip->extent_state & HFSPLUS_EXT_NEW) {
 		if (res != -ENOENT)
 			return res;
@@ -115,6 +127,8 @@ static int __hfsplus_ext_write_extent(struct inode *inode,
 		hip->extent_state &= ~HFSPLUS_EXT_DIRTY;
 	}
 
+	if (locked)
+		mutex_unlock(&HFSPLUS_I(fd_inode)->extents_lock);
 	/*
 	 * We can't just use hfsplus_mark_inode_dirty here, because we
 	 * also get called from hfsplus_write_inode, which should not
@@ -228,36 +242,51 @@ int hfsplus_get_block(struct inode *inode, sector_t iblock,
 	struct super_block *sb = inode->i_sb;
 	struct hfsplus_sb_info *sbi = HFSPLUS_SB(sb);
 	struct hfsplus_inode_info *hip = HFSPLUS_I(inode);
+	unsigned long curr = (unsigned long)current;
 	int res = -EIO;
 	u32 ablock, dblock, mask;
+	atomic_long_t owner;
 	sector_t sector;
-	int was_dirty = 0;
+	int was_dirty = 0, locked = 0;
 
 	/* Convert inode block to disk allocation block */
 	ablock = iblock >> sbi->fs_shift;
 
+	locked = mutex_trylock(&hip->extents_lock);
+	if(!locked){
+		owner = hip->extents_lock.owner;
+		if((unsigned long)atomic_long_cmpxchg(&owner, 0, 0) != curr)
+			return -EAGAIN;
+	}
+
 	if (iblock >= hip->fs_blocks) {
-		if (!create)
-			return 0;
-		if (iblock > hip->fs_blocks)
-			return -EIO;
+		if (!create){
+			res = 0;
+			goto out;
+		}
+		if (iblock > hip->fs_blocks){
+			res = -EIO;
+			goto out;
+		}	
 		if (ablock >= hip->alloc_blocks) {
 			res = hfsplus_file_extend(inode, false);
 			if (res)
-				return res;
+				goto out;
 		}
 	} else
 		create = 0;
 
 	if (ablock < hip->first_blocks) {
 		dblock = hfsplus_ext_find_block(hip->first_extents, ablock);
+		if (locked)
+			mutex_unlock(&hip->extents_lock);
 		goto done;
 	}
 
-	if (inode->i_ino == HFSPLUS_EXT_CNID)
-		return -EIO;
-
-	mutex_lock(&hip->extents_lock);
+	if (inode->i_ino == HFSPLUS_EXT_CNID){
+		res = -EIO;
+		goto out;
+	}	
 
 	/*
 	 * hfsplus_ext_read_extent will write out a cached extent into
@@ -267,12 +296,13 @@ int hfsplus_get_block(struct inode *inode, sector_t iblock,
 	was_dirty = (hip->extent_state & HFSPLUS_EXT_DIRTY);
 	res = hfsplus_ext_read_extent(inode, ablock);
 	if (res) {
-		mutex_unlock(&hip->extents_lock);
-		return -EIO;
+		res = -EIO;
+		goto out;
 	}
 	dblock = hfsplus_ext_find_block(hip->cached_extents,
 					ablock - hip->cached_start);
-	mutex_unlock(&hip->extents_lock);
+	if (locked)
+		mutex_unlock(&hip->extents_lock);
 
 done:
 	hfs_dbg(EXTENT, "get_block(%lu): %llu - %u\n",
@@ -292,6 +322,10 @@ int hfsplus_get_block(struct inode *inode, sector_t iblock,
 	if (create || was_dirty)
 		mark_inode_dirty(inode);
 	return 0;
+out:
+	if (locked)
+		mutex_unlock(&hip->extents_lock);
+	return res;
 }
 
 static void hfsplus_dump_extent(struct hfsplus_extent *extent)
@@ -454,7 +488,6 @@ int hfsplus_file_extend(struct inode *inode, bool zeroout)
 		return -ENOSPC;
 	}
 
-	mutex_lock(&hip->extents_lock);
 	if (hip->alloc_blocks == hip->first_blocks)
 		goal = hfsplus_ext_lastblock(hip->first_extents);
 	else {
@@ -515,11 +548,9 @@ int hfsplus_file_extend(struct inode *inode, bool zeroout)
 out:
 	if (!res) {
 		hip->alloc_blocks += len;
-		mutex_unlock(&hip->extents_lock);
 		hfsplus_mark_inode_dirty(inode, HFSPLUS_I_ALLOC_DIRTY);
 		return 0;
 	}
-	mutex_unlock(&hip->extents_lock);
 	return res;
 
 insert_extent:
@@ -546,7 +577,9 @@ void hfsplus_file_truncate(struct inode *inode)
 	struct hfsplus_inode_info *hip = HFSPLUS_I(inode);
 	struct hfs_find_data fd;
 	u32 alloc_cnt, blk_cnt, start;
-	int res;
+	int res, locked = 0;
+	unsigned long curr = (unsigned long)current;
+	atomic_long_t owner;
 
 	hfs_dbg(INODE, "truncate: %lu, %llu -> %llu\n",
 		inode->i_ino, (long long)hip->phys_size, inode->i_size);
@@ -573,7 +606,12 @@ void hfsplus_file_truncate(struct inode *inode)
 	blk_cnt = (inode->i_size + HFSPLUS_SB(sb)->alloc_blksz - 1) >>
 			HFSPLUS_SB(sb)->alloc_blksz_shift;
 
-	mutex_lock(&hip->extents_lock);
+	locked = mutex_trylock(&hip->extents_lock);
+	if(!locked){
+		owner = hip->extents_lock.owner;
+		if((unsigned long)atomic_long_cmpxchg(&owner, 0, 0) != curr)
+			return;
+	}
 
 	alloc_cnt = hip->alloc_blocks;
 	if (blk_cnt == alloc_cnt)
@@ -581,7 +619,8 @@ void hfsplus_file_truncate(struct inode *inode)
 
 	res = hfs_find_init(HFSPLUS_SB(sb)->ext_tree, &fd);
 	if (res) {
-		mutex_unlock(&hip->extents_lock);
+		if (locked)
+			mutex_unlock(&hip->extents_lock);
 		/* XXX: We lack error handling of hfsplus_file_truncate() */
 		return;
 	}
@@ -619,7 +658,8 @@ void hfsplus_file_truncate(struct inode *inode)
 
 	hip->alloc_blocks = blk_cnt;
 out_unlock:
-	mutex_unlock(&hip->extents_lock);
+	if (locked)
+		mutex_unlock(&hip->extents_lock);
 	hip->phys_size = inode->i_size;
 	hip->fs_blocks = (inode->i_size + sb->s_blocksize - 1) >>
 		sb->s_blocksize_bits;
diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
index 9c9ff6b8c6f7..d3f8c0352a24 100644
--- a/fs/hfsplus/xattr.c
+++ b/fs/hfsplus/xattr.c
@@ -130,7 +130,9 @@ static int hfsplus_create_attributes_file(struct super_block *sb)
 	int index, written;
 	struct address_space *mapping;
 	struct page *page;
-	int old_state = HFSPLUS_EMPTY_ATTR_TREE;
+	atomic_long_t owner;
+	unsigned long curr = (unsigned long)current;
+	int old_state = HFSPLUS_EMPTY_ATTR_TREE, locked = 0;
 
 	hfs_dbg(ATTR_MOD, "create_attr_file: ino %d\n", HFSPLUS_ATTR_CNID);
 
@@ -181,9 +183,14 @@ static int hfsplus_create_attributes_file(struct super_block *sb)
 						    sbi->sect_count,
 						    HFSPLUS_ATTR_CNID);
 
-	mutex_lock(&hip->extents_lock);
+	locked = mutex_trylock(&hip->extents_lock);
+	if(!locked){
+		owner = hip->extents_lock.owner;
+		if((unsigned long)atomic_long_cmpxchg(&owner, 0, 0) != curr)
+			return -EAGAIN;
+	}
+
 	hip->clump_blocks = clump_size >> sbi->alloc_blksz_shift;
-	mutex_unlock(&hip->extents_lock);
 
 	if (sbi->free_blocks <= (hip->clump_blocks << 1)) {
 		err = -ENOSPC;
@@ -194,6 +201,8 @@ static int hfsplus_create_attributes_file(struct super_block *sb)
 		err = hfsplus_file_extend(attr_file, false);
 		if (unlikely(err)) {
 			pr_err("failed to extend attributes file\n");
+			if(locked)
+				mutex_unlock(&hip->extents_lock);
 			goto end_attr_file_creation;
 		}
 		hip->phys_size = attr_file->i_size =
@@ -201,6 +210,8 @@ static int hfsplus_create_attributes_file(struct super_block *sb)
 		hip->fs_blocks = hip->alloc_blocks << sbi->fs_shift;
 		inode_set_bytes(attr_file, attr_file->i_size);
 	}
+	if (locked)
+		mutex_unlock(&hip->extents_lock);
 
 	buf = kzalloc(node_size, GFP_NOFS);
 	if (!buf) {
-- 
2.34.1

