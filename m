Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 795DF2F2D0A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 11:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbhALKit (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jan 2021 05:38:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbhALKis (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jan 2021 05:38:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC70C061575;
        Tue, 12 Jan 2021 02:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MYFCUIIGk6+Ev4/UNSaJZob6LFbbUHMOBhPhWOdGIU0=; b=NjPgJrSntIsL60DgKFCX6AeZpK
        CSYYgSQ7Tnbp/Mur7Tjcbevx1aNTgF4/zphXqj4o/O8Sbdckrim5dpogLif17kSj9FMdJt2rVe7PE
        AyIAmPCyspBBy3hzViAE4FY5gKKtB76NIUkJPqnx2U/PHOAX7+cnEqOWVVFuVuYWcsEGbfSzPfJfr
        kF/sD8YY5ASYAntM5RPkF4LclRwSpNcyHNcLp3hXfE9LAnIOaaRlnBYaSJ+l+7i2TgRKhD8DBSLRQ
        W2+8GVtLAe96f0GYuZD2yMC3sFV6IetQuIztfsU5btXRoLL0eom3HA23QMCIpDLjCH6AxuoyDkr4e
        Z30ErUWA==;
Received: from [2001:4bb8:19b:e528:5ff5:c533:abbf:c8ac] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1kzH3a-004eLw-3y; Tue, 12 Jan 2021 10:37:59 +0000
Date:   Tue, 12 Jan 2021 11:37:45 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        avi@scylladb.com, andres@anarazel.de
Subject: Re: [PATCH 5/6] xfs: split unaligned DIO write code out
Message-ID: <X/17+dI8zX2BwPHH@infradead.org>
References: <20210112010746.1154363-1-david@fromorbit.com>
 <20210112010746.1154363-6-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112010746.1154363-6-david@fromorbit.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 12, 2021 at 12:07:45PM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> The unaligned DIO write path is more convulted than the normal path,

s/convulted/convoluted/

>
> and we are about to make it more complex. Keep the block aligned
> fast path dio write code trim and simple by splitting out the
> unaligned DIO code from it.

I like this, but a few comments below:

>  /*
> + * Handle block aligned direct IO writes
>   *
>   * Lock the inode appropriately to prepare for and issue a direct IO write.
>   * By separating it from the buffered write path we remove all the tricky to
> @@ -518,35 +518,88 @@ static const struct iomap_dio_ops xfs_dio_write_ops = {
>   * until we're sure the bytes at the new EOF have been zeroed and/or the cached
>   * pages are flushed out.
>   *
> + * Returns with locks held indicated by @iolock and errors indicated by
> + * negative return values.

As far as I can tell no locks are held when returning from
xfs_file_dio_write_aligned.

> + */
> +STATIC ssize_t
> +xfs_file_dio_write_aligned(

I thought we got rid of STATIC for new code?

> +	/*
> +	 * No fallback to buffered IO after short writes for XFS, direct I/O
> +	 * will either complete fully or return an error.
> +	 */
> +	ASSERT(ret < 0 || ret == count);

Maybe it is time to drop this assert rather than duplicating it given that
iomap direct I/O has behaved sane in this regard from the start?

> + * To provide the same serialisation for AIO, we also need to wait for
>   * outstanding IOs to complete so that unwritten extent conversion is completed
>   * before we try to map the overlapping block. This is currently implemented by
>   * hitting it with a big hammer (i.e. inode_dio_wait()).
>   *
> + * This means that unaligned dio writes alwys block. There is no "nowait" fast

s/alwys/always/

> +	/*
> +	 * We can't properly handle unaligned direct I/O to reflink
> +	 * files yet, as we can't unshare a partial block.
> +	 */

FYI, this could use up the whole 80 chars.

> +	/*
> +	 * Don't take the exclusive iolock here unless the I/O is unaligned to
> +	 * the file system block size.  We don't need to consider the EOF
> +	 * extension case here because xfs_file_aio_write_checks() will relock
> +	 * the inode as necessary for EOF zeroing cases and fill out the new
> +	 * inode size as appropriate.
> +	 */
> +	if ((iocb->ki_pos | count) & mp->m_blockmask)
> +		return xfs_file_dio_write_unaligned(ip, iocb, from);
> +	return xfs_file_dio_write_aligned(ip, iocb, from);

I don't think that whole comment makes much sense here, the locking
documentation belongs into the aligned/unaligned helpers now.

> -		ret = xfs_file_dio_aio_write(iocb, from);
> +		ret = xfs_file_dio_write(iocb, from);

If we change this naming it would be nice to throw in a patch to
also change the read side as well.
