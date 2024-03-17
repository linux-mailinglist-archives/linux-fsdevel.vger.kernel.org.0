Return-Path: <linux-fsdevel+bounces-14614-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66AE687DEB2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 17:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5ECBB20E41
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 16:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798E15221;
	Sun, 17 Mar 2024 16:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DqqHKmom"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6231CD18;
	Sun, 17 Mar 2024 16:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710693183; cv=none; b=JkA7P7iCqzPzEdeOWkLIYpIJyJTND29VZIN2abag0D8JZf75of340a6/PGO9rkGYt3u89u/2UjMNoI472rT2Bpng2fxP5Gw3YV3PbcQug1UQsaZnkvyIhVriYW4swDLpFqYT9Ulo5jJibpRWVY2Cr/eSdSmWxwpUM4Z4rkkZrW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710693183; c=relaxed/simple;
	bh=aRlhJXa38cH0oJc/vOYeFKNl9CQRX6ZOK3DYw0Kz8CU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gKJ/nVMN/9dsxjWFh2LtXOQeQaW7obJv8tJigrmQFTUajWzmu2PiIay2i6dQvxWVTF7Qxfnaae4vvSEzSmV1qlc/3zxwR2fHgkZQmAF1QQGeAYe62TNBQkYyRmkPNmDC6e0H6siQ3du+tnJEXve0voHgwZIpzREvLgyKuyPInSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DqqHKmom; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50622C433F1;
	Sun, 17 Mar 2024 16:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710693183;
	bh=aRlhJXa38cH0oJc/vOYeFKNl9CQRX6ZOK3DYw0Kz8CU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=DqqHKmomG63eYhtGOqSWLaLJGe3/GbWkEFHBihzmTRKF13iPdS0TI9U8cHb8yZV+t
	 7mcWeTE1KvkwqQQXW+giF7oTVhiNoT5YCtZKXRsLX9L51gAXLXs5sidFoJBlhTIvWX
	 oAKk4WzWoAKt6OFnlNL5+FVkPYPns7zJWsxq4MmnHEjf67fqsDD9/+jZTcOsZQL/VX
	 LwN5KvgO51G93+LKmORrF7gySjppjuCjDc7XZ8vDw3xwPsINCRAF2kR6uBO3Dert+Y
	 HziE0qaJsM9Ehzeq97+vSLnNRKiLf8gFrj+hGqdNDo2455bQ2cYsZyoHe7Z4kmj4GL
	 CDkmPCZisZs0w==
Date: Sun, 17 Mar 2024 09:33:02 -0700
Subject: [PATCH 37/40] xfs: create separate name hash function for xattrs
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, ebiggers@kernel.org, aalbersh@redhat.com
Cc: linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev,
 linux-xfs@vger.kernel.org
Message-ID: <171069246501.2684506.2064171073014791566.stgit@frogsfrogsfrogs>
In-Reply-To: <171069245829.2684506.10682056181611490828.stgit@frogsfrogsfrogs>
References: <171069245829.2684506.10682056181611490828.stgit@frogsfrogsfrogs>
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

Create a new hashing function for extended attribute names.  The next
patch needs this so it can modify the hash strategy for verity xattrs.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_attr.c      |   16 ++++++++++++++--
 fs/xfs/libxfs/xfs_attr.h      |    3 +++
 fs/xfs/libxfs/xfs_attr_leaf.c |    4 ++--
 fs/xfs/scrub/attr.c           |    8 +++++---
 fs/xfs/xfs_attr_item.c        |    3 ++-
 fs/xfs/xfs_attr_list.c        |    3 ++-
 6 files changed, 28 insertions(+), 9 deletions(-)


diff --git a/fs/xfs/libxfs/xfs_attr.c b/fs/xfs/libxfs/xfs_attr.c
index b7aa1bc12fd1..b1fa45197eac 100644
--- a/fs/xfs/libxfs/xfs_attr.c
+++ b/fs/xfs/libxfs/xfs_attr.c
@@ -238,6 +238,16 @@ xfs_attr_get_ilocked(
 	return xfs_attr_node_get(args);
 }
 
+/* Compute hash for an extended attribute name. */
+xfs_dahash_t
+xfs_attr_hashname(
+	unsigned int		attr_flags,
+	const uint8_t		*name,
+	unsigned int		namelen)
+{
+	return xfs_da_hashname(name, namelen);
+}
+
 /*
  * Retrieve an extended attribute by name, and its value if requested.
  *
@@ -268,7 +278,8 @@ xfs_attr_get(
 
 	args->geo = args->dp->i_mount->m_attr_geo;
 	args->whichfork = XFS_ATTR_FORK;
-	args->hashval = xfs_da_hashname(args->name, args->namelen);
+	args->hashval = xfs_attr_hashname(args->attr_filter, args->name,
+					  args->namelen);
 
 	/* Entirely possible to look up a name which doesn't exist */
 	args->op_flags = XFS_DA_OP_OKNOENT;
