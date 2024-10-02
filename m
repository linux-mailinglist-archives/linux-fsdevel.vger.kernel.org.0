Return-Path: <linux-fsdevel+bounces-30635-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB65E98CAEC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 03:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E377286146
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 01:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73A411187;
	Wed,  2 Oct 2024 01:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="C2QKZDwO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D5D79D0
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Oct 2024 01:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727833228; cv=none; b=c/RJn34RQvEwkfH4Q/qwWipFQMbfQPJWtzzQ8kFGvk7JmNp5DItBymCi+KK/9/KXMSmqirhhoTxSpwbTQqXFqjhS1b4temQtSn8VysFFkkEzXcSv3QLKRo1SOKRim8wsf/u7ZfmnQJmo9EdWqUODW8JR3EgJ2HO8dkl/Uat//Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727833228; c=relaxed/simple;
	bh=bpHYf/Ad8ZsA0mRcGw7Z3I00cIH6+OQCTVVfVhvX/+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iPYoHloxnArS4tZYFoXobQsUea4x2Sj0QLcJTrLTlWc4D5jzTAiFgxjkSYRxHiO6bA2m3jDduVJ0wN01w6aT1vG/qvgMWIgT6TKyeJrUAx+2TfY7JVA+/rp6STbsCZ4gKQ6EbakHwlzXtfWKkRH/3L0fiHCaAiWmQNG6m6TY6U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=C2QKZDwO; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20b90984971so28432505ad.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Oct 2024 18:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1727833225; x=1728438025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j2KUInWGphvxBKuc1DE8mW4DxZdaRvJhqE8Ppwgsdrk=;
        b=C2QKZDwOu+o06vyjqdvR17lD6yc7uD1ohVskO15G7t/7Iv4PkpeCd4pt3eqAuQ4k5O
         G6GtKMskGNFlaEWimF5zCzdjhL1AUo/ZN5pnkyAtX6s0APSggtzaWHyRrQXPPaI/0fZS
         EiL+PA0Z8sthoQFzLiCUYAkfUgJOAW6uxCW7bmGmv0xERl8l69YF+jX4Zc1bZY76kFHB
         gjQXtK8bBzXys0py4gMnDUTWrPpXrbbzQL+QT7bOmP4Zg8uiOKkGOrfLozB6ermMylVU
         NvtLI7FB0asN3KQN/JMF20MivdYYD8uq7Hn4menLMO4hdLyGmnH/hlsRip0A1bN8jWEX
         77Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727833225; x=1728438025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j2KUInWGphvxBKuc1DE8mW4DxZdaRvJhqE8Ppwgsdrk=;
        b=hFlbd5Jg/mmJ1P/iO39QA2yHYs+tev0cNWBioAn8YFGzqI97hx/UQRb7DpZDUC9qHK
         sk8rTCoa8IXgVGUecq8bcSlz7LvVnaguhudAX7HENx+FVMNqpBP9qeYlRWg6cPvdd42F
         Z+GjN36EF1pOIhf0QG3cIe6FVM7bz0kga5OK/P/HEb3/4WyUA4KoJgOMLIoVodcxbbUU
         qXe56Dce8uELqtu0IYR9D08sAkCsYxxUp8TaOtPfSbXA/dlzGzVJD2NClo1T08zuh5Kr
         +geEHTrruZ8kdu/sQpSeMppnAMjoBHEZQaiuCTvKzVhU60Br4DgvXiNiH6wcfbcXoJD/
         e++w==
X-Gm-Message-State: AOJu0YxsSnETVPpwLYdJOv7rjth12xHznUtt488kzYS6fCNh0UGngjFC
	sOUKPWuMkeTJd+0sc4DBOMt55iq/qA3AM8uoSnUThnLG0hjM1Ws7/JcSpwH8vDhope23JflpOYd
	M
