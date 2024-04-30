Return-Path: <linux-fsdevel+bounces-18263-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7970F8B68D8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 305151F216C3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413A117BBF;
	Tue, 30 Apr 2024 03:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a2YVxkRq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E84510A1D;
	Tue, 30 Apr 2024 03:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714447963; cv=none; b=TcU7ox2CvbQ2cxFRoOPCdYPwqKx7/IJfxYAXDa6e+VTwqNnzy0xES63y7HjyY92xbMNjiJfg/a8zfdS20H2m1WePVZ4Ss6KqXXEd5ABWf/ZVktWxoYEFz/wTqjH+8iomC8FNf2Yf/wTJt51AatefesrOctdRTvpAmVg3DRR7Oos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714447963; c=relaxed/simple;
	bh=1b5WwY/oi77xgfYu3z0SG3NWJvJwI4o71e1l5ztX8+s=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TkJ3/ae/5zZEgdyGR31Z4pSnbPBaszxW12oYzZsgTStVcbF2kHW/zW6fTTgXu51zQgCcA8WzxI0rBFX/CygmdxEOpuTFpYoegPVrUSUtmyR8bwI0r5P4yHUrsXQ/Rrlo/4ot/f532lVveAJUT97IAUSZ/1JLPuggQJwrlJVmnEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a2YVxkRq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 243C4C116B1;
	Tue, 30 Apr 2024 03:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714447963;
	bh=1b5WwY/oi77xgfYu3z0SG3NWJvJwI4o71e1l5ztX8+s=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=a2YVxkRqeoXr3/j2ORpRQyFQdwy7CyqCYpMtj+LfPrK7ZKiVAnlsM/zxdvkF1UMvi
	 FqmFmEN8fijctKvg2uej9AcmoJkWTg9MEa0K9kpNM9bPLSJhFeZ2xzoEG76a8MxZ/J
	 zGaSnSncXS22cYb+b+m7/VaLWcS3zZunyim+vEmpDpF4PiH5VJajaT5N9AS5qLWgj6
	 3batnJaAAT7jvT4yZKlUEMeBm7xg/UNmqebdnJwyzLUcvvWOL+bgJmjpr0KL1kzt9X
	 bisOiwKQvU3U8w3Tk7wLW43CHrpijnrx+91ReS8wveDDfMGZYjatbM4Cxt4A9ZxPZM
	 zsMJyrU/lHK6Q==
Date: Mon, 29 Apr 2024 20:32:42 -0700
Subject: [PATCH 07/38] xfs: add attribute type for fs-verity
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org, cem@kernel.org,
 djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 fsverity@lists.linux.dev
Message-ID: <171444683219.960383.1750750720014491843.stgit@frogsfrogsfrogs>
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

The Merkle tree blocks and descriptor are stored in the extended
attributes of the inode. Add new attribute type for fs-verity
metadata. Add XFS_ATTR_INTERNAL_MASK to skip parent pointer and
fs-verity attributes as those are only for internal use. While we're
at it add a few comments in relevant places that internally visible
attributes are not suppose to be handled via interface defined in
xfs_xattr.c.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 libxfs/xfs_da_format.h  |   11 ++++++++---
 libxfs/xfs_log_format.h |    1 +
 2 files changed, 9 insertions(+), 3 deletions(-)


diff --git a/libxfs/xfs_da_format.h b/libxfs/xfs_da_format.h
index 86de99e2f757..27b9ad9f8b2e 100644
--- a/libxfs/xfs_da_format.h
+++ b/libxfs/xfs_da_format.h
@@ -715,19 +715,23 @@ struct xfs_attr3_leafblock {
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
 
 #define XFS_ATTR_NSP_ONDISK_MASK	(XFS_ATTR_ROOT | \
 					 XFS_ATTR_SECURE | \
-					 XFS_ATTR_PARENT)
+					 XFS_ATTR_PARENT | \
+					 XFS_ATTR_VERITY)
 
 /* Private attr namespaces not exposed to userspace */
-#define XFS_ATTR_PRIVATE_NSP_MASK	(XFS_ATTR_PARENT)
+#define XFS_ATTR_PRIVATE_NSP_MASK	(XFS_ATTR_PARENT | \
+					 XFS_ATTR_VERITY)
 
 #define XFS_ATTR_ONDISK_MASK	(XFS_ATTR_NSP_ONDISK_MASK | \
 				 XFS_ATTR_LOCAL | \
@@ -737,7 +741,8 @@ struct xfs_attr3_leafblock {
 	{ XFS_ATTR_LOCAL,	"local" }, \
 	{ XFS_ATTR_ROOT,	"root" }, \
 	{ XFS_ATTR_SECURE,	"secure" }, \
-	{ XFS_ATTR_PARENT,	"parent" }
+	{ XFS_ATTR_PARENT,	"parent" }, \
+	{ XFS_ATTR_VERITY,	"verity" }
 
 /*
  * Alignment for namelist and valuelist entries (since they are mixed
diff --git a/libxfs/xfs_log_format.h b/libxfs/xfs_log_format.h
index 0f194ae71b42..4d11d6b7b1ad 100644
--- a/libxfs/xfs_log_format.h
+++ b/libxfs/xfs_log_format.h
@@ -1052,6 +1052,7 @@ struct xfs_icreate_log {
 #define XFS_ATTRI_FILTER_MASK		(XFS_ATTR_ROOT | \
 					 XFS_ATTR_SECURE | \
 					 XFS_ATTR_PARENT | \
+					 XFS_ATTR_VERITY | \
 					 XFS_ATTR_INCOMPLETE)
 
 /*


