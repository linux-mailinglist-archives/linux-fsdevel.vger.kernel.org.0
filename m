Return-Path: <linux-fsdevel+bounces-14411-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40ED587C1CD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Mar 2024 18:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A94541F220DC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Mar 2024 17:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C81A74436;
	Thu, 14 Mar 2024 17:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Soedy5Z1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8A37351C;
	Thu, 14 Mar 2024 17:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710435982; cv=none; b=ufwiXdxkhLQE6ADDm+awo/wkcimGhsLYG6WLL3QLlcdlRXfRaLv3ATvW/TT0065zbaJKgK4bWAwWtDoOD6a+mBAM7U34xVvWa6Tnb4gouqSwtCLQ3AcGcltzUB96/hRfzXmrshRavss6Dkl3yilermQAPFer9L1Z3CDIKWYNqvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710435982; c=relaxed/simple;
	bh=viGiINFDCV7P8QI+dM5uC1tGJDU23A2pJCI1bxg7RKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XdOgZryNKENywxE1jmou56wKKqR7WJ9QpGNt19kRyKuhSlDSczsijmt5DwmnIUflwoNLydwerZKWNLG/0cxe5F8LhOIh4dFfmuAP9dUHxIDcm2MHuH1nmbnryqL1XnHqU6aW4mz/idfPLrE5rF9jt9ju5lPQ9E/5qcEiUXlXARw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Soedy5Z1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D576C433F1;
	Thu, 14 Mar 2024 17:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710435981;
	bh=viGiINFDCV7P8QI+dM5uC1tGJDU23A2pJCI1bxg7RKM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Soedy5Z1kCcIkRe8UsLOBcXoOy9e/gcvMvYsfy6wFS7Q1QQLm2CkUm/kC9kAkTG5i
	 dUg6bRt8dv9CA4ROjNUEWtGzMyMFJ43+W0K8Q4GkaLe6UtNX0DVSfTCCYheVmNCjHR
	 Gz3JvweBGTXTszxLfYJrdhAzwZxtuAuus8siYNow/hqFHpignE/0+YvIDFAiTbX6fO
	 jSOEF9r4n0eZkmAndOhePy4MXKw9WF9rVoeMhWroiWGtGSjHCHv2LKy9GR9xWqCfhN
	 5qOPCvWV+/+KcScDL2qtwCXVK2gW8EFohn8tecaWCz5cqLpkKjn1kYCpnLFAjEz+dK
	 kVTDIiaPU9PVw==
Date: Thu, 14 Mar 2024 10:06:20 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org
Cc: linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 21/29] xfs: add fs-verity support
Message-ID: <20240314170620.GR1927156@frogsfrogsfrogs>
References: <171035223299.2613863.12196197862413309469.stgit@frogsfrogsfrogs>
 <171035223693.2613863.3986547716372413007.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171035223693.2613863.3986547716372413007.stgit@frogsfrogsfrogs>

On Wed, Mar 13, 2024 at 10:58:03AM -0700, Darrick J. Wong wrote:
> From: Andrey Albershteyn <aalbersh@redhat.com>
> 
> Add integration with fs-verity. The XFS store fs-verity metadata in
> the extended file attributes. The metadata consist of verity
> descriptor and Merkle tree blocks.
> 
> The descriptor is stored under "vdesc" extended attribute. The
> Merkle tree blocks are stored under binary indexes which are offsets
> into the Merkle tree.
> 
> When fs-verity is enabled on an inode, the XFS_IVERITY_CONSTRUCTION
> flag is set meaning that the Merkle tree is being build. The
> initialization ends with storing of verity descriptor and setting
> inode on-disk flag (XFS_DIFLAG2_VERITY).
> 
> The verification on read is done in read path of iomap.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> [djwong: replace caching implementation with an xarray, other cleanups]
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>

I started writing more of userspace (xfs_db decoding of verity xattrs,
repair/scrub support) so I think I want to make one more change to this.

