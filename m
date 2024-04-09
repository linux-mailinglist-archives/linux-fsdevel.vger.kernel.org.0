Return-Path: <linux-fsdevel+bounces-16394-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1611E89D11E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 05:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A2DF1C223E1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 03:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFE676020;
	Tue,  9 Apr 2024 03:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cGxpcpu8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897A7757E7;
	Tue,  9 Apr 2024 03:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712633718; cv=none; b=ZvQqdKj7V/kYHI2ZU0tGWHFB8ptW5VKyczuMbkGY5KqU9XW6dTuHfqVGASJZbb+UO5QPfqkfJ8UkIYA/oMXU8j4E1IuTdsKgDZIn4o50CcES+l5MlshxUPT9uSvYbLRpFRTX7B/2fMq6DsBIm9g/eweU7yIGnylcq/fPS+AzA48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712633718; c=relaxed/simple;
	bh=WWx8JagerM+sxQyLyrfevnelxpPsod1hNK7yUFqA7RA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j0qPRKzDVnL88VyxpgXDeffiK9yfkaueoO3yqdNBcVlT/PtIXetuiZQOF+QUxUWPmrkTf7aJ6VGFIc16rjFcPK2BYpy1eoS+Ksxxdc0+GS9WXYN54gD8oyh8bL5E9tfLh2DNTfwB4WEP9mfa1qqxLZlwOCPWa6mb12Qj0CcVbMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cGxpcpu8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E7BAC433F1;
	Tue,  9 Apr 2024 03:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712633718;
	bh=WWx8JagerM+sxQyLyrfevnelxpPsod1hNK7yUFqA7RA=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=cGxpcpu82fSzYeafrE8u1JFSaxg5w8k+1aTccl6l33FlogWelMurpYntw9kVgbZrL
	 kDHQfdao+H8R/9koGmjn6L34xLV8REMsDZBUQGRB+RJr0s8POLV5lHXNiPVt+yJbKI
	 1yg6ic+FBendMm4hZ28F5VRxFj/1VLcY0OLaqUKDaJ/CdJBz4kAZZMMHrgdtc8G+6I
	 5pd5YLVxi3qJEldVKbv8yq/qYq3x6HV0yWd0CK9F3hcWsyIbzFGrf6M66Crd5FTxrt
	 Q2KsIkiiRZSZq69/L8GrVcCarPDEIMXal5H/pyaOFFKli3bZu1LXESrJg3Xrk1mUVg
	 JoMfnie2iAGvA==
Date: Mon, 08 Apr 2024 20:35:17 -0700
Subject: [PATCH 03/14] xfs: create a incompat flag for atomic file mapping
 exchanges
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org
Cc: hch@lst.de, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Message-ID: <171263348511.2978056.14454078733236237965.stgit@frogsfrogsfrogs>
In-Reply-To: <171263348423.2978056.309570547736145336.stgit@frogsfrogsfrogs>
References: <171263348423.2978056.309570547736145336.stgit@frogsfrogsfrogs>
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
---
 fs/xfs/libxfs/xfs_format.h |   23 ++++++++++++-----------
 fs/xfs/libxfs/xfs_fs.h     |    1 +
 fs/xfs/libxfs/xfs_sb.c     |    5 +++++
 fs/xfs/xfs_mount.h         |    2 ++
 fs/xfs/xfs_super.c         |    4 ++++
 5 files changed, 24 insertions(+), 11 deletions(-)


diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
index 2b2f9050fbfbb..ff1e28316e1bb 100644
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
index 8a1e30cf4dc88..53526fca7386c 100644
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
index 73a4b895de670..c350e259b6855 100644
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
index d7cc0c79a14c5..c7b1d7b853ebc 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -292,6 +292,7 @@ typedef struct xfs_mount {
 #define XFS_FEAT_BIGTIME	(1ULL << 24)	/* large timestamps */
 #define XFS_FEAT_NEEDSREPAIR	(1ULL << 25)	/* needs xfs_repair */
 #define XFS_FEAT_NREXT64	(1ULL << 26)	/* large extent counters */
+#define XFS_FEAT_EXCHANGE_RANGE	(1ULL << 27)	/* exchange range */
 
 /* Mount features */
 #define XFS_FEAT_ADD_LOG_FEAT	(1ULL << 47)	/* can add log incompat features */
@@ -363,6 +364,7 @@ __XFS_HAS_FEAT(bigtime, BIGTIME)
 __XFS_HAS_FEAT(needsrepair, NEEDSREPAIR)
 __XFS_HAS_FEAT(large_extent_counts, NREXT64)
 __XFS_MAY_FEAT(add_log_features, ADD_LOG_FEAT)
+__XFS_HAS_FEAT(exchange_range, EXCHANGE_RANGE)
 
 /*
  * Mount features
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 7359f99a33139..ab640055e07f4 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1737,6 +1737,10 @@ xfs_fs_fill_super(
 		goto out_filestream_unmount;
 	}
 
+	if (xfs_has_exchange_range(mp))
+		xfs_warn(mp,
+	"EXPERIMENTAL exchange-range feature enabled. Use at your own risk!");
+
 	error = xfs_mountfs(mp);
 	if (error)
 		goto out_filestream_unmount;


