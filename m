Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0644A6E100E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Apr 2023 16:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjDMOfN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Apr 2023 10:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjDMOfB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Apr 2023 10:35:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11FB7D9C;
        Thu, 13 Apr 2023 07:34:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69AAD636F2;
        Thu, 13 Apr 2023 14:34:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0485C433D2;
        Thu, 13 Apr 2023 14:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681396491;
        bh=Izgd1lPSNsSfYsO8CvPujUw68wzoAf+eYqztB6GEfnM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FI72byrQyViDnEtGxWSM4Eb3yGuvD955CQ9d7Lncd0u9oRfajt+efILeZya7FMPPB
         a8aAcMo9OdRCuH7eZZp02bTCdro1vmQakzRK2vDjwdExAWR5YzfpvAIKhJZ54zFbbM
         RwX8pEN8HcoHKMCElSaeGnzvoyI7ecyR4Pfy+NIUBq/gzMN7h4kEj5ELVYKkQ75/GM
         6BXTGgZgg1bTzp8sBC5atNyhlAS+WCYpPkSh7eK9G0jODffNKaNdsdovDcmGxyPuXU
         SYmCmSnjjrXfPhPA1MDyMQo5Mx1loilXoStXe8rFIom69uZ8pOhIHHvpswxjvrGpiU
         +DtE3+744CJqA==
Date:   Thu, 13 Apr 2023 07:34:51 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [RFCv3 08/10] iomap: Remove IOMAP_DIO_NOSYNC unused dio flag
Message-ID: <20230413143451.GB360877@frogsfrogsfrogs>
References: <cover.1681365596.git.ritesh.list@gmail.com>
 <48a867b27a62045987f55b576b7688d16a896d52.1681365596.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48a867b27a62045987f55b576b7688d16a896d52.1681365596.git.ritesh.list@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 13, 2023 at 02:10:30PM +0530, Ritesh Harjani (IBM) wrote:
> IOMAP_DIO_NOSYNC earlier was added for use in btrfs. But it seems for
> aio dsync writes this is not useful anyway. For aio dsync case, we
> we queue the request and return -EIOCBQUEUED. Now, since IOMAP_DIO_NOSYNC
> doesn't let iomap_dio_complete() to call generic_write_sync(),
> hence we may lose the sync write.
> 
> Hence kill this flag as it is not in use by any FS now.
> 
> Tested-by: Disha Goel <disgoel@linux.ibm.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/direct-io.c  | 2 +-
>  include/linux/iomap.h | 6 ------
>  2 files changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index f771001574d0..36ab1152dbea 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -541,7 +541,7 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  		}
>  
>  		/* for data sync or sync, we need sync completion processing */
> -		if (iocb_is_dsync(iocb) && !(dio_flags & IOMAP_DIO_NOSYNC)) {
> +		if (iocb_is_dsync(iocb)) {
>  			dio->flags |= IOMAP_DIO_NEED_SYNC;
>  
>  		       /*
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 0f8123504e5e..e2b836c2e119 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -377,12 +377,6 @@ struct iomap_dio_ops {
>   */
>  #define IOMAP_DIO_PARTIAL		(1 << 2)
>  
> -/*
> - * The caller will sync the write if needed; do not sync it within
> - * iomap_dio_rw.  Overrides IOMAP_DIO_FORCE_WAIT.
> - */
> -#define IOMAP_DIO_NOSYNC		(1 << 3)
> -
>  ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
>  		unsigned int dio_flags, void *private, size_t done_before);
> -- 
> 2.39.2
> 