X-Google-Smtp-Source: AGHT+IHbPXlGNlNBNCwkCtbLzpCwjr2fEuu8pNhpcjZTuOCY+/oRjkGhWGKft7Fxs8iSyiQkUNBAEQ==
X-Received: by 2002:a17:90b:1811:b0:2d8:8c95:ebb6 with SMTP id 98e67ed59e1d1-2e18480148dmr2230415a91.19.1727833224689;
        Tue, 01 Oct 2024 18:40:24 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-78-197.pa.nsw.optusnet.com.au. [49.179.78.197])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e18f93798bsm329604a91.53.2024.10.01.18.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 18:40:22 -0700 (PDT)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.96)
	(envelope-from <dave@fromorbit.com>)
	id 1svoLj-00Ck8m-0n;
	Wed, 02 Oct 2024 11:40:19 +1000
Received: from dave by devoid.disaster.area with local (Exim 4.98)
	(envelope-from <dave@devoid.disaster.area>)
	id 1svoLj-0000000FxGa-2nwW;
	Wed, 02 Oct 2024 11:40:19 +1000
From: Dave Chinner <david@fromorbit.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	linux-bcachefs@vger.kernel.org,
	kent.overstreet@linux.dev,
	torvalds@linux-foundation.org
Subject: [PATCH 6/7] xfs: implement sb->iter_vfs_inodes
Date: Wed,  2 Oct 2024 11:33:23 +1000
Message-ID: <20241002014017.3801899-7-david@fromorbit.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241002014017.3801899-1-david@fromorbit.com>
References: <20241002014017.3801899-1-david@fromorbit.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Chinner <dchinner@redhat.com>

We can iterate all the in-memory VFS inodes via the xfs_icwalk()
interface, so implement the new superblock operation to walk inodes
in this way.

This removes the dependency XFS has on the sb->s_inodes list and
allows us to avoid the global lock that marshalls this list and
must be taken on every VFS inode instantiation and eviction. This
greatly improves the rate at which we can stream inodes through the
VFS inode cache.

Sharded, share-nothing cold cache workload with 100,000 files per
thread in per-thread directories.

Before:

Filesystem      Files  Threads  Create       Walk      Chmod      Unlink     Bulkstat
       xfs     400000     4      4.269      3.225      4.557      7.316      1.306
       xfs     800000     8      4.844      3.227      4.702      7.905      1.908
       xfs    1600000    16      6.286      3.296      5.592      8.838      4.392
       xfs    3200000    32      8.912      5.681      8.505     11.724      7.085
       xfs    6400000    64     15.344     11.144     14.162     18.604     15.494

After:

Filesystem      Files  Threads  Create       Walk      Chmod      Unlink     Bulkstat
       xfs     400000     4      4.140      3.502      4.154      7.242      1.164
       xfs     800000     8      4.637      2.836      4.444      7.896      1.093
       xfs    1600000    16      5.549      3.054      5.213      8.696      1.107
       xfs    3200000    32      8.387      3.218      6.867     10.668      1.125
       xfs    6400000    64     14.112      3.953     10.365     18.620      1.270

Bulkstat shows the real story here - before we start to see
scalability problems at 16 threads. Patched shows almost perfect
scalability up to 64 threads streaming inodes through the VFS cache
using I_DONTCACHE semantics.

Note: this is an initial, unoptimised implementation that could be
significantly improved and reduced in size by using a radix tree tag
filter for VFS inodes and so use the generic tag-filtered
xfs_icwalk() implementation instead of special casing it like this
patch does.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 fs/xfs/xfs_icache.c | 151 +++++++++++++++++++++++++++++++++++++++++++-
 fs/xfs/xfs_icache.h |   3 +
 fs/xfs/xfs_iops.c   |   1 -
 fs/xfs/xfs_super.c  |  11 ++++
 4 files changed, 163 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index a680e5b82672..ee544556cee7 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -1614,6 +1614,155 @@ xfs_blockgc_free_quota(
 			xfs_inode_dquot(ip, XFS_DQTYPE_PROJ), iwalk_flags);
 }
 
