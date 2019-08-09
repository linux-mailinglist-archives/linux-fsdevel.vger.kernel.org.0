Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA8987ADE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2019 15:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406678AbfHINMV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Aug 2019 09:12:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:52150 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726157AbfHINMU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Aug 2019 09:12:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F2F91B023;
        Fri,  9 Aug 2019 13:12:18 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id F10761E46DD; Fri,  9 Aug 2019 15:05:27 +0200 (CEST)
Date:   Fri, 9 Aug 2019 15:05:27 +0200
From:   Jan Kara <jack@suse.cz>
To:     " Steven J. Magnani " <steve.magnani@digidescorp.com>
Cc:     Jan Kara <jack@suse.com>, Steve Magnani <steve@digidescorp.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] udf: reduce leakage of blocks related to named streams
Message-ID: <20190809130527.GD17568@quack2.suse.cz>
References: <20190807133258.12432-1-steve@digidescorp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807133258.12432-1-steve@digidescorp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 07-08-19 08:32:58,  Steven J. Magnani  wrote:
> From: Steve Magnani <steve@digidescorp.com>
> 
> Windows is capable of creating UDF files having named streams.
> One example is the "Zone.Identifier" stream attached automatically
> to files downloaded from a network. See:
>   https://msdn.microsoft.com/en-us/library/dn392609.aspx
> 
> Modification of a file having one or more named streams in Linux causes
> the stream directory to become detached from the file, essentially leaking
> all blocks pertaining to the file's streams. Worse, an attempt to delete
> the file causes its directory entry (FID) to be deleted, but because the
> driver believes that a hard link to the file remains, the Extended File
> Entry (EFE) and all extents of the file itself remain allocated. Since
> there is no hard link, after the FID has been deleted all of these blocks
> are unreachable (leaked).
> 
> A complete solution to this problem involves walking the File Identifiers
> in the file's stream directory and freeing all extents allocated to each
> named stream (each of which involves a walk of arbitrary length). As the
> complete solution is quite complex, for now just settle for retaining the
> stream directory attachment during file modification, and being able to
> reclaim the blocks of the file, its Extended File Entry, and its Stream
> Directory EFE during file deletion.
> 
> The UDF structures used by Windows to attach a simple Zone.Identifier
> named stream to a file are:
> * A stream directory EFE containing an "in ICB" Zone.Identifier FID,
>   which references
> * An EFE with "in ICB" stream data
> 
> For this case, this partial solution reduces the number of blocks leaked
> during file deletion to just one (the EFE containing the stream data).
> 
> Signed-off-by: Steven J. Magnani <steve@digidescorp.com>

Thanks for the patch! I was thinking about this and rather than this
partial fix, I'd prefer to fail the last unlink of an inode with
a named-stream directory with EOPNOTSUPP. Later we can properly handle this
and walk the named-stream directory and remove all associated EFEs for the
named streams. After all named-stream directories are restricted to not
have any subdirectories, hardlinks, or anything similarly fancy so the walk
should not be *that* hard to implement.

								Honza

