Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 305DF6C4E63
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Mar 2023 15:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbjCVOr0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 10:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbjCVOrI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:47:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B16F664F5
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Mar 2023 07:45:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F04662135
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Mar 2023 14:44:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6E70C433D2;
        Wed, 22 Mar 2023 14:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679496265;
        bh=hfHCGcSbkzny8O3209vje615o7oQwwqYMiFAmIEX6Bg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cTm/ySXDFdoS7MpUx/dhdxnsDrK8q3TywyTZnZMz2F8k5VKX9vdUq1caKbvNkKeBY
         lXub6Qiaz1K7eAu5YQTc+OSydWxqsjaeUHcZl7qWGqgSoUozzpjJJSBdjiSRDXpQ3J
         ONRnt1teRvXrWEBOlt7R64TmFAzYhddKarKv0sYOt4ej06V/9z1cD64lCam+0LxXCn
         wgsePdd/FmF8FDpq2eS1dH/8Wief1qSXUnHnvKAFaAxYk1nX6HqCYypRdES0yri+tR
         7ujgD15OwI+W+0liDtparH7Q0zRsNG3Jvp/ri+ZaksjDK3Ohzvk9tCJrgEv2I8pL7p
         jEZs1KCnfSPPA==
Date:   Wed, 22 Mar 2023 07:44:25 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        dan.j.williams@intel.com, willy@infradead.org, jack@suse.cz,
        akpm@linux-foundation.org
Subject: Re: [PATCH] fsdax: dedupe should compare the min of two iters' length
Message-ID: <20230322144425.GB11351@frogsfrogsfrogs>
References: <1679469958-2-1-git-send-email-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1679469958-2-1-git-send-email-ruansy.fnst@fujitsu.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 22, 2023 at 07:25:58AM +0000, Shiyang Ruan wrote:
> In an dedupe corporation iter loop, the length of iomap_iter decreases
> because it implies the remaining length after each iteration.  The
> compare function should use the min length of the current iters, not the
> total length.
> 
> Fixes: 0e79e3736d54 ("fsdax: dedupe: iter two files at the same time")
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>

Makese sense,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/dax.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index 3e457a16c7d1..9800b93ee14d 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -2022,8 +2022,8 @@ int dax_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
>  
>  	while ((ret = iomap_iter(&src_iter, ops)) > 0 &&
>  	       (ret = iomap_iter(&dst_iter, ops)) > 0) {
> -		compared = dax_range_compare_iter(&src_iter, &dst_iter, len,
> -						  same);
> +		compared = dax_range_compare_iter(&src_iter, &dst_iter,
> +				min(src_iter.len, dst_iter.len), same);
>  		if (compared < 0)
>  			return ret;
>  		src_iter.processed = dst_iter.processed = compared;
> -- 
> 2.39.2
> 
