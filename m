Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEA0651C41B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 May 2022 17:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244117AbiEEPpO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 May 2022 11:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243704AbiEEPpK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 May 2022 11:45:10 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5DCB532F3;
        Thu,  5 May 2022 08:41:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 05939CE2E50;
        Thu,  5 May 2022 15:41:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FD2AC385A4;
        Thu,  5 May 2022 15:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651765287;
        bh=8tY7ik2G1ldHRLbmbjw0SfsVLofsLwZPaHeobuJTuFE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oITRBP3x8dU+04yOvM2PSQR/7qNJeN8GhMlflfauPcTOKnY9PCT3O5oEXeADQorky
         R5odvPIgXrkyhlTy+OaNw2xgmeDCnWRuTyEXRHq84+EEdaQ0HmyEk5Pwncz+vGBwGy
         +I2n+q7mqvp/8VTEfl+Q3qav9EaEPq/XxpwgViy4puPurctepUfP6Zlsq+quNIBgl0
         uSaDBuTiISuv4dhdSUkk66gzXyxPRvzUK+KO8UkCb4azCyqV2AItYruxDh0d/1Hc2A
         2JZ5mcVmPDO3TfUINX+1lwFctOKO21dxddEsxxq9uDriKcRnKX8FefIB7i/trVLyj/
         ZpXAKJPcOMJpQ==
Date:   Thu, 5 May 2022 08:41:26 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/5] iomap: add per-iomap_iter private data
Message-ID: <20220505154126.GB27155@magnolia>
References: <20220504162342.573651-1-hch@lst.de>
 <20220504162342.573651-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504162342.573651-3-hch@lst.de>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 04, 2022 at 09:23:39AM -0700, Christoph Hellwig wrote:
> Allow the file system to keep state for all iterations.  For now only
> wire it up for direct I/O as there is an immediate need for it there.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/iomap/direct-io.c  | 8 ++++++++
>  include/linux/iomap.h | 1 +
>  2 files changed, 9 insertions(+)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 15929690d89e3..355abe2eacc6a 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -520,6 +520,14 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  	dio->submit.waiter = current;
>  	dio->submit.poll_bio = NULL;
>  
> +	/*
> +	 * Transfer the private data that was passed by the caller to the
> +	 * iomap_iter, and clear it in the iocb, as iocb->private will be
> +	 * used for polled bio completion later.
> +	 */
> +	iomi.private = iocb->private;
> +	WRITE_ONCE(iocb->private, NULL);

Do we need to transfer it back after the bio completes?  Or is it a
feature that iocb->private changes to the bio?

--D

> +
>  	if (iov_iter_rw(iter) == READ) {
>  		if (iomi.pos >= dio->i_size)
>  			goto out_free_dio;
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index a5483020dad41..109c055865f73 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -188,6 +188,7 @@ struct iomap_iter {
>  	unsigned flags;
>  	struct iomap iomap;
>  	struct iomap srcmap;
> +	void *private;
>  };
>  
>  int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops);
> -- 
> 2.30.2
> 
