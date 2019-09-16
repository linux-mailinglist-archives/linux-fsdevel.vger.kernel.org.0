Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B71DEB3A08
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2019 14:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbfIPMMw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Sep 2019 08:12:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46996 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbfIPMMw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Sep 2019 08:12:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=66B6dTqqBRGDC7VEWeIKwYBSuPw1k8SGRNvJBRBjKNg=; b=Eyz4305QlnWSJLk4r2X6vg9sR
        mX0TA4fGRQgX5PzF+XTCUXM8eBfFdO5l5SQc3bPU/S+joG8LWvW1dE/f0WRYi9jaqi5mctOiR99X0
        b2MZMs2mFbzpBwtFyynVTHz8rhGBbyZMWqcKqvz/9GPN6x72iSATJWmubXTKywfZkKiRo3iY3HBMp
        I+Dq5i5rSIux0fDs11u/KYUQPEJS395G0KY92+Lms7Rtx6e8fYQ6Se/NmdZxclFK/kRrWUbqVNhIG
        voQHqwhQyXGUW8oS0UpgDqG9iU0KzY2cxd6bCDbiisajO26tKKrIEtfUav5eA96VsGw7g2VA+Ekq2
        MxHWfBySg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1i9ps8-0006Sb-3d; Mon, 16 Sep 2019 12:12:48 +0000
Date:   Mon, 16 Sep 2019 05:12:48 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>
Cc:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, hch@infradead.org, darrick.wong@oracle.com
Subject: Re: [PATCH v3 5/6] ext4: introduce direct IO write path using iomap
 infrastructure
Message-ID: <20190916121248.GD4005@infradead.org>
References: <cover.1568282664.git.mbobrowski@mbobrowski.org>
 <db33705f9ba35ccbe20fc19b8ecbbf2078beff08.1568282664.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db33705f9ba35ccbe20fc19b8ecbbf2078beff08.1568282664.git.mbobrowski@mbobrowski.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 12, 2019 at 09:04:46PM +1000, Matthew Bobrowski wrote:
> @@ -213,12 +214,16 @@ static ssize_t ext4_write_checks(struct kiocb *iocb, struct iov_iter *from)
>  	struct inode *inode = file_inode(iocb->ki_filp);
>  	ssize_t ret;
>  
> +	if (unlikely(IS_IMMUTABLE(inode)))
> +		return -EPERM;
> +
>  	ret = generic_write_checks(iocb, from);
>  	if (ret <= 0)
>  		return ret;
>  
> -	if (unlikely(IS_IMMUTABLE(inode)))
> -		return -EPERM;
> +	ret = file_modified(iocb->ki_filp);
> +	if (ret)
> +		return 0;
>  
>  	/*
>  	 * If we have encountered a bitmap-format file, the size limit

Independent of the error return issue you probably want to split
modifying ext4_write_checks into a separate preparation patch.

> +/*
> + * For a write that extends the inode size, ext4_dio_write_iter() will
> + * wait for the write to complete. Consequently, operations performed
> + * within this function are still covered by the inode_lock(). On
> + * success, this function returns 0.
> + */
> +static int ext4_dio_write_end_io(struct kiocb *iocb, ssize_t size, int error,
> +				 unsigned int flags)
> +{
> +	int ret;
> +	loff_t offset = iocb->ki_pos;
> +	struct inode *inode = file_inode(iocb->ki_filp);
> +
> +	if (error) {
> +		ret = ext4_handle_failed_inode_extension(inode, offset + size);
> +		return ret ? ret : error;
> +	}

Just a personal opinion, but I find the use of the ternary operator
here a little weird.

A plain old:

	ret = ext4_handle_failed_inode_extension(inode, offset + size);
	if (ret)
		return ret;
	return error;

flow much easier.

> +	if (!inode_trylock(inode)) {
> +		if (iocb->ki_flags & IOCB_NOWAIT)
> +			return -EAGAIN;
> +		inode_lock(inode);
> +	}
> +
> +	if (!ext4_dio_checks(inode)) {
> +		inode_unlock(inode);
> +		/*
> +		 * Fallback to buffered IO if the operation on the
> +		 * inode is not supported by direct IO.
> +		 */
> +		return ext4_buffered_write_iter(iocb, from);

I think you want to lift the locking into the caller of this function
so that you don't have to unlock and relock for the buffered write
fallback.

> +	if (offset + count > i_size_read(inode) ||
> +	    offset + count > EXT4_I(inode)->i_disksize) {
> +		ext4_update_i_disksize(inode, inode->i_size);
> +		extend = true;

Doesn't the ext4_update_i_disksize need to be under an open journal
handle?
