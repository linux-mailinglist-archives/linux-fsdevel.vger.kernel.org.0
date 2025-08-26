Return-Path: <linux-fsdevel+bounces-59235-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 537BEB36E0B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 17:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67BAA7C6451
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 15:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82ED43002D7;
	Tue, 26 Aug 2025 15:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="E/gwhz2V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A941E522
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 15:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222855; cv=none; b=YNHBiT7I8THk+OK3IeIk+wKpc6wtSvKd44EuuRfqWh4/vVijwz1QjVjkJSJoNmH1VXtt4IqhSfhKxtgmAwVbJxImfW/Y63Jd6jHYvhhgTgz7LyrPIPZARMPRumpv3G5WQatTQIaumUHShb8iqlahRVA+q9unOqyFufkoPLBF3nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222855; c=relaxed/simple;
	bh=iGOPmPDgb2mTrOdILoInsFEcB8BLS23F5HpFj/iWWC4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I8giiNOtqVin1x2ckqCpXhubaW7uWZx98OzqX4W0ADnhL0Oi/fSrxlJGaDNRK3enEEZgaPu9CqzP2HpF7d+O10E9wRMGLcLxUewYxm/jd2lbiJ3jBMemMhIIG7j9Rb0TjPZZPn4JJ1yZnHzt8DBpISYQwQbRMm+FWzDka3sUOdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=E/gwhz2V; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e962193d9fdso990276.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 08:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222851; x=1756827651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MHeFfKZas9nRMHvdk2OtCU7GKGPwQ5zSLc3+eFr0EUo=;
        b=E/gwhz2V6DVdsP2hun257hYfibgWTaWLwuRZkaRBid8QhnEO39I67sbe20AWfgeAbA
         +6BQSFewSLe59YsOCSsfD0Bw99wy36urpib8aEwgbOC+RYWvtphNmDKvMWgrfLvzQqf7
         pcB/+HDqze9hdnnTg5ZKVYfxvNBiWrga93bp61plyJjrvmf33Oh03ch6Uu4jcuuLvNha
         K5VdJNu0iaM7+WmRp3I3Q+w+5neh3LLUeyStqCvfzRrbDGqtMTyEo3tKgunFGFe1dChH
         TPVKusNn82MRh3UizXM1H0eaaOND9+FJGgWbmcoBre4gA/STdvj4OSQyCBfH3MUR9FtZ
         A0yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222851; x=1756827651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MHeFfKZas9nRMHvdk2OtCU7GKGPwQ5zSLc3+eFr0EUo=;
        b=QWwrn1l5fVm55cE6P0TMEJyujixESVfYbMbGrAm2JVvs7PTe/J8qbG4ttrj8ZKYADn
         stHyMmLDeMobPIq6yxGIfCeM798Q1x7EQJNEaDm3Yl/QxWA40wVbVbw7iJxLRWyqN5CN
         G7nGDBBXNMLNEDHU9ACrOBhG5CFRmqcxFM2ilRaDnKcqrosaCCpfLH1Al4urtzxyocAf
         EF6wGSm1VGb87aimdWEKrBJPi5rrQTQulbAqapW2bcL5cjKnhm2thp0W9xKJ0QhRYoXc
         RC73gDL8AMhSQGVoHe6dDXJI8P3RxJBi08NeM1GS2/oI+Ad1IbaNkTw24B5jgRfrfykY
         PMnw==
X-Gm-Message-State: AOJu0YwwGQrJtSmQrCNMrFZaxXAbCrjsmwZqrLdQXkWn1RQ6cgV0+Yce
	TaoahvyewG5yp6jbBus7xfa3JdnHhkvYWL0DuQA9lO181Q23G+OzRAx+37IH+xo57+Ob6JZyLK7
	zdjAt