> 
> --- a/fs/udf/udf_i.h	2019-07-26 11:35:28.257563879 -0500
> +++ b/fs/udf/udf_i.h	2019-08-06 14:35:55.579654263 -0500
> @@ -42,12 +42,15 @@ struct udf_inode_info {
>  	unsigned		i_efe : 1;	/* extendedFileEntry */
>  	unsigned		i_use : 1;	/* unallocSpaceEntry */
>  	unsigned		i_strat4096 : 1;
> -	unsigned		reserved : 26;
> +	unsigned		i_streamdir : 1;
> +	unsigned		reserved : 25;
>  	union {
>  		struct short_ad	*i_sad;
>  		struct long_ad		*i_lad;
>  		__u8		*i_data;
>  	} i_ext;
> +	struct kernel_lb_addr		i_locStreamdir;
> +	__u64			i_lenStreams;
>  	struct rw_semaphore	i_data_sem;
>  	struct udf_ext_cache cached_extent;
>  	/* Spinlock for protecting extent cache */
> --- a/fs/udf/super.c	2019-07-26 11:35:28.253563792 -0500
> +++ b/fs/udf/super.c	2019-08-06 15:04:30.851086957 -0500
> @@ -151,9 +151,13 @@ static struct inode *udf_alloc_inode(str
>  
>  	ei->i_unique = 0;
>  	ei->i_lenExtents = 0;
> +	ei->i_lenStreams = 0;
>  	ei->i_next_alloc_block = 0;
>  	ei->i_next_alloc_goal = 0;
>  	ei->i_strat4096 = 0;
> +	ei->i_streamdir = 0;
> +	ei->i_locStreamdir.logicalBlockNum = 0xFFFFFFFF;
> +	ei->i_locStreamdir.partitionReferenceNum = 0xFFFF;
>  	init_rwsem(&ei->i_data_sem);
>  	ei->cached_extent.lstart = -1;
>  	spin_lock_init(&ei->i_extent_cache_lock);
> --- a/fs/udf/inode.c	2019-07-26 11:35:28.253563792 -0500
> +++ b/fs/udf/inode.c	2019-08-06 15:04:30.851086957 -0500
> @@ -132,7 +132,7 @@ void udf_evict_inode(struct inode *inode
>  	struct udf_inode_info *iinfo = UDF_I(inode);
>  	int want_delete = 0;
>  
> -	if (!inode->i_nlink && !is_bad_inode(inode)) {
> +	if ((inode->i_nlink == iinfo->i_streamdir) && !is_bad_inode(inode)) {
>  		want_delete = 1;
>  		udf_setsize(inode, 0);
>  		udf_update_inode(inode, IS_SYNC(inode));
> @@ -1485,6 +1485,10 @@ reread:
>  		iinfo->i_lenEAttr = le32_to_cpu(fe->lengthExtendedAttr);
>  		iinfo->i_lenAlloc = le32_to_cpu(fe->lengthAllocDescs);
>  		iinfo->i_checkpoint = le32_to_cpu(fe->checkpoint);
> +		iinfo->i_streamdir = 0;
> +		iinfo->i_lenStreams = 0;
> +		iinfo->i_locStreamdir.logicalBlockNum = 0xFFFFFFFF;
> +		iinfo->i_locStreamdir.partitionReferenceNum = 0xFFFF;
>  	} else {
>  		inode->i_blocks = le64_to_cpu(efe->logicalBlocksRecorded) <<
>  		    (inode->i_sb->s_blocksize_bits - 9);
> @@ -1498,6 +1502,16 @@ reread:
>  		iinfo->i_lenEAttr = le32_to_cpu(efe->lengthExtendedAttr);
>  		iinfo->i_lenAlloc = le32_to_cpu(efe->lengthAllocDescs);
>  		iinfo->i_checkpoint = le32_to_cpu(efe->checkpoint);
> +
> +		/* Named streams */
> +		iinfo->i_streamdir = (efe->streamDirectoryICB.extLength != 0);
> +		iinfo->i_locStreamdir =
> +			lelb_to_cpu(efe->streamDirectoryICB.extLocation);
> +		iinfo->i_lenStreams = le64_to_cpu(efe->objectSize);
> +		if (iinfo->i_lenStreams >= inode->i_size)
> +			iinfo->i_lenStreams -= inode->i_size;
> +		else
> +			iinfo->i_lenStreams = 0;
>  	}
>  	inode->i_generation = iinfo->i_unique;
>  
> @@ -1760,9 +1774,19 @@ static int udf_update_inode(struct inode
>  		       iinfo->i_ext.i_data,
>  		       inode->i_sb->s_blocksize -
>  					sizeof(struct extendedFileEntry));
> -		efe->objectSize = cpu_to_le64(inode->i_size);
> +		efe->objectSize =
> +			cpu_to_le64(inode->i_size + iinfo->i_lenStreams);
>  		efe->logicalBlocksRecorded = cpu_to_le64(lb_recorded);
>  
> +		if (iinfo->i_streamdir) {
> +			struct long_ad *icb_lad = &efe->streamDirectoryICB;
> +
> +			icb_lad->extLocation =
> +				cpu_to_lelb(iinfo->i_locStreamdir);
> +			icb_lad->extLength =
> +				cpu_to_le32(inode->i_sb->s_blocksize);
> +		}
> +
>  		udf_adjust_time(iinfo, inode->i_atime);
>  		udf_adjust_time(iinfo, inode->i_mtime);
>  		udf_adjust_time(iinfo, inode->i_ctime);
> --- a/fs/udf/ialloc.c	2019-07-26 11:35:28.253563792 -0500
> +++ b/fs/udf/ialloc.c	2019-08-06 15:04:30.851086957 -0500
> @@ -31,6 +31,7 @@ void udf_free_inode(struct inode *inode)
>  	struct super_block *sb = inode->i_sb;
>  	struct udf_sb_info *sbi = UDF_SB(sb);
>  	struct logicalVolIntegrityDescImpUse *lvidiu = udf_sb_lvidiu(sb);
> +	struct udf_inode_info *iinfo = UDF_I(inode);
>  
>  	if (lvidiu) {
>  		mutex_lock(&sbi->s_alloc_mutex);
> @@ -42,7 +43,13 @@ void udf_free_inode(struct inode *inode)
>  		mutex_unlock(&sbi->s_alloc_mutex);
>  	}
>  
> -	udf_free_blocks(sb, NULL, &UDF_I(inode)->i_location, 0, 1);
> +	udf_free_blocks(sb, NULL, &iinfo->i_location, 0, 1);
> +	if (iinfo->i_streamdir) {
> +		udf_free_blocks(sb, NULL, &iinfo->i_locStreamdir, 0, 1);
> +		udf_warn(inode->i_sb,
> +			 "Leaking unsupported stream blocks for inode %lu\n",
> +			 inode->i_ino);
> +	}
>  }
>  
>  struct inode *udf_new_inode(struct inode *dir, umode_t mode)
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
