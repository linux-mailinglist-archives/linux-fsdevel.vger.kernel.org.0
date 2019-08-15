Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 673888EBC1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2019 14:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731878AbfHOMmV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Aug 2019 08:42:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:58750 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725977AbfHOMmV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Aug 2019 08:42:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2F32BABBE;
        Thu, 15 Aug 2019 12:42:19 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B1FC81E4200; Thu, 15 Aug 2019 14:42:18 +0200 (CEST)
Date:   Thu, 15 Aug 2019 14:42:18 +0200
From:   Jan Kara <jack@suse.cz>
To:     " Steven J. Magnani " <steve.magnani@digidescorp.com>
Cc:     Jan Kara <jack@suse.com>,
        "Steven J . Magnani" <steve@digidescorp.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] udf: reduce leakage of blocks related to named streams
Message-ID: <20190815124218.GE14313@quack2.suse.cz>
References: <20190814125002.10869-1-steve@digidescorp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814125002.10869-1-steve@digidescorp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 14-08-19 07:50:02,  Steven J. Magnani  wrote:
> Windows is capable of creating UDF files having named streams.
> One example is the "Zone.Identifier" stream attached automatically
> to files downloaded from a network. See:
>   https://msdn.microsoft.com/en-us/library/dn392609.aspx
> 
> Modification of a file having one or more named streams in Linux causes
> the stream directory to become detached from the file, essentially leaking
> all blocks pertaining to the file's streams.
> 
> Fix by saving off information about an inode's streams when reading it,
> for later use when its on-disk data is updated.

Thanks for the patch! I agree with the idea of this patch. Just some
small comments below.

> Changes from v1:
> Remove modifications that would limit leakage of all inode blocks
> on deletion.
> This restricts the patch to preservation of stream data during inode
> modification.

Please put patch changelog below Signed-off-by and --- delimiter so that it
does not get included in the final commit message when I do git-am.

> Signed-off-by: Steven J. Magnani <steve@digidescorp.com>
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
> +	struct kernel_lb_addr	i_locStreamdir;
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

I don't think you need to initialize i_locStreamdir when i_streamdir is
already set to 0...

>  	init_rwsem(&ei->i_data_sem);
>  	ei->cached_extent.lstart = -1;
>  	spin_lock_init(&ei->i_extent_cache_lock);
> --- a/fs/udf/inode.c	2019-07-26 11:35:28.253563792 -0500
> +++ b/fs/udf/inode.c	2019-08-06 15:04:30.851086957 -0500
> @@ -1485,6 +1485,10 @@ reread:
>  		iinfo->i_lenEAttr = le32_to_cpu(fe->lengthExtendedAttr);
>  		iinfo->i_lenAlloc = le32_to_cpu(fe->lengthAllocDescs);
>  		iinfo->i_checkpoint = le32_to_cpu(fe->checkpoint);
> +		iinfo->i_streamdir = 0;
> +		iinfo->i_lenStreams = 0;
> +		iinfo->i_locStreamdir.logicalBlockNum = 0xFFFFFFFF;
> +		iinfo->i_locStreamdir.partitionReferenceNum = 0xFFFF;

Ditto here...

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

Hum, maybe you could just have i_objectSize instead of i_lenStreams? You
use the field just to preserve objectSize anyway so there's no point in
complicating it.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
