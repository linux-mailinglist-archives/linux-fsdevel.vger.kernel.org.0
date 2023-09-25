Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C07C7ADAFC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Sep 2023 17:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbjIYPJK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Sep 2023 11:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbjIYPJJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Sep 2023 11:09:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1393D11B;
        Mon, 25 Sep 2023 08:09:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97C25C433C8;
        Mon, 25 Sep 2023 15:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695654542;
        bh=N+2ZXsRFpTRKK6Mkij+zHbgHBXUeyzDyPcts7rGE+jg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IrQRGjTESxEIm4K1g0GW7BkC5rBOJDLwV71cPuY3W+/xoTU3dw5LhTA9Eegu/x4pP
         iKFkG2eCPMeKmkrtr/8mtW9Gcz+rscltbg3n61CdG3lCmX68oCcMmxr1NCp1UDfLAY
         QstW8cy5GfbRsU/um+KGUGolrWhmRfX8psWM8Clo+rotcA1M1fM5rF5eDuCj44ZmaV
         1YFY7HqJVz10FOzigif/v5LX62ZwGEkr24aAu4As5OF4BzQ46vVUwsDWCxY7lZmKj9
         i1hDu1/qRGVhphdNc1T7aBB825wH4QKkgAcOR4s7CUFbc7QEZe4BXtKEZNJATL4kf6
         5vIeDWV66cCMA==
Date:   Mon, 25 Sep 2023 08:09:02 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        brauner@kernel.org,
        syzbot+1fa947e7f09e136925b8@syzkaller.appspotmail.com
Subject: Re: [PATCH] iomap: add a workaround for racy i_size updates on block
 devices
Message-ID: <20230925150902.GA11456@frogsfrogsfrogs>
References: <20230925095133.311224-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925095133.311224-1-hch@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 25, 2023 at 11:51:33AM +0200, Christoph Hellwig wrote:
> A szybot reproducer that does write I/O while truncating the size of a
> block device can end up in clean_bdev_aliases, which tries to clean the
> bdev aliases that it uses.  This is because iomap_to_bh automatically
> sets the BH_New flag when outside of i_size.  For block devices updates
> to i_size are racy and we can hit this case in a tiny race window,
> leading to the eventual clean_bdev_aliases call.  Fix this by erroring
> out of > i_size I/O on block devices.
> 
> Reported-by: syzbot+1fa947e7f09e136925b8@syzkaller.appspotmail.com
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Tested-by: syzbot+1fa947e7f09e136925b8@syzkaller.appspotmail.com
> ---
>  fs/buffer.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index a6785cd07081cb..12e9a71c693d74 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -2058,8 +2058,17 @@ iomap_to_bh(struct inode *inode, sector_t block, struct buffer_head *bh,
>  		fallthrough;
>  	case IOMAP_MAPPED:
>  		if ((iomap->flags & IOMAP_F_NEW) ||
> -		    offset >= i_size_read(inode))
> +		    offset >= i_size_read(inode)) {
> +			/*
> +			 * This can happen if truncating the block device races
> +			 * with the check in the caller as i_size updates on
> +			 * block devices aren't synchronized by i_rwsem for
> +			 * block devices.

Why /are/ bdevs special like this (not holding i_rwsem during a
truncate) anyway?  Is it because we require the sysadmin to coordinate
device shrink vs. running programs?

--D

> +			 */
> +			if (S_ISBLK(inode->i_mode))
> +				return -EIO;
>  			set_buffer_new(bh);
> +		}
>  		bh->b_blocknr = (iomap->addr + offset - iomap->offset) >>
>  				inode->i_blkbits;
>  		set_buffer_mapped(bh);
> -- 
> 2.39.2
> 
