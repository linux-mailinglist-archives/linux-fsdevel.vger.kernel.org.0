Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7EE1B2639
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2019 21:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389348AbfIMTqn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Sep 2019 15:46:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:45002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388766AbfIMTqn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Sep 2019 15:46:43 -0400
Received: from localhost (unknown [104.132.0.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A93E206BB;
        Fri, 13 Sep 2019 19:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568404002;
        bh=XON54BABhwtc7YnZj3oasAxG322VD3nzpVqlD7VH1FY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yw9PkNNKrrShtHir46qOSEdHEDSgM0cDdxpJ3nkDpFGPykez/8K7MT5wGu5X32A+0
         S41WTnrhBUQG4REzhc80KYa8l3CzbGMsJbUT5SiOYM39n0SlQNr4jW3qC7sytEDQiy
         gQMjdC896k32gehMh5fA/aMiB2uXZ2LZ9q5i4SlQ=
Date:   Fri, 13 Sep 2019 12:46:41 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-btrfs@vger.kernel.org, hch@infradead.org, andres@anarazel.de,
        david@fromorbit.com, riteshh@linux.ibm.com,
        linux-f2fs-devel@lists.sourceforge.net,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 3/3] f2fs: fix inode rwsem regression
Message-ID: <20190913194641.GA72768@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190911093926.pfkkx25mffzeuo32@alap3.anarazel.de>
 <20190911164517.16130-1-rgoldwyn@suse.de>
 <20190911164517.16130-4-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190911164517.16130-4-rgoldwyn@suse.de>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev&id=ebef4d7eda0d06a6ab6dc0f9e9f848276e605962

Merged. Thanks,

On 09/11, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> This is similar to 942491c9e6d6 ("xfs: fix AIM7 regression")
> Apparently our current rwsem code doesn't like doing the trylock, then
> lock for real scheme.  So change our read/write methods to just do the
> trylock for the RWF_NOWAIT case.
> 
> We don't need a check for IOCB_NOWAIT and !direct-IO because it
> is checked in generic_write_checks().
> 
> Fixes: b91050a80cec ("f2fs: add nowait aio support")
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>  fs/f2fs/file.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 3e58a6f697dd..c6f3ef815c05 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -3134,16 +3134,12 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  		goto out;
>  	}
>  
> -	if ((iocb->ki_flags & IOCB_NOWAIT) && !(iocb->ki_flags & IOCB_DIRECT)) {
> -		ret = -EINVAL;
> -		goto out;
> -	}
> -
> -	if (!inode_trylock(inode)) {
> -		if (iocb->ki_flags & IOCB_NOWAIT) {
> +	if (iocb->ki_flags & IOCB_NOWAIT) {
> +		if (!inode_trylock(inode)) {
>  			ret = -EAGAIN;
>  			goto out;
>  		}
> +	} else {
>  		inode_lock(inode);
>  	}
>  
> -- 
> 2.16.4
