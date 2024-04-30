Return-Path: <linux-fsdevel+bounces-18266-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 977FA8B68DE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53451284278
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFAAC12B79;
	Tue, 30 Apr 2024 03:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TPQK+RDh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E9210A1E;
	Tue, 30 Apr 2024 03:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714448010; cv=none; b=oicBYgIZt6yoUN1bLRKuel93/d/NhCKXWzS+KIEQyOR1eRHkBj53NA8AzHH/v8X/U37mp74LPHT4ex73ME04Ojc4IHD3JnqfY4yXqheV0Rct/w18lqWiFB7jG9WhT3cVJwhCJlaI4BBp5gWljNPVaxiEvX3uRT7ggMvlrk65cS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714448010; c=relaxed/simple;
	bh=712srmX5SRwExP1nY9jvD8/eSTUeti2MOTjvH9dMDu4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wu/zsmgDJAOd5/3qyqoeZW2t3qOGYfwpKLM4kIzmCwcAC/WlHW699iM+kaYIb8AhvwgOcZkTTW4n7w8tUfSRf2wGiKoj6ZD7sOu6eFUT46pIekYlCTMVxHlAe/zknZxNbeHkGUMs4CwcXAaHF+czazIie0vInKwOk1cfcXh1zvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TPQK+RDh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D9C1C116B1;
	Tue, 30 Apr 2024 03:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714448010;
	bh=712srmX5SRwExP1nY9jvD8/eSTUeti2MOTjvH9dMDu4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=TPQK+RDhs4YjU81B9BYytEtvkmTt0s0KoTDHQMTVTWXHyK6PhXIZ3h8rY0I75XKtU
	 CTEqYg0OLv1oAAKvOHBTOl0hJlFhOC6Y1xAbu5EyddvQAUiBzonWSE7tDJDaCnbd5E
	 k/WInjEaMDoHumIuUrPeHq000n202gxMqQYkz0zfrcZOvXdKvsmoNH9dJbk3drX8id
	 kXt+P3UMybnd/vC52dU6lCCgVrv50FzfzeMEvlyw1IdcazZqWIpgzL6fsc/vcdjpnj
	 88MND4NmGKuG5lv9XvtatkJZJkRbFTJ0EWI0XsWQhiy6k7hdSx9F5AFZJ3q7xKqXa/
	 qg9yB3kPR1ynA==
Date: Mon, 29 Apr 2024 20:33:29 -0700
Subject: [PATCH 10/38] xfs: add inode on-disk VERITY flag
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org, cem@kernel.org,
 djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 fsverity@lists.linux.dev
Message-ID: <171444683266.960383.2640876395161867782.stgit@frogsfrogsfrogs>
In-Reply-To: <171444683053.960383.12871831441554683674.stgit@frogsfrogsfrogs>
References: <171444683053.960383.12871831441554683674.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Andrey Albershteyn <aalbersh@redhat.com>

Add flag to mark inodes which have fs-verity enabled on them (i.e.
descriptor exist and tree is built).

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 libxfs/xfs_format.h     |    5 ++++-
 libxfs/xfs_inode_buf.c  |    8 ++++++++
 libxfs/xfs_inode_util.c |    2 ++
 3 files changed, 14 insertions(+), 1 deletion(-)


diff --git a/libxfs/xfs_format.h b/libxfs/xfs_format.h
index 563f359f2f07..810f2556762b 100644
--- a/libxfs/xfs_format.h
+++ b/libxfs/xfs_format.h
@@ -1190,6 +1190,7 @@ static inline void xfs_dinode_put_rdev(struct xfs_dinode *dip, xfs_dev_t rdev)
 #define XFS_DIFLAG2_COWEXTSIZE_BIT   2  /* copy on write extent size hint */
 #define XFS_DIFLAG2_BIGTIME_BIT	3	/* big timestamps */
 #define XFS_DIFLAG2_NREXT64_BIT	4	/* large extent counters */
+#define XFS_DIFLAG2_VERITY_BIT	5	/* inode sealed by fsverity */
 #define XFS_DIFLAG2_METADIR_BIT	63	/* filesystem metadata */
 
 #define XFS_DIFLAG2_DAX		(1ULL << XFS_DIFLAG2_DAX_BIT)
@@ -1197,6 +1198,7 @@ static inline void xfs_dinode_put_rdev(struct xfs_dinode *dip, xfs_dev_t rdev)
 #define XFS_DIFLAG2_COWEXTSIZE	(1ULL << XFS_DIFLAG2_COWEXTSIZE_BIT)
 #define XFS_DIFLAG2_BIGTIME	(1ULL << XFS_DIFLAG2_BIGTIME_BIT)
 #define XFS_DIFLAG2_NREXT64	(1ULL << XFS_DIFLAG2_NREXT64_BIT)
+#define XFS_DIFLAG2_VERITY	(1ULL << XFS_DIFLAG2_VERITY_BIT)
 
 /*
  * The inode contains filesystem metadata and can be found through the metadata
@@ -1225,7 +1227,8 @@ static inline void xfs_dinode_put_rdev(struct xfs_dinode *dip, xfs_dev_t rdev)
 
 #define XFS_DIFLAG2_ANY \
 	(XFS_DIFLAG2_DAX | XFS_DIFLAG2_REFLINK | XFS_DIFLAG2_COWEXTSIZE | \
-	 XFS_DIFLAG2_BIGTIME | XFS_DIFLAG2_NREXT64 | XFS_DIFLAG2_METADIR)
+	 XFS_DIFLAG2_BIGTIME | XFS_DIFLAG2_NREXT64 | XFS_DIFLAG2_METADIR | \
+	 XFS_DIFLAG2_VERITY)
 
 static inline bool xfs_dinode_has_bigtime(const struct xfs_dinode *dip)
 {
diff --git a/libxfs/xfs_inode_buf.c b/libxfs/xfs_inode_buf.c
index 085c128c5422..12872acc70c0 100644
--- a/libxfs/xfs_inode_buf.c
+++ b/libxfs/xfs_inode_buf.c
@@ -692,6 +692,14 @@ xfs_dinode_verify(
 	    !xfs_has_rtreflink(mp))
 		return __this_address;
 
+	/* only regular files can have fsverity */
+	if (flags2 & XFS_DIFLAG2_VERITY) {
+		if (!xfs_has_verity(mp))
+			return __this_address;
+		if ((mode & S_IFMT) != S_IFREG)
+			return __this_address;
+	}
+
 	/* COW extent size hint validation */
 	fa = xfs_inode_validate_cowextsize(mp, be32_to_cpu(dip->di_cowextsize),
 			mode, flags, flags2);
diff --git a/libxfs/xfs_inode_util.c b/libxfs/xfs_inode_util.c
index 432186283866..aba80a9769c3 100644
--- a/libxfs/xfs_inode_util.c
+++ b/libxfs/xfs_inode_util.c
@@ -124,6 +124,8 @@ xfs_ip2xflags(
 			flags |= FS_XFLAG_DAX;
 		if (ip->i_diflags2 & XFS_DIFLAG2_COWEXTSIZE)
 			flags |= FS_XFLAG_COWEXTSIZE;
+		if (ip->i_diflags2 & XFS_DIFLAG2_VERITY)
+			flags |= FS_XFLAG_VERITY;
 	}
 
 	if (xfs_inode_has_attr_fork(ip))


