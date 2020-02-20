Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96709166523
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2020 18:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbgBTRm4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 12:42:56 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59712 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbgBTRmz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 12:42:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Xk7duIwfruDQ+dBn2iPfBjkI6Nd94O7rP64gZJKCsXg=; b=sV7uVruKoJdsSyIXPyxD5cdKOf
        S7c5ZlqJ1lHh5SPG/NIxX6wrxoQyTzj8DZd1MOhc3hY39Jy0uoTxiBw96FC5N8gA7hW49ASZPqRHY
        kxYUy/zfWJq8l3wDa8IzDPC0cAMjfqrpZaJ7qJ/X9hxmHZ/NcbQmX2Y3hS8O2h1MNzXVhuNsZJXWm
        umivrfo/ljI/qs/DH96f2G053kESBMKJTVlcSRTKZBJdBObx3xYLytwP6Ejp8h9aryiSosf9F7eVQ
        X0lDDeB755GjfNrz4UxuTte7NLaOl5RwTR+dSh/XgCTNbEIWgZCf8Jrw3lu+VTI7REOrLnAF3p8Si
        VrP8YX6w==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4pqh-0007T1-9W; Thu, 20 Feb 2020 17:42:55 +0000
Date:   Thu, 20 Feb 2020 09:42:55 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, darrick.wong@oracle.com
Subject: Re: [PATCH v2] iomap: return partial I/O count on error in
 iomap_dio_bio_actor
Message-ID: <20200220174255.GA24185@bombadil.infradead.org>
References: <20200220152355.5ticlkptc7kwrifz@fiona>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220152355.5ticlkptc7kwrifz@fiona>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 20, 2020 at 09:23:55AM -0600, Goldwyn Rodrigues wrote:
> In case of a block device error, written parameter in iomap_end()
> is zero as opposed to the amount of submitted I/O.
> Filesystems such as btrfs need to account for the I/O in ordered
> extents, even if it resulted in an error. Having (incomplete)
> submitted bytes in written gives the filesystem the amount of data
> which has been submitted before the error occurred, and the
> filesystem code can choose how to use it.
> 
> The final returned error for iomap_dio_rw() is set by
> iomap_dio_complete().
> 
> Partial writes in direct I/O are considered an error. So,
> ->iomap_end() using written == 0 as error must be changed
> to written < length. In this case, ext4 is the only user.

I really had a hard time understanding this.  I think what you meant
was:

Currently, I/Os that complete with an error indicate this by passing
written == 0 to the iomap_end function.  However, btrfs needs to know how
many bytes were written for its own accounting.  Change the convention
to pass the number of bytes which were actually written, and change the
only user to check for a short write instead of a zero length write.

> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>  fs/ext4/inode.c      | 2 +-
>  fs/iomap/direct-io.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index e60aca791d3f..e50e7414351a 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3475,7 +3475,7 @@ static int ext4_iomap_end(struct inode *inode, loff_t offset, loff_t length,
>  	 * the I/O. Any blocks that may have been allocated in preparation for
>  	 * the direct I/O will be reused during buffered I/O.
>  	 */
> -	if (flags & (IOMAP_WRITE | IOMAP_DIRECT) && written == 0)
> +	if (flags & (IOMAP_WRITE | IOMAP_DIRECT) && written < length)
>  		return -ENOTBLK;
>  
>  	return 0;
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 41c1e7c20a1f..01865db1bd09 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -264,7 +264,7 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
>  		size_t n;
>  		if (dio->error) {
>  			iov_iter_revert(dio->submit.iter, copied);
> -			copied = ret = 0;
> +			ret = 0;
>  			goto out;
>  		}
>  
> -- 
> 2.25.0
> 
