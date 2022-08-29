Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB7E5A534E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Aug 2022 19:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbiH2RhX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Aug 2022 13:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiH2RhV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Aug 2022 13:37:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D66298359;
        Mon, 29 Aug 2022 10:37:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BCC35B81199;
        Mon, 29 Aug 2022 17:37:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A8D4C433D6;
        Mon, 29 Aug 2022 17:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661794637;
        bh=VisVfFlNg3guWb1Uh3Rh6ezVhr8O3Y8hEa+38msXgGM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GscoSoeOHVKI2lcg0f5zeM49fB/QIFy9fiTWTCM24ECcBNKVvuC0m32uPk3e5oFKo
         pMZ6E+up/GbzVPg1dJXbO9xR2Bgus/Avms0DDSkWmlTfu+6aRTezUAbok040CUktbo
         B5GCoqapE20b37gkxTDLGAt8bvpEka4r0uASk0ZOQf9Vo2MpHIlyzMsszKAj9wUf3g
         WWA31D8ziUOc68kWC/gZ/Kj2ypzzngae32aFQyHFDQzCcy1HqjeniNqhZlq2QoY4tY
         QuPggKT/yWcDn2CTwBq17L9W7rv4Kvy2wll3MU+V1/tFcVQefU4uVZp8BbAdsOZIXr
         fwFwv5Th2Xz9A==
Date:   Mon, 29 Aug 2022 10:37:15 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v5 5/8] f2fs: move f2fs_force_buffered_io() into file.c
Message-ID: <Ywz5Sxu78GRJZUp5@google.com>
References: <20220827065851.135710-1-ebiggers@kernel.org>
 <20220827065851.135710-6-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220827065851.135710-6-ebiggers@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 08/26, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> f2fs_force_buffered_io() is only used in file.c, so move it into there.
> No behavior change.  This makes it easier to review later patches.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Acked-by: Jaegeuk Kim <jaegeuk@kernel.org>

> ---
>  fs/f2fs/f2fs.h | 40 ----------------------------------------
>  fs/f2fs/file.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 40 insertions(+), 40 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 0759da1919f4ad..aea816a133a8f1 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -4471,17 +4471,6 @@ static inline void f2fs_i_compr_blocks_update(struct inode *inode,
>  	f2fs_mark_inode_dirty_sync(inode, true);
>  }
>  
> -static inline int block_unaligned_IO(struct inode *inode,
> -				struct kiocb *iocb, struct iov_iter *iter)
> -{
> -	unsigned int i_blkbits = READ_ONCE(inode->i_blkbits);
> -	unsigned int blocksize_mask = (1 << i_blkbits) - 1;
> -	loff_t offset = iocb->ki_pos;
> -	unsigned long align = offset | iov_iter_alignment(iter);
> -
> -	return align & blocksize_mask;
> -}
> -
>  static inline bool f2fs_allow_multi_device_dio(struct f2fs_sb_info *sbi,
>  								int flag)
>  {
> @@ -4492,35 +4481,6 @@ static inline bool f2fs_allow_multi_device_dio(struct f2fs_sb_info *sbi,
>  	return sbi->aligned_blksize;
>  }
>  
> -static inline bool f2fs_force_buffered_io(struct inode *inode,
> -				struct kiocb *iocb, struct iov_iter *iter)
> -{
> -	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> -	int rw = iov_iter_rw(iter);
> -
> -	if (!fscrypt_dio_supported(inode))
> -		return true;
> -	if (fsverity_active(inode))
> -		return true;
> -	if (f2fs_compressed_file(inode))
> -		return true;
> -
> -	/* disallow direct IO if any of devices has unaligned blksize */
> -	if (f2fs_is_multi_device(sbi) && !sbi->aligned_blksize)
> -		return true;
> -
> -	if (f2fs_lfs_mode(sbi) && (rw == WRITE)) {
> -		if (block_unaligned_IO(inode, iocb, iter))
> -			return true;
> -		if (F2FS_IO_ALIGNED(sbi))
> -			return true;
> -	}
> -	if (is_sbi_flag_set(F2FS_I_SB(inode), SBI_CP_DISABLED))
> -		return true;
> -
> -	return false;
> -}
> -
>  static inline bool f2fs_need_verity(const struct inode *inode, pgoff_t idx)
>  {
>  	return fsverity_active(inode) &&
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index ce4905a073b3c4..8a9455bf956f16 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -808,6 +808,46 @@ int f2fs_truncate(struct inode *inode)
>  	return 0;
>  }
>  
> +static int block_unaligned_IO(struct inode *inode, struct kiocb *iocb,
> +			      struct iov_iter *iter)
> +{
> +	unsigned int i_blkbits = READ_ONCE(inode->i_blkbits);
> +	unsigned int blocksize_mask = (1 << i_blkbits) - 1;
> +	loff_t offset = iocb->ki_pos;
> +	unsigned long align = offset | iov_iter_alignment(iter);
> +
> +	return align & blocksize_mask;
> +}
> +
> +static bool f2fs_force_buffered_io(struct inode *inode,
> +				   struct kiocb *iocb, struct iov_iter *iter)
> +{
> +	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> +	int rw = iov_iter_rw(iter);
> +
> +	if (!fscrypt_dio_supported(inode))
> +		return true;
> +	if (fsverity_active(inode))
> +		return true;
> +	if (f2fs_compressed_file(inode))
> +		return true;
> +
> +	/* disallow direct IO if any of devices has unaligned blksize */
> +	if (f2fs_is_multi_device(sbi) && !sbi->aligned_blksize)
> +		return true;
> +
> +	if (f2fs_lfs_mode(sbi) && (rw == WRITE)) {
> +		if (block_unaligned_IO(inode, iocb, iter))
> +			return true;
> +		if (F2FS_IO_ALIGNED(sbi))
> +			return true;
> +	}
> +	if (is_sbi_flag_set(F2FS_I_SB(inode), SBI_CP_DISABLED))
> +		return true;
> +
> +	return false;
> +}
> +
>  int f2fs_getattr(struct user_namespace *mnt_userns, const struct path *path,
>  		 struct kstat *stat, u32 request_mask, unsigned int query_flags)
>  {
> -- 
> 2.37.2
