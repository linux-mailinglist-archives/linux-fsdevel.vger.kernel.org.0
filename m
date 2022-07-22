Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4338457E44A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jul 2022 18:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234435AbiGVQYm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jul 2022 12:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiGVQYm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jul 2022 12:24:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1F58AB31;
        Fri, 22 Jul 2022 09:24:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 245A2621BD;
        Fri, 22 Jul 2022 16:24:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 801EFC341C6;
        Fri, 22 Jul 2022 16:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658507080;
        bh=ERD6L0tGWO0x9Vzt+94y6IPYs2il1yz7+hLCIIQ9VMQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M7syBNh7Q+slzlSg95Ty+U3caUx3OkvdZKYgFaT6zO7YKN9OsdTxAXKpzM/fQ8EUj
         8laTCMg9BidYfI43AVNQjAskrSgTEIhdawoWcCWFN1EAKRyOqivbfv7qK9N59+Vvnq
         ixHzlI/3Lkn2UIyRqLOaAICt3NyJKQeAO9La4LBsM3B/cUM9f6Cxa2XXZSNWSWP4n7
         eKglhO2cux23pKTuvR31k1jROOcx4Jvj6L34W3fwmJ0EjPxsmlZpViqsKNhWnWhV8U
         qZwtGZ8Kg87h7OJAYIWHEdlyKK+giZJRMb/S/JIukT8Eyn8v4Et7jPN0R8WTIdRmRv
         SETEtPcVhPZPQ==
Date:   Fri, 22 Jul 2022 09:24:39 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v4 9/9] xfs: support STATX_DIOALIGN
Message-ID: <YtrPRysafr5KK3NQ@magnolia>
References: <20220722071228.146690-1-ebiggers@kernel.org>
 <20220722071228.146690-10-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722071228.146690-10-ebiggers@kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 22, 2022 at 12:12:28AM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Add support for STATX_DIOALIGN to xfs, so that direct I/O alignment
> restrictions are exposed to userspace in a generic way.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

LGTM
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_iops.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index 29f5b8b8aca69a..bac3f56141801e 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -605,6 +605,15 @@ xfs_vn_getattr(
>  		stat->blksize = BLKDEV_IOSIZE;
>  		stat->rdev = inode->i_rdev;
>  		break;
> +	case S_IFREG:
> +		if (request_mask & STATX_DIOALIGN) {
> +			struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
> +
> +			stat->result_mask |= STATX_DIOALIGN;
> +			stat->dio_mem_align = target->bt_logical_sectorsize;
> +			stat->dio_offset_align = target->bt_logical_sectorsize;
> +		}
> +		fallthrough;
>  	default:
>  		stat->blksize = xfs_stat_blksize(ip);
>  		stat->rdev = 0;
> -- 
> 2.37.0
> 
