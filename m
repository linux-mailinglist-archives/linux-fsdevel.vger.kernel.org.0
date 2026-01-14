Return-Path: <linux-fsdevel+bounces-73608-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFF3D1CA49
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 07:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4311E3013321
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 06:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F7335EDB3;
	Wed, 14 Jan 2026 06:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ljKyQCpW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6CF2BD02A;
	Wed, 14 Jan 2026 06:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768371031; cv=none; b=eDVnOK9BZoGGpvWvCa+SJORyAM42Kq8gGpE9cZYkVLHDd/6ZuAU8s9p4RZZGqlbaac59UhLsUgxnGXbRN1xBgwpBlelUQU+zNoO8knziwgSy0QVEUpjyVxg9qaCRC7rNR8TAuJtOeVFSqy4rAULtVbVCxC/MJlYv75COAf+SNTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768371031; c=relaxed/simple;
	bh=eCzNxGmeysFM0a2jMgS3nYluktTomTCaz0rGyCnslmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GvXpKVUq4oR8Th7Bkt++pdpEc3E78An2KkwTj1Jw9vRGhxMYikIKux2l0G7mupDbbaoKcBnAeXX1R5ZarACv03t+MwkznMm98X7lGFzMQcs4thWyTcDMo/Y9zLKcqqovaLs7CP67xAjzDw/sgswJl/XzXnx4PK5ps8AnRuY19KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ljKyQCpW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 151DAC4CEF7;
	Wed, 14 Jan 2026 06:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768371029;
	bh=eCzNxGmeysFM0a2jMgS3nYluktTomTCaz0rGyCnslmc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ljKyQCpW25KdE3kxUvja9fihsHEkGSOGCUD5pp7qDSJEwgCojGt4N8MqqJGNPKt7b
	 npIOY9Tma8iS2YngCPI0QgvugssoMCkyRfxJZGj0XeTExWaii5G00StQfBmXpk3o53
	 9r6c1QSw3XtXL5mmgZPv4jJpyxyZcz/xy17+/G7qFNjVRPX2XdPnS8g9XQrsukkRWp
	 FTXNsqjKvpHuD+b2WU7z3STgAIXHZIQcVHGi3LauEixwoC3U5C/MgQ8EVWx3r5jIkW
	 b4zsy6DlxDv3U4BqDEBTox4EC97PnkUJs2cV5ziMwtH0FUOpdFvDN8RFNSuLVC1N9D
	 cQPVjjKNb85ow==
Date: Tue, 13 Jan 2026 22:10:28 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>
Cc: Christoph Hellwig <hch@lst.de>, Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Carlos Maiolino <cem@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>, Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>, Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-unionfs@vger.kernel.org,
	kernel-dev@igalia.com
Subject: Re: [PATCH 1/3] exportfs: Rename get_uuid() to get_disk_uuid()
Message-ID: <20260114061028.GF15551@frogsfrogsfrogs>
References: <20260114-tonyk-get_disk_uuid-v1-0-e6a319e25d57@igalia.com>
 <20260114-tonyk-get_disk_uuid-v1-1-e6a319e25d57@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260114-tonyk-get_disk_uuid-v1-1-e6a319e25d57@igalia.com>

On Wed, Jan 14, 2026 at 01:31:41AM -0300, André Almeida wrote:
> To make clear which UUID is being returned, rename get_uuid() to
> get_disk_uuid(). Expand the function documentation to note that this
> function can be also used for filesystem that supports cloned devices
> that might have different UUIDs for userspace tools, while having the
> same UUID for internal usage.

I'm not sure what a "disk uuid" is -- XFS can store two of them in the
ondisk superblock: the admin-modifiable one that blkid reports, and the
secret one that's stamped in all the metadata and cannot change.

IIRC XFS only shares the user-visible UUID, but they're both from the
disk.   Also I'm not sure what a non-disk filesystem is supposed to
provide here?

--D

