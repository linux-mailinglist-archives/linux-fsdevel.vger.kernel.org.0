Return-Path: <linux-fsdevel+bounces-18235-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 382818B6885
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AC481C21A1D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C09E1078F;
	Tue, 30 Apr 2024 03:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ur9k6BGK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D785ADDD4;
	Tue, 30 Apr 2024 03:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714447540; cv=none; b=IDAbA5INbXo0dIc/QFAJizSUepJDnZMHS3vK47e/CmlUQBaq2GzUcbAbbHrbk368Cww7mTwMbxt1/XeFnjq2PkZzWFYlYd1R05Fo0x2KLVr3WRdBvjYOcCuhEGF1yIBbR8UTGdDV7PHtRBqKDzUhu03wqxWRZT+KGuTucefHh4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714447540; c=relaxed/simple;
	bh=cmSJrM6Dbtf0QatfHFaO8/braz2B+zZfw8rTY5IS51k=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BXeaFPeuGP0NuF3OAiiaNB32Ag1e11M963LXie02W1Id527p+huEBkBcegVcPnSWSouTaLpHuPbv6IHjbUCj5lQS43jlvfXsoAcy9NPhj/Zs6W8p9qWpSZA9Kj2hxxhwChHyfHCs1irdwLqFkPftrik1fwpnWRks2TU954Dknz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ur9k6BGK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8877C116B1;
	Tue, 30 Apr 2024 03:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714447540;
	bh=cmSJrM6Dbtf0QatfHFaO8/braz2B+zZfw8rTY5IS51k=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Ur9k6BGKXd8wjZr38X62VTJf8O5JW74t0FQlJpz+DizwTMrCOqwlcAZhIMOjS/YeY
	 ywTrqFepfTBYdII9B4mjGcmb7TCGqMaeNa+OLqdD6Idav8QUx+oqOJw+t4WqF4Ivhz
	 HyKGTEOTYHwbHuYAitAdt9Y2JH/fT9hKwFq66iENsVczKMxSMC8A0tYB0flHkfKzfF
	 OGdqPuTaZI5xlJQlH5X97qch5cEKDp5GWo3d8jmcJH9oz2kepG/VjvChoP9bJp248P
	 GFv5v0MPsrSQti2YYos7zHFxRiKGO0Y04LG1GAy8ZRYqPtfiAxq/T5Tr/qMwGni9yz
	 jsHNx1RUNOovw==
Date: Mon, 29 Apr 2024 20:25:40 -0700
Subject: [PATCH 06/26] xfs: add attribute type for fs-verity
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org, djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, alexl@redhat.com, walters@verbum.org,
 fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org
Message-ID: <171444680463.957659.10450018889610919513.stgit@frogsfrogsfrogs>
In-Reply-To: <171444680291.957659.15782417454902691461.stgit@frogsfrogsfrogs>
References: <171444680291.957659.15782417454902691461.stgit@frogsfrogsfrogs>
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
 fs/xfs/libxfs/xfs_da_format.h  |   11 ++++++++---
 fs/xfs/libxfs/xfs_log_format.h |    1 +
 fs/xfs/xfs_trace.h             |    3 ++-
 3 files changed, 11 insertions(+), 4 deletions(-)


diff --git a/fs/xfs/libxfs/xfs_da_format.h b/fs/xfs/libxfs/xfs_da_format.h
index 86de99e2f7570..27b9ad9f8b2e4 100644
--- a/fs/xfs/libxfs/xfs_da_format.h
+++ b/fs/xfs/libxfs/xfs_da_format.h
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
diff --git a/fs/xfs/libxfs/xfs_log_format.h b/fs/xfs/libxfs/xfs_log_format.h
index 0f194ae71b42c..4d11d6b7b1ad6 100644
--- a/fs/xfs/libxfs/xfs_log_format.h
+++ b/fs/xfs/libxfs/xfs_log_format.h
@@ -1052,6 +1052,7 @@ struct xfs_icreate_log {
 #define XFS_ATTRI_FILTER_MASK		(XFS_ATTR_ROOT | \
 					 XFS_ATTR_SECURE | \
 					 XFS_ATTR_PARENT | \
+					 XFS_ATTR_VERITY | \
 					 XFS_ATTR_INCOMPLETE)
 
 /*
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index 990837afbf667..7116e7d9627d0 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -107,7 +107,8 @@ struct xfs_fsrefs;
 	{ XFS_ATTR_ROOT,	"ROOT" }, \
 	{ XFS_ATTR_SECURE,	"SECURE" }, \
 	{ XFS_ATTR_INCOMPLETE,	"INCOMPLETE" }, \
-	{ XFS_ATTR_PARENT,	"PARENT" }
+	{ XFS_ATTR_PARENT,	"PARENT" }, \
+	{ XFS_ATTR_VERITY,	"VERITY" }
 
 DECLARE_EVENT_CLASS(xfs_attr_list_class,
 	TP_PROTO(struct xfs_attr_list_context *ctx),