This change shortens the key structure name, puts a proper namespace on
the merkleoff field to match everything else in the ondisk structs, and
checks it via xfs_ondisk.h.

--D

diff --git a/fs/xfs/libxfs/xfs_attr.c b/fs/xfs/libxfs/xfs_attr.c
index 3280fbc3027ec..c2f1b38683646 100644
--- a/fs/xfs/libxfs/xfs_attr.c
+++ b/fs/xfs/libxfs/xfs_attr.c
@@ -1593,7 +1593,7 @@ xfs_attr_namecheck(
 
 	if (flags & XFS_ATTR_VERITY) {
 		/* Merkle tree pages are stored under u64 indexes */
-		if (length == sizeof(struct xfs_fsverity_merkle_key))
+		if (length == sizeof(struct xfs_verity_merkle_key))
 			return true;
 
 		/* Verity descriptor blocks are held in a named attribute. */
diff --git a/fs/xfs/libxfs/xfs_da_format.h b/fs/xfs/libxfs/xfs_da_format.h
index 6e3b08d4ad74a..e55e437c47ae3 100644
--- a/fs/xfs/libxfs/xfs_da_format.h
+++ b/fs/xfs/libxfs/xfs_da_format.h
@@ -923,10 +923,10 @@ struct xfs_parent_name_rec {
  * fs-verity attribute name format
  *
  * Merkle tree blocks are stored under extended attributes of the inode. The
- * name of the attributes are offsets into merkle tree.
+ * name of the attributes are byte offsets into merkle tree.
  */
-struct xfs_fsverity_merkle_key {
-	__be64 merkleoff;
+struct xfs_verity_merkle_key {
+	__be64	bk_merkleoff;
 };
 
 /* ondisk xattr name used for the fsverity descriptor */
diff --git a/fs/xfs/libxfs/xfs_ondisk.h b/fs/xfs/libxfs/xfs_ondisk.h
index e4e0e5203ec16..118e993c7d2f3 100644
--- a/fs/xfs/libxfs/xfs_ondisk.h
+++ b/fs/xfs/libxfs/xfs_ondisk.h
@@ -206,8 +206,9 @@ xfs_check_ondisk_structs(void)
 	XFS_CHECK_VALUE(XFS_DQ_BIGTIME_EXPIRY_MAX << XFS_DQ_BIGTIME_SHIFT,
 			16299260424LL);
 
-	/* fs-verity descriptor xattr name */
-	XFS_CHECK_VALUE(sizeof(XFS_VERITY_DESCRIPTOR_NAME), 6);
+	/* fs-verity xattrs */
+	XFS_CHECK_STRUCT_SIZE(struct xfs_verity_merkle_key,	8);
+	XFS_CHECK_VALUE(sizeof(XFS_VERITY_DESCRIPTOR_NAME),	6);
 }
 
 #endif /* __XFS_ONDISK_H */
diff --git a/fs/xfs/xfs_verity.c b/fs/xfs/xfs_verity.c
index 82340c9130494..dca3b68445343 100644
--- a/fs/xfs/xfs_verity.c
+++ b/fs/xfs/xfs_verity.c
@@ -201,20 +201,20 @@ xfs_verity_cache_store(
 }
 
 static inline void
-xfs_fsverity_merkle_key_to_disk(
-	struct xfs_fsverity_merkle_key	*key,
+xfs_verity_merkle_key_to_disk(
+	struct xfs_verity_merkle_key	*key,
 	u64				offset)
 {
-	key->merkleoff = cpu_to_be64(offset);
+	key->bk_merkleoff = cpu_to_be64(offset);
 }
 
 static inline u64
-xfs_fsverity_merkle_key_from_disk(
+xfs_verity_merkle_key_from_disk(
 	void				*attr_name)
 {
-	struct xfs_fsverity_merkle_key	*key = attr_name;
+	struct xfs_verity_merkle_key	*key = attr_name;
 
-	return be64_to_cpu(key->merkleoff);
+	return be64_to_cpu(key->bk_merkleoff);
 }
 
 static int
@@ -272,7 +272,7 @@ xfs_drop_merkle_tree(
 	u64				merkle_tree_size,
 	unsigned int			tree_blocksize)
 {
-	struct xfs_fsverity_merkle_key	name;
+	struct xfs_verity_merkle_key	name;
 	int				error = 0;
 	u64				offset = 0;
 	struct xfs_da_args		args = {
@@ -281,7 +281,7 @@ xfs_drop_merkle_tree(
 		.attr_filter		= XFS_ATTR_VERITY,
 		.op_flags		= XFS_DA_OP_REMOVE,
 		.name			= (const uint8_t *)&name,
-		.namelen		= sizeof(struct xfs_fsverity_merkle_key),
+		.namelen		= sizeof(struct xfs_verity_merkle_key),
 		/* NULL value make xfs_attr_set remove the attr */
 		.value			= NULL,
 	};
@@ -290,7 +290,7 @@ xfs_drop_merkle_tree(
 		return 0;
 
 	for (offset = 0; offset < merkle_tree_size; offset += tree_blocksize) {
-		xfs_fsverity_merkle_key_to_disk(&name, offset);
+		xfs_verity_merkle_key_to_disk(&name, offset);
 		error = xfs_attr_set(&args);
 		if (error)
 			return error;
@@ -372,12 +372,12 @@ xfs_verity_read_merkle(
 	struct fsverity_blockbuf	*block)
 {
 	struct xfs_inode		*ip = XFS_I(req->inode);
-	struct xfs_fsverity_merkle_key	name;
+	struct xfs_verity_merkle_key	name;
 	struct xfs_da_args		args = {
 		.dp			= ip,
 		.attr_filter		= XFS_ATTR_VERITY,
 		.name			= (const uint8_t *)&name,
-		.namelen		= sizeof(struct xfs_fsverity_merkle_key),
+		.namelen		= sizeof(struct xfs_verity_merkle_key),
 		.valuelen		= block->size,
 	};
 	struct xfs_merkle_blob		*mk, *new_mk;
@@ -386,7 +386,7 @@ xfs_verity_read_merkle(
 
 	ASSERT(block->offset >> req->log_blocksize <= ULONG_MAX);
 
-	xfs_fsverity_merkle_key_to_disk(&name, block->offset);
+	xfs_verity_merkle_key_to_disk(&name, block->offset);
 
 	/* Is the block already cached? */
 	mk = xfs_verity_cache_load(ip, key);
@@ -399,7 +399,7 @@ xfs_verity_read_merkle(
 	args.value = new_mk->data;
 
 	/* Read the block in from disk and try to store it in the cache. */
-	xfs_fsverity_merkle_key_to_disk(&name, block->offset);
+	xfs_verity_merkle_key_to_disk(&name, block->offset);
 
 	error = xfs_attr_get(&args);
 	if (error)
@@ -440,19 +440,18 @@ xfs_verity_write_merkle(
 	unsigned int		size)
 {
 	struct xfs_inode	*ip = XFS_I(inode);
-	struct xfs_fsverity_merkle_key	name;
+	struct xfs_verity_merkle_key	name;
 	struct xfs_da_args	args = {
 		.dp		= ip,
 		.whichfork	= XFS_ATTR_FORK,
 		.attr_filter	= XFS_ATTR_VERITY,
-		.namelen	= sizeof(struct xfs_fsverity_merkle_key),
+		.name		= (const uint8_t *)&name,
+		.namelen	= sizeof(struct xfs_verity_merkle_key),
 		.value		= (void *)buf,
 		.valuelen	= size,
 	};
 
-	xfs_fsverity_merkle_key_to_disk(&name, pos);
-	args.name = (const uint8_t *)&name.merkleoff;
-
+	xfs_verity_merkle_key_to_disk(&name, pos);
 	return xfs_attr_set(&args);
 }
 