> Signed-off-by: André Almeida <andrealmeid@igalia.com>
> ---
>  fs/nfsd/blocklayout.c    | 2 +-
>  fs/nfsd/nfs4layouts.c    | 2 +-
>  fs/xfs/xfs_export.c      | 2 +-
>  fs/xfs/xfs_pnfs.c        | 2 +-
>  fs/xfs/xfs_pnfs.h        | 2 +-
>  include/linux/exportfs.h | 8 +++++---
>  6 files changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
> index afa16d7a8013..713a1f69f8fe 100644
> --- a/fs/nfsd/blocklayout.c
> +++ b/fs/nfsd/blocklayout.c
> @@ -218,7 +218,7 @@ nfsd4_block_get_device_info_simple(struct super_block *sb,
>  
>  	b->type = PNFS_BLOCK_VOLUME_SIMPLE;
>  	b->simple.sig_len = PNFS_BLOCK_UUID_LEN;
> -	return sb->s_export_op->get_uuid(sb, b->simple.sig, &b->simple.sig_len,
> +	return sb->s_export_op->get_disk_uuid(sb, b->simple.sig, &b->simple.sig_len,
>  			&b->simple.offset);
>  }
>  
> diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
> index ad7af8cfcf1f..50bb29b2017c 100644
> --- a/fs/nfsd/nfs4layouts.c
> +++ b/fs/nfsd/nfs4layouts.c
> @@ -136,7 +136,7 @@ void nfsd4_setup_layout_type(struct svc_export *exp)
>  	exp->ex_layout_types |= 1 << LAYOUT_FLEX_FILES;
>  #endif
>  #ifdef CONFIG_NFSD_BLOCKLAYOUT
> -	if (sb->s_export_op->get_uuid &&
> +	if (sb->s_export_op->get_disk_uuid &&
>  	    sb->s_export_op->map_blocks &&
>  	    sb->s_export_op->commit_blocks)
>  		exp->ex_layout_types |= 1 << LAYOUT_BLOCK_VOLUME;
> diff --git a/fs/xfs/xfs_export.c b/fs/xfs/xfs_export.c
> index 201489d3de08..d09570ba7445 100644
> --- a/fs/xfs/xfs_export.c
> +++ b/fs/xfs/xfs_export.c
> @@ -244,7 +244,7 @@ const struct export_operations xfs_export_operations = {
>  	.get_parent		= xfs_fs_get_parent,
>  	.commit_metadata	= xfs_fs_nfs_commit_metadata,
>  #ifdef CONFIG_EXPORTFS_BLOCK_OPS
> -	.get_uuid		= xfs_fs_get_uuid,
> +	.get_disk_uuid		= xfs_fs_get_disk_uuid,
>  	.map_blocks		= xfs_fs_map_blocks,
>  	.commit_blocks		= xfs_fs_commit_blocks,
>  #endif
> diff --git a/fs/xfs/xfs_pnfs.c b/fs/xfs/xfs_pnfs.c
> index afe7497012d4..6ef7b29c4060 100644
> --- a/fs/xfs/xfs_pnfs.c
> +++ b/fs/xfs/xfs_pnfs.c
> @@ -50,7 +50,7 @@ xfs_break_leased_layouts(
>   * the exported device.
>   */
>  int
> -xfs_fs_get_uuid(
> +xfs_fs_get_disk_uuid(
>  	struct super_block	*sb,
>  	u8			*buf,
>  	u32			*len,
> diff --git a/fs/xfs/xfs_pnfs.h b/fs/xfs/xfs_pnfs.h
> index 940c6c2ad88c..df82a6ba1a11 100644
> --- a/fs/xfs/xfs_pnfs.h
> +++ b/fs/xfs/xfs_pnfs.h
> @@ -3,7 +3,7 @@
>  #define _XFS_PNFS_H 1
>  
>  #ifdef CONFIG_EXPORTFS_BLOCK_OPS
> -int xfs_fs_get_uuid(struct super_block *sb, u8 *buf, u32 *len, u64 *offset);
> +int xfs_fs_get_disk_uuid(struct super_block *sb, u8 *buf, u32 *len, u64 *offset);
>  int xfs_fs_map_blocks(struct inode *inode, loff_t offset, u64 length,
>  		struct iomap *iomap, bool write, u32 *device_generation);
>  int xfs_fs_commit_blocks(struct inode *inode, struct iomap *maps, int nr_maps,
> diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> index 262e24d83313..dc7029949a62 100644
> --- a/include/linux/exportfs.h
> +++ b/include/linux/exportfs.h
> @@ -252,8 +252,10 @@ struct handle_to_path_ctx {
>   * @commit_metadata:
>   *    @commit_metadata should commit metadata changes to stable storage.
>   *
> - * @get_uuid:
> - *    Get a filesystem unique signature exposed to clients.
> + * @get_disk_uuid:
> + *    Get a filesystem unique signature exposed to clients. It's also useful for
> + *    filesystems that support mounting cloned disks and export different UUIDs
> + *    for userspace, while being internally the same.
>   *
>   * @map_blocks:
>   *    Map and, if necessary, allocate blocks for a layout.
> @@ -282,7 +284,7 @@ struct export_operations {
>  	struct dentry * (*get_parent)(struct dentry *child);
>  	int (*commit_metadata)(struct inode *inode);
>  
> -	int (*get_uuid)(struct super_block *sb, u8 *buf, u32 *len, u64 *offset);
> +	int (*get_disk_uuid)(struct super_block *sb, u8 *buf, u32 *len, u64 *offset);
>  	int (*map_blocks)(struct inode *inode, loff_t offset,
>  			  u64 len, struct iomap *iomap,
>  			  bool write, u32 *device_generation);
> 
> -- 
> 2.52.0
> 
> 

