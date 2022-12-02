Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA7363FC7B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Dec 2022 01:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbiLBAGJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Dec 2022 19:06:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbiLBAF7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Dec 2022 19:05:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D88CAF91;
        Thu,  1 Dec 2022 16:05:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10BBB621CE;
        Fri,  2 Dec 2022 00:05:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 689C7C433D6;
        Fri,  2 Dec 2022 00:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669939557;
        bh=IiyeaxPs1EhycV7peY0dBQYNbMUN49afQfqrUQHkEN0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eyDO0VhDx1Pp6jGfI1Xr4ASibW0lwj74pBQbNpHOlFB1z67REe5U86dIMwo+tvB9r
         WCx5fRLPRoQ8uiYSt7JHhXQmgQi7B4f4D1B7rW8FpUx8SxDYfiPyGyNDvduN4OXq6+
         gpkZzvmtKwYFUfwfvpHQ2HAGNBMNgL3QfmyAH6JQFzOeenyY54G+fr0yvvf9G0ADZv
         WHd1cnH1q+q5qD5bI34s1GCHwMo/El4vGCDRiqaWwQzWDQuKqRnARgP7l0Q7ugfGp+
         HxcbOuHQd9uABhgaZ9LyeDn7PFIFB8SjA5w0my3uHCnqkMkKaKGLXHLa+noQjZbzVj
         Vx3cFppGgkQGA==
Date:   Thu, 1 Dec 2022 16:05:57 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, dan.j.williams@intel.com,
        akpm@linux-foundation.org
Subject: Re: [PATCH v2 6/8] xfs: use dax ops for zero and truncate in fsdax
 mode
Message-ID: <Y4lBZUEkK/oYHeX9@magnolia>
References: <1669908538-55-1-git-send-email-ruansy.fnst@fujitsu.com>
 <1669908730-131-1-git-send-email-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1669908730-131-1-git-send-email-ruansy.fnst@fujitsu.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 01, 2022 at 03:32:10PM +0000, Shiyang Ruan wrote:
> Zero and truncate on a dax file may execute CoW.  So use dax ops which
> contains end work for CoW.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>

LGTM
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_iomap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 881de99766ca..d9401d0300ad 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -1370,7 +1370,7 @@ xfs_zero_range(
>  
>  	if (IS_DAX(inode))
>  		return dax_zero_range(inode, pos, len, did_zero,
> -				      &xfs_direct_write_iomap_ops);
> +				      &xfs_dax_write_iomap_ops);
>  	return iomap_zero_range(inode, pos, len, did_zero,
>  				&xfs_buffered_write_iomap_ops);
>  }
> @@ -1385,7 +1385,7 @@ xfs_truncate_page(
>  
>  	if (IS_DAX(inode))
>  		return dax_truncate_page(inode, pos, did_zero,
> -					&xfs_direct_write_iomap_ops);
> +					&xfs_dax_write_iomap_ops);
>  	return iomap_truncate_page(inode, pos, did_zero,
>  				   &xfs_buffered_write_iomap_ops);
>  }
> -- 
> 2.38.1
> 
