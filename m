Return-Path: <linux-fsdevel+bounces-16987-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B881D8A5E8F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 01:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C20D31C20A2B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 23:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45FB15920B;
	Mon, 15 Apr 2024 23:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iyoGrGff"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C338156967;
	Mon, 15 Apr 2024 23:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713224496; cv=none; b=NlLhPp1WG8dFIQVVoL8jEIPmL6cMySa0QT/s0Hv8nK01JnaNlzlhotYIlSs1FZptmiPpChnhxZLBTvlqDTtryidmZUPIv8rvAfViG7b9aQ83Oc1fGVNID7uD9fdXY4neaRhJz/kbPDNC3YqxsW4QP+ipJMf/Ec1gndBG1Rc5XlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713224496; c=relaxed/simple;
	bh=8q/WYrS3q+KgyCc6pI0qNt+2kb/MvFJVesJGcEUy81c=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gVcBPp8FGMStODuj2Bi/vwfokrleR3zEeZauYBJvW0yF/4/iUyn0yd/scNcs6TyHQk02qZxq8psRWXtywlw/Gbgmyyo+eCZK/tJ4FeWKaifhQj8oLiOmHhHgFf2abt1M4Iz355dAARGa3r7zSYZsF/0c7uREz4fFh311sqaZM9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iyoGrGff; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3BD4C113CC;
	Mon, 15 Apr 2024 23:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713224495;
	bh=8q/WYrS3q+KgyCc6pI0qNt+2kb/MvFJVesJGcEUy81c=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=iyoGrGffUZM5YP3aCTMXXjxBBK7jVaFc0H8V0/T2Z/sYKnG0mx4rs+mIJlq2ZnncC
	 sC5/D6c4MZoqpRWwpkru0CP/eE7Dg03XeEn2z+HDymgx0KRxIcztg3gM70x9ylFeoY
	 GEhC1PgydwlZmSdjgK+n/euYjZazKGSfz7Ce3lcrrM58+bZuOuM5lUOVm/3rGIhxGD
	 AeoNLbFZGvt2Lzbz5iEUkAYL4959hmYiZ8CA3S9/9cso2wH7YtzeP7yzPupzyDo+Wr
	 CespKVJVNf+FUKQ+0SwFpt+ryOVA2dW57/niMoQL6BAzeQSILabc/RHXJ8cofTBwpL
	 WB/NzgiYJkA/w==
Date: Mon, 15 Apr 2024 16:41:35 -0700
Subject: [PATCH 03/15] xfs: create a incompat flag for atomic file mapping
 exchanges
From: "Darrick J. Wong" <djwong@kernel.org>
To: chandanbabu@kernel.org, djwong@kernel.org
Cc: Christoph Hellwig <hch@lst.de>, hch@lst.de, linux-fsdevel@vger.kernel.org,
 linux-xfs@vger.kernel.org
Message-ID: <171322381271.87355.13088068131447551795.stgit@frogsfrogsfrogs>
In-Reply-To: <171322381182.87355.15534989930482135103.stgit@frogsfrogsfrogs>
References: <171322381182.87355.15534989930482135103.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Create a incompat flag so that we only attempt to process file mapping
exchange log items if the filesystem supports it, and a geometry flag to
advertise support if it's present.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/libxfs/xfs_format.h |   23 ++++++++++++-----------
 fs/xfs/libxfs/xfs_fs.h     |    1 +
 fs/xfs/libxfs/xfs_sb.c     |    5 +++++
 fs/xfs/xfs_mount.h         |    2 ++
 fs/xfs/xfs_super.c         |    4 ++++
 5 files changed, 24 insertions(+), 11 deletions(-)


diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
index 2b2f9050fbfb..ff1e28316e1b 100644
--- a/fs/xfs/libxfs/xfs_format.h
+++ b/fs/xfs/libxfs/xfs_format.h
@@ -367,18 +367,19 @@ xfs_sb_has_ro_compat_feature(
 	return (sbp->sb_features_ro_compat & feature) != 0;
 }
 
-#define XFS_SB_FEAT_INCOMPAT_FTYPE	(1 << 0)	/* filetype in dirent */
-#define XFS_SB_FEAT_INCOMPAT_SPINODES	(1 << 1)	/* sparse inode chunks */
-#define XFS_SB_FEAT_INCOMPAT_META_UUID	(1 << 2)	/* metadata UUID */
-#define XFS_SB_FEAT_INCOMPAT_BIGTIME	(1 << 3)	/* large timestamps */
-#define XFS_SB_FEAT_INCOMPAT_NEEDSREPAIR (1 << 4)	/* needs xfs_repair */
-#define XFS_SB_FEAT_INCOMPAT_NREXT64	(1 << 5)	/* large extent counters */
+#define XFS_SB_FEAT_INCOMPAT_FTYPE	(1 << 0)  /* filetype in dirent */
+#define XFS_SB_FEAT_INCOMPAT_SPINODES	(1 << 1)  /* sparse inode chunks */
+#define XFS_SB_FEAT_INCOMPAT_META_UUID	(1 << 2)  /* metadata UUID */
+#define XFS_SB_FEAT_INCOMPAT_BIGTIME	(1 << 3)  /* large timestamps */
+#define XFS_SB_FEAT_INCOMPAT_NEEDSREPAIR (1 << 4) /* needs xfs_repair */
+#define XFS_SB_FEAT_INCOMPAT_NREXT64	(1 << 5)  /* large extent counters */
+#define XFS_SB_FEAT_INCOMPAT_EXCHRANGE	(1 << 6)  /* exchangerange supported */
 #define XFS_SB_FEAT_INCOMPAT_ALL \
