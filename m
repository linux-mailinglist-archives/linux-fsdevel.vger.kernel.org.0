Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFAC9695C8B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Feb 2023 09:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbjBNINg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Feb 2023 03:13:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjBNINX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Feb 2023 03:13:23 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2E85580;
        Tue, 14 Feb 2023 00:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tt/6vKuaMQSuJNLbEE58XuRUskYANiHpSBkNrRojK8s=; b=iQCr85hMLVJ6H/RjgvOYJ9Lm8R
        xxGflQlsETe+RAYVRqZPtFYmOFzKy+IT5CeNVzkBlFprqDLvy9qIKJlJ/EzLn3K7ScseMQQ5ROP1L
        +teK1HOWmEbaYSe8kaTZZVIalLjcuX7tdBt7qpx0B2GxrsFIiEgHM4c8hIqVx+KH6ksMrdR4W3hXG
        36rbVIqhngMXbvhMnkarxwQLbkY0e26agNUTmwjEuIGoly1WNt1pG7hqr0lOyAoYRDxJm5Qaaj959
        dCNRfdQmUChrHaZhAz59wiNa8MsK9OKtNCcL/V7vfW+0uGvLnPsBHOQ3m7My+hS1SfuOTs3V0qw9K
        vCfPXKCw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pRqRD-000UTo-A7; Tue, 14 Feb 2023 08:13:19 +0000
Date:   Tue, 14 Feb 2023 00:13:19 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/3] xfs: failed delalloc conversion results in bad
 extent lists
Message-ID: <Y+tCn8owdne7Cbfg@infradead.org>
References: <20230214055114.4141947-1-david@fromorbit.com>
 <20230214055114.4141947-3-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214055114.4141947-3-david@fromorbit.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 14, 2023 at 04:51:13PM +1100, Dave Chinner wrote:
> index 958e4bb2e51e..fb718a5825d5 100644
> --- a/fs/xfs/libxfs/xfs_bmap.c
> +++ b/fs/xfs/libxfs/xfs_bmap.c
> @@ -4553,8 +4553,12 @@ xfs_bmapi_convert_delalloc(
>  		 * should only happen for the COW fork, where another thread
>  		 * might have moved the extent to the data fork in the meantime.
>  		 */
> -		WARN_ON_ONCE(whichfork != XFS_COW_FORK);
> -		error = -EAGAIN;
> +		if (whichfork != XFS_COW_FORK) {
> +			xfs_bmap_mark_sick(ip, whichfork);
> +			error = -EFSCORRUPTED;
> +		} else {
> +			error = -EAGAIN;
> +		}

The comment above should probably be expanded a bit on what this means
for a non-cow fork extent and how we'll handle it later.

> +	if (error) {
> +		if ((error == -EFSCORRUPTED) || (error == -EFSBADCRC))

Nit: no need for the inner braces.

>  
> +		/*
> +		 * If the inode is sick, then it might have delalloc extents
> +		 * within EOF that we were unable to convert. We have to punch
> +		 * them out here to release the reservation as there is no
> +		 * longer any data to write back into the delalloc range now.
> +		 */
> +		if (!xfs_inode_is_healthy(ip))
> +			xfs_bmap_punch_delalloc_range(ip, 0,
> +						i_size_read(VFS_I(ip)));

Is i_size_read the right check here?  The delalloc extent could extend
past i_size if i_size is not block aligned.  Can't we just simply pass
(xfs_off_t)-1 here?