X-Gm-Gg: ASbGncvrpgMcOm3Uze8GCzuUQqhwAlCvqFkDL9q0+SqCOUVL/PQlC1IlK9y/kR5pZSA
	37ItlPJXNq9vohPlew4tiV6yWJ+H3r52ODzdpWaPl0cwUb1b9A24ssWhvBbEJdpwu+SV4N3jhys
	1Gf7O4YznvjF6XikgV2ieKGx/GizKaxD7h9FdfeLdV0z+bG7DXvRxrhe9/9A/D0AdWgvgayNRCO
	mmWctJdT9fOe2haYAoiWtY6Tag6sWAa+rNlsFZ0EFE4P5c0/UK2ptUHZ0/BgkjROJvwVVhS1UtJ
	22/Vttsv2CYTZrXVZJL3YpUO+EFanrj64AoDXxloptTim5YvpdYF4Xrq8lEzKZ5zHLt6of9X7we
	J0L3O4rGmc/EX8LZpLbrSWeoqHbiYD265azVDhnfPtUaVhhaQ2I4rAtJ3glM1JS7l1vxW2w==
X-Google-Smtp-Source: AGHT+IHbt9utYUFnm1dwkd7+o8dc/UvBZifk8XYav5VgwrlhQqhjicgfzTJlktKYiICmcSDfgPFLgw==
X-Received: by 2002:a05:6902:150a:b0:e90:526a:ac44 with SMTP id 3f1490d57ef6-e96e47927c9mr1893656276.21.1756222850984;
        Tue, 26 Aug 2025 08:40:50 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e96e7caa0c4sm281894276.37.2025.08.26.08.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:40:50 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 02/54] fs: add an icount_read helper
Date: Tue, 26 Aug 2025 11:39:02 -0400
Message-ID: <9bc62a84c6b9d6337781203f60837bd98fbc4a96.1756222464.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1756222464.git.josef@toxicpanda.com>
References: <cover.1756222464.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of doing direct access to ->i_count, add a helper to handle
this. This will make it easier to convert i_count to a refcount later.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 arch/powerpc/platforms/cell/spufs/file.c | 2 +-
 fs/btrfs/inode.c                         | 2 +-
 fs/ceph/mds_client.c                     | 2 +-
 fs/ext4/ialloc.c                         | 4 ++--
 fs/fs-writeback.c                        | 2 +-
 fs/hpfs/inode.c                          | 2 +-
 fs/inode.c                               | 8 ++++----
 fs/nfs/inode.c                           | 4 ++--
 fs/notify/fsnotify.c                     | 2 +-
 fs/smb/client/inode.c                    | 2 +-
 fs/ubifs/super.c                         | 2 +-
 fs/xfs/xfs_inode.c                       | 2 +-
 fs/xfs/xfs_trace.h                       | 2 +-
 include/linux/fs.h                       | 5 +++++
 include/trace/events/filelock.h          | 2 +-
 security/landlock/fs.c                   | 2 +-
 16 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/file.c b/arch/powerpc/platforms/cell/spufs/file.c
index d5a2c77bc908..ce839783c0df 100644
--- a/arch/powerpc/platforms/cell/spufs/file.c
+++ b/arch/powerpc/platforms/cell/spufs/file.c
@@ -1430,7 +1430,7 @@ static int spufs_mfc_open(struct inode *inode, struct file *file)
 	if (ctx->owner != current->mm)
 		return -EINVAL;
 
-	if (atomic_read(&inode->i_count) != 1)
+	if (icount_read(inode) != 1)
 		return -EBUSY;
 
 	mutex_lock(&ctx->mapping_lock);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 784bd48b4da9..ac00554e8479 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4557,7 +4557,7 @@ static void btrfs_prune_dentries(struct btrfs_root *root)
 
 	inode = btrfs_find_first_inode(root, min_ino);
 	while (inode) {
-		if (atomic_read(&inode->vfs_inode.i_count) > 1)
+		if (icount_read(&inode->vfs_inode) > 1)
 			d_prune_aliases(&inode->vfs_inode);
 
 		min_ino = btrfs_ino(inode) + 1;
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 0f497c39ff82..62dba710504d 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2221,7 +2221,7 @@ static int trim_caps_cb(struct inode *inode, int mds, void *arg)
 			int count;
 			dput(dentry);
 			d_prune_aliases(inode);
-			count = atomic_read(&inode->i_count);
+			count = icount_read(inode);
 			if (count == 1)
 				(*remaining)--;
 			doutc(cl, "%p %llx.%llx cap %p pruned, count now %d\n",
diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index df4051613b29..ba4fd9aba1c1 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -252,10 +252,10 @@ void ext4_free_inode(handle_t *handle, struct inode *inode)
 		       "nonexistent device\n", __func__, __LINE__);
 		return;
 	}
