Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93096632D7E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Nov 2022 20:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbiKUT5K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Nov 2022 14:57:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbiKUT5G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Nov 2022 14:57:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D142C6554;
        Mon, 21 Nov 2022 11:57:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED73B61459;
        Mon, 21 Nov 2022 19:57:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35496C433D7;
        Mon, 21 Nov 2022 19:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669060625;
        bh=0S4XOGwo8JLg0ERtYdj5E2QGhsxI9pPXvEp0ppPsprM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OFfk8LpZIjWn5wDishxmYljFxu5ByURfAtNEZLwPAS3mit3Dwlzbb+9WHteyi0t5u
         T3XvKwiU32eGxL1K6j6pvBbCzb3i1FVtkku9VtW6MSXwDdopCYlxMcS/9iqMXWeTCx
         sF2LxDKLRDaU9e7JYv6AN6Smj4+0uJJWcLq+tvcLXft1n4UGiNX0RaKsDSM5bafWvP
         JcbD4uC+X0RZ0qTfSMT6cFtKrBbSOCGTaKf0NqUO0wBFOQMWetyedSXCSAz7wsAhTg
         aK5EoYvkyV7FsdXySJISF7lmXhoGP5YMwmN8OP/L9MFSI7YcGDTyPwqapSr2VZRtwM
         qpwdlJE4zz80g==
Date:   Mon, 21 Nov 2022 19:57:03 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] btrfs: replace INT_LIMIT(loff_t) with OFFSET_MAX
Message-ID: <Y3vYDyjqf68jDdo/@gmail.com>
References: <20221121024418.1800-1-thunder.leizhen@huawei.com>
 <20221121024418.1800-2-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121024418.1800-2-thunder.leizhen@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 21, 2022 at 10:44:17AM +0800, Zhen Lei wrote:
> OFFSET_MAX is self-annotated and more readable.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  fs/btrfs/ordered-data.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> index e54f8280031fa14..100d9f4836b177d 100644
> --- a/fs/btrfs/ordered-data.c
> +++ b/fs/btrfs/ordered-data.c
> @@ -761,11 +761,11 @@ int btrfs_wait_ordered_range(struct inode *inode, u64 start, u64 len)
>  	struct btrfs_ordered_extent *ordered;
>  
>  	if (start + len < start) {
> -		orig_end = INT_LIMIT(loff_t);
> +		orig_end = OFFSET_MAX;
>  	} else {
>  		orig_end = start + len - 1;
> -		if (orig_end > INT_LIMIT(loff_t))
> -			orig_end = INT_LIMIT(loff_t);
> +		if (orig_end > OFFSET_MAX)
> +			orig_end = OFFSET_MAX;
>  	}
>  
>  	/* start IO across the range first to instantiate any delalloc
> -- 

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