@@ -942,7 +953,8 @@ xfs_attr_set(
 
 	args->geo = mp->m_attr_geo;
 	args->whichfork = XFS_ATTR_FORK;
-	args->hashval = xfs_da_hashname(args->name, args->namelen);
+	args->hashval = xfs_attr_hashname(args->attr_filter, args->name,
+					  args->namelen);
 
 	/*
 	 * We have no control over the attribute names that userspace passes us
diff --git a/fs/xfs/libxfs/xfs_attr.h b/fs/xfs/libxfs/xfs_attr.h
index 92711c8d2a9f..19db6c1cc71f 100644
--- a/fs/xfs/libxfs/xfs_attr.h
+++ b/fs/xfs/libxfs/xfs_attr.h
@@ -619,4 +619,7 @@ extern struct kmem_cache *xfs_attr_intent_cache;
 int __init xfs_attr_intent_init_cache(void);
 void xfs_attr_intent_destroy_cache(void);
 
+xfs_dahash_t xfs_attr_hashname(unsigned int attr_flags,
+		const uint8_t *name_string, unsigned int name_length);
+
 #endif	/* __XFS_ATTR_H__ */
diff --git a/fs/xfs/libxfs/xfs_attr_leaf.c b/fs/xfs/libxfs/xfs_attr_leaf.c
index ac904cc1a97b..fcece25fd13e 100644
--- a/fs/xfs/libxfs/xfs_attr_leaf.c
+++ b/fs/xfs/libxfs/xfs_attr_leaf.c
@@ -911,8 +911,8 @@ xfs_attr_shortform_to_leaf(
 		nargs.namelen = sfe->namelen;
 		nargs.value = &sfe->nameval[nargs.namelen];
 		nargs.valuelen = sfe->valuelen;
-		nargs.hashval = xfs_da_hashname(sfe->nameval,
-						sfe->namelen);
+		nargs.hashval = xfs_attr_hashname(sfe->flags, sfe->nameval,
+						  sfe->namelen);
 		nargs.attr_filter = sfe->flags & XFS_ATTR_NSP_ONDISK_MASK;
 		error = xfs_attr3_leaf_lookup_int(bp, &nargs); /* set a->index */
 		ASSERT(error == -ENOATTR);
diff --git a/fs/xfs/scrub/attr.c b/fs/xfs/scrub/attr.c
index c69dee281984..e7d50589f72d 100644
--- a/fs/xfs/scrub/attr.c
+++ b/fs/xfs/scrub/attr.c
@@ -253,7 +253,6 @@ xchk_xattr_listent(
 		.dp			= context->dp,
 		.name			= name,
 		.namelen		= namelen,
-		.hashval		= xfs_da_hashname(name, namelen),
 		.trans			= context->tp,
 		.valuelen		= valuelen,
 	};
@@ -263,6 +262,7 @@ xchk_xattr_listent(
 
 	sx = container_of(context, struct xchk_xattr, context);
 	ab = sx->sc->buf;
+	args.hashval = xfs_attr_hashname(flags, name, namelen);
 
 	if (xchk_should_terminate(sx->sc, &error)) {
 		context->seen_enough = error;
@@ -600,7 +600,8 @@ xchk_xattr_rec(
 			xchk_da_set_corrupt(ds, level);
 			goto out;
 		}
-		calc_hash = xfs_da_hashname(lentry->nameval, lentry->namelen);
+		calc_hash = xfs_attr_hashname(ent->flags, lentry->nameval,
+				lentry->namelen);
 	} else {
 		rentry = (struct xfs_attr_leaf_name_remote *)
 				(((char *)bp->b_addr) + nameidx);
@@ -608,7 +609,8 @@ xchk_xattr_rec(
 			xchk_da_set_corrupt(ds, level);
 			goto out;
 		}
-		calc_hash = xfs_da_hashname(rentry->name, rentry->namelen);
+		calc_hash = xfs_attr_hashname(ent->flags, rentry->name,
+				rentry->namelen);
 	}
 	if (calc_hash != hash)
 		xchk_da_set_corrupt(ds, level);
diff --git a/fs/xfs/xfs_attr_item.c b/fs/xfs/xfs_attr_item.c
index 703770cf1482..4d8264f0a537 100644
--- a/fs/xfs/xfs_attr_item.c
+++ b/fs/xfs/xfs_attr_item.c
@@ -536,7 +536,8 @@ xfs_attri_recover_work(
 	args->whichfork = XFS_ATTR_FORK;
 	args->name = nv->name.i_addr;
 	args->namelen = nv->name.i_len;
-	args->hashval = xfs_da_hashname(args->name, args->namelen);
+	args->hashval = xfs_attr_hashname(attrp->alfi_attr_filter, args->name,
+					  args->namelen);
 	args->attr_filter = attrp->alfi_attr_filter & XFS_ATTRI_FILTER_MASK;
 	args->op_flags = XFS_DA_OP_RECOVERY | XFS_DA_OP_OKNOENT |
 			 XFS_DA_OP_LOGGED;
diff --git a/fs/xfs/xfs_attr_list.c b/fs/xfs/xfs_attr_list.c
index fa74378577c5..96169474d023 100644
--- a/fs/xfs/xfs_attr_list.c
+++ b/fs/xfs/xfs_attr_list.c
@@ -135,7 +135,8 @@ xfs_attr_shortform_list(
 		}
 
 		sbp->entno = i;
-		sbp->hash = xfs_da_hashname(sfe->nameval, sfe->namelen);
+		sbp->hash = xfs_attr_hashname(sfe->flags, sfe->nameval,
+					      sfe->namelen);
 		sbp->name = sfe->nameval;
 		sbp->namelen = sfe->namelen;
 		/* These are bytes, and both on-disk, don't endian-flip */


