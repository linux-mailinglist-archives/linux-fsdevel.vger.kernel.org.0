Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 474782ED42A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Jan 2021 17:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbhAGQUo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Jan 2021 11:20:44 -0500
Received: from verein.lst.de ([213.95.11.211]:41219 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726294AbhAGQUo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Jan 2021 11:20:44 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id AF1D467373; Thu,  7 Jan 2021 17:20:00 +0100 (CET)
Date:   Thu, 7 Jan 2021 17:20:00 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Satya Tangirala <satyat@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] fs: Fix freeze_bdev()/thaw_bdev() accounting of
 bd_fsfreeze_sb
Message-ID: <20210107162000.GA2693@lst.de>
References: <20201224044954.1349459-1-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201224044954.1349459-1-satyat@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Can someone pick this up?  Maybe through Jens' block tree as that is
where my commit this is fixing up came from.

For reference:


Reviewed-by: Christoph Hellwig <hch@lst.de>

On Thu, Dec 24, 2020 at 04:49:54AM +0000, Satya Tangirala wrote:
> freeze/thaw_bdev() currently use bdev->bd_fsfreeze_count to infer
> whether or not bdev->bd_fsfreeze_sb is valid (it's valid iff
> bd_fsfreeze_count is non-zero). thaw_bdev() doesn't nullify
> bd_fsfreeze_sb.
> 
> But this means a freeze_bdev() call followed by a thaw_bdev() call can
> leave bd_fsfreeze_sb with a non-null value, while bd_fsfreeze_count is
> zero. If freeze_bdev() is called again, and this time
> get_active_super() returns NULL (e.g. because the FS is unmounted),
> we'll end up with bd_fsfreeze_count > 0, but bd_fsfreeze_sb is
> *untouched* - it stays the same (now garbage) value. A subsequent
> thaw_bdev() will decide that the bd_fsfreeze_sb value is legitimate
> (since bd_fsfreeze_count > 0), and attempt to use it.
> 
> Fix this by always setting bd_fsfreeze_sb to NULL when
> bd_fsfreeze_count is successfully decremented to 0 in thaw_sb().
> Alternatively, we could set bd_fsfreeze_sb to whatever
> get_active_super() returns in freeze_bdev() whenever bd_fsfreeze_count
> is successfully incremented to 1 from 0 (which can be achieved cleanly
> by moving the line currently setting bd_fsfreeze_sb to immediately
> after the "sync:" label, but it might be a little too subtle/easily
> overlooked in future).
> 
> This fixes the currently panicking xfstests generic/085.
> 
> Fixes: 040f04bd2e82 ("fs: simplify freeze_bdev/thaw_bdev")
> Signed-off-by: Satya Tangirala <satyat@google.com>
> ---
>  fs/block_dev.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index 9e56ee1f2652..12a811a9ae4b 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -606,6 +606,8 @@ int thaw_bdev(struct block_device *bdev)
>  		error = thaw_super(sb);
>  	if (error)
>  		bdev->bd_fsfreeze_count++;
> +	else
> +		bdev->bd_fsfreeze_sb = NULL;
>  out:
>  	mutex_unlock(&bdev->bd_fsfreeze_mutex);
>  	return error;
> -- 
> 2.29.2.729.g45daf8777d-goog
---end quoted text---
