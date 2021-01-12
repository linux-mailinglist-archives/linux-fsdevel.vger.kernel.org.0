Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7AD42F372F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 18:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731303AbhALRcC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jan 2021 12:32:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:35580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727021AbhALRcC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jan 2021 12:32:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8C0662311F;
        Tue, 12 Jan 2021 17:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610472681;
        bh=hx3kcnBTK+3EJoLgdpAJwhITPHZ0HHh1DKuSieNfJfg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z9gjqutsZnsUP356ckbPegqUDZKsQXXxP9eJGdZyOU8bBk8u4FYIkX3C7Wx3NeqMk
         v+aEGfiH5lnMkDGIggxZUuRuwpwUD8mpUPHEGc5T0OvUqiMZDNG0b7VMf4cFd2qcjz
         1HUwMirf62JvcEXIn0EP6SGiYqXY168L+JodLgoWfsyM84qy1ePCxcQXZhFeTp5f+J
         IVNPVJewaAWGGqZt3iZtqq6T4aeMnwMVIacz3qiZgsHIbx6N+rcSfbb8cUdU2TjOQS
         d8TcjcUJWf4dgqNPZF22czS9lFJYH20ifNFJJd5kriPwY2GYNOiqJS6j++Rx/6DXd6
         q4YFbbdwHGkwQ==
Date:   Tue, 12 Jan 2021 09:31:20 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 12/12] xfs: remove a stale comment from
 xfs_file_aio_write_checks()
Message-ID: <20210112173120.GQ1164246@magnolia>
References: <20210109075903.208222-1-ebiggers@kernel.org>
 <20210109075903.208222-13-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210109075903.208222-13-ebiggers@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 08, 2021 at 11:59:03PM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> The comment in xfs_file_aio_write_checks() about calling file_modified()
> after dropping the ilock doesn't make sense, because the code that
> unconditionally acquires and drops the ilock was removed by
> commit 467f78992a07 ("xfs: reduce ilock hold times in
> xfs_file_aio_write_checks").
> 
> Remove this outdated comment.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Yep, thanks for the update. :)

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/xfs/xfs_file.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 5b0f93f738372..4927c6653f15d 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -389,12 +389,6 @@ xfs_file_aio_write_checks(
>  	} else
>  		spin_unlock(&ip->i_flags_lock);
>  
> -	/*
> -	 * Updating the timestamps will grab the ilock again from
> -	 * xfs_fs_dirty_inode, so we have to call it after dropping the
> -	 * lock above.  Eventually we should look into a way to avoid
> -	 * the pointless lock roundtrip.
> -	 */
>  	return file_modified(file);
>  }
>  
> -- 
> 2.30.0
> 