-	if (atomic_read(&inode->i_count) > 1) {
+	if (icount_read(inode) > 1) {
 		ext4_msg(sb, KERN_ERR, "%s:%d: inode #%lu: count=%d",
 			 __func__, __LINE__, inode->i_ino,
-			 atomic_read(&inode->i_count));
+			 icount_read(inode));
 		return;
 	}
 	if (inode->i_nlink) {
diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index a6cc3d305b84..b6768ef3daa6 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1767,7 +1767,7 @@ static int writeback_single_inode(struct inode *inode,
 	int ret = 0;
 
 	spin_lock(&inode->i_lock);
-	if (!atomic_read(&inode->i_count))
+	if (!icount_read(inode))
 		WARN_ON(!(inode->i_state & (I_WILL_FREE|I_FREEING)));
 	else
 		WARN_ON(inode->i_state & I_WILL_FREE);
diff --git a/fs/hpfs/inode.c b/fs/hpfs/inode.c
index a59e8fa630db..34008442ee26 100644
--- a/fs/hpfs/inode.c
+++ b/fs/hpfs/inode.c
@@ -184,7 +184,7 @@ void hpfs_write_inode(struct inode *i)
 	struct hpfs_inode_info *hpfs_inode = hpfs_i(i);
 	struct inode *parent;
 	if (i->i_ino == hpfs_sb(i->i_sb)->sb_root) return;
-	if (hpfs_inode->i_rddir_off && !atomic_read(&i->i_count)) {
+	if (hpfs_inode->i_rddir_off && !icount_read(i)) {
 		if (*hpfs_inode->i_rddir_off)
 			pr_err("write_inode: some position still there\n");
 		kfree(hpfs_inode->i_rddir_off);
diff --git a/fs/inode.c b/fs/inode.c
index cc0f717a140d..a3673e1ed157 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -534,7 +534,7 @@ static void __inode_add_lru(struct inode *inode, bool rotate)
 {
 	if (inode->i_state & (I_DIRTY_ALL | I_SYNC | I_FREEING | I_WILL_FREE))
 		return;
-	if (atomic_read(&inode->i_count))
+	if (icount_read(inode))
 		return;
 	if (!(inode->i_sb->s_flags & SB_ACTIVE))
 		return;
@@ -871,11 +871,11 @@ void evict_inodes(struct super_block *sb)
 again:
 	spin_lock(&sb->s_inode_list_lock);
 	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
-		if (atomic_read(&inode->i_count))
+		if (icount_read(inode))
 			continue;
 
 		spin_lock(&inode->i_lock);
-		if (atomic_read(&inode->i_count)) {
+		if (icount_read(inode)) {
 			spin_unlock(&inode->i_lock);
 			continue;
 		}
@@ -937,7 +937,7 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
 	 * unreclaimable for a while. Remove them lazily here; iput,
 	 * sync, or the last page cache deletion will requeue them.
 	 */
-	if (atomic_read(&inode->i_count) ||
+	if (icount_read(inode) ||
 	    (inode->i_state & ~I_REFERENCED) ||
 	    !mapping_shrinkable(&inode->i_data)) {
 		list_lru_isolate(lru, &inode->i_lru);
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 338ef77ae423..b52805951856 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -608,7 +608,7 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, struct nfs_fattr *fattr)
 		inode->i_sb->s_id,
 		(unsigned long long)NFS_FILEID(inode),
 		nfs_display_fhandle_hash(fh),
-		atomic_read(&inode->i_count));
+		icount_read(inode));
 
 out:
 	return inode;
@@ -2229,7 +2229,7 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 	dfprintk(VFS, "NFS: %s(%s/%lu fh_crc=0x%08x ct=%d info=0x%llx)\n",
 			__func__, inode->i_sb->s_id, inode->i_ino,
 			nfs_display_fhandle_hash(NFS_FH(inode)),
-			atomic_read(&inode->i_count), fattr->valid);
+			icount_read(inode), fattr->valid);
 
 	if (!(fattr->valid & NFS_ATTR_FATTR_FILEID)) {
 		/* Only a mounted-on-fileid? Just exit */
diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 079b868552c2..46bfc543f946 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -66,7 +66,7 @@ static void fsnotify_unmount_inodes(struct super_block *sb)
 		 * removed all zero refcount inodes, in any case.  Test to
 		 * be sure.
 		 */
-		if (!atomic_read(&inode->i_count)) {
+		if (!icount_read(inode)) {
 			spin_unlock(&inode->i_lock);
 			continue;
 		}
diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index fe453a4b3dc8..515b82540840 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -2779,7 +2779,7 @@ int cifs_revalidate_dentry_attr(struct dentry *dentry)
 	}
 
 	cifs_dbg(FYI, "Update attributes: %s inode 0x%p count %d dentry: 0x%p d_time %ld jiffies %ld\n",
-		 full_path, inode, inode->i_count.counter,
+		 full_path, inode, icount_read(inode),
 		 dentry, cifs_get_time(dentry), jiffies);
 
 again:
diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index f3e3b2068608..a0269ba96e3d 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -358,7 +358,7 @@ static void ubifs_evict_inode(struct inode *inode)
 		goto out;
 
 	dbg_gen("inode %lu, mode %#x", inode->i_ino, (int)inode->i_mode);
-	ubifs_assert(c, !atomic_read(&inode->i_count));
+	ubifs_assert(c, !icount_read(inode));
 
 	truncate_inode_pages_final(&inode->i_data);
 
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 9c39251961a3..df8eab11dc48 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -1035,7 +1035,7 @@ xfs_itruncate_extents_flags(
 	int			error = 0;
 
 	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL);
-	if (atomic_read(&VFS_I(ip)->i_count))
+	if (icount_read(VFS_I(ip)))
 		xfs_assert_ilocked(ip, XFS_IOLOCK_EXCL);
 	ASSERT(new_size <= XFS_ISIZE(ip));
 	ASSERT(tp->t_flags & XFS_TRANS_PERM_LOG_RES);
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index ac344e42846c..79b8641880ab 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -1152,7 +1152,7 @@ DECLARE_EVENT_CLASS(xfs_iref_class,
 	TP_fast_assign(
 		__entry->dev = VFS_I(ip)->i_sb->s_dev;
 		__entry->ino = ip->i_ino;
-		__entry->count = atomic_read(&VFS_I(ip)->i_count);
+		__entry->count = icount_read(VFS_I(ip));
 		__entry->pincount = atomic_read(&ip->i_pincount);
 		__entry->iflags = ip->i_flags;
 		__entry->caller_ip = caller_ip;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3dbaf1ca1828..56041d3387fe 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3372,6 +3372,11 @@ static inline void __iget(struct inode *inode)
 	atomic_inc(&inode->i_count);
 }
 
+static inline int icount_read(const struct inode *inode)
+{
+	return atomic_read(&inode->i_count);
+}
+
 extern void iget_failed(struct inode *);
 extern void clear_inode(struct inode *);
 extern void __destroy_inode(struct inode *);
diff --git a/include/trace/events/filelock.h b/include/trace/events/filelock.h
index b8d1e00a7982..fdd36b1daa25 100644
--- a/include/trace/events/filelock.h
+++ b/include/trace/events/filelock.h
@@ -189,7 +189,7 @@ TRACE_EVENT(generic_add_lease,
 		__entry->i_ino = inode->i_ino;
 		__entry->wcount = atomic_read(&inode->i_writecount);
 		__entry->rcount = atomic_read(&inode->i_readcount);
-		__entry->icount = atomic_read(&inode->i_count);
+		__entry->icount = icount_read(inode);
 		__entry->owner = fl->c.flc_owner;
 		__entry->flags = fl->c.flc_flags;
 		__entry->type = fl->c.flc_type;
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index c04f8879ad03..0bade2c5aa1d 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1281,7 +1281,7 @@ static void hook_sb_delete(struct super_block *const sb)
 		struct landlock_object *object;
 
 		/* Only handles referenced inodes. */
-		if (!atomic_read(&inode->i_count))
+		if (!icount_read(inode))
 			continue;
 
 		/*
-- 
2.49.0