-		(XFS_SB_FEAT_INCOMPAT_FTYPE|	\
-		 XFS_SB_FEAT_INCOMPAT_SPINODES|	\
-		 XFS_SB_FEAT_INCOMPAT_META_UUID| \
-		 XFS_SB_FEAT_INCOMPAT_BIGTIME| \
-		 XFS_SB_FEAT_INCOMPAT_NEEDSREPAIR| \
+		(XFS_SB_FEAT_INCOMPAT_FTYPE | \
+		 XFS_SB_FEAT_INCOMPAT_SPINODES | \
+		 XFS_SB_FEAT_INCOMPAT_META_UUID | \
+		 XFS_SB_FEAT_INCOMPAT_BIGTIME | \
+		 XFS_SB_FEAT_INCOMPAT_NEEDSREPAIR | \
 		 XFS_SB_FEAT_INCOMPAT_NREXT64)
 
 #define XFS_SB_FEAT_INCOMPAT_UNKNOWN	~XFS_SB_FEAT_INCOMPAT_ALL
diff --git a/fs/xfs/libxfs/xfs_fs.h b/fs/xfs/libxfs/xfs_fs.h
index 8a1e30cf4dc8..53526fca7386 100644
--- a/fs/xfs/libxfs/xfs_fs.h
+++ b/fs/xfs/libxfs/xfs_fs.h
@@ -239,6 +239,7 @@ typedef struct xfs_fsop_resblks {
 #define XFS_FSOP_GEOM_FLAGS_BIGTIME	(1 << 21) /* 64-bit nsec timestamps */
 #define XFS_FSOP_GEOM_FLAGS_INOBTCNT	(1 << 22) /* inobt btree counter */
 #define XFS_FSOP_GEOM_FLAGS_NREXT64	(1 << 23) /* large extent counters */
+#define XFS_FSOP_GEOM_FLAGS_EXCHANGE_RANGE (1 << 24) /* exchange range */
 
 /*
  * Minimum and maximum sizes need for growth checks.
diff --git a/fs/xfs/libxfs/xfs_sb.c b/fs/xfs/libxfs/xfs_sb.c
index 73a4b895de67..c350e259b685 100644
--- a/fs/xfs/libxfs/xfs_sb.c
+++ b/fs/xfs/libxfs/xfs_sb.c
@@ -26,6 +26,7 @@
 #include "xfs_health.h"
 #include "xfs_ag.h"
 #include "xfs_rtbitmap.h"
+#include "xfs_exchrange.h"
 
 /*
  * Physical superblock buffer manipulations. Shared with libxfs in userspace.
@@ -175,6 +176,8 @@ xfs_sb_version_to_features(
 		features |= XFS_FEAT_NEEDSREPAIR;
 	if (sbp->sb_features_incompat & XFS_SB_FEAT_INCOMPAT_NREXT64)
 		features |= XFS_FEAT_NREXT64;
+	if (sbp->sb_features_incompat & XFS_SB_FEAT_INCOMPAT_EXCHRANGE)
+		features |= XFS_FEAT_EXCHANGE_RANGE;
 
 	return features;
 }
@@ -1259,6 +1262,8 @@ xfs_fs_geometry(
 	}
 	if (xfs_has_large_extent_counts(mp))
 		geo->flags |= XFS_FSOP_GEOM_FLAGS_NREXT64;
+	if (xfs_has_exchange_range(mp))
+		geo->flags |= XFS_FSOP_GEOM_FLAGS_EXCHANGE_RANGE;
 	geo->rtsectsize = sbp->sb_blocksize;
 	geo->dirblocksize = xfs_dir2_dirblock_bytes(sbp);
 
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index 6ec038b88454..b022e5120dc4 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -292,6 +292,7 @@ typedef struct xfs_mount {
 #define XFS_FEAT_BIGTIME	(1ULL << 24)	/* large timestamps */
 #define XFS_FEAT_NEEDSREPAIR	(1ULL << 25)	/* needs xfs_repair */
 #define XFS_FEAT_NREXT64	(1ULL << 26)	/* large extent counters */
+#define XFS_FEAT_EXCHANGE_RANGE	(1ULL << 27)	/* exchange range */
 
 /* Mount features */
 #define XFS_FEAT_NOATTR2	(1ULL << 48)	/* disable attr2 creation */
@@ -355,6 +356,7 @@ __XFS_HAS_FEAT(inobtcounts, INOBTCNT)
 __XFS_HAS_FEAT(bigtime, BIGTIME)
 __XFS_HAS_FEAT(needsrepair, NEEDSREPAIR)
 __XFS_HAS_FEAT(large_extent_counts, NREXT64)
+__XFS_HAS_FEAT(exchange_range, EXCHANGE_RANGE)
 
 /*
  * Mount features
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index bce020374c5e..dbda72df3419 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1727,6 +1727,10 @@ xfs_fs_fill_super(
 		goto out_filestream_unmount;
 	}
 
+	if (xfs_has_exchange_range(mp))
+		xfs_warn(mp,
+	"EXPERIMENTAL exchange-range feature enabled. Use at your own risk!");
+
 	error = xfs_mountfs(mp);
 	if (error)
 		goto out_filestream_unmount;