+/* VFS Inode Cache Walking Code */
+
+/* XFS inodes in these states are not visible to the VFS. */
+#define XFS_ITER_VFS_NOGRAB_IFLAGS	(XFS_INEW | \
+					 XFS_NEED_INACTIVE | \
+					 XFS_INACTIVATING | \
+					 XFS_IRECLAIMABLE | \
+					 XFS_IRECLAIM)
+/*
+ * If the inode we found is visible to the VFS inode cache, then return it to
+ * the caller.
+ *
+ * In the normal case, we need to validate the VFS inode state and take a
+ * reference to it here. We will drop that reference once the VFS inode has been
+ * processed by the ino_iter_fn.
+ *
+ * However, if the INO_ITER_UNSAFE flag is set, we do not take references to the
+ * inode - it is the ino_iter_fn's responsibility to validate the inode is still
+ * a VFS inode once we hand it to them. We do not drop references after
+ * processing these inodes; the processing function may have evicted the VFS
+ * inode from cache as part of it's processing.
+ */
+static bool
+xfs_iter_vfs_igrab(
+	struct xfs_inode	*ip,
+	int			flags)
+{
+	struct inode		*inode = VFS_I(ip);
+	bool			ret = false;
+
+	ASSERT(rcu_read_lock_held());
+
+	/* Check for stale RCU freed inode */
+	spin_lock(&ip->i_flags_lock);
+	if (!ip->i_ino)
+		goto out_unlock_noent;
+
+	if (ip->i_flags & XFS_ITER_VFS_NOGRAB_IFLAGS)
+		goto out_unlock_noent;
+
+	if ((flags & INO_ITER_UNSAFE) ||
+	    super_iter_iget(inode, flags))
+		ret = true;
+
+out_unlock_noent:
+	spin_unlock(&ip->i_flags_lock);
+	return ret;
+}
+
+/*
+ * Initial implementation of vfs inode walker. This does not use batched lookups
+ * for initial simplicity and testing, though it could use them quite
+ * efficiently for both safe and unsafe iteration contexts.
+ */
+static int
+xfs_icwalk_vfs_inodes_ag(
+	struct xfs_perag	*pag,
+	ino_iter_fn		iter_fn,
+	void			*private_data,
+	int			flags)
+{
+	struct xfs_mount	*mp = pag->pag_mount;
+	uint32_t		first_index = 0;
+	int			ret = 0;
+	int			nr_found;
+	bool			done = false;
+
+	do {
+		struct xfs_inode *ip;
+
+		rcu_read_lock();
+		nr_found = radix_tree_gang_lookup(&pag->pag_ici_root,
+				(void **)&ip, first_index, 1);
+		if (!nr_found) {
+			rcu_read_unlock();
+			break;
+		}
+
+		/*
+		 * Update the index for the next lookup. Catch
+		 * overflows into the next AG range which can occur if
+		 * we have inodes in the last block of the AG and we
+		 * are currently pointing to the last inode.
+		 */
+		first_index = XFS_INO_TO_AGINO(mp, ip->i_ino + 1);
+		if (first_index < XFS_INO_TO_AGINO(mp, ip->i_ino))
+			done = true;
+
+		if (!xfs_iter_vfs_igrab(ip, flags)) {
+			rcu_read_unlock();
+			continue;
+		}
+
+		/*
+		 * If we are doing an unsafe iteration, we must continue to hold
+		 * the RCU lock across the callback to guarantee the existence
+		 * of inode. We can't hold the rcu lock for reference counted
+		 * inodes because the callback is allowed to block in that case.
+		 */
+		if (!(flags & INO_ITER_UNSAFE))
+			rcu_read_unlock();
+
+		ret = iter_fn(VFS_I(ip), private_data);
+
+		/*
+		 * We've run the callback, so we can drop the existence
+		 * guarantee we hold on the inode now.
+		 */
+		if (!(flags & INO_ITER_UNSAFE))
+			iput(VFS_I(ip));
+		else
+			rcu_read_unlock();
+
+		if (ret == INO_ITER_ABORT) {
+			ret = 0;
+			break;
+		}
+		if (ret < 0)
+			break;
+
+	} while (!done);
+
+	return ret;
+}
+
+int
+xfs_icwalk_vfs_inodes(
+	struct xfs_mount	*mp,
+	ino_iter_fn		iter_fn,
+	void			*private_data,
+	int			flags)
+{
+	struct xfs_perag	*pag;
+	xfs_agnumber_t		agno;
+	int			ret;
+
+	for_each_perag(mp, agno, pag) {
+		ret = xfs_icwalk_vfs_inodes_ag(pag, iter_fn,
+				private_data, flags);
+		if (ret == INO_ITER_ABORT) {
+			ret = 0;
+			break;
+		}
+		if (ret < 0)
+			break;
+	}
+	return ret;
+}
+
 /* XFS Inode Cache Walking Code */
 
 /*
@@ -1624,7 +1773,6 @@ xfs_blockgc_free_quota(
  */
 #define XFS_LOOKUP_BATCH	32
 
