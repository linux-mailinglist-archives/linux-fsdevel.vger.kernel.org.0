Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2F7A28EE07
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Oct 2020 09:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730003AbgJOH7N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Oct 2020 03:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729184AbgJOH7N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Oct 2020 03:59:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E4DC061755;
        Thu, 15 Oct 2020 00:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PRz1qStSSoVUDOFVhMhmjYK5kRbHYbzYS7mP6GZbHmY=; b=N1EfMwPhf3TH8UisGkms6CSNr4
        PNofhyxkf2+vwiKwqsIXaJ1TiADasNATnVOetmTEMYsK1vxtm5nbaZTwKf0rPDi4k/jt3qMtYGBDT
        iiJbRsECo0DyW6Gz4e2Xt5jy0wRG4bPbHLq7vpEHyJbK0tG8Aenbj6ea6qTn/18fsWgqMjqZW1DY3
        k4yj4JtYY3OaK+LulzHDFHIObzRz/q0fwnGbNNuL4nIpfMOodDC5lpfNir+Kf0t2S82o0FdHnWyWb
        BeRmeHKrHVHme4KKAkgRlaHxMn58p5ZvrUxaXiwBAYZ3WfkFtIDhP3lqpyJYm0KvXzc4ph36L7sVY
        zIO9xCYQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kSyAF-0007uN-A2; Thu, 15 Oct 2020 07:59:07 +0000
Date:   Thu, 15 Oct 2020 08:59:07 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     axboe@kernel.dk, hch@infradead.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        ming.lei@redhat.com, joseph.qi@linux.alibaba.com,
        xiaoguang.wang@linux.alibaba.com
Subject: Re: [v2 2/2] block,iomap: disable iopoll when split needed
Message-ID: <20201015075907.GB30117@infradead.org>
References: <20201015074031.91380-1-jefflexu@linux.alibaba.com>
 <20201015074031.91380-3-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015074031.91380-3-jefflexu@linux.alibaba.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 15, 2020 at 03:40:31PM +0800, Jeffle Xu wrote:
> Both blkdev fs and iomap-based fs (ext4, xfs, etc.) currently support
> sync iopoll. One single bio can contain at most BIO_MAX_PAGES, i.e. 256
> bio_vec. If the input iov_iter contains more than 256 segments, then
> the IO request described by this iov_iter will be split into multiple
> bios, which may cause potential deadlock for sync iopoll.
> 
> When it comes to sync iopoll, the bio is submitted without REQ_NOWAIT
> flag set and the process may hang in blk_mq_get_tag() if the input
> iov_iter has to be split into multiple bios and thus rapidly exhausts
> the queue depth. The process has to wait for the completion of the
> previously allocated requests, which should be done by the following
> sync polling, and thus causing a deadlock.
> 
> Actually there's subtle difference between the behaviour of handling
> HIPRI IO of blkdev and iomap, when the input iov_iter need to split
> into multiple bios. blkdev will set REQ_HIPRI for only the last split
> bio, leaving the previous bio queued into normal hardware queues, which
> will not cause the trouble described above though. iomap will set
> REQ_HIPRI for all bios split from one iov_iter, and thus may cause the
> potential deadlock decribed above.
> 
> Disable iopoll when one request need to be split into multiple bios.
> Though blkdev may not suffer the problem, still it may not make much
> sense to iopoll for big IO, since iopoll is initially for small size,
> latency sensitive IO.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> ---
>  fs/block_dev.c       | 7 +++++++
>  fs/iomap/direct-io.c | 9 ++++++++-
>  2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index 9e84b1928b94..a8a52cab15ab 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -491,6 +491,13 @@ blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
>  	if (is_sync_kiocb(iocb) && nr_pages <= BIO_MAX_PAGES)
>  		return __blkdev_direct_IO_simple(iocb, iter, nr_pages);
>  
> +	/*
> +	 * IOpoll is initially for small size, latency sensitive IO.
> +	 * Disable iopoll if split needed.
> +	 */
> +	if (nr_pages > BIO_MAX_PAGES)
> +		iocb->ki_flags &= ~IOCB_HIPRI;

more pages than BIO_MAX_PAGES don't imply a split because we can
physically merge pages into a single vector (yes, BIO_MAX_PAGES is
utterly misnamed now).
