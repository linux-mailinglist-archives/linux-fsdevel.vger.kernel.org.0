Return-Path: <linux-fsdevel+bounces-14622-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D440D87DEC1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 17:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 582201F20FBE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 16:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317C463B3;
	Sun, 17 Mar 2024 16:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OcdA72Aq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D31F1B949;
	Sun, 17 Mar 2024 16:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710693308; cv=none; b=UnCtMIRsmxTVMFB9T0ElnuX4H3rZ1CBf6jEbxA6UBHsdUQCS5bNpTiRY/ha67HB6Zcaz/VHgZAsqO/V7hmsp/jFc+yx8lJ/xzlX4F2CdTlz6a9fvkqXguvEGNIZnHfbijuuljWN2lwg/gNHQsOG+Rz9gvIadPvOwkbI1tCM6zEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710693308; c=relaxed/simple;
	bh=6tJ2seaphlFM9dJGhh2nAddNTg/heedCJ2rlT4NAnlQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PeuVbeBe2M8NXx0LPQs8B2OvGzOOmdPSDWqNvxVByJvTvutCzKltkn1rpjCd+nSgkXteLy1H7jMwYGdU9/u9DR3aQZ5iRUmxPluVfryY2dZJKs5XM+GSuOFveKa7sgOSq/pd/3iDUVe0jlwFFuZE6R7Ay0rwHfmJMpDDnj3dvdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OcdA72Aq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FBC0C433C7;
	Sun, 17 Mar 2024 16:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710693308;
	bh=6tJ2seaphlFM9dJGhh2nAddNTg/heedCJ2rlT4NAnlQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=OcdA72AqwnwLHINB7Ytnq4j3lb6pqm/wl83iFPBHI6dU96e0HWy9M/eZkJY/PUVPl
	 Cqi7A750tVnSRqaRRKIO6xNVtU6J4uDlDYPmJCwf/iUtEyVGY/GPyB3Omc+KMcJ+y8
	 fH80AkRpaUI9Q2ASVZxkfu7dYs+CIaaTTWKG3Cvbgb7YMom4wIpFb5+g2kHkG7LQbo
	 6/IcsD7tRZQkkn2gB+HtkvHpLtieTtQbsZxx+NVsGdc+aaTvW/GZ/MrCGcSDK4uBAp
	 Mi77OYlVRQPV6PwXvDOAAOIUjBTcAUoutEvu2JwYgBe+Sn7wm5680cxTe8CjmO6kr+
	 muWJEktHZ8tVA==
Date: Sun, 17 Mar 2024 09:35:07 -0700
Subject: [PATCH 05/20] xfs: add attribute type for fs-verity
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, djwong@kernel.org, cem@kernel.org,
 ebiggers@kernel.org
Cc: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-xfs@vger.kernel.org
Message-ID: <171069247744.2685643.5127507389767820706.stgit@frogsfrogsfrogs>
In-Reply-To: <171069247657.2685643.11583844772215446491.stgit@frogsfrogsfrogs>
References: <171069247657.2685643.11583844772215446491.stgit@frogsfrogsfrogs>
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

The Merkle tree blocks and descriptor are stored in the extended
attributes of the inode. Add new attribute type for fs-verity
metadata. Add XFS_ATTR_INTERNAL_MASK to skip parent pointer and
fs-verity attributes as those are only for internal use. While we're
at it add a few comments in relevant places that internally visible
attributes are not suppose to be handled via interface defined in
xfs_xattr.c.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 libxfs/xfs_da_format.h  |   10 +++++++++-
 libxfs/xfs_log_format.h |    1 +
 2 files changed, 10 insertions(+), 1 deletion(-)


diff --git a/libxfs/xfs_da_format.h b/libxfs/xfs_da_format.h
index e7045b36..3a35ba58 100644
--- a/libxfs/xfs_da_format.h
+++ b/libxfs/xfs_da_format.h
@@ -715,14 +715,22 @@ struct xfs_attr3_leafblock {
 #define	XFS_ATTR_ROOT_BIT	1	/* limit access to trusted attrs */
 #define	XFS_ATTR_SECURE_BIT	2	/* limit access to secure attrs */
 #define	XFS_ATTR_PARENT_BIT	3	/* parent pointer attrs */
+#define	XFS_ATTR_VERITY_BIT	4	/* verity merkle tree and descriptor */
 #define	XFS_ATTR_INCOMPLETE_BIT	7	/* attr in middle of create/delete */
 #define XFS_ATTR_LOCAL		(1u << XFS_ATTR_LOCAL_BIT)
 #define XFS_ATTR_ROOT		(1u << XFS_ATTR_ROOT_BIT)
 #define XFS_ATTR_SECURE		(1u << XFS_ATTR_SECURE_BIT)
 #define XFS_ATTR_PARENT		(1u << XFS_ATTR_PARENT_BIT)
+#define XFS_ATTR_VERITY		(1u << XFS_ATTR_VERITY_BIT)
 #define XFS_ATTR_INCOMPLETE	(1u << XFS_ATTR_INCOMPLETE_BIT)
 #define XFS_ATTR_NSP_ONDISK_MASK \
-			(XFS_ATTR_ROOT | XFS_ATTR_SECURE | XFS_ATTR_PARENT)
+			(XFS_ATTR_ROOT | XFS_ATTR_SECURE | XFS_ATTR_PARENT | \
+			 XFS_ATTR_VERITY)
+
+/*
+ * Internal attributes not exposed to the user
+ */
+#define XFS_ATTR_INTERNAL_MASK (XFS_ATTR_PARENT | XFS_ATTR_VERITY)
 
 /*
  * Alignment for namelist and valuelist entries (since they are mixed
diff --git a/libxfs/xfs_log_format.h b/libxfs/xfs_log_format.h
index 9cbcba4b..407fadfb 100644
--- a/libxfs/xfs_log_format.h
+++ b/libxfs/xfs_log_format.h
@@ -975,6 +975,7 @@ struct xfs_icreate_log {
 #define XFS_ATTRI_FILTER_MASK		(XFS_ATTR_ROOT | \
 					 XFS_ATTR_SECURE | \
 					 XFS_ATTR_PARENT | \
+					 XFS_ATTR_VERITY | \
 					 XFS_ATTR_INCOMPLETE)
 
 /*


