Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 528455A5368
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Aug 2022 19:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiH2RnK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Aug 2022 13:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiH2RnI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Aug 2022 13:43:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E420B99B69;
        Mon, 29 Aug 2022 10:43:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 806C76130F;
        Mon, 29 Aug 2022 17:43:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9874AC433C1;
        Mon, 29 Aug 2022 17:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661794986;
        bh=cxPPEBu+h0eaOoH6XNEDFwMgVRSEBxa1GviI21BIVfs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C7UlN/rxD1A07hajY7oNwvf4lBdkN65KxQB1PgDkV11i2ewgJZBMX2GpgYHrDAsTy
         Oln4C1jZ/ElA2r8VlroJ3K03byLr/6Am5E58SrcKgBrWqbzl70Gns18A6A38kusjJv
         6TxtKkFiWv2KEifYCjR7FYeB3c+69CN7AwLymixPQ/MDrVmUKfE7Aij5o89rj+NRG9
         Si3LhZdBnIymBkFvxm/nm/0b6yK3L+URLZaYy/jBTOo8RtodYDoOC3yFMeWb11eTac
         wu3UH/FJDlPjhCmTOCt/B8QvlZq5enC/ZWKX/3pvfn9OVCww54CR/COe0N8aRbvF/P
         LI7nY9FXequHw==
Date:   Mon, 29 Aug 2022 10:43:04 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v5 7/8] f2fs: support STATX_DIOALIGN
Message-ID: <Ywz6qH51lzdYy717@google.com>
References: <20220827065851.135710-1-ebiggers@kernel.org>
 <20220827065851.135710-8-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220827065851.135710-8-ebiggers@kernel.org>
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
> Add support for STATX_DIOALIGN to f2fs, so that direct I/O alignment
> restrictions are exposed to userspace in a generic way.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Acked-by: Jaegeuk Kim <jaegeuk@kernel.org>

> ---
>  fs/f2fs/file.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 8e11311db21060..79177050732803 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -847,6 +847,24 @@ int f2fs_getattr(struct user_namespace *mnt_userns, const struct path *path,
>  		stat->btime.tv_nsec = fi->i_crtime.tv_nsec;
>  	}
>  
> +	/*
> +	 * Return the DIO alignment restrictions if requested.  We only return
> +	 * this information when requested, since on encrypted files it might
> +	 * take a fair bit of work to get if the file wasn't opened recently.
> +	 *
> +	 * f2fs sometimes supports DIO reads but not DIO writes.  STATX_DIOALIGN
> +	 * cannot represent that, so in that case we report no DIO support.
> +	 */
> +	if ((request_mask & STATX_DIOALIGN) && S_ISREG(inode->i_mode)) {
> +		unsigned int bsize = i_blocksize(inode);
> +
> +		stat->result_mask |= STATX_DIOALIGN;
> +		if (!f2fs_force_buffered_io(inode, WRITE)) {
> +			stat->dio_mem_align = bsize;
> +			stat->dio_offset_align = bsize;
> +		}
> +	}
> +
>  	flags = fi->i_flags;
>  	if (flags & F2FS_COMPR_FL)
>  		stat->attributes |= STATX_ATTR_COMPRESSED;
> -- 
> 2.37.2
