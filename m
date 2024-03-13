Return-Path: <linux-fsdevel+bounces-14336-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A561487B09A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 19:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ABA61F28D9C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 18:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF3D1448E0;
	Wed, 13 Mar 2024 17:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fcOnwz55"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BB31448D7;
	Wed, 13 Mar 2024 17:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710352574; cv=none; b=OzeCNwDuvljDHQxYFoBWzv35PJkgMgynp71VUV5R+EHgz9EetmGTq8q4Y0LxeMBQZlYg2EmoOjI4eUvHqR+79dgpjPFrLFn1ur6tS8B/qlVz5NGnw37YCpiqZcNZzy2KUGsDIjL8VhQ+CyuLShN8y79pVEXNl2tqnFIcfSw8yMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710352574; c=relaxed/simple;
	bh=YV2FpcHp1T9nZAjzqj8IXFCQoFgRWZQjMLPyND0pLlc=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tTZIsJinkdPVH6Kmg5crl7/BNWjQ2oLkOw27sUZ9bOjqKhnGTJtoyE05pORmPBXoyU79v5/zCs5VhD51/FlA9eEJeQWPGTJoWr+ixyJ75Qke80SEefioX2Lyyy7un16P4TZAYCbLJM/eobRy/6NjWBkbuDzSj27pOPd76Q/XBtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fcOnwz55; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A23AC433C7;
	Wed, 13 Mar 2024 17:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710352574;
	bh=YV2FpcHp1T9nZAjzqj8IXFCQoFgRWZQjMLPyND0pLlc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=fcOnwz55kBmBXX+/GHlIC3az89npUUmVu5tv0Y6sZXt3ayFWw4IhlcgxGIK+N/fY+
	 LNJc4a/+KX5Rlxrp4PNaHNKqcoRn1ijooyzt7Mb2zE3zFp/y4/1KpepUd+ZwUwYY5k
	 fvzfA6S1+m27VNSPqAW2lhKdmvn1DYInEOAv0j52XUuU4QAHeBEJ2a9HY7z+r1LmvN
	 nuIjRySKCh2XU1OVfJRr1yWvzXuUUPJ3HeAe0DgFkO8lxNlptUlBh7XA6TjnZaK4cG
	 oKMpZ74BHahly6PaU7v1RhzD7qi89OLMOdKZ9VsvxXcAOOyeVw0UTDKqBv7IgsBsjp
	 ZouKvWyu5E2eA==
Date: Wed, 13 Mar 2024 10:56:13 -0700
Subject: [PATCH 14/29] xfs: add attribute type for fs-verity
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, aalbersh@redhat.com, ebiggers@kernel.org
Cc: linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev,
 linux-xfs@vger.kernel.org
Message-ID: <171035223583.2613863.2342282023194573649.stgit@frogsfrogsfrogs>
In-Reply-To: <171035223299.2613863.12196197862413309469.stgit@frogsfrogsfrogs>
References: <171035223299.2613863.12196197862413309469.stgit@frogsfrogsfrogs>
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
 fs/xfs/libxfs/xfs_da_format.h  |   10 +++++++++-
 fs/xfs/libxfs/xfs_log_format.h |    1 +
 fs/xfs/xfs_ioctl.c             |    5 +++++
 fs/xfs/xfs_trace.h             |    3 ++-
 fs/xfs/xfs_xattr.c             |   10 ++++++++++
 5 files changed, 27 insertions(+), 2 deletions(-)


diff --git a/fs/xfs/libxfs/xfs_da_format.h b/fs/xfs/libxfs/xfs_da_format.h
index 839df0e5401b..28d4ac6fa156 100644
--- a/fs/xfs/libxfs/xfs_da_format.h
+++ b/fs/xfs/libxfs/xfs_da_format.h
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
diff --git a/fs/xfs/libxfs/xfs_log_format.h b/fs/xfs/libxfs/xfs_log_format.h
index 9cbcba4bd363..407fadfb5c06 100644
--- a/fs/xfs/libxfs/xfs_log_format.h
+++ b/fs/xfs/libxfs/xfs_log_format.h
@@ -975,6 +975,7 @@ struct xfs_icreate_log {
 #define XFS_ATTRI_FILTER_MASK		(XFS_ATTR_ROOT | \
 					 XFS_ATTR_SECURE | \
 					 XFS_ATTR_PARENT | \
+					 XFS_ATTR_VERITY | \
 					 XFS_ATTR_INCOMPLETE)
 
 /*
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index d0e2cec6210d..ab61d7d552fb 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -352,6 +352,11 @@ static unsigned int
 xfs_attr_filter(
 	u32			ioc_flags)
 {
+	/*
+	 * Only externally visible attributes should be specified here.
+	 * Internally used attributes (such as parent pointers or fs-verity)
+	 * should not be exposed to userspace.
+	 */
 	if (ioc_flags & XFS_IOC_ATTR_ROOT)
 		return XFS_ATTR_ROOT;
 	if (ioc_flags & XFS_IOC_ATTR_SECURE)
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index d4f1b2da21e7..9d4ae05abfc8 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -87,7 +87,8 @@ struct xfs_bmap_intent;
 	{ XFS_ATTR_ROOT,	"ROOT" }, \
 	{ XFS_ATTR_SECURE,	"SECURE" }, \
 	{ XFS_ATTR_INCOMPLETE,	"INCOMPLETE" }, \
-	{ XFS_ATTR_PARENT,	"PARENT" }
+	{ XFS_ATTR_PARENT,	"PARENT" }, \
+	{ XFS_ATTR_VERITY,	"VERITY" }
 
 DECLARE_EVENT_CLASS(xfs_attr_list_class,
 	TP_PROTO(struct xfs_attr_list_context *ctx),
diff --git a/fs/xfs/xfs_xattr.c b/fs/xfs/xfs_xattr.c
index 364104e1b38a..e4c88dde4e44 100644
--- a/fs/xfs/xfs_xattr.c
+++ b/fs/xfs/xfs_xattr.c
@@ -20,6 +20,13 @@
 
 #include <linux/posix_acl_xattr.h>
 
+/*
+ * This file defines interface to work with externally visible extended
+ * attributes, such as those in user, system or security namespaces. This
+ * interface should not be used for internally used attributes (consider
+ * xfs_attr.c).
+ */
+
 /*
  * Get permission to use log-assisted atomic exchange of file extents.
  *
@@ -244,6 +251,9 @@ xfs_xattr_put_listent(
 
 	ASSERT(context->count >= 0);
 
+	if (flags & XFS_ATTR_INTERNAL_MASK)
+		return;
+
 	if (flags & XFS_ATTR_ROOT) {
 #ifdef CONFIG_XFS_POSIX_ACL
 		if (namelen == SGI_ACL_FILE_SIZE &&


