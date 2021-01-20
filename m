Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 405382FDA2B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jan 2021 20:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387969AbhATTzG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jan 2021 14:55:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:53292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387985AbhATSoc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jan 2021 13:44:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8D89E2065D;
        Wed, 20 Jan 2021 18:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611168231;
        bh=db8WPGqWzrEW2T7PU6DEGY1G1Ru5RNnRUrTQIUoqWp0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QHjxCxMd49COzVx8eW/BOzeQnjkyslEZN+N38eXEK2xTebQsZJJGfsCcHcOgz8n2y
         Tk81Xc4P75XU/BQHakBX/qpikCXUEXNMWvRzMtAC/Kn9/KkKKgedvOpVrihyiq9rBk
         C/Io3VUrPtCZhfu7Dc7Q3sl4fB8anONEZQX8HnLn7xYYnjrPjdc6gxRQaB2VnEy1lN
         uxmPHgKY9MdxTECteNZShr2XE4/mbVrhGCkyAuvG9WXaCT44F5SGQbMEPtUIHVSv1J
         r3uECLpV8WKPiDbOkQ8bX8QhlMLJFepkc9wJK3JkWnUcrGdAAoryPBQ8ZUpaxDifmg
         KanhJxNk8HwKQ==
Date:   Wed, 20 Jan 2021 10:43:51 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        avi@scylladb.com, Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH 04/11] xfs: remove the buffered I/O fallback assert
Message-ID: <20210120184351.GF3134581@magnolia>
References: <20210118193516.2915706-1-hch@lst.de>
 <20210118193516.2915706-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118193516.2915706-5-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 18, 2021 at 08:35:09PM +0100, Christoph Hellwig wrote:
> The iomap code has been designed from the start not to do magic fallback,
> so remove the assert in preparation for further code cleanups.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Dave Chinner <dchinner@redhat.com>

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_file.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index ae7313ccaa11ed..97836ec53397d4 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -610,12 +610,6 @@ xfs_file_dio_write(
>  out:
>  	if (iolock)
>  		xfs_iunlock(ip, iolock);
> -
> -	/*
> -	 * No fallback to buffered IO after short writes for XFS, direct I/O
> -	 * will either complete fully or return an error.
> -	 */
> -	ASSERT(ret < 0 || ret == count);
>  	return ret;
>  }
>  
> -- 
> 2.29.2
> 
