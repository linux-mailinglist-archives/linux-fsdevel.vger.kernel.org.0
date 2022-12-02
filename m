Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0004F63FC76
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Dec 2022 01:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbiLBAFy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Dec 2022 19:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbiLBAFs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Dec 2022 19:05:48 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE09C82DB;
        Thu,  1 Dec 2022 16:05:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 18DBCCE1D5D;
        Fri,  2 Dec 2022 00:05:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BD4CC43150;
        Fri,  2 Dec 2022 00:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669939538;
        bh=L6gBULzhRK7OzgCLtfjp0tObT6lwTFeGydXQwDKFfuk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AFNa4HAUVNlhARyuZW89QcJfCEhpDVZfAximztn5gJjqfia5fU6wXOGMwYoXNV/Da
         jEvzG7bmCGisu0B1vC6cD8ExXWesbkPElbPgWH0zLaAaP6B0+2c3wkIF716fqgQ9LP
         ur7HipbKaPkCTeNGCRja0aJzLcUranYd//32/Y3xLg6bBPG6K9Zjqd7aIvh2mDIhEt
         euqq0i9vXsBR69y1Kh+lkVlHPc1qMOKRKh1DHLpLmy4TYgU4aQEZ5757mMs2fM+WeX
         fWuVjeh30Th6ETK6FTOqZoOIDs+2H8+EHy5ZigvF0aqv1Mgmap+PINku4SGCDDB+1g
         3NQnfLfSBfY4Q==
Date:   Thu, 1 Dec 2022 16:05:37 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, dan.j.williams@intel.com,
        akpm@linux-foundation.org
Subject: Re: [PATCH v2 5/8] fsdax: dedupe: iter two files at the same time
Message-ID: <Y4lBUX/XzCjrRQCc@magnolia>
References: <1669908538-55-1-git-send-email-ruansy.fnst@fujitsu.com>
 <1669908701-93-1-git-send-email-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1669908701-93-1-git-send-email-ruansy.fnst@fujitsu.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 01, 2022 at 03:31:41PM +0000, Shiyang Ruan wrote:
> The iomap_iter() on a range of one file may loop more than once.  In
> this case, the inner dst_iter can update its iomap but the outer
> src_iter can't.  This may cause the wrong remapping in filesystem.  Let
> them called at the same time.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>

Thank you for adding that explanation, it makes the problem much more
obvious. :)

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/dax.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index f1eb59bee0b5..354be56750c2 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -1964,15 +1964,15 @@ int dax_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
>  		.len		= len,
>  		.flags		= IOMAP_DAX,
>  	};
> -	int ret;
> +	int ret, compared = 0;
>  
> -	while ((ret = iomap_iter(&src_iter, ops)) > 0) {
> -		while ((ret = iomap_iter(&dst_iter, ops)) > 0) {
> -			dst_iter.processed = dax_range_compare_iter(&src_iter,
> -						&dst_iter, len, same);
> -		}
> -		if (ret <= 0)
> -			src_iter.processed = ret;
> +	while ((ret = iomap_iter(&src_iter, ops)) > 0 &&
> +	       (ret = iomap_iter(&dst_iter, ops)) > 0) {
> +		compared = dax_range_compare_iter(&src_iter, &dst_iter, len,
> +						  same);
> +		if (compared < 0)
> +			return ret;
> +		src_iter.processed = dst_iter.processed = compared;
>  	}
>  	return ret;
>  }
> -- 
> 2.38.1
> 
