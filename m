Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2825657E471
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jul 2022 18:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235667AbiGVQcX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jul 2022 12:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235296AbiGVQcX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jul 2022 12:32:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB9893639;
        Fri, 22 Jul 2022 09:32:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A82FBB82970;
        Fri, 22 Jul 2022 16:32:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59770C341C6;
        Fri, 22 Jul 2022 16:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658507539;
        bh=9kjRTVDxL24Wa+68T4xaPpTYLmzvbSMN20xX2dxrB8g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=icBna0IWzDzuvLGufKYYwp3fkc8pRyl7ILh2N+bdXNC1iPTVoM0JORs0pV2YaQBVz
         Dn1UbPnqqQP9pizgMGAEcsx5tX2ZOVzuEX1AbEQ3x1dn695O3l3C6QclFxrjmHnVA9
         NamWnaf2Et59G3UOAsXG7SurBZJtMJqG7HYGLxE6h1AE1ZP6zfU0ZAL2B5WfjNZNNx
         83MvuOF7NkAbfz/jId+XGbTyW0ETGtLxBjdH6sz7ia0qqk4eFEB0k/O4d1t9cw/ns+
         ydzb6a46SRXdSi40XD+gcuTRm7C5PozIJG6VgxIzex6Zcorf457MGnco2D1Nc4VE3k
         +FIQdWH/zmbqQ==
Date:   Fri, 22 Jul 2022 09:32:18 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v4 1/9] statx: add direct I/O alignment information
Message-ID: <YtrREiRZ4Qrdte6t@magnolia>
References: <20220722071228.146690-1-ebiggers@kernel.org>
 <20220722071228.146690-2-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722071228.146690-2-ebiggers@kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 22, 2022 at 12:12:20AM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Traditionally, the conditions for when DIO (direct I/O) is supported
> were fairly simple.  For both block devices and regular files, DIO had
> to be aligned to the logical block size of the block device.
> 
> However, due to filesystem features that have been added over time (e.g.
> multi-device support, data journalling, inline data, encryption, verity,
> compression, checkpoint disabling, log-structured mode), the conditions
> for when DIO is allowed on a regular file have gotten increasingly
> complex.  Whether a particular regular file supports DIO, and with what
> alignment, can depend on various file attributes and filesystem mount
> options, as well as which block device(s) the file's data is located on.
> 
> Moreover, the general rule of DIO needing to be aligned to the block
> device's logical block size is being relaxed to allow user buffers (but
> not file offsets) aligned to the DMA alignment instead
> (https://lore.kernel.org/linux-block/20220610195830.3574005-1-kbusch@fb.com/T/#u).
> 
> XFS has an ioctl XFS_IOC_DIOINFO that exposes DIO alignment information.
> Uplifting this to the VFS is one possibility.  However, as discussed
> (https://lore.kernel.org/linux-fsdevel/20220120071215.123274-1-ebiggers@kernel.org/T/#u),
> this ioctl is rarely used and not known to be used outside of
> XFS-specific code.  It was also never intended to indicate when a file
> doesn't support DIO at all, nor was it intended for block devices.
> 
> Therefore, let's expose this information via statx().  Add the
> STATX_DIOALIGN flag and two new statx fields associated with it:
> 
> * stx_dio_mem_align: the alignment (in bytes) required for user memory
>   buffers for DIO, or 0 if DIO is not supported on the file.
> 
> * stx_dio_offset_align: the alignment (in bytes) required for file
>   offsets and I/O segment lengths for DIO, or 0 if DIO is not supported
>   on the file.  This will only be nonzero if stx_dio_mem_align is
>   nonzero, and vice versa.
> 
> Note that as with other statx() extensions, if STATX_DIOALIGN isn't set
> in the returned statx struct, then these new fields won't be filled in.
> This will happen if the file is neither a regular file nor a block
> device, or if the file is a regular file and the filesystem doesn't
> support STATX_DIOALIGN.  It might also happen if the caller didn't
> include STATX_DIOALIGN in the request mask, since statx() isn't required
> to return unrequested information.
> 
> This commit only adds the VFS-level plumbing for STATX_DIOALIGN.  For
> regular files, individual filesystems will still need to add code to
> support it.  For block devices, a separate commit will wire it up too.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Looks good to me,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/stat.c                 | 2 ++
>  include/linux/stat.h      | 2 ++
>  include/uapi/linux/stat.h | 4 +++-
>  3 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/stat.c b/fs/stat.c
> index 9ced8860e0f35d..a7930d74448304 100644
> --- a/fs/stat.c
> +++ b/fs/stat.c
> @@ -611,6 +611,8 @@ cp_statx(const struct kstat *stat, struct statx __user *buffer)
>  	tmp.stx_dev_major = MAJOR(stat->dev);
>  	tmp.stx_dev_minor = MINOR(stat->dev);
>  	tmp.stx_mnt_id = stat->mnt_id;
> +	tmp.stx_dio_mem_align = stat->dio_mem_align;
> +	tmp.stx_dio_offset_align = stat->dio_offset_align;
>  
>  	return copy_to_user(buffer, &tmp, sizeof(tmp)) ? -EFAULT : 0;
>  }
> diff --git a/include/linux/stat.h b/include/linux/stat.h
> index 7df06931f25d85..ff277ced50e9fd 100644
> --- a/include/linux/stat.h
> +++ b/include/linux/stat.h
> @@ -50,6 +50,8 @@ struct kstat {
>  	struct timespec64 btime;			/* File creation time */
>  	u64		blocks;
>  	u64		mnt_id;
> +	u32		dio_mem_align;
> +	u32		dio_offset_align;
>  };
>  
>  #endif
> diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
> index 1500a0f58041ae..7cab2c65d3d7fc 100644
> --- a/include/uapi/linux/stat.h
> +++ b/include/uapi/linux/stat.h
> @@ -124,7 +124,8 @@ struct statx {
>  	__u32	stx_dev_minor;
>  	/* 0x90 */
>  	__u64	stx_mnt_id;
> -	__u64	__spare2;
> +	__u32	stx_dio_mem_align;	/* Memory buffer alignment for direct I/O */
> +	__u32	stx_dio_offset_align;	/* File offset alignment for direct I/O */
>  	/* 0xa0 */
>  	__u64	__spare3[12];	/* Spare space for future expansion */
>  	/* 0x100 */
> @@ -152,6 +153,7 @@ struct statx {
>  #define STATX_BASIC_STATS	0x000007ffU	/* The stuff in the normal stat struct */
>  #define STATX_BTIME		0x00000800U	/* Want/got stx_btime */
>  #define STATX_MNT_ID		0x00001000U	/* Got stx_mnt_id */
> +#define STATX_DIOALIGN		0x00002000U	/* Want/got direct I/O alignment info */
>  
>  #define STATX__RESERVED		0x80000000U	/* Reserved for future struct statx expansion */
>  
> -- 
> 2.37.0
> 