-
 /*
  * Decide if we want to grab this inode in anticipation of doing work towards
  * the goal.
@@ -1700,7 +1848,6 @@ xfs_icwalk_ag(
 		int		i;
 
 		rcu_read_lock();
-
 		nr_found = radix_tree_gang_lookup_tag(&pag->pag_ici_root,
 				(void **) batch, first_index,
 				XFS_LOOKUP_BATCH, goal);
diff --git a/fs/xfs/xfs_icache.h b/fs/xfs/xfs_icache.h
index 905944dafbe5..c2754ea28a88 100644
--- a/fs/xfs/xfs_icache.h
+++ b/fs/xfs/xfs_icache.h
@@ -18,6 +18,9 @@ struct xfs_icwalk {
 	long		icw_scan_limit;
 };
 
+int xfs_icwalk_vfs_inodes(struct xfs_mount *mp, ino_iter_fn iter_fn,
+		void *private_data, int flags);
+
 /* Flags that reflect xfs_fs_eofblocks functionality. */
 #define XFS_ICWALK_FLAG_SYNC		(1U << 0) /* sync/wait mode scan */
 #define XFS_ICWALK_FLAG_UID		(1U << 1) /* filter by uid */
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index ee79cf161312..5375c17ed69c 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -1293,7 +1293,6 @@ xfs_setup_inode(
 	inode->i_ino = ip->i_ino;
 	inode->i_state |= I_NEW;
 
-	inode_sb_list_add(inode);
 	/* make the inode look hashed for the writeback code */
 	inode_fake_hash(inode);
 
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index fbb3a1594c0d..a2ef1b582066 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1179,6 +1179,16 @@ xfs_fs_shutdown(
 	xfs_force_shutdown(XFS_M(sb), SHUTDOWN_DEVICE_REMOVED);
 }
 
+static int
+xfs_fs_iter_vfs_inodes(
+	struct super_block	*sb,
+	ino_iter_fn		iter_fn,
+	void			*private_data,
+	int			flags)
+{
+	return xfs_icwalk_vfs_inodes(XFS_M(sb), iter_fn, private_data, flags);
+}
+
 static const struct super_operations xfs_super_operations = {
 	.alloc_inode		= xfs_fs_alloc_inode,
 	.destroy_inode		= xfs_fs_destroy_inode,
@@ -1193,6 +1203,7 @@ static const struct super_operations xfs_super_operations = {
 	.nr_cached_objects	= xfs_fs_nr_cached_objects,
 	.free_cached_objects	= xfs_fs_free_cached_objects,
 	.shutdown		= xfs_fs_shutdown,
+	.iter_vfs_inodes	= xfs_fs_iter_vfs_inodes,
 };
 
 static int
-- 
2.45.2


