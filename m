Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AABD66E1014
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Apr 2023 16:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjDMOfe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Apr 2023 10:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjDMOfd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Apr 2023 10:35:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712B69EF3;
        Thu, 13 Apr 2023 07:35:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F15BC636F5;
        Thu, 13 Apr 2023 14:35:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59579C433D2;
        Thu, 13 Apr 2023 14:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681396531;
        bh=OR4wXytJeJ8PfNpSiJLj2Sj5lxkZ7WbHFnsLJfiRsK0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IygBUGt/a8+wd0iN9ilGGvrrLnzygjRU7VI8ZwXPzRHforodvbyT8JCVENwhS4YCp
         zKQyEjl1Mc5H3SIRAOR3go7XzjKYPQoceTuSOlR1qz5uBHKp1ur6RGDehYeQr+5Svy
         0Xq3NoY2rsqKixy0zkL40UofekTiejeq1hnLb+VK3ieSbJC+NDUQang3Gnb4kqhgbo
         NGqpqHp2pJKmXPbJIUIufX93GDZgIRgVetPlKdJNxkHtuxtuCnif/SODQ3/NxhMfzE
         cKZLrNkZYXM/wA8hDRQcENpHuEiAeoND29vJnLTpubWH1wRQnzrA1ObVJyDeWfYvj+
         aQ0xYkB6v0EAA==
Date:   Thu, 13 Apr 2023 07:35:30 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [RFCv3 09/10] iomap: Minor refactor of iomap_dio_rw
Message-ID: <20230413143530.GC360877@frogsfrogsfrogs>
References: <cover.1681365596.git.ritesh.list@gmail.com>
 <ac0b5e5778585f8d02b4abc355f185cba261b239.1681365596.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac0b5e5778585f8d02b4abc355f185cba261b239.1681365596.git.ritesh.list@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 13, 2023 at 02:10:31PM +0530, Ritesh Harjani (IBM) wrote:
> The next patch brings in the tracepoint patch for iomap DIO functions.
> This is a small refactor change for having a single out path.
> 
> Tested-by: Disha Goel <disgoel@linux.ibm.com>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

IMHO this could've been part of the next patch instead of separate, but
eh, whatever, looks good to me.
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/direct-io.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 36ab1152dbea..5871956ee880 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -679,11 +679,16 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  		unsigned int dio_flags, void *private, size_t done_before)
>  {
>  	struct iomap_dio *dio;
> +	ssize_t ret = 0;
>  
>  	dio = __iomap_dio_rw(iocb, iter, ops, dops, dio_flags, private,
>  			     done_before);
> -	if (IS_ERR_OR_NULL(dio))
> -		return PTR_ERR_OR_ZERO(dio);
> -	return iomap_dio_complete(dio);
> +	if (IS_ERR_OR_NULL(dio)) {
> +		ret = PTR_ERR_OR_ZERO(dio);
> +		goto out;
> +	}
> +	ret = iomap_dio_complete(dio);
> +out:
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(iomap_dio_rw);
> -- 
> 2.39.2
> 
